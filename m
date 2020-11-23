Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E42C0FE0
	for <lists+linux-api@lfdr.de>; Mon, 23 Nov 2020 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbgKWQNG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Nov 2020 11:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbgKWQNF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Nov 2020 11:13:05 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53109C0613CF
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 08:13:04 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d9so20242944oib.3
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=A8hXlmz4hNGsZsnh5OEUeQs//VTGkhhqLWcewLOxTDU=;
        b=DOZ/lOlcuiZaZ9qrkQ1EryQIDktsi7b9qhFx2Z5kvUYYOH/aQArhBG0uOAkHefqMvA
         Pe8milBTYsPbt2wnZ0VGsKtNy/yrYclYq4fJP/qWJfXV412YdAGJGV+1hI8GFQtdUTsP
         P8QX3JE9nXFNxDqa6VwNzALxeRwygw+Pizq0liNQKZx+9VjfFzkFfBfgSJVHKbRAzVIQ
         81b3Npx8V5nqHt8ocD/5gLovjQReWrhMd2M4ntNR/wjpHBL4GZKTeeqXXlKqXuo1THmd
         EdWMpsXTyVpYnuO5TwKFsPVtxs74NjdbkeUViRIq2KsJ/0A3w2fjDQCij4+F9xWKxqLG
         MccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=A8hXlmz4hNGsZsnh5OEUeQs//VTGkhhqLWcewLOxTDU=;
        b=ZgutNys7wRoc95uMlIvekkuDcxfidigQUSoDCY/5wabBn3C7Jsu6L7H9u7QfvEaDJn
         4vXvxpR5GxAQTRmmqMgUu/D8zZgORf/OQwTwkGKX5fBws1gPXZs94aJJHodPNO4VzP8S
         ny7KFBpaN6ZaXvlT/X6Eev1h8kq1xlVelfHOTwQ//PMkXtYNLXBr8e2PD0idySmyH33F
         QwNvsmP7G3SOT7hEhH34Ve2EH7nYbMZJ+ttbiE1Ile1O1pj9wh9e0HW4Fmc2+r9nQQTj
         Mzz8ISSzYD0SLmFsv8qLLJL1qfUV01P2sgBXZlEV1ekoliMcOfGAqMdGf+G5zUfwKfr8
         GsiA==
X-Gm-Message-State: AOAM530WfVnfaAMuaQhWyKYlB1twX7h9S/YbeuWUHKvwJSy6d1ahxepU
        Lkb8YnBlZgQxF0ELjtco45vApUTman4q2zGt7F0=
X-Google-Smtp-Source: ABdhPJxhoIUTktyym2QrwteVpEcxTRKECgDJMMseUHOxTloxgifHb+OoZw13v161Ft/q1D6HO22OsWseIW37GTGMJJM=
X-Received: by 2002:a05:6808:7de:: with SMTP id f30mr14885235oij.148.1606147983516;
 Mon, 23 Nov 2020 08:13:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
 <20201121175404.GA25323@mcrowe.com> <e8f58c73-d66e-3586-56cc-af116b750b28@gmail.com>
 <f038123e-ac09-ccad-0d1e-68ed81b00a9c@linaro.org>
In-Reply-To: <f038123e-ac09-ccad-0d1e-68ed81b00a9c@linaro.org>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 23 Nov 2020 17:12:52 +0100
Message-ID: <CAKgNAkiQ5e08ooCuAdozfvCByfBeEVZu9mzBBPh+TkKB8HFYKg@mail.gmail.com>
Subject: Re: Problems with the new pthread clock implementations
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     Mike Crowe <mac@mcrowe.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Adhemerval,

On Mon, 23 Nov 2020 at 15:39, Adhemerval Zanella
<adhemerval.zanella@linaro.org> wrote:
>
>
>
> On 21/11/2020 18:41, Michael Kerrisk (man-pages) wrote:
> > Hello Mike,
> >
> > On 11/21/20 6:54 PM, Mike Crowe wrote:
> >> Hi Michael,
> >>
> >> On Saturday 21 November 2020 at 07:59:04 +0100, Michael Kerrisk (man-pages) wrote:
> >>> I've been taking a closer look at the the new pthread*clock*() APIs:
> >>> pthread_clockjoin_np()
> >>> pthread_cond_clockwait()
> >>> pthread_mutex_clocklock()
> >>> pthread_rwlock_clockrdlock()
> >>> pthread_rwlock_clockwrlock()
> >>> sem_clockwait()
> >>>
> >>> I've noticed some oddities, and at least a couple of bugs.
> >>>
> >>> First off, I just note that there's a surprisingly wide variation in
> >>> the low-level futex calls being used by these APIs when implementing
> >>> CLOCK_REALTIME support:
> >>>
> >>> pthread_rwlock_clockrdlock()
> >>> pthread_rwlock_clockwrlock()
> >>> sem_clockwait()
> >>> pthread_cond_clockwait()
> >>>     futex(addr,
> >>>         FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 3,
> >>>         {abstimespec}, FUTEX_BITSET_MATCH_ANY)
> >>>     (This implementation seems to be okay)
> >>>
> >>> pthread_clockjoin_np()
> >>>     futex(addr, FUTEX_WAIT, 48711, {reltimespec})
> >>>     (This is buggy; see below.)
> >>>
> >>> pthread_mutex_clocklock()
> >>>     futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec})
> >>>     (There's bugs and strangeness here; see below.)
> >>
> >> Yes, I found it very confusing when I started adding the new
> >> pthread*clock*() functions, and it still takes me a while to find the right
> >> functions when I look now. I believe that Adhemerval was talking about
> >> simplifying some of this.
> >>
> >>> === Bugs ===
> >>>
> >>> pthread_clockjoin_np():
> >>> As already recognized in another mail thread [1], this API accepts any
> >>> kind of clockid, even though it doesn't support most of them.
> >>
> >> Well, it sort of does support them at least as well as many other
> >> implementations of such functions do - it just calculates a relative
> >> timeout using the supplied lock and then uses that. But, ...
> >>
> >>> A further bug is that even if CLOCK_REALTIME is specified,
> >>> pthread_clockjoin_np() sleeps against the CLOCK_MONOTONIC clock.
> >>> (Currently it does this for *all* clockid values.) The problem here is
> >>> that the FUTEX_WAIT operation sleeps against the CLOCK_MONOTONIC clock
> >>> by default. At the least, the FUTEX_CLOCK_REALTIME is required for
> >>> this case. Alternatively, an implementation using
> >>> FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME (like the first four
> >>> functions listed above) might be appropriate.
> >>
> >> ...this is one downside of that. That bug was inherited from the
> >> existing pthread_clock_timedjoin_np implementation.
> >
>
> Indeed, I am working on refactoring the futex internal usage to fix
> this issue.  Thinking twice, I see that using FUTEX_WAIT_BITSET without
> any additional clock adjustments should be better than calling a
> clock_gettime plus FUTEX_WAIT.

Yes, that would be my estimate as well/
>
> > Oh -- that's pretty sad. I hadn't considered the possibility that
> > the (longstanding) "timed" functions might have the same bug.
> >
> >> I was planning to write a patch to just limit the supported clocks, but
> >> I'll have a go at fixing the bug you describe properly instead first which
> >> will limit the implementation to CLOCK_REALTIME and CLOCK_MONOTONIC anyway.
>
> I am working on this as well.

Thanks.

> >>> ===
> >>>
> >>> pthread_mutex_clocklock():
> >>> First of all, there's a small oddity. Suppose we specify the clockid
> >>> as CLOCK_REALTIME, and then while the call is blocked, we set the
> >>> clock realtime backwards. Then, there will be further futex calls to
> >>> handle the modification to the clock (and possibly multiple futex
> >>> calls if the realtime clock is adjusted repeatedly):
> >>>
> >>>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec1})
> >>>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec2})
> >>>         ...
> >>>
> >>> Then there seems to be a bug. If we specify the clockid as
> >>> CLOCK_REALTIME, and while the call is blocked we set the realtime
> >>> clock forwards, then the blocking interval of the call is *not*
> >>> adjusted (shortened), when of course it should be.
> >>
> >> This is because __lll_clocklock_wait ends up doing a relative wait rather
> >> than an absolute one so it suffers from the same problem as
> >> pthread_clockjoin_np.
>
> It is another indication that it would be better to use FUTEX_WAIT_BITSET
> instead.

:-)

> >>> ===
> >>>
> >>> I've attached a couple of small test programs at the end of this mail.
> >>
> >> Thanks for looking at this in detail.
> >>
> >> AFAIK, all of these bugs also affected the corresponding existing
> >> pthread*timed*() functions. When I added the new pthread*clock*() functions
> >> I was trying to keep my changes to the existing code as small as possible.
> >> (I started out trying to "scratch the itch" of libstdc++
> >> std::condition_variable::wait_for misbehaving[2] when the system clock was
> >> warped in 2015 and all of this ballooned from that.) Now that the functions
> >> are in, I think there's definitely scope for improving the implementation
> >> and I will try to do so as time and confidence allows - the implementation
> >> of __pthread_mutex_clocklock_common scares me greatly!
> >
> > Yeah, a lot of glibc code is not so easy to follow... Thank you for
> > taking a look.
>
> The futex code in indeed convoluted, it was initially coded all at
> lowlevellock.h.  Then it was moved out to lowlevellock-futex.h with the
> NaCL port (which required an override of the futex call to implement
> the NaCL libcalls).
>
> Later, the futex-internal.h was added that duplicated some
> lowlevellock-futex.h call with inline function plus some error checking
> (as libstdc++ does).
>
> So currently we have the nptl pthread code using both interfaces, which is
> confusing and the duplicate the logic.  The patchset I am working makes the
> NPTL call to use only futex-internal.h, remove some non required function
> from it, and simplify the functions required on futex-internal.c.
>
> The idea is lowlevellock-futex.h would be used only for lowlevellock.h
> and futex-internal.h.  I am thinking whether it would be useful to
> keep with lowlevellock-futex.h, it just a thin wrapper over futex syscall
> with a *lot* of unused macros and without proper y2038 support (as
> futex-internal.h does).

Thanks, Adhemerval. And more generally, thanks for all of the clean-up
work you do in the codebase. That's just so valuable!

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
