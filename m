Return-Path: <linux-api+bounces-1795-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69253913F48
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2024 01:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6F6B20C3E
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 23:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33F1850BF;
	Sun, 23 Jun 2024 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="fSOdCTDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4OLnKo1"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E012EBC7;
	Sun, 23 Jun 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719186970; cv=none; b=cLiWIt6/zvFqpeN0hkOZcteFwaIZ1Tgy4MwUUk1D6PEDORI9iAZ5sH/OHny/YHTZe4D5V8Q9SHYcCCivg3E8rFpvJsRJmBsBGcxvP/8Cx7H/lejpJuBF1Ub0xpAk5hzXfJ9zgn2Hdh0qc8ETksxfUhZRYy5IUmzpyL2Uma/nZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719186970; c=relaxed/simple;
	bh=BzrJQyqqj93HXv++utuDMDMI1nYocSZZXkuX0vXZwNg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bj3WqASyJ6H3yNhsViagmcpg0EXpku4jotkvcuGzEfJcX+agh7YU4yX5nG2f71otgx62IzvW+4tB+8c1LfHSN/ncSfYQj1YL5kFfDfmK8eqk2ZYH3PwHx4I1Gt3qs7C1s2ZlqpEUVXn+dO1qR/8Sq6Jek0p8W3UW+v6HKrt3rAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=fSOdCTDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S4OLnKo1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EEC431140215;
	Sun, 23 Jun 2024 19:56:03 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Sun, 23 Jun 2024 19:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1719186963;
	 x=1719273363; bh=89YglT7qqAUo2dbaeUN6Jon9K4TQxMQzwhi22mvAAYk=; b=
	fSOdCTDRipJljKBFQkaMRl8CrdMJdclc150sPn6oP9uYxMRLEvvmoOGJPe442FSi
	wC8qSr757yJsfCcz6m4BAMElVbkMMZvl0NQp1P7qiykK/4ewx74fc3FPiEmRDato
	56H+shigsr88N2qEEx/jKzoSk6LNAhOFVqUjAIAKfM7dDB108tNRzBByFoD1Xv8K
	KjgEbWHjSB/R7UzvaqRgPibdBZK+e3cRgd5q5l6S8uSU7Jk9H73EfGX9ZZ/sd2UV
	5lMrPIsEtTV+k3/QboR85l2yf9hbyWqR5d0MW6cLfaEj0dH6cspbCkjPB31bFwVE
	nBmbBFcjSGa2eP7/XYkp9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719186963; x=
	1719273363; bh=89YglT7qqAUo2dbaeUN6Jon9K4TQxMQzwhi22mvAAYk=; b=S
	4OLnKo1OtCMf6auuHcZu3QysQNvJuWMzSkmRQk+tfuTAxtzoF6jKaWQiVLtfRgMd
	OGSEnqjOoMNNR1tNLRNpLV4dNNVYYkIP31Led0OJ7hRKAd5lbCpqnNLZbd454HfK
	2cjCZGgV8MQZTTHGW5dcqa21sgLJrVcRe9hmEoX7l8Deaf1LRB7NJHZ+VGAtvvB2
	q6z3JDKuE5tDqxePfn9Aj4P4I0t2/kd31Ow1JPaj/AmSUAiBvc094tUM0PCzCBCB
	weboL0JCF1qN80EGjFAt0ROXOQ/owGBIQiZv2y5dNnqPZA2SScQvzYnzzdL4oq8v
	m/n2JL+tL6Ab4T3MigrNA==
X-ME-Sender: <xms:E7Z4ZgiG9r5qGH_t9_CLaNBgZRTiQ6mxgCNiH6RhsxHwvNJtDOup8w>
    <xme:E7Z4ZpBduJIYSWiUhBTBFljrrknTXRN_fbecq3jbcZUQNwmRwYvM4MiwyXPyV8du5
    t1wYfpCgy8oEJcsDpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepueekiedtfeethfeuudegiedtveffteefueeiveejieegkeehgfeghfffgfek
    teevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:E7Z4ZoGOrzS3Pf94ydvD97ZLlde9CQqoq7bg8db5sWd_jldbcctA-Q>
    <xmx:E7Z4ZhT_lqonkHtwaBRXZf8HN6ZbJkjVOM3dAMVvC1b85cj1NEEMaQ>
    <xmx:E7Z4ZtxXKgaEDCxJQqRxfsDwfkjScJnh9kCtG4xXOQkyinh1FyrtJw>
    <xmx:E7Z4Zv6srfLfvUP7bE4qlJhjSfewrXks65p6lfF1RveELrOLGL4FVw>
    <xmx:E7Z4ZgqEHny5ynCU76fZ9oE-JoAWPPcRv-nbZskGnCPF4irolP_ELGnz>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 588782340080; Sun, 23 Jun 2024 19:56:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4a36db49-8fb4-4389-883f-3a07f055a26f@app.fastmail.com>
In-Reply-To: <22352c0a-a853-b28d-a36a-09cc502acb8b@linux.intel.com>
References: <20240621085745.233107-1-dev@doubly.so>
 <ab40d5d2-a14a-4cb2-b315-b4cb66654f9e@app.fastmail.com>
 <22352c0a-a853-b28d-a36a-09cc502acb8b@linux.intel.com>
Date: Mon, 24 Jun 2024 11:55:43 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Devin Bayer" <dev@doubly.so>, corentin.chary@gmail.com,
 "Hans de Goede" <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: asus-wmi: support the disable camera LED on F10
 of Zenbook 2023
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024, at 4:57 AM, Ilpo J=C3=A4rvinen wrote:
> On Fri, 21 Jun 2024, Luke Jones wrote:
>=20
> > On Fri, 21 Jun 2024, at 8:57 PM, Devin Bayer wrote:
> > > Adds a sysfs entry for the LED on F10 above the crossed out camera=
 icon on 2023 Zenbooks.
> > >=20
> > > v2
> > > - Changed name from `platform::camera` to `asus::camera`
> > > - Separated patch from patchset
> > >=20
> > > v1
> > > - https://lore.kernel.org/platform-driver-x86/20240620082223.20178=
-1-dev@doubly.so/
> > >=20
> > > Signed-off-by: Devin Bayer <dev@doubly.so>
> > > ---
> > > drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++=
++++
> > > include/linux/platform_data/x86/asus-wmi.h |  2 ++
> > > 2 files changed, 38 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x8=
6/asus-wmi.c
> > > index 3f07bbf809ef..20b7ed6a27b5 100644
> > > --- a/drivers/platform/x86/asus-wmi.c
> > > +++ b/drivers/platform/x86/asus-wmi.c
> > > @@ -73,6 +73,7 @@ module_param(fnlock_default, bool, 0444);
> > > #define NOTIFY_LID_FLIP_ROG 0xbd
> > > =20
> > > #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)
> > > +#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
> > > =20
> > > #define ASUS_MID_FAN_DESC "mid_fan"
> > > #define ASUS_GPU_FAN_DESC "gpu_fan"
> > > @@ -227,6 +228,7 @@ struct asus_wmi {
> > > struct led_classdev lightbar_led;
> > > int lightbar_led_wk;
> > > struct led_classdev micmute_led;
> > > + struct led_classdev camera_led;
> > > struct workqueue_struct *led_workqueue;
> > > struct work_struct tpd_led_work;
> > > struct work_struct wlan_led_work;
> > > @@ -1533,6 +1535,27 @@ static int micmute_led_set(struct led_class=
dev *led_cdev,
> > > return err < 0 ? err : 0;
> > > }
> > > =20
> > > +static enum led_brightness camera_led_get(struct led_classdev *le=
d_cdev)
> > > +{
> > > + struct asus_wmi *asus;
> > > + u32 result;
> > > +
> > > + asus =3D container_of(led_cdev, struct asus_wmi, camera_led);
> > > + asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CAMERA_LED, &result);
> > > +
> > > + return result & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
> > > +}
> > > +
> > > +static int camera_led_set(struct led_classdev *led_cdev,
> > > +    enum led_brightness brightness)
> > > +{
> > > + int state =3D brightness !=3D LED_OFF;
> > > + int err;
> > > +
> > > + err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_CAMERA_LED, state, =
NULL);
> > > + return err < 0 ? err : 0;
> > > +}
> > > +
> > > static void asus_wmi_led_exit(struct asus_wmi *asus)
> > > {
> > > led_classdev_unregister(&asus->kbd_led);
> > > @@ -1540,6 +1563,7 @@ static void asus_wmi_led_exit(struct asus_wm=
i *asus)
> > > led_classdev_unregister(&asus->wlan_led);
> > > led_classdev_unregister(&asus->lightbar_led);
> > > led_classdev_unregister(&asus->micmute_led);
> > > + led_classdev_unregister(&asus->camera_led);
> > > =20
> > > if (asus->led_workqueue)
> > > destroy_workqueue(asus->led_workqueue);
> > > @@ -1631,6 +1655,18 @@ static int asus_wmi_led_init(struct asus_wm=
i *asus)
> > > goto error;
> > > }
> > > =20
> > > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
> > > + asus->camera_led.name =3D "asus::camera";
> > > + asus->camera_led.max_brightness =3D 1;
> > > + asus->camera_led.brightness_get =3D camera_led_get;
> > > + asus->camera_led.brightness_set_blocking =3D camera_led_set;
> > > +
> > > + rv =3D led_classdev_register(&asus->platform_device->dev,
> > > + &asus->camera_led);
> > > + if (rv)
> > > + goto error;
> > > + }
> > > +
> > > error:
> > > if (rv)
> > > asus_wmi_led_exit(asus);
> > > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/=
linux/platform_data/x86/asus-wmi.h
> > > index ab1c7deff118..fb0b00f7d292 100644
> > > --- a/include/linux/platform_data/x86/asus-wmi.h
> > > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > > @@ -50,6 +50,8 @@
> > > #define ASUS_WMI_DEVID_LED5 0x00020015
> > > #define ASUS_WMI_DEVID_LED6 0x00020016
> > > #define ASUS_WMI_DEVID_MICMUTE_LED 0x00040017
> > > +#define ASUS_WMI_DEVID_CAMERA_LED_NEG 0x00060078
> > > +#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
> > > =20
> > > /* Backlight and Brightness */
> > > #define ASUS_WMI_DEVID_ALS_ENABLE 0x00050001 /* Ambient Light Sens=
or */
> > > --=20
> > > 2.45.2
> > >=20
> >=20
> > If Hans and Ilpo have no other comments regarding the written C code:
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Luke,
>=20
> As I've seen you use S-o-b tag a few times like this, do you actually =
mean=20
> Reviewed-by: tag which tells you've looked through the change and thin=
k=20
> it's good/useful for the kernel?
>=20
> S-o-b relates to authorship of the code in the patch (and should be=20
> there right from the submission, not added like this).

I do. Yes. It's been a tough couple of months.

Reviewed-by: Luke D. Jones <luke@ljones.dev>

> --=20
> i.
>=20
>=20

