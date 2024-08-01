Return-Path: <linux-api+bounces-2077-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1F943AB7
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 02:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F70A1F210CE
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 00:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294014F9D1;
	Thu,  1 Aug 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt2QVlX2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2314F9CA;
	Thu,  1 Aug 2024 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471014; cv=none; b=Jpp0Fw8iW0OPaRJ5hjKDvtCRuKK4soqULe8y3xkNkLZVy3hMYHv/PAJ6ig93LAIIO2z+d8fy4zjvf/AAnnDxpsvQt1fGnWjGhnAaxef/7mUwyR3AauOJPZEbZII5MF+UHd4a5HKZWti9R15YiCW5GLNLaqYFPHl73qNorMCwJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471014; c=relaxed/simple;
	bh=YbTyWDcu6WrIidnVKXHhfitfKU7aLc0gVfbt7UCbH3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSG9dpX1qvLOPJpWIhWUGX5aO4Fcp56LE6O6mOVbOjvjUJ4R502VYmEk2rpjq5l0hGCZi+vbhNTtv1aqBaJcs1Kwcrg/zGSixslpOAjQJmrHMmMD6oEr1W0HKDBVja3cW8eix2X5b8vphaxLu7mBIus1TXZ7ZF6/8UwxbnskQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt2QVlX2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so39759725e9.2;
        Wed, 31 Jul 2024 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722471010; x=1723075810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/mwx5vVIcjnZ4gHpJnA5TwYZW1u+Tk0bqToj01SJqg=;
        b=Vt2QVlX2aP60DYXQBKJfy0KaG0vN46UCTKkB/un4vFX2GvGZ5IRNxqqRxzOHFuKJ/7
         U3Ee8mRKcweLWAPM4qcTRRn+Dv1UuL2XuJGr4YHZpU3j4JZvwcsRJB4HVI9qYM80yn1W
         uQe+HmE9SeZh3FE0PzDOgQb12gWfmv3mnSB1ClMA73PhsnLLuloNQ7sgsIOIHZyO5kQ5
         P5yXsc8Bi4mnUPkUvJ3/VtrrdqJtM/C5lbZQzlf2K2DMxdGG9xQ5uciJZypOCjDflqpK
         pPwV1taSWUh8OvyETIpNfNFVJphPoSa81MvAFEvRniqsQr1HdljeXniczWBgP1jlcU8D
         CwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722471010; x=1723075810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/mwx5vVIcjnZ4gHpJnA5TwYZW1u+Tk0bqToj01SJqg=;
        b=iEQBn1qfpEgMGrm9ctc/jMke0sRt6QYFNu5EhFUd3BDvUBacQaNEBr4pS4L5pFViK9
         hGa6fBvCXl1fjYue5+Q6ZLBeNj+2i2KvKMtRyhzGq7wW0QDY8xaw/wHSp38aLEWAJHth
         f6tqyzvdmZgWmPmagmwylYnVzx8ad6y5fxWf5PP4CPgZTTngQJWCVXi0hBP+W/IVAlye
         uJOqBIkPKakRSgiX8Hf1Dhl7WjogFX5nul137d4i5g9ogs3eN/Y61hzORgQ86cOX0Z7p
         7Kvxtn10qvIyMQBAdl+r79u4mFiY1pzcS5zYDJt16dFob+W2Au0fT7qYHw7MIf1oihkl
         n2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWf+pCBwpP5V+7IeiSZIBwrUqTE3RTVptXZfwWUlxDJy3CRSewS4wYo2C47CZrzbXTnpN2TI5hrbkeaCbOP3yt8FpNJZ8lADWjtS4Pq9DnyfKvDeRSORjuqG8rWZAQ8b9CCno4xAtXA4sx+xMYCesPuOBxLquGI2ZpF7yTAVj3TzUt2
X-Gm-Message-State: AOJu0YwBDhDm/SQR2OJo+mzt19BNgnpWGs1s5Wo3VUZN5LlHvSNvQDw6
	LrN09APMKr/Ux/7sMIbQAkmjzna7rd1m/Z/aDYFsIeff4f1cVezDrBzdWPmLvvkXIyGTTjbbH46
	qDgwTtYdIZg9VXR4cW6x4TZfNaNRXtvaW
X-Google-Smtp-Source: AGHT+IG0xmlD8VwsCSwQEadG9uz+AqblqGFznxg+UWJp1yu3RfxFFcuiOiIrv2lWQwdCNKkOCtMCRr5DNmdB513G93Y=
X-Received: by 2002:adf:e286:0:b0:367:9614:fb99 with SMTP id
 ffacd0b85a97d-36baac9e4a3mr468054f8f.10.1722471010226; Wed, 31 Jul 2024
 17:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com>
 <2024073122-shakable-photo-67d1@gregkh>
In-Reply-To: <2024073122-shakable-photo-67d1@gregkh>
From: Chris Wulff <crwulff@gmail.com>
Date: Wed, 31 Jul 2024 20:09:59 -0400
Message-ID: <CAB0kiBK-G3fyaX6TmS008nDyQ+x1zCZpwe_RT-sNdh78gQeOAQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: f_fs: add capability for dfu run-time descriptor
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Wulff <Chris.Wulff@biamp.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Dmitry Antipov <dmantipov@yandex.ru>, David Sands <david.sands@biamp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 24, 2024 at 10:14:58PM +0000, Chris Wulff wrote:
> > From: David Sands <david.sands@biamp.com>
> >
> > Add the ability for FunctionFS driver to be able to create DFU Run-Time
> > descriptors.
>
> Don't you need some userspace documentation for this as well?

Yes, I will add some.

>
> > --- a/include/uapi/linux/usb/ch9.h
> > +++ b/include/uapi/linux/usb/ch9.h
> > @@ -254,6 +254,9 @@ struct usb_ctrlrequest {
> >  #define USB_DT_DEVICE_CAPABILITY     0x10
> >  #define USB_DT_WIRELESS_ENDPOINT_COMP        0x11
> >  #define USB_DT_WIRE_ADAPTER          0x21
> > +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> > +#define USB_DT_DFU_FUNCTIONAL                0x21
>
> So USB_DT_WIRE_ADAPTER and USB_DT_DFU_FUNCTIONAL are the same?  That
> seems wrong.
>
> > +/* these are from the Wireless USB spec */
>
> What spec?  What "these"?


I inserted the DFU constant in numerical order, splitting the original
section, so I
duplicated the comment. (Partly to make it obvious that there were two with=
 the
same number.) It looks like possibly wireless usb is a dead spec.

You can find wireless usb v1.0 on usb.org in the wayback machine, but it lo=
oks
like most of the references have been purged from the current site, and hav=
e
been gone for a few years. There was apparently a v1.1 too, but I never fou=
nd
a copy of that anywhere.

https://web.archive.org/web/20090325042850/http://www.usb.org/developers/wu=
sb/docs/

A few references remain but say the specification is no longer available. E=
g.
https://www.usb.org/bos-descriptor-types

The original section of code that I inserted the new constant into was:

/* these are from the Wireless USB spec */
#define USB_DT_SECURITY 0x0c
#define USB_DT_KEY 0x0d
#define USB_DT_ENCRYPTION_TYPE 0x0e
#define USB_DT_BOS 0x0f
#define USB_DT_DEVICE_CAPABILITY 0x10
#define USB_DT_WIRELESS_ENDPOINT_COMP 0x11
#define USB_DT_WIRE_ADAPTER 0x21
#define USB_DT_RPIPE 0x22
#define USB_DT_CS_RADIO_CONTROL 0x23
/* From the T10 UAS specification */

>
> >  #define USB_DT_RPIPE                 0x22
> >  #define USB_DT_CS_RADIO_CONTROL              0x23
> >  /* From the T10 UAS specification */
> > @@ -263,6 +266,7 @@ struct usb_ctrlrequest {
> >  /* From the USB 3.1 spec */
> >  #define      USB_DT_SSP_ISOC_ENDPOINT_COMP   0x31
> >
> > +
> >  /* Conventional codes for class-specific descriptors.  The convention =
is
> >   * defined in the USB "Common Class" Spec (3.11).  Individual class sp=
ecs
> >   * are authoritative for their usage, not the "common class" writeup.
>
> Unneeded change?

Yeah, I'll clean that up.

>
> > @@ -329,9 +333,10 @@ struct usb_device_descriptor {
> >  #define USB_CLASS_USB_TYPE_C_BRIDGE  0x12
> >  #define USB_CLASS_MISC                       0xef
> >  #define USB_CLASS_APP_SPEC           0xfe
> > -#define USB_CLASS_VENDOR_SPEC                0xff
> > +#define USB_SUBCLASS_DFU                     0x01
> >
> > -#define USB_SUBCLASS_VENDOR_SPEC     0xff
> > +#define USB_CLASS_VENDOR_SPEC                0xff
> > +#define USB_SUBCLASS_VENDOR_SPEC             0xff
>
> Why reorder these?

The subclasses are specific to the class they are under.
USB_SUBCLASS_DFU is part of USB_CLASS_APP_SPEC
USB_SUBCLASS_VENDOR_SPEC is part of USB_CLASS_VENDOR_SPEC

>
> >
> >  /*--------------------------------------------------------------------=
-----*/
> >
> > diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/u=
sb/functionfs.h
> > index 9f88de9c3d66..6d2061500184 100644
> > --- a/include/uapi/linux/usb/functionfs.h
> > +++ b/include/uapi/linux/usb/functionfs.h
> > @@ -37,6 +37,31 @@ struct usb_endpoint_descriptor_no_audio {
> >       __u8  bInterval;
> >  } __attribute__((packed));
> >
> > +/**
> > + * struct usb_dfu_functional_descriptor - DFU Functional descriptor
> > + * @bLength:         Size of the descriptor (bytes)
> > + * @bDescriptorType: USB_DT_DFU_FUNCTIONAL
> > + * @bmAttributes:    DFU attributes
> > + * @wDetachTimeOut:  Maximum time to wait after DFU_DETACH (ms, le16)
> > + * @wTransferSize:   Maximum number of bytes per control-write (le16)
> > + * @bcdDFUVersion:   DFU Spec version (BCD, le16)
> > + */
> > +struct usb_dfu_functional_descriptor {
> > +     __u8  bLength;
> > +     __u8  bDescriptorType;
> > +     __u8  bmAttributes;
> > +     __le16 wDetachTimeOut;
> > +     __le16 wTransferSize;
> > +     __le16 bcdDFUVersion;
> > +} __attribute__ ((packed));
> > +
> > +/* from DFU functional descriptor bmAttributes */
> > +#define DFU_FUNC_ATT_WILL_DETACH             (1 << 3)
> > +#define DFU_FUNC_ATT_MANIFEST_TOLERANT               (1 << 2)
> > +#define DFU_FUNC_ATT_CAN_UPLOAD                      (1 << 1)
> > +#define DFU_FUNC_ATT_CAN_DOWNLOAD            (1 << 0)
>
> Please use proper BIT macros here to make this more obvious.  And in
> sorted order?

Ok. I'll fix this up

>
> thanks,
>
> greg k-h
>

