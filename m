Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505FE21A682
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGISAu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 14:00:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60998 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgGISAt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 14:00:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 0E24B2A65F4
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
Subject: [RFC v2 2/4] selftests: futex: Add futex2 wake/wait test
Date:   Thu,  9 Jul 2020 14:59:19 -0300
Message-Id: <20200709175921.211387-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709175921.211387-1-andrealmeid@collabora.com>
References: <20200709175921.211387-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a simple test to test wake/wait mechanism using futex2 interface.
Create helper files so more tests can evaluate futex2. While 32bit ABIs
from glibc aren't able to use 64 bit sized time variables, add a
temporary workaround that implements the required types and calls the
appropriated syscalls, since futex2 doesn't supports 32 bit sized time.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tools/include/uapi/asm-generic/unistd.h       |   7 +-
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   4 +-
 .../selftests/futex/functional/futex2_wait.c  | 111 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  77 ++++++++++++
 6 files changed, 201 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..40fbf4ce49ff 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -856,8 +856,13 @@ __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 
+#define __NR_futex_wait 440
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_wake 441
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
+
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0efcd494daab..d61f1df94360 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -6,3 +6,4 @@ futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
+futex2_wait
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 23207829ec75..7142a94a7ac3 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -5,6 +5,7 @@ LDLIBS := -lpthread -lrt
 
 HEADERS := \
 	../include/futextest.h \
+	../include/futex2test.h \
 	../include/atomic.h \
 	../include/logging.h
 TEST_GEN_FILES := \
@@ -14,7 +15,8 @@ TEST_GEN_FILES := \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
-	futex_wait_private_mapped_file
+	futex_wait_private_mapped_file \
+	futex2_wait
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_wait.c b/tools/testing/selftests/futex/functional/futex2_wait.c
new file mode 100644
index 000000000000..752ed26803b3
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_wait.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2020
+ *
+ * DESCRIPTION
+ *	Test wait/wake mechanism of futex2, using 32bit sized futexes.
+ *
+ * AUTHOR
+ *	André Almeida <andrealmeid@collabora.com>
+ *
+ * HISTORY
+ *      2020-Jul-9: Initial version by André <andrealmeid@collabora.com>
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
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex-wait-wouldblock"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+futex_t f1 = FUTEX_INITIALIZER;
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
+
+	/* setting absolute timeout for futex2 */
+	if (gettime64(CLOCK_MONOTONIC, &to64))
+		error("gettime64 failed\n", errno);
+
+	to64.tv_nsec += timeout_ns;
+
+	if (to64.tv_nsec >= 1000000000) {
+		to64.tv_sec++;
+		to64.tv_nsec -= 1000000000;
+	}
+
+	if (futex2_wait(&f1, f1, FUTEX_PRIVATE_FLAG | FUTEX_32, &to64))
+		printf("waiter failed errno %d\n", errno);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t waiter;
+	int res, ret = RET_PASS;
+	int c;
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
+	ksft_set_plan(1);
+	ksft_print_msg("%s: Test FUTEX_WAIT\n",
+		       basename(argv[0]));
+
+	info("Calling futex_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1);
+
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling futex2_wake on f1: %u @ %p with val=%u\n", f1, &f1, f1);
+	res = futex2_wake(&f1, 1, FUTEX_PRIVATE_FLAG | FUTEX_32);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_wake returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wake wouldblock succeeds\n");
+	}
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 1acb6ace1680..3730159c865a 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -73,3 +73,6 @@ echo
 echo
 ./futex_wait_uninitialized_heap $COLOR
 ./futex_wait_private_mapped_file $COLOR
+
+echo
+./futex2_wait $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
new file mode 100644
index 000000000000..807b8b57fe61
--- /dev/null
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2020
+ *
+ * DESCRIPTION
+ *	Futex2 library addons for old futex library
+ *
+ * AUTHOR
+ *	André Almeida <andrealmeid@collabora.com>
+ *
+ * HISTORY
+ *      2020-Jul-9: Initial version by André <andrealmeid@collabora.com>
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
+#define FUTEX_32	2
+#endif
+#ifdef __x86_64__
+# ifndef FUTEX_64
+#  define FUTEX_64      3
+# endif
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
+/*
+ * wait for uaddr if (*uaddr == val)
+ */
+static inline int futex2_wait(volatile void *uaddr, unsigned long val,
+			      unsigned long flags, struct timespec64 *timo)
+{
+	return syscall(__NR_futex_wait, uaddr, val, flags, timo);
+}
+
+/*
+ * wake nr futexes waiting for uaddr
+ */
+static inline int futex2_wake(volatile void *uaddr, unsigned int nr, unsigned long flags)
+{
+	return syscall(__NR_futex_wake, uaddr, nr, flags);
+}
-- 
2.27.0

