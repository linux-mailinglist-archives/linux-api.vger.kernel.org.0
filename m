Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABC447AA0
	for <lists+linux-api@lfdr.de>; Mon,  8 Nov 2021 07:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhKHG7j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Nov 2021 01:59:39 -0500
Received: from out2.migadu.com ([188.165.223.204]:17132 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236168AbhKHG7i (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 8 Nov 2021 01:59:38 -0500
Date:   Mon, 8 Nov 2021 14:57:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636354613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQbmR1jcqvCuL03TSf5CWqZohB7XsDdyWdjXB2Dny1k=;
        b=lO14FLeKWK5O+gFiCixgy4SySNPk9B8XwXXOceG7THtu3vjx2BmuTRi7nchx/FqCG4fpDQ
        X10Yr/NceMn0Hg6CKyUg5Gt1aQaWifadewGQ8dKCJqS2/SBgK6V+RW8z5z1CN4NYdyBPCu
        VWww6e4Nif4FMD+FHsF7vLCkH0EejS0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Oskolkov <posk@posk.io>
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
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YYjJ4m8WvHwKCCTx@geo.homenetwork>
References: <20211104195804.83240-1-posk@google.com>
 <20211104195804.83240-4-posk@google.com>
 <YYa5WjXTrhYKmoze@geo.homenetwork>
 <CAFTs51UD_gCFRWe8+14WG3nALQNRdoa322Wcr=RUPbSOpOf6qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51UD_gCFRWe8+14WG3nALQNRdoa322Wcr=RUPbSOpOf6qQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Nov 07, 2021 at 10:26:34AM -0800, Peter Oskolkov wrote:

> On Sat, Nov 6, 2021 at 10:19 AM Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > Hi Peter,
> >
> > On Thu, Nov 04, 2021 at 12:58:01PM -0700, Peter Oskolkov wrote:
> >
> > > +/**
> > > + * umcg_update_state: atomically update umcg_task.state_ts, set new timestamp.
> > > + * @state_ts   - points to the state_ts member of struct umcg_task to update;
> > > + * @expected   - the expected value of state_ts, including the timestamp;
> > > + * @desired    - the desired value of state_ts, state part only;
> > > + * @may_fault  - whether to use normal or _nofault cmpxchg.
> > > + *
> > > + * The function is basically cmpxchg(state_ts, expected, desired), with extra
> > > + * code to set the timestamp in @desired.
> > > + */
> > > +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
> > > +                             bool may_fault)
> > > +{
> > > +     u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> > > +     u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
> > > +
> > > +     /* Cut higher order bits. */
> > > +     next_ts &= UMCG_TASK_STATE_MASK_FULL;
> >
> > next_ts &= (1 << UMCG_STATE_TIMESTAMP_BITS) - 1; or am I wrong.
> 
> Right, thanks. I'll fix it in the next patchset version, if any. But
> at the moment I don't think this is bad enough to prevent merging, if
> the maintainers feel like it - basically, the condition below will
> always be false, so if the state is updated within 16 nanoseconds, the
> timestamps may sometimes match. For this to be an issue, this should
> result in ABA updates, so two state changes should happen in 16
> nanoseconds, which is extremely unlikely (impossible?), as most state

The task state occupy 0-5 bits and use 2 bits(00, 01, 10, 11) to denote
NONE, RUNNING, IDLE, BLOCK. Is it possible to grasp 4 bits from here to 
used to extend the timestamp resolution.

> changes are accompanied by other atomic ops.
> 
> >
> > > +     if (next_ts == curr_ts)
> > > +             ++next_ts;
> > > +
> > > +     /* Remove an old timestamp, if any. */
> > > +     desired &= UMCG_TASK_STATE_MASK_FULL;
> > > +
> > > +     /* Set the new timestamp. */
> > > +     desired |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
> > > +
> > > +     if (may_fault)
> > > +             return cmpxchg_user_64(state_ts, expected, desired);
> > > +
> > > +     return cmpxchg_user_64_nofault(state_ts, expected, desired);
> > > +}
> > > +
> > > +/**
> > > + * sys_umcg_ctl: (un)register the current task as a UMCG task.
> > > + * @flags:       ORed values from enum umcg_ctl_flag; see below;
> > > + * @self:        a pointer to struct umcg_task that describes this
> > > + *               task and governs the behavior of sys_umcg_wait if
> > > + *               registering; must be NULL if unregistering.
> > > + *
> > > + * @flags & UMCG_CTL_REGISTER: register a UMCG task:
> > > + *         UMCG workers:
> > > + *              - @flags & UMCG_CTL_WORKER
> > > + *              - self->state must be UMCG_TASK_BLOCKED
> > > + *         UMCG servers:
> > > + *              - !(@flags & UMCG_CTL_WORKER)
> > > + *              - self->state must be UMCG_TASK_RUNNING
> > > + *
> > > + *         All tasks:
> > > + *              - self->next_tid must be zero
> > > + *
> > > + *         If the conditions above are met, sys_umcg_ctl() immediately returns
> > > + *         if the registered task is a server; a worker will be added to
> > > + *         idle_workers_ptr, and the worker put to sleep; an idle server
> > > + *         from idle_server_tid_ptr will be woken, if present.
> > > + *
> > > + * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
> > > + *           is a UMCG worker, the userspace is responsible for waking its
> > > + *           server (before or after calling sys_umcg_ctl).
> > > + *
> > > + * Return:
> > > + * 0                - success
> > > + * -EFAULT          - failed to read @self
> > > + * -EINVAL          - some other error occurred
> > > + */
> > > +SYSCALL_DEFINE2(umcg_ctl, u32, flags, struct umcg_task __user *, self)
> > > +{
> > > +     struct umcg_task ut;
> > > +
> > > +     if (flags == UMCG_CTL_UNREGISTER) {
> > > +             if (self || !current->umcg_task)
> > > +                     return -EINVAL;
> > > +
> > > +             if (current->flags & PF_UMCG_WORKER)
> > > +                     umcg_handle_exiting_worker();
> > > +             else
> > > +                     umcg_clear_task(current);
> > > +
> > > +             return 0;
> > > +     }
> > > +
> > > +     if (!(flags & UMCG_CTL_REGISTER))
> > > +             return -EINVAL;
> > > +
> > > +     flags &= ~UMCG_CTL_REGISTER;
> > > +     if (flags && flags != UMCG_CTL_WORKER)
> > > +             return -EINVAL;
> > > +
> > > +     if (current->umcg_task || !self)
> > > +             return -EINVAL;
> > > +
> > > +     if (copy_from_user(&ut, self, sizeof(ut)))
> > > +             return -EFAULT;
> > > +
> > > +     if (ut.next_tid)
> > > +             return -EINVAL;
> > > +
> > > +     if (flags == UMCG_CTL_WORKER) {
> > > +             if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_BLOCKED)
> >
> > Or use UMCG_TASK_STATE_MASK that is enough.
> 
> Do you have a use case for this (i.e. when state flags can be
> legitimately set here)? At the moment I can't think of it, and I'd
> rather keep things more strict to avoid dealing with unexpected use
> cases in the future.

When read through  this  thread, I am not realize that this time the
state flags should not be set. But I need to go other round to be more
clear like I'm now reading the doc again..

> > > +                     return -EINVAL;
> > > +
> > > +             WRITE_ONCE(current->umcg_task, self);
> > > +             current->flags |= PF_UMCG_WORKER;
> > > +
> > > +             /* Trigger umcg_handle_resuming_worker() */
> > > +             set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> > > +     } else {
> > > +             if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING)
> >
> > The same here.
> 
> Yes, the same here - why do you think task state flags should be allowed here?
> 
> 
> >
> > > +                     return -EINVAL;
> > > +
> > > +             WRITE_ONCE(current->umcg_task, self);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> >
> > Thanks,
> > Tao
