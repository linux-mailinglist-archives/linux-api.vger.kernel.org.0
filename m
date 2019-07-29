Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB86A79BDB
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfG2V7i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:59:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37643 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfG2V7H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:59:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so54780706wme.2
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=fY7Kpd+yuXwm7P4rTQ7cvrYy2QaBpk8fVQjLQGAJVN63a6jYIT39vRAVo42ZwJBAzc
         n62ZMKGIdmUOn8TiTaOH6nrpDucVU0YcRDV72mybRDgG7NBr+qSy6SlyIgwMmskpV4FU
         SzZOGJUXc8RoTmeCyrvzbWZFH2aq5qq0uB1FIV7juLhHcJdkxLU0kYz4Iy4GBMpAlyUD
         nIwkcWZZ7jRDou2yni8o5J1tZGC0YoYT11WyAlC5SmFIZ/sNRAUFvPQnlihb+KfGDvQ7
         9TyUgYiDS2q7bdJBxivwcTBndEYvbMCsbNLHkVWQP4ZZukErT1caGXVC1FUEEZXOsRj2
         NraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=AbabGZAyYvcAV0xcrfZRV7ewnfu3n/vxv3GB2erl8KxYzzhSoJPb0wbu82NP/TV7z4
         1HBhkyc37NdN47vxM7FnRwxJNdpZzUFbwcc8H/jWxkHIhIlXbIcW03FxuVuO1w3Dm151
         7o3UdVe3I4BRCwZ2tyBizZjrVnXjjx0puxYsigB1WjtPXOoZpGHMGWxdEhb06/X3Lbfu
         26j58TveXDOGKXfKTOgcUtCfgp3VHWE7ofT5QgE7zR81E50jvw96vbBN36OkDHkutNaF
         iGT8mjxCl096Pq1wd+YNxTzm5WFtA7kEsFj2y53gimKl0NROzkV7EKzs/I/Nxf6p9tg8
         cmwQ==
X-Gm-Message-State: APjAAAX5qNPvQ62JwLh/ug2pSm1l3fzgbiRkRZe8/ILFAtlAsJZ3XFKI
        qTeT4dYCpcZIieQOZrNuY2Z7t369gIvIUcNyRM2UVGFIyJf76wBtjXZExbH/RNDJZ9Qm93yZvcY
        GUSvUVpKwPXZoGSe5KHvi2VqxQ5GySbiuQJ4FBVqM48Beh30dZmA1AKZfeWn36v3BTEZ8IR6bak
        ee7pfjqWL08KYs1qEn/RCbh/dJDQ==
X-Google-Smtp-Source: APXvYqyyd8QMGJlXsKgbAJvJZ00e8fZysTvNQDcGQhhfztiT6N+m8EP6WD1I6LYcRUkkK5Js5HMFfg==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr41296662wma.100.1564437545831;
        Mon, 29 Jul 2019 14:59:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:05 -0700 (PDT)
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
Subject: [PATCHv5 09/37] posix-clocks: Introduce CLOCK_MONOTONIC time namespace offsets
Date:   Mon, 29 Jul 2019 22:57:29 +0100
Message-Id: <20190729215758.28405-48-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Add monotonic time virtualisation for time namespace.
Introduce timespec for monotionic clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 8 ++++++++
 include/linux/timens_offsets.h | 1 +
 kernel/time/posix-stubs.c      | 2 ++
 kernel/time/posix-timers.c     | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index b6985aa87479..186c134fe222 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -40,6 +40,13 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
 
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
@@ -65,6 +72,7 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 	return 0;
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 7d7cb68ea778..eaac2c82be5c 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -3,6 +3,7 @@
 #define _LINUX_TIME_OFFSETS_H
 
 struct timens_offsets {
+	struct timespec64 monotonic;
 };
 
 #endif
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..17c67e0aecd8 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -14,6 +14,7 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <linux/compat.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -77,6 +78,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_MONOTONIC:
 		ktime_get_ts64(tp);
+		timens_add_monotonic(tp);
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index aae7ab53790d..cfeb0477d1f9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -196,6 +197,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -210,6 +212,7 @@ static ktime_t posix_get_ktime(clockid_t which_clock)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -224,6 +227,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
-- 
2.22.0

