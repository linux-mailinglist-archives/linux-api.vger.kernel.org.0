Return-Path: <linux-api+bounces-4815-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E057B56645
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 06:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B3E3B6AE0
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 04:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FB267B01;
	Sun, 14 Sep 2025 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+TEr2s7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EC2264BB
	for <linux-api@vger.kernel.org>; Sun, 14 Sep 2025 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822560; cv=none; b=bYGw6WIHdSpnuJcAaWwlknVK2GvGPyTiyTAmHb6cgBwraEA4UxZc90evkqQP5Sfjgm/1Rl37pZJFkEhfwG2MdUIQu/q5QZkH5FoZvyTPUH3uM4eTLGE0RWhZMkDdvmCfRRhqGpE3QC1ncojm08UMV/LSwgqCVV9YgT9sC7e281U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822560; c=relaxed/simple;
	bh=mXj7cE8XRukvZmlGe0peX71/UIhhIPtw83kOLZuHb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zvak5KQDDMa1B1UvbF+HnMAHHc4/vevfEB3aiv99n6Wi4tmjLSPwj14hoUfrsSr8fQQeUUyTyzGWCtEdaJy0Nn8Ia7OLH+2P1qe5gDDQ15OuAos1pibDnuvH3xHRSYvs5TYVS0VP/W0GQMjEW+F8kbpNQ5xafXbUWaWND27lDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+TEr2s7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so475737666b.2
        for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 21:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822553; x=1758427353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfHXrWCKrlpEZqDge/aP0gxhQYbVnNzBJ3I+hBjJodo=;
        b=b+TEr2s7VcMbpmwoP7AjOlMx1fuBw5WSRmF+HTbI1WIKXJUBSGXtQXTtTLFZitRP0d
         UtP5pyH6iwKvqLS8a7meVvUlP/DRc00eoZxNS47REwJlMM4S/4sQ9iMy6BsPaEhkRdBP
         P0b3d9H1VEnyyyqqunCRyder8dFyC0QOzkqz739dLehTnXbFziZp5Chy6CDGX8UFXSJ3
         FO+2QTr9uRcEJFkbqIhe4CLHSpHQstuU9uK0+5yuywGS2xtrunfdC+FN0TRdOa0n/coR
         Fk4TlW87a1ckkDwxJVrJdZuwP8T8KziC0yqBX8xfWV55D9FPZT8BXCHWcX/cedzQ6FGc
         uGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822553; x=1758427353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfHXrWCKrlpEZqDge/aP0gxhQYbVnNzBJ3I+hBjJodo=;
        b=Hip8cTWPNYc4TXZ4kcb00CBRsNqfd2ipPzRwEaevb1nab09f5fvTOZCJXNLopgTIGz
         fxvgBnMW2QF8+oJJz5CixojJkzjEcwb/wdv+VFfMFSFx09osfcNHKSCs3olP1wTtSg+/
         IZyIYkOFcOKyZi+8oBQ8jzkLQLrnSlaNTEmz3R6OLrXfxZNJ3rdybEhSxJgl+s9Ps0uu
         hV7Of2WQ0bqeLa0q4hdMX3PzcbL4QWUyKmWdKQCM9NPklILLaOMwyt8WMiWTvnIYHg5s
         3lwijv0N6ZME6i2m+wsNrEK4uMTjiOYtiOzma4VrHxWR5HzlK3IZtN6Iye+1hvcnF4Jv
         3T2w==
X-Forwarded-Encrypted: i=1; AJvYcCXjFxup+HNB0Vqri9ogVk/LH+/hoCIcPyNx6KF7tvBMMIuyTV3NIH3qt+3ZLCnGt5So/Ak0tLg4Sok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9sD6kdZs1Q8IX7JQ6EAsA269tfZRP8wf2bDNh09GXN+fb29kn
	SPyu7jH1nA2MtM+wpwzCPa/59X6DEM1aqo9VPqx/q0DNc4l4YJcrHqts
X-Gm-Gg: ASbGncvMHCr/j80QmfpuOd+L0bAvLzASVjodivTPyfgB2bi8ROKmXnUc5fteKR6fyWs
	46HTuOeydlYkLtuDC6CKq2e2FP6Y96LVS1kyi4DXfunESKhUczFZNU58mUgkuAlwWbbVsa/WY17
	tgOMNcABPKMrN9PodY43Ldpn7ymm6ErWybjJGTUHSimuSKg+ueePQtvKLVPBaywTzw3yFxh3QG8
	benLIey2sz0T5K49TgwcwQrdjMSB6O2XZcSwtu86kbVP/U1mTnwjONMCpP+sltQgr4yBPn97vkm
	t4aaq8ztH7qMaxu2b9+E8fiz7iO24RHWz4l7a2AgJMSPEkPvGyIyAwfc4R/jWh8fFLn695dSXUr
	+JFeR9abQSUsSvBHOj3M=
X-Google-Smtp-Source: AGHT+IH9WrBYcHXI5H1C26NKONjIwBzDqvLtWme/VOicduvo9YKd3Q1ocrvvAv57lj7aB3SGfgC7Eg==
X-Received: by 2002:a17:907:3e9f:b0:afe:a83a:87ce with SMTP id a640c23a62f3a-b07c353e3e2mr786740566b.2.1757822553165;
        Sat, 13 Sep 2025 21:02:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd413sm687036166b.71.2025.09.13.21.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:02:32 -0700 (PDT)
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
Subject: [PATCH RESEND 58/62] init: rename CONFIG_RD_LZMA to CONFIG_INITRAMFS_DECOMPRESS_LZMA
Date: Sun, 14 Sep 2025 07:02:27 +0300
Message-ID: <20250914040227.3813593-1-safinaskar@gmail.com>
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

Initrd support was removed,
and CONFIG_RD_LZMA has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/configs/clps711x_defconfig        | 2 +-
 arch/arm/configs/hisi_defconfig            | 2 +-
 arch/arm/configs/lpc18xx_defconfig         | 2 +-
 arch/arm/configs/sp7021_defconfig          | 2 +-
 arch/arm/configs/vf610m4_defconfig         | 2 +-
 arch/mips/configs/bmips_stb_defconfig      | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 arch/powerpc/configs/44x/fsp2_defconfig    | 2 +-
 arch/powerpc/configs/skiroot_defconfig     | 2 +-
 arch/riscv/configs/nommu_k210_defconfig    | 2 +-
 arch/riscv/configs/nommu_virt_defconfig    | 2 +-
 arch/sh/configs/sdk7786_defconfig          | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig  | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 +-
 usr/Kconfig                                | 4 ++--
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 4d71d227361f..18ae5ee9d6c9 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -2,7 +2,7 @@ CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_INITRAMFS=y
-CONFIG_RD_LZMA=y
+CONFIG_INITRAMFS_DECOMPRESS_LZMA=y
 CONFIG_EXPERT=y
 CONFIG_JUMP_LABEL=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index fe18af17b7cc..19816374a0d0 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -2,7 +2,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_INITRAMFS=y
-CONFIG_RD_LZMA=y
+CONFIG_INITRAMFS_DECOMPRESS_LZMA=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_HIP01=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index abde171f1742..b1d5d8e4d7fe 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -2,7 +2,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index 4f5cd0d0511d..cfb20e693e1e 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -7,7 +7,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index 9e6175467998..9b20db4bb8e6 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -1,7 +1,7 @@
 CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_EXPERT=y
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 6ccb53279345..300e67507a1f 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -16,7 +16,7 @@ CONFIG_NR_CPUS=4
 CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 CONFIG_RD_XZ=y
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index ba6f06c29fed..5e46664549ec 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index 696f63bbc56e..038a261ebc20 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -9,7 +9,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_INITRAMFS=y
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index a5b30aba9ac1..008a63a90330 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -12,7 +12,7 @@ CONFIG_LOG_BUF_SHIFT=20
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index bc0df803ecaa..282b889596a1 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -3,7 +3,7 @@ CONFIG_LOG_BUF_SHIFT=13
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_GZIP is not set
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index 1291e21b7ce5..e9231eadcbad 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -2,7 +2,7 @@
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 2c339b2111fe..f19e9915e6de 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -28,7 +28,7 @@ CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_DECOMPRESS_BZIP2=y
-CONFIG_RD_LZMA=y
+CONFIG_INITRAMFS_DECOMPRESS_LZMA=y
 CONFIG_RD_LZO=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 06d82e725e64..6b38ba64a2aa 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -15,7 +15,7 @@ CONFIG_RELAY=y
 CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index cde2ae3ca4b1..9b260f57e63f 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -16,7 +16,7 @@ CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
-# CONFIG_RD_LZMA is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index 325c2d95eb74..030c6a898d7a 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -68,7 +68,7 @@ config INITRAMFS_DECOMPRESS_BZIP2
 	  Support loading of a bzip2 encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_LZMA
+config INITRAMFS_DECOMPRESS_LZMA
 	bool "Support initial ramfs compressed using LZMA"
 	default y
 	select DECOMPRESS_LZMA
@@ -157,7 +157,7 @@ config INITRAMFS_COMPRESSION_BZIP2
 
 config INITRAMFS_COMPRESSION_LZMA
 	bool "LZMA"
-	depends on RD_LZMA
+	depends on INITRAMFS_DECOMPRESS_LZMA
 	help
 	  This algorithm's compression ratio is best but has a large dictionary
 	  size which might cause issues in memory constrained systems.
-- 
2.47.2


