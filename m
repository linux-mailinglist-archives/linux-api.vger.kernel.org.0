Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46AD417B76
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbhIXTIR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346210AbhIXTIQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 15:08:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D886C061613
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 12:06:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23so7655250pji.0
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQbXTp9jwktw89AtddwoXiRRXvT8q44fMgRU+kpBvAs=;
        b=hBT2094Q4KVQXKdAcY4LmJQYGAi98KaiZtil0A1jpS1bLDBgk9TcwJnTG2A01kZ5bg
         SJUY9OTGwlTCsKmBvVQe2Ftu0EdsEdtzn2QRd7ZYieqsS36uKU6KPPZ/aPUafZ7nntEf
         8+eEObucgDEbSrBWSI04DzobWanfxDZXhUFUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQbXTp9jwktw89AtddwoXiRRXvT8q44fMgRU+kpBvAs=;
        b=RPHuOIoFpe0lEVYuGwV2EJXGcTnFlUsT2RiHAAz1yInagaWdm4DQddYqXgiqWLNwTT
         1hLqOrY/T4uZMdnBk8p427DKOblq6ixoyzuDBsSfYGE6FsRrR5APwbyaMNm9sfaonW61
         cxL0SDoh9ZqXrS+4DHisGWQ/BLn6joW1XmkybdRkAg8vjdUFa9XQS9ZJlBapkXSZuIQJ
         sjMfgr4UlVieIleXjCcKxYw0TggEkkHhnW53KtM+cwpKgKCApEuYon59g0Tx/69/ez++
         TKy+/yOzuOMWFJF/tiEeYNojmkYCrDBWJKhgRvo34olHGjeV8LPXIPTe5IHXeO5B1KiO
         WAsg==
X-Gm-Message-State: AOAM5301NrkTBiZqPBGMI1GUuQgSkBAzKm/qKpf7Ngn97IcduWUN9euo
        NdBU9g5beBy8N2BfjahkhBCQGg==
X-Google-Smtp-Source: ABdhPJz0Cmr2FruFvG3V3BsomRdJH/fcunLCf5Ac+KO5P7m6yIHEkK69BsHG2AwYfGqnjGfbR7IWMA==
X-Received: by 2002:a17:90a:a584:: with SMTP id b4mr4076791pjq.70.1632510402841;
        Fri, 24 Sep 2021 12:06:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h17sm9748992pfk.66.2021.09.24.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 12:06:42 -0700 (PDT)
Date:   Fri, 24 Sep 2021 12:06:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/6] signal: Remove the bogus sigkill_pending in
 ptrace_stop
Message-ID: <202109241159.950557F64@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87pmsyx29t.fsf@disp2133>
 <202109240804.BC44773A@keescook>
 <87tuiaotz1.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuiaotz1.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 24, 2021 at 10:48:18AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Thu, Sep 23, 2021 at 07:09:34PM -0500, Eric W. Biederman wrote:
> >> 
> >> The existence of sigkill_pending is a little silly as it is
> >> functionally a duplicate of fatal_signal_pending that is used in
> >> exactly one place.
> >
> > sigkill_pending() checks for &tsk->signal->shared_pending.signal but
> > fatal_signal_pending() doesn't.
> 
> The extra test is unnecessary as all SIGKILL's visit complete_signal
> immediately run the loop:
> 
> 			/*
> 			 * Start a group exit and wake everybody up.
> 			 * This way we don't have other threads
> 			 * running and doing things after a slower
> 			 * thread has the fatal signal pending.
> 			 */
> 			signal->flags = SIGNAL_GROUP_EXIT;
> 			signal->group_exit_code = sig;
> 			signal->group_stop_count = 0;
> 			t = p;
> 			do {
> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> 				sigaddset(&t->pending.signal, SIGKILL);
> 				signal_wake_up(t, 1);
> 			} while_each_thread(p, t);
> 			return;
> 
> Which sets SIGKILL in the task specific queue.  Which means only the
> non-shared queue needs to be tested.  Further fatal_signal_pending would
> be buggy if this was not the case.

Okay, so SIGKILL is special from the perspective of shared_pending. Why
was it tested for before? Or rather: how could SIGKILL ever have gotten
set in shared_pending?

Oh, I think I see what you mean about complete_signal() now: that's just
looking at sig, and doesn't care where it got written. i.e. SIGKILL gets
immediately written to pending, even if the prior path through
__send_signal() only wrote it to shared_pending.

> 
> >> Checking for pending fatal signals and returning early in ptrace_stop
> >> is actively harmful.  It casues the ptrace_stop called by
> >> ptrace_signal to return early before setting current->exit_code.
> >> Later when ptrace_signal reads the signal number from
> >> current->exit_code is undefined, making it unpredictable what will
> >> happen.
> >> 
> >> Instead rely on the fact that schedule will not sleep if there is a
> >> pending signal that can awaken a task.
> >
> > This reasoning sound fine, but I can't see where it's happening.
> > It looks like recalc_sigpending() is supposed to happen at the start
> > of scheduling? I see it at the end of ptrace_stop(), though, so it looks
> > like it's reasonable to skip checking shared_pending.
> >
> > (Does the scheduler deal with shared_pending directly?)
> 
> In the call of signal_pending_state from kernel/core/.c:__schedule().
> 
> ptrace_stop would actually be badly broken today if that was not the
> case as several places enter into ptrace_event without testing signals
> first.
> 
> >> Removing the explict sigkill_pending test fixes fixes ptrace_signal
> >> when ptrace_stop does not stop because current->exit_code is always
> >> set to to signr.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Fixes: 3d749b9e676b ("ptrace: simplify ptrace_stop()->sigkill_pending() path")
> >> Fixes: 1a669c2f16d4 ("Add arch_ptrace_stop")
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >>  kernel/signal.c | 18 ++++--------------
> >>  1 file changed, 4 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/kernel/signal.c b/kernel/signal.c
> >> index 952741f6d0f9..9f2dc9cf3208 100644
> >> --- a/kernel/signal.c
> >> +++ b/kernel/signal.c
> >> @@ -2182,15 +2182,6 @@ static inline bool may_ptrace_stop(void)
> >>  	return true;
> >>  }
> >>  
> >> -/*
> >> - * Return non-zero if there is a SIGKILL that should be waking us up.
> >> - * Called with the siglock held.
> >> - */
> >> -static bool sigkill_pending(struct task_struct *tsk)
> >> -{
> >> -	return sigismember(&tsk->pending.signal, SIGKILL) ||
> >> -	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
> >> -}
> >>  
> >>  /*
> >>   * This must be called with current->sighand->siglock held.
> >> @@ -2217,17 +2208,16 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
> >>  		 * calling arch_ptrace_stop, so we must release it now.
> >>  		 * To preserve proper semantics, we must do this before
> >>  		 * any signal bookkeeping like checking group_stop_count.
> >> -		 * Meanwhile, a SIGKILL could come in before we retake the
> >> -		 * siglock.  That must prevent us from sleeping in TASK_TRACED.
> >> -		 * So after regaining the lock, we must check for SIGKILL.
> >
> > Where is the sleep this comment is talking about?
> >
> > i.e. will recalc_sigpending() have been called before the above sleep
> > would happen? I assume it's after ptrace_stop() returns... But I want to
> > make sure the sleep isn't in ptrace_stop() itself somewhere I can't see.
> > I *do* see freezable_schedule() called, and that dumps us into
> > __schedule(), and I don't see a recalc before it checks
> > signal_pending_state().
> >
> > Does a recalc need to happen in plce of the old sigkill_pending()
> > call?
> 
> You read that correctly freezable_schedule is where ptrace_stop sleeps.
> 
> The call chain you are looking for looks something like:
> send_signal
>   complete_signal
>      signal_wake_up
>        signal_wake_up_state
>          set_tsk_thread_flag(t, TIF_SIGPENDING)
> 
> That is to say complete_signal sets TIF_SIGPENDING and
> the per task siqueue SIGKILL entry.
> 
> Calling recalc_sigpending is only needed when a signal is removed from
> the queues, not when a signal is added.

Got it; thanks! Yeah, it was mainly I didn't see where SIGKILL got
handled specially, and now I do. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
