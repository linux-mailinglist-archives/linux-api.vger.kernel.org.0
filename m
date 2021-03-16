Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE733D77D
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 16:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCPPbl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 11:31:41 -0400
Received: from casper.infradead.org ([90.155.50.34]:37634 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhCPPbc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 11:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2LFHkTsbHPGvR5g6piEA0fvad3DcfT58cnGlmZRHYxs=; b=SmkVxld2/3wHzaFeYQD+egXhSj
        L7BVcHR8AYpXEa7EaRy9Y6/uic1TmA6nuyXq6JLKgxEaRUBYbZ137cq6Id2jXRz+ZeoyfljtYwfdq
        mPv1APPaZDCodHCZSs6V4eo3q+LNv6rkbEDws06jEuEKHy/ncJ7lq/VKrG745fBs0A8YFKqyPu3O5
        ARFJpkb5jRqrcPwp8ZyAWmDX8dWOPBRa+KidI3PgQuHz92dFfUXTGcwoIoBl86cvxV2866vJ8qBFf
        VtODKAayUQEul+uh4hdiVpvnaLEj02mN5+CsJC8vYCNsJpE2AwxCHMpwdaABruEODHwUhBZcneAX+
        P1jUU5Lg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMBXO-000EUG-5Z; Tue, 16 Mar 2021 15:23:15 +0000
Date:   Tue, 16 Mar 2021 15:23:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210316152314.GA55391@infradead.org>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
 <20210314093038.GC3773360@infradead.org>
 <20210315132509.GD30489@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315132509.GD30489@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 15, 2021 at 04:25:09PM +0300, Sergei Shtepa wrote:
> The 03/14/2021 12:30, Christoph Hellwig wrote:
> > On Fri, Mar 12, 2021 at 06:44:55PM +0300, Sergei Shtepa wrote:
> > > DM_INTERPOSED_FLAG allow to create DM targets on "the fly".
> > > Underlying block device opens without a flag FMODE_EXCL.
> > > DM target receives bio from the original device via
> > > bdev_interposer.
> > 
> > This is more of a philopical comment, but the idea of just letting the
> > interposed reopen the device by itself seems like a bad idea.  I think
> > that is probably better hidden in the block layer interposer attachment
> > function, which could do the extra blkdev_get_by_dev for the caller.
> 
> I suppose this cannot be implemented, since we need to change the behavior
> for block devices that already have been opened.

That's not what I mean.  Take a look at the patch relative to your
series to let me know what you think.  The new blkdev_interposer_attach
now takes a dev_t + mode for the original device and opens it on
behalf of the interposer.  It also moves the queue freezing into the
API, which should address the concerns about the helper and adds a few
more sanity checks.
