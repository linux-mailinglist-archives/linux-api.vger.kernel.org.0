Return-Path: <linux-api+bounces-4786-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62459B55D45
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 03:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186125C5893
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 01:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91C51A9FA8;
	Sat, 13 Sep 2025 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKbvefFf"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E241A314E
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726112; cv=none; b=h6TgtYMtMvCBtW8JaiQPtpMnY0TEQTk17qKbWI9BzVrFZVy8818SHVHgvpCUdmVbye/FF2JMyEWMEX3APZeK0rWyUc15F//XYDYvWlSwkdM2aiVJkn4FPVnQNYkYZga4xy4qqPN1YWvXF3nXCUXksYd9hU8VhUe0+h9veI4hAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726112; c=relaxed/simple;
	bh=YCPpMauct/lx0d7FW5hIc0XQ6n2+DOQok3eBS/uAsZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXDWIoiTfFsmYQVGiBhwoaqCd1guBRYxsr7oGpET4LDTcE3IDkSi6U/hfyM2fkT39H8AOA/ULx1cMqewNniAJNPSUWOvBnGrQMyuogM6spitr7/5S7mOpGvj1fRjByqOgGxR9ppxyZJlXLuYMT0JxoUd63IiK2BsBXnSASkA5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKbvefFf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07dac96d1eso101248966b.1
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726106; x=1758330906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGsRGTypi9NqdtciySRZZEpkGgKS+BdOkJag/Ax3VcI=;
        b=VKbvefFf6JBv8ek67wEer0RqEYwiljoVukI7dIf37vTbdwK1pUDhIfMM3hyeTN6/rL
         +1tAIenyQG8OqtZbzMV84BPV5G1aCWIv8OKsTJdJCmdh8ibEuPlEt02Wr6PDdRhds8lK
         36BYIjOUazY9M4I/TbvOKS7ix9db1AJlvb5AIqciXeanKK2+T7Qz06EPR7eVVqWzdFIt
         55yW7b9cBiZDy/PaCCDOvTFq3VdctKrn0CCpd+aBZ3B04KsgueUe5rfniJ084iwg3uUj
         SYQehXknTBTUmNRmTROPG26td7Qj9x6WVquBc1EaiO4Lfi2lj6ZlCNjqKeme/nh0bOah
         Va4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726106; x=1758330906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGsRGTypi9NqdtciySRZZEpkGgKS+BdOkJag/Ax3VcI=;
        b=F4v06AW5A5Oi38ZDtX7f9WuYmmyILsIBFj7c60eO5P9Kcirke8Lgy+WorTe0VLOc7P
         7Sl2XVoT26xmM3esvpSNZ3OR85T9Hy3b1j/NcpVNB4pZX3dZ+gXeC2wrSCGzTfl+8K2t
         A9ODLBT6EEF1e02XG8WGPVQOV6mhKuhMfXLEgV5t30ClkUSc5NaPf+au9PEFcdbWUJ2S
         g3dWqutAIT6PykW7spvQV6oabpAEdyRcUwFLRwHky+N9Y4BnVDGUjynD9j1EHo2NK83O
         p59B9d6I+wcIDOR0eBE5Hq0CamF4yiiqyvaot8v/mBNVA+IgYLVBmH2AQuHUaHAv/MO3
         tGBw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ji5Lwbuq9HsZB2hjJmKd0Xk40nPluuQh5IF1W3dfsmOgwVRJlLCEfgPsYyXO+D4hl97l8on/KO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoOBSHsnh82nEnVE+5jeKvGdqBmKVk2bO0tvrTaqHk77tpCyS
	o1bQi1RNbvDAsQpWOfv+AlzC1a3EzRGKncGgKFVs4OhPBUAm6Ex+hdc4
X-Gm-Gg: ASbGnctqDbt42gRkjxzCBiviLbz8pGjwFddz/MIOHoxgDvJezglDmF/ovCTeRmJF0yW
	ZBuYD3fgNtQnPRvTIIkYu2uB2UjwPa7owFwlnxwhNi+sjlsRhzpFoDNC8hERhCsTlN8eYdTB6f2
	WNq+FsCxqCgg/ZxwvTiQQNzz4GTktKSKZSrxYr2XqS5+xEOGtqQXK6KpQgF5nm776oTidNglRHx
	rY9tK6v9E8lTXefdwTwMqO2SovFEs0movBztpDOxunU219Adf8gXjP9h4AfbEphgcsmt7UTePwN
	C4+pr2lVp9nwRpJkL8sJPDYLD0XtwDAv24zyxwfdSehhRhWlkzusviDtr6lH84xk2PA6BGv2AKv
	fzGNKsgs1C0OzkA8TeOE=
X-Google-Smtp-Source: AGHT+IF9BfFXzJCfAH1j6Whgn4db4w3JHUdrGBSr/SBtjDaVKK8KXKnwXgawQKNvW2//sA4Wp0ETBg==
X-Received: by 2002:a17:906:794f:b0:b07:b19c:1389 with SMTP id a640c23a62f3a-b07c2543931mr499914966b.23.1757726105874;
        Fri, 12 Sep 2025 18:15:05 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b334e4fesm475799966b.106.2025.09.12.18.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:15:05 -0700 (PDT)
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
Subject: [PATCH RESEND 32/62] init: move initramfs_below_start_ok to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:11 +0000
Message-ID: <20250913003842.41944-33-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 2 --
 init/initramfs.c        | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d8b809ced11b..509f912c0fce 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -12,8 +12,6 @@
 
 #include "do_mounts.h"
 
-int initramfs_below_start_ok;
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
diff --git a/init/initramfs.c b/init/initramfs.c
index a9c5d211665d..90096177a867 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -601,6 +601,7 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/kexec.h>
 
 unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
+int initramfs_below_start_ok;
 
 phys_addr_t phys_external_initramfs_start __initdata;
 unsigned long phys_external_initramfs_size __initdata;
-- 
2.47.2


