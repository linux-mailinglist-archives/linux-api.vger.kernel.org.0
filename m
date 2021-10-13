Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AE842C115
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJMNOL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 09:14:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232949AbhJMNOL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 09:14:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DCEDkR020938;
        Wed, 13 Oct 2021 09:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qQZUk3i7MxLdM/AiCQ2hG5/ZKe/FWVR+Uo5yKP9+g/w=;
 b=sPHC86hCOI4niZAaOQE5/clfmXUoSJ4vqZ/x2gFRKJwNsJhS7NeuCi7KYD8fC+W+KbMj
 3irSfP9sUmwAeWFR0cnued+llfCH+p5zyDbm6obE/mKhp1RqPVfoseBEj+6KA2GNX2Sp
 pGqeQol4xuL+akMYiB4f+AFoF/hVdBaIqzJy8Hnoa0jBahxV6Xuo45S62bvpmnXH2uhi
 3bfWXgyK/80H+NNXgwD96j23guC+a+p6VkNs5cGbmRYNgBCv8QNbmEFl6hnW0vVW0czO
 0XIngojlgGpQKpzcYyS3ZxdcGiUXgTAPCMiQEvSzV/UMa5zqLj/UNp6wxTeV49j9FO5V QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bntpwyhkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 09:10:54 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DCovSx005791;
        Wed, 13 Oct 2021 09:10:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bntpwyhj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 09:10:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DD3ZfS014075;
        Wed, 13 Oct 2021 13:10:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3bk2qa0rmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 13:10:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DD54HK63635908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 13:05:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD48AE06F;
        Wed, 13 Oct 2021 13:10:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF72BAE05F;
        Wed, 13 Oct 2021 13:10:29 +0000 (GMT)
Received: from [9.43.38.58] (unknown [9.43.38.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 13:10:29 +0000 (GMT)
Message-ID: <adc63bf3-b8b6-c705-805d-a84633a7f728@linux.ibm.com>
Date:   Wed, 13 Oct 2021 18:40:26 +0530
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
 <9a0baa59-f316-103f-3030-990cd91d1813@linux.ibm.com>
 <YWbaAv/RGt+SCnql@dhcp22.suse.cz>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YWbaAv/RGt+SCnql@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KZWwtnUvCDy7mIR1Z7yOme5SE3z69sKB
X-Proofpoint-ORIG-GUID: QEXGOM9ytqnj8cZeq2ubueM60Fg7USs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=953 clxscore=1015 phishscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130088
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/13/21 18:37, Michal Hocko wrote:
> On Wed 13-10-21 18:28:40, Aneesh Kumar K.V wrote:
>> On 10/13/21 18:20, Michal Hocko wrote:
> [...]
>>> I am still not sure the semantic makes sense though. Why should
>>> the lowest node in the nodemask have any special meaning? What if it is
>>> a node with a higher number that somebody preferes to start with?
>>>
>>
>> That is true. I haven't been able to find an easy way to specify the
>> preferred node other than expressing it as first node in the node mask. Yes,
>> it limits the usage of the policy. Any alternate suggestion?
> 
> set_mempolicy is indeed not very suitable for something you are looking
> for. Could you be more specific why the initial node is so important?
> Is this because you want to allocate from a cpu less node first before
> falling back to others?
> 

One of the reason is that the thread that is faulting in pages first is 
not the one that is going to operate on this page long term. Application 
wants to hint the allocation node for the same reason they use 
MPOL_PREFERRED now.

-aneesh
