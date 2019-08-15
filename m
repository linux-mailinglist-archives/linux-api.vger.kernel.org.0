Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CD8F0E7
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfHOQjx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36748 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732561AbfHOQj0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so1780757wme.1
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFCLc/qMrToYwcRbXkH1oKDfgQ/rpvEwCtqObCnJ8as=;
        b=ltSVvab9eB7+umHiQbvSFIuWuQ01j/GeQLlRzGyy8RGbO1xXilPNiimjEwy0qr2jmD
         BxFlD7c1GjL9Jp1xbezOcp9tE0UhmMs+vAInXSlAYQG3aPgk2tlczAdMt6mqjhPowOn4
         Se6OwmYCur5mwxy04Hi5Vg1CXrPBSusFKiORR2atJrXIEG/PeRI4TuUbcndi7VScukxL
         4GP/Lom5G/w4+lGM3NRtob393YkdKMlMWx5Bgqt9P+EuoI2UR3Uc3aR9FB9U0Zm9LefQ
         HYvbXKvOHstZ2aSA/7KJgBbx+i+0+sfWx0wOscSuUo4mwrGxgzeQxRpCraq9jEkF2gSL
         I+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFCLc/qMrToYwcRbXkH1oKDfgQ/rpvEwCtqObCnJ8as=;
        b=NpR57HCroGhcHw4dt28s/PEl7sS2Kt4CIozgCV3q3grCQX2xNzgQKkqOUN/dfHWWSW
         /ZcjraYupVD3oF7WW7yv0wnrWbC9BghYt5WoAU0F0or+qTLIpDce8anta2qhKaFhL3UK
         Jm71O2Pt4aMQGt/J2kgy0fEt2VuEzoItKDqVAUd6CieMQMsnSQp+QPZHgrO4un8ScqtF
         Izwjim9GV8BBf7o1zyXYtaSDTkAUY6MPTB48dJqI6Xpcik8gHcdJCq+CxOPxlBVbGKC6
         3DTLuxMQSKN7DlKY3GNYSFCcQam9bXC4OsntDa/Qb22AAhFOOn+N0RQUU3pzaiu6tElE
         vGfA==
X-Gm-Message-State: APjAAAW2rHiG/WVQTpvOi/kC5kiePvNYW0ONQNEIyBnJoyQTuNFtXkqA
        F+d+3HbLWsAkuNwHfyIWE5GFAA==
X-Google-Smtp-Source: APXvYqxxcfcq6eC4U4RxIqeeuG3bObDUjhvAnupIAvjPzVFh+oLhFaVy1oH1zi46KDhEJdWBt8TmEA==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr3524043wml.77.1565887162529;
        Thu, 15 Aug 2019 09:39:22 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:22 -0700 (PDT)
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 30/36] selftest/timens: Add Time Namespace test for supported clocks
Date:   Thu, 15 Aug 2019 17:38:30 +0100
Message-Id: <20190815163836.2927-31-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A test to check that all supported clocks work on host and inside
a new time namespace. Use both ways to get time: through VDSO and
by entering the kernel with implicit syscall.

Introduce a new timens directory in selftests framework for
the next timens tests.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   5 +
 tools/testing/selftests/timens/config     |   1 +
 tools/testing/selftests/timens/log.h      |  26 +++
 tools/testing/selftests/timens/timens.c   | 185 ++++++++++++++++++++++
 tools/testing/selftests/timens/timens.h   |  63 ++++++++
 7 files changed, 282 insertions(+)
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timens.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 25b43a8c2b15..6fc63b84a857 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -47,6 +47,7 @@ TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
 TARGETS += sysctl
+TARGETS += timens
 ifneq (1, $(quicktest))
 TARGETS += timers
 endif
diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
new file mode 100644
index 000000000000..27a693229ce1
--- /dev/null
+++ b/tools/testing/selftests/timens/.gitignore
@@ -0,0 +1 @@
+timens
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
new file mode 100644
index 000000000000..b877efb78974
--- /dev/null
+++ b/tools/testing/selftests/timens/Makefile
@@ -0,0 +1,5 @@
+TEST_GEN_PROGS := timens
+
+CFLAGS := -Wall -Werror
+
+include ../lib.mk
diff --git a/tools/testing/selftests/timens/config b/tools/testing/selftests/timens/config
new file mode 100644
index 000000000000..4480620f6f49
--- /dev/null
+++ b/tools/testing/selftests/timens/config
@@ -0,0 +1 @@
+CONFIG_TIME_NS=y
diff --git a/tools/testing/selftests/timens/log.h b/tools/testing/selftests/timens/log.h
new file mode 100644
index 000000000000..db64df2a8483
--- /dev/null
+++ b/tools/testing/selftests/timens/log.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_TIMENS_LOG_H__
+#define __SELFTEST_TIMENS_LOG_H__
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
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+#endif
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
new file mode 100644
index 000000000000..55d38f02eb64
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+struct test_clock {
+	clockid_t id;
+	char *name;
+	/*
+	 * off_id is -1 if a clock has own offset, or it contains an index
+	 * which contains a right offset of this clock.
+	 */
+	int off_id;
+	time_t offset;
+};
+
+#define ct(clock, off_id)	{ clock, #clock, off_id }
+static struct test_clock clocks[] = {
+	ct(CLOCK_BOOTTIME, -1),
+	ct(CLOCK_BOOTTIME_ALARM, 1),
+	ct(CLOCK_MONOTONIC, -1),
+	ct(CLOCK_MONOTONIC_COARSE, 1),
+	ct(CLOCK_MONOTONIC_RAW, 1),
+};
+#undef ct
+
+static int child_ns, parent_ns = -1;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME)) {
+		pr_perror("setns()");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	if (parent_ns == -1) {
+		parent_ns = open(path, O_RDONLY);
+		if (parent_ns <= 0)
+			return pr_perror("Unable to open %s", path);
+	}
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
+		return pr_perror("The same child_ns after CLONE_NEWTIME");
+
+	return 0;
+}
+
+static int test_gettime(clockid_t clock_index, bool raw_syscall, time_t offset)
+{
+	struct timespec child_ts_new, parent_ts_old, cur_ts;
+	char *entry = raw_syscall ? "syscall" : "vdso";
+	double precision = 0.0;
+
+	switch (clocks[clock_index].id) {
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_MONOTONIC_RAW:
+		precision = -2.0;
+		break;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index].id, &parent_ts_old, raw_syscall))
+		return -1;
+
+	child_ts_new.tv_nsec = parent_ts_old.tv_nsec;
+	child_ts_new.tv_sec = parent_ts_old.tv_sec + offset;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index].id, &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, child_ts_new.tv_sec) < precision) {
+		ksft_test_result_fail(
+			"Child's %s (%s) time has not changed: %lu -> %lu [%lu]\n",
+			clocks[clock_index].name, entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		return -1;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (_gettime(clocks[clock_index].id, &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, parent_ts_old.tv_sec) > DAY_IN_SEC) {
+		ksft_test_result_fail(
+			"Parent's %s (%s) time has changed: %lu -> %lu [%lu]\n",
+			clocks[clock_index].name, entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		/* Let's play nice and put it closer to original */
+		clock_settime(clocks[clock_index].id, &cur_ts);
+		return -1;
+	}
+
+	ksft_test_result_pass("Passed for %s (%s)\n",
+				clocks[clock_index].name, entry);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int i;
+	time_t offset;
+	int ret = 0;
+
+	nscheck();
+
+	ksft_set_plan(ARRAY_SIZE(clocks) * 2);
+
+	if (init_namespaces())
+		return 1;
+
+	/* Offsets have to be set before tasks enter the namespace. */
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (clocks[i].off_id != -1)
+			continue;
+		offset = TEN_DAYS_IN_SEC + i * 1000;
+		clocks[i].offset = offset;
+		if (_settime(clocks[i].id, offset))
+			return 1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (clocks[i].off_id != -1)
+			offset = clocks[clocks[i].off_id].offset;
+		else
+			offset = clocks[i].offset;
+		ret |= test_gettime(i, true, offset);
+		ret |= test_gettime(i, false, offset);
+	}
+
+	if (ret)
+		ksft_exit_fail();
+
+	ksft_exit_pass();
+	return !!ret;
+}
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
new file mode 100644
index 000000000000..77c127384810
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TIMENS_H__
+#define __TIMENS_H__
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME	0x00000080
+#endif
+
+static inline int _settime(clockid_t clk_id, time_t offset)
+{
+	int fd, len;
+	char buf[4096];
+
+	if (clk_id == CLOCK_MONOTONIC_COARSE || clk_id == CLOCK_MONOTONIC_RAW)
+		clk_id = CLOCK_MONOTONIC;
+
+	len = snprintf(buf, sizeof(buf), "%d %ld 0", clk_id, offset);
+
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+
+	return 0;
+}
+
+static inline int _gettime(clockid_t clk_id, struct timespec *res, bool raw_syscall)
+{
+	int err;
+
+	if (!raw_syscall) {
+		if (clock_gettime(clk_id, res)) {
+			pr_perror("clock_gettime(%d)", (int)clk_id);
+			return -1;
+		}
+		return 0;
+	}
+
+	err = syscall(SYS_clock_gettime, clk_id, res);
+	if (err)
+		pr_perror("syscall(SYS_clock_gettime(%d))", (int)clk_id);
+
+	return err;
+}
+
+static inline void nscheck(void)
+{
+	if (access("/proc/self/ns/time", F_OK) < 0)
+		ksft_exit_skip("Time namespaces are not supported\n");
+}
+
+#endif
-- 
2.22.0

