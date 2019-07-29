Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022F079BEF
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfG2V6u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51319 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389166AbfG2V6t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so55201946wma.1
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNJxm2QMtZcp14624QbakT+mhmccQwYHPQgZhw4FCC0=;
        b=Zhx0iZ7mRqW5plMP0JwzBNNA2fyOBmx9Mi6BehgBdC6t3A7RO4x0BV+iXqhYgP0arJ
         87pZcLLmM/5XoSeA+hAZeVgUZjrOa2/NQCAEbo6WcMh3b5g6ecOfU/qcUERBJx/5xG7n
         tKKuqaYxG9jtbxjCKayrilNZcQIhn5//TfcYXDCLWEdGmB7uj4te9NLyxz1tDPl98TWX
         ErPoePEenNDdLrF/RWhQ44yGhASRapz2HBS8V6rcL/KfzNGDoK1vDGoPOM0v2/8b5T96
         /X1RVqoKfGnAIdzEKTAggevQTtav7YaqxydXcf0vahGnXlAB1ncaqzYRzeojOgnCgDy0
         gWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNJxm2QMtZcp14624QbakT+mhmccQwYHPQgZhw4FCC0=;
        b=R4Cc/AN0BlQkXocWh1B8S2h2hs2kqpfGcRTBtV4Hk4BJ4pYI3pRgHRG+niceR66C5i
         le94XW4QoHX1KmhSG+pxDrJ97/E0XZbxKHuKxSEQ9JNVMEQWL24F5HRGN2MwN4ZpgzBI
         cUbrbwwwVF5rDVdgiNNh/OnnKc7BUH1+7Gqb6M/MKjWB10Tn/47euVUDzzLl8OjKORQR
         sp8e7EleAM7jIGn2YRffANVlQ4u9YWfQo1nXi9QjSFmCpvvqUnFRyyWPcUBvJDZw17fA
         l280cuboMDZK8BEUQ6/mEphhBA1ltYUIk1eyifzQ2bLtRNCzQFQ0HhMYnZ9LURlTwBmE
         9RGg==
X-Gm-Message-State: APjAAAV+jHVIGlM+cxLyPxHLQ9wA5kVpG5XpOov0JGhuJcDQfIyKeM+V
        joVVMYTQ3FLW7bpNjXv/d2l3I3esLdB6W3zQzhLby/J5Yd2NYwfQ/1Bp2S9ZKLNn2KhKYnuvncG
        S8CraeViRCD8gIwvfWOOk50VcM9akZt5sTEYhDu2xGOB/cT6Jq0RWagGBEk1yzBtGGElXHeMDQn
        0CYcj7M/w28dDo5Boy9cT813Iqaw==
X-Google-Smtp-Source: APXvYqyluUlQAg8Wgl5MSHJ6lwIVc3mHZlagGCIdEXadDvYVIzpFNHeljG3eh67ALsErB9TwWW/dPQ==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr105848941wmg.28.1564437527184;
        Mon, 29 Jul 2019 14:58:47 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:46 -0700 (PDT)
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
Subject: [PATCHv5 34/37] selftest/timens: Add procfs selftest
Date:   Mon, 29 Jul 2019 22:57:16 +0100
Message-Id: <20190729215758.28405-35-dima@arista.com>
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

