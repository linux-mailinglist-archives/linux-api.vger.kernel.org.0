Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7E332D39
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 18:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhCIR2M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 12:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhCIR1z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 12:27:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D69C06174A;
        Tue,  9 Mar 2021 09:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mzC64vV9C496DRhf6U+6CEfaYqC9bqDWwcf1nbhyMUU=; b=hKzg8+7iJYAmX02+ttvJHqs1J9
        rDx35d9wpaaaTWpzoqo/CI2YnrziszEVFYX/1eGA8YiY9zQl7v4+pqQ/0sq7GdV3ChF5uf9gQVZOd
        lkxyiZ2iepU79+nuIn+d8vbeM05p036Y8s3xLmEJBTERXx5AKP76PO4qZQGD4VqKLGeh37o7eNftZ
        NfsL8XY4BLLhJhXK0hg1yCLhiikNid1W2+AZS4M7BjXOCtQJogdBHUFAu0G9C2jmus4zuZQIxAJQD
        99cuFfYliK12YaONgu+T64/l18vmuCKcz7DKDorQS32SFxrPlZ5hoZ5BeNp8v66VUtsMEWhmcXAYw
        IOwOPyNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJg8b-000r8r-Jh; Tue, 09 Mar 2021 17:27:23 +0000
Date:   Tue, 9 Mar 2021 17:27:17 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     snitzer@redhat.com, agk@redhat.com, hare@suse.de, song@kernel.org,
        axboe@kernel.dk, dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-api@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH v6 2/4] block: add blk_interposer
Message-ID: <20210309172717.GB201344@infradead.org>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-3-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614774618-22410-3-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> +static blk_qc_t __submit_bio_interposed(struct bio *bio)
> +{
> +	struct bio_list bio_list[2] = { };
> +	blk_qc_t ret = BLK_QC_T_NONE;
> +
> +	current->bio_list = bio_list;
> +	if (likely(bio_queue_enter(bio) == 0)) {
> +		struct block_device *bdev = bio->bi_bdev;
> +
> +		if (likely(bdev_has_interposer(bdev))) {
> +			bio_set_flag(bio, BIO_INTERPOSED);
> +			bdev->bd_interposer->ip_submit_bio(bio);
> +		} else {
> +			/* interposer was removed */
> +			bio_list_add(&current->bio_list[0], bio);
> +		}
> +
> +		blk_queue_exit(bdev->bd_disk->queue);
> +	}
> +	current->bio_list = NULL;
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
> @@ -1043,6 +1071,14 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
>  		return BLK_QC_T_NONE;
>  	}
>  
> +	/*
> +	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
> +	 * created by the bdev_interposer do not get to it for processing.
> +	 */
> +	if (bdev_has_interposer(bio->bi_bdev) &&
> +	    !bio_flagged(bio, BIO_INTERPOSED))
> +		return __submit_bio_interposed(bio);
> +
>  	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
>  		return __submit_bio_noacct_mq(bio);
>  	return __submit_bio_noacct(bio);
> diff --git a/block/genhd.c b/block/genhd.c
> index fcc530164b5a..1ae8516643c8 100644
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
> +DEFINE_MUTEX(bdev_interposer_attach_lock);

This one can and should be marked static.

> +int bdev_interposer_attach(struct block_device *bdev, struct bdev_interposer *interposer,

Please avoid the overly long line.

> +	int ret = 0;
> +
> +	if (WARN_ON(!interposer))

WARN_ON_ONCE?

> +		return -EINVAL;
> +
> +	if (!blk_mq_is_queue_frozen(bdev->bd_disk->queue))
> +		return -EPERM;

This probly should be a WARN_ON_ONCE() as well.

> +
> +	mutex_lock(&bdev_interposer_attach_lock);
> +	if (bdev_has_interposer(bdev)) {
> +		if (bdev->bd_interposer->ip_submit_bio == ip_submit_bio)
> +			ret = -EALREADY;
> +		else
> +			ret = -EBUSY;
> +		goto out;
> +	}

Do we really need the two different error codes here?

> +
> +	interposer->ip_submit_bio = ip_submit_bio;

I'd rather let the caller initialize the field instead of passing the
submit function separately.

> +void bdev_interposer_detach(struct bdev_interposer *interposer,
> +			  const ip_submit_bio_t ip_submit_bio)
> +{

> +	/* Check if it is really our interposer. */
> +	if (WARN_ON(bdev->bd_interposer->ip_submit_bio != ip_submit_bio))
> +		goto out;

I don't really see any need to pass ip_submit_bio just for this check.

> +	struct bdev_interposer * bd_interposer;

The * goes just before the member name.

> +/*
> + * block layer interposers structure and functions
> + */
> +typedef void (*ip_submit_bio_t) (struct bio *bio);
> +
> +struct bdev_interposer {
> +	ip_submit_bio_t ip_submit_bio;
> +	struct block_device *bdev;

Do we need the ip_ prefix here?  Also we probably don't really the
the typedef for the function pointer.

> +#define bdev_has_interposer(bd) ((bd)->bd_interposer != NULL)

And inline function would be nice here.
