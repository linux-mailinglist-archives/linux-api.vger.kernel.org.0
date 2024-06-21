Return-Path: <linux-api+bounces-1777-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C947A911FD7
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 11:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8442F28F547
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBB16DEA7;
	Fri, 21 Jun 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="T42q8ZpV"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804B16DC19;
	Fri, 21 Jun 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960296; cv=none; b=WI+07TnyoIqlfSA7lAcZ6q5kj+3RkrkK/oglJaPztAOC5mCly3BAZp9ZwEPNIX1n5wm4d3qONbNILauF4MfqvRbqL6mMcdbCzFkp9mZNOtM3N2e9wif9GV1GMCjE57DuH23svzcIwOkseImXUVo8hlaoGo14tSLbdgD8JM19JX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960296; c=relaxed/simple;
	bh=M21aNyGYI1RxZ9Fn4kJPks9UHR0SytUOTZR6yL1MGIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bynhwleUs9Ovk8iiVJdO2gCxGiElkrowTwmrKrkauzanDMCjJ2yS/pMHEqi8Kir8VZmHX4DC/oPo8QO0cDGf/3AsrVXiygWfNa0RHz5mo21LcCdcxoyDOE1MTODRwgqQLi+nekSdlymMvXHj0U4sNXAt1QRVT8b/9WHZnYB5Ri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=T42q8ZpV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W5B8Z0y0cz9tCw;
	Fri, 21 Jun 2024 10:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718960286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iVZ1trXnEDw/jzcfU5GRoXhefT6k9hFcQoPbnVSV6jM=;
	b=T42q8ZpVIN9GOjTPNrbFL2u1+dZVArtr6AT9YETmK7mFa0ilKEHVbwboWzCMv0m0GjB0yj
	PZSchl2QtwkCYd3XN0VyEnW+WSX5LJqipR08CQ6G0srl+xksPiPVWVtDev9/N6XWGPQDQs
	mPxfyHd9wAbk6vkf3TC4m+z8ZGNqe5qbPwBgJJ5aJB+TlzAKb+/HHLoTNCT94ikNtXyH99
	ua8ugFpFQ9VJbMEvDHv3469OhRErCzVl3rkCNY6hbCf/eurmiRvHcqTC3/LbTeXt3osqiC
	lm4MTa2/RYDgiHkyAHxJ97GTp1EO8PU8rDYznKhG/H0VisxjzD+5YxkPuOiitw==
From: Devin Bayer <dev@doubly.so>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Devin Bayer <dev@doubly.so>
Subject: [PATCH v2] platform/x86: asus-wmi: support the disable camera LED on F10 of Zenbook 2023
Date: Fri, 21 Jun 2024 10:57:45 +0200
Message-ID: <20240621085745.233107-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a sysfs entry for the LED on F10 above the crossed out camera icon on 2023 Zenbooks.

v2
- Changed name from `platform::camera` to `asus::camera`
- Separated patch from patchset

v1
- https://lore.kernel.org/platform-driver-x86/20240620082223.20178-1-dev@doubly.so/

Signed-off-by: Devin Bayer <dev@doubly.so>
---
 drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f07bbf809ef..20b7ed6a27b5 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -73,6 +73,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
+#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079
 
 #define ASUS_MID_FAN_DESC		"mid_fan"
 #define ASUS_GPU_FAN_DESC		"gpu_fan"
@@ -227,6 +228,7 @@ struct asus_wmi {
 	struct led_classdev lightbar_led;
 	int lightbar_led_wk;
 	struct led_classdev micmute_led;
+	struct led_classdev camera_led;
 	struct workqueue_struct *led_workqueue;
 	struct work_struct tpd_led_work;
 	struct work_struct wlan_led_work;
@@ -1533,6 +1535,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
 	return err < 0 ? err : 0;
 }
 
+static enum led_brightness camera_led_get(struct led_classdev *led_cdev)
+{
+	struct asus_wmi *asus;
+	u32 result;
+
+	asus = container_of(led_cdev, struct asus_wmi, camera_led);
+	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CAMERA_LED, &result);
+
+	return result & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
+}
+
+static int camera_led_set(struct led_classdev *led_cdev,
+			   enum led_brightness brightness)
+{
+	int state = brightness != LED_OFF;
+	int err;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CAMERA_LED, state, NULL);
+	return err < 0 ? err : 0;
+}
+
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
 	led_classdev_unregister(&asus->kbd_led);
@@ -1540,6 +1563,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
 	led_classdev_unregister(&asus->micmute_led);
+	led_classdev_unregister(&asus->camera_led);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -1631,6 +1655,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 			goto error;
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
+		asus->camera_led.name = "asus::camera";
+		asus->camera_led.max_brightness = 1;
+		asus->camera_led.brightness_get = camera_led_get;
+		asus->camera_led.brightness_set_blocking = camera_led_set;
+
+		rv = led_classdev_register(&asus->platform_device->dev,
+						&asus->camera_led);
+		if (rv)
+			goto error;
+	}
+
 error:
 	if (rv)
 		asus_wmi_led_exit(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index ab1c7deff118..fb0b00f7d292 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -50,6 +50,8 @@
 #define ASUS_WMI_DEVID_LED5		0x00020015
 #define ASUS_WMI_DEVID_LED6		0x00020016
 #define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
+#define ASUS_WMI_DEVID_CAMERA_LED_NEG		0x00060078
+#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079
 
 /* Backlight and Brightness */
 #define ASUS_WMI_DEVID_ALS_ENABLE	0x00050001 /* Ambient Light Sensor */
-- 
2.45.2


