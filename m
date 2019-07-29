Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE64379BB1
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbfG2V6J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38812 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389105AbfG2V6H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so33439718wmj.3
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCttgBL0BPZg1/LiUWIoAnwXTnGYw/Et5KrxphEhxpI=;
        b=HkzRt9fJ66LKaENJpsta8WhkdLLXjRKxECxz/C3DZ7kScPXBq5WSLRd62AXTgqkxKe
         TwfIDxwov79P3nbXrsi1TZGm1ZXw5ytYTohw6Yxq0tCmvk20ZFllPoMplE3qzA66UAq4
         jysvr41IVV9wVvUiykBP4rMY/ZXdLEaztMN+OMFjouMzVTIZYTw0gYZAdtU2hueCgdof
         6QPDZMNq2TWHL4Any8DhKDzdpu3mu1OKEOTZyVVZwDnW2wk+erhSye8ID1lUQCb+hWFD
         ehWyy/U6diCu4ZoNj1EN2fnCeW6O0lpZ6e2AYgQ6RzfnFAaxfFnebFmJOkL4h77rJeFo
         ebRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCttgBL0BPZg1/LiUWIoAnwXTnGYw/Et5KrxphEhxpI=;
        b=iDGaFnCXhEqKHP/UU9cjYNxquyeCqkHwLjbQbva6TopJjxuAEhASnXqmZ7kmHLvaC3
         1fwDEnUBG+Yyku2tUOYdMpnsdTWQtC0ovz7iL0426U0OaO4EvtghS7PExtd4H3oO8fuT
         nHymvZN2WLAOxnhP2s7EfZm2GE9nalNqb4UB8q1TBc9kQ8OfGW/iuX2wi2udS2IRGwWs
         BBQnMrtvOytzyaIIkv/xB+0BuMeLdvPao5VfxyyP+tLKdw1SoJgQX34gzDH++W5Sptu7
         V2sxpQ2Yr4GLTkhxcBnArBJyPU+iLp+Zi06cltfBmjlVwLJtriEvV/y7xe0pf+2YkphV
         +3nQ==
X-Gm-Message-State: APjAAAWSl6LOlu2jelvGBhOOfTElYbDsMb57bGNfi89Q69nXCe2qe9wZ
        IqVxGmyqZkWpADa/K5G28mJeTh4TYVhlfedfDS9goZOOPw4/xXG3/fbBrhxrHwFMwJYV8+GdgGQ
        djkwhwJ0/u3brW8poC+WXl4/sxxPGttPV+qYOsGEr/24o5E7uAyFh7FDcPM7bojLbeAzf/LuinR
        tbTCsvSzP9XTcoyH5JYO1wLyi76g==
X-Google-Smtp-Source: APXvYqzPgt9P6fy8oIkobEuaM0cDdbNH47hj7jgxVACbR32K6AD769/1+BicnzMawPtE2YY8Cihp+A==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr106368412wmg.92.1564437484413;
        Mon, 29 Jul 2019 14:58:04 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:03 -0700 (PDT)
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
Subject: [PATCHv5 03/37] posix-clocks: Rename the clock_get() into clock_get_timespec()
Date:   Mon, 29 Jul 2019 22:56:45 +0100
Message-Id: <20190729215758.28405-4-dima@arista.com>
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

The upcoming support for time namespaces requires to have access to:
 - The time in a task's time namespace for sys_clock_gettime()
 - The time in the root name space for common_timer_get()

That adds a valid reason to finally implement a separate callback which
returns the time in ktime_t format, rather than in (struct timespec).

Rename clock_get() callback into clock_get_timespec() as a preparation
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
index 57518efc3810..cada96fdc615 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -644,7 +644,7 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
 }
 
 /**
- * alarm_clock_get - posix clock_get interface
+ * alarm_clock_get - posix clock_get_timespec interface
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
@@ -824,7 +824,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
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
index 0a426f4e3125..dccf7dfcd36a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1417,26 +1417,26 @@ static int thread_cpu_timer_create(struct k_itimer *timer)
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
index d7f2d91acdac..6c9c0f2d2f1e 100644
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
@@ -1032,7 +1032,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	error = kc->clock_get(which_clock, &kernel_tp);
+	error = kc->clock_get_timespec(which_clock, &kernel_tp);
 
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
@@ -1114,7 +1114,7 @@ SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	err = kc->clock_get(which_clock, &ts);
+	err = kc->clock_get_timespec(which_clock, &ts);
 
 	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
@@ -1226,7 +1226,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_clock_realtime_get,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1243,7 +1243,7 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_ktime_get_ts,
+	.clock_get_timespec	= posix_ktime_get_ts,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1258,22 +1258,22 @@ static const struct k_clock clock_monotonic = {
 
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
@@ -1288,7 +1288,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_boottime,
+	.clock_get_timespec	= posix_get_boottime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index de5daa6d975a..b3cc9ee36a6b 100644
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
2.22.0

