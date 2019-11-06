Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C38F12EE
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfKFJxN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 04:53:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKFJxM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Nov 2019 04:53:12 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSHzq-0006eR-Rf; Wed, 06 Nov 2019 10:53:03 +0100
Date:   Wed, 6 Nov 2019 10:53:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
cc:     Florian Weimer <fweimer@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: handle_exit_race && PF_EXITING
In-Reply-To: <20191106085529.GA12575@redhat.com>
Message-ID: <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <20191105152728.GA5666@redhat.com> <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de> <20191106085529.GA12575@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Oleg,

On Wed, 6 Nov 2019, Oleg Nesterov wrote:
> I have found the fix I sent in 2015, attached below. I forgot everything
> I knew about futex.c, so I need some time to adapt it to the current code.
> 
> But I think it is clear what this patch tries to do, do you see any hole?

> @@ -716,11 +716,13 @@ void exit_pi_state_list(struct task_struct *curr)
>  
>  	if (!futex_cmpxchg_enabled)
>  		return;
> +
>  	/*
> -	 * We are a ZOMBIE and nobody can enqueue itself on
> -	 * pi_state_list anymore, but we have to be careful
> -	 * versus waiters unqueueing themselves:
> +	 * attach_to_pi_owner() can no longer add the new entry. But
> +	 * we have to be careful versus waiters unqueueing themselves.
>  	 */
> +	curr->flags |= PF_EXITPIDONE;

This obviously would need a barrier or would have to be moved inside of the
pi_lock region.

>  	raw_spin_lock_irq(&curr->pi_lock);
>  	while (!list_empty(head)) {
>  
> @@ -905,24 +907,12 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
>  		return -EPERM;
>  	}
>  
> -	/*
> -	 * We need to look at the task state flags to figure out,
> -	 * whether the task is exiting. To protect against the do_exit
> -	 * change of the task flags, we do this protected by
> -	 * p->pi_lock:
> -	 */
>  	raw_spin_lock_irq(&p->pi_lock);
> -	if (unlikely(p->flags & PF_EXITING)) {
> -		/*
> -		 * The task is on the way out. When PF_EXITPIDONE is
> -		 * set, we know that the task has finished the
> -		 * cleanup:
> -		 */
> -		int ret = (p->flags & PF_EXITPIDONE) ? -ESRCH : -EAGAIN;
> -
> +	if (unlikely(p->flags & PF_EXITPIDONE)) {
> +		/* exit_pi_state_list() was already called */
>  		raw_spin_unlock_irq(&p->pi_lock);
>  		put_task_struct(p);
> -		return ret;
> +		return -ESRCH;

But, this is incorrect because we'd return -ESRCH to user space while the
futex value still has the TID of the exiting task set which will
subsequently cleanout the futex and set the owner died bit.

The result is inconsistent state and will trigger the asserts in the futex
test suite and in the pthread_mutex implementation.

The only reason why -ESRCH can be returned is when the user space value of
the futex contains garbage. But in this case it does not contain garbage
and returning -ESRCH violates the implicit robustness guarantee of PI
futexes and causes unexpected havoc.

See da791a667536 ("futex: Cure exit race") for example.

The futex PI contract between kernel and user space relies on consistent
state. Guess why that code has more corner case handling than actual
functionality. :)

Thanks,

	tglx

