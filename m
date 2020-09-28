Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDC27B72D
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgI1VhF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgI1Vgv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28567C0613CE;
        Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so1483365pjh.5;
        Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4Am4rbSCn6s1LkiSoS1FQPjQrgQdxus6zxqbBBGArU=;
        b=BLa1n7jGZg/z/AUQhN1k1olzszjlGtanGPHXCxNRPvd1gwLxEQQE3EeiKA12Gq27x9
         pfkzTNhUWeK9uuZXFNLNsypwqnJXbyrClkTc2gNuacrAxshq+hYNNZZoEKJL8PXdjBQI
         gnp5UkwcdgU252d0esse9WI/D4jqX1yCT+ajbHg1rkQ9fscftyHh2ucis/aRf8TyP+Iu
         clw1O4Jms6UvgXvyxcWlTt0qXWPssWIcWPy+KSil9l7e1rB53dafFf5qN3fMtjtdolsz
         arJhJ+Yokn9KIRMB4FDebkuocwFmWHH3OjWc2qXGe2EPwlI9EzqF0txHvpktDhZabNys
         Arjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4Am4rbSCn6s1LkiSoS1FQPjQrgQdxus6zxqbBBGArU=;
        b=kk3aPq9LvmIy9cXGi0HctVf2UXPphWCSqS2vhYIaCJj54DNers8AtLtCaMmbGSxbyZ
         SuQ+VYDLVpycIJoLhFcSmt3aNqBh+Vv7VaXafJeQ9hs2SSMfRJDn7McCUc7hcOdQhpmf
         EtqslM8iTtfZ8A7kC7MuN+MTeLvohuY5FjGP3MRClYwM60nJpbpg9OV9NEgLtkbBAYU+
         ba6oVvif0kOQzHhTttvdns40wtDmbTjBBAiXDf7ZZ4X0l8yZ+31FVSwFj9jAEjRGz/5m
         /5QOnbZsX6+qzhcJFjwiVsQ2WybotjmTGz8to85tV6dRNjuTVWkEbVLIZAjNkQur5ION
         Sanw==
X-Gm-Message-State: AOAM531q5hDUruVVfDZLfKYyKrjxJM9jcOCWmNvp8n3p7vB+Ds5YYCeL
        A5Tv36Ws4OL/P25j1EYi7rk=
X-Google-Smtp-Source: ABdhPJxD+IuFyRv5MbubVmcGTE/u2MkQTy5kQKm9WQW6pH4E0JT2qRuHJfzZN2fc4ohYKFdfxuqF1g==
X-Received: by 2002:a17:90b:611:: with SMTP id gb17mr1013905pjb.71.1601329010674;
        Mon, 28 Sep 2020 14:36:50 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:50 -0700 (PDT)
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
Subject: [PATCH v3 06/14] iommu/ioasid: Introduce API to adjust the quota of an ioasid_set
Date:   Mon, 28 Sep 2020 14:38:33 -0700
Message-Id: <1601329121-36979-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Each ioasid_set is given a quota during allocation. As system
administrators balance resources among VMs, we shall support the
adjustment of quota at runtime. The new quota cannot be less than the
outstanding IOASIDs already allocated within the set. The extra quota
will be returned to the system-wide IOASID pool if the new quota is
smaller than the existing one.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 61e25c2375ab..cf8c7d34e2de 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -654,6 +654,53 @@ void ioasid_set_put(struct ioasid_set *set)
 EXPORT_SYMBOL_GPL(ioasid_set_put);
 
 /**
+ * ioasid_adjust_set - Adjust the quota of an IOASID set
+ * @set:	IOASID set to be assigned
+ * @quota:	Quota allowed in this set
+ *
+ * Return 0 on success. If the new quota is smaller than the number of
+ * IOASIDs already allocated, -EINVAL will be returned. No change will be
+ * made to the existing quota.
+ */
+int ioasid_adjust_set(struct ioasid_set *set, int quota)
+{
+	int ret = 0;
+
+	if (quota <= 0)
+		return -EINVAL;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (set->nr_ioasids > quota) {
+		pr_err("New quota %d is smaller than outstanding IOASIDs %d\n",
+			quota, set->nr_ioasids);
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+
+	if ((quota > set->quota) &&
+		(quota - set->quota > ioasid_capacity_avail)) {
+		ret = -ENOSPC;
+		goto done_unlock;
+	}
+
+	/* Return the delta back to system pool */
+	ioasid_capacity_avail += set->quota - quota;
+
+	/*
+	 * May have a policy to prevent giving all available IOASIDs
+	 * to one set. But we don't enforce here, it should be in the
+	 * upper layers.
+	 */
+	set->quota = quota;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_adjust_set);
+
+/**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
  * @ioasid: the IOASID to find
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 1ae213b660f0..0a5e82148eb9 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -62,6 +62,7 @@ struct ioasid_allocator_ops {
 void ioasid_install_capacity(ioasid_t total);
 ioasid_t ioasid_get_capacity(void);
 struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type);
+int ioasid_adjust_set(struct ioasid_set *set, int quota);
 void ioasid_set_get(struct ioasid_set *set);
 void ioasid_set_put(struct ioasid_set *set);
 
@@ -99,6 +100,11 @@ static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, i
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline int ioasid_adjust_set(struct ioasid_set *set, int quota)
+{
+	return -ENOTSUPP;
+}
+
 static inline void ioasid_set_put(struct ioasid_set *set)
 {
 }
-- 
2.7.4

