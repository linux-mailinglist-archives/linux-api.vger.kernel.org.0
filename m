Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6445E66
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfFNNiW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:38:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38041 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfFNNiW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:38:22 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbmOy-0005NV-SL; Fri, 14 Jun 2019 15:37:57 +0200
Date:   Fri, 14 Jun 2019 15:37:56 +0200 (CEST)
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
Subject: Re: [PATCHv4 06/28] timerfd/timens: Take into account ns clock
 offsets
In-Reply-To: <20190612192628.23797-7-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1906141534090.1722@nanos.tec.linutronix.de>
References: <20190612192628.23797-1-dima@arista.com> <20190612192628.23797-7-dima@arista.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 12 Jun 2019, Dmitry Safonov wrote:
> ---
>  fs/timerfd.c                   |  3 +++
>  include/linux/time_namespace.h | 18 ++++++++++++++++++
>  kernel/time_namespace.c        | 27 +++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)

Again, please split that into:

   1) Introduce the new function

   2) Make use of it

> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index 6a6fc8aa1de7..9b0c2f65e7e8 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -26,6 +26,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/compat.h>
>  #include <linux/rcupdate.h>
> +#include <linux/time_namespace.h>
>  
>  struct timerfd_ctx {
>  	union {
> @@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
>  	}
>  
>  	if (texp != 0) {
> +		if (flags & TFD_TIMER_ABSTIME)
> +			texp = timens_ktime_to_host(clockid, texp);
>  		if (isalarm(ctx)) {
>  			if (flags & TFD_TIMER_ABSTIME)
>  				alarm_start(&ctx->t.alarm, texp);
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> index 1dda8af6b9fe..d32b55fad953 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -56,6 +56,19 @@ static inline void timens_add_boottime(struct timespec64 *ts)
>                  *ts = timespec64_add(*ts, ns_offsets->boottime);
>  }
>  
> +ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
> +				struct timens_offsets *offsets);
> +static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
> +{
> +	struct timens_offsets *offsets = current->nsproxy->time_ns->offsets;
> +
> +	if (!offsets) /* fast-path for the root time namespace */

Can you please avoid tail comments. They break the reading flow. Aside of
that I don't see the value of documenting the obvious.

> +ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim, struct timens_offsets *ns_offsets)

Please line break the arguments

ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
				struct timens_offsets *ns_offsets)

> +{
> +	ktime_t koff;
> +
> +	switch (clockid) {
> +	case CLOCK_MONOTONIC:
> +		koff = timespec64_to_ktime(ns_offsets->monotonic);
> +		break;
> +	case CLOCK_BOOTTIME:
> +	case CLOCK_BOOTTIME_ALARM:
> +		koff = timespec64_to_ktime(ns_offsets->boottime);
> +		break;
> +	default:
> +		return tim;
> +	}
> +
> +	/* tim - off has to be in [0, KTIME_MAX) */

Please be more elaborate why the below conditions can happen at all.

> +	if (tim < koff)
> +		tim = 0;
> +	else if (KTIME_MAX - tim < -koff)
> +		tim = KTIME_MAX;
> +	else
> +		tim = ktime_sub(tim, koff);

Thanks,

	tglx
