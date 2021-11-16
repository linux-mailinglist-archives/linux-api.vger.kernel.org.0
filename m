Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88B445395B
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhKPS0t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 13:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhKPS0q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 13:26:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8EDC061570
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:23:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so163924pjb.1
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S3VDi8jXUI3wm3amg33IPhbdNig0S54BgfAWQ9OQbYc=;
        b=Pkb602cLkmvNOy5JCLHuXvAFntcynE2WvxqHBr5rbjqmeUiDuCHeyaqmTbauT9gLb7
         rrPkXC/R9aUNXM/ip3CLECgU0WwQ2qljAdZ8k1bHilX5JY2Gm1v39lDEKg+9lO48NZgg
         vWeLBSg0qshNzOt/8/LYAHc+OJq2Ks+QQKp7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3VDi8jXUI3wm3amg33IPhbdNig0S54BgfAWQ9OQbYc=;
        b=giABdmAC4iN93Y2qlGXQTzsyJEIkwnJc9sADELlnuUSfiktPGlkt6f4rSy/VBLZZ9s
         7Rkel+1mCwH+yes6+Jpt3e7NMLeEKJqrW3YHKWAsjK2gohxcRhIEegZELEQsRefRg9YS
         cofhPXMDqkjZtQjUItzy1WwrshhcUEc2G2EWWVYCy4+PUxY4CzXD5AkRbld0hATZFIKX
         B6pXbydoCyOnHBqFKgCjKRRfiUbHhpE+SCR/VXyMDygIQAy5LbRTIrpTOwQB3YZVabm5
         0jnzJAKdq50HY8FmNYIGy9hc9ISEkOjYYWg7Yw7SQf/jcZsMmVUfjIxb6R/X9WR2vFsS
         Um1w==
X-Gm-Message-State: AOAM533/OelIYDhyWbseFv/H0gRdwtVghlITSPsm1+9R915dK8zN1qRz
        OrtHj5LRJDg9IE1qvsyni6LlCw==
X-Google-Smtp-Source: ABdhPJwzJzlTrH0Hs6yUPmgfib5ob6W71Urapef9heI+Gkp9lV6mxhii2Vu2vg++gyusHPZR12N9Xw==
X-Received: by 2002:a17:903:230b:b0:141:e3ce:2738 with SMTP id d11-20020a170903230b00b00141e3ce2738mr47064706plh.57.1637087029236;
        Tue, 16 Nov 2021 10:23:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q32sm2863469pja.4.2021.11.16.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:23:48 -0800 (PST)
Date:   Tue, 16 Nov 2021 10:23:48 -0800
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
Subject: Re: [PATCH 1/3] signal: In get_signal test for signal_group_exit
 every time through the loop
Message-ID: <202111161022.7B5720B@keescook>
References: <20211101034147.6203-1-khuey@kylehuey.com>
 <877ddqabvs.fsf@disp2133>
 <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
 <87fsse8maf.fsf@disp2133>
 <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
 <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
 <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
 <875yssekcd.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yssekcd.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 15, 2021 at 11:32:50PM -0600, Eric W. Biederman wrote:
> 
> Recently while investigating a problem with rr and signals I noticed
> that siglock is dropped in ptrace_signal and get_signal does not jump
> to relock.
> 
> Looking farther to see if the problem is anywhere else I see that
> do_signal_stop also returns if signal_group_exit is true.  I believe
> that test can now never be true, but it is a bit hard to trace
> through and be certain.
> 
> Testing signal_group_exit is not expensive, so move the test for
> signal_group_exit into the for loop inside of get_signal to ensure
> the test is never skipped improperly.

Seems reasonable.

> 
> This has been a potential since I added the test for signal_group_exit

nit: missing word after "potential"? "bug", "problem"?

> was added.
> 
> Fixes: 35634ffa1751 ("signal: Always notice exiting tasks")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  kernel/signal.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7c4b7ae714d4..986fa69c15c5 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2662,19 +2662,19 @@ bool get_signal(struct ksignal *ksig)
>  		goto relock;
>  	}
>  
> -	/* Has this task already been marked for death? */
> -	if (signal_group_exit(signal)) {
> -		ksig->info.si_signo = signr = SIGKILL;
> -		sigdelset(&current->pending.signal, SIGKILL);
> -		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> -				&sighand->action[SIGKILL - 1]);
> -		recalc_sigpending();
> -		goto fatal;
> -	}
> -
>  	for (;;) {
>  		struct k_sigaction *ka;
>  
> +		/* Has this task already been marked for death? */
> +		if (signal_group_exit(signal)) {
> +			ksig->info.si_signo = signr = SIGKILL;
> +			sigdelset(&current->pending.signal, SIGKILL);
> +			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> +				&sighand->action[SIGKILL - 1]);
> +			recalc_sigpending();
> +			goto fatal;
> +		}
> +
>  		if (unlikely(current->jobctl & JOBCTL_STOP_PENDING) &&
>  		    do_signal_stop(0))
>  			goto relock;
> -- 
> 2.20.1
> 

-- 
Kees Cook
