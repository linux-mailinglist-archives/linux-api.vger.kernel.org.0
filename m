Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639682FCAF8
	for <lists+linux-api@lfdr.de>; Wed, 20 Jan 2021 07:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbhATGO6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Jan 2021 01:14:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:39843 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbhATGOF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 20 Jan 2021 01:14:05 -0500
IronPort-SDR: p9cz+1SkFX23AAmWysuP0Rj6vBGSqBY9Qlb7hoeBjEqQi2lNenzDHflp3qSdVf4PHCiSyOxxyQ
 W3QvfQZ3GwXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="263861787"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="263861787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 22:13:24 -0800
IronPort-SDR: LMkW+lUXrPTOnHWqwmIDn5TBOW+0POvNE0khzH0BCSgYfp6i4rDp1Td2Sz1qSk9T6mX8kfh2CZ
 tdxoRYDhbFaQ==
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="384449295"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 22:13:20 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: [PATCH -V9 1/3] numa balancing: Migrate on fault among multiple bound nodes
Date:   Wed, 20 Jan 2021 14:12:33 +0800
Message-Id: <20210120061235.148637-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120061235.148637-1-ying.huang@intel.com>
References: <20210120061235.148637-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Now, NUMA balancing can only optimize the page placement among the
NUMA nodes if the default memory policy is used.  Because the memory
policy specified explicitly should take precedence.  But this seems
too strict in some situations.  For example, on a system with 4 NUMA
nodes, if the memory of an application is bound to the node 0 and 1,
NUMA balancing can potentially migrate the pages between the node 0
and 1 to reduce cross-node accessing without breaking the explicit
memory binding policy.

So in this patch, we add MPOL_F_NUMA_BALANCING mode flag to
set_mempolicy() when mode is MPOL_BIND.  With the flag specified, NUMA
balancing will be enabled within the thread to optimize the page
placement within the constrains of the specified memory binding
policy.  With the newly added flag, the NUMA balancing control
mechanism becomes,

- sysctl knob numa_balancing can enable/disable the NUMA balancing
  globally.

- even if sysctl numa_balancing is enabled, the NUMA balancing will be
  disabled for the memory areas or applications with the explicit memory
  policy by default.

- MPOL_F_NUMA_BALANCING can be used to enable the NUMA balancing for the
  applications when specifying the explicit memory policy (MPOL_BIND).

Various page placement optimization based on the NUMA balancing can be
done with these flags.  As the first step, in this patch, if the
memory of the application is bound to multiple nodes (MPOL_BIND), and
in the hint page fault handler the accessing node are in the policy
nodemask, the page will be tried to be migrated to the accessing node
to reduce the cross-node accessing.

If the newly added MPOL_F_NUMA_BALANCING flag is specified by an
application on an old kernel version without its support,
set_mempolicy() will return -1 and errno will be set to EINVAL.  The
application can use this behavior to run on both old and new kernel
versions.

And if the MPOL_F_NUMA_BALANCING flag is specified for the mode other
than MPOL_BIND, set_mempolicy() will return -1 and errno will be set
to EINVAL as before.  Because we don't support optimization based on
the NUMA balancing for these modes.

In the previous version of the patch, we tried to reuse MPOL_MF_LAZY
for mbind().  But that flag is tied to MPOL_MF_MOVE.*, so it seems not
a good API/ABI for the purpose of the patch.

And because it's not clear whether it's necessary to enable NUMA
balancing for a specific memory area inside an application, so we only
add the flag at the thread level (set_mempolicy()) instead of the
memory area level (mbind()).  We can do that when it become necessary.

To test the patch, we run a test case as follows on a 4-node machine
with 192 GB memory (48 GB per node).

1. Change pmbench memory accessing benchmark to call set_mempolicy()
   to bind its memory to node 1 and 3 and enable NUMA balancing.  Some
   related code snippets are as follows,

     #include <numaif.h>
     #include <numa.h>

	struct bitmask *bmp;
	int ret;

	bmp = numa_parse_nodestring("1,3");
	ret = set_mempolicy(MPOL_BIND | MPOL_F_NUMA_BALANCING,
			    bmp->maskp, bmp->size + 1);
	/* If MPOL_F_NUMA_BALANCING isn't supported, fall back to MPOL_BIND */
	if (ret < 0 && errno == EINVAL)
		ret = set_mempolicy(MPOL_BIND, bmp->maskp, bmp->size + 1);
	if (ret < 0) {
		perror("Failed to call set_mempolicy");
		exit(-1);
	}

2. Run a memory eater on node 3 to use 40 GB memory before running pmbench.

3. Run pmbench with 64 processes, the working-set size of each process
   is 640 MB, so the total working-set size is 64 * 640 MB = 40 GB.  The
   CPU and the memory (as in step 1.) of all pmbench processes is bound
   to node 1 and 3. So, after CPU usage is balanced, some pmbench
   processes run on the CPUs of the node 3 will access the memory of
   the node 1.

4. After the pmbench processes run for 100 seconds, kill the memory
   eater.  Now it's possible for some pmbench processes to migrate
   their pages from node 1 to node 3 to reduce cross-node accessing.

Test results show that, with the patch, the pages can be migrated from
node 1 to node 3 after killing the memory eater, and the pmbench score
can increase about 17.5%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: linux-api@vger.kernel.org
---
 include/uapi/linux/mempolicy.h |  4 +++-
 mm/mempolicy.c                 | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 3354774af61e..8948467b3992 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -28,12 +28,14 @@ enum {
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
+#define MPOL_F_NUMA_BALANCING	(1 << 13) /* Optimize with NUMA balancing if possible */
 
 /*
  * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
  * either set_mempolicy() or mbind().
  */
-#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES)
+#define MPOL_MODE_FLAGS							\
+	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES | MPOL_F_NUMA_BALANCING)
 
 /* Flags for get_mempolicy */
 #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2c3a86502053..6961238c7ef5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -875,6 +875,16 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
+	if (flags & MPOL_F_NUMA_BALANCING) {
+		if (new && new->mode == MPOL_BIND) {
+			new->flags |= (MPOL_F_MOF | MPOL_F_MORON);
+		} else {
+			ret = -EINVAL;
+			mpol_put(new);
+			goto out;
+		}
+	}
+
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		mpol_put(new);
@@ -2486,6 +2496,12 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_BIND:
+		/* Optimize placement among multiple nodes via NUMA balancing */
+		if (pol->flags & MPOL_F_MORON) {
+			if (node_isset(thisnid, pol->v.nodes))
+				break;
+			goto out;
+		}
 
 		/*
 		 * allows binding to multiple nodes.
-- 
2.29.2

