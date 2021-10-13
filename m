Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2842C02F
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhJMMij (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 08:38:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233369AbhJMMii (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 08:38:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DCBJEh024119;
        Wed, 13 Oct 2021 08:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=36ACxvP8tHqsmzjnFDbMcxh4XUJSl3B4D2wdJwXzntQ=;
 b=dWksr4aS9xm+iOovdHYeZ0o5r8wytKU0UsVbR3KQF4HbdS4hBz2mZNwq1qFltxmC35j1
 EsZwVpd3p5YSwa6H4WUaxOLBGQSapjFmsziu8Fo08G+/DgT3+S98qvA8whbwYY2Px/Hh
 Hge7GnkIMo3F/+xH8TjMhpCpww0X9m4BzHtgqMByBmWgwIxMKzRqVHtZ+mlOyoOFRm2j
 jwKJWF8qAcgFa8hpLRwOO0uENyltpHiKZAkYAVS0Z2ncHSV5wrLmNsYzMn02rcDKEbYn
 LxPKOatPbCHuubB/kGGPl7jGPiFmVoewiSdfPHjML6lxbvSrS6aZ4P/LBuxMMeu7xDMY tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnqmpactp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 08:36:15 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DBj0b8015468;
        Wed, 13 Oct 2021 08:36:14 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnqmpacsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 08:36:13 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DCXXng003271;
        Wed, 13 Oct 2021 12:36:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3bk2qa0f1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:36:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DCUQJ164160038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 12:30:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44A94AE04D;
        Wed, 13 Oct 2021 12:36:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A911AE063;
        Wed, 13 Oct 2021 12:35:53 +0000 (GMT)
Received: from [9.43.38.58] (unknown [9.43.38.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 12:35:52 +0000 (GMT)
Message-ID: <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
Date:   Wed, 13 Oct 2021 18:05:49 +0530
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
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dasGsp-4Zblut8ynbpSZ492iHBxL-gAv
X-Proofpoint-ORIG-GUID: x4FsEmAvDeMkahv2C7as-pE5gnvNoJO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=808
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130084
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/13/21 16:18, Michal Hocko wrote:
> On Wed 13-10-21 12:42:34, Michal Hocko wrote:
>> [Cc linux-api]
>>
>> On Wed 13-10-21 15:15:39, Aneesh Kumar K.V wrote:
>>> This mempolicy mode can be used with either the set_mempolicy(2)
>>> or mbind(2) interfaces.  Like the MPOL_PREFERRED interface, it
>>> allows an application to set a preference node from which the kernel
>>> will fulfill memory allocation requests. Unlike the MPOL_PREFERRED mode,
>>> it takes a set of nodes. The nodes in the nodemask are used as fallback
>>> allocation nodes if memory is not available on the preferred node.
>>> Unlike MPOL_PREFERRED_MANY, it will not fall back memory allocations
>>> to all nodes in the system. Like the MPOL_BIND interface, it works over a
>>> set of nodes and will cause a SIGSEGV or invoke the OOM killer if
>>> memory is not available on those preferred nodes.
>>>
>>> This patch helps applications to hint a memory allocation preference node
>>> and fallback to _only_ a set of nodes if the memory is not available
>>> on the preferred node.  Fallback allocation is attempted from the node which is
>>> nearest to the preferred node.
>>>
>>> This new memory policy helps applications to have explicit control on slow
>>> memory allocation and avoids default fallback to slow memory NUMA nodes.
>>> The difference with MPOL_BIND is the ability to specify a preferred node
>>> which is the first node in the nodemask argument passed.
> 
> I am sorry but I do not understand the semantic diffrence from
> MPOL_BIND. Could you be more specific please?
> 



MPOL_BIND
	This mode specifies that memory must come from the set of
	nodes specified by the policy.  Memory will be allocated from
	the node in the set with sufficient free memory that is
	closest to the node where the allocation takes place.


MPOL_PREFERRED_STRICT
	This mode specifies that the allocation should be attempted
	from the first node specified in the nodemask of the policy.
	If that allocation fails, the kernel will search other nodes
	in the nodemask, in order of increasing distance from the
	preferred node based on information provided by the platform   firmware.

The difference is the ability to specify the preferred node as the first 
node in the nodemask and all fallback allocations are based on the 
distance from the preferred node. With MPOL_BIND they base based on the 
node where the allocation takes place.

-aneesh

-aneesh
