Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4294612DE
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 11:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353942AbhK2Kvz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 05:51:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1354018AbhK2Ktx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 05:49:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATAMbkM005554;
        Mon, 29 Nov 2021 10:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=qZqIIUR0KtLNk8bWDiOIpWyy/7tvi90Z7UaiIGCCjjI=;
 b=Jpm2UfpwQ8iajJgLviKf43gNCTNrCy94logCU6i0fa7yAYlFtfhbEDIuZVMMOJl8cK6F
 3LgvutEJWeFy55W1ydOt97AIn+ctTS0SjOlqZiXa5GS50In1FL7eHX2Gi02oj2AD6KMn
 8bwLYHt116UeTiPPCAz1SFd5KsMKo9TCs/JGRMP1sgZ/pSNaxfor9HfNYhMkPNypDKQv
 QmAXcdawpARTs6PmM2cUK/agAXubCS4Jjj7M/7gjBHBymYbWsAw+GdKYy0HuoqQ1ZAPb
 lYug65p5iB42wjhu6ttDdKlBzEl37BJRjaixL+xmmw25oCtMozLqEeBBHxk6sC+zVNuA yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmw2aredd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 10:46:16 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATAPTSX014150;
        Mon, 29 Nov 2021 10:46:15 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmw2arecx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 10:46:15 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATAhFXv019221;
        Mon, 29 Nov 2021 10:46:14 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3ckcaadspg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 10:46:14 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATAkDMl57606430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 10:46:13 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93841112065;
        Mon, 29 Nov 2021 10:46:13 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 721E711206E;
        Mon, 29 Nov 2021 10:46:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.56.137])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 10:46:08 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
In-Reply-To: <YaSsR0z6GN07qyH7@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <YaSsR0z6GN07qyH7@dhcp22.suse.cz>
Date:   Mon, 29 Nov 2021 16:16:05 +0530
Message-ID: <87fsrf1bpu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7iMLzSYndp8oDC-GcOE-63xjpfxDzWXq
X-Proofpoint-ORIG-GUID: UHNP75zR8L0phuDWcn7en_iMdnmh8xQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290052
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Tue 16-11-21 12:12:37, Aneesh Kumar K.V wrote:
>> This syscall can be used to set a home node for the MPOL_BIND
>> and MPOL_PREFERRED_MANY memory policy. Users should use this
>> syscall after setting up a memory policy for the specified range
>> as shown below.
>> 
>> mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,
>> 	    new_nodes->size + 1, 0);
>> sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
>> 				  home_node, 0);
>> 
>> The syscall allows specifying a home node/preferred node from which kernel
>> will fulfill memory allocation requests first.
>> 
>> For address range with MPOL_BIND memory policy, if nodemask specifies more
>> than one node, page allocations will come from the node in the nodemask
>> with sufficient free memory that is closest to the home node/preferred node.
>> 
>> For MPOL_PREFERRED_MANY if the nodemask specifies more than one node,
>> page allocation will come from the node in the nodemask with sufficient
>> free memory that is closest to the home node/preferred node. If there is
>> not enough memory in all the nodes specified in the nodemask, the allocation
>> will be attempted from the closest numa node to the home node in the system.
>> 
>> This helps applications to hint at a memory allocation preference node
>> and fallback to _only_ a set of nodes if the memory is not available
>> on the preferred node.  Fallback allocation is attempted from the node which is
>> nearest to the preferred node.
>> 
>> This helps applications to have control on memory allocation numa nodes and
>> avoids default fallback to slow memory NUMA nodes. For example a system with
>> NUMA nodes 1,2 and 3 with DRAM memory and 10, 11 and 12 of slow memory
>> 
>>  new_nodes = numa_bitmask_alloc(nr_nodes);
>> 
>>  numa_bitmask_setbit(new_nodes, 1);
>>  numa_bitmask_setbit(new_nodes, 2);
>>  numa_bitmask_setbit(new_nodes, 3);
>> 
>>  p = mmap(NULL, nr_pages * page_size, protflag, mapflag, -1, 0);
>>  mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,  new_nodes->size + 1, 0);
>> 
>>  sys_set_mempolicy_home_node(p, nr_pages * page_size, 2, 0);
>> 
>> This will allocate from nodes closer to node 2 and will make sure kernel will
>> only allocate from nodes 1, 2 and3. Memory will not be allocated from slow memory
>> nodes 10, 11 and 12
>
> I think you are not really explaining why the home node is really needed
> for that usecase. You can limit memory access to those nodes even
> without the home node. Why the defaulot local node is insufficient is
> really a missing part in the explanation.
>
> One usecase would be cpu less nodes and their preference for the
> allocation. If there are others make sure to mention them in the
> changelog.

Will add this.

>
>> With MPOL_PREFERRED_MANY on the other hand will first try to allocate from the
>> closest node to node 2 from the node list 1, 2 and 3. If those nodes don't have
>> enough memory, kernel will allocate from slow memory node 10, 11 and 12 which
>> ever is closer to node 2.
>> 
>> Cc: Ben Widawsky <ben.widawsky@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Feng Tang <feng.tang@intel.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: linux-api@vger.kernel.org
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  .../admin-guide/mm/numa_memory_policy.rst     | 14 ++++-
>>  include/linux/mempolicy.h                     |  1 +
>>  mm/mempolicy.c                                | 62 +++++++++++++++++++
>>  3 files changed, 76 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
>> index 64fd0ba0d057..6eab52d4c3b2 100644
>> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
>> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
>> @@ -408,7 +408,7 @@ follows:
>>  Memory Policy APIs
>>  ==================
>>  
>> -Linux supports 3 system calls for controlling memory policy.  These APIS
>> +Linux supports 4 system calls for controlling memory policy.  These APIS
>>  always affect only the calling task, the calling task's address space, or
>>  some shared object mapped into the calling task's address space.
>>  
>> @@ -460,6 +460,18 @@ requested via the 'flags' argument.
>>  
>>  See the mbind(2) man page for more details.
>>  
>> +Set home node for a Range of Task's Address Spacec::
>> +
>> +	long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>> +  					 unsigned long home_node,
>> +					 unsigned long flags);
>> +
>> +sys_set_mempolicy_home_node set the home node for a VMA policy present in the
>> +task's address range. The system call updates the home node only for the existing
>> +mempolicy range. Other address ranges are ignored.
>
>> A home node is the NUMA node
>> +closest to which page allocation will come from.
>
> I woudl repgrase
> The home node override the default allocation policy to allocate memory
> close to the local node for an executing CPU.
>

ok

> [...]
>
>> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
>> +		unsigned long, home_node, unsigned long, flags)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma;
>> +	struct mempolicy *new;
>> +	unsigned long vmstart;
>> +	unsigned long vmend;
>> +	unsigned long end;
>> +	int err = -ENOENT;
>> +
>> +	if (start & ~PAGE_MASK)
>> +		return -EINVAL;
>> +	/*
>> +	 * flags is used for future extension if any.
>> +	 */
>> +	if (flags != 0)
>> +		return -EINVAL;
>> +
>> +	if (!node_online(home_node))
>> +		return -EINVAL;
>
> You really want to check the home_node before dereferencing the mask.
>

Any reason why we want to check for home node first?

>> +
>> +	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
>> +	end = start + len;
>> +
>> +	if (end < start)
>> +		return -EINVAL;
>> +	if (end == start)
>> +		return 0;
>> +	mmap_write_lock(mm);
>> +	vma = find_vma(mm, start);
>> +	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
>> +
>> +		vmstart = max(start, vma->vm_start);
>> +		vmend   = min(end, vma->vm_end);
>> +		new = mpol_dup(vma_policy(vma));
>> +		if (IS_ERR(new)) {
>> +			err = PTR_ERR(new);
>> +			break;
>> +		}
>> +		/*
>> +		 * Only update home node if there is an existing vma policy
>> +		 */
>> +		if (!new)
>> +			continue;
>
> Your changelog only mentions MPOL_BIND and MPOL_PREFERRED_MANY as
> supported but you seem to be applying the home node to all existing
> policieso


The restriction is done in policy_node. 

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




>
>> +		new->home_node = home_node;
>> +		err = mbind_range(mm, vmstart, vmend, new);
>> +		if (err)
>> +			break;
>> +	}
>> +	mmap_write_unlock(mm);
>> +	return err;
>> +}
>> +
>
> Other than that I do not see any major issues.
> -- 
> Michal Hocko
> SUSE Labs


-aneesh
