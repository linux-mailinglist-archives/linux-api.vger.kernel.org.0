Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F0462F21
	for <lists+linux-api@lfdr.de>; Tue, 30 Nov 2021 09:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhK3JCu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Nov 2021 04:02:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233648AbhK3JCt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Nov 2021 04:02:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU8qCXb024890;
        Tue, 30 Nov 2021 08:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=CfQ8Mj6Cs70Kv1kCZguVwnoRA/MRS8KTxiiOazk4Rgw=;
 b=QFecwQlQ08suKo445QYsrIy5p0j3OusC5y1213kKR24o0he4Rix4C0xcFpuvNrCl03Tm
 KktLx8qmEVJlUJpHIwhj6eQ4CUw1R/8B4qt3VL5ja6Nb9cEI+5AZed+ecGzbjOtT5uMw
 LsB8QpsMDRVoqepowj6heP7WJiEsCM4FDPLEYPktM5T479ImGHv3JvvfMd6qZN8HExHF
 hLYrRMyhZR9SvhBy4QHnWXYL8aalG/B0VcrXzQ2nE4ffXuNhYxVbUZ/zKBAFBreRgDK5
 FSO4Dfo7wa6VOQ6mkk5NOIDqDXYxrlaLVurNlnf/37z2YMLNuC0k8GkeFpB9PfnTsBGR aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cngtx04ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:59:14 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AU8vMH7007808;
        Tue, 30 Nov 2021 08:59:13 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cngtx049g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:59:13 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AU8ure7019856;
        Tue, 30 Nov 2021 08:59:12 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k1f9h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 08:59:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AU8xAmZ53477786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 08:59:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4586BBE058;
        Tue, 30 Nov 2021 08:59:10 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7C4CBE051;
        Tue, 30 Nov 2021 08:59:04 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.63.32])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 08:59:04 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Ben Widawsky <ben.widawsky@intel.com>,
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
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
In-Reply-To: <20211129140215.11b7cf9f1034a7fe7017768c@linux-foundation.org>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <20211129140215.11b7cf9f1034a7fe7017768c@linux-foundation.org>
Date:   Tue, 30 Nov 2021 14:29:02 +0530
Message-ID: <87wnkqaujt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Isb8HeIGH82avxoVez2urjQXPqnRT9eS
X-Proofpoint-GUID: 9VyevaRw_ioKTEHOEFVGOk5x9SwyTP7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_06,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300048
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 16 Nov 2021 12:12:37 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>
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
>> 
>> With MPOL_PREFERRED_MANY on the other hand will first try to allocate from the
>> closest node to node 2 from the node list 1, 2 and 3. If those nodes don't have
>> enough memory, kernel will allocate from slow memory node 10, 11 and 12 which
>> ever is closer to node 2.
>> 
>> ...
>>
>> @@ -1477,6 +1478,60 @@ static long kernel_mbind(unsigned long start, unsigned long len,
>>  	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
>>  }
>>  
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
> What's the thinking here?  The node can later be offlined and the
> kernel takes no action to reset home nodes, so why not permit setting a
> presently-offline node as the home node?  Checking here seems rather
> arbitrary?

The node online check was needed to avoid accessing 
uninitialised pgdat structure. Such an access can result in
below crash

cpu 0x0: Vector: 300 (Data Access) at [c00000000a693840]                                                                                                                                      
    pc: c0000000004e9bac: __next_zones_zonelist+0xc/0xa0                                                                                                                                      
    lr: c000000000558d54: __alloc_pages+0x474/0x540                                                                                                                                           
    sp: c00000000a693ae0                                                                                                                                                                      
   msr: 8000000000009033                                                                                                                                                                      
   dar: 1508                                                                                                                                                                                  
 dsisr: 40000000                                                                                                                                                                              
  current = 0xc0000000087f8380                                                                                                                                                                
  paca    = 0xc000000003130000   irqmask: 0x03   irq_happened: 0x01                                                                                                                           
    pid   = 1161, comm = test_mpol_prefe                                                                                                                                                      
Linux version 5.16.0-rc3-14872-gd6ef4ee28b4f-dirty (kvaneesh@ltc-boston8) (gcc (Ubuntu 9.3.0-1                                                                                                
7ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #505 SMP Mon Nov 29 22:16:49 CST                                                                                                
 2021                                                                                                                                                                                         
enter ? for help                                                                                                                                                                              
[link register   ] c000000000558d54 __alloc_pages+0x474/0x540                                                                                                                                 
[c00000000a693ae0] c000000000558c68 __alloc_pages+0x388/0x540 (unreliable)                                                                                                                    
[c00000000a693b60] c00000000059299c alloc_pages_vma+0xcc/0x380                                                                                                                                
[c00000000a693bd0] c00000000052129c __handle_mm_fault+0xcec/0x1900                                                                                                                            
[c00000000a693cc0] c000000000522094 handle_mm_fault+0x1e4/0x4f0                                                                                                                               
[c00000000a693d20] c000000000087288 ___do_page_fault+0x2f8/0xc20                               
[c00000000a693de0] c000000000087e50 do_page_fault+0x60/0x130                                   
[c00000000a693e10] c00000000000891c data_access_common_virt+0x19c/0x1f0                        
--- Exception: 300 (Data Access) at 000074931e429160                                           
SP (7fffe8116a50) is in userspace
0:mon>                                         

Now IIUC, even after a node is marked offline via try_offline_node() we
still be able to access the zonelist details using the pgdata struct. 
I was not able to force a NUMA node offline in my test, even after removing the
memory assigned to it. 

root@ubuntu-guest:/sys/devices/system/node/node2# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1
node 0 size: 4046 MB
node 0 free: 3362 MB
node 1 cpus: 2 3
node 1 size: 4090 MB
node 1 free: 3788 MB
node 2 cpus:
node 2 size: 0 MB
node 2 free: 0 MB
node 3 cpus: 6 7
node 3 size: 4063 MB
node 3 free: 3832 MB
node distances:
node   0   1   2   3 
  0:  10  11  222  33 
  1:  44  10  55  66 
  2:  77  88  10  99 
  3:  101  121  132  10 

