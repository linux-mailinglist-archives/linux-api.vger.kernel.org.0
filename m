Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848A2F8619
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKLB1t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39835 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKLB1t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so1195361wmi.4
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKv+/2NKe8dFtfqG1MNboyv8rf4pF1RltFLDpxb/294=;
        b=YvFR64ZmrlQH7Y1i0MGF9kQFRVFCwldFrE7uhfKNBt/6ZZNGDeDqHsV3SbXBMQQb+J
         EHiknXnWAeplO3j8IftaS3O11GGPSVcYxS9E/YNH8Z8+EoAcL9soD3oxuORPxAnblYBN
         hVc8CShVkTenWEVpeLXF3JVZTZbucxhjuAUFEKKAQEJcOxhkCiAq/YqL2COjYINq5IOV
         tA/MFYUdMOPajclxE02BbnJVCyHQOHXWrFpUbsOHmZ71Jb7nB+lDL5yhTIlKSJYrSXrk
         zaRas77RRbE5rjMDCX3h3OL3eQ2sY45jbnIRnygFe+G0BydHkTJVP6BdSGCQGnE01dtD
         mTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKv+/2NKe8dFtfqG1MNboyv8rf4pF1RltFLDpxb/294=;
        b=YbM/xdGJXqVyOYqjm7du7agHYHbSjQDZr3ry6WM0BUhLRh+Kpil03YjDRyFSl7BV9f
         l2ULbwQlhlz9lp/JDuIpN7QkT6dNR0NxvDLOg3OXHlndVG8i3/m+wuhl45qzv0ASciZT
         IgLXZoweif+LiG5ldEN61m6f/ka9rf75+3uik97yD4AK3YDElhpsGeokWjA+UDcdxXpu
         mtO70eEu3sDTe4C773lHWXaxGmB+e3YgSY17nFbuqY/T0GkcY8ExBIj0csLQyNrtb6sd
         taETi6Pmabiq/foCW0pufQnei0C+GBfhNI9hU8cly8ALIjtQz7mrE8i6F0cKIQqUSlKf
         keRA==
X-Gm-Message-State: APjAAAXinHU2rheGnBAwzL+86OgjtmRqVi4AnusEBjRYl95irl9OKRBu
        AwUyyyrvEPUzxf8xgLdTnccMCQ==
X-Google-Smtp-Source: APXvYqw1B2GM2aXq8YbS+BON98R2vaAErR08BRhfGLP71ovSunJTq2KKjo9JtP2AWnCEU4RR7BcPCg==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr1561602wmg.177.1573522066529;
        Mon, 11 Nov 2019 17:27:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:45 -0800 (PST)
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv8 11/34] posix-clocks: Wire up clock_gettime() with timens offsets
Date:   Tue, 12 Nov 2019 01:27:00 +0000
Message-Id: <20191112012724.250792-12-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Adjust monotonic and boottime clocks with per-timens offsets.
As the result a process inside time namespace will see timers and clocks
corrected to offsets that were set on creating namespace.

Note that applications usually go through vDSO to get time, which is not
yet adjusted. Further changes complete time namespace virtualisation
with vDSO support.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   | 9 ++++++++-
 kernel/time/posix-stubs.c  | 3 +++
 kernel/time/posix-timers.c | 5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 4d8c90546635..9a8e81bc4ec2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
@@ -886,6 +887,12 @@ static struct platform_driver alarmtimer_driver = {
 	}
 };
 
+static void get_boottime_timespec(struct timespec64 *tp)
+{
+	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
+}
+
 /**
  * alarmtimer_init - Initialize alarm timer code
  *
@@ -906,7 +913,7 @@ static int __init alarmtimer_init(void)
 	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
-	alarm_bases[ALARM_BOOTTIME].get_timespec = ktime_get_boottime_ts64;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = get_boottime_timespec;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..edaf075d1ee4 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -14,6 +14,7 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <linux/compat.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -77,9 +78,11 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_MONOTONIC:
 		ktime_get_ts64(tp);
+		timens_add_monotonic(tp);
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
+		timens_add_boottime(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fe1de4f71ace..d26b915b227a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -195,6 +196,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -209,6 +211,7 @@ static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -223,6 +226,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -235,6 +239,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 static int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
 	return 0;
 }
 
-- 
2.24.0

