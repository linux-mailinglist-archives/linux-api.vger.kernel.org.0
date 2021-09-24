Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360EE417B4F
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbhIXSxD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 14:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhIXSxD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 14:53:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28370C061571
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 11:51:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 145so9636027pfz.11
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 11:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TAVnXc0nms8n7fIN2yXfZYjRn1YNEO4XXoVuRCnkQP0=;
        b=hjVSGmqQZY77x8GN05wghbbgxmYt+ZzQwcOZWL4wLmQjX7fdgMzeVdCMKGKN5EPBGD
         ayGZAG17jhHtKqzgz0XZK10sE95PBUYD0dg9kshFHiOs2tynL8hlwgpOAd6+Yg8vGLed
         faiG8KbBUHkOLdwlZoLv3vfeB3YFb1zf9b1eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TAVnXc0nms8n7fIN2yXfZYjRn1YNEO4XXoVuRCnkQP0=;
        b=i92/44rv0ErBJ+NvZm4CyiTIirR42zzQqvcz7J4v7a7oHLJsLyWGYa/UkPKCIQE0ly
         OG4dSmIFk5ZSAhwB4kGYrg9d/xnbKZ3NwIjTORMJewPyloswhoOvd2htkB88Hm8tsg+6
         YmUd15KNs/G6F9gKOJq8E/iDx0C2DVGXWMFlApQa4OGY5bdVfNR7yWoP4IcddudUNei/
         wYJf+9OiRWE9DkJMqZO8yHtl50v0gbcwwhNLcnBovvJ16XH020iRNBO3CQXWu7lfV6IC
         GTlNQ+W8DjePLe8qoQEZwWInvjXzVCBHgBgKsglzbyWS8m2hRTimz2aEws6TOZ8FeC4d
         y+oA==
X-Gm-Message-State: AOAM531+8BaXYypu6w2P/GO4KRleh4iI/PiMfAd0gG3jY+nBWZPf2ycs
        a6PW5QokvZ0hq9cZfafKDjUkjw==
X-Google-Smtp-Source: ABdhPJzuKiRhbaVns0VLiUSt+SK8E0CLC+N2x7hv3DOVNEhnI6OfGnntuCXPLcyntdmBmCC+YpQRaw==
X-Received: by 2002:a63:b34a:: with SMTP id x10mr4986221pgt.473.1632509489436;
        Fri, 24 Sep 2021 11:51:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e15sm13177223pjl.11.2021.09.24.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 11:51:28 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:51:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] coredump:  Don't perform any cleanups before dumping
 core
Message-ID: <202109241135.A683423@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <874kaax26c.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kaax26c.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 07:11:39PM -0500, Eric W. Biederman wrote:
> 
> Rename coredump_exit_mm to coredump_task_exit and call it from do_exit
> before PTRACE_EVENT_EXIT, and before any cleanup work for a task
> happens.  This ensures that an accurate copy of the process can be
> captured in the coredump as no cleanup for the process happens before
> the coredump completes.  This also ensures that PTRACE_EVENT_EXIT
> will not be visited by any thread until the coredump is complete.
> 
> Add a new flag PF_POSTCOREDUMP so that tasks that have passed through
> coredump_task_exit can be recognized and ignored in zap_process.
> 
> Now that all of the coredumping happens before exit_mm remove code to
> test for a coredump in progress from mm_release.
> 
> Replace "may_ptrace_stop()" with a simple test of "current->ptrace".
> The other tests in may_ptrace_stop all concern avoiding stopping
> during a coredump.  These tests are no longer necessary as it is now
> guaranteed that fatal_signal_pending will be set if the code enters
> ptrace_stop during a coredump.  The code in ptrace_stop is guaranteed
> not to stop if fatal_signal_pending returns true.
> 
> Until this change "ptrace_event(PTRACE_EVENT_EXIT)" could call
> ptrace_stop without fatal_signal_pending being true, as signals are
> dequeued in get_signal before calling do_exit.  This is no longer
> an issue as "ptrace_event(PTRACE_EVENT_EXIT)" is no longer reached
> until after the coredump completes.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/coredump.c         |  8 ++++----
>  include/linux/sched.h |  1 +
>  kernel/exit.c         | 19 ++++++++++++-------
>  kernel/fork.c         |  3 +--
>  kernel/signal.c       | 27 +--------------------------
>  mm/oom_kill.c         |  2 +-
>  6 files changed, 20 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 5e0e08a7fb9b..d576287fb88b 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -359,7 +359,7 @@ static int zap_process(struct task_struct *start, int exit_code, int flags)
>  
>  	for_each_thread(start, t) {
>  		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> -		if (t != current && t->mm) {
> +		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {

PF_POSTCOREDUMP is "my exit path is done with anything associated with
coredumping, including not having dumped core", yes? i.e. it's a task
lifetime mark, not a "did this actually dump core" mark?

>  			sigaddset(&t->pending.signal, SIGKILL);
>  			signal_wake_up(t, 1);
>  			nr++;
> @@ -404,8 +404,8 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
>  	 *
>  	 * do_exit:
>  	 *	The caller holds mm->mmap_lock. This means that the task which
> -	 *	uses this mm can't pass coredump_exit_mm(), so it can't exit or
> -	 *	clear its ->mm.
> +	 *	uses this mm can't pass coredump_task_exit(), so it can't exit
> +	 *	or clear its ->mm.
>  	 *
>  	 * de_thread:
>  	 *	It does list_replace_rcu(&leader->tasks, &current->tasks),
> @@ -500,7 +500,7 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>  		next = curr->next;
>  		task = curr->task;
>  		/*
> -		 * see coredump_exit_mm(), curr->task must not see
> +		 * see coredump_task_exit(), curr->task must not see
>  		 * ->task == NULL before we read ->next.
>  		 */
>  		smp_mb();
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e12b524426b0..f3741f23935e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1664,6 +1664,7 @@ extern struct pid *cad_pid;
>  #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
>  #define PF_IDLE			0x00000002	/* I am an IDLE thread */
>  #define PF_EXITING		0x00000004	/* Getting shut down */
> +#define PF_POSTCOREDUMP		0x00000008	/* Coredumps should ignore this task */

This might need some bikeshedding. It happens that the coredump code
(zap_process(), actually) will ignore it, but I think what's being
described is "this process has reached an point-of-no-return on the exit
path, where coredumping is either done or never happened".

>  #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
>  #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
>  #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index cb1619d8fd64..774e6b5061b8 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -339,23 +339,29 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
>  	}
>  }
>  
> -static void coredump_exit_mm(struct mm_struct *mm)
> +static void coredump_task_exit(struct task_struct *tsk)
>  {
>  	struct core_state *core_state;
> +	struct mm_struct *mm;
> +
> +	mm = tsk->mm;
> +	if (!mm)
> +		return;
>  
>  	/*
>  	 * Serialize with any possible pending coredump.
>  	 * We must hold mmap_lock around checking core_state
> -	 * and clearing tsk->mm.  The core-inducing thread
> +	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
>  	 * will increment ->nr_threads for each thread in the
> -	 * group with ->mm != NULL.
> +	 * group without PF_POSTCOREDUMP set.
>  	 */
> +	mmap_read_lock(mm);
> +	tsk->flags |= PF_POSTCOREDUMP;

What are the races possible here?

- 2 threads exiting, but neither have core_state, so no change, looks ok
- 1 thread exiting, 1 thread has dumped. core_state exists, in which
  case this starts a loop to wait for wakeup?
	if dumping thread enters zap_process, gets to sigaddset/signal_wake_up
	then the exiting thread sets PF_POSTCOREDUMP and goes to sleep,
	will it wait forever? (I can't tell if sighand locking prevents
	this ordering problem...)
- 2 threads dumping -- similar race to above? I suspect I'm missing
  something, as I'd expect this case to already be handled.

-Kees

>  	core_state = mm->core_state;
> +	mmap_read_unlock(mm);
>  	if (core_state) {
>  		struct core_thread self;
>  
> -		mmap_read_unlock(mm);
> -
>  		self.task = current;
>  		if (self.task->flags & PF_SIGNALED)
>  			self.next = xchg(&core_state->dumper.next, &self);
> @@ -375,7 +381,6 @@ static void coredump_exit_mm(struct mm_struct *mm)
>  			freezable_schedule();
>  		}
>  		__set_current_state(TASK_RUNNING);
> -		mmap_read_lock(mm);
>  	}
>  }
>  
> @@ -480,7 +485,6 @@ static void exit_mm(void)
>  		return;
>  	sync_mm_rss(mm);
>  	mmap_read_lock(mm);
> -	coredump_exit_mm(mm);
>  	mmgrab(mm);
>  	BUG_ON(mm != current->active_mm);
>  	/* more a memory barrier than a real lock */
> @@ -768,6 +772,7 @@ void __noreturn do_exit(long code)
>  	profile_task_exit(tsk);
>  	kcov_task_exit(tsk);
>  
> +	coredump_task_exit(tsk);
>  	ptrace_event(PTRACE_EVENT_EXIT, code);
>  
>  	validate_creds_for_do_exit(tsk);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 38681ad44c76..9bd9f2da9e41 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1392,8 +1392,7 @@ static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
>  	 * purposes.
>  	 */
>  	if (tsk->clear_child_tid) {
> -		if (!(tsk->signal->flags & SIGNAL_GROUP_COREDUMP) &&
> -		    atomic_read(&mm->mm_users) > 1) {
> +		if (atomic_read(&mm->mm_users) > 1) {
>  			/*
>  			 * We don't check the error code - if userspace has
>  			 * not set up a proper pointer then tough luck.
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c9759ff2cb43..b0db80acc6ef 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2158,31 +2158,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  	spin_unlock_irqrestore(&sighand->siglock, flags);
>  }
>  
> -static inline bool may_ptrace_stop(void)
> -{
> -	if (!likely(current->ptrace))
> -		return false;
> -	/*
> -	 * Are we in the middle of do_coredump?
> -	 * If so and our tracer is also part of the coredump stopping
> -	 * is a deadlock situation, and pointless because our tracer
> -	 * is dead so don't allow us to stop.
> -	 * If SIGKILL was already sent before the caller unlocked
> -	 * ->siglock we must see ->core_state != NULL. Otherwise it
> -	 * is safe to enter schedule().
> -	 *
> -	 * This is almost outdated, a task with the pending SIGKILL can't
> -	 * block in TASK_TRACED. But PTRACE_EVENT_EXIT can be reported
> -	 * after SIGKILL was already dequeued.
> -	 */
> -	if (unlikely(current->mm->core_state) &&
> -	    unlikely(current->mm == current->parent->mm))
> -		return false;
> -
> -	return true;
> -}
> -
> -
>  /*
>   * This must be called with current->sighand->siglock held.
>   *
> @@ -2263,7 +2238,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
>  
>  	spin_unlock_irq(&current->sighand->siglock);
>  	read_lock(&tasklist_lock);
> -	if (may_ptrace_stop()) {
> +	if (likely(current->ptrace)) {
>  		/*
>  		 * Notify parents of the stop.
>  		 *
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 295c8bdfd6c8..7877c755ab37 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -788,7 +788,7 @@ static inline bool __task_will_free_mem(struct task_struct *task)
>  
>  	/*
>  	 * A coredumping process may sleep for an extended period in
> -	 * coredump_exit_mm(), so the oom killer cannot assume that
> +	 * coredump_task_exit(), so the oom killer cannot assume that
>  	 * the process will promptly exit and release memory.
>  	 */
>  	if (sig->flags & SIGNAL_GROUP_COREDUMP)
> -- 
> 2.20.1
> 

-- 
Kees Cook
