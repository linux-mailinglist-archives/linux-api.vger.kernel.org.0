Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908B4906A0
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfHPRT2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 13:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfHPRT2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Aug 2019 13:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6D720665;
        Fri, 16 Aug 2019 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565975967;
        bh=d3vXNMjJuc+AuuMg2NCJKt1v5kziFN/XifDdhLiK8eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccyDKIcOWfjWHcQBSGv62ZwodpkYh4GWBDztoOmyVkELSLia758t56f9/kKEPkN7Y
         4piks8OG3LmjFyTBU3fLzKzpQTZhXleZdJe2r+jaKUADpo90nkNjWE3xMC5eFCdDYK
         DD5L9r6EzdvhUABrgL9TQmOSwwOaX6ssfiq4Rhn0=
Date:   Fri, 16 Aug 2019 19:19:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, martin.petersen@oracle.com,
        hare@suse.de, Arnd Bergmann <arnd@arndb.de>,
        Tony Battersby <tonyb@cybernetics.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/20] sg: add v4 interface
Message-ID: <20190816171924.GB20411@kroah.com>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <1565291455.3435.48.camel@linux.vnet.ibm.com>
 <7edab448-22cc-493a-f745-acc5be38f6a5@interlog.com>
 <1565305243.25619.27.camel@linux.vnet.ibm.com>
 <51e7cdfb-7921-9368-9b78-90ba5ac50c77@interlog.com>
 <6606add1-7ae7-5d8d-e660-d267164981d9@acm.org>
 <d0c60641-0607-a9c4-e79d-b6e850ef8682@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c60641-0607-a9c4-e79d-b6e850ef8682@interlog.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 16, 2019 at 11:59:04AM -0400, Douglas Gilbert wrote:
> On 2019-08-15 1:30 p.m., Bart Van Assche wrote:
> > On 8/13/19 9:19 PM, Douglas Gilbert wrote:
> > > Bart Van Assche hinted at a better API design but didn't present
> > > it. If he did, that would be the first time an alternate API
> > > design was presented for async usage in the 20 years that I have
> > > been associated with the driver.
> > 
> > I would like to start from the use cases instead of the implementation
> > of a new SG/IO interface. My employer uses the SG/IO interface for
> > controlling SMR and
> 
> There is no "new" SG/IO interface. Linux has broken the ability of char
> drivers to safely use the read() and write() system calls. This
> adversely impacts the bsg and sg drivers. In response the following
> replacement mappings have been suggested in my first sg patchset:

I don't understand what you mean by "broken the ability of char drivers
to use the read() and write() system calls."

What changed, when did it change, what broke, and why can't we "fix" it
if it really is broken?

thanks,

greg k-h
