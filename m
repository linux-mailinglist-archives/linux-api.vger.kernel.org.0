Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3157B282
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfG3Srl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Jul 2019 14:47:41 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46840 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3Srk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Jul 2019 14:47:40 -0400
Received: by mail-pl1-f202.google.com with SMTP id k9so35842367pls.13
        for <linux-api@vger.kernel.org>; Tue, 30 Jul 2019 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0pXH41oDr5n5A5Nqy3r8yf+zNgEME8ywg2NvLGu1usI=;
        b=tNsT5UytdZLcCZd0C7EgSOYaigaGXMUScGxN0gDTyqpWT45H44j3LfHzphHUobVkL4
         RcU4adigiMxAZXh10qbjMVLNUNASoXCRecfBxQjos3FUv/gFdXjcXhXEW7yiQpQLqsfr
         vxHaX0032jt+/tJfcIUYbo/dXfj6tap4ospXabSre+S9+fKsoIZbo2Tm3lQd8gFD8hyu
         HHX/3zfc7cqkDrDXl8MY9V92WDfj5h7cqWs2N9DAQbGd5LXyANGDL6jfMea7rwIx5fcu
         FGz0vLPdVrtVHJfyAMNwQRq47+Bf5WOLQ1ifCHhnus6oqnmKwUdwaN2klkSY1cIBnpSX
         De1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0pXH41oDr5n5A5Nqy3r8yf+zNgEME8ywg2NvLGu1usI=;
        b=Mw4Eb37nG7Cg8DSSH7wvgFJHDgxiIAKf0mm4KRms8IB0ilcfsoFYu5sXuOpXo3jXcy
         W+DnP4v97DDkxPQqttX8INmcvDChJmFdSsDsAzOXfu48lhKLM9WIweIRkbuCGUYygvgn
         jt6zv5Ix77bs+BagjTXkuwOkbWlro5zy4vjtgVt1KxvtjrmtelV2Kvo5z4akQFndWTLI
         G2r4Z+LsYEupsQ6HVY4KkWnCAz782MYRAhxqkpqrE7goLFPp24Cu6dumfbw2jxK+0IfX
         hjV0uq20wbl5khgZgvRz7WU7hGkxEWIvm+Umvexl1vbI4BON1qiGP4NUqBw+Wxhgz5bZ
         +NdA==
X-Gm-Message-State: APjAAAXmlYCbsVpds4BFh9J1GO+D7t2saZowaiykS0t9b06gY8RAyrLA
        0L3kD8cBEUXR5boE7mhQf0cnGkgPwqM801KucuZW6Q==
X-Google-Smtp-Source: APXvYqzYjVpc+zHP0Gem9lR+d9nkJoivQJ2232f3VwG1MjXQ5j9+3YlYMKtT9Yp3lBjH8G56CWKxH8Rabxg8b3nRG2Vj6A==
X-Received: by 2002:a63:d941:: with SMTP id e1mr76211750pgj.75.1564512459798;
 Tue, 30 Jul 2019 11:47:39 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:47:34 -0700
In-Reply-To: <20190724222354.7cbd6c6e@oasis.local.home>
Message-Id: <20190730184734.202386-1-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190724222354.7cbd6c6e@oasis.local.home>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH] tracefs: Restrict tracefs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Tracefs may release more information about the kernel than desirable, so
restrict it when the kernel is locked down in confidentiality mode by
preventing open().

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---

Added the iput()

 fs/tracefs/inode.c           | 40 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index eeeae0475da9..fb4d1d89ce53 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -27,6 +28,23 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static int default_open_file(struct inode *inode, struct file *filp)
+{
+	struct dentry *dentry = filp->f_path.dentry;
+	struct file_operations *real_fops;
+	int ret;
+
+	if (!dentry)
+		return -EINVAL;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	real_fops = dentry->d_fsdata;
+	return real_fops->open(inode, filp);
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -221,6 +239,12 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
+static void tracefs_destroy_inode(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		kfree(inode->i_fop);
+}
+
 static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 {
 	int err;
@@ -256,6 +280,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode  = tracefs_destroy_inode,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
 };
@@ -387,6 +412,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
+	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -402,8 +428,20 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	if (unlikely(!proxy_fops)) {
+		iput(inode);
+		return failed_creating(dentry);
+	}
+
+	if (!fops)
+		fops = &tracefs_file_operations;
+
+	dentry->d_fsdata = (void *)fops;
+	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
+	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = fops ? fops : &tracefs_file_operations;
+	inode->i_fop = proxy_fops;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index d92323b44a3f..807dc0d24982 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -121,6 +121,7 @@ enum lockdown_reason {
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
 	LOCKDOWN_PERF,
+	LOCKDOWN_TRACEFS,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 88064ce1c844..173191562047 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -36,6 +36,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
 	[LOCKDOWN_PERF] = "unsafe use of perf",
+	[LOCKDOWN_TRACEFS] = "use of tracefs",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.770.g0f2c4a37fd-goog

