Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8CCF7FD4
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 20:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKKTZL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 14:25:11 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:18992 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKTZL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 14:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573500308;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=b6K3Qi9i9szuf158TCmFldp39MUucqCHBsfUZJGN5eY=;
        b=TrFxK6odiCQiiOiLLeQ34xXHg9N4T4qp58Mj7gskrXGd0C1zQL8ptB6exS1e3BErbo
        y7495N0ghQJ8X9S1CEJTVTANjm0B6un7/QPWd3ejojxruhApdZxjbqt5qS7ue38OPRxF
        j8ZAVtLtdE21JSpuRywmiosWscEkjeYj0xq+zKgCR0U8fLL9iDSz5GMN0GtrAFQO0It5
        xIIuHV0GmUeOUjFV0riEeSqUh1DMP53SrvFtRum5Qocg9aJlEt0nHuM7VrIqCPgh20kJ
        0mC8821kuvgdCQT/WAT2Mtbp4fGnKAYqLtBzYA2CQp2bcH8M4h8+I+uB4XvPsstDFPFG
        5DSg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmgLKehaO2hZDSTWbgzIOA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vABJD63XY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Nov 2019 20:13:06 +0100 (CET)
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
Subject: [PATCH v24 03/12] LRNG - /proc interface
Date:   Mon, 11 Nov 2019 19:20:03 +0100
Message-ID: <14363064.2qCCxvpLPG@positron.chronox.de>
In-Reply-To: <6157374.ptSnyUpaCn@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The LRNG /proc interface provides the same files as the legacy
/dev/random. These files behave identically. Yet, all files are
documented at [1].

In addition, it provides the file lrng_type which provides details about
the LRNG:

=2D is the TRNG present

=2D the name of the DRNG that produces the random numbers for /dev/random,
/dev/urandom, getrandom(2)

=2D the hash used to produce random numbers from the entropy pool

=2D the number of secondary DRNG instances

=2D indicator whether the LRNG operates SP800-90B compliant

=2D indicator whether a high-resolution timer is identified - only with a
high-resolution timer the interrupt noise source will deliver sufficient
entropy

=2D indicator whether the LRNG has been minimally seeded (i.e. is the
secondary DRNG seeded with at least 128 bits of of entropy)

=2D indicator whether the LRNG has been fully seeded (i.e. is the
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
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Makefile          |   1 +
 drivers/char/lrng/lrng_interfaces.c |   1 -
 drivers/char/lrng/lrng_internal.h   |   4 +
 drivers/char/lrng/lrng_proc.c       | 192 ++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/lrng/lrng_proc.c

diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index a00cddb45773..b6240b73e33d 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -9,3 +9,4 @@ obj-y				+=3D lrng_pool.o lrng_aux.o \
 				   lrng_interfaces.o \
=20
 obj-$(CONFIG_NUMA)		+=3D lrng_numa.o
+obj-$(CONFIG_SYSCTL)		+=3D lrng_proc.o
diff --git a/drivers/char/lrng/lrng_interfaces.c b/drivers/char/lrng/lrng_i=
nterfaces.c
index e652849a1bdb..1c9517c6df4a 100644
=2D-- a/drivers/char/lrng/lrng_interfaces.c
+++ b/drivers/char/lrng/lrng_interfaces.c
@@ -56,7 +56,6 @@ static DECLARE_WAIT_QUEUE_HEAD(lrng_write_wait);
 static DECLARE_WAIT_QUEUE_HEAD(lrng_init_wait);
 static struct fasync_struct *fasync;
=20
=2Dstruct ctl_table random_table[];
 /********************************** Helper *******************************=
****/
=20
 /* Is the primary DRNG seed level too low? */
diff --git a/drivers/char/lrng/lrng_internal.h b/drivers/char/lrng/lrng_int=
ernal.h
index e6ac2c527378..8528c2e8de88 100644
=2D-- a/drivers/char/lrng/lrng_internal.h
+++ b/drivers/char/lrng/lrng_internal.h
@@ -116,7 +116,11 @@ void lrng_cc20_init_state(struct chacha20_state *state=
);
=20
 /********************************** /proc ********************************=
*****/
=20
+#ifdef CONFIG_SYSCTL
+void lrng_pool_inc_numa_node(void);
+#else
 static inline void lrng_pool_inc_numa_node(void) { }
+#endif
=20
 /****************************** LRNG interfaces **************************=
*****/
=20
diff --git a/drivers/char/lrng/lrng_proc.c b/drivers/char/lrng/lrng_proc.c
new file mode 100644
index 000000000000..0e67dd4e5901
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_proc.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG proc interfaces
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#include <linux/lrng.h>
+#include <linux/sysctl.h>
+#include <linux/uuid.h>
+
+#include "lrng_internal.h"
+
+/* Number of online DRNGs */
+static u32 numa_drngs =3D 1;
+
+void lrng_pool_inc_numa_node(void)
+{
+	numa_drngs++;
+}
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
+	uuid =3D table->data;
+	if (!uuid) {
+		uuid =3D tmp_uuid;
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
+	fake_table.data =3D buf;
+	fake_table.maxlen =3D sizeof(buf);
+
+	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_proc_do_type(struct ctl_table *table, int write,
+			     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct lrng_sdrng *lrng_sdrng_init =3D lrng_sdrng_init_instance();
+	struct ctl_table fake_table;
+	unsigned long flags =3D 0;
+	unsigned char buf[300];
+
+	lrng_sdrng_lock(lrng_sdrng_init, &flags);
+	snprintf(buf, sizeof(buf),
+#ifdef CONFIG_LRNG_TRNG_SUPPORT
+		 "TRNG present: true\n"
+#else
+		 "TRNG present: false\n"
+#endif
+		 "DRNG name: %s\n"
+		 "Hash for reading entropy pool: %s\n"
+		 "DRNG security strength: %d bits\n"
+		 "number of secondary DRNG instances: %u\n"
+		 "SP800-90B compliance: %s\n"
+		 "High-resolution timer: %s\n"
+		 "LRNG minimally seeded: %s\n"
+		 "LRNG fully seeded: %s",
+		 lrng_sdrng_init->crypto_cb->lrng_drng_name(),
+		 lrng_sdrng_init->crypto_cb->lrng_hash_name(),
+		 LRNG_DRNG_SECURITY_STRENGTH_BITS, numa_drngs,
+		 lrng_sp80090b_compliant() ? "true" : "false",
+		 lrng_pool_highres_timer() ? "true" : "false",
+		 lrng_state_min_seeded() ? "true" : "false",
+		 lrng_state_fully_seeded() ? "true" : "false");
+	lrng_sdrng_unlock(lrng_sdrng_init, &flags);
+
+	fake_table.data =3D buf;
+	fake_table.maxlen =3D sizeof(buf);
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
+	entropy_count =3D lrng_avail_entropy();
+
+	fake_table.data =3D &entropy_count;
+	fake_table.maxlen =3D sizeof(entropy_count);
+
+	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+}
+
+static int lrng_sysctl_poolsize =3D LRNG_POOL_SIZE_BITS;
+static int lrng_min_read_thresh =3D LRNG_POOL_WORD_BITS;
+static int lrng_min_write_thresh;
+static int lrng_max_read_thresh =3D LRNG_POOL_SIZE_BITS;
+static int lrng_max_write_thresh =3D LRNG_POOL_SIZE_BITS;
+static char lrng_sysctl_bootid[16];
+static int lrng_sdrng_reseed_max_min;
+
+extern struct ctl_table random_table[];
+struct ctl_table random_table[] =3D {
+	{
+		.procname	=3D "poolsize",
+		.data		=3D &lrng_sysctl_poolsize,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0444,
+		.proc_handler	=3D proc_dointvec,
+	},
+	{
+		.procname	=3D "entropy_avail",
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0444,
+		.proc_handler	=3D lrng_proc_do_entropy,
+	},
+	{
+		.procname	=3D "read_wakeup_threshold",
+		.data		=3D &lrng_read_wakeup_bits,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D &lrng_min_read_thresh,
+		.extra2		=3D &lrng_max_read_thresh,
+	},
+	{
+		.procname	=3D "write_wakeup_threshold",
+		.data		=3D &lrng_write_wakeup_bits,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D &lrng_min_write_thresh,
+		.extra2		=3D &lrng_max_write_thresh,
+	},
+	{
+		.procname	=3D "boot_id",
+		.data		=3D &lrng_sysctl_bootid,
+		.maxlen		=3D 16,
+		.mode		=3D 0444,
+		.proc_handler	=3D lrng_proc_do_uuid,
+	},
+	{
+		.procname	=3D "uuid",
+		.maxlen		=3D 16,
+		.mode		=3D 0444,
+		.proc_handler	=3D lrng_proc_do_uuid,
+	},
+	{
+		.procname       =3D "urandom_min_reseed_secs",
+		.data           =3D &lrng_sdrng_reseed_max_time,
+		.maxlen         =3D sizeof(int),
+		.mode           =3D 0644,
+		.proc_handler   =3D proc_dointvec,
+		.extra1		=3D &lrng_sdrng_reseed_max_min,
+	},
+	{
+		.procname	=3D "lrng_type",
+		.maxlen		=3D 30,
+		.mode		=3D 0444,
+		.proc_handler	=3D lrng_proc_do_type,
+	},
+	{ }
+};
=2D-=20
2.23.0




