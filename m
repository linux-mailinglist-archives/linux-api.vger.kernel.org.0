Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092FB2749F0
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIVUQB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgIVUPj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 16:15:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34356C061755;
        Tue, 22 Sep 2020 13:15:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k14so12873506pgi.9;
        Tue, 22 Sep 2020 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
        b=jppJmmBa70FWfRV8f9gYuwFAJDXAkKEaCluGfIfrHOxo7lgzWD0z7t9lzqv4ENmM+G
         YDTGJDtr9YF+1NZoF0oPw7PhPZYi7si+pxCD7R39twN+tq6aHEY+VsCugnmFUYNy0Rw9
         FEqwzIj/DUOnRqHTSdGpiXCeY9R+ZLZdwBm3ShGjlheG6DDrDB4SH4Uk8uXScHLiB+Oy
         H54bW1+yJedEsV/rBWjxUqGMKGGHBQSJaGQUPJMKR4D7WgovI9tgK6L5T7bEg/+OB17F
         tTfVSKcdT14QZKm+yXi9xTqsHChLn8VLJVV4Vmw7t/CrXmmYxN5+5u1tFZNdVbk55XJG
         FZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
        b=qd2T1j694Jw/R+pKmuQgowWmD9T4CX3d7gqvG6ps3rP6LCVkhzgPCHhal2pyu0HOLH
         39O8nB2msJR6fYGs0HKM4HGo29aHTPw/dnc7G9QIW2trMWieU71qeYIvLFg7qTdB8m87
         X+FcvNSapPtGx6QCM4gwzLGIi/w+DUaekLawP8mVanT5x9BbkFUAvGQ08jGV7TdLUN/V
         wI0+DpcLRWQqNYiAQUqseghpbA7JX0aVyzstZ27/PdVNWmiKe9j3m8O/9EUD5kqZYn+t
         GGQmut+Rs4a2Vvay/I5fqihLuzs2qX+9qd7caBdm+Jv8YtYWp1MPnruXO8Y8z4xdUQle
         qQ/Q==
X-Gm-Message-State: AOAM530ZYiGW0a6EJRCmtiLq8LUtlkwSsxcsUH8oNFTXtvTp9wvDtqIa
        vO8bEokjmsagPJOOp0cAxo8=
X-Google-Smtp-Source: ABdhPJzMoBu9OeQ6SW9fMRtvPed1Kz2CO6V9DKGBaflMqncnfkbwWlIOsGiPWjCxZ/YAwsNir4KeIQ==
X-Received: by 2002:a17:902:9695:b029:d1:e598:4007 with SMTP id n21-20020a1709029695b02900d1e5984007mr6309913plp.65.1600805738786;
        Tue, 22 Sep 2020 13:15:38 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e10sm15793028pgb.45.2020.09.22.13.15.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:15:38 -0700 (PDT)
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
Subject: [PATCH v10 3/7] iommu/uapi: Introduce enum type for PASID data format
Date:   Tue, 22 Sep 2020 13:16:58 -0700
Message-Id: <1600805822-1177-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600805822-1177-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There can be multiple vendor-specific PASID data formats used in UAPI
structures. This patch adds enum type with a last entry which makes
range checking much easier.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index b42acc8fe007..7cc6ee6c41f7 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
 					 IOMMU_SVA_VTD_GPASID_PCD |  \
 					 IOMMU_SVA_VTD_GPASID_PWT)
 
+enum iommu_pasid_data_format {
+	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
+	IOMMU_PASID_FORMAT_LAST,
+};
+
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
  * @argsz:	User filled size of this data
  * @version:	Version of this data structure
- * @format:	PASID table entry format
+ * @format:	PASID table entry format of enum iommu_pasid_data_format type
  * @flags:	Additional information on guest bind request
  * @gpgd:	Guest page directory base of the guest mm to bind
  * @hpasid:	Process address space ID used for the guest mm in host IOMMU
@@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
 	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
-#define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
 	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
-- 
2.7.4

