Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3223CD36EA
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfJKBX5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:23:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44035 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfJKBX4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:23:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so9946972wrl.11
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32i3rlPnPIUjSax4fIDn8Tdz5RBuYEExuGzWxsOVPEI=;
        b=TJsOHWyp3RI3NNxjDHo17VY8gShxlJlrFvbW9z7jzQt6x2+Ki/bFWTz96DDFBH/HOp
         ju1T09Z3RB2FXi59KqHqJ7S3EZh2pnh/KVpZ+fGI2dygg2oSEha4sAnuBwqdvlo4KMS6
         YCqjy2W77i0fdl9d8T8esRf/DMq40Y01cYW0Mv2d00uG2YDEnxRq9VbsKeTfRd34FMAH
         LyqumoVFd9CRIl5nbO4bvI/7S+BUmm2EJ7QZ6USs5awRQ9v0zSnSLzPlntgqaSzdUDux
         MEdCJYdcqWP6JGQkVcQwTjjXFFOPqd8gq9Mi+B+CjChngcg4eXFGWmOv0tq1xC7d2j0t
         /UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32i3rlPnPIUjSax4fIDn8Tdz5RBuYEExuGzWxsOVPEI=;
        b=ERviwWUVd6R9aHeOiFizdPB4XuCXEjX6ALNASvTPKwSI1hz9uCObQIPls8n2zu9+H6
         vjVAVrnkaiVxtj66SqpaDmyuhV50RBKG0zjWXSqpaT6LR0qxJeq4hEZjsfacBiKpwBE0
         4KF7enORN3zaVFnxEBn5B7UU1aorOVZGKV9P1BfGi2p9EpMTE5WdKdXOPrsox9L9Cwrm
         O4w5lGhVWAtYSUHFEQX1UkoFHK1+ZY4IkVdWFZJtgpGGt8iOXJiMcADgvp3dhaqz1IC6
         FKp6fcZM2ie1S9gpHtVp5MWFdI/6qbJ4EOE7ckry8lGeiGlOUJ6v02h+vWMx1TX6HUnh
         X2Xw==
X-Gm-Message-State: APjAAAW+DBPgmNa1LiKptshWgP+ph5gCwiQ4gfztE1q+ru9CLLwtNuvo
        XT7C0Tb7snOUQ9PA+xiAo9Od0w==
X-Google-Smtp-Source: APXvYqx/HJfdsY1kSbXBXdS/66J5oOOV4jeaX6yiWnl4/oK/p+gSh7GqgB3FRk1SAFcFCrbwJV08lA==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr10400886wrs.243.1570757032884;
        Thu, 10 Oct 2019 18:23:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:52 -0700 (PDT)
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
Subject: [PATCHv7 05/33] alarmtimer: Rename gettime() callback to get_ktime()
Date:   Fri, 11 Oct 2019 02:23:13 +0100
Message-Id: <20191011012341.846266-6-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

The upcoming support for time namespaces requires to have access to:
  - The time in a tasks time namespace for sys_clock_gettime()
  - The time in the root name space for common_timer_get()

struct alarm_base needs to follow the same name convention, so rename
.gettime() callback into get_ktime() as a preparation for introducing
get_timespec().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 62b06cfa710d..22b6f9b133b2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -36,13 +36,13 @@
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
- * @gettime:		Function to read the time correlating to the base
+ * @get_ktime:		Function to read the time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
-	ktime_t			(*gettime)(void);
+	ktime_t			(*get_ktime)(void);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -207,7 +207,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->gettime());
+		restart = alarm->function(alarm, base->get_ktime());
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (restart != ALARMTIMER_NORESTART) {
@@ -217,7 +217,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	}
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_fired(alarm, base->gettime());
+	trace_alarmtimer_fired(alarm, base->get_ktime());
 	return ret;
 
 }
@@ -225,7 +225,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	return ktime_sub(alarm->node.expires, base->gettime());
+	return ktime_sub(alarm->node.expires, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 
@@ -270,7 +270,7 @@ static int alarmtimer_suspend(struct device *dev)
 		spin_unlock_irqrestore(&base->lock, flags);
 		if (!next)
 			continue;
-		delta = ktime_sub(next->expires, base->gettime());
+		delta = ktime_sub(next->expires, base->get_ktime());
 		if (!min || (delta < min)) {
 			expires = next->expires;
 			min = delta;
@@ -364,7 +364,7 @@ void alarm_start(struct alarm *alarm, ktime_t start)
 	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_start(alarm, base->gettime());
+	trace_alarmtimer_start(alarm, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_start);
 
@@ -377,7 +377,7 @@ void alarm_start_relative(struct alarm *alarm, ktime_t start)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	start = ktime_add_safe(start, base->gettime());
+	start = ktime_add_safe(start, base->get_ktime());
 	alarm_start(alarm, start);
 }
 EXPORT_SYMBOL_GPL(alarm_start_relative);
@@ -414,7 +414,7 @@ int alarm_try_to_cancel(struct alarm *alarm)
 		alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_cancel(alarm, base->gettime());
+	trace_alarmtimer_cancel(alarm, base->get_ktime());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(alarm_try_to_cancel);
@@ -474,7 +474,7 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	return alarm_forward(alarm, base->gettime(), interval);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 
@@ -500,7 +500,7 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 		return;
 	}
 
-	delta = ktime_sub(absexp, base->gettime());
+	delta = ktime_sub(absexp, base->get_ktime());
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
 	if (!freezer_delta || (delta < freezer_delta)) {
@@ -632,7 +632,7 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
 	if (!absolute)
-		expires = ktime_add_safe(expires, base->gettime());
+		expires = ktime_add_safe(expires, base->get_ktime());
 	if (sigev_none)
 		alarm->node.expires = expires;
 	else
@@ -670,7 +670,7 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->gettime());
+	*tp = ktime_to_timespec64(base->get_ktime());
 	return 0;
 }
 
@@ -747,7 +747,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 		struct timespec64 rmt;
 		ktime_t rem;
 
-		rem = ktime_sub(absexp, alarm_bases[type].gettime());
+		rem = ktime_sub(absexp, alarm_bases[type].get_ktime());
 
 		if (rem <= 0)
 			return 0;
@@ -816,7 +816,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
-		ktime_t now = alarm_bases[type].gettime();
+		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
 	}
@@ -882,9 +882,9 @@ static int __init alarmtimer_init(void)
 
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
-	alarm_bases[ALARM_REALTIME].gettime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
-	alarm_bases[ALARM_BOOTTIME].gettime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
-- 
2.23.0

