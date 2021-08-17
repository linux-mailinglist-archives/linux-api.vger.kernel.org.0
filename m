Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5E3EF469
	for <lists+linux-api@lfdr.de>; Tue, 17 Aug 2021 23:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhHQVH4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Aug 2021 17:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhHQVHy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Aug 2021 17:07:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B9C0613C1
        for <linux-api@vger.kernel.org>; Tue, 17 Aug 2021 14:07:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7404095pjn.4
        for <linux-api@vger.kernel.org>; Tue, 17 Aug 2021 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbBvvX5k5czDYNia7zp5QiKi3YssyFkDzzsumk6vQEA=;
        b=cQbtfcoYK+k1vTQwR5LVreanc4ofzDWjGcG3kxd4xtqsTOR5i8tj4A3lR4MxuEZrn3
         lIXSOQG/g7iDXA/RyiVn0hFS876160HEiQmcHmx7z9FkmxL33OzKCB9UYcU6+PKCalqK
         uJQtJ0UE27Nnfz31A/d+dIS94C3OiVKwZXhTTYWobJKjfJI+nxONb0GQ6ghl/rLi6HIU
         kWIjOztXNi00UliG66AUyEyEE5oSNRMLhV7ZvhsL+uybym9npsaaRSQh2Cz56jpzTQYs
         PTD5334J9m0dtLit3dWE7DZl/CaGMokAAIku/TfFLB720s2oJ0ZDIic6tBjd2PWoi5Kg
         DkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbBvvX5k5czDYNia7zp5QiKi3YssyFkDzzsumk6vQEA=;
        b=X30y4uKxHv8+PCSgYSWxmOTrte0UYlZV5PhIvWKhJn1S8GzW2p8NQHXo58Z6vi0m4X
         1ZwJJwBb2GTUPiX/doZWxsatL4yn7AKQfe1S/nyVHRFRIHv/Pn2Kwbblwdw6dK2EIjsL
         1oAaROMIjM0ZsTDKUWxv7pZ8UmafEeL5JTI8SBJ5URoeggqAVTy6iwoa3P8TtBiPDU/J
         cc871SiV0hfMYl6shT3FdPt0j7mise5e8SK7ni0wFjBnU9TN1x3phzL7L/l6ovWbvdN3
         JV1OJAyBfth2qshC1LTA2O8/YTraV72ONpgUtRVM1dFufWaD61Wpn1safesSqAkzsujt
         jcmw==
X-Gm-Message-State: AOAM533yaIligCBQaUiOsH8IA0amScjYGeOHf9bzcz7+hF78BXJQhBYB
        84XnQgiDL+cfP03KAIxLcqBNdA==
X-Google-Smtp-Source: ABdhPJzuV1OZwdv1hzx2x+7U80/YmmDNKQl/YwBddbDCRJmkqWr6F+NKR+ckKp6J7/L7junlIAtr/w==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr5198319pgp.377.1629234440459;
        Tue, 17 Aug 2021 14:07:20 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 05/14] btrfs: support different disk extent size for delalloc
Date:   Tue, 17 Aug 2021 14:06:37 -0700
Message-Id: <9331034778b6ea3fba90ca4d053aafa3c86c4b49.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, we always reserve the same extent size in the file and extent
size on disk for delalloc because the former is the worst case for the
latter. For RWF_ENCODED writes, we know the exact size of the extent on
disk, which may be less than or greater than (for bookends) the size in
the file. Add a disk_num_bytes parameter to
btrfs_delalloc_reserve_metadata() so that we can reserve the correct
amount of csum bytes. No functional change.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h          |  3 ++-
 fs/btrfs/delalloc-space.c | 18 ++++++++++--------
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/relocation.c     |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index be245b4b8efe..973616d80080 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2798,7 +2798,8 @@ void btrfs_subvolume_release_metadata(struct btrfs_root *root,
 				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 2059d1504149..143650004991 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -267,11 +267,11 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 }
 
 static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
-				    u64 num_bytes, u64 *meta_reserve,
-				    u64 *qgroup_reserve)
+				    u64 num_bytes, u64 disk_num_bytes,
+				    u64 *meta_reserve, u64 *qgroup_reserve)
 {
 	u64 nr_extents = count_max_extents(num_bytes);
-	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
+	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, disk_num_bytes);
 	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
 	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
@@ -285,7 +285,8 @@ static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
 	*qgroup_reserve = nr_extents * fs_info->nodesize;
 }
 
-int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
+int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
+				    u64 disk_num_bytes)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -315,6 +316,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -326,8 +328,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	 * everything out and try again, which is bad.  This way we just
 	 * over-reserve slightly, and clean up the mess when we are done.
 	 */
-	calc_inode_reservations(fs_info, num_bytes, &meta_reserve,
-				&qgroup_reserve);
+	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
+				&meta_reserve, &qgroup_reserve);
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		return ret;
@@ -346,7 +348,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	spin_lock(&inode->lock);
 	nr_extents = count_max_extents(num_bytes);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += num_bytes;
+	inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -451,7 +453,7 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 	ret = btrfs_check_data_free_space(inode, reserved, start, len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_delalloc_reserve_metadata(inode, len);
+	ret = btrfs_delalloc_reserve_metadata(inode, len, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space(inode, *reserved, start, len);
 	return ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..6f9cb8baffd2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1741,7 +1741,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					 fs_info->sectorsize);
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-				reserve_bytes);
+						      reserve_bytes,
+						      reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
 				btrfs_free_reserved_data_space(BTRFS_I(inode),
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 67db9d0a79ec..708d8ab098bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5039,7 +5039,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			goto out;
 		}
 	}
-	ret = btrfs_delalloc_reserve_metadata(inode, blocksize);
+	ret = btrfs_delalloc_reserve_metadata(inode, blocksize, blocksize);
 	if (ret < 0) {
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 914d403b4415..42080f0c88ed 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3016,7 +3016,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 
 		/* Reserve metadata for this range */
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len);
+						      clamped_len, clamped_len);
 		if (ret)
 			goto release_page;
 
-- 
2.32.0

