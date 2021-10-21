Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BED435D75
	for <lists+linux-api@lfdr.de>; Thu, 21 Oct 2021 10:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJUI7M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Oct 2021 04:59:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231522AbhJUI7J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Oct 2021 04:59:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L7ItPt019615;
        Thu, 21 Oct 2021 04:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=echc3DzREK6J1oFPNohjICQhoWIOUCqBxXnkPFQ43qA=;
 b=VNI0heQkkP8hjEAP8s8/B8quAV2AVA9jQDZSHntIPjUfYH5hMLyKfNygZSYtnN7CvJ1v
 VSA+ox3RYHGiOhGOgmNdJKL5ReRCje3RlQmVXlQs2mGi39UPpvQbtTLjFgVcgR5A7+TU
 mS0wUd0zFLqQpqsZnYWKlBDV4NeGdhICIvGyPFRhGAXZCyaG0Dt5wPiDeHhfxp9n938G
 iBdbSUvAnONyoCq0VOnP8BExrX00q6FnrVUlqrhnIAyTt8xHsE4kWnFvIem10SSvRSWS
 cYvlT26oIFiNnaJLnqTIXPaYJDzg5Ct6VarsDXzFtw3oLJr3PY0/WNOMy6hw2VZ+ACuV AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu3px1w48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 04:56:38 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19L7siAN004283;
        Thu, 21 Oct 2021 04:56:37 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu3px1w3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 04:56:37 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19L8mI9D025787;
        Thu, 21 Oct 2021 08:56:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3bqpcahwwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 08:56:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19L8odp854985080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 08:50:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C8D2A405E;
        Thu, 21 Oct 2021 08:56:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02F01A4040;
        Thu, 21 Oct 2021 08:56:29 +0000 (GMT)
Received: from [9.43.107.166] (unknown [9.43.107.166])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Oct 2021 08:56:28 +0000 (GMT)
Message-ID: <328c2e3c-6adb-033f-87a0-8f80296f833f@linux.ibm.com>
Date:   Thu, 21 Oct 2021 14:26:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH v2 2/3] mm/mempolicy: add set_mempolicy_home_node
 syscall
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
References: <20211020092453.179929-1-aneesh.kumar@linux.ibm.com>
 <20211020092453.179929-2-aneesh.kumar@linux.ibm.com>
 <20211021073206.GA20861@shbuild999.sh.intel.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20211021073206.GA20861@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JagBSYIwgAlzCKhNyAt8n5yd_RezAVFT
X-Proofpoint-GUID: GHWVbkPq0cM8uCTxojShxjGBny4y7DuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=821 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210041
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/21/21 13:02, Feng Tang wrote:
> Hi Aneesh,
> 
> On Wed, Oct 20, 2021 at 02:54:52PM +0530, Aneesh Kumar K.V wrote:
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
> 
> I can understand the requirement for MPOL_BIND, and for MPOL_PREFERRED_MANY,
> it provides 3 levels of preference:
>    home node --> preferred nodes --> all nodes
> Any real usage cases for this? For a platform which may have 3 types of
> memory (HBM, DRAM, PMEM), this may be useful.

The patch was based on a need to enable an application (that is already 
using MPOL_PREFERRED to hint a preference node) to run on a system with 
different types of memory (fast and slow memory).

> 
>> This helps applications to hint at a memory allocation preference node
>> and fallback to _only_ a set of nodes if the memory is not available
>> on the preferred node.  Fallback allocation is attempted from the node which is
>> nearest to the preferred node.
>>
>> This helps applications to have control on memory allocation numa nodes and
>> avoids default fallback to slow memory NUMA nodes. For example a system with
>> NUMA nodes 1,2 and 3 with DRAM memory and 10, 11 and 12 of slow memory
>>
>>   new_nodes = numa_bitmask_alloc(nr_nodes);
>>
>>   numa_bitmask_setbit(new_nodes, 1);
>>   numa_bitmask_setbit(new_nodes, 2);
>>   numa_bitmask_setbit(new_nodes, 3);
>>
>>   p = mmap(NULL, nr_pages * page_size, protflag, mapflag, -1, 0);
>>   mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,  new_nodes->size + 1, 0);
>>
>>   sys_set_mempolicy_home_node(p, nr_pages * page_size, 2, 0);
>   
> For this example, it's 'mbind + sys_set_mempolicy_home_node', will case
> 'set_mempolicy + sys_set_mempolicy_home_node' be also supported?
> 

At this point it is not asked for. Hence the patch is looking up for vma 
policy to set the home node. If there is a need to set home node for a 
task, we can look at adding the same. I have kept flags variable, that 
should help us to accommodate such a request if we get one in the future.

-aneesh
