Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE56D540
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbfGRTpu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:45:50 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37410 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404077AbfGRTp0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:45:26 -0400
Received: by mail-pg1-f202.google.com with SMTP id n9so13826540pgq.4
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qw1hNK3wCX6R4vY8e/8vxPZ6PP8rjnDd+LyVPgBCDkE=;
        b=pRCV+LiX3uIS6rBZnORlhMPl5flvnryxw9pzdNLnV4RsRiGtXL2vV9B5QRq36fKmZx
         P+mU/VTMjbfM0ZFiLUdVYr015iychyJ5Mt2SgXuE4WtVg9cLb2kkW+IEdqvZgCHP/HlQ
         LGFeBS/DvyMIPsFn4NjkYH4bPJlDajjAOtzXkU6uyGcs3wylHTewNonrNZ4fjHlDswgO
         vHTCu4yzV8YKkmiwXAVvhB+k3ZTVUbbuRpEW3K1V7F8onGzAsUIcrrztKJapBJLGHQLr
         0RgVi7zW7oU4uEgd9K9pmjt3pADBRYunWWsKq79demanmkwoOM0CN5YkvoslFXxxdhXh
         +6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qw1hNK3wCX6R4vY8e/8vxPZ6PP8rjnDd+LyVPgBCDkE=;
        b=UhOTAfyItC20MUt4ztK3SKQJlOnizQRgLhrW9cAgtHBK07M2bTgbDoRhVEUqGe3CHo
         bfvrSNDNL6KPiu9RNdfHqFjwtEdWyJpqx9r23EP0ddK3MUkxUXYXxnc6BghkguN0v614
         VQT5TEjeYXQHsypUCCw/RkUDMo+scJ7RXz1+OC9msrH/NjWJM5Isqhp90Ta4wEFeQACF
         oIOD+l31kJC5iK4PR5/Y+AjID1N23KYpzsTx3YQnRr83XrGTpKYiAUoUQaB33+R1cOVZ
         lK51nru4kjfs1zbjGU/zAMvaozU+tadOFTNqmnBHswj1gOq+CiU4meqq0jj0gTOQmCnO
         V/+A==
X-Gm-Message-State: APjAAAUOCkmNiq84WdhHnkIkHwsQfatgXEDIO6a2/t5l1YpS/eTy/RAd
        LdVFvLv0k3UwvM6lf2BEbndPI4HjMN8fq6maSKI5dg==
X-Google-Smtp-Source: APXvYqw0b3MspFrMrkYngmKsccdvoswjMjLjdWD+7diBBpS6rTe6CSkRrqT9WJALAnmMCF8TE9+Dud/nR24DK1i9snQlGw==
X-Received: by 2002:a65:584f:: with SMTP id s15mr33387767pgr.175.1563479125753;
 Thu, 18 Jul 2019 12:45:25 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:12 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-27-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 26/29] debugfs: Restrict debugfs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow opening of debugfs files that might be used to muck around when
the kernel is locked down as various drivers give raw access to hardware
through debugfs.  Given the effort of auditing all 2000 or so files and
manually fixing each one as necessary, I've chosen to apply a heuristic
instead.  The following changes are made:

 (1) chmod and chown are disallowed on debugfs objects (though the root dir
     can be modified by mount and remount, but I'm not worried about that).

 (2) When the kernel is locked down, only files with the following criteria
     are permitted to be opened:

	- The file must have mode 00444
	- The file must not have ioctl methods
	- The file must not have mmap

 (3) When the kernel is locked down, files may only be opened for reading.

Normal device interaction should be done through configfs, sysfs or a
miscdev, not debugfs.

Note that this makes it unnecessary to specifically lock down show_dsts(),
show_devs() and show_call() in the asus-wmi driver.

I would actually prefer to lock down all files by default and have the
the files unlocked by the creator.  This is tricky to manage correctly,
though, as there are 19 creation functions and ~1600 call sites (some of
them in loops scanning tables).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: acpi4asus-user@lists.sourceforge.net
cc: platform-driver-x86@vger.kernel.org
cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <greg@kroah.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 fs/debugfs/file.c            | 30 ++++++++++++++++++++++++++++++
 fs/debugfs/inode.c           | 32 ++++++++++++++++++++++++++++++--
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 93e4ca6b2ad7..87846aad594b 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -19,6 +19,7 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/poll.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -136,6 +137,25 @@ void debugfs_file_put(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_file_put);
 
+/*
+ * Only permit access to world-readable files when the kernel is locked down.
+ * We also need to exclude any file that has ways to write or alter it as root
+ * can bypass the permissions check.
+ */
+static bool debugfs_is_locked_down(struct inode *inode,
+				   struct file *filp,
+				   const struct file_operations *real_fops)
+{
+	if ((inode->i_mode & 07777) == 0444 &&
+	    !(filp->f_mode & FMODE_WRITE) &&
+	    !real_fops->unlocked_ioctl &&
+	    !real_fops->compat_ioctl &&
+	    !real_fops->mmap)
+		return false;
+
+	return security_locked_down(LOCKDOWN_DEBUGFS);
+}
+
 static int open_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
@@ -147,6 +167,11 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = debugfs_is_locked_down(inode, filp, real_fops);
+	if (r)
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not clean up after itself at exit? */
@@ -272,6 +297,11 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = debugfs_is_locked_down(inode, filp, real_fops);
+	if (r)
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not cleanup after itself at exit? */
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 042b688ed124..7b975dbb2bb4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -26,6 +26,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -35,6 +36,32 @@ static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
 
+/*
+ * Don't allow access attributes to be changed whilst the kernel is locked down
+ * so that we can use the file mode as part of a heuristic to determine whether
+ * to lock down individual files.
+ */
+static int debugfs_setattr(struct dentry *dentry, struct iattr *ia)
+{
+	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+
+	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
+		return ret;
+	return simple_setattr(dentry, ia);
+}
+
+static const struct inode_operations debugfs_file_inode_operations = {
+	.setattr	= debugfs_setattr,
+};
+static const struct inode_operations debugfs_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.setattr	= debugfs_setattr,
+};
+static const struct inode_operations debugfs_symlink_inode_operations = {
+	.get_link	= simple_get_link,
+	.setattr	= debugfs_setattr,
+};
+
 static struct inode *debugfs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
@@ -369,6 +396,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_private = data;
 
+	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -532,7 +560,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &debugfs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -632,7 +660,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		return failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
-	inode->i_op = &simple_symlink_inode_operations;
+	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
 	return end_creating(dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index 8ef366de70b0..d92323b44a3f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -115,6 +115,7 @@ enum lockdown_reason {
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
+	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index fb437a7ef5f2..88064ce1c844 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -30,6 +30,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
+	[LOCKDOWN_DEBUGFS] = "debugfs access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
-- 
2.22.0.510.g264f2c817a-goog

