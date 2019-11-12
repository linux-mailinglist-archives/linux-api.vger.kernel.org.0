Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC9F8634
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfKLB2n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:28:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50904 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfKLB2O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:28:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so1316033wmh.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJBQklbdth4fIqy8cKhdwCD9F1vJaIAaANn9KZEbUtM=;
        b=i364+MmtGbU6vHOHLHon5GH22AObDEt7OrTi9/xpukajG+W+pbZuHGMjtJ1gccfpJr
         fLzyGOAPbaXUVwJXPrbKrhB03z4T5tJlrZ+n23YliKYQvjqBGW+HoJg8qbRXjba+nF/w
         wASLTAlqUMMQeH5AjsqYnQncc6tEp8ttKb3KeU9Pm3B/qFbkjubirOdZ65z4KPw6DHH6
         S9KaVVKXNTu35HDyF/adWobkw2zoBeA9Dax+gZ0K6yzvn1qxDQYD7Ld+PyiLvsElH0oc
         aKwb9LoTYt4IDPTzpWVx62AmbfTfVh+kfSYkMaab6zeKw0SRS7A2bxdWVY4gNMrIBQNM
         bYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJBQklbdth4fIqy8cKhdwCD9F1vJaIAaANn9KZEbUtM=;
        b=GXcivKDHqiqV8hW774V7Su4Ly7zYqgkefCnZWnSD0RP7acR1k2XQXPZffhV7MOssyr
         OGOVsJ9hAL1BJ1MEtRzskOPv39c4iiymBPL6Y2ShaIjnuaenYiqWmg0nfpKqY1QIm7El
         gZBmBpeKnJTvRlCQIUkY6QOAghuWgTzsXfKS0EgCetlFV3sbgb4itJ7AIvD034KFBvay
         o3Qe/WAWfLC3m3TeHW+HzYPTXd91weI9dl/ZAN9EOV3645uN832JiVmd8/NB1T45rkKc
         DB+DraF4BG+blgaC/wl9atFWJ/pJL7OeoqgJD2+7YnvrQepQHRK/oxo6KIBwuNKuMaVS
         yFeA==
X-Gm-Message-State: APjAAAXvkCiiPQIS218f2jblmwe7OTymVvsO/JmI5K4+zYgZ1WYedCEV
        Qw3FURvsiwtMV8HgOeMvBgEvSg==
X-Google-Smtp-Source: APXvYqxHI1ovecMhGzQ9G3ozKPftNon5uLRyzoO2hY8YPQU6LMdHhctX2uNvUvbfBExFSpUsyaXlOg==
X-Received: by 2002:a1c:48f:: with SMTP id 137mr1644088wme.68.1573522092232;
        Mon, 11 Nov 2019 17:28:12 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:11 -0800 (PST)
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
Subject: [PATCHv8 30/34] selftests/timens: Add a test for clock_nanosleep()
Date:   Tue, 12 Nov 2019 01:27:19 +0000
Message-Id: <20191112012724.250792-31-dima@arista.com>
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

Check that clock_nanosleep() takes into account clock offsets.

Output on success:
 1..4
 ok 1 clockid: 1 abs:0
 ok 2 clockid: 1 abs:1
 ok 3 clockid: 9 abs:0
 ok 4 clockid: 9 abs:1

Output with lack of permissions:
 1..4
 not ok 1 # SKIP need to run as root

Output without support of time namespaces:
 1..4
 not ok 1 # SKIP Time namespaces are not supported

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |   1 +
 tools/testing/selftests/timens/Makefile       |   4 +-
 .../selftests/timens/clock_nanosleep.c        | 150 ++++++++++++++++++
 3 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index b609f6ee9fb9..9b6c8ddac2c8 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,2 +1,3 @@
+clock_nanosleep
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 293aed6be95e..40f630d46ca8 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,6 +1,6 @@
-TEST_GEN_PROGS := timens timerfd
+TEST_GEN_PROGS := timens timerfd clock_nanosleep
 
-CFLAGS := -Wall -Werror
+CFLAGS := -Wall -Werror -pthread
 LDFLAGS := -lrt
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 000000000000..c6f871fb0704
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <pthread.h>
+#include <signal.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+void test_sig(int sig)
+{
+	if (sig == SIGUSR2)
+		pthread_exit(NULL);
+}
+
+struct thread_args {
+	struct timespec *now, *rem;
+	pthread_mutex_t *lock;
+	int clockid;
+	int abs;
+};
+
+void *call_nanosleep(void *_args)
+{
+	struct thread_args *args = _args;
+
+	clock_nanosleep(args->clockid, args->abs ? TIMER_ABSTIME : 0, args->now, args->rem);
+	pthread_mutex_unlock(args->lock);
+	return NULL;
+}
+
+int run_test(int clockid, int abs)
+{
+	struct timespec now = {}, rem;
+	struct thread_args args = { .now = &now, .rem = &rem, .clockid = clockid};
+	struct timespec start;
+	pthread_mutex_t lock;
+	pthread_t thread;
+	int j, ok, ret;
+
+	signal(SIGUSR1, test_sig);
+	signal(SIGUSR2, test_sig);
+
+	pthread_mutex_init(&lock, NULL);
+	pthread_mutex_lock(&lock);
+
+	if (clock_gettime(clockid, &start) == -1) {
+		if (errno == EINVAL && check_skip(clockid))
+			return 0;
+		return pr_perror("clock_gettime");
+	}
+
+
+	if (abs) {
+		now.tv_sec = start.tv_sec;
+		now.tv_nsec = start.tv_nsec;
+	}
+
+	now.tv_sec += 3600;
+	args.abs = abs;
+	args.lock = &lock;
+	ret = pthread_create(&thread, NULL, call_nanosleep, &args);
+	if (ret != 0) {
+		pr_err("Unable to create a thread: %s", strerror(ret));
+		return 1;
+	}
+
+	/* Wait when the thread will call clock_nanosleep(). */
+	ok = 0;
+	for (j = 0; j < 8; j++) {
+		/* The maximum timeout is about 5 seconds. */
+		usleep(10000 << j);
+
+		/* Try to interrupt clock_nanosleep(). */
+		pthread_kill(thread, SIGUSR1);
+
+		usleep(10000 << j);
+		/* Check whether clock_nanosleep() has been interrupted or not. */
+		if (pthread_mutex_trylock(&lock) == 0) {
+			/**/
+			ok = 1;
+			break;
+		}
+	}
+	if (!ok)
+		pthread_kill(thread, SIGUSR2);
+	pthread_join(thread, NULL);
+	pthread_mutex_destroy(&lock);
+
+	if (!ok) {
+		ksft_test_result_pass("clockid: %d abs:%d timeout\n", clockid, abs);
+		return 1;
+	}
+
+	if (rem.tv_sec < 3300 || rem.tv_sec > 3900) {
+		pr_fail("clockid: %d abs: %d remain: %ld\n",
+			clockid, abs, rem.tv_sec);
+		return 1;
+	}
+	ksft_test_result_pass("clockid: %d abs:%d\n", clockid, abs);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, nsfd;
+
+	nscheck();
+
+	ksft_set_plan(4);
+
+	check_config_posix_timers();
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, 7 * 24 * 3600))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, 9 * 24 * 3600))
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Unable to open timens_for_children");
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("Unable to set timens");
+
+	ret = 0;
+	ret |= run_test(CLOCK_MONOTONIC, 0);
+	ret |= run_test(CLOCK_MONOTONIC, 1);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM, 0);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM, 1);
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
+
-- 
2.24.0

