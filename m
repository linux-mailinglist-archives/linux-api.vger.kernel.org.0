Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B032E3B5
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 19:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfE2Rnf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 13:43:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2Rne (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 13:43:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so2360045wrq.12;
        Wed, 29 May 2019 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+W6U4ETnLrYkikxbMk/wh3iIEZoEwtztQ/QLH5NUi74=;
        b=ifWmmDQAHCoqZv+08IMNQwcl3vT3mFrhJwtgx0agF0t1rv94ZjdJ+1/Qz2ZzkxgdRB
         /Y26IvD4wlwQG9KgP9CXtHCTvmJRonYuD82WRCqSW3cVVLKQUSD06tAHq1E4g1bc5WM8
         gJQX28nF2uFE2SQ5owL/3qfbYYlT8++wQSY5mtq7/YeujWf6vskMAhyiT3hdreh/2RU8
         eMgDzSvHQY6YdZUg3117teWUwhTRKSBCJzYnnM08WvqGBtL00+xkBqVhkG2f9H8xZrDF
         C8p8tKwIYlc3zdB2mBorWe4t1CLUi6V2xrJNrDzA8/6PGo+6fki/LBFdp+it0PsRhlMP
         aigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+W6U4ETnLrYkikxbMk/wh3iIEZoEwtztQ/QLH5NUi74=;
        b=WDAWwTxJhOkmdehPyIcikBf1V2AKRPzQEgatP3mc00/wdlMcGCbBc8HD8IsZ+PSm8r
         0uN4WYzodEI3FXH1mnS4LHZ5vQi6B2jiSNvIw7GhJk6mpY4g+8DQZa0iu2nmAub97/4r
         TqIVDvqYK9QkikW/zUnbyv0ck/Csn4ZsIJ7TlWXok/07j7wUzf5Ojf42Lav7hYJsG6P6
         qD8v7sbbq6pTcBqSllA4PPbuWYHU9UBsMbEPzcz4bDugoig0+tWvoZdVQX5n3ldkq+2O
         M/C8cA+9eP9/L3/iSegeH9smYLIW8zNKg5pcWUOzU5vkBRkANallu47IRqfAQhK19FX0
         vAMg==
X-Gm-Message-State: APjAAAVXl5mOeRvssX/Yfm7wNb00zM7kRdW3QcdpZUdNVNzeKi19lVcn
        d0vcVHhjhYDTlmuOU3NY3NU=
X-Google-Smtp-Source: APXvYqxXy6efjOTuKd1UtXyaOx74f+byvZTB6d49G9ysXIZOw2+uyuPsS68sOCEIr723KC7lixtdDw==
X-Received: by 2002:a05:6000:110:: with SMTP id o16mr2703551wrx.200.1559151811898;
        Wed, 29 May 2019 10:43:31 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id k125sm31702wmb.34.2019.05.29.10.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:43:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v3 02/13] vfs: no fallback for ->copy_file_range
Date:   Wed, 29 May 2019 20:43:06 +0300
Message-Id: <20190529174318.22424-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529174318.22424-1-amir73il@gmail.com>
References: <20190529174318.22424-1-amir73il@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that we have generic_copy_file_range(), remove it as a fallback
case when offloads fail. This puts the responsibility for executing
fallbacks on the filesystems that implement ->copy_file_range and
allows us to add operational validity checks to
generic_copy_file_range().

Rework vfs_copy_file_range() to call a new do_copy_file_range()
helper to execute the copying callout, and move calls to
generic_file_copy_range() into filesystem methods where they
currently return failures.

[Amir] overlayfs is not responsible of executing the fallback.
It is the responsibility of the underlying filesystem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ceph/file.c    | 21 ++++++++++++++++++---
 fs/cifs/cifsfs.c  |  4 ++++
 fs/fuse/file.c    | 21 ++++++++++++++++++---
 fs/nfs/nfs4file.c | 20 +++++++++++++++++---
 fs/read_write.c   | 25 ++++++++++++++++---------
 5 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 305daf043eb0..e87f7b2023af 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1889,9 +1889,9 @@ static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
 	return 0;
 }
 
-static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
-				    struct file *dst_file, loff_t dst_off,
-				    size_t len, unsigned int flags)
+static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
+				      struct file *dst_file, loff_t dst_off,
+				      size_t len, unsigned int flags)
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *dst_inode = file_inode(dst_file);
@@ -2100,6 +2100,21 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
+				     len, flags);
+
+	if (ret == -EOPNOTSUPP)
+		ret = generic_copy_file_range(src_file, src_off, dst_file,
+					      dst_off, len, flags);
+	return ret;
+}
+
 const struct file_operations ceph_file_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f5fcd6360056..c65823270313 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1148,6 +1148,10 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 	rc = cifs_file_copychunk_range(xid, src_file, off, dst_file, destoff,
 					len, flags);
 	free_xid(xid);
+
+	if (rc == -EOPNOTSUPP)
+		rc = generic_copy_file_range(src_file, off, dst_file,
+					     destoff, len, flags);
 	return rc;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3959f08279e6..e03901ae729b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3097,9 +3097,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	return err;
 }
 
-static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t len, unsigned int flags)
+static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
 {
 	struct fuse_file *ff_in = file_in->private_data;
 	struct fuse_file *ff_out = file_out->private_data;
@@ -3173,6 +3173,21 @@ static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	return err;
 }
 
+static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
+				     len, flags);
+
+	if (ret == -EOPNOTSUPP)
+		ret = generic_copy_file_range(src_file, src_off, dst_file,
+					      dst_off, len, flags);
+	return ret;
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index cf42a8b939e3..4842f3ab3161 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -129,9 +129,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 }
 
 #ifdef CONFIG_NFS_V4_2
-static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t count, unsigned int flags)
+static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t count, unsigned int flags)
 {
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
@@ -140,6 +140,20 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	return nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
 }
 
+static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t count, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
+				     flags);
+	if (ret == -EOPNOTSUPP)
+		ret = generic_copy_file_range(file_in, pos_in, file_out,
+					      pos_out, count, flags);
+	return ret;
+}
+
 static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 {
 	loff_t ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index 676b02fae589..b63dcb4e4fe9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1595,6 +1595,19 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 }
 EXPORT_SYMBOL(generic_copy_file_range);
 
+static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  size_t len, unsigned int flags)
+{
+	if (file_out->f_op->copy_file_range)
+		return file_out->f_op->copy_file_range(file_in, pos_in,
+						       file_out, pos_out,
+						       len, flags);
+
+	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+				       flags);
+}
+
 /*
  * copy_file_range() differs from regular file read and write in that it
  * specifically allows return partial success.  When it does so is up to
@@ -1655,15 +1668,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		}
 	}
 
-	if (file_out->f_op->copy_file_range) {
-		ret = file_out->f_op->copy_file_range(file_in, pos_in, file_out,
-						      pos_out, len, flags);
-		if (ret != -EOPNOTSUPP)
-			goto done;
-	}
-
-	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				      flags);
+	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+				flags);
+	WARN_ON_ONCE(ret == -EOPNOTSUPP);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
-- 
2.17.1

