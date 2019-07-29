Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAD79C02
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfG2V6X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33225 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfG2V6X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so63569082wru.0
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5fNHGKrtYyQ4hfdzT0liaJu2rBvdvAZGs0hrh0PW8vk=;
        b=gk8acHSxAp1IHneLzg0GntOlQ1xc3FsUKllc/4QpuOUOLzvP1NStI+tQ9k3k8XC6w2
         GrSp6gSpxU6Svx2RPhjGJw7jbrZqHiDykvT0Pof7cxXvz0AmL5nUHZM/FOTC/k2LouEY
         /l9GT4u36q2lT2urZtfiH3W2T8inOkkVi5sVWphM5mdzktPd3tWpvdg1+1G44LdI65xO
         3Xgjo5cBq/d0yFCeZJh+1g8EvAbqI/wyNcz3+s8dwbEAzKkm24vNtDQNwT9h9qYi8ZUZ
         HptSGSG8kZ+V33caxXlz1piDKoPOmFLx9FrFlcu46f/aLWjX6TVpsPaWlhBqgGkCjSFE
         kp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fNHGKrtYyQ4hfdzT0liaJu2rBvdvAZGs0hrh0PW8vk=;
        b=Gb1ABha+r84/pTqWFnJ/Gfzy7v25MBNVlG0soz8RASEW+Y3V+Lb4A5HNL/LVIAmlKD
         1DlUfXQmchOfCmbAh142hIR0xYo/zIitVaa7r7uj45OxBoCCFxdtssePmxARJ5V/qU8E
         70y1DYF5WJ/OxSTfZ0JUV5JLXK8toVLX0Bp/S5A4hZhUTOizIctp+lCbdYS7i8rBO4gG
         RaraS4Aw7FHd1xg4rLlKTFAsi84cw3XJBFLmXA/z2XSvJ4UKzziftgl8bCBO9UxOPxL1
         YoueMZ1qmMLJaamt5Tx/UUtN8JhsbepDdvdzX+nQRA0HKTvuWPf43T7oKnX9Alv0TS8d
         aYIw==
X-Gm-Message-State: APjAAAWLAR7t0/8vWG+6e5H3Zv7H4oYhu8wH1q53f6HVkCa+Klb7rD19
        Q2VP/bBIcOzn48S/DHZf2b1xUdcRloMxyo1/F0vmRMP2RSzeMiIAozhjfiUSwJtGTPSEJVi5k9Q
        1knGnVqFTzxfM8LjvWaDlQ/vcNaxsVoHVmEFrcb3Lxy6uQ6774XvtwVbjUFsRHXm26KR525StQY
        7hQJrJ4xeIUZnVaFv9Va/PGxJoEA==
X-Google-Smtp-Source: APXvYqyYK9fQgpnFWfxFBTucWDklwF9Z+aLUzbTMb7xKPg7fA80MEKrgyR/hUhInjTgAmLUAasM6Cw==
X-Received: by 2002:adf:f812:: with SMTP id s18mr52239162wrp.32.1564437500898;
        Mon, 29 Jul 2019 14:58:20 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:20 -0700 (PDT)
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
Subject: [PATCHv5 15/37] hrtimers: Prepare hrtimer_nanosleep() for time namespaces
Date:   Mon, 29 Jul 2019 22:56:57 +0100
Message-Id: <20190729215758.28405-16-dima@arista.com>
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

clock_nanosleep() accepts absolute values of expiration time when
TIMER_ABSTIME flag is set. This absolute value is inside the task's
time namespace, and has to be converted to the host's time.

There is timens_ktime_to_host() helper for converting time, but
it accepts ktime argument.

As a preparation, make hrtimer_nanosleep() accept a clock value in ktime
instead of timespec64.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/hrtimer.h   | 2 +-
 kernel/time/hrtimer.c     | 8 ++++----
 kernel/time/posix-stubs.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4971100a8cab..3285d75b5a0f 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -459,7 +459,7 @@ static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 /* Precise sleep: */
 
 extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
-extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
+extern long hrtimer_nanosleep(ktime_t rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5ee77f1a8a92..b67927c65410 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1716,7 +1716,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-long hrtimer_nanosleep(const struct timespec64 *rqtp,
+long hrtimer_nanosleep(ktime_t rqtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
@@ -1729,7 +1729,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 		slack = 0;
 
 	hrtimer_init_on_stack(&t.timer, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -1764,7 +1764,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
 #endif
@@ -1784,7 +1784,7 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&tu, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(timespec64_to_ktime(tu), HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 #endif
 
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index edaf075d1ee4..2ccefc9ce184 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -147,7 +147,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -233,7 +233,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(&t, flags & TIMER_ABSTIME ?
+	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
-- 
2.22.0

