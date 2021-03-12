Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE7339700
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 20:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhCLTAk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Mar 2021 14:00:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233886AbhCLTAW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Mar 2021 14:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615575622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4J7duHuTFEUUBvXNMJ2TkKxjxlYDUDL36tWYKwgns0c=;
        b=gM9gMhxcYdRnC2CEzUDksTBjSz8d7c4UOg9WOvU4z4Bnk8c/u6m4EyyYPWteSagul6/Cag
        xSz9yUWZA9/m8ZHKXJsV0UP2xOEDVL3McvP8jpWYHFlmO66eJKDK6d+0F1Gax2bN3n+lDI
        1Qtso6IMhoFb1tO4gx/sApQEgZmUN64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-7v8yz3_ZO9-FhfdynX7e2w-1; Fri, 12 Mar 2021 14:00:19 -0500
X-MC-Unique: 7v8yz3_ZO9-FhfdynX7e2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB036107ACCD;
        Fri, 12 Mar 2021 19:00:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED0C60918;
        Fri, 12 Mar 2021 19:00:14 +0000 (UTC)
Date:   Fri, 12 Mar 2021 14:00:13 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pavel.tide@veeam.com
Subject: Re: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210312190013.GA2004@redhat.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12 2021 at 10:44am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> DM_INTERPOSED_FLAG allow to create DM targets on "the fly".
> Underlying block device opens without a flag FMODE_EXCL.
> DM target receives bio from the original device via
> bdev_interposer.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  drivers/md/dm-core.h          |  3 ++
>  drivers/md/dm-ioctl.c         | 13 ++++++++
>  drivers/md/dm-table.c         | 61 +++++++++++++++++++++++++++++------
>  drivers/md/dm.c               | 38 +++++++++++++++-------
>  include/linux/device-mapper.h |  1 +
>  include/uapi/linux/dm-ioctl.h |  6 ++++
>  6 files changed, 101 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index 5953ff2bd260..9eae419c7b18 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -114,6 +114,9 @@ struct mapped_device {
>  	bool init_tio_pdu:1;
>  
>  	struct srcu_struct io_barrier;
> +
> +	/* attach target via block-layer interposer */
> +	bool is_interposed;
>  };

This flag is a mix of uses.  First it is used to store that
DM_INTERPOSED_FLAG was provided as input param during load.

And the same 'is_interposed' name is used in 'struct dm_dev'.

To me this state should be elevated to block core -- awkward for every
driver that might want to use blk-interposer to be sprinkling state
around its core structures.

So I'd prefer you:
1) rename 'struct mapped_device' to 'interpose' _and_ add it just after
   "bool init_tio_pdu:1;" with "bool interpose:1;" -- this reflects
   interpose was requested during load.
2) bdev_interposer_attach() should be made to set some block core state
   that is able to be tested to check if a device is_interposed.
3) Don't add an 'is_interposed' flag to 'struct dm_dev'

>  
>  void disable_discard(struct mapped_device *md);
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 5e306bba4375..2b4c9557c283 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1267,6 +1267,11 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
>  	return mode;
>  }
>  
> +static inline bool get_interposer_flag(struct dm_ioctl *param)
> +{
> +	return (param->flags & DM_INTERPOSED_FLAG);
> +}
> +

As I mention at the end: rename to DM_INTERPOSE_FLAG

>  static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  		       struct dm_target_spec **spec, char **target_params)
>  {
> @@ -1293,6 +1298,10 @@ static int populate_table(struct dm_table *table,
>  		DMWARN("populate_table: no targets specified");
>  		return -EINVAL;
>  	}
> +	if (table->md->is_interposed && (param->target_count != 1)) {
> +		DMWARN("%s: with interposer should be specified only one target", __func__);

This error/warning reads very awkwardly. Maybe?:
"%s: interposer requires only a single target be specified"

> +		return -EINVAL;
> +	}
>  
>  	for (i = 0; i < param->target_count; i++) {
>  
> @@ -1338,6 +1347,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
>  	if (!md)
>  		return -ENXIO;
>  
> +	md->is_interposed = get_interposer_flag(param);
> +
>  	r = dm_table_create(&t, get_mode(param), param->target_count, md);
>  	if (r)
>  		goto err;
> @@ -2098,6 +2109,8 @@ int __init dm_early_create(struct dm_ioctl *dmi,
>  	if (r)
>  		goto err_hash_remove;
>  
> +	md->is_interposed = get_interposer_flag(dmi);
> +
>  	/* add targets */
>  	for (i = 0; i < dmi->target_count; i++) {
>  		r = dm_table_add_target(t, spec_array[i]->target_type,
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 95391f78b8d5..f6e2eb3f8949 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -225,12 +225,13 @@ void dm_table_destroy(struct dm_table *t)
>  /*
>   * See if we've already got a device in the list.
>   */
> -static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
> +static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev, bool is_interposed)

Think in make more sense to internalize the need to consider
md->interpose here.

So:

static struct dm_dev_internal *find_device(struct dm_table *t, dev_t dev)
{
        struct list_head *l = &t->devices;
        bool is_interposed = t->md->interpose;
        ...

>  {
>  	struct dm_dev_internal *dd;
>  
>  	list_for_each_entry (dd, l, list)
> -		if (dd->dm_dev->bdev->bd_dev == dev)
> +		if ((dd->dm_dev->bdev->bd_dev == dev) &&
> +		    (dd->dm_dev->is_interposed == is_interposed))
>  			return dd;

But why must this extra state be used/tested?  Seems like quite a deep
embedding of interposer into dm_dev_internal.. feels unnecessary.

>  
>  	return NULL;
> @@ -358,6 +359,18 @@ dev_t dm_get_dev_t(const char *path)
>  }
>  EXPORT_SYMBOL_GPL(dm_get_dev_t);
>  
> +static inline void dm_disk_freeze(struct gendisk *disk)
> +{
> +	blk_mq_freeze_queue(disk->queue);
> +	blk_mq_quiesce_queue(disk->queue);
> +}
> +
> +static inline void dm_disk_unfreeze(struct gendisk *disk)
> +{
> +	blk_mq_unquiesce_queue(disk->queue);
> +	blk_mq_unfreeze_queue(disk->queue);
> +}
> +

These interfaces don't account for bio-based at all (pretty sure we've
been over this and you pointed out that they'll just return early), but
they also don't take steps to properly flush outstanding DM io.
Shouldn't you require DM devices do an internal suspend/resume?  And if
original device isn't DM then fallback to blk_mq calls?

>  /*
>   * Add a device to the list, or just increment the usage count if
>   * it's already present.
> @@ -385,7 +398,7 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  			return -ENODEV;
>  	}
>  
> -	dd = find_device(&t->devices, dev);
> +	dd = find_device(&t->devices, dev, t->md->is_interposed);
>  	if (!dd) {
>  		dd = kmalloc(sizeof(*dd), GFP_KERNEL);
>  		if (!dd)
> @@ -398,15 +411,38 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  
>  		refcount_set(&dd->count, 1);
>  		list_add(&dd->list, &t->devices);
> -		goto out;
> -
>  	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
>  		r = upgrade_mode(dd, mode, t->md);
>  		if (r)
>  			return r;
> +		refcount_inc(&dd->count);
>  	}
> -	refcount_inc(&dd->count);

This looks bogus... you cannot only increment refcount with the mode
check/upgrade branch (IIRC: I've made this same mistake in the past)

> -out:
> +
> +	if (t->md->is_interposed) {
> +		struct block_device *original = dd->dm_dev->bdev;
> +		struct block_device *interposer = t->md->disk->part0;
> +
> +		if ((ti->begin != 0) || (ti->len < bdev_nr_sectors(original))) {
> +			dm_put_device(ti, dd->dm_dev);
> +			DMERR("The interposer device should not be less than the original.");
> +			return -EINVAL;

Can you explain why allowing the device to be larger is meaningful?  Not
saying it isn't I'd just like to understand use-cases you forsee.

> +		}
> +
> +		/*
> +		 * Attach mapped interposer device to original.
> +		 * It is quite convenient that device mapper creates
> +		 * one disk for one block device.
> +		 */
> +		dm_disk_freeze(original->bd_disk);
> +		r = bdev_interposer_attach(original, interposer);
> +		dm_disk_unfreeze(original->bd_disk);
> +		if (r) {
> +			dm_put_device(ti, dd->dm_dev);
> +			DMERR("Failed to attach dm interposer.");
> +			return r;
> +		}
> +	}
> +
>  	*result = dd->dm_dev;
>  	return 0;
>  }
> @@ -446,6 +482,7 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
>  {
>  	int found = 0;
>  	struct list_head *devices = &ti->table->devices;
> +	struct mapped_device *md = ti->table->md;
>  	struct dm_dev_internal *dd;
>  
>  	list_for_each_entry(dd, devices, list) {
> @@ -456,11 +493,17 @@ void dm_put_device(struct dm_target *ti, struct dm_dev *d)
>  	}
>  	if (!found) {
>  		DMWARN("%s: device %s not in table devices list",
> -		       dm_device_name(ti->table->md), d->name);
> +		       dm_device_name(md), d->name);
>  		return;
>  	}
> +	if (md->is_interposed) {
> +		dm_disk_freeze(d->bdev->bd_disk);
> +		bdev_interposer_detach(d->bdev);
> +		dm_disk_unfreeze(d->bdev->bd_disk);
> +	}
> +
>  	if (refcount_dec_and_test(&dd->count)) {
> -		dm_put_table_device(ti->table->md, d);
> +		dm_put_table_device(md, d);
>  		list_del(&dd->list);
>  		kfree(dd);
>  	}
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 50b693d776d6..466bf70a66b0 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -762,16 +762,24 @@ static int open_table_device(struct table_device *td, dev_t dev,
>  
>  	BUG_ON(td->dm_dev.bdev);
>  
> -	bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
> -	if (IS_ERR(bdev))
> -		return PTR_ERR(bdev);
> +	if (md->is_interposed) {
>  
> -	r = bd_link_disk_holder(bdev, dm_disk(md));
> -	if (r) {
> -		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
> -		return r;
> +		bdev = blkdev_get_by_dev(dev, td->dm_dev.mode, NULL);
> +		if (IS_ERR(bdev))
> +			return PTR_ERR(bdev);
> +	} else {
> +		bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
> +		if (IS_ERR(bdev))
> +			return PTR_ERR(bdev);
> +
> +		r = bd_link_disk_holder(bdev, dm_disk(md));
> +		if (r) {
> +			blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
> +			return r;
> +		}
>  	}
>  
> +	td->dm_dev.is_interposed = md->is_interposed;

This _should_ hopefully get cleaned up by pushing such state into block
core's interposer interfaces.

But again, not seeing what utility/safety this extra flag is providing
to begin with.  Is this state _actually_ needed at all?


>  	td->dm_dev.bdev = bdev;
>  	td->dm_dev.dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
>  	return 0;
> @@ -785,20 +793,26 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
>  	if (!td->dm_dev.bdev)
>  		return;
>  
> -	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
> -	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
> +	if (td->dm_dev.is_interposed)
> +		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);
> +	else {
> +		bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
> +		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
> +	}
>  	put_dax(td->dm_dev.dax_dev);
>  	td->dm_dev.bdev = NULL;
>  	td->dm_dev.dax_dev = NULL;
>  }
>  
>  static struct table_device *find_table_device(struct list_head *l, dev_t dev,
> -					      fmode_t mode)
> +					      fmode_t mode, bool is_interposed)
>  {
>  	struct table_device *td;
>  
>  	list_for_each_entry(td, l, list)
> -		if (td->dm_dev.bdev->bd_dev == dev && td->dm_dev.mode == mode)
> +		if (td->dm_dev.bdev->bd_dev == dev &&
> +		    td->dm_dev.mode == mode &&
> +		    td->dm_dev.is_interposed == is_interposed)
>  			return td;
>  
>  	return NULL;
> @@ -811,7 +825,7 @@ int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
>  	struct table_device *td;
>  
>  	mutex_lock(&md->table_devices_lock);
> -	td = find_table_device(&md->table_devices, dev, mode);
> +	td = find_table_device(&md->table_devices, dev, mode, md->is_interposed);
>  	if (!td) {
>  		td = kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);
>  		if (!td) {
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 7f4ac87c0b32..76a6dfb1cb29 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -159,6 +159,7 @@ struct dm_dev {
>  	struct block_device *bdev;
>  	struct dax_device *dax_dev;
>  	fmode_t mode;
> +	bool is_interposed;

Again, I'd like this state to be part of 'struct block_device'

>  	char name[16];
>  };
>  
> diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
> index fcff6669137b..fc4d06bb3dbb 100644
> --- a/include/uapi/linux/dm-ioctl.h
> +++ b/include/uapi/linux/dm-ioctl.h
> @@ -362,4 +362,10 @@ enum {
>   */
>  #define DM_INTERNAL_SUSPEND_FLAG	(1 << 18) /* Out */
>  
> +/*
> + * If set, the underlying device should open without FMODE_EXCL
> + * and attach mapped device via bdev_interposer.
> + */
> +#define DM_INTERPOSED_FLAG		(1 << 19) /* In */

Please rename to DM_INTERPOSE_FLAG

> +
>  #endif				/* _LINUX_DM_IOCTL_H */
> -- 
> 2.20.1
> 

