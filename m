Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C54108095
	for <lists+linux-api@lfdr.de>; Sat, 23 Nov 2019 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfKWUkC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Nov 2019 15:40:02 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.175]:23247 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfKWUkB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Nov 2019 15:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574541599;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ThK0/tIEOL2Gmqz3Ei+ZYrYCzmS9Q/TMif6Cp2/Yorg=;
        b=gnqu3ihdsy8qPNLMCF98EIKxsRFconBT3Z2NxqZPK4l6YCJSQUtG0MKz0c4eO3RsNJ
        c9v0HDWT0QAeCe1Ys3HspRGpaExqIUXb3zrDvAKT3Rcz2d+ryTZJcxEKR+VPAUtX2QN/
        VfTVApv+aMWp50nfbqMJIEGNbZh0/Z/q1I94+hnXixYddOamB8R4wweUkBwZS57rJxqI
        NcoXw5w8IjcyvAs/EjIdV4EWd8fMfiwQPCwI2td54vjhDqmotAoI+Jvlcolhq3boIkZa
        k06PhzYXIpzB/RS3tkoNycFrCd89j0hc93n331i2Qsjmm+JPcIJ58YCK4AMoGLKPQ5Cc
        Wk1w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJfSfWrhX"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vANKcU3yR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 23 Nov 2019 21:38:30 +0100 (CET)
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
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v26 10/12] LRNG - add TRNG support
Date:   Sat, 23 Nov 2019 21:34:24 +0100
Message-ID: <33503687.hpnIkuazyB@positron.chronox.de>
In-Reply-To: <2722222.P16TYeLAVu@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de> <2722222.P16TYeLAVu@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The True Random Number Generator (TRNG) provides a random number
generator with prediction resistance (SP800-90A terminology) or an NTG.1
(AIS 31 terminology).

When enabled, it obtains random numbers from the entropy pool and
maintains the information with how much entropy it was seeded with. The
TRNG only generates as much output data as it has as entropy.

The secondary DRNGs seed from the TRNG if it is present. In addition,
the TRNG is accessible from user space using the getrandom system call
with the GRND_TRUERANDOM flag.

When getrandom(GRND_TRUERANDOM) is invoked by a process possessing
CAP_SYS_ADMIN, all available entropy in the entropy pool is used to
serve the request. If the calling process does not possess that
capability, entropy is drawn to the extent that the entropy pool
will retain at least 1024 bits of entropy. This approach prevents
unprivileged processes to deplete existing entropy preventing
privileged callers from obtaining that entropy.

Since the secondary DRNG can draw from the entropy pool down to
a minimum entropy level of 512 bits, it will be provided with
entropy while an unprivileged user stresses
getrandom(GRND_TRUERANDOM).

If the TRNG is disabled, the secondary DRNGs seed from the entropy
pool. The getrandom(GRND_TRUERANDOM) call will return -EOPNOTSUPP
in this case.

The TRNG benefits from the switchable DRNG support which implies that
data provided via /dev/random is generated by the loaded DRNG.

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
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Kconfig     |  22 +++
 drivers/char/lrng/Makefile    |   1 +
 drivers/char/lrng/lrng_trng.c | 297 ++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_trng.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 80fc723c67d2..122d67ee110e 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -91,4 +91,26 @@ config LRNG_JENT
 	  time or at runtime with the lrng_base.jitterrng configuration
 	  variable.
=20
+config LRNG_TRNG_SUPPORT
+	bool "Enable True Random Number Generator support"
+	default y
+	help
+	  The true random number generator (TRNG) support, also
+	  known as DRNG with prediction resistance (SP800-90A
+	  terminology) or NTG.1 (AIS 31 terminology), generates
+	  random numbers after a successful reseed with entropy.
+	  Only when new entropy is provided for a new generation
+	  request, random data is provided with an equal amount
+	  as entropy was added. The TRNG is available via
+	  /dev/random.
+
+	  If the support is not enabled, /dev/random ensures that
+	  it received sufficient initial entropy and will produce
+	  random data without requiring a constant reseed with
+	  entropy. Yet it tries to regularly reseed itself with
+	  fresh entropy.
+
+	  With the TRNG support the /dev/random device will block
+	  if insufficient entropy is available.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index a87d800c9aae..1c72bc060bce 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
 obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
+obj-$(CONFIG_LRNG_TRNG_SUPPORT)	+=3D lrng_trng.o
diff --git a/drivers/char/lrng/lrng_trng.c b/drivers/char/lrng/lrng_trng.c
new file mode 100644
index 000000000000..d594d5d5bffb
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_trng.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG True Random Number Generator (TRNG) processing
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/capability.h>
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+/* TRNG state handle */
+struct lrng_trng {
+	void *trng;				/* TRNG handle */
+	void *hash;				/* Hash handle */
+	u32 trng_entropy_bits;			/* TRNG entropy level */
+	const struct lrng_crypto_cb *crypto_cb;	/* Crypto callbacks */
+	struct mutex lock;
+};
+
+/* TRNG for GRND_TRUERANDOM and seed source for the secondary DRNG(s) */
+static struct lrng_trng lrng_trng =3D {
+	.trng		=3D &primary_chacha20,
+	.crypto_cb	=3D &lrng_cc20_crypto_cb,
+	.lock		=3D __MUTEX_INITIALIZER(lrng_trng.lock)
+};
+
+/********************************** Helper *******************************=
*****/
+
+void lrng_trng_reset(void)
+{
+	lrng_trng.trng_entropy_bits =3D 0;
+	pr_debug("reset TRNG\n");
+}
+
+void lrng_trng_init(void)
+{
+	mutex_lock(&lrng_trng.lock);
+	lrng_trng_reset();
+	lrng_cc20_init_state(&primary_chacha20);
+	mutex_unlock(&lrng_trng.lock);
+}
+
+u32 lrng_trng_retain(void)
+{
+	if (capable(CAP_SYS_ADMIN))
+		return 0;
+	return LRNG_EMERG_ENTROPY_TRNG_UNPRIV;
+}
+
+/************************* Random Number Generation **********************=
*****/
+
+/* Caller must hold lrng_trng.lock */
+static int lrng_trng_generate(u8 *outbuf, u32 outbuflen)
+{
+	struct lrng_trng *trng =3D &lrng_trng;
+	const struct lrng_crypto_cb *crypto_cb =3D trng->crypto_cb;
+	int ret;
+
+	/*
+	 * Only deliver as many bytes as the DRNG is seeded with except during
+	 * initialization to provide a first seed to the secondary DRNG.
+	 */
+	if (lrng_state_min_seeded())
+		outbuflen =3D min_t(u32, outbuflen, trng->trng_entropy_bits>>3);
+	else
+		outbuflen =3D min_t(u32, outbuflen,
+				  LRNG_MIN_SEED_ENTROPY_BITS>>3);
+	if (!outbuflen)
+		return 0;
+
+	ret =3D crypto_cb->lrng_drng_generate_helper_full(trng->trng, outbuf,
+							outbuflen);
+	if (ret !=3D outbuflen) {
+		pr_warn("getting random data from TRNG failed (%d)\n",
+			ret);
+		return ret;
+	}
+
+	if (trng->trng_entropy_bits > (u32)(ret<<3))
+		trng->trng_entropy_bits -=3D ret<<3;
+	else
+		trng->trng_entropy_bits =3D 0;
+	pr_debug("obtained %d bytes of random data from TRNG\n", ret);
+	pr_debug("TRNG entropy level at %u bits\n",
+		 trng->trng_entropy_bits);
+
+	return ret;
+}
+
+/**
+ * Inject data into the TRNG with a given entropy value. The function calls
+ * the DRNG's update function. This function also generates random data if
+ * requested by caller. The caller is only returned the amount of random d=
ata
+ * that is at most equal to the amount of entropy that just seeded the DRN=
G.
+ *
+ * Note, this function seeds the TRNG and generates data in an atomic oper=
ation.
+ *
+ * @inbuf: buffer to inject
+ * @inbuflen: length of inbuf
+ * @entropy_bits: entropy value of the data in inbuf in bits
+ * @outbuf: buffer to fill immediately after seeding to get full entropy
+ * @outbuflen: length of outbuf
+ * @return: number of bytes written to outbuf, 0 if outbuf is not supplied,
+ *	    or < 0 in case of error
+ */
+static int lrng_trng_inject(const u8 *inbuf, u32 inbuflen, u32 entropy_bit=
s,
+			    u8 *outbuf, u32 outbuflen)
+{
+	struct lrng_trng *trng =3D &lrng_trng;
+	int ret;
+
+	/* cap the maximum entropy value to the provided data length */
+	entropy_bits =3D min_t(u32, entropy_bits, inbuflen<<3);
+
+	mutex_lock(&trng->lock);
+	ret =3D trng->crypto_cb->lrng_drng_seed_helper(trng->trng, inbuf,
+						      inbuflen);
+	if (ret < 0) {
+		pr_warn("(re)seeding of TRNG failed\n");
+		goto unlock;
+	}
+	pr_debug("inject %u bytes with %u bits of entropy into TRNG\n",
+		 inbuflen, entropy_bits);
+
+	/* Adjust the fill level indicator to at most the DRNG sec strength */
+	trng->trng_entropy_bits =3D
+		min_t(u32, trng->trng_entropy_bits + entropy_bits,
+		      LRNG_DRNG_SECURITY_STRENGTH_BITS);
+	lrng_init_ops(trng->trng_entropy_bits);
+
+	if (outbuf && outbuflen)
+		ret =3D lrng_trng_generate(outbuf, outbuflen);
+
+unlock:
+	mutex_unlock(&trng->lock);
+	lrng_reader_wakeup();
+
+	return ret;
+}
+
+/**
+ * Seed the TRNG from the internal noise sources and generate random data.=
 The
+ * seeding and the generation of random data is an atomic operation.
+ *
+ * lrng_pool_trylock() must be invoked successfully by caller.
+ */
+int lrng_trng_seed(u8 *outbuf, u32 outbuflen, u32 entropy_retain)
+{
+	struct entropy_buf entropy_buf __aligned(LRNG_KCAPI_ALIGN);
+	struct lrng_trng *trng =3D &lrng_trng;
+	u32 total_entropy_bits;
+	int ret =3D 0, retrieved =3D 0;
+
+	/* Get available entropy in primary DRNG */
+	if (trng->trng_entropy_bits>>3) {
+		mutex_lock(&trng->lock);
+		ret =3D lrng_trng_generate(outbuf, outbuflen);
+		mutex_unlock(&trng->lock);
+		if (ret > 0) {
+			retrieved +=3D ret;
+			if (ret =3D=3D outbuflen)
+				goto out;
+
+			outbuf +=3D ret;
+			outbuflen -=3D ret;
+		}
+		/* Disregard error code as another generate request is below. */
+	}
+
+	mutex_lock(&trng->lock);
+	total_entropy_bits =3D lrng_fill_seed_buffer(trng->crypto_cb, trng->hash,
+						   &entropy_buf,
+						   entropy_retain);
+	mutex_unlock(&trng->lock);
+
+	/*
+	 * Continue even of total_entropy_bits is zero - inject uninitialized
+	 * buffer into TRNG for pure mixing in this case.
+	 */
+
+	pr_debug("reseed TRNG from internal noise sources with %u bits "
+		 "of entropy\n", total_entropy_bits);
+
+	ret =3D lrng_trng_inject((u8 *)&entropy_buf, sizeof(entropy_buf),
+				total_entropy_bits,
+				outbuf, outbuflen);
+
+	memzero_explicit(&entropy_buf, sizeof(entropy_buf));
+
+	if (ret > 0)
+		retrieved +=3D ret;
+
+out:
+	/* Allow the seeding operation to be called again */
+	lrng_pool_unlock();
+
+	return (ret >=3D 0) ? retrieved : ret;
+}
+
+/**
+ * Obtain random data from TRNG with information theoretical entropy by
+ * triggering a reseed. The TRNG will only return as many random bytes as =
it
+ * was seeded with.
+ *
+ * @outbuf: buffer to store the random data in
+ * @outbuflen: length of outbuf
+ * @return: < 0 on error
+ *	    >=3D 0 the number of bytes that were obtained
+ */
+int lrng_trng_get(u8 *outbuf, u32 outbuflen)
+{
+	int ret;
+
+	if (!outbuf || !outbuflen)
+		return 0;
+
+	lrng_drngs_init_cc20();
+
+	if (lrng_pool_trylock())
+		return -EINPROGRESS;
+	ret =3D lrng_trng_seed(outbuf, outbuflen, lrng_trng_retain());
+	if (ret >=3D 0) {
+		pr_debug("read %d bytes of full entropy data from TRNG\n", ret);
+	} else {
+		/* This is no error, but we have not generated anything */
+		if (ret =3D=3D -EINPROGRESS)
+			return 0;
+		pr_debug("reading data from TRNG failed: %d\n", ret);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+int lrng_trng_switch(const struct lrng_crypto_cb *cb)
+{
+	int ret;
+	u8 seed[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	void *trng, *hash;
+
+	trng =3D cb->lrng_drng_alloc(LRNG_DRNG_SECURITY_STRENGTH_BYTES);
+	if (IS_ERR(trng))
+		return PTR_ERR(trng);
+
+	hash =3D cb->lrng_hash_alloc(seed, sizeof(seed));
+	if (IS_ERR(hash)) {
+		pr_warn("could not allocate new LRNG pool hash (%ld)\n",
+			PTR_ERR(hash));
+		cb->lrng_drng_dealloc(trng);
+		return PTR_ERR(hash);
+	}
+
+	/* Update primary DRNG */
+	mutex_lock(&lrng_trng.lock);
+	/* pull from existing DRNG to seed new DRNG */
+	ret =3D lrng_trng.crypto_cb->lrng_drng_generate_helper_full(
+					lrng_trng.trng, seed, sizeof(seed));
+	if (ret < 0) {
+		lrng_trng_reset();
+		pr_warn("getting random data from TRNG failed (%d)\n", ret);
+	} else {
+		/*
+		 * No change of the seed status as the old and new DRNG have
+		 * same security strength.
+		 */
+		ret =3D cb->lrng_drng_seed_helper(trng, seed, ret);
+		if (ret < 0) {
+			lrng_trng_reset();
+			pr_warn("seeding of new TRNG failed (%d)\n", ret);
+		} else {
+			pr_debug("seeded new TRNG instance from old TRNG "
+				 "instance\n");
+		}
+	}
+	memzero_explicit(seed, sizeof(seed));
+
+	if (!lrng_get_available())
+		lrng_trng_reset();
+	lrng_trng.crypto_cb->lrng_drng_dealloc(lrng_trng.trng);
+	lrng_trng.trng =3D trng;
+
+	lrng_trng.crypto_cb->lrng_hash_dealloc(lrng_trng.hash);
+	lrng_trng.hash =3D hash;
+
+	lrng_trng.crypto_cb =3D cb;
+
+	mutex_unlock(&lrng_trng.lock);
+
+	pr_info("TRNG allocated\n");
+
+	return ret;
+}
+#endif	/* CONFIG_LRNG_DRNG_SWITCH */
=2D-=20
2.23.0




