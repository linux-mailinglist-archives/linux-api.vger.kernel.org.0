Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7179BB5
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfG2V6Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34088 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389159AbfG2V6Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so43919007wmd.1
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=Xvj7FXGOcZc8glBEOSMlCCRea94AmWoUVCJMP4wuIQXao27FvB4hBx1k92QxTkajh1
         WY9QHbdeRtE5Z6xDWbgfQ9X7s5m4rKiPEIG3HvXUoVr/LuauNb2sAkNkZoNYLVQWV0j8
         PRoFX4kbJW1IMVapY3ml5xDK0ckUVqvxR3mc/ly8Rhj7LVik0gw9BEUFvWNKPpPyPd6b
         rgcPv4NoHwaotea3sOn3POMM8cMkmKuimIZtGpdPxIZqB296MQkqX1o2x+13ce2N/NUr
         NyapX0AJFU6J35F/tgLrdWswAZ8FWI0O3VPDnRtZx8BFbK5ftShXT2EX6u1+Vpj5+7fS
         K9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=CUM1kJnXrhfFvd5WvcMWKZqk7iOBb7EL9jpChNuvWrt3kwu1iyjDugRBqTYuaq+x6I
         f0os2FmUIRojLhuDd0RRqdNb3mzf6g3rgLdc7uqQz67mRxmBvd9HYNrhoZekYGRMMZ8T
         weK8MvVaXCyspdsZSmYiCPfO+jabXslrddzd2NXA5hDgH4u1sNPFiqXUSSQ7R6Td2l63
         D0iiyQR95fXM5Yt3uHQQVchffhHTlLk08DVVxdnBTr8H+NxaxYOdo7AB2hNafoCCDewa
         W7zpdIbBYHVWgV2DLtgULfSsMDTasN47H4YGwxH3MbrG6eltsBqyGVyyX/V98Dp5iuD2
         av1g==
X-Gm-Message-State: APjAAAV4/9ET5Pq045aS8jIAWVeRSUnItYTk2NJp98ALW6NorRN5LCzd
        OSFyFZxbZUpaeLqA+lriMLujQjUkYcnpmGqKCw435mNWEAXIxm4wsv1zr8FcXuJeUs9eyHMq4h2
        CuyD9wbUsW/VBVjBBuLQiRdH++UuPISIUct88MGxZ8IDId1Dg9R3aDYr2YiBTizXfHTaYu/vfUJ
        eIHarHxLQl3RVULiSBiCyQB5jy9g==
X-Google-Smtp-Source: APXvYqzls+7xlTd6LVoyGi5O5Qsqv6ds0nGfqdgYsh1OcxGC2C81nOLD4IK/YCIrQEc3dfuOi7V58w==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr103549986wmf.51.1564437494027;
        Mon, 29 Jul 2019 14:58:14 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:13 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 10/37] posix-clocks: Introduce CLOCK_BOOTTIME time namespace offset
Date:   Mon, 29 Jul 2019 22:56:52 +0100
Message-Id: <20190729215758.28405-11-dima@arista.com>
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

From: Andrei Vagin <avagin@gmail.com>

Adds boottime virtualisation for time namespace.
Introduce timespec for boottime clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 9 +++++++++
 include/linux/timens_offsets.h | 1 +
 kernel/time/alarmtimer.c       | 1 +
 kernel/time/posix-stubs.c      | 1 +
 kernel/time/posix-timers.c     | 1 +
 5 files changed, 13 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 186c134fe222..334c1a1c6607 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -48,6 +48,14 @@ static inline void timens_add_monotonic(struct timespec64 *ts)
 		*ts = timespec64_add(*ts, ns_offsets->monotonic);
 }
 
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*ts = timespec64_add(*ts, ns_offsets->boottime);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -73,6 +81,7 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 }
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
+static inline void timens_add_boottime(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index eaac2c82be5c..e93aabaa5e45 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -4,6 +4,7 @@
 
 struct timens_offsets {
 	struct timespec64 monotonic;
+	struct timespec64 boottime;
 };
 
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 55cb6e78d082..b1e82bb6cc6b 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 17c67e0aecd8..edaf075d1ee4 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -82,6 +82,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
+		timens_add_boottime(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index cfeb0477d1f9..265fbc816520 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -240,6 +240,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
 	return 0;
 }
 
-- 
2.22.0

