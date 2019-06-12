Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB19442FE2
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfFLT0i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40683 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFLT0g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so18143827wre.7
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFdnPbzpSZSK/4mAaNh5+aPq3e9hZPhWR/XU6PmwusE=;
        b=JJ8+dvJfS/ecnrhETno4VpY88ZrLoU6ak2prXkCGE4Bagi8JtRLxOeljlXTru0bNvU
         KyOUXZcfa5OXMQcRkP0qjKNaoiCaMpHFXycxz6WDWgU1OlrHzEYL4UbqUW26Re2WO1ks
         nXLE248krnSKU+Qo/qQ/J0u2m+XLWDWEYjb2+m61vu6vUzN6rt+tTljyNRVyQhs8oO+/
         1HX1VHQAJSNP3s1gp2qZQTouYMKtL2b0xCera1dTG3DKgVv8gu+WIOgeYB8iBu7BGZpx
         Z/K8F/zurH66GdU2D/mgn4PDdG2rHTy2ObmZaMEGt4pjaRySyWVPib8MuV2bc190OriF
         1ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFdnPbzpSZSK/4mAaNh5+aPq3e9hZPhWR/XU6PmwusE=;
        b=HkrvDWlA93wnAfQdQ+Y/3hfk/3WcjBjq89rqmD1KrlZR8rR4A1wg5Gob87rtinFLwa
         TLDmW5x68gjPRvnS9nKzWwx5QPpixYndQFGHTE/kufzCDP0RW1pnnZ5SpJFthvoYwV6M
         +l0ndy/xeJ8x3clMoafTDXhTMteeMJ0bm2cQaS/hNymEq2RIQkpqAP8cYWRvdtOtEfkK
         AUjaP++vhxFWNyER1Mjsv+kjoTHpUhlcDNI/k5M2mRjpsvBhrt8mE/6Y+kjt3Nl9LHpf
         dCxq7TCvlhEHA86uF79CsozP9imPZQeJdCPueF0j59SHOejNkYeR6i1kMIdYR0RUUeGI
         Kxcw==
X-Gm-Message-State: APjAAAV90ayxlvTBPf0uME2tfNr4WRCA9RCqwYmlM7WIwp6qv7sVdqN6
        FiSbunF9mw/6AcLZDLMVsffo9Q==
X-Google-Smtp-Source: APXvYqz/0oT2cCaNHDEmFRp76dPBF9ZJDcLdOmVH6llx/wbWKtDK1i+0QJJn/r9BDjOqG/M8DKh0kw==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr54816046wrn.244.1560367594287;
        Wed, 12 Jun 2019 12:26:34 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:33 -0700 (PDT)
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
Subject: [PATCHv4 03/28] posix-clocks: add another call back to return clock time in ktime_t
Date:   Wed, 12 Jun 2019 20:26:02 +0100
Message-Id: <20190612192628.23797-4-dima@arista.com>
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

The callsite in common_timer_get() has already a comment:
        /*
         * The timespec64 based conversion is suboptimal, but it's not
         * worth to implement yet another callback.
         */
        kc->clock_get(timr->it_clock, &ts64);
        now = timespec64_to_ktime(ts64);

Now we are going to add time namespaces and we need to be able to get:
* clock value in a task time namespace to return it from the clock_gettime
  syscall.
* clock valuse in the root time namespace to use it in
  common_timer_get().

It looks like another reason why we need a separate callback to return
clock value in ktime_t.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/posix-timers.h   |  3 ++
 kernel/time/alarmtimer.c       | 24 ++++++++++---
 kernel/time/posix-clock.c      |  8 ++---
 kernel/time/posix-cpu-timers.c | 32 +++++++++---------
 kernel/time/posix-timers.c     | 61 ++++++++++++++++++++++------------
 kernel/time/posix-timers.h     |  7 ++--
 6 files changed, 87 insertions(+), 48 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index b20798fc5191..fe13ab265213 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -127,4 +127,7 @@ void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
 void posixtimer_rearm(struct kernel_siginfo *info);
+
+int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp);
+int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp);
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0519a8805aab..68a163c8b4f2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -43,6 +43,8 @@ static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
 	ktime_t			(*gettime)(void);
+	int			(*get_timespec)(const clockid_t which_clock,
+						struct timespec64 *tp);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -645,21 +647,30 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
 }
 
 /**
- * alarm_clock_get - posix clock_get interface
+ * alarm_clock_get_timespec - posix clock_get_timespec interface
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
  * Provides the underlying alarm base time.
  */
-static int alarm_clock_get(clockid_t which_clock, struct timespec64 *tp)
+static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
 
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->gettime());
-	return 0;
+	return base->get_timespec(base->base_clockid, tp);
+}
+
+static ktime_t alarm_clock_get_ktime(clockid_t which_clock)
+{
+	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
+
+	if (!alarmtimer_get_rtcdev())
+		return -EINVAL;
+
+	return base->gettime();
 }
 
 /**
@@ -825,7 +836,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
-	.clock_get		= alarm_clock_get,
+	.clock_get_ktime	= alarm_clock_get_ktime,
+	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_del		= common_timer_del,
@@ -870,8 +882,10 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].gettime = &ktime_get_real;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = posix_get_timespec,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].gettime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = posix_get_boottime_timespec;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
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
index 29176635991f..b6fcf6935204 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -165,12 +165,18 @@ static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 }
 
 /* Get clock_realtime */
-static int posix_clock_realtime_get(clockid_t which_clock, struct timespec64 *tp)
+static int
+posix_clock_realtime_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_real_ts64(tp);
 	return 0;
 }
 
+static ktime_t posix_clock_realtime_get_ktime(clockid_t which_clock)
+{
+	return ktime_get_real();
+}
+
 /* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
@@ -187,12 +193,17 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 /*
  * Get monotonic time for posix timers
  */
-static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
+int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
 	return 0;
 }
 
+static ktime_t posix_get_ktime(clockid_t which_clock)
+{
+	return ktime_get();
+}
+
 /*
  * Get monotonic-raw time for posix timers
  */
@@ -222,18 +233,28 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
+int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
 	return 0;
 }
 
-static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
+static ktime_t posix_get_boottime_ktime(const clockid_t which_clock)
+{
+	return ktime_get_boottime();
+}
+
+static int posix_get_tai_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_clocktai_ts64(tp);
 	return 0;
 }
 
+static ktime_t posix_get_tai_ktime(clockid_t which_clock)
+{
+	return ktime_get_clocktai();
+}
+
 static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 {
 	tp->tv_sec = 0;
@@ -645,7 +666,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -663,12 +683,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 			return;
 	}
 
-	/*
-	 * The timespec64 based conversion is suboptimal, but it's not
-	 * worth to implement yet another callback.
-	 */
-	kc->clock_get(timr->it_clock, &ts64);
-	now = timespec64_to_ktime(ts64);
+	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer move the
@@ -781,7 +796,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get() work.
+	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -1039,7 +1054,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	error = kc->clock_get(which_clock, &kernel_tp);
+	error = kc->clock_get_timespec(which_clock, &kernel_tp);
 
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
@@ -1121,7 +1136,7 @@ SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	err = kc->clock_get(which_clock, &ts);
+	err = kc->clock_get_timespec(which_clock, &ts);
 
 	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
@@ -1233,7 +1248,8 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_clock_realtime_get,
+	.clock_get_timespec	= posix_clock_realtime_get_timespec,
+	.clock_get_ktime	= posix_clock_realtime_get_ktime,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1250,7 +1266,8 @@ static const struct k_clock clock_realtime = {
 
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_ktime_get_ts,
+	.clock_get_timespec	= posix_get_timespec,
+	.clock_get_ktime	= posix_get_ktime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1265,22 +1282,23 @@ static const struct k_clock clock_monotonic = {
 
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
+	.clock_get_ktime	= posix_get_tai_ktime,
+	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1295,7 +1313,8 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_boottime,
+	.clock_get_ktime	= posix_get_boottime_ktime,
+	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index de5daa6d975a..ff227cd1bdbb 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -6,8 +6,11 @@ struct k_clock {
 				struct timespec64 *tp);
 	int	(*clock_set)(const clockid_t which_clock,
 			     const struct timespec64 *tp);
-	int	(*clock_get)(const clockid_t which_clock,
-			     struct timespec64 *tp);
+	/* return the clock value in the current time namespace. */
+	int	(*clock_get_timespec)(const clockid_t which_clock,
+				      struct timespec64 *tp);
+	/* return the clock value in the root time namespace. */
+	ktime_t	(*clock_get_ktime)(const clockid_t which_clock);
 	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
-- 
2.22.0

