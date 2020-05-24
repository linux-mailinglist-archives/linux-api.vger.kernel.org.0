Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F071E03F2
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbgEXXkK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388626AbgEXXj6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:39:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D3EC061A0E
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t8so5673093pju.3
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uc+iDiUBY7yhHZia3RA3hrxLqRjw9B4qWQG29672SBM=;
        b=Rvsj76oEACrsbuN4bDdJH8Ikg2CuKwzIdJIvewuTpLxwANx0lnW0JG9lCx+PQefjbT
         fqkckWXgbasMK5K+6PJZ9RUxwnHhGqrOdfX7bbg6jqnzvFFQJuPQoONbSxjjLsszClmO
         i0ySOR28pdi4NZa0GOXxEFE3AOekRwJt/uK2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc+iDiUBY7yhHZia3RA3hrxLqRjw9B4qWQG29672SBM=;
        b=FcfxTxb7G2G1MAeJQZGCzG9pCVV2yHx9pgkBbmkoVsZfMxsAkldFc5BHnW0kcOjzvq
         s3c97LwdUNcnW4ZD6iw56iGvbh9C5aF5i+Nzo7/GlV7UgZZW8WPcT4DhxvFLsEg44OEJ
         +X8s8MNtkYmkOCHfBI6DpQsQCUUBqUn+Y4YbmDkOR4D30LqEInMHdHXqfDq2eMA8j03A
         JBxFlk87zGI0nAm6jVLrAbRrm3cIEBrvqcJlyQbzeKa7rMmgX+G8xslvRmNDVwD7bvhh
         cNIPnvnCG+dqsDxdzMETXLZscqUbsM3FW7gCKwZPI6DUCsRKe4wVAmcHyr/C8rhyuN4X
         Jx0g==
X-Gm-Message-State: AOAM531TOf7c1IxfOwqCxByAshftR3GjcHBV4ZJsg6hScJF3Zaoj52KQ
        8Tyk+ZTzjBS/HCegZMg+694I1w==
X-Google-Smtp-Source: ABdhPJwvT2hwU0FYbvrqXWxWsJsdVso8pPVHAzBn2fLT5jJ+jx7C6u1At2QE0ONViSH4WK+HkL8Szg==
X-Received: by 2002:a17:902:cb03:: with SMTP id c3mr26188812ply.307.1590363596351;
        Sun, 24 May 2020 16:39:56 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:55 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH 4/5] seccomp: Add SECCOMP_ADDFD_FLAG_MOVE flag to add fd ioctl
Date:   Sun, 24 May 2020 16:39:41 -0700
Message-Id: <20200524233942.8702-5-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524233942.8702-1-sargun@sargun.me>
References: <20200524233942.8702-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Certain files, when moved to another process have metadata changed, such
as netprioidx, and classid. This is the default behaviour in sending
sockets with SCM_RIGHTS over unix sockets. Depending on the usecase,
this may or may not be desirable with the addfd ioctl. This allows
the user to opt-in.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Tycho Andersen <tycho@tycho.ws>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/uapi/linux/seccomp.h |  8 ++++++++
 kernel/seccomp.c             | 31 +++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 7d450a9e4c29..ccd1c960372a 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -115,6 +115,14 @@ struct seccomp_notif_resp {
 
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+/*
+ * Certain file descriptors are behave differently depending on the process
+ * they are created in. Specifcally, sockets, and their interactions with the
+ * net_cls and net_prio cgroup v1 controllers. This "moves" the file descriptor
+ * so that it takes on the cgroup controller's configuration in the process
+ * that the file descriptor is being added to.
+ */
+#define SECCOMP_ADDFD_FLAG_MOVE		(1UL << 1)
 
 /**
  * struct seccomp_notif_addfd
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 88940eeabaee..2e649f3cb10e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -41,6 +41,9 @@
 #include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
+#include <net/netprio_cgroup.h>
+#include <net/sock.h>
+#include <net/cls_cgroup.h>
 
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
@@ -108,6 +111,7 @@ struct seccomp_kaddfd {
 	struct file *file;
 	int fd;
 	unsigned int flags;
+	bool move;
 
 	/* To only be set on reply */
 	int ret;
@@ -769,7 +773,8 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
 
 static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
 {
-	int ret;
+	struct socket *sock;
+	int err, ret;
 
 	/*
 	 * Remove the notification, and reset the list pointers, indicating
@@ -785,12 +790,29 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
 		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
 		if (ret >= 0)
 			fput(addfd->file);
+		else
+			goto out;
 	} else {
 		ret = get_unused_fd_flags(addfd->flags);
 		if (ret >= 0)
 			fd_install(ret, addfd->file);
+		else
+			goto out;
 	}
 
+	if (addfd->move) {
+		sock = sock_from_file(addfd->file, &err);
+		if (sock) {
+			sock_update_netprioidx(&sock->sk->sk_cgrp_data);
+			sock_update_classid(&sock->sk->sk_cgrp_data);
+		}
+	}
+	/*
+	 * An extra reference is taken on the ioctl side, so upon success, we
+	 * must consume all references (and on failure, none).
+	 */
+	fput(addfd->file);
+
 out:
 	addfd->ret = ret;
 	complete(&addfd->completion);
@@ -1279,16 +1301,17 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	if (addfd.fd_flags & (~O_CLOEXEC))
 		return -EINVAL;
 
-	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD))
+	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD|SECCOMP_ADDFD_FLAG_MOVE))
 		return -EINVAL;
 
 	if (addfd.remote_fd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
 		return -EINVAL;
 
-	kaddfd.file = fget(addfd.fd);
+	kaddfd.file = fget_many(addfd.fd, 2);
 	if (!kaddfd.file)
 		return -EBADF;
 
+	kaddfd.move = (addfd.flags & SECCOMP_ADDFD_FLAG_MOVE);
 	kaddfd.flags = addfd.fd_flags;
 	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
 		    addfd.remote_fd : -1;
@@ -1339,7 +1362,7 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 	mutex_unlock(&filter->notify_lock);
 out:
 	if (ret < 0)
-		fput(kaddfd.file);
+		fput_many(kaddfd.file, 2);
 
 	return ret;
 }
-- 
2.25.1

