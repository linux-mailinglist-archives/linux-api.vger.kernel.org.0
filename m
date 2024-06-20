Return-Path: <linux-api+bounces-1768-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C790FEBA
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A43287C5C
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB11991DC;
	Thu, 20 Jun 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="G2iJT9bF"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125517CA19;
	Thu, 20 Jun 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871801; cv=none; b=WQJZR1lD5pv2OHRJtugy2Ynk3KOwzl9cK6AJO1pAOMzYea74BuWqm5fJMMYkDNwC3kDozYlKezNlGPUz6Uz4jyJ4hPVddJpljkBf5XHKUJGKSZCb9S7ZkfFdfMKV34WmyGB/hC3UyAo54Fmv8NnRl2yxDa+uDjEyesVQ4ZoqaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871801; c=relaxed/simple;
	bh=k/BP16SX3byhTtStuXWz+5KnJg/a4c8cs0pyMabQ9VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naJ3Sgn2hQtJwGM0qT9+iYw9DSZQkUtfSPCeo64lHPG8CvxRcGCi5WmT39WxFx62l9MLh/s4Yamf0ifwGRryt4AniQ20AdE0q6EM3jBoLTrOKdY1CWbjeimieFtZaYLNMYmvGq9c6Gvr/8L2D0tjGSO5Y5LLFeSonNxDgGU0CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=G2iJT9bF; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W4YQk5gnnz9sW7;
	Thu, 20 Jun 2024 10:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718871790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OC8uiFNZq2cxU+r/lYeATCspZX8arPQiFvWr36D5GQY=;
	b=G2iJT9bF5nZx91BX/2Ly1OIhCw6qe8XK0jFOBUtpYexrBm8nvuGFRgNmEGxnROxr5nKclo
	8fPI+NsuYlS4inc3yJwKWWUH/WUuNPQg9Fe1RLLhn2RPsbXNMzhShU7LtAlwmwPED4nkuA
	lMRA9slKc5HPhMq62334ohuPq6Y3B4MCGKUieA20RcuzYscxCN8rI1YojPaPgkRJ92PaaT
	3xAzY4b54vUWMhWTmMazsG3i3QyZYEWi53bYUWZtpRncxuztz28xdXz+r7agxOs1PvF9sB
	W3CDG15T/qEcgKIfWolFrBtPCmBpbSYrLGoL7bMKH7HIMQUAhBcdjMOpEawrMA==
From: Devin Bayer <dev@doubly.so>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Devin Bayer <dev@doubly.so>
Subject: [PATCH 1/2] platform/x86: asus-wmi: support camera disable LED
Date: Thu, 20 Jun 2024 08:22:22 +0000
Message-ID: <20240620082223.20178-2-dev@doubly.so>
In-Reply-To: <20240620082223.20178-1-dev@doubly.so>
References: <20240620082223.20178-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W4YQk5gnnz9sW7

Support the LED on F10 above the crossed out camera icon.

Signed-off-by: Devin Bayer <dev@doubly.so>
---
 drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f9b6285c9a6..5585f15e7920 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -73,6 +73,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
+#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079
 
 #define ASUS_MID_FAN_DESC		"mid_fan"
 #define ASUS_GPU_FAN_DESC		"gpu_fan"
@@ -238,6 +239,7 @@ struct asus_wmi {
 	struct led_classdev lightbar_led;
 	int lightbar_led_wk;
 	struct led_classdev micmute_led;
+	struct led_classdev camera_led;
 	struct workqueue_struct *led_workqueue;
 	struct work_struct tpd_led_work;
 	struct work_struct wlan_led_work;
@@ -1642,6 +1644,27 @@ static int micmute_led_set(struct led_classdev *led_cdev,
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
@@ -1649,6 +1672,7 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
 	led_classdev_unregister(&asus->micmute_led);
+	led_classdev_unregister(&asus->camera_led);
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
@@ -1740,6 +1764,18 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 			goto error;
 	}
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
+		asus->camera_led.name = "platform::camera";
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
index 3eb5cd6773ad..b3c35e33f1e7 100644
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


