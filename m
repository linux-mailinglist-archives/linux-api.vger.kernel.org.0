Return-Path: <linux-api+bounces-1767-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECA90FEB5
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538561F212C4
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F3196DA4;
	Thu, 20 Jun 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="JGi99vmk"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E317CA10;
	Thu, 20 Jun 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871800; cv=none; b=bt/yiKTMtR5QYE4tu4GYscJfnWOmynm3fHfwt9Sv9h1tp/2SgAlXyFzVNJ3Vjthq21/icAXk2P+2oscI300v32HG7+s8O021GY+CjOEYiyaH/oJKZ+mH6rs26IxONDuWLMQ1vZjlsfhRO7M5QvgqGIeTpKJnk5bwwwwrL3YfEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871800; c=relaxed/simple;
	bh=m4ud7zcs6w9yafRA+4aYY2FIxfaG6ju8jHF1+5GAIHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5x/8Ibltjjcc7C76T5llV33KQ0ddXaja6H2OrJD62G9ozcZqAU+TKdAnEo8RHETqwzdhAofoUNgeHjLWvjqebc4OCmsfRUkXKQYRwkHO3sM+7WAnVhpwaOpjLmkTc5Csctextf1/j3rNHxBCIZCiwPBZ0rIOVQOU+7Ig08TmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=JGi99vmk; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W4YQn6Xdyz9sTH;
	Thu, 20 Jun 2024 10:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718871793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb0NahHgigsXR2ZZsHJRZEatlrG5dxv1uPzpoOJ+rjY=;
	b=JGi99vmkf/9gI2G3p32PwS+MkE7qV+RIoewuoaJQ1HEHCWg5YIq5g4bd5Tb8D19Eyq3fw3
	i6KQfBS8iXqgQsaIb9p6YwMmO7Xor1kXlWsXuCnYMzxO3YTpeFkHWAvXDIlwL9hZiQ3nrV
	Fmec08dm61dGjsXStkEzfOXKDNNfqXwDXYPAD7MuwN3W9Lkw6ya/aJfRZiWJBlaUFN8HYW
	Ha61LqrBJtq5tqygrjG0A8bZXXsYLeGKtxwcPM6S8qZlcgoDbJnm34a/yBZ72FvL9r0RuO
	d6VqJ5rYHbG9wiqTMXa9nBzvZqug7cFWrZoblrXbsG9Yyujv0RQBy4Au/xcw8Q==
From: Devin Bayer <dev@doubly.so>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Devin Bayer <dev@doubly.so>
Subject: [PATCH 2/2] platform/x86: asus-wmi: support newer fan_boost_mode dev_id
Date: Thu, 20 Jun 2024 08:22:23 +0000
Message-ID: <20240620082223.20178-3-dev@doubly.so>
In-Reply-To: <20240620082223.20178-1-dev@doubly.so>
References: <20240620082223.20178-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W4YQn6Xdyz9sTH

Support changing the fan mode (silent, performance, standard). I reused
the existing fan_boost_mode sysfs entry.

Signed-off-by: Devin Bayer <dev@doubly.so>
---
 drivers/platform/x86/asus-wmi.c            | 87 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 5585f15e7920..e27b8f86d57b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -73,7 +73,6 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
-#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079
 
 #define ASUS_MID_FAN_DESC		"mid_fan"
 #define ASUS_GPU_FAN_DESC		"gpu_fan"
@@ -94,6 +93,10 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_FAN_BOOST_MODE_SILENT_MASK		0x02
 #define ASUS_FAN_BOOST_MODES_MASK		0x03
 
+#define ASUS_FAN_BOOST_MODE2_NORMAL		0
+#define ASUS_FAN_BOOST_MODE2_SILENT		1
+#define ASUS_FAN_BOOST_MODE2_OVERBOOST		2
+
 #define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT	0
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
@@ -268,6 +271,7 @@ struct asus_wmi {
 	int agfn_pwm;
 
 	bool fan_boost_mode_available;
+	u32 fan_boost_mode_dev_id;
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
@@ -3019,14 +3023,14 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 
 /* Fan mode *******************************************************************/
 
-static int fan_boost_mode_check_present(struct asus_wmi *asus)
+static int fan_boost_mode1_check_present(struct asus_wmi *asus)
 {
 	u32 result;
 	int err;
 
-	asus->fan_boost_mode_available = false;
+	asus->fan_boost_mode_dev_id = ASUS_WMI_DEVID_FAN_BOOST_MODE;
 
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE,
+	err = asus_wmi_get_devstate(asus, asus->fan_boost_mode_dev_id,
 				    &result);
 	if (err) {
 		if (err == -ENODEV)
@@ -3044,16 +3048,87 @@ static int fan_boost_mode_check_present(struct asus_wmi *asus)
 	return 0;
 }
 
+static int fan_boost_mode2_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->fan_boost_mode_mask = ASUS_FAN_BOOST_MODES_MASK;
+	asus->fan_boost_mode_dev_id = ASUS_WMI_DEVID_FAN_BOOST_MODE2;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE2,
+				    &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		else
+			return err;
+	}
+
+	if (! (result & ASUS_WMI_DSTS_PRESENCE_BIT))
+		return 0;
+
+	asus->fan_boost_mode_available = true;
+
+	if (result & ASUS_FAN_BOOST_MODE2_SILENT) {
+		asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_SILENT;
+	} else if(result & ASUS_FAN_BOOST_MODE2_OVERBOOST) {
+		asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_OVERBOOST;
+	} else {
+		asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
+	}
+
+	return 0;
+}
+
+static int fan_boost_mode_check_present(struct asus_wmi *asus)
+{
+	int err;
+
+	asus->fan_boost_mode_available = false;
+
+	err = fan_boost_mode1_check_present(asus);
+	if (err)
+		return err;
+
+	if (!asus->fan_boost_mode_available) {
+		err = fan_boost_mode2_check_present(asus);
+	}
+
+	return err;
+}
+
 static int fan_boost_mode_write(struct asus_wmi *asus)
 {
 	u32 retval;
 	u8 value;
+	u8 hw_value;
 	int err;
 
 	value = asus->fan_boost_mode;
 
-	pr_info("Set fan boost mode: %u\n", value);
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
+	/* transform userspace values into hardware values */
+	if(asus->fan_boost_mode_dev_id == ASUS_WMI_DEVID_FAN_BOOST_MODE2) {
+		switch(value) {
+			case ASUS_FAN_BOOST_MODE_SILENT:
+				hw_value = ASUS_FAN_BOOST_MODE2_SILENT;
+				break;
+			case ASUS_FAN_BOOST_MODE_OVERBOOST:
+				hw_value = ASUS_FAN_BOOST_MODE2_OVERBOOST;
+				break;
+			case ASUS_FAN_BOOST_MODE_NORMAL:
+				hw_value = ASUS_FAN_BOOST_MODE2_NORMAL;
+				break;
+			default:
+				return -EINVAL;
+
+		}
+	} else {
+		hw_value = value;
+	}
+
+	pr_info("Set fan boost mode: user=%u hw=%u\n", value, hw_value);
+	err = asus_wmi_set_devstate(asus->fan_boost_mode_dev_id, hw_value,
 				    &retval);
 
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index b3c35e33f1e7..62982f67d632 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -65,6 +65,7 @@
 /* Writing a brightness re-enables the screen if disabled */
 #define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
+#define ASUS_WMI_DEVID_FAN_BOOST_MODE2	0x00110019
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
 /* Misc */
-- 
2.45.2


