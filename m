Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC727B732
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgI1VhH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgI1VhF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 17:37:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F7C0613D8;
        Mon, 28 Sep 2020 14:36:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h23so337488pjv.5;
        Mon, 28 Sep 2020 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6l6hKSmY3TpoEATBMM/LapAftYRk779XqE24cBia0y0=;
        b=bEPobjZ4DsVmnkD/yvBrB3YsKi8EBvuTvq5iOsiKzT502lySqurkXuu25fn5VcyGoz
         Ifd2WQbnnkC6Zu+FBJkqjbAPbbsuJ8fFUFa+IoiBMivvM5SbKWIf0Y4r1tlc/MT8KrGy
         K3VwL+G5aVYucyJbpQ9UcAf6d7nKYtCu8b4Fkrlal09swQj+YAAnM2Hp3JrtjO+Mv9/e
         BSUxIReu8bTwYpv2lKARoRSspBAH/IblZTnEqIfiltFh6Zfx/keqXjylwcZDeCY67Hdb
         PnvLFALyI5IfVhjtKt/14jApbcMV45GOyPu6CfV+AY3MHFgaZDonKokrWJueqN5J+i/y
         sQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6l6hKSmY3TpoEATBMM/LapAftYRk779XqE24cBia0y0=;
        b=jzP/RLNdlygm7SjZiygzc4Hr+12wL8j2i+UNRqP4AVdpDnHjk+GSB1b1Mn7a1m26/Q
         wVc/5MzjZhx5BBE/3nkUEhETg+8WJFODiWJVSMW1JWrCDL7NHkZPC9ampfcpbxttGL5e
         lLjtHkSFvBKjA5wSDrVPMfGP5bWuBLWk86EdCKELt1S9IrSbgrDaOFjhxTQeAQfVtAk4
         PNMVrmH23oQbYaxIiLPWZrjCqhWJ54eh0uTICXEcnRdPbIF3xw1HIrwAPTf4KTgdI6sP
         8RRp5C82b1WWzkueW/zdJpWvZbi19hRz2/yKhj4h0Ut7+FjCW7I4WEFqTBSKdyrCNRSQ
         W+XA==
X-Gm-Message-State: AOAM532BU30ffZcdIJjGX3XlklHsgld/lvYKj2kD00yOn1eZrvzt6e5S
        7WTNljgNVYZRMPiKdGoOWSA=
X-Google-Smtp-Source: ABdhPJz92L8+8E+kFywU9N5aOFhYEwv4F+POgIOP/ZuQa6bkCsajxBmrEBosufsPcnIY0lR4NLycpA==
X-Received: by 2002:a17:90a:ed88:: with SMTP id k8mr1008318pjy.232.1601329019072;
        Mon, 28 Sep 2020 14:36:59 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 14:36:58 -0700 (PDT)
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
Subject: [PATCH v3 14/14] iommu/vt-d: Store guest PASID during bind
Date:   Mon, 28 Sep 2020 14:38:41 -0700
Message-Id: <1601329121-36979-15-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOASID core maintains the guest-host mapping in the form of SPID and
IOASID. This patch assigns the guest PASID (if valid) as SPID while
binding guest page table with a host PASID. This mapping will be used
for lookup and notifications.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8f886718df83..e18f8b5af9ba 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -98,6 +98,7 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 static inline void intel_svm_drop_pasid(ioasid_t pasid)
 {
 	ioasid_detach_data(pasid);
+	ioasid_detach_spid(pasid);
 	ioasid_put(NULL, pasid);
 }
 
@@ -425,6 +426,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		if (data->flags & IOMMU_SVA_GPASID_VAL) {
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
+			ioasid_attach_spid(data->hpasid, data->gpasid);
 		}
 		ioasid_attach_data(data->hpasid, svm);
 		ioasid_get(NULL, svm->pasid);
-- 
2.7.4

