Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE027B738
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgI1VhG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgI1VhF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:37:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A982C0613D7;
        Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so1472143pjb.0;
        Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gd3yej60dudO/8DXRzuDh/k17amPnxhlwfOMJTioVQM=;
        b=tTP4J0IaMk227Z8asAN85KOSM1A9No6RY5e4LLFeNceqe/24u2KHAriyTcErBdU/B1
         31JrR3t6e3CMvNPvKtmHYn5xeL0W5vprCR+nt/PqLPtlde7HhW2YJ7Ifw4hkewplV1En
         3f1l3EKdbTyvD2l6+wVWCFO6ca8AHad7f2TtYBshmeXQPwFA+jlBxzx9StY2//cJs4fP
         nux79mYcFISBDkY6rB1Z21u41p7ZwLBrP/+/hv826s2RTf3iBTCgiynbv311mURUl3pe
         CcxIbqqZgFAB8feDEaYIjQw7quZqOmnwjXIxwKKC8e9R7eRCr5Zz+sn+EXAOw41VaWRb
         NQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gd3yej60dudO/8DXRzuDh/k17amPnxhlwfOMJTioVQM=;
        b=YqhXtOXl+LFdHw+Ped2NEf/1WPZKJJViqFq0R0gy9sEoibsJ+KhqaUXwh1oshtmcdp
         ESYh4UTDEOyFsz4dTiegehxQGp6jTaX3GPZ8wxDwIHWIXaOLwFxF/Ltlbr8v13PgQdqG
         S/n/G7M8/W+q38V7KOP2jiHpz5eRuIg5hYKhU0jssOqDHIjW1JbrzBHswgcxPcAzdbeP
         6K7/jd7xyZGr+i1L1vYztK+CJ3KdFLlsfPpos4Xkd8BJCSSHCBVrpx0RmgAD4FwLCVBc
         9w4kLY+SJfUMd6ob7MXe+/7Oi2nknEjiqVdNEYjLiVtOF1kW7lNnGZ/XhjVr3la66Af4
         4S/A==
X-Gm-Message-State: AOAM5320ltJHKpJhgJaOUqlL7urSJvdyGXAEgX/henKGI49T4MiiJtKs
        H2jbVqM58JqcCcf3DtErNL0=
X-Google-Smtp-Source: ABdhPJx9iz0liS3WtMH3HKPteQJgZuhpU2LsqxwnYQPtfa8tQQAV9sXRarVwRsALY0g9GPPWrLoaKQ==
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr1004758pjb.73.1601329018191;
        Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:57 -0700 (PDT)
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
Subject: [PATCH v3 13/14] iommu/vt-d: Listen to IOASID notifications
Date:   Mon, 28 Sep 2020 14:38:40 -0700
Message-Id: <1601329121-36979-14-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Intel Scalable I/O Virtualization (SIOV) enabled platforms, IOMMU
driver is one of the users of IOASIDs. In normal flow, callers will
perform IOASID allocation, bind, unbind, and free in order. However, for
guest SVA, IOASID free could come before unbind as guest is untrusted.
This patch registers IOASID notification handler such that IOMMU driver
can perform PASID teardown upon receiving an unexpected IOASID free
event.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c   | 94 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  2 +
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 39a09a93300e..8f886718df83 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -95,6 +95,90 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
 }
 
+static inline void intel_svm_drop_pasid(ioasid_t pasid)
+{
+	ioasid_detach_data(pasid);
+	ioasid_put(NULL, pasid);
+}
+
+static DEFINE_MUTEX(pasid_mutex);
+#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
+
+static void intel_svm_free_async_fn(struct work_struct *work)
+{
+	struct intel_svm *svm = container_of(work, struct intel_svm, work);
+	struct intel_svm_dev *sdev;
+
+	/*
+	 * Unbind all devices associated with this PASID which is
+	 * being freed by other users such as VFIO.
+	 */
+	mutex_lock(&pasid_mutex);
+	list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
+		/* Does not poison forward pointer */
+		list_del_rcu(&sdev->list);
+		spin_lock(&svm->iommu->lock);
+		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+					svm->pasid, true);
+		spin_unlock(&svm->iommu->lock);
+		kfree_rcu(sdev, rcu);
+	}
+	/*
+	 * We may not be the last user to drop the reference but since
+	 * the PASID is in FREE_PENDING state, no one can get new reference.
+	 * Therefore, we can safely free the private data svm.
+	 */
+	intel_svm_drop_pasid(svm->pasid);
+	/*
+	 * Free before unbind can only happen with host PASIDs used for
+	 * guest SVM. We get here because ioasid_free is called with
+	 * outstanding references. So we need to drop the reference
+	 * such that the PASID can be reclaimed. unbind_gpasid() after this
+	 * will not result in dropping refcount since the private data is
+	 * already detached.
+	 */
+	kfree(svm);
+
+	mutex_unlock(&pasid_mutex);
+}
+
+
+static int pasid_status_change(struct notifier_block *nb,
+				unsigned long code, void *data)
+{
+	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
+	struct intel_svm *svm = (struct intel_svm *)args->pdata;
+	int ret = NOTIFY_DONE;
+
+	if (code == IOASID_NOTIFY_FREE) {
+		/*
+		 * If PASID UNBIND happens before FREE, private data of the
+		 * IOASID should be NULL, then we don't need to do anything.
+		 */
+		if (!svm)
+			goto done;
+		if (args->id != svm->pasid) {
+			pr_warn("Notify PASID does not match data %d : %d\n",
+				args->id, svm->pasid);
+			goto done;
+		}
+		schedule_work(&svm->work);
+		return NOTIFY_OK;
+	}
+done:
+	return ret;
+}
+
+static struct notifier_block pasid_nb = {
+	.notifier_call = pasid_status_change,
+};
+
+void intel_svm_add_pasid_notifier(void)
+{
+	/* Listen to all PASIDs, not specific to a set */
+	ioasid_register_notifier(NULL, &pasid_nb);
+}
+
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -221,7 +305,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
 #define for_each_svm_dev(sdev, svm, d)			\
@@ -344,6 +427,13 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
 		ioasid_attach_data(data->hpasid, svm);
+		ioasid_get(NULL, svm->pasid);
+		svm->iommu = iommu;
+		/*
+		 * Set up cleanup async work in case IOASID core notify us PASID
+		 * is freed before unbind.
+		 */
+		INIT_WORK(&svm->work, intel_svm_free_async_fn);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 	}
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
@@ -437,7 +527,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_detach_data(pasid);
+				intel_svm_drop_pasid(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f25f7c0..d36038e6ae0b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 int intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+void intel_svm_add_pasid_notifier(void);
 
 struct svm_dev_ops;
 
@@ -770,6 +771,7 @@ struct intel_svm {
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
 	struct list_head list;
+	struct work_struct work; /* For deferred clean up */
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
-- 
2.7.4

