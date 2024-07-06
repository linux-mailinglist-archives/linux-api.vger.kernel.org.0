Return-Path: <linux-api+bounces-1850-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475169293DB
	for <lists+linux-api@lfdr.de>; Sat,  6 Jul 2024 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B4D1C20FA6
	for <lists+linux-api@lfdr.de>; Sat,  6 Jul 2024 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A71304A2;
	Sat,  6 Jul 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYLEM4PD"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC71CA9E;
	Sat,  6 Jul 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273454; cv=none; b=PvU8He+Fo1MnN8dMwU2a7XHMgqhB7oQ+F9kbNGKPT+0tHY6ykuhkU/aTwbfEaVgOFLQV1aVW7tUuQ1+Dz02wBfSWkVb18KIrY00CbgH09m7wmkt2g/mbn2/2Bck1j/jo6vUB1N8piSo8f04z3kkXzHXZQVOogEkRzn4GX7wa0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273454; c=relaxed/simple;
	bh=QJcHcX/QvZow96GFmJaUaP8YM+2ojba68Fwc4yozaBQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BISwhfzP2pzLm8ggHRWMDvFo/66Ne0RqEMrhHzjYiDGAAoe8fGTOulxAwZTdwCOs7yXON8xYeK7gEt6aEgFAVhC9RXEBHUqoJ/tsU48yWTfoEtlA7QTOd+GxLpI43VgkwKnjlaHbYPgVjoEhozOcwOM4bMGjDrTZIQFcfqZCdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYLEM4PD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720273453; x=1751809453;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QJcHcX/QvZow96GFmJaUaP8YM+2ojba68Fwc4yozaBQ=;
  b=LYLEM4PD+fwi/ZDST9qzFij6EWEPcrGelO9L/VIwunOU9tHLGEsAQeDT
   Z+eba1lx+RfqBvRTcJIMV3b0UVhWR20BicOPr6oNhNz9HXxHydThR/WLN
   KH8/HXgLmVlv8utE8eVljMe8IIihX6ByygmaXel9gNnex13u39/dKrOic
   aPQd624W7b8bOb85YhzvLinI+JD+LOqfIzsoXQKgfI/8TE0pN0VW6fJvq
   vfDspIrSY7dT47N3CxYyT+71cnwguCDGcZTAhZy0LiRmxQxd1t1YqR41u
   +0JtVo5f5+PbDY9f8MMwgv4EoydUIWi91QxmnNETBo/1UoQ6JoM1ScMtm
   w==;
X-CSE-ConnectionGUID: lfhqSrj/S8O/tmZJTqu89A==
X-CSE-MsgGUID: IBELD3d4RBGw5USD1IDeMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17742038"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="17742038"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 06:44:12 -0700
X-CSE-ConnectionGUID: z/7+llWNTZ+XX1teFo7oIQ==
X-CSE-MsgGUID: 5sJMXAkoRoWjTnepczNaRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47512408"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.111])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 06:44:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 6 Jul 2024 16:44:05 +0300 (EEST)
To: Devin Bayer <dev@doubly.so>
cc: corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: asus-wmi: support the disable camera
 LED on F10 of Zenbook 2023
In-Reply-To: <20240628084603.217106-1-dev@doubly.so>
Message-ID: <7e8ada6c-83b9-aa44-d5ca-70827ca1a363@linux.intel.com>
References: <20240628084603.217106-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Jun 2024, Devin Bayer wrote:

> Adds a sysfs entry for the LED on F10 above the crossed out camera icon on 2023 Zenbooks.

Thanks for the update, I've applied this into review-ilpo branch with 
small (non-code) edits.

In future, please fold the changelog to 72 characters and include patch 
history only after the first --- line so tools don't put it into the 
commit message. I've handled these for you this time around so there's no 
need to send another version because of those problems.

-- 
 i.
 
> v3
> - add docs for WMI devices
> - remove duplicate #define
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
>  drivers/platform/x86/asus-wmi.c            | 35 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  4 +++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f07bbf809ef..4a9ad8b313e6 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -227,6 +227,7 @@ struct asus_wmi {
>  	struct led_classdev lightbar_led;
>  	int lightbar_led_wk;
>  	struct led_classdev micmute_led;
> +	struct led_classdev camera_led;
>  	struct workqueue_struct *led_workqueue;
>  	struct work_struct tpd_led_work;
>  	struct work_struct wlan_led_work;
> @@ -1533,6 +1534,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
>  	return err < 0 ? err : 0;
>  }
>  
> +static enum led_brightness camera_led_get(struct led_classdev *led_cdev)
> +{
> +	struct asus_wmi *asus;
> +	u32 result;
> +
> +	asus = container_of(led_cdev, struct asus_wmi, camera_led);
> +	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CAMERA_LED, &result);
> +
> +	return result & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
> +}
> +
> +static int camera_led_set(struct led_classdev *led_cdev,
> +			   enum led_brightness brightness)
> +{
> +	int state = brightness != LED_OFF;
> +	int err;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CAMERA_LED, state, NULL);
> +	return err < 0 ? err : 0;
> +}
> +
>  static void asus_wmi_led_exit(struct asus_wmi *asus)
>  {
>  	led_classdev_unregister(&asus->kbd_led);
> @@ -1540,6 +1562,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
>  	led_classdev_unregister(&asus->wlan_led);
>  	led_classdev_unregister(&asus->lightbar_led);
>  	led_classdev_unregister(&asus->micmute_led);
> +	led_classdev_unregister(&asus->camera_led);
>  
>  	if (asus->led_workqueue)
>  		destroy_workqueue(asus->led_workqueue);
> @@ -1631,6 +1654,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
>  			goto error;
>  	}
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
> +		asus->camera_led.name = "asus::camera";
> +		asus->camera_led.max_brightness = 1;
> +		asus->camera_led.brightness_get = camera_led_get;
> +		asus->camera_led.brightness_set_blocking = camera_led_set;
> +
> +		rv = led_classdev_register(&asus->platform_device->dev,
> +						&asus->camera_led);
> +		if (rv)
> +			goto error;
> +	}
> +
>  error:
>  	if (rv)
>  		asus_wmi_led_exit(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index ab1c7deff118..d020fcbbcfb7 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -51,6 +51,10 @@
>  #define ASUS_WMI_DEVID_LED6		0x00020016
>  #define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
>  
> +/* Disable Camera LED */
> +#define ASUS_WMI_DEVID_CAMERA_LED_NEG	0x00060078 /* 0 = on (unused) */
> +#define ASUS_WMI_DEVID_CAMERA_LED	0x00060079 /* 1 = on */
> +
>  /* Backlight and Brightness */
>  #define ASUS_WMI_DEVID_ALS_ENABLE	0x00050001 /* Ambient Light Sensor */
>  #define ASUS_WMI_DEVID_BACKLIGHT	0x00050011
> 
> base-commit: 103a4e4a4351d3d5214c4f54fdf89f0f81b692ef
> 

