Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CAB333540
	for <lists+linux-api@lfdr.de>; Wed, 10 Mar 2021 06:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCJF2X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Mar 2021 00:28:23 -0500
Received: from mx2.veeam.com ([64.129.123.6]:54736 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhCJF2W (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 10 Mar 2021 00:28:22 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id E94784134D;
        Wed, 10 Mar 2021 00:28:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1615354098; bh=7P1LuK7oVuYoBHwxhLnkcL8nA/QjsqG//XB5azxZjzE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=LrGqM1b4VZzXh0wfenVosdSvH1MJXQz0dUCHIpBUr+5vIZc0g5rC1mnc4e13P1Ulf
         201fDQjhAUp3PpfBNsZiiflxIwynxYTBvYwA7vOBWiu2+X3pLKnpKpp61/kK5iYHDn
         2VHDx5yOhiNxLyc8QSsG7AWy9QgbcUZ0RW6haa8g=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Wed, 10 Mar 2021
 06:28:15 +0100
Date:   Wed, 10 Mar 2021 08:28:12 +0300
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
Subject: Re: [PATCH v6 4/4] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210310052812.GB26929@veeam.com>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-5-git-send-email-sergei.shtepa@veeam.com>
 <20210309173555.GC201344@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210309173555.GC201344@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627664
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 03/09/2021 20:35, Christoph Hellwig wrote:
> On Wed, Mar 03, 2021 at 03:30:18PM +0300, Sergei Shtepa wrote:
> > DM_INTERPOSED_FLAG allow to create dm targets on "the fly".
> > Underlying block device opens without a flag FMODE_EXCL.
> > Dm target receives bio from the original device via
> > blk_interposer.
> > 
> > Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> > ---
> >  drivers/md/dm-core.h          |   6 ++
> >  drivers/md/dm-ioctl.c         |   9 +++
> >  drivers/md/dm-table.c         | 115 +++++++++++++++++++++++++++++++---
> >  drivers/md/dm.c               |  38 +++++++----
> >  include/linux/device-mapper.h |   1 +
> >  include/uapi/linux/dm-ioctl.h |   6 ++
> >  6 files changed, 154 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> > index 5953ff2bd260..e5c845f9b1df 100644
> > --- a/drivers/md/dm-core.h
> > +++ b/drivers/md/dm-core.h
> > @@ -21,6 +21,8 @@
> >  
> >  #define DM_RESERVED_MAX_IOS		1024
> >  
> > +struct dm_interposed_dev;
> > +
> >  struct dm_kobject_holder {
> >  	struct kobject kobj;
> >  	struct completion completion;
> > @@ -114,6 +116,10 @@ struct mapped_device {
> >  	bool init_tio_pdu:1;
> >  
> >  	struct srcu_struct io_barrier;
> > +
> > +	/* for interposers logic */
> > +	bool is_interposed;
> > +	struct dm_interposed_dev *ip_dev;
> >  };
> >  
> >  void disable_discard(struct mapped_device *md);
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index 5e306bba4375..2bcb316144a1 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -1267,6 +1267,11 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
> >  	return mode;
> >  }
> >  
> > +static inline bool get_interposer_flag(struct dm_ioctl *param)
> > +{
> > +	return (param->flags & DM_INTERPOSED_FLAG);
> > +}
> > +
> >  static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
> >  		       struct dm_target_spec **spec, char **target_params)
> >  {
> > @@ -1338,6 +1343,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
> >  	if (!md)
> >  		return -ENXIO;
> >  
> > +	md->is_interposed = get_interposer_flag(param);
> > +
> >  	r = dm_table_create(&t, get_mode(param), param->target_count, md);
> >  	if (r)
> >  		goto err;
> > @@ -2098,6 +2105,8 @@ int __init dm_early_create(struct dm_ioctl *dmi,
> >  	if (r)
> >  		goto err_hash_remove;
> >  
> > +	md->is_interposed = get_interposer_flag(dmi);
> > +
> >  	/* add targets */
> >  	for (i = 0; i < dmi->target_count; i++) {
> >  		r = dm_table_add_target(t, spec_array[i]->target_type,
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 95391f78b8d5..0b2f9b66ade5 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -6,6 +6,7 @@
> >   */
> >  
> >  #include "dm-core.h"
> > +#include "dm-interposer.h"
> >  
> >  #include <linux/module.h>
> >  #include <linux/vmalloc.h>
> > @@ -225,12 +226,13 @@ void dm_table_destroy(struct dm_table *t)
> >  /*
> >   * See if we've already got a device in the list.
> >   */
> > -static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev)
> > +static struct dm_dev_internal *find_device(struct list_head *l, dev_t dev, bool is_interposed)
> >  {
> >  	struct dm_dev_internal *dd;
> >  
> >  	list_for_each_entry (dd, l, list)
> > -		if (dd->dm_dev->bdev->bd_dev == dev)
> > +		if ((dd->dm_dev->bdev->bd_dev == dev) &&
> > +		    (dd->dm_dev->is_interposed == is_interposed))
> >  			return dd;
> >  
> >  	return NULL;
> > @@ -358,6 +360,90 @@ dev_t dm_get_dev_t(const char *path)
> >  }
> >  EXPORT_SYMBOL_GPL(dm_get_dev_t);
> >  
> > +/*
> > + * Redirect bio from interposed device to dm device
> > + */
> > +static void dm_interpose_fn(struct dm_interposed_dev *ip_dev, struct bio *bio)
> > +{
> > +	struct mapped_device *md = ip_dev->private;
> > +
> > +	if (bio_flagged(bio, BIO_REMAPPED)) {
> > +		/*
> > +		 * Since bio has already been remapped, we need to subtract
> > +		 * the block device offset from the beginning of the disk.
> > +		 */
> > +		bio->bi_iter.bi_sector -= get_start_sect(bio->bi_bdev);
> > +
> > +		bio_clear_flag(bio, BIO_REMAPPED);
> > +	}
> 
> So instead of doing this shoudn't the imposer just always submit to the
> whole device?  But if we keep it, the logic in this funtion should go
> into a block layer helper, passing a block device instead of the
> dm_interposed_dev.  This avoids having such fragile logic in drivers.

device-mapper allows to create devices of any size using only part of
the underlying device. Therefore, it is not possible to apply the
interposer to the whole block device.
Perhaps it makes sense to put the blk_partition_unremap() function in the
block layer? I'm not sure that's a good thing.

> 
> > +	if ((ofs + len) > bdev_nr_sectors(bdev)) {
> > +		DMERR("The specified range of sectors exceeds of the size of the block device.");
> > +		return -ERANGE;
> > +	}
> > +
> > +	md->ip_dev = kzalloc(sizeof(struct dm_interposed_dev), GFP_KERNEL);
> > +	if (!md->ip_dev)
> > +		return -ENOMEM;
> > +
> > +	if ((ofs == 0) && (len == 0))
> 
> Lots of superflous inner braces.

-- 
Sergei Shtepa
Veeam Software developer.
