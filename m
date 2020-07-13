Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B121D003
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2020 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgGMGt4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 02:49:56 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:29546 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgGMGt4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 02:49:56 -0400
X-Greylist: delayed 643 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 02:49:50 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594622989;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=SaeMvjheM5EdjY7iWUxOguTJrb2cTsHHzBEGhNIJpiQ=;
        b=C0JbvbF6fS1yWKhZEVJoPNhs9EliNz1ja9lh/xmKzvw7hJfRYcZjrbRp6CDPg1U5PK
        WTZcDsG5EZsEIydPnLx9gu0iMwpESLtjaTy3ARUC2QYUx2+OZwx6QPh9vjQvLVbMJbKL
        ySyeWsr2/sOkLgwjKSLglnkupcfSF7q9Fv/a/IchxKBIjWmbpUifIdHVipvFQjAoiyO4
        2CG1y6cvwmat8GaNPwmQjm2zM//c/fpq/Jput3YQ1IMMG64yN5RARtcYXBnjwb0b1gJt
        pb1au2FFucKrhewQwJklYG8ED/x5vONB8atuHD6mvZlmhAI6LazsH3Gol5tXj9mcVjOA
        FC2Q==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSfHReW"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id y0546bw6D6blk2H
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 13 Jul 2020 08:37:47 +0200 (CEST)
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
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v31 10/12] LRNG - add SP800-90B compliant health tests
Date:   Mon, 13 Jul 2020 08:21:27 +0200
Message-ID: <8683219.rMLUfLXkoz@positron.chronox.de>
In-Reply-To: <2050754.Mh6RI2rZIc@positron.chronox.de>
References: <2050754.Mh6RI2rZIc@positron.chronox.de>
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
  Only if all three values are non-zero, the received time delta is
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
  APT as defined in SP800-90B section 4.4.2. The applied significance
  level again is alpha=3D2^-30 compliant to the recommendation of FIPS
  140-2 IG 9.8.

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

  2. All DRNGs are reset which imply that they are treated as being
     not seeded and require a reseed during next invocation.

  3. The SP800-90B startup health test are initiated with all
     implications of the startup tests. That implies that from that point
     on, new events must be observed and its entropy must be inserted into
     the entropy pool before random numbers are calculated from the
     entropy pool.

=46urther details on the SP800-90B compliance and the availability of all
test tools required to perform all tests mandated by SP800-90B are
provided at [1].

The entire health testing code is compile-time configurable.

The patch provides a CONFIG_BROKEN configuration of the APT / RCT cutoff
values which have a high likelihood to trigger the health test failure.
The BROKEN APT cutoff is set to the exact mean of the expected value if
the time stamps are equally distributed (512 time stamps divided by 16
possible values due to using the 4 LSB of the time stamp). The BROKEN
RCT cutoff value is set to 1 which is likely to be triggered during
regular operation.

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
 drivers/char/lrng/Kconfig       |  56 +++++
 drivers/char/lrng/Makefile      |   1 +
 drivers/char/lrng/lrng_health.c | 407 ++++++++++++++++++++++++++++++++
 3 files changed, 464 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_health.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 4684e838f011..323c657f7005 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -106,4 +106,60 @@ config LRNG_JENT
 	  time or at runtime with the lrng_base.jitterrng configuration
 	  variable.
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
+config LRNG_RCT_BROKEN
+	bool "SP800-90B RCT with dangerous low cutoff value"
+	depends on LRNG_HEALTH_TESTS
+	depends on BROKEN
+	default n
+	help
+	  This option enables a dangerously low SP800-90B repetitive
+	  count test (RCT) cutoff value which makes it very likely
+	  that the RCT is triggered to raise a self test failure.
+
+	  This option is ONLY intended for developers wanting to
+	  test the effectiveness of the SP800-90B RCT health test.
+
+	  If unsure, say N.
+
+config LRNG_APT_BROKEN
+	bool "SP800-90B APT with dangerous low cutoff value"
+	depends on LRNG_HEALTH_TESTS
+	depends on BROKEN
+	default n
+	help
+	  This option enables a dangerously low SP800-90B adaptive
+	  proportion test (APT) cutoff value which makes it very
+	  likely that the RCT is triggered to raise a self test
+	  failure.
+
+	  This option is ONLY intended for developers wanting to
+	  test the effectiveness of the SP800-90B APT health test.
+
+	  If unsure, say N.
+
+# Default taken from SP800-90B sec 4.4.1 - significance level 2^-30
+config LRNG_RCT_CUTOFF
+	int
+	default 31 if !LRNG_RCT_BROKEN
+	default 1 if LRNG_RCT_BROKEN
+
+# Default taken from SP800-90B sec 4.4.2 - significance level 2^-30
+config LRNG_APT_CUTOFF
+	int
+	default 325 if !LRNG_APT_BROKEN
+	default 32 if LRNG_APT_BROKEN
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 4f5b6f38f0c4..c3008763dd14 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
 obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
+obj-$(CONFIG_LRNG_HEALTH_TESTS)	+=3D lrng_health.o
diff --git a/drivers/char/lrng/lrng_health.c b/drivers/char/lrng/lrng_healt=
h.c
new file mode 100644
index 000000000000..7817aa6f3357
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_health.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Linux Random Number Generator (LRNG) Health Testing
+ *
+ * Copyright (C) 2019 - 2020, Stephan Mueller <smueller@chronox.de>
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
+/*
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
+		 * Force a reseed of DRNGs to ensure they are seeded with
+		 * entropy that passed the SP800-90B health tests.
+		 * As the DRNG always will reseed before generating
+		 * random numbers, it does not need a reseed trigger.
+		 */
+		lrng_drng_force_reseed();
+	}
+}
+
+/*
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
+/*
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
+		pr_err("SP800-90B runtime health test failure - invalidating all existin=
g entropy and initiate SP800-90B startup\n");
+		lrng_sp80090b_runtime_failure(health);
+	} else {
+		pr_err("SP800-90B startup test failure - resetting\n");
+		lrng_sp80090b_startup_failure(health);
+	}
+}
+
+/*
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
+/*
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
+/*
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
+		if (apt_val >=3D CONFIG_LRNG_APT_CUTOFF)
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
+/*
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
+		if (rct_count >=3D CONFIG_LRNG_RCT_CUTOFF) {
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
+/*
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
+/*
+ * Disable all health tests
+ */
+void lrng_health_disable(void)
+{
+	struct lrng_health *health =3D &lrng_health;
+
+	health->health_test_enabled =3D false;
+
+	if (lrng_sp80090b_health_requested())
+		pr_warn("SP800-90B compliance requested but the Linux RNG is NOT SP800-9=
0B compliant\n");
+}
+
+/*
+ * Hot code path - Perform health test on time stamp received from an event
+ *
+ * @now_time Time stamp
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
2.26.2




