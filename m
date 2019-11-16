Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2735FEB7C
	for <lists+linux-api@lfdr.de>; Sat, 16 Nov 2019 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfKPJmO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 16 Nov 2019 04:42:14 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:28962 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfKPJmD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 16 Nov 2019 04:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573897319;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=i7+tyi/ui/ZZcsCMNco3tb20FtMFwaJDIq266p878QI=;
        b=RkmtxOKnY7CMbHesgAhc1BEsfCG7EBu9u5IC9GIIiuxay9SU4X6+eoKG5NP1chtFY8
        rVzviJ8MNE7pPi8AUJNseFKieR9XC1FbR8oZk8JXNsvdMynlBTKyJfzxeCpDZkqMEd7O
        INv1+kEsy8CuVtsw/Un3oroxDQ2ZCq0XZ4qXR4i65dCsp8VbIUrAufeoPuRkycDYSX+Z
        72U5L9BZAKLaq1zkHxsYrEFrXFZLiErv+j/9UCNDCy9YViyzHDFKZ3OpieETuefTNwIV
        5tmTEtsy7SBv3Tp/h4eKJiQ6BGLYLlgB4NVQxYoALMimXMMdVwg/l1w1f8M5333bA9DV
        Zc4w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x2YdNp5OujZ6kplo"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vAG9eRRI7
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 16 Nov 2019 10:40:27 +0100 (CET)
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
Subject: [PATCH v25 12/12] LRNG - add interface for gathering of raw entropy
Date:   Sat, 16 Nov 2019 10:38:12 +0100
Message-ID: <3610406.x8mDjznOIz@positron.chronox.de>
In-Reply-To: <2787174.DQlWHN5GGo@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The test interface allows a privileged process to capture the raw
unconditioned noise that is collected by the LRNG for statistical
analysis. Extracted noise data is not used to seed the LRNG. This
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
 drivers/char/lrng/lrng_testing.c | 324 +++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_testing.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index e6ca3acc1e48..4ccc710832ef 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -169,4 +169,20 @@ config LRNG_APT_CUTOFF
 	default 325 if !LRNG_APT_BROKEN
 	default 32 if LRNG_APT_BROKEN
=20
+config LRNG_TESTING
+	bool "Enable entropy test interface to LRNG noise source"
+	select CONFIG_DEBUG_FS
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
index 0713e9c0aa6e..c0b6cc4301fe 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
 obj-$(CONFIG_LRNG_TRNG_SUPPORT)	+=3D lrng_trng.o
 obj-$(CONFIG_LRNG_HEALTH_TESTS)	+=3D lrng_health.o
+obj-$(CONFIG_LRNG_TESTING)	+=3D lrng_testing.o
diff --git a/drivers/char/lrng/lrng_testing.c b/drivers/char/lrng/lrng_test=
ing.c
new file mode 100644
index 000000000000..5c33d3bd2172
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_testing.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Linux Random Number Generator (LRNG) Raw entropy collection tool
+ *
+ * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
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
+static atomic_t lrng_rb_reader =3D ATOMIC_INIT(0);
+static atomic_t lrng_rb_writer =3D ATOMIC_INIT(0);
+static atomic_t lrng_rb_first_in =3D ATOMIC_INIT(0);
+static atomic_t lrng_testing_enabled =3D ATOMIC_INIT(0);
+
+static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
+
+static u32 boot_test =3D 0;
+module_param(boot_test, uint, 0644);
+MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the fir=
st"
+			    " entropy events");
+
+static inline void lrng_raw_entropy_reset(void)
+{
+	atomic_set(&lrng_rb_reader, 0);
+	atomic_set(&lrng_rb_writer, 0);
+	atomic_set(&lrng_rb_first_in, 0);
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
+	lrng_raw_entropy_reset();
+	atomic_set(&lrng_testing_enabled, 0);
+	pr_warn("Disabling raw entropy collection\n");
+}
+
+bool lrng_raw_entropy_store(u32 value)
+{
+	unsigned int write_ptr;
+	unsigned int read_ptr;
+
+	if (!atomic_read(&lrng_testing_enabled) && !boot_test)
+		return false;
+
+	write_ptr =3D (unsigned int)atomic_add_return_relaxed(1, &lrng_rb_writer);
+	read_ptr =3D (unsigned int)atomic_read(&lrng_rb_reader);
+
+	/*
+	 * Disable entropy testing for boot time testing after ring buffer
+	 * is filled.
+	 */
+	if (boot_test && write_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
+		pr_warn_once("Boot time entropy collection test disabled\n");
+		return false;
+	}
+
+	if (boot_test && !atomic_read(&lrng_rb_first_in))
+		pr_warn("Boot time entropy collection test enabled\n");
+
+	lrng_testing_rb[write_ptr & LRNG_TESTING_RINGBUFFER_MASK] =3D value;
+
+	/* We got at least one event, enable the reader now. */
+	atomic_set(&lrng_rb_first_in, 1);
+
+	if (wq_has_sleeper(&lrng_raw_read_wait))
+		wake_up_interruptible(&lrng_raw_read_wait);
+
+	/*
+	 * Our writer is taking over the reader - this means the reader
+	 * one full ring buffer available. Thus we "push" the reader ahead
+	 * to guarantee that he will be able to consume the full ring.
+	 */
+	if (!boot_test &&
+	    ((write_ptr & LRNG_TESTING_RINGBUFFER_MASK) =3D=3D
+	    (read_ptr & LRNG_TESTING_RINGBUFFER_MASK)))
+		atomic_inc_return_relaxed(&lrng_rb_reader);
+
+	return true;
+}
+
+static inline bool lrng_raw_have_data(void)
+{
+	unsigned int read_ptr =3D (unsigned int)atomic_read(&lrng_rb_reader);
+	unsigned int write_ptr =3D (unsigned int)atomic_read(&lrng_rb_writer);
+
+	return (atomic_read(&lrng_rb_first_in) &&
+		(write_ptr & LRNG_TESTING_RINGBUFFER_MASK) !=3D
+		 (read_ptr & LRNG_TESTING_RINGBUFFER_MASK));
+}
+
+static int lrng_raw_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	int collected_data =3D 0;
+
+	if (!atomic_read(&lrng_testing_enabled) && !boot_test)
+		return -EAGAIN;
+
+	if (!atomic_read(&lrng_rb_first_in)) {
+		wait_event_interruptible(lrng_raw_read_wait,
+					 lrng_raw_have_data());
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+	}
+
+	while (outbuflen) {
+		unsigned int read_ptr =3D
+			(unsigned int)atomic_add_return_relaxed(
+							1, &lrng_rb_reader);
+		unsigned int write_ptr =3D
+			(unsigned int)atomic_read(&lrng_rb_writer);
+
+		/*
+		 * For boot time testing, only output one round of ring buffer.
+		 */
+		if (boot_test && read_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
+			collected_data =3D -ENOMSG;
+			goto out;
+		}
+
+		/* We reached the writer */
+		if (!boot_test && ((write_ptr & LRNG_TESTING_RINGBUFFER_MASK) =3D=3D
+		    (read_ptr & LRNG_TESTING_RINGBUFFER_MASK))) {
+			wait_event_interruptible(lrng_raw_read_wait,
+						 lrng_raw_have_data());
+			if (signal_pending(current))
+				return -ERESTARTSYS;
+
+			continue;
+		}
+
+		/* We copy out word-wise */
+		if (outbuflen < sizeof(u32)) {
+			atomic_dec_return_relaxed(&lrng_rb_reader);
+			goto out;
+		}
+
+		memcpy(outbuf,
+		       &lrng_testing_rb[read_ptr & LRNG_TESTING_RINGBUFFER_MASK],
+		       sizeof(u32));
+		outbuf +=3D sizeof(u32);
+		outbuflen -=3D sizeof(u32);
+		collected_data +=3D sizeof(u32);
+	}
+
+out:
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
+/*
+ * This data structure holds the dentry's of the debugfs files establishing
+ * the interface to user space.
+ */
+struct lrng_raw_debugfs {
+	struct dentry *lrng_raw_debugfs_root; /* root dentry */
+	struct dentry *lrng_raw_debugfs_lrng_raw; /* .../lrng_raw */
+};
+
+static struct lrng_raw_debugfs lrng_raw_debugfs;
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
+	lrng_raw_entropy_init();
+	ret =3D lrng_raw_extract_user(to, count);
+	lrng_raw_entropy_fini();
+	if (ret < 0)
+		return ret;
+	count -=3D ret;
+	*ppos =3D pos + count;
+	return ret;
+}
+
+/* Module init: allocate memory, register the debugfs files */
+static int lrng_raw_debugfs_init(void)
+{
+	lrng_raw_debugfs.lrng_raw_debugfs_root =3D
+		debugfs_create_dir(KBUILD_MODNAME, NULL);
+	if (IS_ERR(lrng_raw_debugfs.lrng_raw_debugfs_root)) {
+		lrng_raw_debugfs.lrng_raw_debugfs_root =3D NULL;
+		return PTR_ERR(lrng_raw_debugfs.lrng_raw_debugfs_root);
+	}
+	return 0;
+}
+
+static struct file_operations lrng_raw_name_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_read,
+};
+
+static int lrng_raw_debugfs_init_name(void)
+{
+	lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw =3D
+		debugfs_create_file("lrng_raw", 0400,
+				    lrng_raw_debugfs.lrng_raw_debugfs_root,
+				    NULL, &lrng_raw_name_fops);
+	if (IS_ERR(lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw)) {
+		lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw =3D NULL;
+		return PTR_ERR(lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw);
+	}
+	return 0;
+}
+
+static int __init lrng_raw_init(void)
+{
+	int ret =3D lrng_raw_debugfs_init();
+
+	if (ret < 0)
+		return ret;
+
+	ret =3D lrng_raw_debugfs_init_name();
+	if (ret < 0)
+		debugfs_remove_recursive(
+					lrng_raw_debugfs.lrng_raw_debugfs_root);
+
+	return ret;
+}
+
+static void __exit lrng_raw_exit(void)
+{
+	debugfs_remove_recursive(lrng_raw_debugfs.lrng_raw_debugfs_root);
+}
+
+module_init(lrng_raw_init);
+module_exit(lrng_raw_exit);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Kernel module for gathering raw entropy");
=2D-=20
2.23.0




