Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865F333494
	for <lists+linux-api@lfdr.de>; Wed, 10 Mar 2021 05:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhCJEy2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 23:54:28 -0500
Received: from mx4.veeam.com ([104.41.138.86]:33674 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhCJEx5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 9 Mar 2021 23:53:57 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 258C58A78F;
        Wed, 10 Mar 2021 07:53:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615352003; bh=2S21cNEoC4DbfsoORby8T13WajgTXFAjKBIA+uaX2aE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=QtWonQjbibxg7PZTL6pPo2iQzhB1y6WPs9Kj91BVqNOzkatCN2LXOOaycR+prKhxH
         aOicCeOvms9IaolW3eJyHnM9LuGO+03WfHCn6tYLD19DuhrJoPkDHrH64QhQmjvWao
         EGrjxZMSZgwO6R9Vx2tzmpfQi6OGjX9XxjIc7dJ4=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 10 Mar 2021
 05:53:20 +0100
Date:   Wed, 10 Mar 2021 07:53:13 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>, "hare@suse.de" <hare@suse.de>,
        "song@kernel.org" <song@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v6 2/4] block: add blk_interposer
Message-ID: <20210310045313.GA26929@veeam.com>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-3-git-send-email-sergei.shtepa@veeam.com>
 <20210309172717.GB201344@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210309172717.GB201344@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627664
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thank you, Christoph, for the review.
I will correct all except two points.

The 03/09/2021 20:27, Christoph Hellwig wrote:
> > +static blk_qc_t __submit_bio_interposed(struct bio *bio)
> > +{
> > +	struct bio_list bio_list[2] = { };
> > +	blk_qc_t ret = BLK_QC_T_NONE;
> > +
> > +	current->bio_list = bio_list;
> > +	if (likely(bio_queue_enter(bio) == 0)) {
> > +		struct block_device *bdev = bio->bi_bdev;
> > +
> > +		if (likely(bdev_has_interposer(bdev))) {
> > +			bio_set_flag(bio, BIO_INTERPOSED);
> > +			bdev->bd_interposer->ip_submit_bio(bio);
> > +		} else {
> > +			/* interposer was removed */
> > +			bio_list_add(&current->bio_list[0], bio);
> > +		}
> > +
> > +		blk_queue_exit(bdev->bd_disk->queue);
> > +	}
> > +	current->bio_list = NULL;
> > +
> > +	/* Resubmit remaining bios */
> > +	while ((bio = bio_list_pop(&bio_list[0])))
> > +		ret = submit_bio_noacct(bio);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> >   * @bio:  The bio describing the location in memory and on the device.
> > @@ -1043,6 +1071,14 @@ blk_qc_t submit_bio_noacct(struct bio *bio)
> >  		return BLK_QC_T_NONE;
> >  	}
> >  
> > +	/*
> > +	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
> > +	 * created by the bdev_interposer do not get to it for processing.
> > +	 */
> > +	if (bdev_has_interposer(bio->bi_bdev) &&
> > +	    !bio_flagged(bio, BIO_INTERPOSED))
> > +		return __submit_bio_interposed(bio);
> > +
> >  	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
> >  		return __submit_bio_noacct_mq(bio);
> >  	return __submit_bio_noacct(bio);
> > diff --git a/block/genhd.c b/block/genhd.c
> > index fcc530164b5a..1ae8516643c8 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -30,6 +30,11 @@
> >  static struct kobject *block_depr;
> >  
> >  DECLARE_RWSEM(bdev_lookup_sem);
> > +/*
> > + * Prevents different block-layer interposers from attaching or detaching
> > + * to the block device at the same time.
> > + */
> > +DEFINE_MUTEX(bdev_interposer_attach_lock);
> 
> This one can and should be marked static.
> 
> > +int bdev_interposer_attach(struct block_device *bdev, struct bdev_interposer *interposer,
> 
> Please avoid the overly long line.
> 
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!interposer))
> 
> WARN_ON_ONCE?

This function should be called quite rarely, and the absence of the interposer
parameter indicates that the function is being used incorrectly.
I would like to see this warning every time.

> 
> > +		return -EINVAL;
> > +
> > +	if (!blk_mq_is_queue_frozen(bdev->bd_disk->queue))
> > +		return -EPERM;
> 
> This probly should be a WARN_ON_ONCE() as well.

I think it's better to apply WARN_ON here.

> 
> > +
> > +	mutex_lock(&bdev_interposer_attach_lock);
> > +	if (bdev_has_interposer(bdev)) {
> > +		if (bdev->bd_interposer->ip_submit_bio == ip_submit_bio)
> > +			ret = -EALREADY;
> > +		else
> > +			ret = -EBUSY;
> > +		goto out;
> > +	}
> 
> Do we really need the two different error codes here?

I think I need it. If we try to initialize the interposer again, the reason
for this error is most likely in the logic of the module itself.
If the interposer is occupied by someone else, then we need to let know
about it.

> 
> > +
> > +	interposer->ip_submit_bio = ip_submit_bio;
> 
> I'd rather let the caller initialize the field instead of passing the
> submit function separately.

Yes, I think so. This will allow to keep only one parameter of the function.

> 
> > +void bdev_interposer_detach(struct bdev_interposer *interposer,
> > +			  const ip_submit_bio_t ip_submit_bio)
> > +{
> 
> > +	/* Check if it is really our interposer. */
> > +	if (WARN_ON(bdev->bd_interposer->ip_submit_bio != ip_submit_bio))
> > +		goto out;
> 
> I don't really see any need to pass ip_submit_bio just for this check.
> 
> > +	struct bdev_interposer * bd_interposer;
> 
> The * goes just before the member name.
> 
> > +/*
> > + * block layer interposers structure and functions
> > + */
> > +typedef void (*ip_submit_bio_t) (struct bio *bio);
> > +
> > +struct bdev_interposer {
> > +	ip_submit_bio_t ip_submit_bio;
> > +	struct block_device *bdev;
> 
> Do we need the ip_ prefix here?  Also we probably don't really the
> the typedef for the function pointer.

Ok. Maybe submit_bio_hook would be better? or submit_bio_interposer.

> 
> > +#define bdev_has_interposer(bd) ((bd)->bd_interposer != NULL)
> 
> And inline function would be nice here.

-- 
Sergei Shtepa
Veeam Software developer.
