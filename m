Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E1045F6B
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfFNNuF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:50:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38121 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfFNNuF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:50:05 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbmaD-000634-8y; Fri, 14 Jun 2019 15:49:33 +0200
Date:   Fri, 14 Jun 2019 15:49:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv4 08/28] timens/kernel: Take into account timens clock
 offsets in clock_nanosleep
In-Reply-To: <20190612192628.23797-9-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1906141542520.1722@nanos.tec.linutronix.de>
References: <20190612192628.23797-1-dima@arista.com> <20190612192628.23797-9-dima@arista.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 12 Jun 2019, Dmitry Safonov wrote:

Again the subsystem prefix is something pulled out of thin air.

> From: Andrei Vagin <avagin@gmail.com>
> 
> Wire up clock_nanosleep() to timens offsets.
> 
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/hrtimer.h    |  2 +-
>  kernel/time/alarmtimer.c   |  2 ++
>  kernel/time/hrtimer.c      |  8 ++++----
>  kernel/time/posix-stubs.c  | 12 ++++++++++--
>  kernel/time/posix-timers.c | 19 ++++++++++++++++---
>  5 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
> index 2e8957eac4d4..5a3b3e17d0e8 100644
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -473,7 +473,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
>  /* Precise sleep: */
>  
>  extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
> -extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
> +extern long hrtimer_nanosleep(ktime_t rqtp,
>  			      const enum hrtimer_mode mode,
>  			      const clockid_t clockid);
>  
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 6346e6ee0d32..f1f42df179d0 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -819,6 +819,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
>  		ktime_t now = alarm_bases[type].gettime();
>  
>  		exp = ktime_add_safe(now, exp);
> +	} else {
> +		exp = timens_ktime_to_host(which_clock, exp);
>  	}

This one is independent of the hrtimer part. Please split it out into

 Subject: alarmtimer: Make nanosleep time namespace aware

 
>  	ret = alarmtimer_do_nsleep(&alarm, exp, type);
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 41dfff23c1f9..b245f6ff9c8f 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1716,7 +1716,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
>  	return ret;
>  }
>  
> -long hrtimer_nanosleep(const struct timespec64 *rqtp,
> +long hrtimer_nanosleep(ktime_t rqtp,
>  		       const enum hrtimer_mode mode, const clockid_t clockid)

This signature change wants to be separate.

  Subject: hrtimers: Prepare hrtimer_nanosleep() for time namespaces

>  {
>  	struct restart_block *restart;
> @@ -1729,7 +1729,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
>  		slack = 0;
>  
>  	hrtimer_init_on_stack(&t.timer, clockid, mode);
> -	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
> +	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
>  	ret = do_nanosleep(&t, mode);
>  	if (ret != -ERESTART_RESTARTBLOCK)
>  		goto out;
> @@ -1764,7 +1764,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
>  
>  	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
>  	current->restart_block.nanosleep.rmtp = rmtp;
> -	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
> +	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
>  }
>  
>  #endif
> @@ -1784,7 +1784,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
>  
>  	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
>  	current->restart_block.nanosleep.compat_rmtp = rmtp;
> -	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
> +	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
>  }
>  #endif
>  
> diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
> index edaf075d1ee4..4ee0dc180866 100644
> --- a/kernel/time/posix-stubs.c
> +++ b/kernel/time/posix-stubs.c
> @@ -129,6 +129,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
>  		struct __kernel_timespec __user *, rmtp)
>  {
>  	struct timespec64 t;
> +	ktime_t texp;
>  
>  	switch (which_clock) {
>  	case CLOCK_REALTIME:
> @@ -147,7 +148,10 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
>  		rmtp = NULL;
>  	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
>  	current->restart_block.nanosleep.rmtp = rmtp;
> -	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
> +	texp = timespec64_to_ktime(t);
> +	if (flags & TIMER_ABSTIME)
> +		texp = timens_ktime_to_host(clockid, texp;

And then add actual name space support with:

  Subject: posix-timers: Make clock_nanosleep() time namespace aware

> +	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
>  				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
>  				 which_clock);
>  }

Thanks,

	tglx
