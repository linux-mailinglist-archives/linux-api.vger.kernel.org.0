Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41A2159CA1
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBKW4N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 17:56:13 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46857 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgBKW4M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 17:56:12 -0500
Received: by mail-pf1-f202.google.com with SMTP id c185so141742pfb.13
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2020 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=a5LVi1czvjYTZRG10VC6YoW8AwFWVMSQpGq5Mo0ccJ0=;
        b=FsDNRUzDMerRb2TiLxdKBMsmNiW13dSthG+fFckRF863dwlpRI7H85zTW/Odu8uzvZ
         miE/DDwEZEVqFEIom+y0eIxg+bsVgZVr07yV4hHwFrEpx1guNPkyKNUaV9h4BVYGgPHj
         e5wK+JrX4G9SmuqMqc9rWPU1LMdhrkdXqSlvIgrOgFLp7Gqpgncf730gU8PXmDgJldTK
         aK2MxfzkLOgU54VEHwWsiuEtx72LKdLkM1e3wfsuOHYVHH7r2lJtf0hxQjCHkKS0ZeVk
         sy7gQRYbnVjN04xMTVjvvOstiTRY+ffCQYOgiYgKrdFHaxesYfFFoKY8/ihqGLQJn5gn
         PH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=a5LVi1czvjYTZRG10VC6YoW8AwFWVMSQpGq5Mo0ccJ0=;
        b=jqciANkyjVSb3DTF5204390cDGK1zg1WKgwUzOZH6YzEn+mzLACcCM6LYDFJYxLnuz
         pqEc90KccNns5jVtFnPNk+d9xk7rzXUeB23fuN3KY7bx6RQ/caMHD15VS4EWBHXeXGSm
         ZezanytTx8R6TGTOuvKlCzeufiCWqbZGMdYFGowb2zAaNvvx0xnSuJaKxO3lMBHkQdHO
         wMSPi0uy68741VhALQvlPMZQzZvjnmsTUHSqeUBseTlT6pj0wvYk0O/Mw5htQbAkuype
         jiBo97T7XcoWFIwXRnZDonI6ZcHCs8NRb1yIe843NMrvKMc0MHbLSKobhPZKPCi0xj+i
         CG1w==
X-Gm-Message-State: APjAAAW3dsDY/0ij1QNLemGLPPaGCS8jpyzpeF7TH8XcrfLEmYdJOwjE
        Iy4XWYxxvd6pu+KOHeK1FFMEr9re/no=
X-Google-Smtp-Source: APXvYqx/rUFYd8FJL3Cg2ZzHJgT4z7nus3aoD8U2JtQsG2gf1M1/LsybhvCS0PgNIvsvHx6K7XcdaqubiKo=
X-Received: by 2002:a63:7701:: with SMTP id s1mr9794118pgc.271.1581461771648;
 Tue, 11 Feb 2020 14:56:11 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:42 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-2-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 1/6] Add a new flags-accepting interface for anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add functions forwarding from the old names to the new ones so we
don't need to change any callers.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/anon_inodes.c            | 62 ++++++++++++++++++++++---------------
 include/linux/anon_inodes.h | 27 +++++++++++++---
 2 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 89714308c25b..caa36019afca 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -56,60 +56,71 @@ static struct file_system_type anon_inode_fs_type = {
 };
 
 /**
- * anon_inode_getfile - creates a new file instance by hooking it up to an
- *                      anonymous inode, and a dentry that describe the "class"
- *                      of the file
+ * anon_inode_getfile2 - creates a new file instance by hooking it up to
+ *                       an anonymous inode, and a dentry that describe
+ *                       the "class" of the file
  *
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
- * @flags:   [in]    flags
+ * @flags:   [in]    flags for the file
+ * @anon_inode_flags: [in] flags for anon_inode*
  *
- * Creates a new file by hooking it on a single inode. This is useful for files
+ * Creates a new file by hooking it on an unspecified inode. This is useful for files
  * that do not need to have a full-fledged inode in order to operate correctly.
  * All the files created with anon_inode_getfile() will share a single inode,
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns the newly created file* or an error pointer.
+ *
+ * anon_inode_flags must be zero.
  */
-struct file *anon_inode_getfile(const char *name,
-				const struct file_operations *fops,
-				void *priv, int flags)
+struct file *anon_inode_getfile2(const char *name,
+				 const struct file_operations *fops,
+				 void *priv, int flags, int anon_inode_flags)
 {
+	struct inode *inode;
 	struct file *file;
 
-	if (IS_ERR(anon_inode_inode))
-		return ERR_PTR(-ENODEV);
-
-	if (fops->owner && !try_module_get(fops->owner))
-		return ERR_PTR(-ENOENT);
+	if (anon_inode_flags)
+		return ERR_PTR(-EINVAL);
 
+	inode =	anon_inode_inode;
+	if (IS_ERR(inode))
+		return ERR_PTR(-ENODEV);
 	/*
-	 * We know the anon_inode inode count is always greater than zero,
-	 * so ihold() is safe.
+	 * We know the anon_inode inode count is always
+	 * greater than zero, so ihold() is safe.
 	 */
-	ihold(anon_inode_inode);
-	file = alloc_file_pseudo(anon_inode_inode, anon_inode_mnt, name,
+	ihold(inode);
+
+	if (fops->owner && !try_module_get(fops->owner)) {
+		file = ERR_PTR(-ENOENT);
+		goto err;
+	}
+
+	file = alloc_file_pseudo(inode, anon_inode_mnt, name,
 				 flags & (O_ACCMODE | O_NONBLOCK), fops);
 	if (IS_ERR(file))
 		goto err;
 
-	file->f_mapping = anon_inode_inode->i_mapping;
+	file->f_mapping = inode->i_mapping;
 
 	file->private_data = priv;
 
 	return file;
 
 err:
-	iput(anon_inode_inode);
+	iput(inode);
 	module_put(fops->owner);
 	return file;
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfile);
+EXPORT_SYMBOL_GPL(anon_inode_getfile2);
 
 /**
- * anon_inode_getfd - creates a new file instance by hooking it up to an
- *                    anonymous inode, and a dentry that describe the "class"
- *                    of the file
+ * anon_inode_getfd2 - creates a new file instance by hooking it up to an
+ *                     anonymous inode, and a dentry that describe the "class"
+ *                     of the file
  *
  * @name:    [in]    name of the "class" of the new file
  * @fops:    [in]    file operations for the new file
@@ -122,8 +133,8 @@ EXPORT_SYMBOL_GPL(anon_inode_getfile);
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns new descriptor or an error code.
  */
-int anon_inode_getfd(const char *name, const struct file_operations *fops,
-		     void *priv, int flags)
+int anon_inode_getfd2(const char *name, const struct file_operations *fops,
+		      void *priv, int flags, int anon_inode_flags)
 {
 	int error, fd;
 	struct file *file;
@@ -133,7 +144,7 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		return error;
 	fd = error;
 
-	file = anon_inode_getfile(name, fops, priv, flags);
+	file = anon_inode_getfile2(name, fops, priv, flags, anon_inode_flags);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_put_unused_fd;
@@ -147,6 +158,7 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 	return error;
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfd);
+EXPORT_SYMBOL_GPL(anon_inode_getfd2);
 
 static int __init anon_inode_init(void)
 {
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index d0d7d96261ad..10699462dcb1 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -11,11 +11,28 @@
 
 struct file_operations;
 
-struct file *anon_inode_getfile(const char *name,
-				const struct file_operations *fops,
-				void *priv, int flags);
-int anon_inode_getfd(const char *name, const struct file_operations *fops,
-		     void *priv, int flags);
+#define ANON_INODE_SECURE 1
+
+struct file *anon_inode_getfile2(const char *name,
+				 const struct file_operations *fops,
+				 void *priv, int flags, int anon_inode_flags);
+int anon_inode_getfd2(const char *name, const struct file_operations *fops,
+		      void *priv, int flags, int anon_inode_flags);
+
+static inline int anon_inode_getfd(const char *name,
+				   const struct file_operations *fops,
+				   void *priv, int flags)
+{
+	return anon_inode_getfd2(name, fops, priv, flags, 0);
+}
+
+static inline struct file *anon_inode_getfile(const char *name,
+					      const struct file_operations *fops,
+					      void *priv, int flags)
+{
+	return anon_inode_getfile2(name, fops, priv, flags, 0);
+}
+
 
 #endif /* _LINUX_ANON_INODES_H */
 
-- 
2.25.0.225.g125e21ebc7-goog

