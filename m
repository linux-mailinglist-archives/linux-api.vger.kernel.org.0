Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AFA278E91
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIYQbM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgIYQaz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 12:30:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA57C0613CE;
        Fri, 25 Sep 2020 09:30:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so3060283pgl.2;
        Fri, 25 Sep 2020 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
        b=u1CC6UgbFSs/8n+6OuBKY80/00NmmpT23RHftCwURVNAW/XjtaqSnKBCKGuzKdsE1A
         CbFkI6imHijXT9TdUdVw6Qw+8OsqASw71Ek9d/o064dWvbguqNHox/hFFxeW1jHVY/Ha
         u93M5ZFeoirgDjD7ClMsOV9F1BNAVf+VptLa5n7dHwtQ1y7+fvgNxwAapv4h9IoXtX7T
         2Qf/QchPR2v3PglxIVrmx+TkMKLA0mQyCRfAahF8VLPeA28CnhOANo0H23YfER+KmmL1
         PjUWLFz1DXz/N+1JS7/IEtjhtOijkPNIg5wmpGC25ymJwouaa8uH9/MRv8BT2w1tKcqb
         pmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hFUA2EodpJe3a9+C7aWrHwYTMpFRcWcG5EO2y8L7QQ4=;
        b=cVnDX/pWYQzf78YiqZcjOk32OqfZnZxkc9onADm+5oleO/amvvBOiKuQ0BBMIPGUIZ
         cIwI8MPbY/Z0JqdhRjHCRqdKnbEvH+sSwBuL0HGATiJUDDD3CZGpxtvHw6R4Owx3oCMK
         lLpLqYrLPKXchlhuBnc9LQStEAgaPENcWknmHT/MIluHlUUbDZYdUNCizE3bb4aXy5cp
         X7gDkOAGjbI822L72jNn06hiQTK5SLJhD9z7UJY4elbK5T6GMzkeV2+bH01/Kne4qaip
         /kVwbsrmg5YT0pggZa8H3qeMccY8mfM2MNs87PtUN/jOfodwrZZabvhUBx2LsLXY9zob
         HJNA==
X-Gm-Message-State: AOAM533Jss2ygf6/5DH9Fo3oeDs0Ee7UOD4aCNCupjegyTaYONItKMmK
        1+z1EfgaVgXQ5kO95kr2HiU=
X-Google-Smtp-Source: ABdhPJyi++x1n9the3G91l4hEQEpKwsrMBbznrQDzsOtq+hr5iutBcuOLtLLyf3aIihb4UyuA0Ce/w==
X-Received: by 2002:a17:902:8682:b029:d1:f289:1b8a with SMTP id g2-20020a1709028682b02900d1f2891b8amr175665plo.69.1601051455086;
        Fri, 25 Sep 2020 09:30:55 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id j19sm3197039pfe.108.2020.09.25.09.30.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:30:54 -0700 (PDT)
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
Subject: [PATCH v12 2/6] iommu/uapi: Add argsz for user filled data
Date:   Fri, 25 Sep 2020 09:32:43 -0700
Message-Id: <1601051567-54787-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

