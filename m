Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12679C1A
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfG2WB7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:01:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56105 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389107AbfG2V6L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so55189980wmj.5
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lH88XV9r6cFcrzQoc1UDCcNiRR0jvPMk1+ATCF2kgD4=;
        b=fLLG33Ll5ETOUiUrN2/uD/jJzTVMVVXzaP2+CoAncFBVc1C7jSevOZGmvkKK6+A+6z
         DYke42Dm7tsLPiUxgElDFKXLnbKenqhGB7O8+KBFSZPOxLmxihrzbdut39G201RfBAne
         hLlzdzMEGjhS1bAur8EaYtyvh7exQMZpBem9NhW9esKPis//ePlbP8UkH1arTKEByfA2
         TxtK3IoM9Hj4oLSNRNPT9HgkrhL4WfCgp+BlymcvBcIXPG3hbehMP8fwqtg09LLStTSv
         C0dF4ZPrG3hhb3cBhyanraqDula0liKcWPGai5H5R7ww+Yh5gRb445KypUUi1aQpZ1r2
         IEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lH88XV9r6cFcrzQoc1UDCcNiRR0jvPMk1+ATCF2kgD4=;
        b=XYIZQZckNfTmxc98w7v4nlnqKBA/bypfQsYD3gDF7JBEnnpkPH9szx7vyebKLD24RL
         xmhgc8phX1nckyli+iTJ3u6qaN1v4Ul+w56ObODJhBqiaZzvbKy4dKcMyOCvhO1q7T/V
         v6lp+EWaChtm9YLZv27UTYETeq6iBtDA8Ruvaw3DAdsPh5Vwsmg19lxflnbxF7LoPruN
         LunWJs3MCIS/AkEOV3hvcZWo6u8gV7lIGi+z1Jw6yTObOueehaPp/PgW2CkF8Vx/jQpe
         2vEqgDGWURtO8XAbBDC/HQTZ4Zbcvvk+uINGOoSx+PdhKx14nmco0D7zm1rW7aNPCINe
         ODbQ==
X-Gm-Message-State: APjAAAX8EVOmbW09WQ7WDmZjZYQ6dNBqnpAD6JGuyfduERAb2Z37xkpN
        B7u5Pjocfc+jmbBu/+In87DEwbXM2aCzqkmNq10Kp159d+/xmNlyEJegaG+zAD+7KywLRpfwfRC
        DJb7TVQ5+OIJV/KyZ2CIdqLL641ysU+8ZQdv4qYmp6SpgPMPUnYYHU1AnYP8r4b9pI/fjPL3JYr
        CyDqExpD10mYKuGLqaEaT0YaryjQ==
X-Google-Smtp-Source: APXvYqyiywAG/zqRaIbMOINOID/8sHjuyDu9E7DftuqlKKoMdgk/cDOPLRzk1Bxpy0rxZOzSvYF56w==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr40124142wmc.75.1564437489959;
        Mon, 29 Jul 2019 14:58:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:09 -0700 (PDT)
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
Subject: [PATCHv5 07/37] posix-clocks: Introduce clock_get_ktime() callback
Date:   Mon, 29 Jul 2019 22:56:49 +0100
Message-Id: <20190729215758.28405-8-dima@arista.com>
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
index d9e6baa9976a..55cb6e78d082 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -651,7 +651,7 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
  * @which_clock: clockid
  * @tp: timespec to fill.
  *
- * Provides the underlying alarm base time.
+ * Provides the underlying alarm base time in a tasks time namespace.
  */
 static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
@@ -663,6 +663,22 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	return base->get_timespec(base->base_clockid, tp);
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
@@ -826,6 +842,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 
 const struct k_clock alarm_clock = {
 	.clock_getres		= alarm_clock_getres,
+	.clock_get_ktime	= alarm_clock_get_ktime,
 	.clock_get_timespec	= alarm_clock_get_timespec,
 	.timer_create		= alarm_timer_create,
 	.timer_set		= common_timer_set,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a600b8b3e9bf..fb1848c84241 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -172,6 +172,11 @@ posix_clock_realtime_get_timespec(clockid_t which_clock, struct timespec64 *tp)
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
@@ -194,6 +199,11 @@ int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
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
@@ -229,12 +239,22 @@ int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *
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
@@ -782,7 +802,7 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 	 * Posix magic: Relative CLOCK_REALTIME timers are not affected by
 	 * clock modifications, so they become CLOCK_MONOTONIC based under the
 	 * hood. See hrtimer_init(). Update timr->kclock, so the generic
-	 * functions which use timr->kclock->clock_get_timespec() work.
+	 * functions which use timr->kclock->clock_get_*() work.
 	 *
 	 * Note: it_clock stays unmodified, because the next timer_set() might
 	 * use ABSTIME, so it needs to switch back.
@@ -1228,6 +1248,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 static const struct k_clock clock_realtime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_clock_realtime_get_timespec,
+	.clock_get_ktime	= posix_clock_realtime_get_ktime,
 	.clock_set		= posix_clock_realtime_set,
 	.clock_adj		= posix_clock_realtime_adj,
 	.nsleep			= common_nsleep,
@@ -1245,6 +1266,7 @@ static const struct k_clock clock_realtime = {
 static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_timespec,
+	.clock_get_ktime	= posix_get_ktime,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
@@ -1274,6 +1296,7 @@ static const struct k_clock clock_monotonic_coarse = {
 
 static const struct k_clock clock_tai = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_tai_ktime,
 	.clock_get_timespec	= posix_get_tai_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
@@ -1289,6 +1312,7 @@ static const struct k_clock clock_tai = {
 
 static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
 	.nsleep			= common_nsleep,
 	.timer_create		= common_timer_create,
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index b3cc9ee36a6b..183994f7e466 100644
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
2.22.0

