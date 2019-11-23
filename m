Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8472108098
	for <lists+linux-api@lfdr.de>; Sat, 23 Nov 2019 21:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfKWUkK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Nov 2019 15:40:10 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:14488 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfKWUjz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Nov 2019 15:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574541591;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1XIXAyivh3SlVT8r2ht8YGYBzbEHy76nyFOeZnQUS6Q=;
        b=Yj7cvtnjSkfeNYez8B478XTR9yE0HnZQwqGYSvOEAnp8rMyu8u2F9t4CRD1gT2oofM
        ozn3I5JIopqa+QBhMaJBZ24hBKUnJ+TKmK6JbmM5+uvY6xNNwveAaOfp6xwjUXHxeJgx
        SOMWLZ6wCvD7f/0/wIH5GLrzkMPcbCPz0Hrjtaw71mxrfMwnFsCdM+2rjX2L0vcgW7Uz
        c9Txqnc+x14eS/GDxMD6rfd3BGrpt3Ia+kyb/un5rDirIn28xBjr1yPys1HTr/wWIcE3
        YyKDXqQ8wPOjeMIRSwRjtPVUjjfW9Cg1fcYDA2vPvF51cDq0wEglvjfNPoxbDUbXF4Ml
        HIgg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJfSfWrhX"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vANKcV3yS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 23 Nov 2019 21:38:31 +0100 (CET)
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
Subject: [PATCH v26 09/12] LRNG - add Jitter RNG fast noise source
Date:   Sat, 23 Nov 2019 21:34:00 +0100
Message-ID: <32805752.pDMCn23lB6@positron.chronox.de>
In-Reply-To: <2722222.P16TYeLAVu@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de> <2722222.P16TYeLAVu@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The Jitter RNG fast noise source implemented as part of the kernel
crypto API is queried for 256 bits of entropy at the time the seed
buffer managed by the LRNG is about to be filled.

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
 drivers/char/lrng/Kconfig     | 11 +++++
 drivers/char/lrng/Makefile    |  1 +
 drivers/char/lrng/lrng_jent.c | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_jent.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 03e6e2ec356b..80fc723c67d2 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -80,4 +80,15 @@ config LRNG_KCAPI
 	  provided by the selected kernel crypto API RNG.
 endif # LRNG_DRNG_SWITCH
=20
+config LRNG_JENT
+	bool "Enable Jitter RNG as LRNG Seed Source"
+	select CRYPTO_JITTERENTROPY
+	help
+	  The Linux RNG may use the Jitter RNG as noise source. Enabling
+	  this option enables the use of the Jitter RNG. Its default
+	  entropy level is 16 bits of entropy per 256 data bits delivered
+	  by the Jitter RNG. This entropy level can be changed at boot
+	  time or at runtime with the lrng_base.jitterrng configuration
+	  variable.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 027b6ea51c20..a87d800c9aae 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SYSCTL)		+=3D lrng_proc.o
 obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
 obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
+obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
diff --git a/drivers/char/lrng/lrng_jent.c b/drivers/char/lrng/lrng_jent.c
new file mode 100644
index 000000000000..43114a44b8f5
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_jent.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Fast Noise Source: Jitter RNG
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "lrng_internal.h"
+
+/*
+ * Estimated entropy of data is a 16th of LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ * Albeit a full entropy assessment is provided for the noise source indic=
ating
+ * that it provides high entropy rates and considering that it deactivates
+ * when it detects insufficient hardware, the chosen under estimation of
+ * entropy is considered to be acceptable to all reviewers.
+ */
+static u32 jitterrng =3D LRNG_DRNG_SECURITY_STRENGTH_BITS>>4;
+module_param(jitterrng, uint, 0644);
+MODULE_PARM_DESC(jitterrng, "Entropy in bits of 256 data bits from Jitter "
+			    "RNG noise source");
+
+/**
+ * Get Jitter RNG entropy
+ *
+ * @outbuf buffer to store entropy
+ * @outbuflen length of buffer
+ * @return > 0 on success where value provides the added entropy in bits
+ *	   0 if no fast source was available
+ */
+struct rand_data;
+struct rand_data *jent_lrng_entropy_collector(void);
+int jent_read_entropy(struct rand_data *ec, unsigned char *data,
+		      unsigned int len);
+static struct rand_data *lrng_jent_state;
+
+u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen)
+{
+	int ret;
+	u32 ent_bits =3D jitterrng;
+	unsigned long flags;
+	static DEFINE_SPINLOCK(lrng_jent_lock);
+	static int lrng_jent_initialized =3D 0;
+
+	spin_lock_irqsave(&lrng_jent_lock, flags);
+
+	if (!ent_bits || (lrng_jent_initialized =3D=3D -1)) {
+		spin_unlock_irqrestore(&lrng_jent_lock, flags);
+		return 0;
+	}
+
+	if (!lrng_jent_initialized) {
+		lrng_jent_state =3D jent_lrng_entropy_collector();
+		if (!lrng_jent_state) {
+			jitterrng =3D 0;
+			lrng_jent_initialized =3D -1;
+			spin_unlock_irqrestore(&lrng_jent_lock, flags);
+			pr_info("Jitter RNG unusable on current system\n");
+			return 0;
+		}
+		lrng_jent_initialized =3D 1;
+		pr_debug("Jitter RNG working on current system\n");
+	}
+	ret =3D jent_read_entropy(lrng_jent_state, outbuf, outbuflen);
+	spin_unlock_irqrestore(&lrng_jent_lock, flags);
+
+	if (ret) {
+		pr_debug("Jitter RNG failed with %d\n", ret);
+		return 0;
+	}
+
+	/* Obtain entropy statement */
+	if (outbuflen !=3D LRNG_DRNG_SECURITY_STRENGTH_BYTES)
+		ent_bits =3D (ent_bits * outbuflen<<3) /
+			   LRNG_DRNG_SECURITY_STRENGTH_BITS;
+	/* Cap entropy to buffer size in bits */
+	ent_bits =3D min_t(u32, ent_bits, outbuflen<<3);
+	pr_debug("obtained %u bits of entropy from Jitter RNG noise source\n",
+		 ent_bits);
+
+	return ent_bits;
+}
+
+u32 lrng_jent_entropylevel(void)
+{
+	return min_t(u32, jitterrng, LRNG_DRNG_SECURITY_STRENGTH_BITS);
+}
=2D-=20
2.23.0




