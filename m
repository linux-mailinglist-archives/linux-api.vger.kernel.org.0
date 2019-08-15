Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF758F10F
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfHOQlS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:41:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40804 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfHOQio (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:38:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1775678wmj.5
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xONtgxOFu1xrUbT6IwdYairnJYyUH1iSMsXkpOYAQlQ=;
        b=HbJr4BM+041kn+K3gvXA4KUJqzMWAkU8fRQl9clSzT0AQr9wEblmvtDHqCN7u5fDFQ
         SaMSxzn/KgV9KH/nNg1bORWN66EXqgJJoII8V02kDV19UyqPHPQ9aHRJfLBkzSX9F1ko
         jZIibEOpYkbTz18EWiWLUZ6BWXXk7bKPaNHSKxSXoqLL15GJeEgkhsxhWWpoA+gET3yX
         9GfI36QECNCZpLZOamZOowYC7wCXC0oOOCW1AiP/FXlwvikIH6KSZ0kWnYfbNR5557bL
         OoTGiyYa+tlMmgndKlKwTnmrn5UXiTIZ0xbuThzjwnrOvic8SBvdAz/TxeIGik9C2rJV
         QljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xONtgxOFu1xrUbT6IwdYairnJYyUH1iSMsXkpOYAQlQ=;
        b=Mz8DObc+jaVO34aWfU33OxOxl11Hsde+3JtVrE3SYvPSzM0wPB777A2CZNruAtxDPp
         jI2ANdZfn2xXXzwcWFci+dBRzH3ekylDzf98fyTTwWGFmBcuRvJylIbPizeKJ/QyLN3c
         FMTZIbWT5JMQWQVxfqet/fA+4EdhM99WPwVQsAwmoxQO6XLs1Y2TICNc7JPz6dTbjJyv
         vHuBgmmCc1q6VkDdvfsjmGjJX2GKScazO5dTxfUITPydzE+4M3b/YMhTyvGzTETnI0nw
         yK5zFKCVKO/0LhuI5TLwNQ7ufVardIcDyV7mnNz5aEC3iseCh5iSO+wSsoad5N7cfh1b
         X0qw==
X-Gm-Message-State: APjAAAWoeDKDzRSNYN8va+zP4CERFB3q/qcZIyVZcN6JWuHXt8fNSKY5
        Yu64U2DHsfvDh8HHJoObB8iLfg==
X-Google-Smtp-Source: APXvYqy7v38pksCIboirEHgRL0NUyJuIQTraHRC8JFyKFWlKHVrAOUtqPPAamxKjwC2dEAuOAqQ4aw==
X-Received: by 2002:a1c:790d:: with SMTP id l13mr3457943wme.49.1565887121240;
        Thu, 15 Aug 2019 09:38:41 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:40 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 02/36] timens: Add timens_offsets
Date:   Thu, 15 Aug 2019 17:38:02 +0100
Message-Id: <20190815163836.2927-3-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Introduce offsets for time namespace. They will contain an adjustment
needed to convert clocks to/from host's.

Allocate one page for each time namespace that will be premapped into
userspace among vvar pages.

A new namespace is created with the same offsets as the time namespace
of the current process.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 MAINTAINERS                    |  1 +
 include/linux/time_namespace.h | 18 ++++++++++++++++++
 include/linux/timens_offsets.h | 10 ++++++++++
 kernel/time_namespace.c        | 16 ++++++++++++++--
 4 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/timens_offsets.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97b7737f5aba..527aee1e616f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12899,6 +12899,7 @@ S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
 F:	include/linux/time_namespace.h
+F:	include/linux/timens_offsets.h
 F:	kernel/time_namespace.c
 F:	kernel/time/*timer*
 
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 9507ed7072fe..334c1a1c6607 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
+#include <linux/timens_offsets.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
@@ -39,6 +40,21 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
+
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*ts = timespec64_add(*ts, ns_offsets->boottime);
+}
 
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
@@ -64,6 +80,8 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 	return 0;
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts) {}
+static inline void timens_add_boottime(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
new file mode 100644
index 000000000000..e93aabaa5e45
--- /dev/null
+++ b/include/linux/timens_offsets.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIME_OFFSETS_H
+#define _LINUX_TIME_OFFSETS_H
+
+struct timens_offsets {
+	struct timespec64 monotonic;
+	struct timespec64 boottime;
+};
+
+#endif
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 8fd8384b7261..394a9e168e7c 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -47,6 +48,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 {
 	struct time_namespace *ns;
 	struct ucounts *ucounts;
+	struct page *page;
 	int err;
 
 	err = -ENOSPC;
@@ -59,15 +61,24 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto fail_free;
+	ns->offsets = page_address(page);
+	if (old_ns->offsets)
+		memcpy(ns->offsets, old_ns->offsets, sizeof(struct timens_offsets));
+	BUILD_BUG_ON(sizeof(*ns->offsets) > PAGE_SIZE);
+
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto fail_free;
+		goto fail_page;
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	return ns;
-
+fail_page:
+	free_page((unsigned long)ns->offsets);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -95,6 +106,7 @@ void free_time_ns(struct kref *kref)
 	struct time_namespace *ns;
 
 	ns = container_of(kref, struct time_namespace, kref);
+	free_page((unsigned long)ns->offsets);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.22.0

