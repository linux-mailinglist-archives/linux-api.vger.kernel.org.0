Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396813A14F5
	for <lists+linux-api@lfdr.de>; Wed,  9 Jun 2021 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFIM53 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFIM52 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 08:57:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74EC061574;
        Wed,  9 Jun 2021 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9t9Afbi2dvtDVghHwXJJukOvcPVG4QJyjOBbQmQeDJc=; b=H5zwSV7LbA4YD5vmdJrfFA21c1
        NdEvoS9qEO5gbnEpAbUQDiMiwyrz1VYM/pIah0O8JFO53PHfd8hUp91azEstTlSFwaeMa7hBjM4yu
        Rt9lAYXxHLKeOzx75b6GDYHZjDGHayHSWEUXMQ9GB9+HbDPuSwCajNM3fgsNLqm1rgastwAVOos57
        7+SZDjZTMFiG+LlmJY+34HyXUgoX8xZBa46cy75aL4cLsisW+gXYq+TGTquxygWc167pF3dsuYsG+
        OlqjdyjYKowrBW+7MaJD/x9KA5MX1wh8CiihVJSuhlSyjNeOt5yL81SQZg1/ZCHfgXKEDhJfOjkPH
        GjkjZGxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqxjB-000Vzx-Iu; Wed, 09 Jun 2021 12:54:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9AA19867D0; Wed,  9 Jun 2021 14:54:35 +0200 (CEST)
Date:   Wed, 9 Jun 2021 14:54:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
Message-ID: <20210609125435.GA68187@worktop.programming.kicks-ass.net>
References: <20210520183614.1227046-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Quoting random parts of the first few patches folded.

You present an API without explaining, *at*all*, how it's supposed to be
used and I can't seem to figure it out from the implementation either :/

> Index: linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
> ===================================================================
> --- linux-2.6.orig/arch/x86/entry/syscalls/syscall_64.tbl
> +++ linux-2.6/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -368,6 +368,17 @@
>  444	common	landlock_create_ruleset	sys_landlock_create_ruleset
>  445	common	landlock_add_rule	sys_landlock_add_rule
>  446	common	landlock_restrict_self	sys_landlock_restrict_self

> +447	common	umcg_api_version	sys_umcg_api_version
> +448	common	umcg_register_task	sys_umcg_register_task
> +449	common	umcg_unregister_task	sys_umcg_unregister_task

I think we can do away with the api_version thing and frob that in
register. Also, do we really need unregister over just letting a task
exit? Is there a sane use-case where task goes in and out of service?

> +450	common	umcg_wait		sys_umcg_wait
> +451	common	umcg_wake		sys_umcg_wake

Right, except I'm confused by the proposed implementation. I thought the
whole point was to let UMCG tasks block in kernel, at which point we'd
change their state to BLOCKED and have userspace select another task to
run. Such BLOCKED tasks would then also be captured before they return
to userspace, i.e. the whole admission scheduler thing.

I don't see any of that in these patches. So what are they actually
implementing? I can't find enough clues to tell :-(

> +452	common	umcg_swap		sys_umcg_swap

You're presenting it like a pure optimization, but IIRC this is what
enables us to frob the scheduler state to ensure the whole thing is seen
(to the rest of the system) as the M server tasks, instead of the
constellation of N+M worker and server tasks.

Also, you're not doing any of the frobbing required.

> +453	common	umcg_create_group	sys_umcg_create_group
> +454	common	umcg_destroy_group	sys_umcg_destroy_group

This is basically needed for cross-server things, right? What we in the
kernel would call SMP. Some thoughts on that below.

> +455	common	umcg_poll_worker	sys_umcg_poll_worker

Shouldn't this be called idle or something, instead of poll, the whole
point of having this syscall is to that you can indeed go idle.
Userspace can implement polling just fine without help:

	for (;;) {
		struct umcg_task *runnable = xchg(me->umcg_runnable_ptr, NULL);
		if (runnable) {
			// put them on a list and run one
		}
		cpu_relax();
	}

comes to mind (see below).

> +456	common	umcg_run_worker		sys_umcg_run_worker

This I'm confused about again.. there is no fundamental difference
between a worker or server, they're all the same. 

> +457	common	umcg_preempt_worker	sys_umcg_preempt_worker

And that's magic, we'll get to it..

> Index: linux-2.6/include/uapi/linux/umcg.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6/include/uapi/linux/umcg.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_UMCG_H
> +#define _UAPI_LINUX_UMCG_H
> +
> +#include <linux/limits.h>
> +#include <linux/types.h>
> +
> +/*
> + * UMCG task states, the first 8 bits.

All that needs a state transition diagram included

> + */
> +#define UMCG_TASK_NONE			0
> +/* UMCG server states. */
> +#define UMCG_TASK_POLLING		1
> +#define UMCG_TASK_SERVING		2
> +#define UMCG_TASK_PROCESSING		3

I get POLLING, although per the above, this probably wants to be IDLE.

What are the other two again? That is, along with the diagram, each
state wants a description.

> +/* UMCG worker states. */
> +#define UMCG_TASK_RUNNABLE		4
> +#define UMCG_TASK_RUNNING		5
> +#define UMCG_TASK_BLOCKED		6
> +#define UMCG_TASK_UNBLOCKED		7

Weird order, also I can't remember why we need the UNBLOCKED, isn't that
the same as the RUNNABLE, or did we want to distinguish the state were
we're no longer BLOCKED but the user scheduler hasn't yet put us on it's
ready queue (IOW, we're on the runnable_ptr list, see below).

> +
> +/* UMCG task state flags, bits 8-15 */
> +#define UMCG_TF_WAKEUP_QUEUED		(1 << 8)
> +
> +/*
> + * Unused at the moment flags reserved for features to be introduced
> + * in the near future.
> + */
> +#define UMCG_TF_PREEMPT_DISABLED	(1 << 9)
> +#define UMCG_TF_PREEMPTED		(1 << 10)
> +
> +#define UMCG_NOID	UINT_MAX
> +
> +/**
> + * struct umcg_task - controls the state of UMCG-enabled tasks.
> + *
> + * While at the moment only one field is present (@state), in future
> + * versions additional fields will be added, e.g. for the userspace to
> + * provide performance-improving hints and for the kernel to export sched
> + * stats.
> + *
> + * The struct is aligned at 32 bytes to ensure that even with future additions
> + * it fits into a single cache line.
> + */
> +struct umcg_task {
> +	/**
> +	 * @state: the current state of the UMCG task described by this struct.
> +	 *
> +	 * UMCG task state:
> +	 *   bits  0 -  7: task state;
> +	 *   bits  8 - 15: state flags;
> +	 *   bits 16 - 23: reserved; must be zeroes;
> +	 *   bits 24 - 31: for userspace use.
> +	 */
> +	uint32_t	state;
> +} __attribute((packed, aligned(4 * sizeof(uint64_t))));

So last time I really looked at this it looked something like this:

struct umcg_task {
        u32     umcg_status;            /* r/w */
        u32     umcg_server_tid;        /* r   */
        u32     umcg_next_tid;          /* r   */
        u32     __hole__;
        u64     umcg_blocked_ptr;       /*   w */
        u64     umcg_runnable_ptr;      /*   w */
};

(where r/w is from the kernel's pov)
(also see uapi/linux/rseq.h's ptr magic)

So a PF_UMCG_WORKER would be added to sched_submit_work()'s PF_*_WORKER
path to capture these tasks blocking. The umcg_sleeping() hook added
there would:

    put_user(BLOCKED, umcg_task->umcg_status);

    tid = get_user(umcg_task->next_tid);
    if (!tid)
	tid = get_user(umcg_task->umcg_server_tid);
    umcg_server = find_task(tid);

    /* append to blocked list */
    umcg_task->umcg_blocked_ptr = umcg_server->umcg_blocked_ptr;
    umcg_server->umcg_blocked_ptr = umcg_task;

    // with some user_cmpxchg() sprinkled on to make it an atomic single
    // linked list, we can borrow from futex_atomic_cmpxchg_inatomic().

    /* capture return to user */
    add_task_work(current, &current->umcg->task_work, TWA_RESUME);

    umcg_server->state = RUNNING;
    wake_up_process(umcg_server);

That task_work would, as the comment says, capture the return to user,
and do something like:

    put_user(RUNNABLE, umcg_task->umcg_status);

    tid = get_user(umcg_task->umcg_server_tid);
    umcg_server = find_task(tid);

    /* append to runable list */
    umcg_task->umcg_runnable_ptr = umcg_server->umcg_runnable_ptr;
    umcg_server->umcg_runnable_ptr = umcg_task;
    // same as above, this wants some user cmpxchg

    umcg_wait();

And for that we had something like:

void umcg_wait(void)
{
	u32 state;

	for (;;) {
		set_current_state(TASK_INTERRUPTIBLE);
		if (get_user(state, current->umcg->state))
			break;
		if (state == UMCG_RUNNING)
			break;
		if (signal_pending(current))
			break;
		schedule();
	}
	__set_current_state(TASK_RUNNING);
}

Which would wait until the userspace admission logic lets us rip by
setting state to RUNNING and prodding us with a sharp stick.


This all ensures that when a UMCG task goes to sleep, we mark ourselves
BLOCKED, we add ourselves to a user visible blocked list and wake the
owner of that blocked list.

We can either pre-select some task to run after us (next_tid) or it'll
pick the dedicated server task we're assigned to (server_tid).

Any time a task wakes up, it needs to check the blocked list and update
userspace ready queues and the sort, after which it can either run
things if it's a worker or pick another task to run if that's its work
(a server isn't special in this regard).

This was the absolute bare minimum, and I'm not seeing any of that here.
Nor an explanation of what there actually is :/


On top of this there's 'fun' questions about signals, ptrace and
umcg_preemption to be answered.

I think we want to allow signals to happen to UMCG RUNNABLE tasks, but
have them resume umcg_wait() on sigreturn.

I've not re-read the discussion with tglx on ptrace, he had some cute
corner cases IIRC.

The whole preemption thing should be doable with a task_work. Basically
check if the victim is RUNNING, send it TWA_SIGNAL to handle the task
work, the task_work would attempt a RUNNING->RUNNABLE (cmpxchg)
transition, success thereof needs to be propagated back to the syscall
and returned.

Adding preemption also means you have to deal with appending to
runnable_ptr list when the server isn't reaily available (most times).


Now on to those group things; they would basically replace the above
server_tid with a group/list of related server tasks, right? So why not
do so, litearlly:

struct umcg_task {
        u32     umcg_status;            /* r/w */
        u32     umcg_next_tid;          /* r   */
        u64     umcg_server_ptr;        /* r   */
        u64     umcg_blocked_ptr;       /*   w */
        u64     umcg_runnable_ptr;      /*   w */
};

Then have the kernel iterate the umcg_server_ptr list, looking for an
available (RUNNING or IDLE) server, also see the preemption point above.

This does, however, require a umcg_task to pid translation, which we've
so far avoided :/ OTOH it makes that grouping crud a user problem and we
can make the syscalls go away (and I that CRUI would like this better
too).

> +static int do_context_switch(struct task_struct *next)
> +{
> +	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
> +
> +	/*
> +	 * It is important to set_current_state(TASK_INTERRUPTIBLE) before
> +	 * waking @next, as @next may immediately try to wake current back
> +	 * (e.g. current is a server, @next is a worker that immediately
> +	 * blocks or waits), and this next wakeup must not be lost.
> +	 */
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	WRITE_ONCE(utd->in_wait, true);
> +
> +	if (!try_to_wake_up(next, TASK_NORMAL, WF_CURRENT_CPU))
> +		return -EAGAIN;
> +
> +	freezable_schedule();
> +
> +	WRITE_ONCE(utd->in_wait, false);
> +
> +	if (signal_pending(current))
> +		return -EINTR;
> +
> +	return 0;
> +}
> +
> +static int do_wait(void)
> +{
> +	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
> +
> +	if (!utd)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(utd->in_wait, true);
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +	freezable_schedule();
> +
> +	WRITE_ONCE(utd->in_wait, false);
> +
> +	if (signal_pending(current))
> +		return -EINTR;
> +
> +	return 0;
> +}

Both these are fundamentally buggered for not having a loop.

> +/**
> + * sys_umcg_wait - block the current task (if all condtions are met).
> + * @flags:         Reserved.
> + * @timeout:       The absolute timeout of the wait. Not supported yet.
> + *                 Must be NULL.
> + *
> + * Sleep until woken, interrupted, or @timeout expires.
> + *
> + * Return:
> + * 0           - Ok;
> + * -EFAULT     - failed to read struct umcg_task assigned to this task
> + *               via sys_umcg_register();
> + * -EAGAIN     - try again;
> + * -EINTR      - signal pending;
> + * -EOPNOTSUPP - @timeout != NULL (not supported yet).
> + * -EINVAL     - a parameter or a member of struct umcg_task has a wrong value.
> + */
> +SYSCALL_DEFINE2(umcg_wait, u32, flags,
> +		const struct __kernel_timespec __user *, timeout)

I despise timespec, tglx?

> +{
> +	struct umcg_task_data *utd;
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (timeout)
> +		return -EOPNOTSUPP;
> +
> +	rcu_read_lock();
> +	utd = rcu_dereference(current->umcg_task_data);
> +	if (!utd) {
> +		rcu_read_unlock();
> +		return -EINVAL;
> +	}
> +
> +	rcu_read_unlock();

What Jann said.

> +
> +	return do_wait();
> +}
> +
> +/**
> + * sys_umcg_wake - wake @next_tid task blocked in sys_umcg_wait.
> + * @flags:         Reserved.
> + * @next_tid:      The ID of the task to wake.
> + *
> + * Wake @next identified by @next_tid. @next must be either a UMCG core
> + * task or a UMCG worker task.
> + *
> + * Return:
> + * 0           - Ok;
> + * -EFAULT     - failed to read struct umcg_task assigned to next;
> + * -ESRCH      - @next_tid did not identify a task;
> + * -EAGAIN     - try again;
> + * -EINVAL     - a parameter or a member of next->umcg_task has a wrong value.
> + */
> +SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
> +{
> +	struct umcg_task_data *next_utd;
> +	struct task_struct *next;
> +	int ret = -EINVAL;
> +
> +	if (!next_tid)
> +		return -EINVAL;
> +	if (flags)
> +		return -EINVAL;
> +
> +	next = find_get_task_by_vpid(next_tid);
> +	if (!next)
> +		return -ESRCH;
> +
> +	rcu_read_lock();
> +	next_utd = rcu_dereference(next->umcg_task_data);
> +	if (!next_utd)
> +		goto out;
> +
> +	if (!READ_ONCE(next_utd->in_wait)) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}

I'm thining this might want to be a user cmpxchg from RUNNABLE->RUNNING.

You need to deal with concurrent wakeups.

> +
> +	ret = wake_up_process(next);
> +	put_task_struct(next);
> +	if (ret)
> +		ret = 0;
> +	else
> +		ret = -EAGAIN;
> +
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}



