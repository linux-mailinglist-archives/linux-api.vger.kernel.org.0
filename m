Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7E1423E5
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 08:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATHBW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 02:01:22 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:32431 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgATHBV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jan 2020 02:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579503678;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=QKNIQsi8ZdoYSk6W++0bm2Hui7vA8CCGEGPfHd2Fx9c=;
        b=EW2WFqoo56ljRfT7D9GqS0aIyySS5wa0qCDZhE8cpKAUUwkUfCswRpc9gQlxfL4Ikx
        ep4tSq7Sj4QHK+8YYkbTKPDoWc2nwTeyaxk+mMAFo9CeP6gTdUNUW0XHTIsr2zDn7Z9m
        93FLwt036T9jZRY8lOzdxWYOIoZYv2+hLuULFSrkCI2KvMH9sZ5iInl4EGXQ2gk/fSdK
        8XTjE65URDViiMNbKjL61wkHHbR2X5TR5hCV8XduA2oASe99zQ93WRKh7ZZFbm5GIN5A
        GxDmuNbP4Rm1KxVCuHlcNtC8v1RN2Sogy8dOG+8g0gg/s53VZrNchCvL8M5Av1Qoirin
        RyIw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJvSfTe7W"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0K6xsqZT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 20 Jan 2020 07:59:54 +0100 (CET)
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
Subject: [PATCH v29 04/12] LRNG - add switchable DRNG support
Date:   Sun, 19 Jan 2020 22:14:37 +0100
Message-ID: <2873504.ZWMft1h3jb@positron.chronox.de>
In-Reply-To: <1967138.dxe05VgvIB@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <5951792.lmNsirYsPE@positron.chronox.de> <1967138.dxe05VgvIB@positron.chronox.de>
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
 drivers/char/lrng/lrng_switch.c | 182 ++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_switch.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 56f13efd3592..cb701bb0b8b6 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -64,4 +64,11 @@ config LRNG_POOL_SIZE
 	default 7 if LRNG_POOL_SIZE_65536
 	default 8 if LRNG_POOL_SIZE_131072
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
index e69c176f0161..31cfe87c999e 100644
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
index 000000000000..7101bda9d7aa
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_switch.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG DRNG switching support
+ *
+ * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+static int lrng_drng_switch(struct lrng_drng *drng_store,
+			    const struct lrng_crypto_cb *cb, int node)
+{
+	const struct lrng_crypto_cb *old_cb;
+	unsigned long flags =3D 0;
+	int ret;
+	u8 seed[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	void *new_drng =3D cb->lrng_drng_alloc(LRNG_DRNG_SECURITY_STRENGTH_BYTES);
+	void *old_drng, *new_hash, *old_hash;
+	bool sl =3D false, reset_drng =3D !lrng_get_available();
+
+	if (IS_ERR(new_drng)) {
+		pr_warn("could not allocate new DRNG for NUMA node %d (%ld)\n",
+			node, PTR_ERR(new_drng));
+		return PTR_ERR(new_drng);
+	}
+
+	new_hash =3D cb->lrng_hash_alloc(seed, sizeof(seed));
+	if (IS_ERR(new_hash)) {
+		pr_warn("could not allocate new LRNG pool hash (%ld)\n",
+			PTR_ERR(new_hash));
+		cb->lrng_drng_dealloc(new_drng);
+		return PTR_ERR(new_hash);
+	}
+
+	lrng_drng_lock(drng_store, &flags);
+
+	/*
+	 * Pull from existing DRNG to seed new DRNG regardless of seed status
+	 * of old DRNG -- the entropy state for the DRNG is left unchanged which
+	 * implies that als the new DRNG is reseeded when deemed necessary. This
+	 * seeding of the new DRNG shall only ensure that the new DRNG has the
+	 * same entropy as the old DRNG.
+	 */
+	ret =3D drng_store->crypto_cb->lrng_drng_generate_helper(
+				drng_store->drng, seed, sizeof(seed));
+	lrng_drng_unlock(drng_store, &flags);
+
+	if (ret < 0) {
+		reset_drng =3D true;
+		pr_warn("getting random data from DRNG failed for NUMA node %d (%d)\n",
+			node, ret);
+	} else {
+		/* seed new DRNG with data */
+		ret =3D cb->lrng_drng_seed_helper(new_drng, seed, ret);
+		if (ret < 0) {
+			reset_drng =3D true;
+			pr_warn("seeding of new DRNG failed for NUMA node %d (%d)\n",
+				node, ret);
+		} else {
+			pr_debug("seeded new DRNG of NUMA node %d instance from old DRNG instan=
ce\n",
+				 node);
+		}
+	}
+
+	mutex_lock(&drng_store->lock);
+	/*
+	 * If we switch the DRNG from the initial ChaCha20 DRNG to something
+	 * else, there is a lock transition from spin lock to mutex (see
+	 * lrng_drng_is_atomic and how the lock is taken in lrng_drng_lock).
+	 * Thus, we need to take both locks during the transition phase.
+	 */
+	if (lrng_drng_is_atomic(drng_store)) {
+		spin_lock_irqsave(&drng_store->spin_lock, flags);
+		sl =3D true;
+	}
+
+	if (reset_drng)
+		lrng_drng_reset(drng_store);
+
+	old_drng =3D drng_store->drng;
+	old_cb =3D drng_store->crypto_cb;
+	drng_store->drng =3D new_drng;
+	drng_store->crypto_cb =3D cb;
+
+	old_hash =3D drng_store->hash;
+	drng_store->hash =3D new_hash;
+	pr_info("Entropy pool read-hash allocated for DRNG for NUMA node %d\n",
+		node);
+
+	if (sl)
+		spin_unlock_irqrestore(&drng_store->spin_lock, flags);
+	mutex_unlock(&drng_store->lock);
+
+	/* ChaCha20 serves as atomic instance left untouched. */
+	if (old_drng !=3D &chacha20) {
+		old_cb->lrng_drng_dealloc(old_drng);
+		old_cb->lrng_hash_dealloc(old_hash);
+	}
+
+	pr_info("DRNG of NUMA node %d switched\n", node);
+
+	return 0;
+}
+
+/*
+ * Switch the existing DRNG instances with new using the new crypto callba=
cks.
+ * The caller must hold the lrng_crypto_cb_update lock.
+ */
+static int lrng_drngs_switch(const struct lrng_crypto_cb *cb)
+{
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	struct lrng_drng *lrng_drng_init =3D lrng_drng_init_instance();
+	int ret =3D 0;
+
+	/* Update DRNG */
+	if (lrng_drng) {
+		u32 node;
+
+		for_each_online_node(node) {
+			if (lrng_drng[node])
+				ret =3D lrng_drng_switch(lrng_drng[node], cb,
+						       node);
+		}
+	} else {
+		ret =3D lrng_drng_switch(lrng_drng_init, cb, 0);
+	}
+
+	if (!ret)
+		lrng_set_available();
+
+	return 0;
+}
+
+/**
+ * lrng_set_drng_cb - Register new cryptographic callback functions for DR=
NG
+ * The registering implies that all old DRNG states are replaced with new
+ * DRNG states.
+ *
+ * @cb: Callback functions to be registered -- if NULL, use the default
+ *	callbacks pointing to the ChaCha20 DRNG.
+ *
+ * Return:
+ * * 0 on success
+ * * < 0 on error
+ */
+int lrng_set_drng_cb(const struct lrng_crypto_cb *cb)
+{
+	struct lrng_drng *lrng_drng_init =3D lrng_drng_init_instance();
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
+	    (lrng_drng_init->crypto_cb !=3D &lrng_cc20_crypto_cb)) {
+		pr_warn("disallow setting new cipher callbacks, unload the old callbacks=
 first!\n");
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
2.24.1




