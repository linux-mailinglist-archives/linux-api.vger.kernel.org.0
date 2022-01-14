Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479DB48F242
	for <lists+linux-api@lfdr.de>; Fri, 14 Jan 2022 23:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiANWIX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jan 2022 17:08:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37700 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiANWIW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jan 2022 17:08:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B205CE24A6;
        Fri, 14 Jan 2022 22:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576F7C36AE5;
        Fri, 14 Jan 2022 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1642198099;
        bh=QLB+ZKQJRGoI7Mh/ZuwssIuXIuBPqDuI11pPrmiYiGc=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=hsj7HJnakkIuStyMuOBCXT1W+PRiPU6tIx10DGycNTjUbDs9qASOktG3epuZv0OAq
         bDH1eyWDqOJevGFIfh/ZFFLu8AGjaV5tHC/6VHpeLWgtIrux4wFOvsO0ETnk7Ych6C
         zbrDkM745CjJHYBm6nwsBOIPVm0L/KeR5BNWAlK4=
Date:   Fri, 14 Jan 2022 14:08:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@kernel.org,
        mike.kravetz@oracle.com, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, torvalds@linux-foundation.org,
        vbabka@suse.cz, ying.huang@intel.com
Subject:  [patch 097/146] mm/mempolicy: add set_mempolicy_home_node
 syscall
Message-ID: <20220114220817.MyJze7bLB%akpm@linux-foundation.org>
In-Reply-To: <20220114140222.6b14f0061194d3200000c52d@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

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
 
@@ -2344,6 +2421,8 @@ bool __mpol_equal(struct mempolicy *a, s
 		return false;
 	if (a->flags != b->flags)
 		return false;
+	if (a->home_node != b->home_node)
+		return false;
 	if (mpol_store_user_nodemask(a))
 		if (!nodes_equal(a->w.user_nodemask, b->w.user_nodemask))
 			return false;
_
