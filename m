Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C88260DCE
	for <lists+linux-api@lfdr.de>; Tue,  8 Sep 2020 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgIHInD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Sep 2020 04:43:03 -0400
Received: from verein.lst.de ([213.95.11.211]:52067 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgIHInC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 8 Sep 2020 04:43:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CF9668AFE; Tue,  8 Sep 2020 10:42:58 +0200 (CEST)
Date:   Tue, 8 Sep 2020 10:42:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        dgilbert@interlog.com, Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, akinobu.mita@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Message-ID: <20200908084258.GA17030@lst.de>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com> <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com> <20200907060927.GA18909@lst.de> <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnHSEnWPSaM3xS1MtFUJDrSZPfaH_VwAiQ5UkndFTVe3uWNVA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 07, 2020 at 05:01:34PM +0800, Tom Yan wrote:
> Feel free to omit this. But then you will probably want to ditch
> BLKSECTGET as well, and then any usage of queue_max_sectors(), and
> maybe more/all queue_*().
> 
> I'm not really interested in discussing/arguing whether
> general/ideally-speaking it's appropriate/necessary to keep BLKSECTGET
> / add BLKSSZGET. The only reason I added this is that, when BLKSECTGET
> was introduced to sg long time ago, it was wrongly implemented to
> gives out the limit in bytes, so now when I'm fixing it, I'm merely
> making sure that whatever has been relying on the ioctl (e.g. qemu)
> will only need to do one more ioctl (instead of e.g. doing SCSI in its
> non-SCSI-specific part), if they want/need the limit in bytes. If they
> can be implemented more "generic"-ly, feel free to improve/extend them
> to make them "SG_*-qualified".
> 
> Even if you can do SCSI from the userspace, or even should, I don't
> see any reason that we shouldn't provide an ioctl to do
> queue_logical_block_size() *while we provide one to do
> queue_max_sectors()*.

Well, the different definition in bytes for sg actually makes sense
to me, as a bytes based limit is what fundamentally makes sense for
the passthrough interface.  Only that it reuses the same cmd value
is a bit confusing.  So instead of changing anything and potentially
breaking applications I'd suggest to just better document the semantics.
