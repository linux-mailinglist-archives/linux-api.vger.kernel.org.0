Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C7333963
	for <lists+linux-api@lfdr.de>; Wed, 10 Mar 2021 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCJKFR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Mar 2021 05:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhCJKFG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Mar 2021 05:05:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244EC06174A;
        Wed, 10 Mar 2021 02:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LuVa+oXdbXA4zmkmkPx1PW6NzzvlYeYE2D2gOIbMwjE=; b=TQZbVS+mdD61bxIXG6v05MBw5n
        /Ri8XBRdul+NOumajbMAGLnKYfoWeqRxu7WZZvK5eE1/lMVfmthEcjXti8vZKamB4E57ShYrCADVO
        FUqfV9r+6w5y4cUAfmuwxCa9qYvUixBdYpBInqvljBi+Zo2ckFrdMOG0YQeQwsehiA27CviFyAs2V
        m1928byywQPHrtqw0/9aObQrKGELZ+EelTC1EJFvTexnyov0wePzIl30dKgPydUsrqT8l++mPXTDn
        56TbkHOVgdrzaWT6ym6bHaQiwFBx2FYLuJqPwu+6b/FvV3HVNOahODOwg/HIpQ7lgXxUiZJI7gGHE
        oHL4LE+g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJvho-0036nv-IR; Wed, 10 Mar 2021 10:04:42 +0000
Date:   Wed, 10 Mar 2021 10:04:40 +0000
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
Subject: Re: [PATCH v6 2/4] block: add blk_interposer
Message-ID: <20210310100440.GA736136@infradead.org>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-3-git-send-email-sergei.shtepa@veeam.com>
 <20210309172717.GB201344@infradead.org>
 <20210310045313.GA26929@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310045313.GA26929@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 10, 2021 at 07:53:13AM +0300, Sergei Shtepa wrote:
> > Please avoid the overly long line.
> > 
> > > +	int ret = 0;
> > > +
> > > +	if (WARN_ON(!interposer))
> > 
> > WARN_ON_ONCE?
> 
> This function should be called quite rarely, and the absence of the interposer
> parameter indicates that the function is being used incorrectly.
> I would like to see this warning every time.

Yes.  Most kernel code would in fact just remove the check entirely
and let the kernel crash to indicate this.  Maybe that is an even
better option for such a grave API usage mistake.

> > > +struct bdev_interposer {
> > > +	ip_submit_bio_t ip_submit_bio;
> > > +	struct block_device *bdev;
> > 
> > Do we need the ip_ prefix here?  Also we probably don't really the
> > the typedef for the function pointer.
> 
> Ok. Maybe submit_bio_hook would be better? or submit_bio_interposer.

Or interpose_bio?
