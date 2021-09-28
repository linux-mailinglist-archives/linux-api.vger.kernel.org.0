Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE29541B51B
	for <lists+linux-api@lfdr.de>; Tue, 28 Sep 2021 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbhI1R14 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Sep 2021 13:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhI1R1z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Sep 2021 13:27:55 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC5C061745
        for <linux-api@vger.kernel.org>; Tue, 28 Sep 2021 10:26:16 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id w68so820455vkd.7
        for <linux-api@vger.kernel.org>; Tue, 28 Sep 2021 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHjd87qme1N48KPcv4St3/bkFcFepzmwvqFaB3gotgo=;
        b=X0aIcMY0L9KtNAVG+BPTin0cWR/8AVWDq2N3O6QDsSwe7BkK1ktKQkt11WhBbxlEAn
         hwSxpRtANVqbmMSp16Sq1DZIsKUBQd7q+ICKp0PO8p7pGgWAwBssK4TS+hm4kTP6JSms
         TJ2nb1xX4o7OFE5q9R1XupZI/a3FPRhzMd0vrii/Ny+zClkmkUBW8CWKciLaV/FjNwz4
         LkxKwbzKS/1rSPohcf+w6e0gn4ylhCq61pjKN/Ig5i8biM2kk0TIStryl+mCPHyQUlAD
         SOZ/75bPBR+fQljN2NwTj66+l3En60QnMgXbDUZ0oAt6a2kEz358Oc71ppbbGd5sshaj
         av6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHjd87qme1N48KPcv4St3/bkFcFepzmwvqFaB3gotgo=;
        b=TnvpmhCEHhMe09Z1xE2OUUN8RMU2KtDlIEoOchMJiUod2ySF/Ttx8OlEG6pIKnNiFJ
         junNmWXc7A0FhtD1qpQJXM2QiUhJuwk4a+/YQbhooe6vVfcw+J2LOUX3giiDDb5XG2Qk
         F4fkjjeq58mplHCzXkIbsFA5MZAKpdLOEq61GAflemXVgYs8bsC7AzaNUv0TIq0k4Oj3
         QoeJooFzely1Vw/dkUrVufa9f7+UQHTyxA4LmHzL1srGjvuldI5+Ytb4DGJdylOG0iiJ
         r4y5Jt0e5qLt/Ur0P1NJu8mOWWCqRbBeNHOI3nwfdFq/ZfWRhniz/KLHHkGaXt0Pg4aw
         /I6A==
X-Gm-Message-State: AOAM532snS2BkR6xObJjnjzHcJdDOdCCulb3QgeTASE/5kg25jiZO82q
        z7QOzlRi6CxYB2qWu7Zeo8k0iMZLVW8tHRxTomdfFA==
X-Google-Smtp-Source: ABdhPJx3e3F4KZJWMSzzHgKJJUDagxiaFXGmFppmxBCGxK01x/LRYcdyRXbEIJ3Xhgav2OhUleOgk18ORPdltX8k4UY=
X-Received: by 2002:a1f:ab8f:: with SMTP id u137mr5705209vke.17.1632849974870;
 Tue, 28 Sep 2021 10:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210917180323.278250-4-posk@google.com> <874ka5awdp.ffs@tglx>
In-Reply-To: <874ka5awdp.ffs@tglx>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 28 Sep 2021 10:26:04 -0700
Message-ID: <CAFTs51V7QTt3pjfHJ8MSxCgdnTz_5J3Dp8VLt6aGpE0WeB09tA@mail.gmail.com>
Subject: Re: [PATCH 3/5 v0.6] sched/umcg: RFC: implement UMCG syscalls
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

Hi Thomas,

Thanks a lot for the review! I will not comment here on your
suggestions that I fully understand how to address. Please see my
comments below on issues that need more clarification.

Thanks,
Peter

On Tue, Sep 28, 2021 at 2:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter,
>
> On Fri, Sep 17 2021 at 11:03, Peter Oskolkov wrote:
>
> > Define struct umcg_task and two syscalls: sys_umcg_ctl sys_umcg_wait.
> >
> > All key operations, such as wait/wake/context-switch, as well as
> > timeouts and block/wake detection, are working quite reliably.
> >
> > In addition, the userspace can now force the kernel to preempt
> > a running worker by changing its state from RUNNING to
> > RUNNING | PREEMPTED and sending a signal to it. This new functionality
> > is less well tested than the key operations above, but is working
> > well in the common case of the worker busy in the userspace.
> >
> > These big things remain to be addressed (in no particular order):
> > - tracing/debugging
> > - faster context switches (see umcg_do_context_switch in umcg.c)
> > - other architectures (we will need at least arm64 in addition to amd64)
> > - tools/lib/umcg for userspace
> > - kselftests
> >
> > I'm working on finalizing libumcg and kselftests.
> >
> > See Documentation/userspace-api/umcg.[txt|rst] for API usage and
> > other details.
>
> The above is a work log and a todo list, but not a change log.
>
> Change logs have to explain the what and especially the why and for new
> concepts also the design and the rationale behind it.
>
> And no, links to random discussions are not a replacement for that. It's
> not the job of a reviewer to dig for that information. It's the task of
> the submitter to provide that information so the reviewer can digest it.
>
> > v0.5->v0.6 changes:
> > - umcg_task pages are now pinned for RUNNING workers;
>
> What's the rationale for that? Why is that needed and desired?

This was discussed in detail here:
https://lore.kernel.org/lkml/20210908184905.163787-1-posk@google.com/,
for example: https://lore.kernel.org/lkml/YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net/

In short, workqueue functions (sched_submit_work, sched_update_worker)
can be called with mm lock held, and so we cannot fixup pagefaults
inline; so we need to pin struct umcg_task pages temporarily. On the
wakeup path I elide this by setting TF_NOTIFY_RESUME flag and doing
everything later in return-to-usermode-loop in a sleepable context; on
the sched_submit_work (going to sleep) path, we need to access the
userspace to wake up the server, but this is a "nosleep" context, so
the pages have to be pinned.

>
> > v0.2->v0.3 changes:
> > - the overall approach is now based on peterz@'s suggestion in
> >   https://lore.kernel.org/patchwork/cover/1433967/
>
> All of these lore.kernel/org/patchwork/* links resolve to 404. Please
> use proper lore.kernel.org/r/$MSGID links
>
> > /*
> > +
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -173,6 +173,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> >
> >               if (ti_work & _TIF_NOTIFY_RESUME) {
> >                       tracehook_notify_resume(regs);
> > +                     umcg_handle_notify_resume();  /* might sleep */
>
> Please do not use tail comments. They are horrible and disturb the
> reading flow.
>
> Aside of that this 'might sleep' info is not really interesting. All
> functions which are invoked in exit_to_user_mode_loop() can sleep, so
> what's special about this one?
>
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index fd1c04193e18..fdd4e923cca9 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -744,6 +744,8 @@ void __noreturn do_exit(long code)
> >       if (unlikely(!tsk->pid))
> >               panic("Attempted to kill the idle task!");
> >
> > +     umcg_handle_exit();
>
> Why is this invoked _before_ the oops fixup? How is that correct in the
> oops case?

umcg_handle_exit() is just unpinning pinned pages, assigning NULL to a
couple of pointers, and clearing PF_UMCG_WORKER flag, so I assumed
doing it as early as possible is the best way to avoid unnecessarily
triggering workqueue callbacks. Is my logic wrong? (UMCG tasks should
unregister before exiting; if they do, umcg_handle_exit() is a NOOP;
but if they did not unregister, umcg_handle_exit() just makes sure no
pinned pages are left over).

>
> > index 12a9d053e724..c9133cf153b9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4159,6 +4159,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >       p->wake_entry.u_flags = CSD_TYPE_TTWU;
> >       p->migration_pending = NULL;
> >  #endif
> > +#ifdef CONFIG_UMCG
> > +     umcg_clear_child(p);
> > +#endif
>
> Can you please provide stub functions for the CONFIG_UMCG=n case instead
> of sprinkling #ifdefs all over the place?

Will do.

>
> >  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> > @@ -6105,10 +6108,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
> >        * in the possible wakeup of a kworker and because wq_worker_sleeping()
> >        * requires it.
> >        */
> > -     if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
> > +     if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
> >               preempt_disable();
> >               if (task_flags & PF_WQ_WORKER)
> >                       wq_worker_sleeping(tsk);
> > +#ifdef CONFIG_UMCG
> > +             else if (task_flags & PF_UMCG_WORKER)
> > +                     umcg_wq_worker_sleeping(tsk);
> > +#endif
>
> This #ifdeffery can be completely avoided:
>
> #define PF_SWAPWRITE            0x00800000      /* Allowed to write to swap */
> #ifdef CONFIG_UMCG
> # define PF_UMCG_WORKER         0x01000000      /* UMCG worker */
> #else
> # define PF_UMCG_WORKER         0x00000000
> #endif
>
> plus a stub function for umcg_wq_worker_sleeping() and for UMCG=n the whole muck is
> compiled out, the flags test does not care about PF_UMCG_WORKER....
>
> But aside of that, why has umcg_wq_worker_sleeping() to run with
> preemption disabled?
>
> > +/*
> > + * Called by sched_submit_work() for UMCG workers from within preempt_disable()
> > + * context. In the common case, the worker's state changes RUNNING => BLOCKED,
> > + * and its server's state changes IDLE => RUNNING, and the server is ttwu-ed.
> > + *
> > + * Under some conditions (e.g. the worker is "locked", see
> > + * /Documentation/userspace-api/umcg.[txt|rst] for more details), the
> > + * function does nothing.
> > + */
> > +static void __umcg_wq_worker_sleeping(struct task_struct *tsk)
> > +{
> > +     struct umcg_task __user *ut_worker = tsk->umcg_task;
> > +     u32 prev_state, next_state, server_tid;
> > +     bool preempted = false;
> > +     int ret;
> > +
> > +     if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
> > +             return;
> > +
> > +     /* Sometimes "locked" workers run without servers. */
>
> Sometimes the sun shines... Can you please add understandable comments?
> What's wrong with:
>
>        /* Nothing to do for workers which are not attached to a server */
>
> or something like that which explains nicely what this is about.
>
> > +     if (unlikely(!tsk->pinned_umcg_server_page))
>
> and the comment is needed because tsk->pinned_umcg_server_page does not
> make it obvious what the test is about while
>
>         if (unlikely(!ut_worker_has_server(tsk)))
>
> or
>
>         if (unlikely(ut_worker_detached(tsk)))
>
> would be self explanatory.
>
> > +             return;
> > +
> > +     smp_mb();  /* The userspace may change the state concurrently. */
>
> No tail comments please.
>
> Also this does not explain why this needs to be a full barrier. All
> barriers have to come with a proper explanation what they are
> serializing against and what the counter part is even if the counter
> part is in user space. And that documentation wants to be in the code
> and not somewhere else.
>
> > +     if (get_user_nosleep(prev_state, &ut_worker->state))
> > +             goto die;  /* EFAULT */
>
> This /* EFAULT */ comment documents the obvious. Can you please document
> the non-obvious things properly?
>
> > +
> > +     if (prev_state & UMCG_TF_LOCKED)
> > +             return;
> > +
> > +     if ((prev_state & UMCG_TASK_STATE_MASK) != UMCG_TASK_RUNNING)
> > +             return;  /* the worker is in umcg_wait */
>
> So if the worker is in umcg_wait() then why is it reaching this place at
> all? The current task surely knows that it comes here from umcg_wait(),
> right?

This place is on the "worker goes to sleep" path (sched_submit_work).
umcg_wait() puts the worker to sleep, so this place is triggered. I
can remove PF_UMCG_WORKER in umcg_wait() to elide this if you think
this would be better. I'll try that in the next patchset version.

>
> > +retry_once:
> > +     next_state = prev_state & ~UMCG_TASK_STATE_MASK;
> > +     next_state |= UMCG_TASK_BLOCKED;
> > +     preempted = prev_state & UMCG_TF_PREEMPTED;
> > +
> > +     ret = cmpxchg_user_32_nosleep(&ut_worker->state, &prev_state, next_state);
> > +     if (ret == -EAGAIN) {
> > +             if (preempted)
> > +                     goto die;  /* Preemption can only happen once. */
> > +
> > +             if (prev_state != (UMCG_TASK_RUNNING | UMCG_TF_PREEMPTED))
>
> This check falls flat on it's nose when one of the user space bits
> (24-31) is set in prev_state. prev_state is a misnomer anyway. The usual
> convention is to use cur_state because that's what it is up to the point
> where the cmpxchg succeeds.

Right, will fix.

>
> > +                     goto die;  /* Only preemption can happen. */
> > +
> > +             preempted = true;
>
> How is this supposed to do anything? This goes back to retry_once which
> overwrites preempted...

Hmm, yea, will fix. The idea is that we retry here only once, and only
if we retry due to UMCG_TF_PREEMPTED getting set.

>
> > +             goto retry_once;
> > +     }
>
> > +     if (ret)
> > +             goto die;  /* EFAULT */
> > +
> > +     if (get_user_nosleep(server_tid, &ut_worker->next_tid))
> > +             goto die;  /* EFAULT */
> > +
> > +     if (!server_tid)
> > +             return;  /* Waking a waiting worker leads here. */
>
> I have no idea what that comment is trying to say.
>
> > +     /* The idle server's wait may timeout. */
> > +     /* TODO: make a smarter context switch below when available. */
>
> Neither those make any sense to me.
>
> > +     if (mark_server_running(server_tid, false))
> > +             umcg_ttwu(server_tid, WF_CURRENT_CPU);
>
> Well, after looking at both functions I can see why this wants to be
> smarter. Doing the vpid lookup twice instead of once is certainly not
> the smartest solution.

I'll do some refactoring to avoid extra vpid lookups. The comment,
though, hints at a "smarter context switch" that is more than just
"ttwu the server and put the worker to sleep".

>
> > +     return;
> > +
> > +die:
> > +     pr_warn("umcg_wq_worker_sleeping: killing task %d\n", current->pid);
> > +     force_sig(SIGKILL);
> > +}
> > +
> > +/* Called from sched_submit_work() with preempt_disable. */
> > +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> > +{
> > +     __umcg_wq_worker_sleeping(tsk);
> > +     umcg_unpin_pages();
>
> Coming back to my previous question: Why has all of this to run with
> preemption disabled?
>
> There is absolutely no reason to do that and just because you picked a
> place to invoke that with preemption disabled does not count.
>
> In fact none of the existing two functions require to be invoked with
> preemption disabled and I'm going to send out a patch which removes that
> historic leftover.

I've seen your patch - thanks!

>
> And if this is not called with preemption disabled then none of these
> misnomed _nosleep() accessors are needed and the code can be simplified.

We still need to work with pinned pages, as described above - mm lock
can be held here. How would you prefer these accessors to be named
other than "_nosleep()"? Maybe "_nofixup()"?

>
> > + * Try to wake up. May be called with preempt_disable set. May be called
> > + * cross-process.
> > + *
> > + * Note: umcg_ttwu succeeds even if ttwu fails: see wait/wake state
> > + *       ordering logic.
> > + */
> > +static int umcg_ttwu(u32 next_tid, int wake_flags)
> > +{
> > +     struct task_struct *next;
> > +
> > +     rcu_read_lock();
> > +     next = find_task_by_vpid(next_tid);
> > +     if (!next || !(READ_ONCE(next->umcg_task))) {
> > +             rcu_read_unlock();
> > +             return -ESRCH;
> > +     }
> > +
> > +     /* Note: next does not necessarily share mm with current. */
>
> Which is irrelevant, but what's relevant is that there is absolutely no
> sanity check of next_tid. So this just wakes up what ever TID user space
> writes into the user space task memory. Anything copmeing from user
> space cannot be trusted and needs to be validated. find_task_by_vpid()
> is not sufficient for that.

Well, next_tid must point to a task registered with UMCG, and this is
checked above. I'm not sure what other validation is appropriate here.
What kind of sanity checks are needed? The worst thing that can happen
is a spurious wakeup, which is supposedly something that can happen
anyway and is not a major concern?

>
> > +     try_to_wake_up(next, TASK_NORMAL, wake_flags);  /* Result ignored. */
> > +     rcu_read_unlock();
> > +
> > +     return 0;
> > +}
>
>
> > +/* Returns true on success, false on _any_ error. */
> > +static bool mark_server_running(u32 server_tid, bool may_sleep)
> > +{
> > +     struct umcg_task __user *ut_server = NULL;
> > +     u32 state = UMCG_TASK_IDLE;
> > +     struct task_struct *tsk;
> > +
> > +     rcu_read_lock();
> > +     tsk = find_task_by_vpid(server_tid);
> > +     if (tsk)
> > +             ut_server = READ_ONCE(tsk->umcg_task);
> > +     rcu_read_unlock();
> > +
> > +     if (!ut_server)
> > +             return false;
> > +
> > +     if (READ_ONCE(current->mm) != READ_ONCE(tsk->mm))
> > +             return false;
>
> This is broken because it's outside the rcu read side critical section
> so @tsk can be gone already. Also this lacks a check whether @tsk is a
> kthread because kthreads can use a user mm temporarily.

I don't think kthreads can have tsk->umcg_task set, so the function
will return earlier. I'll move the check under rcu.

>
> Also what's the purpose of these undocumented READ_ONCE() instances?

While ttwu can be called cross-mm, anything more involved, such as
changing the server's UMCG state, requires the remote task to belong
to the same process, and this is what the check validates. I'll add
that comment to the code.

>
> Thanks,
>
>         tglx

Thanks,
Peter
