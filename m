Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D548266A14
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgIKVdZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 17:33:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36129 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725852AbgIKVdX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Sep 2020 17:33:23 -0400
Received: (qmail 897715 invoked by uid 1000); 11 Sep 2020 17:33:22 -0400
Date:   Fri, 11 Sep 2020 17:33:22 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tom Yan <tom.ty89@gmail.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        akinobu.mita@gmail.com, linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Message-ID: <20200911213322.GA897374@rowland.harvard.edu>
References: <20200906012716.1553-1-tom.ty89@gmail.com>
 <20200906012716.1553-2-tom.ty89@gmail.com>
 <20200907060927.GA18909@lst.de>
 <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
 <20200908084258.GA17030@lst.de>
 <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
 <20200910052835.GB18283@lst.de>
 <CAGnHSE=pcW0zJMSaowdsRXFa=TmOeidekgvDuEPB8PU7mheXNA@mail.gmail.com>
 <20200911064844.GA22190@lst.de>
 <a8d8e0d3-dfd7-5a2d-8f63-5e1816805c8e@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d8e0d3-dfd7-5a2d-8f63-5e1816805c8e@interlog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:07PM -0400, Douglas Gilbert wrote:
> On 2020-09-11 2:48 a.m., Christoph Hellwig wrote:
> > On Fri, Sep 11, 2020 at 10:52:19AM +0800, Tom Yan wrote:
> > > > How is that an advantage?  Applications that works with block devices
> > > > don't really work with a magic passthrough character device.
> > > 
> > > You must assume that there are applications already assuming that
> > > work. (And it will, at least in some cases, if this series get
> > > merged.)
> > 
> > Why "must" I assume that?
> > 
> > > And you have not been giving me a solid point anyway, as I said, it's
> > > just queue_*() at the end of the day; regardless of whether those
> > > would work in all sg cases, we have been using them in the sg driver
> > > anyway.
> > > 
> > > And it's not like we have to guarantee that (the) ioctls can work in
> > > every case anyway, right? (Especially when they aren't named SG_*).
> > 
> > No.  While it is unfortunte we have all kinds of cases of ioctls working
> > differnetly on different devices.
> > 
> > > 
> > > I mean, what's even your point? How do you propose we fix this?
> > 
> > I propose to not "fix" anything, because nothing is broken except for
> > maybe a lack of documentation.
> 
> Alan Stern are you reading this thread? Why do I ask, you may ask?
> Because 'git blame' fingers you:
> 
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> 
> commit 44ec95425c1d9dce6e4638c29e4362cfb44814e7
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Tue Feb 20 11:01:57 2007 -0500
> 
>     [SCSI] sg: cap reserved_size values at max_sectors
> 
>     This patch (as857) modifies the SG_GET_RESERVED_SIZE and
>     SG_SET_RESERVED_SIZE ioctls in the sg driver, capping the values at
>     the device's request_queue's max_sectors value.  This will permit
>     cdrecord to obtain a legal value for the maximum transfer length,
>     fixing Bugzilla #7026.
> 
>     The patch also caps the initial reserved_size value.  There's no
>     reason to have a reserved buffer larger than max_sectors, since it
>     would be impossible to use the extra space.
> 
>     The corresponding ioctls in the block layer are modified similarly,
>     and the initial value for the reserved_size is set as large as
>     possible.  This will effectively make it default to max_sectors.
>     Note that the actual value is meaningless anyway, since block devices
>     don't have a reserved buffer.
> 
>     Finally, the BLKSECTGET ioctl is added to sg, so that there will be a
>     uniform way for users to determine the actual max_sectors value for
>     any raw SCSI transport.
> 
>     Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
>     Acked-by: Jens Axboe <jens.axboe@oracle.com>
>     Acked-by: Douglas Gilbert <dougg@torque.net>
>     Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Oops, I ack-ed this patch from 2007:-)

The Bugzilla entry it talks about is from 2006!

>  Anyway it would seem BLKSECTGET ioctl
> was meant to be a "uniform way to determine the actual max_sectors value for
> any raw SCSI transport."

Right.  The question at hand was: Given an open file descriptor for an 
SG device, how can a program determine the largest amount it can send in 
a single transfer?  This ioctl seemed to be the best answer.

See comment #26 (https://bugzilla.kernel.org/show_bug.cgi?id=7026#c26) 
and following for the viewpoint of the notoriously prickly author of 
cdrecord.

>  Given that the initial implementation of BLKSECTGET
> now seems to be at odds with other implementations, what should we do?
> 
> It is possible that it was correct on 2007 and the BLKSECTGET ioctl has
> changed elsewhere but failed to fix the sg driver's implementation.

Could be.  Also, I'm not sure how careful people were back then to 
distinguish between logical and physical sector sizes.

> If I get a vote then it would be for Tom Yan's approach: reduce entropy or
> it will overwhelm us :-)
> 
> 
> So Christoph, it IS documented, both in the above commit message and:
>    https://doug-gilbert.github.io/sg_v40.html
> 
> in Table 8. So please stop with your "maybe a lack of documentation" line.

My vote is not to change an interface which a program like cdrecord may 
currently rely on.

I can understand Christoph's point about documentation.  It would be 
good to have something in the actual kernel source, rather than in the 
history or somebody's github files.

Alan Stern
