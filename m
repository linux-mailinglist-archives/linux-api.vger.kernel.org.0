Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E19277925
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 21:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgIXTWr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 15:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgIXTWn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 15:22:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE5C0613D3;
        Thu, 24 Sep 2020 12:22:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so282441pjh.5;
        Thu, 24 Sep 2020 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cd/kUvj/qKVGHAwJBYWnGQx2hf0aCQ0hRurRYYSX7es=;
        b=b2/ZodyybF0tlt2ecP+O6ZdLrWUimeXoncxegNY9lLQktYeCTzDDIsLJDeeBAsceKR
         8y8bHuINmBYxkh+5yjtGHxWeUFaWWhgLlnzfV8bs0oTKsdRJUCGi/VG7/+THkpqKtS7d
         +QN4WKhUK1fLysC3qrZBRJJPuWM848aL+NyE3Mzvw714fVmwHF38S3r6JROz0ayODrbF
         dYvzI1xciuweLzOtpnfV7QWn4QrKijBMFuSHrwdNiZZkCFyNY+eByZWdTOlo482wLb74
         Li20vVljcalZsTAhKPmwSZALsPIUBn0c6zNUU0/DuykFqYIarCy3tLR7EzUBwFmyxVX7
         wvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cd/kUvj/qKVGHAwJBYWnGQx2hf0aCQ0hRurRYYSX7es=;
        b=JgfnvxYqWARCSj0OLZsbgB8ceBym1ZYAIsnUPI3DAu2BjHye8kDNLwJIfahyIfj2bt
         KqCHNVyfHh8/oLOGJJDfZmZGBznDwZpGqwyj7Ro3uFTeqMhIStgQbn9V+zj0wPssu2xt
         2vLngsYSdM1lI7Fnv9uCXeZeI8WxZ4nDfkkctXeIXVoHJsJuK69Ij4oL+Eeh3r/7+CVs
         LGpMsTwPPOKi1jl4AxgJJ4eLPiN/wXo14vxyMTSqCkUaBR9nSvk7MxOW1dYj4y7VGmiP
         8WTdXEs6iFYkSNj0ET0haQ7jwuz7V+T+N4g9ZD6K3TYAk4bt9Tiwk/YQU91JM4mrPLBQ
         d8Hg==
X-Gm-Message-State: AOAM5322x5G8C9uVOOUU9M36i0ls11HlkRwbsBaBFghHBxRYYE+KRoiP
        UqTAXk30aJkEvvEsqm5eqPs=
X-Google-Smtp-Source: ABdhPJxZs0Dhi/7nKfg/AwCX+fMd7pdzWw3nLFX4U2GjDYNu6/T3UEz0a2SxCiAG9jgFAtZHwrKPHQ==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr444252pjb.210.1600975363215;
        Thu, 24 Sep 2020 12:22:43 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id o15sm140918pgi.74.2020.09.24.12.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:22:42 -0700 (PDT)
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
Subject: [PATCH v11 4/6] iommu/uapi: Rename uapi functions
Date:   Thu, 24 Sep 2020 12:24:18 -0700
Message-Id: <1600975460-64521-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

User APIs such as iommu_sva_unbind_gpasid() may also be used by the
kernel. Since we introduced user pointer to the UAPI functions,
in-kernel callers cannot share the same APIs. In-kernel callers are also
trusted, there is no need to validate the data.

We plan to have two flavors of the same API functions, one called
through ioctls, carrying a user pointer and one called directly with
valid IOMMU UAPI structs. To differentiate both, let's rename existing
functions with an iommu_uapi_ prefix.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 18 +++++++++---------
 include/linux/iommu.h | 31 ++++++++++++++++---------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..4ae02291ccc2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1961,35 +1961,35 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
-int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-			   struct iommu_cache_invalidate_info *inv_info)
+int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+				struct iommu_cache_invalidate_info *inv_info)
 {
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
 	return domain->ops->cache_invalidate(domain, dev, inv_info);
 }
-EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
+EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-			   struct device *dev, struct iommu_gpasid_bind_data *data)
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+			       struct device *dev, struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_bind_gpasid(domain, dev, data);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 ioasid_t pasid)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
 	return domain->ops->sva_unbind_gpasid(dev, pasid);
 }
-EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..710d5d2691eb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -424,13 +424,13 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_cache_invalidate(struct iommu_domain *domain,
-				  struct device *dev,
-				  struct iommu_cache_invalidate_info *inv_info);
-extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-		struct device *dev, struct iommu_gpasid_bind_data *data);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+				       struct device *dev,
+				       struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+				      struct device *dev, struct iommu_gpasid_bind_data *data);
+extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1032,21 +1032,22 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int
-iommu_cache_invalidate(struct iommu_domain *domain,
-		       struct device *dev,
-		       struct iommu_cache_invalidate_info *inv_info)
+static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+					      struct device *dev,
+					      struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
-static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-				struct device *dev, struct iommu_gpasid_bind_data *data)
+
+static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
+					     struct device *dev,
+					     struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
 
-static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+					       struct device *dev, int pasid)
 {
 	return -ENODEV;
 }
-- 
2.7.4

