Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9E27B737
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgI1VhG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgI1Vgw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:36:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54872C0613CF;
        Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so2421778pfg.1;
        Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JJmT+wXDNgmHpDjA6Wjx651ekcEY2yxOz6JsHoiTC2s=;
        b=XPHtpj/xAaJjyziV9uUCZbopBjydUsAQm85HbGN9XN242XTj1VTZmgInoTDzMvtpjj
         SO75OlJk1Qqps448QZahHPvBHDaYYTNC3m+f1+7FMcb2upRsU9xA+n3wDJUChaVMv0G8
         tGWUmLpKn10ZWyqw/N2p2nUPjyIskGbVs//ejlAXtyMMAh/h5I4vvVUjOYCWkYgHwybQ
         iWTP5MZk71it+JLkusmAIW+j4u5M/Wh1w3b+D0VVAxl8dkKm0p7Yjlfz5qnm9w23lLjz
         nRYC9cY8T0j+hwpDfsiMWhlXr9sTxf0Q4y0GYzCGmEBBYI1FzoW5VxJRM0vrCjCXCao6
         zc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JJmT+wXDNgmHpDjA6Wjx651ekcEY2yxOz6JsHoiTC2s=;
        b=US4lZ52Z+Oxlu/0bhGn2nTxJTDTqNwPZ8vmLEeZAeozxYUhhItAgjkrpyaOzDJW0R1
         GrGcfQ6QxgQ5BI9/354brYKQ0W4qZn7Do9djYn94Ht747QXcu7If2q8U0n9SRTwLO8lq
         Hu7oOAFwfjNWMWcPbuPLyqK5mRxk3GseFAeeMlRpHcUJotLN6pTSHPJML0oC10ubiLzs
         FZ6xX2SHevP76NcxdvhbLrJUbUD10rTlvB2rqKy5r91yxyGCxp7KICuaP05V5By1M857
         ZGN0XA42OTMIOo6hoK00FDOrsDlkOU3rvk8HqaMouSFvCVZDDFJaGPAQedfoKa7ZgdwS
         xDQg==
X-Gm-Message-State: AOAM530StPrH3OweLgIb5Z+a2ZGtSIP3mI8/5bMXAqTN92YduaORZPfv
        UlPbCyu0D4FL/xS+r0J8W6SEf6uoRNk=
X-Google-Smtp-Source: ABdhPJz2pmATJMgyHqSyYo2SPSRnU2JNB0/L1WajIRXqX0MDjnmGUy7mo2PGrKAkolcH0IWcZPipFg==
X-Received: by 2002:aa7:83d9:0:b029:138:b217:f347 with SMTP id j25-20020aa783d90000b0290138b217f347mr1356862pfn.0.1601329011768;
        Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
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
Subject: [PATCH v3 07/14] iommu/ioasid: Add an iterator API for ioasid_set
Date:   Mon, 28 Sep 2020 14:38:34 -0700
Message-Id: <1601329121-36979-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Users of an ioasid_set may not keep track of all the IOASIDs allocated
under the set. When collective actions are needed for each IOASIDs, it
is useful to iterate over all the IOASIDs within the set. For example,
when the ioasid_set is freed, the user might perform the same cleanup
operation on each IOASID.

This patch adds an API to iterate all the IOASIDs within the set.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 17 +++++++++++++++++
 include/linux/ioasid.h |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index cf8c7d34e2de..9628e78b2ab4 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -701,6 +701,23 @@ int ioasid_adjust_set(struct ioasid_set *set, int quota)
 EXPORT_SYMBOL_GPL(ioasid_adjust_set);
 
 /**
+ * ioasid_set_for_each_ioasid - Iterate over all the IOASIDs within the set
+ *
+ * Caller must hold a reference of the set and handles its own locking.
+ */
+void ioasid_set_for_each_ioasid(struct ioasid_set *set,
+				void (*fn)(ioasid_t id, void *data),
+				void *data)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	xa_for_each(&set->xa, index, entry)
+		fn(index, data);
+}
+EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
+
+/**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
  * @ioasid: the IOASID to find
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 0a5e82148eb9..aab58bc26714 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -75,6 +75,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+				void (*fn)(ioasid_t id, void *data),
+				void *data);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -131,5 +134,11 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 static inline void ioasid_detach_data(ioasid_t ioasid)
 {
 }
+
+static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+					      void (*fn)(ioasid_t id, void *data),
+					      void *data)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

