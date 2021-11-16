Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6C453968
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 19:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhKPSds (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 13:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbhKPSds (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 13:33:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBADC061746
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:30:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq11so158964pjb.3
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GTAAJI0ltdrSWld+SGAvys7taWMA2HrVk1Gbz1jjxAU=;
        b=G0/YE+xN3GXAlKTirM119NnjTGOanYz5HutU0khmj0xNrDGfLpo9dEXLpI3ayiN/LZ
         qT6bC9tj6UPCso3JyA38ScZrBB3vr4Nq3iYlU/KXovXqFiI4f3y1KjqvO7kkS07BRaYy
         jX6akc2uJrqioQ4KSESa6rP9D/FuQQLKHOV7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GTAAJI0ltdrSWld+SGAvys7taWMA2HrVk1Gbz1jjxAU=;
        b=H3VZRZnsOpRNFWsm/qKCBJqeHoabQ1KcIsupTDo9mm04mAAy5Scn5Y8SPKvpLyXWss
         uH4IQrsRKFjAjgLaFNhZ0S/xB5INFaB1Hd55jTv+ElCKplxbef3UToL5b5eIV//lTu7Y
         ah6vORyuCwgsyFPs9NxmAn5a5L1wbHQcoVFX4Zieo9e6Bxmw0UWg/Oqurdx/w6jcdj86
         1YDkkcc2L4+ULT09M4/mGuFmLdrXySQScj0RwXJk8WSQOzV8XRrWxf4JEjwVdTd7dhmS
         fLApx559DIbpbtDIQ6tyNGgylVy9A3GgTOM4MzSO+b2cOOI00IkSVHspoWaAWcsvw99l
         BEsQ==
X-Gm-Message-State: AOAM532xrgLw4riFFwdKMILVBQnmeOoc0pi4Wsf871PmbVKCYRp7xFtE
        xonCZEUQ3XyVoW5Fxe0utrWylg==
X-Google-Smtp-Source: ABdhPJx/y/oON+xAv+NB14+oceVr4Ex7+YFLLyvs3AGDqKNobo2YB1xxQ6109Jactf8wbpFYJyrjHQ==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr47904017plg.17.1637087450846;
        Tue, 16 Nov 2021 10:30:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z30sm18705960pfg.30.2021.11.16.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:30:50 -0800 (PST)
Date:   Tue, 16 Nov 2021 10:30:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@mariadb.com>,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] signal: Requeue signals in the appropriate queue
Message-ID: <202111161027.C7957C65@keescook>
References: <20211101034147.6203-1-khuey@kylehuey.com>
 <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
 <87fsse8maf.fsf@disp2133>
 <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
 <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
 <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
 <87zgq4d5r4.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgq4d5r4.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 15, 2021 at 11:33:19PM -0600, Eric W. Biederman wrote:
> 
> In the event that a tracer changes which signal needs to be delivered
> and that signal is currently blocked then the signal needs to be
> requeued for later delivery.
> 
> With the advent of CLONE_THREAD the kernel has 2 signal queues per
> task.  The per process queue and the per task queue.  Update the code
> so that if the signal is removed from the per process queue it is
> requeued on the per process queue.  This is necessary to make it
> appear the signal was never dequeued.
> 
> The rr debugger reasonably believes that the state of the process from
> the last ptrace_stop it observed until PTRACE_EVENT_EXIT can be recreated
> by simply letting a process run.  If a SIGKILL interrupts a ptrace_stop
> this is not true today.
> 
> So return signals to their original queue in ptrace_signal so that
> signals that are not delivered appear like they were never dequeued.

The only comment I have on this is that it seems like many callers
totally ignore the result store in "type" (signalfd_dequeue,
kernel_dequeue_signal, do_sigtimedwait), which would imply a different
API might be desirable. That said, it's also not a big deal.

> 
> Fixes: 794aa320b79d ("[PATCH] sigfix-2.5.40-D6")
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.gi
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  fs/signalfd.c                |  5 +++--
>  include/linux/sched/signal.h |  7 ++++---
>  kernel/signal.c              | 21 ++++++++++++++-------
>  3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 040e1cf90528..74f134cd1ff6 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -165,11 +165,12 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>  static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info,
>  				int nonblock)
>  {
> +	enum pid_type type;
>  	ssize_t ret;
>  	DECLARE_WAITQUEUE(wait, current);
>  
>  	spin_lock_irq(&current->sighand->siglock);
> -	ret = dequeue_signal(current, &ctx->sigmask, info);
> +	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
>  	switch (ret) {
>  	case 0:
>  		if (!nonblock)
> @@ -184,7 +185,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
>  	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
>  	for (;;) {
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		ret = dequeue_signal(current, &ctx->sigmask, info);
> +		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
>  		if (ret != 0)
>  			break;
>  		if (signal_pending(current)) {
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 23505394ef70..167995d471da 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -286,17 +286,18 @@ static inline int signal_group_exit(const struct signal_struct *sig)
>  extern void flush_signals(struct task_struct *);
>  extern void ignore_signals(struct task_struct *);
>  extern void flush_signal_handlers(struct task_struct *, int force_default);
> -extern int dequeue_signal(struct task_struct *task,
> -			  sigset_t *mask, kernel_siginfo_t *info);
> +extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
> +			  kernel_siginfo_t *info, enum pid_type *type);
>  
>  static inline int kernel_dequeue_signal(void)
>  {
>  	struct task_struct *task = current;
>  	kernel_siginfo_t __info;
> +	enum pid_type __type;
>  	int ret;
>  
>  	spin_lock_irq(&task->sighand->siglock);
> -	ret = dequeue_signal(task, &task->blocked, &__info);
> +	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
>  	spin_unlock_irq(&task->sighand->siglock);
>  
>  	return ret;
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 986fa69c15c5..43e8b7e362b0 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -626,7 +626,8 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
>   *
>   * All callers have to hold the siglock.
>   */
> -int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *info)
> +int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
> +		   kernel_siginfo_t *info, enum pid_type *type)
>  {
>  	bool resched_timer = false;
>  	int signr;
> @@ -634,8 +635,10 @@ int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *in
>  	/* We only dequeue private signals from ourselves, we don't let
>  	 * signalfd steal them
>  	 */
> +	*type = PIDTYPE_PID;
>  	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
>  	if (!signr) {
> +		*type = PIDTYPE_TGID;
>  		signr = __dequeue_signal(&tsk->signal->shared_pending,
>  					 mask, info, &resched_timer);
>  #ifdef CONFIG_POSIX_TIMERS
> @@ -2522,7 +2525,7 @@ static void do_freezer_trap(void)
>  	freezable_schedule();
>  }
>  
> -static int ptrace_signal(int signr, kernel_siginfo_t *info)
> +static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
>  {
>  	/*
>  	 * We do not check sig_kernel_stop(signr) but set this marker
> @@ -2563,7 +2566,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>  
>  	/* If the (new) signal is now blocked, requeue it.  */
>  	if (sigismember(&current->blocked, signr)) {
> -		send_signal(signr, info, current, PIDTYPE_PID);
> +		send_signal(signr, info, current, type);
>  		signr = 0;
>  	}
>  
> @@ -2664,6 +2667,7 @@ bool get_signal(struct ksignal *ksig)
>  
>  	for (;;) {
>  		struct k_sigaction *ka;
> +		enum pid_type type;
>  
>  		/* Has this task already been marked for death? */
>  		if (signal_group_exit(signal)) {
> @@ -2706,16 +2710,18 @@ bool get_signal(struct ksignal *ksig)
>  		 * so that the instruction pointer in the signal stack
>  		 * frame points to the faulting instruction.
>  		 */
> +		type = PIDTYPE_PID;
>  		signr = dequeue_synchronous_signal(&ksig->info);
>  		if (!signr)
> -			signr = dequeue_signal(current, &current->blocked, &ksig->info);
> +			signr = dequeue_signal(current, &current->blocked,
> +					       &ksig->info, &type);
>  
>  		if (!signr)
>  			break; /* will return 0 */
>  
>  		if (unlikely(current->ptrace) && (signr != SIGKILL) &&
>  		    !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
> -			signr = ptrace_signal(signr, &ksig->info);
> +			signr = ptrace_signal(signr, &ksig->info, type);
>  			if (!signr)
>  				continue;
>  		}
> @@ -3540,6 +3546,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
>  	ktime_t *to = NULL, timeout = KTIME_MAX;
>  	struct task_struct *tsk = current;
>  	sigset_t mask = *which;
> +	enum pid_type type;
>  	int sig, ret = 0;
>  
>  	if (ts) {
> @@ -3556,7 +3563,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
>  	signotset(&mask);
>  
>  	spin_lock_irq(&tsk->sighand->siglock);
> -	sig = dequeue_signal(tsk, &mask, info);
> +	sig = dequeue_signal(tsk, &mask, info, &type);
>  	if (!sig && timeout) {
>  		/*
>  		 * None ready, temporarily unblock those we're interested
> @@ -3575,7 +3582,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
>  		spin_lock_irq(&tsk->sighand->siglock);
>  		__set_task_blocked(tsk, &tsk->real_blocked);
>  		sigemptyset(&tsk->real_blocked);
> -		sig = dequeue_signal(tsk, &mask, info);
> +		sig = dequeue_signal(tsk, &mask, info, &type);
>  	}
>  	spin_unlock_irq(&tsk->sighand->siglock);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
