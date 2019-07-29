Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65479BDA
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfG2V7i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:59:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37646 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfG2V7K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:59:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so54780759wme.2
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=XCeulL1HqFo71FGgcdV/5qsSDWdEGSIBblaeaVZGBZUjTcko2yKOt8vaOVNS9Umo4x
         BYK3fAoJ8NZLicm4kDYLSHzAk7dusf9h95YXBk4IKA/FDB4tFYfCdIOznpZSk7WTT+ze
         gj0sOFP0LVlO6b45XQSbeoGr3ZD94Pj5LqPOjImqrrYvzx9mykAhdhw18TZF8RWlkujj
         hMmNo7mXw7jF4SlHvV9Vnrq5ZNGA1MR1frTUyL/Ul51gAgwS3CHdjjX9h4zJcvhtmlc0
         /zSI6gJ7eFXRY7kIqVjYY3CzIueKbZXgWPuJcuSQudYSrWXGM97tyMj8L8VD0Ijy0vHt
         5nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=TgplhE9Z6PkQF1rOIeMo/Ro9BfG2jNg2AD+TzHrLUhwiY+qCIxAokZ/mn3+++wkdZB
         +KPklEv/7X83bt7U1wQoeV6tw1a2AwiDYF8nSsfjK/0rIOmwYGlVCYMcoRjRzOqgHQOM
         hc4HOrdiA4TXfyI/w1ZlJgk7WACOY2AVgK9iEU1nBnFifKw1x7xMhhNF8JB8+aY7Qmxb
         xepTHLNv+oaCGXf8F1P77QqOBjsZ+FWLblzlOxB6U0yfaCuNy0mhEe36qLRZbQu4HuR1
         pNOos0jUjRuyqDZ27te4/cNLpv9h/mmq2pplXemN1m7zmvBklQ/LS0LQmSfoKrGx6LAG
         ChPA==
X-Gm-Message-State: APjAAAW386oGgfRMMlj20HbA4oVehTt/qyrVFyynUf22fPHMbVDO6wqn
        zNNHQOT2zgLI1Ai1d0w331C4nMZI/1mcAJPuZIKrVscW1v/06jzJQl+AQPr5jfbTxRPE1lEnL2r
        4RTsfOJv3xElIYm1Edl7oUGuKAriAFwrr4Ag3Had6wQSND0rbuQTzTJg8RpD65xXh/eHBVFB93t
        kU1FZO3K4DInDNmz7C3q3MmZkXig==
X-Google-Smtp-Source: APXvYqy82N1/rS2k+0d9HP0mbqZT6+7XINBuI3UNSfy2RMfcEhMIKVXp/SDEcPsHnzMKYzmg/9wesg==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr104788522wml.90.1564437547221;
        Mon, 29 Jul 2019 14:59:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:06 -0700 (PDT)
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
Date:   Mon, 29 Jul 2019 22:57:30 +0100
Message-Id: <20190729215758.28405-49-dima@arista.com>
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

