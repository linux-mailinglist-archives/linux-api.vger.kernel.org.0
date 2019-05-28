Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918C32BF77
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE1Gd2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 02:33:28 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36616 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfE1Gd2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 02:33:28 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 02:33:25 EDT
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 697642E09A5;
        Tue, 28 May 2019 09:25:14 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gjyj3ZqPVy-PDkmUO4v;
        Tue, 28 May 2019 09:25:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559024714; bh=K6zlxuXc3ZiiYmoECKuEjIeU1HxTh98Kh3YIPYtNrec=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=0UqRsySvqkS3LazKxNnApMjZpK/fP1oYQCh/U/or4cG9kcftMas6WFNhHUnoTm/mu
         xhatMyLM6ZE7I7HlX2it0JxbGr6r05Hd3NVN81shFwOyBHjHeocCoevZ6WNjmXGgQa
         ppF4bsoDsM3TaIHQpkY0itz36FQqkPfJa8J7/QvI=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jGMIvBUfvr-PDd4CQrV;
        Tue, 28 May 2019 09:25:13 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <9c55a343-2a91-46c6-166d-41b94bf5e9c8@yandex-team.ru>
Date:   Tue, 28 May 2019 09:25:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527143926.GF1658@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.05.2019 17:39, Michal Hocko wrote:
> On Mon 27-05-19 16:21:56, Michal Hocko wrote:
>> On Mon 27-05-19 16:12:23, Michal Hocko wrote:
>>> [Cc linux-api. Please always cc this list when proposing a new user
>>>   visible api. Keeping the rest of the email intact for reference]
>>>
>>> On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
>> [...]
>>>> This implements manual kswapd-style memory reclaim initiated by userspace.
>>>> It reclaims both physical memory and cgroup pages. It works in context of
>>>> task who calls syscall madvise thus cpu time is accounted correctly.
>>
>> I do not follow. Does this mean that the madvise always reclaims from
>> the memcg the process is member of?
> 
> OK, I've had a quick look at the implementation (the semantic should be
> clear from the patch descrition btw.) and it goes all the way up the
> hierarchy and finally try to impose the same limit to the global state.
> This doesn't really make much sense to me. For few reasons.
> 
> First of all it breaks isolation where one subgroup can influence a
> different hierarchy via parent reclaim.

madvise(NULL, size, MADV_STOCKPILE) is the same as memory allocation and
freeing immediately, but without pinning memory and provoking oom.

So, there is shouldn't be any isolation or security issues.

At least probably it should be limited with portion of limit (like half)
instead of whole limit as it does now.

> 
> I also have a problem with conflating the global and memcg states. Does
> it really make any sense to have the same target to the global state
> as per-memcg? How are you supposed to use this interface to shrink a
> particular memcg or for the global situation with a proportional
> distribution to all memcgs?

For now this is out of my use cease. This could be done in userspace
with multiple daemons in different contexts and connection between them.
In this case each daemon should apply pressure only its own level.

Also kernel could remember static pressure applied from each cgroup which
fades away when memory is allocated. And each call adds this pressure to
own requests to cooperate with neighbours. But rhight I don't know how to
implement this without over-engineering. Pure userspace solution looks
much better.

> 
> There also doens't seem to be anything about security model for this
> operation. There is no capability check from a quick look. Is it really
> safe to expose such a functionality for a common user?

Yep, it seems save. This is same as memory allocation and freeing.

> 
> Last but not least, I am not really convinced that madvise is a proper
> interface. It stretches the API which is address range based and it has
> per-process implications.
> 

Well, this is silly but semantic could be explained as preparation for
memory allocation via faulting into region. But since it doesn't need
to know exact range starting address could be arbitrary.

Also we employ MADV_POPULATE which implements batched faults into range
for robust memory allocation and undo for MADV_FREE. Will publish later.
