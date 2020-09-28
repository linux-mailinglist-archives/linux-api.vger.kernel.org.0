Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4327B742
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgI1Vh1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgI1VhH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:37:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86488C0613D5;
        Mon, 28 Sep 2020 14:36:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so1492097pjd.3;
        Mon, 28 Sep 2020 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Atey8nbuDzuUr3JKV5+LdIsFe8hfPfYfTvoAcQuofpk=;
        b=sx18k5qaKY7D44k250bMwq3BUbcBw0v4NNDbb7A3icBG7vgtWUUMQ56NxQaIUEyFZ2
         VAzw/jy0F2ydRi+14LPRsoaSfUxDSUBrWSpCMo6egbxoEEr+q3Bmo0zRmlZPA6Bj/P9Y
         minFyrHvScqwmmBLXc4P38QYP0JAChRfaMNaJf7lD5FVe/YPbblmKFBY2NBo2yrM8FbN
         Afo/LOcLg5udhHvPjOzuV8yK7xjKSPLgVvAOWQ4cVgRMa1OPGkGbmKiZCaq5fh+pzVPV
         FHR/roIi2Asx9cjJORqQe9hn2dj/o/q9vKlM4QIIBcWwI5+9/t1PSLAkApaImjDI56/I
         MaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Atey8nbuDzuUr3JKV5+LdIsFe8hfPfYfTvoAcQuofpk=;
        b=ENbNzUNN28kl72o+WoTr+Xh5hLa1dsDu7sioCCyifcxwVdFKtIdY/ckTk7WzhpTT2v
         D0wY8XMLZ4gD/zRQR0R19uxROyz3mJAi6rQ+4JnDGAA/WJuoHGEbl48PoJgVLZaZP3fM
         mWAZMt7gW3JB4laOa4kTTKNQEtyJ+sO5TqPKfI/wN4t6OkK4tgObECVXWL3JdK/jVWY6
         p7JEEETnsOFg52dTX7HxBYNE1ywb25C8pmgE+S/0kJHS+BgZ3/uJY4HTPO87/qOksW8x
         j5n2/aY6ivnlWx3PykKC3SBDl4bcAywAqf9R8hgttnRT/+nQ2Xn35s2dchm8PvY7w11M
         9/dA==
X-Gm-Message-State: AOAM533YnLvzhahlwlOVRfIU7VHH8koq5sxvDBBcTYfyvwgbhudMWNbG
        ecRuxW79SXG+0Y6djY+BqfQ=
X-Google-Smtp-Source: ABdhPJz/P48h6PBRWfmYp4KTl1u93gqaZoCJDUfjjgJpm/85E2fGfKu8V02yVviaaDMvuehX6BNagw==
X-Received: by 2002:a17:90b:b8f:: with SMTP id bd15mr1062834pjb.65.1601329016059;
        Mon, 28 Sep 2020 14:36:56 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:55 -0700 (PDT)
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
Subject: [PATCH v3 11/14] iommu/ioasid: Support mm type ioasid_set notifications
Date:   Mon, 28 Sep 2020 14:38:38 -0700
Message-Id: <1601329121-36979-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As a system-wide resource, IOASID is often shared by multiple kernel
subsystems that are independent of each other. However, at the
ioasid_set level, these kernel subsystems must communicate with each
other for ownership checking, event notifications, etc. For example, on
Intel Scalable IO Virtualization (SIOV) enabled platforms, KVM and VFIO
instances under the same process/guest must be aware of a shared IOASID
set.
IOASID_SET_TYPE_MM token type was introduced to explicitly mark an
IOASID set that belongs to a process, thus use the same mm_struct
pointer as a token. Users of the same process can then identify with
each other based on this token.

This patch introduces MM token specific event registration APIs. Event
subscribers such as KVM instances can register IOASID event handler
without the knowledge of its ioasid_set. Event handlers are registered
based on its mm_struct pointer as a token. In case when subscribers
register handler *prior* to the creation of the ioasid_set, the
handler’s notification block is stored in a pending list within IOASID
core. Once the ioasid_set of the MM token is created, the notification
block will be registered by the IOASID core.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  15 +++++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 894b17c06ead..d5faeb559a43 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -889,6 +889,29 @@ void ioasid_set_put(struct ioasid_set *set)
 }
 EXPORT_SYMBOL_GPL(ioasid_set_put);
 
+/*
+ * ioasid_find_mm_set - Retrieve IOASID set with mm token
+ * Take a reference of the set if found.
+ */
+static struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
+{
+	struct ioasid_set *set;
+	unsigned long index;
+
+	spin_lock(&ioasid_allocator_lock);
+
+	xa_for_each(&ioasid_sets, index, set) {
+		if (set->type == IOASID_SET_TYPE_MM && set->token == token) {
+			refcount_inc(&set->ref);
+			goto exit_unlock;
+		}
+	}
+	set = NULL;
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return set;
+}
+
 /**
  * ioasid_adjust_set - Adjust the quota of an IOASID set
  * @set:	IOASID set to be assigned
@@ -1121,6 +1144,100 @@ void ioasid_unregister_notifier(struct ioasid_set *set,
 }
 EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
 
+/**
+ * ioasid_register_notifier_mm - Register a notifier block on the IOASID set
+ *                               created by the mm_struct pointer as the token
+ *
+ * @mm: the mm_struct token of the ioasid_set
+ * @nb: notfier block to be registered on the ioasid_set
+ *
+ * This a variant of ioasid_register_notifier() where the caller intends to
+ * listen to IOASID events belong the ioasid_set created under the same
+ * process. Caller is not aware of the ioasid_set, no need to hold reference
+ * of the ioasid_set.
+ */
+int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+	struct ioasid_set *set;
+	int ret = 0;
+
+	if (!mm)
+		return -EINVAL;
+
+	spin_lock(&ioasid_nb_lock);
+
+	/* Check for duplicates, nb is unique per set */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == mm && curr->nb == nb) {
+			ret = -EBUSY;
+			goto exit_unlock;
+		}
+	}
+
+	/* Check if the token has an existing set */
+	set = ioasid_find_mm_set(mm);
+	if (!set) {
+		/* Add to the rsvd list as inactive */
+		curr->active = false;
+	} else {
+		/* REVISIT: Only register empty set for now. Can add an option
+		 * in the future to playback existing PASIDs.
+		 */
+		if (set->nr_ioasids) {
+			pr_warn("IOASID set %d not empty\n", set->id);
+			ret = -EBUSY;
+			goto exit_unlock;
+		}
+		curr = kzalloc(sizeof(*curr), GFP_ATOMIC);
+		if (!curr) {
+			ret = -ENOMEM;
+			goto exit_unlock;
+		}
+		curr->token = mm;
+		curr->nb = nb;
+		curr->active = true;
+		curr->set = set;
+
+		/* Set already created, add to the notifier chain */
+		atomic_notifier_chain_register(&set->nh, nb);
+		/*
+		 * Do not hold a reference, if the set gets destroyed, the nb
+		 * entry will be marked inactive.
+		 */
+		ioasid_set_put(set);
+	}
+
+	list_add(&curr->list, &ioasid_nb_pending_list);
+
+exit_unlock:
+	spin_unlock(&ioasid_nb_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
+
+void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == mm && curr->nb == nb) {
+			list_del(&curr->list);
+			spin_unlock(&ioasid_nb_lock);
+			if (curr->active) {
+				atomic_notifier_chain_unregister(&curr->set->nh,
+								 nb);
+			}
+			kfree(curr);
+			return;
+		}
+	}
+	pr_warn("No ioasid set found for mm token %llx\n",  (u64)mm);
+	spin_unlock(&ioasid_nb_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 1b551c99d568..c6cc855aadb6 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -132,6 +132,9 @@ void ioasid_unregister_notifier(struct ioasid_set *set,
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
+int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -238,5 +241,17 @@ static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 					      void *data)
 {
 }
+
+static inline int ioasid_register_notifier_mm(struct mm_struct *mm,
+					      struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_unregister_notifier_mm(struct mm_struct *mm,
+						 struct notifier_block *nb)
+{
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

