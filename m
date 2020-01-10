Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5413644D
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 01:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgAJAVc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jan 2020 19:21:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgAJAVb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 19:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8kyKdBs+VT1Y2BpHqBqU+1Sj3j0IbI2hHSmTV3zehC4=; b=WOdo0u4EieFYEkcKToNSGes7b
        SIdHAYOSMi8HVPd4nt3eYTiLgR7sYnrg5pC7SjwS+3Lg0Ipl3iBdGjPQCGJTnEoT6LilSwTeYxYBt
        68Xy0Me/r4dUnPFKG2AbIqY1mEPRJA2SSJ8BP0TzN6etvTHOzVZ0nDGSlFOyc8//ILShGJPJhRUED
        61/Kcbrz4PyiSFzpMih9ueF1CDwAUr/QQ2lUq0ElhgZbTLnVmfHODjowJIJ1htCYG4VrB0M9uU7Iz
        4T656aUYr5Wf6TyeIOYwmYTR2kDd1RAp+leGEzg+rF3mheyLe6fLtW9b8LEH9jMqiFbNlZI6APS3e
        l80JjSLyg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipi2f-00038w-QP; Fri, 10 Jan 2020 00:20:45 +0000
Subject: Re: [PATCH v27 10/12] LRNG - add SP800-90B compliant health tests
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <2722222.P16TYeLAVu@positron.chronox.de>
 <2641155.iNH938UiKq@positron.chronox.de>
 <2325404.ZKTBb4nKji@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cd9e893a-ce63-4e9a-fc19-553b1c5f1cff@infradead.org>
Date:   Thu, 9 Jan 2020 16:20:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2325404.ZKTBb4nKji@positron.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On 1/9/20 12:34 AM, Stephan Müller wrote:
> ---
>  drivers/char/lrng/Kconfig       |  56 +++++
>  drivers/char/lrng/Makefile      |   1 +
>  drivers/char/lrng/lrng_health.c | 409 ++++++++++++++++++++++++++++++++
>  3 files changed, 466 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_health.c
> 
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index 10b7cbdb8c8e..7b2bb3da066c 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -103,4 +103,60 @@ config LRNG_JENT
>  	  time or at runtime with the lrng_base.jitterrng configuration
>  	  variable.
>  
> +config LRNG_HEALTH_TESTS
> +	bool "Enable noise source online health tests"
> +	help
> +	  The online health tests validate the noise source at
> +	  runtime for fatal errors. These tests include SP800-90B
> +	  compliant tests which are invoked if the system is booted
> +	  with fips=1. In case of fatal errors during active
> +	  SP800-90B tests, the issue is logged and the noise
> +	  data is discarded. These tests are required for full
> +	  compliance with SP800-90B.
> +
> +	  If unsure, say Y.
> +
> +config LRNG_RCT_BROKEN
> +	bool "SP800-90B RCT with dangerous low cutoff value"
> +	depends on LRNG_HEALTH_TESTS
> +	depends on BROKEN
> +	default n
> +	help
> +	  This option enables a dangerously low SP800-90B repetitive
> +	  count test (RCT) cutoff value which makes it very likely
> +	  that the RCT is triggered to raise a self test failure.

	                                       self-test

> +
> +	  This option is ONLY intended for developers wanting to
> +	  test the effectiveness of the SP800-90B RCT health test.
> +
> +	  If unsure, say N.
> +
> +config LRNG_APT_BROKEN
> +	bool "SP800-90B APT with dangerous low cutoff value"
> +	depends on LRNG_HEALTH_TESTS
> +	depends on BROKEN
> +	default n
> +	help
> +	  This option enables a dangerously low SP800-90B adaptive
> +	  proportion test (APT) cutoff value which makes it very
> +	  likely that the RCT is triggered to raise a self test

	                                              self-test

> +	  failure.
> +
> +	  This option is ONLY intended for developers wanting to
> +	  test the effectiveness of the SP800-90B APT health test.
> +
> +	  If unsure, say N.
> +
> +# Default taken from SP800-90B sec 4.4.1 - significance level 2^-30
> +config LRNG_RCT_CUTOFF
> +	int
> +	default 30 if !LRNG_RCT_BROKEN
> +	default 1 if LRNG_RCT_BROKEN
> +
> +# Default taken from SP800-90B sec 4.4.2 - significance level 2^-30
> +config LRNG_APT_CUTOFF
> +	int
> +	default 325 if !LRNG_APT_BROKEN
> +	default 32 if LRNG_APT_BROKEN
> +
>  endif # LRNG

> diff --git a/drivers/char/lrng/lrng_health.c b/drivers/char/lrng/lrng_health.c
> new file mode 100644
> index 000000000000..da8b42b96918
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_health.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Linux Random Number Generator (LRNG) Health Testing
> + *
> + * Copyright (C) 2019 - 2020, Stephan Mueller <smueller@chronox.de>
> + */

[snip]

> +
> +/***************************************************************************
> + * SP800-90B Compliance
> + *
> + * If the Linux-RNG is booted into FIPS mode, the following interfaces
> + * provide an SP800-90B compliant noise source:
> + *
> + * * /dev/random
> + * * getrandom(2)
> + * * get_random_bytes when using it in conjunction with
> + *   add_random_ready_callback
> + *
> + * All other interfaces, including /dev/urandom or get_random_bytes without
> + * the add_random_ready_callback cannot claim to use an SP800-90B compliant
> + * noise source.
> + ***************************************************************************/
> +
> +/**
> + * Perform SP800-90B startup testing
> + */

/** in the kernel sources means "this is the beginning of a kernel-doc comment block",
but this is not a kernel-doc comment block, so just use /* to begin the comment.

> +static inline void lrng_sp80090b_startup(struct lrng_health *health)
> +{
> +	if (!health->sp80090b_startup_done &&
> +	    atomic_dec_and_test(&health->sp80090b_startup_blocks)) {
> +		health->sp80090b_startup_done = true;
> +		pr_info("SP800-90B startup health tests completed\n");
> +		lrng_init_ops(0);
> +
> +		/*
> +		 * Force a reseed of DRNGs to ensure they are seeded with
> +		 * entropy that passed the SP800-90B health tests.
> +		 * As the DRNG always will reseed before generating
> +		 * random numbers, it does not need a reseed trigger.
> +		 */
> +		lrng_drng_force_reseed();
> +	}
> +}
> +
> +/**
> + * Handle failure of SP800-90B startup testing
> + */

ditto

> +static inline void lrng_sp80090b_startup_failure(struct lrng_health *health)
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

ditto

> +static inline void lrng_sp80090b_runtime_failure(struct lrng_health *health)
> +{
> +	lrng_sp80090b_startup_failure(health);
> +	health->sp80090b_startup_done = false;
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
> + * This function is called by the LRNG to determine whether to unblock
> + * a certain user interface. Therefore, only the potentially blocking
> + * user interfaces are considered SP800-90B compliant.
> + */

ditto.

> +bool lrng_sp80090b_startup_complete(void)
> +{
> +	struct lrng_health *health = &lrng_health;
> +
> +	return (lrng_sp80090b_health_enabled()) ? health->sp80090b_startup_done:
> +						  true;
> +}
> +
> +bool lrng_sp80090b_compliant(void)
> +{
> +	struct lrng_health *health = &lrng_health;
> +
> +	return lrng_sp80090b_health_enabled() && health->sp80090b_startup_done;
> +}
> +
> +/***************************************************************************
> + * Adaptive Proportion Test
> + *
> + * This test complies with SP800-90B section 4.4.2.
> + ***************************************************************************/
> +
> +/**
> + * Reset the APT counter
> + *
> + * @health [in] Reference to health state
> + */

ditto

> +static inline void lrng_apt_reset(struct lrng_health *health,
> +				  unsigned int time_masked)
> +{
> +	struct lrng_apt *apt = &health->apt;
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
> +	struct lrng_apt *apt = &health->apt;
> +
> +	atomic_set(&apt->apt_trigger, LRNG_APT_WINDOW_SIZE);
> +}
> +
> +/**
> + * Insert a new entropy event into APT
> + *
> + * This function does is void as it does not decide about the fate of a time
> + * stamp. An APT failure can only happen at the same time of a stuck test
> + * failure. Thus, the stuck failure will already decide how the time stamp
> + * is handled.
> + *
> + * @health [in] Reference to health state
> + * @now_time [in] Time stamp to process
> + */

ditto
or use complete kernel-doc notation.

> +static inline void lrng_apt_insert(struct lrng_health *health,
> +				   unsigned int now_time)
> +{
> +	struct lrng_apt *apt = &health->apt;
> +
> +	if (!lrng_sp80090b_health_requested())
> +		return;
> +
> +	now_time &= LRNG_APT_WORD_MASK;
> +
> +	/* Initialization of APT */
> +	if (!apt->apt_base_set) {
> +		atomic_set(&apt->apt_base, now_time);
> +		apt->apt_base_set = true;
> +		return;
> +	}
> +
> +	if (now_time == (unsigned int)atomic_read(&apt->apt_base)) {
> +		u32 apt_val = (u32)atomic_inc_return_relaxed(&apt->apt_count);
> +
> +		if (apt_val >= CONFIG_LRNG_APT_CUTOFF)
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
> +/***************************************************************************
> + * Repetition Count Test
> + *
> + * The LRNG uses an enhanced version of the Repetition Count Test
> + * (RCT) specified in SP800-90B section 4.4.1. Instead of counting identical
> + * back-to-back values, the input to the RCT is the counting of the stuck
> + * values while filling the entropy pool.
> + *
> + * The RCT is applied with an alpha of 2^-30 compliant to FIPS 140-2 IG 9.8.
> + *
> + * During the counting operation, the LRNG always calculates the RCT
> + * cut-off value of C. If that value exceeds the allowed cut-off value,
> + * the LRNG will invalidate all entropy for the entropy pool which implies
> + * that no data can be extracted from the entropy pool unless new entropy
> + * is received.
> + ***************************************************************************/
> +
> +/**
> + * Hot code path - Insert data for Repetition Count Test
> + *
> + * @health: Reference to health information
> + * @stuck: Decision of stuck test
> + */

ditto

> +static inline void lrng_rct(struct lrng_health *health, int stuck)
> +{
> +	struct lrng_rct *rct = &health->rct;
> +
> +	if (!lrng_sp80090b_health_requested())
> +		return;
> +
> +	if (stuck) {
> +		u32 rct_count = atomic_add_return_relaxed(1, &rct->rct_count);
> +
> +		pr_debug("RCT count: %u\n", rct_count);
> +
> +		/*
> +		 * The cutoff value is based on the following consideration:
> +		 * alpha = 2^-30 as recommended in FIPS 140-2 IG 9.8.
> +		 * In addition, we imply an entropy value H of 1 bit as this
> +		 * is the minimum entropy required to provide full entropy.
> +		 *
> +		 * Note, rct_count (which equals to value B in the
> +		 * pseudo code of SP800-90B section 4.4.1) starts with zero.
> +		 * Hence we need to subtract one from the cutoff value as
> +		 * calculated following SP800-90B.
> +		 */
> +		if (rct_count >= CONFIG_LRNG_RCT_CUTOFF) {
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
> +/***************************************************************************
> + * Stuck Test
> + *
> + * Checking the:
> + *      1st derivative of the event occurrence (time delta)
> + *      2nd derivative of the event occurrence (delta of time deltas)
> + *      3rd derivative of the event occurrence (delta of delta of time deltas)
> + *
> + * All values must always be non-zero. The stuck test is only valid disabled if
> + * high-resolution time stamps are identified after initialization.
> + ***************************************************************************/
> +
> +static inline u32 lrng_delta(u32 prev, u32 next)
> +{
> +	/*
> +	 * Note that this (unsigned) subtraction does yield the correct value
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
> + *	    != 0 event occurrence stuck (reject time stamp)
> + */

ditto

> +static inline int lrng_irq_stuck(struct lrng_stuck_test *stuck, u32 now_time)
> +{
> +	u32 delta = lrng_delta(stuck->last_time, now_time);
> +	u32 delta2 = lrng_delta(stuck->last_delta, delta);
> +	u32 delta3 = lrng_delta(stuck->last_delta2, delta2);
> +
> +	stuck->last_time = now_time;
> +	stuck->last_delta = delta;
> +	stuck->last_delta2 = delta2;
> +
> +	if (!delta || !delta2 || !delta3)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/***************************************************************************
> + * Health test interfaces
> + ***************************************************************************/
> +
> +/**
> + * Disable all health tests
> + */

ditto

> +void lrng_health_disable(void)
> +{
> +	struct lrng_health *health = &lrng_health;
> +
> +	health->health_test_enabled = false;
> +
> +	if (lrng_sp80090b_health_requested())
> +		pr_warn("SP800-90B compliance requested but the Linux RNG is "
> +			"NOT SP800-90B compliant\n");
> +}
> +
> +/**
> + * Hot code path - Perform health test on time stamp received from an event
> + *
> + * @now_time Time stap
> + */

ditto

> +enum lrng_health_res lrng_health_test(u32 now_time)
> +{


Thanks.
-- 
~Randy

