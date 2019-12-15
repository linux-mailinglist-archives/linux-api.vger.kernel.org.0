Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424FB11F828
	for <lists+linux-api@lfdr.de>; Sun, 15 Dec 2019 15:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfLOO0v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 15 Dec 2019 09:26:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43509 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfLOO0v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Dec 2019 09:26:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so3851503ljm.10;
        Sun, 15 Dec 2019 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CvJ6q7MlYaGjVfTbKfxt+EKa8dtf+YA0ZRShG/GceM=;
        b=OjVKMLs/3jy/rXa3qENfWBUKcAZfxeMUpopDQvEXfuKjSQkc4aEalARXGzeBaj1XHi
         SJBw6hPcAJw2IQyEYr0uvP3dn350na+7lo5hC6yZzBuAu6AXNot1KAi4dQJ6qco1o/Li
         VbQDPQoIhMvCpDseqMuwTo21e8SquG0e/eJBR3pJ6XeUNOgXBnHQrIjnnYsaXQvZ9lqh
         TwMOo5/njdxcx5Jn0hM8GA4N1s3K6UUbUTIpRPdP63S1wHw0TPacK/Oalu7F/aM81QIO
         FfVnFfwZnOWdY5idoB9+qdjvaKzHGDE7SvAkfx61zhGMltYB4zFI8BAcz+T89c2I6XvY
         Io/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CvJ6q7MlYaGjVfTbKfxt+EKa8dtf+YA0ZRShG/GceM=;
        b=gSP7xMKARoGSHKpRLrRCh5ZvEZOn0Z+H7AXQIqsINkfaV/dFKz3fU4CwGj7d/qtiH8
         6wC0n2PVJByjQAWZ3eBOwEr+L5diFabnzCt8lK8yn3ecl3eZTZJTGOVR0lWkX26cQpey
         9QXldCaX0Hz8hI7PZBtEeTpckepasq+dVXCfWFSqAw2i2ZbH8Vdvj36U7+lHOYyEkHqM
         HruI8TEjBNDyMAqGQiTlPiUw6TuZy39OAJ4L8N0RmNXIGnEqkEAyfhqkIlImpvZZ4EH4
         dqMAujNXd9Yd5eeeRPFwTpLgtfqO2M1WQCl1ylyu2JG14gW898X2Ta825kW20dPTinwf
         YXNw==
X-Gm-Message-State: APjAAAX/Xsz+XEIXClpD71ts+vemIMww1NOjAUyDJ0wtZFZhPUcDLDJ0
        3rVesnXwtKZI0YCqRc93NAF32MsUE4Q=
X-Google-Smtp-Source: APXvYqz9Ej/HndOCVU1rjH4tW5QT3OOPh3r/sng0EClE7X21OHqUSk4JNZKL1GAqgoXWbRXO0BQIDw==
X-Received: by 2002:a2e:94d5:: with SMTP id r21mr16672234ljh.33.1576420007925;
        Sun, 15 Dec 2019 06:26:47 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id r9sm8144571lfc.72.2019.12.15.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 06:26:47 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-api@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v6 1/2] platform/x86: asus_wmi: Support throttle thermal policy
Date:   Sun, 15 Dec 2019 16:26:34 +0200
Message-Id: <20191215142634.13888-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191215142527.13780-1-leonmaxx@gmail.com>
References: <20191215142527.13780-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Throttle thermal policy ACPI device is used to control CPU cooling and
throttling. This patch adds sysfs entry for setting current mode and
Fn+F5 hotkey that switches to next.

Policy modes:
* 0x00 - default
* 0x01 - overboost
* 0x02 - silent

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  10 ++
 drivers/platform/x86/asus-wmi.c               | 113 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |   1 +
 3 files changed, 124 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 9e99f2909612..1efac0ddb417 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -46,3 +46,13 @@ Description:
 			* 0 - normal,
 			* 1 - overboost,
 			* 2 - silent
+
+What:		/sys/devices/platform/<platform>/throttle_thermal_policy
+Date:		Dec 2019
+KernelVersion:	5.6
+Contact:	"Leonid Maksymchuk" <leonmaxx@gmail.com>
+Description:
+		Throttle thermal policy mode:
+			* 0 - default,
+			* 1 - overboost,
+			* 2 - silent
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e01635..f10ec9d745e5 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -61,6 +61,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_KBD_BRTDWN		0xc5
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
 #define NOTIFY_KBD_FBM			0x99
+#define NOTIFY_KBD_TTP			0xae
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -81,6 +82,10 @@ MODULE_LICENSE("GPL");
 #define ASUS_FAN_BOOST_MODE_SILENT_MASK		0x02
 #define ASUS_FAN_BOOST_MODES_MASK		0x03
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT	0
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -198,6 +203,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool throttle_thermal_policy_available;
+	u8 throttle_thermal_policy_mode;
+
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
@@ -1724,6 +1732,98 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
 static DEVICE_ATTR_RW(fan_boost_mode);
 
+/* Throttle thermal policy ****************************************************/
+
+static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->throttle_thermal_policy_available = false;
+
+	err = asus_wmi_get_devstate(asus,
+				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+				    &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		return err;
+	}
+
+	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
+		asus->throttle_thermal_policy_available = true;
+
+	return 0;
+}
+
+static int throttle_thermal_policy_write(struct asus_wmi *asus)
+{
+	int err;
+	u8 value;
+	u32 retval;
+
+	value = asus->throttle_thermal_policy_mode;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+				    value, &retval);
+	if (err) {
+		pr_warn("Failed to set throttle thermal policy: %d\n", err);
+		return err;
+	}
+
+	if (retval != 1) {
+		pr_warn("Failed to set throttle thermal policy (retval): 0x%x\n",
+			retval);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
+{
+	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+
+	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+
+	asus->throttle_thermal_policy_mode = new_mode;
+	return throttle_thermal_policy_write(asus);
+}
+
+static ssize_t throttle_thermal_policy_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	u8 mode = asus->throttle_thermal_policy_mode;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", mode);
+}
+
+static ssize_t throttle_thermal_policy_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result;
+	u8 new_mode;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou8(buf, 10, &new_mode);
+	if (result < 0)
+		return result;
+
+	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+		return -EINVAL;
+
+	asus->throttle_thermal_policy_mode = new_mode;
+	throttle_thermal_policy_write(asus);
+
+	return count;
+}
+
+// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+static DEVICE_ATTR_RW(throttle_thermal_policy);
+
 /* Backlight ******************************************************************/
 
 static int read_backlight_power(struct asus_wmi *asus)
@@ -2005,6 +2105,11 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
+	if (asus->throttle_thermal_policy_available && code == NOTIFY_KBD_TTP) {
+		throttle_thermal_policy_switch_next(asus);
+		return;
+	}
+
 	if (is_display_toggle(code) && asus->driver->quirks->no_display_toggle)
 		return;
 
@@ -2155,6 +2260,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
+	&dev_attr_throttle_thermal_policy.attr,
 	NULL
 };
 
@@ -2178,6 +2284,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
+	else if (attr == &dev_attr_throttle_thermal_policy.attr)
+		ok = asus->throttle_thermal_policy_available;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -2437,6 +2545,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_fan_boost_mode;
 
+	err = throttle_thermal_policy_check_present(asus);
+	if (err)
+		goto fail_throttle_thermal_policy;
+
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
 		goto fail_sysfs;
@@ -2521,6 +2633,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
+fail_throttle_thermal_policy:
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 60249e22e844..d39fc658c320 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,7 @@
 #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
 /* Misc */
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
-- 
2.24.0

