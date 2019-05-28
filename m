Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588C52C1E7
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 10:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfE1I6x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 04:58:53 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:33994 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbfE1I6x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 04:58:53 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 820A62E0A7B;
        Tue, 28 May 2019 11:58:50 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id uDbd8mNgjG-wnp8YhTV;
        Tue, 28 May 2019 11:58:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559033930; bh=e67vXEFlguLHoPzm4i6XNcC1TsQ4C+poa1KdWpDWoFM=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=u3veDeuDUQqhxqZN/gx25dJHfV9rTVsyH55dJyggW9tsHn9L8tEWLJMbVDXtSNkn+
         /Mu+KdcC/MNOuZx0EXTTo9HeqV7S1epVvwf7ngTgKEAJdcLz0aKJuK6/qOcof9TqCc
         5C72JSfB2X5Dg3IePfeIr7t3TMMHRgLn5I8OXHEs=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 56Lg4wTzc1-wn8qqC4T;
        Tue, 28 May 2019 11:58:49 +0300
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
 <5af1ba69-61d1-1472-4aa3-20beb4ae44ae@yandex-team.ru>
 <20190528084243.GT1658@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4ecf491b-68b5-9a65-5074-648a4f94d2b0@yandex-team.ru>
Date:   Tue, 28 May 2019 11:58:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528084243.GT1658@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 28.05.2019 11:42, Michal Hocko wrote:
> On Tue 28-05-19 11:04:46, Konstantin Khlebnikov wrote:
>> On 28.05.2019 10:38, Michal Hocko wrote:
> [...]
>>> Could you define the exact semantic? Ideally something for the manual
>>> page please?
>>>
>>
>> Like kswapd which works with thresholds of free memory this one reclaims
>> until 'free' (i.e. memory which could be allocated without invoking
>> direct recliam of any kind) is lower than passed 'size' argument.
> 
> s@lower@higher@ I guess

Yep. My wording still bad.
'size' argument should be called 'watermark' or 'threshold'.

I.e. reclaim while 'free' memory is lower passed 'threshold'.

> 
>> Thus right after madvise(NULL, size, MADV_STOCKPILE) 'size' bytes
>> could be allocated in this memory cgroup without extra latency from
>> reclaimer if there is no other memory consumers.
>>
>> Reclaimed memory is simply put into free lists in common buddy allocator,
>> there is no reserves for particular task or cgroup.
>>
>> If overall memory allocation rate is smooth without rough spikes then
>> calling MADV_STOCKPILE in loop periodically provides enough room for
>> allocations and eliminates direct reclaim from all other tasks.
>> As a result this eliminates unpredictable delays caused by
>> direct reclaim in random places.
> 
> OK, this makes it more clear to me. Thanks for the clarification!
> I have clearly misunderstood and misinterpreted target as the reclaim
> target rather than free memory target.  Sorry about the confusion.
> I sill think that this looks like an abuse of the madvise but if there
> is a wider consensus this is acceptable I will not stand in the way.
> 
