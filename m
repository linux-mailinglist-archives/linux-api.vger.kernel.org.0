Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684512749DC
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVUPj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgIVUPi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 16:15:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBDC0613D0;
        Tue, 22 Sep 2020 13:15:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so13482459pfn.8;
        Tue, 22 Sep 2020 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
        b=cb6TSxO09xgASZW5w/ndzqlwT/f33uAipEpyMeGncV+CUE+1CA0ES0EQtCyRalYIGS
         z1+pmUyhFQPpuAdRAeXqFykTMJ29tnmkCvnSSPqBSHEPpsYqnpfhk5Z6CzonOkjX0G74
         e/l5XvRGEkw1VqzWl1M2yioIA9D/r6+/Pd1IRvEWrAOfYkTzqWBE/4Xca2HrkR7pWKIn
         cWZpctP0xZdBGL1gBJnucU6apck4SCi9bjrDJKklrRhb2x7krAV+XhYheMDYbVQEsw9V
         47RD6d8ABg3hfBcU+Rd4Ux0nfO6vUtVAfdsTWDTZ5Lb1hgens19ZRZqKNYYP7ua42jD0
         8XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
        b=ovyvmaghL1pKRbs75QanhzlQlgtc7nMaqMGjvKY924rhh4un6YADsRnm263Ke0BWKr
         4p3cYdNW1KA6kmPP5V/HAKbPJDkJCKSwt/vhlGDwyEKHQ1zrKrnu2E3Zzym1W10+e2PR
         8FqNsP8vl/6GINBj0Z015YvTUgg20psp8nIUA8zqrL1iYZP0aMC2O0sz26OW6NbVK/O+
         oy2CvYiZ6J8Mdq1XB3ITgwOkTp++JcXbuJtqGlSv/23wV9wG11vGFs6R9eL+Wmc4mGWj
         p8PGJfS/eKhDYRSRqqQXAs/uFZUgsqu7zf8u9AJ59WXaRJay534uvKTy0bM1DKRRAw3C
         KpuQ==
X-Gm-Message-State: AOAM532dhWlmJs20L0If6xfwMgn4sfNXcUVs9/VK81mFCRhOLOJGI0nn
        VouZJE833bC/1i/dAgBozGE=
X-Google-Smtp-Source: ABdhPJwbJEwVptTJRflWCsGdDPOF6cfoG20m3qjacf25ZN60IqTFmZ1QZxD8y5p50uSPKweyKLw1uQ==
X-Received: by 2002:a17:902:7445:b029:d1:dea3:a3ca with SMTP id e5-20020a1709027445b02900d1dea3a3camr6258358plt.19.1600805737742;
        Tue, 22 Sep 2020 13:15:37 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:15:37 -0700 (PDT)
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
Subject: [PATCH v10 2/7] iommu/uapi: Add argsz for user filled data
Date:   Tue, 22 Sep 2020 13:16:57 -0700
Message-Id: <1600805822-1177-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As IOMMU UAPI gets extended, user data size may increase. To support
backward compatibiliy, this patch introduces a size field to each UAPI
data structures. It is *always* the responsibility for the user to fill in
the correct size. Padding fields are adjusted to ensure 8 byte alignment.

Specific scenarios for user data handling are documented in:
Documentation/userspace-api/iommu.rst

As there is no current users of the API, struct version is not
incremented.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index c2b2caf9ed41..b42acc8fe007 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -139,6 +139,7 @@ enum iommu_page_response_code {
 
 /**
  * struct iommu_page_response - Generic page response information
+ * @argsz: User filled size of this data
  * @version: API version of this structure
  * @flags: encodes whether the corresponding fields are valid
  *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
@@ -147,6 +148,7 @@ enum iommu_page_response_code {
  * @code: response code from &enum iommu_page_response_code
  */
 struct iommu_page_response {
+	__u32	argsz;
 #define IOMMU_PAGE_RESP_VERSION_1	1
 	__u32	version;
 #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
@@ -222,6 +224,7 @@ struct iommu_inv_pasid_info {
 /**
  * struct iommu_cache_invalidate_info - First level/stage invalidation
  *     information
+ * @argsz: User filled size of this data
  * @version: API version of this structure
  * @cache: bitfield that allows to select which caches to invalidate
  * @granularity: defines the lowest granularity used for the invalidation:
@@ -250,6 +253,7 @@ struct iommu_inv_pasid_info {
  * must support the used granularity.
  */
 struct iommu_cache_invalidate_info {
+	__u32	argsz;
 #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
 	__u32	version;
 /* IOMMU paging structure cache */
@@ -259,7 +263,7 @@ struct iommu_cache_invalidate_info {
 #define IOMMU_CACHE_INV_TYPE_NR		(3)
 	__u8	cache;
 	__u8	granularity;
-	__u8	padding[2];
+	__u8	padding[6];
 	union {
 		struct iommu_inv_pasid_info pasid_info;
 		struct iommu_inv_addr_info addr_info;
@@ -296,6 +300,7 @@ struct iommu_gpasid_bind_data_vtd {
 
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
+ * @argsz:	User filled size of this data
  * @version:	Version of this data structure
  * @format:	PASID table entry format
  * @flags:	Additional information on guest bind request
@@ -313,17 +318,18 @@ struct iommu_gpasid_bind_data_vtd {
  * PASID to host PASID based on this bind data.
  */
 struct iommu_gpasid_bind_data {
+	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
+	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
 	__u64 flags;
 	__u64 gpgd;
 	__u64 hpasid;
 	__u64 gpasid;
-	__u32 addr_width;
-	__u8  padding[12];
+	__u8  padding[8];
 	/* Vendor specific data */
 	union {
 		struct iommu_gpasid_bind_data_vtd vtd;
-- 
2.7.4

