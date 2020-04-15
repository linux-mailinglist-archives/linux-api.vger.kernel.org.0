Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084E81A9B24
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896514AbgDOKnV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896479AbgDOKXi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 06:23:38 -0400
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5302::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2745C03C1AA;
        Wed, 15 Apr 2020 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586946170;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=hwS+x/N5sydmJA2FCwk6A+EN+suF8ZGXBUS8yhutk64=;
        b=GL2ETJs5cI6/lzkYaFA383WdxmnDNqDkpAKRyfZNZAUNcpBW9sLCd2IypAIlfQLHVv
        NQlWkOhQfebDu5pvDOQDkb8O1mmn6RZs/a+iygQMQBdG9Li0sbdPw/YtuiC32UAC+sAp
        5G5/PzcN8wVvEH8AukvoyJAg4B+PVKh0+dd9jHFoKhOAngK8OQIZKtcYUO1QRgKh7Mon
        ZOO+/2augkM39wCTOB6En8QghL9VJiIP1ke4SBvgwJSFD92Xx1sr12GzNDcuDm1VKb4i
        vePmFEFyIgzocxY5/kiQLrGTB3kH84/t/MVdABV6TsnA85g+c70nFaPb20flnRRIdov3
        eOEQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZIvSaiyU="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id 404ef0w3FAJj11z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 15 Apr 2020 12:19:45 +0200 (CEST)
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
Subject: [PATCH v30 11/12] LRNG - add interface for gathering of raw entropy
Date:   Wed, 15 Apr 2020 12:14:49 +0200
Message-ID: <4946330.IVaNDfpqxB@positron.chronox.de>
In-Reply-To: <11836144.hkEK2qVKZC@positron.chronox.de>
References: <11836144.hkEK2qVKZC@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The test interface allows a privileged process to capture the raw
unconditioned noise that is collected by the LRNG for statistical
analysis. Such testing allows the analysis how much entropy
the interrupt noise source provides on a given platform.
Extracted noise data is not used to seed the LRNG. This
is a test interface and not appropriate for production systems.
Yet, the interface is considered to be sufficiently secured for
production systems.

Access to the data is given through the lrng_raw debugfs file. The
data buffer should be multiples of sizeof(u32) to fill the entire
buffer. Using the option lrng_testing.boot_test=3D1 the raw noise of
the first 1000 entropy events since boot can be sampled.

This test interface allows generating the data required for
analysis whether the LRNG is in compliance with SP800-90B
sections 3.1.3 and 3.1.4.

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
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Kconfig        |  16 ++
 drivers/char/lrng/Makefile       |   1 +
 drivers/char/lrng/lrng_testing.c | 269 +++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_testing.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 323c657f7005..014ee82df79a 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -162,4 +162,20 @@ config LRNG_APT_CUTOFF
 	default 325 if !LRNG_APT_BROKEN
 	default 32 if LRNG_APT_BROKEN
=20
+config LRNG_TESTING
+	bool "Enable entropy test interface to LRNG noise source"
+	depends on DEBUG_FS
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned noise that is collected by the LRNG
+	  for statistical analysis. Extracted noise data is not used
+	  to seed the LRNG.
+
+	  The raw noise data can be obtained using the lrng_raw
+	  debugfs file. Using the option lrng_testing.boot_test=3D1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+	  If unsure, say N.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index c3008763dd14..b2ce1979dc4b 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
 obj-$(CONFIG_LRNG_HEALTH_TESTS)	+=3D lrng_health.o
+obj-$(CONFIG_LRNG_TESTING)	+=3D lrng_testing.o
diff --git a/drivers/char/lrng/lrng_testing.c b/drivers/char/lrng/lrng_test=
ing.c
new file mode 100644
index 000000000000..996fc665a0a0
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_testing.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Linux Random Number Generator (LRNG) Raw entropy collection tool
+ *
+ * Copyright (C) 2019 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/workqueue.h>
+#include <asm/errno.h>
+
+#include "lrng_internal.h"
+
+#define LRNG_TESTING_RINGBUFFER_SIZE	1024
+#define LRNG_TESTING_RINGBUFFER_MASK	(LRNG_TESTING_RINGBUFFER_SIZE - 1)
+
+static u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
+static u32 lrng_rb_reader =3D 0;
+static u32 lrng_rb_writer =3D 0;
+static atomic_t lrng_testing_enabled =3D ATOMIC_INIT(0);
+
+static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
+static DEFINE_SPINLOCK(lrng_raw_lock);
+
+/*
+ * 0 =3D=3D> No boot test, gathering of runtime data allowed
+ * 1 =3D=3D> Boot test enabled and ready for collecting data, gathering ru=
ntime
+ *	 data is disabled
+ * 2 =3D=3D> Boot test completed and disabled, gathering of runtime data is
+ *	 disabled
+ */
+static u32 boot_test =3D 0;
+module_param(boot_test, uint, 0644);
+MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the fir=
st entropy events");
+
+static inline void lrng_raw_entropy_reset(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lrng_raw_lock, flags);
+	lrng_rb_reader =3D 0;
+	lrng_rb_writer =3D 0;
+	spin_unlock_irqrestore(&lrng_raw_lock, flags);
+}
+
+static void lrng_raw_entropy_init(void)
+{
+	/*
+	 * The boot time testing implies we have a running test. If the
+	 * caller wants to clear it, he has to unset the boot_test flag
+	 * at runtime via sysfs to enable regular runtime testing
+	 */
+	if (boot_test)
+		return;
+
+	lrng_raw_entropy_reset();
+	atomic_set(&lrng_testing_enabled, 1);
+	pr_warn("Enabling raw entropy collection\n");
+}
+
+static void lrng_raw_entropy_fini(void)
+{
+	if (boot_test)
+		return;
+
+	atomic_set(&lrng_testing_enabled, 0);
+	lrng_raw_entropy_reset();
+	pr_warn("Disabling raw entropy collection\n");
+}
+
+bool lrng_raw_entropy_store(u32 value)
+{
+	unsigned long flags;
+
+	if (!atomic_read(&lrng_testing_enabled) && (boot_test !=3D 1))
+		return false;
+
+	spin_lock_irqsave(&lrng_raw_lock, flags);
+
+	/*
+	 * Disable entropy testing for boot time testing after ring buffer
+	 * is filled.
+	 */
+	if (boot_test) {
+		if (lrng_rb_writer > LRNG_TESTING_RINGBUFFER_SIZE) {
+			boot_test =3D 2;
+			pr_warn_once("Boot time entropy collection test disabled\n");
+			spin_unlock_irqrestore(&lrng_raw_lock, flags);
+			return false;
+		}
+
+		if (lrng_rb_writer =3D=3D 1)
+			pr_warn("Boot time entropy collection test enabled\n");
+	}
+
+	lrng_testing_rb[lrng_rb_writer & LRNG_TESTING_RINGBUFFER_MASK] =3D value;
+	lrng_rb_writer++;
+
+	spin_unlock_irqrestore(&lrng_raw_lock, flags);
+
+	if (wq_has_sleeper(&lrng_raw_read_wait))
+		wake_up_interruptible(&lrng_raw_read_wait);
+
+	return true;
+}
+
+static inline bool lrng_raw_have_data(void)
+{
+	return ((lrng_rb_writer & LRNG_TESTING_RINGBUFFER_MASK) !=3D
+		 (lrng_rb_reader & LRNG_TESTING_RINGBUFFER_MASK));
+}
+
+static int lrng_raw_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	unsigned long flags;
+	int collected_data =3D 0;
+
+	lrng_raw_entropy_init();
+
+	while (outbuflen) {
+		spin_lock_irqsave(&lrng_raw_lock, flags);
+
+		/* We have no data or reached the writer. */
+		if (!lrng_rb_writer || (lrng_rb_writer =3D=3D lrng_rb_reader)) {
+
+			spin_unlock_irqrestore(&lrng_raw_lock, flags);
+
+			/*
+			 * Now we gathered all boot data, enable regular data
+			 * collection.
+			 */
+			if (boot_test) {
+				boot_test =3D 0;
+				goto out;
+			}
+
+			wait_event_interruptible(lrng_raw_read_wait,
+						 lrng_raw_have_data());
+			if (signal_pending(current)) {
+				collected_data =3D -ERESTARTSYS;
+				goto out;
+			}
+
+			continue;
+		}
+
+		/* We copy out word-wise */
+		if (outbuflen < sizeof(u32)) {
+			spin_unlock_irqrestore(&lrng_raw_lock, flags);
+			goto out;
+		}
+
+		memcpy(outbuf, &lrng_testing_rb[lrng_rb_reader], sizeof(u32));
+		lrng_rb_reader++;
+
+		spin_unlock_irqrestore(&lrng_raw_lock, flags);
+
+		outbuf +=3D sizeof(u32);
+		outbuflen -=3D sizeof(u32);
+		collected_data +=3D sizeof(u32);
+	}
+
+out:
+	lrng_raw_entropy_fini();
+	return collected_data;
+}
+
+/**************************************************************************
+ * Debugfs interface
+ *************************************************************************=
*/
+static int lrng_raw_extract_user(char __user *buf, size_t nbytes)
+{
+	u8 *tmp, *tmp_aligned;
+	int ret =3D 0, large_request =3D (nbytes > 256);
+
+	/*
+	 * The intention of this interface is for collecting at least
+	 * 1000 samples due to the SP800-90B requirements. So, we make no
+	 * effort in avoiding allocating more memory that actually needed
+	 * by the user. Hence, we allocate sufficient memory to always hold
+	 * that amount of data.
+	 */
+	tmp =3D kmalloc(LRNG_TESTING_RINGBUFFER_SIZE + sizeof(u32), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp_aligned =3D PTR_ALIGN(tmp, sizeof(u32));
+
+	while (nbytes) {
+		int i;
+
+		if (large_request && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret =3D=3D 0)
+					ret =3D -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		i =3D min_t(int, nbytes, LRNG_TESTING_RINGBUFFER_SIZE);
+		i =3D lrng_raw_entropy_reader(tmp_aligned, i);
+		if (i <=3D 0) {
+			if (i < 0)
+				ret =3D i;
+			break;
+		}
+		if (copy_to_user(buf, tmp_aligned, i)) {
+			ret =3D -EFAULT;
+			break;
+		}
+
+		nbytes -=3D i;
+		buf +=3D i;
+		ret +=3D i;
+	}
+
+	kzfree(tmp);
+	return ret;
+}
+
+/* DebugFS operations and definition of the debugfs files */
+static ssize_t lrng_raw_read(struct file *file, char __user *to,
+			     size_t count, loff_t *ppos)
+{
+	loff_t pos =3D *ppos;
+	int ret;
+
+	if (!count)
+		return 0;
+
+	ret =3D lrng_raw_extract_user(to, count);
+	if (ret < 0)
+		return ret;
+
+	count -=3D ret;
+	*ppos =3D pos + count;
+
+	return ret;
+}
+
+static const struct file_operations lrng_raw_name_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_read,
+};
+
+static int __init lrng_raw_init(void)
+{
+	struct dentry *lrng_raw_debugfs_root;
+
+	lrng_raw_debugfs_root =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
+	debugfs_create_file_unsafe("lrng_raw", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_raw_name_fops);
+
+	return 0;
+}
+
+module_init(lrng_raw_init);
=2D-=20
2.25.2




