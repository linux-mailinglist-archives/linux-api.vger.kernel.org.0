Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70D2251359
	for <lists+linux-api@lfdr.de>; Tue, 25 Aug 2020 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgHYHh2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Aug 2020 03:37:28 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:31611 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbgHYHgk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Aug 2020 03:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598340989;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FYu5a3JVKBrW0d7vOFMF/Rum0tD/1I27jlLUkkusT1I=;
        b=SkMUTDJ2NyhNJ2+HRogT37sdafRToMD1CJMkC9J+Q7XviiGPmYQmLy8B1U9rPHmd3H
        ApRHecd58SPLm26ZGN8afh8d2q38qZFR5BowARNvXJ1iwY71CqYrUkL3t4e+g2MLtAAu
        koWhlWsFUi20M/K8tfxT1E9LVZx2tcy8wITG/NNjbyCQmfBnXNHjwi2PN9WBLFAbSQKH
        PeUddGclO7xKuviQoBysnzJVUmdG0INptanW+TYKoPf4qEPOBuop6QKNCHZOtUzXYlZT
        rsKPJZXukEeCdCukLHbz5xnT4o0AAFdEd/uZavsbojm2alpjZNW7hUQ+wed4a3kbx8+z
        +ZQg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaIvSXRbo="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7P7ZCZGI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 25 Aug 2020 09:35:12 +0200 (CEST)
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
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: [PATCH v34 11/12] LRNG - add interface for gathering of raw entropy
Date:   Tue, 25 Aug 2020 09:27:32 +0200
Message-ID: <3066201.5fSG56mABF@positron.chronox.de>
In-Reply-To: <11649613.O9o76ZdvQC@positron.chronox.de>
References: <2544450.mvXUDI8C0e@positron.chronox.de> <5532247.MhkbZ0Pkbq@positron.chronox.de> <11649613.O9o76ZdvQC@positron.chronox.de>
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
This includes sampling of the following raw data:

* high-resolution time stamp

* Jiffies

* IRQ number

* IRQ flags

* return instruction pointer

* array logic batching the high-resolution time stamp

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
 drivers/char/lrng/Kconfig        | 124 +++++++
 drivers/char/lrng/Makefile       |   1 +
 drivers/char/lrng/lrng_testing.c | 575 +++++++++++++++++++++++++++++++
 3 files changed, 700 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_testing.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 452ee4adb577..de20f189e297 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -164,4 +164,128 @@ config LRNG_APT_CUTOFF
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
+config LRNG_RAW_HIRES_ENTROPY
+	bool "Enable entropy test interface to hires timer noise source"
+	default y
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned high resolution time stamp noise that
+	  is collected by the LRNG for statistical analysis. Extracted
+	  noise data is not used to seed the LRNG.
+
+	  The raw noise data can be obtained using the lrng_raw_hires
+	  debugfs file. Using the option lrng_testing.boot_raw_hires_test=3D1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_JIFFIES_ENTROPY
+	bool "Enable entropy test interface to Jiffies noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned Jiffies that is collected by
+	  the LRNG for statistical analysis. This data is used for
+	  seeding the LRNG if a high-resolution time stamp is not
+	  available. If a high-resolution time stamp is detected,
+	  the Jiffies value is not collected by the LRNG and no
+	  data is provided via the test interface. Extracted noise
+	  data is not used to seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_jiffies
+	  debugfs file. Using the option lrng_testing.boot_raw_jiffies_test=3D1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_IRQ_ENTROPY
+	bool "Enable entropy test interface to IRQ number noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned interrupt number that is collected by
+	  the LRNG for statistical analysis. This data is used for
+	  seeding the random32 PRNG external to the LRNG if a
+	  high-resolution time stamp is available or it will be used to
+	  seed the LRNG otherwise. Extracted noise data is not used to
+	  seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_irq
+	  debugfs file. Using the option lrng_testing.boot_raw_irq_test=3D1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_IRQFLAGS_ENTROPY
+	bool "Enable entropy test interface to IRQ flags noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned interrupt flags that is collected by
+	  the LRNG for statistical analysis. This data is used for
+	  seeding the random32 PRNG external to the LRNG if a
+	  high-resolution time stamp is available or it will be used to
+	  seed the LRNG otherwise. Extracted noise data is not used to
+	  seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_irqflags
+	  debugfs file. Using the option lrng_testing.boot_raw_irqflags_test=3D1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+config LRNG_RAW_RETIP_ENTROPY
+	bool "Enable entropy test interface to RETIP value noise source"
+	help
+	  The test interface allows a privileged process to capture
+	  the raw unconditioned return instruction pointer value
+	  that is collected by the LRNG for statistical analysis.
+	  This data is used for seeding the random32 PRNG external
+	  to the LRNG if a high-resolution time stamp is available or
+	  it will be used to seed the LRNG otherwise. Extracted noise
+	  data is not used to seed the random number generator.
+
+	  The raw noise data can be obtained using the lrng_raw_retip
+	  debugfs file. Using the option lrng_testing.boot_raw_retip_test=3D1
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
+	default y if (LRNG_RAW_HIRES_ENTROPY || LRNG_RAW_JIFFIES_ENTROPY ||LRNG_R=
AW_IRQ_ENTROPY || LRNG_RAW_IRQFLAGS_ENTROPY || LRNG_RAW_RETIP_ENTROPY || LR=
NG_RAW_ARRAY || LRNG_IRQ_PERF)
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
index 000000000000..a6e2c2b56fe2
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_testing.c
@@ -0,0 +1,575 @@
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
+/************** Raw High-Resolution Timer Entropy Data Handling **********=
*****/
+
+#ifdef CONFIG_LRNG_RAW_HIRES_ENTROPY
+
+static u32 boot_raw_hires_test =3D 0;
+module_param(boot_raw_hires_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_hires_test, "Enable gathering boot time high res=
olution timer entropy of the first entropy events");
+
+static struct lrng_testing lrng_raw_hires =3D {
+	.rb_reader =3D 0,
+	.rb_writer =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw_hires.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_hires.read_wait)
+};
+
+bool lrng_raw_hires_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_hires, value, &boot_raw_hires_test);
+}
+
+static int lrng_raw_hires_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_hires, &boot_raw_hires_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_hires_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_hires_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_hires_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_hires_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_HIRES_ENTROPY */
+
+/********************* Raw Jiffies Entropy Data Handling *****************=
*****/
+
+#ifdef CONFIG_LRNG_RAW_JIFFIES_ENTROPY
+
+static u32 boot_raw_jiffies_test =3D 0;
+module_param(boot_raw_jiffies_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_jiffies_test, "Enable gathering boot time high r=
esolution timer entropy of the first entropy events");
+
+static struct lrng_testing lrng_raw_jiffies =3D {
+	.rb_reader =3D 0,
+	.rb_writer =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw_jiffies.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_jiffies.read_wait)
+};
+
+bool lrng_raw_jiffies_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_jiffies, value,
+				  &boot_raw_jiffies_test);
+}
+
+static int lrng_raw_jiffies_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_jiffies, &boot_raw_jiffies_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_jiffies_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_jiffies_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_jiffies_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_jiffies_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_JIFFIES_ENTROPY */
+
+/************************** Raw IRQ Data Handling ************************=
****/
+
+#ifdef CONFIG_LRNG_RAW_IRQ_ENTROPY
+
+static u32 boot_raw_irq_test =3D 0;
+module_param(boot_raw_irq_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_irq_test, "Enable gathering boot time entropy of=
 the first IRQ entropy events");
+
+static struct lrng_testing lrng_raw_irq =3D {
+	.rb_reader =3D 0,
+	.rb_writer =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw_irq.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_irq.read_wait)
+};
+
+bool lrng_raw_irq_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_irq, value, &boot_raw_irq_test);
+}
+
+static int lrng_raw_irq_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_irq, &boot_raw_irq_test, outbuf,
+				   outbuflen);
+}
+
+static ssize_t lrng_raw_irq_read(struct file *file, char __user *to,
+				 size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_irq_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_irq_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_irq_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_IRQ_ENTROPY */
+
+/************************ Raw IRQFLAGS Data Handling *********************=
*****/
+
+#ifdef CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
+
+static u32 boot_raw_irqflags_test =3D 0;
+module_param(boot_raw_irqflags_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_irqflags_test, "Enable gathering boot time entro=
py of the first IRQ flags entropy events");
+
+static struct lrng_testing lrng_raw_irqflags =3D {
+	.rb_reader =3D 0,
+	.rb_writer =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw_irqflags.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_irqflags.read_wait)
+};
+
+bool lrng_raw_irqflags_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_irqflags, value,
+				  &boot_raw_irqflags_test);
+}
+
+static int lrng_raw_irqflags_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_irqflags, &boot_raw_irqflags_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_irqflags_read(struct file *file, char __user *to,
+				      size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_irqflags_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_irqflags_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_irqflags_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY */
+
+/************************ Raw _RET_IP_ Data Handling *********************=
*****/
+
+#ifdef CONFIG_LRNG_RAW_RETIP_ENTROPY
+
+static u32 boot_raw_retip_test =3D 0;
+module_param(boot_raw_retip_test, uint, 0644);
+MODULE_PARM_DESC(boot_raw_retip_test, "Enable gathering boot time entropy =
of the first return instruction pointer entropy events");
+
+static struct lrng_testing lrng_raw_retip =3D {
+	.rb_reader =3D 0,
+	.rb_writer =3D 0,
+	.lock      =3D __SPIN_LOCK_UNLOCKED(lrng_raw_retip.lock),
+	.read_wait =3D __WAIT_QUEUE_HEAD_INITIALIZER(lrng_raw_retip.read_wait)
+};
+
+bool lrng_raw_retip_entropy_store(u32 value)
+{
+	return lrng_testing_store(&lrng_raw_retip, value, &boot_raw_retip_test);
+}
+
+static int lrng_raw_retip_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_testing_reader(&lrng_raw_retip, &boot_raw_retip_test,
+				   outbuf, outbuflen);
+}
+
+static ssize_t lrng_raw_retip_read(struct file *file, char __user *to,
+				   size_t count, loff_t *ppos)
+{
+	return lrng_testing_extract_user(file, to, count, ppos,
+					 lrng_raw_retip_entropy_reader);
+}
+
+static const struct file_operations lrng_raw_retip_fops =3D {
+	.owner =3D THIS_MODULE,
+	.read =3D lrng_raw_retip_read,
+};
+
+#endif /* CONFIG_LRNG_RAW_RETIP_ENTROPY */
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
+	.rb_writer =3D 0,
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
+	.rb_writer =3D 0,
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
+	lrng_raw_debugfs_root =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+#ifdef CONFIG_LRNG_RAW_HIRES_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_hires", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_hires_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_JIFFIES_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_jiffies", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_jiffies_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_IRQ_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_irq", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_raw_irq_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_irqflags", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_irqflags_fops);
+#endif
+#ifdef CONFIG_LRNG_RAW_RETIP_ENTROPY
+	debugfs_create_file_unsafe("lrng_raw_retip", 0400,
+				   lrng_raw_debugfs_root, NULL,
+				   &lrng_raw_retip_fops);
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




