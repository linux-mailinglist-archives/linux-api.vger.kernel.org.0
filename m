Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A75279BFC
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbfG2V6P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389226AbfG2V6O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so63476695wrm.2
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=M/VNVvPSR7BlmAhDH2lovmGmgLk97R+1GL43do5srTu1wANXq39v9P6m+cEXz6okk+
         ebIpEjYor2Vgti9kLgnwgLx/ptriGbWEG3u7mmaOUbUAZGu6wAPETV5ckspfAq8Pt9cT
         YrmxQriwMO1Y5HbF6Pfx6DpXuoR43Yz/LAFlpTrTZPp/VwKR97aDlDnvQPsrYTeJMH3g
         EaQJrsi5e+PNo19HgAzQVm/HQQwCJNUIZEjm0TiQttw25eUOj+cIlTgVMHwbVV2iPtpk
         xkWcZW5n1DtKPXOA0J6iuRhwuWL0t4MDyZtjA+qnc7yJHIBVHnCZxSmUGZ3ZWZuFNHhR
         BSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=lKm+VMMXf+HqCUpaku8rPcumHQBl0TxkyYV2A6UE0iYEsS5L76j+uzieCbWZrR70Sb
         6u8M+7FSj5VhMozIUmkv0zEkDBT1E1khkvKkH7evic6mZX5hvvpgAuBj7a+44uto7FT0
         l6eZl1fbki8yGfBuHwSy6Ew6OZfz9yFPM43RM3//N9PEVcSGw2mf5rm4ua9qwpz+qZG4
         BgIi7WiYEcMY9YlQScPwSZLDevWgVL8+YsysKeHdik7LiihOEhAG5k3bm68YDiBJxJ1D
         A7kKJQsow/jweF6c+LBPrtYFHtZIIwYkyzwNDAEFgGIMchGarqyrBLHpyzJb6hlK3k28
         hx5g==
X-Gm-Message-State: APjAAAUCPbuiwBC0+uPG9wkS8dfOyuB94jstNcJUX4ElEx0MGgvI9So9
        VQBlOlpNO+Ttcdt02Hu5upqmLXYhAnOd9TEz5GUuJm8BjxTnYxRKE06qygdyrIn0LuRMJGh9c9c
        u8G89RH6W0ovn3LBW7b4bJUgACG5k7n3kt4poKNG7XLApwtEvk39lPJzcn3chfAgAyi+tUkf1to
        F4Us6qe75SpSdmZu61xlUmkvrzaQ==
X-Google-Smtp-Source: APXvYqzVgjJW1NiW+wRac4WVlY92hv8PwXoC70KjvHAcyCjvnPXF0l/RBZpUyVD7uEE/Pda27Es8aw==
X-Received: by 2002:adf:f206:: with SMTP id p6mr50649643wro.216.1564437492712;
        Mon, 29 Jul 2019 14:58:12 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:12 -0700 (PDT)
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
Date:   Mon, 29 Jul 2019 22:56:51 +0100
Message-Id: <20190729215758.28405-10-dima@arista.com>
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

