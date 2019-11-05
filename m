Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E8F0415
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbfKER2s (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 12:28:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42190 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388790AbfKER2r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 12:28:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iS2d8-0000fV-Q3; Tue, 05 Nov 2019 18:28:35 +0100
Date:   Tue, 5 Nov 2019 18:28:33 +0100 (CET)
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
In-Reply-To: <20191105152728.GA5666@redhat.com>
Message-ID: <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <20191105152728.GA5666@redhat.com>
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

On Tue, 5 Nov 2019, Oleg Nesterov wrote:
> On 11/05, Thomas Gleixner wrote:
> >
> > Out of curiosity, what's the race issue vs. robust list which you are
> > trying to solve?
> 
> Off-topic, but this reminds me...
> 
> 	#include <sched.h>
> 	#include <assert.h>
> 	#include <unistd.h>
> 	#include <syscall.h>
> 
> 	#define FUTEX_LOCK_PI		6
> 
> 	int main(void)
> 	{
> 		struct sched_param sp = {};
> 
> 		sp.sched_priority = 2;
> 		assert(sched_setscheduler(0, SCHED_FIFO, &sp) == 0);
> 
> 		int lock = vfork();
> 		if (!lock) {
> 			sp.sched_priority = 1;
> 			assert(sched_setscheduler(0, SCHED_FIFO, &sp) == 0);
> 			_exit(0);
> 		}
> 
> 		syscall(__NR_futex, &lock, FUTEX_LOCK_PI, 0,0,0);
> 		return 0;
> 	}
> 
> this creates the unkillable RT process spinning in futex_lock_pi() on
> a single CPU machine (or you can use taskset).

Uuurgh.

> Probably the patch below makes sense anyway, but of course it doesn't
> solve the real problem: futex_lock_pi() should not spin in this case.

Obviously not.

> It seems to me I even sent the fix a long ago, but I can't recall what
> exactly it did. Probably the PF_EXITING check in attach_to_pi_owner()
> must simply die, I'll try to recall...

We can't do that. The task might have released the futex already, so the
waiter would operate on inconsistent state :(

The problem with that exit race is that there is no form of serialization
which might be used to address that. We can't abuse any of the task locks
for this.

I was working on a patch set some time ago to fix another more esoteric
futex exit issue. Let me resurrect that.

Vs. the signal pending check. That makes sense on its own, but we should
not restrict it to fatal signals. Futexes are interruptible by definition.

Thanks,

	tglx
