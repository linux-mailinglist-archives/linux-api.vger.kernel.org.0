Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77033709C
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 11:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhCKKza (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 05:55:30 -0500
Received: from mx4.veeam.com ([104.41.138.86]:44886 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhCKKy7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 11 Mar 2021 05:54:59 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id B2743114A68;
        Thu, 11 Mar 2021 13:54:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615460091; bh=ysp9Ts3BASY43el8K+K9xpH4kcbWvg9lBmxtjeqWXw4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=kso9SN+yGQEoMFdxtov1n6mfmMQGtgQioYHIOavcU/58x8mJo5gx6obXdt9Kn1I39
         PvfTOxQRq7wueAVxYpJmNmvGphc+QH9m1m39ejT2Hgd4MPQk3wid7k8xQqpt04SBxQ
         wi8sQBfhLOM+a9gzjGFhl1ueHiKyml/fl5g9WpQA=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 11 Mar 2021
 11:54:50 +0100
Date:   Thu, 11 Mar 2021 13:54:42 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>, <snitzer@redhat.com>
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
Subject: Re: [PATCH v6 4/4] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210311105442.GA27754@veeam.com>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-5-git-send-email-sergei.shtepa@veeam.com>
 <20210309173555.GC201344@infradead.org>
 <20210310052812.GB26929@veeam.com>
 <20210310123456.GA758100@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210310123456.GA758100@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627062
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 03/10/2021 15:34, Christoph Hellwig wrote:
> On Wed, Mar 10, 2021 at 08:28:12AM +0300, Sergei Shtepa wrote:
> > > So instead of doing this shoudn't the interposer just always submit to the
> > > whole device?  But if we keep it, the logic in this funtion should go
> > > into a block layer helper, passing a block device instead of the
> 
> > 
> > device-mapper allows to create devices of any size using only part of
> > the underlying device. Therefore, it is not possible to apply the
> > interposer to the whole block device.
> > Perhaps it makes sense to put the blk_partition_unremap() function in the
> > block layer? I'm not sure that's a good thing.
> 
> I suspect the answer is to not remap bios that are going to be handled
> by the interposer.  In fact much of submit_bio_checks as-is is a bad
> idea for interposed devices.  I think what we need to do instead is to
> pass an explicit bdev to submit_bio_checks and use that everywhere,
> including in the subfunctions.
> 
> With that we might also be able to remove the separate interpose hook
> and thus struct bdev_interposer entirely as now ->submit_bio of the
> interposer could do all the work:
> 
> static noinline blk_qc_t submit_bio_interposed(struct bio *bio)
> {
> 	struct block_device *orig_bdev = bio->bi_bdev, *interposer;
> 	struct bio_list bio_list[2] = { };
> 	blk_qc_t ret = BLK_QC_T_NONE;
> 
> 	if (current->bio_list) {
>                 bio_list_add(&current->bio_list[0], bio);
>                 return BLK_QC_T_NONE;
>         }
> 
> 	if (unlikely(bio_queue_enter(bio)))
> 		return BLK_QC_T_NONE;
> 
> 	interposer = orig_bdev->bd_interposer;
> 	if (unlikely(!interposer)) {
> 		/* interposer was removed */
> 		bio_list_add(&current->bio_list[0], bio);
> 		goto queue_exit;
> 	}
> 	if (!submit_bio_checks(bio, interposer))
> 		goto queue_exit;
> 
> 	bio_set_flag(bio, BIO_INTERPOSED);
> 
> 	current->bio_list = bio_list;
> 	ret = interposer->bd_disk->fops->submit_bio(bio);
> 	current->bio_list = NULL;
> 
> queue_exit:
> 	blk_queue_exit(bdev->bd_disk->queue);
> 
> 	/* Resubmit remaining bios */
> 	while ((bio = bio_list_pop(&bio_list[0])))
> 		ret = submit_bio_noacct(bio);
> 	return ret;
> }
> 
> blk_qc_t submit_bio_noacct(struct bio *bio)
> {
> 	if (bio->bi_bdev->bd_interposer && !bio_flagged(bio, BIO_INTERPOSED)
> 		return submit_bio_interposed(bio);
> 		
> 	...
> }

Your point of view is very interesting. I like.
I will try to implement it and check how it works.

So far, I see the problem in that the interposer device has to intercept
all bio requests from the original device. It will not be possible to
implement an interception of some part. Device mapper can create its own
target for a part of the block device.

But maybe it's a good thing. First, there is little real benefit from
being able to intercept bio requests from a part of the block device.
In real use, this may not be necessary. Secondly, it will get rid of the
problem when part of the bio needs to be intercepted, and part does not.

I'd like to know Mike's opinion on this issue.

> 
> Note that both with this and your original code the interposer must
> never resubmit I/O to itself.  Is that actually the case for DM?  I'm
> trying to think of a good debug check for that, but right now I can't
> think of something that doesn't cause any overhead for n

I believe that the BIO_INTERPOSED flag is quite good at solving this
problem. When cloning a bio, the flag is passed, which means that bio
cannot be called twice.


Thank you again.
Because of you, I will have to rewrite some code again ;)
But it's all for the best.
-- 
Sergei Shtepa
Veeam Software developer.
