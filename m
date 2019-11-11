Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26EF7FCB
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 20:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfKKTYP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 14:24:15 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:14580 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKKTYP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 14:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573500249;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=pMIWG/e6sMaU5/HIXjA7bN4jP8A2RZFrWFCgXOHcZgE=;
        b=rXYzWin6AqxzxBjxjSVu5zxf8oUkXSMm26LejI0La17F3vNt4Irvibuxws1k8z5nln
        ciAvowPTzaFb1zXcwtdmG04BoRCvqzFdsxAI9AAky0zPPgz3DIM9KhmL5VSvOaKWUAdG
        woL/iPltOMC0vl3z4tg1rP95EelY9Ctn5XVyhofQiVobRpulKcK34+OGR14ZHnswiFhO
        r99f5aKEil3ptuyZlYBnQuH12yCU9mKBFgcXMky6YX+bbO5MYMosFmzGi40DRGr9Zg5Y
        nS98yeal30o5uWMQ25jFxzBRTpiSiRSInY15ZI1MF1mRsZ3etXjg5jjSvTj/UKEaNQP5
        8YPw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmgLKehaO2hZDSTWbgzIOA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vABJC73XF
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Nov 2019 20:12:07 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>
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
        Neil Horman <nhorman@redhat.com>
Subject: [PATCH v24 11/12] LRNG - add SP800-90B compliant health tests
Date:   Mon, 11 Nov 2019 19:26:10 +0100
Message-ID: <3385183.Cb3iLDTLdO@positron.chronox.de>
In-Reply-To: <6157374.ptSnyUpaCn@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Implement health tests for LRNG's slow noise sources as mandated by
SP-800-90B The file contains the following health tests:

=2D stuck test: The stuck test calculates the first, second and third
  discrete derivative of the time stamp to be processed by the LFSR.
  Only if all three values are zero, the received time delta is
  considered to be non-stuck.

=2D SP800-90B Repetition Count Test (RCT): The LRNG uses an enhanced
  version of the RCT specified in SP800-90B section 4.4.1. Instead of
  counting identical back-to-back values, the input to the RCT is the
  counting of the stuck values during the processing of received
  interrupt events. The RCT is applied with alpha=3D2^-30 compliant to
  the recommendation of FIPS 140-2 IG 9.8. During the counting operation,
  the LRNG always calculates the RCT cut-off value of C. If that value
  exceeds the allowed cut-off value, the LRNG will trigger the health
  test failure discussed below. An error is logged to the kernel log
  that such RCT failure occurred. This test is only applied and
  enforced in FIPS mode, i.e. when the kernel compiled with
  CONFIG_CONFIG_FIPS is started with fips=3D1.

=2D SP800-90B Adaptive Proportion Test (APT): The LRNG implements the
  APT as defined in SP800-90B section 4.4.2. The assumed

The aforementioned health tests are applied to the first 1,024 time stamps
obtained from interrupt events. In case one error is identified for either
the RCT, or the APT, the collected entropy is invalidated and the
SP800-90B startup health test is restarted.

As long as the SP800-90B startup health test is not completed, all LRNG
random number output interfaces that may block will block and not generate
any data. This implies that only those potentially blocking interfaces are
defined to provide random numbers that are seeded with the interrupt noise
source being SP800-90B compliant. All other output interfaces will not be
affected by the SP800-90B startup test and thus are not considered
SP800-90B compliant.

At runtime, the SP800-90B APT and RCT are applied to each time stamp
generated for a received interrupt. When either the APT and RCT indicates
a noise source failure, the LRNG is reset to a state it has immediately
after boot:

=2D all entropy counters are set to zero

=2D the SP800-90B startup tests are re-performed which implies that
getrandom(2) would block again until new entropy was collected

To summarize, the following rules apply:

=E2=80=A2 SP800-90B compliant output interfaces

  - /dev/random

  - getrandom(2) system call

  -  get_random_bytes kernel-internal interface when being triggered by
     the callback registered with add_random_ready_callback

=E2=80=A2 SP800-90B non-compliant output interfaces

  - /dev/urandom

  - get_random_bytes kernel-internal interface called directly

  - randomize_page kernel-internal interface

  - get_random_u32 and get_random_u64 kernel-internal interfaces

  - get_random_u32_wait, get_random_u64_wait, get_random_int_wait, and
    get_random_long_wait kernel-internal interfaces

If either the RCT, or the APT health test fails irrespective whether
during initialization or runtime, the following actions occur:

  1. The entropy of the entire entropy pool is invalidated.

  2. The primary and all secondary DRNGs are reset which imply that they
     are treated as being not seeded and require a reseed during next
     invocation.

  3. The SP800-90B startup health test are initiated with all
     implications of the startup tests. That implies that from that point
     on, new events must be observed and its entropy must be inserted into
     the entropy pool before random numbers are calculated from the
     entropy pool.

=46urther details on the SP800-90B compliance and the availability of all
test tools required to perform all tests mandated by SP800-90B are
provided at [1].

The entire health testing code is compile-time configurable.

CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Willy Tarreau <w@1wt.eu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Vito Caputo <vcaputo@pengaru.com>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: Jan Kara <jack@suse.cz>
CC: Ray Strode <rstrode@redhat.com>
CC: William Jon McCann <mccann@jhu.edu>
CC: zhangjs <zachary@baishancloud.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Lennart Poettering <mzxreary@0pointer.de>
CC: Nicolai Stange <nstange@suse.de>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Kconfig       |  13 +
 drivers/char/lrng/Makefile      |   1 +
 drivers/char/lrng/lrng_health.c | 424 ++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_health.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index efc5f9aaa2a3..4373a1a19538 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -113,4 +113,17 @@ config LRNG_TRNG_SUPPORT
 	  With the TRNG support the /dev/random device will block
 	  if insufficient entropy is available.
=20
+config LRNG_HEALTH_TESTS
+	bool "Enable noise source online health tests"
+	help
+	  The online health tests validate the noise source at
+	  runtime for fatal errors. These tests include SP800-90B
+	  compliant tests which are invoked if the system is booted
+	  with fips=3D1. In case of fatal errors during active
+	  SP800-90B tests, the issue is logged and the noise
+	  data is discarded. These tests are required for full
+	  compliance with SP800-90B.
+
+	  If unsure, say Y.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 1c72bc060bce..0713e9c0aa6e 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
 obj-$(CONFIG_LRNG_TRNG_SUPPORT)	+=3D lrng_trng.o
+obj-$(CONFIG_LRNG_HEALTH_TESTS)	+=3D lrng_health.o
diff --git a/drivers/char/lrng/lrng_health.c b/drivers/char/lrng/lrng_healt=
h.c
new file mode 100644
index 000000000000..b8d96cec1f71
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_health.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Linux Random Number Generator (LRNG) Health Testing
+ *
+ * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fips.h>
+#include <linux/module.h>
+
+#include "lrng_internal.h"
+
+/* Stuck Test */
+struct lrng_stuck_test {
+	u32 last_time;		/* Stuck test: time of previous IRQ */
+	u32 last_delta;		/* Stuck test: delta of previous IRQ */
+	u32 last_delta2;	/* Stuck test: 2. time derivation of prev IRQ */
+};
+
+/* Repetition Count Test */
+struct lrng_rct {
+	atomic_t rct_count;	/* Number of stuck values */
+};
+
+/* Adaptive Proportion Test */
+struct lrng_apt {
+	/* Taken from SP800-90B sec 4.4.2 - significance level 2^-30 */
+#define LRNG_APT_CUTOFF		325
+	/* Data window size */
+#define LRNG_APT_WINDOW_SIZE	512
+	/* LSB of time stamp to process */
+#define LRNG_APT_LSB		16
+#define LRNG_APT_WORD_MASK	(LRNG_APT_LSB - 1)
+	atomic_t apt_count;		/* APT counter */
+	atomic_t apt_base;		/* APT base reference */
+
+	atomic_t apt_trigger;
+	bool apt_base_set;	/* Is APT base set? */
+};
+
+/* The health test code must operate lock-less */
+struct lrng_health {
+	struct lrng_rct rct;
+	struct lrng_apt apt;
+
+	bool health_test_enabled;
+
+	/* SP800-90B startup health tests */
+#define LRNG_SP80090B_STARTUP_SAMPLES  1024
+#define LRNG_SP80090B_STARTUP_BLOCKS   ((LRNG_SP80090B_STARTUP_SAMPLES + \
+					 LRNG_APT_WINDOW_SIZE - 1) /    \
+					LRNG_APT_WINDOW_SIZE)
+	bool sp80090b_startup_done;
+	atomic_t sp80090b_startup_blocks;
+};
+
+static struct lrng_health lrng_health =3D {
+	.rct.rct_count =3D ATOMIC_INIT(0),
+
+	.apt.apt_count =3D ATOMIC_INIT(0),
+	.apt.apt_base =3D ATOMIC_INIT(-1),
+	.apt.apt_trigger =3D ATOMIC_INIT(LRNG_APT_WINDOW_SIZE),
+	.apt.apt_base_set =3D false,
+
+	.health_test_enabled =3D true,
+
+	.sp80090b_startup_blocks =3D ATOMIC_INIT(LRNG_SP80090B_STARTUP_BLOCKS),
+	.sp80090b_startup_done =3D false,
+};
+
+static DEFINE_PER_CPU(struct lrng_stuck_test, lrng_stuck_test);
+
+static inline bool lrng_sp80090b_health_requested(void)
+{
+	/* Health tests are only requested in FIPS mode */
+	return fips_enabled;
+}
+
+static inline bool lrng_sp80090b_health_enabled(void)
+{
+	struct lrng_health *health =3D &lrng_health;
+
+	return lrng_sp80090b_health_requested() && health->health_test_enabled;
+}
+
+/*************************************************************************=
**
+ * SP800-90B Compliance
+ *
+ * If the Linux-RNG is booted into FIPS mode, the following interfaces
+ * provide an SP800-90B compliant noise source:
+ *
+ * * /dev/random
+ * * getrandom(2)
+ * * get_random_bytes when using it in conjunction with
+ *   add_random_ready_callback
+ *
+ * All other interfaces, including /dev/urandom or get_random_bytes without
+ * the add_random_ready_callback cannot claim to use an SP800-90B compliant
+ * noise source.
+ *************************************************************************=
**/
+
+/**
+ * Perform SP800-90B startup testing
+ */
+static inline void lrng_sp80090b_startup(struct lrng_health *health)
+{
+	if (!health->sp80090b_startup_done &&
+	    atomic_dec_and_test(&health->sp80090b_startup_blocks)) {
+		health->sp80090b_startup_done =3D true;
+		pr_info("SP800-90B startup health tests completed\n");
+		lrng_init_ops(0);
+
+		/*
+		 * Force a reseed of secondary DRNGs to ensure they are
+		 * seeded with entropy that passed the SP800-90B health tests.
+		 * As the primary DRNG always will reseed before generating
+		 * random numbers, it does not need a reseed trigger.
+		 */
+		lrng_sdrng_force_reseed();
+	}
+}
+
+/**
+ * Handle failure of SP800-90B startup testing
+ */
+static inline void lrng_sp80090b_startup_failure(struct lrng_health *healt=
h)
+{
+	/* Reset of LRNG and its entropy - NOTE: we are in atomic context */
+	lrng_reset();
+
+	/*
+	 * Reset the SP800-90B startup test.
+	 *
+	 * NOTE SP800-90B section 4.3 bullet 4 does not specify what
+	 * exactly is to be done in case of failure! Thus, we do what
+	 * makes sense, i.e. restarting the health test and thus gating
+	 * the output function of /dev/random and getrandom(2).
+	 */
+	atomic_set(&health->sp80090b_startup_blocks,
+		   LRNG_SP80090B_STARTUP_BLOCKS);
+}
+
+/**
+ * Handle failure of SP800-90B runtime testing
+ */
+static inline void lrng_sp80090b_runtime_failure(struct lrng_health *healt=
h)
+{
+	lrng_sp80090b_startup_failure(health);
+	health->sp80090b_startup_done =3D false;
+}
+
+static inline void lrng_sp80090b_failure(struct lrng_health *health)
+{
+	if (health->sp80090b_startup_done) {
+		pr_err("SP800-90B runtime health test failure - invalidating "
+		       "all existing entropy and initiate SP800-90B startup\n");
+		lrng_sp80090b_runtime_failure(health);
+	} else {
+		pr_err("SP800-90B startup test failure - resetting\n");
+		lrng_sp80090b_startup_failure(health);
+	}
+}
+
+/**
+ * Is the SP800-90B startup testing complete?
+ *
+ * This function is called by the LRNG to determine whether to unblock
+ * a certain user interface. Therefore, only the potentially blocking
+ * user interfaces are considered SP800-90B compliant.
+ */
+bool lrng_sp80090b_startup_complete(void)
+{
+	struct lrng_health *health =3D &lrng_health;
+
+	return (lrng_sp80090b_health_enabled()) ? health->sp80090b_startup_done:
+						  true;
+}
+
+bool lrng_sp80090b_compliant(void)
+{
+	struct lrng_health *health =3D &lrng_health;
+
+	return lrng_sp80090b_health_enabled() && health->sp80090b_startup_done;
+}
+
+/*************************************************************************=
**
+ * Adaptive Proportion Test
+ *
+ * This test complies with SP800-90B section 4.4.2.
+ *************************************************************************=
**/
+
+/**
+ * Reset the APT counter
+ *
+ * @health [in] Reference to health state
+ */
+static inline void lrng_apt_reset(struct lrng_health *health,
+				  unsigned int time_masked)
+{
+	struct lrng_apt *apt =3D &health->apt;
+
+	pr_debug("APT value %d for base %d\n",
+		 atomic_read(&apt->apt_count), atomic_read(&apt->apt_base));
+
+	/* Reset APT */
+	atomic_set(&apt->apt_count, 0);
+	atomic_set(&apt->apt_base, time_masked);
+}
+
+static inline void lrng_apt_restart(struct lrng_health *health)
+{
+	struct lrng_apt *apt =3D &health->apt;
+
+	atomic_set(&apt->apt_trigger, LRNG_APT_WINDOW_SIZE);
+}
+
+/**
+ * Insert a new entropy event into APT
+ *
+ * This function does is void as it does not decide about the fate of a ti=
me
+ * stamp. An APT failure can only happen at the same time of a stuck test
+ * failure. Thus, the stuck failure will already decide how the time stamp
+ * is handled.
+ *
+ * @health [in] Reference to health state
+ * @now_time [in] Time stamp to process
+ */
+static inline void lrng_apt_insert(struct lrng_health *health,
+				   unsigned int now_time)
+{
+	struct lrng_apt *apt =3D &health->apt;
+
+	if (!lrng_sp80090b_health_requested())
+		return;
+
+	now_time &=3D LRNG_APT_WORD_MASK;
+
+	/* Initialization of APT */
+	if (!apt->apt_base_set) {
+		atomic_set(&apt->apt_base, now_time);
+		apt->apt_base_set =3D true;
+		return;
+	}
+
+	if (now_time =3D=3D (unsigned int)atomic_read(&apt->apt_base)) {
+		u32 apt_val =3D (u32)atomic_inc_return_relaxed(&apt->apt_count);
+
+		if (apt_val >=3D LRNG_APT_CUTOFF)
+			lrng_sp80090b_failure(health);
+	}
+
+	if (atomic_dec_and_test(&apt->apt_trigger)) {
+		lrng_apt_restart(health);
+		lrng_apt_reset(health, now_time);
+		lrng_sp80090b_startup(health);
+	}
+}
+
+/*************************************************************************=
**
+ * Repetition Count Test
+ *
+ * The LRNG uses an enhanced version of the Repetition Count Test
+ * (RCT) specified in SP800-90B section 4.4.1. Instead of counting identic=
al
+ * back-to-back values, the input to the RCT is the counting of the stuck
+ * values while filling the entropy pool.
+ *
+ * The RCT is applied with an alpha of 2^-30 compliant to FIPS 140-2 IG 9.=
8.
+ *
+ * During the counting operation, the LRNG always calculates the RCT
+ * cut-off value of C. If that value exceeds the allowed cut-off value,
+ * the LRNG will invalidate all entropy for the entropy pool which implies
+ * that no data can be extracted from the entropy pool unless new entropy
+ * is received.
+ *************************************************************************=
**/
+
+/**
+ * Hot code path - Insert data for Repetition Count Test
+ *
+ * @health: Reference to health information
+ * @stuck: Decision of stuck test
+ */
+static inline void lrng_rct(struct lrng_health *health, int stuck)
+{
+	struct lrng_rct *rct =3D &health->rct;
+
+	if (!lrng_sp80090b_health_requested())
+		return;
+
+	if (stuck) {
+		u32 rct_count =3D atomic_add_return_relaxed(1, &rct->rct_count);
+
+		pr_debug("RCT count: %u\n", rct_count);
+
+		/*
+		 * The cutoff value is based on the following consideration:
+		 * alpha =3D 2^-30 as recommended in FIPS 140-2 IG 9.8.
+		 * In addition, we imply an entropy value H of 1 bit as this
+		 * is the minimum entropy required to provide full entropy.
+		 *
+		 * Note, rct_count (which equals to value B in the
+		 * pseudo code of SP800-90B section 4.4.1) starts with zero.
+		 * Hence we need to subtract one from the cutoff value as
+		 * calculated following SP800-90B.
+		 */
+		if (rct_count >=3D 30) {
+			atomic_set(&rct->rct_count, 0);
+
+			/*
+			 * APT must start anew as we consider all previously
+			 * recorded data to contain no entropy.
+			 */
+			lrng_apt_restart(health);
+
+			lrng_sp80090b_failure(health);
+		}
+	} else {
+		atomic_set(&rct->rct_count, 0);
+	}
+}
+
+/*************************************************************************=
**
+ * Stuck Test
+ *
+ * Checking the:
+ *      1st derivative of the event occurrence (time delta)
+ *      2nd derivative of the event occurrence (delta of time deltas)
+ *      3rd derivative of the event occurrence (delta of delta of time del=
tas)
+ *
+ * All values must always be non-zero. The stuck test is only valid disabl=
ed if
+ * high-resolution time stamps are identified after initialization.
+ *************************************************************************=
**/
+
+static inline u32 lrng_delta(u32 prev, u32 next)
+{
+	/*
+	 * Note that this (unsigned) subtraction does yield the correct value
+	 * in the wraparound-case, i.e. when next < prev.
+	 */
+	return (next - prev);
+}
+
+/**
+ * Hot code path
+ *
+ * @health: Reference to health information
+ * @now: Event time
+ * @return: 0 event occurrence not stuck (good time stamp)
+ *	    !=3D 0 event occurrence stuck (reject time stamp)
+ */
+static inline int lrng_irq_stuck(struct lrng_stuck_test *stuck, u32 now_ti=
me)
+{
+	u32 delta =3D lrng_delta(stuck->last_time, now_time);
+	u32 delta2 =3D lrng_delta(stuck->last_delta, delta);
+	u32 delta3 =3D lrng_delta(stuck->last_delta2, delta2);
+
+	stuck->last_time =3D now_time;
+	stuck->last_delta =3D delta;
+	stuck->last_delta2 =3D delta2;
+
+	if (!delta || !delta2 || !delta3)
+		return 1;
+
+	return 0;
+}
+
+/*************************************************************************=
**
+ * Health test interfaces
+ *************************************************************************=
**/
+
+/**
+ * Disable all health tests
+ */
+void lrng_health_disable(void)
+{
+	struct lrng_health *health =3D &lrng_health;
+
+	health->health_test_enabled =3D false;
+
+	if (lrng_sp80090b_health_requested())
+		pr_warn("SP800-90B compliance requested but the Linux RNG is "
+			"NOT SP800-90B compliant\n");
+}
+
+/**
+ * Hot code path - Perform health test on time stamp received from an event
+ *
+ * @now_time Time stap
+ */
+enum lrng_health_res lrng_health_test(u32 now_time)
+{
+	struct lrng_health *health =3D &lrng_health;
+	struct lrng_stuck_test *stuck_test =3D this_cpu_ptr(&lrng_stuck_test);
+	int stuck;
+
+	if (!health->health_test_enabled)
+		return lrng_health_pass;
+
+	lrng_apt_insert(health, now_time);
+
+	stuck =3D lrng_irq_stuck(stuck_test, now_time);
+	lrng_rct(health, stuck);
+	if (stuck) {
+		/* SP800-90B disallows using a failing health test time stamp */
+		return lrng_sp80090b_health_requested() ?
+			lrng_health_fail_drop : lrng_health_fail_use;
+	}
+
+	return lrng_health_pass;
+}
=2D-=20
2.23.0




