Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8807E13BD9E
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2020 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgAOKje (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 05:39:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:12188 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgAOKje (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jan 2020 05:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579084766;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PGF+aSGBgyOTOkOJuXwcr4oKXZNjFUkRg22zzKcVwbY=;
        b=GGjIb5kkNEO67FaUaFSM4ylqAwansVzWg5TH+V2m8KCIM2jO5GPZfuBxssIgzrd5Pi
        TD7JY3ypNKOOr6qdbrwQmMOf1zVD6wPeWCsnsYeEAcDE195iLKwvRH34AdEqwwWUvIKT
        DUZY4E4hOnU7x5jdx7VNv0a/v/yETSNR7Ha15RQ1EHaFxRuYA9AB5dWXutl3dFljMlw2
        M2wqhq6NvfsCQ5crNYekqNysP6akSOY26wqPBMmfx+VJqX/l/eIn2EFLSaIHkHRh98Ch
        9FGIHpF36plEHlDxW7S8CEpSkl3pilqGNZ2hDtCBrxSioVJ83z7VADX1XzefQDuQ+Q2k
        uTxA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0FAbwVzw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 15 Jan 2020 11:37:58 +0100 (CET)
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
Subject: [PATCH v28 12/12] LRNG - add power-on and runtime self-tests
Date:   Wed, 15 Jan 2020 11:36:23 +0100
Message-ID: <14680840.Vbse3Ty9G8@positron.chronox.de>
In-Reply-To: <5951792.lmNsirYsPE@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2641155.iNH938UiKq@positron.chronox.de> <5951792.lmNsirYsPE@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Parts of the LFSR are already covered by self-tests, including:

* Self-test of SP800-90A DRBG provided by the Linux kernel crypto API.

* Self-test of the PRNG provided by the Linux kernel crypto API.

* Raw noise source data testing including SP800-90B compliant
  tests when enabling CONFIG_LRNG_HEALTH_TESTS

This patch adds the self-tests for the remaining critical functions of
the LRNG that are essential to maintain entropy and provide
cryptographic strong random numbers. The following self-tests are
implemented:

* Self-test of the time array maintenance. This test verifies whether
the time stamp array management to store multiple values in one integer
implements a concatenation of the data.

* Self-test of the LFSR operation. This test injects a monotonic
increasing counter into the LFSR. After completion of the injection of
the counter, 3 pool words are compared with known good values. The known
good values are calculated with the newly-developed tool
lfsr_testvector_generation provided as part of the LRNG test tool set at
[1].

* Self-test of the Hash_DF operation ensures that this function operates
compliant to the specification. The self-test performs a Hash_DF
operation of a zeroized entropy pool state. The test vectors are
generated using the newly-developed tool hash_df_testvector_generation
provided as part of the LRNG test tool set at [1].

* Self-test of the ChaCha20 DRNG is based on the self-tests that are
already present and implemented with the stand-alone user space
ChaCha20 DRNG implementation available at [2]. The self-tests cover
different use cases of the DRNG seeded with known seed data.

The status of the LRNG self-tests is provided with the selftest_status
SysFS file. If the file contains a zero, the self-tests passed. The
value 0xffffffff means that the self-tests were not executed. Any other
value indicates a self-test failure.

The self-test may be compiled to panic the system if the self-test
fails.

All self-tests operate on private state data structures. This implies
that none of the self-tests have any impact on the regular LRNG
operations. This allows the self-tests to be repeated at runtime by
writing anything into the selftest_status SysFS file.

[1] https://www.chronox.de/lrng.html
[2] https://www.chronox.de/chacha20.html

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
CC: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
CC: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Kconfig         |  25 ++
 drivers/char/lrng/Makefile        |   1 +
 drivers/char/lrng/lrng_selftest.c | 418 ++++++++++++++++++++++++++++++
 3 files changed, 444 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_selftest.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index e503a4bb7475..0c9ad9563fb7 100644
--- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -175,4 +175,29 @@ config LRNG_TESTING
 
 	  If unsure, say N.
 
+config LRNG_SELFTEST
+	bool "Enable power-on and on-demand self-tests"
+	help
+	  The power-on self-tests are executed during boot time
+	  covering the ChaCha20 DRNG, the LFSR processing and the
+	  time stamp management of the LRNG.
+
+	  The on-demand self-tests are triggered by writing any
+	  value into the SysFS file selftest_status. At the same
+	  time, when reading this file, the test status is
+	  returned. A zero indicates that all tests were executed
+	  successfully.
+
+	  If unsure, say Y.
+
+if LRNG_SELFTEST
+
+config LRNG_SELFTEST_PANIC
+	bool "Panic the kernel upon self-test failure"
+	help
+	  If the option is enabled, the kernel is terminated if an
+	  LRNG power-on self-test failure is detected.
+
+endif # LRNG_SELFTEST
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index b2ce1979dc4b..92219c565f66 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_LRNG_KCAPI)	+= lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+= lrng_jent.o
 obj-$(CONFIG_LRNG_HEALTH_TESTS)	+= lrng_health.o
 obj-$(CONFIG_LRNG_TESTING)	+= lrng_testing.o
+obj-$(CONFIG_LRNG_SELFTEST)	+= lrng_selftest.o
diff --git a/drivers/char/lrng/lrng_selftest.c b/drivers/char/lrng/lrng_selftest.c
new file mode 100644
index 000000000000..da213572e1dd
--- /dev/null
+++ b/drivers/char/lrng/lrng_selftest.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG power-on and on-demand self-test
+ *
+ * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+/*
+ * In addition to the self-tests below, the following LRNG components
+ * are covered with self-tests during regular operation:
+ *
+ * * power-on self-test: SP800-90A DRBG provided by the Linux kernel crypto API
+ * * power-on self-test: PRNG provided by the Linux kernel crypto API
+ * * runtime test: Raw noise source data testing including SP800-90B compliant
+ *		   tests when enabling CONFIG_LRNG_HEALTH_TESTS
+ *
+ * Additional developer tests present with LRNG code:
+ * * SP800-90B APT and RCT test enforcement validation when enabling
+ *   CONFIG_LRNG_APT_BROKEN or CONFIG_LRNG_RCT_BROKEN.
+ * * Collection of raw entropy from the interrupt noise source when enabling
+ *   CONFIG_LRNG_TESTING and pulling the data from the kernel with the provided
+ *   interface.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/lrng.h>
+#include <linux/slab.h>
+
+#include "lrng_chacha20.h"
+#include "lrng_internal.h"
+#include "lrng_lfsr.h"
+#include "lrng_sw_noise.h"
+
+#define LRNG_SELFTEST_PASSED		0
+#define LRNG_SEFLTEST_ERROR_TIME	(1 << 0)
+#define LRNG_SEFLTEST_ERROR_LFSR	(1 << 1)
+#define LRNG_SEFLTEST_ERROR_CHACHA20	(1 << 2)
+#define LRNG_SEFLTEST_ERROR_HASHDF	(1 << 3)
+#define LRNG_SELFTEST_NOT_EXECUTED	0xffffffff
+
+static u32 lrng_time_selftest[LRNG_TIME_ARRAY_SIZE];
+
+static unsigned int lrng_selftest_status = LRNG_SELFTEST_NOT_EXECUTED;
+
+static inline void lrng_time_process_selftest_insert(u32 time)
+{
+	static u32 lrng_time_selftest_ptr = 0;
+	u32 ptr = lrng_time_selftest_ptr++ & LRNG_TIME_WORD_MASK;
+
+	lrng_time_selftest[lrng_time_idx2array(ptr)] |=
+		lrng_time_slot_val(time & LRNG_TIME_SLOTSIZE_MASK,
+				   lrng_time_idx2slot(ptr));
+}
+
+static unsigned int lrng_time_process_selftest(void)
+{
+	u32 time;
+	u32 idx_zero_compare = (0 << 0) | (1 << 8) | (2 << 16) | (3 << 24);
+	u32 idx_one_compare  = (4 << 0) | (5 << 8) | (6 << 16) | (7 << 24);
+	u32 idx_last_compare = ((LRNG_TIME_NUM_VALUES - 4) << 0)  |
+			       ((LRNG_TIME_NUM_VALUES - 3) << 8)  |
+			       ((LRNG_TIME_NUM_VALUES - 2) << 16) |
+			       ((LRNG_TIME_NUM_VALUES - 1) << 24);
+
+	(void)idx_one_compare;
+
+	for (time = 0; time < LRNG_TIME_NUM_VALUES; time++)
+		lrng_time_process_selftest_insert(time);
+
+	if ((lrng_time_selftest[0] != idx_zero_compare) ||
+#if (LRNG_TIME_ARRAY_SIZE > 1)
+	    (lrng_time_selftest[1] != idx_one_compare)  ||
+#endif
+	    (lrng_time_selftest[LRNG_TIME_ARRAY_SIZE - 1] != idx_last_compare))
+	{
+		pr_err("LRNG time array self-test FAILED\n");
+		return LRNG_SEFLTEST_ERROR_TIME;
+	}
+
+	return LRNG_SELFTEST_PASSED;
+}
+
+/*
+ * The test vectors are generated with the lfsr_testvector_generation tool
+ * provided as part of the test tool set of the LRNG.
+ */
+static unsigned int lrng_pool_lfsr_selftest(void)
+{
+	/*
+	 * First, 67th and last entry of entropy pool.
+	 *
+	 * The 67th entry is picked because this one is the first to receive
+	 * an entry. As we start with 1 to inject into the LFSR, the
+	 * 67th entry should be equal to rol(1, 7) >> 3 considering that
+	 * all other values of the LFSR are zero and the the twist value of 0
+	 * is applied.
+	 */
+	static u32 const lrng_lfsr_selftest_result[][3] = {
+		{ 0xf56df24a, 0x00000010, 0x0e014939 },
+		{ 0x4b130726, 0x00000010, 0x2802f509 },
+		{ 0x87279152, 0x00000010, 0x00150000 },
+		{ 0x0b67f997, 0x00000010, 0x00150000 },
+		{ 0x4fea174f, 0x00000010, 0xcbf4a6ae },
+		{ 0x77149108, 0x00000010, 0x77bfadf2 },
+		{ 0x1e96037e, 0x00000010, 0x18017e79 },
+		{ 0xc84acef2, 0x00000010, 0x6345f7a8 },
+		{ 0x6a2eb6df, 0x00000010, 0x03950000 },
+	};
+	struct lrng_pool *lrng_pool, *lrng_pool_aligned;
+	u32 i, ret = LRNG_SELFTEST_PASSED;
+
+	BUILD_BUG_ON(ARRAY_SIZE(lrng_lfsr_selftest_result) <
+							CONFIG_LRNG_POOL_SIZE);
+
+	lrng_pool = kzalloc(sizeof(struct lrng_pool) + LRNG_KCAPI_ALIGN,
+			    GFP_KERNEL);
+	if (!lrng_pool)
+		return LRNG_SEFLTEST_ERROR_LFSR;
+	lrng_pool_aligned = PTR_ALIGN(lrng_pool, sizeof(u32));
+
+	for (i = 1; i <= LRNG_POOL_SIZE; i++)
+		_lrng_pool_lfsr_u32(lrng_pool_aligned, i);
+
+	if ((atomic_read_u32(&lrng_pool_aligned->pool[0]) !=
+	     lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][0]) ||
+	    (atomic_read_u32(&lrng_pool_aligned->pool[67 &
+						      (LRNG_POOL_SIZE - 1)]) !=
+	     lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][1]) ||
+	    (atomic_read_u32(&lrng_pool_aligned->pool[LRNG_POOL_SIZE - 1]) !=
+	     lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][2])) {
+		pr_err("LRNG LFSR self-test FAILED\n");
+		ret = LRNG_SEFLTEST_ERROR_LFSR;
+	}
+
+	kfree(lrng_pool);
+	return ret;
+}
+
+/*
+ * The test vectors are generated with the hash_df_testvector_generation tool
+ * provided as part of the test tool set of the LRNG.
+ */
+static unsigned int lrng_hash_df_selftest(void)
+{
+	const struct lrng_crypto_cb *crypto_cb = &lrng_cc20_crypto_cb;
+
+	/*
+	 * The size of 45 bytes is chosen arbitrarily. Yet, this size should
+	 * ensure that we have at least two hash blocks plus some fraction
+	 * of a hash block generated.
+	 */
+	static u8 const lrng_hash_df_selftest_result[][45] = {
+		{
+			0x3b, 0xbe, 0x7a, 0xbd, 0x2b, 0x16, 0x02, 0x4c,
+			0xfc, 0xd3, 0x02, 0x15, 0xf0, 0x86, 0xd4, 0xdb,
+			0x49, 0xec, 0x26, 0x53, 0xd6, 0xc9, 0x6d, 0xad,
+			0x24, 0xca, 0x72, 0x89, 0x2c, 0xfa, 0x48, 0x18,
+			0xf7, 0x47, 0xb5, 0x2f, 0x92, 0xa2, 0x1b, 0xd9,
+			0x24, 0xa7, 0x2f, 0xa2, 0x0b,
+		}, {
+			0xd2, 0xaa, 0xf9, 0x76, 0x26, 0xc6, 0x13, 0xea,
+			0xb8, 0xde, 0xe6, 0x88, 0x8f, 0xc4, 0x7a, 0x7d,
+			0x9c, 0xb4, 0x1b, 0xd1, 0xd1, 0x8a, 0x40, 0xc9,
+			0xaa, 0x45, 0xa6, 0xb6, 0xb5, 0x6f, 0xf6, 0xbc,
+			0xbb, 0x77, 0x37, 0xbc, 0x5a, 0x2d, 0xcc, 0x84,
+			0x25, 0x68, 0x5e, 0xba, 0x16,
+		}, {
+			0x58, 0x66, 0x82, 0x88, 0x29, 0x19, 0xa4, 0xbb,
+			0x33, 0x42, 0xc9, 0x72, 0x0d, 0x68, 0x6e, 0xb9,
+			0xc6, 0xe0, 0x7a, 0xf9, 0x20, 0xca, 0x6d, 0x18,
+			0x35, 0xec, 0xfa, 0x9e, 0xf6, 0x3a, 0xa7, 0xb6,
+			0x92, 0x7a, 0xe5, 0xcd, 0xc5, 0x13, 0x9f, 0x65,
+			0x6a, 0xe1, 0xe4, 0x3f, 0xb9,
+		}, {
+			0xdd, 0xf1, 0x34, 0xca, 0x08, 0xe3, 0xce, 0x8a,
+			0x26, 0x6b, 0xce, 0x99, 0x8a, 0x84, 0xd2, 0x21,
+			0x98, 0x10, 0x95, 0x5f, 0x9f, 0xc3, 0xf2, 0xe4,
+			0x79, 0x75, 0xb5, 0x15, 0xa7, 0xa2, 0xf1, 0xc4,
+			0xdc, 0x67, 0xcb, 0x67, 0x8c, 0xb2, 0x1b, 0xd5,
+			0xd6, 0x8b, 0xc2, 0x34, 0xd6,
+		}, {
+			0xc3, 0x16, 0x9d, 0xf0, 0x78, 0x15, 0xab, 0xf2,
+			0x2f, 0xc9, 0x2e, 0xe1, 0xc6, 0x5e, 0xfa, 0x03,
+			0xaf, 0xd4, 0xd5, 0x47, 0x2a, 0xe8, 0x06, 0xe8,
+			0x7e, 0x0a, 0x71, 0xc7, 0x0d, 0x39, 0xb1, 0xa9,
+			0x5a, 0x49, 0xee, 0x8b, 0x2f, 0xcd, 0xea, 0x96,
+			0xcc, 0x08, 0x71, 0xef, 0x9c,
+		}, {
+			0x1a, 0x3d, 0x70, 0x39, 0xc2, 0x02, 0x4d, 0x3a,
+			0xaa, 0x14, 0x20, 0x88, 0x96, 0x4c, 0x7c, 0xe4,
+			0xaa, 0x49, 0x89, 0x30, 0x50, 0x96, 0xb6, 0xa7,
+			0x55, 0x0a, 0xf8, 0xd2, 0x4e, 0x83, 0x9d, 0x1f,
+			0x56, 0x49, 0x13, 0xc6, 0x46, 0x55, 0x73, 0x0d,
+			0x74, 0xcd, 0x81, 0xe0, 0x65,
+		}, {
+			0x4b, 0xf6, 0x49, 0x89, 0x2a, 0x9f, 0x67, 0xd7,
+			0xb8, 0x1d, 0xbb, 0x5d, 0xf0, 0x1b, 0x60, 0xb6,
+			0xb7, 0xf3, 0x86, 0x6d, 0xe0, 0x04, 0xa1, 0xbc,
+			0x3b, 0xb0, 0x10, 0x91, 0xe8, 0x22, 0x67, 0x5b,
+			0xe8, 0xf0, 0x4f, 0x82, 0x70, 0xc7, 0xe1, 0xc8,
+			0xd8, 0xad, 0x70, 0xcf, 0xf6,
+		}, {
+			0x60, 0x1f, 0x71, 0x07, 0x92, 0xae, 0xa0, 0x24,
+			0xb6, 0xa4, 0x10, 0x70, 0x1f, 0x94, 0x51, 0x9a,
+			0x5a, 0x81, 0xc4, 0x46, 0x78, 0x56, 0x71, 0xdd,
+			0x45, 0x63, 0x01, 0x34, 0x87, 0x79, 0xb4, 0xd5,
+			0x91, 0x79, 0xb9, 0x93, 0x11, 0x44, 0x50, 0xad,
+			0x64, 0x7e, 0x5c, 0xec, 0x16,
+		}, {
+			0x49, 0x2f, 0xa0, 0x45, 0xf8, 0xb0, 0x80, 0x88,
+			0x79, 0xeb, 0xb6, 0x82, 0x1c, 0xf3, 0x67, 0xc4,
+			0x88, 0x88, 0xe9, 0x75, 0x20, 0x54, 0x78, 0xc6,
+			0x5c, 0x59, 0xcf, 0xd9, 0x73, 0x12, 0x17, 0xf4,
+			0x30, 0x9c, 0xb7, 0x21, 0x45, 0xe2, 0xb6, 0x0c,
+			0x0c, 0xeb, 0x1b, 0xdc, 0xdc,
+		}
+	};
+	struct lrng_pool *lrng_pool, *lrng_pool_aligned;
+	u8 hash_df[sizeof(lrng_hash_df_selftest_result[0])]
+							__aligned(sizeof(u32));
+	u32 generated;
+	int ret = 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(lrng_hash_df_selftest_result) <
+							CONFIG_LRNG_POOL_SIZE);
+
+	lrng_pool = kzalloc(sizeof(struct lrng_pool) + LRNG_KCAPI_ALIGN,
+			    GFP_KERNEL);
+	if (!lrng_pool)
+		return LRNG_SEFLTEST_ERROR_HASHDF;
+	lrng_pool_aligned = PTR_ALIGN(lrng_pool, sizeof(u32));
+
+	generated = __lrng_pool_hash_df(crypto_cb, NULL, lrng_pool_aligned,
+					hash_df, sizeof(hash_df) << 3);
+
+	if ((generated >> 3) != sizeof(hash_df) ||
+	    memcmp(hash_df, lrng_hash_df_selftest_result[CONFIG_LRNG_POOL_SIZE],
+		   sizeof(hash_df))) {
+		pr_err("LRNG Hash DF self-test FAILED\n");
+		ret = LRNG_SEFLTEST_ERROR_HASHDF;
+	}
+
+	kfree(lrng_pool);
+	return ret;
+}
+
+/*
+ * The test vectors were generated using the ChaCha20 DRNG from
+ * https://www.chronox.de/chacha20.html
+ */
+static unsigned int lrng_chacha20_drng_selftest(void)
+{
+	const struct lrng_crypto_cb *crypto_cb = &lrng_cc20_crypto_cb;
+	static u8 const seed[CHACHA_KEY_SIZE * 2] = {
+		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+		0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+		0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+		0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+		0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+		0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+	};
+	struct chacha20_block chacha20;
+	int ret;
+	u8 outbuf[CHACHA_KEY_SIZE * 2] __aligned(sizeof(u32));
+
+	/*
+	 * Expected result when ChaCha20 DRNG state is zero:
+	 *	* constants are set to "expand 32-byte k"
+	 *	* remaining state is 0
+	 * and pulling one half ChaCha20 DRNG block.
+	 */
+	static u8 const expected_halfblock[CHACHA_KEY_SIZE] = {
+		0x76, 0xb8, 0xe0, 0xad, 0xa0, 0xf1, 0x3d, 0x90,
+		0x40, 0x5d, 0x6a, 0xe5, 0x53, 0x86, 0xbd, 0x28,
+		0xbd, 0xd2, 0x19, 0xb8, 0xa0, 0x8d, 0xed, 0x1a,
+		0xa8, 0x36, 0xef, 0xcc, 0x8b, 0x77, 0x0d, 0xc7 };
+
+	/*
+	 * Expected result when ChaCha20 DRNG state is zero:
+	 *	* constants are set to "expand 32-byte k"
+	 *	* remaining state is 0
+	 * followed by a reseed with two keyblocks
+	 *	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	 *	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	 *	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	 *	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	 *	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+	 *	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+	 *	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	 *	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f
+	 * and pulling one ChaCha20 DRNG block.
+	 */
+	static u8 const expected_oneblock[CHACHA_KEY_SIZE * 2] = {
+		0xf5, 0xb4, 0xb6, 0x5a, 0xec, 0xcd, 0x5a, 0x65,
+		0x87, 0x56, 0xe3, 0x86, 0x51, 0x54, 0xfc, 0x90,
+		0x56, 0xff, 0x5e, 0xae, 0x58, 0xf2, 0x01, 0x88,
+		0xb1, 0x7e, 0xb8, 0x2e, 0x17, 0x9a, 0x27, 0xe6,
+		0x86, 0xb3, 0xed, 0x33, 0xf7, 0xb9, 0x06, 0x05,
+		0x8a, 0x2d, 0x1a, 0x93, 0xc9, 0x0b, 0x80, 0x04,
+		0x03, 0xaa, 0x60, 0xaf, 0xd5, 0x36, 0x40, 0x11,
+		0x67, 0x89, 0xb1, 0x66, 0xd5, 0x88, 0x62, 0x6d };
+
+	/*
+	 * Expected result when ChaCha20 DRNG state is zero:
+	 *	* constants are set to "expand 32-byte k"
+	 *	* remaining state is 0
+	 * followed by a reseed with one key block plus one byte
+	 *	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	 *	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	 *	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	 *	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	 *	0x20
+	 * and pulling less than one ChaCha20 DRNG block.
+	 */
+	static u8 const expected_block_nonalinged[CHACHA_KEY_SIZE + 1] = {
+		0x3d, 0x13, 0x47, 0x1e, 0x7f, 0x7c, 0x99, 0x33,
+		0xfc, 0x44, 0xa4, 0xdd, 0xf9, 0x3d, 0xe1, 0x9a,
+		0xd4, 0xe8, 0x7a, 0x7d, 0x42, 0xac, 0xd1, 0xcd,
+		0x10, 0x69, 0xe7, 0xbf, 0xd4, 0xfd, 0x69, 0x4b,
+		0xa7 };
+
+	memset(&chacha20, 0, sizeof(chacha20));
+	lrng_cc20_init_rfc7539(&chacha20);
+
+	/* Generate with zero state */
+	ret = crypto_cb->lrng_drng_generate_helper(&chacha20, outbuf,
+						   sizeof(expected_halfblock));
+	if (ret != sizeof(expected_halfblock))
+		goto err;
+	if (memcmp(outbuf, expected_halfblock, sizeof(expected_halfblock)))
+		goto err;
+
+	/* Clear state of DRNG */
+	memset(&chacha20.key.u[0], 0, 48);
+
+	/* Reseed with 2 key blocks */
+	ret = crypto_cb->lrng_drng_seed_helper(&chacha20, seed,
+					       sizeof(expected_oneblock));
+	if (ret < 0)
+		goto err;
+	ret = crypto_cb->lrng_drng_generate_helper(&chacha20, outbuf,
+						   sizeof(expected_oneblock));
+	if (ret != sizeof(expected_oneblock))
+		goto err;
+	if (memcmp(outbuf, expected_oneblock, sizeof(expected_oneblock)))
+		goto err;
+
+	/* Clear state of DRNG */
+	memset(&chacha20.key.u[0], 0, 48);
+
+	/* Reseed with 1 key block and one byte */
+	ret = crypto_cb->lrng_drng_seed_helper(&chacha20, seed,
+					sizeof(expected_block_nonalinged));
+	if (ret < 0)
+		goto err;
+	ret = crypto_cb->lrng_drng_generate_helper(&chacha20, outbuf,
+					sizeof(expected_block_nonalinged));
+	if (ret != sizeof(expected_block_nonalinged))
+		goto err;
+	if (memcmp(outbuf, expected_block_nonalinged,
+		   sizeof(expected_block_nonalinged)))
+		goto err;
+
+	return LRNG_SELFTEST_PASSED;
+
+err:
+	pr_err("LRNG ChaCha20 DRNG self-test FAILED\n");
+	return LRNG_SEFLTEST_ERROR_CHACHA20;
+}
+
+static int lrng_selftest(void)
+{
+	unsigned int ret = lrng_time_process_selftest();
+
+	ret |= lrng_pool_lfsr_selftest();
+	ret |= lrng_chacha20_drng_selftest();
+	ret |= lrng_hash_df_selftest();
+
+	if (ret) {
+		if (IS_ENABLED(CONFIG_LRNG_SELFTEST_PANIC))
+			panic("LRNG self-tests failed: %u\n", ret);
+	} else {
+		pr_info("LRNG self-tests passed\n");
+	}
+
+	lrng_selftest_status = ret;
+
+	if (lrng_selftest_status)
+		return -EFAULT;
+	return 0;
+}
+
+#ifdef CONFIG_SYSFS
+/* Re-perform self-test when any value is written to the sysfs file. */
+static int lrng_selftest_sysfs_set(const char *val,
+				   const struct kernel_param *kp)
+{
+	return lrng_selftest();
+}
+
+static const struct kernel_param_ops lrng_selftest_sysfs = {
+	.set = lrng_selftest_sysfs_set,
+	.get = param_get_uint,
+};
+module_param_cb(selftest_status, &lrng_selftest_sysfs, &lrng_selftest_status,
+		0644);
+#endif	/* CONFIG_SYSFS */
+
+static int __init lrng_selftest_init(void)
+{
+	return lrng_selftest();
+}
+
+module_init(lrng_selftest_init);
-- 
2.24.1




