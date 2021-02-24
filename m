Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128913239CF
	for <lists+linux-api@lfdr.de>; Wed, 24 Feb 2021 10:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhBXJrA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Feb 2021 04:47:00 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52684 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234728AbhBXJpp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Feb 2021 04:45:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UPRGkQZ_1614159898;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UPRGkQZ_1614159898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 17:44:59 +0800
Subject: Re: [RFC] Hugepage collapse in process context
To:     David Rientjes <rientjes@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Chris Kennelly <ckennelly@google.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
 <YCzSDPbBsksCX5zP@dhcp22.suse.cz>
 <0b51a213-650e-7801-b6ed-9545466c15db@suse.cz>
 <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com>
 <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <25d9347b-9359-efab-e1e3-f98bd0012af9@linux.alibaba.com>
Date:   Wed, 24 Feb 2021 17:44:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



ÔÚ 2021/2/19 ÉÏÎç6:34, David Rientjes Ð´µÀ:
> On Thu, 18 Feb 2021, David Hildenbrand wrote:
> 
>>>>> Hi everybody,
>>>>>
>>>>> Khugepaged is slow by default, it scans at most 4096 pages every 10s.
>>>>> That's normally fine as a system-wide setting, but some applications
>>>>> would
>>>>> benefit from a more aggressive approach (as long as they are willing to
>>>>> pay for it).
>>>>>
>>>>> Instead of adding priorities for eligible ranges of memory to
>>>>> khugepaged,
>>>>> temporarily speeding khugepaged up for the whole system, or sharding its
>>>>> work for memory belonging to a certain process, one approach would be to
>>>>> allow userspace to induce hugepage collapse.
>>>>>
>>>>> The benefit to this approach would be that this is done in process
>>>>> context
>>>>> so its cpu is charged to the process that is inducing the collapse.
>>>>> Khugepaged is not involved.
>>>>
>>>> Yes, this makes a lot of sense to me.
>>>>
>>>>> Idea was to allow userspace to induce hugepage collapse through the new
>>>>> process_madvise() call.  This allows us to collapse hugepages on behalf
>>>>> of
>>>>> current or another process for a vectored set of ranges.
>>>>
>>>> Yes, madvise sounds like a good fit for the purpose.
>>>
>>> Agreed on both points.
>>>
>>>>> This could be done through a new process_madvise() mode *or* it could be
>>>>> a
>>>>> flag to MADV_HUGEPAGE since process_madvise() allows for a flag
>>>>> parameter
>>>>> to be passed.  For example, MADV_F_SYNC.
>>>>
>>>> Would this MADV_F_SYNC be applicable to other madvise modes? Most
>>>> existing madvise modes do not seem to make much sense. We can argue that
>>>> MADV_PAGEOUT would guarantee the range was indeed reclaimed but I am not
>>>> sure we want to provide such a strong semantic because it can limit
>>>> future reclaim optimizations.
>>>>
>>>> To me MADV_HUGEPAGE_COLLAPSE sounds like the easiest way forward.
>>>
>>> I guess in the old madvise(2) we could create a new combo of MADV_HUGEPAGE |
>>> MADV_WILLNEED with this semantic? But you are probably more interested in
>>> process_madvise() anyway. There the new flag would make more sense. But
>>> there's
>>> also David H.'s proposal for MADV_POPULATE and there might be benefit in
>>> considering both at the same time? Should e.g. MADV_POPULATE with
>>> MADV_HUGEPAGE
>>> have the collapse semantics? But would MADV_POPULATE be added to
>>> process_madvise() as well? Just thinking out loud so we don't end up with
>>> more
>>> flags than necessary, it's already confusing enough as it is.
>>>
>>
>> Note that madvise() eats only a single value, not flags. Combinations as you
>> describe are not possible.
>>
>> Something MADV_HUGEPAGE_COLLAPSE make sense to me that does not need the mmap
>> lock in write and does not modify the actual VMA, only a mapping.
>>
> 
> Agreed, and happy to see that there's a general consensus for the 
> direction.  Benefit of a new madvise mode is that it can be used for 
> madvise() as well if you are interested in only a single range of your own 
> memory and then it doesn't need to reconcile with any of the already 
> overloaded semantics of MADV_HUGEPAGE.

It's a good idea to let process deal with its own THP policy.
but current applications will miss the benefit w/o changes, and change is
expensive for end users. So except this work, may a per memcg collapse benefit
apps and free for them, we often deploy apps in cgroups on server now.

Thanks
Alex

> 
> Otherwise, process_madvise() can be used for other processes and/or 
> vectored ranges.
> 
> Song's use case for this to prioritize thp usage is very important for us 
> as well.  I hadn't thought of the madvise(MADV_HUGEPAGE) + 
> madvise(MADV_HUGEPAGE_COLLAPSE) use case: I was anticipating the latter 
> would allocate the hugepage with khugepaged's gfp mask so it would always 
> compact.  But it seems like this would actually be better to use the gfp 
> mask that would be used at fault for the vma and left to userspace to 
> determine whether that's MADV_HUGEPAGE or not.  Makes sense.
> 
> (Userspace could even do madvise(MADV_NOHUGEPAGE) + 
> madvise(MADV_HUGEPAGE_COLLAPSE) to do the synchronous collapse but 
> otherwise exclude it from khugepaged's consideration if it were inclined.)
> 
> Two other minor points:
> 
>  - Currently, process_madvise() doesn't use the flags parameter at all so 
>    there's the question of whether we need generalized flags that apply to 
>    most madvise modes or whether the flags can be specific to the mode 
>    being used.  For example, a natural extension of this new mode would be 
>    to determine the hugepage size if we were ever to support synchronous 
>    collapse into a 1GB gigantic page on x86 (MADV_F_1GB? :)
> 
>  - We haven't discussed the future of khugepaged with this new mode: it 
>    seems like we could simply implement khugepaged fully in userspace and 
>    remove it from the kernel? :)
> 
