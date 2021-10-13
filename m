Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD342C0CE
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJMNBb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 09:01:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233662AbhJMNBa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 09:01:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DAj2RV030875;
        Wed, 13 Oct 2021 08:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I6QWnvh7CDu2cHlUScZ2g8w/ZhEhc7C3C6S2gifLyME=;
 b=Ws+G4uwqkB/gfDXzxpI/LZDYvx2SPF5g9WnWRrT7aJK/BPZDvZRr35lqI8UuzyTTJvs8
 H0X/qOu/gWryLFYZNRukfeRQZ1jsLPBOj1iM7E0dU/uR2qcFHTSGkd34zat4/c1vy+oB
 vjxnLXzpppdGsp4RxVw6ggnWT5BFMCE8YPluSyoB+B8Y7sv8iu70Fj+CWfjVFcKUWYsS
 rjsQY5ZpCjfoGBBJFwF4jlPZZwPmM/uJkJzDoOiSH/DqXFrsvFuYjzc2e2lYzfafHv18
 fUWsHrqLJ2f709y2W7ndL4xrX8Krzr2OYH2x/i88Zbdx9nbk5cV82Stbb2L1TAkOPD6V NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnm40x6wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 08:59:09 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DBeZCN008462;
        Wed, 13 Oct 2021 08:59:08 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnm40x6vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 08:59:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DCvRxc026011;
        Wed, 13 Oct 2021 12:59:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9tw9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:59:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DCwtQn2163296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 12:58:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 116F4AE04D;
        Wed, 13 Oct 2021 12:58:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2B5AAE068;
        Wed, 13 Oct 2021 12:58:43 +0000 (GMT)
Received: from [9.43.38.58] (unknown [9.43.38.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 12:58:43 +0000 (GMT)
Message-ID: <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
Date:   Wed, 13 Oct 2021 18:28:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH] mm/mempolicy: add MPOL_PREFERRED_STRICT memory policy
Content-Language: en-US
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
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
 <YWa4FoicH0VztGTl@dhcp22.suse.cz> <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
 <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
 <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: do1FoY5ZMD10-LI6VnV8SC0i2V0OHcD5
X-Proofpoint-GUID: vo7-CIkvo6E282yGxa_abL5WBqbghWMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=818 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130084
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/13/21 18:20, Michal Hocko wrote:
> On Wed 13-10-21 18:05:49, Aneesh Kumar K.V wrote:
>> On 10/13/21 16:18, Michal Hocko wrote:
>>> On Wed 13-10-21 12:42:34, Michal Hocko wrote:
>>>> [Cc linux-api]
>>>>
>>>> On Wed 13-10-21 15:15:39, Aneesh Kumar K.V wrote:
>>>>> This mempolicy mode can be used with either the set_mempolicy(2)
>>>>> or mbind(2) interfaces.  Like the MPOL_PREFERRED interface, it
>>>>> allows an application to set a preference node from which the kernel
>>>>> will fulfill memory allocation requests. Unlike the MPOL_PREFERRED mode,
>>>>> it takes a set of nodes. The nodes in the nodemask are used as fallback
>>>>> allocation nodes if memory is not available on the preferred node.
>>>>> Unlike MPOL_PREFERRED_MANY, it will not fall back memory allocations
>>>>> to all nodes in the system. Like the MPOL_BIND interface, it works over a
>>>>> set of nodes and will cause a SIGSEGV or invoke the OOM killer if
>>>>> memory is not available on those preferred nodes.
>>>>>
>>>>> This patch helps applications to hint a memory allocation preference node
>>>>> and fallback to _only_ a set of nodes if the memory is not available
>>>>> on the preferred node.  Fallback allocation is attempted from the node which is
>>>>> nearest to the preferred node.
>>>>>
>>>>> This new memory policy helps applications to have explicit control on slow
>>>>> memory allocation and avoids default fallback to slow memory NUMA nodes.
>>>>> The difference with MPOL_BIND is the ability to specify a preferred node
>>>>> which is the first node in the nodemask argument passed.
>>>
>>> I am sorry but I do not understand the semantic diffrence from
>>> MPOL_BIND. Could you be more specific please?
>>>
>>
>>
>>
>> MPOL_BIND
>> 	This mode specifies that memory must come from the set of
>> 	nodes specified by the policy.  Memory will be allocated from
>> 	the node in the set with sufficient free memory that is
>> 	closest to the node where the allocation takes place.
>>
>>
>> MPOL_PREFERRED_STRICT
>> 	This mode specifies that the allocation should be attempted
>> 	from the first node specified in the nodemask of the policy.
>> 	If that allocation fails, the kernel will search other nodes
>> 	in the nodemask, in order of increasing distance from the
>> 	preferred node based on information provided by the platform   firmware.
>>
>> The difference is the ability to specify the preferred node as the first
>> node in the nodemask and all fallback allocations are based on the distance
>> from the preferred node. With MPOL_BIND they base based on the node where
>> the allocation takes place.
> 
> OK, this makes it more clear. Thanks!
> 
> I am still not sure the semantic makes sense though. Why should
> the lowest node in the nodemask have any special meaning? What if it is
> a node with a higher number that somebody preferes to start with?
> 

That is true. I haven't been able to find an easy way to specify the 
preferred node other than expressing it as first node in the node mask. 
Yes, it limits the usage of the policy. Any alternate suggestion?

We could do
set_mempolicy(MPOLD_PREFERRED, nodemask(nodeX)))
set_mempolicy(MPOLD_PREFFERED_EXTEND, nodemask(fallback nodemask for 
above PREFERRED policy))

But that really complicates the interface?

-aneesh
