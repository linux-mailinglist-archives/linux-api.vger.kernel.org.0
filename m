Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154A17D0D5
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfGaWSZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:18:25 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51682 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfGaWRd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:17:33 -0400
Received: by mail-pl1-f201.google.com with SMTP id d2so38350239pla.18
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ntXMs3tuU1WJWAT2FcG/TTitDVr73WJt0FGo+YbSY68=;
        b=HrqnGgT/Kx9hNGqVlVUgxnIYl8rTBybQ5Ifj2bggLCtzemtg2blYVGJnWffbszo0G4
         UjpHxW7HkBRdo+INLWhc2IdjCbhXZgEQAyRDJP7VOCjca5XaX8JP3xsW4cw3/ItmAR9w
         dVVXTLsma167hFq93lDweBzp0DSst3nDGEQiAB+UsZcWxpj4hB4YeI6Zfw9m7aScye1X
         BHjkyJyHMgUbuhXo35blKaHLa1jtFfEaLkQtn1NloMxZSDPrmPucX8FaypPD045qIOk/
         GmM0qi5ox7Ho4Xicn1IuSwqboZe5rlqLPYk/gJ+2MJxFFO9+ROiNLWDI4+Zot70/0RUU
         db6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ntXMs3tuU1WJWAT2FcG/TTitDVr73WJt0FGo+YbSY68=;
        b=hZQ5SLK931mBzwfZy7hsGKxdOYcEyRM5ufjCJfhzvDAvU056+xFX2P6mgQYm/kASju
         Tj2Rm0IWyXMNkjz5Yg90KKZXHsWqX0OK825MiU4PuZ7p/cROgiXnBrdJ57n4GrSXzG5z
         5L76QYDo1bJdugphxybvgbKqgrGxXRsCHxNjWK9xWHEbWqtgRhNwwCir9ycY15F10deM
         SSnH30PQed0ld0otnoUV3G8xXrwNrzOUJLH5cDoNzIBr1nsIEIzXY0mFWY8c0kFezho+
         dgD3j7YNX2XqyMqFOQdqzG3ZrevSi0AdGuAincWNl+O3RpZ/DcNpClboZhyAkyOdqlz7
         Xdaw==
X-Gm-Message-State: APjAAAVpvHbhm6RWCmSD68n6wblqnGp7Kd2uQQTScyJPf9xzgmL9TpQN
        QS91s9sg9XeZU4uErRsH8L9J9nSuW8EZOdwlGZLUoA==
X-Google-Smtp-Source: APXvYqx9DA2EjjfkcwjhE4budPDyV07tqbfVAJJzleENfVZUWm3i3nqE3fBnVJrX9ObnRu9QWiOGVhTVLL4ak7oB/pRHyg==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr115321144pgj.4.1564611452695;
 Wed, 31 Jul 2019 15:17:32 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:14 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-27-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 26/29] debugfs: Restrict debugfs when the kernel is locked down
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
index ec5c197985ec..51ced4ae9280 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -36,6 +37,32 @@ static struct vfsmount *debugfs_mount;
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
@@ -353,6 +380,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_private = data;
 
+	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -516,7 +544,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &debugfs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -616,7 +644,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
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
2.22.0.770.g0f2c4a37fd-goog

