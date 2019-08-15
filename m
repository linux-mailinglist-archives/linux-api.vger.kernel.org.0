Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E98F0DD
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbfHOQj3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40676 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbfHOQj3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so2759193wrd.7
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNJxm2QMtZcp14624QbakT+mhmccQwYHPQgZhw4FCC0=;
        b=Re/ccRVj6uveaZFzmN7SNBWwJ4tAjTCz8vLPc8plMX10YUl5P5m9FP1ONkuI7LkpPm
         1+w6PSOH80umvi+inVFHF1zT0uTEJZFEPF3/MJNEub112F2QziqYo0q9BXrNxfB8L/ma
         tzANJGEACqjB10xHHus/015CP0mmJ8XutOpGYMH8YU81PA5SnVphSdSIgdtNryBV+DQJ
         b87K9cbSpiasACxRjJJQ6IoDoS+WgvhPAJNxgaqYLulT7WtEJ3sfdb03RjhBQ384HZ46
         4GaXUSCaty9ucAV3kQ4XovF3CaeDNtIQehBfzOtlX/PLz7Fkf4sSFDJw54ITzHiI8fnH
         aq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNJxm2QMtZcp14624QbakT+mhmccQwYHPQgZhw4FCC0=;
        b=gAQoaoVqkgbl9h8+Yf9aMp3njs/+9bXJ1R0KM/XVWvv6AZkxwherJYHrTmDXXH2AXQ
         Xj457E0VLZCLtBCvE8mtmemOI9wNVX0rKsz9/mxlfh6FAUw3DTmqFMjFxqoIimOBOZqG
         YXbMeWqUPvsOqqwAYLpqzgsitZyQHM27fig/do72SPA9bvTrymPKYy7xIevZBBTA3l2J
         P0ikDiVS5KNj4fnRz7qsMHIPcoJwdyy1NO/XPcLaDh5Ss49Y/FT/MTUHhpng8BXYEave
         5ia3URyfG4yUCmlOvzexRtYs5XhOmOsRvOPdMopk+wH5G6NjI9tVklQaGdLlxfoYKKT5
         4Iaw==
X-Gm-Message-State: APjAAAXp1G3fKa1PZdlB+kiqMDcGmBqOxLzkFi2FDUYpkC0Y/kwvDygd
        79gGFyVqXB3LGShniEZ1VDNNSg==
X-Google-Smtp-Source: APXvYqw3fZJ3iyUouHJ8nFwyilGjr1T2hb1aa+sQleUr6TTLPfUpz6FgB0H4htJUIadaJKqKU/hRgg==
X-Received: by 2002:adf:e790:: with SMTP id n16mr6226156wrm.120.1565887166646;
        Thu, 15 Aug 2019 09:39:26 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:26 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv6 33/36] selftest/timens: Add procfs selftest
Date:   Thu, 15 Aug 2019 17:38:33 +0100
Message-Id: <20190815163836.2927-34-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Check that /proc/uptime is correct inside a new time namespace.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/procfs.c   | 144 ++++++++++++++++++++++
 3 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/procfs.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 9b6c8ddac2c8..94ffdd9cead7 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,3 +1,4 @@
 clock_nanosleep
+procfs
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 76a1dc891184..f96f50d1fef8 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep
+TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
new file mode 100644
index 000000000000..3c3c6e634d50
--- /dev/null
+++ b/tools/testing/selftests/timens/procfs.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <math.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define MAX_TEST_TIME_SEC		(60*5)
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static int child_ns, parent_ns;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME))
+		return pr_perror("setns()");
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	parent_ns = open(path, O_RDONLY);
+	if (parent_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_err("The same child_ns after CLONE_NEWTIME");
+
+	if (_settime(CLOCK_BOOTTIME, TEN_DAYS_IN_SEC))
+		return -1;
+
+	return 0;
+}
+
+static int read_proc_uptime(struct timespec *uptime)
+{
+	unsigned long up_sec, up_nsec;
+	FILE *proc;
+
+	proc = fopen("/proc/uptime", "r");
+	if (proc == NULL) {
+		pr_perror("Unable to open /proc/uptime");
+		return -1;
+	}
+
+	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
+		if (errno) {
+			pr_perror("fscanf");
+			return -errno;
+		}
+		pr_err("failed to parse /proc/uptime");
+		return -1;
+	}
+	fclose(proc);
+
+	uptime->tv_sec = up_sec;
+	uptime->tv_nsec = up_nsec;
+	return 0;
+}
+
+static int check_uptime(void)
+{
+	struct timespec uptime_new, uptime_old;
+	time_t uptime_expected;
+	double prec = MAX_TEST_TIME_SEC;
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (read_proc_uptime(&uptime_old))
+		return 1;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (read_proc_uptime(&uptime_new))
+		return 1;
+
+	uptime_expected = uptime_old.tv_sec + TEN_DAYS_IN_SEC;
+	if (fabs(difftime(uptime_new.tv_sec, uptime_expected)) > prec) {
+		pr_fail("uptime in /proc/uptime: old %ld, new %ld [%ld]",
+			uptime_old.tv_sec, uptime_new.tv_sec,
+			uptime_old.tv_sec + TEN_DAYS_IN_SEC);
+		return 1;
+	}
+
+	ksft_test_result_pass("Passed for /proc/uptime\n");
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	if (init_namespaces())
+		return 1;
+
+	ret |= check_uptime();
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
-- 
2.22.0

