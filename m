Return-Path: <linux-api+bounces-4773-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFF4B55C42
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 03:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BFF1D6200C
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DFE19258E;
	Sat, 13 Sep 2025 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJWWdfHX"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF941339A4
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725250; cv=none; b=HDnCPsQcB9uf9a0V0CzGyVtE6mwfcaiu255qXypJ9D/QD+y02s9+De4XWwoGzGh0lTD6yOd5E8hCpKA7rlBrzJg5uUbPwqAwBfFUKlqj4d8ZyjcmWxGGSS1PNxqBSC6yTiCCUI2BfCb3U1WHjVMbMDii+2G7EseeI9VfIiMwQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725250; c=relaxed/simple;
	bh=WmrSleO2XCNYN8uS+EKoWQ5+E5KvuC+dDdzgWUmiL7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq2wvHHejfJkK+W0jqbht8EPtrdULzcG7U6+7kezHnD3bFV2GH3jZnBG+5ZhlDNCtolEzEPoUgXHoUSlxJZsFGY94PNWxEf2vppvDljdGwp4d244A4hokggdwLu4vu0V7gOigFGXZVtBoBQ8+jb0TwFkR2qxr6O7RciOyks692I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJWWdfHX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so344919266b.3
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 18:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725246; x=1758330046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoEWD/ShpnwzaQ8ORuPz9c0ALO6Ls67XcNa7R8iqlGI=;
        b=MJWWdfHXdyyxn+qZxVH4DHxwMcIT4qAafC00rGnqPEIXIU4kCt7lhJt7wWfYB4mV2/
         b+nlHZOUEAEpw32mNdqPDuX6WDTqq/uIRW7bD1vUv96nBtUPlucQkJRTPnNJk+5noDnW
         mKp4cAm4cmigaIxf0/9ZxG+YfkVzzcH8tVOxcUR0alnYeP6aBT+N5ORVCIcW2NRKeJKq
         GNHfkNo4L71eYJeK8rNpATt14Lc0+jxJqU9wUlpWjBHQnxAWeCAUXmsKwoFmWjNfjnfq
         XdF6VYrC81c7Xd4xquqLcjzB7zOhccL0yoqx7FTh5WW+sQ2vY82qrfFsQaZm/l7WuqSY
         oWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725246; x=1758330046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoEWD/ShpnwzaQ8ORuPz9c0ALO6Ls67XcNa7R8iqlGI=;
        b=koU4KksCgd8EIqHRwcAPXLpZCGqI79xJvkXad/9MPUv7np7genraYlu95P5Knwfaw7
         hv5Ougf55zHWH9eLznq6cBBMLeObYZ8iGMdpbGoH4yaUvQtCfLTZV2Fg3dUMUpPu/DHn
         8AuPk18juwFOzb9jki3PHq3cgwfxGkstybTjjh+Rf35n60QyDMvh9swDPJfJYeNvcC7j
         vhvkcnTvmcPSSRAYaENfLrq/yBmpc3428Hl0gWFLhGj2bKKnF/sGBASvTXoeqJMArQe7
         eT8pzwI9kdOGjOwaA8CouI4kC3OZZGInkYcMQogAH3xaSUXwNIGtPU4leRtlqeEN94oZ
         DRaA==
X-Forwarded-Encrypted: i=1; AJvYcCV2QlBtDSXs3u7ja8m1Ya0x7zdR/4qALiDy/JEirNLL3e/ZANwOc2HhPmJlmh+E8wC2Xi6P1UAlinQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnXYkFFYC0N+YHZdoESsyDkeTohvY47sHlsbeUiFg6Z9rDppn
	mzV/fFWwwqeidJu/JJ/I3dkbOAVG4Hdze6LeSMIXzMPZp++wCkaPL8je
X-Gm-Gg: ASbGncuSuV3zcB3PwVz9MMLKnWyF/o6ljR/uXQ4yis72ygtPv8Kh4OcdvjxSFkT2mlm
	KmRaH+3xy1X8/9brryJHJjEuX4P0ZvBtsUYPJd22elazoiOMf+iX24+yazvXmQDr+JzMBY0j73b
	Dir6SONm9NGsX6h7DRJZ0NIzOUpBf5vGxbKyP9Rr0uuDzf3AxU9WP67GRz0hmMoYAUtHnYlqsBz
	42ucfdaBZIJv8B4LOyl3i3hkMJ34wNc/XP26a0rsyezz+PeKm6f83Fxzv5isAjalSdyE9LbLOJ7
	2YsmqWdv2KiF+zCxPObMMGnfRe4swyOdAjAbW7a7G2DZSwGWix4+j0s+bNhcqV3ePVf+Xc4megI
	NsiMkBIVgBZxGPbtNSieRsfA4EOiswA==
X-Google-Smtp-Source: AGHT+IFN5sGx8Mx9m2aD2jbl3cQxyHXmx0LPyYapXdwnUwhP9+XvMT+8Mvs3QRhc/UxXrnFX4WIsYg==
X-Received: by 2002:a17:907:daa:b0:b04:7232:3e97 with SMTP id a640c23a62f3a-b07c357507cmr467580066b.21.1757725245716;
        Fri, 12 Sep 2025 18:00:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dcf77sm470822766b.64.2025.09.12.18.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:00:45 -0700 (PDT)
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
Subject: [PATCH RESEND 19/62] init: remove mentions of "ramdisk=" command line parameter
Date: Sat, 13 Sep 2025 00:37:58 +0000
Message-ID: <20250913003842.41944-20-safinaskar@gmail.com>
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

It is already removed

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4210-origen.dts   | 2 +-
 arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts | 2 +-
 arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts | 2 +-
 arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts | 2 +-
 arch/arm/configs/exynos_defconfig                 | 2 +-
 arch/arm/configs/s5pv210_defconfig                | 2 +-
 drivers/block/Kconfig                             | 1 -
 7 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-origen.dts b/arch/arm/boot/dts/samsung/exynos4210-origen.dts
index f1927ca15e08..4dcf794bd18b 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-origen.dts
@@ -36,7 +36,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial2:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
index 18f4f494093b..4cdeddeff3fc 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
@@ -30,7 +30,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
index c83fb250e664..4b18cc55d6ca 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
@@ -27,7 +27,7 @@ aliases {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial1:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts b/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
index bb623726ef1e..4164c7c2a3eb 100644
--- a/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts
@@ -27,7 +27,7 @@ memory@40000000 {
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		bootargs = "root=/dev/ram0 rw initrd=0x41000000,8M init=/linuxrc";
 		stdout-path = "serial2:115200n8";
 	};
 
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 6915c766923a..77d3521f55d4 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -15,7 +15,7 @@ CONFIG_HIGHMEM=y
 CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
+CONFIG_CMDLINE="root=/dev/ram0 rw initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 02121eec3658..8ec82d9b51e4 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -8,7 +8,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_ARM_APPENDED_DTB=y
-CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
+CONFIG_CMDLINE="root=/dev/ram0 rw initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index df38fb364904..8cf06e40f61c 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -229,7 +229,6 @@ config BLK_DEV_RAM
 	  store a copy of a minimal root file system off of a floppy into RAM
 	  during the initial install of Linux.
 
-	  Note that the kernel command line option "ramdisk=XX" is now obsolete.
 	  For details, read <file:Documentation/admin-guide/blockdev/ramdisk.rst>.
 
 	  To compile this driver as a module, choose M here: the
-- 
2.47.2


