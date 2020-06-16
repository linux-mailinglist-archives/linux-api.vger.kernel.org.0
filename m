Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7A1FA6E3
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 05:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgFPD0p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jun 2020 23:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFPDZe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jun 2020 23:25:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D17C08C5C2
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 20:25:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so8821403pfi.13
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HcknO+2U6NyZmGxMbR3CAHSQ4G454UQIfBRNwJsDAGs=;
        b=Ni9Nj86TxOCxN+Q1noSGMuOS4x3lT9BEmWWFkE5gXguwF94uaaqkDDRC0ZDI2dFwqH
         6UQCDz5uppetU9OsClPUQVnfL7QLC7Lhie+Nj/0QfNVNZRco/pe3pJZKvxbx48Yw93YL
         K9aHPzSRk0B6z5wkni3ESg09Vw41qQyXw7c2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcknO+2U6NyZmGxMbR3CAHSQ4G454UQIfBRNwJsDAGs=;
        b=ZT8jk1XMCS0N0ERVlK0MXOZYwtBxxSyScZVaCczrtyXCGnt/pOWCjt78V7eJzscM+d
         sET8YYIXtlolETtLOkAN4+zDOVhRMQ9+TpD6QxeulwFVTutswa3MH0nwloM86ERceb7I
         8xC8W6G4jhbpSpYP7Qi+jS5wJOwUHJlC2N1EDUJo3YRj4fJJ+007yudnInr/rHYeAxr6
         A04PukOdPpcQMsqBMo/wbWDvGc47fDoHYgSmqm7Ixp9fUO3VBlvhpRbcz/OPvfsMh7hl
         bp4bDbNiAXhuZy5bjB2j/oButytgIrvfyHvnaJShNMJ2U5+T6wWJcOZvalI2gc+mt9tJ
         1lLA==
X-Gm-Message-State: AOAM531oyUzFZ55duLyo7MjKuz/cQKMJ0Fl6K37aojLgYFY11DQW80Rx
        ilthgy/yDWle7sVgxBSy0FW8vg==
X-Google-Smtp-Source: ABdhPJwQdqKI0yfpNYbLt1UQTfVscQHjWyX7NqI+wJHdQip2vpApLLc4Cl2Na7ZB9UMEzOWHLaarVQ==
X-Received: by 2002:a05:6a00:84e:: with SMTP id q14mr252444pfk.309.1592277933644;
        Mon, 15 Jun 2020 20:25:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c2sm12623848pgk.77.2020.06.15.20.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 20:25:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 05/11] fs: Expand __fd_install_received() to accept fd
Date:   Mon, 15 Jun 2020 20:25:18 -0700
Message-Id: <20200616032524.460144-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032524.460144-1-keescook@chromium.org>
References: <20200616032524.460144-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Expand __fd_install_received() with support for replace_fd() for the
coming seccomp "addfd" ioctl(). Add new wrapper fd_replace_received()
for the new mode and update existing wrappers to retain old mode.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file.c            | 22 ++++++++++++++++------
 include/linux/file.h | 10 +++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 14a8ef74efb2..b583e7c60571 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -950,8 +950,8 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __fd_install_received(struct file *file, bool ufd_required, int __user *ufd,
-			  unsigned int o_flags)
+int __fd_install_received(int fd, struct file *file, bool ufd_required,
+			  int __user *ufd, unsigned int o_flags)
 {
 	struct socket *sock;
 	int new_fd;
@@ -961,9 +961,11 @@ int __fd_install_received(struct file *file, bool ufd_required, int __user *ufd,
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	if (fd < 0) {
+		new_fd = get_unused_fd_flags(o_flags);
+		if (new_fd < 0)
+			return new_fd;
+	}
 
 	if (ufd_required) {
 		error = put_user(new_fd, ufd);
@@ -973,6 +975,15 @@ int __fd_install_received(struct file *file, bool ufd_required, int __user *ufd,
 		}
 	}
 
+	if (fd < 0)
+		fd_install(new_fd, get_file(file));
+	else {
+		new_fd = fd;
+		error = replace_fd(new_fd, file, o_flags);
+		if (error)
+			return error;
+	}
+
 	/* Bump the usage count and install the file. The resulting value of
 	 * "error" is ignored here since we only need to take action when
 	 * the file is a socket and testing "sock" for NULL is sufficient.
@@ -982,7 +993,6 @@ int __fd_install_received(struct file *file, bool ufd_required, int __user *ufd,
 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
 		sock_update_classid(&sock->sk->sk_cgrp_data);
 	}
-	fd_install(new_fd, get_file(file));
 	return new_fd;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 999a2c56db07..f1d16e24a12e 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -91,16 +91,20 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __fd_install_received(struct file *file, bool ufd_required,
+extern int __fd_install_received(int fd, struct file *file, bool ufd_required,
 				 int __user *ufd, unsigned int o_flags);
 static inline int fd_install_received_user(struct file *file, int __user *ufd,
 					   unsigned int o_flags)
 {
-	return __fd_install_received(file, true, ufd, o_flags);
+	return __fd_install_received(-1, file, true, ufd, o_flags);
 }
 static inline int fd_install_received(struct file *file, unsigned int o_flags)
 {
-	return __fd_install_received(file, false, NULL, o_flags);
+	return __fd_install_received(-1, file, false, NULL, o_flags);
+}
+static inline int fd_replace_received(int fd, struct file *file, unsigned int o_flags)
+{
+	return __fd_install_received(fd, file, false, NULL, o_flags);
 }
 
 extern void flush_delayed_fput(void);
-- 
2.25.1

