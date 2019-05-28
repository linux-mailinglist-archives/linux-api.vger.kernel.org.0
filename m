Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001F72C0C8
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE1IEw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 04:04:52 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:55556 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfE1IEv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 04:04:51 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5733E2E0A36;
        Tue, 28 May 2019 11:04:48 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id m59xZhNhfy-4l5i7XHm;
        Tue, 28 May 2019 11:04:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559030688; bh=M5GVJ5UIA7HPk8GVmrSjaHR1Kocs/6E9oStwcHVdqSs=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=sliMViUISlZv4ivdP47YUmKzIFD6JxWHzMWRPoMofXHi0Bl+gyker5cZo1ApiaRIX
         H6vjAeJxiF3qHI6Qw4jAKpxzBRUmSPeFLWG7TV+eAlkO5pB8z9Rfxi8B4u8tLqnMnt
         6Fk93jMvklQm1PE68ODKx+mLq0YhXEUE2EYY84v4=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 8KcqFbu0Vu-4llCBi6N;
        Tue, 28 May 2019 11:04:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from
 user space)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, linux-api@vger.kernel.org
References: <155895155861.2824.318013775811596173.stgit@buzz>
 <20190527141223.GD1658@dhcp22.suse.cz> <20190527142156.GE1658@dhcp22.suse.cz>
 <20190527143926.GF1658@dhcp22.suse.cz>
 <9c55a343-2a91-46c6-166d-41b94bf5e9c8@yandex-team.ru>
 <20190528065153.GB1803@dhcp22.suse.cz>
 <a4e5eeb8-3560-d4b4-08a0-8a22c677c0f7@yandex-team.ru>
 <20190528073835.GP1658@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5af1ba69-61d1-1472-4aa3-20beb4ae44ae@yandex-team.ru>
Date:   Tue, 28 May 2019 11:04:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528073835.GP1658@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 28.05.2019 10:38, Michal Hocko wrote:
> On Tue 28-05-19 10:30:12, Konstantin Khlebnikov wrote:
>> On 28.05.2019 9:51, Michal Hocko wrote:
>>> On Tue 28-05-19 09:25:13, Konstantin Khlebnikov wrote:
>>>> On 27.05.2019 17:39, Michal Hocko wrote:
>>>>> On Mon 27-05-19 16:21:56, Michal Hocko wrote:
>>>>>> On Mon 27-05-19 16:12:23, Michal Hocko wrote:
>>>>>>> [Cc linux-api. Please always cc this list when proposing a new user
>>>>>>>     visible api. Keeping the rest of the email intact for reference]
>>>>>>>
>>>>>>> On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
>>>>>> [...]
>>>>>>>> This implements manual kswapd-style memory reclaim initiated by userspace.
>>>>>>>> It reclaims both physical memory and cgroup pages. It works in context of
>>>>>>>> task who calls syscall madvise thus cpu time is accounted correctly.
>>>>>>
>>>>>> I do not follow. Does this mean that the madvise always reclaims from
>>>>>> the memcg the process is member of?
>>>>>
>>>>> OK, I've had a quick look at the implementation (the semantic should be
>>>>> clear from the patch descrition btw.) and it goes all the way up the
>>>>> hierarchy and finally try to impose the same limit to the global state.
>>>>> This doesn't really make much sense to me. For few reasons.
>>>>>
>>>>> First of all it breaks isolation where one subgroup can influence a
>>>>> different hierarchy via parent reclaim.
>>>>
>>>> madvise(NULL, size, MADV_STOCKPILE) is the same as memory allocation and
>>>> freeing immediately, but without pinning memory and provoking oom.
>>>>
>>>> So, there is shouldn't be any isolation or security issues.
>>>>
>>>> At least probably it should be limited with portion of limit (like half)
>>>> instead of whole limit as it does now.
>>>
>>> I do not think so. If a process is running inside a memcg then it is
>>> a subject of a limit and that implies an isolation. What you are
>>> proposing here is to allow escaping that restriction unless I am missing
>>> something. Just consider the following setup
>>>
>>> 		root (total memory = 2G)
>>> 		 / \
>>>              (1G) A   B (1G)
>>>                      / \
>>>              (500M) C   D (500M)
>>>
>>> all of them used up close to the limit and a process inside D requests
>>> shrinking to 250M. Unless I am misunderstanding this implementation
>>> will shrink D, B root to 250M (which means reclaiming C and A as well)
>>> and then globally if that was not sufficient. So you have allowed D to
>>> "allocate" 1,75G of memory effectively, right?
>>
>> It shrinks not 'size' memory - only while usage + size > limit.
>> So, after reclaiming 250M in D all other levels will have 250M free.
> 
> Could you define the exact semantic? Ideally something for the manual
> page please?
> 

Like kswapd which works with thresholds of free memory this one reclaims
until 'free' (i.e. memory which could be allocated without invoking
direct recliam of any kind) is lower than passed 'size' argument.

Thus right after madvise(NULL, size, MADV_STOCKPILE) 'size' bytes
could be allocated in this memory cgroup without extra latency from
reclaimer if there is no other memory consumers.

Reclaimed memory is simply put into free lists in common buddy allocator,
there is no reserves for particular task or cgroup.

If overall memory allocation rate is smooth without rough spikes then
calling MADV_STOCKPILE in loop periodically provides enough room for
allocations and eliminates direct reclaim from all other tasks.
As a result this eliminates unpredictable delays caused by
direct reclaim in random places.
