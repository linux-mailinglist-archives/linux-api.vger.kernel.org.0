Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F9F9A17
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKLT6k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 14:58:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44410 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLT6j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 14:58:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id z188so6682868lfa.11;
        Tue, 12 Nov 2019 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=qwHy+UFtzMoDTw3ZqlgozsMHWsnuGCbJFY4GmJOspJM=;
        b=fdDRXsadmJ23SumAhe2pcn8KjFBJpk8cv9QzTM7GcLWvJoFFRJ5IpKKGSldRVWB2K1
         GD5KBGnjOyHsYsZQPp+Xt0j+PVkgCK6ZLgMKVNuV3IZq+ODcZ/x0ICpDG/h7BBSE+OOU
         g0d4UN2L4kEM3ZR1db4d8TizokrxALABox38GHVALwkitIyvITYCLZVJUvAQmSt16Ias
         IlhjmIDnxayrMHiwKRYUZosB2s/LXWfWlurMnt2Fhr7PtEG6Ph25wU2lWYRhEa/ot0lN
         +yQ/ZXpvgqJyHjv631dWxWCGqijGRyQsus6QIvag6suZlT5/fcXe3HxlE7DIaoQsebjB
         /Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=qwHy+UFtzMoDTw3ZqlgozsMHWsnuGCbJFY4GmJOspJM=;
        b=keCQL3UtyUvZV1+PoqSIBf8gOtaX+Rihsk1Dv3vZX2jP6iWpe1FxWiwWHsXDiXDPaa
         nXJFi3xUQc0rhjMnm1q8emsXyXbnZqwQ77AIh4Wofc4aJQqLoHh2o8G4yvSKwEurUVIv
         J0OyTRALXF0a3qW4ZyRqP+4idFLgi4rnUZUM9kEgLQevl41g7nIGNJJ5/+d3oOpVLp3m
         S/I1jEEbj+ugk9G0EUrMu5SFR6BYsOUmvDIW54H8gj18CmMvCVSX0OZRo8UuGyKzEpwL
         +mKnKWWSZuenq/Rdx0U3+uQgwz636YXDXqDzRjfQ9C0WUxuh2R7HDz3HkjnKJBAhLe9+
         k1tA==
X-Gm-Message-State: APjAAAW5p9X9CSFs9v+KfLjdua9/abJ1p1xehBsp5u1ny6Jz6jNAZrV3
        LCZPq4qgasegkT99BQ/sSfE=
X-Google-Smtp-Source: APXvYqwxInTHKkrbjdbkGM3kbecrvSy4HgoEwtbBYYPXJ8PnUejYDa5opKdS8yjjh2AyFVdZckBItQ==
X-Received: by 2002:a19:6a03:: with SMTP id u3mr6890518lfu.25.1573588715704;
        Tue, 12 Nov 2019 11:58:35 -0800 (PST)
Received: from ?IPv6:2a02:17d0:4a6:5700:d63d:7eff:fed9:a39? ([2a02:17d0:4a6:5700:d63d:7eff:fed9:a39])
        by smtp.googlemail.com with ESMTPSA id d5sm7897662ljc.51.2019.11.12.11.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:58:34 -0800 (PST)
Subject: Re: [PATCH v24 11/12] LRNG - add SP800-90B compliant health tests
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <3385183.Cb3iLDTLdO@positron.chronox.de>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <556c89ae-4272-970d-1644-cb77dc3c7946@gmail.com>
Date:   Wed, 13 Nov 2019 00:58:32 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3385183.Cb3iLDTLdO@positron.chronox.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010406030209040506020009"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010406030209040506020009
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

11.11.2019 23:26, Stephan M=C3=BCller =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Implement health tests for LRNG's slow noise sources as mandated by
> SP-800-90B The file contains the following health tests:
>=20
> - stuck test: The stuck test calculates the first, second and third
>    discrete derivative of the time stamp to be processed by the LFSR.
>    Only if all three values are zero, the received time delta is
>    considered to be non-stuck.

The other way round?
>=20
> - SP800-90B Repetition Count Test (RCT): The LRNG uses an enhanced
>    version of the RCT specified in SP800-90B section 4.4.1. Instead of
>    counting identical back-to-back values, the input to the RCT is the
>    counting of the stuck values during the processing of received
>    interrupt events. The RCT is applied with alpha=3D2^-30 compliant to=

>    the recommendation of FIPS 140-2 IG 9.8. During the counting operati=
on,
>    the LRNG always calculates the RCT cut-off value of C. If that value=

>    exceeds the allowed cut-off value, the LRNG will trigger the health
>    test failure discussed below. An error is logged to the kernel log
>    that such RCT failure occurred. This test is only applied and
>    enforced in FIPS mode, i.e. when the kernel compiled with
>    CONFIG_CONFIG_FIPS is started with fips=3D1.
>=20
> - SP800-90B Adaptive Proportion Test (APT): The LRNG implements the
>    APT as defined in SP800-90B section 4.4.2. The assumed

The sentence ends in the middle.

>=20
> The aforementioned health tests are applied to the first 1,024 time sta=
mps
> obtained from interrupt events. In case one error is identified for eit=
her
> the RCT, or the APT, the collected entropy is invalidated and the
> SP800-90B startup health test is restarted.
>=20
> As long as the SP800-90B startup health test is not completed, all LRNG=

> random number output interfaces that may block will block and not gener=
ate
> any data. This implies that only those potentially blocking interfaces =
are
> defined to provide random numbers that are seeded with the interrupt no=
ise
> source being SP800-90B compliant. All other output interfaces will not =
be
> affected by the SP800-90B startup test and thus are not considered
> SP800-90B compliant.
>=20
> At runtime, the SP800-90B APT and RCT are applied to each time stamp
> generated for a received interrupt. When either the APT and RCT indicat=
es
> a noise source failure, the LRNG is reset to a state it has immediately=

> after boot:
>=20
> - all entropy counters are set to zero
>=20
> - the SP800-90B startup tests are re-performed which implies that
> getrandom(2) would block again until new entropy was collected
>=20
> To summarize, the following rules apply:
>=20
> =E2=80=A2 SP800-90B compliant output interfaces
>=20
>    - /dev/random
>=20
>    - getrandom(2) system call
>=20
>    -  get_random_bytes kernel-internal interface when being triggered b=
y
>       the callback registered with add_random_ready_callback
>=20
> =E2=80=A2 SP800-90B non-compliant output interfaces
>=20
>    - /dev/urandom
>=20
>    - get_random_bytes kernel-internal interface called directly
>=20
>    - randomize_page kernel-internal interface
>=20
>    - get_random_u32 and get_random_u64 kernel-internal interfaces
>=20
>    - get_random_u32_wait, get_random_u64_wait, get_random_int_wait, and=

>      get_random_long_wait kernel-internal interfaces
>=20
> If either the RCT, or the APT health test fails irrespective whether
> during initialization or runtime, the following actions occur:
>=20
>    1. The entropy of the entire entropy pool is invalidated.
>=20
>    2. The primary and all secondary DRNGs are reset which imply that th=
ey
>       are treated as being not seeded and require a reseed during next
>       invocation.
>=20
>    3. The SP800-90B startup health test are initiated with all
>       implications of the startup tests. That implies that from that po=
int
>       on, new events must be observed and its entropy must be inserted =
into
>       the entropy pool before random numbers are calculated from the
>       entropy pool.
>=20
> Further details on the SP800-90B compliance and the availability of all=

> test tools required to perform all tests mandated by SP800-90B are
> provided at [1].
>=20
> The entire health testing code is compile-time configurable.
>=20
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> CC: Willy Tarreau <w@1wt.eu>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: Vito Caputo <vcaputo@pengaru.com>
> CC: Andreas Dilger <adilger.kernel@dilger.ca>
> CC: Jan Kara <jack@suse.cz>
> CC: Ray Strode <rstrode@redhat.com>
> CC: William Jon McCann <mccann@jhu.edu>
> CC: zhangjs <zachary@baishancloud.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: Lennart Poettering <mzxreary@0pointer.de>
> CC: Nicolai Stange <nstange@suse.de>
> Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
> Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Tested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>   drivers/char/lrng/Kconfig       |  13 +
>   drivers/char/lrng/Makefile      |   1 +
>   drivers/char/lrng/lrng_health.c | 424 +++++++++++++++++++++++++++++++=
+
>   3 files changed, 438 insertions(+)
>   create mode 100644 drivers/char/lrng/lrng_health.c
>=20
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index efc5f9aaa2a3..4373a1a19538 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -113,4 +113,17 @@ config LRNG_TRNG_SUPPORT
>   	  With the TRNG support the /dev/random device will block
>   	  if insufficient entropy is available.
>  =20
> +config LRNG_HEALTH_TESTS
> +	bool "Enable noise source online health tests"
> +	help
> +	  The online health tests validate the noise source at
> +	  runtime for fatal errors. These tests include SP800-90B
> +	  compliant tests which are invoked if the system is booted
> +	  with fips=3D1. In case of fatal errors during active
> +	  SP800-90B tests, the issue is logged and the noise
> +	  data is discarded. These tests are required for full
> +	  compliance with SP800-90B.

How have you tested that these tests work at runtime? Maybe add some=20
code under a new CONFIG item that depends on CONFIG_BROKEN that=20
deliberately botches the RNG and triggers failures?

> +
> +	  If unsure, say Y.
> +
>   endif # LRNG
> diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
> index 1c72bc060bce..0713e9c0aa6e 100644
> --- a/drivers/char/lrng/Makefile
> +++ b/drivers/char/lrng/Makefile
> @@ -15,3 +15,4 @@ obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
>   obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
>   obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
>   obj-$(CONFIG_LRNG_TRNG_SUPPORT)	+=3D lrng_trng.o
> +obj-$(CONFIG_LRNG_HEALTH_TESTS)	+=3D lrng_health.o
> diff --git a/drivers/char/lrng/lrng_health.c b/drivers/char/lrng/lrng_h=
ealth.c
> new file mode 100644
> index 000000000000..b8d96cec1f71
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_health.c
> @@ -0,0 +1,424 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Linux Random Number Generator (LRNG) Health Testing
> + *
> + * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
> + *
> + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> + * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=

> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> + * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> + * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUC=
H
> + * DAMAGE.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/fips.h>
> +#include <linux/module.h>
> +
> +#include "lrng_internal.h"
> +
> +/* Stuck Test */
> +struct lrng_stuck_test {
> +	u32 last_time;		/* Stuck test: time of previous IRQ */
> +	u32 last_delta;		/* Stuck test: delta of previous IRQ */
> +	u32 last_delta2;	/* Stuck test: 2. time derivation of prev IRQ */
> +};
> +
> +/* Repetition Count Test */
> +struct lrng_rct {
> +	atomic_t rct_count;	/* Number of stuck values */
> +};
> +
> +/* Adaptive Proportion Test */
> +struct lrng_apt {
> +	/* Taken from SP800-90B sec 4.4.2 - significance level 2^-30 */
> +#define LRNG_APT_CUTOFF		325
> +	/* Data window size */
> +#define LRNG_APT_WINDOW_SIZE	512
> +	/* LSB of time stamp to process */
> +#define LRNG_APT_LSB		16
> +#define LRNG_APT_WORD_MASK	(LRNG_APT_LSB - 1)
> +	atomic_t apt_count;		/* APT counter */
> +	atomic_t apt_base;		/* APT base reference */
> +
> +	atomic_t apt_trigger;
> +	bool apt_base_set;	/* Is APT base set? */
> +};
> +
> +/* The health test code must operate lock-less */
> +struct lrng_health {
> +	struct lrng_rct rct;
> +	struct lrng_apt apt;
> +
> +	bool health_test_enabled;
> +
> +	/* SP800-90B startup health tests */
> +#define LRNG_SP80090B_STARTUP_SAMPLES  1024
> +#define LRNG_SP80090B_STARTUP_BLOCKS   ((LRNG_SP80090B_STARTUP_SAMPLES=
 + \
> +					 LRNG_APT_WINDOW_SIZE - 1) /    \
> +					LRNG_APT_WINDOW_SIZE)
> +	bool sp80090b_startup_done;
> +	atomic_t sp80090b_startup_blocks;
> +};
> +
> +static struct lrng_health lrng_health =3D {
> +	.rct.rct_count =3D ATOMIC_INIT(0),
> +
> +	.apt.apt_count =3D ATOMIC_INIT(0),
> +	.apt.apt_base =3D ATOMIC_INIT(-1),
> +	.apt.apt_trigger =3D ATOMIC_INIT(LRNG_APT_WINDOW_SIZE),
> +	.apt.apt_base_set =3D false,
> +
> +	.health_test_enabled =3D true,
> +
> +	.sp80090b_startup_blocks =3D ATOMIC_INIT(LRNG_SP80090B_STARTUP_BLOCKS=
),
> +	.sp80090b_startup_done =3D false,
> +};
> +
> +static DEFINE_PER_CPU(struct lrng_stuck_test, lrng_stuck_test);
> +
> +static inline bool lrng_sp80090b_health_requested(void)
> +{
> +	/* Health tests are only requested in FIPS mode */
> +	return fips_enabled;
> +}
> +
> +static inline bool lrng_sp80090b_health_enabled(void)
> +{
> +	struct lrng_health *health =3D &lrng_health;
> +
> +	return lrng_sp80090b_health_requested() && health->health_test_enable=
d;
> +}
> +
> +/*********************************************************************=
******
> + * SP800-90B Compliance
> + *
> + * If the Linux-RNG is booted into FIPS mode, the following interfaces=

> + * provide an SP800-90B compliant noise source:
> + *
> + * * /dev/random
> + * * getrandom(2)
> + * * get_random_bytes when using it in conjunction with
> + *   add_random_ready_callback
> + *
> + * All other interfaces, including /dev/urandom or get_random_bytes wi=
thout
> + * the add_random_ready_callback cannot claim to use an SP800-90B comp=
liant
> + * noise source.
> + *********************************************************************=
******/
> +
> +/**
> + * Perform SP800-90B startup testing
> + */
> +static inline void lrng_sp80090b_startup(struct lrng_health *health)
> +{
> +	if (!health->sp80090b_startup_done &&
> +	    atomic_dec_and_test(&health->sp80090b_startup_blocks)) {
> +		health->sp80090b_startup_done =3D true;
> +		pr_info("SP800-90B startup health tests completed\n");
> +		lrng_init_ops(0);
> +
> +		/*
> +		 * Force a reseed of secondary DRNGs to ensure they are
> +		 * seeded with entropy that passed the SP800-90B health tests.
> +		 * As the primary DRNG always will reseed before generating
> +		 * random numbers, it does not need a reseed trigger.
> +		 */
> +		lrng_sdrng_force_reseed();
> +	}
> +}
> +
> +/**
> + * Handle failure of SP800-90B startup testing
> + */
> +static inline void lrng_sp80090b_startup_failure(struct lrng_health *h=
ealth)
> +{
> +	/* Reset of LRNG and its entropy - NOTE: we are in atomic context */
> +	lrng_reset();
> +
> +	/*
> +	 * Reset the SP800-90B startup test.
> +	 *
> +	 * NOTE SP800-90B section 4.3 bullet 4 does not specify what
> +	 * exactly is to be done in case of failure! Thus, we do what
> +	 * makes sense, i.e. restarting the health test and thus gating
> +	 * the output function of /dev/random and getrandom(2).
> +	 */
> +	atomic_set(&health->sp80090b_startup_blocks,
> +		   LRNG_SP80090B_STARTUP_BLOCKS);
> +}
> +
> +/**
> + * Handle failure of SP800-90B runtime testing
> + */
> +static inline void lrng_sp80090b_runtime_failure(struct lrng_health *h=
ealth)
> +{
> +	lrng_sp80090b_startup_failure(health);
> +	health->sp80090b_startup_done =3D false;
> +}
> +
> +static inline void lrng_sp80090b_failure(struct lrng_health *health)
> +{
> +	if (health->sp80090b_startup_done) {
> +		pr_err("SP800-90B runtime health test failure - invalidating "
> +		       "all existing entropy and initiate SP800-90B startup\n");
> +		lrng_sp80090b_runtime_failure(health);
> +	} else {
> +		pr_err("SP800-90B startup test failure - resetting\n");
> +		lrng_sp80090b_startup_failure(health);
> +	}
> +}
> +
> +/**
> + * Is the SP800-90B startup testing complete?
> + *
> + * This function is called by the LRNG to determine whether to unblock=

> + * a certain user interface. Therefore, only the potentially blocking
> + * user interfaces are considered SP800-90B compliant.
> + */
> +bool lrng_sp80090b_startup_complete(void)
> +{
> +	struct lrng_health *health =3D &lrng_health;
> +
> +	return (lrng_sp80090b_health_enabled()) ? health->sp80090b_startup_do=
ne:
> +						  true;
> +}
> +
> +bool lrng_sp80090b_compliant(void)
> +{
> +	struct lrng_health *health =3D &lrng_health;
> +
> +	return lrng_sp80090b_health_enabled() && health->sp80090b_startup_don=
e;
> +}
> +
> +/*********************************************************************=
******
> + * Adaptive Proportion Test
> + *
> + * This test complies with SP800-90B section 4.4.2.
> + *********************************************************************=
******/
> +
> +/**
> + * Reset the APT counter
> + *
> + * @health [in] Reference to health state
> + */
> +static inline void lrng_apt_reset(struct lrng_health *health,
> +				  unsigned int time_masked)
> +{
> +	struct lrng_apt *apt =3D &health->apt;
> +
> +	pr_debug("APT value %d for base %d\n",
> +		 atomic_read(&apt->apt_count), atomic_read(&apt->apt_base));
> +
> +	/* Reset APT */
> +	atomic_set(&apt->apt_count, 0);
> +	atomic_set(&apt->apt_base, time_masked);
> +}
> +
> +static inline void lrng_apt_restart(struct lrng_health *health)
> +{
> +	struct lrng_apt *apt =3D &health->apt;
> +
> +	atomic_set(&apt->apt_trigger, LRNG_APT_WINDOW_SIZE);
> +}
> +
> +/**
> + * Insert a new entropy event into APT
> + *
> + * This function does is void as it does not decide about the fate of =
a time
> + * stamp. An APT failure can only happen at the same time of a stuck t=
est
> + * failure. Thus, the stuck failure will already decide how the time s=
tamp
> + * is handled.
> + *
> + * @health [in] Reference to health state
> + * @now_time [in] Time stamp to process
> + */
> +static inline void lrng_apt_insert(struct lrng_health *health,
> +				   unsigned int now_time)
> +{
> +	struct lrng_apt *apt =3D &health->apt;
> +
> +	if (!lrng_sp80090b_health_requested())
> +		return;
> +
> +	now_time &=3D LRNG_APT_WORD_MASK;
> +
> +	/* Initialization of APT */
> +	if (!apt->apt_base_set) {
> +		atomic_set(&apt->apt_base, now_time);
> +		apt->apt_base_set =3D true;
> +		return;
> +	}
> +
> +	if (now_time =3D=3D (unsigned int)atomic_read(&apt->apt_base)) {
> +		u32 apt_val =3D (u32)atomic_inc_return_relaxed(&apt->apt_count);
> +
> +		if (apt_val >=3D LRNG_APT_CUTOFF)
> +			lrng_sp80090b_failure(health);
> +	}
> +
> +	if (atomic_dec_and_test(&apt->apt_trigger)) {
> +		lrng_apt_restart(health);
> +		lrng_apt_reset(health, now_time);
> +		lrng_sp80090b_startup(health);
> +	}
> +}
> +
> +/*********************************************************************=
******
> + * Repetition Count Test
> + *
> + * The LRNG uses an enhanced version of the Repetition Count Test
> + * (RCT) specified in SP800-90B section 4.4.1. Instead of counting ide=
ntical
> + * back-to-back values, the input to the RCT is the counting of the st=
uck
> + * values while filling the entropy pool.
> + *
> + * The RCT is applied with an alpha of 2^-30 compliant to FIPS 140-2 I=
G 9.8.
> + *
> + * During the counting operation, the LRNG always calculates the RCT
> + * cut-off value of C. If that value exceeds the allowed cut-off value=
,
> + * the LRNG will invalidate all entropy for the entropy pool which imp=
lies
> + * that no data can be extracted from the entropy pool unless new entr=
opy
> + * is received.
> + *********************************************************************=
******/
> +
> +/**
> + * Hot code path - Insert data for Repetition Count Test
> + *
> + * @health: Reference to health information
> + * @stuck: Decision of stuck test
> + */
> +static inline void lrng_rct(struct lrng_health *health, int stuck)
> +{
> +	struct lrng_rct *rct =3D &health->rct;
> +
> +	if (!lrng_sp80090b_health_requested())
> +		return;
> +
> +	if (stuck) {
> +		u32 rct_count =3D atomic_add_return_relaxed(1, &rct->rct_count);
> +
> +		pr_debug("RCT count: %u\n", rct_count);
> +
> +		/*
> +		 * The cutoff value is based on the following consideration:
> +		 * alpha =3D 2^-30 as recommended in FIPS 140-2 IG 9.8.
> +		 * In addition, we imply an entropy value H of 1 bit as this
> +		 * is the minimum entropy required to provide full entropy.
> +		 *
> +		 * Note, rct_count (which equals to value B in the
> +		 * pseudo code of SP800-90B section 4.4.1) starts with zero.
> +		 * Hence we need to subtract one from the cutoff value as
> +		 * calculated following SP800-90B.
> +		 */
> +		if (rct_count >=3D 30) {
> +			atomic_set(&rct->rct_count, 0);
> +
> +			/*
> +			 * APT must start anew as we consider all previously
> +			 * recorded data to contain no entropy.
> +			 */
> +			lrng_apt_restart(health);
> +
> +			lrng_sp80090b_failure(health);
> +		}
> +	} else {
> +		atomic_set(&rct->rct_count, 0);
> +	}
> +}
> +
> +/*********************************************************************=
******
> + * Stuck Test
> + *
> + * Checking the:
> + *      1st derivative of the event occurrence (time delta)
> + *      2nd derivative of the event occurrence (delta of time deltas)
> + *      3rd derivative of the event occurrence (delta of delta of time=
 deltas)
> + *
> + * All values must always be non-zero. The stuck test is only valid di=
sabled if
> + * high-resolution time stamps are identified after initialization.
> + *********************************************************************=
******/
> +
> +static inline u32 lrng_delta(u32 prev, u32 next)
> +{
> +	/*
> +	 * Note that this (unsigned) subtraction does yield the correct value=

> +	 * in the wraparound-case, i.e. when next < prev.
> +	 */
> +	return (next - prev);
> +}
> +
> +/**
> + * Hot code path
> + *
> + * @health: Reference to health information
> + * @now: Event time
> + * @return: 0 event occurrence not stuck (good time stamp)
> + *	    !=3D 0 event occurrence stuck (reject time stamp)
> + */
> +static inline int lrng_irq_stuck(struct lrng_stuck_test *stuck, u32 no=
w_time)
> +{
> +	u32 delta =3D lrng_delta(stuck->last_time, now_time);
> +	u32 delta2 =3D lrng_delta(stuck->last_delta, delta);
> +	u32 delta3 =3D lrng_delta(stuck->last_delta2, delta2);
> +
> +	stuck->last_time =3D now_time;
> +	stuck->last_delta =3D delta;
> +	stuck->last_delta2 =3D delta2;
> +
> +	if (!delta || !delta2 || !delta3)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*********************************************************************=
******
> + * Health test interfaces
> + *********************************************************************=
******/
> +
> +/**
> + * Disable all health tests
> + */
> +void lrng_health_disable(void)
> +{
> +	struct lrng_health *health =3D &lrng_health;
> +
> +	health->health_test_enabled =3D false;
> +
> +	if (lrng_sp80090b_health_requested())
> +		pr_warn("SP800-90B compliance requested but the Linux RNG is "
> +			"NOT SP800-90B compliant\n");
> +}
> +
> +/**
> + * Hot code path - Perform health test on time stamp received from an =
event
> + *
> + * @now_time Time stap
> + */
> +enum lrng_health_res lrng_health_test(u32 now_time)
> +{
> +	struct lrng_health *health =3D &lrng_health;
> +	struct lrng_stuck_test *stuck_test =3D this_cpu_ptr(&lrng_stuck_test)=
;
> +	int stuck;
> +
> +	if (!health->health_test_enabled)
> +		return lrng_health_pass;
> +
> +	lrng_apt_insert(health, now_time);
> +
> +	stuck =3D lrng_irq_stuck(stuck_test, now_time);
> +	lrng_rct(health, stuck);
> +	if (stuck) {
> +		/* SP800-90B disallows using a failing health test time stamp */
> +		return lrng_sp80090b_health_requested() ?
> +			lrng_health_fail_drop : lrng_health_fail_use;
> +	}
> +
> +	return lrng_health_pass;
> +}
>=20


--=20
Alexander E. Patrakov


--------------ms010406030209040506020009
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Криптографическая подпись S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C5wwggVNMIIENaADAgECAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3DQEBCwUAMIGCMQsw
CQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoM
GkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBB
dXRoZW50aWNhdGlvbiBDQSBHMTAeFw0xOTA2MDYwODAxMzVaFw0yMDA2MDYwODAxMzVaMB0x
GzAZBgNVBAMMEnBhdHJha292QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAOA0sb1ubDnIK32rbgW3BnjBcx1pYuEFOCU6aPVJ2gU+wtKJgAo9IdVUXG6kC1fF
hXjIcZHOgbEqzFjHK1yXlHIUWEv+N8KdmBDOK1UdKQj58d9A4hnH62iEiwQsOR5YT1UyHX4A
pfMjsBja7254cixR4jOPzfA4YUD6JTTPioyjDwuYQlhweVyXziKswLtGWfKeDcm3fOlKYxGy
hxjWJRamGTreNBVC9uMkF4DHszpUm07agR2U4mnWy7FsjBuRJ++iX0SvuxKWf19HQWgmgIys
jBVrArhVzgjOOnbvlklW849wIARF4Y0WAf91DsqPtuR8hu7+9KIVj2qk9BeNXXUCAwEAAaOC
AiEwggIdMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUfmD8+GynPT3XrpOheQKPs3QpO/Uw
SwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vY2FjZXJ0LmFjdGFsaXMuaXQv
Y2VydHMvYWN0YWxpcy1hdXRjbGlnMTAdBgNVHREEFjAUgRJwYXRyYWtvdkBnbWFpbC5jb20w
RwYDVR0gBEAwPjA8BgYrgR8BGAEwMjAwBggrBgEFBQcCARYkaHR0cHM6Ly93d3cuYWN0YWxp
cy5pdC9hcmVhLWRvd25sb2FkMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDCB6AYD
VR0fBIHgMIHdMIGboIGYoIGVhoGSbGRhcDovL2xkYXAwNS5hY3RhbGlzLml0L2NuJTNkQWN0
YWxpcyUyMENsaWVudCUyMEF1dGhlbnRpY2F0aW9uJTIwQ0ElMjBHMSxvJTNkQWN0YWxpcyUy
MFMucC5BLi8wMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDti
aW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSENM
LUcxL2dldExhc3RDUkwwHQYDVR0OBBYEFEhX9pz3jwI3+erfsAVB2b4xSsM8MA4GA1UdDwEB
/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAQEAVbKht9PGiUsUaqiyzJb6blSMNaLwopQr3AsI
FvthyqnSqxmSNYDeZsQYPgBnXvMCvHCn07pm1b96Y3XstBt2FWb9dpDr7y+ec3vxFHb3lKGb
3WREB1kEATnBu2++dPcILG58gdzgYde3RAJC3/OyOZhDqKwQA5CnXTHigTzw75iezdLne5pU
MjEQoxdqC+sgbrAueaEpMmRsGSKzgIX8eQ3DWwyIL56fYPJP3u4WZmBUKTFhhUWowG62QLtt
ZjkiX/j+vjcSRd2app8lYDwQRornZAqrDxy+c4qQJ5FN234p36opwespDCwLN3Z6wPzLvzS+
jAlmV3DF2xuZGMoebzCCBkcwggQvoAMCAQICCCzUitOxHg+JMA0GCSqGSIb3DQEBCwUAMGsx
CzAJBgNVBAYTAklUMQ4wDAYDVQQHDAVNaWxhbjEjMCEGA1UECgwaQWN0YWxpcyBTLnAuQS4v
MDMzNTg1MjA5NjcxJzAlBgNVBAMMHkFjdGFsaXMgQXV0aGVudGljYXRpb24gUm9vdCBDQTAe
Fw0xNTA1MTQwNzE0MTVaFw0zMDA1MTQwNzE0MTVaMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UE
CAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAz
MzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMD8wYlW2Yji9ARlv80JNasoKTD+
DMr3J6scEe6GPV3k9WxEtgxXM5WX3oiKjS2p25Mqk8cnV2fpMaEvdO9alrGes0vqcUqly7Pk
U753RGlseYXR2XCjVhs4cuRYjuBmbxpRSJxRImmPnThKY41r0nl6b3A6Z2MOjPQF7h6OCYYw
tz/ziv/+UBV587U2uIlOukaS7Xjk4ArYkQsGTSsfBBXqqn06WL3xG+B/dRO5/mOtY5tHdhPH
ydsBk2kksI3PJ0yNgKV7o6HM7pG9pB6sGhj96uVLnnVnJ0WXOuV1ISv2eit9ir60LjT99hf+
TMZLxA5yaVJ57fYjBMbxM599cw0CAwEAAaOCAdUwggHRMEEGCCsGAQUFBwEBBDUwMzAxBggr
BgEFBQcwAYYlaHR0cDovL29jc3AwNS5hY3RhbGlzLml0L1ZBL0FVVEgtUk9PVDAdBgNVHQ4E
FgQUfmD8+GynPT3XrpOheQKPs3QpO/UwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRS
2Ig6yJ94Zu2J83s4cJTJAgI20DBFBgNVHSAEPjA8MDoGBFUdIAAwMjAwBggrBgEFBQcCARYk
aHR0cHM6Ly93d3cuYWN0YWxpcy5pdC9hcmVhLWRvd25sb2FkMIHjBgNVHR8EgdswgdgwgZag
gZOggZCGgY1sZGFwOi8vbGRhcDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVu
dGljYXRpb24lMjBSb290JTIwQ0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2
NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6
Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwDgYD
VR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQBNk87VJL5BG0oWWHNfZYny2Xo+WIy8
y8QP5VsWZ7LBS6Qz8kn8zJp3c9xdOkudZbcA3vm5U8HKXc1JdzNmpSh92zq/OeZLvUa+rnnc
mvhxkFE9Doag6NitggBPZwXHwDcYn430/F8wqAt3LX/bsd6INVrhPFk3C2SoAjLjUQZibXvQ
uFINMN4l6j86vCrkUaGzSqnXT45NxIivkAPhBQgpGtcTi4f+3DxkyTDbWtf9LuaC4l2jgB3g
C7f56nmdpGfpYsyvKE7+Ip+WryH93pWt6C+r68KU3Gu02cU1/dHvNOXWUDeKkVT3T26wZVrT
aMx+0nS3i63KDfJdhFzutfdBgCWHcp03NhOhMqy1RnAylF/dVZgkka6hKaWe1tOU21kS4uvs
D4wM5k6tl0pin2o6u47kyoJJMOxRSQcosWtDXUmaLHUG91ZC6hvBDmDmpmS6h/r+7mtPrpYO
xTr4hW3me2EfXkTvNTvBQtbi4LrZchg9vhi44EJ7L53g7GzQFn5KK8vqqgMb1c1+T0mkKdqS
edgGiB9TDdYtv4HkUj/N00TKxZMLiDMw4V8ShUL6bKTXNfb3E68s47cD+MatFjUuGFj0uFPv
ZlvlNAoJ7IMfXzIiTWy35X+akm+d49wBh54yv6icz2t/cBU1y1weuPBd8NUH/Ue3mXk0SXwk
GP3yVDGCA/YwggPyAgEBMIGXMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8w
DQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSww
KgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4r
qg9tGyNesDANBglghkgBZQMEAgEFAKCCAi8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTkxMTEyMTk1ODMyWjAvBgkqhkiG9w0BCQQxIgQgKjtWZLv6jjg2
0rqLuVSA/Qv5RsI8Pn1A3s6o1FPgZn8wbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAEuyy5BTLhBM2GnZNJvr679WvD2n2I4g5FxT9ltIw/qQWvIUDzwOBDMBFsnS
YJfzO4BEOmcpxikvvWP5RdvY1IUm3nQQFZ3L/dze1TkRHVsP0NWezpYRThpu53VisZcpPbf8
OqdXnOYXgRwrtuvxjmal6GaMlk7p/+TVTxjY7B3Dbmx6yM4pUYdL5CS5tSwOY1b/POfffL4p
9MkqWmwc0svzjb4uALKy9eY0CXJeChsW04DNKFOIB1O5RUJaUwZwTzt3UidrEJLJAWgVZtgC
I9j7WwM2Szma5qd9Xr7VfeiwoIKe9RZzLB+nn+NFr96K41kC0MVVbvN4/sP9hNJ0AWgAAAAA
AAA=
--------------ms010406030209040506020009--
