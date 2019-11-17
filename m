Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89ACFF8D0
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 12:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfKQLC3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 06:02:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:16703 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQLC3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 06:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573988546;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CLtEbrqUYKD2wQNQMuHkpIC0PxqzpBsG0RbyF4DIpxI=;
        b=EelJndJnzMGtFwrCoFBJHQi94kJFv3h6YGN+jWEXmhzovP02CGELJG64I46RAARcAm
        wuWtUTvsCqu0acPaqGD7Qpy5FQExJEh16nzCxMRpgHBKRzgPflGq2cAy0GFiV5++Mbqy
        w82Rm2PEokvjW8n3H8owuHV+rX38IUJkr59YiuEU47C1DRXoxw7iBP9vdVdOLFAvF4SP
        4mxKzVTCAZ0bAHofYUAfsXf6TIxz/KdHZvxh+yyTLfJj/Z/r+4q3sikFc7Juc7VKe8Zt
        kDcIaL0w+wADO9ZNt1anhGjrCVtNudQe015zCT/jlIUgV4eIB5ZcXhDowi0F4i2unu3m
        rcSw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbIvSfb0y2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAHB1FVSv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 12:01:15 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Nicolai Stange <nstange@suse.de>
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
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 01/12] Linux Random Number Generator
Date:   Sun, 17 Nov 2019 12:01:15 +0100
Message-ID: <4567011.rgkcMjRUIa@positron.chronox.de>
In-Reply-To: <87mucvadvg.fsf@suse.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2645285.kI0haNqfm4@positron.chronox.de> <87mucvadvg.fsf@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Samstag, 16. November 2019, 19:13:23 CET schrieb Nicolai Stange:

Hi Nicolai,

> Hi Stephan,
>=20
> Stephan M=FCller <smueller@chronox.de> writes:
> > +/* Initialize the default DRNG during boot */
>=20
> I think that this can get called a bit too early through the
> get_random_bytes() invoked from e.g. boot_init_stack_canary(): in
> start_kernel(), there is
>=20
> 	boot_init_stack_canary();
>=20
> 	time_init();
>=20
> On ARM (at least with arm_arch_timer.c), get_cycles() would return 0
> until
>=20
>   time_init() =3D> timer_probe() =3D> arch_timer_of_init() =3D>
>   arch_timer_common_init() =3D> arch_timer_arch_init() =3D>
>   arch_timer_delay_timer_register() =3D> register_current_timer_delay()
>=20
> has executed and thus, ...
>=20
> > +void lrng_drngs_init_cc20(void)
> > +{
> > +	unsigned long flags =3D 0;
> > +
> > +	if (lrng_get_available())
> > +		return;
> > +
> > +	lrng_sdrng_lock(&lrng_sdrng_init, &flags);
> > +	if (lrng_get_available()) {
> > +		lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
> > +		return;
> > +	}
> > +
> > +	if (random_get_entropy() || random_get_entropy()) {
> > +		/*
> > +		 * As the highres timer is identified here, previous interrupts
> > +		 * obtained during boot time are treated like a lowres-timer
> > +		 * would have been present.
> > +		 */
> > +		lrng_pool_configure(true, LRNG_IRQ_ENTROPY_BITS);
> > +	} else {
> > +		lrng_health_disable();
> > +		lrng_pool_configure(false, LRNG_IRQ_ENTROPY_BITS *
> > +					   LRNG_IRQ_OVERSAMPLING_FACTOR);
> > +		pr_warn("operating without high-resolution timer and applying "
> > +			"IRQ oversampling factor %u\n",
> > +			LRNG_IRQ_OVERSAMPLING_FACTOR);
>=20
> ... LRNG thinks that no high-res timer is available even though there
> is:
>=20
> [    0.000000] lrng_sdrng: operating without high-resolution timer and
> applying IRQ oversampling factor 10 [    0.000000] lrng_chacha20: ChaCha20
> core initialized
> [    0.000000] lrng_chacha20: ChaCha20 core initialized
> [    0.000014] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps
> every 2147483647500ns [    0.000036] clocksource: timer: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns [    0.000114]
> bcm2835: system timer (irq =3D 27)
> [    0.000594] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
> [    0.000613] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns [    0.000631]
> sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078=
ns
> [    0.000645] Switching to timer-based delay loop, resolution 52ns
>=20
> Note that this last line comes from aforementioned
> register_current_timer_delay().
>=20
> Similarly, get_random_bytes() can get called quite early through
> WARN() =3D> warn_slowpath_fmt() =3D> __warn() =3D> print_oops_end_marker(=
) =3D>
> init_oops_id().
>=20
> Perhaps it would make sense not to do the (pool + health test)
> initalization "on-demand", but rather make sure it happens at some
> well-defined point after time_init()? Or at least that the pool +
> the health tests get reconfigured eventually?


Thank you very much for testing this and reporting it.

I have extracted the initialization of the time source into its own functio=
n=20
and execute it with core_initcall. With that, the DRNG is initialized at th=
e=20
time it needs initialization.

But the time source check is now done when time_init is completed as first=
=20
time_init is called and then arch_call_rest_init -> rest_init -> kernel_ini=
t -
> kernel_init_freeable -> do_basic_setup -> do_initcalls where the initcall=
s=20
registered with the core_initcall callback are now executed as the first=20
batch.


>=20
>=20
> Thanks,
>=20
> Nicolai
>=20
> P.S: include/linux/lrng.h needs an #include <linux/errno.h> for
>      CONFIG_LRNG_DRNG_SWITCH=3Dn

Thank you, added.
>=20
> > +	}
> > +
> > +	lrng_sdrng_reset(&lrng_sdrng_init);
> > +	lrng_cc20_init_state(&secondary_chacha20);
> > +	lrng_state_init_seed_work();
> > +	lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
> > +
> > +	lrng_sdrng_lock(&lrng_sdrng_atomic, &flags);
> > +	lrng_sdrng_reset(&lrng_sdrng_atomic);
> > +	/*
> > +	 * We do not initialize the state of the atomic DRNG as it is identic=
al
> > +	 * to the secondary DRNG at this point.
> > +	 */
> > +	lrng_sdrng_unlock(&lrng_sdrng_atomic, &flags);
> > +
> > +	lrng_trng_init();
> > +
> > +	lrng_set_available();
> > +}
> > +
> > +/* Reset LRNG such that all existing entropy is gone */


Ciao
Stephan


