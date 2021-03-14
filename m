Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE8333A25A
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 03:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhCNCTg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Mar 2021 21:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhCNCTL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Mar 2021 21:19:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063ACC061574;
        Sat, 13 Mar 2021 18:19:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2390555C;
        Sun, 14 Mar 2021 03:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615688348;
        bh=4I7l6MsBdcrlbIfCr+pyxXnIMce/5m/JVSnDkBpBzRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4IAs1sTM+B9tCbUOzd1PJ5NxfYmRBrTgA+ewOYiXBgLCA+HPG/E1Gc13DmPqUL3g
         8LdNZ4gAsN82SLOtWXDAFaY5xWkJ3DtlJ2gAzNmb2DeU7oHYH3M2Hc/2SnxAboucTg
         wU9zo73tPE1zVvgzQWmnJrA/kfdw/dEBkD3XvR0g=
Date:   Sun, 14 Mar 2021 04:18:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Peter Chen <peter.chen@kernel.org>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH 1/2] usb: gadget: uvc: Updating bcdUVC field to 0x0110
Message-ID: <YE1yeEPwHoMgML0s@pendragon.ideasonboard.com>
References: <20210308102735.9251-1-pawell@gli-login.cadence.com>
 <20210314015846.GB17526@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210314015846.GB17526@b29397-desktop>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Pawel,

Thank you for the patch.

On Sun, Mar 14, 2021 at 09:58:46AM +0800, Peter Chen wrote:
> On 21-03-08 11:27:34, Pawel Laszczak wrote:
> > From: Pawel Laszczak <pawell@cadence.com>
> > 
> > Command Verifier during UVC Descriptor Tests (Class Video Control
> > Interface Descriptor Test Video) compleins about:
> 
> %s/compleins/complains
> 
> > Video Control Interface Header bcdUVC is 0x0100. USB Video Class
> > specification 1.0 has been replaced by 1.1 specification
> > (UVC: 6.2.26) Class Video Control Interface Descriptor bcdUVC is not 1.1
> 
> What does this (UVC: 6.2.26) mean? There are only 4 chapters for this
> spec, Am I something wrong?

I assume this is a reference to a test case in the test suite.

> > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > ---
> >  drivers/usb/gadget/function/uvc_configfs.c | 2 +-
> >  drivers/usb/gadget/legacy/webcam.c         | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> > index 00fb58e50a15..cd28dec837dd 100644
> > --- a/drivers/usb/gadget/function/uvc_configfs.c
> > +++ b/drivers/usb/gadget/function/uvc_configfs.c
> > @@ -231,7 +231,7 @@ static struct config_item *uvcg_control_header_make(struct config_group *group,
> >  	h->desc.bLength			= UVC_DT_HEADER_SIZE(1);
> >  	h->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
> >  	h->desc.bDescriptorSubType	= UVC_VC_HEADER;
> > -	h->desc.bcdUVC			= cpu_to_le16(0x0100);
> > +	h->desc.bcdUVC			= cpu_to_le16(0x0110);
> >  	h->desc.dwClockFrequency	= cpu_to_le32(48000000);
> >  
> >  	config_item_init_type_name(&h->item, name, &uvcg_control_header_type);
> > diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
> > index a9f8eb8e1c76..3a61de4bb2b1 100644
> > --- a/drivers/usb/gadget/legacy/webcam.c
> > +++ b/drivers/usb/gadget/legacy/webcam.c
> > @@ -90,7 +90,7 @@ static const struct UVC_HEADER_DESCRIPTOR(1) uvc_control_header = {
> >  	.bLength		= UVC_DT_HEADER_SIZE(1),
> >  	.bDescriptorType	= USB_DT_CS_INTERFACE,
> >  	.bDescriptorSubType	= UVC_VC_HEADER,
> > -	.bcdUVC			= cpu_to_le16(0x0100),
> > +	.bcdUVC			= cpu_to_le16(0x0110),
> >  	.wTotalLength		= 0, /* dynamic */
> >  	.dwClockFrequency	= cpu_to_le32(48000000),
> >  	.bInCollection		= 0, /* dynamic */

The change looks good to me. With the typo in the commit message fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
