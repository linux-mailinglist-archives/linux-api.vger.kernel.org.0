Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7B2B785
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfE0Oag (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 10:30:36 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47398 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfE0Oag (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 10:30:36 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id BBD552E0443;
        Mon, 27 May 2019 17:30:32 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id e8Wsdjfvxe-UV5ivtGg;
        Mon, 27 May 2019 17:30:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558967432; bh=7qLRUcrPwsW5zqic4YMh4GiJeUahg2HnH6OlPeS5QxU=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=sZ+nULcNfpXw4488ph8T3fFpY67ss5VqhjNQj6mGo6huQCGDB8dRvy6foEzHo4b76
         MJwIK5XNb5758igtdz2KoVwMsyi8QgIOH4swDHzKDl/9rL2JcDSLSd/L2nBp1hO+M2
         LL5GB6yQRSYSm3bnHraLoeqW2e/3FIRnQxb4CG2w=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:d877:17c:81de:6e43])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id I2Oi11RdUk-UV8COmwf;
        Mon, 27 May 2019 17:30:31 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <e17e1370-9e88-e50c-94e3-736c122c1baf@yandex-team.ru>
Date:   Mon, 27 May 2019 17:30:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527142156.GE1658@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.05.2019 17:21, Michal Hocko wrote:
> On Mon 27-05-19 16:12:23, Michal Hocko wrote:
>> [Cc linux-api. Please always cc this list when proposing a new user
>>   visible api. Keeping the rest of the email intact for reference]
>>
>> On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
> [...]
>>> This implements manual kswapd-style memory reclaim initiated by userspace.
>>> It reclaims both physical memory and cgroup pages. It works in context of
>>> task who calls syscall madvise thus cpu time is accounted correctly.
> 
> I do not follow. Does this mean that the madvise always reclaims from
> the memcg the process is member of?
> 

First it reclaims in its own memcg while limit - usage < requested.
Then repeats this in parent memcg and so on. And at least pokes global
direct reclaimer while system wide free memory is less than requested.

So, if machine is divided into containers without overcommit global
reclaim will never happens - memcg will free enough memory.
