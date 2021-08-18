Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724703F0C08
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhHRTpz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhHRTpz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 15:45:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C8C061764;
        Wed, 18 Aug 2021 12:45:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629315916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugd5yMYYslAQneDH7qKf8oseYTGEw+5qM8tsVxHTGIo=;
        b=HGXMOS9N2VZLffGfEU3bPxojyejlAvrSxJOeOGYT0kgHpKAzznjPtiv2QuLKnKB/5doiSq
        FurlBjwwcUojGTmGnwzgIjJuWoy+WpRDjT9AXX/NwOFkMWBUTOuHZXI6NJo6TKDmdcRi4p
        s2DlCLA6MJ2Ha82NIW8FEzIBlvAUchxU3sw0htXYZsTEgK6odA0kfopHvyItOSniJ7+4bL
        RCsiOQCXtGa+t/FaIt3vawgjKriJJf7y+H3Wa4kpsDsTD+cdXamRXlH5LdSjpJQ1iKdig1
        VGhgxSrLEuyytZGC/KY/QOzVs17O6Lt648AIfPxDaYBG4BiDvkElEL6HgXmyrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629315916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugd5yMYYslAQneDH7qKf8oseYTGEw+5qM8tsVxHTGIo=;
        b=B6aumQSGeuqc2MxLeDeggrwDf4YXt9yFbT2egn8SF+6x/0bKj1dCg78qZ3si8VFmpFgG/e
        WW5AX7M5omSgkADw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 2/4] futex2: Implement vectorized wait
In-Reply-To: <20210818162034.GA26408@worktop.programming.kicks-ass.net>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
 <20210805190405.59110-3-andrealmeid@collabora.com> <87v94310gm.ffs@tglx>
 <20210818162034.GA26408@worktop.programming.kicks-ass.net>
Date:   Wed, 18 Aug 2021 21:45:15 +0200
Message-ID: <87k0ki1qr8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 18 2021 at 18:20, Peter Zijlstra wrote:
> On Wed, Aug 18, 2021 at 01:00:57PM +0200, Thomas Gleixner wrote:
>> > +/**
>> > + * struct futex_waitv - A waiter for vectorized wait
>> > + * @val:   Expected value at uaddr
>> > + * @uaddr: User address to wait on
>> > + * @flags: Flags for this waiter
>> > + */
>> > +struct futex_waitv {
>> > +	__u64 val;
>> 
>> Again. Why u64?
>
> So I think the idea was that if we're going to do new syscalls, we
> should cater for future extentions, one of which was 64bit futexes (for
> 64bit archs) (along with u{8,16,32})
>
> The previous set of patches implemented a more complete replacement ABI
> -- which I rather liked, however the implementation was completely
> disjoint from the existing futexes, which was a non-starter for me.
>
> Anyway, yes, current futexes are u32, but if we want to ever do u64
> futexes, we should either do this syscall with a u64, or already plan to
> retire the whole syscall.
>
> Obiously this would've made good Changelog material, but alas it wasn't
> there.

Fair enough, but OTOH 64bit futexes for 64bit architectures: What's
exactly the point? Just because 64bit architectures can implement it is
not really a good reason. Where is the use case and the benefit and
what's the workaround for 32bit user space / architectures?

I'm not opposed against variable sized futexes in principle, but they
come with limitations and we end up with tons of sanity checks and
exclusions all over the place.

The 32bit futexes have a charm as they just work for all architectures
and the interaction with PI and robust list is trivial and well
established.

I serioulsy doubt that 8 and 16 bit futexes can be actually used for
locking in a meaningful way. If they are purely wait/wake then the
question is whether they actually fit into futex in the first place or
just happen to be implementable via futexes.

Thanks,

        tglx
