Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E3941641A
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242684AbhIWROb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:14:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbhIWROW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:14:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 78F871F44612
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 19/22] selftests: futex: Add sys_futex_waitv() test
Date:   Thu, 23 Sep 2021 14:11:08 -0300
Message-Id: <20210923171111.300673-20-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Create a new file to test the waitv mechanism. Test both private and
shared futexes. Wake the last futex in the array, and check if the
return value from futex_waitv() is the right index.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/futex_waitv.c  | 237 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  22 ++
 5 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0e78b49d0f2f..fbcbdb6963b3 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -8,3 +8,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_wait
 futex_requeue
+futex_waitv
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index bd1fec59e010..5cc38de9d8ea 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,7 +17,8 @@ TEST_GEN_FILES := \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
 	futex_wait \
-	futex_requeue
+	futex_requeue \
+	futex_waitv
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
new file mode 100644
index 000000000000..a94337f677e1
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex_waitv() test by André Almeida <andrealmeid@collabora.com>
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+
+#include <errno.h>
+#include <error.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <sys/shm.h>
+#include "futextest.h"
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex-wait"
+#define WAKE_WAIT_US 10000
+#define NR_FUTEXES 30
+static struct futex_waitv waitv[NR_FUTEXES];
+u_int32_t futexes[NR_FUTEXES] = {0};
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c	Use color\n");
+	printf("  -h	Display this help message\n");
+	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+void *waiterfn(void *arg)
+{
+	struct timespec to;
+	int res;
+
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res = futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res < 0) {
+		ksft_test_result_fail("futex_waitv returned: %d %s\n",
+				      errno, strerror(errno));
+	} else if (res != NR_FUTEXES - 1) {
+		ksft_test_result_fail("futex_waitv returned: %d, expecting %d\n",
+				      res, NR_FUTEXES - 1);
+	}
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t waiter;
+	int res, ret = RET_PASS;
+	struct timespec to;
+	int c, i;
+
+	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(7);
+	ksft_print_msg("%s: Test FUTEX_WAITV\n",
+		       basename(argv[0]));
+
+	for (i = 0; i < NR_FUTEXES; i++) {
+		waitv[i].uaddr = (uintptr_t)&futexes[i];
+		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
+		waitv[i].val = 0;
+		waitv[i].__reserved = 0;
+	}
+
+	/* Private waitv */
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, FUTEX_PRIVATE_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("futex_wake private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv private\n");
+	}
+
+	/* Shared waitv */
+	for (i = 0; i < NR_FUTEXES; i++) {
+		int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+
+		if (shm_id < 0) {
+			perror("shmget");
+			exit(1);
+		}
+
+		unsigned int *shared_data = shmat(shm_id, NULL, 0);
+
+		*shared_data = 0;
+		waitv[i].uaddr = (uintptr_t)shared_data;
+		waitv[i].flags = FUTEX_32;
+		waitv[i].val = 0;
+		waitv[i].__reserved = 0;
+	}
+
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex_wake(u64_to_ptr(waitv[NR_FUTEXES - 1].uaddr), 1, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv shared\n");
+	}
+
+	for (i = 0; i < NR_FUTEXES; i++)
+		shmdt(u64_to_ptr(waitv[i].uaddr));
+
+	/* Testing a waiter without FUTEX_32 flag */
+	waitv[0].flags = FUTEX_PRIVATE_FLAG;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res = futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
+	}
+
+	/* Testing a waiter with an unaligned address */
+	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
+	waitv[0].uaddr = 1;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res = futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL) {
+		ksft_test_result_fail("futex_wake private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv with an unaligned address\n");
+	}
+
+	/* Testing a NULL address for waiters.uaddr */
+	waitv[0].uaddr = 0x00000000;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res = futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv NULL address in waitv.uaddr\n");
+	}
+
+	/* Testing a NULL address for *waiters */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res = futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	if (res == EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv NULL address in *waiters\n");
+	}
+
+	/* Testing an invalid clockid */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("gettime64 failed\n", errno);
+
+	to.tv_sec++;
+
+	res = futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_TAI);
+	if (res == EINVAL) {
+		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_waitv invalid clockid\n");
+	}
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 11a9d62290f5..5ccd599da6c3 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -79,3 +79,6 @@ echo
 
 echo
 ./futex_requeue $COLOR
+
+echo
+./futex_waitv $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
new file mode 100644
index 000000000000..9d305520e849
--- /dev/null
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Futex2 library addons for futex tests
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+#include <stdint.h>
+
+#define u64_to_ptr(x) ((void *)(uintptr_t)(x))
+
+/**
+ * futex_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+}
-- 
2.33.0

