Return-Path: <linux-api+bounces-5128-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7BBE68D0
	for <lists+linux-api@lfdr.de>; Fri, 17 Oct 2025 08:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A63A9DE4
	for <lists+linux-api@lfdr.de>; Fri, 17 Oct 2025 06:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4E30F54D;
	Fri, 17 Oct 2025 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFcFb+BL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D891C30E849
	for <linux-api@vger.kernel.org>; Fri, 17 Oct 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681436; cv=none; b=Bs9XerUhV1hRIUt5Gl+lt46L4h83lJ0mpQZoq359CLoh0cwzgrbbV8kyyDjBXcEtz9lXyT4wzw3nr9xHX1kP2ZSPm+oi1KW0Jet8n1pd1/WxbzhTkHaDjjMYSk2uXcpLdDMq9zQ+Z6lyMOA57epSStEUckYPzfaFIpXC9W5kvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681436; c=relaxed/simple;
	bh=xFurCGxlKeC/tk9lJqwt+qhC4G1oERsMk1YgSqg0z4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czc0DpTpLI3hgkG0PMXR0QCuAcuUqAKgLdP0MFvkMaqDWURWOfIuRmSI5aEUHU8iSl5y2T6JPQBERu1O5Vu7rfh7BO8diy2PwuiSEswzFspmYxPgLZw0/JSKvHPJWTo00+P/y/dfiRdBLmajNr0Ns/NahdDZNulgqkbY4Vq5KPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFcFb+BL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-426edfffc66so1018365f8f.1
        for <linux-api@vger.kernel.org>; Thu, 16 Oct 2025 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681432; x=1761286232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fApFH3gxVydnn6o27DJgEciM38Nk8T7NkdtS/0xgRng=;
        b=gFcFb+BLxPQu3TNKE4BTIz2YCDdFdCrDvakY3QsBdxkG64g5Bp6XuX76Acly2y6AUp
         NFPAA5JbIki9VRjsWcKI6spOrW3iuC6l698G1yQwvPCx2YDQiY2aGRFN91jyAiYwdKMU
         Q9QfZvhNWC4M6vtOfcwG/oz7gFfCZbHgtdjnkF34hOKs+I6E6H/fUP2jyna2scZcYkeg
         c7oATP1o+5lrO5o3gl8w54ldG/MyII0+etGyZnt5ed0SXPn4CEalJ/+ivjPOpm3h161y
         bfebaSWOTVFMrL2GlvQYo1HN6tTYr2FuFdbpYeuCN2gro1x7QgcCTfX0kGnpU1JApVhA
         039A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681432; x=1761286232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fApFH3gxVydnn6o27DJgEciM38Nk8T7NkdtS/0xgRng=;
        b=sfuodX4Ado8yPuyu5OkDuiPTsL4VD4oL+Ey17hY1Iv2usbysXtjPe29UlGMQSa0y9/
         5++9euVXF1hZno3WmOSPBet9nkETSpYaswY1UgRw2bj8Nhnht2JnRxWF0Gie3VLiM69x
         mSTGzQ4qGUYRH53kjDIU+cxI+cH2Y/JD0IZyZKzC/JGcsqqRTvbUmso7I3VXCb8E4eiv
         X4O2qHysY0dfZc+y37ePV94/zvM2E+ePppLS28mDd9XIi6QSQF/lkwHuq1CoAJEbmCHQ
         CpPD6SJpEijixBh6Rbji4yKfj2gyyDti/ImJiI/uVoUD2s+ji1N9eC27eE1jl5wuShoE
         B2yg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2ffkLIjlJ7EQfIXli3pESN3ySIsI+JZMVgfw3QLHLdHCG9IJKM0p6kAtwx+KNLxsrVIx0yBRqf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNswO7PjN1miE+etH6QnZB0d0mPcHOj+3qj0vlEsMVNMYhog6t
	GP2PjAKEYlBUuLEa5wF9pLh3qf2x32OswIEAMxwvUPx8WyQ8g23imhEB
X-Gm-Gg: ASbGnct36wnNkl/7tNBx0rW2afr2Lz3Bwx4/ZSn2cM6A+iZVnuVVtNV3Go8Q2uJniTU
	gnh4RM4dIMqBUkrZF0hyqj2F/urIwZdl4tqLOfRRgw/6vkH3+6/qvTwEW10bz0RQiTo9lndGUc5
	BvdTy2fzkjDJWtrpqVlRV8fBBoi1uE9yIXo0Q3wclRLLHo1Jx6Q5zaBZfhQ8Lz5H/M7RldouNMF
	j/OB540TXia2CF/Wn9+mkrp85W1O/+pz56I7WPAP5yT5B9mPpsbRgh1L7QSP//TBjvzcxXYITQR
	NAdiqHNXOhCADZeTryrd+mB2hj4MB7xkEuIvD0fAX/zuiyY5LdzgZIKwPZLmVLR1sFrr/UCypVP
	r9mQ0sSIp3KOUbt4313yT7ktIRMk59ShsJSi/J5OgRiKKjVaz51u+3TkDAWWA64/pvZUDvgQcj5
	sx
X-Google-Smtp-Source: AGHT+IH347DjV12fYF0hhdy1vww1ouDPmUAfsNrazlguHL6g+y9YN/2fKxqG5dPAECrqaSU8hvDOLQ==
X-Received: by 2002:a05:6000:4210:b0:426:d30a:88b0 with SMTP id ffacd0b85a97d-426fb8b7cb2mr4254322f8f.22.1760681432093;
        Thu, 16 Oct 2025 23:10:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce57d49bsm40185002f8f.10.2025.10.16.23.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:10:31 -0700 (PDT)
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
Subject: [PATCH v3 1/3] init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
Date: Fri, 17 Oct 2025 06:09:54 +0000
Message-ID: <20251017060956.1151347-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017060956.1151347-1-safinaskar@gmail.com>
References: <20251017060956.1151347-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

...which do nothing. They were deprecated (in documentation) in
6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
"rdev"") in 2020 and in kernel messages in c8376994c86c ("initrd: remove
support for multiple floppies") in 2020.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts.c                                | 7 -------
 init/do_mounts_rd.c                             | 7 -------
 4 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..15af6933eab4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3319,8 +3319,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	load_ramdisk=	[RAM] [Deprecated]
-
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
@@ -5284,8 +5282,6 @@
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
 
-	prompt_ramdisk=	[RAM] [Deprecated]
-
 	prot_virt=	[S390] enable hosting protected virtual machines
 			isolated from the hypervisor (if hardware supports
 			that). If enabled, the default kernel base address
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 2227f86100ad..4d720001c12e 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 6af29da8889e..0f2f44e6250c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -34,13 +34,6 @@ static int root_wait;
 
 dev_t ROOT_DEV;
 
-static int __init load_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated load_ramdisk= option\n");
-	return 1;
-}
-__setup("load_ramdisk=", load_ramdisk);
-
 static int __init readonly(char *str)
 {
 	if (*str)
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 19d9f33dcacf..5311f2d7edc8 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -18,13 +18,6 @@
 static struct file *in_file, *out_file;
 static loff_t in_pos, out_pos;
 
-static int __init prompt_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated prompt_ramdisk= option\n");
-	return 1;
-}
-__setup("prompt_ramdisk=", prompt_ramdisk);
-
 int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
-- 
2.47.3


