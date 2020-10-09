Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413F7288C93
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbgJIP3b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Oct 2020 11:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbgJIP3a (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Oct 2020 11:29:30 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6556F22261;
        Fri,  9 Oct 2020 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602257370;
        bh=+a0QD0XOHMqpJMDLxqtDZCq4Dwlwyp9i1c41fzMX1OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WisCFbIltSHyFXLFhQO4rA5pwBjFv/nI+bjQ8ReG69XF0XaKek5yAsO40Yhn+GiVG
         nqNr4K9oEVOBYyADjiYWFr4LxShsVK5a8sOK5DyUC5K9HrFrNzXl9cxycpDtBRBGl/
         HDWTV3nJTzzP6RpdrhbXyKe207PlVvW7/JXd+s60=
Date:   Fri, 9 Oct 2020 08:29:27 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de, linux-api@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 1/3] block: add zone specific block statuses
Message-ID: <20201009152927.GA1023921@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200924205330.4043232-1-kbusch@kernel.org>
 <20200924205330.4043232-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924205330.4043232-2-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 24, 2020 at 01:53:28PM -0700, Keith Busch wrote:
> A zoned device with limited resources to open or activate zones may
> return an error when the host exceeds those limits. The same command may
> be successful if retried later, but the host needs to wait for specific
> zone states before it should expect a retry to succeed. Have the block
> layer provide an appropriate status for these conditions so applications
> can distinuguish this error for special handling.

Hi Jens,

Can be considered for inclusion? The series still applies cleanly to
block for-next.
