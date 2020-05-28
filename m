Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8F91E5DF2
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 13:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgE1LJd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgE1LJ3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 May 2020 07:09:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCEC08C5C5
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 04:09:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q9so2982753pjm.2
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKwxzcojHN10iEPqL5iX/7JIXAHxE1GUfvHxVpXUU0I=;
        b=QPdC0yzHn6KGN5j8I0pnAgQmuavpeXhIEr7mNUYyK8KBCqpTj+qFhcejl1cyubvgOb
         o68D1mtT/qZ05fYNTqEFInQA3yDp2u3bcwnAPz7JSUo+T40KO81M0C9ZTZL6yJemt/Jr
         aVafAjdgHG5uVFNfFzi1ALCdmhn1lzCpYl8Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKwxzcojHN10iEPqL5iX/7JIXAHxE1GUfvHxVpXUU0I=;
        b=inYloXgipJ+8t+E0Ybh/jlDzKNurclROTt5LntcotlNZ25rHY9PX19kuE+qECZEZ+X
         PqtHlVZlrOc7BGGfSXjI7l9i0jmdXdTE7+3yPKeTuz9KUBuFzJ68rxJFwpe+KTtrugDk
         djODQPSr1+J7O1RMFqyeK+nqzVEz389G8z7EFFELPBRgjhYDKCLCwKNniI+S1flBrq1z
         2T3UmqG7Sbt54AE7j2jBdDMk4xoJAjf2GOv2J1NlGvVH+ZMTJb26RWCReyG/cBP5R362
         caVyRwmWhcScQkd1crykxTBy+9QWMajahbTmmZ9OairPkYuHOT4SJV5EqVBWo840+L3N
         T84g==
X-Gm-Message-State: AOAM533Y/E21MLACDL5J3MJwOMvF6T5GMRE2fSsUedLEITdVQBLdAN1t
        ZhKX4rz7FyJn0hN9cTGb53elwQ==
X-Google-Smtp-Source: ABdhPJyB6Cev99SUe5qE/phXvYRWc/snaHBfzCPMyjlBS/vaNQdkT4LS4atn5fwNJ4EvWW5F6lEm1w==
X-Received: by 2002:a17:90a:dd44:: with SMTP id u4mr3014800pjv.132.1590664168483;
        Thu, 28 May 2020 04:09:28 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j26sm4565759pfr.215.2020.05.28.04.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:09:27 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     keescook@chromium.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Date:   Thu, 28 May 2020 04:08:58 -0700
Message-Id: <20200528110858.3265-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528110858.3265-1-sargun@sargun.me>
References: <20200528110858.3265-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Test whether we can add file descriptors in response to notifications.
This injects the file descriptors via notifications, and then uses
kcmp to determine whether or not it has been successful.

It also includes some basic sanity checking for arguments.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..05516c185d78 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -45,6 +45,7 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <linux/kcmp.h>
+#include <sys/resource.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -181,6 +182,12 @@ struct seccomp_metadata {
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
 #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+/* On success, the return value is the remote process's added fd number */
+#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOR(3,	\
+						struct seccomp_notif_addfd)
+
+/* valid flags for seccomp_notif_addfd */
+#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
 
 struct seccomp_notif {
 	__u64 id;
@@ -201,6 +208,15 @@ struct seccomp_notif_sizes {
 	__u16 seccomp_notif_resp;
 	__u16 seccomp_data;
 };
+
+struct seccomp_notif_addfd {
+	__u64 size;
+	__u64 id;
+	__u64 flags;
+	__u32 srcfd;
+	__u32 newfd;
+	__u32 newfd_flags;
+};
 #endif
 
 #ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
@@ -3686,6 +3702,170 @@ TEST(user_notification_continue)
 	}
 }
 
+TEST(user_notification_sendfd)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, memfd;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	__u64 nextid;
+
+	memfd = memfd_create("test", 0);
+	ASSERT_GE(memfd, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Check that the basic notification machinery works */
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (syscall(__NR_getppid) != USER_NOTIF_MAGIC)
+			exit(1);
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
+	}
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	addfd.size = sizeof(addfd);
+	addfd.srcfd = memfd;
+	addfd.newfd_flags = O_CLOEXEC;
+	addfd.newfd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0xff;
+
+	/* Verify bad flags cannot be set */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Verify that remote_fd cannot be set without setting flags */
+	addfd.flags = 0;
+	addfd.newfd = 1;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Verify we can set an arbitrary remote fd */
+	addfd.newfd = 0;
+
+	ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_GE(ret, 0);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
+
+	/* Verify we can set a specific remote fd */
+	addfd.newfd = 42;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), 42);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, 42), 0);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	nextid = req.id + 1;
+
+	/* Wait for getppid to be called for the second time */
+	sleep(1);
+
+	addfd.id = nextid;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINPROGRESS);
+
+	memset(&req, 0, sizeof(req));
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	ASSERT_EQ(nextid, req.id);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(memfd);
+}
+
+TEST(user_notification_sendfd_rlimit)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, memfd;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	const struct rlimit lim = {
+		.rlim_cur	= 0,
+		.rlim_max	= 0,
+	};
+
+	memfd = memfd_create("test", 0);
+	ASSERT_GE(memfd, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Check that the basic notification machinery works */
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
+
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	ASSERT_EQ(prlimit(pid, RLIMIT_NOFILE, &lim, NULL), 0);
+
+	addfd.size = sizeof(addfd);
+	addfd.srcfd = memfd;
+	addfd.newfd_flags = O_CLOEXEC;
+	addfd.newfd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0;
+
+	/* Should probably spot check /proc/sys/fs/file-nr */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EMFILE);
+
+	addfd.newfd = 100;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(memfd);
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.25.1

