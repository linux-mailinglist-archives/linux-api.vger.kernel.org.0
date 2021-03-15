Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0123433B3D4
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCONZh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 09:25:37 -0400
Received: from mx4.veeam.com ([104.41.138.86]:53066 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCONZP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 15 Mar 2021 09:25:15 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 4FDA832F9F;
        Mon, 15 Mar 2021 16:25:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615814713; bh=jGq0svZPmtl01jelq6P2Cc9ZwqyJe3BkWfzivXHT4Io=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=aca5kLwaHgqvkrFf7D5LcXAmWTjK6izYDQyQ5YBQZHkiwYgn3M0naYEdASM/s7mYs
         kTCwxC7V1cJ+EzpODLDVqKwQHGlVaBbuALMfXno8Fc0QEOXREGCoKWbOrcVSXxRDEp
         +a41olwOCNsJif5OZqfMc0rj/ZXbuZbyjTWe48GE=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 15 Mar 2021
 14:25:11 +0100
Date:   Mon, 15 Mar 2021 16:25:09 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210315132509.GD30489@veeam.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
 <20210314093038.GC3773360@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210314093038.GC3773360@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627C62
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 03/14/2021 12:30, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 06:44:55PM +0300, Sergei Shtepa wrote:
> > DM_INTERPOSED_FLAG allow to create DM targets on "the fly".
> > Underlying block device opens without a flag FMODE_EXCL.
> > DM target receives bio from the original device via
> > bdev_interposer.
> 
> This is more of a philopical comment, but the idea of just letting the
> interposed reopen the device by itself seems like a bad idea.  I think
> that is probably better hidden in the block layer interposer attachment
> function, which could do the extra blkdev_get_by_dev for the caller.

I suppose this cannot be implemented, since we need to change the behavior
for block devices that already have been opened.

-- 
Sergei Shtepa
Veeam Software developer.
