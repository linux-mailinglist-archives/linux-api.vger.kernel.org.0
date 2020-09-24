Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F82277928
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgIXTWs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgIXTWr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 15:22:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A4C0613CE;
        Thu, 24 Sep 2020 12:22:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fa1so305846pjb.0;
        Thu, 24 Sep 2020 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LSyf3SkDlCwf2HoUFoGuJC/iHiB7H7zbzGxUquhsjX0=;
        b=Y54jGFG4Dvfx79HKsQQAX/hTavu8nf5mTVKAs2Q9rI27U4li2hxb16xlVrYcxiwUre
         yqhiSQ75HFHd9M1l4umpPyFWdpS+CKBhCC9cDQzg1tiEF31h5wAe/ebGKa+NNcIeEAcG
         wDMkHxWJrqr1Ay++nsF2xRTsAYWtpoKO3u6Kuhk36DRmoGxsT1al430J+VfImf4nYwbY
         TVSoC/E+otAt7IteRNBTL0M2I2Ooc/gq7c5NpXWMNxQBO/F/v25jxybnWqjAHzx5Ov6X
         SYNMQiLTkw6kZZvlVHdYtR1OoCtFjIFkhW0MxBoJl6pi5cPcik8mQZW/pTCMtQBPw0Wm
         R8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LSyf3SkDlCwf2HoUFoGuJC/iHiB7H7zbzGxUquhsjX0=;
        b=P6K7wYJ34e5PmK6QvLsvczuDijx9hUIa0A6zexf9yYzRDLgEoLWBKnPXVOxAYhQfY/
         uXHSrnSpI28T/xtRz5vMzhW+vkSu+ds5I01lso8spI0YInq29szsheZ9YIJfW2emmwBC
         k83VkyM/lRICHvgPzFQ5iGN5Sey0zOJwCqrOtlk7eGwXlgY7gfk6I9pJU9fyeER4pbAp
         FO3O2Gz8Nbg1eRyVd2R6FhEA8l8mJ3WuRJVYBrKnA95Bg66yjmcfvEdq+Uy5ALpiCaXb
         2AP1RRdww/6QoeiOynX2EkC4zN69gjl8jr32ucTbROo61eqwhwYhLpGIy3GCDoPV55X8
         1yJQ==
X-Gm-Message-State: AOAM532pJ+EyigpUu4lSrzoRLaXHfGtxnHKnnS3N68CvXbQEnl4DpPVd
        BMvdECbtmGoIZcv4iXhs7WwUS5zegV4=
X-Google-Smtp-Source: ABdhPJzcpOiwS2fDjHUZJg7vVG5h4/KkDzF8MA2f4ZusOHCMZPBL5vzXHq+iQDqywOn+Gt3xDFY04w==
X-Received: by 2002:a17:90b:104f:: with SMTP id gq15mr370787pjb.215.1600975366882;
        Thu, 24 Sep 2020 12:22:46 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id o15sm140918pgi.74.2020.09.24.12.22.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:22:46 -0700 (PDT)
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
        Yi Sun <yi.y.sun@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v11 6/6] iommu/vt-d: Check UAPI data processed by IOMMU core
Date:   Thu, 24 Sep 2020 12:24:20 -0700
Message-Id: <1600975460-64521-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOMMU generic layer already does sanity checks on UAPI data for version
match and argsz range based on generic information.

This patch adjusts the following data checking responsibilities:
- removes the redundant version check from VT-d driver
- removes the check for vendor specific data size
- adds check for the use of reserved/undefined flags

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  3 +--
 drivers/iommu/intel/svm.c   | 11 +++++++++--
 include/uapi/linux/iommu.h  |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 461f3a6864d4..18ed3b3c70d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5408,8 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	int ret = 0;
 	u64 size = 0;
 
-	if (!inv_info || !dmar_domain ||
-	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+	if (!inv_info || !dmar_domain)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 99353d6468fa..0cb9a15f1112 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -284,8 +284,15 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
-	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+		return -EINVAL;
+
+	/* IOMMU core ensures argsz is more than the start of the union */
+	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
+		return -EINVAL;
+
+	/* Make sure no undefined flags are used in vendor data */
+	if (data->vendor.vtd.flags & ~(IOMMU_SVA_VTD_GPASID_LAST - 1))
 		return -EINVAL;
 
 	if (!dev_is_pci(dev))
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 66d4ca40b40f..e1d9e75f2c94 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -288,6 +288,7 @@ struct iommu_gpasid_bind_data_vtd {
 #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
 #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
 #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
+#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
 	__u64 flags;
 	__u32 pat;
 	__u32 emt;
-- 
2.7.4

