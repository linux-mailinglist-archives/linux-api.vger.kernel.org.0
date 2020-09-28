Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8F27B727
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgI1Vgt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgI1Vgs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67A7C0613CE;
        Mon, 28 Sep 2020 14:36:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so1483308pjh.5;
        Mon, 28 Sep 2020 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WrycSqfFwgro1544B9fdHLaLNfHVDac357G1kt17GJI=;
        b=Kb9q23sPGgUyP1xOwc0nnzQiUdt/USvAEWwpN+/lGcIlI6oMtrG86vMz3EyuyQqUjn
         g9Qm6QuwloJc1YYvC4woVROgE2cCnCEp6/3ZDlxttDDXXCTc+2kYbc8Ai0+kOkUfErzk
         xxvqeQOSAWD6qfw4taneDEwBsVN1wOeem3XuHcb0l9v0M3purNhB5gxZObpoznaQhtJl
         ink3pH9NrfwppGXN3UMO1ukXAXq1OBfm/6ShSgXeH99YFe10iVU9YG+E6EB7p0iKB2El
         p7L1Q8ACluZWnY+FgaLDwUzCkrhF4z/n5qHeq3BLs5w8VwbOmilgpZbOl5az3JvgqfK0
         yNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WrycSqfFwgro1544B9fdHLaLNfHVDac357G1kt17GJI=;
        b=AFi2d7dzlVwLDcxBG4UH9lWsoZnc99WTiclq/H700OYdyFUi24I5cawTat64ciO/qt
         kng3Y301N6lTEgquNUO5FZ0+jKclbL49uSN2+y6uPZiXgwZzdbkFKEXdUX8YSAvcszbZ
         LKHIPgMcYdDjYzNdG4d/+9vO5YijGrRw2j47+JuhRnl7nRQ1fUhgZ4f3RAaK/eYGyXTQ
         glHUKa+flycFyeaVg1s/M4TeG2p7H11CoY/PtPzAqLsByr48Wyrev4eJk5Lj+KDkzxU6
         ifHJxW91NbahzcK69Pi+glIDBaM/wIxXd3qfT2S3jmJguiyngoS/zldgVpNzVd2MNa4z
         KNnA==
X-Gm-Message-State: AOAM533kI/nnJS7khgeNti/FrFMLTacwOQaF9Pvcq/iW1OcY+jJ6Lurh
        ZY0gzpkK29VpK3k68eKwYMc=
X-Google-Smtp-Source: ABdhPJwfpXpe8calsKuaQ30f9foaawWHO3e8GwjwWs2Wem/63O+55jMMYsxr2+0Ly3E5r4jzAJEM6Q==
X-Received: by 2002:a17:90a:e015:: with SMTP id u21mr1011131pjy.33.1601329008375;
        Mon, 28 Sep 2020 14:36:48 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 04/14] iommu/ioasid: Support setting system-wide capacity
Date:   Mon, 28 Sep 2020 14:38:31 -0700
Message-Id: <1601329121-36979-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOASID is a system-wide resource that could vary on different systems.
The default capacity is 20 bits as defined in the PCI-E specifications.
This patch adds a function to allow adjusting system IOASID capacity.
For VT-d this is set during boot as part of the Intel IOMMU
initialization.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  5 +++++
 drivers/iommu/ioasid.c      | 20 ++++++++++++++++++++
 include/linux/ioasid.h      | 11 +++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 18ed3b3c70d7..e7bcb299e51e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -42,6 +42,7 @@
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
 #include <linux/swiotlb.h>
+#include <linux/ioasid.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -3331,6 +3332,10 @@ static int __init init_dmars(void)
 	if (ret)
 		goto free_iommu;
 
+	/* PASID is needed for scalable mode irrespective to SVM */
+	if (intel_iommu_sm)
+		ioasid_install_capacity(intel_pasid_max_id);
+
 	/*
 	 * for each drhd
 	 *   enable fault log
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 6cfbdfb492e0..4277cb17e15b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -10,6 +10,10 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
+/* Default to PCIe standard 20 bit PASID */
+#define PCI_PASID_MAX 0x100000
+static ioasid_t ioasid_capacity = PCI_PASID_MAX;
+static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 struct ioasid_data {
 	ioasid_t id;
 	struct ioasid_set *set;
@@ -17,6 +21,22 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
+void ioasid_install_capacity(ioasid_t total)
+{
+	if (ioasid_capacity && ioasid_capacity != PCI_PASID_MAX) {
+		pr_warn("IOASID capacity is already set.\n");
+		return;
+	}
+	ioasid_capacity = ioasid_capacity_avail = total;
+}
+EXPORT_SYMBOL_GPL(ioasid_install_capacity);
+
+ioasid_t ioasid_get_capacity(void)
+{
+	return ioasid_capacity;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_capacity);
+
 /*
  * struct ioasid_allocator_data - Internal data structure to hold information
  * about an allocator. There are two types of allocators:
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index c7f649fa970a..7fc320656be2 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -32,6 +32,8 @@ struct ioasid_allocator_ops {
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
+void ioasid_install_capacity(ioasid_t total);
+ioasid_t ioasid_get_capacity(void);
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
 void ioasid_free(ioasid_t ioasid);
@@ -42,6 +44,15 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
+static inline void ioasid_install_capacity(ioasid_t total)
+{
+}
+
+static inline ioasid_t ioasid_get_capacity(void)
+{
+	return 0;
+}
+
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
 {
-- 
2.7.4

