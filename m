Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84F227B73A
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgI1VhG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgI1Vgy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877FC0613D3;
        Mon, 28 Sep 2020 14:36:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so2036447pgf.12;
        Mon, 28 Sep 2020 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0VNflzOyKJDouCud0picP6wYZjX9Ua4i7l764OZICM8=;
        b=IB+nqXH8/Ev0X4HeTmPN8SZYS754bLGnkBj5Lct14pNRT9/UKsRz/V2LFPn7LOceQG
         vVqrkkz1/puqoi5Zf8iKXrlYx6uByFULsgSrfVmraZdegMB2VT46QxW1vndMFwErgXTj
         MIcgza7ehvpAtNYqB95pGnpzB/UYUlsbY/oEkw3Gntnxcpz/ZZG+Kc/8vqS74k9uUPOb
         b1rppJF7KgTmvH+CbQkgiL5wX6tt9hNXXxeH3vSZfy6GHYWXYJM5uq41mwr8ehTTI5KT
         TQ14n8IxwP1lgQNvit4P2QB5rdUA2JzPrv2QTg3ZfcSR/nXyI1/rs8MuWDYJjjJps90N
         +0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0VNflzOyKJDouCud0picP6wYZjX9Ua4i7l764OZICM8=;
        b=jbWsdJWWG5tBz/idIQmjjnAQUES/ztNXZ0/zpiig9svkLp/oi3uUbd5Cdwr2jg012p
         u41N7HcsNwBxupfli5Z0dz4DbkRX22YE/zMV8fPlAkXJKj+jaJX4GgDBvhfGx7F7rZ1g
         BEEHfzdBpMujNtanL1eUvsZUM72ZSgISejUDKnQ+zBaTFAN4rSAcUGE2rgKdMVuDzTnS
         LLxzx1Ers8GGqrz4WNZabhW2yV+VfdiY++coBUjWk1sE1fQyBpRK4bMGSUG2YeQIyjt8
         7DMYFaUmGtPVzkGYeKkIUL90+BdomQVSAMct55xu7XPsLm+6UzZRrFBsufDq/4rjbGuU
         XeEw==
X-Gm-Message-State: AOAM533CgIq2we8LbHTaE97gj7kibk9L/4BnqfIzZBE1A9qEP9S5mh62
        9giJUXStcgRQUvj6a4mPvKE=
X-Google-Smtp-Source: ABdhPJyN0AGs4yJhjYycm/0Nepx35dklx4xC7RepgnKoEUnRZq4rWEiBGv96T2lnza4ujIwp6Fksbw==
X-Received: by 2002:a65:5902:: with SMTP id f2mr725734pgu.379.1601329013998;
        Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
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
Subject: [PATCH v3 09/14] iommu/ioasid: Introduce ioasid_set private ID
Date:   Mon, 28 Sep 2020 14:38:36 -0700
Message-Id: <1601329121-36979-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When an IOASID set is used for guest SVA, each VM will acquire its
ioasid_set for IOASID allocations. IOASIDs within the VM must have a
host/physical IOASID backing, mapping between guest and host IOASIDs can
be non-identical. IOASID set private ID (SPID) is introduced in this
patch to be used as guest IOASID. However, the concept of ioasid_set
specific namespace is generic, thus named SPID.

As SPID namespace is within the IOASID set, the IOASID core can provide
lookup services at both directions. SPIDs may not be available when its
IOASID is allocated, the mapping between SPID and IOASID is usually
established when a guest page table is bound to a host PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  19 +++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 828cc44b1b1c..378fef8f23d9 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -26,6 +26,7 @@ enum ioasid_state {
  * struct ioasid_data - Meta data about ioasid
  *
  * @id:		Unique ID
+ * @spid:	Private ID unique within a set
  * @users:	Number of active users
  * @state:	Track state of the IOASID
  * @set:	ioasid_set of the IOASID belongs to
@@ -34,6 +35,7 @@ enum ioasid_state {
  */
 struct ioasid_data {
 	ioasid_t id;
+	ioasid_t spid;
 	refcount_t users;
 	enum ioasid_state state;
 	struct ioasid_set *set;
@@ -363,6 +365,105 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid)
+{
+	ioasid_t ioasid = INVALID_IOASID;
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!xa_load(&ioasid_sets, set->id)) {
+		pr_warn("Invalid set\n");
+		goto done;
+	}
+
+	xa_for_each(&set->xa, index, entry) {
+		if (spid == entry->spid) {
+			refcount_inc(&entry->users);
+			ioasid = index;
+		}
+	}
+done:
+	return ioasid;
+}
+
+/**
+ * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
+ *
+ * @ioasid: the system-wide IOASID to attach
+ * @spid:   the ioasid_set private ID of @ioasid
+ *
+ * After attching SPID, future lookup can be done via ioasid_find_by_spid().
+ */
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	struct ioasid_data *data;
+	int ret = 0;
+
+	if (spid == INVALID_IOASID)
+		return -EINVAL;
+
+	spin_lock(&ioasid_allocator_lock);
+	data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!data) {
+		pr_err("No IOASID entry %d to attach SPID %d\n",
+			ioasid, spid);
+		ret = -ENOENT;
+		goto done_unlock;
+	}
+	/* Check if SPID is unique within the set */
+	if (ioasid_find_by_spid_locked(data->set, spid) != INVALID_IOASID) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	data->spid = spid;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_attach_spid);
+
+void ioasid_detach_spid(ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	spin_lock(&ioasid_allocator_lock);
+	data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!data || data->spid == INVALID_IOASID) {
+		pr_err("Invalid IOASID entry %d to detach\n", ioasid);
+		goto done_unlock;
+	}
+	data->spid = INVALID_IOASID;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_spid);
+
+/**
+ * ioasid_find_by_spid - Find the system-wide IOASID by a set private ID and
+ * its set.
+ *
+ * @set:	the ioasid_set to search within
+ * @spid:	the set private ID
+ *
+ * Given a set private ID and its IOASID set, find the system-wide IOASID. Take
+ * a reference upon finding the matching IOASID. Return INVALID_IOASID if the
+ * IOASID is not found in the set or the set is not valid.
+ */
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
+{
+	ioasid_t ioasid;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid = ioasid_find_by_spid_locked(set, spid);
+	spin_unlock(&ioasid_allocator_lock);
+	return ioasid;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
+
 static inline bool ioasid_set_is_valid(struct ioasid_set *set)
 {
 	return xa_load(&ioasid_sets, set->id) == set;
@@ -529,6 +630,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	data->id = id;
+	data->spid = INVALID_IOASID;
 	data->state = IOASID_STATE_ACTIVE;
 	refcount_set(&data->users, 1);
 
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 16d421357173..2dfe85e6cb7e 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -79,6 +79,10 @@ bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
+void ioasid_detach_spid(ioasid_t ioasid);
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
+
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
@@ -159,6 +163,21 @@ static inline void ioasid_detach_data(ioasid_t ioasid)
 {
 }
 
+static inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_detach_spid(ioasid_t ioasid)
+{
+}
+
+static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set,
+					   ioasid_t spid)
+{
+	return INVALID_IOASID;
+}
+
 static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 					      void (*fn)(ioasid_t id, void *data),
 					      void *data)
-- 
2.7.4

