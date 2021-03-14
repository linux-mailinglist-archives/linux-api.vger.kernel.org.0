Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A4633A265
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 03:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhCNCaz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Mar 2021 21:30:55 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45256 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhCNCan (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Mar 2021 21:30:43 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 02C1A55C;
        Sun, 14 Mar 2021 03:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615689042;
        bh=ibheVfpzm+JE73D5nVjhfA/XFmhnMvmRbtXmyfTRNJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDKnyLByxnc+cu3aOpqUV3Jdvti1BSI1I7mvH/zau/rooHUY+NeSQLF+SQYgElm9p
         yOeWXK3alybNmqHy3DipT033C5gL9yy13SovOnpdbzDK/035eSvAWF7QWVet+UvUO0
         TBB0rfZOD7YXure8ouUFaAuHrjhZ78xBLzpuZbUQ=
Date:   Sun, 14 Mar 2021 04:30:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter.chen@kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH 2/2] usb: webcam: Invalid size of Processing Unit
 Descriptor
Message-ID: <YE11Lk3XXbB1B+aD@pendragon.ideasonboard.com>
References: <20210308102735.9251-1-pawell@gli-login.cadence.com>
 <20210308102735.9251-2-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308102735.9251-2-pawell@gli-login.cadence.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Pawel,

Thank you for the patch.

On Mon, Mar 08, 2021 at 11:27:35AM +0100, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> According with USB Device Class Definition for Video Device the
> Processing Unit Descriptor bLength should be 12 (10 + bmControlSize),
> but it has 11.
> 
> Invalid length caused that Processing Unit Descriptor Test Video form
> CV tool failed. To fix this issue patch adds bmVideoStandards into
> uvc_processing_unit_descriptor structure.

The bmVideoStandards field was added in UVC 1.1, it wasn't part of UVC
1.0a. The commit message should explain this.

This change looks good to me, but could you also update
drivers/usb/gadget/legacy/webcam.c and
drivers/usb/gadget/function/f_uvc.c to explicitly set this field to 0 ?

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  include/uapi/linux/usb/video.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
> index d854cb19c42c..2a54e8fdd341 100644
> --- a/include/uapi/linux/usb/video.h
> +++ b/include/uapi/linux/usb/video.h
> @@ -302,6 +302,7 @@ struct uvc_processing_unit_descriptor {
>  	__u8   bControlSize;
>  	__u8   bmControls[2];
>  	__u8   iProcessing;
> +	__u8   bmVideoStandards;
>  } __attribute__((__packed__));
>  
>  #define UVC_DT_PROCESSING_UNIT_SIZE(n)			(9+(n))

-- 
Regards,

Laurent Pinchart
