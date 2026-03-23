Return-Path: <linux-api+bounces-6024-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHV1HY/lwGl5OQQAu9opvQ
	(envelope-from <linux-api+bounces-6024-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:02:39 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB732ED3CC
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25F16301F9FD
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5EC2FFF90;
	Mon, 23 Mar 2026 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XA0Trzs5"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A34223DCE;
	Mon, 23 Mar 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249339; cv=none; b=HxiAUvrQKdK47vhnxOD6DFATXGVnZAlwsxLUOaAnx7fCdnb5qrQwIIF5HOEd6IZZykbT0V5GxCh3fOc7kFy6sfgzIiAvhcTfxenUXu7dwHO/1zLvfwQpNoiC1Do7LzCN04squ2dcnH++2F8VXIxbAlfHZ7DodTA4jzxIXYcc88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249339; c=relaxed/simple;
	bh=s2ZO+V1VNwkKoUgHbpFADUh+GlqftqdkuU8gDC4oedQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5jg3xyobWtTuP00OvrralUhC+V/LmEsubBbN38hFuoc1aMjdrs2RT9ESkjnR38Jm2qkGCcq+ykNRIi+IoHDdAOGMwkHYfURXYSmA19uIFmX8faB5l6uvO+rSQJfGlfGdHUtxWhquJfrdVcvscTpe6gR2XW07CNC9RHGo5ttFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XA0Trzs5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Jo+hJi6UycCRcr/98mKLuq4pm1gn//akJmcNAXefkcE=; b=XA0Trzs5mVR15PMgnchHaRx7FW
	4o/k8ghGv0dyuIlwda7dxhFmCBtsC1O8gVkDkvjVG/c5+NEJOudYXtSTePTmGKu9kGuqb2jCvs30D
	M0hxv6ABP/OFZjhHFt3zZhRQbL5IIh6nni2aYxmis3vN1hFaAt9CMrCdDin5bboAlm/tE/1yoeeun
	nTWLawiIjKzj3UCMi9MTizPH+46cXusrbh+dGxMsE49Klyv+nqTrz9XDCBTi4bNaJi+JyksQqcwpw
	80sFQeuvebbx3y51M8T0LfDyVqaogWw4Rl62X3AILMyCQkXYLEhJcGNohYcxuh+4Jz2oEQ/RhNtPF
	BvWnRvuQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIn-0000000G9io-0IQy;
	Mon, 23 Mar 2026 07:02:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 1/3] fs: fix archiecture-specific compat_ftruncate64
Date: Mon, 23 Mar 2026 08:01:44 +0100
Message-ID: <20260323070205.2939118-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070205.2939118-1-hch@lst.de>
References: <20260323070205.2939118-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6024-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-api@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: EFB732ED3CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The "small" argument to do_sys_ftruncate indicates if > 32-bit size
should be reject, but all the arch-specific compat ftruncate64
implementations get this wrong.  Merge do_sys_ftruncate and
ksys_ftruncate, replace the integer as boolean small flag with a
descriptive one about LFS semantics, and use it correctly in the
architecture-specific ftruncate64 implementations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 3dd681d944f6 ("arm64: 32-bit (compat) applications support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/kernel/sys32.c       |  2 +-
 arch/mips/kernel/linux32.c      |  2 +-
 arch/parisc/kernel/sys_parisc.c |  4 ++--
 arch/powerpc/kernel/sys_ppc32.c |  2 +-
 arch/sparc/kernel/sys_sparc32.c |  2 +-
 arch/x86/kernel/sys_ia32.c      |  3 ++-
 fs/internal.h                   |  1 -
 fs/open.c                       | 12 ++++++------
 include/linux/syscalls.h        |  8 ++------
 9 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 96bcfb907443..12a948f3a504 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -89,7 +89,7 @@ COMPAT_SYSCALL_DEFINE4(aarch32_truncate64, const char __user *, pathname,
 COMPAT_SYSCALL_DEFINE4(aarch32_ftruncate64, unsigned int, fd, u32, __pad,
 		       arg_u32p(length))
 {
-	return ksys_ftruncate(fd, arg_u64(length));
+	return ksys_ftruncate(fd, arg_u64(length), FTRUNCATE_LFS);
 }
 
 COMPAT_SYSCALL_DEFINE5(aarch32_readahead, int, fd, u32, __pad,
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index a0c0a7a654e9..fe9a787db569 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -60,7 +60,7 @@ SYSCALL_DEFINE4(32_truncate64, const char __user *, path,
 SYSCALL_DEFINE4(32_ftruncate64, unsigned long, fd, unsigned long, __dummy,
 	unsigned long, a2, unsigned long, a3)
 {
-	return ksys_ftruncate(fd, merge_64(a2, a3));
+	return ksys_ftruncate(fd, merge_64(a2, a3), FTRUNCATE_LFS);
 }
 
 SYSCALL_DEFINE5(32_llseek, unsigned int, fd, unsigned int, offset_high,
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index b2cdbb8a12b1..fcb0d8069139 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -216,7 +216,7 @@ asmlinkage long parisc_truncate64(const char __user * path,
 asmlinkage long parisc_ftruncate64(unsigned int fd,
 					unsigned int high, unsigned int low)
 {
-	return ksys_ftruncate(fd, (long)high << 32 | low);
+	return ksys_ftruncate(fd, (long)high << 32 | low, FTRUNCATE_LFS);
 }
 
 /* stubs for the benefit of the syscall_table since truncate64 and truncate 
@@ -227,7 +227,7 @@ asmlinkage long sys_truncate64(const char __user * path, unsigned long length)
 }
 asmlinkage long sys_ftruncate64(unsigned int fd, unsigned long length)
 {
-	return ksys_ftruncate(fd, length);
+	return ksys_ftruncate(fd, length, FTRUNCATE_LFS);
 }
 asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index d451a8229223..03fa487f2614 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -101,7 +101,7 @@ PPC32_SYSCALL_DEFINE4(ppc_ftruncate64,
 		       unsigned int, fd, u32, reg4,
 		       unsigned long, len1, unsigned long, len2)
 {
-	return ksys_ftruncate(fd, merge_64(len1, len2));
+	return ksys_ftruncate(fd, merge_64(len1, len2), FTRUNCATE_LFS);
 }
 
 PPC32_SYSCALL_DEFINE6(ppc32_fadvise64,
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index f84a02ab6bf9..04432b82b9e3 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -58,7 +58,7 @@ COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, path, u32, high, u32, lo
 
 COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, u32, high, u32, low)
 {
-	return ksys_ftruncate(fd, ((u64)high << 32) | low);
+	return ksys_ftruncate(fd, ((u64)high << 32) | low, FTRUNCATE_LFS);
 }
 
 static int cp_compat_stat64(struct kstat *stat,
diff --git a/arch/x86/kernel/sys_ia32.c b/arch/x86/kernel/sys_ia32.c
index 6cf65397d225..610a1c2f4519 100644
--- a/arch/x86/kernel/sys_ia32.c
+++ b/arch/x86/kernel/sys_ia32.c
@@ -61,7 +61,8 @@ SYSCALL_DEFINE3(ia32_truncate64, const char __user *, filename,
 SYSCALL_DEFINE3(ia32_ftruncate64, unsigned int, fd,
 		unsigned long, offset_low, unsigned long, offset_high)
 {
-	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
+	return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low,
+			FTRUNCATE_LFS);
 }
 
 /* warning: next two assume little endian */
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..2663823e273a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -199,7 +199,6 @@ extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
 
 int do_ftruncate(struct file *file, loff_t length, int small);
-int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..412d0d6fbaa7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -197,7 +197,7 @@ int do_ftruncate(struct file *file, loff_t length, int small)
 				   ATTR_MTIME | ATTR_CTIME, file);
 }
 
-int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags)
 {
 	if (length < 0)
 		return -EINVAL;
@@ -205,18 +205,18 @@ int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (fd_empty(f))
 		return -EBADF;
 
-	return do_ftruncate(fd_file(f), length, small);
+	return do_ftruncate(fd_file(f), length, !(flags & FTRUNCATE_LFS));
 }
 
 SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
 {
-	return do_sys_ftruncate(fd, length, 1);
+	return ksys_ftruncate(fd, length, 0);
 }
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
 {
-	return do_sys_ftruncate(fd, length, 1);
+	return ksys_ftruncate(fd, length, 0);
 }
 #endif
 
@@ -229,7 +229,7 @@ SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
 
 SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
 {
-	return do_sys_ftruncate(fd, length, 0);
+	return ksys_ftruncate(fd, length, FTRUNCATE_LFS);
 }
 #endif /* BITS_PER_LONG == 32 */
 
@@ -245,7 +245,7 @@ COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, pathname,
 COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd,
 		       compat_arg_u64_dual(length))
 {
-	return ksys_ftruncate(fd, compat_arg_u64_glue(length));
+	return ksys_ftruncate(fd, compat_arg_u64_glue(length), FTRUNCATE_LFS);
 }
 #endif
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 02bd6ddb6278..8787b3511c86 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1283,12 +1283,8 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 			     AT_SYMLINK_NOFOLLOW);
 }
 
-int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
-
-static inline long ksys_ftruncate(unsigned int fd, loff_t length)
-{
-	return do_sys_ftruncate(fd, length, 1);
-}
+#define FTRUNCATE_LFS	(1u << 0)	/* allow truncating > 32-bit */
+int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags);
 
 int do_sys_truncate(const char __user *pathname, loff_t length);
 
-- 
2.47.3


