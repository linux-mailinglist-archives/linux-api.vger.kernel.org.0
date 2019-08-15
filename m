Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D28F261
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfHORi2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 13:38:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHORi2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 13:38:28 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyJhN-0002YD-Mf; Thu, 15 Aug 2019 19:38:05 +0200
Date:   Thu, 15 Aug 2019 19:38:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 10/36] kernel: Add do_timens_ktime_to_host() helper
In-Reply-To: <20190815163836.2927-11-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1908151935320.1908@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-11-dima@arista.com>
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
> +ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
> +				struct timens_offsets *ns_offsets)
> +{
> +	ktime_t offset;
> +
> +	switch (clockid) {
> +	case CLOCK_MONOTONIC:
> +		offset = timespec64_to_ktime(ns_offsets->monotonic);
> +		break;
> +	case CLOCK_BOOTTIME:
> +	case CLOCK_BOOTTIME_ALARM:
> +		offset = timespec64_to_ktime(ns_offsets->boottime);
> +		break;
> +	default:
> +		return tim;
> +	}
> +
> +	/*
> +	 * Check that @tim value is in [offset, KTIME_MAX + offset]
> +	 * and subtract offset.
> +	 */
> +	if (tim < offset) {
> +		/*
> +		 * User can specify @tim *absolute* value - if it's lesser than
> +		 * the time namespace's offset - it's already expired.
> +		 */
> +		tim = 0;
> +	} else if (KTIME_MAX - tim < -offset) {
> +		/*
> +		 * User-supplied @tim may be close or even equal KTIME_MAX
> +		 * and time namespace offset can be negative.
> +		 * Let's check (tim - offset) for an overflow.
> +		 * Return KTIME_MAX in such case, as the time value is
> +		 * thousands *years* in future anyway.
> +		 */
> +		tim = KTIME_MAX;
> +	} else {
> +		tim = ktime_sub(tim, offset);
> +	}

While the overflow check is correct, wouldn't it be more intuitive to do:

      	  	tim = ktime_sub(tim, offset);
		if (unlikely(tim > KTIME_MAX))
			tim = KTIME_MAX;

Thanks,

	tglx
