Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9468327B729
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgI1Vgz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgI1Vgt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EDFC061755;
        Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h23so337202pjv.5;
        Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwi3i0q/cn+NLcsJ/OschTx3Q/x+51Mi2oWAxj4yj8g=;
        b=NL596sY6bqU+rbeX7xBtMeb+xWj2cDDR5UT9FJx8xhU4w82SByKy6IfuXP0HnbkVTo
         jLJdAIFGrnLu983EZyts0X8Jx98i7P1nF+vNcbAR78d0T3mX25+RcLGZ/RRIppFIEXOJ
         3knEe5CgXferUTfrddi6u3uasBCAlAgDBnKIc1+PSX9ozsQscj5WSmkXnOWhbNijRv3Y
         RTZZsQHyMR5doENwOQw752lpfrLhoyQyFgyjNszTqq9X2dg/fS7leywkuYfv9/YrZ7f4
         30TBFIIO6T+Q7Ij/rUqfCntf8cMIo7WIfo6jRZMz80yd9h/AmsnUQywiY7VwX1mivYL5
         i5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwi3i0q/cn+NLcsJ/OschTx3Q/x+51Mi2oWAxj4yj8g=;
        b=T9AMp83cWtvmM7tW0PGLp0i+owDGhqEGNrqnZWATZ0xIQcdubdXuycKMKFL0v3ipIZ
         /p1fi+Irnw63DdaASTV0aFsF/6DEFXYeTUdS9QJ4aSxb/cWamD2gu3Ym7XICGXuYDnD6
         eo89zL1wf5IAw4cK97BiewDFIPr4Hnqc36LeaAwIAy+QoahLjpkChEYqOFxYm7IJ4tqD
         /Lx5rcBJD7fEQlcFsnhc2GJqKKXmESBwGLtDgwpkTeGvkJYZ56elrweto+e4ed1H/7B9
         /8U5/iJsoM2Y7qvi8U1RozTXR9ac+NiaDqkgyDK7HwfZtcdSELHr9LwSmIYHc5tYqLxM
         LrnQ==
X-Gm-Message-State: AOAM530T7NGirB966fIpwHAmbjZsegf+plRc4sfiJc0+auyErw44GP1C
        Rl3SboAbIsfnKhLSe66h+mA=
X-Google-Smtp-Source: ABdhPJxi4ZHS+UE6ljCKa0oXDHjzLOvulhCdfiHhbQUALXqDNffipWYxYK9VkwT/qvoc2zTWeb8c0A==
X-Received: by 2002:a17:90a:3d0e:: with SMTP id h14mr1067667pjc.34.1601329007377;
        Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:46 -0700 (PDT)
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
Subject: [PATCH v3 03/14] iommu/ioasid: Add a separate function for detach data
Date:   Mon, 28 Sep 2020 14:38:30 -0700
Message-Id: <1601329121-36979-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOASID private data can be cleared by ioasid_attach_data() with a NULL
data pointer. A common use case is for a caller to free the data
afterward. ioasid_attach_data() calls synchronize_rcu() before return
such that free data can be sure without outstanding readers.
However, since synchronize_rcu() may sleep, ioasid_attach_data() cannot
be used under spinlocks.

This patch adds ioasid_detach_data() as a separate API where
synchronize_rcu() is called only in this case. ioasid_attach_data() can
then be used under spinlocks. In addition, this change makes the API
symmetrical.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c |  4 ++--
 drivers/iommu/ioasid.c    | 54 ++++++++++++++++++++++++++++++++++++++---------
 include/linux/ioasid.h    |  5 ++++-
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2c5645f0737a..06a16bee7b65 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -398,7 +398,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_attach_data(data->hpasid, NULL);
+		ioasid_detach_data(data->hpasid);
 		kfree(svm);
 	}
 
@@ -441,7 +441,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_attach_data(pasid, NULL);
+				ioasid_detach_data(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 5f63af07acd5..6cfbdfb492e0 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -272,24 +272,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
 
 	spin_lock(&ioasid_allocator_lock);
 	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		rcu_assign_pointer(ioasid_data->private, data);
-	else
+
+	if (!ioasid_data) {
 		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
+		goto done_unlock;
+	}
 
-	/*
-	 * Wait for readers to stop accessing the old private data, so the
-	 * caller can free it.
-	 */
-	if (!ret)
-		synchronize_rcu();
+	if (ioasid_data->private) {
+		ret = -EBUSY;
+		goto done_unlock;
+	}
+	rcu_assign_pointer(ioasid_data->private, data);
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
+ * ioasid_detach_data - Clear the private data of an ioasid
+ *
+ * @ioasid: the IOASIDD to clear private data
+ */
+void ioasid_detach_data(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!ioasid_data) {
+		pr_warn("IOASID %u not found to detach data from\n", ioasid);
+		goto done_unlock;
+	}
+
+	if (ioasid_data->private) {
+		rcu_assign_pointer(ioasid_data->private, NULL);
+		goto done_unlock;
+	}
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	/*
+	 * Wait for readers to stop accessing the old private data,
+	 * so the caller can free it.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_data);
+
+/**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
  * @min: the minimum ID (inclusive)
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 9c44947a68c8..c7f649fa970a 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
-
+void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
@@ -72,5 +72,8 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline void ioasid_detach_data(ioasid_t ioasid)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

