Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25F1D5201
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfJLTQU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 15:16:20 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34103 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfJLTQT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 15:16:19 -0400
Received: by mail-qt1-f201.google.com with SMTP id y10so13364483qti.1
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KxnswPZUssm6ryZr4fnHpqAwiHqgDDpgiYcU8HwcCO0=;
        b=oWqCf2GVcMjBfhG4UpUEg4sKvtAEUDIYBUHm5gum/Z2gfWp7NZRU8WH8LTSTeMJ+5n
         WmvJkEPfhvdgcrzJArGRB7/ngXHROCfvdW3duCP+VNET6PFop7J+RKo0NmItepiHE1vk
         77R3vdFKnKJB8m86HYBgtOOeghLUlrgezQL6jAeAU6wuAY2ZhckA7h54CB3TkIg0Yya8
         9G8+gByS0j7/0MnmVdJVeBoISwmruYBcmsM8BIGm67oEyTJz60HkiwDqRtayzSk8FRwD
         8plBVFxHBSkmwMOfyKWJ/DMXaEDQnmYp7v8Y82q6RgLG7TclSAJKDdlx575YLpJl9Syy
         3wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KxnswPZUssm6ryZr4fnHpqAwiHqgDDpgiYcU8HwcCO0=;
        b=A1n1YndjXfEnW43XJa9L1TAQJDVo3hk0H3OgqYdcMabxiNjELoDcY+EYODUv+/XlhM
         yR4IOjdks++j48avaD4vAIWnY2ATlG8GJOer+dyhsog+dVBmwVG08yEARD+tyd22j+Ol
         U3zIbbxSUUrmySf2P3l9NQPEGK5I7e5SvWiR4J5qL4VfhJobFIlM+DghMuTGpMDQ3TmO
         2GvNmBOMhWnohHyLX8CeOsTlkOl7urQpfYjyOGrZ/F17g3jRFIFJxNJM0JyC5JoOUyd1
         6GtaLifxLUwhOcNpVjfIdgW4603rUi38B+KH5zaEIBHeNfdjuxD+VyMmRSUj82PlDh+7
         Oavg==
X-Gm-Message-State: APjAAAXTOxpvqtp2Uy6WR26Xma2FnTG6Vke4zAM6pjGNkWnMusyP5xbt
        pk6K95DHeVnNTZjKAKrlCV9TfEp4rewXnGaTbOq3VcSTaG/Usrg4wgW0+AQrEt6fMUj9fyThhDh
        g+RIfSPnFKMQa8cj8GpQDmqNIHhioA+KEl3W2Y5zrnH5t54tuj7dEcxQxGc6vtvXzJw==
X-Google-Smtp-Source: APXvYqxT08/c3duLodWgA+FprszC4YvEp38n6VE6vemh6CZUJ55DAWYAKzO2h1ePpk200IFnhnrNB+HkoDQ=
X-Received: by 2002:a05:6214:1264:: with SMTP id r4mr23425487qvv.64.1570907776916;
 Sat, 12 Oct 2019 12:16:16 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:15:58 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-4-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The new secure flag makes userfaultfd use a new "secure" anonymous
file object instead of the default one, letting security modules
supervise userfaultfd use.

Requiring that users pass a new flag lets us avoid changing the
semantics for existing callers.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                 | 28 +++++++++++++++++++++++++---
 include/uapi/linux/userfaultfd.h |  8 ++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f9fd18670e22..29f920fb236e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1022,6 +1022,13 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 {
 	int fd;
 
+	/*
+	 * Using a secure-mode UFFD to monitor forks isn't supported
+	 * right now.
+	 */
+	if (new->flags & UFFD_SECURE)
+		return -EOPNOTSUPP;
+
 	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
 			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
@@ -1841,6 +1848,18 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		ret = -EINVAL;
 		goto out;
 	}
+	if ((ctx->flags & UFFD_SECURE) &&
+	    (features & UFFD_FEATURE_EVENT_FORK)) {
+		/*
+		 * We don't support UFFD_FEATURE_EVENT_FORK on a
+		 * secure-mode UFFD: doing so would need us to
+		 * construct the new file object in the context of the
+		 * fork child, and it's not worth it right now.
+		 */
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
@@ -1942,6 +1961,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
 	struct userfaultfd_ctx *ctx;
 	int fd;
+	static const int uffd_flags = UFFD_SECURE;
 
 	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
@@ -1951,8 +1971,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* Check the UFFD_* constants for consistency.  */
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
+	BUILD_BUG_ON(UFFD_SHARED_FCNTL_FLAGS & uffd_flags);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
@@ -1969,8 +1990,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd2("[userfaultfd]", &userfaultfd_fops, ctx,
+			       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+			       ((flags & UFFD_SECURE) ? ANON_INODE_SECURE : 0));
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 48f1a7c2f1f0..12d7d40d7f25 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -231,4 +231,12 @@ struct uffdio_zeropage {
 	__s64 zeropage;
 };
 
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd with MAC security checks enabled.
+ */
+#define UFFD_SECURE 1
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.23.0.700.g56cf767bdb-goog

