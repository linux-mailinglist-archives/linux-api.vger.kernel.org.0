Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0719033CF59
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 09:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhCPIKX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 04:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234137AbhCPIKR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 04:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615882216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHROXA+CQMQiClGXMoA926mIGShsZigtdFiw3Oqg6pI=;
        b=UKj1t2E2zADyAFO2w7uAeJeXOo/+yYzDVmxO/jWvyCDUnP1fl7vxg1RgtNhLFGyZgXty6+
        K+F5OkQ7vHzPwnbjuu+JrBOkDMShuxru9FTviOynr84RK3eeSPhgcYiM6OXtDPKPZJjo3Z
        2t3PNXJCnkGAJpJJKwSNuwyDjDsVIFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-0eejHMe6OYCq_dHeuffm7g-1; Tue, 16 Mar 2021 04:10:11 -0400
X-MC-Unique: 0eejHMe6OYCq_dHeuffm7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0FB107ACCD;
        Tue, 16 Mar 2021 08:10:10 +0000 (UTC)
Received: from T590 (ovpn-13-0.pek2.redhat.com [10.72.13.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 006DA6A045;
        Tue, 16 Mar 2021 08:09:51 +0000 (UTC)
Date:   Tue, 16 Mar 2021 16:09:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pavel.tide@veeam.com
Subject: Re: [PATCH v7 2/3] block: add bdev_interposer
Message-ID: <YFBnypYemiR08A/c@T590>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12, 2021 at 06:44:54PM +0300, Sergei Shtepa wrote:
> bdev_interposer allows to redirect bio requests to another devices.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  block/bio.c               |  2 ++
>  block/blk-core.c          | 57 +++++++++++++++++++++++++++++++++++++++
>  block/genhd.c             | 54 +++++++++++++++++++++++++++++++++++++
>  include/linux/blk_types.h |  3 +++
>  include/linux/blkdev.h    |  9 +++++++
>  5 files changed, 125 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a1c4d2900c7a..0bfbf06475ee 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -640,6 +640,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>  		bio_set_flag(bio, BIO_THROTTLED);
>  	if (bio_flagged(bio_src, BIO_REMAPPED))
>  		bio_set_flag(bio, BIO_REMAPPED);
> +	if (bio_flagged(bio_src, BIO_INTERPOSED))
> +		bio_set_flag(bio, BIO_INTERPOSED);
>  	bio->bi_opf = bio_src->bi_opf;
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..da1abc4c27a9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1018,6 +1018,55 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  	return ret;
>  }
>  
> +static noinline blk_qc_t submit_bio_interposed(struct bio *bio)
> +{
> +	blk_qc_t ret = BLK_QC_T_NONE;
> +	struct bio_list bio_list[2] = { };
> +	struct gendisk *orig_disk;
> +
> +	if (current->bio_list) {
> +		bio_list_add(&current->bio_list[0], bio);
> +		return BLK_QC_T_NONE;
> +	}
> +
> +	orig_disk = bio->bi_bdev->bd_disk;
> +	if (unlikely(bio_queue_enter(bio)))
> +		return BLK_QC_T_NONE;
> +
> +	current->bio_list = bio_list;
> +
> +	do {
> +		struct block_device *interposer = bio->bi_bdev->bd_interposer;
> +
> +		if (unlikely(!interposer)) {
> +			/* interposer was removed */
> +			bio_list_add(&current->bio_list[0], bio);
> +			break;
> +		}
> +		/* assign bio to interposer device */
> +		bio_set_dev(bio, interposer);
> +		bio_set_flag(bio, BIO_INTERPOSED);
> +
> +		if (!submit_bio_checks(bio))
> +			break;
> +		/*
> +		 * Because the current->bio_list is initialized,
> +		 * the submit_bio callback will always return BLK_QC_T_NONE.
> +		 */
> +		interposer->bd_disk->fops->submit_bio(bio);

Given original request queue may become live when calling attach() and
detach(), see below comment. bdev_interposer_detach() may be run
when running ->submit_bio(), meantime the interposer device is
gone during the period, then kernel oops.

> +	} while (false);
> +
> +	current->bio_list = NULL;
> +
> +	blk_queue_exit(orig_disk->queue);
> +
> +	/* Resubmit remaining bios */
> +	while ((bio = bio_list_pop(&bio_list[0])))
> +		ret = submit_bio_noacct(bio);
> +
> +	return ret;
> +}
> +
>  /**
>   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
>   * @bio:  The bio describing the location in memory and on the device.
> @@ -1029,6 +1078,14 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>   */
>  blk_qc_t submit_bio_noacct(struct bio *bio)
>  {
> +	/*
> +	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
> +	 * created by the bdev_interposer do not get to it for processing.
> +	 */
> +	if (bdev_has_interposer(bio->bi_bdev) &&
> +	    !bio_flagged(bio, BIO_INTERPOSED))
> +		return submit_bio_interposed(bio);
> +
>  	if (!submit_bio_checks(bio))
>  		return BLK_QC_T_NONE;
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index c55e8f0fced1..c840ecffea68 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -30,6 +30,11 @@
>  static struct kobject *block_depr;
>  
>  DECLARE_RWSEM(bdev_lookup_sem);
> +/*
> + * Prevents different block-layer interposers from attaching or detaching
> + * to the block device at the same time.
> + */
> +static DEFINE_MUTEX(bdev_interposer_attach_lock);
>  
>  /* for extended dynamic devt allocation, currently only one major is used */
>  #define NR_EXT_DEVT		(1 << MINORBITS)
> @@ -1940,3 +1945,52 @@ static void disk_release_events(struct gendisk *disk)
>  	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
>  	kfree(disk->ev);
>  }
> +
> +int bdev_interposer_attach(struct block_device *original,
> +			   struct block_device *interposer)
> +{
> +	int ret = 0;
> +
> +	if (WARN_ON(((!original) || (!interposer))))
> +		return -EINVAL;
> +	/*
> +	 * interposer should be simple, no a multi-queue device
> +	 */
> +	if (!interposer->bd_disk->fops->submit_bio)
> +		return -EINVAL;
> +
> +	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
> +		return -EPERM;

The original request queue may become live now...

> +
> +	mutex_lock(&bdev_interposer_attach_lock);
> +
> +	if (bdev_has_interposer(original))
> +		ret = -EBUSY;
> +	else {
> +		original->bd_interposer = bdgrab(interposer);
> +		if (!original->bd_interposer)
> +			ret = -ENODEV;
> +	}
> +
> +	mutex_unlock(&bdev_interposer_attach_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bdev_interposer_attach);
> +
> +void bdev_interposer_detach(struct block_device *original)
> +{
> +	if (WARN_ON(!original))
> +		return;
> +
> +	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
> +		return;

The original request queue may become live now...


-- 
Ming

