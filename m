Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004522AE28
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 07:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE0FjT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 01:39:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:7420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfE0FjT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 01:39:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 22:39:18 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2019 22:39:16 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 12/16] fpga: dfl: afu: add error reporting support.
Date:   Mon, 27 May 2019 13:22:22 +0800
Message-Id: <1558934546-12171-13-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Error reporting is one important private feature, it reports error
detected on port and accelerated function unit (AFU). It introduces
several sysfs interfaces to allow userspace to check and clear
errors detected by hardware.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v2: add more error code description for error clear sysfs in doc.
    return -EINVAL instead of -EBUSY when input error code doesn't
    match in error clear sysfs.
v3: replace scnprintf with sprintf in sysfs interfaces.
    update sysfs doc kernel version and date.
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  39 ++++
 drivers/fpga/Makefile                             |   1 +
 drivers/fpga/dfl-afu-error.c                      | 225 ++++++++++++++++++++++
 drivers/fpga/dfl-afu-main.c                       |   4 +
 drivers/fpga/dfl-afu.h                            |   4 +
 5 files changed, 273 insertions(+)
 create mode 100644 drivers/fpga/dfl-afu-error.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index f5f746d..eeaebbd 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -79,3 +79,42 @@ KernelVersion:	5.3
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. Read this file to get the status of issued command
 		to userclck_freqcntrcmd.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/revision
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the revision of this error
+		reporting private feature.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/errors
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get errors detected on port and
+		Accelerated Function Unit (AFU).
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/first_malformed_req
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first malformed request
+		captured by hardware.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/clear
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. Write error code to this file to clear errors.
+		Write fails with -EINVAL if input parsing fails or input error
+		code doesn't match.
+		Write fails with -EBUSY or -ETIMEDOUT if error can't be cleared
+		as hardware is in low power state (-EBUSY) or not responding
+		(-ETIMEDOUT).
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 312b937..7255891 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
+dfl-afu-objs += dfl-afu-error.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
new file mode 100644
index 0000000..f20dbdf
--- /dev/null
+++ b/drivers/fpga/dfl-afu-error.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Accelerated Function Unit (AFU) Error Reporting
+ *
+ * Copyright 2019 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@linux.intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Mitchel Henry <henry.mitchel@intel.com>
+ */
+
+#include <linux/uaccess.h>
+
+#include "dfl-afu.h"
+
+#define PORT_ERROR_MASK		0x8
+#define PORT_ERROR		0x10
+#define PORT_FIRST_ERROR	0x18
+#define PORT_MALFORMED_REQ0	0x20
+#define PORT_MALFORMED_REQ1	0x28
+
+#define ERROR_MASK		GENMASK_ULL(63, 0)
+
+/* mask or unmask port errors by the error mask register. */
+static void __port_err_mask(struct device *dev, bool mask)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
+}
+
+/* clear port errors. */
+static int __port_err_clear(struct device *dev, u64 err)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *base_err, *base_hdr;
+	int ret;
+	u64 v;
+
+	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	/*
+	 * clear Port Errors
+	 *
+	 * - Check for AP6 State
+	 * - Halt Port by keeping Port in reset
+	 * - Set PORT Error mask to all 1 to mask errors
+	 * - Clear all errors
+	 * - Set Port mask to all 0 to enable errors
+	 * - All errors start capturing new errors
+	 * - Enable Port by pulling the port out of reset
+	 */
+
+	/* if device is still in AP6 power state, can not clear any error. */
+	v = readq(base_hdr + PORT_HDR_STS);
+	if (FIELD_GET(PORT_STS_PWR_STATE, v) == PORT_STS_PWR_STATE_AP6) {
+		dev_err(dev, "Could not clear errors, device in AP6 state.\n");
+		return -EBUSY;
+	}
+
+	/* Halt Port by keeping Port in reset */
+	ret = __port_disable(pdev);
+	if (ret)
+		return ret;
+
+	/* Mask all errors */
+	__port_err_mask(dev, true);
+
+	/* Clear errors if err input matches with current port errors.*/
+	v = readq(base_err + PORT_ERROR);
+
+	if (v == err) {
+		writeq(v, base_err + PORT_ERROR);
+
+		v = readq(base_err + PORT_FIRST_ERROR);
+		writeq(v, base_err + PORT_FIRST_ERROR);
+	} else {
+		ret = -EINVAL;
+	}
+
+	/* Clear mask */
+	__port_err_mask(dev, false);
+
+	/* Enable the Port by clear the reset */
+	__port_enable(pdev);
+
+	return ret;
+}
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	return sprintf(buf, "%u\n", dfl_feature_revision(base));
+}
+static DEVICE_ATTR_RO(revision);
+
+static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 error;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	error = readq(base + PORT_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
+}
+static DEVICE_ATTR_RO(errors);
+
+static ssize_t first_error_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 error;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	error = readq(base + PORT_FIRST_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
+}
+static DEVICE_ATTR_RO(first_error);
+
+static ssize_t first_malformed_req_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 req0, req1;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	req0 = readq(base + PORT_MALFORMED_REQ0);
+	req1 = readq(base + PORT_MALFORMED_REQ1);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%016llx%016llx\n",
+		       (unsigned long long)req1, (unsigned long long)req0);
+}
+static DEVICE_ATTR_RO(first_malformed_req);
+
+static ssize_t clear_store(struct device *dev, struct device_attribute *attr,
+			   const char *buff, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	u64 value;
+	int ret;
+
+	if (kstrtou64(buff, 0, &value))
+		return -EINVAL;
+
+	mutex_lock(&pdata->lock);
+	ret = __port_err_clear(dev, value);
+	mutex_unlock(&pdata->lock);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(clear);
+
+static struct attribute *port_err_attrs[] = {
+	&dev_attr_revision.attr,
+	&dev_attr_errors.attr,
+	&dev_attr_first_error.attr,
+	&dev_attr_first_malformed_req.attr,
+	&dev_attr_clear.attr,
+	NULL,
+};
+
+static struct attribute_group port_err_attr_group = {
+	.attrs = port_err_attrs,
+	.name = "errors",
+};
+
+static int port_err_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	dev_dbg(&pdev->dev, "PORT ERR Init.\n");
+
+	mutex_lock(&pdata->lock);
+	__port_err_mask(&pdev->dev, false);
+	mutex_unlock(&pdata->lock);
+
+	return sysfs_create_group(&pdev->dev.kobj, &port_err_attr_group);
+}
+
+static void port_err_uinit(struct platform_device *pdev,
+			   struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT ERR UInit.\n");
+
+	sysfs_remove_group(&pdev->dev.kobj, &port_err_attr_group);
+}
+
+const struct dfl_feature_id port_err_id_table[] = {
+	{.id = PORT_FEATURE_ID_ERROR,},
+	{0,}
+};
+
+const struct dfl_feature_ops port_err_ops = {
+	.init = port_err_init,
+	.uinit = port_err_uinit,
+};
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c8bc0b5..bcf6e28 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -523,6 +523,10 @@ static void port_afu_uinit(struct platform_device *pdev,
 		.ops = &port_afu_ops,
 	},
 	{
+		.id_table = port_err_id_table,
+		.ops = &port_err_ops,
+	},
+	{
 		.ops = NULL,
 	}
 };
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 35e60c5..c3182a2 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -100,4 +100,8 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 struct dfl_afu_dma_region *
 afu_dma_region_find(struct dfl_feature_platform_data *pdata,
 		    u64 iova, u64 size);
+
+extern const struct dfl_feature_ops port_err_ops;
+extern const struct dfl_feature_id port_err_id_table[];
+
 #endif /* __DFL_AFU_H */
-- 
1.8.3.1

