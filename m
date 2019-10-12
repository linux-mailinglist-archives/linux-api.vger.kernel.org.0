Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB49D51FB
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfJLTQQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 15:16:16 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35058 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfJLTQQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 15:16:16 -0400
Received: by mail-pl1-f201.google.com with SMTP id o12so7997122pll.2
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XBcGefgr1yRisxJT4NE2JQJYpjj8lNWOfHcCyIG9KpI=;
        b=ic3TEmp3rq98da85M0YYxffLPJvBhxV5otcPnbDFdiP+s7Ef//5umgryYUQiJhRRVc
         FT4Jo2Q1EgG3q99Fgn0tEZnoIJq2F1Llk+odHuy81UCsDt4oKoBRd7vjPcAtRTjpukXs
         fN98NDbm4+rlXNgAoBJ4uzE05o6FTuVkKPVbVulo3cdZM+xt1U6m1GWenQXYhFxiGS31
         oOGM3xpxZUqkui0wZMby25jHolu5GkruCZEN3GPddD7J3xnPuWEOEJqfT7mullE9HB82
         Dzo5lzCc7D/Ns/zuEqEjrMCIh6RPg70YAXULNkgiWhsCW7QF3o+3C4s7isky1arH81Io
         wohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XBcGefgr1yRisxJT4NE2JQJYpjj8lNWOfHcCyIG9KpI=;
        b=CI53OEtw2/x6b5URXU5lO0WVpEwQEG4FTsuZFp5/b3QwrA1EoPgXXZkZfGZH53fEOk
         zvIHy+M4vSMDpxHgjsrH4SNxTQa40KZcHIp6qaH1lMAUR8qllFUK1+w2h0o/M92U4D88
         IRgDb661q6beG7yFmXwoMmMDkrsGS2yXSVUDULaur3nAa3S5rmUwUe1tJOnxiuvc0mxX
         0zTCMVg31CYfu7hc8/iiUfUSQreBxpkEbSuWffhBRNefGtS5XojQh7w6uxAgKs7WL4zR
         6z5xbQ9V43w6jLqrcBQHGemZc0Is/2IjWlAi8vBV7HARh4NURzuJpJNUY+rnu0u48jjc
         smdQ==
X-Gm-Message-State: APjAAAVVhR6WWiVJrgNsHjO3h8apoqvjKH6Nxu6K/9xCaHEPjCRqbBp9
        4IngvFgIsKBaMmf3wQxchPfNoMYBBfYhlrRtNXezxf+UAulk0Ks8pLeR613vsFSUD8kpQjL/tEw
        BcSf3dUNGiOpPeyc1HJLRLqFT1K81ZEh/Fk/EIEaHBzzeik8SmyX0LaaOikvsBNuQwg==
X-Google-Smtp-Source: APXvYqyjtLhKOlLs/X/TM4D1BsJHFx6ZCWxIVVOSH2sl3Mizifjdv2koxAijNACLcV4zc532tKNHFwEaKX8=
X-Received: by 2002:a63:383:: with SMTP id 125mr24098053pgd.41.1570907774844;
 Sat, 12 Oct 2019 12:16:14 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:15:57 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-3-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 2/7] Add a concept of a "secure" anonymous file
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A secure anonymous file is one we hooked up to its own inode (as
opposed to the shared inode we use for non-secure anonymous files). A
new selinux hook gives security modules a chance to initialize, label,
and veto the creation of these secure anonymous files. Security
modules had limit ability to interact with non-secure anonymous files
due to all of these files sharing a single inode.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/anon_inodes.c          | 45 ++++++++++++++++++++++++++++++---------
 include/linux/lsm_hooks.h |  8 +++++++
 include/linux/security.h  |  2 ++
 security/security.c       |  8 +++++++
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index caa36019afca..d68d76523ad3 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,6 +55,23 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
+struct inode *anon_inode_make_secure_inode(const char *name,
+					   const struct file_operations *fops)
+{
+	struct inode *inode;
+	int error;
+	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_PTR(PTR_ERR(inode));
+	inode->i_flags &= ~S_PRIVATE;
+	error =	security_inode_init_security_anon(inode, name, fops);
+	if (error) {
+		iput(inode);
+		return ERR_PTR(error);
+	}
+	return inode;
+}
+
 /**
  * anon_inode_getfile2 - creates a new file instance by hooking it up to
  *                       an anonymous inode, and a dentry that describe
@@ -72,7 +89,9 @@ static struct file_system_type anon_inode_fs_type = {
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns the newly created file* or an error pointer.
  *
- * anon_inode_flags must be zero.
+ * If anon_inode_flags contains ANON_INODE_SECURE, create a new inode
+ * and enable security checks for it. Otherwise, attach a new file to
+ * a singleton placeholder inode with security checks disabled.
  */
 struct file *anon_inode_getfile2(const char *name,
 				 const struct file_operations *fops,
@@ -81,17 +100,23 @@ struct file *anon_inode_getfile2(const char *name,
 	struct inode *inode;
 	struct file *file;
 
-	if (anon_inode_flags)
+	if (anon_inode_flags & ~ANON_INODE_SECURE)
 		return ERR_PTR(-EINVAL);
 
-	inode =	anon_inode_inode;
-	if (IS_ERR(inode))
-		return ERR_PTR(-ENODEV);
-	/*
-	 * We know the anon_inode inode count is always
-	 * greater than zero, so ihold() is safe.
-	 */
-	ihold(inode);
+	if (anon_inode_flags & ANON_INODE_SECURE) {
+		inode =	anon_inode_make_secure_inode(name, fops);
+		if (IS_ERR(inode))
+			return ERR_PTR(PTR_ERR(inode));
+	} else {
+		inode =	anon_inode_inode;
+		if (IS_ERR(inode))
+			return ERR_PTR(-ENODEV);
+		/*
+		 * We know the anon_inode inode count is always
+		 * greater than zero, so ihold() is safe.
+		 */
+		ihold(inode);
+	}
 
 	if (fops->owner && !try_module_get(fops->owner)) {
 		file = ERR_PTR(-ENOENT);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a3763247547c..3744ce9e9172 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -215,6 +215,10 @@
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
+ * @inode_init_security_anon:
+ *      Set up a secure anonymous inode.
+ *	Returns 0 on success. Returns -EPERM if	the security module denies
+ *	the creation of this inode.
  * @inode_create:
  *	Check permission to create a regular file.
  *	@dir contains inode structure of the parent of the new file.
@@ -1552,6 +1556,9 @@ union security_list_options {
 					const struct qstr *qstr,
 					const char **name, void **value,
 					size_t *len);
+	int (*inode_init_security_anon)(struct inode *inode,
+					const char *name,
+					const struct file_operations *fops);
 	int (*inode_create)(struct inode *dir, struct dentry *dentry,
 				umode_t mode);
 	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
@@ -1876,6 +1883,7 @@ struct security_hook_heads {
 	struct hlist_head inode_alloc_security;
 	struct hlist_head inode_free_security;
 	struct hlist_head inode_init_security;
+	struct hlist_head inode_init_security_anon;
 	struct hlist_head inode_create;
 	struct hlist_head inode_link;
 	struct hlist_head inode_unlink;
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..5b6f7e0de577 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -315,6 +315,8 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode, const char *name,
+				      const struct file_operations *fops);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..c87695f66413 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1001,6 +1001,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+int
+security_inode_init_security_anon(struct inode *inode,
+				  const char *name,
+				  const struct file_operations *fops)
+{
+	return call_int_hook(inode_init_security_anon, 0, inode, name, fops);
+}
+
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
-- 
2.23.0.700.g56cf767bdb-goog

