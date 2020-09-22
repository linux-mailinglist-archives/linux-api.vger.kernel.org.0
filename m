Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10E32749ED
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVUPp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgIVUPn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 16:15:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B242C0613D2;
        Tue, 22 Sep 2020 13:15:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so12873272pgl.10;
        Tue, 22 Sep 2020 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=42ZLvMqGkMbjL9RB04eoud8+y4TLkWBqmGYPRgmoi0k=;
        b=FS6u343LsEWEOkrgfMVcCfSbXxMfZH/x4Ng1F7cEQAW5KsmlRaixazwzmfS8faxfta
         unxJAIafhzjG0Hw7yhZ41elKp+tK/WOu/UR9Hp9vjuayFsvP/of7tXMoqujdDo129Tr4
         H6pJM43VE1H6V/+0cdci8xYJ5LJONABhsfK0IZ5vLwC72N3bA2KiIrAupXIZq2ReTuno
         lgPqEW2zJZLPPp3mr8tIDJhv64REZEizd4u4EGVnZQy8ToT7rli7+XfNLH2y+UQNk8ll
         tzILqJx+8lHqu57QRUWFJ4GAyiRWKvrsiBjrC75SfQttpOFMJtSOqysO9GtotJOmG9Gq
         Or+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=42ZLvMqGkMbjL9RB04eoud8+y4TLkWBqmGYPRgmoi0k=;
        b=XCcyJgFQLs+FRy+6SdzJcVr9M2j7NIeagxFk1Cw+VJfDrCQxS0OP1bYvDD7ip0cBRk
         SYM30JTdEBjwjn2yaaSgyGuyh4hpCgYtQDKju+pHN9GBgxkEtBd2E9rQAGt11nlArXWB
         NJAUVgyTqmrsFj1jBkix/vUDvWPsgvDjnIHJvbZP4USAM1y86zeB2M7tq6PRJaYpbY4B
         +XkQM+GbuKs112U1hEAttRntHirS1Cs20t1pxVGReU1MZ1lg0E79X/MGhb2t/Z0TcSIj
         USPYG76lKqWw4YWgWzGc4S5pg+M2V8B+pu8ow09ckMkRFgYsoMPAhUuOxYzZ/mrnF6F6
         kZMQ==
X-Gm-Message-State: AOAM530/RU+9Cw+Y1214LzP7/ym/KTdRKaopxoGEGv0US1BwLVg107uS
        pbp/dAc7J0JDWNkgNP0Ifbo=
X-Google-Smtp-Source: ABdhPJwNyOVM/0mf+mRUSD//8h8yGlquQcQtyLkw+vjpJI6zq2KMrDQdWDwKTKE4NyiQxipGFq2YHg==
X-Received: by 2002:a17:902:8682:b029:d1:e5e7:be5b with SMTP id g2-20020a1709028682b02900d1e5e7be5bmr6156438plo.53.1600805743190;
        Tue, 22 Sep 2020 13:15:43 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:15:42 -0700 (PDT)
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
Subject: [PATCH v10 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Date:   Tue, 22 Sep 2020 13:17:02 -0700
Message-Id: <1600805822-1177-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
index c64bca5af419..1ebc23df4fbc 100644
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

