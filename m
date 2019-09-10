Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF764AE377
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393268AbfIJGJi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 02:09:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:9595 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393258AbfIJGJi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Sep 2019 02:09:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 23:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,487,1559545200"; 
   d="scan'208";a="175206857"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2019 23:09:11 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, gregkh@linuxfoundation.org,
        Wu Hao <hao.wu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v6 2/3] fpga: dfl: fme: add thermal management support
Date:   Tue, 10 Sep 2019 13:50:39 +0800
Message-Id: <1568094640-4920-3-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568094640-4920-1-git-send-email-hao.wu@intel.com>
References: <1568094640-4920-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch adds support to thermal management private feature for DFL
FPGA Management Engine (FME). This private feature driver registers
a hwmon for thermal/temperature monitoring (hwmon temp1_input).
If hardware automatic throttling is supported by this hardware, then
driver also exposes sysfs interfaces under hwmon for thresholds
(temp1_max/ crit/ emergency), threshold alarms (temp1_max_alarm/
temp1_crit_alarm) and throttling policy (temp1_max_policy).

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---
v2: create a dfl_fme_thermal hwmon to expose thermal information.
    move all sysfs interfaces under hwmon
	tempareture       --> hwmon temp1_input
	threshold1        --> hwmon temp1_alarm
	threshold2        --> hwmon temp1_crit
	trip_threshold    --> hwmon temp1_emergency
	threshold1_status --> hwmon temp1_alarm_status
	threshold2_status --> hwmon temp1_crit_status
	threshold1_policy --> hwmon temp1_alarm_policy
v3: rename some hwmon sysfs interfaces to follow hwmon ABI.
	temp1_alarm        --> temp1_max
	temp1_alarm_status --> temp1_max_alarm
	temp1_crit_status  --> temp1_crit_alarm
	temp1_alarm_policy --> temp1_max_policy
    update sysfs doc for above sysfs interface changes.
    replace scnprintf with sprintf in sysfs interface.
v4: use HWMON_CHANNEL_INFO.
    rebase, and update date in sysfs doc.
v5: no change.
v6: rebased, and clean up (remove empty uinit function).
    update date in sysfs doc.
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme |  64 ++++++++
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 178 +++++++++++++++++++++++
 3 files changed, 243 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 72634d3..c84b3c1 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -106,3 +106,67 @@ KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. Read this file to get the second error detected by
 		hardware.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/name
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. Read this file to get the name of hwmon device, it
+		supports values:
+		    'dfl_fme_thermal' - thermal hwmon device name
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns FPGA device temperature in millidegrees
+		Celsius.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns hardware threshold1 temperature in
+		millidegrees Celsius. If temperature rises at or above this
+		threshold, hardware starts 50% or 90% throttling (see
+		'temp1_max_policy').
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns hardware threshold2 temperature in
+		millidegrees Celsius. If temperature rises at or above this
+		threshold, hardware starts 100% throttling.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_emergency
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns hardware trip threshold temperature in
+		millidegrees Celsius. If temperature rises at or above this
+		threshold, a fatal event will be triggered to board management
+		controller (BMC) to shutdown FPGA.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max_alarm
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns 1 if temperature is currently at or above
+		hardware threshold1 (see 'temp1_max'), otherwise 0.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit_alarm
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns 1 if temperature is currently at or above
+		hardware threshold2 (see 'temp1_crit'), otherwise 0.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max_policy
+Date:		September 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. Read this file to get the policy of hardware threshold1
+		(see 'temp1_max'). It only supports two values (policies):
+		    0 - AP2 state (90% throttling)
+		    1 - AP1 state (50% throttling)
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 73c779e..72380e1 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -156,7 +156,7 @@ config FPGA_DFL
 
 config FPGA_DFL_FME
 	tristate "FPGA DFL FME Driver"
-	depends on FPGA_DFL
+	depends on FPGA_DFL && HWMON
 	help
 	  The FPGA Management Engine (FME) is a feature device implemented
 	  under Device Feature List (DFL) framework. Select this option to
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 4d78e18..752d71c 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -14,6 +14,8 @@
  *   Henry Mitchel <henry.mitchel@intel.com>
  */
 
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -181,6 +183,178 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 	.ioctl = fme_hdr_ioctl,
 };
 
+#define FME_THERM_THRESHOLD	0x8
+#define TEMP_THRESHOLD1		GENMASK_ULL(6, 0)
+#define TEMP_THRESHOLD1_EN	BIT_ULL(7)
+#define TEMP_THRESHOLD2		GENMASK_ULL(14, 8)
+#define TEMP_THRESHOLD2_EN	BIT_ULL(15)
+#define TRIP_THRESHOLD		GENMASK_ULL(30, 24)
+#define TEMP_THRESHOLD1_STATUS	BIT_ULL(32)		/* threshold1 reached */
+#define TEMP_THRESHOLD2_STATUS	BIT_ULL(33)		/* threshold2 reached */
+/* threshold1 policy: 0 - AP2 (90% throttle) / 1 - AP1 (50% throttle) */
+#define TEMP_THRESHOLD1_POLICY	BIT_ULL(44)
+
+#define FME_THERM_RDSENSOR_FMT1	0x10
+#define FPGA_TEMPERATURE	GENMASK_ULL(6, 0)
+
+#define FME_THERM_CAP		0x20
+#define THERM_NO_THROTTLE	BIT_ULL(0)
+
+#define MD_PRE_DEG
+
+static bool fme_thermal_throttle_support(void __iomem *base)
+{
+	u64 v = readq(base + FME_THERM_CAP);
+
+	return FIELD_GET(THERM_NO_THROTTLE, v) ? false : true;
+}
+
+static umode_t thermal_hwmon_attrs_visible(const void *drvdata,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	const struct dfl_feature *feature = drvdata;
+
+	/* temperature is always supported, and check hardware cap for others */
+	if (attr == hwmon_temp_input)
+		return 0444;
+
+	return fme_thermal_throttle_support(feature->ioaddr) ? 0444 : 0;
+}
+
+static int thermal_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	u64 v;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		v = readq(feature->ioaddr + FME_THERM_RDSENSOR_FMT1);
+		*val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
+		break;
+	case hwmon_temp_max:
+		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
+		*val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * 1000);
+		break;
+	case hwmon_temp_crit:
+		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
+		*val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * 1000);
+		break;
+	case hwmon_temp_emergency:
+		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
+		*val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * 1000);
+		break;
+	case hwmon_temp_max_alarm:
+		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
+		*val = (long)FIELD_GET(TEMP_THRESHOLD1_STATUS, v);
+		break;
+	case hwmon_temp_crit_alarm:
+		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
+		*val = (long)FIELD_GET(TEMP_THRESHOLD2_STATUS, v);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops thermal_hwmon_ops = {
+	.is_visible = thermal_hwmon_attrs_visible,
+	.read = thermal_hwmon_read,
+};
+
+static const struct hwmon_channel_info *thermal_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_EMERGENCY |
+				 HWMON_T_MAX   | HWMON_T_MAX_ALARM |
+				 HWMON_T_CRIT  | HWMON_T_CRIT_ALARM),
+	NULL
+};
+
+static const struct hwmon_chip_info thermal_hwmon_chip_info = {
+	.ops = &thermal_hwmon_ops,
+	.info = thermal_hwmon_info,
+};
+
+static ssize_t temp1_max_policy_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	u64 v;
+
+	v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(TEMP_THRESHOLD1_POLICY, v));
+}
+
+static DEVICE_ATTR_RO(temp1_max_policy);
+
+static struct attribute *thermal_extra_attrs[] = {
+	&dev_attr_temp1_max_policy.attr,
+	NULL,
+};
+
+static umode_t thermal_extra_attrs_visible(struct kobject *kobj,
+					   struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+
+	return fme_thermal_throttle_support(feature->ioaddr) ? attr->mode : 0;
+}
+
+static const struct attribute_group thermal_extra_group = {
+	.attrs		= thermal_extra_attrs,
+	.is_visible	= thermal_extra_attrs_visible,
+};
+__ATTRIBUTE_GROUPS(thermal_extra);
+
+static int fme_thermal_mgmt_init(struct platform_device *pdev,
+				 struct dfl_feature *feature)
+{
+	struct device *hwmon;
+
+	/*
+	 * create hwmon to allow userspace monitoring temperature and other
+	 * threshold information.
+	 *
+	 * temp1_input      -> FPGA device temperature
+	 * temp1_max        -> hardware threshold 1 -> 50% or 90% throttling
+	 * temp1_crit       -> hardware threshold 2 -> 100% throttling
+	 * temp1_emergency  -> hardware trip_threshold to shutdown FPGA
+	 * temp1_max_alarm  -> hardware threshold 1 alarm
+	 * temp1_crit_alarm -> hardware threshold 2 alarm
+	 *
+	 * create device specific sysfs interfaces, e.g. read temp1_max_policy
+	 * to understand the actual hardware throttling action (50% vs 90%).
+	 *
+	 * If hardware doesn't support automatic throttling per thresholds,
+	 * then all above sysfs interfaces are not visible except temp1_input
+	 * for temperature.
+	 */
+	hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
+						     "dfl_fme_thermal", feature,
+						     &thermal_hwmon_chip_info,
+						     thermal_extra_groups);
+	if (IS_ERR(hwmon)) {
+		dev_err(&pdev->dev, "Fail to register thermal hwmon\n");
+		return PTR_ERR(hwmon);
+	}
+
+	return 0;
+}
+
+static const struct dfl_feature_id fme_thermal_mgmt_id_table[] = {
+	{.id = FME_FEATURE_ID_THERMAL_MGMT,},
+	{0,}
+};
+
+static const struct dfl_feature_ops fme_thermal_mgmt_ops = {
+	.init = fme_thermal_mgmt_init,
+};
+
 static struct dfl_feature_driver fme_feature_drvs[] = {
 	{
 		.id_table = fme_hdr_id_table,
@@ -195,6 +369,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 		.ops = &fme_global_err_ops,
 	},
 	{
+		.id_table = fme_thermal_mgmt_id_table,
+		.ops = &fme_thermal_mgmt_ops,
+	},
+	{
 		.ops = NULL,
 	},
 };
-- 
1.8.3.1

