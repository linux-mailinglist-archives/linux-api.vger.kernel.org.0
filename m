Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6E3DE67F
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhHCF7y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 01:59:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:34948 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234051AbhHCF7x (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Aug 2021 01:59:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235529260"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="235529260"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 22:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="479233384"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2021 22:59:39 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v7 4/5] mm/mempolicy: Advertise new MPOL_PREFERRED_MANY
Date:   Tue,  3 Aug 2021 13:59:21 +0800
Message-Id: <1627970362-61305-5-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Adds a new mode to the existing mempolicy modes, MPOL_PREFERRED_MANY.

MPOL_PREFERRED_MANY will be adequately documented in the internal
admin-guide with this patch. Eventually, the man pages for mbind(2),
get_mempolicy(2), set_mempolicy(2) and numactl(8) will also have text
about this mode. Those shall contain the canonical reference.

NUMA systems continue to become more prevalent. New technologies like
PMEM make finer grain control over memory access patterns increasingly
desirable. MPOL_PREFERRED_MANY allows userspace to specify a set of
nodes that will be tried first when performing allocations. If those
allocations fail, all remaining nodes will be tried. It's a straight
forward API which solves many of the presumptive needs of system
administrators wanting to optimize workloads on such machines. The mode
will work either per VMA, or per thread.

[Michal Hocko: refine kernel doc for MPOL_PREFERRED_MANY]
Link: https://lore.kernel.org/r/20200630212517.308045-13-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/mm/numa_memory_policy.rst | 15 +++++++++++----
 mm/mempolicy.c                                      |  7 +------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 067a90a1499c..64fd0ba0d057 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -245,6 +245,13 @@ MPOL_INTERLEAVED
 	address range or file.  During system boot up, the temporary
 	interleaved system default policy works in this mode.
 
+MPOL_PREFERRED_MANY
+	This mode specifices that the allocation should be preferrably
+	satisfied from the nodemask specified in the policy. If there is
+	a memory pressure on all nodes in the nodemask, the allocation
+	can fall back to all existing numa nodes. This is effectively
+	MPOL_PREFERRED allowed for a mask rather than a single node.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
@@ -253,10 +260,10 @@ MPOL_F_STATIC_NODES
 	nodes changes after the memory policy has been defined.
 
 	Without this flag, any time a mempolicy is rebound because of a
-	change in the set of allowed nodes, the node (Preferred) or
-	nodemask (Bind, Interleave) is remapped to the new set of
-	allowed nodes.  This may result in nodes being used that were
-	previously undesired.
+        change in the set of allowed nodes, the preferred nodemask (Preferred
+        Many), preferred node (Preferred) or nodemask (Bind, Interleave) is
+        remapped to the new set of allowed nodes.  This may result in nodes
+        being used that were previously undesired.
 
 	With this flag, if the user-specified nodes overlap with the
 	nodes allowed by the task's cpuset, then the memory policy is
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a00bb1c48a15..e437fe96acd0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1463,12 +1463,7 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	*flags = *mode & MPOL_MODE_FLAGS;
 	*mode &= ~MPOL_MODE_FLAGS;
 
-	/*
-	 * The check should be 'mode >= MPOL_MAX', but as 'prefer_many'
-	 * is not fully implemented, don't permit it to be used for now,
-	 * and the logic will be restored in following patch
-	 */
-	if ((unsigned int)(*mode) >=  MPOL_PREFERRED_MANY)
+	if ((unsigned int)(*mode) >=  MPOL_MAX)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
-- 
2.14.1

