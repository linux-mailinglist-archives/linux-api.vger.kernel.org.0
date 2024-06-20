Return-Path: <linux-api+bounces-1774-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B139114D6
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 23:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA70FB21CD3
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031397E58D;
	Thu, 20 Jun 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="pVEHlSzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UY+YRFuP"
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A47711C;
	Thu, 20 Jun 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919669; cv=none; b=ObMnPntmVGsG2ZolQ4g/6poRJoaKxy7JSHoM5hZbrD7qVobT7hhwgb4QjJ3LJI/XkA1GoPeqZpxA5Bdoe2Zx5ajyaeR6hxjVig/dpDQ5i4RaxhrleFM5qwyF+ZGjzpooWXzDhcNUKonllkjTRqvNaf+b7/bvgbfKOOSK3HJud2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919669; c=relaxed/simple;
	bh=WpuU19vmTKbofK2gQplueUgolsFBx2pt9q8yJbUln0s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PFwpj+H1tMnidRdkcOK1kcraO/lQuB4qfZ3VcJf8l7NVAmvtMdPgoQoEHHvvVEHZD70oCgonUuUpocmzTEIIhU7XJNggoocFIk7n+6T53iWd6mqxIHHAj6ft1qLn/ssOGvC/xoJw6WiAQZsg1FhfM7BuST/0Kzip6+XHVTnOUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=pVEHlSzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UY+YRFuP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 90C801140185;
	Thu, 20 Jun 2024 17:41:06 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Thu, 20 Jun 2024 17:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1718919666; x=1719006066; bh=zCnYiIjAkA
	sr6vmZnoznJvVH6yAn3CfED7lE05yJcBU=; b=pVEHlSzwLXoiO66HAPQAOLBzIy
	SIOhM0gaW+8CgOagQiYqYeS0QU1n/Xf6tDNlVe8hPeUBTuR6QP6tHs5MmtsBDWzn
	NqvvK+8oL+YFdTdUFy8F71MvMUASk21XZkTGx4LCWZOo0mmw/rXEq6qqklaKl0SB
	tjqZjNrA5v/qxPD+VpEDDHSpxSgvqt4RbqXCuzadH2JBgXjbMajljZPBpmoYI3jF
	vFUg0LrHxDtWXovcJ/8G1l4dmMUK0FUa3UVXs36bm7IKsBeHsMd2oDZ8GfASohte
	+xnRb9LazezXdrZ6kJbP4NKj97hmX+ECzn+Uj7zM0Q4qcm3Idcg45SmSBBXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718919666; x=1719006066; bh=zCnYiIjAkAsr6vmZnoznJvVH6yAn
	3CfED7lE05yJcBU=; b=UY+YRFuPInKuSX2AgEJqyGLGpGKHt4ffqpf/HDx2RkR+
	W2TeoJiPByYSjIv7siFzuKIRlu4tEVB1SmiFYv28cz7zDkbcS+DHsKbxuqqBkPPY
	PIGb9eYY9ydVnZMMwEVnBl/SYnyK2N6yjTc14mTk6QKjd439EzlNGhbENj71KzUz
	FJ1kZSnad343Uczbv9nAR1HYDnY1uVMNv4WoZxoiGlXQVMjeH0MSXTQ2IdXwgjGz
	X7qT+Xmw6ucZ/hmfDa7X6cfAmNQGjDoiZfHOOqkZB6O6ZPNoDEMHLIOXnksVWntw
	stHEG2qqh6sI/uNsuKn6tqndslzLmMbU6b3bEsUQDw==
X-ME-Sender: <xms:8aF0ZkC-ezlRi_rO5EbkMRKrF9EbmOU9hzADB6tcWoHu11d-BqTcvQ>
    <xme:8aF0Zmidk9FDp31QKIZaWzXYP4cla8D2eNXy7CionmnXzkpiM51nm0G9eCdoMW0Tn
    k9STZB6dbitAuBOhJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeffedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpedutdelgfdvgeekueeuteevffelfedukeeitedugfdvtdeutdetjeduudeuvdeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:8aF0ZnnNhR5JfdkqWVEwZNztwByosnXyuPwizIeNiEO9lwKP8PBKIw>
    <xmx:8aF0ZqyeAtRTWhvLD-QX3Inj0hBw4uKk-C9xtx_yTim3O_fkri0A1w>
    <xmx:8aF0ZpTbf0oaLvkA1xAoTdtC0I2ko3jDh24pQeN5ASkYdEtxKup46Q>
    <xmx:8aF0ZlYSDt0yiGkt6BTaTprWSZ69NfQUmAXq_VgmDlkUKWr3JYlZDw>
    <xmx:8qF0ZiKQowSrKxFjEI7A7muK-jBjeQMeGzUNkxq1oB53yNxTFzz6RpHY>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A954A2340080; Thu, 20 Jun 2024 17:41:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ede8505f-bcf6-403e-bda2-6848cd4ff4c7@app.fastmail.com>
In-Reply-To: <20240620082223.20178-2-dev@doubly.so>
References: <20240620082223.20178-1-dev@doubly.so>
 <20240620082223.20178-2-dev@doubly.so>
Date: Fri, 21 Jun 2024 09:40:45 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Devin Bayer" <dev@doubly.so>, corentin.chary@gmail.com
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: support camera disable LED
Content-Type: text/plain

On Thu, 20 Jun 2024, at 8:22 PM, Devin Bayer wrote:
> Support the LED on F10 above the crossed out camera icon.
> 
> Signed-off-by: Devin Bayer <dev@doubly.so>
> ---
> drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
> include/linux/platform_data/x86/asus-wmi.h |  2 ++
> 2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f9b6285c9a6..5585f15e7920 100644
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
> @@ -238,6 +239,7 @@ struct asus_wmi {
> struct led_classdev lightbar_led;
> int lightbar_led_wk;
> struct led_classdev micmute_led;
> + struct led_classdev camera_led;
> struct workqueue_struct *led_workqueue;
> struct work_struct tpd_led_work;
> struct work_struct wlan_led_work;
> @@ -1642,6 +1644,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
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
> @@ -1649,6 +1672,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
> led_classdev_unregister(&asus->wlan_led);
> led_classdev_unregister(&asus->lightbar_led);
> led_classdev_unregister(&asus->micmute_led);
> + led_classdev_unregister(&asus->camera_led);
>  
> if (asus->led_workqueue)
> destroy_workqueue(asus->led_workqueue);
> @@ -1740,6 +1764,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
> goto error;
> }
>  
> + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
> + asus->camera_led.name = "platform::camera";

What do other devices label their camera LED as? The one I could find appears to use `<vendor>::camera`. So maybe `asus::camera` would be better? This also keeps in line with `asus::kbd_backlight`.

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
> index 3eb5cd6773ad..b3c35e33f1e7 100644
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

I'll defer final review to Hans and Ilpo to be sure I've not missed anything, otherwise it LGTM pending the one comment above.

