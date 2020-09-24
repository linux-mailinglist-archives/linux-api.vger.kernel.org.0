Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF53277926
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgIXTWr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgIXTWp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 15:22:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726CC0613D4;
        Thu, 24 Sep 2020 12:22:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so282497pjh.5;
        Thu, 24 Sep 2020 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wN8C/4LaMgC4xXzyeup2eKtGecJkPZF6u6r0N4hr/Xk=;
        b=lBur0+adKv6poMP3YiCX7r42CPpisO2ycgLHpTJykqNiFyKYrqprE9ucPRessklUct
         A9yMdkYMPpSHphMqINYvT4h4jI7HHNehR7s045JgulkMCBuFKJ7fPM8ACZyYEVZX9J2C
         bKqdL+3ZVOCXETswirKaDBBbFvIlmk/iCxGAX351LtBWDkDP+aj09eeaYLfMoevzFGbz
         QVZiuu+37ruFnWsdXr0M7NRxJtxIAwM/HJ9Ljl6wRSrXr+CUq6AtY0DDkLL1ybbd7wpm
         XgPkOjkVtIWhUSraO6jkZcxduyx5ZB35bt16H3z/R0LDBKm7WfWLjtOOpvOUk3pgPspX
         64XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wN8C/4LaMgC4xXzyeup2eKtGecJkPZF6u6r0N4hr/Xk=;
        b=BqBNNwQL03YsqbBPVbwX7zW0izMBamIAy92p5xtbes2f3D+9FmK8M0QpQotK8TkARi
         ibAxi+C21g5CesIUcMQiZeB6Ln1GSVgs8G46Lo/mmMWwGl1wobH2QQsNzKhgrH/w6uWf
         vTDKD0ASkxyJSz/7bEJUmixq+hvzcRwX/tsnddRtHDpo+Ojwi3rRF3QZenVxHGiqEshR
         iMJtup6bdZzpivEs4V5yttlkTdumSvJ6sm5Y5ocSer2EFHMSDCgJQvb4AfmFv8MczkJv
         NQq+GM602GPWmV+3VnMhTGzYBBf8hVZl23cYhpIOzk3kyYl5MyjCQEVwkdu0kI8ltDzu
         Qf3Q==
X-Gm-Message-State: AOAM531NuTYAGE6SOhbNJFCEFTNbjGgphhjncuEg6JhVXzWZ3es5EB6f
        cxS0yP31pWDTfcPLfboPWck=
X-Google-Smtp-Source: ABdhPJw7zs9BtaILiqRblMSvkD9Nd3iwhx6JylYBOpt/+zcmnLAt0piu2fIlrmd2eTsubHrCalpXYw==
X-Received: by 2002:a17:90a:f30c:: with SMTP id ca12mr425450pjb.102.1600975364798;
        Thu, 24 Sep 2020 12:22:44 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id o15sm140918pgi.74.2020.09.24.12.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:22:44 -0700 (PDT)
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
Subject: [PATCH v11 5/6] iommu/uapi: Handle data and argsz filled by users
Date:   Thu, 24 Sep 2020 12:24:19 -0700
Message-Id: <1600975460-64521-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOMMU user APIs are responsible for processing user data. This patch
changes the interface such that user pointers can be passed into IOMMU
code directly. Separate kernel APIs without user pointers are introduced
for in-kernel users of the UAPI functionality.

IOMMU UAPI data has a user filled argsz field which indicates the data
length of the structure. User data is not trusted, argsz must be
validated based on the current kernel data size, mandatory data size,
and feature flags.

User data may also be extended, resulting in possible argsz increase.
Backward compatibility is ensured based on size and flags (or
the functional equivalent fields) checking.

This patch adds sanity checks in the IOMMU layer. In addition to argsz,
reserved/unused fields in padding, flags, and version are also checked.
Details are documented in Documentation/userspace-api/iommu.rst

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c      | 199 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h      |  28 +++++--
 include/uapi/linux/iommu.h |   1 +
 3 files changed, 212 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4ae02291ccc2..5c1b7ae48aae 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1961,34 +1961,219 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+/*
+ * Check flags and other user provided data for valid combinations. We also
+ * make sure no reserved fields or unused flags are set. This is to ensure
+ * not breaking userspace in the future when these fields or flags are used.
+ */
+static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
+{
+	u32 mask;
+	int i;
+
+	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
+	if (info->cache & ~mask)
+		return -EINVAL;
+
+	if (info->granularity >= IOMMU_INV_GRANU_NR)
+		return -EINVAL;
+
+	switch (info->granularity) {
+	case IOMMU_INV_GRANU_ADDR:
+		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
+			return -EINVAL;
+
+		mask = IOMMU_INV_ADDR_FLAGS_PASID |
+			IOMMU_INV_ADDR_FLAGS_ARCHID |
+			IOMMU_INV_ADDR_FLAGS_LEAF;
+
+		if (info->granu.addr_info.flags & ~mask)
+			return -EINVAL;
+		break;
+	case IOMMU_INV_GRANU_PASID:
+		mask = IOMMU_INV_PASID_FLAGS_PASID |
+			IOMMU_INV_PASID_FLAGS_ARCHID;
+		if (info->granu.pasid_info.flags & ~mask)
+			return -EINVAL;
+
+		break;
+	case IOMMU_INV_GRANU_DOMAIN:
+		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check reserved padding fields */
+	for (i = 0; i < sizeof(info->padding); i++) {
+		if (info->padding[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-				struct iommu_cache_invalidate_info *inv_info)
+				void __user *uinfo)
 {
+	struct iommu_cache_invalidate_info inv_info = { 0 };
+	u32 minsz;
+	int ret = 0;
+
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
-	return domain->ops->cache_invalidate(domain, dev, inv_info);
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_cache_invalidate_info, granu);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(&inv_info, uinfo, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (inv_info.argsz < minsz)
+		return -EINVAL;
+
+	/* PASID and address granu require additional info beyond minsz */
+	if (inv_info.argsz == minsz &&
+	    ((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
+		    (inv_info.granularity == IOMMU_INV_GRANU_ADDR)))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
+	    inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.pasid_info))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
+	    inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.addr_info))
+		return -EINVAL;
+
+	/*
+	 * User might be using a newer UAPI header which has a larger data
+	 * size, we shall support the existing flags within the current
+	 * size. Copy the remaining user data _after_ minsz but not more
+	 * than the current kernel supported size.
+	 */
+	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
+			   min_t(u32, inv_info.argsz, sizeof(inv_info)) - minsz))
+		return -EFAULT;
+
+	/* Now the argsz is validated, check the content */
+	ret = iommu_check_cache_invl_data(&inv_info);
+	if (ret)
+		return ret;
+
+	return domain->ops->cache_invalidate(domain, dev, &inv_info);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-			       struct device *dev, struct iommu_gpasid_bind_data *data)
+static int iommu_check_bind_data(struct iommu_gpasid_bind_data *data)
+{
+	u32 mask;
+	int i;
+
+	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
+		return -EINVAL;
+
+	/* Check the range of supported formats */
+	if (data->format >= IOMMU_PASID_FORMAT_LAST)
+		return -EINVAL;
+
+	/* Check all flags */
+	mask = IOMMU_SVA_GPASID_VAL;
+	if (data->flags & ~mask)
+		return -EINVAL;
+
+	/* Check reserved padding fields */
+	for (i = 0; i < sizeof(data->padding); i++) {
+		if (data->padding[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int iommu_sva_prepare_bind_data(void __user *udata,
+				       struct iommu_gpasid_bind_data *data)
 {
+	u32 minsz;
+
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(data, udata, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (data->argsz < minsz)
+		return -EINVAL;
+	/*
+	 * User might be using a newer UAPI header, we shall let IOMMU vendor
+	 * driver decide on what size it needs. Since the guest PASID bind data
+	 * can be vendor specific, larger argsz could be the result of extension
+	 * for one vendor but it should not affect another vendor.
+	 * Copy the remaining user data _after_ minsz
+	 */
+	if (copy_from_user((void *)data + minsz, udata + minsz,
+			   min_t(u32, data->argsz, sizeof(*data)) - minsz))
+		return -EFAULT;
+
+	return iommu_check_bind_data(data);
+}
+
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+			       void __user *udata)
+{
+	struct iommu_gpasid_bind_data data = { 0 };
+	int ret;
+
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_bind_gpasid(domain, dev, data);
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return domain->ops->sva_bind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-				 ioasid_t pasid)
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			     ioasid_t pasid)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_unbind_gpasid(dev, pasid);
 }
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 void __user *udata)
+{
+	struct iommu_gpasid_bind_data data = { 0 };
+	int ret;
+
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return iommu_sva_unbind_gpasid(domain, dev, data.hpasid);
+}
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
 static void __iommu_detach_device(struct iommu_domain *domain,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 710d5d2691eb..3ca3a40fc80f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -426,11 +426,14 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
 				       struct device *dev,
-				       struct iommu_cache_invalidate_info *inv_info);
+				       void __user *uinfo);
+
 extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-				      struct device *dev, struct iommu_gpasid_bind_data *data);
+				      struct device *dev, void __user *udata);
 extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-					struct device *dev, ioasid_t pasid);
+					struct device *dev, void __user *udata);
+extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1032,22 +1035,29 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
-					      struct device *dev,
-					      struct iommu_cache_invalidate_info *inv_info)
+static inline int
+iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+			    struct device *dev,
+			    struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-					     struct device *dev,
-					     struct iommu_gpasid_bind_data *data)
+					     struct device *dev, void __user *udata)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-					       struct device *dev, int pasid)
+					       struct device *dev, void __user *udata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+					  struct device *dev,
+					  ioasid_t pasid)
 {
 	return -ENODEV;
 }
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 5946779ac1f9..66d4ca40b40f 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -322,6 +322,7 @@ struct iommu_gpasid_bind_data {
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
+#define IOMMU_PASID_FORMAT_LAST		2
 	__u32 format;
 	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
-- 
2.7.4

