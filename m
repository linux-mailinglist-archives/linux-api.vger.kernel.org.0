Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DE2AE20
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 07:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0FjL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 01:39:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:7420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfE0FjJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 01:39:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 22:39:09 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2019 22:39:07 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 07/16] fpga: dfl: pci: enable SRIOV support.
Date:   Mon, 27 May 2019 13:22:17 +0800
Message-Id: <1558934546-12171-8-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch enables the standard sriov support. It allows user to
enable SRIOV (and VFs), then user could pass through accelerators
(VFs) into virtual machine or use VFs directly in host.

Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h     |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 66b5720..2fa571b 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -223,8 +223,46 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 	return ret;
 }
 
+static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_cdev *cdev = drvdata->cdev;
+	int ret = 0;
+
+	mutex_lock(&cdev->lock);
+
+	if (!num_vfs) {
+		/*
+		 * disable SRIOV and then put released ports back to default
+		 * PF access mode.
+		 */
+		pci_disable_sriov(pcidev);
+
+		__dfl_fpga_cdev_config_port_vf(cdev, false);
+
+	} else if (cdev->released_port_num == num_vfs) {
+		/*
+		 * only enable SRIOV if cdev has matched released ports, put
+		 * released ports into VF access mode firstly.
+		 */
+		__dfl_fpga_cdev_config_port_vf(cdev, true);
+
+		ret = pci_enable_sriov(pcidev, num_vfs);
+		if (ret)
+			__dfl_fpga_cdev_config_port_vf(cdev, false);
+	} else {
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&cdev->lock);
+	return ret;
+}
+
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
+	if (dev_is_pf(&pcidev->dev))
+		cci_pci_sriov_configure(pcidev, 0);
+
 	cci_remove_feature_devs(pcidev);
 	pci_disable_pcie_error_reporting(pcidev);
 }
@@ -234,6 +272,7 @@ static void cci_pci_remove(struct pci_dev *pcidev)
 	.id_table = cci_pcie_id_tbl,
 	.probe = cci_pci_probe,
 	.remove = cci_pci_remove,
+	.sriov_configure = cci_pci_sriov_configure,
 };
 
 module_pci_driver(cci_pci_driver);
@@ -241,3 +280,4 @@ static void cci_pci_remove(struct pci_dev *pcidev)
 MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 308c808..28d61b6 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1112,6 +1112,47 @@ int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);
 
+static void config_port_vf(struct device *fme_dev, int port_id, bool is_vf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_PORT_OFST(port_id));
+
+	v &= ~FME_PORT_OFST_ACC_CTRL;
+	v |= FIELD_PREP(FME_PORT_OFST_ACC_CTRL,
+			is_vf ? FME_PORT_OFST_ACC_VF : FME_PORT_OFST_ACC_PF);
+
+	writeq(v, base + FME_HDR_PORT_OFST(port_id));
+}
+
+/**
+ * __dfl_fpga_cdev_config_port_vf - configure port to VF access mode
+ *
+ * @cdev: parent container device.
+ * @if_vf: true for VF access mode, and false for PF access mode
+ *
+ * Return: 0 on success, negative error code otherwise.
+ *
+ * This function is needed in sriov configuration routine. It could be used to
+ * configures the released ports access mode to VF or PF.
+ * The caller needs to hold lock for protection.
+ */
+void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf)
+{
+	struct dfl_feature_platform_data *pdata;
+
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		if (device_is_registered(&pdata->dev->dev))
+			continue;
+
+		config_port_vf(cdev->fme_dev, pdata->id, is_vf);
+	}
+}
+EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_config_port_vf);
+
 static int __init dfl_fpga_init(void)
 {
 	int ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 63f39ab..1350e8e 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -421,5 +421,6 @@ struct platform_device *
 
 int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev,
 			      u32 port_id, bool release);
+void __dfl_fpga_cdev_config_port_vf(struct dfl_fpga_cdev *cdev, bool is_vf);
 
 #endif /* __FPGA_DFL_H */
-- 
1.8.3.1

