Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C637343DD3B
	for <lists+linux-api@lfdr.de>; Thu, 28 Oct 2021 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1JAX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Oct 2021 05:00:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58766 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhJ1JAX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Oct 2021 05:00:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S8kPNt021757;
        Thu, 28 Oct 2021 08:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H9joglvr5oJ6g3PlHzqqljos/bygqxE9a4oaFS8xuJI=;
 b=TBp0FQe3xFtTAZvS92LM06QMTbPB/L6ENBjZ+riSWWIZ/2n5FTy9FnL9SOVSfp5YBH2S
 9wi1A0KypcNWXNFSXP52FKPwAd/HhqLsnY/3mh1/hIkX+iV9nvQ0XLJlF8P6Q9zuEdbp
 SJhsoQKwsdFLhkss+zJD88zkgJ7XJvQ0n67TP8AOukWiCCGpRFqkn0wKMPZg++3hHBkt
 N5t6UkvozLgnDKC6uLnkp/1VT6Av7n7c9NNE+D/V8adDcnW6C9jSLI5y91z4BRR7M+1Z
 GWuLbiCTZ+gZiO2GS9f/xzD1KpCeTxIc8AoWZ0bj5Dad2z2DhuZ7qwdPhOJHikBfgpZS qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byrn7r6jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 08:57:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19S8kdcD024888;
        Thu, 28 Oct 2021 08:57:41 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byrn7r6j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 08:57:41 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19S8rXph005971;
        Thu, 28 Oct 2021 08:57:40 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3bx4f8rf1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 08:57:40 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19S8vc8u32571658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 08:57:39 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9836E084;
        Thu, 28 Oct 2021 08:57:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8C616E091;
        Thu, 28 Oct 2021 08:57:31 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.43.151])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 08:57:31 +0000 (GMT)
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
Subject: [PATCH v3 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Date:   Thu, 28 Oct 2021 14:27:00 +0530
Message-Id: <20211028085701.505593-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211028085701.505593-1-aneesh.kumar@linux.ibm.com>
References: <20211028085701.505593-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PGoCrTsEVa0taM-6xLrTvtFazHtBDodu
X-Proofpoint-ORIG-GUID: vWEq2E6hZfBtqqJkNTKHEGP9hikep25E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280044
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
 mm/mempolicy.c                                | 54 +++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

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
index 35a0e72c74a3..dfb760d30e7d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -296,6 +296,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	atomic_set(&policy->refcnt, 1);
 	policy->mode = mode;
 	policy->flags = flags;
+	policy->home_node = NUMA_NO_NODE;
 
 	return policy;
 }
@@ -1477,6 +1478,52 @@ static long kernel_mbind(unsigned long start, unsigned long len,
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
@@ -1801,6 +1848,11 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
 	}
 
+	if ((policy->mode == MPOL_BIND ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    policy->home_node != NUMA_NO_NODE)
+		return policy->home_node;
+
 	return nd;
 }
 
@@ -2251,6 +2303,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
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

