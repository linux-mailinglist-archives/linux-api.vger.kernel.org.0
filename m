Return-Path: <linux-api+bounces-3746-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1962AB38AB
	for <lists+linux-api@lfdr.de>; Mon, 12 May 2025 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D257AB80B
	for <lists+linux-api@lfdr.de>; Mon, 12 May 2025 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5B296155;
	Mon, 12 May 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZXMAE/K"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509D255227
	for <linux-api@vger.kernel.org>; Mon, 12 May 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055976; cv=none; b=ORQLNYCJtxpzt6KcWv6OAsljK3ybaED+pEhKIrHzF0PgwRAuAAZv9z7XwPdLTJAPt1koJfnCl69s0DjhDGAdOv1iNp1YV5B/g4Zqp8eiHEt8Klw0/67R/+DrbOCdoS6R2TQVtO4IMq7GEe9qH8JbyWG219F4Wl79tnd76xA2xwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055976; c=relaxed/simple;
	bh=Sow3ieK523EXyMicqcCSjkd/TH+5nWsIoTZ6MRpL6MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDgfYaOqAnil72QFRPEjR/0S0GwIfkuLaNgmbV/eIOwvlQ1Ao2fUwVGICFH0UEZR3va4uZf+s7gmtW8bFDdwJN7R0OouZKBf6kpj1HNmrws7VPlS8WEJik76oBGka9DO3SH6x73vzK/JoOnal6uPXLaxdqdgp2LEqony6xLjf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZXMAE/K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747055971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDXnQGld1rGn7NpA5vNTnzaJVN2Ft1voUe3ylxYDySo=;
	b=YZXMAE/KK3RBHk+5RhA1CGPjZGRFdkQHy0kCU1HXyx4qGFpvRs1G8ZYf+iH4EueEP7NQM4
	RbTSYbq5CviiSZHkKwMivrDTQO9JkWW+ay0E+Twt2F4Zs2pEnq161h5zamn7jYTe6DRzz8
	3G1tcnDBz4HNxIUC4ZRA2hqGOBSFCvc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-zRLAQzAQMBClhDxMU0XCYQ-1; Mon, 12 May 2025 09:19:29 -0400
X-MC-Unique: zRLAQzAQMBClhDxMU0XCYQ-1
X-Mimecast-MFC-AGG-ID: zRLAQzAQMBClhDxMU0XCYQ_1747055968
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad21f1eec62so274087466b.1
        for <linux-api@vger.kernel.org>; Mon, 12 May 2025 06:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055968; x=1747660768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDXnQGld1rGn7NpA5vNTnzaJVN2Ft1voUe3ylxYDySo=;
        b=M5gHbrtqzCZHxwZksNwKcZeNtYQluYzEYOmWdLXx7jzgX7Sfh7ZTcRGf1MtGQHzxmm
         L7KQQmxzqvHrXjGpDS45Rhr2+jx5g3Ag0xc/OnUn01SNcYbeTP7oSMYMSZyFzIrzWf9j
         FbAgEeK0sPXm6biwV0NL+ZlZCDbAnhR91IXstgDt+9gTqNecujfLJrbh17WV8liVGfSj
         6IMYpvpyx8b5ZAGm9qQtSZN0uuZgyxNm8CFt6o2uqgd+8JiGEkbiSbqcdFxacV8P1Rrs
         mKbF/iBbmcatxwALYmLphU4aEEDc3xfcdvd0nbFmyxY9YHLT+JrZOnYL51RA5TS3q4jD
         0G9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpYDSymWG+X5e2Uit8gaVu2ONveSCpb0g+4Fify3UDXQbb5cjW/eBDVWaJ5qysE/cRBdoFID7PQVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUEmcc8Rt3Zpm+ZR+SJfKTCsa6arSkuDNG36yqBYK/ceo/BYrT
	eXO8Qkbf+4x7iJ2EoeePl1bEnjcsGfySEYuCnWJOiC++tmoCJWOwGmG8UQHqRCZzDAUpv5AwTXJ
	luOfFk0/s7luvQcMUDl9IDFF3FVNoKlsoH4HDUCFj9gtvfUUTx9kn3VOe
X-Gm-Gg: ASbGncvrzuItJWeQoqkCyYlPt+nOTmBxyGsLQ5lWhOYmxt6FD7iNBIoDGkrU7bWoBjm
	6Kb4N5fUlPbVTBWW9O4D7k5kLAy59vg3XWNUAj+nFhlOqL+jr7ZRFw0TFZ62ZKJ/CDX5Q4zw7dN
	Fzi2CrbwG9uxXlsV/Pru4h2fONFHoXVzK5L/BYXBdPUhpzOn9LL5wm679heqiLjDS5yyByJveN/
	5+IFQhMKAwEuAGTfxt/nivmpVCy0OB/BKnFMYtz8pTcHI3naE2b5Z9IaKTw8+7CY7649OmmsaWb
	qmBK9WikNjMtRtneEvFyq59vIeM=
X-Received: by 2002:a17:906:6a22:b0:ad2:cce:8d5e with SMTP id a640c23a62f3a-ad21b16d4d8mr1361758466b.7.1747055967954;
        Mon, 12 May 2025 06:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Wm34D/72hdzOITX/1P+LJJ3f88CMImIhv4h5FTIdAsUC2LOrFnS2VVLTTqMPzoKoT8uong==
X-Received: by 2002:a17:906:6a22:b0:ad2:cce:8d5e with SMTP id a640c23a62f3a-ad21b16d4d8mr1361754066b.7.1747055967429;
        Mon, 12 May 2025 06:19:27 -0700 (PDT)
Received: from [127.0.0.1] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bde09sm612328766b.125.2025.05.12.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:19:26 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 May 2025 15:18:57 +0200
Subject: [PATCH v5 4/7] fs: split fileattr/fsxattr converters into helpers
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-xattrat-syscall-v5-4-a88b20e37aae@kernel.org>
References: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
In-Reply-To: <20250512-xattrat-syscall-v5-0-a88b20e37aae@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=Sow3ieK523EXyMicqcCSjkd/TH+5nWsIoTZ6MRpL6MI=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMhS/+l+d2NV18V2W7kMGnsp1P5oOhUkzLv1iXWyve
 u6BgJTb4oCOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE8kpYPifV7rt5W3p05uf
 VJmX/T9pu3iZ1uHej6nJczr3l3gX/F8dz8jwtzfAKvXqrcigX7ucu9t/uaQYyQb8rb92wEHraHl
 ATC03ANV+Srw=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

This will be helpful for file_get/setattr syscalls to convert
between fileattr and fsxattr.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/file_attr.c           | 32 +++++++++++++++++++++-----------
 include/linux/fileattr.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index be62d97cc444..d9eab553dc25 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -89,6 +89,16 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
+{
+	memset(fsx, 0, sizeof(struct fsxattr));
+	fsx->fsx_xflags = fa->fsx_xflags;
+	fsx->fsx_extsize = fa->fsx_extsize;
+	fsx->fsx_nextents = fa->fsx_nextents;
+	fsx->fsx_projid = fa->fsx_projid;
+	fsx->fsx_cowextsize = fa->fsx_cowextsize;
+}
+
 /**
  * copy_fsxattr_to_user - copy fsxattr to userspace.
  * @fa:		fileattr pointer
@@ -100,12 +110,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 
-	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
-	xfa.fsx_extsize = fa->fsx_extsize;
-	xfa.fsx_nextents = fa->fsx_nextents;
-	xfa.fsx_projid = fa->fsx_projid;
-	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+	fileattr_to_fsxattr(fa, &xfa);
 
 	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
 		return -EFAULT;
@@ -114,6 +119,15 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
+{
+	fileattr_fill_xflags(fa, fsx->fsx_xflags);
+	fa->fsx_extsize = fsx->fsx_extsize;
+	fa->fsx_nextents = fsx->fsx_nextents;
+	fa->fsx_projid = fsx->fsx_projid;
+	fa->fsx_cowextsize = fsx->fsx_cowextsize;
+}
+
 static int copy_fsxattr_from_user(struct fileattr *fa,
 				  struct fsxattr __user *ufa)
 {
@@ -122,11 +136,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
 	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
 		return -EFAULT;
 
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_extsize = xfa.fsx_extsize;
-	fa->fsx_nextents = xfa.fsx_nextents;
-	fa->fsx_projid = xfa.fsx_projid;
-	fa->fsx_cowextsize = xfa.fsx_cowextsize;
+	fsxattr_to_fileattr(&xfa, fa);
 
 	return 0;
 }
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 6030d0bf7ad3..433efa0f4784 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -33,7 +33,9 @@ struct fileattr {
 	bool	fsx_valid:1;
 };
 
+void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx);
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);

-- 
2.47.2


