Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAE278E89
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYQa5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIYQa4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 12:30:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9BFC0613CE;
        Fri, 25 Sep 2020 09:30:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so2100383pjg.1;
        Fri, 25 Sep 2020 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vUY73uGNXRdGBf6OJopom4ParHouExoa+/+ufyGwMqo=;
        b=VytEt46aajPufsI4GahDOSYsgCoAmLwFG477/s2czYsnwtQiUaVS2r1cqdQ3B2yprz
         XATVAzTkwJ5JfsKJhPiUnHacvkkqpq0HRCWttGAi2EoXUNRiwTAgo/GwaR+yg5AYPKoc
         iHEIBnfjtHMep9K8CqYGiKHqdAYA7u1R0Ri6IjyTvHU3gqGM9kXCFt3KGeJ0K3uzNlto
         pG2LLDxXmRzbfF1tXozGk39nPUVbU2H1gr8Mswq11NHU6KdFKysPvsg4H/mJVD4iMYPi
         NI3v0cN9PbHIijozrpH5ISFz8IxTQB36okSIsjoMu8lbEW2hIdK53LU4nEhwOWUWxrU5
         9G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vUY73uGNXRdGBf6OJopom4ParHouExoa+/+ufyGwMqo=;
        b=tst7ZMUoFNBs/CxE2fNRe+u+ES9L92aLC2oIlWtLB2RQ1dUmfa1hRjppB9IchTJEbC
         wlCA6yrHFF0/7PwtDhNRlF4i56Wl78tu+WPJL7pDdKMgcGEzMsgiEsZ8iSoTp951fZjp
         4dysaYWgSdcRSYnO7UAR+Y3wZN0gcOqDF+/VIXDLuRF5Vh8aiS1NgM/ZkF1WFYmKWZf0
         QTBa7BRDKhefxUPb4GTD3lK+nfzN5B8ZJm6WTatYlzokJ9M4aXLfzgo9UjnzoQU1nTJu
         Qd0IQcle0zIbUIAhK9MKHaTDIX0ghGNEWCO7Jtw+H99YiJBIv11uuFHG0+g90HSbDych
         ULVg==
X-Gm-Message-State: AOAM532EURnLuLbtguwYa9wWcGnadnS+evTSTkgjWg9lNSeEoKLk6moS
        lTsiAE3PAAx2wayerlVJs/k=
X-Google-Smtp-Source: ABdhPJw9rdZ8nPicF3cXOAtrpxmc2N1oWOsbXZNewmqu24lQwzW6J9SWZAXQnMTmId37PJ3LOvfaKQ==
X-Received: by 2002:a17:90a:4b42:: with SMTP id o2mr338515pjl.205.1601051456301;
        Fri, 25 Sep 2020 09:30:56 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id j19sm3197039pfe.108.2020.09.25.09.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:30:55 -0700 (PDT)
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
Subject: [PATCH v12 3/6] iommu/uapi: Use named union for user data
Date:   Fri, 25 Sep 2020 09:32:44 -0700
Message-Id: <1601051567-54787-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOMMU UAPI data size is filled by the user space which must be validated
by the kernel. To ensure backward compatibility, user data can only be
extended by either re-purpose padding bytes or extend the variable sized
union at the end. No size change is allowed before the union. Therefore,
the minimum size is the offset of the union.

To use offsetof() on the union, we must make it named.

Link: https://lore.kernel.org/linux-iommu/20200611145518.0c2817d6@x1.home/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel/iommu.c | 22 +++++++++++-----------
 drivers/iommu/intel/svm.c   |  2 +-
 include/uapi/linux/iommu.h  |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87b17bac04c2..461f3a6864d4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5434,8 +5434,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 	/* Size is only valid in address selective invalidation */
 	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
-		size = to_vtd_size(inv_info->addr_info.granule_size,
-				   inv_info->addr_info.nb_granules);
+		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
+				   inv_info->granu.addr_info.nb_granules);
 
 	for_each_set_bit(cache_type,
 			 (unsigned long *)&inv_info->cache,
@@ -5456,20 +5456,20 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		 * granularity.
 		 */
 		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
-		    (inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
-			pasid = inv_info->pasid_info.pasid;
+		    (inv_info->granu.pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
+			pasid = inv_info->granu.pasid_info.pasid;
 		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
-			 (inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
-			pasid = inv_info->addr_info.pasid;
+			 (inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
+			pasid = inv_info->granu.addr_info.pasid;
 
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
 			/* HW will ignore LSB bits based on address mask */
 			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
 			    size &&
-			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
+			    (inv_info->granu.addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
 				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
-						   inv_info->addr_info.addr, size);
+						   inv_info->granu.addr_info.addr, size);
 			}
 
 			/*
@@ -5477,9 +5477,9 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 * We use npages = -1 to indicate that.
 			 */
 			qi_flush_piotlb(iommu, did, pasid,
-					mm_to_dma_pfn(inv_info->addr_info.addr),
+					mm_to_dma_pfn(inv_info->granu.addr_info.addr),
 					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
-					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
+					inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
 
 			if (!info->ats_enabled)
 				break;
@@ -5502,7 +5502,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 				size = 64 - VTD_PAGE_SHIFT;
 				addr = 0;
 			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR) {
-				addr = inv_info->addr_info.addr;
+				addr = inv_info->granu.addr_info.addr;
 			}
 
 			if (info->ats_enabled)
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 95c3164a2302..99353d6468fa 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -370,7 +370,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       (pgd_t *)(uintptr_t)data->gpgd,
-				       data->hpasid, &data->vtd, dmar_domain,
+				       data->hpasid, &data->vendor.vtd, dmar_domain,
 				       data->addr_width);
 	spin_unlock(&iommu->lock);
 	if (ret) {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index b42acc8fe007..5946779ac1f9 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -267,7 +267,7 @@ struct iommu_cache_invalidate_info {
 	union {
 		struct iommu_inv_pasid_info pasid_info;
 		struct iommu_inv_addr_info addr_info;
-	};
+	} granu;
 };
 
 /**
@@ -333,7 +333,7 @@ struct iommu_gpasid_bind_data {
 	/* Vendor specific data */
 	union {
 		struct iommu_gpasid_bind_data_vtd vtd;
-	};
+	} vendor;
 };
 
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

