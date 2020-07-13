Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1727321D004
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2020 08:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgGMGt5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jul 2020 02:49:57 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:26964 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMGt5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jul 2020 02:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594622990;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9g9KgOFiuFVGml6Kvyf2e0D526HCIaN8iWyY2gSiVbE=;
        b=NzYEmPzQ9LIaMlRS/K6+sQoL7rESIDG/ElwwAcNcPxSJTK/nJZUn1qp9qJmThfG6uC
        J7I73lzpIGnIpNsNPbxmCg30FXNReqj1H5x0f8MLG6Wxl/0XpBf3LbbIMvqxQyB1qh8Q
        1QM1SE3VZXDrIqwOFpFHltuQa3xhhmrv4+u74obfzY4auPWxcVPClsnL2ZV6wpcSG4Qd
        TeEADwB19EWhyCrgMUWYImV+J8a/ylhzzpY6BDKWzY4zzzm6a4gCY83SExbk1VQ95g5r
        FNo4iXzxOC4Od12aBpscHw5Hub7EYTqTQmv0WI9DXLE02HnpD/VFZTFp7XLWigtLxZAS
        jTRQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSfHReW"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id y0546bw6D6bjk2G
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 13 Jul 2020 08:37:45 +0200 (CEST)
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
Subject: [PATCH v31 11/12] LRNG - add interface for gathering of raw entropy
Date:   Mon, 13 Jul 2020 08:21:52 +0200
Message-ID: <4280492.cEBGB3zze1@positron.chronox.de>
In-Reply-To: <2050754.Mh6RI2rZIc@positron.chronox.de>
References: <2050754.Mh6RI2rZIc@positron.chronox.de>
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

In addition, the test interface allows gathering of the conatenated raw
entropy data to verify that the concatenation works appropriately.

=46inally, the execution duration for processing a time stamp can be
obtained with the LRNG raw entropy interface.

If a test interface is not compiled, its code is a noop which has no
impact on the performance.

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
 drivers/char/lrng/Kconfig        |  59 +++++
 drivers/char/lrng/Makefile       |   1 +
 drivers/char/lrng/lrng_testing.c | 393 +++++++++++++++++++++++++++++++
 3 files changed, 453 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_testing.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 323c657f7005..1e5f28b8face 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -162,4 +162,63 @@ config LRNG_APT_CUTOFF
 	default 325 if !LRNG_APT_BROKEN
 	default 32 if LRNG_APT_BROKEN
=20
+menuconfig LRNG_TESTING_MENU
+	bool "LRNG testing interfaces"
+	depends on DEBUG_FS
+	help
+	  Enable one or more of the following test interfaces.
+
+	  If unsure, say N.
+
+if LRNG_TESTING_MENU
+
+config LRNG_RAW_ENTROPY
+	bool "Enable entropy test interface to LRNG noise source"
+	default y
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
+config LRNG_RAW_ARRAY
+	bool "Enable test interface to LRNG raw entropy storage array"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw noise data that is collected by the LRNG
+	  in the per-CPU array for statistical analysis. The purpose
+	  of this interface is to verify that the array handling code
+	  truly only concatenates data and provides the same entropy
+	  rate as the raw unconditioned noise source when assessing
+	  the collected data byte-wise.
+
+	  The data can be obtained using the lrng_raw_array debugfs
+	  file. Using the option lrng_testing.boot_raw_array=3D1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_IRQ_PERF
+	bool "Enable LRNG interrupt performance monitor"
+	help
+	  With this option, the performance monitor of the LRNG
+	  interrupt handling code is enabled. The file provides
+	  the execution time of the interrupt handler in
+	  cycles.
+
+	  The interrupt performance data can be obtained using
+	  the lrng_irq_perf debugfs file. Using the option
+	  lrng_testing.boot_irq_perf=3D1 the performance data of
+	  the first 1000 entropy events since boot can be sampled.
+
+config LRNG_TESTING
+	bool
+	default y if (LRNG_RAW_ENTROPY || LRNG_RAW_ARRAY || LRNG_IRQ_PERF)
+
+endif #LRNG_TESTING_MENU
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
index 000000000000..45e01a528aa1
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_testing.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Linux Random Number Generator (LRNG) testing interfaces
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
+struct lrng_testing {
+	u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
+	u32 rb_reader;
+	u32 rb_writer;
+	atomic_t lrng_testing_enabled;
+	spinlock_t lock;
+	wait_queue_head_t read_wait;
+};
+
+/*************************** Generic Data Handling ***********************=
*****/
+
+/*
+ * boot variable:
+ * 0 =3D=3D> No boot test, gathering of runtime data allowed
+ * 1 =3D=3D> Boot test enabled and ready for collecting data, gathering ru=
ntime
+ *	 data is disabled
+ * 2 =3D=3D> Boot test completed and disabled, gathering of runtime data is
+ *	 disabled
+ */
+
+static inline void lrng_testing_reset(struct lrng_testing *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	data->rb_reader =3D 0;
+	data->rb_writer =3D 0;
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static inline void lrng_testing_init(struct lrng_testing *data, u32 boot)
+{
+	/*
+	 * The boot time testing implies we have a running test. If the
+	 * caller wants to clear it, he has to unset the boot_test flag
+	 * at runtime via sysfs to enable regular runtime testing
+	 */
+	if (boot)
+		return;
+
+	lrng_testing_reset(data);
+	atomic_set(&data->lrng_testing_enabled, 1);
+	pr_warn("Enabling data collection\n");
+}
+
+static inline void lrng_testing_fini(struct lrng_testing *data)
+{
+	atomic_set(&data->lrng_testing_enabled, 0);
+	lrng_testing_reset(data);
+	pr_warn("Disabling data collection\n");
+}
+
+
+static inline bool lrng_testing_store(struct lrng_testing *data, u32 value,
+				      u32 *boot)
+{
+	unsigned long flags;
+
+	if (!atomic_read(&data->lrng_testing_enabled) && (*boot !=3D 1))
+		return false;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	/*
+	 * Disable entropy testing for boot time testing after ring buffer
+	 * is filled.
+	 */
+	if (*boot) {
+		if (data->rb_writer > LRNG_TESTING_RINGBUFFER_SIZE) {
+			*boot =3D 2;
+			pr_warn_once("One time data collection test disabled\n");
+			spin_unlock_irqrestore(&data->lock, flags);
+			return false;
+		}
+
+		if (data->rb_writer =3D=3D 1)
+			pr_warn("One time data collection test enabled\n");
+	}
+
+	data->lrng_testing_rb[data->rb_writer & LRNG_TESTING_RINGBUFFER_MASK] =3D
+									value;
+	data->rb_writer++;
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	if (wq_has_sleeper(&data->read_wait))
+		wake_up_interruptible(&data->read_wait);
+
+	return true;
+}
+
+static inline bool lrng_testing_have_data(struct lrng_testing *data)
+{
+	return ((data->rb_writer & LRNG_TESTING_RINGBUFFER_MASK) !=3D
+		 (data->rb_reader & LRNG_TESTING_RINGBUFFER_MASK));
+}
+
+static inline int lrng_testing_reader(struct lrng_testing *data, u32 *boot,
+				      u8 *outbuf, u32 outbuflen)
+{
+	unsigned long flags;
+	int collected_data =3D 0;
+
+	lrng_testing_init(data, *boot);
+
+	while (outbuflen) {
+		spin_lock_irqsave(&data->lock, flags);
+
+		/* We have no data or reached the writer. */
+		if (!data->rb_writer ||
+		    (data->rb_writer =3D=3D data->rb_reader)) {
+
+			spin_unlock_irqrestore(&data->lock, flags);
+
+			/*
+			 * Now we gathered all boot data, enable regular data
+			 * collection.
+			 */
+			if (*boot) {
+				*boot =3D 0;
+				goto out;
+			}
+
+			wait_event_interruptible(data->read_wait,
+						 lrng_testing_have_data(data));
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
+			spin_unlock_irqrestore(&data->lock, flags);
+			goto out;
+		}
+
+		memcpy(outbuf, &data->lrng_testing_rb[data->rb_reader],
+		       sizeof(u32));
+		data->rb_reader++;
+
+		spin_unlock_irqrestore(&data->lock, flags);
+
+		outbuf +=3D sizeof(u32);
+		outbuflen -=3D sizeof(u32);
+		collected_data +=3D sizeof(u32);
+	}
+
+out:
+	if (!lrng_testing_have_data(data))
+		lrng_testing_fini(data);
+	return collected_data;
+}
+
+static int lrng_testing_extract_user(struct file *file, char __user *buf,
+				     size_t nbytes, loff_t *ppos,
+				     int (*reader)(u8 *outbuf, u32 outbuflen))
+{
+	loff_t pos =3D *ppos;
+	u8 *tmp, *tmp_aligned;
+	int ret =3D 0, large_request =3D (nbytes > 256);
+
+	if (!nbytes)
+		return 0;
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
+		i =3D reader(tmp_aligned, i);
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
+
+	nbytes -=3D ret;
+	*ppos =3D pos + nbytes;
+
+	return ret;
+}
+
+/************************* Raw Entropy Data Handling *********************=
*****/
+
+#ifdef CONFIG_LRNG_RAW_ENTROPY
+
+static u32 boot_test =3D 0;
+module_param(boot_test, uint, 0644);
+MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the fir=
st entropy events");
+
+static struct lrng_testing lrng_raw =3D {
+	.rb_reader =3D 0,
+	.rb_reader =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw.read_wait)
+};
+
+bool lrng_raw_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw, value, &boot_test);
+}
+
+static int lrng_raw_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw, &boot_test, outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_read(struct file *file, char __user *to,
+			     size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_ENTROPY */
+
+/********************** Raw Entropy Array Data Handling ******************=
*****/
+
+#ifdef CONFIG_LRNG_RAW_ARRAY
+
+static u32 boot_raw_array =3D 0;
+module_param(boot_raw_array, uint, 0644);
+MODULE_PARM_DESC(boot_raw_array, "Enable gathering boot time raw noise arr=
ay data of the first entropy events");
+
+static struct lrng_testing lrng_raw_array =3D {
+	.rb_reader =3D 0,
+	.rb_reader =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw_array.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_array.read_wait)
+};
+
+bool lrng_raw_array_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_array, value, &boot_raw_array);
+}
+
+static int lrng_raw_array_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_array, &boot_raw_array, outbuf,
+				   outbuflen);
+}
+
+static ssize_t lrng_raw_array_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_array_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_array_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_array_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_ARRAY */
+
+/******************** Interrupt Performance Data Handling ****************=
*****/
+
+#ifdef CONFIG_LRNG_IRQ_PERF
+
+static u32 boot_irq_perf =3D 0;
+module_param(boot_irq_perf, uint, 0644);
+MODULE_PARM_DESC(boot_irq_perf, "Enable gathering boot time interrupt perf=
ormance data of the first entropy events");
+
+static struct lrng_testing lrng_irq_perf =3D {
+	.rb_reader =3D 0,
+	.rb_reader =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_irq_perf.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_irq_perf.read_wait)
+};
+
+bool lrng_perf_time(u32 start)
+{
+	return lrng_testing_store(&lrng_irq_perf, random_get_entropy() - start,
+				  &boot_irq_perf);
+}
+
+static int lrng_irq_perf_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_irq_perf, &boot_irq_perf, outbuf,
+				   outbuflen);
+}
+
+static ssize_t lrng_irq_perf_read(struct file *file, char __user *to,
+				  size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_irq_perf_reader);
+}
+
+static const struct file_operations lrng_irq_perf_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_irq_perf_read,
+};
+
+#endif /* CONFIG_LRNG_IRQ_PERF */
+
+/**************************************************************************
+ * Debugfs interface
+ *************************************************************************=
*/
+
+static int __init lrng_raw_init(void)
+{
+	struct dentry *lrng_raw_debugfs_root;
+
+
+	lrng_raw_debugfs_root =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+#ifdef CONFIG_LRNG_RAW_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_raw_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_ARRAY
+	debugfs_create_file_unsafe("lrng_raw_array", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_array_fops);
+#endif
+#ifdef CONFIG_LRNG_IRQ_PERF
+	debugfs_create_file_unsafe("lrng_irq_perf", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_irq_perf_fops);
+#endif
+
+	return 0;
+}
+
+module_init(lrng_raw_init);
=2D-=20
2.26.2




