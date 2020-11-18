Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231BD2B849A
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKRTSo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgKRTSo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 14:18:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A024C0613D4
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:18:44 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so2053454pfp.5
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MWvx3Ver7VQMAjkIz8yJn/b/DZfGy90gJU2/HV9wyc=;
        b=GwZdwOGUW0dgpNA2dZ61X/ZcHIWrgh8n/MfP1Raf+Xt/pZesKw2hdfYdLqAiGRMKuJ
         Q1xDGpIi0ja5/B6Pv7ccfvJVmuqsSOV5JjlzXJdLOlTih9jEnLpreYmisAAb2i5ab/+4
         42YvY4NU/utzkmcEi8GlqabIgSCKGGrEDdhc8o2suISL9wb4zLlxN6nBKYcA4GF2bgdM
         QKF5EMo/XfGgxnwqcLeh8QDPXAs3dKghDdNUl6B4bAkpqHT6Kz36JcyhVJvJAEkAA8Q7
         J+C9bLLgrzi6Ra1aEZDdxg1TCO12KFjxYAlxjwkBzzfWHL7UO1+lXrXOLjgaIZ2vdb5R
         BJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MWvx3Ver7VQMAjkIz8yJn/b/DZfGy90gJU2/HV9wyc=;
        b=ScM6nKqft9bWhKRRtn8oh7gbkUQ/yxAHJy4//Ws6Oh3edQUI4SjnAtuVb31rhncyfH
         xRVO8nvxnJxOEUjpp0a4SiEcBFN0IIMNq4dz6zYsW1JBfYxjUiRHYfbIPugbOgG7B/Pq
         OEyoQbzFPR2tesFR7S9EpUD0O/t0KAMw1IkdTB8iejcoxTEr29HE3a5mfgagPN3Sl7kq
         H7cDKpKkMQ0FYx9FgL1y0PQl8Va/kp1TVR+ioB3gCSkDTl3Es8jBnOP/uiHwuMtn5Y6w
         SyDNyqTi2wpbb0wkctJWEsRj1Fb2Y9WOx3BTFGPDjMWtKF7k07sYVVYhw6bVwsuywmK+
         U8ew==
X-Gm-Message-State: AOAM5322DYclSqCnipTz/4xju8hKp00/7t+8yvn2SmlaKqayEeUn8Kj7
        O47XYdqzmaSRFPFc0Wr0fVOleQ==
X-Google-Smtp-Source: ABdhPJxzYboN2gIhwKGOa22Ojjf5qoXPudAh6b4IuXJSHFMcz1Po+K8Ms6MPO8ByqmBRoO66I+SqQw==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr515346pjb.174.1605727123777;
        Wed, 18 Nov 2020 11:18:43 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id c22sm19491863pfo.211.2020.11.18.11.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:18:42 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 05/11] btrfs: fix check_data_csum() error message for direct I/O
Date:   Wed, 18 Nov 2020 11:18:12 -0800
Message-Id: <e33db7a6a4f56d0caedfe6a1aad131edca56b340.1605723568.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723568.git.osandov@fb.com>
References: <cover.1605723568.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
check_data_csum()") replaced the start parameter to check_data_csum()
with page_offset(), but page_offset() is not meaningful for direct I/O
pages. Bring back the start parameter.

Fixes: 1dae796aabf6 ("btrfs: inode: sink parameter start and len to check_data_csum()")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index abc0fd162f6c..c5fa1bd3dfe7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2939,11 +2939,12 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
  * @icsum:	checksum index in the io_bio->csum array, size of csum_size
  * @page:	page where is the data to be verified
  * @pgoff:	offset inside the page
+ * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
  */
 static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
-			   int icsum, struct page *page, int pgoff)
+			   int icsum, struct page *page, int pgoff, u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
@@ -2968,8 +2969,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), page_offset(page) + pgoff,
-				    csum, csum_expected, io_bio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
+				    io_bio->mirror_num);
 	if (io_bio->device)
 		btrfs_dev_stat_inc_and_print(io_bio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
@@ -3010,7 +3011,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 	}
 
 	phy_offset >>= root->fs_info->sectorsize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	return check_data_csum(inode, io_bio, phy_offset, page, offset, start);
 }
 
 /*
@@ -7733,7 +7734,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
 			    (!csum || !check_data_csum(inode, io_bio, icsum,
-						       bvec.bv_page, pgoff))) {
+						       bvec.bv_page, pgoff,
+						       start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
 						 start, bvec.bv_page,
 						 btrfs_ino(BTRFS_I(inode)),
-- 
2.29.2

