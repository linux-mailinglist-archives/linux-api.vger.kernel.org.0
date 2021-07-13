Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988103C7595
	for <lists+linux-api@lfdr.de>; Tue, 13 Jul 2021 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGMRR6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jul 2021 13:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGMRR6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jul 2021 13:17:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D92EC0613E9
        for <linux-api@vger.kernel.org>; Tue, 13 Jul 2021 10:15:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a6so31115644ljq.3
        for <linux-api@vger.kernel.org>; Tue, 13 Jul 2021 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TRElncUApLCHRIerX6tD+RzBqbqdZ3F0Mpo2jg30Jx0=;
        b=oZK6lBP0C1TUfupGEUR83jD4aWoePZG9wxjZmwMzyFtaQEpZOOvz7ySZ8R9dySXvkk
         zHpz+xU57gCTGhOdBVveHZkysVyzqINe4ixIH1Wxbp5NbZMRX0eDwKhq4LGsQPsicyHI
         LnigKyrRPuSahzjCxqdkMgcqD0ozs8NFN9L99XWNCSLvUeeHa3LdYxaLMGBlCLws9bN5
         fUCTqz8Z6JQaRKXu20rHf0mJsoRNA204tPp+uaDtePXeYVJeKvpsu+R7r386iyCdusOM
         kqF+7Kd0myposqkDIVI62kL71KQcpmJ948pqv32W+5jL7UNzYjhYgahmVIkRP2td5M6z
         dL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TRElncUApLCHRIerX6tD+RzBqbqdZ3F0Mpo2jg30Jx0=;
        b=iwSpphLzU3i4DUQHUxQd8gM85yaYomLDzcIDxgjaAHGc0/Zy9syOeT9NqSDqR71GLW
         lsUtdxgLk+2svhOQFGbdjigCnTpo7yR/TTJBPBB4ELIjBQy7zra+E2sYtYUt5HRdQ+Wj
         gGLrakkUQpHPceMHVmGfbpwYrrspinzTqwKjQg2GPpC0HMaZLVcjjqkcYTQsfqFicOGC
         8PjQ7x/737N9xAo3kqehyPleWgCLH0hWoPkepydI8p/RMRF+j/qUnVWgMm+knSV1ynSN
         0rVBSDBo9UqjXgXoHox29VHjlAkUjJak+xvYcxZv13ITd8RGh8j5kp1or/0mGW1+kR9z
         qW2w==
X-Gm-Message-State: AOAM531XUg7O7+7/2/CzmLIlwhIIY4zRieqE2KBCiN0iF7mia7egY4Ul
        OMdnLwiE++xQYlK9vZkBT3qkloFqbtFUcUs2pGGJPg==
X-Google-Smtp-Source: ABdhPJyf7GujIzwXailhgsxgfd/9Mlseri46FP9xEUeiTaKMYMd+4BMwlW0qPgiwEGfg+cn2OSBihchdCsONYcdOjWk=
X-Received: by 2002:a05:651c:111b:: with SMTP id d27mr5027279ljo.387.1626196506026;
 Tue, 13 Jul 2021 10:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-3-posk@google.com>
 <YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net> <CAPNVh5fbDTNPCnSoQFia_VSuDcLsReGey+7iouK6V=p1S7v=sg@mail.gmail.com>
 <20210713161030.GA2591@worktop.programming.kicks-ass.net>
In-Reply-To: <20210713161030.GA2591@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 13 Jul 2021 10:14:54 -0700
Message-ID: <CAPNVh5fpLDVTznS9m343LjhRn1uUQdWbPuo0C_+G5D6RsugL=w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 13, 2021 at 9:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 09, 2021 at 09:57:32AM -0700, Peter Oskolkov wrote:
> > On Fri, Jul 9, 2021 at 1:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > This is horrible... Jann is absolutely right, you do not, *ever* do
> > > userspace spinlocks. What's wrong with the trivial lockless single
> > > linked list approach?.
> >
> > I'm not sure how to get around the ABA problem with a lockless single
> > linked list: https://en.wikipedia.org/wiki/ABA_problem
>
> I'm familiar with the problem. I'm just not sure how we got there.
>
> Last time we had umcg_blocked_ptr / umcg_runnable_ptr which were kernel
> append, user clear single linked lists used for RUNNING->BLOCKED and
> BLOCKED->RUNNABLE notifications.
>
> But those seem gone, instead we now have idle_servers_ptr /
> idle_workers_ptr. I've not yet fully digested things, but they seem to
> implement some 'SMP' policy. Can we please forget about the whole SMP
> thing for now and focus on getting the basics sorted?

Hmm... yes, I was always working on the M:N model, i.e. multiple
servers, i.e. SMP. Apologies if this was not clear.

I think I'm close to having "SMP basics sorted" - I believe it will
take me longer now to go back to "UP" and then extend this to SMP. And
the result can probably be not as clean as having SMP there from the
beginning. Just give me another couple of days, please!

>
> So if we implement the bits outlined here:
>
>   https://lore.kernel.org/linux-api/20210609125435.GA68187@worktop.programming.kicks-ass.net/
>   https://lore.kernel.org/linux-api/YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net/
>
> Then what is mising for full N:1 (aka UP) ?
>
> One thing I've considered is that we might want to add u64 timestamps
> for the various state transitions, such that userspace can compute
> elapsed time which is useful for more dynamic scheduling policies.

Tagging state transitions with unique-per-task tags (counters) will
simplify a lot of things in the userspace, as these can be used to
sort out block/wakeup/swap races easily. If these tags have timestamp
semantics (e.g. nanos), even better - as you suggest, scheduling can
be tweaked, tracing/instrumentation will naturally use these, etc.

Synchronizing state+timestamp updates will be a challenge, unless we
share a 64-bit field for state + timestamp: 6 bytes for the timestamp
and two bytes for the state (I think one byte for the state is too
tight, although it will be enough initially). 6 bytes of nanos will
cycle over in a couple of days (if my math is right), so should not be
an issue for uniqueness; and I guess the userspace can always easily
restore the higher two bytes of the timestamp if needed.

So... should I convert u32 state into u64 state+timestamp field?

>
> Another is preemption; I'm thinking we can drive that with signals, but
> that does give complications -- signals are super gross API wise.
> Another method would be much preferred I think. We could add another
> syscall which allows userspace (from eg. SIGALRM/SIGPROF/SIGVTALRM) to
> force a worker to do a RUNNING->RUNNABLE transition and schedule back to
> the server.

I haven't looked into preemption yet, so I'll try any approach you
suggest (after the "basics" are sorted out).

> Then lets consider N:M (aka SMP). The basics of SMP is sharing work
> between servers. For a large part userspace can already do that by
> keeping a shared ready queue. Servers that go idle pick up a work,
> re-assign it to themselves and go.
>
> The pain-point seems to be *efficient* BLOCKED->RUNNABLE notifications
> across servers. Inefficient options include the userspace servers
> iterating all known other servers and trying to steal their
> umcg_runnable_ptr and processing it. This is 'difficult' in that there
> is no natural wakeup and hence letting a server do IDLE will increase
> latency and destroy work concervance.
>
> The alternative seems to be to let the kernel do the server iteration,
> looking for a RUNNING one and using that umcg_runnable_ptr field and
> kicking it. For that we can set up an immutable linked list between
> struct umcg_task's, a circular single linked list that the kernel
> iterates until it's back where it started. Then there is no dymaic
> state.

In full utilization scenarios, which are typical in our use cases
(custom scheduling is not that useful if there are idle CPUs/servers),
the kernel will quite often find no idle servers, so having a dynamic
list/stack of idle servers is more efficient. I'll post what I have in
mind (the kernel marks servers as deleted, the userspace does
cleanup/gc) soon.
