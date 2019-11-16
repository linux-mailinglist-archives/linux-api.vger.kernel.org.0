Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1637FF49E
	for <lists+linux-api@lfdr.de>; Sat, 16 Nov 2019 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKPSN2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Sat, 16 Nov 2019 13:13:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:50332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfKPSN2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 16 Nov 2019 13:13:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB08FB15A;
        Sat, 16 Nov 2019 18:13:25 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter\, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 01/12] Linux Random Number Generator
References: <6157374.ptSnyUpaCn@positron.chronox.de>
        <2787174.DQlWHN5GGo@positron.chronox.de>
        <2645285.kI0haNqfm4@positron.chronox.de>
Date:   Sat, 16 Nov 2019 19:13:23 +0100
In-Reply-To: <2645285.kI0haNqfm4@positron.chronox.de> ("Stephan
 \=\?utf-8\?Q\?M\=C3\=BCller\=22's\?\=
        message of "Sat, 16 Nov 2019 10:33:20 +0100")
Message-ID: <87mucvadvg.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Stephan,

Stephan Müller <smueller@chronox.de> writes:

> +/* Initialize the default DRNG during boot */

I think that this can get called a bit too early through the
get_random_bytes() invoked from e.g. boot_init_stack_canary(): in
start_kernel(), there is

	boot_init_stack_canary();

	time_init();

On ARM (at least with arm_arch_timer.c), get_cycles() would return 0
until

  time_init() => timer_probe() => arch_timer_of_init() =>
  arch_timer_common_init() => arch_timer_arch_init() =>
  arch_timer_delay_timer_register() => register_current_timer_delay()

has executed and thus, ...

> +void lrng_drngs_init_cc20(void)
> +{
> +	unsigned long flags = 0;
> +
> +	if (lrng_get_available())
> +		return;
> +
> +	lrng_sdrng_lock(&lrng_sdrng_init, &flags);
> +	if (lrng_get_available()) {
> +		lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
> +		return;
> +	}
> +
> +	if (random_get_entropy() || random_get_entropy()) {
> +		/*
> +		 * As the highres timer is identified here, previous interrupts
> +		 * obtained during boot time are treated like a lowres-timer
> +		 * would have been present.
> +		 */
> +		lrng_pool_configure(true, LRNG_IRQ_ENTROPY_BITS);
> +	} else {
> +		lrng_health_disable();
> +		lrng_pool_configure(false, LRNG_IRQ_ENTROPY_BITS *
> +					   LRNG_IRQ_OVERSAMPLING_FACTOR);
> +		pr_warn("operating without high-resolution timer and applying "
> +			"IRQ oversampling factor %u\n",
> +			LRNG_IRQ_OVERSAMPLING_FACTOR);


... LRNG thinks that no high-res timer is available even though there
is:

[    0.000000] lrng_sdrng: operating without high-resolution timer and applying IRQ oversampling factor 10
[    0.000000] lrng_chacha20: ChaCha20 core initialized
[    0.000000] lrng_chacha20: ChaCha20 core initialized
[    0.000014] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.000036] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.000114] bcm2835: system timer (irq = 27)
[    0.000594] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
[    0.000613] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000631] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000645] Switching to timer-based delay loop, resolution 52ns

Note that this last line comes from aforementioned
register_current_timer_delay().

Similarly, get_random_bytes() can get called quite early through
WARN() => warn_slowpath_fmt() => __warn() => print_oops_end_marker() =>
init_oops_id().

Perhaps it would make sense not to do the (pool + health test)
initalization "on-demand", but rather make sure it happens at some
well-defined point after time_init()? Or at least that the pool +
the health tests get reconfigured eventually?


Thanks,

Nicolai

P.S: include/linux/lrng.h needs an #include <linux/errno.h> for
     CONFIG_LRNG_DRNG_SWITCH=n


> +	}
> +
> +	lrng_sdrng_reset(&lrng_sdrng_init);
> +	lrng_cc20_init_state(&secondary_chacha20);
> +	lrng_state_init_seed_work();
> +	lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
> +
> +	lrng_sdrng_lock(&lrng_sdrng_atomic, &flags);
> +	lrng_sdrng_reset(&lrng_sdrng_atomic);
> +	/*
> +	 * We do not initialize the state of the atomic DRNG as it is identical
> +	 * to the secondary DRNG at this point.
> +	 */
> +	lrng_sdrng_unlock(&lrng_sdrng_atomic, &flags);
> +
> +	lrng_trng_init();
> +
> +	lrng_set_available();
> +}
> +
> +/* Reset LRNG such that all existing entropy is gone */

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer
