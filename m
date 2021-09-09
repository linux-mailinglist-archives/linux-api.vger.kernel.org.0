Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9F404313
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 03:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbhIIBoI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 21:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbhIIBng (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 21:43:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA8C061A11
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 18:40:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h1so331089ljl.9
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tXuyUI3lCOB2GN9kHx3unDWW1ILjBXBvLfPHip2u8Y=;
        b=SbkNE/F1HWuVqTjyeJRXMt82GvqhBIP76ZwL7EMX4bIMupxNLJFb2UzZRATUXxzqHs
         95NimfWvahBzJa5sMa5dUy3mfzTMnkrt+hbL2s6TkRSAwTS67WHyBLYUTCWXWg47cB4c
         t3BZp4Nycqkhkm3q+dIe59/Hmaypbowp8ZId9+Bj53baj2NoQfIHi2GXQ1dTBVReqnFr
         4aYWO3DjMeJ/rCVzhLikq3hnjZUcbIeaB1Ox47n0+9RA3lC2eFUbiuxTfoS+UVddtp2R
         HdeP/XSq6eTz64e02TAfLb9AxkW+/J45Np14xr3VqzWlRI2e4b6YlUPKqg0l+ivQrLOX
         bLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tXuyUI3lCOB2GN9kHx3unDWW1ILjBXBvLfPHip2u8Y=;
        b=CbaQexhNXIMQDqg6vhbHEYGulL+5Cvi0qQcei4lhOx82f9V54ntC5ztROPY3Nqqh79
         A9Hr3Ab4RpUTui+UkmDov1klz2Lc0H7IOtxmueCiWfL/PkBsIaJTp54G/+JWQwomjr5d
         QrrXb35G3tDu7obYsPz7ycP91Cp1tDJOd24Lj1ciV2LIkP8esWL3wzHYVJaa7JyA52Xv
         AJuCu+CAe0fB8AyOjqZtqC7OWDg1LX2IOXLisyfBJ7RE7gFEX65Ffn2OOJaPAMk0JI94
         P6X5JoezZCjvkXgKNJZDRImobR4I2/r/P9/w12Z3rZcOv0XYG9geZM90cOQ7/v037772
         QYvw==
X-Gm-Message-State: AOAM533lfSeWYfROgAcIcOMa8ulvbb++/I+kBazPJmma1d1adBVGbSPj
        pmwVhqX0iL9/l/cuJLiLAyotIIbbKamkJId1WS4lcQ==
X-Google-Smtp-Source: ABdhPJzcpEVcAnIebve+KkLngy0GQX0BKlyMboI6mNPVQ40Prj2kNcu09j36aQELUrS1IJYSGjinA81DZHviwFTnk6c=
X-Received: by 2002:a2e:a903:: with SMTP id j3mr266241ljq.347.1631151608817;
 Wed, 08 Sep 2021 18:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-4-posk@google.com>
In-Reply-To: <20210908184905.163787-4-posk@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Sep 2021 03:39:42 +0200
Message-ID: <CAG48ez3Kd0sfKBi9CUSYDSd+ydkQ6H=zm2-iSB3jXHCyFvuWHw@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.5] sched/umcg: RFC: implement UMCG syscalls
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 8, 2021 at 8:49 PM Peter Oskolkov <posk@posk.io> wrote:
> Define struct umcg_task and two syscalls: sys_umcg_ctl sys_umcg_wait.
>
> All key operations, such as wait/wake/context-switch, as well as
> timeouts and block/wake detection, are working quite reliably.
>
> In addition, the userspace can now force the kernel to preempt
> a running worker by changing its state from RUNNING to
> RUNNING | PREEMPTED and sending a signal to it. This new functionality
> is less well tested than the key operations above, but is working
> well in the common case of the worker busy in the userspace.

I haven't properly reviewed the entire thing, but I've left a bunch of
comments below. Especially for the part about priority inversion /
livelocks at the bottom, it might be tricky to figure out exactly how
this should work.

[...]
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
[...]
> @@ -4159,6 +4160,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>         p->wake_entry.u_flags = CSD_TYPE_TTWU;
>         p->migration_pending = NULL;
>  #endif
> +#ifdef CONFIG_UMCG
> +       p->umcg_task = NULL;
> +       p->flags &= ~PF_UMCG_WORKER;
> +#endif

These things probably also need to be reset on execve, not just on
fork? In particular the userspace pointer in ->umcg_task will become
meaningless on execve(). Maybe a good spot to reset that would be
somewhere in begin_new_exec(), before the call to exec_mmap()? Or
maybe execve should bail out early on if the task is configured for
UMCG?

[...]
> diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
[...]
> +/*
> + * NOTE: all code below is called from workqueue submit/update, so all
> + *       errors result in the termination of the current task (via SIGKILL).
> + */
> +
> +/* Returns true on success, false on _any_ error. */
> +static bool mark_server_running(u32 server_tid)
> +{
> +       struct umcg_task __user *ut_server = NULL;
> +       u32 state = UMCG_TASK_IDLE;
> +       struct task_struct *tsk;
> +
> +       rcu_read_lock();
> +       tsk = find_task_by_vpid(server_tid);
> +       if (tsk)
> +               ut_server = READ_ONCE(tsk->umcg_task);

Since you are reading the ->umcg_task pointer of another task here,
protected only by READ_ONCE(), I think the writes over in the
umcg_ctl() syscall and in do_exit() should be using WRITE_ONCE()?

You should check here that userspace isn't just giving us a TID of
some entirely unrelated thread (and also that if that thread just
died, and its ID was reassigned to a new thread in another process,
we're not going to access an address belonging to an entirely
different process here). I think an appropriate check would be
"READ_ONCE(tsk->group_leader) == current->group_leader"?

(And then maybe you could also do that check in the other places that
do find_task_by_vpid() - for consistency and also in general to reduce
how much userspace can interfere with the scheduling of unrelated
processes.)

> +       rcu_read_unlock();
> +
> +       if (!ut_server)
> +               return false;
> +
> +       return !cmpxchg_user_32(&ut_server->state, &state, UMCG_TASK_RUNNING);
> +}
> +
> +/*
> + * In the common case, change @tsk RUNNING => BLOCKED. Called from
> + * preempt_disable() and local_irq_disable() context.
> + */
> +static void __umcg_wq_worker_sleeping(struct task_struct *tsk)

Can you maybe add a sentence here that describes in more high-level
terms what's going on? Something like "The current task is a UMCG
worker that is about to block, so we may have to inform userspace and
maybe also wake up another task on this CPU to keep the CPU fully
utilized"?

> +{
> +       struct umcg_task __user *ut_worker = tsk->umcg_task;
> +       u32 prev_state, next_state, server_tid;
> +       bool preempted = false;
> +       int ret;
> +
> +       if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
> +               return;
> +
> +       smp_mb();  /* Guard the read below. */

There are two sides to a barrier - one specific operation (or set of
operations) has to happen after another operation (or set of
operations). The comment doesn't make it clear against which preceding
operation we're ordering the following read.

> +       if (get_user_nosleep(prev_state, &ut_worker->state))
> +               goto die;  /* EFAULT */
> +
> +       if (prev_state & UMCG_TF_LOCKED)
> +               return;
> +       if ((prev_state & UMCG_TASK_STATE_MASK) != UMCG_TASK_RUNNING)
> +               return;  /* the worker is in umcg_wait */
> +
> +retry_once:
> +       next_state = prev_state & ~UMCG_TASK_STATE_MASK;
> +       next_state |= UMCG_TASK_BLOCKED;
> +       preempted = prev_state & UMCG_TF_PREEMPTED;
> +
> +       ret = cmpxchg_user_32(&ut_worker->state, &prev_state, next_state);
> +       if (ret == -EAGAIN) {
> +               if (preempted)
> +                       goto die;  /* Preemption can only happen once. */
> +
> +               if (prev_state != (UMCG_TASK_RUNNING | UMCG_TF_PREEMPTED))
> +                       goto die;  /* Only preemption can happen. */
> +
> +               preempted = true;
> +               goto retry_once;
> +       }
> +       if (ret)
> +               goto die;  /* EFAULT */
> +
> +       if (get_user_nosleep(server_tid, &ut_worker->next_tid))
> +               goto die;  /* EFAULT */
> +
> +       if (!server_tid)
> +               return;  /* Waking a waiting worker leads here. */
> +
> +       /* The idle server's wait may timeout. */
> +       /* TODO: make a smarter context switch below when available. */
> +       if (mark_server_running(server_tid))
> +               umcg_ttwu(server_tid, WF_CURRENT_CPU);
> +
> +       return;
> +
> +die:
> +       pr_warn("umcg_wq_worker_sleeping: killing task %d\n", current->pid);
> +       force_sig(SIGKILL);
> +}
> +
> +/* Called from sched_submit_work() with preempt_disable. */
> +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> +{
> +       /*
> +        * Although UMCG preemption state change (UMCG_TF_PREEMPTED) racing
> +        * with the worker blocking in a syscall is handled correctly in
> +        * __umcg_wq_worker_sleeping() above, actual signal to the worker
> +        * during the execution of this function might be causing
> +        * isuses, based on some observed test failures. Disabling IRQs
> +        * make the failures go away.
> +        */

I guess that's a todo item to figure out before this lands?

> +       local_irq_disable();
> +       __umcg_wq_worker_sleeping(tsk);
> +       local_irq_enable();
> +}
> +
> +/**
> + * enqueue_idle_worker - push an idle worker onto idle_workers_ptr list/stack.
> + *
> + * Returns true on success, false on a fatal failure.
> + */
> +static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
> +{
> +       u64 __user *node = &ut_worker->idle_workers_ptr;
> +       u64 __user *head_ptr;
> +       u64 first = (u64)node;
> +       u64 head;
> +
> +       if (get_user_nosleep(head, node) || !head)
> +               return false;
> +
> +       head_ptr = (u64 __user *)head;
> +
> +       if (put_user_nosleep(1ULL, node))
> +               return false;

Can anyone observe this value, and if so, what does it mean for them?

If it's a meaningful value, maybe there should be a #define for it
somewhere that gives it a proper name; if it isn't, and you're just
writing it here as a sort of sanity check, maybe add a comment that
explains that?

> +       if (xchg_user_64(head_ptr, &first))
> +               return false;
> +
> +       if (put_user_nosleep(first, node))
> +               return false;
> +
> +       return true;
> +}
[...]
> +/*
> + * Returns true to wait,

Maybe clarify this as "Returns true to switch away from this task
(either by switching to a specific other task or by just scheduling)",
or something like that?

> false to return to the userspace.

Maybe "false to continue execution in the current task"? We're not
necessarily going to return straight to userspace from here.

> Called with IRQs
> + * disabled. In the common case, enqueues the worker to idle_workers_ptr list
> + * and wakes the idle server (if present).
> + */

The comment here says that we're called with IRQs disabled, but
there's a path in our caller umcg_wq_worker_running() where we're
called almost directly after calling might_sleep(). Isn't that a
contradiction?

As far as I can tell, we always get here in sleepable context.

> +static bool process_waking_worker(struct task_struct *tsk, u32 *server_tid)
> +{
> +       struct umcg_task __user *ut_worker = tsk->umcg_task;
> +       u32 prev_state, next_state;
> +       int ret = 0;
> +
> +       *server_tid = 0;
> +
> +       if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
> +               return false;
> +
> +       if (fatal_signal_pending(tsk))
> +               return false;
> +
> +       smp_mb();  /* Guard the read below. */
> +       if (get_user_nosleep(prev_state, &ut_worker->state))
> +               goto die;
> +       if ((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_RUNNING) {
> +               u32 tid;
> +
> +               if (prev_state & UMCG_TF_LOCKED)
> +                       return true;  /* Wakeup: wait but don't enqueue. */
> +
> +               smp_mb();  /* Order getting state and getting server_tid */
> +
> +               if (get_user_nosleep(tid, &ut_worker->next_tid))
> +                       goto die;
> +               if (prev_state & UMCG_TF_PREEMPTED) {
> +                       if (!tid)
> +                               goto die;  /* PREEMPTED workers must have a server. */
> +
> +                       /* Always enqueue preempted workers. */
> +                       if (!mark_server_running(tid))
> +                               goto die;
> +
> +                       *server_tid = tid;
> +               } else if (tid)
> +                       return false;  /* pass-through: RUNNING with a server. */
> +
> +               /* If !PREEMPTED, the worker gets here via UMCG_WAIT_WAKE_ONLY */
> +       } else if (unlikely((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE &&
> +                       (prev_state & UMCG_TF_LOCKED)))
> +               return false;  /* The worker prepares to sleep or to unregister. */
> +
> +       if ((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE)
> +               return true;  /* the worker called umcg_wait(); don't enqueue */
> +
> +       next_state = prev_state & ~UMCG_TASK_STATE_MASK;
> +       next_state |= UMCG_TASK_IDLE;
> +
> +       if (prev_state != next_state)
> +               ret = cmpxchg_user_32(&ut_worker->state, &prev_state, next_state);
> +       if (ret)
> +               goto die;
> +
> +       if (!enqueue_idle_worker(ut_worker))
> +               goto die;
> +
> +       smp_mb();  /* Order enqueuing the worker with getting the server. */
> +       if (!(*server_tid) && !get_idle_server(ut_worker, server_tid))
> +               goto die;
> +
> +       return true;
> +
> +die:
> +       pr_warn("umcg_wq_worker_running: killing task %d\n", current->pid);
> +       force_sig(SIGKILL);
> +       return false;
> +}
> +
> +void umcg_wq_worker_running(struct task_struct *tsk)
> +{
> +       might_sleep();
> +
> +       /* Avoid recursion by removing PF_UMCG_WORKER */
> +       current->flags &= ~PF_UMCG_WORKER;
> +
> +       do {
> +               bool should_wait;
> +               u32 server_tid;
> +
> +               should_wait = process_waking_worker(tsk, &server_tid);
> +
> +               if (!should_wait)
> +                       break;
> +
> +               if (server_tid)
> +                       umcg_do_context_switch(server_tid, 0);
> +               else
> +                       umcg_idle_loop(0);

I think a pretty nasty aspect here is that if we're deep in some
kernel code that is holding some mutex, and we have to briefly
schedule() for a kmalloc() call or something like that, and userspace
does something stupid like suddenly setting our ->state to
UMCG_TASK_IDLE, then we'll go into umcg_idle_loop() and potentially
sleep forever, even though we might be holding some important mutex
that half the system needs to function, and then the whole machine
deadlocks or something like that.

An even more nasty situation would be if we're holding some kernel
mutex that the thread which UMCG-preempted us is holding, so when we
get scheduled we'll reschedule over to that other thread, but when
that thread gets scheduled it notices that the mutex is still held, so
then it'll reschedule back over to us, and then we'll reschedule back
over... that'd be even worse than Priority Inversion, where at least
*some* work gets done, even if it's not the most high-priority work;
we'd just get stuck in an unproductive livelock.


I think umcg_idle_loop() should never be called from scheduler
callbacks (meaning umcg_wq_worker_running()), only from UMCG syscalls.
There also shouldn't be any mechanism in a scheduler callback that
would allow userspace to prevent the task from executing for a long
amount of time. For comparison, when you use sched_setscheduler() to
set the priority of a task to SCHED_IDLE, the task will still run very
infrequently; see
<https://www.kernel.org/doc/html/latest/scheduler/sched-design-CFS.html#scheduling-policies>:
"SCHED_IDLE: This is even weaker than nice 19, but its not a true idle
timer scheduler in order to avoid to get into priority inversion
problems which would deadlock the machine."

Maybe UMCG_TF_PREEMPTED should always only take effect once we're out
of whatever syscall or pagefault handler we were in?

(A more complicated/messy/ugly compromise would be to add a field to
task_struct that keeps track of how often we have switched to another
thread in the scheduler callback because someone set UMCG_TF_PREEMPTED
on us, and reset that counter when we've reached a safe point where
we're sure we can't be holding any locks (e.g. when returning to
userspace?); and if the counter gets too big, temporarily ignore
UMCG_TF_PREEMPTED until we've reached a safe point. But I'm not a
scheduler expert, I don't know how much sense that makes in the bigger
picture. I guess it would only make sense if the preempting task is
likely to finish its work before the scheduler gets back to us?)

(Or maybe yet another approach would be to temporarily drop the
current thread to SCHED_IDLE somehow while it is preempted, but then
only explicitly reschedule once, and then let the kernel figure out
how to deal with the locking issues just like it would for a normal
SCHED_IDLE thread - in other words, by accepting that there will
potentially be a priority inversion situation for several seconds
before the idle thread drops its lock... Probably also not ideal...)


> +       } while (true);
> +
> +       current->flags |= PF_UMCG_WORKER;
> +}
