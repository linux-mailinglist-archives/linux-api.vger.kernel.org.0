Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2D45396D
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 19:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhKPSeR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 13:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbhKPSeO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 13:34:14 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59D5C061570
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:31:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g28so18408163pgg.3
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j4+lKThDJbbAktRPCq9TfADc/zgUKrnl5njopfzTLfc=;
        b=VuWKqC5czp8WpX/82MPZmsb/ac+LTU4k32UPSs4eA9SGVjk9IhP3CXgcW7B6JSsvlq
         10HlxsUAyDVDKtlxjIe5DulrulwjC0oBtVx3TyOx/BX3fAR1Hbc/R2VrEk4E9i7ia++M
         wrRH6Szu7Dp+nV0qpbNVR9fqT56lYzlYp3OPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j4+lKThDJbbAktRPCq9TfADc/zgUKrnl5njopfzTLfc=;
        b=gqR5DXJDvgkfD4ltdwZOXmDriHe8G5JIaqfHN6bc0rTkXUOG41At75rkxBsifrflq2
         lodIK/ZVFaTF5tkDi9wIqXrRMKiQjcdpceutrSflCGj6o2npCGhw3SlMYzo1k/LeTKVz
         YWYSVcJoyqwtU/TC2nIfg4BG1d+6ap6D2vvQT9ERx/UWAKGPUGmckmRS4ohenezcFkKs
         w6WHj4zLSIO6kLCX06mmgC/1WQ1vR+YKR1FBlgXw1KwCaHy9LOU6vywhMeky9R88R8k1
         S7e2aj+qctBYIDMFvUB9Za4qN3Jm5PWVAXRNsFTATWf9fkvLuVSrNuh3LpRwVUuuJ9PB
         70HQ==
X-Gm-Message-State: AOAM5337OPqMfMZFrk15tB5mf9e54iahBLwc1cW3pnM+QkVq4SmNzGmQ
        AX9Ls/pR/yFbP5FZVRJ1Spcnmw==
X-Google-Smtp-Source: ABdhPJzldjHQEBFnOV/fJJ5FmAa6khPC53toMdW+6DQgWy/6Jd6Pt7BjGFLdYKVnRfo7vywjfN1gQQ==
X-Received: by 2002:a05:6a00:1a04:b0:4a0:6e3:27b3 with SMTP id g4-20020a056a001a0400b004a006e327b3mr1198608pfv.24.1637087476065;
        Tue, 16 Nov 2021 10:31:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8sm15750575pgk.66.2021.11.16.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:31:15 -0800 (PST)
Date:   Tue, 16 Nov 2021 10:31:15 -0800
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
Subject: Re: [PATCH 3/3] signal: Requeue ptrace signals
Message-ID: <202111161031.57764153B@keescook>
References: <20211101034147.6203-1-khuey@kylehuey.com>
 <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
 <87fsse8maf.fsf@disp2133>
 <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
 <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
 <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
 <87tugcd5p2.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tugcd5p2.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 15, 2021 at 11:34:33PM -0600, Eric W. Biederman wrote:
> 
> Kyle Huey <me@kylehuey.com> writes:
> 
> > rr, a userspace record and replay debugger[0], uses the recorded register
> > state at PTRACE_EVENT_EXIT to find the point in time at which to cease
> > executing the program during replay.
> >
> > If a SIGKILL races with processing another signal in get_signal, it is
> > possible for the kernel to decline to notify the tracer of the original
> > signal. But if the original signal had a handler, the kernel proceeds
> > with setting up a signal handler frame as if the tracer had chosen to
> > deliver the signal unmodified to the tracee. When the kernel goes to
> > execute the signal handler that it has now modified the stack and registers
> > for, it will discover the pending SIGKILL, and terminate the tracee
> > without executing the handler. When PTRACE_EVENT_EXIT is delivered to
> > the tracer, however, the effects of handler setup will be visible to
> > the tracer.
> >
> > Because rr (the tracer) was never notified of the signal, it is not aware
> > that a signal handler frame was set up and expects the state of the program
> > at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
> > by allowing the program to execute from the last event. When that fails
> > to happen during replay, rr will assert and die.
> >
> > The following patches add an explicit check for a newly pending SIGKILL
> > after the ptracer has been notified and the siglock has been reacquired.
> > If this happens, we stop processing the current signal and proceed
> > immediately to handling the SIGKILL. This makes the state reported at
> > PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
> > work to set up a signal handler frame that will never be used.
> >
> > [0] https://rr-project.org/
> 
> The problem is that while the traced process makes it into ptrace_stop,
> the tracee is killed before the tracer manages to wait for the
> tracee and discover which signal was about to be delivered.
> 
> More generally the problem is that while siglock was dropped a signal
> with process wide effect is short cirucit delivered to the entire
> process killing it, but the process continues to try and deliver another
> signal.
> 
> In general it impossible to avoid all cases where work is performed
> after the process has been killed.  In particular if the process is
> killed after get_signal returns the code will simply not know it has
> been killed until after delivering the signal frame to userspace.
> 
> On the other hand when the code has already discovered the process
> has been killed and taken user space visible action that shows
> the kernel knows the process has been killed, it is just silly
> to then write the signal frame to the user space stack.
> 
> Instead of being silly detect the process has been killed
> in ptrace_signal and requeue the signal so the code can pretend
> it was simply never dequeued for delivery.
> 
> To test the process has been killed I use fatal_signal_pending rather
> than signal_group_exit to match the test in signal_pending_state which
> is used in schedule which is where ptrace_stop detects the process has
> been killed.
> 
> Requeuing the signal so the code can pretend it was simply never
> dequeued improves the user space visible behavior that has been
> present since ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4").
> 
> Kyle Huey verified that this change in behavior and makes rr happy.
> 
> Reported-by: Kyle Huey <khuey@kylehuey.com>
> Reported-by: Marko Mäkelä <marko.makela@mariadb.com>
> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.gi
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yay pre-git-history! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  kernel/signal.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 43e8b7e362b0..621401550f0f 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2565,7 +2565,8 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
>  	}
>  
>  	/* If the (new) signal is now blocked, requeue it.  */
> -	if (sigismember(&current->blocked, signr)) {
> +	if (sigismember(&current->blocked, signr) ||
> +	    fatal_signal_pending(current)) {
>  		send_signal(signr, info, current, type);
>  		signr = 0;
>  	}
> -- 
> 2.20.1
> 

-- 
Kees Cook
