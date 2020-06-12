Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB311F7D2E
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2020 20:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLSve (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jun 2020 14:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSvd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Jun 2020 14:51:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180DC03E96F;
        Fri, 12 Jun 2020 11:51:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9534A2A57E7
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org
Subject: [RFC 2/4] selftests: futex: Add futex2 wake/wait test
Date:   Fri, 12 Jun 2020 15:51:20 -0300
Message-Id: <20200612185122.327860-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612185122.327860-1-andrealmeid@collabora.com>
References: <20200612185122.327860-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a simple test to test wake/wait mechanism using futex2 interface.
Create helper files so more tests can evaluate futex2.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tools/include/uapi/asm-generic/unistd.h       |   7 +-
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   4 +-
 .../selftests/futex/functional/futex2_wait.c  | 106 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  50 +++++++++
 6 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..e050b9669fc3 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -320,6 +320,8 @@ __SYSCALL(__NR_unshare, sys_unshare)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
 __SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#define __NR_futex_wait 439
+__SC_3264(__NR_futex_wait, sys_futex_wait_time32, sys_futex_wait)
 #endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
@@ -856,8 +858,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 
+#define __NR_futex_wake 440
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
+
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 441
 
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
index 000000000000..93f1609210eb
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_wait.c
@@ -0,0 +1,106 @@
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
+ *      2020-06-11: Initial version by André <andrealmeid@collabora.com>
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
+	time_t abs_to;
+	struct timespec to;
+
+	/* setting absolute timeout for futex2 */
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		error("clock_gettime failed\n", errno);
+	abs_to = (NSEC_PER_SEC * to.tv_sec) + to.tv_nsec + timeout_ns;
+
+	if (futex2_wait(&f1, f1, FUTEX_PRIVATE_FLAG | FUTEX_32, &abs_to))
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
index 000000000000..3a560ad7e813
--- /dev/null
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -0,0 +1,50 @@
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
+ *      2020-06-11: Initial version by André <andrealmeid@collabora.com>
+ *
+ *****************************************************************************/
+#include "futextest.h"
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
+ * wait for uaddr if (*uaddr == val)
+ */
+static inline int futex2_wait(volatile void *uaddr, unsigned long val,
+			      unsigned long flags, time_t *timo)
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

