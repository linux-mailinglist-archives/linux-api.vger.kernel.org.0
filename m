Return-Path: <linux-api+bounces-4769-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC6AB55BFA
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 02:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6375E7B9421
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 00:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276D1891AB;
	Sat, 13 Sep 2025 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtiqmCR7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDB405F7
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724989; cv=none; b=OGtAEJopWVVOzfoVXZ1K0p29dWsnwiV8ZwhCiJRS1rFZTEDzqE424ZmG0S9H/5fjYuDGVVoM520uzgpSjyUq2GLErooA1Q65BqAmH35BaOgxabf2Fe3VBresoCl09RAkuOSb5hIrmoVKHjLUpPcgAQFCLfSmM/UGLcepuaurICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724989; c=relaxed/simple;
	bh=ds9VwpQCIQQEuVYbVkP08KSVWpcFcJ5JA8drV9AyvVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZVGWM1zWcKcDqsvnFLhETVW1bnlWgNG1y1aAKrfharjm97cf9nAZXwxIE2a2iEyLBpjbnCwOww98q2wK7VhIuXDU052SgWzcmkFpx8j07xiHVT+FiK8WoXO8znp4KhU+V2uyx7Y32kHbnOiFpcn3w/kX36u+CnADsJJcC8xLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtiqmCR7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0415e03e25so324379566b.0
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724984; x=1758329784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57Y6Vt+tKEG1ezrQxMY6sE7xxEuIy1GPZf6G9mOPdfs=;
        b=dtiqmCR7q8fQrujZcyidoHKzEpXWqVzSbJIyCLsw+S+iaLSpeTjjIImksv6bHWz8s5
         EgMR9qHWRbW+iJ407fN+pRg39jUca5A1RrVCXvryTRkSsCcCRBy7P8v/FjEM2cRULRB/
         Upqt8LUSyYMlpcM2ayIWDP+BuzU7VOzcL0cpdFD/Ypy5kblfRtosXml1v3sfFVyN/CSa
         JaTNPvO43NqTjObdxSrK5wQJ1Nl7QGp/hZaetC2Pg7WLtW0MrNVRtn+Mr877NBUqheaD
         OHVkjgU9fMp/bkTsjOZNPYOvxpS/AbSfChUCHmTHyYL0QF7CELgSjnc2KdPW5fuJspg+
         Nmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724984; x=1758329784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57Y6Vt+tKEG1ezrQxMY6sE7xxEuIy1GPZf6G9mOPdfs=;
        b=iGlpPfmh6hndWpQL8EU5HNhjFnJvMc+8+6c8eIz/4/DPhDi8AKPcUfbcUz5ty2EQuc
         cuf0XRegmKXNlxTboSVMdgWPtXyR+cfuc3kYZXtnCMAqCx5evFoT2siep8/TObdGR50n
         UvQVgQAjeRd1OlC3iBdGcaXxFHtW7fcRyjvCwfzS2FC/BrZbI4QPEr+3wrfcGQDeyzZy
         5TPMplJFeWI2uHSozMx618Xju1dkRtMminsl3MEj4Jw180Ja4vwuBOHeq/31aN3/MqmE
         QsP38S3tl7HTSK7MVN8x/eS/GnUeGFrjhGk6vXblJhVrekNUunzsDeKiEgNCsMeogLzU
         jmWA==
X-Forwarded-Encrypted: i=1; AJvYcCVMV0jbeg3knpscW8cKszGpIHjBT+Wb4nnU5KTJlmY8+SmUEoB0nLKkEHpSO0UaGSdqyNW+5CpgqZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi244uyNoCKdyS/nHxEHj7ZWj3Uf+7EUKttdGJMU+d7JV2TBnL
	Ej5T17IWy7XvMuwPoFUJQ3F94/9ec8kA0d47nZ5JvSY1zPLC4894sj5g
X-Gm-Gg: ASbGnct8An/zoY9qycRYKTqoXbrA7ySm+jY72mdJFyWxTRPgCeOkwUs/QlzXAmgPF1t
	V45+GiQ4W9nqiJJSg4Hz2EWjJEfkbEnVe89fTM5drCkUpOErTkXqqJMyx9sCJwncNQ/tA1GWGKT
	H9RknaBmfCA5H9V7uBWNhq3CurASCBWM/+M94J6HjQ5zdC2iIhXjZUZKPgFmHEeOvu1EJKpV2T3
	fJpZV70MPzSGvTnj7G+jxEljRFFLwlhTaPCZgl1LyyJ9XmwOMQecfkmVXFnRkIK27g3Ti7jtKem
	wx18jQjmx8m32BQTIJrdeJ/GqlHYvRDlzNb3iNZUlbl0w5KsrG1hoQl+Zle1VRoo3lua3xu7Mgh
	myaqm2OSdX76kcdHZxNo59pI/g9LyHg==
X-Google-Smtp-Source: AGHT+IG1YYL4kFwbVvTnXfTe3odNA00ZLAAz2mLJaF8vV1UmquQWKJyitdN/Fum9NwuVLBLjujgrow==
X-Received: by 2002:a17:907:3fa1:b0:b07:88aa:255b with SMTP id a640c23a62f3a-b07c354ed12mr458973666b.11.1757724983824;
        Fri, 12 Sep 2025 17:56:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b33478besm484760966b.99.2025.09.12.17.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:56:23 -0700 (PDT)
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
Subject: [PATCH RESEND 15/62] doc: modernize Documentation/admin-guide/blockdev/ramdisk.rst
Date: Sat, 13 Sep 2025 00:37:54 +0000
Message-ID: <20250913003842.41944-16-safinaskar@gmail.com>
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

Update it to reflect initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../admin-guide/blockdev/ramdisk.rst          | 103 ++----------------
 1 file changed, 7 insertions(+), 96 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/ramdisk.rst b/Documentation/admin-guide/blockdev/ramdisk.rst
index e57c61108dbc..6289e085f18f 100644
--- a/Documentation/admin-guide/blockdev/ramdisk.rst
+++ b/Documentation/admin-guide/blockdev/ramdisk.rst
@@ -5,18 +5,14 @@ Using the RAM disk block device with Linux
 .. Contents:
 
 	1) Overview
-	2) Kernel Command Line Parameters
-	3) Using "rdev"
-	4) An Example of Creating a Compressed RAM Disk
+	2) Module parameters
 
 
 1) Overview
 -----------
 
-The RAM disk driver is a way to use main system memory as a block device.  It
-is required for initrd, an initial filesystem used if you need to load modules
-in order to access the root filesystem (see Documentation/admin-guide/initrd.rst).  It can
-also be used for a temporary filesystem for crypto work, since the contents
+The RAM disk driver is a way to use main system memory as a block device.
+It can also be used for a temporary filesystem for crypto work, since the contents
 are erased on reboot.
 
 The RAM disk dynamically grows as more space is required. It does this by using
@@ -30,109 +26,24 @@ and (re)build the kernel.
 
 To use RAM disk support with your system, run './MAKEDEV ram' from the /dev
 directory.  RAM disks are all major number 1, and start with minor number 0
-for /dev/ram0, etc.  If used, modern kernels use /dev/ram0 for an initrd.
-
-The new RAM disk also has the ability to load compressed RAM disk images,
-allowing one to squeeze more programs onto an average installation or
-rescue floppy disk.
+for /dev/ram0, etc.
 
 
-2) Parameters
----------------------------------
+2) Module parameters
+--------------------
 
-2a) Kernel Command Line Parameters
-
-	ramdisk_size=N
+	rd_size=N
 		Size of the ramdisk.
 
 This parameter tells the RAM disk driver to set up RAM disks of N k size.  The
 default is 4096 (4 MB).
 
-2b) Module parameters
-
 	rd_nr
 		/dev/ramX devices created.
 
 	max_part
 		Maximum partition number.
 
-	rd_size
-		See ramdisk_size.
-
-3) Using "rdev"
----------------
-
-"rdev" is an obsolete, deprecated, antiquated utility that could be used
-to set the boot device in a Linux kernel image.
-
-Instead of using rdev, just place the boot device information on the
-kernel command line and pass it to the kernel from the bootloader.
-
-You can also pass arguments to the kernel by setting FDARGS in
-arch/x86/boot/Makefile and specify in initrd image by setting FDINITRD in
-arch/x86/boot/Makefile.
-
-Some of the kernel command line boot options that may apply here are::
-
-  ramdisk_size=M
-
-If you make a boot disk that has LILO, then for the above, you would use::
-
-	append = "ramdisk_size=M"
-
-4) An Example of Creating a Compressed RAM Disk
------------------------------------------------
-
-To create a RAM disk image, you will need a spare block device to
-construct it on. This can be the RAM disk device itself, or an
-unused disk partition (such as an unmounted swap partition). For this
-example, we will use the RAM disk device, "/dev/ram0".
-
-Note: This technique should not be done on a machine with less than 8 MB
-of RAM. If using a spare disk partition instead of /dev/ram0, then this
-restriction does not apply.
-
-a) Decide on the RAM disk size that you want. Say 2 MB for this example.
-   Create it by writing to the RAM disk device. (This step is not currently
-   required, but may be in the future.) It is wise to zero out the
-   area (esp. for disks) so that maximal compression is achieved for
-   the unused blocks of the image that you are about to create::
-
-	dd if=/dev/zero of=/dev/ram0 bs=1k count=2048
-
-b) Make a filesystem on it. Say ext2fs for this example::
-
-	mke2fs -vm0 /dev/ram0 2048
-
-c) Mount it, copy the files you want to it (eg: /etc/* /dev/* ...)
-   and unmount it again.
-
-d) Compress the contents of the RAM disk. The level of compression
-   will be approximately 50% of the space used by the files. Unused
-   space on the RAM disk will compress to almost nothing::
-
-	dd if=/dev/ram0 bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz
-
-e) Put the kernel onto the floppy::
-
-	dd if=zImage of=/dev/fd0 bs=1k
-
-f) Put the RAM disk image onto the floppy, after the kernel. Use an offset
-   that is slightly larger than the kernel, so that you can put another
-   (possibly larger) kernel onto the same floppy later without overlapping
-   the RAM disk image. An offset of 400 kB for kernels about 350 kB in
-   size would be reasonable. Make sure offset+size of ram_image.gz is
-   not larger than the total space on your floppy (usually 1440 kB)::
-
-	dd if=/tmp/ram_image.gz of=/dev/fd0 bs=1k seek=400
-
-g) Make sure that you have already specified the boot information in
-   FDARGS and FDINITRD or that you use a bootloader to pass kernel
-   command line boot options to the kernel.
-
-That is it. You now have your boot/root compressed RAM disk floppy. Some
-users may wish to combine steps (d) and (f) by using a pipe.
-
 
 						Paul Gortmaker 12/95
 
-- 
2.47.2


