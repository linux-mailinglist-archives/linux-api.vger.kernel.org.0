Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1EEF1756
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 14:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfKFNis (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 08:38:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44271 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfKFNir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Nov 2019 08:38:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSLWB-0005eJ-OQ; Wed, 06 Nov 2019 14:38:39 +0100
Date:   Wed, 6 Nov 2019 14:38:38 +0100 (CET)
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
In-Reply-To: <20191106121111.GC12575@redhat.com>
Message-ID: <alpine.DEB.2.21.1911061409480.1869@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <20191105152728.GA5666@redhat.com> <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de> <20191106085529.GA12575@redhat.com> <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de> <20191106103509.GB12575@redhat.com>
 <alpine.DEB.2.21.1911061154520.1869@nanos.tec.linutronix.de> <20191106121111.GC12575@redhat.com>
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

On Wed, 6 Nov 2019, Oleg Nesterov wrote:
> But why we can not rely on handle_exit_race() without PF_EXITING check?
> 
> Yes, exit_robust_list() is called before exit_pi_state_list() which (with
> this patch) sets PF_EXITPIDONE. But this is fine? handle_futex_death()
> doesn't wakeup pi futexes, exit_pi_state_list() does this.

I know. You still create inconsistent state because of this:

>  	raw_spin_lock_irq(&p->pi_lock);
> -	if (unlikely(p->flags & PF_EXITING)) {
> +	if (unlikely(p->flags & PF_EXITPIDONE)) {
>  		/*
>  		 * The task is on the way out. When PF_EXITPIDONE is
>  		 * set, we know that the task has finished the
>  		 * cleanup:
>  		 */
> -		int ret = handle_exit_race(uaddr, uval, p);
> +		int ret = handle_exit_race(uaddr, uval);
>  
>  		raw_spin_unlock_irq(&p->pi_lock);
>  		put_task_struct(p);

Same explanation as before just not prosa this time:

exit()					lock_pi(futex2)
  exit_pi_state_list()
   lock(tsk->pi_lock)
   tsk->flags |= PF_EXITPIDONE;		 attach_to_pi_owner()
					  ...
  // Loop unrolled for clarity
  while(!list_empty())			  lock(tsk->pi_lock);
     cleanup(futex1)
       unlock(tsk->pi_lock)
     ...			          if (tsk->flags & PF_EXITPIDONE)
					     ret = handle_exit_race()
					       if (uval != orig_uval)
					           return -EAGAIN;
					       return -ESRCH;

    cleanup(futex2)			  return to userspace err = -ESRCH
      update futex2->uval
      with new owner TID and set
      OWNER_DIED

    					 userspace handles -ESRCH

					 but futex2->uval has a valid TID
					 and OWNER_DIED set.

That's inconsistent state, the futex became a SNAFUtex and user space
cannot recover from that. At least not existing user space and we cannot
break that, right?

If the kernel returns -ESRCH then the futex value must be preserved (except
for the waiters bit being set, but that's not part of the problem at hand).

You cannot just look at the kernel state with futexes. We have to guarantee
consistent state between kernel and user space no matter what. And of
course we have to be careful about user space creating inconsistent state
for stupid or malicious reasons. See the whole state table above
attach_to_pi_state().

The only way to fix this live lock issue is to gracefully wait for the
cleanup to complete instead of busy looping.

Yes, it sucks, but futexes suck by definition.

Thanks,

	tglx
