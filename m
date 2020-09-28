Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16E27B718
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgI1Vgr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgI1Vgq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD940C0613CE;
        Mon, 28 Sep 2020 14:36:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md22so2782920pjb.0;
        Mon, 28 Sep 2020 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYpPSnzf7wFktbr//qjM+H85a7ND2QWunvW4sMQhPic=;
        b=AfhNiBZ3y4VLME6QMDWrRmWV6D4N6WoKulskg8+Hrocu+cv0d0NLb4OXqVxwzIkr/7
         pd5i1gzeBDkeODVVTgQNpvPkQ8ikTJ79ZQOfxFmiMVQ6wvu8TQu4o75WJSfb4L49ulLH
         sGjvR6/aG1JYxM5TPP+CijNnOpHji/WaOmkHBymvbOS0URoaPbNJpyAJpAVKoposvmmY
         1L8TXy5odOjYXXtdMxrP6YFBg+mKYz9KS3B31N9+qMavi41EN8Hn8IdImjIomU+qrHnG
         D1edMXAVTreqh0qIZG1ciQuUavQdmh4ZyE0uI6pKRUQg/mSu9adzHIIvaAU0eB46reiX
         ohcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MYpPSnzf7wFktbr//qjM+H85a7ND2QWunvW4sMQhPic=;
        b=Qx7/4dLbXHRVBQdYWQ+VM7MBaCK2+iTU4eBX5B40ziF/dP56PGAAbx+8AmlFtZ1mfg
         FVUxuGV4VqZxVOWS8DTnvbkQ6GrnMlp8ap37BuMFutkynVVnyK0yo4ST+VzhAudfkUOi
         G0RagiaDf1rEHzD1qPaortur7XDAgYTS8wlJeCTUykqx9tTiL4AmgbW6tK73q4/9Ji/V
         dzX8B5FpHouh7oYkX5FDH6L8gpSThJDHpQf0WsEQwdc+TQBykR+hIMQKgVUzEULSJz1n
         NzmUYuXcvhk7/qRPyBSfAZGUaCjzRUbwCRyb7nOArRGSpP20epwSkAFkzdE0qQYbd47q
         5tTQ==
X-Gm-Message-State: AOAM531bj8iOLHrblIkKK/rlQARttIbHz0m4t2qHnR0cssbML0aD1Akz
        Hub8A8ty7mk0y8Z2rdV/RHU=
X-Google-Smtp-Source: ABdhPJzehtrtRBhg3lZdaKSsz3aa9JDa/K5e4NsmahiEFn3owyozG9YtLr3acyFytGVwmpNMAlpzww==
X-Received: by 2002:a17:90a:6a0e:: with SMTP id t14mr1014463pjj.97.1601329006297;
        Mon, 28 Sep 2020 14:36:46 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:45 -0700 (PDT)
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
Subject: [PATCH v3 02/14] iommu/ioasid: Rename ioasid_set_data()
Date:   Mon, 28 Sep 2020 14:38:29 -0700
Message-Id: <1601329121-36979-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Rename ioasid_set_data() to ioasid_attach_data() to avoid confusion with
struct ioasid_set. ioasid_set is a group of IOASIDs that share a common
token.

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 6 +++---
 drivers/iommu/ioasid.c    | 6 +++---
 include/linux/ioasid.h    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0cb9a15f1112..2c5645f0737a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -346,7 +346,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
-		ioasid_set_data(data->hpasid, svm);
+		ioasid_attach_data(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 		mmput(svm->mm);
 	}
@@ -398,7 +398,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_set_data(data->hpasid, NULL);
+		ioasid_attach_data(data->hpasid, NULL);
 		kfree(svm);
 	}
 
@@ -441,7 +441,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_set_data(pasid, NULL);
+				ioasid_attach_data(pasid, NULL);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada..5f63af07acd5 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -258,14 +258,14 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
 EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
 
 /**
- * ioasid_set_data - Set private data for an allocated ioasid
+ * ioasid_attach_data - Set private data for an allocated ioasid
  * @ioasid: the ID to set data
  * @data:   the private data
  *
  * For IOASID that is already allocated, private data can be set
  * via this API. Future lookup can be done via ioasid_find.
  */
-int ioasid_set_data(ioasid_t ioasid, void *data)
+int ioasid_attach_data(ioasid_t ioasid, void *data)
 {
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
@@ -287,7 +287,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ioasid_set_data);
+EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
  * ioasid_alloc - Allocate an IOASID
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddc..9c44947a68c8 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -39,7 +39,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
-int ioasid_set_data(ioasid_t ioasid, void *data);
+int ioasid_attach_data(ioasid_t ioasid, void *data);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -67,7 +67,7 @@ static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allo
 {
 }
 
-static inline int ioasid_set_data(ioasid_t ioasid, void *data)
+static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 {
 	return -ENOTSUPP;
 }
-- 
2.7.4

