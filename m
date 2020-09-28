Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0853227B741
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgI1Vh1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgI1VhH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:37:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3DFC0613D6;
        Mon, 28 Sep 2020 14:36:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so2042999pgm.11;
        Mon, 28 Sep 2020 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d1FfSiT0/rNuXhBVREG/yc6QeqXaZmsaJ55ClmMPrSA=;
        b=r0TFUtTL36ac2nmkkmqUvShag9p4Nr90dTd1zKFHpK0u06RB7xzvc10y/8rI43dRe9
         aL92VrM5u5jZPGZTrUTvzcCbWgiyP4IcC96N052t63wUVxyrF/jZ7TDILYSXdKRmmr/L
         GEX41iDNcl+PjkT7LI/2yZK1HVJ83WPCUcOeUtUuwd0GNCVro3zwgXgxmi1qwlKttoCR
         xNC42K+M5nDlIwHkyZA8/Hmp646Gumsdrwn+oVp4UOzedPc3hrLGGIUYuRmBnUsuzTZq
         hNy82OUKOWV1dcv//ylXy4FULe24ZdrYw95f9PDvCipj1BN+xc/Ip+xKPrBsIAtdMh0j
         I18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d1FfSiT0/rNuXhBVREG/yc6QeqXaZmsaJ55ClmMPrSA=;
        b=cRzV0EkkCdEyvx5+2KazepHNz3NBeHwWGn9HjF6HQDf/6c+OTa3zyfxO81928lPKxv
         1vGwdDqfueDU+OAFY/5Vynnaan49wHM/OKPL83EsCsyZHjznpptY3wLGSumhD5I1BT/u
         /JzcWbxchnGFHnVLfjyyACZZX0mqZu4iBGBv3AsDiPVd4hjvdBXyeyh10cJdaLDIIkEq
         cp6JZ6H09XUnUin2AgCWM8TfM1u5rJ1i1aYUtuRCTMbDBEpA4shtYK22vi7Wxe+MuE7R
         p9LuhaGcY8yEbQZsteLmUusXeSEvWKoqqZAPENtF9Dn7e9MAVa4ovid4HMrjEAIjjsPA
         1SXA==
X-Gm-Message-State: AOAM533BUzXPVvjsz94tKlxCgBGOB4v0rP7Na/B+A3vThYlg6LEre4M/
        K1fzfaecxXWxqnbE+4HJJtI=
X-Google-Smtp-Source: ABdhPJwj+5XtiJEtx58cHwj9dKNKedPMVVg0ZTMpDicVIRoVL1W2IJBC4s9o5U0euw0uP7XZGvRA0g==
X-Received: by 2002:a65:410c:: with SMTP id w12mr756685pgp.411.1601329017069;
        Mon, 28 Sep 2020 14:36:57 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:56 -0700 (PDT)
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
Subject: [PATCH v3 12/14] iommu/vt-d: Remove mm reference for guest SVA
Date:   Mon, 28 Sep 2020 14:38:39 -0700
Message-Id: <1601329121-36979-13-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Now that IOASID core keeps track of the IOASID to mm_struct ownership in
the forms of ioasid_set with IOASID_SET_TYPE_MM token type, there is no
need to keep the same mapping in VT-d driver specific data. Native SVM
usage is not affected by the change.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2e764e283469..39a09a93300e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -338,12 +338,6 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			ret = -ENOMEM;
 			goto out;
 		}
-		/* REVISIT: upper layer/VFIO can track host process that bind
-		 * the PASID. ioasid_set = mm might be sufficient for vfio to
-		 * check pasid VMM ownership. We can drop the following line
-		 * once VFIO and IOASID set check is in place.
-		 */
-		svm->mm = get_task_mm(current);
 		svm->pasid = data->hpasid;
 		if (data->flags & IOMMU_SVA_GPASID_VAL) {
 			svm->gpasid = data->gpasid;
@@ -351,7 +345,6 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		}
 		ioasid_attach_data(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
-		mmput(svm->mm);
 	}
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
 	if (!sdev) {
-- 
2.7.4

