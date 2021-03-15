Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8533B346
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 14:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCONGq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 09:06:46 -0400
Received: from mx2.veeam.com ([64.129.123.6]:48806 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhCONG1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 15 Mar 2021 09:06:27 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id D9844418B2;
        Mon, 15 Mar 2021 09:06:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1615813578; bh=HBLmTesna8PK59lBt7HhhjezdROcGjFkg/1fCkD4cE8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=ZbTpU0itlRmXRiEgLx9BekdUfve16VeoQM4eeCK90AVP/oNmIOiWil7GAgLJoxSlQ
         jk7D2iUUgerjhC/FOCDVrGEiUHaceB+OzWDlN44wEDrcEcB1aqSQf+GClGh8Nk7Z9g
         TSdk5iUT2LTbOdLTXLHKkpEmWMcuJoRL1FpqJWoQ=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 15 Mar 2021
 14:06:15 +0100
Date:   Mon, 15 Mar 2021 16:06:13 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 2/3] block: add bdev_interposer
Message-ID: <20210315130613.GC30489@veeam.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
 <20210314092823.GB3773360@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210314092823.GB3773360@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627C62
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 03/14/2021 12:28, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 06:44:54PM +0300, Sergei Shtepa wrote:
> > bdev_interposer allows to redirect bio requests to another devices.
> 
> I think this warrants a somewhat more detailed description.
> 
> The code itself looks pretty good to me now, a bunch of nitpicks and
> a question below:
> 
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
> 
> I don't think this case can ever happen:
> 
>  - current->bio_list != NULL means a ->submit_bio or blk_mq_submit_bio
>    is active.  But if this device is being interposed this means the
>    interposer recurses into itself, which should never happen.  So
>    I think we'll want a WARN_ON_ONCE here as a debug check instead.

Yes, it is.
Completely remove this check or add "BUG_ON(current->bio_list);" for
an emergency?

> 
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
> 
> Reassigning the bi_bdev here means the original source is lost by the
> time we reach the interposer.  This initially seemed a little limiting,
> but I guess the interposer driver can just record that information
> locally, so we should be fine.  The big upside of this is that no
> extra argument to submit_bio_checks, which means less changes to the
> normal fast path, so if this works for everyone that is a nice
> improvement over my draft.
> 
> > +
> > +		if (!submit_bio_checks(bio))
> > +			break;
> > +		/*
> > +		 * Because the current->bio_list is initialized,
> > +		 * the submit_bio callback will always return BLK_QC_T_NONE.
> > +		 */
> > +		interposer->bd_disk->fops->submit_bio(bio);
> > +	} while (false);
> 
> I find the do { ... } while (false) idiom here a little strange.  Normal
> kernel style would be a goto done instead of the breaks.
> 

Ok. I'll use the normal kernel style.

> > +int bdev_interposer_attach(struct block_device *original,
> > +			   struct block_device *interposer)
> 
> A kerneldoc comment for bdev_interposer_attach (and
> bdev_interposer_detach) would be nice to explain the API a little more.
> 

Yes, I should add kerneldoc comments.

> > +{
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(((!original) || (!interposer))))
> > +		return -EINVAL;
> 
> No need for the inner two levels of braces.

Ok.

> 
> > +	 * interposer should be simple, no a multi-queue device
> > +	 */
> > +	if (!interposer->bd_disk->fops->submit_bio)
> 
> Please use queue_is_mq() instead.

Ok.

> 
> > +	if (bdev_has_interposer(original))
> > +		ret = -EBUSY;
> > +	else {
> > +		original->bd_interposer = bdgrab(interposer);
> 
> Just thinking out a loud:  what happens if the interposed device
> goes away?  Shouldn't we at very least also make sure this
> gabs another refererence on bdev as well?

If the original device is removed from the system, the interposer device
will be permanently occupied. I need to add an interposer release when
deleting a block device.

> 
> > +struct bdev_interposer;
> 
> Not needed any more.

Yes.

> 
> > +static inline bool bdev_has_interposer(struct block_device *bdev)
> > +{
> > +	return (bdev->bd_interposer != NULL);
> > +};
> 
> No need for the braces.

Ok.

-- 
Sergei Shtepa
Veeam Software developer.
