Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8732357D05
	for <lists+linux-api@lfdr.de>; Thu,  8 Apr 2021 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhDHHKM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 8 Apr 2021 03:10:12 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:52421 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHHKK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Apr 2021 03:10:10 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id CC1E6DC6F0
        for <linux-api@vger.kernel.org>; Thu,  8 Apr 2021 07:06:58 +0000 (UTC)
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 39717FF807;
        Thu,  8 Apr 2021 07:06:33 +0000 (UTC)
Date:   Thu, 8 Apr 2021 09:06:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH] mtd: add OTP (one-time-programmable) erase ioctl
Message-ID: <20210408090632.62fb6dbc@xps13>
In-Reply-To: <904d986fbd6f718cf8b7b9fc54b339d4@walle.cc>
References: <20210303201819.2752-1-michael@walle.cc>
        <c8f6bd61-528e-0353-aa23-aaec2be2b3ff@microchip.com>
        <904d986fbd6f718cf8b7b9fc54b339d4@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

Michael Walle <michael@walle.cc> wrote on Thu, 08 Apr 2021 08:55:42
+0200:

> Hi Tudor,
> 
> Am 2021-04-08 07:51, schrieb Tudor.Ambarus@microchip.com:
> > Would you please resend this patch, together with the mtd-utils
> > and the SPI NOR patch in a single patch set? You'll help us all
> > having all in a single place.  
> 
> This has already been picked-up:
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=mtd/next&id=e3c1f1c92d6ede3cfa09d6a103d3d1c1ef645e35
> 
> Although, I didn't receive an email notice.
> 
> -michael

Sometimes the notifications are not triggered when there is a conflict
when applying the patch from patchwork directly. I usually answer
manually in this case but I might have forgotten.

About the patch, I felt it was good enough for merging, and I want to
avoid applying such patches right before freezing our branches. Hence,
I tend to be more aggressive earlier in the release cycles because I
hate when my patches get delayed infinitely. The other side is a more
careful approach when -rc6 gets tagged so that I can drop anything which
would be crazily broken before our -next branches are stalled, leading
for an useless public revert. Of course, I am fully open to removing
this patch from -next if you ever feel it was too early and will
happily get rid of it for this release: we can move the patch for the
next release if you agree on this (especially since it touches the
ABI).

Cheers,
Miquèl
