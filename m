Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBD79BC6
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbfG2V6y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37604 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbfG2V6x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so54780093wme.2
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNzlBhr0Ob2l0AvvzXZp7FfZ03no19mEjcZV68SiC50=;
        b=EFGoFRolRgMSHSfkVg6shq2tfnoDbHJyLg8LLbwY/04x713ZXmiFgW/iC0QXgb+rku
         7Y7MPa6cliqPRtfHD3zAd8KrgynwGagQIeY/uXSwITDUPq6Lw9Sxy8c9VvTmi0Zvbziq
         xih1+j0PLHo0SSxzG6asdTolt8OCDTuJJ/f3r6IywQJ/lPaPciq7IPyyaC+KybBSzgVl
         0j96H5D6m+uKRa4hZRCFHotU6MOPQhqkXrrCv4r9ruPCESPFA9U7hqgi/aTyQMjCGgb9
         gjeyHwJ4lvALPQxwbEG7ztSw2Y70f3VIEwunrXZYicpoaODxKLCaLPBiBHSKH+cvQTEx
         fakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNzlBhr0Ob2l0AvvzXZp7FfZ03no19mEjcZV68SiC50=;
        b=V1RSCQkIzIegflcW1l10rRpHTDt0sW5pm1xi0FCTkLoEgfHyxIIf9ekPYyyrL9l/ww
         NxJd9hfQYQyVeWdRj+pN+qLePDpSc2dzT5ZuOwQ2dk/vrCjxWiL0/ggWaHK6X2d9JpUg
         /YSwh+pH7uRJfiAmEmP60jtbHfj0LjSaZVPxr/lMgwTf043BvQuSCc2ztwt3nOjvuJy+
         Z3bD9Z0fXJTlFi+hyE1nsMbw+IY51s/nTHFFqVgaGKeMy9kOQjtKzFF5HN3xxLfalVcP
         28GBSPLhcBHO5yM5Ys4wxSBksELBEAXKthwjh6CRlBPh+y3VubXs7hjPqtN8pBCFBXST
         vOzA==
X-Gm-Message-State: APjAAAWAU0HDksROfNSN2MatU4ctxH8EUL5vWVQrPqe4jBHyuSW0hZrH
        4xJwLKsmNgyjVVJjFIaN8C44sdwSP7/7/ZbVrPaOD9ST2XijvpT1U70pgEii1b1tKTB87ko+H04
        cCEolAPV5fo/1us++wpMR8o8XWfRehQFhjgH5sQi2QBhtSEieqI9aiWuVvAGsk0+Iuo5sPSvbQX
        M9Nhq0QBwGCpZAm0ymgXMh9Fd6Nw==
X-Google-Smtp-Source: APXvYqzOWkDvQUPdUF4Iov0t2dpgrbWS0HxdIT3HERvg7uGzFtCXMMH2uo7ibuqrLBCjyOEhbY2BJg==
X-Received: by 2002:a1c:e710:: with SMTP id e16mr103936443wmh.38.1564437530322;
        Mon, 29 Jul 2019 14:58:50 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:49 -0700 (PDT)
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
Subject: [PATCHv5 36/37] selftests/timens: Add a simple perf test for clock_gettime()
Date:   Mon, 29 Jul 2019 22:57:18 +0100
Message-Id: <20190729215758.28405-37-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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

