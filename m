Return-Path: <linux-api+bounces-5387-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1EC7144E
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 23:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE134D624
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 22:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2131159C;
	Wed, 19 Nov 2025 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8k/DZ8/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32A82ECD37
	for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591219; cv=none; b=K9HTQOitmks7M/BO0lOPpec7eku2BkbKuHI6H/Ry5jvsievNA1EhY3487roLJhLVvY4qy28DEaUwZ46p9s+SgV/fs+mRAo8tdqi4I8Jep7PgiGg76P1ek7/bFXKmj6AVIdgotU54vEyCzS3a+tsHIOfihloD6LzCTsJdi7ISJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591219; c=relaxed/simple;
	bh=qOnnawt4egcjVD3EMm4ADkZ2z7Vo9vrDOjzvgdq3kes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgajFbJyBeMYHy3QxglYRtwHot1uAm+FEhnEeRwEm94oCdxcMNsw4GJpsIbRX5J4yzI0edsl8JtgnUh85kdCZeCw28US0NLhPXd1WvqEQKHjKkNWncXVUJQNzInex+WDHee/oWhsTuMf2hGgSIDetRReZW64NvOvmphlFA3Vx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8k/DZ8/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5957753e0efso179326e87.1
        for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 14:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763591216; x=1764196016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBHV1EUw0WBXSKlFcI/NhGu5XRuHQn0XLzAOgD+DTYU=;
        b=R8k/DZ8/ZkWu1ODdCi03BUhd0F6wJ+SI26jz55vpEOV1pSnPERLev3IwAQeGU9Ksnb
         xjiOXUCNbqNR3md5yGCT9dIVKjPaIS3mpoLpkuyO+XWoQLOU2mnh+9SDElRz5SHfHh3Q
         B0Wp03c6n0pUeFnj//hlczVj1aLV2ivD34FgWCLm3Wp2rJmju2T6TENUxfmee1/qUvse
         xHh5AEGWJi1knuZfskaA8eIhL5PpmlkU5smszODFrAzYd+ZNUXTteOUwRFrOEC4wNHEL
         l9c+nmG/rJdGmgVVAigFNQxltkX3V8NVu3TMSbQcqLexwAuvZ+VR2gIcAI3nv0pI67PG
         Rfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591216; x=1764196016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IBHV1EUw0WBXSKlFcI/NhGu5XRuHQn0XLzAOgD+DTYU=;
        b=jnQ19WgFgJXFhwENBlo+bONKmBmeqkxdhfMicmOOksPbdY0mKh60C166w1jgEJD8mf
         dTKC8rUkQHcCNnNUnleMrgl0DK8lbwbE3nO/P2dXQ2zEAHxSFxPYJ668zWnKwFT/Q/+Y
         1blhx8ce8MTDVkmkvZVWNSCgA1rK7RU+iv9GwOmAG5Z/DniHktV4icDRl2VsdYilGXT/
         nCsrPsxXD9NMkskeuOvLypHkUaDQieryVUGhNyPSIjsrCZbIv0IwR3FLRK2h9PDktmaN
         hOj8zkN6hkRpAGT0aVhmQ7Hje+2nJk4YA6zojU4rldMYfTaClFN52e9PPiNUk2lWknIP
         R6wg==
X-Forwarded-Encrypted: i=1; AJvYcCVT2PqEqcnm1IOrQhZKiePjzbH8h8ZWnnlJ90aoWy1lQiaHTNrU8Xsrov8r9PrSI/WrLVEZGF1BuPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqL3FDIDMGo/+FxioNHb1kL7hP3PkB3KaoVO7d0MpybZ7EEdn
	0zFJqN5mrhX+3VGz975lzijTofOYPOnTA+TiI5k9NJ/EGh7nWI0JQy8L
X-Gm-Gg: ASbGncs0xU2sRtNrT+0Ehzjt3Zmj47UdRpJFexNy5sPt10OqTZWe1SMmLNuxYqiaXRS
	hrXdaXrr18NYVg6vm8xovmPANvcerNsQGsgQ6rXCWclX45VG0/LLGZHMrHWIrx8u7yyZpHMCgWI
	K3ieMt2zoTWJ2fDKLpssS0X6oaWAIcqbQc3F67yb1MCYzBfpNS8y62Y5wPuUMoFy90x2Ew2nFa+
	NFEBFnpSZYTk+ltg5Yan5+0HaE27Om88cC6sN67sKvQ1m9Iiiiac9xPUjTmT8KF3Mg5H4C89p/Z
	YyUv6QLlxLtTOtALqO4c/XiO5xT8Db+af4U0XgVZKmhnlC/Oy3y7JsmXJrnIRLynLXFghmBpiqF
	AaXvQgfPw2PMDbV2SBSF2sED+4e/BeKC/vPU3KGcJ/Sjnu7yb0hCmSVlPo8Srml/648uObCzgmA
	KUC2AO+jc/
X-Google-Smtp-Source: AGHT+IFgA9RKL+uFTnctiFZKqulaPxewVQd+eAgCSkyCWbVEq5Iah76Q4RixKmx92rXz16tT6l4F2g==
X-Received: by 2002:a05:6512:3d08:b0:594:25e6:8a3a with SMTP id 2adb3069b0e04-5969e2e74d7mr178185e87.20.1763591216022;
        Wed, 19 Nov 2025 14:26:56 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969db8989csm168021e87.39.2025.11.19.14.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:26:54 -0800 (PST)
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
Subject: [PATCH v4 3/3] init: remove /proc/sys/kernel/real-root-dev
Date: Wed, 19 Nov 2025 22:24:07 +0000
Message-ID: <20251119222407.3333257-4-safinaskar@gmail.com>
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

It is not used anymore.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f3ee807b5d8b..218265babaf9 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index fe335dbc95e0..892e69ab41c4 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -8,31 +8,11 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init no_initrd(char *str)
 {
 	pr_warn("noinitrd option is deprecated and will be removed soon\n");
-- 
2.47.3


