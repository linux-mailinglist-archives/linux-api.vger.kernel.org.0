Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E067135494
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2020 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgAIIlM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 9 Jan 2020 03:41:12 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:11766 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgAIIlE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 03:41:04 -0500
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w098c22Zb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 9 Jan 2020 09:38:02 +0100 (CET)
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
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v27 11/12] LRNG - add interface for gathering of raw entropy
Date:   Thu, 09 Jan 2020 09:35:01 +0100
Message-ID: <1617334.xIvO9ur7bq@positron.chronox.de>
In-Reply-To: <2641155.iNH938UiKq@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2722222.P16TYeLAVu@positron.chronox.de> <2641155.iNH938UiKq@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
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
buffer. Using the option lrng_testing.boot_test=1 the raw noise of
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
Tested-by: Roman Drahtm�ller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Kconfig        |  16 ++
 drivers/char/lrng/Makefile       |   1 +
 drivers/char/lrng/lrng_testing.c | 271 +++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_testing.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 7b2bb3da066c..394066aa5a86 100644
--- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -159,4 +159,20 @@ config LRNG_APT_CUTOFF
 	default 325 if !LRNG_APT_BROKEN
 	default 32 if LRNG_APT_BROKEN
 
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
+	  debugfs file. Using the option lrng_testing.boot_test=1
+	  the raw noise of the first 1000 entropy events since boot
+	  can be sampled.
+
+	  If unsure, say N.
+
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index c3008763dd14..b2ce1979dc4b 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_LRNG_DRBG)		+= lrng_drbg.o
 obj-$(CONFIG_LRNG_KCAPI)	+= lrng_kcapi.o
 obj-$(CONFIG_LRNG_JENT)		+= lrng_jent.o
 obj-$(CONFIG_LRNG_HEALTH_TESTS)	+= lrng_health.o
+obj-$(CONFIG_LRNG_TESTING)	+= lrng_testing.o
diff --git a/drivers/char/lrng/lrng_testing.c b/drivers/char/lrng/lrng_testing.c
new file mode 100644
index 000000000000..0e287eccd622
--- /dev/null
+++ b/drivers/char/lrng/lrng_testing.c
@@ -0,0 +1,271 @@
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
+static u32 lrng_rb_reader = 0;
+static u32 lrng_rb_writer = 0;
+static atomic_t lrng_testing_enabled = ATOMIC_INIT(0);
+
+static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
+static DEFINE_SPINLOCK(lrng_raw_lock);
+
+/*
+ * 0 ==> No boot test, gathering of runtime data allowed
+ * 1 ==> Boot test enabled and ready for collecting data, gathering runtime
+ *	 data is disabled
+ * 2 ==> Boot test completed and disabled, gathering of runtime data is
+ *	 disabled
+ */
+static u32 boot_test = 0;
+module_param(boot_test, uint, 0644);
+MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the first"
+			    " entropy events");
+
+static inline void lrng_raw_entropy_reset(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lrng_raw_lock, flags);
+	lrng_rb_reader = 0;
+	lrng_rb_writer = 0;
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
+	if (!atomic_read(&lrng_testing_enabled) && (boot_test != 1))
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
+			boot_test = 2;
+			pr_warn_once("Boot time entropy collection test "
+				     "disabled\n");
+			spin_unlock_irqrestore(&lrng_raw_lock, flags);
+			return false;
+		}
+
+		if (lrng_rb_writer == 1)
+			pr_warn("Boot time entropy collection test enabled\n");
+	}
+
+	lrng_testing_rb[lrng_rb_writer & LRNG_TESTING_RINGBUFFER_MASK] = value;
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
+	return ((lrng_rb_writer & LRNG_TESTING_RINGBUFFER_MASK) !=
+		 (lrng_rb_reader & LRNG_TESTING_RINGBUFFER_MASK));
+}
+
+static int lrng_raw_entropy_reader(u8 *outbuf, u32 outbuflen)
+{
+	unsigned long flags;
+	int collected_data = 0;
+
+	lrng_raw_entropy_init();
+
+	while (outbuflen) {
+		spin_lock_irqsave(&lrng_raw_lock, flags);
+
+		/* We have no data or reached the writer. */
+		if (!lrng_rb_writer || (lrng_rb_writer == lrng_rb_reader)) {
+
+			spin_unlock_irqrestore(&lrng_raw_lock, flags);
+
+			/*
+			 * Now we gathered all boot data, enable regular data
+			 * collection.
+			 */
+			if (boot_test) {
+				boot_test = 0;
+				goto out;
+			}
+
+			wait_event_interruptible(lrng_raw_read_wait,
+						 lrng_raw_have_data());
+			if (signal_pending(current)) {
+				collected_data = -ERESTARTSYS;
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
+		outbuf += sizeof(u32);
+		outbuflen -= sizeof(u32);
+		collected_data += sizeof(u32);
+	}
+
+out:
+	lrng_raw_entropy_fini();
+	return collected_data;
+}
+
+/**************************************************************************
+ * Debugfs interface
+ **************************************************************************/
+static int lrng_raw_extract_user(char __user *buf, size_t nbytes)
+{
+	u8 *tmp, *tmp_aligned;
+	int ret = 0, large_request = (nbytes > 256);
+
+	/*
+	 * The intention of this interface is for collecting at least
+	 * 1000 samples due to the SP800-90B requirements. So, we make no
+	 * effort in avoiding allocating more memory that actually needed
+	 * by the user. Hence, we allocate sufficient memory to always hold
+	 * that amount of data.
+	 */
+	tmp = kmalloc(LRNG_TESTING_RINGBUFFER_SIZE + sizeof(u32), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp_aligned = PTR_ALIGN(tmp, sizeof(u32));
+
+	while (nbytes) {
+		int i;
+
+		if (large_request && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		i = min_t(int, nbytes, LRNG_TESTING_RINGBUFFER_SIZE);
+		i = lrng_raw_entropy_reader(tmp_aligned, i);
+		if (i <= 0) {
+			if (i < 0)
+				ret = i;
+			break;
+		}
+		if (copy_to_user(buf, tmp_aligned, i)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		nbytes -= i;
+		buf += i;
+		ret += i;
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
+	loff_t pos = *ppos;
+	int ret;
+
+	if (!count)
+		return 0;
+
+	ret = lrng_raw_extract_user(to, count);
+	if (ret < 0)
+		return ret;
+
+	count -= ret;
+	*ppos = pos + count;
+
+	return ret;
+}
+
+static const struct file_operations lrng_raw_name_fops = {
+	.owner = THIS_MODULE,
+	.read = lrng_raw_read,
+};
+
+static int __init lrng_raw_init(void)
+{
+	struct dentry *lrng_raw_debugfs_root;
+
+	lrng_raw_debugfs_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	debugfs_create_file_unsafe("lrng_raw", 0400, lrng_raw_debugfs_root,
+				   NULL, &lrng_raw_name_fops);
+
+	return 0;
+}
+
+module_init(lrng_raw_init);
-- 
2.24.1




