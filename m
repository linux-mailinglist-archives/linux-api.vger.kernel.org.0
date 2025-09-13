Return-Path: <linux-api+bounces-4783-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EACCB55D00
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 03:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EADD5C0024
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39B1A239A;
	Sat, 13 Sep 2025 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUORZv5M"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC0193077
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725909; cv=none; b=fvtmR561XKukKaXzzEGLmfnoXG2fjN6KzBOXe/rZ8sdh/F9tz7Asj5vi+PDx++l6gw/qzYp8HzACcg9S8KeMjrX9yuCJ0DtzyupEL+pr/sEnpnZLpzxlhwkb+egKN+F2h0l2hkBK+vxv+/YONn99ENWWCwyFTkE+Z3XYbrQpos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725909; c=relaxed/simple;
	bh=KpML4fn90471dg944P+9+9FByq3Xjb/jBBYn5xTeENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ui+5OAcxgdWoeIxbOtkjOXoWdhs0UHH92iiigRnnNbhjs+nODm7Ul8AeFRMw5/ArVqkwFP85YOakx2tfW6BbhR5Hg3UqL3mw9Z0hgIgyyMtwFBkbciSUx/CsQikD1cBtgLR8c92HJvLEs8i9cSCx3LpyeUE/62w/URxhI6I8lDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUORZv5M; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3994993a12.0
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725904; x=1758330704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=;
        b=aUORZv5MCUdwsV0MU7oCzj3ZTm7w3ESOPYBigQlqMxPsAavMDyHGJgEYQWATfs3+b/
         biPBcBrCE9URVMoH0rqHehw0T1BRhiZjlA9durZSP0yEkzERpopJvyeRh9qFGG5oSCsQ
         OuIa430sEthMDEkIZDIQQAO65i2svbWCQtUDobiF+pJzf/eh+f2Qg9BVDr0XDXs5AJy7
         S+eE8Bk/nYgSsoMihCGJb0SQb6wVy+gefAADkk7B44V5PV1ioyXUHisNSxZuDoeNZtpw
         pk7wtMp9HCPO+M4hoY912LuHIIjWkZVXjLrL7AKM6klm1vtlLotKzYFANlld9p+SFPzp
         US6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725904; x=1758330704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6O+lfSZLBCLtFpNKL/1anVub0eApVizJE0pmHD2kMo=;
        b=oYYwuNBpGbr6BvuaYagKnPveDJKw9fJZa4YQ/lhhdbMj6eXv4jIi0vYgdwp82iPNx3
         Ac9WkTvf2qAzp+k9GuNZ+3eGYDUISiAgxzq5ucEbCCdN4uBzmJ7/COcpwYwO6Y1pSp5u
         EEVOJxJUv5FWvl5QIeNn2kk5Rm/y6N/BoIrVZt9EFvDnaY8ybZJM6aKDIGoZWNGdD9kt
         eXUcBqSk/YjVXfBHUTULjdKmstP8avldfYJjtQXqunB/p7xyM5OKY8DbD3XRx3F0fbDJ
         oxGZgKnml0kmmP7bmiGgM7yQCvC+9X1+XlYRYleY6CeVaRzABeYafffSD/v7xyb6p91s
         OKwA==
X-Forwarded-Encrypted: i=1; AJvYcCUQzPBZyywOz6amWQ+dIVM8FXmOZwwZEyqdi4xUtFAzT2x7it47EDfbjOfs/zk3OEXA9fP3PI/i1aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GcXuDx82aKX7wokAJejmjNeNhke/KYLMXXVsKRs2tg0b4eB8
	833/+SuJId+39Lfood+5j3naF1boWVlTQiZ3RdvsXVo6WaaaaroTxEU9
X-Gm-Gg: ASbGncsbpU0EL/L/Lp7kazC1XHfjwgnodBnp08pPDN/Jd5/PSQFMKtsw7sjisXGHLEw
	XL8yPC5nX0SpAUZ4oR74lNCfWeetq5I/CXZZFVm+rkeSL1q1mcEU1mYoa8D1pL5/yxDbsW8+CD+
	lkXK8jFytGvwFuNLK20wq6zvkQJKF1iQCIKzVOT60PEFJZegIzrnS+HNFe1v0GkTRDqF4EO9RBB
	cP5c4amoLIvz5Pep2Wr3CBPqlDH8fbBVzFtWiKGUOc73Odjdy2zaE9jha+qiEEyxYagodZ3Elww
	S1CSjBiP4nWENEGuPFUlVGeuTXZxpyB7jAvBbqEC9snpUJxVB4WHYrJmOsBNRmzXUH9ZVxEO19S
	9bUOmcxznO8IBa3nja40=
X-Google-Smtp-Source: AGHT+IEEs4w0VYWOrTZ2mf5mPdRdgIBBMsi5zMJEle+Jt2EK6Q+4TbCNWtdbvmdxcJfUUMXxxDwLfQ==
X-Received: by 2002:a05:6402:5242:b0:628:a4fb:3b44 with SMTP id 4fb4d7f45d1cf-62ed825998fmr4990182a12.1.1757725904210;
        Fri, 12 Sep 2025 18:11:44 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62efb5b8b0asm913566a12.20.2025.09.12.18.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:11:43 -0700 (PDT)
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
Subject: [PATCH RESEND 29/62] init: move virt_external_initramfs_{start,end} to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:08 +0000
Message-ID: <20250913003842.41944-30-safinaskar@gmail.com>
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

Move definitions of virt_external_initramfs_start and
virt_external_initramfs_end to init/initramfs.c

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 1 -
 init/initramfs.c        | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 8bdeb205a0cd..535ce459ab94 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -12,7 +12,6 @@
 
 #include "do_mounts.h"
 
-unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 int initrd_below_start_ok;
 
 static int __init early_initrdmem(char *p)
diff --git a/init/initramfs.c b/init/initramfs.c
index 9a221c713c60..d2301cc6c470 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -600,6 +600,8 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
+
 phys_addr_t phys_external_initramfs_start __initdata;
 unsigned long phys_external_initramfs_size __initdata;
 
-- 
2.47.2


