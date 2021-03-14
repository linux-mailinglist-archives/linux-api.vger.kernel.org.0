Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE3233A245
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 02:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhCNB7Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Mar 2021 20:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhCNB65 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 13 Mar 2021 20:58:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27AA64EBD;
        Sun, 14 Mar 2021 01:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615687137;
        bh=WHo+lvcZLl9wZV9beuG7CsnjZiWaxGG3Oam9mA1tSOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDy7/pFnKH6AjK0+XbWJWcRvb7ikHCMF91LWazstYgOYC5OZNm7S+5wS8j2ZUCn8d
         Ui/Wrd4SvHHwzmDJPLg+fCKboofjzhUy4rvk7/oPyQTLNI0Z/McFRco3Cb/ka7o1cP
         bYI1D31fgmMl19OUSskw+8mlgM7YyeMu8i2YC0WH/ZN+hO09y3nFtQddElPLyf5dS4
         sl9GR/C6qWV1klll5QQOtz78OmSXSuQkRkgmm92MsRPrDWtPFCVw8uNb8CzYqk2/IO
         19Lrb7ubeWa4mqIiuPIRnIIKkJ/IefMdZ82c9ReS1hDa5h13G7pM1/8e7T4SVUXNn5
         veHW/y9+UJOaQ==
Date:   Sun, 14 Mar 2021 09:58:46 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH 1/2] usb: gadget: uvc: Updating bcdUVC field to 0x0110
Message-ID: <20210314015846.GB17526@b29397-desktop>
References: <20210308102735.9251-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102735.9251-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21-03-08 11:27:34, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Command Verifier during UVC Descriptor Tests (Class Video Control
> Interface Descriptor Test Video) compleins about:

%s/compleins/complains

> 
> Video Control Interface Header bcdUVC is 0x0100. USB Video Class
> specification 1.0 has been replaced by 1.1 specification
> (UVC: 6.2.26) Class Video Control Interface Descriptor bcdUVC is not 1.1

What does this (UVC: 6.2.26) mean? There are only 4 chapters for this
spec, Am I something wrong?

> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/gadget/function/uvc_configfs.c | 2 +-
>  drivers/usb/gadget/legacy/webcam.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
> index 00fb58e50a15..cd28dec837dd 100644
> --- a/drivers/usb/gadget/function/uvc_configfs.c
> +++ b/drivers/usb/gadget/function/uvc_configfs.c
> @@ -231,7 +231,7 @@ static struct config_item *uvcg_control_header_make(struct config_group *group,
>  	h->desc.bLength			= UVC_DT_HEADER_SIZE(1);
>  	h->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
>  	h->desc.bDescriptorSubType	= UVC_VC_HEADER;
> -	h->desc.bcdUVC			= cpu_to_le16(0x0100);
> +	h->desc.bcdUVC			= cpu_to_le16(0x0110);
>  	h->desc.dwClockFrequency	= cpu_to_le32(48000000);
>  
>  	config_item_init_type_name(&h->item, name, &uvcg_control_header_type);
> diff --git a/drivers/usb/gadget/legacy/webcam.c b/drivers/usb/gadget/legacy/webcam.c
> index a9f8eb8e1c76..3a61de4bb2b1 100644
> --- a/drivers/usb/gadget/legacy/webcam.c
> +++ b/drivers/usb/gadget/legacy/webcam.c
> @@ -90,7 +90,7 @@ static const struct UVC_HEADER_DESCRIPTOR(1) uvc_control_header = {
>  	.bLength		= UVC_DT_HEADER_SIZE(1),
>  	.bDescriptorType	= USB_DT_CS_INTERFACE,
>  	.bDescriptorSubType	= UVC_VC_HEADER,
> -	.bcdUVC			= cpu_to_le16(0x0100),
> +	.bcdUVC			= cpu_to_le16(0x0110),
>  	.wTotalLength		= 0, /* dynamic */
>  	.dwClockFrequency	= cpu_to_le32(48000000),
>  	.bInCollection		= 0, /* dynamic */
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen

