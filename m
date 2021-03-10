Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD7333CB1
	for <lists+linux-api@lfdr.de>; Wed, 10 Mar 2021 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCJMfw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Mar 2021 07:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJMf0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Mar 2021 07:35:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A01C061760;
        Wed, 10 Mar 2021 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gI+fVKwWNdRCMXLSxBhBb6g0npcADtH3Xd9db2ybLVU=; b=W6bUKRZIT5KWYpA2Tcf98R55Li
        rdV7pccBhtX/KUEPjKSP+gJVp7A5ngj21LOhWjri3WGIAUHm7+fZ9BGTPyZlpTc35Tfb2GMPa+FJY
        Wr8nhkqe5owRjRQ3ujRu4q4NLgUK+cgUzXcfpSU8xlopjR8uUBFmf8owkXYSs9uLN0KF13GAFWiGX
        VGEtWIl82UpTCEv9b9eBE0fDpqyQ6ENW7K3H60Lhix9ElTsGXgzNyLUJNHQkfXkAMn07xHAogAGpo
        jOdS6/FjHx7+vlm1v+MG/4A5E2AX4GPhfMWveJIYb4gEoNSv4npdzLzRTsPWA6eKYksmRKDP4nEmh
        NKS17l/A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJy3E-003O6D-2z; Wed, 10 Mar 2021 12:34:59 +0000
Date:   Wed, 10 Mar 2021 12:34:56 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>, "hare@suse.de" <hare@suse.de>,
        "song@kernel.org" <song@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v6 4/4] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210310123456.GA758100@infradead.org>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-5-git-send-email-sergei.shtepa@veeam.com>
 <20210309173555.GC201344@infradead.org>
 <20210310052812.GB26929@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310052812.GB26929@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 10, 2021 at 08:28:12AM +0300, Sergei Shtepa wrote:
> > So instead of doing this shoudn't the interposer just always submit to the
> > whole device?  But if we keep it, the logic in this funtion should go
> > into a block layer helper, passing a block device instead of the

> 
> device-mapper allows to create devices of any size using only part of
> the underlying device. Therefore, it is not possible to apply the
> interposer to the whole block device.
> Perhaps it makes sense to put the blk_partition_unremap() function in the
> block layer? I'm not sure that's a good thing.

I suspect the answer is to not remap bios that are going to be handled
by the interposer.  In fact much of submit_bio_checks as-is is a bad
idea for interposed devices.  I think what we need to do instead is to
pass an explicit bdev to submit_bio_checks and use that everywhere,
including in the subfunctions.

With that we might also be able to remove the separate interpose hook
and thus struct bdev_interposer entirely as now ->submit_bio of the
interposer could do all the work:

static noinline blk_qc_t submit_bio_interposed(struct bio *bio)
{
	struct block_device *orig_bdev = bio->bi_bdev, *interposer;
	struct bio_list bio_list[2] = { };
	blk_qc_t ret = BLK_QC_T_NONE;

	if (current->bio_list) {
                bio_list_add(&current->bio_list[0], bio);
                return BLK_QC_T_NONE;
        }

	if (unlikely(bio_queue_enter(bio)))
		return BLK_QC_T_NONE;

	interposer = orig_bdev->bd_interposer;
	if (unlikely(!interposer)) {
		/* interposer was removed */
		bio_list_add(&current->bio_list[0], bio);
		goto queue_exit;
	}
	if (!submit_bio_checks(bio, interposer))
		goto queue_exit;

	bio_set_flag(bio, BIO_INTERPOSED);

	current->bio_list = bio_list;
	ret = interposer->bd_disk->fops->submit_bio(bio);
	current->bio_list = NULL;

queue_exit:
	blk_queue_exit(bdev->bd_disk->queue);

	/* Resubmit remaining bios */
	while ((bio = bio_list_pop(&bio_list[0])))
		ret = submit_bio_noacct(bio);
	return ret;
}

blk_qc_t submit_bio_noacct(struct bio *bio)
{
	if (bio->bi_bdev->bd_interposer && !bio_flagged(bio, BIO_INTERPOSED)
		return submit_bio_interposed(bio);
		
	...
}

Note that both with this and your original code the interposer must
never resubmit I/O to itself.  Is that actually the case for DM?  I'm
trying to think of a good debug check for that, but right now I can't
think of something that doesn't cause any overhead for n
