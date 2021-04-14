Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECD335EC9C
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 07:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348166AbhDNFzX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 01:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348118AbhDNFzU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 01:55:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA0C061574;
        Tue, 13 Apr 2021 22:54:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id r13so5904133pjf.2;
        Tue, 13 Apr 2021 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWOlpkJ/oHMUuNQKOxSP4pRWWWHkfXlkyYq4pN3Iwfw=;
        b=eV9RwBML/PRjQqR1n0+BtU2LXzm8XB260ShL3aBj0rGb8mqAQ5HIrd1T5Rve58YvuW
         SIIk7vv5DBRW7O7dC/lHRCqzmKJPF9nZlOZw2lDv1A+e5O9lqJqlSGDWLUlYnmtedR67
         /nvjL5Jo9R1FJzo0680XBKIv32ItVzfRn1n/3VZv11ol8BKja0a+2lCwbwZFL3t03fPl
         Oo/O/FOy/tZx1FGVeIJdUwRd1irbjVB33ZYuovrXpMiUe/w3Dh7UApkgBqMcZOBrl6V5
         zzFDA4lLxPlGXVpVL8RwNIiPyjJ5TPzdhL36M3Szrhyq1nKqIrCGQV4o610yc+VWJPG7
         uQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWOlpkJ/oHMUuNQKOxSP4pRWWWHkfXlkyYq4pN3Iwfw=;
        b=NSBNIHq8a6hkvRT4sihJa5BhXWq3NQLcaA0feoVQsW7SQUq4EwhCSRGbbubM1+9dUF
         ec1rfOujy+g2HYVWYVLGiFRx8yAhnaEnuqKAzH/t+IbAieJgCz48slGbctILQwXtq0DV
         iRp3Z9yePAHHmGs2yTMYhNy+MAizhrvnAfOLhynZrGUrBAIHsUIijJw6050Sgn8GhtHX
         bL0W1wmIKnz629aF6RSWf/ujeWdTw6zRZV1XTj4i3TfKumir1PbGPP4Tz1+0b/elwFXC
         fuScB4OdgnAdmKvfIxA2iMsM3U7pvyLWnzpQKNL6z8SK6WuBrIt79lK+q5GzNkhQ/Hf8
         q5Uw==
X-Gm-Message-State: AOAM5304kUtOwxl+n1X9hXrBI3ADeUwzDaqOp2hgXQlGZY7m31Fj7gf2
        ZVCMblJo/jdVuZc68X4TS2hApQZNts+iu37O
X-Google-Smtp-Source: ABdhPJzV15VnjGOX2aOSqvqNDWAQYNppbYIYDZvNVmrU+8k4IenEy48TwtU99UFfyZpoTNlc3vVtBQ==
X-Received: by 2002:a17:90b:78d:: with SMTP id l13mr1765003pjz.182.1618379698413;
        Tue, 13 Apr 2021 22:54:58 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u17sm13728969pfm.113.2021.04.13.22.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:54:58 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/4] selftests: add tests for process_vm_exec
Date:   Tue, 13 Apr 2021 22:52:17 -0700
Message-Id: <20210414055217.543246-5-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Output:
 $ make run_tests
 TAP version 13
 1..4
 # selftests: process_vm_exec: process_vm_exec
 # 1..1
 # ok 1 275 ns/syscall
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: process_vm_exec: process_vm_exec
 # selftests: process_vm_exec: process_vm_exec_fault
 # 1..1
 # ok 1 789 ns/signal
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 2 selftests: process_vm_exec: process_vm_exec_fault
 # selftests: process_vm_exec: ptrace_vm_exec
 # 1..1
 # ok 1 1378 ns/syscall# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 3 selftests: process_vm_exec: ptrace_vm_exec
 # selftests: process_vm_exec: process_vm_exec_syscall
 # 1..1
 # ok 1 write works as expectd
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 4 selftests: process_vm_exec: process_vm_exec_syscall

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 .../selftests/process_vm_exec/Makefile        |   7 ++
 tools/testing/selftests/process_vm_exec/log.h |  26 ++++
 .../process_vm_exec/process_vm_exec.c         | 105 +++++++++++++++++
 .../process_vm_exec/process_vm_exec_fault.c   | 111 ++++++++++++++++++
 .../process_vm_exec/process_vm_exec_syscall.c |  81 +++++++++++++
 .../process_vm_exec/ptrace_vm_exec.c          | 111 ++++++++++++++++++
 6 files changed, 441 insertions(+)
 create mode 100644 tools/testing/selftests/process_vm_exec/Makefile
 create mode 100644 tools/testing/selftests/process_vm_exec/log.h
 create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec.c
 create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec_fault.c
 create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec_syscall.c
 create mode 100644 tools/testing/selftests/process_vm_exec/ptrace_vm_exec.c

diff --git a/tools/testing/selftests/process_vm_exec/Makefile b/tools/testing/selftests/process_vm_exec/Makefile
new file mode 100644
index 000000000000..bdf7fcf0fdd3
--- /dev/null
+++ b/tools/testing/selftests/process_vm_exec/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+UNAME_M := $(shell uname -m)
+TEST_GEN_PROGS_x86_64 := process_vm_exec process_vm_exec_fault ptrace_vm_exec process_vm_exec_syscall
+TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
+
+include ../lib.mk
diff --git a/tools/testing/selftests/process_vm_exec/log.h b/tools/testing/selftests/process_vm_exec/log.h
new file mode 100644
index 000000000000..ef268c2cf2b8
--- /dev/null
+++ b/tools/testing/selftests/process_vm_exec/log.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_PROCESS_VM_EXEC_LOG_H__
+#define __SELFTEST_PROCESS_VM_EXEC_LOG_H__
+
+#define pr_msg(fmt, lvl, ...)						\
+	ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",			\
+			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
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
+#endif
diff --git a/tools/testing/selftests/process_vm_exec/process_vm_exec.c b/tools/testing/selftests/process_vm_exec/process_vm_exec.c
new file mode 100644
index 000000000000..aa4009c43e01
--- /dev/null
+++ b/tools/testing/selftests/process_vm_exec/process_vm_exec.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/user.h>
+#include <sys/uio.h>
+#include <sys/prctl.h>
+#include "asm/unistd.h"
+#include <time.h>
+#include <sys/mman.h>
+
+#include "../kselftest.h"
+#include "log.h"
+
+#ifndef __NR_process_vm_exec
+#define __NR_process_vm_exec 441
+#endif
+
+#define TEST_SYSCALL 123
+#define TEST_SYSCALL_RET 456
+#define TEST_MARKER 789
+#define TEST_TIMEOUT 5
+#define TEST_STACK_SIZE 65536
+
+static inline long __syscall1(long n, long a1)
+{
+	unsigned long ret;
+
+	__asm__ __volatile__ ("syscall" : "=a"(ret) : "a"(n), "D"(a1) : "rcx", "r11", "memory");
+
+	return ret;
+}
+
+int marker;
+
+static void guest(void)
+{
+	while (1)
+		if (__syscall1(TEST_SYSCALL, marker) != TEST_SYSCALL_RET)
+			abort();
+}
+
+int main(int argc, char **argv)
+{
+	struct sigcontext ctx = {};
+	struct timespec start, cur;
+	int status, ret;
+	pid_t pid;
+	long sysnr;
+	void *stack;
+
+	ksft_set_plan(1);
+
+	stack = mmap(NULL, TEST_STACK_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, 0, 0);
+	if (stack == MAP_FAILED)
+		return pr_perror("mmap");
+
+	pid  = fork();
+	if (pid == 0) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
+		marker = TEST_MARKER;
+		kill(getpid(), SIGSTOP);
+		abort();
+		return 0;
+	}
+
+	ctx.rip = (long)guest;
+	ctx.rsp = (long)stack + TEST_STACK_SIZE;
+	ctx.cs = 0x33;
+
+	sysnr = 0;
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	while (1) {
+		unsigned long long sigmask = 0xffffffff;
+		siginfo_t siginfo;
+
+		clock_gettime(CLOCK_MONOTONIC, &cur);
+		if (start.tv_sec + TEST_TIMEOUT < cur.tv_sec ||
+		    (start.tv_sec + TEST_TIMEOUT == cur.tv_sec &&
+		     start.tv_nsec < cur.tv_nsec))
+			break;
+
+		ret = syscall(__NR_process_vm_exec, pid, &ctx, 0, &siginfo, &sigmask, 8);
+#ifdef __DEBUG
+		ksft_print_msg("ret %d signo %d sysno %d ip %lx\n",
+			ret, siginfo.si_signo, siginfo.si_syscall, ctx.rip);
+#endif
+		if (ret != 0)
+			pr_fail("unexpected return code: ret %d errno %d", ret, errno);
+		if (siginfo.si_signo != SIGSYS)
+			pr_fail("unexpected signal: %d", siginfo.si_signo);
+		if (siginfo.si_syscall != TEST_SYSCALL)
+			pr_fail("unexpected syscall: %d", siginfo.si_syscall);
+		ctx.rax = TEST_SYSCALL_RET;
+		sysnr++;
+	}
+	ksft_test_result_pass("%ld ns/syscall\n", 1000000000 / sysnr);
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/process_vm_exec/process_vm_exec_fault.c b/tools/testing/selftests/process_vm_exec/process_vm_exec_fault.c
new file mode 100644
index 000000000000..b2c49095f386
--- /dev/null
+++ b/tools/testing/selftests/process_vm_exec/process_vm_exec_fault.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <sys/user.h>
+#include <sys/uio.h>
+#include <asm/unistd.h>
+
+#include "../kselftest.h"
+#include "log.h"
+
+#ifndef __NR_process_vm_exec
+#define __NR_process_vm_exec 441
+#endif
+
+#define TEST_TIMEOUT 5
+#define TEST_STACK_SIZE 65536
+
+#define TEST_VAL 0xaabbccddee
+
+unsigned long test_val;
+
+static inline void fault(unsigned long addr)
+{
+	unsigned long val = 0;
+
+	__asm__ __volatile__ (
+	"movq %%rcx, (%%rax)\n"
+	:
+	: "a"(addr), "c"(val)
+	:);
+}
+
+
+int marker;
+
+static void guest(void)
+{
+	unsigned long addr = 0;
+
+	while (1) {
+		addr = (addr + 1) % 8;
+		fault(addr);
+		if (test_val != TEST_VAL)
+			_exit(1);
+	}
+}
+
+int main(char argc, char **argv)
+{
+	siginfo_t siginfo;
+	unsigned long long sigmask = 0xffffffff;
+	struct sigcontext ctx = {};
+	struct timespec start, cur;
+	unsigned long addr;
+	int status, ret;
+	char *stack;
+	pid_t pid;
+	long faults;
+
+	ksft_set_plan(1);
+
+	stack = mmap(NULL, TEST_STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_ANONYMOUS, 0, 0);
+	if (stack == MAP_FAILED)
+		return pr_perror("mmap");
+
+	pid  = fork();
+	if (pid == 0) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
+		marker = 789;
+		kill(getpid(), SIGSTOP);
+		abort();
+		return 0;
+	}
+
+	ctx.rip = (long)guest;
+	ctx.rsp = (long)stack + TEST_STACK_SIZE;
+	ctx.cs = 0x33;
+
+	faults = 0;
+	addr = 0;
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	while (1) {
+		addr = (addr + 1) % 8;
+
+		clock_gettime(CLOCK_MONOTONIC, &cur);
+		if (start.tv_sec + TEST_TIMEOUT < cur.tv_sec ||
+		    (start.tv_sec + TEST_TIMEOUT == cur.tv_sec &&
+		     start.tv_nsec < cur.tv_nsec))
+			break;
+
+		ret = syscall(__NR_process_vm_exec, pid, &ctx, 0, &siginfo, &sigmask, 8);
+		if (addr % 8 != ctx.rax)
+			return pr_fail("unexpected address: %lx", addr);
+		ctx.rax = (long)&test_val;
+		ctx.rcx = TEST_VAL;
+		faults++;
+	}
+	ksft_test_result_pass("%ld ns/signal\n", 1000000000 / faults);
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/process_vm_exec/process_vm_exec_syscall.c b/tools/testing/selftests/process_vm_exec/process_vm_exec_syscall.c
new file mode 100644
index 000000000000..c0a7f6ee5b1a
--- /dev/null
+++ b/tools/testing/selftests/process_vm_exec/process_vm_exec_syscall.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <signal.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
+#include <sys/user.h>
+#include <sys/uio.h>
+#include <asm/unistd.h>
+
+#include "../kselftest.h"
+#include "log.h"
+
+#ifndef __NR_process_vm_exec
+#define __NR_process_vm_exec 441
+#endif
+
+#ifndef PROCESS_VM_EXEC_SYSCALL
+#define PROCESS_VM_EXEC_SYSCALL 0x1
+#endif
+
+#define TEST_VAL 0x1e511e51
+
+int test_val = TEST_VAL;
+
+int main(int argc, char **argv)
+{
+	struct sigcontext ctx = {};
+	unsigned long long sigmask;
+	int ret, p[2], val;
+	siginfo_t siginfo;
+	pid_t pid;
+
+	ksft_set_plan(1);
+
+	pid  = fork();
+	if (pid < 0)
+		return pr_perror("fork");
+	if (pid == 0) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
+		kill(getpid(), SIGSTOP);
+		return 0;
+	}
+
+	test_val = 0;
+	if (pipe(p))
+		return pr_perror("pipe");
+
+	ctx.rax = __NR_write;
+	ctx.rdi = p[1];
+	ctx.rsi = (unsigned long) &test_val;
+	ctx.rdx = sizeof(test_val);
+	ctx.r10 = 0;
+	ctx.r8 = 0;
+	ctx.r9 = 0;
+	sigmask = 0xffffffff;
+	ret = syscall(__NR_process_vm_exec, pid, &ctx, PROCESS_VM_EXEC_SYSCALL,
+		      &siginfo, &sigmask, 8);
+	if (ret != 0)
+		return pr_perror("process_vm_exec");
+	if (siginfo.si_signo != SIGSYS)
+		return pr_fail("unexpected signal: %d", siginfo.si_signo);
+	if (ctx.rax != sizeof(test_val))
+		pr_fail("unexpected rax: %lx", ctx.rax);
+	if (kill(pid, SIGKILL))
+		return pr_perror("kill");
+	if (wait(NULL) != pid)
+		return pr_perror("kill");
+	if (read(p[0], &val, sizeof(val)) != sizeof(val))
+		pr_perror("read");
+	if (val != TEST_VAL)
+		pr_fail("unexpected data: %x", val);
+	ksft_test_result_pass("process_vm_exec(..., PROCESS_VM_EXEC_SYSCALL, ...) \n");
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/process_vm_exec/ptrace_vm_exec.c b/tools/testing/selftests/process_vm_exec/ptrace_vm_exec.c
new file mode 100644
index 000000000000..aac14c2e8f11
--- /dev/null
+++ b/tools/testing/selftests/process_vm_exec/ptrace_vm_exec.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <sys/ptrace.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <sys/user.h>
+#include <sys/uio.h>
+#include <time.h>
+
+#include "../kselftest.h"
+#include "log.h"
+
+static inline long __syscall1(long n, long a1)
+{
+	unsigned long ret;
+
+	__asm__ __volatile__ ("syscall"
+		: "=a"(ret)
+		: "a"(n), "D"(a1)
+		: "rcx", "r11", "memory");
+	return ret;
+}
+
+#define TEST_SYSCALL 444
+#define TEST_SYSCALL_RET 555
+#define TEST_MARKER 789
+#define TEST_TIMEOUT 5
+
+static int marker;
+
+static void guest(void)
+{
+	while (1) {
+		int ret;
+
+		ret = __syscall1(TEST_SYSCALL, marker);
+		if (ret != TEST_SYSCALL_RET)
+			abort();
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct user_regs_struct regs = {};
+	struct timespec start, cur;
+	int status;
+	long sysnr;
+	pid_t pid;
+
+	ksft_set_plan(1);
+
+	pid  = fork();
+	if (pid == 0) {
+		marker = TEST_MARKER;
+		kill(getpid(), SIGSTOP);
+		/* unreachable */
+		abort();
+		return 0;
+	}
+
+	if (waitpid(pid, &status, WUNTRACED) != pid)
+		return pr_perror("waidpid");
+	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
+		return pr_perror("PTRACE_ATTACH");
+	if (wait(&status) != pid)
+		return pr_perror("waidpid");
+	if (ptrace(PTRACE_CONT, pid, 0, 0))
+		return pr_perror("PTRACE_CONT");
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waidpid");
+
+	if (ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_EXITKILL))
+		return pr_perror("PTRACE_SETOPTIONS");
+	if (ptrace(PTRACE_GETREGS, pid, NULL, &regs))
+		return pr_perror("PTRACE_SETREGS");
+	regs.rip = (long)guest;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (sysnr = 0; ; sysnr++) {
+		int status;
+
+		clock_gettime(CLOCK_MONOTONIC, &cur);
+		if (start.tv_sec + TEST_TIMEOUT < cur.tv_sec ||
+		    (start.tv_sec + TEST_TIMEOUT == cur.tv_sec &&
+		     start.tv_nsec < cur.tv_nsec))
+			break;
+		if (ptrace(PTRACE_SETREGS, pid, NULL, &regs))
+			return pr_perror("PTRACE_SETREGS");
+		if (ptrace(PTRACE_SYSEMU, pid, 0, 0))
+			return pr_perror("PTRACE_SYSEMU");
+		if (waitpid(pid, &status, 0) != pid)
+			return pr_perror("waitpid");
+		if (!WIFSTOPPED(status) || WSTOPSIG(status) != SIGTRAP)
+			return pr_err("unexpected status: %d", status);
+		if (ptrace(PTRACE_GETREGS, pid, NULL, &regs))
+			return pr_perror("PTRACE_GETREGS: %d", regs.rdi);
+		if (regs.rdi != TEST_MARKER)
+			return pr_err("unexpected marker: %d", regs.rdi);
+		if (regs.orig_rax != TEST_SYSCALL)
+			return pr_err("unexpected syscall: %d", regs.orig_rax);
+		regs.rax = TEST_SYSCALL_RET;
+	}
+	ksft_test_result_pass("%ld ns/syscall\n", 1000000000 / sysnr);
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.29.2

