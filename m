Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D103D45E3B
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfFNNcv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:32:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfFNNcv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:32:51 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbmJY-0005Aq-Ov; Fri, 14 Jun 2019 15:32:21 +0200
Date:   Fri, 14 Jun 2019 15:32:20 +0200 (CEST)
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
Subject: Re: [PATCHv4 03/28] posix-clocks: add another call back to return
 clock time in ktime_t
In-Reply-To: <20190612192628.23797-4-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1906141511440.1722@nanos.tec.linutronix.de>
References: <20190612192628.23797-1-dima@arista.com> <20190612192628.23797-4-dima@arista.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dmitry,

On Wed, 12 Jun 2019, Dmitry Safonov wrote:

> From: Andrei Vagin <avagin@gmail.com>
> 
> The callsite in common_timer_get() has already a comment:
>         /*
>          * The timespec64 based conversion is suboptimal, but it's not
>          * worth to implement yet another callback.
>          */
>         kc->clock_get(timr->it_clock, &ts64);
>         now = timespec64_to_ktime(ts64);
> 
> Now we are going to add time namespaces and we need to be able to get:

Please avoid 'we' and try to describe the changes in a neutral technical
form, e.g.:

 The upcoming support for time namespaces requires to have access to:

> * clock value in a task time namespace to return it from the clock_gettime
>   syscall.

  - The time in a tasks time namespace for sys_clock_gettime()

> * clock valuse in the root time namespace to use it in
>   common_timer_get().

  - The time in the root name space for common_timer_get()

> It looks like another reason why we need a separate callback to return
> clock value in ktime_t.

 That adds a valid reason to finally implement a separate callback which
 returns the time in ktime_t format.

Hmm?

> +int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp);
> +int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp);
>  #endif
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 0519a8805aab..68a163c8b4f2 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -43,6 +43,8 @@ static struct alarm_base {
>  	spinlock_t		lock;
>  	struct timerqueue_head	timerqueue;
>  	ktime_t			(*gettime)(void);
> +	int			(*get_timespec)(const clockid_t which_clock,
> +						struct timespec64 *tp);
>  	clockid_t		base_clockid;
>  } alarm_bases[ALARM_NUMTYPE];
>  
> @@ -645,21 +647,30 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
>  }
>  
>  /**
> - * alarm_clock_get - posix clock_get interface
> + * alarm_clock_get_timespec - posix clock_get_timespec interface
>   * @which_clock: clockid
>   * @tp: timespec to fill.
>   *
>   * Provides the underlying alarm base time.
>   */
> -static int alarm_clock_get(clockid_t which_clock, struct timespec64 *tp)
> +static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
>  {
>  	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
>  
>  	if (!alarmtimer_get_rtcdev())
>  		return -EINVAL;
>  
> -	*tp = ktime_to_timespec64(base->gettime());
> -	return 0;
> +	return base->get_timespec(base->base_clockid, tp);
> +}
> +
> +static ktime_t alarm_clock_get_ktime(clockid_t which_clock)

Please add kernel doc for this function. It does not make sense to have one
documented and the other not.

> +{
> +	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
> +
> +	if (!alarmtimer_get_rtcdev())
> +		return -EINVAL;
> +
> +	return base->gettime();
>  }
  
> --- a/kernel/time/posix-timers.h
> +++ b/kernel/time/posix-timers.h
> @@ -6,8 +6,11 @@ struct k_clock {
>  				struct timespec64 *tp);
>  	int	(*clock_set)(const clockid_t which_clock,
>  			     const struct timespec64 *tp);
> -	int	(*clock_get)(const clockid_t which_clock,
> -			     struct timespec64 *tp);
> +	/* return the clock value in the current time namespace. */
> +	int	(*clock_get_timespec)(const clockid_t which_clock,
> +				      struct timespec64 *tp);
> +	/* return the clock value in the root time namespace. */
> +	ktime_t	(*clock_get_ktime)(const clockid_t which_clock);
>  	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
>  	int	(*timer_create)(struct k_itimer *timer);
>  	int	(*nsleep)(const clockid_t which_clock, int flags,

TBH, this patch is way to big. It changes too many things at once. Can you
please structure it this way:

 1) Rename k_clock::clock_get to k_clock::clock_get_timespec and fix up all
    struct initializers

 2) Rename the clock_get_timespec functions per instance

 3) Add the new callback

 4) Add the new functions per instance and add them to the corresponding
    struct initializers

 5) Use the new callback

Thanks,

	tglx
