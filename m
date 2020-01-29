Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A305C14C7C4
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgA2I6y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 03:58:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46101 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgA2I6x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 03:58:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so6196892pll.13
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 00:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6Stw5XLuw1I+mUTM2ZMnaa8NrTgZtVImtXCq57YVRU=;
        b=ZMzGt5XN4m1AHw+McrdZWn7C5olYRkCyQ7yLcnxKyYM1r+2eQPRg4jRkRlfbmYKFxA
         D73YhWnUI5dENpn81lIQgbaiCtU1lvyIdAPEfRUnahalFftjhRd/IaJIOEv+HFCf191t
         GJKEzLB3219sjSC1vLtCF2ZApDiGtAyQYqmKenDmxrEvpCupUIXeWQeVOujglvfo+xHA
         cSuDM/9qQ6tBYbZsS6awnkKoDsmkKVBvn8FkR6cK08b3m7vWZZSkMMs8z+Ls9FOrkUMV
         5w1NtT3bU9/SZph4iRIDsvtTz96WKNLBjFmU236WuUMyjkFWYp03wYtXjSMHFG4NaFFf
         CoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6Stw5XLuw1I+mUTM2ZMnaa8NrTgZtVImtXCq57YVRU=;
        b=j87qrak32Yr8PcYns/2bLyHOJ6yJMjgOI8jvB8DoqW+8LkzzH/nV/73Osuzi/ql6yO
         8k5heqwTUx1PE2BZcY1YVDPj/xva2aJpmjhJoBUoJFp1mSqLMCWYiChi6CDxqeUTyOid
         ZnCvdKbm4FbLe3XVZOZsXPDR7bonlaS4DqozlVHeDzFHvYjuJ/cMzFBr5EyMERXo+4qU
         XeWmPObzdJ+eqSXby3GQ+93KpgE+4VhZ3ZmtK2w5Zubk+MDSo8s7BS2MMoWJvFPadSZO
         lRFUJXdqQBEgN92GzZZbkaCKbSfqVHdAjmqSBiH5HMSOKewhmOMK6EMzthRkltMD9uCJ
         6uOw==
X-Gm-Message-State: APjAAAWE74mM0uNYiJoUgHR9dl1qD/rcF4B0F1y0sROaUbDKknfZbT6q
        ZYTAxuKmhJkObYG6NSAsrHQl5A==
X-Google-Smtp-Source: APXvYqwptKX25lx/YVOU7zX26oowkgR244HvEhw4PcxwqucPMOijWY2xp+umH8w1SYTKCn6L56Q8PA==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr9640223pjo.69.1580288332068;
        Wed, 29 Jan 2020 00:58:52 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s131sm1935932pfs.135.2020.01.29.00.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:58:51 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH v4 4/4] Btrfs: add support for linkat() AT_REPLACE
Date:   Wed, 29 Jan 2020 00:58:34 -0800
Message-Id: <55e3795a385177f13cde7041fe7a5e1644994879.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The implementation is fairly straightforward and looks a lot like
btrfs_rename(). The only tricky bit is that instead of playing games
with the dcache, we simply drop the dentry for it to be instantiated on
the next lookup. This can be improved in the future.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8c9a114f48f6..b489671d1b5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6762,14 +6762,16 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 		      struct dentry *dentry, int flags)
 {
 	struct btrfs_trans_handle *trans = NULL;
+	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
+	struct inode *new_inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 index;
 	int err;
 	int drop_inode = 0;
 
-	if (flags)
+	if (flags & ~AT_LINK_REPLACE)
 		return -EINVAL;
 
 	/* do not allow sys_link's with other subvols of the same device */
@@ -6779,17 +6781,50 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
 		return -EMLINK;
 
+	/* check for collisions, even if the name isn't there */
+	err = btrfs_check_dir_item_collision(root, dir->i_ino,
+					     dentry->d_name.name,
+					     dentry->d_name.len);
+	if (err) {
+		if (err == -EEXIST) {
+			if (WARN_ON(!new_inode))
+				return err;
+		} else {
+			return err;
+		}
+	}
+
+	/*
+	 * we're using link to replace one file with another. Start IO on it now
+	 * so we don't add too much work to the end of the transaction
+	 */
+	if (new_inode && S_ISREG(inode->i_mode) && new_inode->i_size)
+		filemap_flush(inode->i_mapping);
+
 	err = btrfs_set_inode_index(BTRFS_I(dir), &index);
 	if (err)
 		goto fail;
 
 	/*
+	 * For the source:
 	 * 2 items for inode and inode ref
 	 * 2 items for dir items
 	 * 1 item for parent inode
 	 * 1 item for orphan item deletion if O_TMPFILE
+	 *
+	 * For the target:
+	 * 1 for the possible orphan item
+	 * 1 for the dir item
+	 * 1 for the dir index
+	 * 1 for the inode ref
+	 * 1 for the inode
 	 */
-	trans = btrfs_start_transaction(root, inode->i_nlink ? 5 : 6);
+	trans_num_items = 5;
+	if (!inode->i_nlink)
+		trans_num_items++;
+	if (new_inode)
+		trans_num_items += 5;
+	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		trans = NULL;
@@ -6801,6 +6836,22 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	inc_nlink(inode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
+
+	if (new_inode) {
+		inode_inc_iversion(new_inode);
+		new_inode->i_ctime = current_time(new_inode);
+		err = btrfs_unlink_inode(trans, root, BTRFS_I(dir),
+					 BTRFS_I(new_inode),
+					 dentry->d_name.name,
+					 dentry->d_name.len);
+		if (!err && new_inode->i_nlink == 0)
+			err = btrfs_orphan_add(trans, BTRFS_I(new_inode));
+		if (err) {
+			btrfs_abort_transaction(trans, err);
+			goto fail;
+		}
+	}
+
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
@@ -6824,8 +6875,12 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 			if (err)
 				goto fail;
 		}
-		ihold(inode);
-		d_instantiate(dentry, inode);
+		if (new_inode) {
+			d_drop(dentry);
+		} else {
+			ihold(inode);
+			d_instantiate(dentry, inode);
+		}
 		ret = btrfs_log_new_name(trans, BTRFS_I(inode), NULL, parent,
 					 true, NULL);
 		if (ret == BTRFS_NEED_TRANS_COMMIT) {
-- 
2.25.0

