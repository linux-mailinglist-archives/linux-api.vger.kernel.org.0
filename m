Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AE30B093
	for <lists+linux-api@lfdr.de>; Mon,  1 Feb 2021 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhBATm6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Feb 2021 14:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhBATmo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Feb 2021 14:42:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC2C061756;
        Mon,  1 Feb 2021 11:42:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so10584108plg.13;
        Mon, 01 Feb 2021 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sPxRlDZVCgLrmX5i4bW0vNdjIwlKi4D6sFiaqH5u5g=;
        b=G+qStO7CkVvgsNXqB/Wb0xndz5YAZ0RZrs54KBqSeBWnQwmZZrW4vLkgw3gfK3GZt6
         RpXWZRrP+uCyvoqxHBKNCS/uC8MXa7J7miKMoZeZelacqSbSARKbDmMaMBP79iE63Mv4
         CzVYO6kKxCRIdhWNYow5YNV3mfte0MkkmbXcsRdk+Fo3t73XIlUekwU3nv/YhOCC5AKb
         jqh9UWlv1tRU0f7qxTS1rydAYnNyhZdJZNoYgZUyFfmNOt0R7KLbbTnz4F9unRrd+t5P
         heRn8ZL7Tj39fs+lxdA7Os0HhAnyzYpgv7n0U3mYoBOVOntHK1FvTDWzuNw3vMw5XtQL
         re/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sPxRlDZVCgLrmX5i4bW0vNdjIwlKi4D6sFiaqH5u5g=;
        b=a7ifauJVZS6HjI/VUV/c91YGNu3u1sQAGZuU9LSaJmUTRW7XTKugBnkJdsM2nUnxI1
         7XpI4NfiAk7qA+dMvitW2TplYrvjrxKUukJvXV78PBr0rRkemG187hoILw04PvvN92HI
         bMFMM5J9N7OJTgVb6B+2GZOsukK2/Oft05xmWOSUYC8nKJGl6UxrYHc5tz2K9p1OW/cA
         7yOLmZRvuzPQFHH9XjFs+njNwOvuvcA417LO/8mwZiSrb8qyMv7qqx7A3HMDADT1sJSQ
         Pz+fFZXxbqEC31B0jhb7KqTv6Arw36G+1nPTHuWYR9RvqpAAB07kbey23DPen90JjGHP
         1CRw==
X-Gm-Message-State: AOAM5318PH2VEx/c37jf8NuqYoC8QTAYBgU1+5zofXo9BMvi17/j7Qos
        FSA2B+CJsWQwhSIgR4TyL2Q=
X-Google-Smtp-Source: ABdhPJw9YWcNuHFuTmMPxsVUG3s1VGIHPRHmuVePCWcxJqJN2Qj4tJcarkH23fR/KYYV3RZnTL99Kg==
X-Received: by 2002:a17:902:a58c:b029:df:f345:80ec with SMTP id az12-20020a170902a58cb02900dff34580ecmr18525611plb.66.1612208522619;
        Mon, 01 Feb 2021 11:42:02 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id i4sm18213155pfo.40.2021.02.01.11.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:42:01 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH 3/3] selftest/arm64/ptrace: add tests for PTRACE_O_ARM64_RAW_REGS
Date:   Mon,  1 Feb 2021 11:40:12 -0800
Message-Id: <20210201194012.524831-4-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201194012.524831-1-avagin@gmail.com>
References: <20210201194012.524831-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Test output:
 TAP version 13
 1..2
 # selftests: arm64/ptrace: ptrace_syscall_raw_regs_test
 # 1..2
 # ok 1 x7: 686920776f726c64
 # ok 2 The child exited with code 0.
 # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: arm64/ptrace: ptrace_syscall_raw_regs_test
 # selftests: arm64/ptrace: ptrace_syscall_regs_test
 # 1..3
 # ok 1 x7: 0
 # ok 2 x7: 1
 # ok 3 The child exited with code 0.
 # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 2 selftests: arm64/ptrace: ptrace_syscall_regs_test

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/ptrace/Makefile |   6 +
 .../ptrace/ptrace_syscall_raw_regs_test.c     | 142 +++++++++++++++++
 .../arm64/ptrace/ptrace_syscall_regs_test.c   | 150 ++++++++++++++++++
 4 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/ptrace/Makefile
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_raw_regs_test.c
 create mode 100644 tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 2c9d012797a7..704770a60ece 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte
+ARM64_SUBTARGETS ?= tags signal pauth fp mte ptrace
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/ptrace/Makefile b/tools/testing/selftests/arm64/ptrace/Makefile
new file mode 100644
index 000000000000..84b27449f3d1
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -g -I../../../../../usr/include/
+TEST_GEN_PROGS := ptrace_syscall_raw_regs_test ptrace_syscall_regs_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/ptrace/ptrace_syscall_raw_regs_test.c b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_raw_regs_test.c
new file mode 100644
index 000000000000..78f913303a99
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_raw_regs_test.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+
+#include "../../kselftest.h"
+
+#define TEST_VAL 0x686920776f726c64UL
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt "\n", ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+static long loop(void *val)
+{
+	register long x0 __asm__("x0");
+	register void *x1 __asm__("x1") = val;
+	register long x8 __asm__("x8") = 555;
+
+	__asm__ (
+		"again:\n"
+		"ldr x7, [x1, 0]\n"
+		"svc 0\n"
+		"str x7, [x1, 0]\n"
+			   : "=r"(x0)
+			   : "r"(x1), "r"(x8)
+			   :
+	);
+	return 0;
+}
+
+static int child(void)
+{
+	long  val = TEST_VAL;
+
+	loop(&val);
+	if (val != ~TEST_VAL) {
+		ksft_print_msg("Unexpected x7: %lx\n", val);
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifndef PTRACE_SYSEMU
+#define PTRACE_SYSEMU 31
+#endif
+
+#ifndef PTRACE_O_ARM64_RAW_REGS
+#define PTRACE_O_ARM64_RAW_REGS                (1 << 28)
+#endif
+
+int main(int argc, void **argv)
+{
+	struct user_regs_struct regs = {};
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(struct user_regs_struct),
+	};
+	int status;
+	pid_t pid;
+
+	ksft_set_plan(2);
+
+	pid = fork();
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		child();
+		_exit(0);
+	}
+	if (pid < 0)
+		return 1;
+
+	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
+		return pr_perror("Can't attach to the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_ARM64_RAW_REGS))
+		return pr_perror("Can't set PTRACE_O_ARM64_RAW_REGS");
+	/* skip SIGSTOP */
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+
+	/* Resume the child to the next system call. */
+	if (ptrace(PTRACE_SYSEMU, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP)
+		return pr_err("Unexpected status: %d", status);
+
+	/* Check that x7 isnt't clobbered if PTRACE_O_ARM64_RAW_REGS is set. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.regs[7] != TEST_VAL)
+		return pr_fail("unexpected x7: %lx", regs.regs[7]);
+	ksft_test_result_pass("x7: %llx\n", regs.regs[7]);
+
+	/* Check that the child will see a new value of x7. */
+	regs.regs[0] = 0;
+	regs.regs[7] = ~TEST_VAL;
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't set child registers");
+
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+
+	if (status != 0)
+		return pr_fail("Child exited with code %d.", status);
+
+	ksft_test_result_pass("The child exited with code 0.\n");
+	ksft_exit_pass();
+	return 0;
+}
+
diff --git a/tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c
new file mode 100644
index 000000000000..d1534525ef26
--- /dev/null
+++ b/tools/testing/selftests/arm64/ptrace/ptrace_syscall_regs_test.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+
+#include "../../kselftest.h"
+
+#define TEST_VAL 0x686920776f726c64UL
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt "\n", ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+static long loop(void *val)
+{
+	register long x0 __asm__("x0");
+	register void *x1 __asm__("x1") = val;
+	register long x8 __asm__("x8") = 555;
+
+	__asm__ (
+		"again:\n"
+		"ldr x7, [x1, 0]\n"
+		"svc 0\n"
+		"str x7, [x1, 0]\n"
+			   : "=r"(x0)
+			   : "r"(x1), "r"(x8)
+			   :
+	);
+	return 0;
+}
+
+static int child(void)
+{
+	long  val = TEST_VAL;
+
+	loop(&val);
+	if (val != TEST_VAL) {
+		ksft_print_msg("Unexpected x7: %lx\n", val);
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifndef PTRACE_O_ARM64_RAW_REGS
+#define PTRACE_O_ARM64_RAW_REGS                (1 << 28)
+#endif
+
+int main(int argc, void **argv)
+{
+	struct user_regs_struct regs = {};
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(struct user_regs_struct),
+	};
+	int status;
+	pid_t pid;
+
+	ksft_set_plan(3);
+
+	pid = fork();
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		child();
+		_exit(0);
+	}
+	if (pid < 0)
+		return 1;
+
+	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
+		return pr_perror("Can't attach to the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	/* skip SIGSTOP */
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+
+	/* Resume the child to the next system call. */
+	if (ptrace(PTRACE_SYSCALL, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP)
+		return pr_err("Unexpected status: %d", status);
+
+	/* Check that x7 is 0 on syscall-enter. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.regs[7] != 0)
+		return pr_fail("Unexpected x7: %lx", regs.regs[7]);
+	ksft_test_result_pass("x7: %llx\n", regs.regs[7]);
+
+	if (ptrace(PTRACE_SYSCALL, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+	if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP)
+		return pr_err("Unexpected status: %d", status);
+
+	/* Check that x7 is 1 on syscall-exit. */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't get child registers");
+	if (regs.regs[7] != 1)
+		return pr_fail("Unexpected x7: %lx", regs.regs[7]);
+	ksft_test_result_pass("x7: %llx\n", regs.regs[7]);
+
+	/* Check that the child will not a new value of x7. */
+	regs.regs[0] = 0;
+	regs.regs[7] = ~TEST_VAL;
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		return pr_perror("Can't set child registers");
+
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("Can't resume the child %d", pid);
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Can't wait for the child %d", pid);
+
+	if (status != 0)
+		return pr_fail("Child exited with code %d.", status);
+
+	ksft_test_result_pass("The child exited with code 0.\n");
+	ksft_exit_pass();
+	return 0;
+}
+
-- 
2.29.2

