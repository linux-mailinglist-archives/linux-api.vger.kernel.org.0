Return-Path: <linux-api+bounces-6038-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKjiCKUOyGl+ggUAu9opvQ
	(envelope-from <linux-api+bounces-6038-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 18:23:49 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DB34F472
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 18:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FD763029798
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037E3A3E97;
	Sat, 28 Mar 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he2Tc3id"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521E34D4CC
	for <linux-api@vger.kernel.org>; Sat, 28 Mar 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718622; cv=none; b=KylDlUFU36juCbmD4eTvK5zSv3G8MVAO+3HJqiRitRv9CiUpGjQpjGDLVWebMWhBrPdKU6Td4cdWLcPZFB+YCu9xshz9L8hHK9O9CuRrFxNxj4JjiVQnypTJFpek92vthN7M3RJuK2mOYEy+Wvpp4HbPxJT/UdOXYV2ln8VWZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718622; c=relaxed/simple;
	bh=WbXqvQhn4qwD4XjOM1f/RolmfvXydvP/QpIVZ5/s984=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQmXL9gWQ/dhqFlvS+w40dRC6gVNdlqMg3Q6l1KC5EEwerNrgwcY/IPds+FsjYp4QMv9dsiN/hbyfn+eHYSOyNXeRvzDZiwSPpRaBTDpKAEfDIw3ejdvQRC0bB3okfhw5mx9UONEgt1MUtoYG1yKy1EHZaLyiR+nXn7tYwQ0OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he2Tc3id; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso1855651a91.0
        for <linux-api@vger.kernel.org>; Sat, 28 Mar 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718621; x=1775323421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=he2Tc3id36N/dNrImAB0FtQFWApWtJHTjZ72YR26i8lE+n/7H96TCzG9qYvHmqk+2e
         uhIK/YFXplWVcKkPvGinoa+vojsICJPfJOCo90pDQcWKUw0bcf9YMhWHaGc6t3aDXzaz
         J0ZN74GIXjZxZ1cHytdCxoivIZe9H2+5LHik+R0ySUgsb7V81/k2KYAcaoJxglkogLHt
         itgBsuq/w5xhyhloX2BJw9loZpXt2izQxnRHpMpCU28qK6a3lsRUy1qiplwSVk2WBqXf
         i+gHVslEVJre6VrlGsJP/g1RxCmDbsoFkhecX6fevPzYq0iINcrs9faBGCP9baFUrKFp
         WCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718621; x=1775323421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=QvvYFTlCaD2xcz+pUREl5/2Yul5Bo3jfVBPVkiX2COoJlhPlhMk6KYkyeXFXp81Jzn
         6dduiyTuYCoUVigGy1VngpbvaDXrnnrvf24MP9wgzMS2Hob7t/EPWCO18j2ZFzLbzQMN
         O3Oz+Er5/N9bHnnrp5Zav0Z2J8vyTkrgfvte9p5mSvSPuEV1uLelE9DK02CIls+MsliM
         MDhCT0JythD+o3F5LdU1NU5zh6Yivwa6IEtrUBo4PBTVk7W2cROF76MqICCQi1gzAbtJ
         CNL2nvk3/2ha+PFj+s1NmudfzLQ2gFSmBMwuaOTEocR+NcHjTO5rrGQUnCvuKwDyOxQz
         jGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSFhybgjh89UuT+RTPoXAm7BvA7osm7AWtIYaZLq5iHhYkd2JY89vfZeSo16OW3+Za4uc8ISoFOTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYJE2m2oH53cydoFS4lfA88WnO9L5WyqnCBONcqO1bZAob7tR
	SgMzXNPnD944gCgzat1FEJYQd/Tz6DYJFD0A47koCUyzpm3U3eEwEkR9
X-Gm-Gg: ATEYQzxe6GIfF4EOjBwCIQvvBWunf6x2HMn8Qc40B7ruOpCeJt3CSGXFF/yX2+sQL4z
	+H/bi8wdVo9NoG3vGSWlnKf6N6H277OIMfns8cXgEz+zprRzWfQk9bgreI5hhXeCJDBj8unPzWi
	6BnZMSr2bLQrHanbaMOWD0vwV/q7ZO6LN9nOZcZ5evXAlqlcVCef59EBN0Mk4/lohVvOk0UJI8q
	EO/e1DSCeNs+8b8utxmU7CHlcXIDmDwdnU993cgpoWySqYqGBiVrr/pFhbKSK5bxqEEzinQDIvc
	KsX5DcXPMBYyKco9S0EpD/W2/qhoZjcWHH7kRgsIsLLx0Yclx3c/dh1Jty9ReXUl1eZIYP2NEFV
	elpBjfrsS5md1Sy7npsN6FhThghjG8odHC3kyoRe+kLZ2kTQnzZBXqD5fereYLUedRkZpaqK4nH
	IC8lTfmwBG0ZQonZqpqRLb84+4OiX/8M/xoVqcBpvy0ErXwfcOuiMVyWY=
X-Received: by 2002:a17:90b:2744:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-35c30094a5amr6635171a91.25.1774718620730;
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
Date: Sat, 28 Mar 2026 23:22:21 +0600
Message-ID: <20260328172314.45807-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6038-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B40DB34F472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

The following filesystems have been tested by building and booting the kernel
x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
regular files can be successfully opened and non-regular files (directory, fifo etc)
return -EFTYPE.
- btrfs
- NFS (loopback)
- SMB (loopback)

Changes in v6:
- OPENAT2_REGULAR stripped from file->f_flags in do_dentry_open so that it doesn't leak in fcntl(fd, F_GETFL)
- BUILD_BUG_ON updated to use VALID_OPENAT2_FLAGS instead of VALID_OPEN_FLAGS in build_open_flags and in fcntl_init
- v5 is at: https://lore.kernel.org/linux-fsdevel/20260307140726.70219-1-dorjoychy111@gmail.com/T/

Changes in v5:
- EFTYPE is already used in BSDs mentioned in commit message
- consistently return -EFTYPE in all filesystems
- v4 is at: https://lore.kernel.org/linux-fsdevel/20260221145915.81749-1-dorjoychy111@gmail.com/T/

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- atomic_open codepaths updated to work properly for OPENAT2_REGULAR
- commit message includes the uapi-group URL
- v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-dorjoychy111@gmail.com/T/

Changes in v3:
- included motivation about O_REGULAR flag in commit message e.g., programs not wanting to be tricked into opening device nodes
- fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
- fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 060000000 to 0100000000
- added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O_* macros from hex to octal
- v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-dorjoychy111@gmail.com/T/

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (4):
  openat2: new OPENAT2_REGULAR flag support
  kselftest/openat2: test for OPENAT2_REGULAR flag
  sparc/fcntl.h: convert O_* flag macros from hex to octal
  mips/fcntl.h: convert O_* flag macros from hex to octal

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
 fs/ceph/file.c                                |  4 ++
 fs/fcntl.c                                    |  4 +-
 fs/gfs2/inode.c                               |  6 +++
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 ++
 fs/open.c                                     |  8 ++--
 fs/smb/client/dir.c                           | 14 ++++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 24 files changed, 131 insertions(+), 35 deletions(-)

-- 
2.53.0


