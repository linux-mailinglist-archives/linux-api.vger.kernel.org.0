Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD3265992
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 08:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgIKGsu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 02:48:50 -0400
Received: from verein.lst.de ([213.95.11.211]:35691 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGsr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Sep 2020 02:48:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2702967373; Fri, 11 Sep 2020 08:48:45 +0200 (CEST)
Date:   Fri, 11 Sep 2020 08:48:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, akinobu.mita@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Message-ID: <20200911064844.GA22190@lst.de>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com> <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com> <20200907060927.GA18909@lst.de> <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com> <20200908084258.GA17030@lst.de> <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com> <20200910052835.GB18283@lst.de> <CAGnHSE=pcW0zJMSaowdsRXFa=TmOeidekgvDuEPB8PU7mheXNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSE=pcW0zJMSaowdsRXFa=TmOeidekgvDuEPB8PU7mheXNA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 11, 2020 at 10:52:19AM +0800, Tom Yan wrote:
> > How is that an advantage?  Applications that works with block devices
> > don't really work with a magic passthrough character device.
> 
> You must assume that there are applications already assuming that
> work. (And it will, at least in some cases, if this series get
> merged.)

Why "must" I assume that?

> And you have not been giving me a solid point anyway, as I said, it's
> just queue_*() at the end of the day; regardless of whether those
> would work in all sg cases, we have been using them in the sg driver
> anyway.
> 
> And it's not like we have to guarantee that (the) ioctls can work in
> every case anyway, right? (Especially when they aren't named SG_*).

No.  While it is unfortunte we have all kinds of cases of ioctls working
differnetly on different devices.

> 
> I mean, what's even your point? How do you propose we fix this?

I propose to not "fix" anything, because nothing is broken except for
maybe a lack of documentation.
