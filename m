Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE93D3F6E
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfJKMXu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 08:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfJKMXu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Oct 2019 08:23:50 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CCDA44BD1
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 12:23:49 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id s15so5666908edj.1
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 05:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cPBHk1mEoebcHg5P34RWIFsyAjZtXn8ix58sCjirqg=;
        b=qA+nyb4xT3cKcRo45GybhexTKA5wHr/WbxlwwY1RuGfxd7Ci6Z1RmGY9AjJDIOFBK6
         678R/0W0YU4rJyb9GNnyumuSkH5BC8911+t5vZqzGyguVWYprM8IUTT1gFpnLVl8IOvl
         eiCC1AkK3Jw2fwxkQnHFnLb2OgmoNbqyvWhlke3qPQnquy8i4DdojwcQhCbdqjPQvwbL
         CVbMFrf+arDu8r3m/aDjnWT37v2xNj1imAUNZEL2Uf7occoAtwaJcfpIKkfiMPJMneKa
         AfcleJPgPH0/wl5jVOa8hN4hbuK37YN4OD/EJmPdhJNphwaKiSTQMDrf+bktkH71nHcv
         H8ag==
X-Gm-Message-State: APjAAAWAdKp7chMt/EnH72rLpFFGK64Wh5Mbon/VNXYn0cbJkYxeN0Et
        /k6TlI3cwxHD/xdquAM+8810Mbt7B9YIW6TbPdqYIECf/Fv22YcgP1b+xn3dBgaD8AbNVvPnhhe
        ZArfTckdjQtGr37Iu7WKo
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr13234267edr.272.1570796627954;
        Fri, 11 Oct 2019 05:23:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3FaL2QqsIQ6t673/hPHNxo+RsW5gKJLm6+xJjO1xTQgAVjVXfuzs53s1wKTr2WV9wc/xbwQ==
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr13234239edr.272.1570796627703;
        Fri, 11 Oct 2019 05:23:47 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id w21sm1533538eda.90.2019.10.11.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:23:47 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] pidfd: add tests for NSpid info in fdinfo
Date:   Fri, 11 Oct 2019 14:23:21 +0200
Message-Id: <20191011122323.7770-2-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011122323.7770-1-ckellner@redhat.com>
References: <20191009160532.20674-1-ckellner@redhat.com>
 <20191011122323.7770-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Add tests that check that if pid namespaces are configured the fdinfo
file of a pidfd contains an NSpid: entry containing the process id
in the current and additionally all nested namespaces.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 tools/testing/selftests/pidfd/Makefile        |  2 +-
 tools/testing/selftests/pidfd/pidfd.h         | 12 +++
 .../selftests/pidfd/pidfd_fdinfo_test.c       | 98 +++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c    | 12 ---
 4 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 7550f08822a3..43db1b98e845 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g -I../../../../usr/include/ -pthread
 
-TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test pidfd_wait
+TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index c6bc68329f4b..2946d788645b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -84,4 +84,16 @@ static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
 }
 
+static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
+{
+	size_t stack_size = 1024;
+	char *stack[1024] = { 0 };
+
+#ifdef __ia64__
+	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
+#else
+	return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
+#endif
+}
+
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
new file mode 100644
index 000000000000..fbae502ad8ad
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+static int child_fdinfo_nspid_test(void *args)
+{
+	ksft_print_msg("Child: pid %d\n", getpid());
+	return 0;
+}
+
+static int compare_fdinfo_nspid(int pidfd, char *expect, size_t len)
+{
+	char path[512];
+	FILE *f;
+	size_t n = 0;
+	ssize_t k;
+	char *line = NULL;
+	int r = -1;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
+
+	f = fopen(path, "re");
+	if (!f)
+		return -1;
+
+	while ((k = getline(&line, &n, f)) != -1) {
+		if (strncmp(line, "NSpid:", 6))
+			continue;
+
+		line[k - 1] = '\0';
+		ksft_print_msg("Child: fdinfo NSpid line: '%s'.\n", line);
+		r = strncmp(line + 6, expect, len);
+		break;
+	}
+
+	free(line);
+	fclose(f);
+
+	return r;
+}
+
+static void test_pidfd_fdinfo_nspid(void)
+{
+	char expect[512];
+	int pid, pidfd = 0;
+	int n, r;
+	const char *test_name = "pidfd check for NSpid information in fdinfo";
+
+	pid = pidfd_clone(CLONE_PIDFD | CLONE_NEWPID | CLONE_NEWUSER, &pidfd,
+			  child_fdinfo_nspid_test);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: pidfd_clone failed (ret %d, errno %d)\n",
+			test_name, pid, errno);
+
+	ksft_print_msg("Parent: child-pid: %d\n", pid);
+
+	/* The child will have pid 1 in the new pid namespace,
+	 * so the line must be 'NSPid:\t<pid>\t1'
+	 */
+	n = snprintf(expect, sizeof(expect), "\t%d\t%d", pid, 1);
+	r = compare_fdinfo_nspid(pidfd, expect, n);
+
+	(void)close(pidfd);
+
+	if (wait_for_pid(pid))
+		ksft_exit_fail_msg(
+			"%s test: waitpid failed (ret %d, errno %d)\n",
+			test_name, r, errno);
+
+	if (r != 0)
+		ksft_exit_fail_msg("%s test: Failed\n", test_name);
+	else
+		ksft_test_result_pass("%s test: Passed\n", test_name);
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	test_pidfd_fdinfo_nspid();
+
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7aff2d3b42c0..9cf0b6b3e389 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -27,18 +27,6 @@
 
 #define MAX_EVENTS 5
 
-static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
-{
-	size_t stack_size = 1024;
-	char *stack[1024] = { 0 };
-
-#ifdef __ia64__
-	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
-#else
-	return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
-#endif
-}
-
 static int signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
-- 
2.21.0

