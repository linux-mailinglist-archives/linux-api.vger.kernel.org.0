Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0F2C0DCE
	for <lists+linux-api@lfdr.de>; Mon, 23 Nov 2020 15:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgKWOjC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Nov 2020 09:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgKWOjB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Nov 2020 09:39:01 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9A2C0613CF
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 06:39:01 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 7so13488054qtp.1
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z1dses8M5H+nWlQ4Tjd6h3mov9TeDVgweoEVdcEDSCc=;
        b=ZSgr3JDvj8OvO69U1lOJuZTeLd71tTMu4cekuHuqR6FunlgIlhuWuT12XcP7lsKNil
         7a2ZG6gzF6k1luexT+ZrCJXwQ2MptjQJPQ5FkwIFUUENxBFOCkPuIBT/BlQUljyOCXEp
         ufYAx16DJMNoqo60v6kOsyGnXv+0NuJn+Oz6MBUqmv/uhV0cFU0pK+9Tyr9m1jaLbWrD
         clAXcS5NdEYrQC3BrQs0LnotYJTxBJ460l6rUAnO6ATtx5ic0Y1P+NIBH3suUG4invlw
         QU97//5j0gyTy474h7kVRxCNC4aunJkVPoWPeQGQ7BNGOE6ChjcCRKkJjM/r4oi9p+IZ
         xS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z1dses8M5H+nWlQ4Tjd6h3mov9TeDVgweoEVdcEDSCc=;
        b=MFphV0gVC/Ce+YswRJhfKPb/1Qywlz48aM29SmvLNXXrCfCyy5YMDfIzr17Meng2G2
         Q0pjXHAE59BPwa/DSH12ptQEB+EaubecQSXyZsr22xrhCMRantEJE3Wly67Zc5uOyeya
         Y2r6nww2Dk1dVI5AC/ncYOkydXwXIUAlo51yNOcc/8R8xrJWtmnTdiViK78UkpOwG9b0
         x3dQT1EyEFbpyfmcF8qEK4kWJiQfV1I/ZxJOxg5J5NY1VQMNKOZHxcWbaL89pzawyv+C
         Z9eVmgD8zgEP9O85cTBip4uPkqpi9zyijsw/CXnpuMizFRRXbMBi178dk6OqMDCszrr3
         GGiw==
X-Gm-Message-State: AOAM531J62vA9FElbDU1INa3DJS55719/FMNHg6Hv5CNMdr9dRyTPkQd
        vuHy/b3gqXFkcYxka4aTN117AoKrGbp+Rg==
X-Google-Smtp-Source: ABdhPJzYbBOByWhnJxzLbV8dF5FmUNKYbtaRT3hU1+XcyWA0hjz7McnjXA6/g4crqMtFwLIr6pTKqQ==
X-Received: by 2002:ac8:5d53:: with SMTP id g19mr30365934qtx.354.1606142339638;
        Mon, 23 Nov 2020 06:38:59 -0800 (PST)
Received: from [192.168.1.4] ([177.194.48.209])
        by smtp.googlemail.com with ESMTPSA id k4sm9403213qtp.5.2020.11.23.06.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 06:38:59 -0800 (PST)
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Mike Crowe <mac@mcrowe.com>
Cc:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
References: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
 <20201121175404.GA25323@mcrowe.com>
 <e8f58c73-d66e-3586-56cc-af116b750b28@gmail.com>
From:   Adhemerval Zanella <adhemerval.zanella@linaro.org>
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Subject: Re: Problems with the new pthread clock implementations
Message-ID: <f038123e-ac09-ccad-0d1e-68ed81b00a9c@linaro.org>
Date:   Mon, 23 Nov 2020 11:38:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8f58c73-d66e-3586-56cc-af116b750b28@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 21/11/2020 18:41, Michael Kerrisk (man-pages) wrote:
> Hello Mike,
> 
> On 11/21/20 6:54 PM, Mike Crowe wrote:
>> Hi Michael,
>>
>> On Saturday 21 November 2020 at 07:59:04 +0100, Michael Kerrisk (man-pages) wrote:
>>> I've been taking a closer look at the the new pthread*clock*() APIs:
>>> pthread_clockjoin_np()
>>> pthread_cond_clockwait()
>>> pthread_mutex_clocklock()
>>> pthread_rwlock_clockrdlock()
>>> pthread_rwlock_clockwrlock()
>>> sem_clockwait()
>>>
>>> I've noticed some oddities, and at least a couple of bugs.
>>>
>>> First off, I just note that there's a surprisingly wide variation in
>>> the low-level futex calls being used by these APIs when implementing
>>> CLOCK_REALTIME support:
>>>
>>> pthread_rwlock_clockrdlock()
>>> pthread_rwlock_clockwrlock()
>>> sem_clockwait()
>>> pthread_cond_clockwait()
>>>     futex(addr,
>>>         FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 3,
>>>         {abstimespec}, FUTEX_BITSET_MATCH_ANY)
>>>     (This implementation seems to be okay)
>>>
>>> pthread_clockjoin_np()
>>>     futex(addr, FUTEX_WAIT, 48711, {reltimespec})
>>>     (This is buggy; see below.)
>>>
>>> pthread_mutex_clocklock()
>>>     futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec})
>>>     (There's bugs and strangeness here; see below.)
>>
>> Yes, I found it very confusing when I started adding the new
>> pthread*clock*() functions, and it still takes me a while to find the right
>> functions when I look now. I believe that Adhemerval was talking about
>> simplifying some of this.
>>
>>> === Bugs ===
>>>
>>> pthread_clockjoin_np():
>>> As already recognized in another mail thread [1], this API accepts any
>>> kind of clockid, even though it doesn't support most of them.
>>
>> Well, it sort of does support them at least as well as many other
>> implementations of such functions do - it just calculates a relative
>> timeout using the supplied lock and then uses that. But, ...
>>
>>> A further bug is that even if CLOCK_REALTIME is specified,
>>> pthread_clockjoin_np() sleeps against the CLOCK_MONOTONIC clock.
>>> (Currently it does this for *all* clockid values.) The problem here is
>>> that the FUTEX_WAIT operation sleeps against the CLOCK_MONOTONIC clock
>>> by default. At the least, the FUTEX_CLOCK_REALTIME is required for
>>> this case. Alternatively, an implementation using
>>> FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME (like the first four
>>> functions listed above) might be appropriate.
>>
>> ...this is one downside of that. That bug was inherited from the
>> existing pthread_clock_timedjoin_np implementation.
> 

Indeed, I am working on refactoring the futex internal usage to fix
this issue.  Thinking twice, I see that using FUTEX_WAIT_BITSET without
any additional clock adjustments should be better than calling a
clock_gettime plus FUTEX_WAIT.

> Oh -- that's pretty sad. I hadn't considered the possibility that
> the (longstanding) "timed" functions might have the same bug.
> 
>> I was planning to write a patch to just limit the supported clocks, but
>> I'll have a go at fixing the bug you describe properly instead first which
>> will limit the implementation to CLOCK_REALTIME and CLOCK_MONOTONIC anyway.

I am working on this as well.

>>
>>> ===
>>>
>>> pthread_mutex_clocklock():
>>> First of all, there's a small oddity. Suppose we specify the clockid
>>> as CLOCK_REALTIME, and then while the call is blocked, we set the
>>> clock realtime backwards. Then, there will be further futex calls to
>>> handle the modification to the clock (and possibly multiple futex
>>> calls if the realtime clock is adjusted repeatedly):
>>>
>>>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec1})
>>>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec2})
>>>         ...
>>>
>>> Then there seems to be a bug. If we specify the clockid as
>>> CLOCK_REALTIME, and while the call is blocked we set the realtime
>>> clock forwards, then the blocking interval of the call is *not*
>>> adjusted (shortened), when of course it should be.
>>
>> This is because __lll_clocklock_wait ends up doing a relative wait rather
>> than an absolute one so it suffers from the same problem as
>> pthread_clockjoin_np.

It is another indication that it would be better to use FUTEX_WAIT_BITSET
instead.

>>
>>> ===
>>>
>>> I've attached a couple of small test programs at the end of this mail.
>>
>> Thanks for looking at this in detail.
>>
>> AFAIK, all of these bugs also affected the corresponding existing
>> pthread*timed*() functions. When I added the new pthread*clock*() functions
>> I was trying to keep my changes to the existing code as small as possible.
>> (I started out trying to "scratch the itch" of libstdc++
>> std::condition_variable::wait_for misbehaving[2] when the system clock was
>> warped in 2015 and all of this ballooned from that.) Now that the functions
>> are in, I think there's definitely scope for improving the implementation
>> and I will try to do so as time and confidence allows - the implementation
>> of __pthread_mutex_clocklock_common scares me greatly!
> 
> Yeah, a lot of glibc code is not so easy to follow... Thank you for
> taking a look.

The futex code in indeed convoluted, it was initially coded all at 
lowlevellock.h.  Then it was moved out to lowlevellock-futex.h with the 
NaCL port (which required an override of the futex call to implement 
the NaCL libcalls).

Later, the futex-internal.h was added that duplicated some 
lowlevellock-futex.h call with inline function plus some error checking 
(as libstdc++ does).

So currently we have the nptl pthread code using both interfaces, which is
confusing and the duplicate the logic.  The patchset I am working makes the
NPTL call to use only futex-internal.h, remove some non required function
from it, and simplify the functions required on futex-internal.c.

The idea is lowlevellock-futex.h would be used only for lowlevellock.h
and futex-internal.h.  I am thinking whether it would be useful to
keep with lowlevellock-futex.h, it just a thin wrapper over futex syscall
with a *lot* of unused macros and without proper y2038 support (as
futex-internal.h does).
