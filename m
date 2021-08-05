Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3D3E1C13
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbhHETFW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 15:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhHETE5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 15:04:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E012C0617B0;
        Thu,  5 Aug 2021 12:04:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id CCBD81F4432A
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 3/4] selftests: futex2: Add waitv test
Date:   Thu,  5 Aug 2021 16:04:04 -0300
Message-Id: <20210805190405.59110-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805190405.59110-1-andrealmeid@collabora.com>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
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
 .../selftests/futex/functional/futex2_waitv.c | 154 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  72 ++++++++
 5 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0e78b49d0f2f..913ce6f91bb0 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -8,3 +8,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_wait
 futex_requeue
+futex2_waitv
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index bd1fec59e010..cb5f1bdd6678 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,7 +17,8 @@ TEST_GEN_FILES := \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
 	futex_wait \
-	futex_requeue
+	futex_requeue \
+	futex2_waitv
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_waitv.c b/tools/testing/selftests/futex/functional/futex2_waitv.c
new file mode 100644
index 000000000000..562eec6e946c
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_waitv.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2021
+ *
+ * DESCRIPTION
+ *	Test waitv/wake mechanism of futex2, using 32bit sized futexes.
+ *
+ * AUTHOR
+ *	André Almeida <andrealmeid@collabora.com>
+ *
+ * HISTORY
+ *      2021-Feb-5: Initial version by André <andrealmeid@collabora.com>
+ *
+ *****************************************************************************/
+
+#include <errno.h>
+#include <error.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <pthread.h>
+#include <sys/shm.h>
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex2-wait"
+#define WAKE_WAIT_US 10000
+#define NR_FUTEXES 30
+struct futex_waitv waitv[NR_FUTEXES];
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
+	struct timespec64 to64;
+	int res;
+
+	/* setting absolute timeout for futex2 */
+	if (gettime64(CLOCK_MONOTONIC, &to64))
+		error("gettime64 failed\n", errno);
+
+	to64.tv_sec++;
+
+	res = futex2_waitv(waitv, NR_FUTEXES, 0, &to64);
+	if (res < 0) {
+		ksft_test_result_fail("futex2_waitv returned: %d %s\n",
+				      errno, strerror(errno));
+	} else if (res != NR_FUTEXES - 1) {
+		ksft_test_result_fail("futex2_waitv returned: %d, expecting %d\n",
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
+	ksft_set_plan(2);
+	ksft_print_msg("%s: Test FUTEX2_WAITV\n",
+		       basename(argv[0]));
+
+	for (i = 0; i < NR_FUTEXES; i++) {
+		waitv[i].uaddr = &futexes[i];
+		waitv[i].flags = FUTEX_32;
+		waitv[i].val = 0;
+	}
+
+	/* Private waitv */
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex_wake(waitv[NR_FUTEXES - 1].uaddr, 1, FUTEX_PRIVATE_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_waitv private\n");
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
+		waitv[i].uaddr = shared_data;
+		waitv[i].flags = FUTEX_32 | FUTEX_SHARED_FLAG;
+		waitv[i].val = 0;
+	}
+
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex_wake(waitv[NR_FUTEXES - 1].uaddr, 1, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_waitv shared returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_waitv shared\n");
+	}
+
+	for (i = 0; i < NR_FUTEXES; i++)
+		shmdt(waitv[i].uaddr);
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 11a9d62290f5..e2b4b4747368 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -79,3 +79,6 @@ echo
 
 echo
 ./futex_requeue $COLOR
+
+echo
+./futex2_waitv $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
new file mode 100644
index 000000000000..dbc29d8e8187
--- /dev/null
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2021
+ *
+ * DESCRIPTION
+ *	Futex2 library addons for old futex library
+ *
+ * AUTHOR
+ *	André Almeida <andrealmeid@collabora.com>
+ *
+ * HISTORY
+ *      2021-Feb-5: Initial version by André <andrealmeid@collabora.com>
+ *
+ *****************************************************************************/
+#include "futextest.h"
+#include <stdio.h>
+
+#define NSEC_PER_SEC	1000000000L
+
+#ifndef FUTEX_8
+# define FUTEX_8	0
+#endif
+#ifndef FUTEX_16
+# define FUTEX_16	1
+#endif
+#ifndef FUTEX_32
+# define FUTEX_32	2
+#endif
+
+#ifndef FUTEX_SHARED_FLAG
+#define FUTEX_SHARED_FLAG 8
+#endif
+
+/*
+ * - Y2038 section for 32-bit applications -
+ *
+ * Remove this when glibc is ready for y2038. Then, always compile with
+ * `-DTIME_BITS=64` or `-D__USE_TIME_BITS64`. glibc will provide both
+ * timespec64 and clock_gettime64 so we won't need to define here.
+ */
+#if defined(__i386__) || __TIMESIZE == 32
+# define NR_gettime __NR_clock_gettime64
+#else
+# define NR_gettime __NR_clock_gettime
+#endif
+
+struct timespec64 {
+	long long tv_sec;	/* seconds */
+	long long tv_nsec;	/* nanoseconds */
+};
+
+int gettime64(clock_t clockid, struct timespec64 *tv)
+{
+	return syscall(NR_gettime, clockid, tv);
+}
+/*
+ * - End of Y2038 section -
+ */
+
+/**
+ * futex2_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int futex2_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
+			      unsigned long flags, struct timespec64 *timo)
+{
+	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo);
+}
-- 
2.32.0

