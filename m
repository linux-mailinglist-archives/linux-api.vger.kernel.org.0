Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FE4663CE
	for <lists+linux-api@lfdr.de>; Thu,  2 Dec 2021 13:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbhLBMmI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Dec 2021 07:42:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52152 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241434AbhLBMmI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Dec 2021 07:42:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2BNPvA031606;
        Thu, 2 Dec 2021 12:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zx+LU8zcyXl/nAHpEzlyw40h5igxK6dYpg8j3RN9z/8=;
 b=CGbzGCaP70kksMsZ7MVNKSVWGqrAzuuSA3vT26MSGnmBSzcEZSAnrsza8C66mrE7Nyin
 XQjRIj1ciEKQhOoKwvROjh/b1VGXZXuAXh3ZYmaFAZRTR34o7BtdMeCSvw3l1kBHvRlK
 UOvMNJk77B7qB4wlIdEUL1xN9sJmp3F260/JqupEIDjRKfEx7jbq0qmA5GD9J96XHcW9
 CzeCMdrM/IAiEDs92xJGmIaBLWzspN8VPGndWPsHfgkRZthZRwZQcVHP4vlSLgH33e19
 MrZNeTIOBtWWBJGvQ59xn/HDtkteiftbdNyhmcSF+/VjecCyNYE0Irmj8XVnS1jo+Lh0 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpw7t9eaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:38:30 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2BONPe036134;
        Thu, 2 Dec 2021 12:38:30 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpw7t9ea6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:38:30 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2CXg3d027979;
        Thu, 2 Dec 2021 12:38:29 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3cn5f0sytv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:38:29 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2CcSKe25493878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 12:38:28 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 215516E053;
        Thu,  2 Dec 2021 12:38:28 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F79B6E060;
        Thu,  2 Dec 2021 12:38:22 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.77.159])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 12:38:21 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: [PATCH v6 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Date:   Thu,  2 Dec 2021 18:08:09 +0530
Message-Id: <20211202123810.267175-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202123810.267175-1-aneesh.kumar@linux.ibm.com>
References: <20211202123810.267175-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KSl5RhrwK6TOi9CikqDnjb-YR8pRcgYu
X-Proofpoint-GUID: muZRukgUBXEZK6ywwt0DUda8IiAVLz1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_07,2021-12-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020080
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This syscall can be used to set a home node for the MPOL_BIND
and MPOL_PREFERRED_MANY memory policy. Users should use this
syscall after setting up a memory policy for the specified range
as shown below.

mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,
	    new_nodes->size + 1, 0);
sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
				  home_node, 0);

The syscall allows specifying a home node/preferred node from which kernel
will fulfill memory allocation requests first.

For address range with MPOL_BIND memory policy, if nodemask specifies more
than one node, page allocations will come from the node in the nodemask
with sufficient free memory that is closest to the home node/preferred node.

For MPOL_PREFERRED_MANY if the nodemask specifies more than one node,
page allocation will come from the node in the nodemask with sufficient
free memory that is closest to the home node/preferred node. If there is
not enough memory in all the nodes specified in the nodemask, the allocation
will be attempted from the closest numa node to the home node in the system.

This helps applications to hint at a memory allocation preference node
and fallback to _only_ a set of nodes if the memory is not available
on the preferred node.  Fallback allocation is attempted from the node which is
nearest to the preferred node.

This helps applications to have control on memory allocation numa nodes and
avoids default fallback to slow memory NUMA nodes. For example a system with
NUMA nodes 1,2 and 3 with DRAM memory and 10, 11 and 12 of slow memory

 new_nodes = numa_bitmask_alloc(nr_nodes);

 numa_bitmask_setbit(new_nodes, 1);
 numa_bitmask_setbit(new_nodes, 2);
 numa_bitmask_setbit(new_nodes, 3);

 p = mmap(NULL, nr_pages * page_size, protflag, mapflag, -1, 0);
 mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,  new_nodes->size + 1, 0);

 sys_set_mempolicy_home_node(p, nr_pages * page_size, 2, 0);

This will allocate from nodes closer to node 2 and will make sure the kernel will
only allocate from nodes 1, 2, and 3. Memory will not be allocated from slow memory
nodes 10, 11, and 12. This differs from default MPOL_BIND behavior in that with
default MPOL_BIND the allocation will be attempted from node closer to the local node.
One of the reasons to specify a home node is to allow allocations from cpu less
NUMA node and its nearby NUMA nodes.

With MPOL_PREFERRED_MANY on the other hand will first try to allocate from the
closest node to node 2 from the node list 1, 2 and 3. If those nodes don't have
enough memory, kernel will allocate from slow memory node 10, 11 and 12 which
ever is closer to node 2.

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
Cc: linux-api@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 16 +++-
 include/linux/mempolicy.h                     |  1 +
 mm/mempolicy.c                                | 79 +++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 64fd0ba0d057..a080d24df7de 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
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
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 3c7595e81150..668389b4b53d 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -46,6 +46,7 @@ struct mempolicy {
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
 	nodemask_t nodes;	/* interleave/bind/perfer */
+	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 673b5fb13346..cfed45ab3647 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -296,6 +296,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
+	policy->home_node = NUMA_NO_NODE;
 
 	return policy;
 }
@@ -1477,6 +1478,77 @@ static long kernel_mbind(unsigned long start, unsigned long len,
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
@@ -1801,6 +1873,11 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
 	}
 
+	if ((policy->mode == MPOL_BIND ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    policy->home_node != NUMA_NO_NODE)
+		return policy->home_node;
+
 	return nd;
 }
 
@@ -2343,6 +2420,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 		return false;
 	if (a->flags != b->flags)
 		return false;
+	if (a->home_node != b->home_node)
+		return false;
 	if (mpol_store_user_nodemask(a))
 		if (!nodes_equal(a->w.user_nodemask, b->w.user_nodemask))
 			return false;
-- 
2.31.1

