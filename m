Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915EE2E85EF
	for <lists+linux-api@lfdr.de>; Sat,  2 Jan 2021 00:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhAAX4X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 Jan 2021 18:56:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhAAX4X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 Jan 2021 18:56:23 -0500
Received: from localhost (unknown [IPv6:2804:431:c7f4:46f8:ae05:b936:9029:cd4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 90E4B1F411B3;
        Fri,  1 Jan 2021 23:55:40 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH] entry: Use different define for selector variable in SUD
Date:   Fri,  1 Jan 2021 20:55:29 -0300
Message-Id: <20210101235529.1563262-1-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Michael Kerrisk suggested that, from an API perspective, it is a bad
idea to share the PR_SYS_DISPATCH_ defines between the prctl operation
and the selector variable.  Therefore, define two new constants to be
used by SUD's selector variable, and the corresponding documentation.

While this changes the API, it is backward compatible, as the values
remained the same and the old defines are still in place.  In addition,
SUD has never been part of a Linux release, it will show up for the
first time in 5.11.

Cc: Linux API <linux-api@vger.kernel.org>
Suggested-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../admin-guide/syscall-user-dispatch.rst          |  4 ++--
 include/uapi/linux/prctl.h                         |  2 ++
 kernel/entry/syscall_user_dispatch.c               |  4 ++--
 .../syscall_user_dispatch/sud_benchmark.c          |  8 +++++---
 .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++------
 5 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index a380d6515774..fc13112e36e3 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -70,8 +70,8 @@ trampoline code on the vDSO, that trampoline is never intercepted.
 [selector] is a pointer to a char-sized region in the process memory
 region, that provides a quick way to enable disable syscall redirection
 thread-wide, without the need to invoke the kernel directly.  selector
-can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
-value should terminate the program with a SIGSYS.
+can be set to PR_SYS_DISPATCH_FILTER_ALLOW or PR_SYS_DISPATCH_FILTER_BLOCK.
+Any other value should terminate the program with a SIGSYS.
 
 Security Notes
 --------------
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 90deb41c8a34..a66c9fe41249 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -251,5 +251,7 @@ struct prctl_mm_map {
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
 # define PR_SYS_DISPATCH_ON		1
+# define PR_SYS_DISPATCH_FILTER_ALLOW	0
+# define PR_SYS_DISPATCH_FILTER_BLOCK	1
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index b0338a5625d9..265c33b26dcf 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -50,10 +50,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 		if (unlikely(__get_user(state, sd->selector)))
 			do_exit(SIGSEGV);
 
-		if (likely(state == PR_SYS_DISPATCH_OFF))
+		if (likely(state == PR_SYS_DISPATCH_FILTER_ALLOW))
 			return false;
 
-		if (state != PR_SYS_DISPATCH_ON)
+		if (state != PR_SYS_DISPATCH_FILTER_BLOCK)
 			do_exit(SIGSYS);
 	}
 
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 6689f1183dbf..7617bd9ba6e1 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -22,6 +22,8 @@
 # define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF	0
 # define PR_SYS_DISPATCH_ON	1
+# define PR_SYS_DISPATCH_FILTER_ALLOW	0
+# define PR_SYS_DISPATCH_FILTER_BLOCK	1
 #endif
 
 #ifdef __NR_syscalls
@@ -55,8 +57,8 @@ unsigned long trapped_call_count = 0;
 unsigned long native_call_count = 0;
 
 char selector;
-#define SYSCALL_BLOCK   (selector = PR_SYS_DISPATCH_ON)
-#define SYSCALL_UNBLOCK (selector = PR_SYS_DISPATCH_OFF)
+#define SYSCALL_BLOCK   (selector = PR_SYS_DISPATCH_FILTER_BLOCK)
+#define SYSCALL_UNBLOCK (selector = PR_SYS_DISPATCH_FILTER_ALLOW)
 
 #define CALIBRATION_STEP 100000
 #define CALIBRATE_TO_SECS 5
@@ -170,7 +172,7 @@ int main(void)
 	syscall(MAGIC_SYSCALL_1);
 
 #ifdef TEST_BLOCKED_RETURN
-	if (selector == PR_SYS_DISPATCH_OFF) {
+	if (selector == PR_SYS_DISPATCH_FILTER_ALLOW) {
 		fprintf(stderr, "Failed to return with selector blocked.\n");
 		exit(-1);
 	}
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 6498b050ef89..21e1550db118 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -18,6 +18,8 @@
 # define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF	0
 # define PR_SYS_DISPATCH_ON	1
+# define PR_SYS_DISPATCH_FILTER_ALLOW	0
+# define PR_SYS_DISPATCH_FILTER_BLOCK	1
 #endif
 
 #ifndef SYS_USER_DISPATCH
@@ -30,8 +32,8 @@
 # define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
 #endif
 
-#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
-#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
+#define SYSCALL_DISPATCH_ON(x) ((x) = PR_SYS_DISPATCH_FILTER_BLOCK)
+#define SYSCALL_DISPATCH_OFF(x) ((x) = PR_SYS_DISPATCH_FILTER_ALLOW)
 
 /* Test Summary:
  *
@@ -56,7 +58,7 @@
 
 TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 {
-	char sel = 0;
+	char sel = PR_SYS_DISPATCH_FILTER_ALLOW;
 	struct sysinfo info;
 	int ret;
 
@@ -79,7 +81,7 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 
 TEST(bad_prctl_param)
 {
-	char sel = 0;
+	char sel = PR_SYS_DISPATCH_FILTER_ALLOW;
 	int op;
 
 	/* Invalid op */
@@ -220,7 +222,7 @@ TEST_SIGNAL(bad_selector, SIGSYS)
 	sigset_t mask;
 	struct sysinfo info;
 
-	glob_sel = 0;
+	glob_sel = PR_SYS_DISPATCH_FILTER_ALLOW;
 	nr_syscalls_emulated = 0;
 	si_code = 0;
 	si_errno = 0;
@@ -288,7 +290,7 @@ TEST(direct_dispatch_range)
 {
 	int ret = 0;
 	struct sysinfo info;
-	char sel = 0;
+	char sel = PR_SYS_DISPATCH_FILTER_ALLOW;
 
 	/*
 	 * Instead of calculating libc addresses; allow the entire
-- 
2.29.2

