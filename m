Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807972C016
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 09:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE1HaR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 03:30:17 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35856 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfE1HaR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 03:30:17 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9F0C32E1491;
        Tue, 28 May 2019 10:30:13 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WmZsxO0Rsv-UCpWmw9d;
        Tue, 28 May 2019 10:30:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559028613; bh=b0tnBEaeSE0wx9SZBTkiemsceGG2gh/BPri5iBFlmTM=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=DeNEc67DccTvfjrv2GfpuCVW+0gZXFHC6VH0rBG93Qz6lpTLSEf0QDCDa+3WL7I+X
         GZ8AN9RY+GikIyHi0zKEkYkJ7LcVcPAMrKYVVVMk3GQ1tgfpYnF2u0AnUQXSJ9zY2x
         SaDK7qu1acKd2GlSFahxObLpKxDazFH1JAOnVFfc=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id bD1sDRHzsZ-UClmLKBl;
        Tue, 28 May 2019 10:30:12 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a4e5eeb8-3560-d4b4-08a0-8a22c677c0f7@yandex-team.ru>
Date:   Tue, 28 May 2019 10:30:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528065153.GB1803@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 28.05.2019 9:51, Michal Hocko wrote:
> On Tue 28-05-19 09:25:13, Konstantin Khlebnikov wrote:
>> On 27.05.2019 17:39, Michal Hocko wrote:
>>> On Mon 27-05-19 16:21:56, Michal Hocko wrote:
>>>> On Mon 27-05-19 16:12:23, Michal Hocko wrote:
>>>>> [Cc linux-api. Please always cc this list when proposing a new user
>>>>>    visible api. Keeping the rest of the email intact for reference]
>>>>>
>>>>> On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
>>>> [...]
>>>>>> This implements manual kswapd-style memory reclaim initiated by userspace.
>>>>>> It reclaims both physical memory and cgroup pages. It works in context of
>>>>>> task who calls syscall madvise thus cpu time is accounted correctly.
>>>>
>>>> I do not follow. Does this mean that the madvise always reclaims from
>>>> the memcg the process is member of?
>>>
>>> OK, I've had a quick look at the implementation (the semantic should be
>>> clear from the patch descrition btw.) and it goes all the way up the
>>> hierarchy and finally try to impose the same limit to the global state.
>>> This doesn't really make much sense to me. For few reasons.
>>>
>>> First of all it breaks isolation where one subgroup can influence a
>>> different hierarchy via parent reclaim.
>>
>> madvise(NULL, size, MADV_STOCKPILE) is the same as memory allocation and
>> freeing immediately, but without pinning memory and provoking oom.
>>
>> So, there is shouldn't be any isolation or security issues.
>>
>> At least probably it should be limited with portion of limit (like half)
>> instead of whole limit as it does now.
> 
> I do not think so. If a process is running inside a memcg then it is
> a subject of a limit and that implies an isolation. What you are
> proposing here is to allow escaping that restriction unless I am missing
> something. Just consider the following setup
> 
> 		root (total memory = 2G)
> 		 / \
>             (1G) A   B (1G)
>                     / \
>             (500M) C   D (500M)
> 
> all of them used up close to the limit and a process inside D requests
> shrinking to 250M. Unless I am misunderstanding this implementation
> will shrink D, B root to 250M (which means reclaiming C and A as well)
> and then globally if that was not sufficient. So you have allowed D to
> "allocate" 1,75G of memory effectively, right?

It shrinks not 'size' memory - only while usage + size > limit.
So, after reclaiming 250M in D all other levels will have 250M free.

Of course there might be race because reclaimer works with one level
at the time. Probably it should start from inner level at each iteration.

>   
>>>
>>> I also have a problem with conflating the global and memcg states. Does
>>> it really make any sense to have the same target to the global state
>>> as per-memcg? How are you supposed to use this interface to shrink a
>>> particular memcg or for the global situation with a proportional
>>> distribution to all memcgs?
>>
>> For now this is out of my use cease. This could be done in userspace
>> with multiple daemons in different contexts and connection between them.
>> In this case each daemon should apply pressure only its own level.
> 
> Do you expect all daemons to agree on their shrinking target? Could you
> elaborate? I simply do not see how this can work with memcgs lower in
> the hierarchy having a smaller limit than their parents.
> 

Daemons could distribute pressure among leaves and propagate it into parents.
Together with low-limit this gives enough control over pressure distribution.
