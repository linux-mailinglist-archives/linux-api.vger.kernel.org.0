Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3474301B
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfFLT0j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfFLT0j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so18165950wrn.1
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+0bCsvW0leJeWcSaXdF9Pf6o6k198MJcOxy/7YaYSY=;
        b=G3xBxusSn3AJXI3lbO60Zw8icEb9IYRciGYBwSUszE4r9qdxvf3satBIm9c73YEMrG
         9DIhfmyklqZU0G75I9+SkqDh0R7i6a27QyiVtEE2wjs9Q+cCoUynJ4SXm6nF7GIoCh1o
         f6Z4S8lQlP9bkUjfW2cqjnmofW9/isPXn8JVXp/9cNwJgaeONsWRcDYRs22xiR8gvlgt
         YWg8v11V8RjsW51zv0MLB03eFKttm6QRV9tDeYOsdcH/mekV2WZSiUINlgNH4U1VuT21
         r9P9V+tx6Q2J0vPyHQwCt+ut/pit31wNLG5BO7Es87XXNTArjqGgxUZ7rbg+vXDcEDVG
         7tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+0bCsvW0leJeWcSaXdF9Pf6o6k198MJcOxy/7YaYSY=;
        b=M9R1tp3npqkLU/AQqoDpUMOj+BDXNCICqhb5cX/qs0SJKwdYMyJM4q9/x/mS1/EGwc
         pcSCSe5cALDfiXLiDMkdRLh6Soft7LLoiE382OlPzr4dwzZQJIKOzuKDpJpRSQRb8drc
         DjsztAOauvlCu6dhcXLx1EesfMP+s+GeQ1IJn5/88lY69T5l5vI2TbpiE3xGI0vffNBq
         Uu3P9juv7vnTcWLTn0mCV3PYv0CoWVl8cocq6aePzh+U3JtI6CDOkqXHseZf1DI1Fkv5
         gGOMgd6KZkq2OVpsZsVOGM8/JLCOQFfeGJnB0WEupWPmALe6Goqpbt9xKJ0zGfkEI2Gi
         qn/g==
X-Gm-Message-State: APjAAAUpX6Op05XBibfjBbdI9pLOFXiIz+5M4JBaRGdx9gABbEHmd1Xc
        rLTqBA7TgPp3+33XUW69fVMVaA==
X-Google-Smtp-Source: APXvYqyKkGf4WbdKqtzWBxyv6vK7MB/pLfwtqXEj/31JuYGR+I/fvx1QsWtDX1YDefUU7xFLyrmcTw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr36012935wrw.309.1560367597224;
        Wed, 12 Jun 2019 12:26:37 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:36 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 05/28] timens: Introduce CLOCK_BOOTTIME offset
Date:   Wed, 12 Jun 2019 20:26:04 +0100
Message-Id: <20190612192628.23797-6-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 81d0c989df3c..1dda8af6b9fe 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -48,6 +48,14 @@ static inline void timens_add_monotonic(struct timespec64 *ts)
                 *ts = timespec64_add(*ts, ns_offsets->monotonic);
 }
 
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+        struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+        if (ns_offsets)
+                *ts = timespec64_add(*ts, ns_offsets->boottime);
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
index 68a163c8b4f2..6346e6ee0d32 100644
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
index 52098f6ad596..573942ae2629 100644
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

