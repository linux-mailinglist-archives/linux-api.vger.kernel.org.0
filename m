Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7273527791E
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 21:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIXTWk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgIXTWi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 15:22:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829BFC0613CE;
        Thu, 24 Sep 2020 12:22:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z18so355455pfg.0;
        Thu, 24 Sep 2020 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1ewdPXd793uzSm94QTwRbEaE1FZR+m0CytxIeckPH0=;
        b=NYLBKp/lp//Zy9sRpI0qJJtKV10QvllXCjlaeB6cVmOf5jz4ID1zpjGaemv/Q3ipUe
         ZIYPtWuGrcFRuhoZdwgChZjC0oIkcsDLPoxe+t7uzPh11YaX5XZD9QHe+IAvHhLntV3/
         ddsHR7qeEDam2vHImgJuUhxZ3JRAsih7LFiClzD9qHVSl4tMnmPXm5H0bDFd3UMQUUep
         gJtK/IOtp+VyRcz9IPYOLFjvv+KmzqjJV72FGTv8nXGkd5VGjkPBQPBQCKb8qlbcSlFT
         Q4qvaM0gNibR8NYxZqWHltLyD8KO3HmACWfZgwJAATII1L3bpwtAcPPbwf6FeWLgeWw8
         rpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B1ewdPXd793uzSm94QTwRbEaE1FZR+m0CytxIeckPH0=;
        b=o68vg6+Ex7xJuT+NKGf7B0rWwLqF+nQ4uTxY0io61VHkeFoucfVvPlcIIISnpfIrID
         zpZ/vq7SPZCmtF7r5udFa7LO68UKlzpbnqAwLZY7Ns5wlJFABglC9sZWZCoJ9dqJGpGr
         Lf9ZMdSC69g532hTrHZ44u3gFG3lSxU1bjvcF3tAoUe+9XI1Z+6WVQuseem6HmmdxnXS
         IBeJ9e/Yx4H/JrJV19cMz8tGNnkXPcNh6n2debwTft+6BBdiXyrwKdecLxLWuCrZNfWh
         R8yuM+Xb7f0U6jKF0EgZqXVeJav7UXoZkNMVkDqmOurFdNcWrole4vB/Evf/FJ08k+03
         sF/A==
X-Gm-Message-State: AOAM531kGBPATQXL0dEXo2Drxgz1TwoWYV4uH71YvzYQkByADA2KKdfg
        zT+Q45NxOYl7Fjp7W9aNc1o=
X-Google-Smtp-Source: ABdhPJxqMAMMzzoyTgqGuq+QTu9wzchurrWf/2kec9HFUnNdDBRgtm2FM5R3zQD7GeDdPLnPxW+Qhg==
X-Received: by 2002:a65:6658:: with SMTP id z24mr465614pgv.367.1600975358005;
        Thu, 24 Sep 2020 12:22:38 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id o15sm140918pgi.74.2020.09.24.12.22.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:22:37 -0700 (PDT)
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
        Yi Sun <yi.y.sun@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH v11 1/6] docs: IOMMU user API
Date:   Thu, 24 Sep 2020 12:24:15 -0700
Message-Id: <1600975460-64521-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

IOMMU UAPI is newly introduced to support communications between guest
virtual IOMMU and host IOMMU. There has been lots of discussions on how
it should work with VFIO UAPI and userspace in general.

This document is intended to clarify the UAPI design and usage. The
mechanics of how future extensions should be achieved are also covered
in this documentation.

Cc: linux-api@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/userspace-api/iommu.rst | 209 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 2 files changed, 210 insertions(+)
 create mode 100644 Documentation/userspace-api/iommu.rst

diff --git a/Documentation/userspace-api/iommu.rst b/Documentation/userspace-api/iommu.rst
new file mode 100644
index 000000000000..d3108c1519d5
--- /dev/null
+++ b/Documentation/userspace-api/iommu.rst
@@ -0,0 +1,209 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. iommu:
+
+=====================================
+IOMMU Userspace API
+=====================================
+
+IOMMU UAPI is used for virtualization cases where communications are
+needed between physical and virtual IOMMU drivers. For baremetal
+usage, the IOMMU is a system device which does not need to communicate
+with userspace directly.
+
+The primary use cases are guest Shared Virtual Address (SVA) and
+guest IO virtual address (IOVA), wherein the vIOMMU implementation
+relies on the physical IOMMU and for this reason requires interactions
+with the host driver.
+
+.. contents:: :local:
+
+Functionalities
+===============
+Communications of user and kernel involve both directions. The
+supported user-kernel APIs are as follows:
+
+1. Bind/Unbind guest PASID (e.g. Intel VT-d)
+2. Bind/Unbind guest PASID table (e.g. ARM SMMU)
+3. Invalidate IOMMU caches upon guest requests
+4. Report errors to the guest and serve page requests
+
+Requirements
+============
+The IOMMU UAPIs are generic and extensible to meet the following
+requirements:
+
+1. Emulated and para-virtualised vIOMMUs
+2. Multiple vendors (Intel VT-d, ARM SMMU, etc.)
+3. Extensions to the UAPI shall not break existing userspace
+
+Interfaces
+==========
+Although the data structures defined in IOMMU UAPI are self-contained,
+there are no user API functions introduced. Instead, IOMMU UAPI is
+designed to work with existing user driver frameworks such as VFIO.
+
+Extension Rules & Precautions
+-----------------------------
+When IOMMU UAPI gets extended, the data structures can *only* be
+modified in two ways:
+
+1. Adding new fields by re-purposing the padding[] field. No size change.
+2. Adding new union members at the end. May increase the structure sizes.
+
+No new fields can be added *after* the variable sized union in that it
+will break backward compatibility when offset moves. A new flag must
+be introduced whenever a change affects the structure using either
+method. The IOMMU driver processes the data based on flags which
+ensures backward compatibility.
+
+Version field is only reserved for the unlikely event of UAPI upgrade
+at its entirety.
+
+It's *always* the caller's responsibility to indicate the size of the
+structure passed by setting argsz appropriately.
+Though at the same time, argsz is user provided data which is not
+trusted. The argsz field allows the user app to indicate how much data
+it is providing; it's still the kernel's responsibility to validate
+whether it's correct and sufficient for the requested operation.
+
+Compatibility Checking
+----------------------
+When IOMMU UAPI extension results in some structure size increase,
+IOMMU UAPI code shall handle the following cases:
+
+1. User and kernel has exact size match
+2. An older user with older kernel header (smaller UAPI size) running on a
+   newer kernel (larger UAPI size)
+3. A newer user with newer kernel header (larger UAPI size) running
+   on an older kernel.
+4. A malicious/misbehaving user passing illegal/invalid size but within
+   range. The data may contain garbage.
+
+Feature Checking
+----------------
+While launching a guest with vIOMMU, it is strongly advised to check
+the compatibility upfront, as some subsequent errors happening during
+vIOMMU operation, such as cache invalidation failures cannot be nicely
+escalated to the guest due to IOMMU specifications. This can lead to
+catastrophic failures for the users.
+
+User applications such as QEMU are expected to import kernel UAPI
+headers. Backward compatibility is supported per feature flags.
+For example, an older QEMU (with older kernel header) can run on newer
+kernel. Newer QEMU (with new kernel header) may refuse to initialize
+on an older kernel if new feature flags are not supported by older
+kernel. Simply recompiling existing code with newer kernel header should
+not be an issue in that only existing flags are used.
+
+IOMMU vendor driver should report the below features to IOMMU UAPI
+consumers (e.g. via VFIO).
+
+1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
+2. IOMMU_NESTING_FEAT_BIND_PGTBL
+3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
+4. IOMMU_NESTING_FEAT_CACHE_INVLD
+5. IOMMU_NESTING_FEAT_PAGE_REQUEST
+
+Take VFIO as example, upon request from VFIO userspace (e.g. QEMU),
+VFIO kernel code shall query IOMMU vendor driver for the support of
+the above features. Query result can then be reported back to the
+userspace caller. Details can be found in
+Documentation/driver-api/vfio.rst.
+
+
+Data Passing Example with VFIO
+------------------------------
+As the ubiquitous userspace driver framework, VFIO is already IOMMU
+aware and shares many key concepts such as device model, group, and
+protection domain. Other user driver frameworks can also be extended
+to support IOMMU UAPI but it is outside the scope of this document.
+
+In this tight-knit VFIO-IOMMU interface, the ultimate consumer of the
+IOMMU UAPI data is the host IOMMU driver. VFIO facilitates user-kernel
+transport, capability checking, security, and life cycle management of
+process address space ID (PASID).
+
+VFIO layer conveys the data structures down to the IOMMU driver. It
+follows the pattern below::
+
+   struct {
+	__u32 argsz;
+	__u32 flags;
+	__u8  data[];
+   };
+
+Here data[] contains the IOMMU UAPI data structures. VFIO has the
+freedom to bundle the data as well as parse data size based on its own flags.
+
+In order to determine the size and feature set of the user data, argsz
+and flags (or the equivalent) are also embedded in the IOMMU UAPI data
+structures.
+
+A "__u32 argsz" field is *always* at the beginning of each structure.
+
+For example:
+::
+
+   struct iommu_cache_invalidate_info {
+	__u32	argsz;
+	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
+	__u32	version;
+	/* IOMMU paging structure cache */
+	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
+	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
+	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
+	#define IOMMU_CACHE_INV_TYPE_NR		(3)
+	__u8	cache;
+	__u8	granularity;
+	__u8	padding[6];
+	union {
+		struct iommu_inv_pasid_info pasid_info;
+		struct iommu_inv_addr_info addr_info;
+	} granu;
+   };
+
+VFIO is responsible for checking its own argsz and flags. It then
+invokes appropriate IOMMU UAPI functions. The user pointers are passed
+to the IOMMU layer for further processing. The responsibilities are
+divided as follows:
+
+- Generic IOMMU layer checks argsz range based on UAPI data in the
+  current kernel version.
+
+- Generic IOMMU layer checks content of the UAPI data for non-zero
+  reserved bits in flags, padding fields, and unsupported version.
+  This is to ensure not breaking userspace in the future when these
+  fields or flags are used.
+
+- Vendor IOMMU driver checks argsz based on vendor flags. UAPI data
+  is consumed based on flags. Vendor driver has access to
+  unadulterated argsz value in case of vendor specific future
+  extensions. Currently, it does not perform the copy_from_user()
+  itself. A __user pointer can be provided in some future scenarios
+  where there's vendor data outside of the structure definition.
+
+IOMMU code treats UAPI data in two categories:
+
+- structure contains vendor data
+  (Example: iommu_uapi_cache_invalidate())
+
+- structure contains only generic data
+  (Example: iommu_uapi_sva_bind_gpasid())
+
+
+
+Sharing UAPI with in-kernel users
+---------------------------------
+For UAPIs that are shared with in-kernel users, a wrapper function is
+provided to distinguish the callers. For example,
+
+Userspace caller ::
+
+  int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
+                                   struct device *dev,
+                                   void __user *udata)
+
+In-kernel caller ::
+
+  int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+                              struct device *dev, ioasid_t ioasid);
diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..00d51eef3d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9125,6 +9125,7 @@ L:	iommu@lists.linux-foundation.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	Documentation/devicetree/bindings/iommu/
+F:	Documentation/userspace-api/iommu.rst
 F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
-- 
2.7.4

