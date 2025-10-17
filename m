Return-Path: <linux-api+bounces-5130-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19095BE6995
	for <lists+linux-api@lfdr.de>; Fri, 17 Oct 2025 08:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CC34FC6E7
	for <lists+linux-api@lfdr.de>; Fri, 17 Oct 2025 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F630FF2B;
	Fri, 17 Oct 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxsUWHaQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053830FC3C
	for <linux-api@vger.kernel.org>; Fri, 17 Oct 2025 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681484; cv=none; b=MDxNbuoLBkuU9GcKnCzVP4H+9+nC03/52NyLu9OguU2fw1nLZuqGhFtUYJlv5e86CzsAtGVNE0rsJf5qvQKR/CP9ZeuU3whrWi3e8apEg5XGOY9DyFY7DXzsgSoHyywzb661gIr5Cm3KNrjSyR3+eXe/VNvaoHZ2c9FplYSsYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681484; c=relaxed/simple;
	bh=ulNxyjs+7P2Oi91QTv8ZCqiBF+ih61EgQsdAC1fi7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsG5eODaBxvB56ENmIOg/pkLETZoP9hgN4dvswbUekyHMRfR0KGIebAIob85EWZgLOfi3PmZe21pR9GqvLh0c/Lwn0oWdDNYrADhJZ7SpLfI4agBxuYsMPAhtTcBvPUnM8R7qXy2k6Ago8eB5HT4zk39bFZ4siaIMSTL9RzMvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxsUWHaQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1430265f8f.0
        for <linux-api@vger.kernel.org>; Thu, 16 Oct 2025 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681481; x=1761286281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqXHg8fIVhNftDZOE9plbEgrQCbIv7x8GRINtPvlAdM=;
        b=fxsUWHaQhj7CFg7lwcIffAaSGDYWnNOGnC2Wtr3PDtaEQ9OtgWAnhCZQLOr71juH5N
         3E/e54f8YRt74Evm+pMY6HvoH1eAmF6GGjFao2uXEssAtfz413aAKV/SMCQpVD1yjpF5
         xc+Ur35Icqe6/d4U7f4prbrV3uXc52+J4ltL6zk0jWtqUqy3Wu1QIgjoRWEs94JGfPf6
         fN9loldJBtOUIUBY/zuNxxt9O41Ya+f1i0Soerajk472YDphWjYYmMdQOA3QRy7P4Tfa
         GFMJNBc840prEByFOpUiIYEcNOtpizvHVz2tfiQgiwYAyKEIgyRVv4/P/RFOb4FO9GG8
         Ps6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681481; x=1761286281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqXHg8fIVhNftDZOE9plbEgrQCbIv7x8GRINtPvlAdM=;
        b=fNtqkp4lzEfl51djUY7Qbw23XMNcJZ0OTs6CGdtEUa5rp3qadRCZlyjapYVppzBFZC
         12TBJglgcCdpNnSC4D/u5YxFlummIRVzNH3L4422WucRhQLD3xbFWY6WuMgOG8R1+O/K
         OVh5M0wNPlini1Hk5Vg5RkaqCEt0NpIcJlDcs5/qoamDBsPTHMD8rJRKUk0tkltFfmBo
         rbdnrIJKuyQYpJLk9T7GsmYjCRxomfSvYe2Q5EDgcI83c8TlNq5ROB9W99Ez74y3y8Jb
         +6uSlCOVmEDZyh2k6gCuMrRXHTEbczSvSzeh5TyQG6mWZ9PXF2NkKor0Hc++txRA+s9n
         Q9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCV41y+E1awRAXA+UN6Py6SG5VLm1ogd+b70q/xlfY863GkA9wl1Nhms1vURIe33WRqc9121NL3yZeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvIUppN1AlnBIr24B6lLJR255x5hLmAX4vnkz17cyaXELqhQE
	OVrbfxNt0ozHzmIeCbxRR7HDrysObUs6ePw9/j5OUCUoe7EhwP96pO91
X-Gm-Gg: ASbGnctM5dVy2rd0GKbTGQIAFjjMBnDCBUw2BcrVs/UskQbdQBvaHYtaAnzhgVUYsaL
	vu+kSsAOxnRdTwv1n1V7xbdI2tdAS4FKjAYy/K2ryv52WaWzIIRrp3lYdMWcPHfWYm9/LL0HjDt
	fIwlD1Oe4tzcRk544SwBU+ypW14lNdvXXcJSeAzLuw5MW6oTL1FmuRKfEU4XVNBtjcXPfyQn3ib
	rwSWWYjGV7I36+KEO79hLL0vufVQu3oKfB+4uWQu5Jq7tCXsx+ZARxqJN9K3sNGArY8dGWiXLp0
	AWc4een/V2SlroXkV5y5CJj7iOsvrizGYCU2eiFQ2gSPzXUKgDlMr2hRJ6wD5OJVxvxJobdeTtR
	hbHB8DQuHolRSh8MQmkN5Y7sq7aae5vF0NJ9TqjHWQWI3gU8b4K9aQbNKlpq+6gSF9cWTvQkTmF
	Jh5FCeZLRNU78=
X-Google-Smtp-Source: AGHT+IG9nFyXU6/YzYNrNEKOmFbcI73aJtoTWz3HhvfOqLzAHFD1KIWSe0W31I+6MYQb5EK9zvZOHQ==
X-Received: by 2002:a05:6000:2507:b0:425:737a:4804 with SMTP id ffacd0b85a97d-42704d4422dmr1625416f8f.4.1760681480389;
        Thu, 16 Oct 2025 23:11:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ff84cbb7sm7231059f8f.23.2025.10.16.23.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:11:19 -0700 (PDT)
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
Subject: [PATCH v3 3/3] init: remove /proc/sys/kernel/real-root-dev
Date: Fri, 17 Oct 2025 06:09:56 +0000
Message-ID: <20251017060956.1151347-4-safinaskar@gmail.com>
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
index bf381aa0400f..82613a3be756 100644
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


