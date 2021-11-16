Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4B452B26
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 07:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhKPGqY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 01:46:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234075AbhKPGqV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 01:46:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AG4lYbW012440;
        Tue, 16 Nov 2021 06:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l3eJArpBHasWQifX499As2E/Oh+ehj7DyZkHmcMxXO4=;
 b=g65kV74wCn6nMPvuTt8j521hm6yaj2N2XhGV8L38AYHj+akBdE308baZi5yjrVKK9n3j
 5+fQIBLrc1zOmujEYD4mY2hmFPyidMTlynphOBEW1y0pDuJ7zWOHumEITxVfZJg2WpO4
 Ta/BuUzFGX8nv138k22aurJAThylpG8eE2SwLTp8/ywQcCZ6nFh7rGIaHS+04XLcFZhY
 AexRkSImH6VN0j5V/c5VqBxDFVW7ZpH2UgrfAnJuOTa4DqvXerhnq+aqqthFCTn7jX/E
 QieQreuKBWNwLKHBzHA/gPOn6h6JDcfHlUEmAnbL7x0zp5xs02Es/TMqGY/iw7Hy2Vkx Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cc5x8ssvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:42:58 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AG6RUob011568;
        Tue, 16 Nov 2021 06:42:57 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cc5x8ssv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:42:57 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AG6gegQ024375;
        Tue, 16 Nov 2021 06:42:56 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3ca50awst4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:42:56 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AG6gtbB58327406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 06:42:55 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A266E6E059;
        Tue, 16 Nov 2021 06:42:55 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1096E6E052;
        Tue, 16 Nov 2021 06:42:50 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.124.74])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Nov 2021 06:42:49 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org,
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
Subject: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Date:   Tue, 16 Nov 2021 12:12:37 +0530
Message-Id: <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YUNTKzsdf9DIzglaC7J_7VrIHaWCSrEd
X-Proofpoint-ORIG-GUID: 2O1S_R5PZNJzJc7YMWXh1gCdVCobwP9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111160034
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

This will allocate from nodes closer to node 2 and will make sure kernel will
only allocate from nodes 1, 2 and3. Memory will not be allocated from slow memory
nodes 10, 11 and 12

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
 .../admin-guide/mm/numa_memory_policy.rst     | 14 ++++-
 include/linux/mempolicy.h                     |  1 +
 mm/mempolicy.c                                | 62 +++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 64fd0ba0d057..6eab52d4c3b2 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -408,7 +408,7 @@ follows:
 Memory Policy APIs
 ==================
 
-Linux supports 3 system calls for controlling memory policy.  These APIS
+Linux supports 4 system calls for controlling memory policy.  These APIS
 always affect only the calling task, the calling task's address space, or
 some shared object mapped into the calling task's address space.
 
@@ -460,6 +460,18 @@ requested via the 'flags' argument.
 
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
+closest to which page allocation will come from.
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
index 673b5fb13346..cdd6430932d1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -296,6 +296,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
+	policy->home_node = NUMA_NO_NODE;
 
 	return policy;
 }
@@ -1477,6 +1478,60 @@ static long kernel_mbind(unsigned long start, unsigned long len,
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
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+	/*
+	 * flags is used for future extension if any.
+	 */
+	if (flags != 0)
+		return -EINVAL;
+
+	if (!node_online(home_node))
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
+		new->home_node = home_node;
+		err = mbind_range(mm, vmstart, vmend, new);
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
@@ -1801,6 +1856,11 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
 	}
 
+	if ((policy->mode == MPOL_BIND ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    policy->home_node != NUMA_NO_NODE)
+		return policy->home_node;
+
 	return nd;
 }
 
@@ -2343,6 +2403,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
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

