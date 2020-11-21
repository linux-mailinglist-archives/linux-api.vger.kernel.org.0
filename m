Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECC52BC135
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgKUSBk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 13:01:40 -0500
Received: from avasout06.plus.net ([212.159.14.18]:58592 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgKUSBj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 13:01:39 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Nov 2020 13:01:38 EST
Received: from deneb ([80.229.24.9])
        by smtp with ESMTP
        id gX5JkNtRrhO4HgX5Kkqm0a; Sat, 21 Nov 2020 17:54:07 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=VwQbUJbxAAAA:8 a=-An2I_7KAAAA:8
 a=N1aVq1xuAAAA:8 a=Z26BvieBETH4tY53u9QA:9 a=CjuIK1q_8ugA:10 a=lLqUAKteju4A:10
 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=Sq34B_EcNBM9_nrAYB9S:22 a=xB1R8EzRJLK013CBARk5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
         s=20191005; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=GFwiHDuQbRadJezLsPmyDswdkrtS5ITRFSk8hVe0Pxk=; b=aToO4
        Rcya0yaeJWku54WsqGA4dKa3zFZm5tDp5C4EQnIiN0bc6/dmGazwCl62K42PhGHLaM6Ug0Av2+mlZ
        ivQBY2bOGAfkahW5mjoO4pfB/ufh5rQw22BIIzWaWjVCLq9kt3wS+LYH3GuCA62MsXudf97+fFTui
        6S013f7uBq3saFITrOqdvg5mc7zbn1oyitPQIYkXAh9ug2h7Px9FqLSPjLqBA1BitlhFqQlUjvvXZ
        w6GENrasqPjqMptVMIWzlevLMCiksKwH/Ui9S1wm37BcFitYBDj+ROWjUHSzYTH7EwfEs8NO2MpS7
        lFBuPD2T/NwKSFBelvOzSAYlJKfHQ==;
Received: from mac by deneb with local (Exim 4.92)
        (envelope-from <mac@mcrowe.com>)
        id 1kgX5J-0002y7-0V; Sat, 21 Nov 2020 17:54:05 +0000
Date:   Sat, 21 Nov 2020 17:54:04 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Problems with the new pthread clock implementations
Message-ID: <20201121175404.GA25323@mcrowe.com>
References: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfFD4jhC1sjk70s0Ra0yIWzWsj0DuZjSnNzN4v7qhNJh8ER5mfJA58h2PdN4JkIO1Dtm1AaXOj9s/Tl6EgwdEeDzhemJizelJwQ8LNNkT+Zj5S0UGUIJg
 EVZ51a2HMwhrU1G6hJv7GvD01v18DmAQ92fhrUzGN2TnV/ndKtAgSKu0
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michael,

On Saturday 21 November 2020 at 07:59:04 +0100, Michael Kerrisk (man-pages) wrote:
> I've been taking a closer look at the the new pthread*clock*() APIs:
> pthread_clockjoin_np()
> pthread_cond_clockwait()
> pthread_mutex_clocklock()
> pthread_rwlock_clockrdlock()
> pthread_rwlock_clockwrlock()
> sem_clockwait()
> 
> I've noticed some oddities, and at least a couple of bugs.
> 
> First off, I just note that there's a surprisingly wide variation in
> the low-level futex calls being used by these APIs when implementing
> CLOCK_REALTIME support:
> 
> pthread_rwlock_clockrdlock()
> pthread_rwlock_clockwrlock()
> sem_clockwait()
> pthread_cond_clockwait()
>     futex(addr,
>         FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 3,
>         {abstimespec}, FUTEX_BITSET_MATCH_ANY)
>     (This implementation seems to be okay)
> 
> pthread_clockjoin_np()
>     futex(addr, FUTEX_WAIT, 48711, {reltimespec})
>     (This is buggy; see below.)
> 
> pthread_mutex_clocklock()
>     futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec})
>     (There's bugs and strangeness here; see below.)

Yes, I found it very confusing when I started adding the new
pthread*clock*() functions, and it still takes me a while to find the right
functions when I look now. I believe that Adhemerval was talking about
simplifying some of this.

> === Bugs ===
> 
> pthread_clockjoin_np():
> As already recognized in another mail thread [1], this API accepts any
> kind of clockid, even though it doesn't support most of them.

Well, it sort of does support them at least as well as many other
implementations of such functions do - it just calculates a relative
timeout using the supplied lock and then uses that. But, ...

> A further bug is that even if CLOCK_REALTIME is specified,
> pthread_clockjoin_np() sleeps against the CLOCK_MONOTONIC clock.
> (Currently it does this for *all* clockid values.) The problem here is
> that the FUTEX_WAIT operation sleeps against the CLOCK_MONOTONIC clock
> by default. At the least, the FUTEX_CLOCK_REALTIME is required for
> this case. Alternatively, an implementation using
> FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME (like the first four
> functions listed above) might be appropriate.

...this is one downside of that. That bug was inherited from the
existing pthread_clock_timedjoin_np implementation.

I was planning to write a patch to just limit the supported clocks, but
I'll have a go at fixing the bug you describe properly instead first which
will limit the implementation to CLOCK_REALTIME and CLOCK_MONOTONIC anyway.

> ===
> 
> pthread_mutex_clocklock():
> First of all, there's a small oddity. Suppose we specify the clockid
> as CLOCK_REALTIME, and then while the call is blocked, we set the
> clock realtime backwards. Then, there will be further futex calls to
> handle the modification to the clock (and possibly multiple futex
> calls if the realtime clock is adjusted repeatedly):
> 
>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec1})
>         futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec2})
>         ...
> 
> Then there seems to be a bug. If we specify the clockid as
> CLOCK_REALTIME, and while the call is blocked we set the realtime
> clock forwards, then the blocking interval of the call is *not*
> adjusted (shortened), when of course it should be.

This is because __lll_clocklock_wait ends up doing a relative wait rather
than an absolute one so it suffers from the same problem as
pthread_clockjoin_np.

> ===
> 
> I've attached a couple of small test programs at the end of this mail.

Thanks for looking at this in detail.

AFAIK, all of these bugs also affected the corresponding existing
pthread*timed*() functions. When I added the new pthread*clock*() functions
I was trying to keep my changes to the existing code as small as possible.
(I started out trying to "scratch the itch" of libstdc++
std::condition_variable::wait_for misbehaving[2] when the system clock was
warped in 2015 and all of this ballooned from that.) Now that the functions
are in, I think there's definitely scope for improving the implementation
and I will try to do so as time and confidence allows - the implementation
of __pthread_mutex_clocklock_common scares me greatly!

Thanks.

Mike.

[1] https://lore.kernel.org/linux-man/20201119120034.GA20599@mcrowe.com/
[2] https://randombitsofuselessinformation.blogspot.com/2018/06/its-about-time-monotonic-time.html
