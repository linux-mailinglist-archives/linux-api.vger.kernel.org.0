Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B403D36F3
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfJKBYL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37049 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfJKBYK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so9960127wro.4
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKMvh3TVCiPMPLUBrZ3DHVUeq/BZpRss8YldgguRDNM=;
        b=m7aym05tTiVEW8U1ykPTY+A/LOE4gvvek69lIq/4PpKGDPfT3+/Kt+ZpetJnkh1YGd
         7XM3EdcLTNR+BmjKy8hQQLLADfjPPjJYtbMjWTSc60pPhhOygzO4lRJefAEufF8u2tj+
         Zo4rvanU/aEaHbTL+jTfxuNz6I4QLLLpo/QREZYctp6NPL+z9j0rtsqfJRtbubHAk/B1
         /U9IqwzC2QsLFdVf8NTGGTG9VqlZpXa3JGi4Kmuid763iykAUaCvhZQhUHaxU79PZxRe
         qlX0rHeHw44k4bqyvFX2+4o9OL5AUrVYT+CRgHM0iUyY7WvEQnoZuH6H4bsg2etUgNMA
         peFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKMvh3TVCiPMPLUBrZ3DHVUeq/BZpRss8YldgguRDNM=;
        b=Xa00Sxmsyjn5V6LV1fxkeOZHjJ4h1i+UJ1srYg6U1UvRyGSHLDnpvDDvRPd2uCXUfq
         W0az+JSSW+tc3Mo8nttUaNPoSdB0yv9VoY0hsJPVrRFQfX2CNUWdOb8is855M/1gvzzH
         rf1ndk2mZOpU6SWJ3/Oz9bplbeIslUeVDe5kQi/9zwoxhI9yOKlixTnTVAR14uKAgfYP
         G0NvmAoNcOBDNSyHvdntmcOGj9pQV/QFrF0XRygxw9mgSZRzIF92kS6Vbcyfe8iMsEpB
         4OsqFWIzer+Ig4dibQd323ostna1gk9lvhpbfLhmE2ggH3AnpnnIJEXUjW3svhLs5UB6
         4K0w==
X-Gm-Message-State: APjAAAVxwspfSDLouE7adr/X+U9ygpQ2Y32tAHX+Tuxc50mup+vjmSWH
        Ml+J4sOOvb3pyUbotkmrLBHFkQ==
X-Google-Smtp-Source: APXvYqw4a04uZei2tOzW3S+dsdzWXGmB8SvL6s8OUzgP0pHH3Ux+4fpM/CZNoPFzdba5emQeKfZbbg==
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr10189124wrw.32.1570757047992;
        Thu, 10 Oct 2019 18:24:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv7 15/33] posix-timers: Make clock_nanosleep() time namespace aware
Date:   Fri, 11 Oct 2019 02:23:23 +0100
Message-Id: <20191011012341.846266-16-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

clock_nanosleep() accepts absolute values of expiration time, if the
TIMER_ABSTIME flag is set. This value is in the task time namespace,
which has to be converted to the host time namespace.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-stubs.c  | 12 ++++++++++--
 kernel/time/posix-timers.c | 17 +++++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 2ccefc9ce184..47ee2684d250 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -129,6 +129,7 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		struct __kernel_timespec __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime_t texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -147,7 +148,10 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
 	current->restart_block.nanosleep.rmtp = rmtp;
-	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(clockid, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -215,6 +219,7 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 t;
+	ktime texp;
 
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -233,7 +238,10 @@ SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
 		rmtp = NULL;
 	current->restart_block.nanosleep.type = rmtp ? TT_COMPAT : TT_NONE;
 	current->restart_block.nanosleep.compat_rmtp = rmtp;
-	return hrtimer_nanosleep(timespec64_to_ktime(t), flags & TIMER_ABSTIME ?
+	texp = timespec64_to_ktime(t);
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(clockid, texp);
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index c0ae1f6d2add..ccae99a645e1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1228,6 +1228,19 @@ static int common_nsleep(const clockid_t which_clock, int flags,
 				 which_clock);
 }
 
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
+}
+
 SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 		const struct __kernel_timespec __user *, rqtp,
 		struct __kernel_timespec __user *, rmtp)
@@ -1305,7 +1318,7 @@ static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_monotonic_timespec,
 	.clock_get_ktime	= posix_get_monotonic_ktime,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1354,7 +1367,7 @@ static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
-- 
2.23.0

