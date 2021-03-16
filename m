Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0171833D768
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhCPP3d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 11:29:33 -0400
Received: from casper.infradead.org ([90.155.50.34]:37518 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbhCPP3L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 11:29:11 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 11:29:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YKpxXpBnW4nbd5qI6DXunIfxtVthTR1e36xUzlkaskA=; b=BM2YyQ+RcJhc+gUVaiJMbXRBN4
        9RfoWcqJmOTZ62rocN0WvWm7V4ufUVkSbuqMzNJvP2DNvaQdbY610eFleULsjckdsHV9gixbBJfi9
        3cXUozMHGwcnaXw4tJX2dXGq6cpK+066wpEmr0xK+mlBnkmaQktuNZ8nImXyqdK3dIkiUo9oVYZLC
        VCtQhcLHikCpkcFJHeQi0/Tfyw8olOZSHRyKDhFGzGwaPbERAgJTo8hHr1Gx+kYiMFa9KGdAbRWZG
        YPzMAKBjfrXP+bzms9vhYC8g0Al/9LWRN3eMazdTnNVXF0x3JS67GonT3HC28aYscl3mYZCizF51X
        SJ78KSdA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMBZ6-000EY4-Kn; Tue, 16 Mar 2021 15:25:00 +0000
Date:   Tue, 16 Mar 2021 15:25:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210316152500.GA55711@infradead.org>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
 <20210314093038.GC3773360@infradead.org>
 <20210315132509.GD30489@veeam.com>
 <20210316152314.GA55391@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316152314.GA55391@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 16, 2021 at 03:23:14PM +0000, Christoph Hellwig wrote:
> On Mon, Mar 15, 2021 at 04:25:09PM +0300, Sergei Shtepa wrote:
> > The 03/14/2021 12:30, Christoph Hellwig wrote:
> > > On Fri, Mar 12, 2021 at 06:44:55PM +0300, Sergei Shtepa wrote:
> > > > DM_INTERPOSED_FLAG allow to create DM targets on "the fly".
> > > > Underlying block device opens without a flag FMODE_EXCL.
> > > > DM target receives bio from the original device via
> > > > bdev_interposer.
> > > 
> > > This is more of a philopical comment, but the idea of just letting the
> > > interposed reopen the device by itself seems like a bad idea.  I think
> > > that is probably better hidden in the block layer interposer attachment
> > > function, which could do the extra blkdev_get_by_dev for the caller.
> > 
> > I suppose this cannot be implemented, since we need to change the behavior
> > for block devices that already have been opened.
> 
> That's not what I mean.  Take a look at the patch relative to your
> series to let me know what you think.  The new blkdev_interposer_attach
> now takes a dev_t + mode for the original device and opens it on
> behalf of the interposer.  It also moves the queue freezing into the
> API, which should address the concerns about the helper and adds a few
> more sanity checks.

And now actually with the diff:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2f188a865024ac..d4d7c1caa43966 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,19 +161,6 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
 
-bool blk_mq_is_queue_frozen(struct request_queue *q)
-{
-	bool frozen;
-
-	mutex_lock(&q->mq_freeze_lock);
-	frozen = percpu_ref_is_dying(&q->q_usage_counter) &&
-		 percpu_ref_is_zero(&q->q_usage_counter);
-	mutex_unlock(&q->mq_freeze_lock);
-
-	return frozen;
-}
-EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);
-
 /*
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
diff --git a/block/genhd.c b/block/genhd.c
index fa406b972371ae..64d6338b08cc87 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1944,51 +1944,70 @@ static void disk_release_events(struct gendisk *disk)
 	kfree(disk->ev);
 }
 
-int bdev_interposer_attach(struct block_device *original,
+struct block_device *blkdev_interposer_attach(dev_t dev, fmode_t mode,
 			   struct block_device *interposer)
 {
+	struct block_device *bdev;
 	int ret = 0;
 
-	if (WARN_ON(((!original) || (!interposer))))
-		return -EINVAL;
-	/*
-	 * interposer should be simple, no a multi-queue device
-	 */
-	if (!interposer->bd_disk->fops->submit_bio)
-		return -EINVAL;
+	if (WARN_ON_ONCE(!bdev_is_partition(interposer)))
+		return ERR_PTR(-EINVAL);
+	if (WARN_ON_ONCE(!queue_is_mq(interposer->bd_disk->queue)))
+		return ERR_PTR(-EINVAL);
 
-	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
-		return -EPERM;
+	bdev = blkdev_get_by_dev(dev, mode, NULL);
+	if (IS_ERR(bdev))
+		return bdev;
 
-	mutex_lock(&bdev_interposer_attach_lock);
+	ret = -EINVAL;
+	if (WARN_ON_ONCE(bdev_nr_sectors(bdev) != bdev_nr_sectors(interposer)))
+		goto out;
 
-	if (bdev_has_interposer(original))
-		ret = -EBUSY;
-	else {
-		original->bd_interposer = bdgrab(interposer);
-		if (!original->bd_interposer)
-			ret = -ENODEV;
-	}
+	blk_mq_freeze_queue(bdev->bd_disk->queue);
+	blk_mq_quiesce_queue(bdev->bd_disk->queue);
 
+	mutex_lock(&bdev_interposer_attach_lock);
+	ret = -EBUSY;
+	if (bdev_has_interposer(bdev))
+		goto out_unlock;
+	ret = -ENODEV;
+	bdev->bd_interposer = bdgrab(interposer);
+	if (!bdev->bd_interposer)
+		goto out_unlock;
+	ret = 0;
+out_unlock:
 	mutex_unlock(&bdev_interposer_attach_lock);
 
-	return ret;
+	blk_mq_unquiesce_queue(bdev->bd_disk->queue);
+	blk_mq_unfreeze_queue(bdev->bd_disk->queue);
+out:
+	if (ret) {
+		blkdev_put(bdev, mode);
+		bdev = ERR_PTR(ret);
+	}
+
+	return bdev;
 }
-EXPORT_SYMBOL_GPL(bdev_interposer_attach);
+EXPORT_SYMBOL_GPL(blkdev_interposer_attach);
 
-void bdev_interposer_detach(struct block_device *original)
+void blkdev_interposer_detach(struct block_device *bdev, fmode_t mode)
 {
-	if (WARN_ON(!original))
-		return;
+	struct block_device *interposer;
 
-	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
+	if (WARN_ON_ONCE(!bdev_has_interposer(bdev)))
 		return;
 
+	blk_mq_freeze_queue(bdev->bd_disk->queue);
+	blk_mq_quiesce_queue(bdev->bd_disk->queue);
+
 	mutex_lock(&bdev_interposer_attach_lock);
-	if (bdev_has_interposer(original)) {
-		bdput(original->bd_interposer);
-		original->bd_interposer = NULL;
-	}
+	interposer = bdev->bd_interposer;
+	bdev->bd_interposer = NULL;
 	mutex_unlock(&bdev_interposer_attach_lock);
+
+	blk_mq_unquiesce_queue(bdev->bd_disk->queue);
+	blk_mq_unfreeze_queue(bdev->bd_disk->queue);
+
+	blkdev_put(interposer, mode);
 }
-EXPORT_SYMBOL_GPL(bdev_interposer_detach);
+EXPORT_SYMBOL_GPL(blkdev_interposer_detach);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index f6e2eb3f894940..fde57bb5105025 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -359,18 +359,6 @@ dev_t dm_get_dev_t(const char *path)
 }
 EXPORT_SYMBOL_GPL(dm_get_dev_t);
 
-static inline void dm_disk_freeze(struct gendisk *disk)
-{
-	blk_mq_freeze_queue(disk->queue);
-	blk_mq_quiesce_queue(disk->queue);
-}
-
-static inline void dm_disk_unfreeze(struct gendisk *disk)
-{
-	blk_mq_unquiesce_queue(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue);
-}
-
 /*
  * Add a device to the list, or just increment the usage count if
  * it's already present.
@@ -418,29 +406,11 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		refcount_inc(&dd->count);
 	}
 
-	if (t->md->is_interposed) {
-		struct block_device *original = dd->dm_dev->bdev;
-		struct block_device *interposer = t->md->disk->part0;
-
-		if ((ti->begin != 0) || (ti->len < bdev_nr_sectors(original))) {
-			dm_put_device(ti, dd->dm_dev);
-			DMERR("The interposer device should not be less than the original.");
-			return -EINVAL;
-		}
-
-		/*
-		 * Attach mapped interposer device to original.
-		 * It is quite convenient that device mapper creates
-		 * one disk for one block device.
-		 */
-		dm_disk_freeze(original->bd_disk);
-		r = bdev_interposer_attach(original, interposer);
-		dm_disk_unfreeze(original->bd_disk);
-		if (r) {
-			dm_put_device(ti, dd->dm_dev);
-			DMERR("Failed to attach dm interposer.");
-			return r;
-		}
+	if (t->md->is_interposed &&
+	    (ti->begin != 0 || ti->len < bdev_nr_sectors(dd->dm_dev->bdev))) {
+		dm_put_device(ti, dd->dm_dev);
+		DMERR("The interposer device should not be less than the original.");
+		return -EINVAL;
 	}
 
 	*result = dd->dm_dev;
@@ -496,11 +466,6 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
 		       dm_device_name(md), d->name);
 		return;
 	}
-	if (md->is_interposed) {
-		dm_disk_freeze(d->bdev->bd_disk);
-		bdev_interposer_detach(d->bdev);
-		dm_disk_unfreeze(d->bdev->bd_disk);
-	}
 
 	if (refcount_dec_and_test(&dd->count)) {
 		dm_put_table_device(md, d);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c488e9554aa000..532ce17064b1c1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -763,10 +763,12 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	BUG_ON(td->dm_dev.bdev);
 
 	if (md->is_interposed) {
-
-		bdev = blkdev_get_by_dev(dev, td->dm_dev.mode, NULL);
-		if (IS_ERR(bdev))
+		bdev = blkdev_interposer_attach(dev, td->dm_dev.mode,
+						md->disk->part0);
+		if (IS_ERR(bdev)) {
+			DMERR("Failed to attach dm interposer.");
 			return PTR_ERR(bdev);
+		}
 	} else {
 		bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
 		if (IS_ERR(bdev))
@@ -793,9 +795,9 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 	if (!td->dm_dev.bdev)
 		return;
 
-	if (td->dm_dev.is_interposed)
-		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);
-	else {
+	if (td->dm_dev.is_interposed) {
+		blkdev_interposer_detach(td->dm_dev.bdev, td->dm_dev.mode);
+	} else {
 		bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
 		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6f01971abf7b9b..2c473c9b899089 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -533,7 +533,6 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
-bool blk_mq_is_queue_frozen(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 90f62b4197da91..fbc510162c3827 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2036,8 +2036,8 @@ static inline bool bdev_has_interposer(struct block_device *bdev)
 	return (bdev->bd_interposer != NULL);
 };
 
-int bdev_interposer_attach(struct block_device *original,
+struct block_device *blkdev_interposer_attach(dev_t dev, fmode_t mode,
 			   struct block_device *interposer);
-void bdev_interposer_detach(struct block_device *original);
+void blkdev_interposer_detach(struct block_device *bdev, fmode_t mode);
 
 #endif /* _LINUX_BLKDEV_H */
