Return-Path: <linux-api+bounces-4768-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C7B55BDB
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 02:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB73B1B28690
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 00:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833BC155322;
	Sat, 13 Sep 2025 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcTnakkN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4D405F7
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724922; cv=none; b=AK20/Lc6VIjyoewZIROLisLwu9sEUcPQCkoaiVaW7vlnZnCDADoZ0NVSwkt5MWALViiYBRZAqugR2/32lBU7RQH+BjEcSnRkJ9C6SI3dxZ2PtGNH8pZpCeQ0DKOGWTEvBQHlutKPKqyPYL6IzY77BtHANvMjSU8tr/IJT9hcxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724922; c=relaxed/simple;
	bh=eGt6p4ZjFeLe2iCSQ/AVZeB8ZlFdwKPgIafRJWfogAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3Esfmq1gkpyqLT/dhDoKnHD2A0Sg8OKKdLE5t2I8GJMRJO6OXi2wCQcfQrfgwU9rjMq7dmwRsL2/AOk6GjCDzxLTuBQ1O6zmw/rygYMULFyBtq81j2bBt8ZNhA3uRqsKB+THLcJ/weGsDQODPXeBK4bxFl6IWq6ibiXSykx4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcTnakkN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b02c719a117so428952866b.1
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724918; x=1758329718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brUQzIfCd0Hsthf3I31XlgkqlDsgZYmVYRfws4Ev66A=;
        b=ZcTnakkNmFYjQdChEjtaqK6HEcCwMgYs1rXg39HJJglVr4tegCv0ClYqye4QSs7t5B
         nBzOxKX9ffT0TGlKUjDYDesIqmLae9atQjaty2n+4wACYUDNbsMBnvrEJU+7A6wppzuf
         JkP2j1HCvksc/G+cQLMJEB26oM4bly9Uaf7len5rAcFLSnrXK4MmjB6mR3W+WbQQzGj2
         s0B9VmeQH+3+7yBlflwz4FO+7d2p4g5iDNhDU+wLnTbCVPDkcwCH9tSj+xzmhjrzsvNV
         xYCXm15o6tgPTnS+wPQy3tNtCeu/09LXTyp/+sllPbYOZ5RLlcWPnA/Rd3bvtnahbXWt
         lKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724918; x=1758329718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brUQzIfCd0Hsthf3I31XlgkqlDsgZYmVYRfws4Ev66A=;
        b=nIuoK9O7RAONCZeZ02igYCz+FNCgukjfkt8gkO8PPzPzT9lgbs16JsqE8ct8pAMtRn
         RVcIUJVb6iP5BY1h/Bt2APFAjdO7cUdOharva26BSudQu8oL65C7HLP3PI3PbTHTi1Sq
         vRJ194lHDoiGFDiXW1jXNpjT11vYRtUjmpqTGLdPM7e5InHYd0EWTtXQGBu97Dce34LF
         DKHFeHXL28L1SlS7ptGKe88geED1QPcVi0fi0Zj+BJQzfEip6ssUCc7XRLBGQXRK/ePT
         YhiR7IG35/krKNfLaoy0xOq+Fq6HXxO5xGgk+yVhqsZyfFMh+kgnbBOT6OFhCq1tm5d9
         IpOw==
X-Forwarded-Encrypted: i=1; AJvYcCXzvFl5SFD+XpItcSAsnbpK0xX9DVO+7YEzGg8UVdI/wO76yUJPjRtKxgtuIUMJfnJd8sJ2Nf+Y6K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXu0U5tGxz6oP8uw7rFjATZH+1IgkKVD8r/xVWHbq13fD+J7G
	WTAI8sJgT3x9JQn8+GXaimdA+SFsHLgcOPfCutQfv4KFPf1aYF33E/W0
X-Gm-Gg: ASbGnctVZbzXwcw6QQ9qc2mWhkgftIqLL+wJXez2eZzX9gf9bO62y9e/28p8POhNEbS
	Di/lzI+0skAPUKbHhKeK7HepIQbrziP+i6tI3PFt42G9MunnFBtlxTqFcfnt7fEtPxergoB2ryS
	p05u2Iivj6beuYyUUh6b11AD3agK0PIXYulmUjc9Cs86/SS3JNNlu+ZzQOW0sfG97X4GdaW283O
	rf82E14B/WNn0F5wxWewTdhAD+AawAUxHHkFw01UZoLzQSieI97+y5ptcoikyZ3VnPpQzveckUr
	dQuILzin/8EHJzwC9FUnlf+JcM2xgR7aohp5vNtgy28TTzhslbQi22BaTNfJKnIdpDIL9rsOPdZ
	jxKcOxkztNja4UZXM7IaIVCUYNldbRw==
X-Google-Smtp-Source: AGHT+IFhKaZuOZuHh9m3zt1qgdjZK8E9TZ0Xtk6mNXJxSo6OktVvoEgwN+yDRi3/QGfp0/HMd569SA==
X-Received: by 2002:a17:907:3d8c:b0:afe:8b53:449c with SMTP id a640c23a62f3a-b07c37dc9f1mr442768666b.34.1757724918489;
        Fri, 12 Sep 2025 17:55:18 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b316e2d4sm471493966b.45.2025.09.12.17.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:55:18 -0700 (PDT)
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
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 14/62] init: m68k, mips, powerpc, s390, sh: remove Root_RAM0
Date: Sat, 13 Sep 2025 00:37:53 +0000
Message-ID: <20250913003842.41944-15-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root_RAM0 used to specify ramdisk as root device.
It means nothing now, so let's remove it

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/m68k/kernel/uboot.c                |  1 -
 arch/mips/kernel/setup.c                |  1 -
 arch/powerpc/kernel/setup-common.c      | 11 ++++-------
 arch/powerpc/platforms/powermac/setup.c |  4 +---
 arch/s390/kernel/setup.c                |  2 --
 arch/sh/kernel/setup.c                  |  4 +---
 include/linux/root_dev.h                |  1 -
 init/do_mounts.c                        |  2 --
 8 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index fa7c279ead5d..d278060a250c 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -83,7 +83,6 @@ static void __init parse_uboot_commandline(char *commandp, int size)
 	    (uboot_initrd_end > uboot_initrd_start)) {
 		initrd_start = uboot_initrd_start;
 		initrd_end = uboot_initrd_end;
-		ROOT_DEV = Root_RAM0;
 		pr_info("initrd at 0x%lx:0x%lx\n", initrd_start, initrd_end);
 	}
 #endif /* if defined(CONFIG_BLK_DEV_INITRD) */
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 11b9b6b63e19..a78e24873231 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -173,7 +173,6 @@ static unsigned long __init init_initrd(void)
 		goto disable;
 	}
 
-	ROOT_DEV = Root_RAM0;
 	return PFN_UP(end);
 disable:
 	initrd_start = 0;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 68d47c53876c..97d330f3b8f1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -363,17 +363,14 @@ void __init check_for_initrd(void)
 	DBG(" -> check_for_initrd()  initrd_start=0x%lx  initrd_end=0x%lx\n",
 	    initrd_start, initrd_end);
 
-	/* If we were passed an initrd, set the ROOT_DEV properly if the values
-	 * look sensible. If not, clear initrd reference.
+	/* If we were not passed an sensible initramfs, clear initramfs reference.
 	 */
-	if (is_kernel_addr(initrd_start) && is_kernel_addr(initrd_end) &&
-	    initrd_end > initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
+	if (!(is_kernel_addr(initrd_start) && is_kernel_addr(initrd_end) &&
+	    initrd_end > initrd_start))
 		initrd_start = initrd_end = 0;
 
 	if (initrd_start)
-		pr_info("Found initrd at 0x%lx:0x%lx\n", initrd_start, initrd_end);
+		pr_info("Found initramfs at 0x%lx:0x%lx\n", initrd_start, initrd_end);
 
 	DBG(" <- check_for_initrd()\n");
 #endif /* CONFIG_BLK_DEV_INITRD */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index eb092f293113..237d8386a3f4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -296,9 +296,7 @@ static void __init pmac_setup_arch(void)
 #endif
 #ifdef CONFIG_PPC32
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
+	if (!initrd_start)
 #endif
 		ROOT_DEV = DEFAULT_ROOT_DEVICE;
 #endif
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 7b529868789f..a4ce721b7fe8 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -923,8 +923,6 @@ void __init setup_arch(char **cmdline_p)
 	/* boot_command_line has been already set up in early.c */
 	*cmdline_p = boot_command_line;
 
-        ROOT_DEV = Root_RAM0;
-
 	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	if (IS_ENABLED(CONFIG_EXPOLINE_AUTO))
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 50f1d39fe34f..c4312ee13db9 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -147,10 +147,8 @@ void __init check_for_initrd(void)
 
 	/*
 	 * If we got this far in spite of the boot loader's best efforts
-	 * to the contrary, assume we actually have a valid initrd and
-	 * fix up the root dev.
+	 * to the contrary, assume we actually have a valid initramfs.
 	 */
-	ROOT_DEV = Root_RAM0;
 
 	/*
 	 * Address sanitization
diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index 847c9a06101b..e411533b90b7 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -10,7 +10,6 @@ enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
 	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
 	Root_Generic = MKDEV(UNNAMED_MAJOR, 253),
-	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
 };
 
 extern dev_t ROOT_DEV;
diff --git a/init/do_mounts.c b/init/do_mounts.c
index f0b1a83dbda4..5c407ca54063 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -437,8 +437,6 @@ static dev_t __init parse_root_device(char *root_device_name)
 		return Root_NFS;
 	if (strcmp(root_device_name, "/dev/cifs") == 0)
 		return Root_CIFS;
-	if (strcmp(root_device_name, "/dev/ram") == 0)
-		return Root_RAM0;
 
 	error = early_lookup_bdev(root_device_name, &dev);
 	if (error) {
-- 
2.47.2


