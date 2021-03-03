Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5F32C670
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451032AbhCDA2v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:51 -0500
Received: from mx2.veeam.com ([64.129.123.6]:55740 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357602AbhCCNBx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 08:01:53 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 5920442316;
        Wed,  3 Mar 2021 07:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1614774655; bh=x7rROgKPf0HReqUk25cOaad8Lw4OtTksb4dqe7dYmB8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Q1qdibd5XKtMwMdMwXTshhDDBB7TPhwYxFJwzFl22f95GhjadAqdDCR+CrgFZOtnZ
         i/XwikbB6/gM87wm6uH99RKHY2OAWLHqUosdTI1Ku8238ua/I3oq8XEN70hjTAac0c
         LydUPxDM1QQcQIfxw3IPTCsLZC/SQv743yhoM924=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Mar 2021 13:30:51 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <hare@suse.de>,
        <song@kernel.org>, <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v6 4/4] dm: add DM_INTERPOSED_FLAG
Date:   Wed, 3 Mar 2021 15:30:18 +0300
Message-ID: <1614774618-22410-5-git-send-email-sergei.shtepa@veeam.com>
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

DM_INTERPOSED_FLAG allow to create dm targets on "the fly".
Underlying block device opens without a flag FMODE_EXCL.
Dm target receives bio from the original device via
blk_interposer.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm-core.h          |   6 ++
 drivers/md/dm-ioctl.c         |   9 +++
 drivers/md/dm-table.c         | 115 +++++++++++++++++++++++++++++++---
 drivers/md/dm.c               |  38 +++++++----
 include/linux/device-mapper.h |   1 +
 include/uapi/linux/dm-ioctl.h |   6 ++
 6 files changed, 154 insertions(+), 21 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5953ff2bd260..e5c845f9b1df 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -21,6 +21,8 @@
 
 #define DM_RESERVED_MAX_IOS		1024
 
+struct dm_interposed_dev;
+
 struct dm_kobject_holder {
 	struct kobject kobj;
 	struct completion completion;
@@ -114,6 +116,10 @@ struct mapped_device {
 	bool init_tio_pdu:1;
 
 	struct srcu_struct io_barrier;
+
+	/* for interposers logic */
+	bool is_interposed;
+	struct dm_interposed_dev *ip_dev;
 };
 
 void disable_discard(struct mapped_device *md);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 5e306bba4375..2bcb316144a1 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1267,6 +1267,11 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
 	return mode;
 }
 
+static inline bool get_interposer_flag(struct dm_ioctl *param)
+{
+	return (param->flags & DM_INTERPOSED_FLAG);
+}
+
 static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 		       struct dm_target_spec **spec, char **target_params)
 {
@@ -1338,6 +1343,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (!md)
 		return -ENXIO;
 
+	md->is_interposed = get_interposer_flag(param);
+
 	r = dm_table_create(&t, get_mode(param), param->target_count, md);
 	if (r)
 		goto err;
@@ -2098,6 +2105,8 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 	if (r)
 		goto err_hash_remove;
 
+	md->is_interposed = get_interposer_flag(dmi);
+
 	/* add targets */
 	for (i = 0; i < dmi->target_count; i++) {
 		r = dm_table_add_target(t, spec_array[i]->target_type,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 95391f78b8d5..0b2f9b66ade5 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -6,6 +6,7 @@
  */
 
 #include "dm-core.h"
+#include "dm-interposer.h"
 
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -225,12 +226,13 @@ void dm_table_destroy(struct dm_table *t)
 /*
  * See if we've already got a device in the list.
  */
-static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
+static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev, bool is_interposed)
 {
 	struct dm_dev_internal *dd;
 
 	list_for_each_entry (dd, l, list)
-		if (dd->dm_dev->bdev->bd_dev == dev)
+		if ((dd->dm_dev->bdev->bd_dev == dev) &&
+		    (dd->dm_dev->is_interposed == is_interposed))
 			return dd;
 
 	return NULL;
@@ -358,6 +360,90 @@ dev_t dm_get_dev_t(const char *path)
 }
 EXPORT_SYMBOL_GPL(dm_get_dev_t);
 
+/*
+ * Redirect bio from interposed device to dm device
+ */
+static void dm_interpose_fn(struct dm_interposed_dev *ip_dev, struct bio *bio)
+{
+	struct mapped_device *md = ip_dev->private;
+
+	if (bio_flagged(bio, BIO_REMAPPED)) {
+		/*
+		 * Since bio has already been remapped, we need to subtract
+		 * the block device offset from the beginning of the disk.
+		 */
+		bio->bi_iter.bi_sector -= get_start_sect(bio->bi_bdev);
+
+		bio_clear_flag(bio, BIO_REMAPPED);
+	}
+
+	/*
+	 * Set acceptor device.
+	 * It is quite convenient that device mapper creates
+	 * one disk for one block device.
+	 */
+	bio->bi_bdev = md->disk->part0;
+
+	/*
+	 * Bio should be resubmitted.
+	 * The bio will be checked again and placed in current->bio_list.
+	 */
+	submit_bio_noacct(bio);
+}
+
+static int _interposer_dev_create(struct block_device *bdev, sector_t ofs, sector_t len,
+				  struct mapped_device *md)
+{
+	int ret;
+
+	DMDEBUG("Create dm interposer.");
+
+	if (md->ip_dev) {
+		DMERR("The dm interposer device already in use.");
+		return -EALREADY;
+	}
+
+	if ((ofs + len) > bdev_nr_sectors(bdev)) {
+		DMERR("The specified range of sectors exceeds of the size of the block device.");
+		return -ERANGE;
+	}
+
+	md->ip_dev = kzalloc(sizeof(struct dm_interposed_dev), GFP_KERNEL);
+	if (!md->ip_dev)
+		return -ENOMEM;
+
+	if ((ofs == 0) && (len == 0))
+		DMDEBUG("Whole block device should be interposed.");
+
+	dm_interposer_dev_init(md->ip_dev,
+			       ofs, len,
+			       md, dm_interpose_fn);
+
+	ret = dm_interposer_dev_attach(bdev, md->ip_dev);
+	if (ret) {
+		DMERR("Cannot attach dm interposer device.");
+		kfree(md->ip_dev);
+		md->ip_dev = NULL;
+	}
+
+	return ret;
+}
+
+static void _interposer_dev_remove(struct block_device *bdev, struct mapped_device *md)
+{
+	if (!md->ip_dev)
+		return;
+
+	DMDEBUG("Remove dm interposer. %llu bios was interposed.",
+		atomic64_read(&md->ip_dev->ip_cnt));
+
+	if (dm_interposer_detach_dev(bdev, md->ip_dev))
+		DMERR("Failed to detach dm interposer.");
+
+	kfree(md->ip_dev);
+	md->ip_dev = NULL;
+}
+
 /*
  * Add a device to the list, or just increment the usage count if
  * it's already present.
@@ -385,7 +471,7 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 			return -ENODEV;
 	}
 
-	dd = find_device(&t->devices, dev);
+	dd = find_device(&t->devices, dev, t->md->is_interposed);
 	if (!dd) {
 		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
 		if (!dd)
@@ -398,15 +484,22 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 
 		refcount_set(&dd->count, 1);
 		list_add(&dd->list, &t->devices);
-		goto out;
-
 	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
 		r = upgrade_mode(dd, mode, t->md);
 		if (r)
 			return r;
+		refcount_inc(&dd->count);
 	}
-	refcount_inc(&dd->count);
-out:
+
+	if (t->md->is_interposed) {
+		r = _interposer_dev_create(dd->dm_dev->bdev, ti->begin, ti->len, t->md);
+		if (r) {
+			dm_put_device(ti, dd->dm_dev);
+			DMERR("Failed to attach dm interposer.");
+			return r;
+		}
+	}
+
 	*result = dd->dm_dev;
 	return 0;
 }
@@ -446,6 +539,7 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 {
 	int found = 0;
 	struct list_head *devices = &ti->table->devices;
+	struct mapped_device *md = ti->table->md;
 	struct dm_dev_internal *dd;
 
 	list_for_each_entry(dd, devices, list) {
@@ -456,11 +550,14 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 	}
 	if (!found) {
 		DMWARN("%s: device %s not in table devices list",
-		       dm_device_name(ti->table->md), d->name);
+		       dm_device_name(md), d->name);
 		return;
 	}
+	if (md->is_interposed)
+		_interposer_dev_remove(d->bdev, md);
+
 	if (refcount_dec_and_test(&dd->count)) {
-		dm_put_table_device(ti->table->md, d);
+		dm_put_table_device(md, d);
 		list_del(&dd->list);
 		kfree(dd);
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 50b693d776d6..466bf70a66b0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -762,16 +762,24 @@ static int open_table_device(struct table_device *td, dev_t dev,
 
 	BUG_ON(td->dm_dev.bdev);
 
-	bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
+	if (md->is_interposed) {
 
-	r = bd_link_disk_holder(bdev, dm_disk(md));
-	if (r) {
-		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
-		return r;
+		bdev = blkdev_get_by_dev(dev, td->dm_dev.mode, NULL);
+		if (IS_ERR(bdev))
+			return PTR_ERR(bdev);
+	} else {
+		bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
+		if (IS_ERR(bdev))
+			return PTR_ERR(bdev);
+
+		r = bd_link_disk_holder(bdev, dm_disk(md));
+		if (r) {
+			blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
+			return r;
+		}
 	}
 
+	td->dm_dev.is_interposed = md->is_interposed;
 	td->dm_dev.bdev = bdev;
 	td->dm_dev.dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
 	return 0;
@@ -785,20 +793,26 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 	if (!td->dm_dev.bdev)
 		return;
 
-	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
-	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	if (td->dm_dev.is_interposed)
+		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);
+	else {
+		bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
+		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	}
 	put_dax(td->dm_dev.dax_dev);
 	td->dm_dev.bdev = NULL;
 	td->dm_dev.dax_dev = NULL;
 }
 
 static struct table_device *find_table_device(struct list_head *l, dev_t dev,
-					      fmode_t mode)
+					      fmode_t mode, bool is_interposed)
 {
 	struct table_device *td;
 
 	list_for_each_entry(td, l, list)
-		if (td->dm_dev.bdev->bd_dev == dev && td->dm_dev.mode == mode)
+		if (td->dm_dev.bdev->bd_dev == dev &&
+		    td->dm_dev.mode == mode &&
+		    td->dm_dev.is_interposed == is_interposed)
 			return td;
 
 	return NULL;
@@ -811,7 +825,7 @@ int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
 	struct table_device *td;
 
 	mutex_lock(&md->table_devices_lock);
-	td = find_table_device(&md->table_devices, dev, mode);
+	td = find_table_device(&md->table_devices, dev, mode, md->is_interposed);
 	if (!td) {
 		td = kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);
 		if (!td) {
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 7f4ac87c0b32..76a6dfb1cb29 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -159,6 +159,7 @@ struct dm_dev {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	fmode_t mode;
+	bool is_interposed;
 	char name[16];
 };
 
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index fcff6669137b..fc4d06bb3dbb 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -362,4 +362,10 @@ enum {
  */
 #define DM_INTERNAL_SUSPEND_FLAG	(1 << 18) /* Out */
 
+/*
+ * If set, the underlying device should open without FMODE_EXCL
+ * and attach mapped device via bdev_interposer.
+ */
+#define DM_INTERPOSED_FLAG		(1 << 19) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
2.20.1

