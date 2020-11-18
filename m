Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8212B74CF
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 04:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKRD3T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 22:29:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgKRD3T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 22:29:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A3CED1F44D34
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 5/7] selftests: Add kselftest for syscall user dispatch
Date:   Tue, 17 Nov 2020 22:28:38 -0500
Message-Id: <20201118032840.3429268-6-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118032840.3429268-1-krisman@collabora.com>
References: <20201118032840.3429268-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Implement functionality tests for syscall user dispatch.  In order to
make the test portable, refrain from open coding syscall dispatchers and
calculating glibc memory ranges.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Kees Cook <keescook@chromium.org>

---
Changes since v6:
  - Update selftests to reflect {offset,len} api change
Changes since v4:
  - Update bad selector test to reflect change in API

Changes since v3:
  - Sort entry in Makefile
  - Add SPDX header
  - Use __NR_syscalls if available
---
 tools/testing/selftests/Makefile              |   1 +
 .../syscall_user_dispatch/.gitignore          |   3 +
 .../selftests/syscall_user_dispatch/Makefile  |   9 +
 .../selftests/syscall_user_dispatch/config    |   1 +
 .../syscall_user_dispatch/sud_test.c          | 310 ++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/.gitignore
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/Makefile
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/config
 create mode 100644 tools/testing/selftests/syscall_user_dispatch/sud_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c283503159..96d5682fb9d8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -56,6 +56,7 @@ TARGETS += sparc64
 TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
+TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
 TARGETS += timens
diff --git a/tools/testing/selftests/syscall_user_dispatch/.gitignore b/tools/testing/selftests/syscall_user_dispatch/.gitignore
new file mode 100644
index 000000000000..f539615ad5da
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sud_test
+sud_benchmark
diff --git a/tools/testing/selftests/syscall_user_dispatch/Makefile b/tools/testing/selftests/syscall_user_dispatch/Makefile
new file mode 100644
index 000000000000..8e15fa42bcda
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+top_srcdir = ../../../..
+INSTALL_HDR_PATH = $(top_srcdir)/usr
+LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
+
+CFLAGS += -Wall -I$(LINUX_HDR_PATH)
+
+TEST_GEN_PROGS := sud_test
+include ../lib.mk
diff --git a/tools/testing/selftests/syscall_user_dispatch/config b/tools/testing/selftests/syscall_user_dispatch/config
new file mode 100644
index 000000000000..039e303e59d7
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/config
@@ -0,0 +1 @@
+CONFIG_GENERIC_ENTRY=y
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
new file mode 100644
index 000000000000..6498b050ef89
--- /dev/null
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Collabora Ltd.
+ *
+ * Test code for syscall user dispatch
+ */
+
+#define _GNU_SOURCE
+#include <sys/prctl.h>
+#include <sys/sysinfo.h>
+#include <sys/syscall.h>
+#include <signal.h>
+
+#include <asm/unistd.h>
+#include "../kselftest_harness.h"
+
+#ifndef PR_SET_SYSCALL_USER_DISPATCH
+# define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF	0
+# define PR_SYS_DISPATCH_ON	1
+#endif
+
+#ifndef SYS_USER_DISPATCH
+# define SYS_USER_DISPATCH	2
+#endif
+
+#ifdef __NR_syscalls
+# define MAGIC_SYSCALL_1 (__NR_syscalls + 1) /* Bad Linux syscall number */
+#else
+# define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
+#endif
+
+#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
+#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
+
+/* Test Summary:
+ *
+ * - dispatch_trigger_sigsys: Verify if PR_SET_SYSCALL_USER_DISPATCH is
+ *   able to trigger SIGSYS on a syscall.
+ *
+ * - bad_selector: Test that a bad selector value triggers SIGSYS with
+ *   si_errno EINVAL.
+ *
+ * - bad_prctl_param: Test that the API correctly rejects invalid
+ *   parameters on prctl
+ *
+ * - dispatch_and_return: Test that a syscall is selectively dispatched
+ *   to userspace depending on the value of selector.
+ *
+ * - disable_dispatch: Test that the PR_SYS_DISPATCH_OFF correctly
+ *   disables the dispatcher
+ *
+ * - direct_dispatch_range: Test that a syscall within the allowed range
+ *   can bypass the dispatcher.
+ */
+
+TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
+{
+	char sel = 0;
+	struct sysinfo info;
+	int ret;
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	sysinfo(&info);
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(bad_prctl_param)
+{
+	char sel = 0;
+	int op;
+
+	/* Invalid op */
+	op = -1;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
+	ASSERT_EQ(EINVAL, errno);
+
+	/* PR_SYS_DISPATCH_OFF */
+	op = PR_SYS_DISPATCH_OFF;
+
+	/* offset != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* len != 0 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0xff, 0);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* sel != NULL */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Valid parameter */
+	errno = 0;
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x0, 0x0);
+	EXPECT_EQ(0, errno);
+
+	/* PR_SYS_DISPATCH_ON */
+	op = PR_SYS_DISPATCH_ON;
+
+	/* Dispatcher region is bad (offset > 0 && len == 0) */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel);
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Invalid selector */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1);
+	ASSERT_EQ(EFAULT, errno);
+
+	/*
+	 * Dispatcher range overflows unsigned long
+	 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel);
+	ASSERT_EQ(EINVAL, errno) {
+		TH_LOG("Should reject bad syscall range");
+	}
+
+	/*
+	 * Allowed range overflows usigned long
+	 */
+	prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel);
+	ASSERT_EQ(EINVAL, errno) {
+		TH_LOG("Should reject bad syscall range");
+	}
+}
+
+/*
+ * Use global selector for handle_sigsys tests, to avoid passing
+ * selector to signal handler
+ */
+char glob_sel;
+int nr_syscalls_emulated;
+int si_code;
+int si_errno;
+
+static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
+{
+	si_code = info->si_code;
+	si_errno = info->si_errno;
+
+	if (info->si_syscall == MAGIC_SYSCALL_1)
+		nr_syscalls_emulated++;
+
+	/* In preparation for sigreturn. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
+TEST(dispatch_and_return)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(-1, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+
+	/* MAGIC_SYSCALL_1 should be emulated. */
+	nr_syscalls_emulated = 0;
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(MAGIC_SYSCALL_1);
+	EXPECT_EQ(MAGIC_SYSCALL_1, ret) {
+		TH_LOG("Failed to intercept syscall");
+	}
+	EXPECT_EQ(1, nr_syscalls_emulated) {
+		TH_LOG("Failed to emulate syscall");
+	}
+	ASSERT_EQ(SYS_USER_DISPATCH, si_code) {
+		TH_LOG("Bad si_code in SIGSYS");
+	}
+	ASSERT_EQ(0, si_errno) {
+		TH_LOG("Bad si_errno in SIGSYS");
+	}
+}
+
+TEST_SIGNAL(bad_selector, SIGSYS)
+{
+	long ret;
+	struct sigaction act;
+	sigset_t mask;
+	struct sysinfo info;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	memset(&act, 0, sizeof(act));
+	sigemptyset(&mask);
+
+	act.sa_sigaction = handle_sigsys;
+	act.sa_flags = SA_SIGINFO;
+	act.sa_mask = mask;
+
+	ret = sigaction(SIGSYS, &act, NULL);
+	ASSERT_EQ(0, ret);
+
+	/* Make sure selector is good prior to prctl. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	glob_sel = -1;
+
+	sysinfo(&info);
+
+	/* Even though it is ready to catch SIGSYS, the signal is
+	 * supposed to be uncatchable.
+	 */
+
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
+}
+
+TEST(disable_dispatch)
+{
+	int ret;
+	struct sysinfo info;
+	char sel = 0;
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	/* MAGIC_SYSCALL_1 doesn't exist. */
+	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_OFF, 0, 0, 0);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Failed to unset syscall user dispatch");
+	}
+
+	/* Shouldn't have any effect... */
+	SYSCALL_DISPATCH_ON(glob_sel);
+
+	ret = syscall(__NR_sysinfo, &info);
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST(direct_dispatch_range)
+{
+	int ret = 0;
+	struct sysinfo info;
+	char sel = 0;
+
+	/*
+	 * Instead of calculating libc addresses; allow the entire
+	 * memory map and lock the selector.
+	 */
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &sel);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
+	}
+
+	SYSCALL_DISPATCH_ON(sel);
+
+	ret = sysinfo(&info);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Dispatch triggered unexpectedly");
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.29.2

