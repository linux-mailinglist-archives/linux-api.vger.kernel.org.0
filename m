Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4751D44C4BA
	for <lists+linux-api@lfdr.de>; Wed, 10 Nov 2021 16:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKJP7K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Nov 2021 10:59:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhKJP7K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Nov 2021 10:59:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAFIbKf030034;
        Wed, 10 Nov 2021 15:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zJVn3pCvyG4wbU/9YLj1S4GmUorIzqJgxqXedZHgLlY=;
 b=Lqp/5fjKLbwdzIfkuYaOsR0w0vARu9O0O6kINxULk+PxdnvNZdnoP7WcWprJGqVzTNVM
 94WZTEms1NSqO+VW4Iwa3ps3jzXuGuEvho7s0o6ftEEYRCnUaG+Ay23lWyUwNSR2r+b7
 zBy9OoA/aABosL9aHiouaRcdJX5p8dxZQWE0nRcDkamcH7bICyWkCTYUxxbKpdeD1gce
 wJL9kShrde7ATp5/D28GAI6opyUk3sGKfeS6Tr/4R2/lcAjANt3VCTZlr5cUHrJ+uI+v
 sECR5bjK11TXrBeJ3RD11zCsjEGezywUJMsUNI/kbIR7AfPFVWJC+Ymuu5SSSBGPyNbb Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c8gm28ty6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:56:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AAFrWAh001343;
        Wed, 10 Nov 2021 15:56:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c8gm28tx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:56:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AAFj7oR025344;
        Wed, 10 Nov 2021 15:56:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3c5hbam5cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 15:56:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AAFnM4v42926574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 15:49:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5600C52052;
        Wed, 10 Nov 2021 15:56:01 +0000 (GMT)
Received: from [9.43.87.13] (unknown [9.43.87.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 311D752050;
        Wed, 10 Nov 2021 15:55:55 +0000 (GMT)
Message-ID: <e46eecaf-5c93-1ef3-a3c8-2a72c9c8dd3b@linux.ibm.com>
Date:   Wed, 10 Nov 2021 21:25:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, Ben Widawsky <ben.widawsky@intel.com>,
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
References: <20211101050206.549050-1-aneesh.kumar@linux.ibm.com>
 <20211101050206.549050-3-aneesh.kumar@linux.ibm.com>
 <871r3okpjh.fsf@meer.lwn.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <871r3okpjh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xsOoGOKCXADymWOh323nxMxnfdrvKHaT
X-Proofpoint-GUID: L6SNECGRnExaZfBbJFaAaUIqIOttrayr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100081
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/10/21 20:48, Jonathan Corbet wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> This syscall can be used to set a home node for the MPOL_BIND
>> and MPOL_PREFERRED_MANY memory policy. Users should use this
>> syscall after setting up a memory policy for the specified range
>> as shown below.
> 
> So I noticed one little thing as I was looking at this...
> 
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
>> +		new->home_node = home_node;
>> +		err = mbind_range(mm, vmstart, vmend, new);
>> +		if (err)
>> +			break;
>> +	}
>> +	mmap_write_unlock(mm);
>> +	return err;
>> +}
> 
> You never do anything with flags; I believe you want to check and ensure
> that it's zero if there are no defined flags at this point?
> 
>

Will update that in v5. I guess EINVAL is the right error for flags != 0?

-aneesh
