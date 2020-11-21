Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40DA2BC24E
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 22:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgKUVlL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 16:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUVlL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 16:41:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B50C0613CF
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 13:41:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c9so14313892wml.5
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 13:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pf8Gn8Juj5s+1VjZTniQ4dGsLJwfS4VCpMGAd7uCp3Q=;
        b=pxBALrp/JtXJ+lG1u7yz1baE0hFmc0U1q2M5S+unHDz2e+Ftg01x+peinP05x27cWC
         CM1cBZF4QXpNv3GB1J5GaqYpeGD9nBUfPz+e3V4rQ1cLoaJpDZEVXIsq6IUAO1Ei/7QB
         87AJx2oNPfkaDhQWNrjwSwjrHJj+b4Yftbur39Cf4+cGBdDxqs4LRypBHf10flz2Rq1Y
         HzUlZa14sMbhPTWY6c+CLljxMMDRcrvET214dRJ3O+GHJKPgdhPdXULA1ZvsAzcSHfD6
         C81Eo0I595B1AIcJcXPSet6aS4rfH2ooytvsR59hA6Q6baevzUKs8L8PkmfYHbu2LovK
         Vy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pf8Gn8Juj5s+1VjZTniQ4dGsLJwfS4VCpMGAd7uCp3Q=;
        b=kTzu25GGcJs3xvBU5ymjeSloXP0g+9eu2ci+uTlYivmldTCN7lzk8Iq+fzpHt0Be4n
         8itD6Nm6T9pdt9BmFD4y4B3w8Ikx4P8S1Bl/XylXpapK6ivuA46calzTGVY2cRwiMcnH
         bVekkZrVP9HG1Ce3JwEwZyji7fc6RdiZD7MRwKD4zNp94G/l5WcVBRmVHLwrdrImRRK2
         bgLueXkwqCQe9njPBnD1CbqjALOyNyf7guyKCGkj2TGWt+Fq3ZhPrzSOBIq67pACr4Az
         vowmCOQdSXIj1W7K4Wp+GJnlZQnSTNL9aptRTAzUOpHaDgycQkjzbsYof+6HH5hh+E4x
         3cWw==
X-Gm-Message-State: AOAM530WEj5I1DLMlpB/OnfBMbiYiv29z4wrMbQjkR/IhtDWNAE3KXsk
        3r1CW5PiT7vV1/DKfr2xG8DEzEgItvytcw==
X-Google-Smtp-Source: ABdhPJzAz84oDayEaDfwJkIT7OTsbIB8MBbztmPG4OwmbSoKYHV/271/5xLMasLyZUYvnbjU6P12QQ==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr16207286wmg.90.1605994866740;
        Sat, 21 Nov 2020 13:41:06 -0800 (PST)
Received: from ?IPv6:2001:a61:24b3:de01:7310:e730:497d:ea6a? ([2001:a61:24b3:de01:7310:e730:497d:ea6a])
        by smtp.gmail.com with ESMTPSA id t13sm10232583wru.67.2020.11.21.13.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 13:41:05 -0800 (PST)
Cc:     mtk.manpages@gmail.com,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Problems with the new pthread clock implementations
To:     Mike Crowe <mac@mcrowe.com>
References: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
 <20201121175404.GA25323@mcrowe.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e8f58c73-d66e-3586-56cc-af116b750b28@gmail.com>
Date:   Sat, 21 Nov 2020 22:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201121175404.GA25323@mcrowe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Mike,

On 11/21/20 6:54 PM, Mike Crowe wrote:
> Hi Michael,
> 
> On Saturday 21 November 2020 at 07:59:04 +0100, Michael Kerrisk (man-pages) wrote:
>> I've been taking a closer look at the the new pthread*clock*() APIs:
>> pthread_clockjoin_np()
>> pthread_cond_clockwait()
>> pthread_mutex_clocklock()
>> pthread_rwlock_clockrdlock()
>> pthread_rwlock_clockwrlock()
>> sem_clockwait()
>>
>> I've noticed some oddities, and at least a couple of bugs.
>>
>> First off, I just note that there's a surprisingly wide variation in
>> the low-level futex calls being used by these APIs when implementing
>> CLOCK_REALTIME support:
>>
>> pthread_rwlock_clockrdlock()
>> pthread_rwlock_clockwrlock()
>> sem_clockwait()
>> pthread_cond_clockwait()
>>     futex(addr,
>>         FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 3,
>>         {abstimespec}, FUTEX_BITSET_MATCH_ANY)
>>     (This implementation seems to be okay)
>>
>> pthread_clockjoin_np()
>>     futex(addr, FUTEX_WAIT, 48711, {reltimespec})
>>     (This is buggy; see below.)
>>
>> pthread_mutex_clocklock()
>>     futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec})
>>     (There's bugs and strangeness here; see below.)
> 
> Yes, I found it very confusing when I started adding the new
> pthread*clock*() functions, and it still takes me a while to find the right
> functions when I look now. I believe that Adhemerval was talking about
> simplifying some of this.
> 
>> === Bugs ===
>>
>> pthread_clockjoin_np():
>> As already recognized in another mail thread [1], this API accepts any
>> kind of clockid, even though it doesn't support most of them.
> 
> Well, it sort of does support them at least as well as many other
> implementations of such functions do - it just calculates a relative
> timeout using the supplied lock and then uses that. But, ...
> 
>> A further bug is that even if CLOCK_REALTIME is specified,
>> pthread_clockjoin_np() sleeps against the CLOCK_MONOTONIC clock.
>> (Currently it does this for *all* clockid values.) The problem here is
>> that the FUTEX_WAIT operation sleeps against the CLOCK_MONOTONIC clock
>> by default. At the least, the FUTEX_CLOCK_REALTIME is required for
>> this case. Alternatively, an implementation using
>> FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME (like the first four
>> functions listed above) might be appropriate.
> 
> ...this is one downside of that. That bug was inherited from the
> existing pthread_clock_timedjoin_np implementation.

Oh -- that's pretty sad. I hadn't considered the possibility that
the (longstanding) "timed" functions might have the same bug.

> I was planning to write a patch to just limit the supported clocks, but
> I'll have a go at fixing the bug you describe properly instead first which
> will limit the implementation to CLOCK_REALTIME and CLOCK_MONOTONIC anyway.
> 
>> ===
>>
>> pthread_mutex_clocklock():
>> First of all, there's a small oddity. Suppose we specify the clockid
>> as CLOCK_REALTIME, and then while the call is blocked, we set the
>> clock realtime backwards. Then, there will be further futex calls to
>> handle the modification to the clock (and possibly multiple futex
>> calls if the realtime clock is adjusted repeatedly):
>>
>>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec1})
>>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec2})
>>         ...
>>
>> Then there seems to be a bug. If we specify the clockid as
>> CLOCK_REALTIME, and while the call is blocked we set the realtime
>> clock forwards, then the blocking interval of the call is *not*
>> adjusted (shortened), when of course it should be.
> 
> This is because __lll_clocklock_wait ends up doing a relative wait rather
> than an absolute one so it suffers from the same problem as
> pthread_clockjoin_np.
> 
>> ===
>>
>> I've attached a couple of small test programs at the end of this mail.
> 
> Thanks for looking at this in detail.
> 
> AFAIK, all of these bugs also affected the corresponding existing
> pthread*timed*() functions. When I added the new pthread*clock*() functions
> I was trying to keep my changes to the existing code as small as possible.
> (I started out trying to "scratch the itch" of libstdc++
> std::condition_variable::wait_for misbehaving[2] when the system clock was
> warped in 2015 and all of this ballooned from that.) Now that the functions
> are in, I think there's definitely scope for improving the implementation
> and I will try to do so as time and confidence allows - the implementation
> of __pthread_mutex_clocklock_common scares me greatly!

Yeah, a lot of glibc code is not so easy to follow... Thank you for
taking a look.

Cheers,

Michael

> [1] https://lore.kernel.org/linux-man/20201119120034.GA20599@mcrowe.com/
> [2] https://randombitsofuselessinformation.blogspot.com/2018/06/its-about-time-monotonic-time.html
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
