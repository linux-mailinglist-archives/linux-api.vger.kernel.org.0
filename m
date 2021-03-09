Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CAB332D60
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 18:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCIRgu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 12:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIRgf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 12:36:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167DC06174A;
        Tue,  9 Mar 2021 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aNwUo/LtHmQGqRnI1vgEqwPKSe5SPBhW6I6/Yb0wI8I=; b=qYc4qsbKTDNENjLXPk8gvcLhtM
        SnnONfH1FbECsnGYc3qSefRGw/xG/g2aMXyRO8rCZMbiRrNvqZFT39C2jhz2K6nRvbqx7tcDlihPE
        tLf1nnazVbDMyu+Ek0Ewb5Q7NNGvuqrTLREr3nzigLBlgozbHK2pj8ytFPHs+0IO74UGlxkrZDVD6
        02NTvp4VQAV7wCPHSgXBoajeakKgih10589Ax148QYEx/PISsuRCs3FK7yYyu+2F7hDnli9U1v2tA
        rkn5ugF3eNcG7tTBkBxGtNih6ocgga3qekhgO/7BSll1ZX7BM8CjOX92zNExcPgnWk3Ydu91J9WGS
        UwG+EE6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJgGx-000rxw-Fk; Tue, 09 Mar 2021 17:35:58 +0000
Date:   Tue, 9 Mar 2021 17:35:55 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     snitzer@redhat.com, agk@redhat.com, hare@suse.de, song@kernel.org,
        axboe@kernel.dk, dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-api@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH v6 4/4] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210309173555.GC201344@infradead.org>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-5-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614774618-22410-5-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 03, 2021 at 03:30:18PM +0300, Sergei Shtepa wrote:
> DM_INTERPOSED_FLAG allow to create dm targets on "the fly".
> Underlying block device opens without a flag FMODE_EXCL.
> Dm target receives bio from the original device via
> blk_interposer.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  drivers/md/dm-core.h          |   6 ++
>  drivers/md/dm-ioctl.c         |   9 +++
>  drivers/md/dm-table.c         | 115 +++++++++++++++++++++++++++++++---
>  drivers/md/dm.c               |  38 +++++++----
>  include/linux/device-mapper.h |   1 +
>  include/uapi/linux/dm-ioctl.h |   6 ++
>  6 files changed, 154 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> index 5953ff2bd260..e5c845f9b1df 100644
> --- a/drivers/md/dm-core.h
> +++ b/drivers/md/dm-core.h
> @@ -21,6 +21,8 @@
>  
>  #define DM_RESERVED_MAX_IOS		1024
>  
> +struct dm_interposed_dev;
> +
>  struct dm_kobject_holder {
>  	struct kobject kobj;
>  	struct completion completion;
> @@ -114,6 +116,10 @@ struct mapped_device {
>  	bool init_tio_pdu:1;
>  
>  	struct srcu_struct io_barrier;
> +
> +	/* for interposers logic */
> +	bool is_interposed;
> +	struct dm_interposed_dev *ip_dev;
>  };
>  
>  void disable_discard(struct mapped_device *md);
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 5e306bba4375..2bcb316144a1 100644
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
>  static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  		       struct dm_target_spec **spec, char **target_params)
>  {
> @@ -1338,6 +1343,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
>  	if (!md)
>  		return -ENXIO;
>  
> +	md->is_interposed = get_interposer_flag(param);
> +
>  	r = dm_table_create(&t, get_mode(param), param->target_count, md);
>  	if (r)
>  		goto err;
> @@ -2098,6 +2105,8 @@ int __init dm_early_create(struct dm_ioctl *dmi,
>  	if (r)
>  		goto err_hash_remove;
>  
> +	md->is_interposed = get_interposer_flag(dmi);
> +
>  	/* add targets */
>  	for (i = 0; i < dmi->target_count; i++) {
>  		r = dm_table_add_target(t, spec_array[i]->target_type,
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 95391f78b8d5..0b2f9b66ade5 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include "dm-core.h"
> +#include "dm-interposer.h"
>  
>  #include <linux/module.h>
>  #include <linux/vmalloc.h>
> @@ -225,12 +226,13 @@ void dm_table_destroy(struct dm_table *t)
>  /*
>   * See if we've already got a device in the list.
>   */
> -static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
> +static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev, bool is_interposed)
>  {
>  	struct dm_dev_internal *dd;
>  
>  	list_for_each_entry (dd, l, list)
> -		if (dd->dm_dev->bdev->bd_dev == dev)
> +		if ((dd->dm_dev->bdev->bd_dev == dev) &&
> +		    (dd->dm_dev->is_interposed == is_interposed))
>  			return dd;
>  
>  	return NULL;
> @@ -358,6 +360,90 @@ dev_t dm_get_dev_t(const char *path)
>  }
>  EXPORT_SYMBOL_GPL(dm_get_dev_t);
>  
> +/*
> + * Redirect bio from interposed device to dm device
> + */
> +static void dm_interpose_fn(struct dm_interposed_dev *ip_dev, struct bio *bio)
> +{
> +	struct mapped_device *md = ip_dev->private;
> +
> +	if (bio_flagged(bio, BIO_REMAPPED)) {
> +		/*
> +		 * Since bio has already been remapped, we need to subtract
> +		 * the block device offset from the beginning of the disk.
> +		 */
> +		bio->bi_iter.bi_sector -= get_start_sect(bio->bi_bdev);
> +
> +		bio_clear_flag(bio, BIO_REMAPPED);
> +	}

So instead of doing this shoudn't the imposer just always submit to the
whole device?  But if we keep it, the logic in this funtion should go
into a block layer helper, passing a block device instead of the
dm_interposed_dev.  This avoids having such fragile logic in drivers.

> +	if ((ofs + len) > bdev_nr_sectors(bdev)) {
> +		DMERR("The specified range of sectors exceeds of the size of the block device.");
> +		return -ERANGE;
> +	}
> +
> +	md->ip_dev = kzalloc(sizeof(struct dm_interposed_dev), GFP_KERNEL);
> +	if (!md->ip_dev)
> +		return -ENOMEM;
> +
> +	if ((ofs == 0) && (len == 0))

Lots of superflous inner braces.
