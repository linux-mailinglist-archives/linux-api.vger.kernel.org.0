Return-Path: <linux-api+bounces-6026-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFumEbXlwGl6OQQAu9opvQ
	(envelope-from <linux-api+bounces-6026-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:03:17 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC492ED40E
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F17A301E3E0
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9323446CA;
	Mon, 23 Mar 2026 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TRdqtC3V"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCA223DCE;
	Mon, 23 Mar 2026 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249351; cv=none; b=QXbNC42fIUnvk54oiDKcGlueC8iHm8i9ZKQiiqKQ0C+HGHCtkDbWfYVMPZbyw4nzjbL95113bskw17gGG6LkvgSdzsG0o9UScDUX6vWsV2gt10re6ItvADDSdwGqVIiNQrykcu6kZZLtPkGt7b1rwpmzwXzFYvv4iVzRekZewQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249351; c=relaxed/simple;
	bh=EatjSQw4+B5pP/iKZyBLC7kKTvA5t+96nriL2cudrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWbI7/rWol5zyC++nWZfGTDPdXrVJHRGhRrWGLh5M3/rQE0gUdrSMRHurSPjK/DHBTJS/DNgwejhZtzDlvrLl+7LgSXXKw87YPCKPycu3FVSJlPHaXRFu5bztYhKFjU9FHLBmVP72ZGgnIADOfD4+zhyOuDKb5Cy6UHysXddv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TRdqtC3V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wlkrm0myB9P5DBDaclzihXCLak0GcKolkRDqx8ZruQ0=; b=TRdqtC3V4JFkKzclMhRAwPhHvy
	haVphzi2M7zk2uFS2hNi2cvsdo3KRHQNhivSBcXRnQY04c/UZFTQUTWRBCRGlYddGLskEQJv3Y+62
	SDFsbVLO+EL5tXadw1l46vFGdvKD9ppMVDE/hUbqjPRgrSFgAcAWkNETxhTUOlzZz9cuyrHZU9svb
	+kW/i3TienruQ8EuClSUwk/Y+uSNWjzooEsCpDUbTCywABz1EyUkpWPW3kxAyRx3/MCoQfpRUNwzs
	vhXUJmOuK5THFvsbqDy0IQ/jjLSkS0FvtgFwEY30dC0kyDFHrH8AkLvYUqfmJUz0Zd3bfW+Njpl7X
	r2vG4dnA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIz-0000000G9lB-1wml;
	Mon, 23 Mar 2026 07:02:30 +0000
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
Subject: [PATCH 3/3] fs: remove do_sys_truncate
Date: Mon, 23 Mar 2026 08:01:46 +0100
Message-ID: <20260323070205.2939118-4-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-6026-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEC492ED40E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

do_sys_truncate ist only used to implement ksys_truncate and the native
truncate syscalls.  Merge do_sys_truncate into ksys_truncate and return
int from it as it only returns 0 or negative errnos.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 8 ++++----
 include/linux/syscalls.h | 8 +-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 181c1597e73c..681d405bc61e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -126,7 +126,7 @@ int vfs_truncate(const struct path *path, loff_t length)
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
 
-int do_sys_truncate(const char __user *pathname, loff_t length)
+int ksys_truncate(const char __user *pathname, loff_t length)
 {
 	unsigned int lookup_flags = LOOKUP_FOLLOW;
 	struct path path;
@@ -151,13 +151,13 @@ int do_sys_truncate(const char __user *pathname, loff_t length)
 
 SYSCALL_DEFINE2(truncate, const char __user *, path, long, length)
 {
-	return do_sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length)
 {
-	return do_sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 #endif
 
@@ -222,7 +222,7 @@ COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
 #if BITS_PER_LONG == 32
 SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
 {
-	return do_sys_truncate(path, length);
+	return ksys_truncate(path, length);
 }
 
 SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8787b3511c86..f5639d5ac331 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1285,13 +1285,7 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
 
 #define FTRUNCATE_LFS	(1u << 0)	/* allow truncating > 32-bit */
 int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags);
-
-int do_sys_truncate(const char __user *pathname, loff_t length);
-
-static inline long ksys_truncate(const char __user *pathname, loff_t length)
-{
-	return do_sys_truncate(pathname, length);
-}
+int ksys_truncate(const char __user *pathname, loff_t length);
 
 static inline unsigned int ksys_personality(unsigned int personality)
 {
-- 
2.47.3


