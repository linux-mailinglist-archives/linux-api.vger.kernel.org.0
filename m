Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E54FAD51FC
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfJLTQO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 15:16:14 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54621 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbfJLTQO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 15:16:14 -0400
Received: by mail-pg1-f202.google.com with SMTP id e13so3616057pgi.21
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/UHvjgRQlFr+QTHINyaWDXzgiWPrMOtH1xWtvxTh1Pk=;
        b=QVaCwJI/Dy+4bGAEPxHQzjVMbjAytCXRo0MmNrV48LlYVf3yDoZPPRzxqjXSnM5Mmp
         fHlXBhfXUIxldxUCrkPPcUACkv0ggT8jetsndX2bQaHSVSVCBaiYFNID4GMHl4VIGjrX
         Vw/baW+5BXaY0HP+0bCqzPYcGlPGoDvAl9Oym00VsAmffcDJ4YZU6V4lEtKZbqI9V5ge
         EDDuWX2MWPeIx1dhLdRILCrYoGC+qCveyidVQBIJ2wibYjLRcv+P/XOORpO+d1YS9KIs
         X+BEX6xBFtaZFft+FtZGFrvzeezygTi/2ai2D4QFKdXF0zHkz/dK1K0jhmAeJNGcY6AK
         y51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/UHvjgRQlFr+QTHINyaWDXzgiWPrMOtH1xWtvxTh1Pk=;
        b=f45p+IOOgMMEmbIAWb3YxEMBXVbfZlkcR+1Asm3gmjg5GJtByrj4pnV4ujyuXTmZxy
         GUq2wmY/aJQn081IU3jpfieeRSTa7ZPVduyNMpPeuPXf4OicyNlrYR9dyDrtYPpYHUZV
         VRLegBZ3KTThJYnW2YGCisVK8/2acpVitSQrH0x8om61aVLUP718fwQCKsO1fmkAqpDG
         wEOEK/sWNnJGfGM+SqA+/b4b8W3F2ex+VxGQFS8tSccotWsXn2vtfTj64s3KI6+Wn1IV
         zbf0M7m1ysNROo0XEnvRKDDve3NUkgssoHiqP+SpzWl2eq83dRtAEd/2QjtldsSGGxBf
         cvbQ==
X-Gm-Message-State: APjAAAUUgEcfvvDE+TLhm1iMOt0/5HQzShVOFbRumY+jAIX3StHMPLkn
        qYW1HDgGgI+uz+lA5hh7ZYzqjTLVty7wIT7lAYYwIxTZEVv2BHILlelLL0hBZiNDNzIpd41GFkG
        aQYzKOSECjSQcAEyEVWgRA1ZaqoXx4Kwm8iS84FkV/81Mwd62Eh/0FeK6G/8dxAk+SQ==
X-Google-Smtp-Source: APXvYqzZzST+dwz9qdPhpAdj1SPmX1Nudrfqa/IQzTNLYSwju7u82ReYlDZoSMKW3qfqlE/4Q11i6MDAmoY=
X-Received: by 2002:a63:f850:: with SMTP id v16mr24430933pgj.257.1570907772984;
 Sat, 12 Oct 2019 12:16:12 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:15:56 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-2-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 1/7] Add a new flags-accepting interface for anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
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
2.23.0.700.g56cf767bdb-goog

