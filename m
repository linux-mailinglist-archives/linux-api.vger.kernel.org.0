Return-Path: <linux-api+bounces-1779-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C686B912084
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F481C23735
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF116E894;
	Fri, 21 Jun 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="fTbZFX1f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rl414+6C"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859816E87A;
	Fri, 21 Jun 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962075; cv=none; b=bX+YrkgiCNYGEwLBAw6BJ2n5G51ezYanDrioXaHLf6zfuaaJhluyv/6xA8rizqssG3caZkjasuGb8Y0WNt8Pjc2ks1c0M3B/9GpJHRQADCNIh5hiRC6yxDG2L1ieHBLMs9xoovcqB1bmofY+KpgHk75dPVN89hAhriNerHcQRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962075; c=relaxed/simple;
	bh=nM7LTszmPvuuu0dhLJaLtzxRSfEmV8pfdUFj7EveWxs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OPmZcWzHVYqUvPsXUyhMf8KEkeH5d8H9w5S41uQY1VgbUsxgHgPQXyywfrLuHUPUyshdY8pMwZqbo4SBxUE47+LRAlhDtCQqkz60gWpZusgLAoPosk/vd8kJV2tfs1DfauBER0xGk90qFu0gzu5MnkE4VJG9PRfmQorbhXcF7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=fTbZFX1f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rl414+6C; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C1A2011401F4;
	Fri, 21 Jun 2024 05:27:52 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Fri, 21 Jun 2024 05:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718962072; x=1719048472; bh=Y8IBkZlexo
	lr5cfgEz+BjS3AEENMDxiAYHTFGs+LnYY=; b=fTbZFX1fL2lnK1lURKuiCY7uwW
	UnNTjJ8sZ/NsLG0EkTlAr86muPsYwRuKg9jiYTdE5Sscj/JCYyi4EWghTVKl3W0P
	fNaJJr+FUR1V3GvzX97magDd32gcEYdS1KjOKNDazy744OCHf52ofJAsE0dJQtMO
	MDvFWqjAMHqoz8Y+U33iBjX56Ep2X3MZnUvSw0Jw73MehRvVj2DLpYhOhCmTfKaf
	iPTIphXkgWywT4893sPptLXWrKPKlGVTzrjQ7+ybW3HV3JbvQLxKXEk5TZ3TkvcY
	AoU+/BUa70uGzHZ4PhW88Ovus5XDUsKnvCXYTx7Ggh0WhV2gnpnhtNgX1SEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718962072; x=1719048472; bh=Y8IBkZlexolr5cfgEz+BjS3AEENM
	DxiAYHTFGs+LnYY=; b=rl414+6C5SXYCYF2IVbg3yzepwyeIRDkxwcOzsPa7Ho4
	wV6zJMtAl9iw7HebLxvfeg1Q0mePjhwpQ92tVPLz0O0tGecYv1v5g/KSVVVI/0NB
	1n26XmwgVMDlHxFL3tuB/mzWqnvbA5gXnyRr99II6/Y4eV45yfMhRW6xmiJWBzPk
	JwbFLEQkvyLbDO/wEs+prYOw3uLJ9Re/jAGwUmV8QJSq0KlsCFC89mnPfCVYp5St
	hwRxrNh4ksx0v2Bu9g5AG33ZayUqepR32YAQ2uEyQocB6y5WuduZUsnUJtBwvWwZ
	LowUV23MJgV+BvH3w4RlxHJCyFkyUiMmv008+JWh/Q==
X-ME-Sender: <xms:mEd1ZkYWClx-m9mr8ueH9SMKtcGGfHAWZ8UKcmWy9s6Kj2k9OzlPJQ>
    <xme:mEd1ZvZ7zMQW4nYZWX5oc_iwN8C-DrpViDlkSlywj_lcM9Ws3gtgby3EoKFBnjKg5
    I-_tNHqSRBbujOPE7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeelffevveffhfeuteetteevteelteduudfgjedvleejteetlefhieeiudfgveel
    feenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:mEd1Zu8jmBSlALriWRB0I5yG16vGL_gKcg0wdwB9rtzcwlDrD9lL9w>
    <xmx:mEd1ZupyRxyWzzlkeedtC2siqLK6sa4-_zx3ZcwYDgFHWLZw-UPVQg>
    <xmx:mEd1ZvrtpVM2PDK14pLKRT1jsqC9jk20yfuXbnEeKtpYF9_HHQKVOg>
    <xmx:mEd1ZsSL02A6uhHucJKbx6hiuYF75BI-zMlxDHw6_PojWi5qy1b0Jw>
    <xmx:mEd1ZgCQ0sMdyEFy-TQmg33AgJfEdU0aijj3ViVaU3e3dxDD9Ua7w_F9>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7E79A2340082; Fri, 21 Jun 2024 05:27:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab40d5d2-a14a-4cb2-b315-b4cb66654f9e@app.fastmail.com>
In-Reply-To: <20240621085745.233107-1-dev@doubly.so>
References: <20240621085745.233107-1-dev@doubly.so>
Date: Fri, 21 Jun 2024 21:27:32 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Devin Bayer" <dev@doubly.so>, corentin.chary@gmail.com
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: support the disable camera LED on F10
 of Zenbook 2023
Content-Type: text/plain

On Fri, 21 Jun 2024, at 8:57 PM, Devin Bayer wrote:
> Adds a sysfs entry for the LED on F10 above the crossed out camera icon on 2023 Zenbooks.
> 
> v2
> - Changed name from `platform::camera` to `asus::camera`
> - Separated patch from patchset
> 
> v1
> - https://lore.kernel.org/platform-driver-x86/20240620082223.20178-1-dev@doubly.so/
> 
> Signed-off-by: Devin Bayer <dev@doubly.so>
> ---
> drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
> include/linux/platform_data/x86/asus-wmi.h |  2 ++
> 2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f07bbf809ef..20b7ed6a27b5 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -73,6 +73,7 @@ module_param(fnlock_default, bool, 0444);
> #define NOTIFY_LID_FLIP_ROG 0xbd
>  
> #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)
> +#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
>  
> #define ASUS_MID_FAN_DESC "mid_fan"
> #define ASUS_GPU_FAN_DESC "gpu_fan"
> @@ -227,6 +228,7 @@ struct asus_wmi {
> struct led_classdev lightbar_led;
> int lightbar_led_wk;
> struct led_classdev micmute_led;
> + struct led_classdev camera_led;
> struct workqueue_struct *led_workqueue;
> struct work_struct tpd_led_work;
> struct work_struct wlan_led_work;
> @@ -1533,6 +1535,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
> return err < 0 ? err : 0;
> }
>  
> +static enum led_brightness camera_led_get(struct led_classdev *led_cdev)
> +{
> + struct asus_wmi *asus;
> + u32 result;
> +
> + asus = container_of(led_cdev, struct asus_wmi, camera_led);
> + asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CAMERA_LED, &result);
> +
> + return result & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
> +}
> +
> +static int camera_led_set(struct led_classdev *led_cdev,
> +    enum led_brightness brightness)
> +{
> + int state = brightness != LED_OFF;
> + int err;
> +
> + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CAMERA_LED, state, NULL);
> + return err < 0 ? err : 0;
> +}
> +
> static void asus_wmi_led_exit(struct asus_wmi *asus)
> {
> led_classdev_unregister(&asus->kbd_led);
> @@ -1540,6 +1563,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
> led_classdev_unregister(&asus->wlan_led);
> led_classdev_unregister(&asus->lightbar_led);
> led_classdev_unregister(&asus->micmute_led);
> + led_classdev_unregister(&asus->camera_led);
>  
> if (asus->led_workqueue)
> destroy_workqueue(asus->led_workqueue);
> @@ -1631,6 +1655,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
> goto error;
> }
>  
> + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
> + asus->camera_led.name = "asus::camera";
> + asus->camera_led.max_brightness = 1;
> + asus->camera_led.brightness_get = camera_led_get;
> + asus->camera_led.brightness_set_blocking = camera_led_set;
> +
> + rv = led_classdev_register(&asus->platform_device->dev,
> + &asus->camera_led);
> + if (rv)
> + goto error;
> + }
> +
> error:
> if (rv)
> asus_wmi_led_exit(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index ab1c7deff118..fb0b00f7d292 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -50,6 +50,8 @@
> #define ASUS_WMI_DEVID_LED5 0x00020015
> #define ASUS_WMI_DEVID_LED6 0x00020016
> #define ASUS_WMI_DEVID_MICMUTE_LED 0x00040017
> +#define ASUS_WMI_DEVID_CAMERA_LED_NEG 0x00060078
> +#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
>  
> /* Backlight and Brightness */
> #define ASUS_WMI_DEVID_ALS_ENABLE 0x00050001 /* Ambient Light Sensor */
> -- 
> 2.45.2
> 

If Hans and Ilpo have no other comments regarding the written C code:

Signed-off-by: Luke D. Jones <luke@ljones.dev>

