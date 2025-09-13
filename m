Return-Path: <linux-api+bounces-4776-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E9B55C80
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A458AE3D3B
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 01:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0E19E7E2;
	Sat, 13 Sep 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRwUyBVP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A415B971
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725449; cv=none; b=OgJVrPtqbt0GxwAruPF6ZBsZwxlyD5ivAuenn8AbnIbs94DNhe/TZw9rWHTtxFzIfsAL0vBRF4/eX/aXB5v9oZImNPoxE88GYCIf9Mk42igOsnJGis0aeDGf3z3oiETtYhLz4seXR3l063/ALM4cTeQL3qaAskevPV6s1mNqYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725449; c=relaxed/simple;
	bh=XdKFLt7HKTWqlTaryS+0sdRR6IIe2s8E5XqHxfJZ80U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/gjk6nK8dGBPT9nIt/5aRUAyn+aNC/LokkSwtEadopJynyzynvmP7cZATtK4dx+3c6WIQf5GbpoNDqYHwzw9q/IlV0vGyupdt8GWKLffEvbRiUVWf6i8z64m9tSgVjCQy7x9JVQMDkbNwSGEuSqSayJod75nqfhIqkcukS2bCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRwUyBVP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso377936a12.1
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725444; x=1758330244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP3KPO8+P4bejD4XvvOjfSlYK9K4kJKcAHCDef6XF+Q=;
        b=RRwUyBVPnVlKd0QyX7QZ/B8xHbpig+Z2q2Rr0IXtkLN1RECSatPb94HGOD60tUFHa1
         4qdgmLfCmT1u7a8yJxRMhTrlQ/FKgvxR+IXG16wPGbb4rybWPlqDYRmV67YUPEgCpqRn
         MSir2IDCQdZySb6GZ/P0X94QU9neoYMzHjvPy7UXI/KEGAqdP5G0Rm/DnTvm8DF0rnMl
         TvzpWt1calnnkQkXZGiRqKin9theNHhcOi/UoxpNd22vXN3ro2sBkWj1NX6p3NuoGJgL
         YRJD68Kn6CszgFLoTHxMGcaDfHFvEGKbmLD0IdJUjzY4zNy1wmS+Yaqtzchrx/Eo+CpQ
         qZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725444; x=1758330244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP3KPO8+P4bejD4XvvOjfSlYK9K4kJKcAHCDef6XF+Q=;
        b=EoKBlOCPgJSj6fmmSaOmj9hZ7CWGSU4Ml5eiESRDKvoGNIomUm7TRcjnI020nKwbdb
         BpzqQvSlxUEucCMeGi61VzIzWrn+ph8nDcQGkB0d+klisDP1wW5iIK6fdXxuSWDzzIVP
         n7NYKzvyANSLHMbg13pmiAFzUCEQ+WQI+ioa6BySZrAeSPJFL9GAIWk28uF8QupbKz5H
         o3R2b33HnXlhBZ7TJyV4/o0JiqtGTQklhHMSKN+fhpyDZJLcT5qHAOlIuPcZ92Mo9j35
         r9wiq2YWsS1jXNE5Seb5x1rpEp+1TbSaozdC0yBLRpdr80ZfV6Fn8ecXFpY4x48ZDbSb
         n8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKNqAgmvf44tc6SMFsRsODpFgPBbiegSPnBtrPEgt+A1+p+Pwm6D4kZSPzWRq0hvwPInyqmGTob3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jcoa6qrYwyAUeDVQKb1//4YnmVAtdStYD0k2q3M2yJnnC1Ea
	g4l4hSiETvLrdoOCqmsu1Pi5NPd1H3Yo+NC/KZ2XHSdd6hCAHLw6M9GN
X-Gm-Gg: ASbGncsieTV2t1xVTfCDV3ujh3PyhI2pv+XcOqDtvz2I9fyhDmWFiFKa+ojUDTFe/ga
	4D1aXXfomYDhpjXRAbQfPTF3XV4cBe2Mq3sGigSyaXqiOFk5DuQmUlR3K3BrG/VmlR0lH39cz/D
	BN3kPlqdYL5EAAF/iMn/9ELoTVlwiPzXomPPBVlZ3lrEzUm++Ro8UFQ5Ain1qPs3rKn2HvR6qzG
	FJArRL1T0IbHo410ByBQI7fVhRFmI8h8WH3P4Yb0ReZcoMP102xLMKrFOH9nJ+rvcvEzmXcw/Gf
	TLXxVPoR8s/pfLepnicYJxOZDFpwiPJPvTQbjmOil2vBXNItm4uMDVkxZIrcbiRP6fpdkuJpF76
	+7EcpWJCldr9bAg1Ggt29FR2cmfMg/A==
X-Google-Smtp-Source: AGHT+IF5gJzNBXdtzBXv0OSH4ftjGJnmmybFv16rcAGk5hl57bAzoCs28S7e9w+ysKsSQWZRdIzUSQ==
X-Received: by 2002:a05:6402:3482:b0:61d:249a:43fe with SMTP id 4fb4d7f45d1cf-62ed82c5a43mr4352436a12.24.1757725443498;
        Fri, 12 Sep 2025 18:04:03 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec6b6cec5sm4014207a12.1.2025.09.12.18.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:04:02 -0700 (PDT)
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
Subject: [PATCH RESEND 22/62] doc: remove obsolete mentions of pivot_root
Date: Sat, 13 Sep 2025 00:38:01 +0000
Message-ID: <20250913003842.41944-23-safinaskar@gmail.com>
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

They refer to initrd, which was removed in previous commits

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/device-mapper/dm-init.rst | 4 ++--
 Documentation/arch/arm/ixp4xx.rst                   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
index 981d6a907699..586bb38d716b 100644
--- a/Documentation/admin-guide/device-mapper/dm-init.rst
+++ b/Documentation/admin-guide/device-mapper/dm-init.rst
@@ -5,8 +5,8 @@ Early creation of mapped devices
 It is possible to configure a device-mapper device to act as the root device for
 your system in two ways.
 
-The first is to build an initial ramdisk which boots to a minimal userspace
-which configures the device, then pivot_root(8) in to it.
+The first is to build initramfs which boots to a minimal userspace
+which configures the device, then switches to it.
 
 The second is to create one or more device-mappers using the module parameter
 "dm-mod.create=" through the kernel boot command line argument.
diff --git a/Documentation/arch/arm/ixp4xx.rst b/Documentation/arch/arm/ixp4xx.rst
index 17aafc610908..ac9cb28776c7 100644
--- a/Documentation/arch/arm/ixp4xx.rst
+++ b/Documentation/arch/arm/ixp4xx.rst
@@ -137,8 +137,8 @@ Intel IXDPG425 Development Platform
    added. One issue with this board is that the mini-PCI slots only
    have the 3.3v line connected, so you can't use a PCI to mini-PCI
    adapter with an E100 card. So to NFS root you need to use either
-   the CSR or a WiFi card and a ramdisk that BOOTPs and then does
-   a pivot_root to NFS.
+   the CSR or a WiFi card and initramfs that BOOTPs and then switches
+   to NFS.
 
 Motorola PrPMC1100 Processor Mezanine Card
 http://www.fountainsys.com
-- 
2.47.2


