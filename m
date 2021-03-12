Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB57A33921C
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 16:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhCLPpl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Mar 2021 10:45:41 -0500
Received: from mx4.veeam.com ([104.41.138.86]:50032 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhCLPpX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 12 Mar 2021 10:45:23 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 741A9874F3;
        Fri, 12 Mar 2021 18:45:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615563919; bh=ZsS9OaFDK0F73QmlFcb2IgsRKU3DBf+S0NM5uzcqHR0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dMYiXSmfV8U0INVNZkEnHxS0D6qqWRjuUbs/GKZLMo94CpQMN53kd3NFvqQ1ttdZg
         HN2Y1unepikb3wRQaXOqEvgyMI7C8Zzgsv9xjQVr/vbd6BmVlvqdFO0OIn8kRDHCa+
         Bn7oW8WTJZdJTcyYq0zZGm9h2Ul1mS0r8tg1DWzM=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 12 Mar 2021 16:45:17 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v7 2/3] block: add bdev_interposer
Date:   Fri, 12 Mar 2021 18:44:54 +0300
Message-ID: <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627366
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

bdev_interposer allows to redirect bio requests to another devices.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/bio.c               |  2 ++
 block/blk-core.c          | 57 +++++++++++++++++++++++++++++++++++++++
 block/genhd.c             | 54 +++++++++++++++++++++++++++++++++++++
 include/linux/blk_types.h |  3 +++
 include/linux/blkdev.h    |  9 +++++++
 5 files changed, 125 insertions(+)

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
index fc60ff208497..da1abc4c27a9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1018,6 +1018,55 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 	return ret;
 }
 
+static noinline blk_qc_t submit_bio_interposed(struct bio *bio)
+{
+	blk_qc_t ret = BLK_QC_T_NONE;
+	struct bio_list bio_list[2] = { };
+	struct gendisk *orig_disk;
+
+	if (current->bio_list) {
+		bio_list_add(&current->bio_list[0], bio);
+		return BLK_QC_T_NONE;
+	}
+
+	orig_disk = bio->bi_bdev->bd_disk;
+	if (unlikely(bio_queue_enter(bio)))
+		return BLK_QC_T_NONE;
+
+	current->bio_list = bio_list;
+
+	do {
+		struct block_device *interposer = bio->bi_bdev->bd_interposer;
+
+		if (unlikely(!interposer)) {
+			/* interposer was removed */
+			bio_list_add(&current->bio_list[0], bio);
+			break;
+		}
+		/* assign bio to interposer device */
+		bio_set_dev(bio, interposer);
+		bio_set_flag(bio, BIO_INTERPOSED);
+
+		if (!submit_bio_checks(bio))
+			break;
+		/*
+		 * Because the current->bio_list is initialized,
+		 * the submit_bio callback will always return BLK_QC_T_NONE.
+		 */
+		interposer->bd_disk->fops->submit_bio(bio);
+	} while (false);
+
+	current->bio_list = NULL;
+
+	blk_queue_exit(orig_disk->queue);
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
@@ -1029,6 +1078,14 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
  */
 blk_qc_t submit_bio_noacct(struct bio *bio)
 {
+	/*
+	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
+	 * created by the bdev_interposer do not get to it for processing.
+	 */
+	if (bdev_has_interposer(bio->bi_bdev) &&
+	    !bio_flagged(bio, BIO_INTERPOSED))
+		return submit_bio_interposed(bio);
+
 	if (!submit_bio_checks(bio))
 		return BLK_QC_T_NONE;
 
diff --git a/block/genhd.c b/block/genhd.c
index c55e8f0fced1..c840ecffea68 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -30,6 +30,11 @@
 static struct kobject *block_depr;
 
 DECLARE_RWSEM(bdev_lookup_sem);
+/*
+ * Prevents different block-layer interposers from attaching or detaching
+ * to the block device at the same time.
+ */
+static DEFINE_MUTEX(bdev_interposer_attach_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
@@ -1940,3 +1945,52 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+int bdev_interposer_attach(struct block_device *original,
+			   struct block_device *interposer)
+{
+	int ret = 0;
+
+	if (WARN_ON(((!original) || (!interposer))))
+		return -EINVAL;
+	/*
+	 * interposer should be simple, no a multi-queue device
+	 */
+	if (!interposer->bd_disk->fops->submit_bio)
+		return -EINVAL;
+
+	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
+		return -EPERM;
+
+	mutex_lock(&bdev_interposer_attach_lock);
+
+	if (bdev_has_interposer(original))
+		ret = -EBUSY;
+	else {
+		original->bd_interposer = bdgrab(interposer);
+		if (!original->bd_interposer)
+			ret = -ENODEV;
+	}
+
+	mutex_unlock(&bdev_interposer_attach_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bdev_interposer_attach);
+
+void bdev_interposer_detach(struct block_device *original)
+{
+	if (WARN_ON(!original))
+		return;
+
+	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
+		return;
+
+	mutex_lock(&bdev_interposer_attach_lock);
+	if (bdev_has_interposer(original)) {
+		bdput(original->bd_interposer);
+		original->bd_interposer = NULL;
+	}
+	mutex_unlock(&bdev_interposer_attach_lock);
+}
+EXPORT_SYMBOL_GPL(bdev_interposer_detach);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..13bda4732cf5 100644
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
+	struct block_device     *bd_interposer;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
@@ -304,6 +306,7 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_INTERPOSED,		/* bio was reassigned to another block device */
 	BIO_FLAG_LAST
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b43..90f62b4197da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2031,4 +2031,13 @@ int fsync_bdev(struct block_device *bdev);
 int freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev);
 
+static inline bool bdev_has_interposer(struct block_device *bdev)
+{
+	return (bdev->bd_interposer != NULL);
+};
+
+int bdev_interposer_attach(struct block_device *original,
+			   struct block_device *interposer);
+void bdev_interposer_detach(struct block_device *original);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.20.1

