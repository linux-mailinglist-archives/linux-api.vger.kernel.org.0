Return-Path: <linux-api+bounces-2056-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11267942920
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 10:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348E91C2149C
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE671A7F99;
	Wed, 31 Jul 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KhuDuMBK"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601671A6166;
	Wed, 31 Jul 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414487; cv=none; b=Qdw65llUOLckA8Zb6iMw/LrdovmPksJMW8Q5bjEFqk4jIrzLFZHhIoTanqLI83daxloN2FXu8m+cq/8u9hC7IVBtERl+llxvwJdVAFhYItLn+r5+OEJ/ObYk/20ONKyGDSV/qLMS40iLHCwYardNXCAsd5Lxxa4+ZIyjQb3YDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414487; c=relaxed/simple;
	bh=mlRazMvsK22c0jA4I5oFJzC0Vc4GmS54awPfGY0DxZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeWjvZA1Mf0TCL3H4lkNEYktnGrqPDI4fpLIZjf6HKT+snJgGBZIv0zkI8eD67TbqxoJAUA/btAB1KQOMyzpuB22Oa0JhsURJuhg0a7zil/WzedQAa60wlA3/tnD40lBWY0HKAWx7+zgSlWKayzS6gyJTFCbV822nY34oE0BtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KhuDuMBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41705C116B1;
	Wed, 31 Jul 2024 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722414486;
	bh=mlRazMvsK22c0jA4I5oFJzC0Vc4GmS54awPfGY0DxZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhuDuMBK2U1VnCF/kkcwZOdZz3hWwNradWurT5ECsg4k8JUWibkP9qltixp3BiTMw
	 ry3qmTd1VoOYucQIRJ5J5imc9qUbd3VNqZKwBYI1lanzhRZs12mRYAZEEI+1+wZAj4
	 7t2XxHES86C/SYSoKCaR06MvVWF0LRpjhL7l8z1w=
Date: Wed, 31 Jul 2024 10:27:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Wulff <Chris.Wulff@biamp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	David Sands <david.sands@biamp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] usb: gadget: f_fs: add capability for dfu run-time
 descriptor
Message-ID: <2024073122-shakable-photo-67d1@gregkh>
References: <CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com>

On Wed, Apr 24, 2024 at 10:14:58PM +0000, Chris Wulff wrote:
> From: David Sands <david.sands@biamp.com>
> 
> Add the ability for FunctionFS driver to be able to create DFU Run-Time
> descriptors.

Don't you need some userspace documentation for this as well?

> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -254,6 +254,9 @@ struct usb_ctrlrequest {
>  #define USB_DT_DEVICE_CAPABILITY	0x10
>  #define USB_DT_WIRELESS_ENDPOINT_COMP	0x11
>  #define USB_DT_WIRE_ADAPTER		0x21
> +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> +#define USB_DT_DFU_FUNCTIONAL		0x21

So USB_DT_WIRE_ADAPTER and USB_DT_DFU_FUNCTIONAL are the same?  That
seems wrong.

> +/* these are from the Wireless USB spec */

What spec?  What "these"?

>  #define USB_DT_RPIPE			0x22
>  #define USB_DT_CS_RADIO_CONTROL		0x23
>  /* From the T10 UAS specification */
> @@ -263,6 +266,7 @@ struct usb_ctrlrequest {
>  /* From the USB 3.1 spec */
>  #define	USB_DT_SSP_ISOC_ENDPOINT_COMP	0x31
>  
> +
>  /* Conventional codes for class-specific descriptors.  The convention is
>   * defined in the USB "Common Class" Spec (3.11).  Individual class specs
>   * are authoritative for their usage, not the "common class" writeup.

Unneeded change?

> @@ -329,9 +333,10 @@ struct usb_device_descriptor {
>  #define USB_CLASS_USB_TYPE_C_BRIDGE	0x12
>  #define USB_CLASS_MISC			0xef
>  #define USB_CLASS_APP_SPEC		0xfe
> -#define USB_CLASS_VENDOR_SPEC		0xff
> +#define USB_SUBCLASS_DFU			0x01
>  
> -#define USB_SUBCLASS_VENDOR_SPEC	0xff
> +#define USB_CLASS_VENDOR_SPEC		0xff
> +#define USB_SUBCLASS_VENDOR_SPEC		0xff

Why reorder these?

>  
>  /*-------------------------------------------------------------------------*/
>  
> diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/usb/functionfs.h
> index 9f88de9c3d66..6d2061500184 100644
> --- a/include/uapi/linux/usb/functionfs.h
> +++ b/include/uapi/linux/usb/functionfs.h
> @@ -37,6 +37,31 @@ struct usb_endpoint_descriptor_no_audio {
>  	__u8  bInterval;
>  } __attribute__((packed));
>  
> +/**
> + * struct usb_dfu_functional_descriptor - DFU Functional descriptor
> + * @bLength:		Size of the descriptor (bytes)
> + * @bDescriptorType:	USB_DT_DFU_FUNCTIONAL
> + * @bmAttributes:	DFU attributes
> + * @wDetachTimeOut:	Maximum time to wait after DFU_DETACH (ms, le16)
> + * @wTransferSize:	Maximum number of bytes per control-write (le16)
> + * @bcdDFUVersion:	DFU Spec version (BCD, le16)
> + */
> +struct usb_dfu_functional_descriptor {
> +	__u8  bLength;
> +	__u8  bDescriptorType;
> +	__u8  bmAttributes;
> +	__le16 wDetachTimeOut;
> +	__le16 wTransferSize;
> +	__le16 bcdDFUVersion;
> +} __attribute__ ((packed));
> +
> +/* from DFU functional descriptor bmAttributes */
> +#define DFU_FUNC_ATT_WILL_DETACH		(1 << 3)
> +#define DFU_FUNC_ATT_MANIFEST_TOLERANT		(1 << 2)
> +#define DFU_FUNC_ATT_CAN_UPLOAD			(1 << 1)
> +#define DFU_FUNC_ATT_CAN_DOWNLOAD		(1 << 0)

Please use proper BIT macros here to make this more obvious.  And in
sorted order?

thanks,

greg k-h

