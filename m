Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92156466D54
	for <lists+linux-api@lfdr.de>; Thu,  2 Dec 2021 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348289AbhLBW7G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Dec 2021 17:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348385AbhLBW7G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Dec 2021 17:59:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E2C061758;
        Thu,  2 Dec 2021 14:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D94EDB823D0;
        Thu,  2 Dec 2021 22:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F619C00446;
        Thu,  2 Dec 2021 22:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638485740;
        bh=dmdKG+0+gJRdi9kgqpFN5QPtnc1XLR8C15wCo6dkQnA=;
        h=Date:From:To:Subject:From;
        b=FDHgyC4ZYNXDE688TaFaix/4eCdKodtSdSSkCfuNfJGopXLl98c+2IioQYOPHaQjm
         Ka+NgtiLfDv3HV1uYkSN9JwxrIxZlJT/KeTczxQ+BsgiO2wcXvidp47KQB/kfAf/Hp
         X/Ligr8P9zyg1cg/aoMSWu7CY4iHlNP+VM/XYwpw=
Date:   Thu, 02 Dec 2021 14:55:39 -0800
From:   akpm@linux-foundation.org
To:     aarcange@redhat.com, ak@linux.intel.com,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@kernel.org,
        mike.kravetz@oracle.com, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, vbabka@suse.cz, ying.huang@intel.com
Subject:  + mm-mempolicy-add-set_mempolicy_home_node-syscall.patch
 added to -mm tree
Message-ID: <20211202225539.QnnZ_apKk%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


The patch titled
     Subject: mm/mempolicy: add set_mempolicy_home_node syscall
has been added to the -mm tree.  Its filename is
     mm-mempolicy-add-set_mempolicy_home_node-syscall.patch

This patch should soon appear at
    https://ozlabs.org/~akpm/mmots/broken-out/mm-mempolicy-add-set_mempolicy_home_node-syscall.patch
and later at
    https://ozlabs.org/~akpm/mmotm/broken-out/mm-mempolicy-add-set_mempolicy_home_node-syscall.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next and is updated
there every 3-4 working days

------------------------------------------------------
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: mm/mempolicy: add set_mempolicy_home_node syscall

This syscall can be used to set a home node for the MPOL_BIND and
MPOL_PREFERRED_MANY memory policy.  Users should use this syscall after
setting up a memory policy for the specified range as shown below.

mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,
	    new_nodes->size + 1, 0);
sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
				  home_node, 0);

The syscall allows specifying a home node/preferred node from which kernel
will fulfill memory allocation requests first.

For address range with MPOL_BIND memory policy, if nodemask specifies more
than one node, page allocations will come from the node in the nodemask
with sufficient free memory that is closest to the home node/preferred
node.

For MPOL_PREFERRED_MANY if the nodemask specifies more than one node, page
allocation will come from the node in the nodemask with sufficient free
memory that is closest to the home node/preferred node.  If there is not
enough memory in all the nodes specified in the nodemask, the allocation
will be attempted from the closest numa node to the home node in the
system.

This helps applications to hint at a memory allocation preference node and
fallback to _only_ a set of nodes if the memory is not available on the
preferred node.  Fallback allocation is attempted from the node which is
nearest to the preferred node.

This helps applications to have control on memory allocation numa nodes
and avoids default fallback to slow memory NUMA nodes.  For example a
system with NUMA nodes 1,2 and 3 with DRAM memory and 10, 11 and 12 of
slow memory

 new_nodes = numa_bitmask_alloc(nr_nodes);

 numa_bitmask_setbit(new_nodes, 1);
 numa_bitmask_setbit(new_nodes, 2);
 numa_bitmask_setbit(new_nodes, 3);

 p = mmap(NULL, nr_pages * page_size, protflag, mapflag, -1, 0);
 mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,  new_nodes->size + 1, 0);

 sys_set_mempolicy_home_node(p, nr_pages * page_size, 2, 0);

This will allocate from nodes closer to node 2 and will make sure the
kernel will only allocate from nodes 1, 2, and 3.  Memory will not be
allocated from slow memory nodes 10, 11, and 12.  This differs from
default MPOL_BIND behavior in that with default MPOL_BIND the allocation
will be attempted from node closer to the local node.  One of the reasons
to specify a home node is to allow allocations from cpu less NUMA node and
its nearby NUMA nodes.

With MPOL_PREFERRED_MANY on the other hand will first try to allocate from
the closest node to node 2 from the node list 1, 2 and 3.  If those nodes
don't have enough memory, kernel will allocate from slow memory node 10,
11 and 12 which ever is closer to node 2.

Link: https://lkml.kernel.org/r/20211202123810.267175-3-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: <linux-api@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/admin-guide/mm/numa_memory_policy.rst |   16 +-
 include/linux/mempolicy.h                           |    1 
 mm/mempolicy.c                                      |   79 ++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

--- a/Documentation/admin-guide/mm/numa_memory_policy.rst~mm-mempolicy-add-set_mempolicy_home_node-syscall
+++ a/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -408,7 +408,7 @@ follows:
 Memory Policy APIs
 ==================
 
-Linux supports 3 system calls for controlling memory policy.  These APIS
+Linux supports 4 system calls for controlling memory policy.  These APIS
 always affect only the calling task, the calling task's address space, or
 some shared object mapped into the calling task's address space.
 
@@ -460,6 +460,20 @@ requested via the 'flags' argument.
 
 See the mbind(2) man page for more details.
 
+Set home node for a Range of Task's Address Spacec::
+
+	long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
+  					 unsigned long home_node,
+					 unsigned long flags);
+
+sys_set_mempolicy_home_node set the home node for a VMA policy present in the
+task's address range. The system call updates the home node only for the existing
+mempolicy range. Other address ranges are ignored. A home node is the NUMA node
+closest to which page allocation will come from. Specifying the home node override
+the default allocation policy to allocate memory close to the local node for an
+executing CPU.
+
+
 Memory Policy Command Line Interface
 ====================================
 
--- a/include/linux/mempolicy.h~mm-mempolicy-add-set_mempolicy_home_node-syscall
+++ a/include/linux/mempolicy.h
@@ -46,6 +46,7 @@ struct mempolicy {
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
 	nodemask_t nodes;	/* interleave/bind/perfer */
+	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
--- a/mm/mempolicy.c~mm-mempolicy-add-set_mempolicy_home_node-syscall
+++ a/mm/mempolicy.c
@@ -296,6 +296,7 @@ static struct mempolicy *mpol_new(unsign
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
+	policy->home_node = NUMA_NO_NODE;
 
 	return policy;
 }
@@ -1478,6 +1479,77 @@ static long kernel_mbind(unsigned long s
 	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
 }
 
+SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
+		unsigned long, home_node, unsigned long, flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct mempolicy *new;
+	unsigned long vmstart;
+	unsigned long vmend;
+	unsigned long end;
+	int err = -ENOENT;
+
+	start = untagged_addr(start);
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+	/*
+	 * flags is used for future extension if any.
+	 */
+	if (flags != 0)
+		return -EINVAL;
+
+	/*
+	 * Check home_node is online to avoid accessing uninitialized
+	 * NODE_DATA.
+	 */
+	if (home_node >= MAX_NUMNODES || !node_online(home_node))
+		return -EINVAL;
+
+	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
+	end = start + len;
+
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
+	mmap_write_lock(mm);
+	vma = find_vma(mm, start);
+	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
+
+		vmstart = max(start, vma->vm_start);
+		vmend   = min(end, vma->vm_end);
+		new = mpol_dup(vma_policy(vma));
+		if (IS_ERR(new)) {
+			err = PTR_ERR(new);
+			break;
+		}
+		/*
+		 * Only update home node if there is an existing vma policy
+		 */
+		if (!new)
+			continue;
+
+		/*
+		 * If any vma in the range got policy other than MPOL_BIND
+		 * or MPOL_PREFERRED_MANY we return error. We don't reset
+		 * the home node for vmas we already updated before.
+		 */
+		if (new->mode != MPOL_BIND && new->mode != MPOL_PREFERRED_MANY) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		new->home_node = home_node;
+		err = mbind_range(mm, vmstart, vmend, new);
+		mpol_put(new);
+		if (err)
+			break;
+	}
+	mmap_write_unlock(mm);
+	return err;
+}
+
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 		unsigned long, mode, const unsigned long __user *, nmask,
 		unsigned long, maxnode, unsigned int, flags)
@@ -1802,6 +1874,11 @@ static int policy_node(gfp_t gfp, struct
 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
 	}
 
+	if ((policy->mode == MPOL_BIND ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    policy->home_node != NUMA_NO_NODE)
+		return policy->home_node;
+
 	return nd;
 }
 
@@ -2345,6 +2422,8 @@ bool __mpol_equal(struct mempolicy *a, s
 		return false;
 	if (a->flags != b->flags)
 		return false;
+	if (a->home_node != b->home_node)
+		return false;
 	if (mpol_store_user_nodemask(a))
 		if (!nodes_equal(a->w.user_nodemask, b->w.user_nodemask))
 			return false;
_

Patches currently in -mm which might be from aneesh.kumar@linux.ibm.com are

mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch
mm-mempolicy-add-set_mempolicy_home_node-syscall.patch
mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch

