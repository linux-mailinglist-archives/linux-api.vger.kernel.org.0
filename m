Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8DC27B72E
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgI1VhF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgI1Vgv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D22C061755;
        Mon, 28 Sep 2020 14:36:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so2083062pgm.0;
        Mon, 28 Sep 2020 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eRDofHXL1eTRP4hrUIyEdMxXn0TAZ1YuH1cXuixeJ7w=;
        b=lmlxkOpGkBup8lsjiFbiOWzZwldYTUVKpBYkyDc+CHaYNtMDlxTDrdC9gc7uSjdDOA
         h7Q3J2TZLPbaaUPNPuRFVkTBQcQlnVk/oZTVFbpRA/mGHN7H5ezYa2wrEaXsrDE+5iOI
         tAqtSlLtKU7Z1Pz72iXn2aC4vXf5gEhz4v9riB3GImqx8ku7FPuOAZj+wu4FDKeAmifS
         8Kdt7yaBzeaGnUd6/PGe4/N+q75zYd+qFf9LpWbWlkQ1sxgMxZKGJV6Sxvh9qp/B6Mif
         1BYv4E47dGjG0Gqsp0TS+46wLVxtEc5vRPpkTu0PglFqHa9o1ILu2DQDzPaqjLPqzIjW
         v18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eRDofHXL1eTRP4hrUIyEdMxXn0TAZ1YuH1cXuixeJ7w=;
        b=mBY1nOgDsMA7g5dZjfHa5ZMMkDpfTdmOAQD0u8pbEYOGVtajvCTTUiu3Z9UoXEw6wc
         lGJOgG/MsJClvPnsUFUYqjszAG1G4FX9x5X+LKXJMyU8Q1vQoStqjvc0KgF4eXhPO1wg
         ROGnaxLjhAhq3hYPcVSYy9N23pCFAsHaWHaCXMDnZ01pS40CSfK+7XhMcYF7lnk2ag3v
         8qSARYYz3GdYla4YHqm6SXzT2lTn4wxlJFt/btQ81v/kYF8VfhfhGXMao0Ip9qYZWXP2
         Vx2t/E7KuJS7ooieIIilYBCDZ0jJH58DbS6rc6vjc2FDQvxMblmI5LVNIzYLY0kCstRm
         YNBQ==
X-Gm-Message-State: AOAM532jia6Jb1ex4sgb9eQQXduypljiRBtJU+yrj4Khx24tuMv5Mtp9
        O4IPSf9wTe6nLUa4LTTro5NGqKl1Mig=
X-Google-Smtp-Source: ABdhPJxuVxOD8ExwPSz81xqGLqSYgtKpvksmhgnegohax0lp4/KyKlqHfF6YmC+VUnLlVpicENFnTg==
X-Received: by 2002:aa7:8216:0:b029:142:2501:3968 with SMTP id k22-20020aa782160000b029014225013968mr1217231pfi.45.1601329009559;
        Mon, 28 Sep 2020 14:36:49 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:49 -0700 (PDT)
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
Subject: [PATCH v3 05/14] iommu/ioasid: Redefine IOASID set and allocation APIs
Date:   Mon, 28 Sep 2020 14:38:32 -0700
Message-Id: <1601329121-36979-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

ioasid_set was introduced as an arbitrary token that is shared by a
group of IOASIDs. For example, two IOASIDs allocated via the same
ioasid_set pointer belong to the same set.

For guest SVA usages, system-wide IOASID resources need to be
partitioned such that each VM can have its own quota and being managed
separately. ioasid_set is the perfect candidate for meeting such
requirements. This patch redefines and extends ioasid_set with the
following new fields:
- Quota
- Reference count
- Storage of its namespace
- The token is now stored in the ioasid_set with types

Basic ioasid_set level APIs are introduced that wire up these new data.
Existing users of IOASID APIs are converted where a host IOASID set is
allocated for bare-metal usage.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  26 +++--
 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/svm.c   |  25 ++--
 drivers/iommu/ioasid.c      | 277 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/ioasid.h      |  53 +++++++--
 5 files changed, 333 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e7bcb299e51e..872391890323 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -104,6 +104,9 @@
  */
 #define INTEL_IOMMU_PGSIZES	(~0xFFFUL)
 
+/* PASIDs used by host SVM */
+struct ioasid_set *host_pasid_set;
+
 static inline int agaw_to_level(int agaw)
 {
 	return agaw + 2;
@@ -3147,8 +3150,8 @@ static void intel_vcmd_ioasid_free(ioasid_t ioasid, void *data)
 	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
 	 * We can only free the PASID when all the devices are unbound.
 	 */
-	if (ioasid_find(NULL, ioasid, NULL)) {
-		pr_alert("Cannot free active IOASID %d\n", ioasid);
+	if (IS_ERR(ioasid_find(host_pasid_set, ioasid, NULL))) {
+		pr_err("IOASID %d to be freed but not in system set\n", ioasid);
 		return;
 	}
 	vcmd_free_pasid(iommu, ioasid);
@@ -3333,8 +3336,17 @@ static int __init init_dmars(void)
 		goto free_iommu;
 
 	/* PASID is needed for scalable mode irrespective to SVM */
-	if (intel_iommu_sm)
+	if (intel_iommu_sm) {
 		ioasid_install_capacity(intel_pasid_max_id);
+		/* We should not run out of IOASIDs at boot */
+		host_pasid_set = ioasid_set_alloc(NULL, PID_MAX_DEFAULT,
+						  IOASID_SET_TYPE_NULL);
+		if (IS_ERR_OR_NULL(host_pasid_set)) {
+			pr_err("Failed to allocate host PASID set %lu\n",
+				PTR_ERR(host_pasid_set));
+			intel_iommu_sm = 0;
+		}
+	}
 
 	/*
 	 * for each drhd
@@ -3381,7 +3393,7 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
-
+	ioasid_set_put(host_pasid_set);
 	kfree(g_iommus);
 
 error:
@@ -5163,7 +5175,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_free(host_pasid_set, domain->default_pasid);
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5181,7 +5193,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		int pasid;
 
 		/* No private data needed for the default pasid */
-		pasid = ioasid_alloc(NULL, PASID_MIN,
+		pasid = ioasid_alloc(host_pasid_set, PASID_MIN,
 				     pci_max_pasids(to_pci_dev(dev)) - 1,
 				     NULL);
 		if (pasid == INVALID_IOASID) {
@@ -5224,7 +5236,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	spin_unlock(&iommu->lock);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_free(host_pasid_set, domain->default_pasid);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index c9850766c3a9..ccdc23446015 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -99,6 +99,7 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 }
 
 extern u32 intel_pasid_max_id;
+extern struct ioasid_set *host_pasid_set;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
 void intel_pasid_free_id(int pasid);
 void *intel_pasid_lookup_id(int pasid);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 06a16bee7b65..2e764e283469 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -228,7 +228,9 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
-static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
+static int pasid_to_svm_sdev(struct device *dev,
+			     struct ioasid_set *set,
+			     unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
 {
@@ -242,7 +244,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
 		return -EINVAL;
 
-	svm = ioasid_find(NULL, pasid, NULL);
+	svm = ioasid_find(set, pasid, NULL);
 	if (IS_ERR(svm))
 		return PTR_ERR(svm);
 
@@ -312,7 +314,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	ret = pasid_to_svm_sdev(dev, data->hpasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, NULL,
+				data->hpasid, &svm, &sdev);
 	if (ret)
 		goto out;
 
@@ -417,7 +420,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 		return -EINVAL;
 
 	mutex_lock(&pasid_mutex);
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, NULL, pasid, &svm, &sdev);
 	if (ret)
 		goto out;
 
@@ -555,7 +558,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
+		svm->pasid = ioasid_alloc(host_pasid_set, PASID_MIN,
 					  pasid_max - 1, svm);
 		if (svm->pasid == INVALID_IOASID) {
 			kfree(svm);
@@ -572,7 +575,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
+				ioasid_free(host_pasid_set, svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -590,7 +593,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
+			ioasid_free(host_pasid_set, svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -638,7 +641,8 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, host_pasid_set,
+				pasid, &svm, &sdev);
 	if (ret)
 		goto out;
 
@@ -659,7 +663,7 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_free(svm->pasid);
+				ioasid_free(host_pasid_set, svm->pasid);
 				if (svm->mm)
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 				list_del(&svm->list);
@@ -1130,7 +1134,8 @@ int intel_svm_page_response(struct device *dev,
 		goto out;
 	}
 
-	ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
+	ret = pasid_to_svm_sdev(dev, host_pasid_set,
+				prm->pasid, &svm, &sdev);
 	if (ret || !sdev) {
 		ret = -ENODEV;
 		goto out;
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 4277cb17e15b..61e25c2375ab 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split into
- * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc and ioasid_free.
+ * sets. Users create a set with ioasid_set_alloc, then allocate/free IDs
+ * with ioasid_alloc and ioasid_free.
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -14,6 +14,8 @@
 #define PCI_PASID_MAX 0x100000
 static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
+static DEFINE_XARRAY_ALLOC(ioasid_sets);
+
 struct ioasid_data {
 	ioasid_t id;
 	struct ioasid_set *set;
@@ -343,6 +345,114 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+static inline bool ioasid_set_is_valid(struct ioasid_set *set)
+{
+	return xa_load(&ioasid_sets, set->id) == set;
+}
+
+/**
+ * ioasid_set_alloc - Allocate a new IOASID set for a given token
+ *
+ * @token:	An optional arbitrary number that can be associated with the
+ *		IOASID set. @token can be NULL if the type is
+ *		IOASID_SET_TYPE_NULL
+ * @quota:	Quota allowed in this set
+ * @type:	The type of the token used to create the IOASID set
+ *
+ * IOASID is limited system-wide resource that requires quota management.
+ * Token will be stored in the ioasid_set returned. A reference will be taken
+ * on the newly created set. Subsequent IOASID allocation within the set need
+ * to use the retured ioasid_set pointer.
+ */
+struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
+{
+	struct ioasid_set *set;
+	unsigned long index;
+	ioasid_t id;
+
+	if (type >= IOASID_SET_TYPE_NR)
+		return ERR_PTR(-EINVAL);
+
+	/* REVISIT: may support set w/o quota, use system available */
+	if (!quota)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Need to check space available if we share system-wide quota.
+	 * TODO: we may need to support quota free sets in the future.
+	 */
+	spin_lock(&ioasid_allocator_lock);
+	if (quota > ioasid_capacity_avail) {
+		pr_warn("Out of IOASID capacity! ask %d, avail %d\n",
+			quota, ioasid_capacity_avail);
+		set = ERR_PTR(-ENOSPC);
+		goto exit_unlock;
+	}
+
+	/*
+	 * Token is only unique within its types but right now we have only
+	 * mm type. If we have more token types, we have to match type as well.
+	 */
+	switch (type) {
+	case IOASID_SET_TYPE_MM:
+		if (!token) {
+			set = ERR_PTR(-EINVAL);
+			goto exit_unlock;
+		}
+		/* Search existing set tokens, reject duplicates */
+		xa_for_each(&ioasid_sets, index, set) {
+			if (set->token == token &&
+				set->type == IOASID_SET_TYPE_MM) {
+				set = ERR_PTR(-EEXIST);
+				goto exit_unlock;
+			}
+		}
+		break;
+	case IOASID_SET_TYPE_NULL:
+		if (!token)
+			break;
+		fallthrough;
+	default:
+		pr_err("Invalid token and IOASID type\n");
+		set = ERR_PTR(-EINVAL);
+		goto exit_unlock;
+	}
+
+	set = kzalloc(sizeof(*set), GFP_ATOMIC);
+	if (!set) {
+		set = ERR_PTR(-ENOMEM);
+		goto exit_unlock;
+	}
+
+	if (xa_alloc(&ioasid_sets, &id, set,
+		     XA_LIMIT(0, ioasid_capacity_avail - quota),
+		     GFP_ATOMIC)) {
+		kfree(set);
+		set = ERR_PTR(-ENOSPC);
+		goto exit_unlock;
+	}
+
+	set->token = token;
+	set->type = type;
+	set->quota = quota;
+	set->id = id;
+	refcount_set(&set->ref, 1);
+
+	/*
+	 * Per set XA is used to store private IDs within the set, get ready
+	 * for ioasid_set private ID and system-wide IOASID allocation
+	 * results.
+	 */
+	xa_init(&set->xa);
+	ioasid_capacity_avail -= quota;
+
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+
+	return set;
+}
+EXPORT_SYMBOL_GPL(ioasid_set_alloc);
+
 /**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
@@ -360,11 +470,22 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 {
 	struct ioasid_data *data;
 	void *adata;
-	ioasid_t id;
+	ioasid_t id = INVALID_IOASID;
+
+	spin_lock(&ioasid_allocator_lock);
+	/* Check if the IOASID set has been allocated and initialized */
+	if (WARN_ON(!ioasid_set_is_valid(set)))
+		goto done_unlock;
+
+	if (set->quota <= set->nr_ioasids) {
+		pr_err_ratelimited("IOASID set out of quota %d\n",
+				   set->quota);
+		goto done_unlock;
+	}
 
 	data = kzalloc(sizeof(*data), GFP_ATOMIC);
 	if (!data)
-		return INVALID_IOASID;
+		goto done_unlock;
 
 	data->set = set;
 	data->private = private;
@@ -373,11 +494,10 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	 * Custom allocator needs allocator data to perform platform specific
 	 * operations.
 	 */
-	spin_lock(&ioasid_allocator_lock);
 	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
 	id = active_allocator->ops->alloc(min, max, adata);
 	if (id == INVALID_IOASID) {
-		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
+		pr_err_ratelimited("Failed IOASID allocation %lu\n", active_allocator->flags);
 		goto exit_free;
 	}
 
@@ -386,46 +506,153 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		/* Custom allocator needs framework to store and track allocation results */
 		pr_err("Failed to alloc ioasid from %d\n", id);
 		active_allocator->ops->free(id, active_allocator->ops->pdata);
+		if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM)
+			xa_erase(&active_allocator->xa, id);
 		goto exit_free;
 	}
 	data->id = id;
 
-	spin_unlock(&ioasid_allocator_lock);
-	return id;
+	/* Store IOASID in the per set data */
+	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
+		pr_err_ratelimited("Failed to store ioasid %d in set\n", id);
+		active_allocator->ops->free(id, active_allocator->ops->pdata);
+		goto exit_free;
+	}
+	set->nr_ioasids++;
+	goto done_unlock;
 exit_free:
-	spin_unlock(&ioasid_allocator_lock);
 	kfree(data);
-	return INVALID_IOASID;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return id;
 }
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
-/**
- * ioasid_free - Free an IOASID
- * @ioasid: the ID to remove
- */
-void ioasid_free(ioasid_t ioasid)
+static void ioasid_do_free_locked(struct ioasid_data *data)
 {
 	struct ioasid_data *ioasid_data;
 
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (!ioasid_data) {
-		pr_err("Trying to free unknown IOASID %u\n", ioasid);
-		goto exit_unlock;
-	}
-
-	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
+	active_allocator->ops->free(data->id, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
-		ioasid_data = xa_erase(&active_allocator->xa, ioasid);
+		ioasid_data = xa_erase(&active_allocator->xa, data->id);
 		kfree_rcu(ioasid_data, rcu);
 	}
 
-exit_unlock:
+	data->set->nr_ioasids--;
+	xa_erase(&data->set->xa, data->id);
+}
+
+static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to free unknown IOASID %u\n", ioasid);
+		return;
+	}
+	if (data->set != set) {
+		pr_warn("Cannot free IOASID %u due to set ownership\n", ioasid);
+		return;
+	}
+	/* Check if the set exists */
+	if (WARN_ON(!xa_load(&ioasid_sets, data->set->id)))
+		return;
+
+	ioasid_do_free_locked(data);
+}
+
+/**
+ * ioasid_free - Drop reference on an IOASID. Free if refcount drops to 0,
+ *               including free from its set and system-wide list.
+ * @set:	The ioasid_set to check permission with. If not NULL, IOASID
+ *		free will fail if the set does not match.
+ * @ioasid:	The IOASID to remove
+ */
+void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_free_locked(set, ioasid);
 	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
+static void ioasid_set_get_locked(struct ioasid_set *set)
+{
+	if (WARN_ON(!ioasid_set_is_valid(set)))
+		return;
+
+	refcount_inc(&set->ref);
+}
+
+void ioasid_set_get(struct ioasid_set *set)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_set_get_locked(set);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_set_get);
+
+static void ioasid_set_put_locked(struct ioasid_set *set)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (WARN_ON(!ioasid_set_is_valid(set)))
+		return;
+
+	if (!refcount_dec_and_test(&set->ref))
+		return;
+
+	/* The set is already empty, we just destroy the set. */
+	if (xa_empty(&set->xa))
+		goto done_destroy;
+
+	/*
+	 * Free all PASIDs from system-wide IOASID pool, all subscribers gets
+	 * notified and do cleanup of their own.
+	 * Note that some references of the IOASIDs within the set can still
+	 * be held after the free call. This is OK in that the IOASIDs will be
+	 * marked inactive, the only operations can be done is ioasid_put.
+	 * No need to track IOASID set states since there is no reclaim phase.
+	 */
+	xa_for_each(&set->xa, index, entry) {
+		ioasid_free_locked(set, index);
+		/* Free from per set private pool */
+		xa_erase(&set->xa, index);
+	}
+
+done_destroy:
+	/* Return the quota back to system pool */
+	ioasid_capacity_avail += set->quota;
+
+	/*
+	 * Token got released right away after the ioasid_set is freed.
+	 * If a new set is created immediately with the newly released token,
+	 * it will not allocate the same IOASIDs unless they are reclaimed.
+	 */
+	xa_erase(&ioasid_sets, set->id);
+	kfree_rcu(set, rcu);
+}
+
+/**
+ * ioasid_set_put - Drop a reference to the IOASID set. Free all IOASIDs within
+ *                  the set if there are no more users.
+ *
+ * @set:	The IOASID set ID to be freed
+ *
+ * If refcount drops to zero, all IOASIDs allocated within the set will be
+ * freed.
+ */
+void ioasid_set_put(struct ioasid_set *set)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_set_put_locked(set);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_set_put);
+
 /**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 7fc320656be2..1ae213b660f0 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,14 +4,43 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/xarray.h>
+#include <linux/refcount.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
+/* IOASID set types */
+enum ioasid_set_type {
+	IOASID_SET_TYPE_NULL = 1, /* Set token is NULL */
+	IOASID_SET_TYPE_MM,	  /* Set token is a mm_struct pointer
+				   * i.e. associated with a process
+				   */
+	IOASID_SET_TYPE_NR,
+};
+
+/**
+ * struct ioasid_set - Meta data about ioasid_set
+ * @xa:		XArray to store ioasid_set private IDs, can be used for
+ *		guest-host IOASID mapping, or just a private IOASID namespace.
+ * @token:	Unique to identify an IOASID set
+ * @type:	Token types
+ * @quota:	Max number of IOASIDs can be allocated within the set
+ * @nr_ioasids:	Number of IOASIDs currently allocated in the set
+ * @id:		ID of the set
+ * @ref:	Reference count of the users
+ */
 struct ioasid_set {
-	int dummy;
+	struct xarray xa;
+	void *token;
+	int type;
+	int quota;
+	int nr_ioasids;
+	int id;
+	refcount_t ref;
+	struct rcu_head rcu;
 };
 
 /**
@@ -29,14 +58,16 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
-#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
-
 #if IS_ENABLED(CONFIG_IOASID)
 void ioasid_install_capacity(ioasid_t total);
 ioasid_t ioasid_get_capacity(void);
+struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type);
+void ioasid_set_get(struct ioasid_set *set);
+void ioasid_set_put(struct ioasid_set *set);
+
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_free(ioasid_t ioasid);
+void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -59,12 +90,20 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_free(ioasid_t ioasid)
+static inline void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
+{
+}
+
+static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void ioasid_set_put(struct ioasid_set *set)
 {
 }
 
-static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-				bool (*getter)(void *))
+static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *))
 {
 	return NULL;
 }
-- 
2.7.4

