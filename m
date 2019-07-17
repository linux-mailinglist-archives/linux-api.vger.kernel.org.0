Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705E56C16D
	for <lists+linux-api@lfdr.de>; Wed, 17 Jul 2019 21:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGQTZO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jul 2019 15:25:14 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57125 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbfGQTZO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Jul 2019 15:25:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TX8x0ih_1563391508;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX8x0ih_1563391508)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 03:25:10 +0800
Subject: Re: [v2 PATCH 2/2] mm: mempolicy: handle vma with unmovable pages
 mapped correctly in mbind
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
 <1561162809-59140-3-git-send-email-yang.shi@linux.alibaba.com>
 <0cbc99f6-76a9-7357-efa7-a2d551b3cd12@suse.cz>
 <9defdc16-c825-05b7-b394-abdf39000220@linux.alibaba.com>
 <3197a7df-c7bc-2bac-3d40-dbfc97d4a909@linux.alibaba.com>
 <7be3d36a-19fe-2e3b-8840-27fb5fd60f15@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a5c48e13-68a3-ae0f-6554-d06fc79b2fe4@linux.alibaba.com>
Date:   Wed, 17 Jul 2019 12:25:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7be3d36a-19fe-2e3b-8840-27fb5fd60f15@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 7/17/19 11:50 AM, Vlastimil Babka wrote:
> On 7/17/19 8:23 PM, Yang Shi wrote:
>>
>> On 7/16/19 10:28 AM, Yang Shi wrote:
>>>
>>> On 7/16/19 5:07 AM, Vlastimil Babka wrote:
>>>> On 6/22/19 2:20 AM, Yang Shi wrote:
>>>>> @@ -969,10 +975,21 @@ static long do_get_mempolicy(int *policy,
>>>>> nodemask_t *nmask,
>>>>>    /*
>>>>>     * page migration, thp tail pages can be passed.
>>>>>     */
>>>>> -static void migrate_page_add(struct page *page, struct list_head
>>>>> *pagelist,
>>>>> +static int migrate_page_add(struct page *page, struct list_head
>>>>> *pagelist,
>>>>>                    unsigned long flags)
>>>>>    {
>>>>>        struct page *head = compound_head(page);
>>>>> +
>>>>> +    /*
>>>>> +     * Non-movable page may reach here.  And, there may be
>>>>> +     * temporaty off LRU pages or non-LRU movable pages.
>>>>> +     * Treat them as unmovable pages since they can't be
>>>>> +     * isolated, so they can't be moved at the moment.  It
>>>>> +     * should return -EIO for this case too.
>>>>> +     */
>>>>> +    if (!PageLRU(head) && (flags & MPOL_MF_STRICT))
>>>>> +        return -EIO;
>>>>> +
>>>> Hm but !PageLRU() is not the only way why queueing for migration can
>>>> fail, as can be seen from the rest of the function. Shouldn't all cases
>>>> be reported?
>>> Do you mean the shared pages and isolation failed pages? I'm not sure
>>> whether we should consider these cases break the semantics or not, so
>>> I leave them as they are. But, strictly speaking they should be
>>> reported too, at least for the isolation failed page.
> CC'd linux-api, should be done on v3 posting also.
>
>> By reading mbind man page, it says:
>>
>> If MPOL_MF_MOVE is specified in flags, then the kernel will attempt to
>> move all the existing pages in the memory range so that they follow the
>> policy.  Pages that are shared with other processes will not be moved.
>> If MPOL_MF_STRICT is also specified, then the call fails with the error
>> EIO if some pages could not be moved.
> I don't think this means that for shared pages, -EIO should not be
> reported. I can imagine both interpretations of the paragraph. I guess
> we can be conservative and keep not reporting them, if that was always
> the case - but then perhaps clarify the man page?

Yes, I agree the man page does looks ambiguous.  Anyway, I think we 
could add a patch later to kernel or manpage for either interpretations 
once it gets clarified.

>
>> It looks the code already handles shared page correctly, we just need
>> return -EIO for isolation failed page if MPOL_MF_STRICT is specified.
>>
>>> Thanks,
>>> Yang
>>>
>>>>>        /*
>>>>>         * Avoid migrating a page that is shared with others.
>>>>>         */
>>>>> @@ -984,6 +1001,8 @@ static void migrate_page_add(struct page *page,
>>>>> struct list_head *pagelist,
>>>>>                    hpage_nr_pages(head));
>>>>>            }
>>>>>        }
>>>>> +
>>>>> +    return 0;
>>>>>    }
>>>>>      /* page allocation callback for NUMA node migration */
>>>>> @@ -1186,9 +1205,10 @@ static struct page *new_page(struct page
>>>>> *page, unsigned long start)
>>>>>    }
>>>>>    #else
>>>>>    -static void migrate_page_add(struct page *page, struct list_head
>>>>> *pagelist,
>>>>> +static int migrate_page_add(struct page *page, struct list_head
>>>>> *pagelist,
>>>>>                    unsigned long flags)
>>>>>    {
>>>>> +    return -EIO;
>>>>>    }
>>>>>      int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>>>>>

