Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF08F0FD
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfHOQjD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39394 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbfHOQjC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so2765478wra.6
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A++qkU2LSGgfXs6UE6u7P02O03tykCF0hhZRPVNpZoY=;
        b=gALHslAjor1eT1GcAdzPzmnnc5FtceVDPT0zzDZYHuRlZ43JHqJHPUYrr+jpU5KzNb
         WB5g6E5KcphqenYFe9LeQS1QJMu9Ifd+a31x3UbNSedEykcqnsUHMVD4Tms0DbEP2v0N
         ykIt1imgws1+mcydxUuWzDEBAyFhuwPeStlHJsiAwUQSipu9zRHGeju4gS2ScATz1ZOB
         hMaLMRQ8RC/bSlBdMpJeLPYkDZP04vHOLIf0e1u59YAwjsC0KpynvY739iEjICpva/3O
         2hz1GqNJRoXjq7UbgCKV+8t9m5L2cP6z3OKqUXiPjNd7aoYn0pjrVKdzWyeSAHyQT2v6
         jc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A++qkU2LSGgfXs6UE6u7P02O03tykCF0hhZRPVNpZoY=;
        b=K5uJYOfs0ofnhNC4OBdCYOAOXmNCiniQn7uNwZctRukbnK1agCA/CTcZWP3hiFBDpa
         kaKYdN6aPFGhP3jVZOLmyl8DwL9Iz7HZdo9onZDYTH1+yeRlmVTqlDrhCXDcFamPWJzh
         eaiMbSAUqZNXoKLNUjz0XHLyEouLjmUy6HYlQRo8hF+i8ooHLMnsE+5MnEVLNvRU/wmr
         MUle/CaS+qZJP+fK0j0MP+uXQR7p3/DzdNAOy7mNOrM5t69rk1Rg9BM1VuSXFPzu6ryA
         7amQfbEayWNDPOGPa0HUp9uucw4C6tno5ciQgkF0COrj5g4y8qB51PIKUt9PBfy2BZPE
         9M/g==
X-Gm-Message-State: APjAAAXMIiBat8E7DR7E+oB97mKsqcRBC21xcmmN5aUFLRdDciC4ogGH
        qqPi+GmAX4e+IJm+mjGJNo47qQ==
X-Google-Smtp-Source: APXvYqzu+XjBZgtwLWrc/pJ12jpcPn2mC6kXQEsFK38AEgezWEeMLERTRQUs5JLZbS5DExBylT7pvg==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr6182306wrg.325.1565887139891;
        Thu, 15 Aug 2019 09:38:59 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:59 -0700 (PDT)
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
Subject: [PATCHv6 15/36] posix-timers: Make clock_nanosleep() time namespace aware
Date:   Thu, 15 Aug 2019 17:38:15 +0100
Message-Id: <20190815163836.2927-16-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

clock_nanosleep() accepts absolute values of expiration time, if the
TIMER_ABSTIME flag is set. This value is in the task time namespace,
which has to be converted to the host time namespace.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-stubs.c  | 12 ++++++++++--
 kernel/time/posix-timers.c | 21 ++++++++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

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
index 1f30e3ef0918..c71eedd17c94 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1227,7 +1227,22 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 const struct timespec64 *rqtp)
 {
-	return hrtimer_nanosleep(rqtp, flags & TIMER_ABSTIME ?
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
+}
+
+static int common_nsleep_timens(const clockid_t which_clock, int flags,
+			 const struct timespec64 *rqtp)
+{
+	ktime_t texp = timespec64_to_ktime(*rqtp);
+
+	if (flags & TIMER_ABSTIME)
+		texp = timens_ktime_to_host(which_clock, texp);
+
+	return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
 				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
 				 which_clock);
 }
@@ -1308,7 +1323,7 @@ static const struct k_clock clock_monotonic = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_timespec	= posix_get_monotonic_timespec,
 	.clock_get_ktime	= posix_get_monotonic_ktime,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
@@ -1355,7 +1370,7 @@ static const struct k_clock clock_boottime = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get_ktime	= posix_get_boottime_ktime,
 	.clock_get_timespec	= posix_get_boottime_timespec,
-	.nsleep			= common_nsleep,
+	.nsleep			= common_nsleep_timens,
 	.timer_create		= common_timer_create,
 	.timer_set		= common_timer_set,
 	.timer_get		= common_timer_get,
-- 
2.22.0

