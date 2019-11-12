Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DDF8644
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKLB2G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:28:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35373 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfKLB2F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:28:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so1226231wmo.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddvnrlVQIBQi2UdmQm0T4s30wuJ+GSXXFOcBue2IHWU=;
        b=Ww31a6Rd5K/50GI+Kcp0/h9pnlkQbJkZaUkyXPcP0en2v85unLO2MkG+fQBf157jrg
         TyyM3X9PxEPTnL1icLUZ0//lBmnR4U4IKcR/9HJbs4sPeA0zAP7SDq/Ix45SxK7RKqAC
         LaQxvTcF8/OU43CcJgcCGil9oaMz3UQBM+uYUjT+hYhTbWSSaAmPDnJDpHT7fIWz1iIz
         GfwCUgy0atb3/7MBQHgHsu6bLyriDnbsHgI1qGVe92dSB4RIPy1xk2VSRjvFbK5smbsY
         ZsNG1ji7h+/EAHp7/RGk4gucnQ936fw3DKgBTQEvptkF/tdkE4l8+WSRUFvE+m6RrTUw
         NmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddvnrlVQIBQi2UdmQm0T4s30wuJ+GSXXFOcBue2IHWU=;
        b=q97z961UXkPdiCW1BsacQRD3oqO057HR97oSfhkTS2rP3u9V5YOkxWS3WepEtmdmmY
         FdQrwL3CsVK+3own2ImCHkWJKHOU/p8dCbAkznlk2aUzCxq630y1LgPcT5SxidxWQDtz
         8diDEmW0k6StEWsFTQR9ev2rzkWSTHowbg2cDq5TCCVO3bL8PLFuTeoYlLtvInGMxJV3
         zlfCCLUNOxJESJX9nsgZ2N7lc7Sg4M8oFQeg+3MlrINFLK3eVKkcDKiZN5ozwrZyZRCq
         ew9ztByBekncRWcN3e73r02pYvBLoVOD0I3Kizb5iZlvu4m3oMUC2CExWRq1QYYCvAql
         1xxQ==
X-Gm-Message-State: APjAAAWBxb0Qv2dCrZD9iO7DDQGwIssoQYjrV/aARhIIQ0QKrpdprMLy
        Ehq462VG4TwTKMc5oq5V8Pj8Pg==
X-Google-Smtp-Source: APXvYqyLxSBHM/hB7ZUA50t0oHTiQ00OdpJZlTDrDeD25VmT6pRVFGWoQZBI8peaxOXtVqMXBVzQtw==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr1612505wmb.175.1573522082622;
        Mon, 11 Nov 2019 17:28:02 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:02 -0800 (PST)
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
Subject: [PATCHv8 23/34] time: Allocate per-timens vvar page
Date:   Tue, 12 Nov 2019 01:27:12 +0000
Message-Id: <20191112012724.250792-24-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
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
index 90e82654b4ce..cdb438ba0037 100644
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
2.24.0

