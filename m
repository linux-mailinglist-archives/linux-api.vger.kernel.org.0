Return-Path: <linux-api+bounces-3436-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D61A6C538
	for <lists+linux-api@lfdr.de>; Fri, 21 Mar 2025 22:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A39189ECF7
	for <lists+linux-api@lfdr.de>; Fri, 21 Mar 2025 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC980232395;
	Fri, 21 Mar 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fIRjMm4y"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED9230BC5
	for <linux-api@vger.kernel.org>; Fri, 21 Mar 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592750; cv=none; b=fqw/tHgbOaBuItUCwnDys6UVeQe8w6fF6LLBjD4txe3fu+7Crb6KpJLFVhHX1ptqN5ukvQUbExoc6WyUvSzGsx53ZTZsVG1PpPhLg2a4Pdbq9idPvnTbKXmmvl60e2y/bOVUG6OncqqCk7whX7EYyLu9MjwCFHgvrdZgWx3G0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592750; c=relaxed/simple;
	bh=yG1Qzi6F+aGsBMpdWaT175/M25TWqxBfzW0aBc2Mby8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=GKUO6Yce7eec4EALQ7LkJfBU5YiucK0MzVvQLeSLISdHFIf1ludixa6bVjRrBA94t5V3TRWaF5H2fDVdI6uY6Up8BiqIWjU/UF4b57Aq2VxXSY2QNHBE1kgOaco4PNCdHEAplu/deXtnCMjBiVn0/XH4pPncmxAxaGQ9sXIygXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fIRjMm4y; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476775df2f0so33479811cf.1
        for <linux-api@vger.kernel.org>; Fri, 21 Mar 2025 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742592747; x=1743197547; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkEW7se4kA9gakYYehbVu1ZGmOR39c99GGBG3Q74ESA=;
        b=fIRjMm4y38rt6rR4EiVKrVqg8BgTJNJQzyxdGM3k4y0k9FWSEYB11GkLVZzJlOJC6P
         LYoP8Lc8BN7MqvRpg1M6uwz5/HCvBNBnnUPff9qC9ZraQOsQ5GUQEawk8nwSJ2R7w19Z
         Sk01Pvd8sjpeKYJJxvykAYmwnre5DsbtRyrfPhzlWJPMAhta6i64rgRDiNja4KVmxnVP
         rzhGnDTCiEHE+V04jIUKueIyxF6Gr30GDSoRcl/LOSRTXDBhiSsLptTCSi6lTO7cgJdu
         3HHzCXJxe7cd89ONE4gDisu7v9DNNUwILVxBToovN+8GcAfKKh+8f8rSbRrLTA/ycUPn
         SCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742592747; x=1743197547;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WkEW7se4kA9gakYYehbVu1ZGmOR39c99GGBG3Q74ESA=;
        b=hYTVxYlneuwVNKGzZunoFNzKuAhoA5l8w7K6tWGczofqQXrpJcDDxLhyz3NGyLoDQS
         VbkeZ297kfLWm2qNzB3UVX3CPPQc3uuJOM7tZIoIFXndnoGgCDRXM4FPTQKJXDUnh6Ye
         Zk1ET8Ra1Mvib3jp3aYsIDOK67UwouEut9IrfJUgpR39gNIozGLVsqNVMQDXomwko9G0
         IyNqS+USCOoMQiFnAJI4l1Gs8n3BIi5jDoFAX78yh2LjzGQ964/DO6F4mYoeLdEputA8
         16wnq1n+VuXNnhoj6TnB6KnItt8cFnt5jRtedzLmlvgfWQ7kqBcQXh2ZpkMYnJ3H8DLh
         kd0A==
X-Forwarded-Encrypted: i=1; AJvYcCUAJ7qzkWBJmqwTALpFmMqOrbfq+Ef4M9yayu6VGNZoFojthQ/s0IUTgwJBw+VDH1Wg4WJkjScHg3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/HkG0bSQ13kkwu+edR5TiEZbdXe49BKu5Qti43d5wdaE+xF+
	u6aG0LaxLe9kMCl9fnbimgDefXsFTDr7YQxp30hCqF8t0G49ufOUBXpLMdDDhg==
X-Gm-Gg: ASbGncteliGa66XHC2rwTmtbXu5WNSouqy3HaUfTTt0jSetqxN0VGlgdN+gFflkvoHX
	gu9g3+QcnbLJxaEP3kvGtDASfKqb0I0x8np2MOuSLtApb2+oANOwNqpoSwbYYLWpUDz5qBa4WMZ
	flzIkgA8ZkGhp3VyXFe0OLfxA0t80PM0B2dqxGmB/GVkzEJTtciGcLS5Lx7xXhjcCUZ3xmvqfp4
	+8OovRXA+HbAFKq/e2M5H1F/lMJmg1YEdDg93FXh5gd4a81avv6aW7sWeyygZ0BwNgzGgItnlBM
	WcKNNBT+a7aDSr43WxLPu4bjubm4Zn1j4d6dCJza7z8jLVprLc342aa1RqsovJB3aAFtF7OtOTx
	U+h6dPbcI4zuKnQ==
X-Google-Smtp-Source: AGHT+IEqvMs9f3zdHkqatEuHHMLq+Pp1CGQwo1N+6m68HBYAt0XjQifVPk3cXxCHJ8EdFG+VR82ouA==
X-Received: by 2002:a05:622a:1f98:b0:471:fef5:ee84 with SMTP id d75a77b69052e-4771d924e1emr70292591cf.7.1742592746683;
        Fri, 21 Mar 2025 14:32:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d64d5f6sm16343541cf.81.2025.03.21.14.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:32:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:32:25 -0400
Message-ID: <e2d5b27847fde03e0b4b9fc7a464fd87@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250320_1749/pstg-lib:20250320_2248/pstg-pwork:20250320_1749
From: Paul Moore <paul@paul-moore.com>
To: Andrey Albershteyn <aalbersh@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] lsm: introduce new hooks for setting/getting inode  fsxattr
References: <20250321-xattrat-syscall-v4-1-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-1-3e82e6fb3264@kernel.org>

On Mar 21, 2025 Andrey Albershteyn <aalbersh@redhat.com> wrote:
> 
> Introduce new hooks for setting and getting filesystem extended
> attributes on inode (FS_IOC_FSGETXATTR).
> 
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/ioctl.c                    |  7 ++++++-
>  include/linux/lsm_hook_defs.h |  4 ++++
>  include/linux/security.h      | 16 ++++++++++++++++
>  security/security.c           | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 1 deletion(-)

Thanks Andrey, one small change below, but otherwise this looks pretty
good.  If you feel like trying to work up the SELinux implementation but
need some assitance please let me know, I'll be happy to help :)

> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 638a36be31c14afc66a7fd6eb237d9545e8ad997..4434c97bc5dff5a3e8635e28745cd99404ff353e 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -525,10 +525,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	int error;
>  
>  	if (!inode->i_op->fileattr_get)
>  		return -ENOIOCTLCMD;
>  
> +	error = security_inode_getfsxattr(inode, fa);
> +	if (error)
> +		return error;
> +
>  	return inode->i_op->fileattr_get(dentry, fa);
>  }
>  EXPORT_SYMBOL(vfs_fileattr_get);
> @@ -692,7 +697,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
>  		}
>  		err = fileattr_set_prepare(inode, &old_ma, fa);
> -		if (!err)
> +		if (!err && !security_inode_setfsxattr(inode, fa))
>  			err = inode->i_op->fileattr_set(idmap, dentry, fa);
>  	}
>  	inode_unlock(inode);

I don't believe we want to hide or otherwise drop the LSM return code as
that could lead to odd behavior, e.g. returning 0/success despite not
having executed the fileattr_set operation.

--
paul-moore.com

