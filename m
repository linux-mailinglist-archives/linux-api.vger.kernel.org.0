Return-Path: <linux-api+bounces-6025-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENIzEoTlwGl6OQQAu9opvQ
	(envelope-from <linux-api+bounces-6025-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:02:28 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A532ED3A3
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 08:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F96830054C0
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0C35C183;
	Mon, 23 Mar 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YdkQ84WT"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DF231836;
	Mon, 23 Mar 2026 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249345; cv=none; b=MG6WPbDJ6jDC+bV/iSAS14epfUdfH8nBydGJxM7K41rVI6Cq+avTgo1cBXxRxo8sHg0cg6WZsW83ihRznmTzWn/dW8GFueLhMAyy2xCI3trxPQmJmQ7wSNUrB+KeN3tS3CyZD/unjyP5wzRHVSXvle5mEhaeakU1pJW/GiSrtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249345; c=relaxed/simple;
	bh=chqLyxWYqhdnxZRDugjkOaEmCQGgsxb0JuWCztHU8B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0JCuRzUevQKQmPkGhAGK7VRjZqd+PKlXpbmoNwK/QIIMoxKUp1lTz0ULmcNvEEjHxIFbf/+V66TaS4KA4lMy3lHLEl8RTVhtWI1CIDUCfY7RN/XIw+QrSp+rdWmYsJKUvnDqrcIwRYmVZOKDUjc0Rqju3p0QdylJhNZpTlP6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YdkQ84WT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K4orJb2U7jo77rJOM/60B2idHYzibFtexOIXEJjzLmY=; b=YdkQ84WTBNdlag+U1IP4PCep8i
	Px0qdWy9rfMDEzJnnG/DvDXj1xVgKt1CHjjpnz07nUKX9y5fBx/xS6CMPoH79C2gJC9kt0apBdeAU
	0bRmYOmF6PEgyZCRpz//N12NFmjSof1H35Nir05Dp9vCf0imRSWdgX+sqiEn1QimU07Y35BtUqqPz
	Aci6mUH0QMnOnnS5Ns6iWFVBWfmzHkZnbtjHoPWzca4kxS3t6wEoAYfNsPj0+IyllEdBC2Pqt9hmx
	zSb46hWvGaVYH8DdsA37I61Ice/zkXSKiIRL7O48zKvr52WQrAEDlAiHMCjN4IZ3vW5wozbgmAQTk
	6JyrsbPQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZIt-0000000G9jb-03ST;
	Mon, 23 Mar 2026 07:02:23 +0000
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
Subject: [PATCH 2/3] fs: pass on FTRUNCATE_* flags to do_truncate
Date: Mon, 23 Mar 2026 08:01:45 +0100
Message-ID: <20260323070205.2939118-3-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6025-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 29A532ED3A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pass the flags one level down to replace the somewhat confusing small
argument, and clean up do_truncate as a result.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h       |  2 +-
 fs/open.c           | 22 ++++++++++------------
 io_uring/truncate.c |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 2663823e273a..52e4c354e7a4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -198,7 +198,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
 
-int do_ftruncate(struct file *file, loff_t length, int small);
+int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
diff --git a/fs/open.c b/fs/open.c
index 412d0d6fbaa7..181c1597e73c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -161,23 +161,21 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 }
 #endif
 
-int do_ftruncate(struct file *file, loff_t length, int small)
+int do_ftruncate(struct file *file, loff_t length, unsigned int flags)
 {
-	struct inode *inode;
-	struct dentry *dentry;
+	struct dentry *dentry = file->f_path.dentry;
+	struct inode *inode = dentry->d_inode;
 	int error;
 
-	/* explicitly opened as large or we are on 64-bit box */
-	if (file->f_flags & O_LARGEFILE)
-		small = 0;
-
-	dentry = file->f_path.dentry;
-	inode = dentry->d_inode;
 	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
 		return -EINVAL;
 
-	/* Cannot ftruncate over 2^31 bytes without large file support */
-	if (small && length > MAX_NON_LFS)
+	/*
+	 * Cannot ftruncate over 2^31 bytes without large file support, either
+	 * through opening with O_LARGEFILE or by using ftruncate64().
+	 */
+	if (length > MAX_NON_LFS &&
+	    !(file->f_flags & O_LARGEFILE) && !(flags & FTRUNCATE_LFS))
 		return -EINVAL;
 
 	/* Check IS_APPEND on real upper inode */
@@ -205,7 +203,7 @@ int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags)
 	if (fd_empty(f))
 		return -EBADF;
 
-	return do_ftruncate(fd_file(f), length, !(flags & FTRUNCATE_LFS));
+	return do_ftruncate(fd_file(f), length, flags);
 }
 
 SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
diff --git a/io_uring/truncate.c b/io_uring/truncate.c
index 487baf23b44e..c88d8bd8d20e 100644
--- a/io_uring/truncate.c
+++ b/io_uring/truncate.c
@@ -41,7 +41,7 @@ int io_ftruncate(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = do_ftruncate(req->file, ft->len, 1);
+	ret = do_ftruncate(req->file, ft->len, 0);
 
 	io_req_set_res(req, ret, 0);
 	return IOU_COMPLETE;
-- 
2.47.3


