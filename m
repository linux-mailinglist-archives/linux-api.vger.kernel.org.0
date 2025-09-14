Return-Path: <linux-api+bounces-4819-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC99B56689
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 06:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958C2424CE1
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 04:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE8273D81;
	Sun, 14 Sep 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPbZj1qM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C67248176
	for <linux-api@vger.kernel.org>; Sun, 14 Sep 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822702; cv=none; b=Jzf0ygn4d/KkGZaBTZ+fPxJ8KyiXFBdR5Iei/bcqLsZH5WZXfkJOcSawf6ivCxd5JNjO2c/MV9b57fwgzaGbNKGuRMIgr0AH9L2UhNKglssLmVYzFVqOz8cp6vio3RtvajlUy01ohMz82hkIofAh85LpDZE4KadxgGb/AVE2loo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822702; c=relaxed/simple;
	bh=K5eh5PFkTwqgMsR/pgApUC7mRgd5tIkIjFvctye1Fsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUG+4obcnDjEg9vQvEn2+hh1gENB/Jy3v05bythZyPit/5mcgfKxmW9ZTCnvPJQGIWhqKK4kxCz1pcc8/gPsyfbI5qR0xwo7xxzgemgFlQ90hryKWnU64hZkqp31FP73UH4ZV0D2E5XPqGbdYSsoveN75S1TSy9LWlkufQWwWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPbZj1qM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0787fc3008so458249466b.3
        for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822698; x=1758427498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=kPbZj1qMmGYeecjJGUIlyIHIYamuich/CNzkJDmaNgGaqWvmKRH/xWtRF41uM5qkzv
         aCOo6S2Jlgd26xKUeuaakbbG7HEqDWn4lpel7AStmc2VlwPrBzY5joso88BimDPHYlXE
         lGKrirBAgOS/lwpoTHzC/tUmPxv1QF+CBszBJWWwZ+66J7mYEyOimyL2AtSvZIWLx1gK
         5mb9tOIr2zMFazTcGHaTU8u9ffMEBQkt1YmPKV0KVFaH5qyy1RH+UXAWhuy3AcjFOjXc
         Kxvqk7LMiYKMLQ7+ce+4bi1vcyj+dMrkLMVvDZ3cpLh4Ep/R+rND2M09mBBHfKuxH8K6
         CeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822698; x=1758427498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=XoYBoh1aVfAJOhRLWZaNb090CIimbAnD1Syc5fSlrqrOnFGwnOVP5CKTylnsTwMzJB
         QCXivvhVHLuXgt7aiKrELqSoUN8ft5Mq/g+ym+jlVMfqgBYqI9yTSLOQDuif53YCeILo
         uf9VeeOqYckEqYFs2dwHY47ez2wnHRirkZqiwpD8ltn0afjFOlgHkclNJlhi3YZnIlRs
         CEW6lombgnhoUFuVBXRb0N8be7VPQrjk2ckc9JoSH5eg08fTBrjMKMv68mBOtj+zqx3X
         mB38rELzRxzgl7/GG2/FNZnj96jAiqDlw7AMfKmKiD9QQk2E/r036Vrpf2X8phfdmBZg
         ApuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8+0nJ9yDNFKf012tHnXqwPar991kMDZ6JKXwET9SVCH7IDqNfqyCJk5jP87OQhacpHXVwZsISxQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9hEncnBiWKf9fL+eSAnkTyiGfNIDpsMyOmh2WwbbEJ3Py9f5
	93bCTa7tL11iCvMYq16JV3hcCr5RCnEmLXkTrZORGz3CGLxjBoBK9TvJ
X-Gm-Gg: ASbGncvvB0GWJ9makollkn+W2v6IstU+IUqsxFohCxGhDb0ZtSD/PWXbrqkjsU33Sm2
	uXYhNoh6OcClTWj/S3pWq+Rnn+grtck1jupGKXTVywppqqJXaYY9pQFPWQTkSox6yHhNvPmTzO1
	F7VwRtZUXiKsz1TUxVmAW4+6m4POgUWO0Q8aCOLzZ6kusOKsfMxq7hX44umAKkauZS1cxpcc6ce
	UGX/7FZVGcYshMuCxhMsPj2MPcFEOLsHqvnAoWqe1AZDcSj7Js7scU1r1Wwa2pFwYEcHY4oa/Xw
	MQHXYYqADqOKg3jtFGBYk0/dpubNjuiw8TSJEfVtCXo2d3hqVzAVLFc9+yIooOk/m96f5M4GGgO
	tr+K6WCN3BdCEVZEsOIg=
X-Google-Smtp-Source: AGHT+IEha/cEycx+vu0xF7TxjEegwfvZABBYj962u8Q3zWPEYF1LD+BxwewIqIoCpytaOJDSx3nrIQ==
X-Received: by 2002:a17:907:3d8e:b0:b04:706a:bcfc with SMTP id a640c23a62f3a-b07c37fd45cmr876333266b.33.1757822697695;
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07dbf5dbf5sm308085466b.79.2025.09.13.21.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
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
Subject: [PATCH RESEND 62/62] init: rename CONFIG_RD_ZSTD to CONFIG_INITRAMFS_DECOMPRESS_ZSTD
Date: Sun, 14 Sep 2025 07:04:51 +0300
Message-ID: <20250914040451.3848715-1-safinaskar@gmail.com>
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
and CONFIG_RD_ZSTD has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/riscv/configs/nommu_k210_defconfig | 2 +-
 usr/Kconfig                             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 6e961256a941..68cae0496b54 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
-# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_DECOMPRESS_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index 3a891a0c9ef4..06e1c1474b68 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -100,7 +100,7 @@ config INITRAMFS_DECOMPRESS_LZ4
 	  Support loading of a LZ4 encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_ZSTD
+config INITRAMFS_DECOMPRESS_ZSTD
 	bool "Support initial ramfs compressed using ZSTD"
 	default y
 	select DECOMPRESS_ZSTD
@@ -206,7 +206,7 @@ config INITRAMFS_COMPRESSION_LZ4
 
 config INITRAMFS_COMPRESSION_ZSTD
 	bool "ZSTD"
-	depends on RD_ZSTD
+	depends on INITRAMFS_DECOMPRESS_ZSTD
 	help
 	  ZSTD is a compression algorithm targeting intermediate compression
 	  with fast decompression speed. It will compress better than GZIP and
-- 
2.47.2


