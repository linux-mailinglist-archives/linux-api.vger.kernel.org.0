Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785CDD36E6
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfJKBXw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:23:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKBXv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:23:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so9938590wrq.10
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90PjiYhtgNgMLOv8ABM/+Y9Zkx3VTJeUMzSCSU3Pc2s=;
        b=ORGRn0XJMAmXPLF0qgQkK4yqtSX8DRXKu9P9T2GuEieJ5AZQJNJlBjG+roN7bSkEGG
         HjOoKTApXe85jXcRGGliHMt+R2VjUVrYg5Nuob9UhIDTmceirnA+6Ek5vj8B5cN3UFps
         WUCQNTFXe0VbGfozZCCjIl+UZ9+0rcrorAX/jYBFkVgqFZ1s0Pc/Rr0UZMjS3084KPyc
         yRVj1Jekxxa6qyyNliOMQhWsyveWoo+OdDlc0bNAU8A2dXX+3HLGPiBiTHORojezmVuP
         kIMkwTdCmaJ/yMx0YIep5MOLw2mej5qG70xEp6E7fVbYUc8/ag5WNNexcB6NRZ3MIy7r
         1m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90PjiYhtgNgMLOv8ABM/+Y9Zkx3VTJeUMzSCSU3Pc2s=;
        b=b5TVvNqqbCQi+UAMVKWI9pKPqqBRJ8B49arR8XI2csIy1Zt53KLUg48KTnoW678VNI
         0S6LRprHZQlQllsK8AHZujWRFoPJraewS0ZRp7VJyauPY4c+8tUSssfYfHHC8AFfTaqQ
         R5mZNnXrbIDzTTwL+c88rnzBmP9wFWiCb/GLdnkhfFaxFksDt6WgLPepckxCQVbuIldq
         EhnjDmXzIBpKIZaVjYhAhgOpI0Y8uNr+IQnAumD1oJAZqt7CJkke03QkB5FsPS+kOTDQ
         l0t04vO0G3TYyH+hzama2bHSKNQ72/xpmzC1o96hhFzJLcP96R3XX0/e/KEl149zcqV9
         O6aQ==
X-Gm-Message-State: APjAAAXeXsJ5hNQKVZ2I8WIBfR8yKHWHMkGm+AIE5RrkW0G/17v9owSH
        I80w3hTPTQHXe6jBXWnm8yNbCg==
X-Google-Smtp-Source: APXvYqyzoh8Oxbi8/7X8ayaln2LFqEMIjzlD50OuUNXIc09DTYZbiL9ZvgU87ZZFa+vHe6yTk3nUWg==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr10868421wrr.93.1570757029749;
        Thu, 10 Oct 2019 18:23:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:49 -0700 (PDT)
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
Subject: [PATCHv7 03/33] posix-clocks: Rename the clock_get() callback to clock_get_timespec()
Date:   Fri, 11 Oct 2019 02:23:11 +0100
Message-Id: <20191011012341.846266-4-dima@arista.com>
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
 - The time in a task's time namespace for sys_clock_gettime()
 - The time in the root name space for common_timer_get()

That adds a valid reason to finally implement a separate callback which
returns the time in ktime_t format, rather than in (struct timespec).

Rename the clock_get() callback to clock_get_timespec() as a preparation
for introducing clock_get_ktime().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c       |  4 ++--
 kernel/time/posix-clock.c      |  8 ++++----
 kernel/time/posix-cpu-timers.c | 32 ++++++++++++++++----------------
 kernel/time/posix-timers.c     | 22 +++++++++++-----------
 kernel/time/posix-timers.h     |  4 ++--
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 451f9d05ccfe..8523df726fee 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -657,7 +657,7 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
 }
 
 /**
- * alarm_clock_get - posix clock_get interface
+ * alarm_clock_get - posix clock_get_timespec interface
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
@@ -837,7 +837,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
-	.clock_get		= alarm_clock_get,
+	.clock_get_timespec	= alarm_clock_get,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_del		= common_timer_del,
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index ec960bb939fd..c8f9c9b1cd82 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -315,8 +315,8 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 }
 
 const struct k_clock clock_posix_dynamic = {
-	.clock_getres	= pc_clock_getres,
-	.clock_set	= pc_clock_settime,
-	.clock_get	= pc_clock_gettime,
-	.clock_adj	= pc_clock_adjtime,
+	.clock_getres		= pc_clock_getres,
+	.clock_set		= pc_clock_settime,
+	.clock_get_timespec	= pc_clock_gettime,
+	.clock_adj		= pc_clock_adjtime,
 };
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 92a431981b1c..c84ee50e2eab 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1391,26 +1391,26 @@ static int thread_cpu_timer_create(struct k_itimer *timer)
 }
 
 const struct k_clock clock_posix_cpu = {
-	.clock_getres	= posix_cpu_clock_getres,
-	.clock_set	= posix_cpu_clock_set,
-	.clock_get	= posix_cpu_clock_get,
-	.timer_create	= posix_cpu_timer_create,
-	.nsleep		= posix_cpu_nsleep,
-	.timer_set	= posix_cpu_timer_set,
-	.timer_del	= posix_cpu_timer_del,
-	.timer_get	= posix_cpu_timer_get,
-	.timer_rearm	= posix_cpu_timer_rearm,
+	.clock_getres		= posix_cpu_clock_getres,
+	.clock_set		= posix_cpu_clock_set,
+	.clock_get_timespec	= posix_cpu_clock_get,
+	.timer_create		= posix_cpu_timer_create,
+	.nsleep			= posix_cpu_nsleep,
+	.timer_set		= posix_cpu_timer_set,
+	.timer_del		= posix_cpu_timer_del,
+	.timer_get		= posix_cpu_timer_get,
+	.timer_rearm		= posix_cpu_timer_rearm,
 };
 
 const struct k_clock clock_process = {
-	.clock_getres	= process_cpu_clock_getres,
-	.clock_get	= process_cpu_clock_get,
-	.timer_create	= process_cpu_timer_create,
-	.nsleep		= process_cpu_nsleep,
+	.clock_getres		= process_cpu_clock_getres,
+	.clock_get_timespec	= process_cpu_clock_get,
+	.timer_create		= process_cpu_timer_create,
+	.nsleep			= process_cpu_nsleep,
 };
 
 const struct k_clock clock_thread = {
-	.clock_getres	= thread_cpu_clock_getres,
-	.clock_get	= thread_cpu_clock_get,
-	.timer_create	= thread_cpu_timer_create,
+	.clock_getres		= thread_cpu_clock_getres,
+	.clock_get_timespec	= thread_cpu_clock_get,
+	.timer_create		= thread_cpu_timer_create,
 };
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0ec5b7a1d769..44d4f9cb782d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -667,7 +667,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * The timespec64 based conversion is suboptimal, but it's not
 	 * worth to implement yet another callback.
 	 */
-	kc->clock_get(timr->it_clock, &ts64);
+	kc->clock_get_timespec(timr->it_clock, &ts64);
 	now = timespec64_to_ktime(ts64);
 
 	/*
@@ -781,7 +781,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get() work.
+	 * functions which use timr->kclock->clock_get_timespec() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -1067,7 +1067,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	error = kc->clock_get(which_clock, &kernel_tp);
+	error = kc->clock_get_timespec(which_clock, &kernel_tp);
 
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
@@ -1149,7 +1149,7 @@ SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	err = kc->clock_get(which_clock, &ts);
+	err = kc->clock_get_timespec(which_clock, &ts);
 
 	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
@@ -1261,7 +1261,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_clock_realtime_get,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1279,7 +1279,7 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_ktime_get_ts,
+	.clock_get_timespec	= posix_ktime_get_ts,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1295,22 +1295,22 @@ static const struct k_clock clock_monotonic = {
 
 static const struct k_clock clock_monotonic_raw = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_monotonic_raw,
+	.clock_get_timespec	= posix_get_monotonic_raw,
 };
 
 static const struct k_clock clock_realtime_coarse = {
 	.clock_getres		= posix_get_coarse_res,
-	.clock_get		= posix_get_realtime_coarse,
+	.clock_get_timespec	= posix_get_realtime_coarse,
 };
 
 static const struct k_clock clock_monotonic_coarse = {
 	.clock_getres		= posix_get_coarse_res,
-	.clock_get		= posix_get_monotonic_coarse,
+	.clock_get_timespec	= posix_get_monotonic_coarse,
 };
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_tai,
+	.clock_get_timespec	= posix_get_tai,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1326,7 +1326,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_boottime,
+	.clock_get_timespec	= posix_get_boottime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 897c29e162b9..070611b2c253 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -6,8 +6,8 @@ struct k_clock {
 				struct timespec64 *tp);
 	int	(*clock_set)(const clockid_t which_clock,
 			     const struct timespec64 *tp);
-	int	(*clock_get)(const clockid_t which_clock,
-			     struct timespec64 *tp);
+	int	(*clock_get_timespec)(const clockid_t which_clock,
+				      struct timespec64 *tp);
 	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
-- 
2.23.0

