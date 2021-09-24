Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE7B41776F
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbhIXPX4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347051AbhIXPX4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 11:23:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B93C061613
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 08:22:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v19so7216389pjh.2
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MoAStGlkm8JafyxsSKRaE9chixbqEn2aLPHW3knObUM=;
        b=EiaPGplPuy87PxxspGRXkVjI4qy/bDpYDlOHeg52JcCe+X9hxiMsRybnqBAdI3ZvF7
         Bxj91H7vVoMNz3YkQdOR0ucTBqyYxBtkxQGEOZPhpnhW8eHb8WBYDY0gdh3sWKxtrHDA
         G2VWmnwu1vwhZt8C7SOOiAC86rocjq7oRbe5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MoAStGlkm8JafyxsSKRaE9chixbqEn2aLPHW3knObUM=;
        b=zJALWGLwm4GV0bCJkwcZU6Zwf/gHoqVjIyvlNrykAc9TDfLMMot/x97BcrtIx7k2zP
         tMqMdZLREGtHCVfq2fivsDI/C7ccDQG3MgjhXpp8dFdX9d0MXaWYDYsKZKz95hohz3Bj
         jCarn7nDH/DOWen1hiMVNOZ+5gwg9CT0UW6kBr7XjNmzTmEQxXSDLWlvSFB4J0l1LnYi
         /EODjp/Gx1yawFfH2uxtq3sVKlxOD0/Hzrw9l4zXtyjb45N+jzqiKq0zm0m3wlJkP3b0
         xtWIEj8zud5A9keijIWR3YHSb8THZKmqGefxIBRHIfgbA0rDEXOI519njnQY6pIRK4qD
         xKfQ==
X-Gm-Message-State: AOAM532M8rFJTtCyFsyVqle9+uvcWInY1Yhq6s9KAVZYozs6yuOQRBQi
        wAp6yM3GgdOeexZN2dlve8lTdQ==
X-Google-Smtp-Source: ABdhPJzr75h5r2OSi1hEn63xdaArzKIyncQf40M3Q3xeZO1rzFG4ooPspT/sHxKXuLkWIDkAMtqG5g==
X-Received: by 2002:a17:90a:1a11:: with SMTP id 17mr2884401pjk.234.1632496942188;
        Fri, 24 Sep 2021 08:22:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s69sm9986041pgc.35.2021.09.24.08.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:22:21 -0700 (PDT)
Date:   Fri, 24 Sep 2021 08:22:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/6] signal: Remove the bogus sigkill_pending in
 ptrace_stop
Message-ID: <202109240804.BC44773A@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87pmsyx29t.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmsyx29t.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 07:09:34PM -0500, Eric W. Biederman wrote:
> 
> The existence of sigkill_pending is a little silly as it is
> functionally a duplicate of fatal_signal_pending that is used in
> exactly one place.

sigkill_pending() checks for &tsk->signal->shared_pending.signal but
fatal_signal_pending() doesn't.

> Checking for pending fatal signals and returning early in ptrace_stop
> is actively harmful.  It casues the ptrace_stop called by
> ptrace_signal to return early before setting current->exit_code.
> Later when ptrace_signal reads the signal number from
> current->exit_code is undefined, making it unpredictable what will
> happen.
> 
> Instead rely on the fact that schedule will not sleep if there is a
> pending signal that can awaken a task.

This reasoning sound fine, but I can't see where it's happening.
It looks like recalc_sigpending() is supposed to happen at the start
of scheduling? I see it at the end of ptrace_stop(), though, so it looks
like it's reasonable to skip checking shared_pending.

(Does the scheduler deal with shared_pending directly?)

> Removing the explict sigkill_pending test fixes fixes ptrace_signal
> when ptrace_stop does not stop because current->exit_code is always
> set to to signr.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3d749b9e676b ("ptrace: simplify ptrace_stop()->sigkill_pending() path")
> Fixes: 1a669c2f16d4 ("Add arch_ptrace_stop")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/signal.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 952741f6d0f9..9f2dc9cf3208 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2182,15 +2182,6 @@ static inline bool may_ptrace_stop(void)
>  	return true;
>  }
>  
> -/*
> - * Return non-zero if there is a SIGKILL that should be waking us up.
> - * Called with the siglock held.
> - */
> -static bool sigkill_pending(struct task_struct *tsk)
> -{
> -	return sigismember(&tsk->pending.signal, SIGKILL) ||
> -	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
> -}
>  
>  /*
>   * This must be called with current->sighand->siglock held.
> @@ -2217,17 +2208,16 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
>  		 * calling arch_ptrace_stop, so we must release it now.
>  		 * To preserve proper semantics, we must do this before
>  		 * any signal bookkeeping like checking group_stop_count.
> -		 * Meanwhile, a SIGKILL could come in before we retake the
> -		 * siglock.  That must prevent us from sleeping in TASK_TRACED.
> -		 * So after regaining the lock, we must check for SIGKILL.

Where is the sleep this comment is talking about?

i.e. will recalc_sigpending() have been called before the above sleep
would happen? I assume it's after ptrace_stop() returns... But I want to
make sure the sleep isn't in ptrace_stop() itself somewhere I can't see.
I *do* see freezable_schedule() called, and that dumps us into
__schedule(), and I don't see a recalc before it checks
signal_pending_state().

Does a recalc need to happen in plce of the old sigkill_pending()
call?

-- 
Kees Cook
