Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781527B733
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgI1VhI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgI1VhF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:37:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3CC0613D4;
        Mon, 28 Sep 2020 14:36:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so2403799pfd.5;
        Mon, 28 Sep 2020 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skpapxtmeJ/cYq/K8imoktpdIvqrK6X5zzz1uYJGL14=;
        b=rturQUDAJ1hdL8TxJHjJ6hhzoUvnbjCpO4UULkaJpxorWGPz4uKZPpWSt9o8/h6gFO
         l82BK4XS8iD7vaMgWmV+R8DrHxLnCopppPFwf0VA3IjV9FKf8KWdwdJdV8Pq9ErUuF7I
         LpnCVPWFFrENYPCn4gbxht2x924VSuAmbAPB4DRIUVlYT6swDKSKobckT2HrF5Cm+gbi
         6k3jUACx7jlea8VZre2ebmg0rSlO3QEzKSNLKyNWybk5px6UQCL41BwkWb7BzgQcLwHa
         +T5eNLGbJx7UOfyAm49yNeHFbRXQBJ/E/Nxe4TrzNludY9yjNzCle4VM3LnPfjZSWzyR
         myfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skpapxtmeJ/cYq/K8imoktpdIvqrK6X5zzz1uYJGL14=;
        b=W6osDQ56Ffk/oX6eLQXRkqiqxb/Ain6jVOzEHoMZVCH+UkmUt5t5aKB8qzqRG3jwmh
         iDXf/CbYkvjoRsjMa5Sc4e+Vz1X8ApkekQE4rHM/n7Spkr3fRtf8xExV0MsEYah9dR4c
         l++vuxTBPHtXWpr0dLoQIbNOwFaWOGvMuRQxPIKTGrU100uoBQT6AzOqQjl+0PPV/Z1A
         ntWDgyA/tXMpbg5McWPB5ndE1SMrlx7sHxMVO9wM6Q63+Tt8zvbFOFPI4kdGdDokkTta
         SQP/16S5lOgJkdd6AanZ5uKkP+NQI8nGHKWzulGTXJi0y8XfXatVVRJdLxQjj5fmRvCQ
         TfQQ==
X-Gm-Message-State: AOAM532lJRVuLNkfge+kYyBv9VqALto625WZF/3XVHtIDMS+/BOaYk5t
        JR6A+968V7o52//xBHgVWyA=
X-Google-Smtp-Source: ABdhPJzFkWZu4V5KCd9j9uLQCwDJ40hP5WkAZHyBS9tHwwM0CQUfeN4sssthRjRDsahHF5GTHe7oNw==
X-Received: by 2002:a63:ff07:: with SMTP id k7mr775065pgi.39.1601329015015;
        Mon, 28 Sep 2020 14:36:55 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:54 -0700 (PDT)
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
Subject: [PATCH v3 10/14] iommu/ioasid: Introduce notification APIs
Date:   Mon, 28 Sep 2020 14:38:37 -0700
Message-Id: <1601329121-36979-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Relations among IOASID users largely follow a publisher-subscriber
pattern. E.g. to support guest SVA on Intel Scalable I/O Virtualization
(SIOV) enabled platforms, VFIO, IOMMU, device drivers, KVM are all users
of IOASIDs. When a state change occurs, VFIO publishes the change event
that needs to be processed by other users/subscribers.

This patch introduced two types of notifications: global and per
ioasid_set. The latter is intended for users who only needs to handle
events related to the IOASID of a given set.
For more information, refer to the kernel documentation at
Documentation/ioasid.rst.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  57 +++++++++++++++++++-
 2 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 378fef8f23d9..894b17c06ead 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -10,12 +10,35 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
+/*
+ * An IOASID can have multiple consumers where each consumer may have
+ * hardware contexts associated with the IOASID.
+ * When a status change occurs, like on IOASID deallocation, notifier chains
+ * are used to keep the consumers in sync.
+ * This is a publisher-subscriber pattern where publisher can change the
+ * state of each IOASID, e.g. alloc/free, bind IOASID to a device and mm.
+ * On the other hand, subscribers get notified for the state change and
+ * keep local states in sync.
+ */
+static ATOMIC_NOTIFIER_HEAD(ioasid_notifier);
+/* List to hold pending notification block registrations */
+static LIST_HEAD(ioasid_nb_pending_list);
+static DEFINE_SPINLOCK(ioasid_nb_lock);
+
 /* Default to PCIe standard 20 bit PASID */
 #define PCI_PASID_MAX 0x100000
 static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
 
+struct ioasid_set_nb {
+	struct list_head	list;
+	struct notifier_block	*nb;
+	void			*token;
+	struct ioasid_set	*set;
+	bool			active;
+};
+
 enum ioasid_state {
 	IOASID_STATE_INACTIVE,
 	IOASID_STATE_ACTIVE,
@@ -365,6 +388,42 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+/**
+ * ioasid_notify - Send notification on a given IOASID for status change.
+ *
+ * @data:	The IOASID data to which the notification will send
+ * @cmd:	Notification event sent by IOASID external users, can be
+ *		IOASID_BIND or IOASID_UNBIND.
+ *
+ * @flags:	Special instructions, e.g. notify within a set or global by
+ *		IOASID_NOTIFY_FLAG_SET or IOASID_NOTIFY_FLAG_ALL flags
+ * Caller must hold ioasid_allocator_lock and reference to the IOASID
+ */
+static int ioasid_notify(struct ioasid_data *data,
+			 enum ioasid_notify_val cmd, unsigned int flags)
+{
+	struct ioasid_nb_args args = { 0 };
+	int ret = 0;
+
+	/* IOASID_FREE/ALLOC are internal events emitted by IOASID core only */
+	if (cmd <= IOASID_NOTIFY_FREE)
+		return -EINVAL;
+
+	if (flags & ~(IOASID_NOTIFY_FLAG_ALL | IOASID_NOTIFY_FLAG_SET))
+		return -EINVAL;
+
+	args.id = data->id;
+	args.set = data->set;
+	args.pdata = data->private;
+	args.spid = data->spid;
+	if (flags & IOASID_NOTIFY_FLAG_ALL)
+		ret = atomic_notifier_call_chain(&ioasid_notifier, cmd, &args);
+	if (flags & IOASID_NOTIFY_FLAG_SET)
+		ret = atomic_notifier_call_chain(&data->set->nh, cmd, &args);
+
+	return ret;
+}
+
 static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid)
 {
 	ioasid_t ioasid = INVALID_IOASID;
@@ -417,6 +476,7 @@ int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
 		goto done_unlock;
 	}
 	data->spid = spid;
+	ioasid_notify(data, IOASID_NOTIFY_BIND, IOASID_NOTIFY_FLAG_SET);
 
 done_unlock:
 	spin_unlock(&ioasid_allocator_lock);
@@ -436,6 +496,7 @@ void ioasid_detach_spid(ioasid_t ioasid)
 		goto done_unlock;
 	}
 	data->spid = INVALID_IOASID;
+	ioasid_notify(data, IOASID_NOTIFY_UNBIND, IOASID_NOTIFY_FLAG_SET);
 
 done_unlock:
 	spin_unlock(&ioasid_allocator_lock);
@@ -469,6 +530,28 @@ static inline bool ioasid_set_is_valid(struct ioasid_set *set)
 	return xa_load(&ioasid_sets, set->id) == set;
 }
 
+static void ioasid_add_pending_nb(struct ioasid_set *set)
+{
+	struct ioasid_set_nb *curr;
+
+	if (set->type != IOASID_SET_TYPE_MM)
+		return;
+
+	/*
+	 * Check if there are any pending nb requests for the given token, if so
+	 * add them to the notifier chain.
+	 */
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == set->token && !curr->active) {
+			atomic_notifier_chain_register(&set->nh, curr->nb);
+			curr->set = set;
+			curr->active = true;
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+}
+
 /**
  * ioasid_set_alloc - Allocate a new IOASID set for a given token
  *
@@ -556,6 +639,13 @@ struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
 	set->quota = quota;
 	set->id = id;
 	refcount_set(&set->ref, 1);
+	ATOMIC_INIT_NOTIFIER_HEAD(&set->nh);
+
+	/*
+	 * Check if there are any pending nb requests for the given token, if so
+	 * add them to the notifier chain.
+	 */
+	ioasid_add_pending_nb(set);
 
 	/*
 	 * Per set XA is used to store private IDs within the set, get ready
@@ -641,6 +731,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	set->nr_ioasids++;
+	ioasid_notify(data, IOASID_NOTIFY_ALLOC, IOASID_NOTIFY_FLAG_SET);
 	goto done_unlock;
 exit_free:
 	kfree(data);
@@ -687,6 +778,8 @@ static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
 		return;
 
 	data->state = IOASID_STATE_FREE_PENDING;
+	ioasid_notify(data, IOASID_NOTIFY_FREE,
+		      IOASID_NOTIFY_FLAG_ALL | IOASID_NOTIFY_FLAG_ALL);
 	if (!refcount_dec_and_test(&data->users))
 		return;
 
@@ -726,6 +819,7 @@ EXPORT_SYMBOL_GPL(ioasid_set_get);
 
 static void ioasid_set_put_locked(struct ioasid_set *set)
 {
+	struct ioasid_set_nb *curr;
 	struct ioasid_data *entry;
 	unsigned long index;
 
@@ -757,6 +851,16 @@ static void ioasid_set_put_locked(struct ioasid_set *set)
 	/* Return the quota back to system pool */
 	ioasid_capacity_avail += set->quota;
 
+	/* Restore pending status of the set NBs */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == set->token) {
+			if (curr->active)
+				curr->active = false;
+			else
+				pr_warn("Set token exists but not active!\n");
+		}
+	}
+
 	/*
 	 * Token got released right away after the ioasid_set is freed.
 	 * If a new set is created immediately with the newly released token,
@@ -778,7 +882,9 @@ static void ioasid_set_put_locked(struct ioasid_set *set)
 void ioasid_set_put(struct ioasid_set *set)
 {
 	spin_lock(&ioasid_allocator_lock);
+	spin_lock(&ioasid_nb_lock);
 	ioasid_set_put_locked(set);
+	spin_unlock(&ioasid_nb_lock);
 	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_set_put);
@@ -980,6 +1086,41 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 }
 EXPORT_SYMBOL_GPL(ioasid_find);
 
+int ioasid_register_notifier(struct ioasid_set *set, struct notifier_block *nb)
+{
+	if (set)
+		return atomic_notifier_chain_register(&set->nh, nb);
+	else
+		return atomic_notifier_chain_register(&ioasid_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_register_notifier);
+
+void ioasid_unregister_notifier(struct ioasid_set *set,
+				struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+
+	spin_lock(&ioasid_nb_lock);
+	/*
+	 * Pending list is registered with a token without an ioasid_set,
+	 * therefore should not be unregistered directly.
+	 */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->nb == nb) {
+			pr_warn("Cannot unregister NB from pending list\n");
+			spin_unlock(&ioasid_nb_lock);
+			return;
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+
+	if (set)
+		atomic_notifier_chain_unregister(&set->nh, nb);
+	else
+		atomic_notifier_chain_unregister(&ioasid_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 2dfe85e6cb7e..1b551c99d568 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -23,6 +23,7 @@ enum ioasid_set_type {
 
 /**
  * struct ioasid_set - Meta data about ioasid_set
+ * @nh:		List of notifiers private to that set
  * @xa:		XArray to store ioasid_set private IDs, can be used for
  *		guest-host IOASID mapping, or just a private IOASID namespace.
  * @token:	Unique to identify an IOASID set
@@ -33,6 +34,7 @@ enum ioasid_set_type {
  * @ref:	Reference count of the users
  */
 struct ioasid_set {
+	struct atomic_notifier_head nh;
 	struct xarray xa;
 	void *token;
 	int type;
@@ -58,6 +60,47 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
+/* Notification data when IOASID status changed */
+enum ioasid_notify_val {
+	IOASID_NOTIFY_ALLOC = 1,
+	IOASID_NOTIFY_FREE,
+	IOASID_NOTIFY_BIND,
+	IOASID_NOTIFY_UNBIND,
+};
+
+#define IOASID_NOTIFY_FLAG_ALL BIT(0)
+#define IOASID_NOTIFY_FLAG_SET BIT(1)
+/**
+ * enum ioasid_notifier_prios - IOASID event notification order
+ *
+ * When status of an IOASID changes, users might need to take actions to
+ * reflect the new state. For example, when an IOASID is freed due to
+ * exception, the hardware context in virtual CPU, DMA device, and IOMMU
+ * shall be cleared and drained. Order is required to prevent life cycle
+ * problems.
+ */
+enum ioasid_notifier_prios {
+	IOASID_PRIO_LAST,
+	IOASID_PRIO_DEVICE,
+	IOASID_PRIO_IOMMU,
+	IOASID_PRIO_CPU,
+};
+
+/**
+ * struct ioasid_nb_args - Argument provided by IOASID core when notifier
+ * is called.
+ * @id:		The IOASID being notified
+ * @spid:	The set private ID associated with the IOASID
+ * @set:	The IOASID set of @id
+ * @pdata:	The private data attached to the IOASID
+ */
+struct ioasid_nb_args {
+	ioasid_t id;
+	ioasid_t spid;
+	struct ioasid_set *set;
+	void *pdata;
+};
+
 #if IS_ENABLED(CONFIG_IOASID)
 void ioasid_install_capacity(ioasid_t total);
 ioasid_t ioasid_get_capacity(void);
@@ -82,7 +125,10 @@ void ioasid_detach_data(ioasid_t ioasid);
 int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
 void ioasid_detach_spid(ioasid_t ioasid);
 ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
-
+int ioasid_register_notifier(struct ioasid_set *set,
+			struct notifier_block *nb);
+void ioasid_unregister_notifier(struct ioasid_set *set,
+				struct notifier_block *nb);
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
@@ -145,6 +191,15 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*
 	return NULL;
 }
 
+static inline int ioasid_register_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_unregister_notifier(struct notifier_block *nb)
+{
+}
+
 static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
 {
 	return -ENOTSUPP;
-- 
2.7.4

