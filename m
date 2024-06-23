Return-Path: <linux-api+bounces-1793-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD4913CEF
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05701C20A6D
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2024 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598418307C;
	Sun, 23 Jun 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVOkt6Pa"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA3181311;
	Sun, 23 Jun 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161831; cv=none; b=CrAj5hIBWschlfb3vh/M3HiINe6kiMntMSn1Wze5+YAqW41dn2aDVMkFZ+my6om751S9I9FuJRSd2zw6FZB5XxjGRPaA1WbthzR0KHF5ck38tW1TYwNMOvEamG5KhaiQngB1CudchfpQ3tr0lP61wesFYLz62knDyR+FND6LJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161831; c=relaxed/simple;
	bh=cEfwR6KM+NHGdsn1m/dn+Ifk1vd9vLeAifgYiaCpLbc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rpo5J0TEpNzNjCvMTxPcMptJu8kD66juzfgga2axyjoeyDzm2fZKY7x1v7AVQoMAC5zQ/qNAx2qp+TSPPg+VuqUQPaf7zyYoApWsSXxs2O0HccoFVs5ZfrJsOSjvaqW68MjYLWlUW5+jOg0kzOQgP+jBOLfAtRiV/7VWhXMMasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVOkt6Pa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719161829; x=1750697829;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cEfwR6KM+NHGdsn1m/dn+Ifk1vd9vLeAifgYiaCpLbc=;
  b=gVOkt6PahYs2uaN/uqXLE0gTf0BCgSMKDZdzWOj7gBYK2LHjLZCiZUnt
   1IczwVaOywPW38VFumxI1LsfhSHdx3koABIV2ODCp7nk9xRFwzDuJ/PLw
   X2V+YZJPjASaNUXXQnGaZICy79np71D8nqjeTU9+QzgiFyFU4NF/QxMyw
   ffiItapZ4KZ7mloZUDS6qUBQ08cfluTg9IJfKkbavx7UVNYPh7h+EBR6S
   0MrN2Fz80hlyPwTjH0HZxjAvDTBjSz8iSTo2iJjvBL+VsTq6DZOvMyWBz
   s82ssD0nEjU2uFkQkw1MXzBbC36NK/zGOqAkT2jXoMrQZS+LbpjZUYYBH
   w==;
X-CSE-ConnectionGUID: dRkQ0aWvRvygGR5iIYol1A==
X-CSE-MsgGUID: 8oWJkAElRG+zoMgtWDsB6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="19036523"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="19036523"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 09:57:08 -0700
X-CSE-ConnectionGUID: ZxrGOrwsT8qY8OCqt18+pg==
X-CSE-MsgGUID: WO8QYSqyTN+tWjqPoAIu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="43185507"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 09:57:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 23 Jun 2024 19:57:01 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: Devin Bayer <dev@doubly.so>, corentin.chary@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: asus-wmi: support the disable camera
 LED on F10 of Zenbook 2023
In-Reply-To: <ab40d5d2-a14a-4cb2-b315-b4cb66654f9e@app.fastmail.com>
Message-ID: <22352c0a-a853-b28d-a36a-09cc502acb8b@linux.intel.com>
References: <20240621085745.233107-1-dev@doubly.so> <ab40d5d2-a14a-4cb2-b315-b4cb66654f9e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Jun 2024, Luke Jones wrote:

> On Fri, 21 Jun 2024, at 8:57 PM, Devin Bayer wrote:
> > Adds a sysfs entry for the LED on F10 above the crossed out camera icon on 2023 Zenbooks.
> > 
> > v2
> > - Changed name from `platform::camera` to `asus::camera`
> > - Separated patch from patchset
> > 
> > v1
> > - https://lore.kernel.org/platform-driver-x86/20240620082223.20178-1-dev@doubly.so/
> > 
> > Signed-off-by: Devin Bayer <dev@doubly.so>
> > ---
> > drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
> > include/linux/platform_data/x86/asus-wmi.h |  2 ++
> > 2 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index 3f07bbf809ef..20b7ed6a27b5 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -73,6 +73,7 @@ module_param(fnlock_default, bool, 0444);
> > #define NOTIFY_LID_FLIP_ROG 0xbd
> >  
> > #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)
> > +#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
> >  
> > #define ASUS_MID_FAN_DESC "mid_fan"
> > #define ASUS_GPU_FAN_DESC "gpu_fan"
> > @@ -227,6 +228,7 @@ struct asus_wmi {
> > struct led_classdev lightbar_led;
> > int lightbar_led_wk;
> > struct led_classdev micmute_led;
> > + struct led_classdev camera_led;
> > struct workqueue_struct *led_workqueue;
> > struct work_struct tpd_led_work;
> > struct work_struct wlan_led_work;
> > @@ -1533,6 +1535,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
> > return err < 0 ? err : 0;
> > }
> >  
> > +static enum led_brightness camera_led_get(struct led_classdev *led_cdev)
> > +{
> > + struct asus_wmi *asus;
> > + u32 result;
> > +
> > + asus = container_of(led_cdev, struct asus_wmi, camera_led);
> > + asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CAMERA_LED, &result);
> > +
> > + return result & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
> > +}
> > +
> > +static int camera_led_set(struct led_classdev *led_cdev,
> > +    enum led_brightness brightness)
> > +{
> > + int state = brightness != LED_OFF;
> > + int err;
> > +
> > + err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CAMERA_LED, state, NULL);
> > + return err < 0 ? err : 0;
> > +}
> > +
> > static void asus_wmi_led_exit(struct asus_wmi *asus)
> > {
> > led_classdev_unregister(&asus->kbd_led);
> > @@ -1540,6 +1563,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
> > led_classdev_unregister(&asus->wlan_led);
> > led_classdev_unregister(&asus->lightbar_led);
> > led_classdev_unregister(&asus->micmute_led);
> > + led_classdev_unregister(&asus->camera_led);
> >  
> > if (asus->led_workqueue)
> > destroy_workqueue(asus->led_workqueue);
> > @@ -1631,6 +1655,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
> > goto error;
> > }
> >  
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
> > + asus->camera_led.name = "asus::camera";
> > + asus->camera_led.max_brightness = 1;
> > + asus->camera_led.brightness_get = camera_led_get;
> > + asus->camera_led.brightness_set_blocking = camera_led_set;
> > +
> > + rv = led_classdev_register(&asus->platform_device->dev,
> > + &asus->camera_led);
> > + if (rv)
> > + goto error;
> > + }
> > +
> > error:
> > if (rv)
> > asus_wmi_led_exit(asus);
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > index ab1c7deff118..fb0b00f7d292 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -50,6 +50,8 @@
> > #define ASUS_WMI_DEVID_LED5 0x00020015
> > #define ASUS_WMI_DEVID_LED6 0x00020016
> > #define ASUS_WMI_DEVID_MICMUTE_LED 0x00040017
> > +#define ASUS_WMI_DEVID_CAMERA_LED_NEG 0x00060078
> > +#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
> >  
> > /* Backlight and Brightness */
> > #define ASUS_WMI_DEVID_ALS_ENABLE 0x00050001 /* Ambient Light Sensor */
> > -- 
> > 2.45.2
> > 
> 
> If Hans and Ilpo have no other comments regarding the written C code:
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Luke,

As I've seen you use S-o-b tag a few times like this, do you actually mean 
Reviewed-by: tag which tells you've looked through the change and think 
it's good/useful for the kernel?

S-o-b relates to authorship of the code in the patch (and should be 
there right from the submission, not added like this).

-- 
 i.


