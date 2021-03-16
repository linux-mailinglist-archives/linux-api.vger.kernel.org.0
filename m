Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341733CA50
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 01:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCPA0X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 20:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCPAZy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 15 Mar 2021 20:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F218F64DD7;
        Tue, 16 Mar 2021 00:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615854354;
        bh=kzru3q3N00y7gWO/p3TyE79suM7+knKvfVLoD0wZ2vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TeW551lnhnuOC5NGOjdlWCJpP18eO5gNiLy9tGd3Wm2FIURLWImz6IGjeT//sOcsz
         B0dlJ/7soHVmmhekMWI5CGNbpHDQ6hkbmZSprWkFQ4n1eT8vXqwzBKu7cD872ls0zA
         f6+0eVSxFUK//JUQw5RLdDLoaXmnXDbx0JwPv21TKbAA45b5eJI97menENmYoxxcEg
         CRzZW/seIl8sMHYn4OCsXWrUxGbeiJuRo0PcrAnBsOTwwakTqgXSZ1CcEiaqZbrINt
         19IN/+jaB9OQE4oRzUzVJGufj8UvbDSPPnbuiqgf2yQgYLfdydZt/YaRhphhJ2Oiau
         893DMQfFpSK9g==
Date:   Tue, 16 Mar 2021 08:25:49 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH v4 2/2] usb: webcam: Invalid size of Processing Unit
 Descriptor
Message-ID: <20210316002549.GB15335@b29397-desktop>
References: <20210315071748.29706-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315071748.29706-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21-03-15 08:17:48, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> According with USB Device Class Definition for Video Device the
> Processing Unit Descriptor bLength should be 12 (10 + bmControlSize),
> but it has 11.
> 
> Invalid length caused that Processing Unit Descriptor Test Video form
> CV tool failed. To fix this issue patch adds bmVideoStandards into
> uvc_processing_unit_descriptor structure.
> 
> The bmVideoStandards field was added in UVC 1.1 and it wasn't part of
> UVC 1.0a.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> 

Reviewed-by: Peter Chen <peter.chen@kernel.org>

> ---
> Changelog:
> v4:
> - fixed compilation error caused by v2
> v3:
> - updated the commit message
> - added bmVideoStandard field to UVC gadget driver
> v2:
> - updated UVC_DT_PROCESSING_UNIT_SIZE macro
> 
>  drivers/usb/gadget/function/f_uvc.c | 1 +
>  drivers/usb/gadget/legacy/webcam.c  | 1 +
>  include/uapi/linux/usb/video.h      | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 5d62720bb9e1..e3b0a79c8f01 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -823,6 +823,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
>  	pd->bmControls[0]		= 1;
>  	pd->bmControls[1]		= 0;
>  	pd->iProcessing			= 0;
> +	pd->bmVideoStandards		= 0;
>  
>  	od = &opts->uvc_output_terminal;
>  	od->bLength			= UVC_DT_OUTPUT_TERMINAL_SIZE;
> diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
> index 3a61de4bb2b1..accb4dacf715 100644
> --- a/drivers/usb/gadget/legacy/webcam.c
> +++ b/drivers/usb/gadget/legacy/webcam.c
> @@ -125,6 +125,7 @@ static const struct uvc_processing_unit_descriptor uvc_processing = {
>  	.bmControls[0]		= 1,
>  	.bmControls[1]		= 0,
>  	.iProcessing		= 0,
> +	.bmVideoStandards	= 0,
>  };
>  
>  static const struct uvc_output_terminal_descriptor uvc_output_terminal = {
> diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
> index d854cb19c42c..bfdae12cdacf 100644
> --- a/include/uapi/linux/usb/video.h
> +++ b/include/uapi/linux/usb/video.h
> @@ -302,9 +302,10 @@ struct uvc_processing_unit_descriptor {
>  	__u8   bControlSize;
>  	__u8   bmControls[2];
>  	__u8   iProcessing;
> +	__u8   bmVideoStandards;
>  } __attribute__((__packed__));
>  
> -#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(9+(n))
> +#define UVC_DT_PROCESSING_UNIT_SIZE(n)			(10+(n))
>  
>  /* 3.7.2.6. Extension Unit Descriptor */
>  struct uvc_extension_unit_descriptor {
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

