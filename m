Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC082AE24
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfE0FjQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 01:39:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:7420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfE0FjP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 01:39:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 22:39:14 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2019 22:39:13 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 10/16] fpga: dfl: add id_table for dfl private feature driver
Date:   Mon, 27 May 2019 13:22:20 +0800
Message-Id: <1558934546-12171-11-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch adds id_table for each dfl private feature driver,
it allows to reuse same private feature driver to match and support
multiple dfl private features.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 14 ++++++++++++--
 drivers/fpga/dfl-fme-main.c | 11 ++++++++---
 drivers/fpga/dfl-fme-pr.c   |  7 ++++++-
 drivers/fpga/dfl-fme.h      |  3 ++-
 drivers/fpga/dfl.c          | 21 +++++++++++++++++++--
 drivers/fpga/dfl.h          | 21 +++++++++++++++------
 6 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 8b434a4..65b3e89 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -435,6 +435,11 @@ static void port_hdr_uinit(struct platform_device *pdev,
 	return ret;
 }
 
+static const struct dfl_feature_id port_hdr_id_table[] = {
+	{.id = PORT_FEATURE_ID_HEADER,},
+	{0,}
+};
+
 static const struct dfl_feature_ops port_hdr_ops = {
 	.init = port_hdr_init,
 	.uinit = port_hdr_uinit,
@@ -495,6 +500,11 @@ static void port_afu_uinit(struct platform_device *pdev,
 	sysfs_remove_files(&pdev->dev.kobj, port_afu_attrs);
 }
 
+static const struct dfl_feature_id port_afu_id_table[] = {
+	{.id = PORT_FEATURE_ID_AFU,},
+	{0,}
+};
+
 static const struct dfl_feature_ops port_afu_ops = {
 	.init = port_afu_init,
 	.uinit = port_afu_uinit,
@@ -502,11 +512,11 @@ static void port_afu_uinit(struct platform_device *pdev,
 
 static struct dfl_feature_driver port_feature_drvs[] = {
 	{
-		.id = PORT_FEATURE_ID_HEADER,
+		.id_table = port_hdr_id_table,
 		.ops = &port_hdr_ops,
 	},
 	{
-		.id = PORT_FEATURE_ID_AFU,
+		.id_table = port_afu_id_table,
 		.ops = &port_afu_ops,
 	},
 	{
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 8b2a337..38c6342 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -158,6 +158,11 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 	return -ENODEV;
 }
 
+static const struct dfl_feature_id fme_hdr_id_table[] = {
+	{.id = FME_FEATURE_ID_HEADER,},
+	{0,}
+};
+
 static const struct dfl_feature_ops fme_hdr_ops = {
 	.init = fme_hdr_init,
 	.uinit = fme_hdr_uinit,
@@ -166,12 +171,12 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 
 static struct dfl_feature_driver fme_feature_drvs[] = {
 	{
-		.id = FME_FEATURE_ID_HEADER,
+		.id_table = fme_hdr_id_table,
 		.ops = &fme_hdr_ops,
 	},
 	{
-		.id = FME_FEATURE_ID_PR_MGMT,
-		.ops = &pr_mgmt_ops,
+		.id_table = fme_pr_mgmt_id_table,
+		.ops = &fme_pr_mgmt_ops,
 	},
 	{
 		.ops = NULL,
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index cd94ba8..52f1745 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -483,7 +483,12 @@ static long fme_pr_ioctl(struct platform_device *pdev,
 	return ret;
 }
 
-const struct dfl_feature_ops pr_mgmt_ops = {
+const struct dfl_feature_id fme_pr_mgmt_id_table[] = {
+	{.id = FME_FEATURE_ID_PR_MGMT,},
+	{0}
+};
+
+const struct dfl_feature_ops fme_pr_mgmt_ops = {
 	.init = pr_mgmt_init,
 	.uinit = pr_mgmt_uinit,
 	.ioctl = fme_pr_ioctl,
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index de20755..7a021c4 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -35,6 +35,7 @@ struct dfl_fme {
 	struct dfl_feature_platform_data *pdata;
 };
 
-extern const struct dfl_feature_ops pr_mgmt_ops;
+extern const struct dfl_feature_ops fme_pr_mgmt_ops;
+extern const struct dfl_feature_id fme_pr_mgmt_id_table[];
 
 #endif /* __DFL_FME_H */
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 28d61b6..1bb2b58 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -14,6 +14,8 @@
 
 #include "dfl.h"
 
+#define DRV_VERSION	"0.8"
+
 static DEFINE_MUTEX(dfl_id_mutex);
 
 /*
@@ -281,6 +283,21 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
 	return ret;
 }
 
+static bool dfl_feature_drv_match(struct dfl_feature *feature,
+				  struct dfl_feature_driver *driver)
+{
+	const struct dfl_feature_id *ids = driver->id_table;
+
+	if (ids) {
+		while (ids->id) {
+			if (ids->id == feature->id)
+				return true;
+			ids++;
+		}
+	}
+	return false;
+}
+
 /**
  * dfl_fpga_dev_feature_init - init for sub features of dfl feature device
  * @pdev: feature device.
@@ -301,8 +318,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 
 	while (drv->ops) {
 		dfl_fpga_dev_for_each_feature(pdata, feature) {
-			/* match feature and drv using id */
-			if (feature->id == drv->id) {
+			if (dfl_feature_drv_match(feature, drv)) {
 				ret = dfl_feature_instance_init(pdev, pdata,
 								feature, drv);
 				if (ret)
@@ -1178,3 +1194,4 @@ static void __exit dfl_fpga_exit(void)
 MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 3c5dc3a..fbc57f0 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -30,8 +30,8 @@
 /* plus one for fme device */
 #define MAX_DFL_FEATURE_DEV_NUM    (MAX_DFL_FPGA_PORT_NUM + 1)
 
-/* Reserved 0x0 for Header Group Register and 0xff for AFU */
-#define FEATURE_ID_FIU_HEADER		0x0
+/* Reserved 0xfe for Header Group Register and 0xff for AFU */
+#define FEATURE_ID_FIU_HEADER		0xfe
 #define FEATURE_ID_AFU			0xff
 
 #define FME_FEATURE_ID_HEADER		FEATURE_ID_FIU_HEADER
@@ -169,13 +169,22 @@ struct dfl_fpga_port_ops {
 int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
 
 /**
- * struct dfl_feature_driver - sub feature's driver
+ * struct dfl_feature_id - dfl private feature id
  *
- * @id: sub feature id.
- * @ops: ops of this sub feature.
+ * @id: unique dfl private feature id.
  */
-struct dfl_feature_driver {
+struct dfl_feature_id {
 	u64 id;
+};
+
+/**
+ * struct dfl_feature_driver - dfl private feature driver
+ *
+ * @id_table: id_table for dfl private features supported by this driver.
+ * @ops: ops of this dfl private feature driver.
+ */
+struct dfl_feature_driver {
+	const struct dfl_feature_id *id_table;
 	const struct dfl_feature_ops *ops;
 };
 
-- 
1.8.3.1

