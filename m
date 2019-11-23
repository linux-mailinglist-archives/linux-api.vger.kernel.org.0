Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA226108086
	for <lists+linux-api@lfdr.de>; Sat, 23 Nov 2019 21:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKWUjt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Nov 2019 15:39:49 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.176]:19911 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKWUjp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Nov 2019 15:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574541582;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=pZJHhJ4QGLDQQZWHMHnDGgqAQ27Z2Lqcy7vO7/o00CQ=;
        b=azZ3zrdidXt0yI/ZNLmYlPvobUbm2+9JIBC2M7kvDWWdu6zADMPq4TdO1/UWFWDek5
        LVuOveakjrkRXL4aQrt6twf0FE60Sb1JP+JXnIc/Fu0pDc0eDOd5gUjPAFDfhwYPgmgQ
        bZ/JmvgAwB42GGv0RCzuIi0bwfu/k47wegpKRtcYWMBX+ndJ8TMFdJO/zn2sV+e3Ovkp
        6n1EMOa4KwIGGEIZtFKgZkiESzXYLzg8nDRZmZAPrO1ySK5JFFzOAhPVemuaqdcTHdQA
        nco9vEqtyJEPRveD4CabP2dGKig+X5UWlhseUciU2U/XswkNOvkiXE2UbkhSj33MH1Fp
        cU/g==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJfSfWrhX"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vANKcb3yY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 23 Nov 2019 21:38:37 +0100 (CET)
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
Subject: [PATCH v26 04/12] LRNG - add switchable DRNG support
Date:   Sat, 23 Nov 2019 21:11:41 +0100
Message-ID: <10161131.P5Zqvtahu1@positron.chronox.de>
In-Reply-To: <2722222.P16TYeLAVu@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de> <2722222.P16TYeLAVu@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The DRNG switch support allows replacing the DRNG mechanism of the
LRNG. The switching support rests on the interface definition of
include/linux/lrng.h. A new DRNG is implemented by filling in the
interface defined in this header file.

In addition to the DRNG, the extension also has to provide a hash
implementation that is used to hash the entropy pool for random number
extraction.

Note: It is permissible to implement a DRNG whose operations may sleep.
However, the hash function must not sleep.

The switchable DRNG support allows replacing the DRNG at runtime.
However, only one DRNG extension is allowed to be loaded at any given
time. Before replacing it with another DRNG implementation, the possibly
existing DRNG extension must be unloaded.

The switchable DRNG extension activates the new DRNG during load time.
It is expected, however, that such a DRNG switch would be done only once
by an administrator to load the intended DRNG implementation.

It is permissible to compile DRNG extensions either as kernel modules or
statically. The initialization of the DRNG extension should be performed
with a late_initcall to ensure the extension is available when user
space starts but after all other initialization completed.
The initialization is performed by registering the function call data
structure with the lrng_set_drng_cb function. In order to unload the
DRNG extension, lrng_set_drng_cb must be invoked with the NULL
parameter.

The DRNG extension should always provide a security strength that is at
least as strong as LRNG_DRNG_SECURITY_STRENGTH_BITS.

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
 drivers/char/lrng/Kconfig       |   7 ++
 drivers/char/lrng/Makefile      |   1 +
 drivers/char/lrng/lrng_switch.c | 185 ++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_switch.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 1ba10fd421f3..c6e8eafd836c 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -52,4 +52,11 @@ config LRNG_POOL_SIZE
 	default 4 if LRNG_POOL_SIZE_65536
 	default 5 if LRNG_POOL_SIZE_131072
=20
+menuconfig LRNG_DRNG_SWITCH
+	bool "Support DRNG runtime switching"
+	help
+	  The Linux RNG per default uses a ChaCha20 DRNG that is
+	  accessible via the external interfaces. With this configuration
+	  option other DRNGs can be selected and loaded at runtime.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index b6240b73e33d..6bac97638767 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -10,3 +10,4 @@ obj-y				+=3D lrng_pool.o lrng_aux.o \
=20
 obj-$(CONFIG_NUMA)		+=3D lrng_numa.o
 obj-$(CONFIG_SYSCTL)		+=3D lrng_proc.o
+obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
diff --git a/drivers/char/lrng/lrng_switch.c b/drivers/char/lrng/lrng_switc=
h.c
new file mode 100644
index 000000000000..1e91a0d6df08
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_switch.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG DRNG switching support
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+static void lrng_sdrng_switch(struct lrng_sdrng *sdrng_store,
+			      const struct lrng_crypto_cb *cb, int node)
+{
+	const struct lrng_crypto_cb *old_cb;
+	unsigned long flags =3D 0;
+	int ret;
+	u8 seed[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	void *new_sdrng =3D
+			cb->lrng_drng_alloc(LRNG_DRNG_SECURITY_STRENGTH_BYTES);
+	void *old_sdrng, *new_hash =3D NULL, *old_hash =3D NULL;
+	bool sl =3D false, reset_sdrng =3D !lrng_get_available();
+
+	if (IS_ERR(new_sdrng)) {
+		pr_warn("could not allocate new secondary DRNG for NUMA node "
+			"%d (%ld)\n", node, PTR_ERR(new_sdrng));
+		return;
+	}
+
+#ifndef CONFIG_LRNG_TRNG_SUPPORT
+	new_hash =3D cb->lrng_hash_alloc(seed, sizeof(seed));
+#endif	/* CONFIG_LRNG_TRNG_SUPPORT */
+	if (IS_ERR(new_hash)) {
+		pr_warn("could not allocate new LRNG pool hash (%ld)\n",
+			PTR_ERR(new_hash));
+		cb->lrng_drng_dealloc(new_sdrng);
+		return;
+	}
+
+	lrng_sdrng_lock(sdrng_store, &flags);
+
+	/*
+	 * Pull from existing DRNG to seed new DRNG regardless of seed status
+	 * of old DRNG -- the entropy state for the secondary DRNG is left
+	 * unchanged which implies that als the new DRNG is reseeded when deemed
+	 * necessary. This seeding of the new DRNG shall only ensure that the
+	 * new DRNG has the same entropy as the old DRNG.
+	 */
+	ret =3D sdrng_store->crypto_cb->lrng_drng_generate_helper(
+				sdrng_store->sdrng, seed, sizeof(seed));
+	lrng_sdrng_unlock(sdrng_store, &flags);
+
+	if (ret < 0) {
+		reset_sdrng =3D true;
+		pr_warn("getting random data from secondary DRNG failed for "
+			"NUMA node %d (%d)\n", node, ret);
+	} else {
+		/* seed new DRNG with data */
+		ret =3D cb->lrng_drng_seed_helper(new_sdrng, seed, ret);
+		if (ret < 0) {
+			reset_sdrng =3D true;
+			pr_warn("seeding of new secondary DRNG failed for NUMA "
+				"node %d (%d)\n", node, ret);
+		} else {
+			pr_debug("seeded new secondary DRNG of NUMA node %d "
+				 "instance from old secondary DRNG instance\n",
+				 node);
+		}
+	}
+
+	mutex_lock(&sdrng_store->lock);
+	/*
+	 * If we switch the secondary DRNG from the initial ChaCha20 DRNG to
+	 * something else, there is a lock transition from spin lock to mutex
+	 * (see lrng_sdrng_is_atomic and how the lock is taken in
+	 * lrng_sdrng_lock). Thus, we need to take both locks during the
+	 * transition phase.
+	 */
+	if (lrng_sdrng_is_atomic(sdrng_store)) {
+		spin_lock_irqsave(&sdrng_store->spin_lock, flags);
+		sl =3D true;
+	}
+
+	if (reset_sdrng)
+		lrng_sdrng_reset(sdrng_store);
+
+	old_sdrng =3D sdrng_store->sdrng;
+	old_cb =3D sdrng_store->crypto_cb;
+	sdrng_store->sdrng =3D new_sdrng;
+	sdrng_store->crypto_cb =3D cb;
+
+	if (new_hash) {
+		old_hash =3D sdrng_store->hash;
+		sdrng_store->hash =3D new_hash;
+		pr_info("Entropy pool read-hash allocated for DRNG for NUMA "
+			"node %d\n", node);
+	}
+
+	if (sl)
+		spin_unlock_irqrestore(&sdrng_store->spin_lock, flags);
+	mutex_unlock(&sdrng_store->lock);
+
+	/* Secondary ChaCha20 serves as atomic instance left untouched. */
+	if (old_sdrng !=3D &secondary_chacha20) {
+		old_cb->lrng_drng_dealloc(old_sdrng);
+		if (old_hash)
+			old_cb->lrng_hash_dealloc(old_hash);
+	}
+
+	pr_info("secondary DRNG of NUMA node %d switched\n", node);
+}
+
+/**
+ * Switch the existing DRNG instances with new using the new crypto callba=
cks.
+ * The caller must hold the lrng_crypto_cb_update lock.
+ */
+static int lrng_drngs_switch(const struct lrng_crypto_cb *cb)
+{
+	struct lrng_sdrng **lrng_sdrng =3D lrng_sdrng_instances();
+	struct lrng_sdrng *lrng_sdrng_init =3D lrng_sdrng_init_instance();
+	int ret =3D lrng_trng_switch(cb);
+
+	if (ret)
+		return ret;
+
+	/* Update secondary DRNG */
+	if (lrng_sdrng) {
+		u32 node;
+
+		for_each_online_node(node) {
+			if (lrng_sdrng[node])
+				lrng_sdrng_switch(lrng_sdrng[node], cb, node);
+		}
+	} else
+		lrng_sdrng_switch(lrng_sdrng_init, cb, 0);
+
+	lrng_set_available();
+
+	return 0;
+}
+
+/**
+ * lrng_set_drng_cb - Register new cryptographic callback functions for DR=
NG
+ * The registering implies that all old DRNG states are replaced with new
+ * DRNG states.
+ * @cb: Callback functions to be registered -- if NULL, use the default
+ *	callbacks pointing to the ChaCha20 DRNG.
+ * @return: 0 on success, < 0 on error
+ */
+int lrng_set_drng_cb(const struct lrng_crypto_cb *cb)
+{
+	struct lrng_sdrng *lrng_sdrng_init =3D lrng_sdrng_init_instance();
+	int ret;
+
+	if (!cb)
+		cb =3D &lrng_cc20_crypto_cb;
+
+	mutex_lock(&lrng_crypto_cb_update);
+
+	/*
+	 * If a callback other than the default is set, allow it only to be
+	 * set back to the default callback. This ensures that multiple
+	 * different callbacks can be registered at the same time. If a
+	 * callback different from the current callback and the default
+	 * callback shall be set, the current callback must be deregistered
+	 * (e.g. the kernel module providing it must be unloaded) and the new
+	 * implementation can be registered.
+	 */
+	if ((cb !=3D &lrng_cc20_crypto_cb) &&
+	    (lrng_sdrng_init->crypto_cb !=3D &lrng_cc20_crypto_cb)) {
+		pr_warn("disallow setting new cipher callbacks, unload the old "
+			"callbacks first!\n");
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D lrng_drngs_switch(cb);
+
+out:
+	mutex_unlock(&lrng_crypto_cb_update);
+	return ret;
+}
+EXPORT_SYMBOL(lrng_set_drng_cb);
=2D-=20
2.23.0




