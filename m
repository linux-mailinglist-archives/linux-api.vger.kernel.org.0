Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8B1962E2
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2020 02:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgC1Bbf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Mar 2020 21:31:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52716 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC1Bbf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Mar 2020 21:31:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02S1TLMU178550;
        Sat, 28 Mar 2020 01:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fR5qDgzVr2L0h5vxEaP8fTihaDFhGIbo2x91LpYmtO4=;
 b=lI+rmT2F9XdBAyn+ZddMiWaiapiuEohek/qi/NLLO1CYcgvekecEw8jVBHYLcLVP7pTn
 4pxIWtSfGtoYUvqOqcZiENSNub5R0+CJX4WFLAlzeB98EJH4HfpDcZ92xEM6lkJv5jkB
 vTGFLc1D++TEpPJ2hjvJ+fgC8SDGH63/tNkwCqP03Ekzs+6JFu+p3OElYpfoXARwNAfH
 s12ixwzANZAZAYOeroKM+1qrw6zqzU0uSwAJ9CktShYj8JHt+64VkP1S2vXMcJVR9/Lb
 oQM8QQAGQmV3hf2F31MbEBp+Srxjl2KB+WhqjtykJ7Aeg0Yz/Kzzavt+1yoRNw8T6fHD YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 301459dudx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Mar 2020 01:31:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02S1T5RJ041114;
        Sat, 28 Mar 2020 01:31:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30073ja8m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Mar 2020 01:31:25 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02S1VOlU019098;
        Sat, 28 Mar 2020 01:31:24 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 18:31:24 -0700
Subject: Re: [PATCH] mm: introduce MAP_FIXED_HUGETLB_LEN to mmap()
To:     John Hubbard <jhubbard@nvidia.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>, linux-mm@kvack.org,
        Linux API <linux-api@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com>
 <a3444ac1-90d3-83fa-fd7b-85ea77c6e0ff@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0de74135-200f-ce91-3f27-5ab759220c9d@oracle.com>
Date:   Fri, 27 Mar 2020 18:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a3444ac1-90d3-83fa-fd7b-85ea77c6e0ff@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003280012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003280012
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/27/20 12:12 PM, John Hubbard wrote:
> On 3/27/20 5:59 AM, Li Xinhai wrote:
>> The purpose of MAP_FIXED_HUGETLB_LEN is to check whether the parameter
>> length is valid or not according to the target file's huge page size.
>> When it is used, if length is not aligned to underlying huge page size,
>> mmap() is failed with errno set to EINVAL. When it is not used, the
>> current semantic is maintained, i.e., length is round up to underlying
>> huge page size.
>>
>> In current code, the vma related call, except mmap, are all consider
>> not correctly aligned length as invalid parameter, including mprotect,
>> munmap, mlock, etc., by checking through hugetlb_vm_op_split. So, user
>> will see failure, after successfully call mmap, although using same
>> length parameter to other mapping syscall.
>>
>> With MAP_FIXED_HUGETLB_LEN, user can choose to check if length is
>> correctly aligned at first place when call mmap, instead of failure after
>> mapping has been created.
> 
> Hi Li,
> 
> This is not worth creating a new MAP_ flag. If you look at the existing flags
> you will see that they are both limited and carefully chosen, so as to cover
> a reasonable chunk of functionality per flag. We don't just drop in a flag
> for tiny corner cases like this one.
> 
> btw, remember that user API changes require man pages updates as well. And
> that the API has to be supported forever. And that if we use up valuable
> flag slots on trivia then we'll run out of flags quite soon, and won't be
> able to do broader, more important upgrades.
> 
> Also, we need to include a user space API mailing list for things that
> affect that. Adding them now: Linux API <linux-api@vger.kernel.org>
> The man pages mailing list will also be needed if we go there.
> 
> Let's take a closer look at your problem and see what it takes to solve it.
> If we need some sort of flag to mmap() or other routines, fine. But so far,
> I can see at least two solutions that are much easier:

I too question the motivation for this patch.  Is it simply to eliminate some
of the hugetlb special behavior and make it behave more like the rest of mm?

> Solution idea #2: just do the length check unconditionally here (without looking
> at a new flag), and return an error if it is not aligned. And same thing for the
> MAP_HUGETLB case below. And delete the "len = ALIGN(len, huge_page_size(hs));" in
> both cases.
> 
> That would still require a man page update, and consensus that it won't Break
> The World, but it's possible (I really don't know) that this is a more common
> and desirable behavior.
> 
> Let's see if anyone else weighs in about this.

That certainly would be the easiest thing to do.  However, I'm guessing
the current behavior was added when hugetlb mmap support was added.  There
is no telling how many applications might break if we change the behavior.
I'm guessing this is the reason Li chose to only change the behavior if
a new flag was specified.
-- 
Mike Kravetz
