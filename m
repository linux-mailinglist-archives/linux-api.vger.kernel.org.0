Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6CF05D2
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 20:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbfKETTX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 14:19:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390856AbfKETTW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 14:19:22 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iS4MH-0002Zo-5d; Tue, 05 Nov 2019 20:19:17 +0100
Date:   Tue, 5 Nov 2019 20:19:15 +0100 (CET)
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
In-Reply-To: <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <20191105152728.GA5666@redhat.com> <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de> <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
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

On Tue, 5 Nov 2019, Thomas Gleixner wrote:
> 
> I'm a moron. It's vfork() not fork() so the behaviour is expected.
> 
> Staring more at the trace which shows me where this goes down the drain.

 parent	    	    	child
 
  set FIFO prio 2
 
  vfork()			->	set FIFO prio 1
   implies wait_for_child()	 	sched_setscheduler(...)
 			   		exit()
					do_exit()
					tsk->flags |= PF_EXITING;
 					....
					mm_release()
					  exit_futex(); (NOOP in this case)
					  complete() --> wakes parent
 sys_futex()
    loop infinite because
    	 PF_EXITING is set,
	 but PF_EXITPIDONE not

So the obvious question is why PF_EXITPIDONE is set way after the futex
exit cleanup has run, but moving this right after exit_futex() would not
solve the exit race completely because the code after setting PF_EXITING is
preemptible. So the same crap could happen just by preemption:

  task holds futex
  ...
  do_exit()
    tsk->flags |= PF_EXITING;

preemption (unrelated wakeup of some other higher prio task, e.g. timer)

  switch_to(other_task)

  return to user
  sys_futex()
	loop infinite as above

And just for the fun of it the futex exit cleanup could trigger the wakeup
itself before PF_EXITPIDONE is set.

There is some other issue which I need to lookup again. That's a slightly
different problem but related to futex exit race conditions.

The way we can deal with that is:

    do_exit()
    tsk->flags |= PF_EXITING;
    ...
    mutex_lock(&tsk->futex_exit_mutex);
    futex_exit();
    tsk->flags |= PF_EXITPIDONE;
    mutex_unlock(&tsk->futex_exit_mutex);
    
and on the futex lock_pi side:

    if (!(tsk->flags & PF_EXITING))
    	return 0;		<- All good

    if (tsk->flags & PF_EXITPIDONE)
        return -EOWNERDEAD;	<- Locker can take over

    mutex_lock(&tsk->futex_exit_mutex);
    if (tsk->flags & PF_EXITPIDONE) {
        mutex_unlock(&tsk->futex_exit_mutex);
        return -EOWNERDEAD;	<- Locker can take over
    }

    queue_futex();
    mutex_unlock(&tsk->futex_exit_mutex);

Not that I think it's pretty, but it plugs all holes AFAICT.

Thanks,

	tglx
