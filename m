Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA9263C6E
	for <lists+linux-api@lfdr.de>; Thu, 10 Sep 2020 07:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIJF2i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Sep 2020 01:28:38 -0400
Received: from verein.lst.de ([213.95.11.211]:59397 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgIJF2i (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 Sep 2020 01:28:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F3E668B02; Thu, 10 Sep 2020 07:28:35 +0200 (CEST)
Date:   Thu, 10 Sep 2020 07:28:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, akinobu.mita@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Message-ID: <20200910052835.GB18283@lst.de>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com> <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com> <20200907060927.GA18909@lst.de> <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com> <20200908084258.GA17030@lst.de> <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSE=ASs3DG2yp1NpODHimwxHe+=XPRsOyDdkB3ThtyEU-KA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 10, 2020 at 09:59:05AM +0800, Tom Yan wrote:
> If we rename it to e.g. SG_GET_MAX_XFER_BYTES, it will still break
> applications unless we also keep the wrong/ugly/confusing name (and
> you lose the advantage/generality that the two ioctls can be used on
> both sg and "pure" block devices; which seems to be the case of some
> SG_* ioctls as well).

How is that an advantage?  Applications that works with block devices
don't really work with a magic passthrough character device.

> I don't really care enough though. I mean, I'm okay with
> SG_GET_MAX_XFER_BYTES *and* NO "improper" BLKSECTGET. If that will get
> the patch series in, I am willing to send a new version. If not, I'm
> just gonna drop this.

You must assume that there are applications already that depend in the
"weird" BLKSECTGET on sg, given that it has been around so long.  Any
change to the semantics will break them.
