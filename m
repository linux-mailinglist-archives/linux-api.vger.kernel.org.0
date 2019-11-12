Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAFF863D
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfKLB1u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51976 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKLB1q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so1308611wme.1
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vvXJtBtRcAlCgq+EpTVtXS7271TSerNXee1+6F33Z4=;
        b=Z14bUDSn3luy1hN0Ab2jn9g+Csxxd1Qorqfn11+on3xsZKx746xnS8Bs1iGEJxtVcH
         UrIeQSUCcatMWTpTiQnEfooCl/oPhqI3zNZwUWB0Nsa4rYceeMlO43cGbykXI2ZZG58w
         RLFhuuObRjGbOKcrgXFp/B2R5kRJZ9pQ9GtFLiQc+kN2wHkakLPatO3vcbS3wyGTmuQX
         i1Ohs90npH1dPHE1SO9NFGnA+SbRY2kL8X8Ah+bNiSrFqyA9zryzH5tjDnhKkKvAJwep
         AOnRQHd0D5+4Rw08/YYBi4twZmpOhxBxaZCOOdHcfeja1Cb6d2bH8DOLI2kyGG90apiS
         liHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vvXJtBtRcAlCgq+EpTVtXS7271TSerNXee1+6F33Z4=;
        b=uQfwDqrlR3hF67br6yCAJWrYhk5yI+V3Ld+Ik4sILTZtq0IfOCyCBSsj5ngpjwZCWQ
         Mhi4JZLa6TYpZ0HrXWFDQPCheRzVS74kNUU928N34/0lTHnQ7ZdcyoK0+G8WpSvE1YTf
         djUNku1G2KNc3aWbKEjVfFO1oiwAGv9BK2V+gFQZy9bDs/HLvBb5gBOFbZv+v/53MO9l
         9i6ye57yNo6uL/xcaQSZ/rFdb8fEfQElrwUD6d8xupI6ACAIhY6QMZJq82hOOic7EkOF
         TbwVbGqFD0B6Hia+gPmjcC1Z5LNtjW3wENzJRmxynHtSRyE4xZCiyYYHvhlg/tr+ev2P
         zjaQ==
X-Gm-Message-State: APjAAAUFCE82RhLdbT320Wf/hug72W3FCPnLQdOeEsdEYOw3W3fSOEse
        +IiQ0AJjVBj1JXxfqVkm9pwr3w==
X-Google-Smtp-Source: APXvYqwo7vpduJI23T2q+gjJBeCbCxzk9pcgiMuB6XdL2NbQFBZNpyS64pJIwNFwBMGnydhwDV+Qag==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr1609197wmc.130.1573522063778;
        Mon, 11 Nov 2019 17:27:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:43 -0800 (PST)
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
Subject: [PATCHv8 09/34] posix-clocks: Introduce clock_get_ktime() callback
Date:   Tue, 12 Nov 2019 01:26:58 +0000
Message-Id: <20191112012724.250792-10-dima@arista.com>
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

The callsite in common_timer_get() has already a comment:
    /*
     * The timespec64 based conversion is suboptimal, but it's not
     * worth to implement yet another callback.
     */
    kc->clock_get(timr->it_clock, &ts64);
    now = timespec64_to_ktime(ts64);

The upcoming support for time namespaces requires to have access to:
- The time in a task's time namespace for sys_clock_gettime()
- The time in the root name space for common_timer_get()

That adds a valid reason to finally implement a separate callback which
returns the time in ktime_t format.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   | 19 ++++++++++++++++++-
 kernel/time/posix-timers.c | 26 +++++++++++++++++++++++++-
 kernel/time/posix-timers.h |  3 +++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 357be1fe6e1f..4d8c90546635 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -663,7 +663,7 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
- * Provides the underlying alarm base time.
+ * Provides the underlying alarm base time in a tasks time namespace.
  */
 static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
@@ -677,6 +677,22 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	return 0;
 }
 
+/**
+ * alarm_clock_get_ktime - posix clock_get_ktime interface
+ * @which_clock: clockid
+ *
+ * Provides the underlying alarm base time in the root namespace.
+ */
+static ktime_t alarm_clock_get_ktime(clockid_t which_clock)
+{
+	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
+
+	if (!alarmtimer_get_rtcdev())
+		return -EINVAL;
+
+	return base->get_ktime();
+}
+
 /**
  * alarm_timer_create - posix timer_create interface
  * @new_timer: k_itimer pointer to manage
@@ -840,6 +856,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
+	.clock_get_ktime	= alarm_clock_get_ktime,
 	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 68d4690cc225..a1f6b968c5d8 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -171,6 +171,11 @@ static int posix_get_realtime_timespec(clockid_t which_clock, struct timespec64
 	return 0;
 }
 
+static ktime_t posix_get_realtime_ktime(clockid_t which_clock)
+{
+	return ktime_get_real();
+}
+
 /* Set clock_realtime */
 static int posix_clock_realtime_set(const clockid_t which_clock,
 				    const struct timespec64 *tp)
@@ -193,6 +198,11 @@ static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64
 	return 0;
 }
 
+static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
+{
+	return ktime_get();
+}
+
 /*
  * Get monotonic-raw time for posix timers
  */
@@ -228,12 +238,22 @@ static int posix_get_boottime_timespec(const clockid_t which_clock, struct times
 	return 0;
 }
 
+static ktime_t posix_get_boottime_ktime(const clockid_t which_clock)
+{
+	return ktime_get_boottime();
+}
+
 static int posix_get_tai_timespec(clockid_t which_clock, struct timespec64 *tp)
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
@@ -781,7 +801,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get_timespec() work.
+	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -1262,6 +1282,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_realtime_timespec,
+	.clock_get_ktime	= posix_get_realtime_ktime,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1280,6 +1301,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_monotonic_timespec,
+	.clock_get_ktime	= posix_get_monotonic_ktime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1310,6 +1332,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_tai_ktime,
 	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
@@ -1326,6 +1349,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 070611b2c253..f32a2ebba9b8 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -6,8 +6,11 @@ struct k_clock {
 				struct timespec64 *tp);
 	int	(*clock_set)(const clockid_t which_clock,
 			     const struct timespec64 *tp);
+	/* Returns the clock value in the current time namespace. */
 	int	(*clock_get_timespec)(const clockid_t which_clock,
 				      struct timespec64 *tp);
+	/* Returns the clock value in the root time namespace. */
+	ktime_t	(*clock_get_ktime)(const clockid_t which_clock);
 	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
-- 
2.24.0

