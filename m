Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C351127B730
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgI1VhG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgI1Vgx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:53 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2E3C0613D0;
        Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so2398187pfc.7;
        Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yei0j16GxAwc2LYHNKX/wuGB6g/wxiefyuN8CN5KOhA=;
        b=MhU9PjhyMf7MNclmE9Russh4LvaKfSInVEGZrrRsaACtJ7o+CqjrM2qqEXHfugFxcx
         4xmexKD6I9SIlhcjT14ashIvfQNP+Mn/+h+YB2GdlcEyo3aZD4VvMzpSpcWPh3MMbeYo
         wJcqiGj0Hx/DMgX/Gn6XAGtxJ3jPcAnQq4c68DEfsK+QZ/p49Dei9QbC1clDBGzRsBcb
         eCkyGtYhHXHnVM03n5tktZUnX4EPhMkYuCjnm7K2fX6Uemncm3a3NNrav3IAXKRDPbAK
         NRlW9IDDF4X+qHKz4qD12xSgbVxqKcb/NnKdw8j50diHXE8o0ZTLTSI7b4K5UbrZQUHe
         zpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yei0j16GxAwc2LYHNKX/wuGB6g/wxiefyuN8CN5KOhA=;
        b=jhsw6KJfkbJGk8o9HF3rbzXLH9PZ8HFwxD6EvMMu9LbxAP1TiUS14+rqBE2scI0+qq
         D5lm5ZhzOPV17Cs+x4HJHbc3XSs6jaK/5mTaju3W54ftwhaR1JSiIgP9uFqIc2tNkItT
         ctrEUTO41mgcI1X4m9OoY9hbQM3Yxd3/56+EEryN1BI9C8EpglxNW716F9I51WP6ruQJ
         ThoVvEPtdLxURtslQ9qKCKA24nlX6brAZYW7R1vUZ+rOqlsGHwcxFZD7QhJJx2Wf181c
         nXYo8KlsZK205cZ+G/n29QRrrJXpK+v5rIjj5bil4RNSjbYlEGuhadVrubAbDm+bucUE
         sUIA==
X-Gm-Message-State: AOAM533Xvg1nqDFi386EU8OPkFFkl6EtdjT+tqQSdiiBvlrPAcBhPP3o
        tkNhjgb9TF4bqwE12Xe24ChY6DleaHc=
X-Google-Smtp-Source: ABdhPJx9T9NnJRyW+H0loFWwDE01pVod4Mng5pPkleA/hyh82iEdSLAAucXmylihIEBsiFhDJDFuZg==
X-Received: by 2002:a63:784:: with SMTP id 126mr792741pgh.428.1601329012945;
        Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
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
Subject: [PATCH v3 08/14] iommu/ioasid: Add reference couting functions
Date:   Mon, 28 Sep 2020 14:38:35 -0700
Message-Id: <1601329121-36979-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There can be multiple users of an IOASID, each user could have hardware
contexts associated with the IOASID. In order to align lifecycles,
reference counting is introduced in this patch. It is expected that when
an IOASID is being freed, each user will drop a reference only after its
context is cleared.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  24 ++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 9628e78b2ab4..828cc44b1b1c 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -16,8 +16,26 @@ static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
 
+enum ioasid_state {
+	IOASID_STATE_INACTIVE,
+	IOASID_STATE_ACTIVE,
+	IOASID_STATE_FREE_PENDING,
+};
+
+/**
+ * struct ioasid_data - Meta data about ioasid
+ *
+ * @id:		Unique ID
+ * @users:	Number of active users
+ * @state:	Track state of the IOASID
+ * @set:	ioasid_set of the IOASID belongs to
+ * @private:	Private data associated with the IOASID
+ * @rcu:	For free after RCU grace period
+ */
 struct ioasid_data {
 	ioasid_t id;
+	refcount_t users;
+	enum ioasid_state state;
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
@@ -511,6 +529,8 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	data->id = id;
+	data->state = IOASID_STATE_ACTIVE;
+	refcount_set(&data->users, 1);
 
 	/* Store IOASID in the per set data */
 	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
@@ -560,6 +580,14 @@ static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
 	if (WARN_ON(!xa_load(&ioasid_sets, data->set->id)))
 		return;
 
+	/* Free is already in progress */
+	if (data->state == IOASID_STATE_FREE_PENDING)
+		return;
+
+	data->state = IOASID_STATE_FREE_PENDING;
+	if (!refcount_dec_and_test(&data->users))
+		return;
+
 	ioasid_do_free_locked(data);
 }
 
@@ -717,6 +745,95 @@ void ioasid_set_for_each_ioasid(struct ioasid_set *set,
 }
 EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
 
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to get unknown IOASID %u\n", ioasid);
+		return -EINVAL;
+	}
+	if (data->state == IOASID_STATE_FREE_PENDING) {
+		pr_err("Trying to get IOASID being freed%u\n", ioasid);
+		return -EBUSY;
+	}
+
+	/* Check set ownership if the set is non-null */
+	if (set && data->set != set) {
+		pr_err("Trying to get IOASID %u outside the set\n", ioasid);
+		/* data found but does not belong to the set */
+		return -EACCES;
+	}
+	refcount_inc(&data->users);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_locked);
+
+/**
+ * ioasid_get - Obtain a reference to an ioasid
+ * @set:	the ioasid_set to check permission against if not NULL
+ * @ioasid:	the ID to remove
+ *
+ *
+ * Return: 0 on success, error if failed.
+ */
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	int ret;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_get_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
+bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to put unknown IOASID %u\n", ioasid);
+		return false;
+	}
+	if (set && data->set != set) {
+		pr_err("Trying to drop IOASID %u outside the set\n", ioasid);
+		return false;
+	}
+	if (!refcount_dec_and_test(&data->users))
+		return false;
+
+	ioasid_do_free_locked(data);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ioasid_put_locked);
+
+/**
+ * ioasid_put - Release a reference to an ioasid
+ * @set:	the ioasid_set to check permission against if not NULL
+ * @ioasid:	the ID to remove
+ *
+ * Put a reference to the IOASID, free it when the number of references drops to
+ * zero.
+ *
+ * Return: %true if the IOASID was freed, %false otherwise.
+ */
+bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	bool ret;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_put_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_put);
+
 /**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index aab58bc26714..16d421357173 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,6 +73,10 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
+bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
@@ -112,6 +116,26 @@ static inline void ioasid_set_put(struct ioasid_set *set)
 {
 }
 
+static inline int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
+static inline int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
+static inline bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return false;
+}
+
+static inline bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return false;
+}
+
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *))
 {
 	return NULL;
-- 
2.7.4

