Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7213A3498B
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfFDN4p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 09:56:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37157 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDN4o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 09:56:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id h1so15951087wro.4;
        Tue, 04 Jun 2019 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6PI4syosh7EfSJTic+zCwLA0ox1LN6buatDn+DnYF7s=;
        b=QvQv/x7CcuqCg//VbtrW7YqPtveZoOlQGwlm4LncCJJhPsJO4PC1G+8tTLWPz63kcN
         xkVqcq1vC6rnvGeHUI56T5ChVNfgRrEqQMxtpC8towmWJ+qnUe8L77yDFLyOQG5msK2B
         K48JkLH7DXghs+7hsWbdE2zwiP1zf3W5qw6b7kbNpKNbLynkrcTV+0z6d7iH3bFCRPp8
         PR0lshHsOubwt7nDU1q33jj6rb4JC/LYuF7tVUMzsDbI497HYhmjnSrxO8WyPcsTP64j
         BhpMekRyuzGeuw+MYQMNOl84QiKl26sO0BR/fBVfar5XEdWOmWHZQE2B5bxwrI+qI52o
         LsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6PI4syosh7EfSJTic+zCwLA0ox1LN6buatDn+DnYF7s=;
        b=N+zGSaxmODMX2IoSIFPITTxvHLv8UTySm1ER5ePExLcuQDEe04Yf8a9xj85VQ100xx
         IS6m2sFzP0fDpzvxSaDQnowq9Wpp1L9vSAaprcjvvssM33foEqfjFAmgZ4qgm5aY0Znq
         6OVThyD6IVQjeTuFp7ErRZzHhEYmUmLAJhv6nkjK0KHchE9h3K8dhFv/IO85seWflcSC
         3wdgejAMYwmlemw+2mDUrB1FwX+ZnkqsKbyXn7AspH1BBTOYcphSD0SMmYNNvYoeGUIw
         NwlIdfZGpufjMTbecOX4yJ9ld6lm0+FJgJuDMeHnCpsQ0c6eUNpEZ9MId5tOYqU2d2F/
         Rf6w==
X-Gm-Message-State: APjAAAV9p1n7vunCJRnKHo1dsSs/1J3jRu9/tjEhKK5fmt9d0N0JT7fs
        VHYhguke5INjGBClT8bDJmMnOniF2uM=
X-Google-Smtp-Source: APXvYqyBKQ2KmHYXHoj5Hp05FKV2Yb9nNXsN1fhgDQ/XLRzRUyqraK1Xt90yL22v1baTEKtw0mICcQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr6337464wro.303.1559656601940;
        Tue, 04 Jun 2019 06:56:41 -0700 (PDT)
Received: from localhost.localdomain (p548C66C4.dip0.t-ipconnect.de. [84.140.102.196])
        by smtp.gmail.com with ESMTPSA id f2sm18282585wrq.48.2019.06.04.06.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:56:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v5 8/9] vfs: allow copy_file_range to copy across devices
Date:   Tue,  4 Jun 2019 16:56:32 +0300
Message-Id: <20190604135632.1487-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We want to enable cross-filesystem copy_file_range functionality
where possible, so push the "same superblock only" checks down to
the individual filesystem callouts so they can make their own
decisions about cross-superblock copy offload and fallack to
generic_copy_file_range() for cross-superblock copy.

[Amir] We do not call ->remap_file_range() in case the files are not
on the same sb and do not call ->copy_file_range() in case the files
do not belong to the same filesystem driver.

This changes behavior of the copy_file_range(2) syscall, which will
now allow cross filesystem in-kernel copy.  CIFS already supports
cross-superblock copy, between two shares to the same server. This
functionality will now be available via the copy_file_range(2) syscall.

Cc: Steve French <stfrench@microsoft.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Darrick,

Per feedback from Olga, I am sending a modified version of this patch
to address cross file_system_type copy issue in nfs.

For the sake of global warming I am not re-posting the entire patch set.
I removed your RVB because of the change.

Thanks,
Amir.

Changes since v4:
- Check "same filesystem driver" by comapring ->copy_file_range()
  function pointer

 fs/ceph/file.c    |  4 +++-
 fs/cifs/cifsfs.c  |  2 +-
 fs/fuse/file.c    |  5 ++++-
 fs/nfs/nfs4file.c |  5 ++++-
 fs/read_write.c   | 18 ++++++++++++------
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e87f7b2023af..4cd41ed5cc53 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 	if (src_inode == dst_inode)
 		return -EINVAL;
+	if (src_inode->i_sb != dst_inode->i_sb)
+		return -EXDEV;
 	if (ceph_snap(dst_inode) != CEPH_NOSNAP)
 		return -EROFS;
 
@@ -2109,7 +2111,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
 
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(src_file, src_off, dst_file,
 					      dst_off, len, flags);
 	return ret;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c65823270313..f11eea6125c1 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1149,7 +1149,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 					len, flags);
 	free_xid(xid);
 
-	if (rc == -EOPNOTSUPP)
+	if (rc == -EOPNOTSUPP || rc == -EXDEV)
 		rc = generic_copy_file_range(src_file, off, dst_file,
 					     destoff, len, flags);
 	return rc;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e03901ae729b..569baf286835 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (fc->no_copy_file_range)
 		return -EOPNOTSUPP;
 
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
+
 	inode_lock(inode_out);
 
 	if (fc->writeback_cache) {
@@ -3182,7 +3185,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
 
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(src_file, src_off, dst_file,
 					      dst_off, len, flags);
 	return ret;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 4842f3ab3161..f4157eb1f69d 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				      struct file *file_out, loff_t pos_out,
 				      size_t count, unsigned int flags)
 {
+	/* Only offload copy if superblock is the same */
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
 	if (file_inode(file_in) == file_inode(file_out))
@@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
 				     flags);
-	if (ret == -EOPNOTSUPP)
+	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = generic_copy_file_range(file_in, pos_in, file_out,
 					      pos_out, count, flags);
 	return ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index cec7e7b1f693..bb594c8f4404 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1599,7 +1599,16 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  size_t len, unsigned int flags)
 {
-	if (file_out->f_op->copy_file_range)
+	/*
+	 * Although we now allow filesystems to handle cross sb copy, passing
+	 * a file of the wrong filesystem type to filesystem driver can result
+	 * in an attempt to dereference the wrong type of ->private_data, so
+	 * avoid doing that until we really have a good reason.
+	 * NFS has several different file_system_type's, but they all end up
+	 * using the same ->copy_file_range() function pointer.
+	 */
+	if (file_out->f_op->copy_file_range &&
+	    file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
 		return file_out->f_op->copy_file_range(file_in, pos_in,
 						       file_out, pos_out,
 						       len, flags);
@@ -1622,10 +1631,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (flags != 0)
 		return -EINVAL;
 
-	/* this could be relaxed once a method supports cross-fs copies */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
-		return -EXDEV;
-
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
 				       flags);
 	if (unlikely(ret))
@@ -1648,7 +1653,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * Try cloning first, this is supported by more file systems, and
 	 * more efficient if both clone and copy are supported (e.g. NFS).
 	 */
-	if (file_in->f_op->remap_file_range) {
+	if (file_in->f_op->remap_file_range &&
+	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
 		loff_t cloned;
 
 		cloned = file_in->f_op->remap_file_range(file_in, pos_in,
-- 
2.17.1

