Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6133F7BA
	for <lists+linux-api@lfdr.de>; Wed, 17 Mar 2021 19:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhCQSBI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Mar 2021 14:01:08 -0400
Received: from pbmsgap02.intersil.com ([192.157.179.202]:39552 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhCQSBA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Mar 2021 14:01:00 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 14:00:59 EDT
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.42/8.16.0.42) with SMTP id 12HHhX7Y007459;
        Wed, 17 Mar 2021 13:50:01 -0400
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap02.intersil.com with ESMTP id 378ren1t4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 13:50:01 -0400
Received: from pbmxdp03.intersil.corp (132.158.200.224) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2176.2; Wed, 17 Mar 2021 13:49:59 -0400
Received: from localhost (132.158.202.108) by pbmxdp03.intersil.corp
 (132.158.200.224) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 17 Mar 2021 13:49:58 -0400
From:   <min.li.xe@renesas.com>
To:     <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v1] misc: Add Renesas Synchronization Management Unit (SMU) support
Date:   Wed, 17 Mar 2021 13:44:54 -0400
Message-ID: <1616003094-1701-1-git-send-email-min.li.xe@renesas.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-MML: disable
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_11:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170120
X-Proofpoint-Spam-Reason: mlx
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
of timing and synchronization devices.It will be used by Renesas PTP Clock
Manager for Linux (pcm4l) software to provide support to GNSS assisted
partial timing support (APTS) and other networking timing functions.

Current version provides kernel API's to support the following functions
-set combomode to enable SYNCE clock support
-read dpll's state to determine if the dpll is locked to the GNSS channel
-read dpll's ffo (fractional frequency offset)

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/misc/Kconfig      |  10 ++
 drivers/misc/Makefile     |   2 +
 drivers/misc/rsmu_cdev.c  | 336 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/rsmu_cdev.h  |  72 ++++++++++
 drivers/misc/rsmu_cm.c    | 166 +++++++++++++++++++++++
 drivers/misc/rsmu_sabre.c | 128 ++++++++++++++++++
 include/uapi/linux/rsmu.h |  61 +++++++++
 7 files changed, 775 insertions(+)
 create mode 100644 drivers/misc/rsmu_cdev.c
 create mode 100644 drivers/misc/rsmu_cdev.h
 create mode 100644 drivers/misc/rsmu_cm.c
 create mode 100644 drivers/misc/rsmu_sabre.c
 create mode 100644 include/uapi/linux/rsmu.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f532c59..1e2bc33 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -445,6 +445,16 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config RSMU
+	tristate "Renesas Synchronization Management Unit (SMU)"
+	depends on MFD_RSMU_I2C || MFD_RSMU_SPI
+	help
+	  This option enables support for the IDT ClockMatrix(TM) and 82P33xxx
+	  families of timing and synchronization devices.It will be used by
+	  Renesas PTP Clock Manager for Linux (pcm4l) software to provide support
+	  for GNSS assisted partial timing support (APTS) and other networking
+	  timing functions.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b6f15..21b8ed4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,5 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+rsmu-objs			:= rsmu_cdev.o rsmu_cm.o rsmu_sabre.o
+obj-$(CONFIG_RSMU)		+= rsmu.o
diff --git a/drivers/misc/rsmu_cdev.c b/drivers/misc/rsmu_cdev.c
new file mode 100644
index 0000000..d80de4d
--- /dev/null
+++ b/drivers/misc/rsmu_cdev.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
+ * of timing and synchronization devices.It will be used by Renesas PTP Clock
+ * Manager for Linux (pcm4l) software to provide support to GNSS assisted
+ * partial timing support (APTS) and other networking timing functions.
+ *
+ * Please note it must work with Renesas MFD driver to access device through
+ * I2C/SPI.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/mfd/rsmu.h>
+#include <uapi/linux/rsmu.h>
+
+#include "rsmu_cdev.h"
+
+#define DRIVER_NAME	"rsmu"
+#define DRIVER_MAX_DEV	BIT(MINORBITS)
+
+static struct class *rsmu_class;
+static dev_t rsmu_cdevt;
+static struct rsmu_ops *ops_array[] = {
+	[RSMU_CM] = &cm_ops,
+	[RSMU_SABRE] = &sabre_ops,
+};
+
+static int
+rsmu_set_combomode(struct rsmu_cdev *rsmu, void __user *arg)
+{
+	struct rsmu_ops *ops = rsmu->ops;
+	struct rsmu_combomode mode;
+	int err;
+
+	if (copy_from_user(&mode, arg, sizeof(mode)))
+		return -EFAULT;
+
+	if (ops->set_combomode == NULL)
+		return -ENOTSUPP;
+
+	mutex_lock(rsmu->lock);
+	err = ops->set_combomode(rsmu, mode.dpll, mode.mode);
+	mutex_unlock(rsmu->lock);
+
+	return err;
+}
+
+static int
+rsmu_get_dpll_state(struct rsmu_cdev *rsmu, void __user *arg)
+{
+	struct rsmu_ops *ops = rsmu->ops;
+	struct rsmu_get_state state_request;
+	u8 state;
+	int err;
+
+	if (copy_from_user(&state_request, arg, sizeof(state_request)))
+		return -EFAULT;
+
+	if (ops->get_dpll_state == NULL)
+		return -ENOTSUPP;
+
+	mutex_lock(rsmu->lock);
+	err = ops->get_dpll_state(rsmu, state_request.dpll, &state);
+	mutex_unlock(rsmu->lock);
+
+	state_request.state = state;
+	if (copy_to_user(arg, &state_request, sizeof(state_request)))
+		return -EFAULT;
+
+	return err;
+}
+
+static int
+rsmu_get_dpll_ffo(struct rsmu_cdev *rsmu, void __user *arg)
+{
+	struct rsmu_ops *ops = rsmu->ops;
+	struct rsmu_get_ffo ffo_request;
+	int err;
+
+	if (copy_from_user(&ffo_request, arg, sizeof(ffo_request)))
+		return -EFAULT;
+
+	if (ops->get_dpll_ffo == NULL)
+		return -ENOTSUPP;
+
+	mutex_lock(rsmu->lock);
+	err = ops->get_dpll_ffo(rsmu, ffo_request.dpll, &ffo_request);
+	mutex_unlock(rsmu->lock);
+
+	if (copy_to_user(arg, &ffo_request, sizeof(ffo_request)))
+		return -EFAULT;
+
+	return err;
+}
+
+static int
+rsmu_open(struct inode *iptr, struct file *fptr)
+{
+	struct rsmu_cdev *rsmu;
+
+	rsmu = container_of(iptr->i_cdev, struct rsmu_cdev, rsmu_cdev);
+	if (!rsmu)
+		return -EAGAIN;
+
+	fptr->private_data = rsmu;
+	return 0;
+}
+
+static int
+rsmu_release(struct inode *iptr, struct file *fptr)
+{
+	struct rsmu_cdev *rsmu;
+
+	rsmu = container_of(iptr->i_cdev, struct rsmu_cdev, rsmu_cdev);
+	if (!rsmu)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static long
+rsmu_ioctl(struct file *fptr, unsigned int cmd, unsigned long data)
+{
+	struct rsmu_cdev *rsmu = fptr->private_data;
+	void __user *arg = (void __user *)data;
+	int err = 0;
+
+	if (!rsmu)
+		return -EINVAL;
+
+	switch (cmd) {
+	case RSMU_SET_COMBOMODE:
+		err = rsmu_set_combomode(rsmu, arg);
+		break;
+	case RSMU_GET_STATE:
+		err = rsmu_get_dpll_state(rsmu, arg);
+		break;
+	case RSMU_GET_FFO:
+		err = rsmu_get_dpll_ffo(rsmu, arg);
+		break;
+	default:
+		/* Should not get here */
+		dev_err(rsmu->dev, "Undefined RSMU IOCTL");
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+static long rsmu_compat_ioctl(struct file *fptr, unsigned int cmd,
+			      unsigned long data)
+{
+	return rsmu_ioctl(fptr, cmd, data);
+}
+
+static const struct file_operations rsmu_fops = {
+	.owner = THIS_MODULE,
+	.open = rsmu_open,
+	.release = rsmu_release,
+	.unlocked_ioctl = rsmu_ioctl,
+	.compat_ioctl =	rsmu_compat_ioctl,
+};
+
+static int rsmu_init_ops(struct rsmu_cdev *rsmu)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ops_array); i++)
+		if (ops_array[i]->type == rsmu->type)
+			break;
+
+	if (i == ARRAY_SIZE(ops_array))
+		return -EINVAL;
+
+	rsmu->ops = ops_array[i];
+	return 0;
+}
+
+static int
+rsmu_probe(struct platform_device *pdev)
+{
+	struct rsmu_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct rsmu_cdev *rsmu;
+	struct device *rsmu_cdev;
+	int err;
+
+	rsmu = devm_kzalloc(&pdev->dev, sizeof(*rsmu), GFP_KERNEL);
+	if (!rsmu)
+		return -ENOMEM;
+
+	rsmu->dev = &pdev->dev;
+	rsmu->mfd = pdev->dev.parent;
+	rsmu->type = pdata->type;
+	rsmu->lock = pdata->lock;
+	rsmu->index = pdata->index;
+
+	/* Save driver private data */
+	platform_set_drvdata(pdev, rsmu);
+
+	cdev_init(&rsmu->rsmu_cdev, &rsmu_fops);
+	rsmu->rsmu_cdev.owner = THIS_MODULE;
+	err = cdev_add(&rsmu->rsmu_cdev,
+		       MKDEV(MAJOR(rsmu_cdevt), 0), 1);
+	if (err < 0) {
+		dev_err(rsmu->dev, "cdev_add failed");
+		err = -EIO;
+		goto err_rsmu_dev;
+	}
+
+	if (!rsmu_class) {
+		err = -EIO;
+		dev_err(rsmu->dev, "rsmu class not created correctly");
+		goto err_rsmu_cdev;
+	}
+
+	rsmu_cdev = device_create(rsmu_class, rsmu->dev,
+				  MKDEV(MAJOR(rsmu_cdevt), 0),
+				  rsmu, "rsmu%d", rsmu->index);
+	if (IS_ERR(rsmu_cdev)) {
+		dev_err(rsmu->dev, "Unable to create char device");
+		err = PTR_ERR(rsmu_cdev);
+		goto err_rsmu_cdev;
+	}
+
+	err = rsmu_init_ops(rsmu);
+	if (err) {
+		dev_err(rsmu->dev, "Unable to match type %d", rsmu->type);
+		goto err_rsmu_cdev;
+	}
+
+	dev_info(rsmu->dev, "Probe SMU type %d successful\n", rsmu->type);
+	return 0;
+
+	/* Failure cleanup */
+err_rsmu_cdev:
+	cdev_del(&rsmu->rsmu_cdev);
+err_rsmu_dev:
+	return err;
+}
+
+static int
+rsmu_remove(struct platform_device *pdev)
+{
+	struct rsmu_cdev *rsmu = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	if (!rsmu)
+		return -ENODEV;
+
+	if (!rsmu_class) {
+		dev_err(dev, "rsmu_class is NULL");
+		return -EIO;
+	}
+
+	device_destroy(rsmu_class, MKDEV(MAJOR(rsmu_cdevt), 0));
+	cdev_del(&rsmu->rsmu_cdev);
+
+	return 0;
+}
+
+static const struct platform_device_id rsmu_id_table[] = {
+	{ "rsmu-cdev0", },
+	{ "rsmu-cdev1", },
+	{ "rsmu-cdev2", },
+	{ "rsmu-cdev3", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, rsmu_id_table);
+
+static struct platform_driver rsmu_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+	},
+	.probe = rsmu_probe,
+	.remove =  rsmu_remove,
+	.id_table = rsmu_id_table,
+};
+
+static int __init rsmu_init(void)
+{
+	int err;
+
+	rsmu_class = class_create(THIS_MODULE, DRIVER_NAME);
+	if (IS_ERR(rsmu_class)) {
+		err = PTR_ERR(rsmu_class);
+		pr_err("Unable to register rsmu class");
+		return err;
+	}
+
+	err = alloc_chrdev_region(&rsmu_cdevt, 0, DRIVER_MAX_DEV, DRIVER_NAME);
+	if (err < 0) {
+		pr_err("Unable to get major number");
+		goto err_rsmu_class;
+	}
+
+	err = platform_driver_register(&rsmu_driver);
+	if (err < 0) {
+		pr_err("Unabled to register %s driver", DRIVER_NAME);
+		goto err_rsmu_drv;
+	}
+	return 0;
+
+	/* Error Path */
+err_rsmu_drv:
+	unregister_chrdev_region(rsmu_cdevt, DRIVER_MAX_DEV);
+err_rsmu_class:
+	class_destroy(rsmu_class);
+	return err;
+}
+
+static void __exit rsmu_exit(void)
+{
+	platform_driver_unregister(&rsmu_driver);
+	unregister_chrdev_region(rsmu_cdevt, DRIVER_MAX_DEV);
+	class_destroy(rsmu_class);
+	rsmu_class = NULL;
+}
+
+module_init(rsmu_init);
+module_exit(rsmu_exit);
+
+MODULE_DESCRIPTION("Renesas SMU character device driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/rsmu_cdev.h b/drivers/misc/rsmu_cdev.h
new file mode 100644
index 0000000..3ced817
--- /dev/null
+++ b/drivers/misc/rsmu_cdev.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * This driver is developed for the IDT ClockMatrix(TM) of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#ifndef __LINUX_RSMU_CDEV_H
+#define __LINUX_RSMU_CDEV_H
+
+#include <linux/cdev.h>
+
+struct rsmu_ops;
+
+/**
+ * struct rsmu_cdev - Driver data for RSMU character device
+ * @dev: pointer to platform device
+ * @mfd: pointer to MFD device
+ * @rsmu_cdev: character device handle
+ * @lock: mutex to protect operations from being interrupted
+ * @type: rsmu device type
+ * @ops: rsmu device methods
+ * @index: rsmu device index
+ */
+struct rsmu_cdev {
+	struct device *dev;
+	struct device *mfd;
+	struct cdev rsmu_cdev;
+	struct mutex *lock;
+	enum rsmu_type type;
+	struct rsmu_ops *ops;
+	u8 index;
+};
+
+extern struct rsmu_ops cm_ops;
+extern struct rsmu_ops sabre_ops;
+
+struct rsmu_ops {
+	enum rsmu_type type;
+	int (*set_combomode)(struct rsmu_cdev *rsmu, u8 dpll, u8 mode);
+	int (*get_dpll_state)(struct rsmu_cdev *rsmu, u8 dpll, u8 *state);
+	int (*get_dpll_ffo)(struct rsmu_cdev *rsmu, u8 dpll,
+			    struct rsmu_get_ffo *ffo);
+};
+
+/**
+ * Enumerated type listing DPLL combination modes
+ */
+enum rsmu_dpll_combomode {
+	E_COMBOMODE_CURRENT = 0,
+	E_COMBOMODE_FASTAVG,
+	E_COMBOMODE_SLOWAVG,
+	E_COMBOMODE_HOLDOVER,
+	E_COMBOMODE_MAX
+};
+
+/**
+ * An id used to identify the respective child class states.
+ */
+enum rsmu_class_state {
+	E_SRVLOINITIALSTATE = 0,
+	E_SRVLOUNQUALIFIEDSTATE = 1,
+	E_SRVLOLOCKACQSTATE = 2,
+	E_SRVLOFREQUENCYLOCKEDSTATE = 3,
+	E_SRVLOTIMELOCKEDSTATE = 4,
+	E_SRVLOHOLDOVERINSPECSTATE = 5,
+	E_SRVLOHOLDOVEROUTOFSPECSTATE = 6,
+	E_SRVLOFREERUNSTATE = 7,
+	E_SRVNUMBERLOSTATES = 8,
+	E_SRVLOSTATEINVALID = 9,
+};
+#endif
diff --git a/drivers/misc/rsmu_cm.c b/drivers/misc/rsmu_cm.c
new file mode 100644
index 0000000..d5af624
--- /dev/null
+++ b/drivers/misc/rsmu_cm.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This driver is developed for the IDT ClockMatrix(TM) of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/mfd/idt8a340_reg.h>
+#include <linux/mfd/rsmu.h>
+#include <uapi/linux/rsmu.h>
+#include <asm/unaligned.h>
+
+#include "rsmu_cdev.h"
+
+static int rsmu_cm_set_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 mode)
+{
+	u16 dpll_ctrl_n;
+	u8 cfg;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_ctrl_n = DPLL_CTRL_0;
+		break;
+	case 1:
+		dpll_ctrl_n = DPLL_CTRL_1;
+		break;
+	case 2:
+		dpll_ctrl_n = DPLL_CTRL_2;
+		break;
+	case 3:
+		dpll_ctrl_n = DPLL_CTRL_3;
+		break;
+	case 4:
+		dpll_ctrl_n = DPLL_CTRL_4;
+		break;
+	case 5:
+		dpll_ctrl_n = DPLL_CTRL_5;
+		break;
+	case 6:
+		dpll_ctrl_n = DPLL_CTRL_6;
+		break;
+	case 7:
+		dpll_ctrl_n = DPLL_CTRL_7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mode >= E_COMBOMODE_MAX)
+		return -EINVAL;
+
+	err = rsmu_read(rsmu->mfd, dpll_ctrl_n + DPLL_CTRL_COMBO_MASTER_CFG,
+			&cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	/* Only need to enable/disable COMBO_MODE_HOLD. */
+	if (mode)
+		cfg |= COMBO_MASTER_HOLD;
+	else
+		cfg &= ~COMBO_MASTER_HOLD;
+
+	return rsmu_write(rsmu->mfd, dpll_ctrl_n + DPLL_CTRL_COMBO_MASTER_CFG,
+			  &cfg, sizeof(cfg));
+}
+
+static int rsmu_cm_get_dpll_state(struct rsmu_cdev *rsmu, u8 dpll, u8 *state)
+{
+	u8 cfg;
+	int err;
+
+	/* 8 is sys dpll */
+	if (dpll > 8)
+		return -EINVAL;
+
+	err = rsmu_read(rsmu->mfd,
+			  STATUS + DPLL0_STATUS + dpll,
+			  &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	switch (cfg & DPLL_STATE_MASK) {
+	case DPLL_STATE_FREERUN:
+		*state = E_SRVLOUNQUALIFIEDSTATE;
+		break;
+	case DPLL_STATE_LOCKACQ:
+	case DPLL_STATE_LOCKREC:
+		*state = E_SRVLOLOCKACQSTATE;
+		break;
+	case DPLL_STATE_LOCKED:
+		*state = E_SRVLOTIMELOCKEDSTATE;
+		break;
+	case DPLL_STATE_HOLDOVER:
+		*state = E_SRVLOHOLDOVERINSPECSTATE;
+		break;
+	default:
+		*state = E_SRVLOSTATEINVALID;
+		break;
+	}
+
+	return 0;
+}
+
+static int rsmu_cm_get_dpll_ffo(struct rsmu_cdev *rsmu, u8 dpll,
+				struct rsmu_get_ffo *ffo)
+{
+	u8 buf[8] = {0};
+	s64 fcw = 0;
+	u16 dpll_filter_status;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_filter_status = DPLL0_FILTER_STATUS;
+		break;
+	case 1:
+		dpll_filter_status = DPLL1_FILTER_STATUS;
+		break;
+	case 2:
+		dpll_filter_status = DPLL2_FILTER_STATUS;
+		break;
+	case 3:
+		dpll_filter_status = DPLL3_FILTER_STATUS;
+		break;
+	case 4:
+		dpll_filter_status = DPLL4_FILTER_STATUS;
+		break;
+	case 5:
+		dpll_filter_status = DPLL5_FILTER_STATUS;
+		break;
+	case 6:
+		dpll_filter_status = DPLL6_FILTER_STATUS;
+		break;
+	case 7:
+		dpll_filter_status = DPLL7_FILTER_STATUS;
+		break;
+	case 8:
+		dpll_filter_status = DPLLSYS_FILTER_STATUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = rsmu_read(rsmu->mfd, STATUS + dpll_filter_status, buf, 6);
+	if (err)
+		return err;
+
+	/* Convert to frequency control word */
+	fcw = sign_extend64(get_unaligned_le64(buf), 47);
+
+	/* FCW unit is 2 ^ -53 = 1.1102230246251565404236316680908e-16 */
+	ffo->ffo = fcw * 111;
+
+	return 0;
+}
+
+struct rsmu_ops cm_ops = {
+	.type = RSMU_CM,
+	.set_combomode = rsmu_cm_set_combomode,
+	.get_dpll_state = rsmu_cm_get_dpll_state,
+	.get_dpll_ffo = rsmu_cm_get_dpll_ffo,
+};
diff --git a/drivers/misc/rsmu_sabre.c b/drivers/misc/rsmu_sabre.c
new file mode 100644
index 0000000..a60086f
--- /dev/null
+++ b/drivers/misc/rsmu_sabre.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This driver is developed for the IDT 82P33XXX series of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/mfd/idt82p33_reg.h>
+#include <linux/mfd/rsmu.h>
+#include <uapi/linux/rsmu.h>
+#include <asm/unaligned.h>
+
+#include "rsmu_cdev.h"
+
+static int rsmu_sabre_set_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 mode)
+{
+	u16 dpll_ctrl_n;
+	u8 cfg;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_ctrl_n = DPLL1_OPERATING_MODE_CNFG;
+		break;
+	case 1:
+		dpll_ctrl_n = DPLL2_OPERATING_MODE_CNFG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mode >= E_COMBOMODE_MAX)
+		return -EINVAL;
+
+	err = rsmu_read(rsmu->mfd, dpll_ctrl_n, &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	cfg &= ~(COMBO_MODE_MASK << COMBO_MODE_SHIFT);
+	cfg |= mode << COMBO_MODE_SHIFT;
+
+	return rsmu_write(rsmu->mfd, dpll_ctrl_n, &cfg, sizeof(cfg));
+}
+
+static int rsmu_sabre_get_dpll_state(struct rsmu_cdev *rsmu, u8 dpll, u8 *state)
+{
+	u16 dpll_sts_n;
+	u8 cfg;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_sts_n = DPLL1_OPERATING_STS;
+		break;
+	case 1:
+		dpll_sts_n = DPLL2_OPERATING_STS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = rsmu_read(rsmu->mfd, dpll_sts_n, &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	switch (cfg & OPERATING_STS_MASK) {
+	case DPLL_STATE_FREERUN:
+		*state = E_SRVLOUNQUALIFIEDSTATE;
+		break;
+	case DPLL_STATE_PRELOCKED2:
+	case DPLL_STATE_PRELOCKED:
+		*state = E_SRVLOLOCKACQSTATE;
+		break;
+	case DPLL_STATE_LOCKED:
+		*state = E_SRVLOTIMELOCKEDSTATE;
+		break;
+	case DPLL_STATE_HOLDOVER:
+		*state = E_SRVLOHOLDOVERINSPECSTATE;
+		break;
+	default:
+		*state = E_SRVLOSTATEINVALID;
+		break;
+	}
+
+	return 0;
+}
+
+static int rsmu_sabre_get_dpll_ffo(struct rsmu_cdev *rsmu, u8 dpll,
+				   struct rsmu_get_ffo *ffo)
+{
+	u8 buf[8] = {0};
+	s64 fcw = 0;
+	u16 dpll_freq_n;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_freq_n = DPLL1_HOLDOVER_FREQ_CNFG;
+		break;
+	case 1:
+		dpll_freq_n = DPLL2_HOLDOVER_FREQ_CNFG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = rsmu_read(rsmu->mfd, dpll_freq_n, buf, 5);
+	if (err)
+		return err;
+
+	/* Convert to frequency control word */
+	fcw = sign_extend64(get_unaligned_le64(buf), 39);
+
+	/* FCW unit is 77760 / ( 1638400 * 2^48) = 1.68615121864946 * 10^-16 */
+	ffo->ffo = div_s64(fcw * 168615, 1000);
+
+	return 0;
+}
+
+struct rsmu_ops sabre_ops = {
+	.type = RSMU_SABRE,
+	.set_combomode = rsmu_sabre_set_combomode,
+	.get_dpll_state = rsmu_sabre_get_dpll_state,
+	.get_dpll_ffo = rsmu_sabre_get_dpll_ffo,
+};
diff --git a/include/uapi/linux/rsmu.h b/include/uapi/linux/rsmu.h
new file mode 100644
index 0000000..28b9d94
--- /dev/null
+++ b/include/uapi/linux/rsmu.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Driver for the IDT ClockMatrix(TM) and 82p33xxx families of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+
+#ifndef __UAPI_LINUX_RSMU_CDEV_H
+#define __UAPI_LINUX_RSMU_CDEV_H
+
+/* Set dpll combomode */
+struct rsmu_combomode {
+	__u8 dpll;
+	__u8 mode;
+};
+
+/* Get dpll state */
+struct rsmu_get_state {
+	__u8 dpll;
+	__u8 state;
+};
+
+/* Get dpll ffo (fractional frequency offset) in ppqt*/
+struct rsmu_get_ffo {
+	__u8 dpll;
+	__s64 ffo;
+};
+
+/*
+ * RSMU IOCTL List
+ */
+#define RSMU_MAGIC '?'
+
+/**
+ * @Description
+ * ioctl to set SMU combo mode.
+ *
+ * @Parameters
+ * pointer to struct rsmu_combomode that contains dpll combomode setting
+ */
+#define RSMU_SET_COMBOMODE  _IOW(RSMU_MAGIC, 1, struct rsmu_combomode)
+
+/**
+ * @Description
+ * ioctl to get SMU dpll state.
+ *
+ * @Parameters
+ * pointer to struct rsmu_get_state that contains dpll state
+ */
+#define RSMU_GET_STATE  _IOR(RSMU_MAGIC, 2, struct rsmu_get_state)
+
+/**
+ * @Description
+ * ioctl to get SMU dpll ffo.
+ *
+ * @Parameters
+ * pointer to struct rsmu_get_ffo that contains dpll ffo in ppqt
+ */
+#define RSMU_GET_FFO  _IOR(RSMU_MAGIC, 3, struct rsmu_get_ffo)
+#endif /* __UAPI_LINUX_RSMU_CDEV_H */
-- 
2.7.4

