Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494363259E9
	for <lists+linux-api@lfdr.de>; Thu, 25 Feb 2021 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhBYWy1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Feb 2021 17:54:27 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:7678 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231335AbhBYWyR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Feb 2021 17:54:17 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610377200"; 
   d="scan'208";a="73172367"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2021 07:53:14 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9736A40083F0;
        Fri, 26 Feb 2021 07:53:10 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Dirk Behme <Dirk.Behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Subject: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car devices
Date:   Thu, 25 Feb 2021 22:51:44 +0000
Message-Id: <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The DAB hardware accelerator found on R-Car E3 and R-Car M3-N devices is
a hardware accelerator for software DAB demodulators.
It consists of one FFT (Fast Fourier Transform) module and one decoder
module, compatible with DAB specification (ETSI EN 300 401 and
ETSI TS 102 563).
The decoder module can perform FIC decoding and MSC decoding processing
from de-puncture to final decoded result.

This patch adds a device driver to support the FFT module only.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 MAINTAINERS                      |   7 ++
 drivers/misc/Kconfig             |   1 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/rcar_dab/Kconfig    |  11 ++
 drivers/misc/rcar_dab/Makefile   |   8 ++
 drivers/misc/rcar_dab/rcar_dev.c | 176 +++++++++++++++++++++++++++++++
 drivers/misc/rcar_dab/rcar_dev.h | 116 ++++++++++++++++++++
 drivers/misc/rcar_dab/rcar_fft.c | 160 ++++++++++++++++++++++++++++
 include/uapi/linux/rcar_dab.h    |  35 ++++++
 9 files changed, 515 insertions(+)
 create mode 100644 drivers/misc/rcar_dab/Kconfig
 create mode 100644 drivers/misc/rcar_dab/Makefile
 create mode 100644 drivers/misc/rcar_dab/rcar_dev.c
 create mode 100644 drivers/misc/rcar_dab/rcar_dev.h
 create mode 100644 drivers/misc/rcar_dab/rcar_fft.c
 create mode 100644 include/uapi/linux/rcar_dab.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 16ada1a4b751..83cd7a42d11d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4917,6 +4917,13 @@ L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/input/keyboard/dlink-dir685-touchkeys.c
 
+DAB HW ACCELERATOR DRIVER FOR R-CAR
+M:	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+L:	linux-renesas-soc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/renesas,dab.yaml
+F:	drivers/misc/rcar_dab/*
+
 DALLAS/MAXIM DS1685-FAMILY REAL TIME CLOCK
 M:	Joshua Kinard <kumba@gentoo.org>
 S:	Maintained
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f532c59bb59b..fe2ffb41e006 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -461,4 +461,5 @@ source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
+source "drivers/misc/rcar_dab/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b6f15a3c70..cb8821383287 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_RCAR_DAB)		+= rcar_dab/
diff --git a/drivers/misc/rcar_dab/Kconfig b/drivers/misc/rcar_dab/Kconfig
new file mode 100644
index 000000000000..ea0d2e1e9c2e
--- /dev/null
+++ b/drivers/misc/rcar_dab/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# R-Car DAB Hardware Accelerator
+#
+
+config RCAR_DAB
+	tristate "DAB accelerator for Renesas R-Car devices"
+	depends on ARCH_R8A77990 || ARCH_R8A77965
+	help
+	  Some R-Car devices come with an IP to accelerate DAB decoding.
+	  Enable this option to add driver support.
diff --git a/drivers/misc/rcar_dab/Makefile b/drivers/misc/rcar_dab/Makefile
new file mode 100644
index 000000000000..2eb818bfa7bf
--- /dev/null
+++ b/drivers/misc/rcar_dab/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Makefile for the Renesas R-Car DAB driver
+#
+
+obj-$(CONFIG_RCAR_DAB) += rcar_dab.o
+
+rcar_dab-y := rcar_dev.o rcar_fft.o
diff --git a/drivers/misc/rcar_dab/rcar_dev.c b/drivers/misc/rcar_dab/rcar_dev.c
new file mode 100644
index 000000000000..f53da3037597
--- /dev/null
+++ b/drivers/misc/rcar_dab/rcar_dev.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * R-Car Gen3 DAB hardware accelerator driver
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ *
+ */
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/rcar_dab.h>
+#include "rcar_dev.h"
+
+irqreturn_t rcar_dab_irq(int irq, void *devid)
+{
+	struct rcar_dab *dab = devid;
+	u32 intsr, intcr1;
+
+	spin_lock(&dab->shared_regs_lock);
+
+	intcr1 = rcar_dab_read(dab, RCAR_DAB_INTCR1);
+	rcar_dab_write(dab, RCAR_DAB_INTCR1, 0x000003FF);
+
+	intsr = rcar_dab_read(dab, RCAR_DAB_INTSR);
+	if (!intsr) {
+		rcar_dab_write(dab, RCAR_DAB_INTCR1, intcr1);
+		spin_unlock(&dab->shared_regs_lock);
+		return IRQ_NONE;
+	}
+
+	/* Re-enable interrupts that haven't fired */
+	rcar_dab_write(dab, RCAR_DAB_INTCR1, 0x3FF & (intsr | intcr1));
+	/* Clear interrupts */
+	rcar_dab_write(dab, RCAR_DAB_INTSR, 0x7 & ~intsr);
+
+	spin_unlock(&dab->shared_regs_lock);
+
+	if (intsr & RCAR_DAB_INTSR_FFT_DONE)
+		rcar_dab_fft_irq(dab);
+
+	return IRQ_HANDLED;
+}
+
+static long rcar_dab_unlocked_ioctl(struct file *file, unsigned int cmd,
+				    unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct rcar_dab *dab;
+	int ret;
+
+	dab = container_of(file->private_data, struct rcar_dab, misc);
+
+	switch (cmd) {
+	case RCAR_DAB_IOC_FFT:
+		if (!access_ok(argp, sizeof(struct rcar_dab_fft_req)))
+			return -EFAULT;
+		ret = rcar_dab_fft(dab, argp);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
+static const struct file_operations rcar_dab_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= rcar_dab_unlocked_ioctl,
+};
+
+static int rcar_dab_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_dab *dab;
+	int ret, irq;
+
+	dab = devm_kzalloc(dev, sizeof(*dab), GFP_KERNEL);
+	if (!dab)
+		return -ENOMEM;
+	dab->pdev = pdev;
+
+	dab->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dab->base))
+		return PTR_ERR(dab->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Can't get the irq.\n");
+		return -EINVAL;
+	}
+
+	dab->clk = devm_clk_get(&pdev->dev, "dab");
+	if (IS_ERR(dab->clk)) {
+		ret = PTR_ERR(dab->clk);
+		dev_err(dev, "Can't get the clock (%d).\n", ret);
+		return ret;
+	}
+
+	spin_lock_init(&dab->shared_regs_lock);
+
+	ret = clk_prepare_enable(dab->clk);
+	if (ret)
+		return ret;
+
+	ret = rcar_dab_fft_probe(dab);
+	if (ret)
+		goto error_clock_disable;
+
+	ret = devm_request_irq(dev, irq, rcar_dab_irq, 0, dev_name(dev), dab);
+	if (ret) {
+		dev_err(dev, "Can't request the irq (%d).\n", ret);
+		goto error_remove;
+	}
+
+	platform_set_drvdata(pdev, dab);
+
+	dab->misc.minor = MISC_DYNAMIC_MINOR;
+	dab->misc.name = RCAR_DAB_DRV_NAME;
+	dab->misc.fops = &rcar_dab_fops;
+	ret = misc_register(&dab->misc);
+	if (ret) {
+		dev_err(dev, "Can't register misc device (%d).\n", ret);
+		goto error_remove;
+	}
+
+	dev_info(dev, "R-Car Gen3 DAB misc driver ready.\n");
+
+	return 0;
+
+error_remove:
+	rcar_dab_fft_remove(dab);
+
+error_clock_disable:
+	clk_disable_unprepare(dab->clk);
+
+	return ret;
+}
+
+static int rcar_dab_remove(struct platform_device *pdev)
+{
+	struct rcar_dab *dab = platform_get_drvdata(pdev);
+
+	misc_deregister(&dab->misc);
+	rcar_dab_fft_remove(dab);
+	clk_disable_unprepare(dab->clk);
+
+	return 0;
+}
+
+static const struct of_device_id rcar_dab_of_table[] = {
+	{ .compatible = "renesas,rcar-gen3-dab" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rcar_dab_of_table);
+
+static struct platform_driver rcar_dab_driver = {
+	.driver			= {
+		.name		= RCAR_DAB_DRV_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(rcar_dab_of_table),
+	},
+	.probe		= rcar_dab_probe,
+	.remove		= rcar_dab_remove,
+};
+
+module_platform_driver(rcar_dab_driver);
+
+MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
+MODULE_DESCRIPTION("Driver for R-Car DAB IP");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/rcar_dab/rcar_dev.h b/drivers/misc/rcar_dab/rcar_dev.h
new file mode 100644
index 000000000000..1fc6d1fc04d6
--- /dev/null
+++ b/drivers/misc/rcar_dab/rcar_dev.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * R-Car Gen3 DAB driver shared definitions
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ *
+ */
+#ifndef _RCAR_DEV_H_
+#define _RCAR_DEV_H_
+
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+
+#define RCAR_DAB_DRV_NAME			"rcar_dab"
+
+/* FFT registers offset */
+#define RCAR_DAB_FFTCR				0x000
+#define RCAR_DAB_FFTSSR				0x004
+#define RCAR_DAB_FFTREQCR			0x00C
+#define RCAR_DAB_FFTINADDR			0x010
+#define RCAR_DAB_FFTOUTADDR			0x014
+#define RCAR_DAB_FFTNUMOFDMR			0x018
+
+/* Interrupt registers offset */
+#define RCAR_DAB_INTSR				0x0C0
+#define RCAR_DAB_INTCR1				0x0C4
+
+/* Register DAB_FFTCR */
+#define RCAR_DAB_FFTCR_FFT_EN_DISABLED		0
+#define RCAR_DAB_FFTCR_FFT_EN_ENABLED		1
+
+/* Register DAB_FFTREQCR */
+#define RCAR_DAB_FFTREQCR_FFT_REQ_INACTIVE	0
+#define RCAR_DAB_FFTREQCR_FFT_REQ_ACTIVE	1
+
+/* Register DAB_INTSR */
+#define RCAR_DAB_INTSR_FFT_DONE			0x1
+
+/* Register DAB_INTCR1 */
+#define RCAR_DAB_INTCR1_FFT_DONE_MASK		0x1
+#define RCAR_DAB_INTCR1_FFT_DONE_INT_ENABLED	0
+#define RCAR_DAB_INTCR1_FFT_DONE_INT_DISABLED	1
+
+struct rcar_dab_fft {
+	bool done;			/*
+					 * Condition for waking up the process
+					 * sleeping while FFT is in progress.
+					 */
+	wait_queue_head_t wait;		/* Wait queue for FFT. */
+	struct mutex lock;		/* Mutex for FFT. */
+	dma_addr_t dma_input_buf;	/*
+					 * Input buffer seen by the FFT
+					 * module.
+					 */
+	dma_addr_t dma_output_buf;	/*
+					 * Output buffer seen by the FFT
+					 * module.
+					 */
+	void *input_buffer;		/* Input buffer seen by the CPU */
+	void *output_buffer;		/* Output buffer seen by the CPU */
+};
+
+struct rcar_dab {
+	void __iomem *base;		/* Base register address. */
+	struct clk *clk;		/* Module clock. */
+	struct platform_device *pdev;	/* Platform device. */
+	spinlock_t shared_regs_lock;	/*
+					 * Spin lock for accessing shared
+					 * registers.
+					 */
+	struct miscdevice misc;		/* misc structure */
+	struct rcar_dab_fft fft;	/* FFT specific data */
+};
+
+static inline void rcar_dab_write(struct rcar_dab *dab, u32 offset, u32 data)
+{
+	writel(data, dab->base + offset);
+}
+
+static inline u32 rcar_dab_read(struct rcar_dab *dab, u32 offset)
+{
+	return readl(dab->base + offset);
+}
+
+/*
+ * Most of the registers are module specific (either FFT, FIC, or MSC specific)
+ * and contain only one field. Furthermore, most of the registers are accessed
+ * in the context of single process, therefore we don't need to make sure we
+ * serialize access to those registers. However, some of the registers are
+ * shared among modules (like the interrupt specific ones), and the irq function
+ * might try and access those registers while a process is requesting some
+ * module specific processing, therefore accessing those registers require
+ * serialization via spin locks.
+ */
+static inline void rcar_dab_update_bits_locked(struct rcar_dab *dab,
+					       u32 offset, u32 mask, u32 val)
+{
+	u32 tmp, orig;
+
+	spin_lock(&dab->shared_regs_lock);
+
+	orig = rcar_dab_read(dab, offset);
+	tmp = orig & ~mask;
+	tmp |= val & mask;
+	rcar_dab_write(dab, offset, tmp);
+
+	spin_unlock(&dab->shared_regs_lock);
+}
+
+int rcar_dab_fft_probe(struct rcar_dab *dab);
+void rcar_dab_fft_remove(struct rcar_dab *dab);
+void rcar_dab_fft_irq(struct rcar_dab *dab);
+void rcar_dab_fft_disable(struct rcar_dab *dab);
+int rcar_dab_fft(struct rcar_dab *dab, struct rcar_dab_fft_req __user *fft_req);
+
+#endif /* _RCAR_DEV_H_ */
diff --git a/drivers/misc/rcar_dab/rcar_fft.c b/drivers/misc/rcar_dab/rcar_fft.c
new file mode 100644
index 000000000000..bc064dc4de4c
--- /dev/null
+++ b/drivers/misc/rcar_dab/rcar_fft.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * R-Car Gen3 DAB FFT implementation
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ *
+ */
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/rcar_dab.h>
+#include "rcar_dev.h"
+
+#define FFT_MAX_BUFFER_SIZE		8192
+
+/* The index of the array corresponds to the value for FFT_MODE */
+static const unsigned int rcar_dab_fft_size_lut[] = {
+	256, 512, 1024, 2048
+};
+
+int rcar_dab_fft_probe(struct rcar_dab *dab)
+{
+	struct device *dev = &dab->pdev->dev;
+
+	rcar_dab_fft_disable(dab);
+	mutex_init(&dab->fft.lock);
+	init_waitqueue_head(&dab->fft.wait);
+
+	dab->fft.input_buffer = dma_alloc_coherent(dev, FFT_MAX_BUFFER_SIZE,
+						   &dab->fft.dma_input_buf,
+						   GFP_KERNEL);
+	if (!dab->fft.input_buffer)
+		return -ENOMEM;
+
+	dab->fft.output_buffer = dma_alloc_coherent(dev, FFT_MAX_BUFFER_SIZE,
+						    &dab->fft.dma_output_buf,
+						    GFP_KERNEL);
+	if (!dab->fft.output_buffer) {
+		dma_free_coherent(dev, FFT_MAX_BUFFER_SIZE,
+				  dab->fft.input_buffer,
+				  dab->fft.dma_input_buf);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void rcar_dab_fft_remove(struct rcar_dab *dab)
+{
+	struct device *dev = &dab->pdev->dev;
+
+	rcar_dab_fft_disable(dab);
+
+	dma_free_coherent(dev, FFT_MAX_BUFFER_SIZE, dab->fft.input_buffer,
+			  dab->fft.dma_input_buf);
+	dma_free_coherent(dev, FFT_MAX_BUFFER_SIZE, dab->fft.output_buffer,
+			  dab->fft.dma_output_buf);
+}
+
+static int rcar_dab_fft_init(struct rcar_dab *dab, struct rcar_dab_fft_req *fft)
+{
+	u32 mode;
+
+	for (mode = 0; mode < ARRAY_SIZE(rcar_dab_fft_size_lut); mode++)
+		if (rcar_dab_fft_size_lut[mode] == fft->points)
+			break;
+	if (mode == ARRAY_SIZE(rcar_dab_fft_size_lut))
+		return -EINVAL;
+	if (fft->ofdm_number == 0)
+		return -EINVAL;
+
+	rcar_dab_write(dab, RCAR_DAB_FFTSSR, mode);
+	rcar_dab_write(dab, RCAR_DAB_FFTNUMOFDMR, fft->ofdm_number);
+	rcar_dab_write(dab, RCAR_DAB_FFTINADDR, (u32)dab->fft.dma_input_buf);
+	rcar_dab_write(dab, RCAR_DAB_FFTOUTADDR, (u32)dab->fft.dma_output_buf);
+
+	return 0;
+}
+
+void rcar_dab_fft_disable(struct rcar_dab *dab)
+{
+	/* Disable FFT interrupt in case it's enabled */
+	rcar_dab_update_bits_locked(dab, RCAR_DAB_INTCR1,
+				    RCAR_DAB_INTCR1_FFT_DONE_MASK,
+				    RCAR_DAB_INTCR1_FFT_DONE_INT_DISABLED);
+
+	/* Clear FFT interrupt status */
+	rcar_dab_update_bits_locked(dab, RCAR_DAB_INTSR,
+				    RCAR_DAB_INTSR_FFT_DONE, 0);
+
+	/* Mark FFT req as inactive */
+	rcar_dab_write(dab, RCAR_DAB_FFTREQCR,
+		       RCAR_DAB_FFTREQCR_FFT_REQ_INACTIVE);
+
+	/* Disable FFT */
+	rcar_dab_write(dab, RCAR_DAB_FFTCR, RCAR_DAB_FFTCR_FFT_EN_DISABLED);
+}
+
+static void rcar_dab_fft_enable(struct rcar_dab *dab)
+{
+	/* Clear FFT interrupt status */
+	rcar_dab_update_bits_locked(dab, RCAR_DAB_INTSR,
+				    RCAR_DAB_INTSR_FFT_DONE, 0);
+
+	/* Enable Interrupt bit */
+	rcar_dab_update_bits_locked(dab, RCAR_DAB_INTCR1,
+				    RCAR_DAB_INTCR1_FFT_DONE_MASK,
+				    RCAR_DAB_INTCR1_FFT_DONE_INT_ENABLED);
+
+	/* Enable FFT */
+	rcar_dab_write(dab, RCAR_DAB_FFTCR, RCAR_DAB_FFTCR_FFT_EN_ENABLED);
+
+	/* Mark FFT request as active */
+	rcar_dab_write(dab, RCAR_DAB_FFTREQCR,
+		       RCAR_DAB_FFTREQCR_FFT_REQ_ACTIVE);
+}
+
+void rcar_dab_fft_irq(struct rcar_dab *dab)
+{
+	rcar_dab_fft_disable(dab);
+	dab->fft.done = true;
+	wake_up_interruptible(&dab->fft.wait);
+}
+
+int rcar_dab_fft(struct rcar_dab *dab, struct rcar_dab_fft_req __user *fft_req)
+{
+	int buffer_size, ret;
+
+	buffer_size = fft_req->points * 4;
+
+	mutex_lock(&dab->fft.lock);
+
+	if (copy_from_user(dab->fft.input_buffer, fft_req->input_address,
+			   buffer_size)) {
+		mutex_unlock(&dab->fft.lock);
+		return -EFAULT;
+	}
+
+	dab->fft.done = false;
+	ret = rcar_dab_fft_init(dab, fft_req);
+	if (ret) {
+		mutex_unlock(&dab->fft.lock);
+		return ret;
+	}
+
+	rcar_dab_fft_enable(dab);
+	wait_event_interruptible_timeout(dab->fft.wait, dab->fft.done, HZ);
+	if (!dab->fft.done) {
+		rcar_dab_fft_disable(dab);
+		ret = -EFAULT;
+	} else if (copy_to_user(fft_req->output_address, dab->fft.output_buffer,
+				buffer_size)) {
+		ret = -EFAULT;
+	}
+
+	mutex_unlock(&dab->fft.lock);
+
+	return ret;
+}
diff --git a/include/uapi/linux/rcar_dab.h b/include/uapi/linux/rcar_dab.h
new file mode 100644
index 000000000000..7f1ef07e3b57
--- /dev/null
+++ b/include/uapi/linux/rcar_dab.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * R-Car Gen3 DAB user space interface data structures
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ *
+ */
+#ifndef _RCAR_DAB_H_
+#define _RCAR_DAB_H_
+
+struct rcar_dab_fft_req {
+	int points;			/*
+					 * The number of points to use.
+					 * Legal values are 256, 512, 1024, and
+					 * 2048.
+					 */
+	unsigned char ofdm_number;	/*
+					 * Orthogonal Frequency Division
+					 * Multiplexing (OFDM).
+					 * Minimum value is 1, maximum value is
+					 * 255.
+					 */
+	void __user *input_address;	/*
+					 * User space address for the input
+					 * buffer.
+					 */
+	void __user *output_address;	/*
+					 * User space address for the output
+					 * buffer.
+					 */
+};
+
+#define	RCAR_DAB_IOC_FFT		_IOWR(0x90, 1, struct rcar_dab_fft_req *)
+
+#endif /* _RCAR_DAB_H_ */
-- 
2.25.1

