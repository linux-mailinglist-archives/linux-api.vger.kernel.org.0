Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0625F2FF
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIGGJa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 02:09:30 -0400
Received: from verein.lst.de ([213.95.11.211]:47722 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIGGJa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 02:09:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2236B6736F; Mon,  7 Sep 2020 08:09:28 +0200 (CEST)
Date:   Mon, 7 Sep 2020 08:09:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, stern@rowland.harvard.edu,
        akinobu.mita@gmail.com, hch@lst.de, linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Message-ID: <20200907060927.GA18909@lst.de>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com> <20200906012716.1553-1-tom.ty89@gmail.com> <20200906012716.1553-2-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906012716.1553-2-tom.ty89@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Sep 06, 2020 at 09:27:14AM +0800, Tom Yan wrote:
> Provide an ioctl to get the logical sector size so that the maximum
> bytes per request can be derived.
> 
> Follow-up of the BLKSECTGET fix.

I don't think this has any business going in.  /dev/sg is a generic
interface that is not specific to block based command sets.  Just issue
your command set specific command to query the logical block size if
you care about it.
