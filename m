Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4092032C672
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbhCDA2x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:53 -0500
Received: from mx2.veeam.com ([64.129.123.6]:55742 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358686AbhCCNB4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 08:01:56 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 0622741352;
        Wed,  3 Mar 2021 07:30:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1614774649; bh=kVdX0DoMqCg6JGjEDh1pSv+rLQxBcVCpC74d42rJURQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=wV8pWzIdQyQSSGnkRh1rKgKxx41WUvYfp/5N1isebLcSQ5MkXucvwFOox3aO5R8dc
         NLyhVOew7CISDPj3Bs9baPftpWvsdlX2snfExRpGClAbmDBWcgC8+5O9wOmwHCDENZ
         tQUrYzGtbxODEmL6IFkQIUwJcIfp+k2Vc0MhQKl0=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Mar 2021 13:30:46 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <hare@suse.de>,
        <song@kernel.org>, <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v6 3/4] dm: introduce dm-interposer
Date:   Wed, 3 Mar 2021 15:30:17 +0300
Message-ID: <1614774618-22410-4-git-send-email-sergei.shtepa@veeam.com>
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

dm-interposer.c/. h contains code for working with blk_interposer
and provides an API for interposer in device-mapper.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/Makefile        |   2 +-
 drivers/md/dm-interposer.c | 258 +++++++++++++++++++++++++++++++++++++
 drivers/md/dm-interposer.h |  40 ++++++
 3 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-interposer.c
 create mode 100644 drivers/md/dm-interposer.h

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index ef7ddc27685c..bd5b38bee82e 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -5,7 +5,7 @@
 
 dm-mod-y	+= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o dm-io.o dm-kcopyd.o dm-sysfs.o dm-stats.o \
-		   dm-rq.o
+		   dm-rq.o dm-interposer.o
 dm-multipath-y	+= dm-path-selector.o dm-mpath.o
 dm-historical-service-time-y += dm-ps-historical-service-time.o
 dm-io-affinity-y += dm-ps-io-affinity.o
diff --git a/drivers/md/dm-interposer.c b/drivers/md/dm-interposer.c
new file mode 100644
index 000000000000..e5346db81def
--- /dev/null
+++ b/drivers/md/dm-interposer.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bio.h>
+#include <linux/rwsem.h>
+#include <linux/refcount.h>
+#include <linux/device-mapper.h>
+#include <linux/interval_tree_generic.h>
+
+#include "dm-core.h"
+#include "dm-interposer.h"
+
+#define DM_MSG_PREFIX "interposer"
+
+struct dm_interposer {
+	struct bdev_interposer blk_ip;
+
+	struct kref kref;
+	struct rw_semaphore ip_devs_lock;
+	struct rb_root_cached ip_devs_root; /* dm_interposed_dev tree, since there can be multiple
+					     * interceptors for different ranges for a single
+					     * block device. */
+};
+
+/*
+ * Interval tree for device mapper
+ */
+#define START(node) ((node)->start)
+#define LAST(node) ((node)->last)
+INTERVAL_TREE_DEFINE(struct dm_rb_range, node, sector_t, _subtree_last,
+		     START, LAST,, dm_rb);
+
+static DEFINE_MUTEX(dm_interposer_attach_lock);
+
+static void dm_submit_bio_interposer_fn(struct bio *bio)
+{
+	struct dm_interposer *ip;
+	unsigned int noio_flag = 0;
+	sector_t start;
+	sector_t last;
+	struct dm_rb_range *node;
+
+	ip = container_of(bio->bi_bdev->bd_interposer, struct dm_interposer, blk_ip);
+
+	start = bio->bi_iter.bi_sector;
+	if (bio_flagged(bio, BIO_REMAPPED))
+		start -= get_start_sect(bio->bi_bdev);
+	last = start + dm_sector_div_up(bio->bi_iter.bi_size, SECTOR_SIZE);
+
+	noio_flag = memalloc_noio_save();
+	down_read(&ip->ip_devs_lock);
+	node = dm_rb_iter_first(&ip->ip_devs_root, start, last);
+	while (node) {
+		struct dm_interposed_dev *ip_dev =
+			container_of(node, struct dm_interposed_dev, node);
+
+		atomic64_inc(&ip_dev->ip_cnt);
+		ip_dev->dm_interpose_bio(ip_dev, bio);
+
+		node = dm_rb_iter_next(node, start, last);
+	}
+	up_read(&ip->ip_devs_lock);
+	memalloc_noio_restore(noio_flag);
+}
+
+void dm_interposer_free(struct kref *kref)
+{
+	struct dm_interposer *ip = container_of(kref, struct dm_interposer, kref);
+
+	bdev_interposer_detach(&ip->blk_ip, dm_submit_bio_interposer_fn);
+
+	kfree(ip);
+}
+
+struct dm_interposer *dm_interposer_new(struct block_device *bdev)
+{
+	int ret = 0;
+	struct dm_interposer *ip;
+
+	ip = kzalloc(sizeof(struct dm_interposer), GFP_NOIO);
+	if (!ip)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&ip->kref);
+	init_rwsem(&ip->ip_devs_lock);
+	ip->ip_devs_root = RB_ROOT_CACHED;
+
+	ret = bdev_interposer_attach(bdev, &ip->blk_ip, dm_submit_bio_interposer_fn);
+	if (ret) {
+		DMERR("Failed to attach bdev_interposer.");
+		kref_put(&ip->kref, dm_interposer_free);
+		return ERR_PTR(ret);
+	}
+
+	return ip;
+}
+
+static struct dm_interposer *dm_interposer_get(struct block_device *bdev)
+{
+	struct dm_interposer *ip;
+
+	if (!bdev_has_interposer(bdev))
+		return NULL;
+
+	if (bdev->bd_interposer->ip_submit_bio != dm_submit_bio_interposer_fn) {
+		DMERR("Block devices interposer slot already occupied.");
+		return ERR_PTR(-EBUSY);
+	}
+
+	ip = container_of(bdev->bd_interposer, struct dm_interposer, blk_ip);
+
+	kref_get(&ip->kref);
+	return ip;
+}
+
+static inline void dm_disk_freeze(struct gendisk *disk)
+{
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+}
+
+static inline void dm_disk_unfreeze(struct gendisk *disk)
+{
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+}
+
+/**
+ * dm_interposer_dev_init - initialize interposed device
+ * @ip_dev: interposed device
+ * @ofs: offset from the beginning of the block device
+ * @len: the length of the part of the block device to which requests will be interposed
+ * @private: user purpose parameter
+ * @interpose_fn: interposing callback
+ *
+ * Initialize structure dm_interposed_dev.
+ * For interposing part of block device set ofs and len.
+ * For interposing whole device set ofs=0 and len=0.
+ */
+void dm_interposer_dev_init(struct dm_interposed_dev *ip_dev,
+			    sector_t ofs, sector_t len,
+			    void *private, dm_interpose_bio_t interpose_fn)
+{
+	ip_dev->node.start = ofs;
+	ip_dev->node.last = ofs + len - 1;
+	ip_dev->dm_interpose_bio = interpose_fn;
+	ip_dev->private = private;
+
+	atomic64_set(&ip_dev->ip_cnt, 0);
+}
+
+/**
+ * dm_interposer_dev_attach - attach interposed device to his block device
+ * @bdev: block device
+ * @ip_dev: interposed device
+ *
+ * Return error code.
+ */
+int dm_interposer_dev_attach(struct block_device *bdev, struct dm_interposed_dev *ip_dev)
+{
+	int ret = 0;
+	struct dm_interposer *ip = NULL;
+	unsigned int noio_flag = 0;
+
+	if (!ip_dev)
+		return -EINVAL;
+
+	dm_disk_freeze(bdev->bd_disk);
+	mutex_lock(&dm_interposer_attach_lock);
+	noio_flag = memalloc_noio_save();
+
+	ip = dm_interposer_get(bdev);
+	if (ip == NULL)
+		ip = dm_interposer_new(bdev);
+	if (IS_ERR(ip)) {
+		ret = PTR_ERR(ip);
+		goto out;
+	}
+
+	/* Attach dm_interposed_dev to dm_interposer */
+	down_write(&ip->ip_devs_lock);
+	do {
+		struct dm_rb_range *node;
+
+		/* checking that ip_dev already exists for this region */
+		node = dm_rb_iter_first(&ip->ip_devs_root, ip_dev->node.start, ip_dev->node.last);
+		if (node) {
+			DMERR("Block device in region [%llu,%llu] already have interposer.",
+			      node->start, node->last);
+
+			ret = -EBUSY;
+			break;
+		}
+
+		/* insert ip_dev to ip tree */
+		dm_rb_insert(&ip_dev->node, &ip->ip_devs_root);
+		/* increment ip reference counter */
+		kref_get(&ip->kref);
+	} while (false);
+	up_write(&ip->ip_devs_lock);
+
+	kref_put(&ip->kref, dm_interposer_free);
+
+out:
+	memalloc_noio_restore(noio_flag);
+	mutex_unlock(&dm_interposer_attach_lock);
+	dm_disk_unfreeze(bdev->bd_disk);
+
+	return ret;
+}
+
+/**
+ * dm_interposer_detach_dev - detach interposed device from his block device
+ * @bdev: block device
+ * @ip_dev: interposed device
+ *
+ * Return error code.
+ */
+int dm_interposer_detach_dev(struct block_device *bdev, struct dm_interposed_dev *ip_dev)
+{
+	int ret = 0;
+	struct dm_interposer *ip = NULL;
+	unsigned int noio_flag = 0;
+
+	if (!ip_dev)
+		return -EINVAL;
+
+	dm_disk_freeze(bdev->bd_disk);
+	mutex_lock(&dm_interposer_attach_lock);
+	noio_flag = memalloc_noio_save();
+
+	ip = dm_interposer_get(bdev);
+	if (IS_ERR(ip)) {
+		ret = PTR_ERR(ip);
+		DMERR("Interposer not found.");
+		goto out;
+	}
+	if (unlikely(ip == NULL)) {
+		ret = -ENXIO;
+		DMERR("Interposer not found.");
+		goto out;
+	}
+
+	down_write(&ip->ip_devs_lock);
+	{
+		dm_rb_remove(&ip_dev->node, &ip->ip_devs_root);
+		/* the reference counter here cannot be zero */
+		kref_put(&ip->kref, dm_interposer_free);
+	}
+	up_write(&ip->ip_devs_lock);
+
+	/* detach and free interposer if it's not needed */
+	kref_put(&ip->kref, dm_interposer_free);
+out:
+	memalloc_noio_restore(noio_flag);
+	mutex_unlock(&dm_interposer_attach_lock);
+	dm_disk_unfreeze(bdev->bd_disk);
+
+	return ret;
+}
diff --git a/drivers/md/dm-interposer.h b/drivers/md/dm-interposer.h
new file mode 100644
index 000000000000..17a5411f6f00
--- /dev/null
+++ b/drivers/md/dm-interposer.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Device mapper's interposer.
+ */
+
+#include <linux/rbtree.h>
+
+struct dm_rb_range {
+	struct rb_node node;
+	sector_t start;		/* start sector of rb node */
+	sector_t last;		/* end sector of rb node */
+	sector_t _subtree_last; /* highest sector in subtree of rb node */
+};
+
+typedef void (*dm_interpose_bio_t) (struct dm_interposed_dev *ip_dev, struct bio *bio);
+
+struct dm_interposed_dev {
+	struct dm_rb_range node;
+	void *private;
+	dm_interpose_bio_t dm_interpose_bio;
+
+	atomic64_t ip_cnt; /* for debug purpose only */
+};
+
+/*
+ * Initialize structure dm_interposed_dev.
+ * For interposing part of block device set ofs and len.
+ * For interposing whole device set ofs=0 and len=0.
+ */
+void dm_interposer_dev_init(struct dm_interposed_dev *ip_dev,
+			    sector_t ofs, sector_t len,
+			    void *private, dm_interpose_bio_t interpose_fn);
+/*
+ * Attach interposer to his block device.
+ */
+int dm_interposer_dev_attach(struct block_device *bdev, struct dm_interposed_dev *ip_dev);
+/*
+ * Detach interposer from his block device.
+ */
+int dm_interposer_detach_dev(struct block_device *bdev, struct dm_interposed_dev *ip_dev);
-- 
2.20.1

