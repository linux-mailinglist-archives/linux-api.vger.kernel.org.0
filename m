Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7378F42FF3
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfFLT1M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:12 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40568 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbfFLT1K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:27:10 -0400
Received: by mail-wr1-f51.google.com with SMTP id p11so18145344wre.7
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqvh4DCvN+dpRdu4XtCpb1xeAeOGsGHxSesMUE8fBGU=;
        b=G5PkHOwTJ1qAeRt/jn5YsrAe6uCf0bloQ8xkxMUDT/S2AISYS8tjd10LmwYS4gkzCK
         KYo8pDM6B8OY85DbmAiNWh3+O8CSCB3XO46miXK1sKHSeLQfl8Epm5tTq3/map6xOLaW
         F9BktswdbSVTnJp2uZSgvUko2ddtTUtF1W30799iGDm9eEomoY4FZ9AE2WjRFy6K1OyP
         m/519MrHr0I9pJoM5cKx0VRr8CDuq4MBL1nm4zq8zCrsVrGjEOei5U+VKPMrtf9xbBhB
         8ltLsZn97e6Te/7O5pWaojPooGwG2GTLQJI5z6+2AMMG4TmKUPVmgSWuQxvtt8Ab5c+e
         xj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqvh4DCvN+dpRdu4XtCpb1xeAeOGsGHxSesMUE8fBGU=;
        b=QBG8wufDgRxbUxrrKVXFj9o7SdvKFWG/7egX1t+l4nCXJgXOiTkQIjzFUp1p1O1isD
         ur1xGsIeVbOqRk6VS31BEQ+cbmmnqZRNw3NdxKnxoh9s0wZHSYlZAJvjdDjzHS60ofzO
         j3ZjbDqd95BhfSSST0ngyoWxRy1Bxyf6I033ENlqr9SI4LVypR4Y31dLuCaVcvfsxlP5
         69MI/ndgpVHvK3zEV3PJ8aVYZIDz2OW2Nzh8S4MKEd2tL31gvOncNq2ZGAyJI/rfxAZb
         HhBRRhx45GX/pnh90vQfUIn9ofgKLOjvGPqjvPsBPAkw1diGBySybvmFFf+q1jxXYFVV
         bnnQ==
X-Gm-Message-State: APjAAAVTtcLpoZ161eJ8qhScQgxBDQFyAYY9uSWmpLhuzVnU8CnYzwRs
        zUQJLkX1G83wz8dzdVPzMORvYw==
X-Google-Smtp-Source: APXvYqzEnIeTzBmGRXg3sjTooSqX8eqWYJ5HbneB5PZByk2SxZGW56Qz2ynTI4i5ZS6YBfS1e+5OYg==
X-Received: by 2002:adf:f50c:: with SMTP id q12mr28232476wro.300.1560367629151;
        Wed, 12 Jun 2019 12:27:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:08 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 27/28] selftests: Add a simple perf test for clock_gettime()
Date:   Wed, 12 Jun 2019 20:26:26 +0100
Message-Id: <20190612192628.23797-28-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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
 tools/testing/selftests/timens/.gitignore     |  2 +
 tools/testing/selftests/timens/Makefile       |  8 +-
 tools/testing/selftests/timens/gettime_perf.c | 74 +++++++++++++++++++
 .../selftests/timens/gettime_perf_cold.c      | 63 ++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)
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
index ae1ffd24cc43..ef65bf96b55c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,10 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+ifeq ($(ARCH),x86_64)
+TEST_GEN_PROGS += gettime_perf_cold
+endif
 
 CFLAGS := -Wall -Werror
 LDFLAGS := -lrt
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 000000000000..510d77a941d9
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,74 @@
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
+
+#include "log.h"
+#include "timens.h"
+
+//#define TEST_SYSCALL
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+#ifndef TEST_SYSCALL
+	clock_gettime(clockid, &start);
+#else
+	syscall(__NR_clock_gettime, clockid, &start);
+#endif
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+#ifndef TEST_SYSCALL
+		clock_gettime(clockid, &tp);
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
index 000000000000..f72db8a4c903
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf_cold.c
@@ -0,0 +1,63 @@
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
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+static __inline__ unsigned long long rdtsc(void)
+{
+	unsigned hi, lo;
+
+	__asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
+	return ((unsigned long long) lo) | (((unsigned long long)hi) << 32);
+}
+
+static void test(clock_t clockid, char *clockstr)
+{
+	struct timespec tp;
+	long long s, e;
+
+	s = rdtsc();
+	clock_gettime(clockid, &tp);
+	e = rdtsc();
+	printf("%lld\n", e - s);
+	return;
+}
+
+int main(int argc, char **argv)
+{
+	time_t offset = 10;
+	int nsfd;
+
+	if (argc == 1) {
+		test(CLOCK_MONOTONIC, "monotonic");
+		return 0;
+	}
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
+	test(CLOCK_MONOTONIC, "monotonic");
+	return 0;
+}
-- 
2.22.0

