Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4979BDF
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfG2V7l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:59:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfG2V7D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:59:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so60262727wrm.8
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWONBeyHUFeuP9HeVP1feg7kja/FCo25UXl44Sqb+Bw=;
        b=jSvASoXftlylJJpx1NtrZZXOX0C76DZ87P11B/KaD1UjLkgkcN2kunxvV9Zk67PjLV
         S7xSCNZa7dmvaxwt4bWvH9bq/Dg9FZuCEZIJxHYR/ItFOzutchtBUwt6ctCkjq4Kjm6j
         2MA1w7y8BXC0V2WyTz2IBcjAsnIlTtKwZGYNPPE7PJ6sKOBQH0EHavils7zsYE/PldYH
         /SVuaIS6aqeNuWEZcCmgM/Kva73yh3l1sx5azmWCYvzc9wbWERqiAPwqQ9baa+ktLuNm
         CCu2I9/WJCa6vd200RSFgnAyzjoZhhv92OuMBLFpKsMYqRZ0zj+0Pu8LZDpyOB1LKosj
         S/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWONBeyHUFeuP9HeVP1feg7kja/FCo25UXl44Sqb+Bw=;
        b=hvE+ZwcFMALlwCGbv5wOqT26l9yNibIe3vbnIE6RRRmiNJ6O+bsT97yOugWZxxuBFc
         4kpn4Zn+Rko96La98j5FMvcYoTbURw2+hX0YyoQjAHiZogjW3jQ/5ealWt7Gb662cdBv
         pajfVIW5wwagpuqJaHIEc/iRWVTRY7GfF0BId+otpwqDWd5b+2jf23//bNbnlezZikDq
         JYUlAqgEyCua0kCQqz869nxMM1RaDNWrgFdUOrefUUauF6E8Hwp9PQudEuhs6MX5t0BX
         pBaqfoj9rshBRVGFdCxPsx+pA5LdiBZy6enU0av7QcYV7AKSOtMeHDUJMdW6yokAWD7D
         bj/g==
X-Gm-Message-State: APjAAAWx4b1JjHenTN7r1LbE5cTrwb/SzmoeR1ZPwNH/l9JQvLTyXhIC
        DKuClkn8mP9i9COa0jM6PKbSubx+ULLn3SaqWdvDZTGJjEsH2IpN6x4Jmpj785k88JUNB8Dp2vf
        hL5gNzHgES8qGZFk3NXAzOp9y+qaa6YdZanudhbIfRd0BQKzWuCqKWWjnNZEN4wtVuPXhqnO940
        sup7KVg/shwiEEDKIKco1oFazblg==
X-Google-Smtp-Source: APXvYqzMuAVSNsMyux+KKYFNLn0ZfQnWJtfVyckKX2TZp0onf8iwQbGIUGB1hkkSPA3GzfvPpoGvOg==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr128233610wrj.283.1564437541606;
        Mon, 29 Jul 2019 14:59:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:01 -0700 (PDT)
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
Subject: [PATCHv5 06/37] alarmtimer: Provide get_timespec() callback
Date:   Mon, 29 Jul 2019 22:57:26 +0100
Message-Id: <20190729215758.28405-45-dima@arista.com>
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

Wire up alarm bases with get_timespec().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/posix-timers.h | 3 +++
 kernel/time/alarmtimer.c     | 8 ++++++--
 kernel/time/posix-timers.c   | 4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

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
index 37254eb64459..d9e6baa9976a 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -37,12 +37,15 @@
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
+ * @get_timespec:	Function to read the namespace time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
 	ktime_t			(*get_ktime)(void);
+	int			(*get_timespec)(const clockid_t which_clock,
+						struct timespec64 *tp);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -657,8 +660,7 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->get_ktime());
-	return 0;
+	return base->get_timespec(base->base_clockid, tp);
 }
 
 /**
@@ -869,8 +871,10 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_timespec = posix_get_timespec,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = posix_get_boottime_timespec;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a71e43178a7d..a600b8b3e9bf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -188,7 +188,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 /*
  * Get monotonic time for posix timers
  */
-static int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
+int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
 	return 0;
@@ -223,7 +223,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 	return 0;
 }
 
-static int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
+int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
 	return 0;
-- 
2.22.0

