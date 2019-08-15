Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D6E8F0E1
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfHOQjd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43323 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732635AbfHOQjc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so2741952wrn.10
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNzlBhr0Ob2l0AvvzXZp7FfZ03no19mEjcZV68SiC50=;
        b=lEoBWr/l9/iLTMF1B/oushAubFvvDA3LFPkd6IjCGn9pgS0IFhoF9Yy2yaiE3vrLUd
         jJO0j/4Wjl/7oXtBNZTonc37HjTiRtu+0epqFejV4T/dEV6VziDEl2nMq/qEsxwhPchq
         NGeED9hcGee/REM3zl+XbxnhxIuTBjjpCGOYZ/h8C0xmYiVS7bkaQ8FQ+1AUNypn/fF7
         IUQIxCyU0+mXfUZrW3PNyoC/MQUh2lQz4DtWX+3Lo602XmB4yHvDFcTu0+dGw6UKd7AR
         3O+s12tFLZA20VTFPxHnLjSBOrZIs32CBVyGV0wHIp4g3xU0CuYYbJTxsikpKg1c5w5i
         M+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNzlBhr0Ob2l0AvvzXZp7FfZ03no19mEjcZV68SiC50=;
        b=BlspV67p7TNUrbesgvPWjFLvdddQatvH6VM5UgQ7z/e1ik53pu4c/7vnP85VG1zUBI
         qEFBlTPf0lJNS598oLNY04dSRFpJ81KB9JEdEYN2Hb01rp2mA3Nk8h2DKMQc2rbMlXq+
         78prKEnOAilp2x3ITh0dJ0hCSB8o/mMtKziz4uKD+8VE0/rd+VatL+X2S7oGwLjf+CyR
         dMzzKEVt3R5vQSshnkP7GzTvpZu6Y6sjNVCM0BINPPdaDlrWVoyTCFfXHhdUS3gLIcV4
         8jwH0kBCJNhBH1P9MvguPp//ow198XR/2fuaBzroCpCFTuNnqipddielpEw60axalGk6
         Stlg==
X-Gm-Message-State: APjAAAUiW/VO0MfkhjEmPOcITnKDiPSVNh4Ul5z+Oka7VVKQ/T693KQt
        Ojr/890m9Q5fK9bkrw2guR9STw==
X-Google-Smtp-Source: APXvYqwEpGWisP87ub3Gf8DIMP9+02IuCKI5M2LMLpWoWGUE1WsMOxFWroBwocp6qKevHT/4yVBJ+g==
X-Received: by 2002:a5d:5343:: with SMTP id t3mr6250908wrv.156.1565887169810;
        Thu, 15 Aug 2019 09:39:29 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:29 -0700 (PDT)
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
Subject: [PATCHv6 35/36] selftests/timens: Add a simple perf test for clock_gettime()
Date:   Thu, 15 Aug 2019 17:38:35 +0100
Message-Id: <20190815163836.2927-36-dima@arista.com>
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

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |   2 +
 tools/testing/selftests/timens/Makefile       |  10 +-
 tools/testing/selftests/timens/gettime_perf.c | 101 +++++++++++
 .../selftests/timens/gettime_perf_cold.c      | 160 ++++++++++++++++++
 4 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf_cold.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 3b7eda8f35ce..16292e4d08a5 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,6 @@
 clock_nanosleep
+gettime_perf
+gettime_perf_cold
 procfs
 timens
 timer
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index ae1ffd24cc43..97e0460eaf48 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,6 +1,12 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+ifeq ($(ARCH),x86_64)
+TEST_GEN_PROGS += gettime_perf_cold
+endif
 
 CFLAGS := -Wall -Werror
-LDFLAGS := -lrt
+LDFLAGS := -lrt -ldl
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 000000000000..f7d7832c0293
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <dlfcn.h>
+
+#include "log.h"
+#include "timens.h"
+
+//#define TEST_SYSCALL
+
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
+static void fill_function_pointers(void)
+{
+	void *vdso = dlopen("linux-vdso.so.1",
+			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-gate.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso) {
+		pr_err("[WARN]\tfailed to find vDSO\n");
+		return;
+	}
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		pr_err("Warning: failed to find clock_gettime in vDSO\n");
+
+}
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+#ifndef TEST_SYSCALL
+	vdso_clock_gettime(clockid, &start);
+#else
+	syscall(__NR_clock_gettime, clockid, &start);
+#endif
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+#ifndef TEST_SYSCALL
+		vdso_clock_gettime(clockid, &tp);
+#else
+		syscall(__NR_clock_gettime, clockid, &tp);
+#endif
+	}
+
+	ksft_test_result_pass("%s:\tclock: %10s\tcycles:\t%10ld\n",
+			      in_ns ? "ns" : "host", clockstr, i);
+}
+
+int main(int argc, char *argv[])
+{
+	time_t offset = 10;
+	int nsfd;
+
+	ksft_set_plan(4);
+
+	fill_function_pointers();
+
+	test(CLOCK_MONOTONIC, "monotonic", false);
+	test(CLOCK_BOOTTIME, "boottime", false);
+
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic", true);
+	test(CLOCK_BOOTTIME, "boottime", true);
+
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/timens/gettime_perf_cold.c b/tools/testing/selftests/timens/gettime_perf_cold.c
new file mode 100644
index 000000000000..2ab0869744a6
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf_cold.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <dlfcn.h>
+#include <signal.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define PAGE_SIZE 4096
+#define CACHE_LINE_SIZE 64
+
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
+static void fill_function_pointers(void)
+{
+	void *vdso = dlopen("linux-vdso.so.1",
+			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-gate.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso) {
+		pr_err("[WARN]\tfailed to find vDSO\n");
+		return;
+	}
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		pr_err("Warning: failed to find clock_gettime in vDSO\n");
+
+}
+
+static inline __attribute__((always_inline)) unsigned long long rdtsc(void)
+{
+	unsigned int hi, lo;
+
+	__asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
+	return ((unsigned long long) lo) | (((unsigned long long)hi) << 32);
+}
+
+static inline __attribute__((always_inline)) void test(clock_t clockid, char *clockstr)
+{
+	struct timespec tp;
+	long long s, e;
+
+	s = rdtsc();
+	vdso_clock_gettime(clockid, &tp);
+	e = rdtsc();
+	printf("%lld\n", e - s);
+}
+
+static inline void clflush(volatile void *__p)
+{
+	asm volatile("clflush %0" : "+m"(*(volatile char *)__p));
+}
+
+void *pg_addr;
+void sigh(int sig)
+{
+	void *addr;
+
+	addr = mmap(pg_addr, PAGE_SIZE, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	if (addr != pg_addr) {
+		pr_perror("Unable to map %lx", (long) pg_addr);
+		exit(1);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	time_t offset = 10;
+	void *vdso_start = 0, *vdso_end = 0;
+	void *vvar_start = 0, *vvar_end = 0;
+	char buf[PAGE_SIZE];
+	int nsfd, i;
+	FILE *maps;
+
+	fill_function_pointers();
+	if (argc == 1)
+		goto out;
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+out:
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) {
+		pr_perror("Unable to open /proc/self/maps");
+		return 1;
+	}
+
+	while (fgets(buf, sizeof(buf), maps)) {
+		unsigned long start, end;
+		char tail[PAGE_SIZE];
+		int r;
+
+		r = sscanf(buf, "%lx-%lx %*s %*s %*s %*s %s\n", &start, &end, tail);
+
+		if (r < 3)
+			continue;
+
+		if (strcmp(tail, "[vdso]") == 0) {
+			vdso_start = (void *)start;
+			vdso_end = (void *)end;
+		}
+		if (strcmp(tail, "[vvar]") == 0) {
+			vvar_start = (void *)start;
+			vvar_end = (void *)end;
+		}
+	}
+	if (!vvar_start || !vdso_start) {
+		pr_err("Unable to find vdso\n");
+		return 1;
+	}
+
+	/* Map zero pages instead of unreadable vdso pages. */
+	signal(SIGSEGV, sigh);
+	signal(SIGBUS, sigh);
+	for (pg_addr = vdso_start; pg_addr < vdso_end; pg_addr += PAGE_SIZE)
+		buf[0] += *(char *)pg_addr;
+	for (pg_addr = vvar_start; pg_addr < vvar_end; pg_addr += PAGE_SIZE)
+		buf[0] += *(char *)pg_addr;
+	signal(SIGSEGV, SIG_DFL);
+	signal(SIGBUS, SIG_DFL);
+
+	for (i = 0; i < 10240; i++) {
+		void *p;
+
+		for (p = vdso_start; p < vdso_end; p += CACHE_LINE_SIZE)
+			clflush(p);
+		for (p = vvar_start; p < vvar_end; p += CACHE_LINE_SIZE)
+			clflush(p);
+		test(CLOCK_MONOTONIC, "monotonic");
+	}
+	return 0;
+}
-- 
2.22.0

