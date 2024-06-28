Return-Path: <linux-api+bounces-1799-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DA591BA50
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AAE1F229C1
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8E14A609;
	Fri, 28 Jun 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="NGGZVuxZ"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9041103;
	Fri, 28 Jun 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564396; cv=none; b=RETP/v5IJoyySwDNv1se1HT2hdIEjyIM0H1Ps9n1L1wKuSqY7+/Kdah4r4XZl3XPuGo8SpKfYTdZkdeIrUnfO2dxDlYvHl/moGO3KXNiA9w1zGoecEJPANdei5IAFr9H6BE17B/BTbbh2eO49F055ZUZSmoy7u9Bn6ehbLLMunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564396; c=relaxed/simple;
	bh=daoP4o6NCVravagG1KU3tV/ZSt7sXmSsS6DECAgo7QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVF/7m+RX66gttxqNrAghJuO6sqzu5HjMx2QfshKD6BJ37ixSiY+q6BfuveQTYF63S5Q+sqO9pxt3lVMHlDrqPPwS+0KXcSruuuHgUtK0MPE4sNN6kNbtdSdSnPsNSwiOVjilr2pGriAIr0lCuH6pFYYWxqsfBbMKnG2D+EySRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=NGGZVuxZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9TYv6fVHz9sSD;
	Fri, 28 Jun 2024 10:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1719564387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dggIXAiX5MvgM14eZ2cfk9y9wjzYfTJJ6oAvTLM9diU=;
	b=NGGZVuxZ9oRI2pMUaNCHikjQfOPM3zJAZAVzNarXLqSdqWrPd3UOh3rlmKyRiBXGf5W5Yy
	UtvveltLPaXArxXG+nAHsGi6z7xXkVhNMWF4EqkyBrjkpYzLkM1tsa9+pYSRMKW6W3Ei2b
	Jvw9bqmnuNqTO3K78CXYzdhEVaGGYodD5vqlQ0i/2T+QBDdJCPVBWjAxRmVRwMXcHTNgRq
	/ywnF2Ec9hUWxrnM6X6f5DCItbQ3b7S/VEZKOHz9IjyCQF5wZUtGmakjpBgQ/tccw3kQax
	+rPNHRfUNllvoWSE/RcLX15s7oLZ+R2kLIJiJxgd/eW8NPdwhSa0+Hm7AkL3ww==
From: Devin Bayer <dev@doubly.so>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Devin Bayer <dev@doubly.so>
Subject: [PATCH v3] platform/x86: asus-wmi: support the disable camera LED on F10 of Zenbook 2023
Date: Fri, 28 Jun 2024 10:46:03 +0200
Message-ID: <20240628084603.217106-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9TYv6fVHz9sSD

Adds a sysfs entry for the LED on F10 above the crossed out camera icon on 2023 Zenbooks.

v3
- add docs for WMI devices
- remove duplicate #define

v2
- Changed name from `platform::camera` to `asus::camera`
- Separated patch from patchset

v1
- https://lore.kernel.org/platform-driver-x86/20240620082223.20178-1-dev@doubly.so/

Signed-off-by: Devin Bayer <dev@doubly.so>
---
 drivers/platform/x86/asus-wmi.c            | 35 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f07bbf809ef..4a9ad8b313e6 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -227,6 +227,7 @@ struct asus_wmi {
 	struct led_classdev lightbar_led;
 	int lightbar_led_wk;
 	struct led_classdev micmute_led;
+	struct led_classdev camera_led;
 	struct workqueue_struct *led_workqueue;
 	struct work_struct tpd_led_work;
 	struct work_struct wlan_led_work;
@@ -1533,6 +1534,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
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
@@ -1540,6 +1562,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
 	led_classdev_unregister(&asus->micmute_led);
+	led_classdev_unregister(&asus->camera_led);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -1631,6 +1654,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
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
index ab1c7deff118..d020fcbbcfb7 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -51,6 +51,10 @@
 #define ASUS_WMI_DEVID_LED6		0x00020016
 #define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
 
+/* Disable Camera LED */
+#define ASUS_WMI_DEVID_CAMERA_LED_NEG	0x00060078 /* 0 = on (unused) */
+#define ASUS_WMI_DEVID_CAMERA_LED	0x00060079 /* 1 = on */
+
 /* Backlight and Brightness */
 #define ASUS_WMI_DEVID_ALS_ENABLE	0x00050001 /* Ambient Light Sensor */
 #define ASUS_WMI_DEVID_BACKLIGHT	0x00050011

base-commit: 103a4e4a4351d3d5214c4f54fdf89f0f81b692ef
-- 
2.45.2


