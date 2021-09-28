Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052A441B7E1
	for <lists+linux-api@lfdr.de>; Tue, 28 Sep 2021 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbhI1UCY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Sep 2021 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242593AbhI1UCX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Sep 2021 16:02:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE0C06161C;
        Tue, 28 Sep 2021 13:00:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632859241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7e/QL1SpcLLIiSjaCP7hCUsjIQqSLXxLXSn+s1HLR0=;
        b=qrrDYwtMqfYfSlrEZshrqamhhneYMkL5HOJWzOEINdVZw1wlzriW3L5BlMwVing1IagUSc
        PVRuFzd99C8Bn1l/BCdqMvuDvoXR44K3j/QZ1LHsH4PeD+kyKmK/rROU4i7gENxfvmAsJx
        exLpOHT60xcf/blr1WRv8ZI5UxBluQWgPsMBrvld5b+30oliqY07hUfMNz0oemFnn6Exon
        SHuiLAAk2D4oqUV+otqe1rO3D2ZBYe4r0cXqGDXqOZ8zVyddfdA988Keq/kS1gM9QE5zrt
        x4DRRijzgyWBwiWj2JxKw5Dxc7+k6zPsjXbBh0F06f+P7KK1PBgod9nt0Xc4LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632859241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7e/QL1SpcLLIiSjaCP7hCUsjIQqSLXxLXSn+s1HLR0=;
        b=CTRXym9cjzJ0XEMNvPypvEgu1rtkDDIAWUy4WmrbCbAxq7L4ELtLOPRWKraRue8s4QA0NK
        Gt/NYcgF80PVm+Aw==
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH 3/5 v0.6] sched/umcg: RFC: implement UMCG syscalls
In-Reply-To: <CAFTs51V7QTt3pjfHJ8MSxCgdnTz_5J3Dp8VLt6aGpE0WeB09tA@mail.gmail.com>
References: <20210917180323.278250-4-posk@google.com> <874ka5awdp.ffs@tglx>
 <CAFTs51V7QTt3pjfHJ8MSxCgdnTz_5J3Dp8VLt6aGpE0WeB09tA@mail.gmail.com>
Date:   Tue, 28 Sep 2021 22:00:40 +0200
Message-ID: <87mtnwa2s7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter,

On Tue, Sep 28 2021 at 10:26, Peter Oskolkov wrote:
> On Tue, Sep 28, 2021 at 2:21 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Fri, Sep 17 2021 at 11:03, Peter Oskolkov wrote:
>>
>> What's the rationale for that? Why is that needed and desired?
>
> In short, workqueue functions (sched_submit_work, sched_update_worker)
> can be called with mm lock held, and so we cannot fixup pagefaults
> inline; so we need to pin struct umcg_task pages temporarily. On the
> wakeup path I elide this by setting TF_NOTIFY_RESUME flag and doing
> everything later in return-to-usermode-loop in a sleepable context; on
> the sched_submit_work (going to sleep) path, we need to access the
> userspace to wake up the server, but this is a "nosleep" context, so
> the pages have to be pinned.

Fair enough. That's the kind of information which belongs into the
change log. But this wants also be documented in the code, e.g. in the
comment above umcg_pin_pages(). You'll be happy to have it there when
you are forced to stare at that code 3 month after it got merged.

>> > diff --git a/kernel/exit.c b/kernel/exit.c
>> > index fd1c04193e18..fdd4e923cca9 100644
>> > --- a/kernel/exit.c
>> > +++ b/kernel/exit.c
>> > @@ -744,6 +744,8 @@ void __noreturn do_exit(long code)
>> >       if (unlikely(!tsk->pid))
>> >               panic("Attempted to kill the idle task!");
>> >
>> > +     umcg_handle_exit();
>>
>> Why is this invoked _before_ the oops fixup? How is that correct in the
>> oops case?
>
> umcg_handle_exit() is just unpinning pinned pages, assigning NULL to a
> couple of pointers, and clearing PF_UMCG_WORKER flag, so I assumed
> doing it as early as possible is the best way to avoid unnecessarily
> triggering workqueue callbacks. Is my logic wrong? (UMCG tasks should
> unregister before exiting; if they do, umcg_handle_exit() is a NOOP;
> but if they did not unregister, umcg_handle_exit() just makes sure no
> pinned pages are left over).

Look at the comment right below where you placed that call.

"Just unpinning" calls into a boatload of code in mm and you really want
to do that _after_ all sanity checks and fixups and before exit_mm(). 

It really does not matter much where exactly and I have no idea which
workqueue callbacks you are worried about. The code after the fixup is
fully preemptible (in theory).

>> > +
>> > +     if (prev_state & UMCG_TF_LOCKED)
>> > +             return;
>> > +
>> > +     if ((prev_state & UMCG_TASK_STATE_MASK) != UMCG_TASK_RUNNING)
>> > +             return;  /* the worker is in umcg_wait */
>>
>> So if the worker is in umcg_wait() then why is it reaching this place at
>> all? The current task surely knows that it comes here from umcg_wait(),
>> right?
>
> This place is on the "worker goes to sleep" path (sched_submit_work).
> umcg_wait() puts the worker to sleep, so this place is triggered. I
> can remove PF_UMCG_WORKER in umcg_wait() to elide this if you think
> this would be better. I'll try that in the next patchset version.

I was just wondering about that as it seemed strange to me that a task
which invoked umcg_wait() has to inspect it's own user space state to
figure out that it comes from umcg_wait(). There might be a reason for
this, but if not then avoiding this pointless exercise completely is
definitely not the worst idea.

>> > +     /* The idle server's wait may timeout. */
>> > +     /* TODO: make a smarter context switch below when available. */
>>
>> Neither those make any sense to me.
>>
>> > +     if (mark_server_running(server_tid, false))
>> > +             umcg_ttwu(server_tid, WF_CURRENT_CPU);
>>
>> Well, after looking at both functions I can see why this wants to be
>> smarter. Doing the vpid lookup twice instead of once is certainly not
>> the smartest solution.
>
> I'll do some refactoring to avoid extra vpid lookups. The comment,
> though, hints at a "smarter context switch" that is more than just
> "ttwu the server and put the worker to sleep".

These TODOs are not really helpful at the moment. Let's get the straight
forward version to work first. Enhancing this is an orthogonal issue.

>> And if this is not called with preemption disabled then none of these
>> misnomed _nosleep() accessors are needed and the code can be simplified.
>
> We still need to work with pinned pages, as described above - mm lock
> can be held here. How would you prefer these accessors to be named
> other than "_nosleep()"? Maybe "_nofixup()"?

nofixup() would be weird because the actual access uses an exception
fixup :)

If you look at mm/maccess.c you might notice that we already have such
functions, e.g. copy_from_user_nofault(). Pretty obvious name that.

I'll reply to that patch separately as the approach taken there needs
more than a quick name change.

>> > +static int umcg_ttwu(u32 next_tid, int wake_flags)
>> > +{
>> > +     struct task_struct *next;
>> > +
>> > +     rcu_read_lock();
>> > +     next = find_task_by_vpid(next_tid);
>> > +     if (!next || !(READ_ONCE(next->umcg_task))) {
>> > +             rcu_read_unlock();
>> > +             return -ESRCH;
>> > +     }
>> > +
>> > +     /* Note: next does not necessarily share mm with current. */
>>
>> Which is irrelevant, but what's relevant is that there is absolutely no
>> sanity check of next_tid. So this just wakes up what ever TID user space
>> writes into the user space task memory. Anything copmeing from user
>> space cannot be trusted and needs to be validated. find_task_by_vpid()
>> is not sufficient for that.
>
> Well, next_tid must point to a task registered with UMCG, and this is
> checked above. I'm not sure what other validation is appropriate here.
> What kind of sanity checks are needed? The worst thing that can happen
> is a spurious wakeup, which is supposedly something that can happen
> anyway and is not a major concern?

A spurious wakeup which is caused by a race in the kernel is definitely
not unexpected and inevitable.

User controlled targeted wakeups at random threads are not really the
same category. There is a reason why you can't send signals to random
processes/tasks. 

Whether you like it or not, _any_ user supplied value which is used to
cause a directed action of the kernel has to be considered malicious
unless you can explain coherently why there is absolutely no risk.

> Well, next_tid must point to a task registered with UMCG ...

is not really sufficient. All it tells us is that it is a task which has
a umcg pointer. Not more not less. It does not answer the following
questions:

 - Is it a task which is related to the same UMCG entity?
 - Does it belong to the same user/group or whatever?
 - ...

You might want to talk to Kees Cook about that.

>> > +     rcu_read_lock();
>> > +     tsk = find_task_by_vpid(server_tid);
>> > +     if (tsk)
>> > +             ut_server = READ_ONCE(tsk->umcg_task);
>> > +     rcu_read_unlock();
>> > +
>> > +     if (!ut_server)
>> > +             return false;
>> > +
>> > +     if (READ_ONCE(current->mm) != READ_ONCE(tsk->mm))
>> > +             return false;
>>
>> This is broken because it's outside the rcu read side critical section
>> so @tsk can be gone already. Also this lacks a check whether @tsk is a
>> kthread because kthreads can use a user mm temporarily.
>
> I don't think kthreads can have tsk->umcg_task set, so the function
> will return earlier. I'll move the check under rcu.

Indeed, you are right. This stuff is just hard to read.

	rcu_read_lock();
	tsk = find_task_by_vpid(server_tid);

        /*
         * Validate that the task is associated with UMCG and
         * has the same mm because $RAISINS...
         */
        if (tsk && tsk->umcg_task && current->mm == tsk->mm) {
            ...
            do_stuff(tsk);
	    ...
        }
        rcu_read_unlock();

>> Also what's the purpose of these undocumented READ_ONCE() instances?
>
> While ttwu can be called cross-mm, anything more involved, such as
> changing the server's UMCG state, requires the remote task to belong
> to the same process, and this is what the check validates. I'll add
> that comment to the code.

But that has nothing to do with my question:

  >> Also what's the purpose of these undocumented READ_ONCE() instances?

READ_ONCE(current->mm) is pointless. current->mm cannot change while
current is evaluating it. READ_ONCE(tsk->mm) does not provide any value
either.

READ_ONCE() is a clear indicator for dealing with concurrency and we
expect a corresponding WRITE_ONCE() and a comment explaining what this
is about.

Sprinkling READ_ONCE() around the code is absolutely not helpful.

If you are unsure about the usage of this, please ask your colleagues or
on the mailing list upfront instead of letting reviewers scratch their
heads.

Btw, the same problems exist all over the place and there is quite some
duplicated code which is wrong except for one instance. Can you please
make that:

find_umcg_task(tid)
{
	tsk = find_task_by_vpid(tid);

        /*
         * Validate that the task is associated with UMCG and
         * has the same mm because $RAISINS...
         */
        if (tsk && tsk->umcg_task && current->mm == tsk->mm)
        	return tsk;

        return NULL:
}

and at the callsites:

    rcu_read_lock();
    tsk = find_umcg_task(tid);
    if (tsk)
       do_stuff(tsk);
    rcu_read_unlock();

Hmm? 

Thanks,

        tglx
