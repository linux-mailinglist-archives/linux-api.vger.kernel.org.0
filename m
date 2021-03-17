Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4333F54B
	for <lists+linux-api@lfdr.de>; Wed, 17 Mar 2021 17:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCQQRV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Mar 2021 12:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232559AbhCQQRI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Mar 2021 12:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615997827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELfQVFAUQ4JQADtBeiTRn2ychDmW2jmEhNf66mea9PA=;
        b=NIfuzLxyCmm0qE+6IjSiqH0en3A3G0yl2H/e8dV03DhiB0o+xODrwGe/weTw77b2PizihS
        AIhSE6i4Jt1rxnfW1sX/waQ7eQOWlagO8PdUATj6gPohuPELKeLV4VFYKwPIGpI7SP4uqi
        DCw27YA73ZwdcwBUgenC4DiSCSNhlJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-eaSNbJBEPKuT39uC2itS5Q-1; Wed, 17 Mar 2021 10:58:31 -0400
X-MC-Unique: eaSNbJBEPKuT39uC2itS5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D481926DA1;
        Wed, 17 Mar 2021 14:58:29 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5371737DD;
        Wed, 17 Mar 2021 14:58:23 +0000 (UTC)
Date:   Wed, 17 Mar 2021 10:58:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 2/3] block: add bdev_interposer
Message-ID: <20210317145822.GA29481@redhat.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-3-git-send-email-sergei.shtepa@veeam.com>
 <YFBnypYemiR08A/c@T590>
 <20210316163544.GA31272@veeam.com>
 <YFFxdz84esfiTvNk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFFxdz84esfiTvNk@T590>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 16 2021 at 11:03pm -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Tue, Mar 16, 2021 at 07:35:44PM +0300, Sergei Shtepa wrote:
> > The 03/16/2021 11:09, Ming Lei wrote:
> > > On Fri, Mar 12, 2021 at 06:44:54PM +0300, Sergei Shtepa wrote:
> > > > bdev_interposer allows to redirect bio requests to another devices.
> > > > 
> > > > Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>

...

> > > > +
> > > > +int bdev_interposer_attach(struct block_device *original,
> > > > +			   struct block_device *interposer)
> > > > +{
> > > > +	int ret = 0;
> > > > +
> > > > +	if (WARN_ON(((!original) || (!interposer))))
> > > > +		return -EINVAL;
> > > > +	/*
> > > > +	 * interposer should be simple, no a multi-queue device
> > > > +	 */
> > > > +	if (!interposer->bd_disk->fops->submit_bio)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (WARN_ON(!blk_mq_is_queue_frozen(original->bd_disk->queue)))
> > > > +		return -EPERM;
> > > 
> > > The original request queue may become live now...
> > 
> > Yes.
> > I will remove the blk_mq_is_queue_frozen() function and use a different
> > approach.
> 
> Looks what attach and detach needs is that queue is kept as frozen state
> instead of being froze simply at the beginning of the two functions, so
> you can simply call freeze/unfreeze inside the two functions.
> 
> But what if 'original' isn't a MQ queue?  queue usage counter is just
> grabed when calling ->submit_bio(), and queue freeze doesn't guarantee there
> isn't any io activity, is that a problem for bdev_interposer use case?

Right, I raised the same concern here:
https://listman.redhat.com/archives/dm-devel/2021-March/msg00135.html
(toward bottom inlined after dm_disk_{freeze,unfreeze}

Anyway, this certainly needs to be addressed.

Mike

