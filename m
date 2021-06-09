Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D83A1E08
	for <lists+linux-api@lfdr.de>; Wed,  9 Jun 2021 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhFIUVI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIUVI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 16:21:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF2C061574
        for <linux-api@vger.kernel.org>; Wed,  9 Jun 2021 13:19:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e2so1500715ljk.4
        for <linux-api@vger.kernel.org>; Wed, 09 Jun 2021 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAygAxZX9OdGJcHJ7SPcLnV7w97SnkQyWWgs407VRjU=;
        b=M5iA/b/nEqwtYEInDCvVIYHGZ7derBher903QWI6X89ocKj4RiXdwvs70nbRuPUOPQ
         sIwx8y87dQTwUg9+wgHLWIvrbewlr4GE/M6xNdauTPOpW3hN5rfNV9fUVzxXTZaLlBwI
         XlRjxrhW4+L1RajH4g96kPBkAnHv2sHT4bbW9c23qYSj2GpaM5KRt0vzbvbkkYUhC3jm
         v2D93GATD3OBvWnvoKZv/V+ZFKEMcQ2acGonRKFp6ENqGUpyuMtQDs4wcSHWiInSMiIe
         OrFHK3D2sjl4TcIr39P8V4otc5niBCRXQiT8mjT1/lhjyyjJ9H0o3ZSqimGqVdgmpb3+
         QrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAygAxZX9OdGJcHJ7SPcLnV7w97SnkQyWWgs407VRjU=;
        b=p9v1eX3neQ3uKJhdy0KP3xTSyrxG/343KE2zkGdtrVj4WcQdmdmcoB5WYnCW5RxkX8
         PEIV42OeG4vKAtLdeuA8jK8FZxq3EaEdkFiXxKPuhYdk2bXbz5MIQWeGZ4iZ33S4ujDP
         3zrhfTVM59eLmPwsEjfKvvA8vOFWhRa/atO4znHaSEhfscKoWODxHLlck0j2P6tNrDs8
         tXNrp2A/Ppx6RFHfKZPWPMtCbBfjreho6b10xzWXiI56scknbUC2VbSAR23R02C3hfBx
         P3qMxQVCbveZC2KcmhEBrkywaWHFFBg5ls2DHQlsZFtpwmaNcj0cJqX6FvZw+JcPGbub
         Pmlg==
X-Gm-Message-State: AOAM530sesbt0ipZ8a/CJPxno+zS+ix6qLDxd7VETTuc3+f5EBC3Rjq1
        OiytxVebDOxML68eYp9eQtwCyq/2Iqb8nahZ9KGL9w==
X-Google-Smtp-Source: ABdhPJyWdmSAOAUuBdIlkW99gBGwfT7wkN0B58yAWAywCOmRol2sB6LnA+RX7M4SviJz2EB8X4xFGfUntjK+wWxR0XA=
X-Received: by 2002:a2e:7f0f:: with SMTP id a15mr1120533ljd.387.1623269951154;
 Wed, 09 Jun 2021 13:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <20210609125435.GA68187@worktop.programming.kicks-ass.net>
In-Reply-To: <20210609125435.GA68187@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 9 Jun 2021 13:18:59 -0700
Message-ID: <CAPNVh5e6GoKdYztRvQRXxjuYGJK0yEDkDaBCp=i3nU9XwfDGSg@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 9, 2021 at 5:55 AM Peter Zijlstra <peterz@infradead.org> wrote:

Finally, a high-level review - thanks a lot, Peter! My comments below,
and two high-level "important questions" at the end of my reply (with
some less important questions here and there).

[...]

> You present an API without explaining, *at*all*, how it's supposed to be
> used and I can't seem to figure it out from the implementation either :/

I tried to explain it in the doc patch that I followed up with:
https://lore.kernel.org/patchwork/cover/1433967/#1632328

Or do you mean it more narrowly, i.e. I do not explain syscalls in
detail? This assessment I agree with - my approach was/is to finalize
the userpace API (libumcg) first, and make the userspace vs kernel
decisions later.

For example, you wonder why there is no looping in umcg_wait
(do_wait). This is because the looping happens in the userspace in
libumcg. My overall approach was to make the syscalls as simple as
possible and push extra logic to the userspace.

It seems that this approach is not resonating with kernel
developers/maintainers - you are the third person asking why there is
no looping in sys_umcg_wait, despite the fact that I explicitly
mentioned pushing it out to the userspace.

Let me try to make my case once more here.

umcg_wait/umcg_wake: the RUNNABLE/RUNNING state changes, checks, and
looping happen in the userspace (libumcg - see umcg_wait/umcg_wake in
patch 5 here: https://lore.kernel.org/patchwork/patch/1433971/), while
the syscalls simply sleep/wake. I find doing it in the userspace is
much simpler and easier than in the kernel, as state reads and writes
are just atomic memory accesses; in the kernel it becomes much more
difficult - rcu locked sections, tasks locked, etc.

On the other hand I agree that having syscalls more logically
complete, in the sense that they do not require much hand-holding and
retries from the userspace, is probably better from the API design
perspective. My worry here is that state validation and retries in the
userspace are unavoidable, and so going the usual way we will end up
with retry loops both in the kernel and in the userspace.

So I pose this IMPORTANT QUESTION #1 to you that I hope to get a clear
answer to: it is strongly preferable to have syscalls be "logically
complete" in the sense that they retry things internally, and in
generally try to cover all possible corner cases; or, alternatively,
is it OK to make syscalls lightweight but "logically incomplete", and
have the accompanied userspace wrappers do all of the heavy lifting
re: state changes/validation, retries, etc.?

I see two additional benefits of thin/lightweight syscalls:
- reading userspace state is needed much less often (e.g. my umcg_wait
and umcg_wake syscalls do not access userspace data at all - also see
my "second important question" below)
- looping in the kernel, combined with reading/writing to userspace
memory, can easily lead to spinning in the kernel (e.g. trying to
atomically change a variable and looping until succeeding)

A clear answer one way or the other will help a lot!

[...]

> > +448  common  umcg_register_task      sys_umcg_register_task
> > +449  common  umcg_unregister_task    sys_umcg_unregister_task
>
> I think we can do away with the api_version thing and frob that in
> register.

Ok, will do.

> Also, do we really need unregister over just letting a task
> exit? Is there a sane use-case where task goes in and out of service?

I do not know of a specific use case here. On the other hand, I do not
know of a specific use case to unregister RSEQ, but the capability is
there. Maybe the assumption is that the userspace memory passed to the
kernel in register() may be freed before the task exits, and so there
should be a way to tell the kernel to no longer use it?

>
> > +450  common  umcg_wait               sys_umcg_wait
> > +451  common  umcg_wake               sys_umcg_wake
>
> Right, except I'm confused by the proposed implementation. I thought the
> whole point was to let UMCG tasks block in kernel, at which point we'd
> change their state to BLOCKED and have userspace select another task to
> run. Such BLOCKED tasks would then also be captured before they return
> to userspace, i.e. the whole admission scheduler thing.
>
> I don't see any of that in these patches. So what are they actually
> implementing? I can't find enough clues to tell :-(

As I mentioned above, state changes are done in libumcg in userspace
here: https://lore.kernel.org/patchwork/cover/1433967/#1632328

If you insist this logic should live in the kernel, I'll do it (grudgingly).

>
> > +452  common  umcg_swap               sys_umcg_swap
>
> You're presenting it like a pure optimization, but IIRC this is what
> enables us to frob the scheduler state to ensure the whole thing is seen
> (to the rest of the system) as the M server tasks, instead of the
> constellation of N+M worker and server tasks.

Yes, you recall it correctly.

> Also, you're not doing any of the frobbing required.

This is because I consider the frobbing a (very) nice to have rather
than a required feature, and so I am hoping to argue about how to
properly do it in later patchsets. This whole thing (UMCG) will be
extremely useful even without runtime accounting hacking and whatnot,
and so I hope to have everything else settled and tested and merged
before we spend another several weeks/months trying to make the
frobbing perfect.

>
> > +453  common  umcg_create_group       sys_umcg_create_group
> > +454  common  umcg_destroy_group      sys_umcg_destroy_group
>
> This is basically needed for cross-server things, right? What we in the
> kernel would call SMP. Some thoughts on that below.

Yes, right.

>
> > +455  common  umcg_poll_worker        sys_umcg_poll_worker
>
> Shouldn't this be called idle or something, instead of poll, the whole
> point of having this syscall is to that you can indeed go idle.

That's another way of looking at it. Yes, this means the server idles
until a worker becomes available. How would you call it? umcg_idle()?

> Userspace can implement polling just fine without help:
>
>         for (;;) {
>                 struct umcg_task *runnable = xchg(me->umcg_runnable_ptr, NULL);
>                 if (runnable) {
>                         // put them on a list and run one
>                 }
>                 cpu_relax();
>         }
>
> comes to mind (see below).
>
> > +456  common  umcg_run_worker         sys_umcg_run_worker
>
> This I'm confused about again.. there is no fundamental difference
> between a worker or server, they're all the same.

I don't see it this way. A server runs (on CPU) by itself and blocks
when there is a worker attached; a worker runs (on CPU) only when it
has a (blocked) server attached to it and, when the worker blocks, its
server detaches and runs another worker. So workers and servers are
the opposite of each other.

>
> > +457  common  umcg_preempt_worker     sys_umcg_preempt_worker
>
> And that's magic, we'll get to it..
>
> > Index: linux-2.6/include/uapi/linux/umcg.h
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/include/uapi/linux/umcg.h
> > @@ -0,0 +1,70 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_UMCG_H
> > +#define _UAPI_LINUX_UMCG_H
> > +
> > +#include <linux/limits.h>
> > +#include <linux/types.h>
> > +
> > +/*
> > + * UMCG task states, the first 8 bits.
>
> All that needs a state transition diagram included

I will add it. For now the doc patch can be consulted:
https://lore.kernel.org/patchwork/cover/1433967/#1632328

>
> > + */
> > +#define UMCG_TASK_NONE                       0
> > +/* UMCG server states. */
> > +#define UMCG_TASK_POLLING            1
> > +#define UMCG_TASK_SERVING            2
> > +#define UMCG_TASK_PROCESSING         3
>
> I get POLLING, although per the above, this probably wants to be IDLE.

Ack.

>
> What are the other two again? That is, along with the diagram, each
> state wants a description.

SERVING: the server is blocked, its attached worker is running
PROCESSING: the server is running (= processing a block or wake
event), has no running worker attached

Both of these states are different from POLLING/IDLE and from each other.

>
> > +/* UMCG worker states. */
> > +#define UMCG_TASK_RUNNABLE           4
> > +#define UMCG_TASK_RUNNING            5
> > +#define UMCG_TASK_BLOCKED            6
> > +#define UMCG_TASK_UNBLOCKED          7
>
> Weird order, also I can't remember why we need the UNBLOCKED, isn't that
> the same as the RUNNABLE, or did we want to distinguish the state were
> we're no longer BLOCKED but the user scheduler hasn't yet put us on it's
> ready queue (IOW, we're on the runnable_ptr list, see below).

Yes, UNBLOCKED it a transitory state meaning the worker's blocking
operation has completed, but the wake event hasn't been delivered to
the userspace yet (and so the worker it not yet RUNNABLE)

[...]

> > +struct umcg_task {
> > +     /**
> > +      * @state: the current state of the UMCG task described by this struct.
> > +      *
> > +      * UMCG task state:
> > +      *   bits  0 -  7: task state;
> > +      *   bits  8 - 15: state flags;
> > +      *   bits 16 - 23: reserved; must be zeroes;
> > +      *   bits 24 - 31: for userspace use.
> > +      */
> > +     uint32_t        state;
> > +} __attribute((packed, aligned(4 * sizeof(uint64_t))));
>
> So last time I really looked at this it looked something like this:
>
> struct umcg_task {
>         u32     umcg_status;            /* r/w */
>         u32     umcg_server_tid;        /* r   */
>         u32     umcg_next_tid;          /* r   */
>         u32     __hole__;
>         u64     umcg_blocked_ptr;       /*   w */
>         u64     umcg_runnable_ptr;      /*   w */
> };
>
> (where r/w is from the kernel's pov)
> (also see uapi/linux/rseq.h's ptr magic)

I tried doing it this way, i.e. to only have only userspace struct
added (without kernel-only data), and I found it really cumbersome and
inconvenient and much slower than the proposed implementation. For
example, when a worker blocks, it seems working with "struct
task_struct *peer" to get to the worker's server is easy and
straightforward; reading server_tid from userspace, then looking up
the task and only then doing what is needed (change state and wakeup)
is ... unnecessary? Also validating things becomes really important
but difficult (what if the user put something weird in
umcg_server_tid? or the ptr fields?). In my proposed implementation
only the state is user-writable, and it does not really affect most of
the kernel-side work.

Why do you think everything should be in the userspace memory?

>
> So a PF_UMCG_WORKER would be added to sched_submit_work()'s PF_*_WORKER
> path to capture these tasks blocking. The umcg_sleeping() hook added
> there would:
>
>     put_user(BLOCKED, umcg_task->umcg_status);
>
>     tid = get_user(umcg_task->next_tid);
>     if (!tid)
>         tid = get_user(umcg_task->umcg_server_tid);
>     umcg_server = find_task(tid);
>
>     /* append to blocked list */
>     umcg_task->umcg_blocked_ptr = umcg_server->umcg_blocked_ptr;
>     umcg_server->umcg_blocked_ptr = umcg_task;
>
>     // with some user_cmpxchg() sprinkled on to make it an atomic single
>     // linked list, we can borrow from futex_atomic_cmpxchg_inatomic().
>
>     /* capture return to user */
>     add_task_work(current, &current->umcg->task_work, TWA_RESUME);
>
>     umcg_server->state = RUNNING;
>     wake_up_process(umcg_server);
>
> That task_work would, as the comment says, capture the return to user,
> and do something like:
>
>     put_user(RUNNABLE, umcg_task->umcg_status);
>
>     tid = get_user(umcg_task->umcg_server_tid);
>     umcg_server = find_task(tid);
>
>     /* append to runable list */
>     umcg_task->umcg_runnable_ptr = umcg_server->umcg_runnable_ptr;
>     umcg_server->umcg_runnable_ptr = umcg_task;
>     // same as above, this wants some user cmpxchg
>
>     umcg_wait();
>
> And for that we had something like:
>
> void umcg_wait(void)
> {
>         u32 state;
>
>         for (;;) {
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 if (get_user(state, current->umcg->state))
>                         break;
>                 if (state == UMCG_RUNNING)
>                         break;
>                 if (signal_pending(current))
>                         break;
>                 schedule();
>         }
>         __set_current_state(TASK_RUNNING);
> }
>
> Which would wait until the userspace admission logic lets us rip by
> setting state to RUNNING and prodding us with a sharp stick.
>
>
> This all ensures that when a UMCG task goes to sleep, we mark ourselves
> BLOCKED, we add ourselves to a user visible blocked list and wake the
> owner of that blocked list.
>
> We can either pre-select some task to run after us (next_tid) or it'll
> pick the dedicated server task we're assigned to (server_tid).
>
> Any time a task wakes up, it needs to check the blocked list and update
> userspace ready queues and the sort, after which it can either run
> things if it's a worker or pick another task to run if that's its work
> (a server isn't special in this regard).
>
> This was the absolute bare minimum, and I'm not seeing any of that here.
> Nor an explanation of what there actually is :/
>
>
> On top of this there's 'fun' questions about signals, ptrace and
> umcg_preemption to be answered.
>
> I think we want to allow signals to happen to UMCG RUNNABLE tasks, but
> have them resume umcg_wait() on sigreturn.
>
> I've not re-read the discussion with tglx on ptrace, he had some cute
> corner cases IIRC.
>
> The whole preemption thing should be doable with a task_work. Basically
> check if the victim is RUNNING, send it TWA_SIGNAL to handle the task
> work, the task_work would attempt a RUNNING->RUNNABLE (cmpxchg)
> transition, success thereof needs to be propagated back to the syscall
> and returned.
>
> Adding preemption also means you have to deal with appending to
> runnable_ptr list when the server isn't reaily available (most times).
>
>
> Now on to those group things; they would basically replace the above
> server_tid with a group/list of related server tasks, right? So why not
> do so, litearlly:
>
> struct umcg_task {
>         u32     umcg_status;            /* r/w */
>         u32     umcg_next_tid;          /* r   */
>         u64     umcg_server_ptr;        /* r   */
>         u64     umcg_blocked_ptr;       /*   w */
>         u64     umcg_runnable_ptr;      /*   w */
> };
>
> Then have the kernel iterate the umcg_server_ptr list, looking for an
> available (RUNNING or IDLE) server, also see the preemption point above.
>
> This does, however, require a umcg_task to pid translation, which we've
> so far avoided :/ OTOH it makes that grouping crud a user problem and we
> can make the syscalls go away (and I that CRUI would like this better
> too).

All of the code above assumes userspace-only data. I did not look into
every detail of your suggestions because I want to make sure we first
agree on this: do we keep every bit of information in the userspace
(other than "struct umcg_task __user *" pointer in task_struct) or do
we have some kernel-only details as well?

So IMPORTANT QUESTION #2: why would we want to keep __everything__ in
the userspace memory? I understand that CRIU would like this, but
given that the implementation would at a minimum have to

1. read a umcg_server_ptr (points to the server's umcg_task)
2. get the server tid out of it (presumably by reading a field from
the server's umcg_task; what if the tid is wrong?)
3. do a tid lookup

to get a task_struct pointer, it will be slower; I am also not sure it
call be done safely at all: with kernel-side data and I can do rcu
locking, task locking, etc. to ensure that the value I got does not
change while I'm working with it; with userspace data, a lot of races
will have to be specially coded for that can be easily handled by
kernel-side rcu locks or spin locks... Maybe this is just my ignorance
showing, and indeed things can be done simply and easily with
userspace-only data, but I am not sure how.

A common example:

- worker W1 with server S1 calls umcg_wait()
- worker W2 with server S2 calls umcg_swap(W1)

If due to preemption and other concurrency weirdness the two syscalls
above race with each other, each trying to change the server assigned
to W1. I can easily handle the race by doing kernel-side locking;
without kernel-side locking (cannot do rcu locks and/or spin locks
while accessing userspace data) I am not sure how to handle the race.
Maybe it is possible with careful atomic writes to states and looping
to handle this specific race (what if the userspace antagonistically
writes to the same location? will it force the syscall to spin
indefinitely?); but with proper locking many potential races can be
handled; with atomic ops and looping it is more difficult... Will we
have to add a lock to struct umcg_task? And acquire it from the kernel
side? And worry about spinning forever?

>
> > +static int do_context_switch(struct task_struct *next)
> > +{
[...]
> > +}
> > +
> > +static int do_wait(void)
> > +{
[...]
> > +}
>
> Both these are fundamentally buggered for not having a loop.

As I mentioned above, the loop is in the userpace.

[...]
> > +SYSCALL_DEFINE2(umcg_wait, u32, flags,
> > +             const struct __kernel_timespec __user *, timeout)
>
> I despise timespec, tglx?

What are the alternatives? I just picked what the futex code uses.

[...]
> > +SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
> > +{
[...]
>
> I'm thinking this might want to be a user cmpxchg from RUNNABLE->RUNNING.
>
> You need to deal with concurrent wakeups.

This is done in the userspace - much easier to do it there...

In summary, two IMPORTANT QUESTIONS:

1. thin vs fat syscalls: can we push some code/logic to the userspace
(state changes, looping/retries), or do we insist on syscalls handling
everything? Please have in mind that even if we choose the second
approach (fat syscalls), the userspace will most likely still have to
do everything it does under the first option just to handle
signals/interrupts (i.e. unscheduled wakeups);
2. kernel-side data vs userspace-only: can we avoid having kernel-side
data? More specifically, what alternatives to rcu_read_lock and/or
task_lock are available when working with userspace data?

When these two questions are answered to everybody's satisfaction, we
can discuss this patchset/library/API in more detail.

Thanks,
Peter
