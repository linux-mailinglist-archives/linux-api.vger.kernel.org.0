Return-Path: <linux-api+bounces-4806-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C579B5657E
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 05:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28061A22B44
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 03:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70930265CA2;
	Sun, 14 Sep 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRPnFhfi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A431D7E5B
	for <linux-api@vger.kernel.org>; Sun, 14 Sep 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822233; cv=none; b=jv17D6IirEh+00fHr2gz/msHGZunsCgzHx7i9v7K03kYA/f26VyXUIuhELb9fLIOGFRk+Z/Y2wXlkuQ3ATU/T23hMUjS2iosi4bfYjgneF23Tdcdg0ZYOLQuqBU5kK/oebEmGyvVDGIQf2rno3KwYifeoX89DgbdLWgQdBPLtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822233; c=relaxed/simple;
	bh=6pXJgBOVmgKyryw3LURicaeyD0WS1HvzY8WG0GWatOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE+nDsnkON6jMLHfyQjn/rpBERVhRWW+tih9ujiOvUBuoG0CTKSz+i8x4cFZdNaXPsGUJJ8XzQ0HtxJUY2F9w2+Okn+/TyRq3R35T/sKrcHC+XmxATzCCK5h+4cjSFtBtIs2Kp5nWUAjWL2nK1Hifw6RWg1zROqxkGQ5MgYbQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRPnFhfi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07e081d852so184010666b.2
        for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822228; x=1758427028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=kRPnFhfit7+R6UzkS4cF3DKL1S7JHip+IAyQf6T2UGYDd+vYI9IC8v9G51KVb5WDAk
         RN/gPz1lGKSMFe9Oe7MIowDwv3N0e4/KFS91xhYm0G+VoSkSei8WkHktPa2wEMB4pNUj
         WzAE/ebYcnJlcUWXpTXxg7oBxbqGV3WM9sIv1WyWWMlOmd/DBHQ0UO8HJ8wtmu7F5pSQ
         pAM88kkn9raeM/jhalMJUOdMS5VqW/+AUemoRwnUmW0/oDdl4OSBi4zM++ZdXBaXmYLj
         VGYSY1r8rSsi6oTo3enO0OXT4w2WPUK9VtsKTo5k8z5kW918njUd5UMO2sKFBB8AaeWA
         2SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822228; x=1758427028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7psSH4JIkuISYR7xy9RNjBVG2GzEUFc3+zgpdmbt9Y=;
        b=jg6GMc+ZkGyF+agkRfcaSYMBsniEx37VKUKVQLMSCaYpI06kfcSj1OCEcHPbW3vRvZ
         9zCVp1+GFIK1zGUDX+Jg6vdCoBzUg0V868ucXQXL9JLrq8Cuv11JE6WtWsm8WuR9KC1K
         bQPwxOrk4pIqxN9mfQYrDxVyxrPwno0UyaoGauJcPFD99Xd/gjzZR9SuwUxERxzhuvny
         rojpKXVdEEp2ewv/Oxxgt30KPGqpRGDO4WMYPfx/XgBCMY/hUDnwcOOH37jWGGKp5rqp
         2/U4e/el1rJV3DC2nq1kzTldWSydEGXbJM45BJZgtB6cWZU3iK2Jqgvudxox+6QIfZWO
         DSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGvxoHxsrx03lh6p6U21rhc4b/2DLU4RNMtJRNaBEg7VKVaMAcWjAtiVgpDVigZhGVwjrNgcy2Lpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLViHkdMBitFyXdLrTqrSrXqLu6v2IkUO6cNIv99DzuDri3DSg
	ODpG6Yhu+S26aWq88Yp3wZOxH0A68ge9bH9JR0qbvVdZsTY3vmPT0Q+X
X-Gm-Gg: ASbGncuqkjgZMjDNzvN4/GZ5aMFW/zg9RCMAis87DJOe6N5+bgMmmg8wSbTnQO0JEy5
	qagX9slYwo4BLIMoHcQ9NQhLjdNh9qXFzyh+LQ98Bt9dsJtkxco5+Mq+53cdgik+wkul8TKm4PQ
	TanpanYGe2IJrTD73WtAiCdR6jwhk/CZ3PL6p+5MbaCsmHrC9bn5jrv5DlhK17vYEK3Y8le9o22
	QgRrCqXSdXU+3k/OJzKIeyUbUv1mgRpkv5yAqN9Vvt0TbJqCBXC7x3VP2py6XEHJyDouwA0A3YF
	VyVHoHkgB087s8oJV0rQ9QNEBQwvZRKSDQKirIWsyTtEovOLVPGXR/s6dSE08a2M5dozsZSp9k3
	01fUMza7xbE2U8KXePIGOQURx0Z/hDA==
X-Google-Smtp-Source: AGHT+IHHnPU+sOVT053l7deT3P8z3LJVFAOiksWjmZKd0Ub2gBIDgZK1/4gCPHfUrNaBqPQVOEAIKA==
X-Received: by 2002:a17:907:d16:b0:b04:6338:c936 with SMTP id a640c23a62f3a-b07c35b8e53mr876582466b.17.1757822228258;
        Sat, 13 Sep 2025 20:57:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f1e54sm673986866b.75.2025.09.13.20.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:57:07 -0700 (PDT)
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
Subject: [PATCH RESEND 49/62] init: rename ramdisk_execute_command to initramfs_execute_command
Date: Sun, 14 Sep 2025 06:57:03 +0300
Message-ID: <20250914035703.3729713-1-safinaskar@gmail.com>
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
 init/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/init/main.c b/init/main.c
index 5186233c64fd..cbebd64f523c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -160,7 +160,7 @@ static size_t initargs_offs;
 #endif
 
 static char *execute_command;
-static char *ramdisk_execute_command = "/init";
+static char *initramfs_execute_command = "/init";
 
 /*
  * Used to generate warnings if static_key manipulation functions are used
@@ -609,7 +609,7 @@ static int __init rdinit_setup(char *str)
 {
 	unsigned int i;
 
-	ramdisk_execute_command = str;
+	initramfs_execute_command = str;
 	/* See "auto" comment in init_setup */
 	for (i = 1; i < MAX_INIT_ARGS; i++)
 		argv_init[i] = NULL;
@@ -1491,12 +1491,12 @@ static int __ref kernel_init(void *unused)
 
 	do_sysctl_args();
 
-	if (ramdisk_execute_command) {
-		ret = run_init_process(ramdisk_execute_command);
+	if (initramfs_execute_command) {
+		ret = run_init_process(initramfs_execute_command);
 		if (!ret)
 			return 0;
 		pr_err("Failed to execute %s (error %d)\n",
-		       ramdisk_execute_command, ret);
+		       initramfs_execute_command, ret);
 	}
 
 	/*
@@ -1588,11 +1588,11 @@ static noinline void __init kernel_init_freeable(void)
 	 * the work
 	 */
 	int ramdisk_command_access;
-	ramdisk_command_access = init_eaccess(ramdisk_execute_command);
+	ramdisk_command_access = init_eaccess(initramfs_execute_command);
 	if (ramdisk_command_access != 0) {
 		pr_warn("check access for rdinit=%s failed: %i, ignoring\n",
-			ramdisk_execute_command, ramdisk_command_access);
-		ramdisk_execute_command = NULL;
+			initramfs_execute_command, ramdisk_command_access);
+		initramfs_execute_command = NULL;
 		prepare_namespace();
 	}
 
-- 
2.47.2


