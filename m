Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5978A22F
	for <lists+linux-api@lfdr.de>; Mon, 12 Aug 2019 17:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfHLPXl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Aug 2019 11:23:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfHLPXl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Aug 2019 11:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j335fiiDQMBjJDi/0YItD4IEXZCw2bFlsQGThx9UUxc=; b=RFejK4MgtfOMyLRCkPcGWWTXk
        nTXMwXgnvOqZBGhKIdS/oTSJC7Fa85pRnJpLb7/jmoDHvGt61cOj4sd/jUfzOjmAhwKkJxvFq1SaV
        XiwPP5ctlHaLhGtfWQPjQ8/0lfftVXJfOlBjbWk+B0IDUDkXl1kii7giVW1MT54tQFaITVWSYQHgL
        mvUbOF1EpBU8ob8+BygFFUD/GZdH7lceZc9oHRBQ+TOVrjJD1JsXp5w8kquMyGbYL3L+qYdUjt1z+
        vo5heiTAcl4VEqb3Dmlgae8apLDPWMUyZJ0wmeKksUAfdqieEIFJqSdegrazCsWwroeB82cwHwW59
        fLV17OjtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxCAd-0005L5-Uf; Mon, 12 Aug 2019 15:23:39 +0000
Date:   Mon, 12 Aug 2019 08:23:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     James Bottomley <jejb@linux.vnet.ibm.com>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, martin.petersen@oracle.com,
        hare@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
Message-ID: <20190812152339.GA15295@infradead.org>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565291455.3435.48.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 08, 2019 at 12:10:55PM -0700, James Bottomley wrote:
> Since this will be an extension of something that exists both in your
> sg driver and in the block bsg interface (and thus needs an
> implementation there), I added both linux-block and linux-api to the cc
> (the latter because you're adding to an API).
> 
> Simply extending sg to use the v4 header protocol in uapi/linux/bsg.h
> is fine modulo the code being in the right form.  The problems are the
> new ioctls you want to add that would need to be present there as well.
>  The specific question being how we support async or non-blocking I/O
> on the sg and bsg interfaces.  The standard way we add asynchronous I/O
> is supposed to be via .poll on the file descriptor.  you already use
> read and write in sg and bsg doesn't have a polling interface, but it
> looks like we could use MSG to signal an ioctl is ready to be serviced
> for both.  Would shifting to a non-blocking poll based interface for
> ioctls remove the need to add these SG_IOSUBMIT/SG_IORECEIVE ioctls
> since we could now do everything over blocking or non-blocking SG_IO?

I've spent some wading through this patchset, and it is huge.  I thing
we need to stage it a bit better and split it into multiple.

 1) One (or maybe even multiple) with all the cleanups and minor
    speedups.  That alone is a lot of changes, and will take a while
    to settle
 2) extending the bsg/v4 API to /dev/sg.  I think that is very useful,
    although I need to look at the details a bit more
 3) adding a new async API.  While this seems very useful from the
    theoretical perspective, I really thing the guts need to be in
    common code and then be used by sg and the block device nodes
    (if it happens to be an ioctl).  What worries me a bit there
    is that we have another way to deal with async I/O.  I wonder
    if we can fit this into aio/io_uring somehow.  But I'd rather
    not even thing about that much until we've done all the groundwork.
