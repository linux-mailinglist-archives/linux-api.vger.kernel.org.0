Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02E4F8649
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfKLB3J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:29:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53656 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfKLB2C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:28:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so1293329wmc.3
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McAHoFRaQr4I/ePxN9Ecr5ANGRTz4vDJr2KBvUQJ654=;
        b=RgbPhrM/lcB+YxbhLcozTVdFQqLupP8FUYHRuLoEQ/fHXE3KfE57exuxlEuyb9Bn6P
         sA2HtmstugP/zhEkNS3xGhUDj1oE/9AzQsGt5SjM47fVf3HidfXze2kzylp0KQNZPvG0
         0BolCt94PzOycW84XzNuXUhGbwBCHXklkepPojVY9X8j5iJzC7y6kF1XsDkakjrQl+5F
         w74ZBSH5xv2/XQ8D9bN7iZ6E95yJLrdsOAayfSbsHGt44UgpJBqigK5O7QWclNgNtisD
         XMBO6iBnC2sSv7pZvx09eWD+S3bvC4wftEe5r1A5MffPmr53OI8ahdYfrlk6s/OvjZIc
         8kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McAHoFRaQr4I/ePxN9Ecr5ANGRTz4vDJr2KBvUQJ654=;
        b=Uk/pMVfzbCpBSjSn4iOWe3arc/mdnt8KRlYOILXmYgP/C1WvgcZgZH31Au1J3gao8I
         YrTG8i2ElyWOZRL27N2guEh15YWs2V8EMke+2I2sSw86/uEpCoWdGWnS+3hD0WWrFQ7k
         mz4BcUor9+y0qI4ZPcfIQMfgPxWEpSrunmvgNEH4Op6elDhMv1qBG2vrr4bwuYM1DzV7
         RGj+Py4eBbj2cJD75+YPR+mmm3gZH2V5OJNpu7ISIotV+u4K2WLqDpxp888Xu8i6AlXH
         PxRWhtRyDeuYydSRikDTvBMWfQuIglPwkwrGdVBLdZVuKx/Rh2ns2KD9t6yZncxdJd4y
         jIkA==
X-Gm-Message-State: APjAAAVBa/U3swXDUZcpVnZD9zkZqNkDDYun9U3johf2hGENBgqaGUiA
        AiGnOhu1qS7/8Tm1nCccJZRkrg==
X-Google-Smtp-Source: APXvYqzzjGKhPMOLJb9JRqRDdS6+Sg4ie6ArD5NrMgxk04F0yAq9zvmJ7k9ldfV6PgEnTxUmi4AdeA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr1383935wmc.37.1573522078570;
        Mon, 11 Nov 2019 17:27:58 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:57 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv8 20/34] lib/vdso: Prepare for time namespace support
Date:   Tue, 12 Nov 2019 01:27:09 +0000
Message-Id: <20191112012724.250792-21-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To support time namespaces in the vdso with a minimal impact on regular non
time namespace affected tasks, the namespace handling needs to be hidden in
a slow path.

The most obvious place is vdso_seq_begin(). If a task belongs to a time
namespace then the VVAR page which contains the system wide vdso data is
replaced with a namespace specific page which has the same layout as the
VVAR page. That page has vdso_data->seq set to 1 to enforce the slow path
and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time
namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the vdso data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

If VDSO time namespace support is disabled the whole magic is compiled out.

Initial testing shows that the disabled case is almost identical to the
host case which does not take the slow timens path. With the special timens
page installed the performance hit is constant time and in the range of
5-7%.

For the vdso functions which are not using the sequence count an
unconditional check for vdso_data->clock_mode is added which switches to
the real vdso when the clock_mode is VCLOCK_TIMENS.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[Make do_hres_timens() work with raw clocks too: choose vdso_data
 pointer by CS_RAW offset.]
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time.h    |   6 ++
 include/vdso/datapage.h |  19 ++++-
 init/Kconfig            |   1 +
 lib/vdso/Kconfig        |   6 ++
 lib/vdso/gettimeofday.c | 152 ++++++++++++++++++++++++++++++++++++++--
 5 files changed, 178 insertions(+), 6 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 27d83fd2ae61..b1a592638d7d 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -96,4 +96,10 @@ static inline bool itimerspec64_valid(const struct itimerspec64 *its)
  */
 #define time_after32(a, b)	((s32)((u32)(b) - (u32)(a)) < 0)
 #define time_before32(b, a)	time_after32(a, b)
+
+struct timens_offset {
+	s64	sec;
+	u64	nsec;
+};
+
 #endif
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 2e302c0f41f7..65a38acce27e 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -21,6 +21,8 @@
 #define CS_RAW		1
 #define CS_BASES	(CS_RAW + 1)
 
+#define VCLOCK_TIMENS	UINT_MAX
+
 /**
  * struct vdso_timestamp - basetime per clock_id
  * @sec:	seconds
@@ -48,6 +50,7 @@ struct vdso_timestamp {
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
+ * @offset[clock_id]:	time namespace offset per clock_id
  * @tz_minuteswest:	minutes west of Greenwich
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
@@ -55,6 +58,17 @@ struct vdso_timestamp {
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
+ *
+ * @basetime is used to store the base time for the system wide time getter
+ * VVAR page.
+ *
+ * @offset is used by the special time namespace VVAR pages which are
+ * installed instead of the real VVAR page. These namespace pages must set
+ * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
+ * time namespace slow path. The namespace aware functions retrieve the
+ * real system wide VVAR page, read host time and add the per clock offset.
+ * For clocks which are not affected by time namespace adjustement the
+ * offset must be zero.
  */
 struct vdso_data {
 	u32			seq;
@@ -65,7 +79,10 @@ struct vdso_data {
 	u32			mult;
 	u32			shift;
 
-	struct vdso_timestamp	basetime[VDSO_BASES];
+	union {
+		struct vdso_timestamp	basetime[VDSO_BASES];
+		struct timens_offset	offset[VDSO_BASES];
+	};
 
 	s32			tz_minuteswest;
 	s32			tz_dsttime;
diff --git a/init/Kconfig b/init/Kconfig
index 5477f665c860..4d5162f1ad89 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1098,6 +1098,7 @@ config UTS_NS
 
 config TIME_NS
 	bool "TIME namespace"
+	depends on GENERIC_VDSO_TIME_NS
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 9fe698ff62ec..d883ac299508 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -24,4 +24,10 @@ config GENERIC_COMPAT_VDSO
 	help
 	  This config option enables the compat VDSO layer.
 
+config GENERIC_VDSO_TIME_NS
+	bool
+	help
+	  Selected by architectures which support time namespaces in the
+	  VDSO
+
 endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9923e1eab9db..8107e07f9b82 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,15 +38,96 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
+#ifdef CONFIG_TIME_NS
+static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+		      struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_timestamp *vdso_ts;
+	const struct timens_offset *offs = &vdns->offset[clk];
+	u64 cycles, last, ns;
+	u32 seq, msk;
+	s64 sec;
+
+	msk = 1U << clk;
+	if (msk & VDSO_HRES)
+		vd = &vd[CS_HRES_COARSE];
+	else if (msk & VDSO_RAW)
+		vd = &vd[CS_RAW];
+	else
+		return -1;
+	vdso_ts = &vd->basetime[clk];
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode);
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return -1;
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	ns += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+#else
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return NULL;
+}
+
+static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+		      struct __kernel_timespec *ts)
+{
+	return -EINVAL;
+}
+#endif
+
 static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
-		   struct __kernel_timespec *ts)
+				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	u64 cycles, last, sec, ns;
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vd);
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. Time namespace
+		 * enabled tasks have a special VVAR page installed which
+		 * has vd->seq set to 1 and vd->clock_mode set to
+		 * VCLOCK_TIMENS. For non time namespace affected tasks
+		 * this does not affect performance because if vd->seq is
+		 * odd, i.e. a concurrent update is in progress the extra
+		 * check for vd->clock_mode is just a few extra
+		 * instructions while spin waiting for vd->seq to become
+		 * even again.
+		 */
+		while (1) {
+			seq = READ_ONCE(vd->seq);
+			if (likely(!(seq & 1)))
+				break;
+			if (IS_ENABLED(CONFIG_TIME_NS) &&
+			    vd->clock_mode == VCLOCK_TIMENS)
+				return do_hres_timens(vd, clk, ts);
+			cpu_relax();
+		}
+		smp_rmb();
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
@@ -68,14 +149,63 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+static void do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+			 struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	const struct timens_offset *offs = &vdns->offset[clk];
+	u64 nsec;
+	s64 sec;
+	s32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		sec = vdso_ts->sec;
+		nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	nsec += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+}
+#else
+static void do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+			 struct __kernel_timespec *ts) {}
+#endif
+
 static __always_inline void do_coarse(const struct vdso_data *vd, clockid_t clk,
-		      struct __kernel_timespec *ts)
+				      struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vd);
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. See comment in
+		 * do_hres().
+		 */
+		while (1) {
+			seq = READ_ONCE(vd->seq);
+			if (likely(!(seq & 1)))
+				break;
+			if (IS_ENABLED(CONFIG_TIME_NS) &&
+			    vd->clock_mode == VCLOCK_TIMENS) {
+				do_coarse_timens(vd, clk, ts);
+				return;
+			}
+			cpu_relax();
+		}
+		smp_rmb();
+
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
@@ -160,6 +290,10 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 	}
 
 	if (unlikely(tz != NULL)) {
+		if (IS_ENABLED(CONFIG_TIME_NS) &&
+		    vd->clock_mode == VCLOCK_TIMENS)
+			vd = __arch_get_timens_vdso_data();
+
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
 	}
@@ -171,7 +305,12 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 static __maybe_unused time_t __cvdso_time(time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	time_t t;
+
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data();
+
+	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
@@ -193,6 +332,9 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	if (unlikely((u32) clock >= MAX_CLOCKS))
 		return -1;
 
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data();
+
 	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
-- 
2.24.0

