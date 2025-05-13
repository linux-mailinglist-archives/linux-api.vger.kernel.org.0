Return-Path: <linux-api+bounces-3760-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A47AB4F4C
	for <lists+linux-api@lfdr.de>; Tue, 13 May 2025 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4298C35DA
	for <lists+linux-api@lfdr.de>; Tue, 13 May 2025 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317121B9E5;
	Tue, 13 May 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwRn6GRH"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649A202C4E
	for <linux-api@vger.kernel.org>; Tue, 13 May 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127910; cv=none; b=sSVbgiFMYZVaEv4Ku414qZMs6b0HPmmLlTbzlwOHUQtZ5XcunJGGw+TxwTFM/fK9YH4AT3gWp/9jqKLipbd44XPcfJgrqeYAlvh7tLFnhfuKyN7L1orUqdywSJYqsT18KI5P21mFv+P7bBQe7uC+YNdq7QVcX0w/dxEoKC/uUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127910; c=relaxed/simple;
	bh=7/qlLocSDGOnq9HanUewnfKPkCH1bdYdAp9tNZm+5GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVoruMV6aC89cQDS3V4mJi7REnvQ6mkQa/+vYN8XNG3bymQihkkD795tEVMxcGaKptTdpfx0Kimmz5GMnUwmly+8Nlml5+UYGUnOEbhgaNiRCd8ja1RYKB4WaQ8y8lyBqFW0VZNb5Y91MHsMZMSuvIWEgpcMKwTmuXw0+yu1g6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwRn6GRH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls6EYzWLpzSyrbfDPukFujnVQKFcbGgB9h/N+wiqpNc=;
	b=NwRn6GRHautpzCamQJj5HCppOOMKHak9CpnTP8wm2MoOirnL7p3+z3uVZWHPTF4+ntwC4V
	ENJ5ml3Mwx34gelmCe3U6e4hamdvdV1gWHCzr43UndNKIR4XmxsFqoatCS9xymu1QAcfjf
	s8GwfKfBoDNgrcWF+QgTw4Ax/AKIG38=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-CEDDETM5PX-tFR7_oI4I0g-1; Tue, 13 May 2025 05:18:23 -0400
X-MC-Unique: CEDDETM5PX-tFR7_oI4I0g-1
X-Mimecast-MFC-AGG-ID: CEDDETM5PX-tFR7_oI4I0g_1747127902
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so32443085e9.2
        for <linux-api@vger.kernel.org>; Tue, 13 May 2025 02:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127902; x=1747732702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls6EYzWLpzSyrbfDPukFujnVQKFcbGgB9h/N+wiqpNc=;
        b=jniHCeUcjPVVADLqWwt9mpTuPvfAy+MQpHIao6r3kE91jRHpP76kjnIfJEloelQFMY
         1AE3Yc92AtWIQYYK490e7x9GRoaP53D1PVSrPnwytvJue3T4E2FXBUOI7Z4TZJyLB/VC
         BZc9OZzHwuhGxdg7WLWiszpfa3al4xCbpnlB2QYRK32j9wXqllyYZxlxIjC6mCO/8itP
         bm69zzU1zCcibGNemJBXDcSwd4gW+DNGfuLHVPewTgJXI1Jni2NHJGDEmoiF0V8FJ/LC
         ctkyMDhKeXRRJLvkH+YdmGocBfTEI6uiVZB6haUYikheGgWhBZZe8pEWha31luDJxw4d
         cGgA==
X-Forwarded-Encrypted: i=1; AJvYcCWwkzkJeDSZ9T8ksWYSQhpeLrQgBOEytc+HLGgGKdgk+nLBdOKqZoY3P0A1QdSXoGRV56LXQkRNeNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJFmr3NMT4XecXXxiRXfnQ5eSgBmACMKDxSMm8z6AVvPf4kcGk
	HE7vqqu2QVV++jKfQq3y7xtFJ5MJr37+8sHUUNu7pnUS6BUn140U05mnvHwfO/90yHIicMbgCWS
	XuR8Vio0l2wZrxmtNKvMkQHyC5fuu3yLBJ2SApO2Nt4acFYKa4hc5oAwX
X-Gm-Gg: ASbGncs+PbO/QMUehh0G7Ja7cmpz8SYu4NxC8XpYcmHqOS+ogYc56KFL+ZvNl3oftMk
	LewojBvBT5vWbVcOMihZSSvJ9OFp2L8ifdNcqA91BZ58hbTZjL6sEYtrFT9Ryldo5wN2vyzqkn+
	KZg7Uz2IRN8ScpeA8gyRbJpMZjwOV7Pre9vClfN4K12v0jaJ8x1aA3KCnFtR2I6HBQuZ7kxI1Ol
	/GZBVcFqoq3uhHjXbzUMU0uHJTJFPg/2mHcI5fm787IDU//G+i4ONcgqyyUokJOsmxfytTI3NGL
	bTNIJ2WTB32/bzuYW0s/QWPVV9KQuhs8LLhzvH0ZGtFEBvo=
X-Received: by 2002:a05:600c:37c7:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-442d6d379b2mr155020595e9.14.1747127901746;
        Tue, 13 May 2025 02:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEEtHWgn5s898vXVMD6AEOwzulPPtHZtUMHxI74NvDZ3sPtiUYejsU22j+vwltmbRtQ8fYMg==
X-Received: by 2002:a05:600c:37c7:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-442d6d379b2mr155019705e9.14.1747127901297;
        Tue, 13 May 2025 02:18:21 -0700 (PDT)
Received: from [127.0.0.2] (109-92-26-237.static.isp.telekom.rs. [109.92.26.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm12345655e9.18.2025.05.13.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:18:20 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Tue, 13 May 2025 11:17:57 +0200
Subject: [PATCH v5 4/7] fs: split fileattr/fsxattr converters into helpers
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-xattrat-syscall-v5-4-22bb9c6c767f@kernel.org>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=7/qlLocSDGOnq9HanUewnfKPkCH1bdYdAp9tNZm+5GE=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpT5vBmqeS9Of1kvckyD89yLKSHZd6cITHwR8ON6Q
 Krbn8kRqyw6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJbAgXpwBMZHojI8Npu1fs2yWveYpu
 X75O9+PGOXL/F3U+vN7XHFJf5fdw0aozDH/lf/x993b3NibzczpnPr7ddd+5/McRwUl+3zqveq7
 g+LeWDwBTZEzV
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
index be62d97cc444a445deac1c8ac8331f4a3766126a..d9eab553dc250f84075ac74c1c7d8d6fd6588374 100644
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
index 6030d0bf7ad32693a0f48a6f28475d97e768bb3e..433efa0f47844ef063373eb390672812682b6388 100644
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


