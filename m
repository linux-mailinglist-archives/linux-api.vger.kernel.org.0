Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB966D3719
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfJKBY6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfJKBYc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id j11so9980316wrp.1
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JF3wvUb/Li3fW1jOcia0wAhEt20HXglpe7GKc5WTHCs=;
        b=iRPYz/k0uKezn5O1qS+aetYjUBXoNk/YCWFwLYv7Y80RqthM1W+U38kuz4cr+ybp6I
         rR/2bscJeRMT8vTAFAWKtgAikm+f9m1Jzesm95BY4IAALTq6wxNOGBdp+GekPr3lES++
         yij94G6gX9ydKmmLRw9nVxJXFiRQMnTRRLfACVEvTN17v/wFYho0XoYJjizLcI8ltJQP
         uDg4QgBnOkM5j/dlMMdyET3gXaqsdoSqcqqBFopSBb6kdWJKQMGs/8K9fRjTYIkgMxDV
         OD8xOfZWHlHoDAGmhNTGCFo+L/DcdhcllquO4SK3Ef06sdvUr8lSPxBJdu1s1q5Z38az
         oxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JF3wvUb/Li3fW1jOcia0wAhEt20HXglpe7GKc5WTHCs=;
        b=Z50ixXk54ooy4+pfe43UYuYjWrCVb2sJSK96dcexEVw93eXstuQU89iJ2AwH0Jo7RP
         So2QSEDN7KfLD0BMM0rI/YkQIXpxlAdFyCR8/I5t1K0FsFxqSadKbMj7cNrMApJv7mRR
         yw2X2ZIQ6zQe8ImS9BC6ztSAkrTCn9etNle3uVncGD7UX125s1uZtj1gBZzqWkMrbrA5
         pme7qC5e3HoYL8qzy0rMJr9Ba0CnN2YhYW0kug5lx++84fDle8ZjkDygtlliWdqRY6HY
         gAud5WeDMl2aLCDdHZ6YZiM2FL3oz99H0Efr8MjHUh2/QKw6dvHcOtJg6K4lv5mZC2Zm
         ZNxQ==
X-Gm-Message-State: APjAAAUTWk0ZtKePHVWsS5MHjqiR9M9u0Zvud2bR/Czqobnvmwn+q4E+
        ORk+gMOLEhP+tsgpOnLgwuoWbw==
X-Google-Smtp-Source: APXvYqwUhTPPOiHd4vT58kBkblRv96antskXBTS4cDbNuBArP6+gjUKIhFmPjwG/X3b1cxOpC9/wcg==
X-Received: by 2002:adf:8068:: with SMTP id 95mr11575140wrk.249.1570757069862;
        Thu, 10 Oct 2019 18:24:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:29 -0700 (PDT)
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
Subject: [PATCHv7 29/33] selftests/timens: Add a test for clock_nanosleep()
Date:   Fri, 11 Oct 2019 02:23:37 +0100
Message-Id: <20191011012341.846266-30-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
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
 .../selftests/timens/clock_nanosleep.c        | 143 ++++++++++++++++++
 3 files changed, 146 insertions(+), 2 deletions(-)
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
index 66b90cd28e5c..801e7ab2f8bf 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,5 +1,5 @@
-TEST_GEN_PROGS := timens timerfd
+TEST_GEN_PROGS := timens timerfd clock_nanosleep
 
-CFLAGS := -Wall -Werror
+CFLAGS := -Wall -Werror -pthread
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 000000000000..0f4eab6e4669
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,143 @@
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
+void test_sig(int sig) {
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
+	if (clock_gettime(clockid, &start) == -1)
+		return pr_perror("clock_gettime");
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
2.23.0

