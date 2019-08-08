Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD0856EA
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389766AbfHHAIg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:08:36 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55938 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389775AbfHHAIf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:35 -0400
Received: by mail-pl1-f202.google.com with SMTP id q11so54322611pll.22
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lAGo2XEfN1Kmsxc7Q91nfXTi8fMC4u4EK30rK7PWIbE=;
        b=m+FRVkzTTZecGp5G2Qtqu3b3ltj41jQE9rKyhJ7cPwHw1LSJx+WpoqIpl3R8tbpsEW
         38V+0FKg5iE30T69xOt3/6X5K65cB4YpYkQGm37jtTAcSQbg+9LCEDOIRjOIEQtQ0tvW
         J6rWvWVMM2meBMpilyHgCTvPR+17Rq9u6MRwlg9vzXChEpiovRni67ZOWfHEj8bF1tLv
         lVh8A8W7SiilL6uPfEhj6miiT66NuBw8j18UBpg6QJA7nDJ+ZuthE4e6cOxWZpPVdbau
         vAtr0tQrwVEPEYajDU1dXEbCF03VWoRTXXAXideAwL6ew9w+c42B94m7PjeWovUxscIF
         hDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lAGo2XEfN1Kmsxc7Q91nfXTi8fMC4u4EK30rK7PWIbE=;
        b=N1R3jgu259tnE8OCiOO52sxW9Oaz1XWMe2Nui2+fsFcqNwKb/+rVTsbXPUvaDW+de5
         XKkaubWlTohzWwEYOqlpesSCfN8KvBiXHBRtU4hZdGbpdXIgh8fdiAJ+YY9KR0BnIGXv
         A2jQSBO0ED1iLQwG+JjzMFuL5o1JNdr8UirqnxALQ+Vsg9KyJYkUZsT1fmOtp5/gC5pf
         1eXGc+e5ekZbwwcb9FKKrjPiHKIYIsKYgW42y1RH+s9ZhkJF5Kz1JzBTCiliIM4IW2Go
         O93d5cY7T42g2DTOeRSepGfnLqEVM5GkOylF5xKvWWrixeUr9i7LhmemiMKtNiOzDwvX
         c/Iw==
X-Gm-Message-State: APjAAAWt1fjfGCNJ0c5WAGAh6bEFLshtetinPmtWcjaMyJKWC6LZ+kFN
        fPkUIOzoWgAWMmgv421GqV1gQo3MLWyE34M9pzrsXQ==
X-Google-Smtp-Source: APXvYqx7OkuIfHCySJZprzWOfnAAQDKJEnIVhWIjflbWl0ZornABeBzNdt/8hnskuPnMxdBWG3gnzWDneFwwdFOWw9LhDg==
X-Received: by 2002:a63:e807:: with SMTP id s7mr9723607pgh.194.1565222914450;
 Wed, 07 Aug 2019 17:08:34 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:19 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 27/29] tracefs: Restrict tracefs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Tracefs may release more information about the kernel than desirable, so
restrict it when the kernel is locked down in confidentiality mode by
preventing open().

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c           | 40 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1387bcd96a79..12a325fb4cbd 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -28,6 +29,23 @@ static struct vfsmount *tracefs_mount;
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
@@ -210,6 +228,12 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
+static void tracefs_destroy_inode(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		kfree(inode->i_fop);
+}
+
 static int tracefs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -236,6 +260,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode  = tracefs_destroy_inode,
 	.show_options	= tracefs_show_options,
 };
 
@@ -372,6 +397,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
+	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -387,8 +413,20 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
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

