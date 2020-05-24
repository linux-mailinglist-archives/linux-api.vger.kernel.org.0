Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439221E03EB
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgEXXj4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388618AbgEXXjy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:39:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3F5C08C5C0
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so6828572plt.5
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urgPd3ozxiorxnog0oOmlhSiDdNFLQVW0phChlMGf6Y=;
        b=XWEpOFL8Sb6joFdVJlHGZbscXW9SbwwbZ+H156lWOV+zEGrakiYZEwjiwWOC6+49Hk
         Gkj1ndF5ycryynQb7Kys2EjxFSxmUY4H1VOn9880Tszwpg8Mjvz7Fs9MPs84mhzL62Fm
         fzzgBkpa7Gat2iEj2x5dct1gPYYoimboXxnp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urgPd3ozxiorxnog0oOmlhSiDdNFLQVW0phChlMGf6Y=;
        b=SdvCaV+49A8W+Z6Qjg7SxKnzWIHUhdLELaabgIw216Eac7BAO5PzdVy/8Fyv650ng4
         5RNivL0yIAF2KmDwkw4pT0HX5PHTDisd5mWKtOEmKpQ+1QA1BHWeahuxmYYPHStL7+Pt
         B+C1KXhXqeLXcDKG57sTVKOAj8vt0X7B60FwsBMhsSYriepkM/VUoPNudMOZ5DGcJ1/w
         /0QAQm8LB5RrFunPahzR/MOsaTo7k0e6Hkp0SSJqKjOyWLYq67QOIEQ+ZGsHKj+79OpG
         ekwc1gmn6Zw4KJ23dJr/Kn9QkJec+Jn/zqzKaWNHpWjaFz6MsXxTi4g3SkmY9BIVfZR5
         BbYg==
X-Gm-Message-State: AOAM5310CCJlo4+eAk3/+b8XXBdacbtCOq9w9ljFAOHlm/out//8WxWa
        sgzHBhynWigk7PEt0zXdIj/FNQ==
X-Google-Smtp-Source: ABdhPJza0eupCtsQbPUEy8GxPoa3/m7TrMrK40xwCCOq7gI4keO0qt0w/NtByShbf3FydfKPANjPzg==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr24893920plo.221.1590363593438;
        Sun, 24 May 2020 16:39:53 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:52 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH 3/5] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Date:   Sun, 24 May 2020 16:39:40 -0700
Message-Id: <20200524233942.8702-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524233942.8702-1-sargun@sargun.me>
References: <20200524233942.8702-1-sargun@sargun.me>
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
 tools/testing/selftests/seccomp/seccomp_bpf.c | 227 ++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..1ec43fef2b93 100644
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
+	__u32 size;
+	__u32 fd;
+	__u64 id;
+	__u32 fd_flags;
+	__u32 remote_fd;
+	__u64 flags;
+};
 #endif
 
 #ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
@@ -3686,6 +3702,217 @@ TEST(user_notification_continue)
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
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	addfd.size = sizeof(addfd);
+	addfd.fd = memfd;
+	addfd.fd_flags = O_CLOEXEC;
+	addfd.remote_fd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0xff;
+
+	/* Verify bad flags cannot be set */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Verify that remote_fd cannot be set without setting flags */
+	addfd.flags = 0;
+	addfd.remote_fd = 1;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Verify we can set an arbitrary remote fd */
+	addfd.remote_fd = 0;
+
+	ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_GE(ret, 0);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
+
+	/* Verify we can set a specific remote fd */
+	addfd.remote_fd = 42;
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
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(memfd);
+}
+
+TEST(user_notification_sendfd_goaway)
+{
+	pid_t pid, pid2;
+	long ret;
+	int status, listener, memfd;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
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
+		syscall(__NR_getppid);
+		exit(0);
+	}
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+
+	ASSERT_EQ(kill(pid, SIGSTOP), 0);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	pid2 = fork();
+	if (pid2 == 0) {
+		sleep(1);
+		exit(kill(pid, SIGCONT) != 0);
+	}
+
+	/* Add FD should return ENOENT */
+	addfd.size = sizeof(addfd);
+	addfd.fd = memfd;
+	addfd.fd_flags = O_CLOEXEC;
+	addfd.remote_fd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	EXPECT_EQ(waitpid(pid2, &status, 0), pid2);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
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
+	addfd.fd = memfd;
+	addfd.fd_flags = O_CLOEXEC;
+	addfd.remote_fd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0;
+
+	/* Should probably spot check /proc/sys/fs/file-nr */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EMFILE);
+
+	addfd.remote_fd = 100;
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

