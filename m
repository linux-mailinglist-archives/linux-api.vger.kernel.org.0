Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41154347E2
	for <lists+linux-api@lfdr.de>; Wed, 20 Oct 2021 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJTJ2u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Oct 2021 05:28:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22689 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhJTJ2t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Oct 2021 05:28:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K9AfxK015872;
        Wed, 20 Oct 2021 05:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y5icvuJDxqe1KHzqX7MzLISJ3yUKoqBaUuJavwxPWOk=;
 b=DdJg+KoDGqamebhGOqTXCmi7yHCx40XGyg+PJZSVUsCv1RXiUeA+DvW6oxES/ZUfTp3p
 OPvUcCx3q4F97i1+Gc9jdFpOoTpoT3gqAH6l9evg3ru8kc+T+r4RaPQOw/qUYHpaQZV9
 BAEcAU/94bYmF+Pi+/Dg9ZFjBx5s7BuNQdYnwDXhS4LZ+ABGWomAaEvND3TnPewap8MT
 1qkxCQXrEq4AqJGQm2UsIrPa6k+p9WtLVbZRVNvLw4fuF8nrJiU5XsCtmB9vAmyCsWWl
 Nwx8xs5At/Qd/CbnmhyxWDoNSZv9tAXPGtPLSs9cJGJC+WE2x4qVUoy3P8ZKrerhi5mO sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btb2qpqqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 05:25:24 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19K8HqTi008252;
        Wed, 20 Oct 2021 05:25:23 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btb2qpqq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 05:25:23 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19K9HGlR004340;
        Wed, 20 Oct 2021 09:25:22 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3bqpcc2vaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 09:25:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19K9PLCo44564862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 09:25:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A21BE061;
        Wed, 20 Oct 2021 09:25:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E71DBBE062;
        Wed, 20 Oct 2021 09:25:14 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.103.88])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 09:25:14 +0000 (GMT)
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
Subject: [RFC PATCH v2 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Date:   Wed, 20 Oct 2021 14:54:52 +0530
Message-Id: <20211020092453.179929-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020092453.179929-1-aneesh.kumar@linux.ibm.com>
References: <20211020092453.179929-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X_iK_dfLN6zJikmL3goYIv5nDJDNUHbp
X-Proofpoint-ORIG-GUID: 3FJUwBBg7f1UZMwuFlXLekubag6za-jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200051
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
 include/linux/mempolicy.h |  1 +
 mm/mempolicy.c            | 54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 4091692bed8c..7a224d11bdd0 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -47,6 +47,7 @@ struct mempolicy {
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
 	nodemask_t nodes;	/* interleave/bind/perfer */
+	int home_node;		/* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
 
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6f0f607cd070..20415c9347e0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -296,6 +296,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
+	policy->home_node = NUMA_NO_NODE;
 
 	return policy;
 }
@@ -1483,6 +1484,52 @@ static long kernel_mbind(unsigned long start, unsigned long len,
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
@@ -1807,6 +1854,11 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
 	}
 
+	if ((policy->mode == MPOL_BIND ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    policy->home_node != NUMA_NO_NODE)
+		return policy->home_node;
+
 	return nd;
 }
 
@@ -2257,6 +2309,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
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

