Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66F4474F1
	for <lists+linux-api@lfdr.de>; Sun,  7 Nov 2021 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhKGS33 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Nov 2021 13:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKGS33 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Nov 2021 13:29:29 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D2C061714
        for <linux-api@vger.kernel.org>; Sun,  7 Nov 2021 10:26:46 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id h133so7150786vke.10
        for <linux-api@vger.kernel.org>; Sun, 07 Nov 2021 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVWxq2SX8iKkf01bcvZv4ACcZmlcmz41QXMt8ATwkIA=;
        b=MR4TRo5yutL/LK5jM/F5nvSqUsTI6QWE3ELz3BlUGJmkKB/aI5u5YV6v5HZxZrL/+6
         ydoyPmk/FlW+jAN5fVWg3W9BXdqU+OPKkTMUJ9gBi5PXLwyfIhqx76SP0tx3coW4bHt/
         7GtsceaGk5j5NMuxwuAtyr99ZW+gMLELFKxHDg5dV/RYTs5y/cbLMUFFnVzXghybtssG
         O3CqaVB3yIyA4jk32qvmy9kLeArIt8AbieoVWq6hA6eQQPCivUcT+jypgnSdQIQKHN4N
         KajzhlVnMH9ufywqmRosqeZwSIBACaQTNuYOS2tU4ZzupyogJRDVjP9wDjmG3P1nCl0i
         CNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVWxq2SX8iKkf01bcvZv4ACcZmlcmz41QXMt8ATwkIA=;
        b=tGkjLALyJrzOfLXfiPtEZrH4zTOgRDhJnszWIQPMiBTX9a3Vd4Bzoc4Dr7Y1gUhe/M
         8RNVGmOBWGteYWv9YFeFGgVtDTMNn4+9qN0H4HMgOaysYsWrz5k09zcSKw0oNpjZcz1L
         uRVHmK/PQveUiX2ZLrFosLK0a7KsAv2iAgyqWybl7/3GOOf6NniuUNoBeuTrWs1T2HVJ
         FmZCTOWYto2bssjk/W4rwVqMyYwHsy0UQgiLgr1oroBKN3TUNiQ5G+iyqk91KjwkEb0y
         kMv/zXmwcEMIm9q5+zZyicMXa2kKgUGcZfQFVcsQFMhEFRoCaQ3FR999inAShTQ2GIME
         p5aA==
X-Gm-Message-State: AOAM532t3rzwnSFOmpunwkxwn5QiGAqfg7yuKsoSZVvnhx9rZtsWbjit
        Aq3LenF9QAIW1g0ySV0VwP56S47NbCHXj35vCie3Tw==
X-Google-Smtp-Source: ABdhPJyHxcwX8wYYEQn3Uxm0Zb82uJ1McE3J66N5U3GROqqJt507URRpQvPyJBjOL1lbrmfMGOwejAXwoa+lfPMV1IY=
X-Received: by 2002:a1f:b64e:: with SMTP id g75mr91129659vkf.13.1636309605427;
 Sun, 07 Nov 2021 10:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-1-posk@google.com> <20211104195804.83240-4-posk@google.com>
 <YYa5WjXTrhYKmoze@geo.homenetwork>
In-Reply-To: <YYa5WjXTrhYKmoze@geo.homenetwork>
From:   Peter Oskolkov <posk@posk.io>
Date:   Sun, 7 Nov 2021 10:26:34 -0800
Message-ID: <CAFTs51UD_gCFRWe8+14WG3nALQNRdoa322Wcr=RUPbSOpOf6qQ@mail.gmail.com>
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 6, 2021 at 10:19 AM Tao Zhou <tao.zhou@linux.dev> wrote:
>
> Hi Peter,
>
> On Thu, Nov 04, 2021 at 12:58:01PM -0700, Peter Oskolkov wrote:
>
> > +/**
> > + * umcg_update_state: atomically update umcg_task.state_ts, set new timestamp.
> > + * @state_ts   - points to the state_ts member of struct umcg_task to update;
> > + * @expected   - the expected value of state_ts, including the timestamp;
> > + * @desired    - the desired value of state_ts, state part only;
> > + * @may_fault  - whether to use normal or _nofault cmpxchg.
> > + *
> > + * The function is basically cmpxchg(state_ts, expected, desired), with extra
> > + * code to set the timestamp in @desired.
> > + */
> > +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
> > +                             bool may_fault)
> > +{
> > +     u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> > +     u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
> > +
> > +     /* Cut higher order bits. */
> > +     next_ts &= UMCG_TASK_STATE_MASK_FULL;
>
> next_ts &= (1 << UMCG_STATE_TIMESTAMP_BITS) - 1; or am I wrong.

Right, thanks. I'll fix it in the next patchset version, if any. But
at the moment I don't think this is bad enough to prevent merging, if
the maintainers feel like it - basically, the condition below will
always be false, so if the state is updated within 16 nanoseconds, the
timestamps may sometimes match. For this to be an issue, this should
result in ABA updates, so two state changes should happen in 16
nanoseconds, which is extremely unlikely (impossible?), as most state
changes are accompanied by other atomic ops.

>
> > +     if (next_ts == curr_ts)
> > +             ++next_ts;
> > +
> > +     /* Remove an old timestamp, if any. */
> > +     desired &= UMCG_TASK_STATE_MASK_FULL;
> > +
> > +     /* Set the new timestamp. */
> > +     desired |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
> > +
> > +     if (may_fault)
> > +             return cmpxchg_user_64(state_ts, expected, desired);
> > +
> > +     return cmpxchg_user_64_nofault(state_ts, expected, desired);
> > +}
> > +
> > +/**
> > + * sys_umcg_ctl: (un)register the current task as a UMCG task.
> > + * @flags:       ORed values from enum umcg_ctl_flag; see below;
> > + * @self:        a pointer to struct umcg_task that describes this
> > + *               task and governs the behavior of sys_umcg_wait if
> > + *               registering; must be NULL if unregistering.
> > + *
> > + * @flags & UMCG_CTL_REGISTER: register a UMCG task:
> > + *         UMCG workers:
> > + *              - @flags & UMCG_CTL_WORKER
> > + *              - self->state must be UMCG_TASK_BLOCKED
> > + *         UMCG servers:
> > + *              - !(@flags & UMCG_CTL_WORKER)
> > + *              - self->state must be UMCG_TASK_RUNNING
> > + *
> > + *         All tasks:
> > + *              - self->next_tid must be zero
> > + *
> > + *         If the conditions above are met, sys_umcg_ctl() immediately returns
> > + *         if the registered task is a server; a worker will be added to
> > + *         idle_workers_ptr, and the worker put to sleep; an idle server
> > + *         from idle_server_tid_ptr will be woken, if present.
> > + *
> > + * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
> > + *           is a UMCG worker, the userspace is responsible for waking its
> > + *           server (before or after calling sys_umcg_ctl).
> > + *
> > + * Return:
> > + * 0                - success
> > + * -EFAULT          - failed to read @self
> > + * -EINVAL          - some other error occurred
> > + */
> > +SYSCALL_DEFINE2(umcg_ctl, u32, flags, struct umcg_task __user *, self)
> > +{
> > +     struct umcg_task ut;
> > +
> > +     if (flags == UMCG_CTL_UNREGISTER) {
> > +             if (self || !current->umcg_task)
> > +                     return -EINVAL;
> > +
> > +             if (current->flags & PF_UMCG_WORKER)
> > +                     umcg_handle_exiting_worker();
> > +             else
> > +                     umcg_clear_task(current);
> > +
> > +             return 0;
> > +     }
> > +
> > +     if (!(flags & UMCG_CTL_REGISTER))
> > +             return -EINVAL;
> > +
> > +     flags &= ~UMCG_CTL_REGISTER;
> > +     if (flags && flags != UMCG_CTL_WORKER)
> > +             return -EINVAL;
> > +
> > +     if (current->umcg_task || !self)
> > +             return -EINVAL;
> > +
> > +     if (copy_from_user(&ut, self, sizeof(ut)))
> > +             return -EFAULT;
> > +
> > +     if (ut.next_tid)
> > +             return -EINVAL;
> > +
> > +     if (flags == UMCG_CTL_WORKER) {
> > +             if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_BLOCKED)
>
> Or use UMCG_TASK_STATE_MASK that is enough.

Do you have a use case for this (i.e. when state flags can be
legitimately set here)? At the moment I can't think of it, and I'd
rather keep things more strict to avoid dealing with unexpected use
cases in the future.

>
> > +                     return -EINVAL;
> > +
> > +             WRITE_ONCE(current->umcg_task, self);
> > +             current->flags |= PF_UMCG_WORKER;
> > +
> > +             /* Trigger umcg_handle_resuming_worker() */
> > +             set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> > +     } else {
> > +             if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING)
>
> The same here.

Yes, the same here - why do you think task state flags should be allowed here?


>
> > +                     return -EINVAL;
> > +
> > +             WRITE_ONCE(current->umcg_task, self);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
>
> Thanks,
> Tao
