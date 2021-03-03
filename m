Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C132C674
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355475AbhCDA2y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:54 -0500
Received: from mx4.veeam.com ([104.41.138.86]:53888 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhCCNFF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 08:05:05 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 488D8114A96;
        Wed,  3 Mar 2021 15:30:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1614774643; bh=d/8zCRYtc8qXQVDCMasHDlNURXwuj37o4RUMhtXmscA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZWhpw4MstUM6lU5R2JIjR56OjdoScQ8HkEvQEeYLkWc23H2XvVPi8K2NXQnFV01yV
         CTmUJ3IUZkJ0GIferUy9rBu1tBNliTIv/wv+ztapX+klkR9CLv1TnbOJbp+dznsMFh
         7Cz/3+49DMvVwZfVfrNdjEvMB+l6wsZ9tu1MTRWM=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Mar 2021 13:30:41 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <hare@suse.de>,
        <song@kernel.org>, <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v6 2/4] block: add blk_interposer
Date:   Wed, 3 Mar 2021 15:30:16 +0300
Message-ID: <1614774618-22410-3-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265637363
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

blk_interposer allows to intercept bio requests, remap bio
to another devices or add new bios.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/bio.c               |  2 +
 block/blk-core.c          | 36 +++++++++++++++
 block/genhd.c             | 93 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  4 ++
 include/linux/blkdev.h    | 17 +++++++
 5 files changed, 152 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a..0bfbf06475ee 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -640,6 +640,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 		bio_set_flag(bio, BIO_THROTTLED);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
+	if (bio_flagged(bio_src, BIO_INTERPOSED))
+		bio_set_flag(bio, BIO_INTERPOSED);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..e749507cadd3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1018,6 +1018,34 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 	return ret;
 }
 
+static blk_qc_t __submit_bio_interposed(struct bio *bio)
+{
+	struct bio_list bio_list[2] = { };
+	blk_qc_t ret = BLK_QC_T_NONE;
+
+	current->bio_list = bio_list;
+	if (likely(bio_queue_enter(bio) == 0)) {
+		struct block_device *bdev = bio->bi_bdev;
+
+		if (likely(bdev_has_interposer(bdev))) {
+			bio_set_flag(bio, BIO_INTERPOSED);
+			bdev->bd_interposer->ip_submit_bio(bio);
+		} else {
+			/* interposer was removed */
+			bio_list_add(&current->bio_list[0], bio);
+		}
+
+		blk_queue_exit(bdev->bd_disk->queue);
+	}
+	current->bio_list = NULL;
+
+	/* Resubmit remaining bios */
+	while ((bio = bio_list_pop(&bio_list[0])))
+		ret = submit_bio_noacct(bio);
+
+	return ret;
+}
+
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
@@ -1043,6 +1071,14 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
 		return BLK_QC_T_NONE;
 	}
 
+	/*
+	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
+	 * created by the bdev_interposer do not get to it for processing.
+	 */
+	if (bdev_has_interposer(bio->bi_bdev) &&
+	    !bio_flagged(bio, BIO_INTERPOSED))
+		return __submit_bio_interposed(bio);
+
 	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
 		return __submit_bio_noacct_mq(bio);
 	return __submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index fcc530164b5a..1ae8516643c8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -30,6 +30,11 @@
 static struct kobject *block_depr;
 
 DECLARE_RWSEM(bdev_lookup_sem);
+/*
+ * Prevents different block-layer interposers from attaching or detaching
+ * to the block device at the same time.
+ */
+DEFINE_MUTEX(bdev_interposer_attach_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
@@ -1941,3 +1946,91 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+/**
+ * bdev_interposer_attach - Attach interposer to block device
+ * @bdev: target block device
+ * @interposer: block device interposer
+ * @ip_submit_bio: hook for submit_bio()
+ *
+ * Returns:
+ *     -EINVAL if @interposer is NULL.
+ *     -EPERM if queue is not frozen.
+ *     -EBUSY if the block device already has @interposer.
+ *     -EALREADY if the block device already has @interposer with same callback.
+ *     -ENODEV if the block device cannot be referenced.
+ *
+ * Disk must be frozen by blk_mq_freeze_queue().
+ */
+int bdev_interposer_attach(struct block_device *bdev, struct bdev_interposer *interposer,
+			  const ip_submit_bio_t ip_submit_bio)
+{
+	int ret = 0;
+
+	if (WARN_ON(!interposer))
+		return -EINVAL;
+
+	if (!blk_mq_is_queue_frozen(bdev->bd_disk->queue))
+		return -EPERM;
+
+	mutex_lock(&bdev_interposer_attach_lock);
+	if (bdev_has_interposer(bdev)) {
+		if (bdev->bd_interposer->ip_submit_bio == ip_submit_bio)
+			ret = -EALREADY;
+		else
+			ret = -EBUSY;
+		goto out;
+	}
+
+	interposer->ip_submit_bio = ip_submit_bio;
+
+	interposer->bdev = bdgrab(bdev);
+	if (!interposer->bdev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	bdev->bd_interposer = interposer;
+out:
+	mutex_unlock(&bdev_interposer_attach_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bdev_interposer_attach);
+
+/**
+ * bdev_interposer_detach - Detach interposer from block device
+ * @interposer: block device interposer
+ * @ip_submit_bio: hook for submit_bio()
+ *
+ * Disk must be frozen by blk_mq_freeze_queue().
+ */
+void bdev_interposer_detach(struct bdev_interposer *interposer,
+			  const ip_submit_bio_t ip_submit_bio)
+{
+	struct block_device *bdev;
+
+	if (WARN_ON(!interposer))
+		return;
+
+	mutex_lock(&bdev_interposer_attach_lock);
+
+	/* Check if the interposer is still active. */
+	bdev = interposer->bdev;
+	if (WARN_ON(!bdev))
+		goto out;
+
+	if (WARN_ON(!blk_mq_is_queue_frozen(bdev->bd_disk->queue)))
+		goto out;
+
+	/* Check if it is really our interposer. */
+	if (WARN_ON(bdev->bd_interposer->ip_submit_bio != ip_submit_bio))
+		goto out;
+
+	bdev->bd_interposer = NULL;
+	interposer->bdev = NULL;
+	bdput(bdev);
+out:
+	mutex_unlock(&bdev_interposer_attach_lock);
+}
+EXPORT_SYMBOL_GPL(bdev_interposer_detach);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..2b43f65bb356 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -19,6 +19,7 @@ struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
+struct bdev_interposer;
 
 struct block_device {
 	sector_t		bd_start_sect;
@@ -46,6 +47,7 @@ struct block_device {
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
+	struct bdev_interposer * bd_interposer;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
@@ -304,6 +306,8 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_INTERPOSED,		/* bio has been interposed and can be moved to
+				 * a different block device */
 	BIO_FLAG_LAST
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c032cfe133c7..82f8515fa3c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2033,4 +2033,21 @@ int fsync_bdev(struct block_device *bdev);
 int freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev);
 
+/*
+ * block layer interposers structure and functions
+ */
+typedef void (*ip_submit_bio_t) (struct bio *bio);
+
+struct bdev_interposer {
+	ip_submit_bio_t ip_submit_bio;
+	struct block_device *bdev;
+};
+
+#define bdev_has_interposer(bd) ((bd)->bd_interposer != NULL)
+
+int bdev_interposer_attach(struct block_device *bdev, struct bdev_interposer *interposer,
+			   const ip_submit_bio_t ip_submit_bio);
+void bdev_interposer_detach(struct bdev_interposer *interposer,
+			    const ip_submit_bio_t ip_submit_bio);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.20.1

