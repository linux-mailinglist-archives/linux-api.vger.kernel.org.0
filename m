Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0665D672B
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbfJNQVk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 12:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbfJNQVk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 Oct 2019 12:21:40 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4056485543
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 16:21:39 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id l9so10488496edi.8
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 09:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtUIgbdeIrKEU86WG+XAaLfv7v+d3INsqWNoyXYUh1I=;
        b=AMM5aGWXJzO6NZ0z27uoBmtqDf3A+O1md3uj96CDALzraKz2KHEUKvlvwRzV8w59Xo
         ETPmiy3/dRMpcGy5fjxin7ecoZds7MGqREfQYwdHc1h1AX7ipclfm5Lpys5KxQL+Y1yX
         daUmAt/AR0xg5H8nrM1chwxnkA7ID+nRB1q8n+sDdQsRmdQRWiSUnqhCU4W8OY6KqiIj
         S+CvIsamZBww0SLohdnnETVhndlGpfo5WoHZZvWrsrUhFVUsq6bD3BT6jUfejoGP9EoA
         Wemyg5Ds4Ksaqlv5BCCJbiAXVMzfWwCd9HkUZjqhKvdm3U3k1vZ+y8WqVYh2x4ebFSHf
         2q6g==
X-Gm-Message-State: APjAAAWfQnEY9kIYQo41FwXXjPDgL7a7x+3gNkEYCbwyGNah8r6aufTQ
        AN06wnu0B17KQbIHCrHSvankEDjl7K/X1pxPtJo1lUi0Jda23d00SfYn+nqiHXTbjxcTinybYI3
        RrUQbOtvYuVJ9qav+vQl0
X-Received: by 2002:a17:906:5e49:: with SMTP id b9mr29550195eju.255.1571070097863;
        Mon, 14 Oct 2019 09:21:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTMjSFKIg/YGx+cLs2qoqA8k5lHs6tkj/1SoPBpi6LXL4ttgZBFUeqz2tsdXNaYZXrsPDiNQ==
X-Received: by 2002:a17:906:5e49:: with SMTP id b9mr29550175eju.255.1571070097502;
        Mon, 14 Oct 2019 09:21:37 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id bq13sm2355909ejb.25.2019.10.14.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:21:36 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Jann Horn <jannh@google.com>,
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
Subject: [PATCH v4 2/2] pidfd: add tests for NSpid info in fdinfo
Date:   Mon, 14 Oct 2019 18:20:33 +0200
Message-Id: <20191014162034.2185-2-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191014162034.2185-1-ckellner@redhat.com>
References: <20191011122323.7770-1-ckellner@redhat.com>
 <20191014162034.2185-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Add a test that checks that if pid namespaces are configured the fdinfo
file of a pidfd contains an NSpid: entry containing the process id in
the current and additionally all nested namespaces. In the case that
a pidfd is from a pid namespace not in the same namespace hierarchy as
the process accessing the fdinfo file, ensure the 'NSpid' shows 0 for
that pidfd, analogous to the 'Pid' entry.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
Changes in v4:
- Rework to test include a the situation where the fdinfo for a pidfd
  of a process in a sibling pid namespace is being read and ensure
  the NSpid field only contains one entry, being 0.

 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../selftests/pidfd/pidfd_fdinfo_test.c       | 265 ++++++++++++++++++
 2 files changed, 266 insertions(+), 1 deletion(-)
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
 
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
new file mode 100644
index 000000000000..3721be994abd
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <assert.h>
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
+struct error {
+	int  code;
+	char msg[512];
+};
+
+static int error_set(struct error *err, int code, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	if (code == PIDFD_PASS || !err || err->code != PIDFD_PASS)
+		return code;
+
+	err->code = code;
+	va_start(args, fmt);
+	r = vsnprintf(err->msg, sizeof(err->msg), fmt, args);
+	assert((size_t)r < sizeof(err->msg));
+	va_end(args);
+
+	return code;
+}
+
+static void error_report(struct error *err, const char *test_name)
+{
+	switch (err->code) {
+	case PIDFD_ERROR:
+		ksft_exit_fail_msg("%s test: Fatal: %s\n", test_name, err->msg);
+		break;
+
+	case PIDFD_FAIL:
+		/* will be: not ok %d # error %s test: %s */
+		ksft_test_result_error("%s test: %s\n", test_name, err->msg);
+		break;
+
+	case PIDFD_SKIP:
+		/* will be: not ok %d # SKIP %s test: %s */
+		ksft_test_result_skip("%s test: %s\n", test_name, err->msg);
+		break;
+
+	case PIDFD_XFAIL:
+		ksft_test_result_pass("%s test: Expected failure: %s\n",
+				      test_name, err->msg);
+		break;
+
+	case PIDFD_PASS:
+		ksft_test_result_pass("%s test: Passed\n");
+		break;
+
+	default:
+		ksft_exit_fail_msg("%s test: Unknown code: %d %s\n",
+				   test_name, err->code, err->msg);
+		break;
+	}
+}
+
+static inline int error_check(struct error *err, const char *test_name)
+{
+	/* In case of error we bail out and terminate the test program */
+	if (err->code == PIDFD_ERROR)
+		error_report(err, test_name);
+
+	return err->code;
+}
+
+struct child {
+	pid_t pid;
+	int   fd;
+};
+
+static struct child clone_newns(int (*fn)(void *), void *args,
+				struct error *err)
+{
+	static int flags = CLONE_PIDFD | CLONE_NEWPID | CLONE_NEWNS | SIGCHLD;
+	size_t stack_size = 1024;
+	char *stack[1024] = { 0 };
+	struct child ret;
+
+	if (!(flags & CLONE_NEWUSER) && geteuid() != 0)
+		flags |= CLONE_NEWUSER;
+
+#ifdef __ia64__
+	ret.pid = __clone2(fn, stack, stack_size, flags, args, &ret.fd);
+#else
+	ret.pid = clone(fn, stack + stack_size, flags, args, &ret.fd);
+#endif
+
+	if (ret.pid < 0) {
+		error_set(err, PIDFD_ERROR, "clone failed (ret %d, errno %d)",
+			  ret.fd, errno);
+		return ret;
+	}
+
+	ksft_print_msg("New child: %d, fd: %d\n", ret.pid, ret.fd);
+
+	return ret;
+}
+
+static inline int child_join(struct child *child, struct error *err)
+{
+	int r;
+
+	(void)close(child->fd);
+	r = wait_for_pid(child->pid);
+	if (r < 0)
+		error_set(err, PIDFD_ERROR, "waitpid failed (ret %d, errno %d)",
+			  r, errno);
+	else if (r > 0)
+		error_set(err, r, "child %d reported: %d", child->pid, r);
+
+	return r;
+}
+
+static inline void trim_newline(char *str)
+{
+	char *pos = strrchr(str, '\n');
+
+	if (pos)
+		*pos = '\0';
+}
+
+static int verify_fdinfo_nspid(int pidfd, struct error *err,
+			       const char *expect, ...)
+{
+	char buffer[512] = {0, };
+	char path[512] = {0, };
+	va_list args;
+	FILE *f;
+	char *line = NULL;
+	size_t n = 0;
+	int found = 0;
+	int r;
+
+	va_start(args, expect);
+	r = vsnprintf(buffer, sizeof(buffer), expect, args);
+	assert((size_t)r < sizeof(buffer));
+	va_end(args);
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
+	f = fopen(path, "re");
+	if (!f)
+		return error_set(err, PIDFD_ERROR, "fdinfo open failed for %d",
+				 pidfd);
+
+	while (getline(&line, &n, f) != -1) {
+		if (strncmp(line, "NSpid:", 6))
+			continue;
+
+		found = 1;
+
+		r = strcmp(line + 6, buffer);
+		if (r != 0) {
+			trim_newline(line);
+			trim_newline(buffer);
+			error_set(err, PIDFD_FAIL, "NSpid: '%s' != '%s'",
+				  line + 6, buffer);
+		}
+		break;
+	}
+
+	free(line);
+	fclose(f);
+
+	if (found == 0)
+		return error_set(err, PIDFD_FAIL, "NSpid not found for fd %d",
+				 pidfd);
+
+	return PIDFD_PASS;
+}
+
+static int child_fdinfo_nspid_test(void *args)
+{
+	struct error err;
+	int pidfd;
+	int r;
+
+	/* if we got no fd for the sibling, we are done */
+	if (!args)
+		return PIDFD_PASS;
+
+	/* verify that we can not resolve the pidfd for a process
+	 * in a sibling pid namespace, i.e. a pid namespace it is
+	 * not in our or a descended namespace
+	 */
+	r = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (r < 0) {
+		ksft_print_msg("Failed to remount / private\n");
+		return PIDFD_ERROR;
+	}
+
+	(void)umount2("/proc", MNT_DETACH);
+	r = mount("proc", "/proc", "proc", 0, NULL);
+	if (r < 0) {
+		ksft_print_msg("Failed to remount /proc\n");
+		return PIDFD_ERROR;
+	}
+
+	pidfd = *(int *)args;
+	r = verify_fdinfo_nspid(pidfd, &err, "\t0\n");
+
+	if (r != PIDFD_PASS)
+		ksft_print_msg("NSpid fdinfo check failed: %s\n", err.msg);
+
+	return r;
+}
+
+static void test_pidfd_fdinfo_nspid(void)
+{
+	struct child a, b;
+	struct error err = {0, };
+	const char *test_name = "pidfd check for NSpid in fdinfo";
+
+	/* Create a new child in a new pid and mount namespace */
+	a = clone_newns(child_fdinfo_nspid_test, NULL, &err);
+	error_check(&err, test_name);
+
+	/* Pass the pidfd representing the first child to the
+	 * second child, which will be in a sibling pid namespace,
+	 * which means that the fdinfo NSpid entry for the pidfd
+	 * should only contain '0'.
+	 */
+	b = clone_newns(child_fdinfo_nspid_test, &a.fd, &err);
+	error_check(&err, test_name);
+
+	/* The children will have pid 1 in the new pid namespace,
+	 * so the line must be 'NSPid:\t<pid>\t1'.
+	 */
+	verify_fdinfo_nspid(a.fd, &err, "\t%d\t%d\n", a.pid, 1);
+	verify_fdinfo_nspid(b.fd, &err, "\t%d\t%d\n", b.pid, 1);
+
+	/* wait for the process, check the exit status and set
+	 * 'err' accordingly, if it is not already set.
+	 */
+	child_join(&a, &err);
+	child_join(&b, &err);
+
+	error_report(&err, test_name);
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
-- 
2.21.0

