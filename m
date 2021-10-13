Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D773A42C1F0
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 15:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhJMN7z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 09:59:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236338AbhJMN7u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 09:59:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DDiqr5000381;
        Wed, 13 Oct 2021 09:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IihffKGcUPmMJ3a5tn/7rkwdO4yJhhTGDQI0EXjZiRI=;
 b=m/bmbcTCQdpObvj6ANkssp31goMgsESX5+iURy4vHYTBgYTmBGfHE2PFa6R/7GO74zuR
 MJ9MIw+tRCu+7+mOCfvwsMY5Yt3iE9iY3OP91RI/FvVoaAhIoqAi+apImTICpz0gFBXk
 g1WcqqAYlSBgAQX3w/MHFVJzN/Px3avvvfAGCw5jmeb193/jCvykZhw/yoUUJJIF9UFd
 JeDUoKNiq2ZppszRZksvRJtzv+FWl++TE1r23xKq7Tt0B/dAY2Q7FT3/EXT9F/kWSahm
 /GcmKoJP+9/J3sVnMFp2FPO6slMpGAJDHq5AkNRJZlXm1ijug42KURM3YBn0IuuCUS6j tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnprjd77p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 09:57:31 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DDDC2P016897;
        Wed, 13 Oct 2021 09:57:31 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bnprjd776-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 09:57:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DDlWwX023844;
        Wed, 13 Oct 2021 13:57:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qabf02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 13:57:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DDvKAs45351248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 13:57:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7433EAE061;
        Wed, 13 Oct 2021 13:57:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 925DFAE06A;
        Wed, 13 Oct 2021 13:57:08 +0000 (GMT)
Received: from [9.43.38.58] (unknown [9.43.38.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 13:57:08 +0000 (GMT)
Message-ID: <291424a2-c962-533e-c755-e4239fd55f5d@linux.ibm.com>
Date:   Wed, 13 Oct 2021 19:27:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH] mm/mempolicy: add MPOL_PREFERRED_STRICT memory policy
Content-Language: en-US
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
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
 <YWa4FoicH0VztGTl@dhcp22.suse.cz> <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
 <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
 <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
 <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
In-Reply-To: <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iOqfaxLJPHZ71LWO6y_2WHiZ8owaTpqB
X-Proofpoint-ORIG-GUID: gWxYkwUQOHh4R9GBeUc0VBiur3ukgFVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=840 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130092
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/13/21 18:28, Aneesh Kumar K.V wrote:
> On 10/13/21 18:20, Michal Hocko wrote:
>> On Wed 13-10-21 18:05:49, Aneesh Kumar K.V wrote:
>>> On 10/13/21 16:18, Michal Hocko wrote:
>>>> On Wed 13-10-21 12:42:34, Michal Hocko wrote:
>>>>> [Cc linux-api]
>>>>>
>>>>> On Wed 13-10-21 15:15:39, Aneesh Kumar K.V wrote:
>>>>>> This mempolicy mode can be used with either the set_mempolicy(2)
>>>>>> or mbind(2) interfaces.  Like the MPOL_PREFERRED interface, it
>>>>>> allows an application to set a preference node from which the kernel
>>>>>> will fulfill memory allocation requests. Unlike the MPOL_PREFERRED 
>>>>>> mode,
>>>>>> it takes a set of nodes. The nodes in the nodemask are used as 
>>>>>> fallback
>>>>>> allocation nodes if memory is not available on the preferred node.
>>>>>> Unlike MPOL_PREFERRED_MANY, it will not fall back memory allocations
>>>>>> to all nodes in the system. Like the MPOL_BIND interface, it works 
>>>>>> over a
>>>>>> set of nodes and will cause a SIGSEGV or invoke the OOM killer if
>>>>>> memory is not available on those preferred nodes.
>>>>>>
>>>>>> This patch helps applications to hint a memory allocation 
>>>>>> preference node
>>>>>> and fallback to _only_ a set of nodes if the memory is not available
>>>>>> on the preferred node.  Fallback allocation is attempted from the 
>>>>>> node which is
>>>>>> nearest to the preferred node.
>>>>>>
>>>>>> This new memory policy helps applications to have explicit control 
>>>>>> on slow
>>>>>> memory allocation and avoids default fallback to slow memory NUMA 
>>>>>> nodes.
>>>>>> The difference with MPOL_BIND is the ability to specify a 
>>>>>> preferred node
>>>>>> which is the first node in the nodemask argument passed.
>>>>
>>>> I am sorry but I do not understand the semantic diffrence from
>>>> MPOL_BIND. Could you be more specific please?
>>>>
>>>
>>>
>>>
>>> MPOL_BIND
>>>     This mode specifies that memory must come from the set of
>>>     nodes specified by the policy.  Memory will be allocated from
>>>     the node in the set with sufficient free memory that is
>>>     closest to the node where the allocation takes place.
>>>
>>>
>>> MPOL_PREFERRED_STRICT
>>>     This mode specifies that the allocation should be attempted
>>>     from the first node specified in the nodemask of the policy.
>>>     If that allocation fails, the kernel will search other nodes
>>>     in the nodemask, in order of increasing distance from the
>>>     preferred node based on information provided by the platform   
>>> firmware.
>>>
>>> The difference is the ability to specify the preferred node as the first
>>> node in the nodemask and all fallback allocations are based on the 
>>> distance
>>> from the preferred node. With MPOL_BIND they base based on the node 
>>> where
>>> the allocation takes place.
>>
>> OK, this makes it more clear. Thanks!
>>
>> I am still not sure the semantic makes sense though. Why should
>> the lowest node in the nodemask have any special meaning? What if it is
>> a node with a higher number that somebody preferes to start with?
>>
> 
> That is true. I haven't been able to find an easy way to specify the 
> preferred node other than expressing it as first node in the node mask. 
> Yes, it limits the usage of the policy. Any alternate suggestion?
> 
> We could do
> set_mempolicy(MPOLD_PREFERRED, nodemask(nodeX)))
> set_mempolicy(MPOLD_PREFFERED_EXTEND, nodemask(fallback nodemask for 
> above PREFERRED policy))
> 
> But that really complicates the interface?
> 
>

Another option is to keep this mbind(2) specific and overload flags to 
be the preferred nodeid.

mbind(va, len, MPOL_PREFERRED_STRICT, nodemask, max_node, preferred_node);

  -aneesh

