Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A6135496
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2020 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgAIIlQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 9 Jan 2020 03:41:16 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.124]:14809 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgAIIlL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 03:41:11 -0500
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w098cC2Zp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 9 Jan 2020 09:38:12 +0100 (CET)
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
Subject: [PATCH v27 03/12] LRNG - sysctls and /proc interface
Date:   Thu, 09 Jan 2020 09:31:39 +0100
Message-ID: <2649838.LjHEXeKtmW@positron.chronox.de>
In-Reply-To: <2641155.iNH938UiKq@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2722222.P16TYeLAVu@positron.chronox.de> <2641155.iNH938UiKq@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The LRNG sysctl interface provides the same controls as the existing
/dev/random implementation. These sysctls behave identically and are
implemented identically. The goal is to allow a possible merge of the
existing /dev/random implementation with this implementation which
implies that this patch tries have a very close similarity. Yet, all
sysctls are documented at [1].

In addition, it provides the file lrng_type which provides details about
the LRNG:

- the name of the DRNG that produces the random numbers for /dev/random,
/dev/urandom, getrandom(2)

- the hash used to produce random numbers from the entropy pool

- the number of secondary DRNG instances

- indicator whether the LRNG operates SP800-90B compliant

- indicator whether a high-resolution timer is identified - only with a
high-resolution timer the interrupt noise source will deliver sufficient
entropy

- indicator whether the LRNG has been minimally seeded (i.e. is the
secondary DRNG seeded with at least 128 bits of of entropy)

- indicator whether the LRNG has been fully seeded (i.e. is the
secondary DRNG seeded with at least 256 bits of entropy)

[1] https://www.chronox.de/lrng.html

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
Tested-by: Roman Drahtm�ller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Makefile          |   1 +
 drivers/char/lrng/lrng_interfaces.c |   1 -
 drivers/char/lrng/lrng_internal.h   |   4 +
 drivers/char/lrng/lrng_proc.c       | 163 ++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/lrng/lrng_proc.c

diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 0a32f22c2c1a..e69c176f0161 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -9,3 +9,4 @@ obj-y				+= lrng_pool.o lrng_aux.o \
 				   lrng_interfaces.o \
 
 obj-$(CONFIG_NUMA)		+= lrng_numa.o
+obj-$(CONFIG_SYSCTL)		+= lrng_proc.o
diff --git a/drivers/char/lrng/lrng_interfaces.c b/drivers/char/lrng/lrng_interfaces.c
index ff40ed37ddd6..8c4bf53d86ec 100644
--- a/drivers/char/lrng/lrng_interfaces.c
+++ b/drivers/char/lrng/lrng_interfaces.c
@@ -34,7 +34,6 @@ static DECLARE_WAIT_QUEUE_HEAD(lrng_write_wait);
 static DECLARE_WAIT_QUEUE_HEAD(lrng_init_wait);
 static struct fasync_struct *fasync;
 
-struct ctl_table random_table[];
 /********************************** Helper ***********************************/
 
 /* Is the DRNG seed level too low? */
diff --git a/drivers/char/lrng/lrng_internal.h b/drivers/char/lrng/lrng_internal.h
index c2b0a467548e..349152d3c1b0 100644
--- a/drivers/char/lrng/lrng_internal.h
+++ b/drivers/char/lrng/lrng_internal.h
@@ -116,7 +116,11 @@ void lrng_cc20_init_state(struct chacha20_state *state);
 
 /********************************** /proc *************************************/
 
+#ifdef CONFIG_SYSCTL
+void lrng_pool_inc_numa_node(void);
+#else
 static inline void lrng_pool_inc_numa_node(void) { }
+#endif
 
 /****************************** LRNG interfaces *******************************/
 
diff --git a/drivers/char/lrng/lrng_proc.c b/drivers/char/lrng/lrng_proc.c
new file mode 100644
index 000000000000..f4ee01f61925
--- /dev/null
+++ b/drivers/char/lrng/lrng_proc.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG proc and sysctl interfaces
+ *
+ * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+#include <linux/lrng.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/sysctl.h>
+#include <linux/uuid.h>
+
+#include "lrng_internal.h"
+
+/*
+ * This function is used to return both the bootid UUID, and random
+ * UUID.  The difference is in whether table->data is NULL; if it is,
+ * then a new UUID is generated and returned to the user.
+ *
+ * If the user accesses this via the proc interface, the UUID will be
+ * returned as an ASCII string in the standard UUID format; if via the
+ * sysctl system call, as 16 bytes of binary data.
+ */
+static int lrng_proc_do_uuid(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table fake_table;
+	unsigned char buf[64], tmp_uuid[16], *uuid;
+
+	uuid = table->data;
+	if (!uuid) {
+		uuid = tmp_uuid;
+		generate_random_uuid(uuid);
+	} else {
+		static DEFINE_SPINLOCK(bootid_spinlock);
+
+		spin_lock(&bootid_spinlock);
+		if (!uuid[8])
+			generate_random_uuid(uuid);
+		spin_unlock(&bootid_spinlock);
+	}
+
+	sprintf(buf, "%pU", uuid);
+
+	fake_table.data = buf;
+	fake_table.maxlen = sizeof(buf);
+
+	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_proc_do_entropy(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table fake_table;
+	int entropy_count;
+
+	entropy_count = lrng_avail_entropy();
+
+	fake_table.data = &entropy_count;
+	fake_table.maxlen = sizeof(entropy_count);
+
+	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_sysctl_poolsize = LRNG_POOL_SIZE_BITS;
+static int lrng_min_write_thresh;
+static int lrng_max_write_thresh = LRNG_POOL_SIZE_BITS;
+static char lrng_sysctl_bootid[16];
+static int lrng_drng_reseed_max_min;
+
+struct ctl_table random_table[] = {
+	{
+		.procname	= "poolsize",
+		.data		= &lrng_sysctl_poolsize,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "entropy_avail",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_entropy,
+	},
+	{
+		.procname	= "write_wakeup_threshold",
+		.data		= &lrng_write_wakeup_bits,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &lrng_min_write_thresh,
+		.extra2		= &lrng_max_write_thresh,
+	},
+	{
+		.procname	= "boot_id",
+		.data		= &lrng_sysctl_bootid,
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_uuid,
+	},
+	{
+		.procname	= "uuid",
+		.maxlen		= 16,
+		.mode		= 0444,
+		.proc_handler	= lrng_proc_do_uuid,
+	},
+	{
+		.procname       = "urandom_min_reseed_secs",
+		.data           = &lrng_drng_reseed_max_time,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+		.extra1		= &lrng_drng_reseed_max_min,
+	},
+	{ }
+};
+
+/* Number of online DRNGs */
+static u32 numa_drngs = 1;
+
+void lrng_pool_inc_numa_node(void)
+{
+	numa_drngs++;
+}
+
+static int lrng_proc_type_show(struct seq_file *m, void *v)
+{
+	struct lrng_drng *lrng_drng_init = lrng_drng_init_instance();
+	unsigned long flags = 0;
+	unsigned char buf[300];
+
+	lrng_drng_lock(lrng_drng_init, &flags);
+	snprintf(buf, sizeof(buf),
+		 "DRNG name: %s\n"
+		 "Hash for reading entropy pool: %s\n"
+		 "DRNG security strength: %d bits\n"
+		 "number of DRNG instances: %u\n"
+		 "SP800-90B compliance: %s\n"
+		 "High-resolution timer: %s\n"
+		 "LRNG minimally seeded: %s\n"
+		 "LRNG fully seeded: %s\n",
+		 lrng_drng_init->crypto_cb->lrng_drng_name(),
+		 lrng_drng_init->crypto_cb->lrng_hash_name(),
+		 LRNG_DRNG_SECURITY_STRENGTH_BITS, numa_drngs,
+		 lrng_sp80090b_compliant() ? "true" : "false",
+		 lrng_pool_highres_timer() ? "true" : "false",
+		 lrng_state_min_seeded() ? "true" : "false",
+		 lrng_state_fully_seeded() ? "true" : "false");
+	lrng_drng_unlock(lrng_drng_init, &flags);
+
+	seq_write(m, buf, strlen(buf));
+
+	return 0;
+}
+
+static int __init lrng_proc_type_init(void)
+{
+	proc_create_single("lrng_type", 0444, NULL, &lrng_proc_type_show);
+	return 0;
+}
+
+module_init(lrng_proc_type_init);
-- 
2.24.1




