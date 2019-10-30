Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E96E95C6
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 05:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfJ3EdD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 00:33:03 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47440 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfJ3EdD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Oct 2019 00:33:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tgg3fnq_1572409976;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tgg3fnq_1572409976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Oct 2019 12:32:59 +0800
Subject: Re: mbind() breaks its API definition since v5.2 by commit
 d883544515aa (mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE*
 and MPOL_MF_STRICT were specified)
To:     Li Xinhai <lixinhai.lxh@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lixinhai_lxh <lixinhai_lxh@126.com>
References: <2019103010274679257634@gmail.com>
 <dc4864bf-8fa3-f5c8-f68c-57edc68d4662@linux.alibaba.com>
 <2019103011122763779044@gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <da734171-bd69-b56b-2ca9-3038790155dd@linux.alibaba.com>
Date:   Tue, 29 Oct 2019 21:32:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2019103011122763779044@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 10/29/19 8:12 PM, Li Xinhai wrote:
> On 2019-10-30 at 10:50 Yang Shi wrote:
>>
>> On 10/29/19 7:27 PM, Li Xinhai wrote:
>>> One change in do_mbind() of this commit has suspicious usage of return value of
>>> queue_pages_range(), excerpt as below:
>>>
>>> ---
>>> @@ -1243,10 +1265,15 @@ static long do_mbind(unsigned long start, unsigned long len,
>>>     	if (err)
>>>     	goto mpol_out;
>>>    
>>> -	err = queue_pages_range(mm, start, end, nmask,
>>> +	ret = queue_pages_range(mm, start, end, nmask,
>>>     	 flags | MPOL_MF_INVERT, &pagelist);
>>> -	if (!err)
>>> -	err = mbind_range(mm, start, end, new);
>>> +
>>> +	if (ret < 0) {      /////// convert to all possible 'ret' to '-EIO' <<<<
>>> +	err = -EIO;
>>> +	goto up_out;
>>> +	}
>>> +
>>> +	err = mbind_range(mm, start, end, new);
>>>    
>>>     	if (!err) {
>>>     	int nr_failed = 0;
>>> ---
>>>
>>> Note that inside queue_pages_range(), the call to walk_page_range() may return
>>> errors from 'test_walk' of 'struct mm_walk_ops', e.g. -EFAULT. Now, those error
>>> codes are no longer reported to user space application.
>>>
>>>    From user space, the mbind() call need to reported error, with EFAULT, as example:
>>> EFAULT
>>> Part or all of the memory range specified by nodemask and maxnode points
>>> outside your accessible address space. Or, there was an unmapped hole in the
>>> specified memory range specified by addr and len.
>> Thanks for catching this. That commit was aimed to correct the return
>> values for some corner cases in mbind(), but it should not alter the
>> errno for other failure cases, i.e. -EFAULT.
>>
>> Could you please try the below patch (build test only)?
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 4ae967b..99df43a 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -1286,7 +1286,7 @@ static long do_mbind(unsigned long start, unsigned
>> long len,
>>                            flags | MPOL_MF_INVERT, &pagelist);
>>
>>          if (ret < 0) {
>> -               err = -EIO;
>> +               err = ret;
>>                  goto up_out;
>>          }
>>
>>
> This seems do not work, because the 'pagelist' would have some pages queued
> into it, need to put back those pages instead of return quickly.
>
> So, we need to remove this page leak as well. <<<<<<
>
> In my understanding, revert the changes as I quoted above may solve it, but not sure
> the details about changes at end of do_mbind(), should keep them at there without
> further change?

Thanks for pointing this out. We don't have to revert this commit to 
handle the non-empty pagelist correctly. The simplest way is to just put 
those pages back and I'm supposed this is also the preferred way since 
mbind_range() is not called to really apply the policy so those pages 
should not be migrated.

The below patch should solve this:

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967b..d80025c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1286,7 +1286,10 @@ static long do_mbind(unsigned long start, 
unsigned long len,
                           flags | MPOL_MF_INVERT, &pagelist);

         if (ret < 0) {
-               err = -EIO;
+               if (!list_empty(&pagelist))
+                       putback_movable_pages(&pagelist);
+
+               err = ret;
                 goto up_out;
         }

>
> - Xinhai
>
>>> Please correct me if this is the intended change(and will have updated API
>>> definition), or something was misunderstood.
>>>
>>> -Xinhai
> >

