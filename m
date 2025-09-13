Return-Path: <linux-api+bounces-4780-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9BBB55CC7
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 03:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 603DB4E1E87
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52219E7E2;
	Sat, 13 Sep 2025 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN1KTiCS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468018E377
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725710; cv=none; b=Nk5txoTWWpa9KdduX4B5h5S690CSxoujieXvEei4RMclEmWJUIL09w3r1+SIIZtFOcoEk1SGpLrny6EyBnBoR0piVoczm6BDjFzuzjcrRDDjCby9e9FBGV4zsBQNPTawybdGhP0vLnGXE65vmNuSblYb2fZxL3tZSIeSN5BMWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725710; c=relaxed/simple;
	bh=gH7Rddwu9MUu/+t3B7A94tjqEJhL770gz/5Md0mQZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq6YvFuhELq29hIy/Hp4srosi1Ia3sjkLUy4tJ+ysx8ZhhxpyQP/jJIcBDlcs9E+oxMaz0Tof3sUHUFL47CLIOWH2t0xUvBqK/yMbTaEXCqxHxH0dW/20Z/gmea9nmS8NvPi0s2Ia5hTwdZmeCUtrll+gI/NFy25Chg1NsEU6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN1KTiCS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso4872646a12.3
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725706; x=1758330506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=;
        b=aN1KTiCSwNPhtSh+4uLVVS63QBvN1SQIF/X+JI6JOkxphBHQx6cZlucBweKr0dd0aN
         TyaIVk7Wj1K4VbPS2H1rxAtLy39JfuTVaf8ZjwqRG3ylPlDNWaL8Rk8F3bDrnhZ7xQ9e
         zWgd+E9p49vul5ymwY8zacDsBH+TLU0baB9Emkeu29h5FMnkiJxkorjM2Rx/2vd3Wutp
         N9bjlEMsBJ83lkS8d/LH2Pnq6MagRHvRD+W+JloMVC4Fp4g8J5IWzZtPVJoAMLtnuXwv
         zaoOA/2BrTy+aWoOHpYqAtaMEkFqAJBBJyuc53gZ0vBFnbXXf6VzmFsbv1wjwLn3amUT
         doXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725706; x=1758330506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=;
        b=IvTlPjaccxhCI7HQHAqnbgTpwYBHmq1O7eYcAe+6ZmMhmWSi4BSWOLblWn3sqgwWjr
         xk/AlZuy6KcJCkYAJ/EBoEO9MSjrdOYoGMpH5XzI1H1gxmCFqqMqp1FO/YixUvNsuxUT
         sxHH8Yrd7W55tNNTUQjABTTE5bSwFUxmO2GwcdqTJF8u1cj2GkXOXJ9+AyyYtGxzGLFS
         /TRxxJ+wjhUsvONQGHIL4txApMtTHsvqoWKpadsl7zGP1Jbor4GiaHn+Gc0Vy9VB6Y9Q
         dFZ/z+fKdbtYOlcdtNjnMkHQuZNlSpXtRWTF8oWRnWjbLMJyyokGQRwj1EsGnITp4TKW
         BFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz+zGEPDEOeOUdLXrZXsvslW+FgdhiaHDSlg3+d0F4fIEkQWVDZ4pFFAANqoOWFzotk6w19lRz638=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ppWBSJjCJb5Jcn4Jk3i3mdeoEBw2wGAdHquFlCnxtUvQxkHA
	dRoG4SPnXtI8ou/vsHBtpbBYIDcY1/ZnbcRKvb77HZdBJaMCku2vg3ha
X-Gm-Gg: ASbGncv1x3jqglXeM0nWp8/brotL+lecpCR7oaNLKUqj8GjOjfW8aJOP4ulIEXO4M+a
	D860avgGQ2gcEHI2qQPRulxYlPNCVcFW0luGycraQSAxSz4vWJpyMWbFAGVMKsz8isUf9zMqf0r
	pw9Dtq8zicFqXoB87b0Fp+GhMgP9yJGfbqS4I0b7ne+ghZ9i/Uz1zjBwSLZ1DEuUcqoaiHmgguK
	2K1wy9HlksinOXeoR0GqktJJsfxhdxQMInM1TlrvyY1FPyWsdT7EYD3FztTUCzLiDscb31Whrxb
	x6dxs7YJzSDhD4vvHZ21PuEMvfqFWelboFFo9lzTjg5W8FexDZ5zTbmNEMapVKMEagWVOjFJwWo
	Fj0jc9CR0MbkWr8pmp+AoVd/JNj/JeA==
X-Google-Smtp-Source: AGHT+IGdk3XVuMADNouJH/aBQO3dgisawWr0ra1gK5dmtwng/BJ+8DUWD+mdbhpnTmhbFrSAIQbncg==
X-Received: by 2002:a05:6402:26d0:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-62ee5b367b9mr3462166a12.19.1757725706048;
        Fri, 12 Sep 2025 18:08:26 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62eff1a5c6esm720024a12.50.2025.09.12.18.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:08:24 -0700 (PDT)
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
Subject: [PATCH RESEND 26/62] init: move phys_external_initramfs_{start,size} to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:05 +0000
Message-ID: <20250913003842.41944-27-safinaskar@gmail.com>
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

Move definitions of phys_external_initramfs_start and
phys_external_initramfs_size to init/initramfs.c

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 3 ---
 init/initramfs.c        | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 444182a76999..06be76aa602c 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -15,9 +15,6 @@
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
 
-phys_addr_t phys_external_initramfs_start __initdata;
-unsigned long phys_external_initramfs_size __initdata;
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
diff --git a/init/initramfs.c b/init/initramfs.c
index 6abe0a3ca4ce..5242d851e839 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -600,6 +600,9 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+phys_addr_t phys_external_initramfs_start __initdata;
+unsigned long phys_external_initramfs_size __initdata;
+
 static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
 void __init reserve_initrd_mem(void)
-- 
2.47.2


