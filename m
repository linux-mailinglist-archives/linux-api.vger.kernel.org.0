Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9848F464
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfHOTVu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 15:21:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfHOTVu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 15:21:50 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyLJL-0004V8-6e; Thu, 15 Aug 2019 21:21:23 +0200
Date:   Thu, 15 Aug 2019 21:21:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCHv6 22/36] x86/vdso: Add offsets page in vvar
In-Reply-To: <20190815163836.2927-23-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1908152117231.1908@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-23-dima@arista.com>
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

On Thu, 15 Aug 2019, Dmitry Safonov wrote:
> ---
>  arch/Kconfig                          |  5 +++
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/entry/vdso/vdso-layout.lds.S |  9 ++++-
>  arch/x86/entry/vdso/vdso2c.c          |  3 ++
>  arch/x86/entry/vdso/vma.c             | 12 +++++++
>  arch/x86/include/asm/vdso.h           |  1 +
>  init/Kconfig                          |  1 +
>  lib/vdso/gettimeofday.c               | 47 +++++++++++++++++++++++++++

This needs to be split into the generic lib/vdso part and then x86 making
use of it.

> +#ifdef CONFIG_TIME_NS

This should be COMPILE_WITH_TIME_NS and not CONFIG_TIME_NS

> +extern u8 timens_page
> +	__attribute__((visibility("hidden")));
> +
> +notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts)

This needs notrace because?

> +{
> +	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
> +	struct timespec64 *offset64;
> +
> +	switch (clk) {
> +	case CLOCK_MONOTONIC:
> +	case CLOCK_MONOTONIC_COARSE:
> +	case CLOCK_MONOTONIC_RAW:
> +		offset64 = &timens->monotonic;
> +		break;
> +	case CLOCK_BOOTTIME:
> +		offset64 = &timens->boottime;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/*
> +	 * The kernel allows to set a negative offset only if the current clock
> +	 * value in a namespace is positive, so the result tv_sec can't be
> +	 * negative here.
> +	 */
> +	ts->tv_nsec += offset64->tv_nsec;
> +	ts->tv_sec += offset64->tv_sec;
> +	if (ts->tv_nsec >= NSEC_PER_SEC) {
> +		ts->tv_nsec -= NSEC_PER_SEC;
> +		ts->tv_sec++;
> +	}
> +	if (ts->tv_nsec < 0) {
> +		ts->tv_nsec += NSEC_PER_SEC;
> +		ts->tv_sec--;
> +	}

That's broken for 32bit user space on 64bit hosts. On LE due to
misalignment and on BE because 32bit will read always 0.

> +}
> +#else
> +notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts) {}
> +#endif
> +
>  static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  		   struct __kernel_timespec *ts)
>  {
> @@ -65,6 +108,8 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>  	ts->tv_nsec = ns;
>  
> +	clk_to_ns(clk, ts);
> +
>  	return 0;
>  }
>  
> @@ -79,6 +124,8 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
>  		ts->tv_sec = vdso_ts->sec;
>  		ts->tv_nsec = vdso_ts->nsec;
>  	} while (unlikely(vdso_read_retry(vd, seq)));
> +
> +	clk_to_ns(clk, ts);
>  }
>  
>  static __maybe_unused int
> -- 
> 2.22.0
> 
> 
