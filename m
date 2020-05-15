Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED11D5CDB
	for <lists+linux-api@lfdr.de>; Sat, 16 May 2020 01:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOXkc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 19:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbgEOXkb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 May 2020 19:40:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8BC061A0C
        for <linux-api@vger.kernel.org>; Fri, 15 May 2020 16:40:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y18so1737897pfl.9
        for <linux-api@vger.kernel.org>; Fri, 15 May 2020 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJzFvwUo6iwn8/DhNKCJMUEDGhhpSA9N+Qu+KJbXwr8=;
        b=qVHejHX0vz/9v+B4nZFIfZakrLDKIV9dHq+Own9O52KzZBA6raffF1PWe0K7xm7t8/
         DoTt32O7hItE3VUMFDIU7ZCEo0FOR+235oUGGtNZeCten6HNw9qw6heNeGMeWHv20iG/
         1d9tYLqDdjGo4H7TkWoE6HgQQVuwXuzQxpBQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJzFvwUo6iwn8/DhNKCJMUEDGhhpSA9N+Qu+KJbXwr8=;
        b=SZr787pe0VPaWMdthcKZH8odX8DUdeoKiADb9055XgdWhWN7oIKm9pjxAMpzgHxxdI
         ZFGGCGRa6VBdO/beTcm67iCyFYCQTwSxB1SauuJQcABr6QRZ7+c4VcB4R92kzQZQPxfV
         KWQFN8QIEt6JwtWpH05spWw2xNGeUea2YtSPeYu/6aECLbAoe70kZDHWeYaLK/v4QtqG
         5FX9sK+ekae5uxDdYEa4hk3alJ4gb6YoaY4zAgWkvaQGbllvYIQCweA2EbggXPwWV0RA
         0f8oE26aH5GyGeBcZ3vgpEsHpn5xZ+icTUHklAW+YqscBqffAQrkbH6MtBBA4m0AqyOd
         FSsA==
X-Gm-Message-State: AOAM530o8vcWhCxDIqppunsIVmFfhlkEhHgQUnnIul75yk1DfEW7uBnA
        dB5W+nUOMtshuxa61h7z8Eyibg==
X-Google-Smtp-Source: ABdhPJyDbT/37zGxxJ04QtTD4suKPeXcd688xN9h0qJJSHQhZSh5RAyLeHbzDChQBhC95TREq+CLWQ==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr6304335pfj.256.1589586029248;
        Fri, 15 May 2020 16:40:29 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id x20sm1264990pfc.211.2020.05.15.16.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 16:40:28 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com
Subject: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Date:   Fri, 15 May 2020 16:40:05 -0700
Message-Id: <20200515234005.32370-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This includes the thread group leader ID in the seccomp_notif. This is
immediately useful for opening up a pidfd for the group leader, as
pidfds only work on group leaders.

Previously, it was considered to include an actual pidfd in the
seccomp_notif structure[1], but it was suggested to avoid proliferating
mechanisms to create pidfds[2].

[1]: https://lkml.org/lkml/2020/1/24/133
[2]: https://lkml.org/lkml/2020/5/15/481

Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/uapi/linux/seccomp.h                  |  2 +
 kernel/seccomp.c                              |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 50 +++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index c1735455bc53..f0c272ef0f1e 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -75,6 +75,8 @@ struct seccomp_notif {
 	__u32 pid;
 	__u32 flags;
 	struct seccomp_data data;
+	__u32 tgid;
+	__u8 pad0[4];
 };
 
 /*
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..538bcbbcf4da 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1061,6 +1061,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 
 	unotif.id = knotif->id;
 	unotif.pid = task_pid_vnr(knotif->task);
+	unotif.tgid = task_tgid_vnr(knotif->task);
 	unotif.data = *(knotif->data);
 
 	knotif->state = SECCOMP_NOTIFY_SENT;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..5658c6e95461 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -187,6 +187,8 @@ struct seccomp_notif {
 	__u32 pid;
 	__u32 flags;
 	struct seccomp_data data;
+	__u32 tgid;
+	__u8 pad0[4];
 };
 
 struct seccomp_notif_resp {
@@ -3226,6 +3228,8 @@ TEST(user_notification_basic)
 		req.pid = 0;
 		EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	}
+	EXPECT_EQ(pid, req.pid);
+	EXPECT_EQ(pid, req.tgid);
 
 	pollfd.fd = listener;
 	pollfd.events = POLLIN | POLLOUT;
@@ -3453,6 +3457,7 @@ TEST(user_notification_child_pid_ns)
 
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	EXPECT_EQ(req.pid, pid);
+	EXPECT_EQ(req.tgid, pid);
 
 	resp.id = req.id;
 	resp.error = 0;
@@ -3686,6 +3691,51 @@ TEST(user_notification_continue)
 	}
 }
 
+void *getppid_thread(void *arg)
+{
+	int *tid = arg;
+
+	*tid = syscall(__NR_gettid);
+	if (*tid <= 0)
+		return (void *)(long)errno;
+	return NULL;
+}
+
+TEST(user_notification_groupleader)
+{
+	struct seccomp_notif_resp resp = {};
+	struct seccomp_notif req = {};
+	int ret, listener, tid, pid;
+	pthread_t thread;
+	void *status;
+
+	pid = getpid();
+	ASSERT_GT(pid, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_trap_syscall(__NR_gettid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	ASSERT_EQ(0, pthread_create(&thread, NULL, getppid_thread, &tid));
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	resp.id = req.id;
+	resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	ASSERT_EQ(0, pthread_join(thread, &status));
+	ASSERT_EQ(0, status);
+
+	EXPECT_EQ(tid, req.pid);
+	EXPECT_EQ(pid, req.tgid);
+}
+
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.20.1

