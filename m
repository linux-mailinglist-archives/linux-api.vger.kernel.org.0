Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6533A3DF
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 10:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhCNJ3J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Mar 2021 05:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhCNJ3H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Mar 2021 05:29:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED2C061574;
        Sun, 14 Mar 2021 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cJLxS0cKtxz/yWIdGGPLjrB05uBAS6vzMsJcT1fhpJI=; b=pMazN/6mo7fShBGqzeBn+DuTpk
        9BSTTFQOzPxgPqWRjj9PHehQe2B6KVceoktHco4MA0IWV52RWkBLByYjwvb95zlHEfaDOc9AIa6TN
        8VCzRuScXBb635KoNwhi0iO7jcnk1UB5RQjE+FxEhNtRJAtpn24K/JSRRHDoffwVtCb/NBfdX3zdp
        QB1YThZhLxlPPfZAtk33BkF14AwjjPcWJ3erRssI6xIq2B4uuTbZTulUNGFdDJgmKh+u5lR4/juz9
        FYcmp+Rcafsv61I3Z7WQ/v3QlkWqQIFgE2ONWnKPIBV3q+rhMU6p+3n5FJiMDPLX4CWzE3wUUd3ar
        mlTDF+9w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLN2t-00Fqgg-Df; Sun, 14 Mar 2021 09:28:30 +0000
Date:   Sun, 14 Mar 2021 09:28:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pavel.tide@veeam.com
Subject: Re: [PATCH v7 2/3] block: add bdev_interposer
Message-ID: <20210314092823.GB3773360@infradead.org>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12, 2021 at 06:44:54PM +0300, Sergei Shtepa wrote:
> bdev_interposer allows to redirect bio requests to another devices.

I think this warrants a somewhat more detailed description.

The code itself looks pretty good to me now, a bunch of nitpicks and
a question below:

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

I don't think this case can ever happen:

 - current->bio_list != NULL means a ->submit_bio or blk_mq_submit_bio
   is active.  But if this device is being interposed this means the
   interposer recurses into itself, which should never happen.  So
   I think we'll want a WARN_ON_ONCE here as a debug check instead.

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

Reassigning the bi_bdev here means the original source is lost by the
time we reach the interposer.  This initially seemed a little limiting,
but I guess the interposer driver can just record that information
locally, so we should be fine.  The big upside of this is that no
extra argument to submit_bio_checks, which means less changes to the
normal fast path, so if this works for everyone that is a nice
improvement over my draft.

> +
> +		if (!submit_bio_checks(bio))
> +			break;
> +		/*
> +		 * Because the current->bio_list is initialized,
> +		 * the submit_bio callback will always return BLK_QC_T_NONE.
> +		 */
> +		interposer->bd_disk->fops->submit_bio(bio);
> +	} while (false);

I find the do { ... } while (false) idiom here a little strange.  Normal
kernel style would be a goto done instead of the breaks.

> +int bdev_interposer_attach(struct block_device *original,
> +			   struct block_device *interposer)

A kerneldoc comment for bdev_interposer_attach (and
bdev_interposer_detach) would be nice to explain the API a little more.

> +{
> +	int ret = 0;
> +
> +	if (WARN_ON(((!original) || (!interposer))))
> +		return -EINVAL;

No need for the inner two levels of braces.

> +	 * interposer should be simple, no a multi-queue device
> +	 */
> +	if (!interposer->bd_disk->fops->submit_bio)

Please use queue_is_mq() instead.

> +	if (bdev_has_interposer(original))
> +		ret = -EBUSY;
> +	else {
> +		original->bd_interposer = bdgrab(interposer);

Just thinking out a loud:  what happens if the interposed device
goes away?  Shouldn't we at very least also make sure this
gabs another refererence on bdev as well?

> +struct bdev_interposer;

Not needed any more.

> +static inline bool bdev_has_interposer(struct block_device *bdev)
> +{
> +	return (bdev->bd_interposer != NULL);
> +};

No need for the braces.
