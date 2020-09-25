Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5B278E8D
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgIYQbC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbgIYQbA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 12:31:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506D1C0613CE;
        Fri, 25 Sep 2020 09:31:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so3671987pfp.11;
        Fri, 25 Sep 2020 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LSyf3SkDlCwf2HoUFoGuJC/iHiB7H7zbzGxUquhsjX0=;
        b=HirDKlAAMkGWAf1STePQ3QJkiXE7V9lvnoCP3iKzdgGsUoBllA+XVwfogsD72X/f6h
         7tHN/hkzs2cLjFIzKmEPanSPvZ2t3YJH/3rvDov3wOBWR2k69SXrXvxRmNrVS1IYYbhp
         PhwDqdm8DvSQMik89etcIj/It/09Eeeb7so1j5kwhHKaVrC16JU1gHrkiFn714ORh4z6
         Jw8FV0PrmuWiwEfa1rbGXbtj2blhu9zM4dt8cmPoZrupMxIil0PR/6t6tu3imK6nQyok
         WffmfeK6nNklQFrw/D6mmY+tSAuE7V21z3rdmI2PwjbZPKAM0oC1D8FPgnlvSKwp/CIW
         NljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LSyf3SkDlCwf2HoUFoGuJC/iHiB7H7zbzGxUquhsjX0=;
        b=gZscHYbBNQrPTxBix6IzOKl6IukBd56FyuOGD/AFZeu6mJrNh62E9TaJvR+3aX0Rxg
         4/s+70riZ+L8Fm4iHgK4MIyxZOO2o4E1ypi/5HwK7BAVcRQkEid8qMrGrnVXVQpwZBFV
         CUnBMpHwwdgcH1esSZgf/sPB6b3u9iJO/LaaJ5cKvw/hPycLA0uDN4RDb3IKrKp1G6Yo
         PFBIuWhPsd9OSZFveKxeoJjNno65tcV7+8sIYLXNhZlio2vMA4Tmk6syStxEFEwmZRrB
         WAT+Mrg3CHYQIxlpofvRFlbtLbiOJC2W4MwR3vok7ZKi3W5qzF8Rl2uwkCdfwtIKXapW
         +kKw==
X-Gm-Message-State: AOAM532KHQl+vzEEwy2RPXINdKM7YLGqbnGS6O/eZdMq4h3jBjOq9Pqw
        18wHR5wg+8ewLHYemo1BHAo=
X-Google-Smtp-Source: ABdhPJxES9mSmYCxxF5wPNlQxp4xWTu4A0olsptxBPLuXZRW3kV2wcYDnUuS+TVtd9iO4SCXfUdkzQ==
X-Received: by 2002:a17:902:bd07:b029:d1:f42c:454f with SMTP id p7-20020a170902bd07b02900d1f42c454fmr229733pls.54.1601051459865;
        Fri, 25 Sep 2020 09:30:59 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id j19sm3197039pfe.108.2020.09.25.09.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:30:59 -0700 (PDT)
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
Subject: [PATCH v12 6/6] iommu/vt-d: Check UAPI data processed by IOMMU core
Date:   Fri, 25 Sep 2020 09:32:47 -0700
Message-Id: <1601051567-54787-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

