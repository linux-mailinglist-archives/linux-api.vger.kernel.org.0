Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B624233D987
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhCPQgH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 12:36:07 -0400
Received: from mx4.veeam.com ([104.41.138.86]:59098 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237871AbhCPQf6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 16 Mar 2021 12:35:58 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 3FCF38A77C;
        Tue, 16 Mar 2021 19:35:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615912553; bh=F1gKLL7wk3iE1vLbPnTkUW3slRzh6GWWwMLJyS5YH1U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=LgzU5IuRT4MU2/aszmA5F9lbIBFZyR0JP9db5s+sCQFZiTjb45y6KnOJxlsOfzgGF
         2TgpDyaufoHsv+9icTxQL+xZ6vLqIKVJ3pB4tYjq5umA9JBEcWgrbih71QTueezVpN
         YP/fey343S+4gT4Xc9pWcLfTWJlQBacMoU6aItoE=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Tue, 16 Mar 2021
 17:35:50 +0100
Date:   Tue, 16 Mar 2021 19:35:44 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 2/3] block: add bdev_interposer
Message-ID: <20210316163544.GA31272@veeam.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
 <YFBnypYemiR08A/c@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YFBnypYemiR08A/c@T590>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B586D756B
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 03/16/2021 11:09, Ming Lei wrote:
> On Fri, Mar 12, 2021 at 06:44:54PM +0300, Sergei Shtepa wrote:
> > bdev_interposer allows to redirect bio requests to another devices.
> > 
> > Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> > ---
> >  block/bio.c               |  2 ++
> >  block/blk-core.c          | 57 +++++++++++++++++++++++++++++++++++++++
> >  block/genhd.c             | 54 +++++++++++++++++++++++++++++++++++++
> >  include/linux/blk_types.h |  3 +++
> >  include/linux/blkdev.h    |  9 +++++++
> >  5 files changed, 125 insertions(+)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index a1c4d2900c7a..0bfbf06475ee 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -640,6 +640,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
> >  		bio_set_flag(bio, BIO_THROTTLED);
> >  	if (bio_flagged(bio_src, BIO_REMAPPED))
> >  		bio_set_flag(bio, BIO_REMAPPED);
> > +	if (bio_flagged(bio_src, BIO_INTERPOSED))
> > +		bio_set_flag(bio, BIO_INTERPOSED);
> >  	bio->bi_opf = bio_src->bi_opf;
> >  	bio->bi_ioprio = bio_src->bi_ioprio;
> >  	bio->bi_write_hint = bio_src->bi_write_hint;
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index fc60ff208497..da1abc4c27a9 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1018,6 +1018,55 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> >  	return ret;
> >  }
> >  
> > +static noinline blk_qc_t submit_bio_interposed(struct bio *bio)
> > +{
> > +	blk_qc_t ret = BLK_QC_T_NONE;
> > +	struct bio_list bio_list[2] = { };
> > +	struct gendisk *orig_disk;
> > +
> > +	if (current->bio_list) {
> > +		bio_list_add(&current->bio_list[0], bio);
> > +		return BLK_QC_T_NONE;
> > +	}
> > +
> > +	orig_disk = bio->bi_bdev->bd_disk;
> > +	if (unlikely(bio_queue_enter(bio)))
> > +		return BLK_QC_T_NONE;
> > +
> > +	current->bio_list = bio_list;
> > +
> > +	do {
> > +		struct block_device *interposer = bio->bi_bdev->bd_interposer;
> > +
> > +		if (unlikely(!interposer)) {
> > +			/* interposer was removed */
> > +			bio_list_add(&current->bio_list[0], bio);
> > +			break;
> > +		}
> > +		/* assign bio to interposer device */
> > +		bio_set_dev(bio, interposer);
> > +		bio_set_flag(bio, BIO_INTERPOSED);
> > +
> > +		if (!submit_bio_checks(bio))
> > +			break;
> > +		/*
> > +		 * Because the current->bio_list is initialized,
> > +		 * the submit_bio callback will always return BLK_QC_T_NONE.
> > +		 */
> > +		interposer->bd_disk->fops->submit_bio(bio);
> 
> Given original request queue may become live when calling attach() and
> detach(), see below comment. bdev_interposer_detach() may be run
> when running ->submit_bio(), meantime the interposer device is
> gone during the period, then kernel oops.

I think that since the bio_queue_enter() function was called,
q->q_usage_counter will not allow the critical code in the attach/detach
functions to be executed, which is located between the blk_freeze_queue
and blk_unfreeze_queue calls.
Please correct me if I'm wrong.

> 
> > +	} while (false);
> > +
> > +	current->bio_list = NULL;
> > +
> > +	blk_queue_exit(orig_disk->queue);
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
> > @@ -1029,6 +1078,14 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
> >   */
> >  blk_qc_t submit_bio_noacct(struct bio *bio)
> >  {
> > +	/*
> > +	 * Checking the BIO_INTERPOSED flag is necessary so that the bio
> > +	 * created by the bdev_interposer do not get to it for processing.
> > +	 */
> > +	if (bdev_has_interposer(bio->bi_bdev) &&
> > +	    !bio_flagged(bio, BIO_INTERPOSED))
> > +		return submit_bio_interposed(bio);
> > +
> >  	if (!submit_bio_checks(bio))
> >  		return BLK_QC_T_NONE;
> >  
> > diff --git a/block/genhd.c b/block/genhd.c
> > index c55e8f0fced1..c840ecffea68 100644
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
> > +static DEFINE_MUTEX(bdev_interposer_attach_lock);
> >  
> >  /* for extended dynamic devt allocation, currently only one major is used */
> >  #define NR_EXT_DEVT		(1 << MINORBITS)
> > @@ -1940,3 +1945,52 @@ static void disk_release_events(struct gendisk *disk)
> >  	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
> >  	kfree(disk->ev);
> >  }
> > +
> > +int bdev_interposer_attach(struct block_device *original,
> > +			   struct block_device *interposer)
> > +{
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(((!original) || (!interposer))))
> > +		return -EINVAL;
> > +	/*
> > +	 * interposer should be simple, no a multi-queue device
> > +	 */
> > +	if (!interposer->bd_disk->fops->submit_bio)
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
> > +		return -EPERM;
> 
> The original request queue may become live now...

Yes.
I will remove the blk_mq_is_queue_frozen() function and use a different
approach.

> 
> > +
> > +	mutex_lock(&bdev_interposer_attach_lock);
> > +
> > +	if (bdev_has_interposer(original))
> > +		ret = -EBUSY;
> > +	else {
> > +		original->bd_interposer = bdgrab(interposer);
> > +		if (!original->bd_interposer)
> > +			ret = -ENODEV;
> > +	}
> > +
> > +	mutex_unlock(&bdev_interposer_attach_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(bdev_interposer_attach);
> > +
> > +void bdev_interposer_detach(struct block_device *original)
> > +{
> > +	if (WARN_ON(!original))
> > +		return;
> > +
> > +	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
> > +		return;
> 
> The original request queue may become live now...
> 
> 
> -- 
> Ming
> 

-- 
Sergei Shtepa
Veeam Software developer.
