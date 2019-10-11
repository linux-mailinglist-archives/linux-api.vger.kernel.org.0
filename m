Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACDD3721
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfJKBZQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51415 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfJKBYV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so8709858wme.1
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mW0XLtDdNZDYfFY1aesitxdJBDMPczhpUzcCYZwJd8M=;
        b=CHUyM43Z6EROQ4WBQs4x8vgFTX9krOl6EKhUlSfoaHKyyAOdbOkjraaMDsjfmLngAs
         4SY2HvfRxfIIGAGCsvb+Km2IQ4VqAitGvRIZxaO5/2FT6h3wxDPS60KDJ8MjQ3Sd6Yfd
         EkUz40L3NpnMxNy7tbMPShpGVhaBUz1njpntZEe7V7ryTDhsXXxsgdzB+fl6KHDd9rU7
         vSGC6hPpaABK114utBaF34Z3rEWqT7q5G4tiXakKcJOh9llnmhy2EIB4d7xo5WSXaFek
         l8eRE6u01SxmNPjgdaXCnzR+86HtZ50c26Xt2tLIkxmnbeUT2IG5jm/oKgHrV6gd/W4e
         +G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mW0XLtDdNZDYfFY1aesitxdJBDMPczhpUzcCYZwJd8M=;
        b=GXui41HxeT+pkVrFsRs3V9z/t0qlW4Zf31wIPKpUA3bYYi3z/4kHg7GCW0UVukqbFs
         wz+YATNyb/iTVDHnlJcqHrhJwAMTPnfcHDi/azijdeLYAm9y901dzRuMyoSQf5xjwam2
         rvX+MI00VuxnPFnmseoS3OBfZR3ebRAFlbMMFrl5DkQhi6c58lMT6W/1rIpPbaepz9sU
         O0IpPX1ixQ3+g3zSqIFPcygRpRzrELuSqVeRyywgpW5JiprhsA+bvZXG16t1EpcRvVj3
         V3o2K75PjWPnX201CDwDwgfAXelNwH3ULtEkV/tPhE/lqd1+W4kAJpP5dFvCsGKTH4QG
         fuTg==
X-Gm-Message-State: APjAAAX5qNMnYio4cgU3sluhHzHG9Enq6MStQeSIfkwT9OQAbqBGthek
        B2k2aPolZsoBDbov1f1GNLUBOw==
X-Google-Smtp-Source: APXvYqwhflsGehyS7l7PY/PAkkMnUbW985XMEKJuBRNE39FqrG5e5fGzOBfXA8RjYK7zk/5M6a8W+Q==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr934132wmd.172.1570757058983;
        Thu, 10 Oct 2019 18:24:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:18 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv7 22/33] time: Allocate per-timens vvar page
Date:   Fri, 11 Oct 2019 02:23:30 +0100
Message-Id: <20191011012341.846266-23-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

VDSO support for Time namespace needs to set up a page with the same
layout as VVAR. That timens page will be placed on position of VVAR page
inside namespace. That page contains time namespace clock offsets and it
has vdso_data->seq set to 1 to enforce the slow path and
vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time namespace
handling path.

Allocate the timens page during namespace creation. Setup the offsets
when the first task enters the ns and freeze them to guarantee the pace
of monotonic/boottime clocks and to avoid breakage of applications.

The design decision is to have a global offset_lock which is used
during namespace offsets set up and to freeze offsets when first task
joins the new ns. That is better in terms of memory usage comparing
to having per-ns mutex that's used only during the set up period.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Based-on-work-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h |   3 +
 kernel/time/namespace.c        | 103 ++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 772911945944..c479cfda2c3e 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -23,6 +23,9 @@ struct time_namespace {
 	struct ucounts *ucounts;
 	struct ns_common ns;
 	struct timens_offsets offsets;
+	struct page *vvar_page;
+	/* Disallow changing offsets after any task joined namespace. */
+	bool frozen_offsets;
 } __randomize_layout;
 extern struct time_namespace init_time_ns;
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 1a0fbaa5d2d4..e14cd1ca387d 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -15,6 +15,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <vdso/datapage.h>
 
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *ns_offsets)
@@ -90,16 +91,23 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 
 	kref_init(&ns->kref);
 
+	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!ns->vvar_page)
+		goto fail_free;
+
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto fail_free;
+		goto fail_free_page;
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	ns->offsets = old_ns->offsets;
+	ns->frozen_offsets = false;
 	return ns;
 
+fail_free_page:
+	__free_page(ns->vvar_page);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -128,6 +136,93 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 	return clone_time_ns(user_ns, old_ns);
 }
 
+static struct timens_offset offset_from_ts(struct timespec64 off)
+{
+	struct timens_offset ret;
+
+	ret.sec = off.tv_sec;
+	ret.nsec = off.tv_nsec;
+
+	return ret;
+}
+
+/*
+ * A time namespace VVAR page has the same layout as the VVAR page which
+ * contains the system wide VDSO data.
+ *
+ * For a normal task the VVAR pages are installed in the normal ordering:
+ *     VVAR
+ *     PVCLOCK
+ *     HVCLOCK
+ *     TIMENS   <- Not really required
+ *
+ * Now for a timens task the pages are installed in the following order:
+ *     TIMENS
+ *     PVCLOCK
+ *     HVCLOCK
+ *     VVAR
+ *
+ * The check for vdso_data->clock_mode is in the unlikely path of
+ * the seq begin magic. So for the non-timens case most of the time
+ * 'seq' is even, so the branch is not taken.
+ *
+ * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
+ * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
+ * update to finish and for 'seq' to become even anyway.
+ *
+ * Timens page has vdso_data->clock_mode set to VCLOCK_TIMENS which enforces
+ * the time namespace handling path.
+ */
+static void timens_setup_vdso_data(struct vdso_data *vdata,
+				   struct time_namespace *ns)
+{
+	struct timens_offset *offset = vdata->offset;
+	struct timens_offset monotonic = offset_from_ts(ns->offsets.monotonic);
+	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
+
+	vdata->seq			= 1;
+	vdata->clock_mode		= VCLOCK_TIMENS;
+	offset[CLOCK_MONOTONIC]		= monotonic;
+	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
+	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
+	offset[CLOCK_BOOTTIME]		= boottime;
+	offset[CLOCK_BOOTTIME_ALARM]	= boottime;
+}
+
+/*
+ * Protects possibly multiple offsets writers racing each other
+ * and tasks entering the namespace.
+ */
+static DEFINE_MUTEX(offset_lock);
+
+static void timens_set_vvar_page(struct task_struct *task,
+				struct time_namespace *ns)
+{
+	struct vdso_data *vdata;
+	unsigned int i;
+
+	if (ns == &init_time_ns)
+		return;
+
+	/* Fast-path, taken by every task in namespace except the first. */
+	if (likely(ns->frozen_offsets))
+		return;
+
+	mutex_lock(&offset_lock);
+	/* Nothing to-do: vvar_page has been already initialized. */
+	if (ns->frozen_offsets)
+		goto out;
+
+	ns->frozen_offsets = true;
+	vdata = arch_get_vdso_data(page_address(ns->vvar_page));
+
+	for (i = 0; i < CS_BASES; i++)
+		timens_setup_vdso_data(&vdata[i], ns);
+
+out:
+	mutex_unlock(&offset_lock);
+}
+
 void free_time_ns(struct kref *kref)
 {
 	struct time_namespace *ns;
@@ -136,6 +231,7 @@ void free_time_ns(struct kref *kref)
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
+	__free_page(ns->vvar_page);
 	kfree(ns);
 }
 
@@ -192,6 +288,8 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	timens_set_vvar_page(current, ns);
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -211,6 +309,8 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
+	timens_set_vvar_page(tsk, ns);
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -246,6 +346,7 @@ struct time_namespace init_time_ns = {
 	.user_ns	= &init_user_ns,
 	.ns.inum	= PROC_TIME_INIT_INO,
 	.ns.ops		= &timens_operations,
+	.frozen_offsets	= true,
 };
 
 static int __init time_ns_init(void)
-- 
2.23.0

