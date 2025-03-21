Return-Path: <linux-api+bounces-3429-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F3A6C3A0
	for <lists+linux-api@lfdr.de>; Fri, 21 Mar 2025 20:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528DE3B6677
	for <lists+linux-api@lfdr.de>; Fri, 21 Mar 2025 19:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEF23024D;
	Fri, 21 Mar 2025 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zj/Ch96k"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21207230268
	for <linux-api@vger.kernel.org>; Fri, 21 Mar 2025 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586565; cv=none; b=p20SxbiPI95P3Rmm6eSKxtp3Tp5NAgA+f46cIjKDgHNkdgEl6aH4pVEZmJGai+pmq1TSOHO/C3a09adbsloWNu4FpQG+SSqXJvTMFB0pohx0XdU7Iab6ka4tgd3RmwbnvTzVP1soZ8ZpRb1Q7bc/SXyGHESHHWOQzDaEAr7Ejp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586565; c=relaxed/simple;
	bh=FQVoAK1grhAv3nZByLs+uzRSU6UsJz/ykU8hQy3B+S4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WGGR7nFAMQrLgqTi9GP3rbrnfUt0ex4ODaQ8wIN1HQleMAFAGRec/Viwbp9/bxYjou2UeTV9lxAdDa+Hz8N3FFxrhyNbc6kRsDGI+EzKEDwE1SMZwfC84AxVuppZ0y6V3RUPZeBAt3kujnl3S3Wc+nWQ3c1z3CshDcmn8mo7hwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zj/Ch96k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742586560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1wNhBnm2ReGLfeaXSKjzDT3Sr3/X+7bRy4uy/8cmkEY=;
	b=Zj/Ch96kj2UTOIxpe0+9KH4Zv0p3ou3orEJRdxGDEdjp30Bdv1IIA/s3fOw6FIFHBHS8Yl
	KO+XkcAe7p6uEvCqa5N/vuciuDNpeJymuUj8P8QGXUKaghgNMcxE4wtFicwaxM7q/CFHdo
	izRD3sX3NGDtkCHNs53UCCrSnh9Vdlw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Jn7cq5gnOE-qp8zQlFkH9w-1; Fri, 21 Mar 2025 15:49:18 -0400
X-MC-Unique: Jn7cq5gnOE-qp8zQlFkH9w-1
X-Mimecast-MFC-AGG-ID: Jn7cq5gnOE-qp8zQlFkH9w_1742586552
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abec83a498cso214471966b.1
        for <linux-api@vger.kernel.org>; Fri, 21 Mar 2025 12:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586548; x=1743191348;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wNhBnm2ReGLfeaXSKjzDT3Sr3/X+7bRy4uy/8cmkEY=;
        b=fRsBrP8d8a8NgNk712iyY1pbXkIGdCs+ME7tWaXoLBxhQjTelHz28JQKTR/emA++hR
         4pT6v5yzhMSzoWmp6uMfSdlQa12W+EB56IP4MSfdXrKbNDYYoSU2A7BhaKgmgnaYbomh
         yfvKJlcnKmYnLmtcQiZqpXurMCaeepvtgJJhdq+AImrRx/ZK4VjogI3jIAHRiG/9SJ9D
         sm0LwnwNC7OgAb/guUO/U0F5NaKSpvegdu7jxOcebWO9k2z1Ykt8nfqnef+7WCedVr/w
         x1n30p/trnI6hNSWyeXXp8DGtLtagjC3mmcEEk/FayzG8LfqJ2hRZ9FyNyLAGMSAAKSm
         LY2g==
X-Forwarded-Encrypted: i=1; AJvYcCVr4huF8Yr2jBwC3DTjgvjpskjbiIi7uci3ObMyvVVMa6tFpzGhHChScOvbeU+uW6MZJleVNsNHm6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98KW7evrE+8ie2S1EcCZov8RgNpECTItmV3kD9SBNFgvm1duG
	L/3onqQvVpg+Iu0fi9UqSffxKa936SWWT+s+3GBdof3ZwLCalEWVEkVNy3uZ6hejibq59m8Wqjx
	OSp1SJiBm3LGICaSlN1WSQu1POg9ivp8pSBLN/KaKYjF5WOCeS8joVkVW
X-Gm-Gg: ASbGncsaI+hAWIucB8LLRpm7FHy3J/PMBja1JJNPpmUX6j5PPsedV43JiU+wiM2wvMt
	AKlZk3KcmWcd1Un8pMmT4Vt0VV8u6MVDZ5OK0nXeFzjC7Y+4oSHfVWIgauDYB07ysJVsI0nP9cz
	K7oUIkzkeKk2zH7Lu/H+0uODxY3zmx5vreHkkcERFL1VfncfyXGDphtCeo+tU1ODqufcIOHESZi
	IEkFSzDJK85N3tBG9UNiqCN91sAid112sxHvFkcYxRCYoaoRGOLAZ/SAY7ao8/aF7V4GqQFwghc
	+v5ko+QXE/2FRGDEzSXAivY1nXdu6FFqBeuc9gb4Aw==
X-Received: by 2002:a17:907:7dab:b0:ac2:7a6d:c927 with SMTP id a640c23a62f3a-ac3f251f252mr442163866b.50.1742586547720;
        Fri, 21 Mar 2025 12:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIuU8NfxIMB+ef2e3eKHAzCm35NOLlzxTP1nDtQXGYf88xl+hzf++88iNdtamLPujW3TPHjA==
X-Received: by 2002:a17:907:7dab:b0:ac2:7a6d:c927 with SMTP id a640c23a62f3a-ac3f251f252mr442156966b.50.1742586547062;
        Fri, 21 Mar 2025 12:49:07 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d38sm204412266b.39.2025.03.21.12.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:49:06 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH v4 0/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Date: Fri, 21 Mar 2025 20:48:39 +0100
Message-Id: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJjC3WcC/2XN0QqDIBTG8VcJr+fwHLPVrvYeYxeaVrKoUJEie
 vdZDAbr8v/B+Z2VeOOs8eSercSZaL0dhxT5JSN1J4fWUKtTE2QoGEBOZxmCk4H6xdey72khAXi
 hUStRkXQ1OdPY+RCfr9Sd9WF0y/Eg4r5+LcSTFZECFYoXTOeNqhU+3sYNpr+OriU7FvkPQIAzw
 BMg2U2DaMqq/AO2bfsAGIg0CfAAAAA=
X-Change-ID: 20250114-xattrat-syscall-6a1136d2db59
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
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>, 
 Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7149; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=FQVoAK1grhAv3nZByLs+uzRSU6UsJz/ykU8hQy3B+S4=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0u8e2vB17Ur5VW0+Gx1C7pyq2fjopYGGydO9y6YW+
 c/4/jCiIG1rRykLgxgXg6yYIss6aa2pSUVS+UcMauRh5rAygQxh4OIUgIlcSGZkaAtVCfd2P3uU
 cQdTt4coF6++p8WE+2wb8xhWObiyr2E8y8jQURZRWfY081TjgR7tSktm7c+nv4iv0W9lm1se/Wa
 T5xkGAGijRuY=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

This patchset introduced two new syscalls getfsxattrat() and
setfsxattrat(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
except they use *at() semantics. Therefore, there's no need to open the
file to get an fd.

These syscalls allow userspace to set filesystem inode attributes on
special files. One of the usage examples is XFS quota projects.

XFS has project quotas which could be attached to a directory. All
new inodes in these directories inherit project ID set on parent
directory.

The project is created from userspace by opening and calling
FS_IOC_FSSETXATTR on each inode. This is not possible for special
files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
with empty project ID. Those inodes then are not shown in the quota
accounting but still exist in the directory. This is not critical but in
the case when special files are created in the directory with already
existing project quota, these new inodes inherit extended attributes.
This creates a mix of special files with and without attributes.
Moreover, special files with attributes don't have a possibility to
become clear or change the attributes. This, in turn, prevents userspace
from re-creating quota project on these existing files.

Christian, if this get in some mergeable state, please don't merge it
yet. Amir suggested these syscalls better to use updated struct fsxattr
with masking from Pali Rohár patchset, so, let's see how it goes.

NAME

	getfsxattrat/setfsxattrat - get/set filesystem inode attributes

SYNOPSIS

	#include <sys/syscall.h>    /* Definition of SYS_* constants */
	#include <unistd.h>

	long syscall(SYS_getfsxattrat, int dirfd, const char *pathname,
		struct fsxattr *fsx, size_t size,
		unsigned int at_flags);
	long syscall(SYS_setfsxattrat, int dirfd, const char *pathname,
		struct fsxattr *fsx, size_t size,
		unsigned int at_flags);

	Note: glibc doesn't provide for getfsxattrat()/setfsxattrat(),
	use syscall(2) instead.

DESCRIPTION

	The syscalls take fd and path to the child together with struct
	fsxattr. If path is absolute, fd is not used. If path is empty,
	inode under fd is used to get/set attributes on.

	This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
	ioctl with a difference that file don't need to be open as we
	can reference it with a path instead of fd. By having this we
	can manipulated filesystem inode attributes not only on regular
	files but also on special ones. This is not possible with
	FS_IOC_FSSETXATTR ioctl as with special files we can not call
	ioctl() directly on the filesystem inode using file descriptor.

RETURN VALUE

	On success, 0 is returned.  On error, -1 is returned, and errno
	is set to indicate the error.

ERRORS

	EINVAL		Invalid at_flag specified (only
			AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH is
			supported).

	EINVAL		Size was smaller than any known version of
			struct fsxattr.

	EINVAL		Invalid combination of parameters provided in
			fsxattr for this type of file.

	E2BIG		Size of input argument **struct fsxattr** is too
			big.

	EBADF		Invalid file descriptor was provided.

	EPERM		No permission to change this file.

	EOPNOTSUPP	Filesystem does not support setting attributes
			on this type of inode

HISTORY

	Added in Linux 6.14.

EXAMPLE

Create directory and file "mkdir ./dir && touch ./dir/foo" and then
execute the following program:

	#include <fcntl.h>
	#include <errno.h>
	#include <string.h>
	#include <linux/fs.h>
	#include <stdio.h>
	#include <sys/syscall.h>
	#include <unistd.h>

	int
	main(int argc, char **argv) {
		int dfd;
		int error;
		struct fsxattr fsx;

		dfd = open("./dir", O_RDONLY);
		if (dfd == -1) {
			printf("can not open ./dir");
			return dfd;
		}

		error = syscall(467, dfd, "./foo", &fsx, 0);
		if (error) {
			printf("can not call 467: %s", strerror(errno));
			return error;
		}

		printf("dir/foo flags: %d\n", fsx.fsx_xflags);

		fsx.fsx_xflags |= FS_XFLAG_NODUMP;
		error = syscall(468, dfd, "./foo", &fsx, 0);
		if (error) {
			printf("can not call 468: %s", strerror(errno));
			return error;
		}

		printf("dir/foo flags: %d\n", fsx.fsx_xflags);

		return error;
	}

SEE ALSO

	ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2)

---
Changes in v4:
- Use getname_maybe_null() for correct handling of dfd + path semantic
- Remove restriction for special files on which flags are allowed
- Utilize copy_struct_from_user() for better future compatibility
- Add draft man page to cover letter
- Convert -ENOIOCTLCMD to -EOPNOSUPP as more appropriate for syscall
- Add missing __user to header declaration of syscalls
- Link to v3: https://lore.kernel.org/r/20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org

Changes in v3:
- Remove unnecessary "dfd is dir" check as it checked in user_path_at()
- Remove unnecessary "same filesystem" check
- Use CLASS() instead of directly calling fdget/fdput
- Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org

v1:
https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/

Previous discussion:
https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/

---
Andrey Albershteyn (3):
      lsm: introduce new hooks for setting/getting inode fsxattr
      fs: split fileattr/fsxattr converters into helpers
      fs: introduce getfsxattrat and setfsxattrat syscalls

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   2 +
 arch/arm64/tools/syscall_32.tbl             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 fs/inode.c                                  | 130 ++++++++++++++++++++++++++++
 fs/ioctl.c                                  |  39 ++++++---
 include/linux/fileattr.h                    |   2 +
 include/linux/lsm_hook_defs.h               |   4 +
 include/linux/security.h                    |  16 ++++
 include/linux/syscalls.h                    |   6 ++
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/fs.h                     |   3 +
 security/security.c                         |  32 +++++++
 25 files changed, 259 insertions(+), 13 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250114-xattrat-syscall-6a1136d2db59

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>


