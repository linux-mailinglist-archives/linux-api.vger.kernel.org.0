Return-Path: <linux-api+bounces-4767-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A4B55BCF
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 02:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805E51779F8
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BC15A864;
	Sat, 13 Sep 2025 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvT6e3Ob"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED878F43
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724858; cv=none; b=a9Wf/4ET9K8kC7ZpAurZfY97fvHdXCAwtoJh5GjpWzpuTdSK0JRNNu46VKZrF7h7SRJHHhjxJIEriwt3+QMLZyOu/ArHlV0vtbFoTw8YM+mH+yDsS9xgXXgSDShkP+E8j7IjJ0XxlIqffV96720u0AbHLVsqBlbiETyh21qDoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724858; c=relaxed/simple;
	bh=Jkxu5ZUI0H6ttWYEi4Z84BWe03GXjUbvUo6lUIoM5rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfVmQPDfCApDH/rJ9ZgRgvh9gzRGUAYPhBOWLWexaWbiHdtjdXmJi9rzWK4cfdoDgi0Ew3TedGLpUcMOkeoPSpH6mwAAjowGiE/Z1iiWtWYR3LLakLqE1FeJ/ITnZdoKToVIHCO+BsBkh3H+UKs58jQobqC+axHHhzHipk/dJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvT6e3Ob; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07c081660aso312663466b.0
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 17:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724853; x=1758329653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNaBVV0FpkKN0cdUwxCZ8fQss5eC0TEeX4co/5GJ2YQ=;
        b=NvT6e3ObjPoqqPnxCS60GcwK+yLdOlfN22Jnv2lY67RA/U1al/OIo3S4BwG/GKULue
         oTCpL8coYPSgHWTBgX54uuCFQcUq1LHojhq2vj1SU0MSap61BLXAyUIZVC9Wm8MNNSKQ
         ZIJvpWkRvAUlrww9wJU5tj83FxL3UGf6dcaoDZIF/lsSYItI6HG6gpZSxJDoVbVfCCvt
         rdp0lb5dDw4ls+bnlyJn6EDojFmBWvllBN5GBV9Xi95j5sjAnNZnWIgr/IlHDyt1nZ0I
         q0ApG2FWKiKptbJBqBpWqvJuz2WEwrbOtYPrqw9HMraW/wyXa/GoD5KUhkMKAT0DY+iW
         pwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724853; x=1758329653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNaBVV0FpkKN0cdUwxCZ8fQss5eC0TEeX4co/5GJ2YQ=;
        b=BUMeYQzApMDOeHl1LcqpdBMN+Xt9GRr5RTIRGBE0zydBAtoMZ1qWUemz4cyDltY9oA
         FDcE0y4ykZJ6/GurDujgWELsPHvRSUOhDAv3lkEihyzJB+VAtmGEttPhef6xJ6C97KAd
         nomwCQ1QRhj75Ju/UqL6Iaz9ateWkjEBG3CUSePnCcg0SXO03totcOYgY9dX/F0RyPoE
         GLBHGa7gVVyokwP6g8ZPZ4b/yrpiT1H1pBcIsUYnlLCDWKoK50ZauoGqarnHEHEy+LE1
         RHiyb1ZXGMalY+KQPxZzutTF76osIkTaOILRDsXbym2omtecqrlkUenntu0sGmBakjf1
         sxJw==
X-Forwarded-Encrypted: i=1; AJvYcCVidMwhw9muoN/PqOHlD4okVCvSQbjwkfpDGuOKV3bL61S54p0zjSu20ZN5p5kL1hz3+Efin0GgK7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIE5K0Pdfj6tCKPLTapT+8LaSrT6yAaKoK90H0wrzt/HEvzTYK
	3zz6asRFqkLTwjoond/yMJ5HaaOI0w6gJHfEQu1lk4KavVmQfcGjwh0b
X-Gm-Gg: ASbGncvDsmx6Ea3runno1O/8V+WDv+KoxrhxtoYcD7etDJi+UNIJGH0kDzkj5Lsshz3
	6uorYzqBVWpr/agxCDK04LgbHnA+pFMUwsjVCU61Y8YhlhaAqloEaeCQZlNbVStp69k5YURqPXY
	jYBHoBi1Ps6eD5cL9uZfCqEznd4Qn81e7cVY/2iXRhvLa8FbZ6nCF9AZCDT0+f0XLgU7RH1T5jI
	8OkMuFO8rZgHOiOS+DPBLg4ETrAQuX8qrPsyPE17N+KdL3Va8Jxmj6gsfCXm47/TZhvSzLk/RZU
	gVWocLOBUzAIsg34OjGg+fckGA5wNSe+twBgicii+YWxTYfqxUAU161j4JSeiA6jwBgKuCxp2P0
	+ldFGl5vbQsnQTMsCaLfngG7xQr50JA==
X-Google-Smtp-Source: AGHT+IFRAhwUW5zsVWdQl7rom9u+xngcdJiQFGIxNb9yv6sUT2JdEwHxw5AIwBj5WkuunZa0hzcUAQ==
X-Received: by 2002:a17:907:7e8c:b0:b04:3513:5138 with SMTP id a640c23a62f3a-b07c37fca87mr474198766b.41.1757724853144;
        Fri, 12 Sep 2025 17:54:13 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da310sm465332066b.20.2025.09.12.17.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:54:12 -0700 (PDT)
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
Subject: [PATCH RESEND 13/62] ext2: remove ext2_image_size and associated code
Date: Sat, 13 Sep 2025 00:37:52 +0000
Message-ID: <20250913003842.41944-14-safinaskar@gmail.com>
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

It is not used anymore

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/ext2/ext2.h          |  9 ---------
 include/linux/ext2_fs.h | 13 -------------
 2 files changed, 22 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index cf97b76e9fd3..d623a14040d9 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -608,15 +608,6 @@ struct ext2_dir_entry_2 {
 					 ~EXT2_DIR_ROUND)
 #define EXT2_MAX_REC_LEN		((1<<16)-1)
 
-static inline void verify_offsets(void)
-{
-#define A(x,y) BUILD_BUG_ON(x != offsetof(struct ext2_super_block, y));
-	A(EXT2_SB_MAGIC_OFFSET, s_magic);
-	A(EXT2_SB_BLOCKS_OFFSET, s_blocks_count);
-	A(EXT2_SB_BSIZE_OFFSET, s_log_block_size);
-#undef A
-}
-
 /*
  * ext2 mount options
  */
diff --git a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
index 1fef88569037..e5ebe6cdf06c 100644
--- a/include/linux/ext2_fs.h
+++ b/include/linux/ext2_fs.h
@@ -27,17 +27,4 @@
  */
 #define EXT2_LINK_MAX		32000
 
-#define EXT2_SB_MAGIC_OFFSET	0x38
-#define EXT2_SB_BLOCKS_OFFSET	0x04
-#define EXT2_SB_BSIZE_OFFSET	0x18
-
-static inline u64 ext2_image_size(void *ext2_sb)
-{
-	__u8 *p = ext2_sb;
-	if (*(__le16 *)(p + EXT2_SB_MAGIC_OFFSET) != cpu_to_le16(EXT2_SUPER_MAGIC))
-		return 0;
-	return (u64)le32_to_cpup((__le32 *)(p + EXT2_SB_BLOCKS_OFFSET)) <<
-		le32_to_cpup((__le32 *)(p + EXT2_SB_BSIZE_OFFSET));
-}
-
 #endif	/* _LINUX_EXT2_FS_H */
-- 
2.47.2


