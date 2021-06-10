Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B673A32A9
	for <lists+linux-api@lfdr.de>; Thu, 10 Jun 2021 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJSFF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Jun 2021 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJSFF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Jun 2021 14:05:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB76C061574;
        Thu, 10 Jun 2021 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m9ATLxPlJl1/+DOkY4vi71njcU2bvfBjngdSnUf1Ad0=; b=XR/uoGiKaXe5TQ78eTKMCdYyrb
        lcP7WUcoo86b5OO3BnqxucciJQlJK9wdfT1PNrXBNu0gh33xxSavHolVGyw/qoyljCHNKuD24NSRd
        l3r0iM2NBHc/gf7gUlk/a8navBJkVUQdEFcd9FBqZkGerPfqPCPzapdiH06xCI9ONruHjY+r2lG+d
        yT+WJ4p9an28ju+VR7HpZkVa+XyYXz1zzQCfhlYrBbMuS+Y222U7r7VNeq0ymZZVWriQp2/3/nLek
        MQVcb9NEvUPrZhLn3jMydZv5yyi6dDUHiDfYrp+KaVjtVCRtvayD0mJ2Y8HB6M1freKrXPOlxt5Ts
        CEZRqbxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrP0u-005aW6-Jt; Thu, 10 Jun 2021 18:02:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D9B13001E3;
        Thu, 10 Jun 2021 20:02:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 614F420811809; Thu, 10 Jun 2021 20:02:49 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:02:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
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
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
Message-ID: <YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net>
References: <20210520183614.1227046-1-posk@google.com>
 <20210609125435.GA68187@worktop.programming.kicks-ass.net>
 <CAPNVh5e6GoKdYztRvQRXxjuYGJK0yEDkDaBCp=i3nU9XwfDGSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5e6GoKdYztRvQRXxjuYGJK0yEDkDaBCp=i3nU9XwfDGSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 09, 2021 at 01:18:59PM -0700, Peter Oskolkov wrote:
> On Wed, Jun 9, 2021 at 5:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Finally, a high-level review - thanks a lot, Peter! My comments below,
> and two high-level "important questions" at the end of my reply (with
> some less important questions here and there).
> 
> [...]
> 
> > You present an API without explaining, *at*all*, how it's supposed to be
> > used and I can't seem to figure it out from the implementation either :/
> 
> I tried to explain it in the doc patch that I followed up with:
> https://lore.kernel.org/patchwork/cover/1433967/#1632328

Urgh, you write RST :-( That sorta helps, but I'm still unclear on a
number of things, more below.

> Or do you mean it more narrowly, i.e. I do not explain syscalls in
> detail? This assessment I agree with - my approach was/is to finalize
> the userpace API (libumcg) first, and make the userspace vs kernel
> decisions later.

Yeah, I couldn't figure out how to use the syscalls and thus how to
interpret their implementation. A little more in the way of comments
would've been helpful.

> For example, you wonder why there is no looping in umcg_wait
> (do_wait). This is because the looping happens in the userspace in
> libumcg. My overall approach was to make the syscalls as simple as
> possible and push extra logic to the userspace.

So a simple comment on the syscall that says:

  Userspace is expected to do:

	do {
		sys_umcg_wait();
	} while (smp_load_acquire(&umcg_task->state) != RUNNING);

would've made all the difference. It provides context.

> It seems that this approach is not resonating with kernel
> developers/maintainers - you are the third person asking why there is
> no looping in sys_umcg_wait, despite the fact that I explicitly
> mentioned pushing it out to the userspace.

We've been trained, through years of 'funny' bugs, to go 'BUG BUG BUG'
when schedule() is not in a loop. And pushing the loop to userspace has
me all on edge for being 'weird'.

> Let me try to make my case once more here.
> 
> umcg_wait/umcg_wake: the RUNNABLE/RUNNING state changes, checks, and
> looping happen in the userspace (libumcg - see umcg_wait/umcg_wake in
> patch 5 here: https://lore.kernel.org/patchwork/patch/1433971/), while
> the syscalls simply sleep/wake. I find doing it in the userspace is
> much simpler and easier than in the kernel, as state reads and writes
> are just atomic memory accesses; in the kernel it becomes much more
> difficult - rcu locked sections, tasks locked, etc.

Small difficulties as far as things go I think. The worst part is having
to do arch asm for the userspace cmpxchg. Luckily we can crib/share with
futex there.

> On the other hand I agree that having syscalls more logically
> complete, in the sense that they do not require much hand-holding and
> retries from the userspace, is probably better from the API design
> perspective. My worry here is that state validation and retries in the
> userspace are unavoidable, and so going the usual way we will end up
> with retry loops both in the kernel and in the userspace.

Can you expand on where you'd see the need for userspace to retry?

The canonical case in my mind is where a task, that's been BLOCKED in
kernelspace transitions to UNBLOCK/RUNNABLE in return-to-user and waits
for RUNNING.

Once it gets RUNNING, userspace can assume it can just go. It will never
have to re-check, because there's no way RUNNING can go away again. The
only way for RUNNING to become anything else, is setting it yourself
and/or doing a syscall.

Also, by having the BLOCKED thing block properly in return-to-user, you
don't have to wrap *all* the userspace syscall invocations. If you let
it return early, you get to wrap syscalls, which is both fragile and
bad for performance.

> So I pose this IMPORTANT QUESTION #1 to you that I hope to get a clear
> answer to: it is strongly preferable to have syscalls be "logically
> complete" in the sense that they retry things internally, and in
> generally try to cover all possible corner cases; or, alternatively,
> is it OK to make syscalls lightweight but "logically incomplete", and
> have the accompanied userspace wrappers do all of the heavy lifting
> re: state changes/validation, retries, etc.?

Intuitively I'd go with complete. I'd have never even considered the
incomplete option. But let me try and get my head around the incomplete
cases.

Oooh, I found the BLOCKED stuff, you hid it inside the grouping patch,
that makes no sense :-( Reason I'm looking is that I don't see how you
get around the blocked and runnable lists. You have to tell userspace
about them.

FWIW: I think you placed umcg_on_block() wrong, it needs to be before
the terrible PI thing. Also, like said, please avoid yet another branch
here by using PF_UMCG_WORKER.

> I see two additional benefits of thin/lightweight syscalls:
> - reading userspace state is needed much less often (e.g. my umcg_wait
> and umcg_wake syscalls do not access userspace data at all - also see
> my "second important question" below)

It is also broken I think, best I can make of it is somsething like
this:

    WAIT						WAKE

    if (smp_load_acquire(&state) == RUNNING)
	return;

							state = RUNNING;


    do {
      sys_umcg_wait()
      {
	in_wait = true;
							sys_umcg_wake()
							{
							  if (in_wait)
							    wake_up_process()
							}
	set_current_state(INTERRUPTIBLE);
	schedule();
	in_wait = false;
      }
    } while (smp_load_acquire(&state) != RUNNING);


missed wakeup, 'forever' stuck. You have to check your blocking
condition between setting state and scheduling. And if you do that, you
have a 'fat' syscall again.

> - looping in the kernel, combined with reading/writing to userspace
> memory, can easily lead to spinning in the kernel (e.g. trying to
> atomically change a variable and looping until succeeding)

I don't imagine spinning in kernel or userspace matters.

> > Also, do we really need unregister over just letting a task
> > exit? Is there a sane use-case where task goes in and out of service?
> 
> I do not know of a specific use case here. On the other hand, I do not
> know of a specific use case to unregister RSEQ, but the capability is
> there. Maybe the assumption is that the userspace memory passed to the
> kernel in register() may be freed before the task exits, and so there
> should be a way to tell the kernel to no longer use it?

Fair enough I suppose.

> >
> > > +450  common  umcg_wait               sys_umcg_wait
> > > +451  common  umcg_wake               sys_umcg_wake
> >
> > Right, except I'm confused by the proposed implementation. I thought the
> > whole point was to let UMCG tasks block in kernel, at which point we'd
> > change their state to BLOCKED and have userspace select another task to
> > run. Such BLOCKED tasks would then also be captured before they return
> > to userspace, i.e. the whole admission scheduler thing.
> >
> > I don't see any of that in these patches. So what are they actually
> > implementing? I can't find enough clues to tell :-(
> 
> As I mentioned above, state changes are done in libumcg in userspace
> here: https://lore.kernel.org/patchwork/cover/1433967/#1632328
> 
> If you insist this logic should live in the kernel, I'll do it (grudgingly).

So you have some of it, I just didn't find it because it's hidding in
that grouping thing.

> > > +452  common  umcg_swap               sys_umcg_swap
> >
> > You're presenting it like a pure optimization, but IIRC this is what
> > enables us to frob the scheduler state to ensure the whole thing is seen
> > (to the rest of the system) as the M server tasks, instead of the
> > constellation of N+M worker and server tasks.
> 
> Yes, you recall it correctly.
> 
> > Also, you're not doing any of the frobbing required.
> 
> This is because I consider the frobbing a (very) nice to have rather
> than a required feature, and so I am hoping to argue about how to
> properly do it in later patchsets. This whole thing (UMCG) will be
> extremely useful even without runtime accounting hacking and whatnot,
> and so I hope to have everything else settled and tested and merged
> before we spend another several weeks/months trying to make the
> frobbing perfect.

Sure, not saying you need the frobbing from the get-go, but it's a much
stronger argument for having the API in the first place. So mentioning
this property (along with a TODO) is a stronger justification.

This goes to *why again. It's fairly easy to see what from the code, but
code rarely explains why.

That said; if we do: @next_pid, we might be able to do away with this. A
!RUNING transition will attempt to wake-and-switch to @next_tid. This is
BLOCKED from syscall or explicit using umcg_wait().

> > > +455  common  umcg_poll_worker        sys_umcg_poll_worker
> >
> > Shouldn't this be called idle or something, instead of poll, the whole
> > point of having this syscall is to that you can indeed go idle.
> 
> That's another way of looking at it. Yes, this means the server idles
> until a worker becomes available. How would you call it? umcg_idle()?

I'm trying to digest the thing; it's doing *far* more than just idling,
but yes, sys_umcg_idle() or something.

> > This I'm confused about again.. there is no fundamental difference
> > between a worker or server, they're all the same.
> 
> I don't see it this way. A server runs (on CPU) by itself and blocks
> when there is a worker attached; a worker runs (on CPU) only when it
> has a (blocked) server attached to it and, when the worker blocks, its
> server detaches and runs another worker. So workers and servers are
> the opposite of each other.

So I was viewing the server more like the idle thread, its 'work' is
idle, which is always available.

> > > + */
> > > +#define UMCG_TASK_NONE                       0
> > > +/* UMCG server states. */
> > > +#define UMCG_TASK_POLLING            1
> > > +#define UMCG_TASK_SERVING            2
> > > +#define UMCG_TASK_PROCESSING         3
> >
> > I get POLLING, although per the above, this probably wants to be IDLE.
> 
> Ack.
> 
> >
> > What are the other two again? That is, along with the diagram, each
> > state wants a description.
> 
> SERVING: the server is blocked, its attached worker is running
> PROCESSING: the server is running (= processing a block or wake
> event), has no running worker attached
> 
> Both of these states are different from POLLING/IDLE and from each other.

But if we view the server as the worker with work 'idle', then serving
becomes RUNNABLE and PROCESSING becomes RUNNING, right?

And sys_run_worker(next); becomes:

	self->state = RUNNABLE;
	self->next_tid = next;
	sys_umcg_wait();

The question is if we need an explicit IDLE state along with calling
sys_umcg_idle(). I can't seem to make up my mind on that.

> > > +/* UMCG worker states. */
> > > +#define UMCG_TASK_RUNNABLE           4
> > > +#define UMCG_TASK_RUNNING            5
> > > +#define UMCG_TASK_BLOCKED            6
> > > +#define UMCG_TASK_UNBLOCKED          7
> >
> > Weird order, also I can't remember why we need the UNBLOCKED, isn't that
> > the same as the RUNNABLE, or did we want to distinguish the state were
> > we're no longer BLOCKED but the user scheduler hasn't yet put us on it's
> > ready queue (IOW, we're on the runnable_ptr list, see below).
> 
> Yes, UNBLOCKED it a transitory state meaning the worker's blocking
> operation has completed, but the wake event hasn't been delivered to
> the userspace yet (and so the worker it not yet RUNNABLE)

So if I understand the proposal correctly the only possible option is
something like:

	for (;;) {
		next = user_sched_pick();
		if (next) {
			sys_umcg_run(next);
			continue;
		}

		sys_umcg_poll(&next);
		if (next) {
			next->state = RUNNABLE;
			user_sched_enqueue(next);
		}
	}

This seems incapable of implementing generic scheduling policies and has
a hard-coded FIFO policy.

The poll() thing cannot differentiate between: 'find new task' and 'go
idle'. So you cannot keep running it until all new tasks are found.

But you basically get to do a syscall to discover every new task, while
the other proposal gets you a user visible list of new tasks, no
syscalls needed at all.

It's also not quite clear to me what you do about RUNNING->BLOCKED, how
does the userspace scheduler know to dequeue a task?


My proposal gets you something like:

	for (;;) {
		self->state = RUNNABLE;
		self->next_tid = 0; // next == self == server -> idle

		p = xchg(self->blocked_ptr, NULL);
		while (p) {
			n = new->blocked_ptr;
			user_sched_dequeue(p);
			p = n;
		}

		// Worker can have unblocked again before we got here,
		// hence we need to process blocked before runnable.
		// Worker cannot have blocked again, since we didn't
		// know it was runnable, hence it cannot have ran again.

		p = xchg(self->runnable_ptr, NULL);
		while (p) {
			n = new->runnable_ptr;
			user_sched_enqeue(p);
			p = n;
		}

		n = user_sched_pick();
		if (n)
			self->next_tid = n->tid;

		// new self->*_ptr state will have changed self->state
		// to RUNNING and we'll not switch to ->next.

		sys_umcg_wait();

		// self->state == RUNNING
	}

This allows you to implement arbitrary policies and instantly works with
preemption once we implement that. Preemption would put the running
worker in RUNNABLE, mark the server RUNNING and switch.

Hmm, looking at it written out like that, we don't need sys_umcg_wake(),
sys_umcg_swap() at all.

Anyway, and this is how I got here, UNBLOCKED is not required because we
cannot run it before we've observed it RUNNABLE. Yes the state exists
where it's no longer BLOCKED, and it's not yet on the runqueue, but when
we don't know it's RUNNABLE we'll not pick it, so its moot.

> > So last time I really looked at this it looked something like this:
> >
> > struct umcg_task {
> >         u32     umcg_status;            /* r/w */
> >         u32     umcg_server_tid;        /* r   */
> >         u32     umcg_next_tid;          /* r   */
> >         u32     __hole__;
> >         u64     umcg_blocked_ptr;       /*   w */
> >         u64     umcg_runnable_ptr;      /*   w */
> > };
> >
> > (where r/w is from the kernel's pov)
> > (also see uapi/linux/rseq.h's ptr magic)
> 
> I tried doing it this way, i.e. to only have only userspace struct
> added (without kernel-only data), and I found it really cumbersome and
> inconvenient and much slower than the proposed implementation.

> For example, when a worker blocks, it seems working with "struct
> task_struct *peer" to get to the worker's server is easy and
> straightforward; reading server_tid from userspace, then looking up
> the task and only then doing what is needed (change state and wakeup)
> is ... unnecessary? 

Is find_task_by_vpid() really that slow? The advantage of having it in
userspace is that you can very easily change 'affinities' of the
workers. You can simply set ->server_tid and it goes elsewhere.

> Also validating things becomes really important
> but difficult (what if the user put something weird in
> umcg_server_tid? or the ptr fields?).

If find_task_by_vpid() returns NULL, we return -ESRCH. If the user
cmpxchg returns -EFAULT we pass along the message. If userspace put a
valid but crap pointer in it, userspace gets to keep the pieces.

> In my proposed implementation only the state is user-writable, and it
> does not really affect most of the kernel-side work.
> 
> Why do you think everything should be in the userspace memory?

Because then we avoid all the kernel state and userspace gets to have
all the state without endless syscalls.

Note that with the proposal, per the above, we're at:

enum {
	UMCG_STATE_RUNNING,
	UMCG_STATE_RUNABLE,
	UMCG_STATE_BLOCKED,
};

struct umcg_task {
        u32     umcg_status;            /* r/w */
        u32     umcg_server_tid;        /* r   */
        u32     umcg_next_tid;          /* r   */
        u32     umcg_tid;		/* r   */
        u64     umcg_blocked_ptr;       /*   w */
        u64     umcg_runnable_ptr;      /*   w */
};

/*
 * Register current's UMCG state.
 */
sys_umcg_register(struct umcg_task *self, unsigned int flags);

/*
 * Just 'cause.
 */
sys_umcg_unregister(struct umcg_task *self)

/*
 * UMCG context switch.
 */
sys_umcg_wait(u64 time, unsigned int flags)
{
	unsigned int state = RUNNABLE;
	unsigned int tid;

	if (self->state == RUNNING)
		return;

	tid = self->next_tid;
	if (!tid)
		tid = self->server_tid;

	if (tid == self->server_tid && tid == self->tid)
		return umcg_idle(time, flags);

	next = find_process_by_pid(tid);
	if (!next) {
		return -ESRCH;

	ret = user_try_cmpxchg(next->umcg->state, &state, RUNNING);
	if (!ret)
		ret = -EBUSY;
	if (ret < 0)
		return ret;

	return umcg_switch_to(next);
}

With this (and the BLOCKING bits outlined last time) we can implement
full N:1 userspace scheduling (UP).

( Note that so far we assume all UMCG workers share the same address
  space, otherwise the user_try_cmpxchg() doesn't work. )

And I _think_ you can do the whole SMP thing in userspace as well, just
have the servers share queue state and reassign ->server_tid where
needed. No additional syscalls required.

> All of the code above assumes userspace-only data. I did not look into
> every detail of your suggestions because I want to make sure we first
> agree on this: do we keep every bit of information in the userspace
> (other than "struct umcg_task __user *" pointer in task_struct) or do
> we have some kernel-only details as well?

Most of the kernel state you seem to have implemented seems to limit
flexibility / implement specific policy. All because apparently
find_task_by_vpid() is considered expensive?

You've enangled the whole BLOCKING stuff with the SMP stuff. And by
putting that state in the kernel you've limited flexibility.

Also, if you don't have kernel state it can't go out of sync and cause
problems.

> So IMPORTANT QUESTION #2: why would we want to keep __everything__ in
> the userspace memory? I understand that CRIU would like this, but
> given that the implementation would at a minimum have to
> 
> 1. read a umcg_server_ptr (points to the server's umcg_task)
> 2. get the server tid out of it (presumably by reading a field from
> the server's umcg_task; what if the tid is wrong?)
> 3. do a tid lookup

So if we leave SMP as an exercise in scheduling queue management, And
implement the above, then you need:

 - copy_from_user()/get_user() for the first 4 words
 - find_task_by_vpid()

that gets you a task pointer, then we get to update a blocked_ptr.

If anything goes wrong, simply return an error and let userspace sort it
out.

> to get a task_struct pointer, it will be slower; I am also not sure it
> call be done safely at all: with kernel-side data and I can do rcu
> locking, task locking, etc. to ensure that the value I got does not
> change while I'm working with it; with userspace data, a lot of races
> will have to be specially coded for that can be easily handled by
> kernel-side rcu locks or spin locks... Maybe this is just my ignorance
> showing, and indeed things can be done simply and easily with
> userspace-only data, but I am not sure how.
> 
> A common example:
> 
> - worker W1 with server S1 calls umcg_wait()
> - worker W2 with server S2 calls umcg_swap(W1)
> 
> If due to preemption and other concurrency weirdness the two syscalls
> above race with each other, each trying to change the server assigned
> to W1. I can easily handle the race by doing kernel-side locking;
> without kernel-side locking (cannot do rcu locks and/or spin locks
> while accessing userspace data) I am not sure how to handle the race.
> Maybe it is possible with careful atomic writes to states and looping
> to handle this specific race (what if the userspace antagonistically
> writes to the same location? will it force the syscall to spin
> indefinitely?); but with proper locking many potential races can be
> handled; with atomic ops and looping it is more difficult... Will we
> have to add a lock to struct umcg_task? And acquire it from the kernel
> side? And worry about spinning forever?

What would you want locking for? I really don't see a problem here.

Both blocked_ptr and runnable_ptr are cmpxchg single-linked-lists. Yes
they can spin a little, but that's not a new problem, futex has all
that.

And ->state only needs single cmpxchg ops, no loops, either we got the
wakeup, or we didn't. The rest is done with memory ordering:


	server				worker

	self->state = RUNNABLE;		self->state = BLOCKED;

	head = xchg(list, NULL)		add_to_list(self, &server->blocked_ptr);

					if (try_cmpxchg_user(&server->umcg->state, RUNNABLE, RUNNING) > 0)
	sys_umcg_wait()				wake_up_process(server);


Either server sees the add, or we see it's RUNNABLE and wake it up
(or both).

If anything on the BLOCKED side goes wrong (bad pointers, whatever),
have it segfault.

<edit> Ooh, I forgot you can't just go wake the server when it's running
something else... so that does indeed need more states/complication, the
ordering argument stands though. We'll need something like
self->current_tid or somesuch </edit>


> > > +SYSCALL_DEFINE2(umcg_wait, u32, flags,
> > > +             const struct __kernel_timespec __user *, timeout)
> >
> > I despise timespec, tglx?
> 
> What are the alternatives? I just picked what the futex code uses.

u64 nanoseconds. Not sure tglx really wants to do that though, but
still, timespec is a terrible thing.

> In summary, two IMPORTANT QUESTIONS:
> 
> 1. thin vs fat syscalls: can we push some code/logic to the userspace
> (state changes, looping/retries), or do we insist on syscalls handling
> everything? 

Well, the way I see it it's a trade of what is handled where. I get a
smaller API (although I'm sure I've forgotten something trivial again
that wrecks everything <edit> I did :/ </edit>) and userspace gets to
deal with all of SMP and scheduling policies.

You hard-coded a global-fifo and had a enormous number of syscalls and
needed to wrap every syscall invocation in order to fix up the return.

> Please have in mind that even if we choose the second
> approach (fat syscalls), the userspace will most likely still have to
> do everything it does under the first option just to handle
> signals/interrupts (i.e. unscheduled wakeups);

IIRC sigreturn goes back into the kernel and we can resume blocking
there.

> 2. kernel-side data vs userspace-only: can we avoid having kernel-side
> data? More specifically, what alternatives to rcu_read_lock and/or
> task_lock are available when working with userspace data?

What would you want locked and why?


Anyway, this email is far too long again (basically took me all day :/),
hope it helps a bit. Thomas is stuck fixing XSAVE disasters, but I'll
ask him to chime in once that's done.


