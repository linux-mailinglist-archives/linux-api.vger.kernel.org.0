Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D95F865B
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKLB3v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:29:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50847 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfKLB1l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so1315045wmh.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOA0vDbw/NVXlVn4EHrAgoWsjoc11VgoaMF3R+fSNyc=;
        b=PSnvmtcsqSWK6tLCn1fQqhfYjJCN9UJ04tC0vwgzDz0RXGQChKfeStqACDD11HZFo2
         XrjRu19ZJIJaiH95n3D2wIocVIorMlyKQcZIYSokgPB1UBPq0ZLZ6VXPvj5S/NYZcFPJ
         PVr9e5aLvBHyvUzi19Br31i2uDHmwBDYHjZVPK3T0b0lQB2mfKMUJIX2arylKDttFXLQ
         ZUaj7mMIrubRMw1RM2MRPOgXDZRx3uJGjLieV+y8JnWeG5T9Y3P7tcIlT9GzApn5hXbB
         FZ5XM0rcyDx3iSH9AOPyNfH/Z99GfBh/eLScwG6HLlP+WuzyCWMagnhDDfYuaic8h3if
         pvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOA0vDbw/NVXlVn4EHrAgoWsjoc11VgoaMF3R+fSNyc=;
        b=jsFr2++ADvH8YUaeF29dCgkyqRCrBssJI1rq0RrJhFQ93l72/q437IfpMTAlQs+AGl
         sVOvAtiqG6wGh6Z2waQkoCntr5yioHqetqjeWw45o/qECM0gcO44aF8bf8ZP2shATwvF
         2hdPb3I+4VBkSmYXAi12A7PAzaHYDQbllhrODavQTz6EZtC6TID+Mhzcf3Cq0obuoXXP
         skGCv32iy91ZYOVlUhuWBVED7/M89/BjS2SscdUtxZsYzroJq5U8I5vYwPW7OIHgnqyy
         6SVIBw/RQza0wTR/JbE0L4ukal1lcKIs0hudBRHZNv9HhYDS7jSRFV+Fez5+A9M0rTgl
         C2FQ==
X-Gm-Message-State: APjAAAUoVec8xiyhVkfXSovaMcQghmeuq9HPMVyxvQgwPIOne9+PMZG3
        HRe7tVnvGH6vwvYsrfsKJmtO0g==
X-Google-Smtp-Source: APXvYqz4Q6JwsjcFRYXxCtlhTLkKJA34j1pX57XKLnAfIxBSJt/dHy/eQTFBL8hMXUfR3uT43eggpA==
X-Received: by 2002:a05:600c:294e:: with SMTP id n14mr1502461wmd.18.1573522058297;
        Mon, 11 Nov 2019 17:27:38 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:37 -0800 (PST)
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
Subject: [PATCHv8 05/34] posix-clocks: Rename the clock_get() callback to clock_get_timespec()
Date:   Tue, 12 Nov 2019 01:26:54 +0000
Message-Id: <20191112012724.250792-6-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
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
index 42d512fcfda2..8ff6da77a01f 100644
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
2.24.0

