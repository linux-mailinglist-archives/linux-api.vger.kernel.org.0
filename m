Return-Path: <linux-api+bounces-5386-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB8C7143E
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7D6C34D3DF
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693DD311C1B;
	Wed, 19 Nov 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks/+oZuJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DEE2F0C6D
	for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591198; cv=none; b=tBAze6/Cs+/uvJQLuZiBiNl7Uynt+IisimDxBgSrn/V3zrFoBy8andkhNQS4W1tU9UGzPCkTR+s+rHIbQjSFtYuqLhIUe5NgZ55ZbkoqaLHg4vrmLBdN9di1EmTT795DzjI+l5wa+UGId18TBYMpUqqXbjMj+YOkDquy8EEx3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591198; c=relaxed/simple;
	bh=B30ksd/i6KlWZzGSOJluZMvprLijJbryg/ZlhpI37Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUSXBBL4LWcT3emiW/N5VyWKYBIDN2/kwkgsWGJlqynGqh3zgyXDCUvpo1Hyh49DTDXLKhACCntSrEE+afOCMM/8JdfGmIRT3tnKRXfwR02Q0AXbwa/jlAzGfbLj1+TLnIVm9wMs9RA3cgUhPs+MH0GxfdTiMvpK9AOxvnRkZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks/+oZuJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59431f57bf6so174218e87.3
        for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763591194; x=1764195994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpz7T6QQ/kKXNjO1wwsOWaO7Nw3DfMsERYzmwHv+rnY=;
        b=Ks/+oZuJCDnebhI/q84MpZIMxSSmR02wVCEevnZc1aVVu9pDn1WEtDzlaWN4rHlVEK
         xRTI+4lXSL73O0KE9kgIGE1c0FiCg7u2InWpFSvXguS7hu6KuxzsB2MYGztfV5anG9vG
         COYW43//eD8Vdu+t4Ft8o4W3DWuvWQ3vrMBroCj3Gj4DP3zbYsJGxzwUHPwvf0aU+OuS
         G4aMe7Mv92CUhLl/KUHpKuum+hX4ahVMaLmmIk/a04AfZ+IIcQ5bdKqn7BqOfNLHj3Ix
         mKIfyfMnA42vfid2aXlHPDxr9k9IccE2MzTGL20vfqF4aLub6u8iBT5bDMaNuv1KQ33t
         R62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591194; x=1764195994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rpz7T6QQ/kKXNjO1wwsOWaO7Nw3DfMsERYzmwHv+rnY=;
        b=cSo/uE2yDFkyHLim5Ydt2CQ5jKBOkqGwCfK5KTbJgC8Ot8SJb7bKof1BiDfF9eg30n
         qsdvOLXezSR8VQfj3sAaZoD6LRXxMwlmg9eMJbv9yUrAGwHTuyezcOpvTCAeoZ7P80vh
         WOLtPN7ldMaNAMsiiV/4CWqQW75q/6836RKAhUZE+adlObFgioyFkIaDZE+O+1TaDxM3
         saELXXvzZd/Y6RJL22+ZZ84mec/M5GjzWaYO3GCn2A5P/UyjKpXXMWSxa3Yf7jTEGAFI
         H/wl+wFWsrz7NKlECPn+4Up3DglQDTF+VrUCa8zI0jviDAQFxs3PcxKr5UvswCqHqMba
         TZkA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8UGYUz/G+FuhIhM8iPckN4atG0JCl6g7MPlyTSPURm/ER35yOUp8O9DtPAJwAdvt2cLmDEshZYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUA08+I7zpia3RGmaYcVm4bk37Qo0Bxrtu9NBFUr+HBMDn0im
	fR5w46pFQg88XDE4fSOjcvZVqoqPGIROTMO6rKUvD0HjEbeVIfkpJSi+
X-Gm-Gg: ASbGncvSwiRVbZtMbKPJIn+Zu+soIgeY7kRd73ELQ1oasGaxWejc5WOjpX4GZW+usuv
	ZK10ZG6gI4iakBg+JTAeUVZnoggIGe2Q3/gjGCOKvlzNvg/Bx0F9HgQbPdIveIktlzMyndkkOC1
	QiYewybo73LiwUzRSrBbgDBDHP11DPdvVqFMnIf3Gz2bRl5mJ/4YMO0XKtZFUGIOZBSgY1lcn2s
	ojlL8ZeYaRkK2uuUa7au71kTGCRm6jllfdSoREdrPGiJSmtgCPjBxCjbo1tXjdK1hU8Iv8Fdn7c
	DtIPuVbY/fPE/vBBuNSqLMZXDmEt740lU3CorVAa7sA5oLVoEqJ4XlWBpqHhx97OJnqtR+gUJ+3
	tXZfY/CaiDzR7nbSqOE/yF23JNsDp7CTRSYMQnCo9usFIPSy6h0oevsJLvPBYrVNmdksogccF+r
	tlF1+8WF7RYuheBwUYxQjR
X-Google-Smtp-Source: AGHT+IHKJFkl9t5N8j7PyCRMaEBOUQoDY6WPT5NRD3nx1OIP3SnAvvmsobVsbW3qyUfaDOP5L+EeFQ==
X-Received: by 2002:a05:6512:3e0a:b0:590:6598:4edf with SMTP id 2adb3069b0e04-5969e318d8cmr157688e87.47.1763591193750;
        Wed, 19 Nov 2025 14:26:33 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969db8989csm167842e87.39.2025.11.19.14.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:26:33 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v4 2/3] initrd: remove deprecated code path (linuxrc)
Date: Wed, 19 Nov 2025 22:24:06 +0000
Message-ID: <20251119222407.3333257-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119222407.3333257-1-safinaskar@gmail.com>
References: <20251119222407.3333257-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove linuxrc initrd code path, which was deprecated in 2020.

Initramfs and (non-initial) RAM disks (i. e. brd) still work.

Both built-in and bootloader-supplied initramfs still work.

Non-linuxrc initrd code path (i. e. using /dev/ram as final root
filesystem) still works, but I put deprecation message into it.

Also I deprecate command line parameters "noinitrd" and "ramdisk_start=".

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +-
 fs/init.c                                     | 14 ---
 include/linux/init_syscalls.h                 |  1 -
 include/linux/initrd.h                        |  2 -
 init/do_mounts.c                              |  4 +-
 init/do_mounts.h                              | 18 +---
 init/do_mounts_initrd.c                       | 87 ++-----------------
 init/do_mounts_rd.c                           | 17 +---
 8 files changed, 22 insertions(+), 129 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 15af6933eab4..df441d1a9555 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4324,8 +4324,10 @@
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
 
-	noinitrd	[RAM] Tells the kernel not to load any configured
-			initial RAM disk.
+	noinitrd	[Deprecated,RAM] Tells the kernel not to load any configured
+			initial RAM disk. Currently this parameter applies to
+			initrd only, not to initramfs. But it applies to both
+			in EFI mode.
 
 	nointremap	[X86-64,Intel-IOMMU,EARLY] Do not enable interrupt
 			remapping.
@@ -5338,7 +5340,7 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
-	ramdisk_start=	[RAM] RAM disk image start address
+	ramdisk_start=	[Deprecated,RAM] RAM disk image start address
 
 	random.trust_cpu=off
 			[KNL,EARLY] Disable trusting the use of the CPU's
diff --git a/fs/init.c b/fs/init.c
index 07f592ccdba8..60719494d9a0 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -27,20 +27,6 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 	return ret;
 }
 
-int __init init_umount(const char *name, int flags)
-{
-	int lookup_flags = LOOKUP_MOUNTPOINT;
-	struct path path;
-	int ret;
-
-	if (!(flags & UMOUNT_NOFOLLOW))
-		lookup_flags |= LOOKUP_FOLLOW;
-	ret = kern_path(name, lookup_flags, &path);
-	if (ret)
-		return ret;
-	return path_umount(&path, flags);
-}
-
 int __init init_chdir(const char *filename)
 {
 	struct path path;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 92045d18cbfc..0bdbc458a881 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -2,7 +2,6 @@
 
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
-int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index f1a1f4c92ded..7e5d26c8136f 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -3,8 +3,6 @@
 #ifndef __LINUX_INITRD_H
 #define __LINUX_INITRD_H
 
-#define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
-
 /* starting block # of image */
 extern int rd_image_start;
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 0f2f44e6250c..1054ad3c905a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -476,13 +476,11 @@ void __init prepare_namespace(void)
 	if (saved_root_name[0])
 		ROOT_DEV = parse_root_device(saved_root_name);
 
-	if (initrd_load(saved_root_name))
-		goto out;
+	initrd_load();
 
 	if (root_wait)
 		wait_for_root(saved_root_name);
 	mount_root(saved_root_name);
-out:
 	devtmpfs_mount();
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	init_chroot(".");
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6069ea3eb80d..a386ee5314c9 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -23,25 +23,15 @@ static inline __init int create_dev(char *name, dev_t dev)
 }
 
 #ifdef CONFIG_BLK_DEV_RAM
-
-int __init rd_load_disk(int n);
-int __init rd_load_image(char *from);
-
+int __init rd_load_image(void);
 #else
-
-static inline int rd_load_disk(int n) { return 0; }
-static inline int rd_load_image(char *from) { return 0; }
-
+static inline int rd_load_image(void) { return 0; }
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-bool __init initrd_load(char *root_device_name);
+void __init initrd_load(void);
 #else
-static inline bool initrd_load(char *root_device_name)
-{
-	return false;
-	}
-
+static inline void initrd_load(void) { }
 #endif
 
 /* Ensure that async file closing finished to prevent spurious errors. */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index f6867bad0d78..fe335dbc95e0 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -2,13 +2,7 @@
 #include <linux/unistd.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/minix_fs.h>
-#include <linux/romfs_fs.h>
 #include <linux/initrd.h>
-#include <linux/sched.h>
-#include <linux/freezer.h>
-#include <linux/kmod.h>
-#include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
 
@@ -41,6 +35,7 @@ late_initcall(kernel_do_mounts_initrd_sysctls_init);
 
 static int __init no_initrd(char *str)
 {
+	pr_warn("noinitrd option is deprecated and will be removed soon\n");
 	mount_initrd = 0;
 	return 1;
 }
@@ -70,85 +65,19 @@ static int __init early_initrd(char *p)
 }
 early_param("initrd", early_initrd);
 
-static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
-{
-	ksys_unshare(CLONE_FS | CLONE_FILES);
-	console_on_rootfs();
-	/* move initrd over / and chdir/chroot in initrd root */
-	init_chdir("/root");
-	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	init_chroot(".");
-	ksys_setsid();
-	return 0;
-}
-
-static void __init handle_initrd(char *root_device_name)
-{
-	struct subprocess_info *info;
-	static char *argv[] = { "linuxrc", NULL, };
-	extern char *envp_init[];
-	int error;
-
-	pr_warn("using deprecated initrd support, will be removed soon.\n");
-
-	real_root_dev = new_encode_dev(ROOT_DEV);
-	create_dev("/dev/root.old", Root_RAM0);
-	/* mount initrd on rootfs' /root */
-	mount_root_generic("/dev/root.old", root_device_name,
-			   root_mountflags & ~MS_RDONLY);
-	init_mkdir("/old", 0700);
-	init_chdir("/old");
-
-	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
-					 GFP_KERNEL, init_linuxrc, NULL, NULL);
-	if (!info)
-		return;
-	call_usermodehelper_exec(info, UMH_WAIT_PROC|UMH_FREEZABLE);
-
-	/* move initrd to rootfs' /old */
-	init_mount("..", ".", NULL, MS_MOVE, NULL);
-	/* switch root and cwd back to / of rootfs */
-	init_chroot("..");
-
-	if (new_decode_dev(real_root_dev) == Root_RAM0) {
-		init_chdir("/old");
-		return;
-	}
-
-	init_chdir("/");
-	ROOT_DEV = new_decode_dev(real_root_dev);
-	mount_root(root_device_name);
-
-	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = init_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
-	if (!error)
-		printk("okay\n");
-	else {
-		if (error == -ENOENT)
-			printk("/initrd does not exist. Ignored.\n");
-		else
-			printk("failed\n");
-		printk(KERN_NOTICE "Unmounting old root\n");
-		init_umount("/old", MNT_DETACH);
-	}
-}
-
-bool __init initrd_load(char *root_device_name)
+void __init initrd_load(void)
 {
 	if (mount_initrd) {
 		create_dev("/dev/ram", Root_RAM0);
 		/*
-		 * Load the initrd data into /dev/ram0. Execute it as initrd
-		 * unless /dev/ram0 is supposed to be our actual root device,
-		 * in that case the ram disk is just set up here, and gets
-		 * mounted in the normal path.
+		 * Load the initrd data into /dev/ram0.
 		 */
-		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			init_unlink("/initrd.image");
-			handle_initrd(root_device_name);
-			return true;
+		if (rd_load_image()) {
+			pr_warn("using deprecated initrd support, will be removed in January 2027; "
+				"use initramfs instead or (as a last resort) /sys/firmware/initrd; "
+				"see section \"Workaround\" in "
+				"https://lore.kernel.org/lkml/20251010094047.3111495-1-safinaskar@gmail.com\n");
 		}
 	}
 	init_unlink("/initrd.image");
-	return false;
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 5311f2d7edc8..0a021bbcd501 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -22,6 +22,7 @@ int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
 {
+	pr_warn("ramdisk_start= option is deprecated and will be removed soon\n");
 	rd_image_start = simple_strtol(str,NULL,0);
 	return 1;
 }
@@ -177,7 +178,7 @@ static unsigned long nr_blocks(struct file *file)
 	return i_size_read(inode) >> 10;
 }
 
-int __init rd_load_image(char *from)
+int __init rd_load_image(void)
 {
 	int res = 0;
 	unsigned long rd_blocks, devblocks, nr_disks;
@@ -191,7 +192,7 @@ int __init rd_load_image(char *from)
 	if (IS_ERR(out_file))
 		goto out;
 
-	in_file = filp_open(from, O_RDONLY, 0);
+	in_file = filp_open("/initrd.image", O_RDONLY, 0);
 	if (IS_ERR(in_file))
 		goto noclose_input;
 
@@ -220,10 +221,7 @@ int __init rd_load_image(char *from)
 	/*
 	 * OK, time to copy in the data
 	 */
-	if (strcmp(from, "/initrd.image") == 0)
-		devblocks = nblocks;
-	else
-		devblocks = nr_blocks(in_file);
+	devblocks = nblocks;
 
 	if (devblocks == 0) {
 		printk(KERN_ERR "RAMDISK: could not determine device size\n");
@@ -267,13 +265,6 @@ int __init rd_load_image(char *from)
 	return res;
 }
 
-int __init rd_load_disk(int n)
-{
-	create_dev("/dev/root", ROOT_DEV);
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n));
-	return rd_load_image("/dev/root");
-}
-
 static int exit_code;
 static int decompress_error;
 
-- 
2.47.3


