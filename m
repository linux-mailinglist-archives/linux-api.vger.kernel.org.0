Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B82372D51
	for <lists+linux-api@lfdr.de>; Tue,  4 May 2021 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhEDPxL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 May 2021 11:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhEDPxK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 May 2021 11:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620143535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+a+ZchBSphuAXQvcuIUOn9Rh82lP2Y2KDctoB7uZ/q8=;
        b=iIwrKLcvqi4UuU2BSzWG5/Zjb42BQEjXGjh/tkqLH47/pCQt708Op/ZbijuE2PhISECEmi
        fnJjy7mcOuWyL4SNkSoBbwzThc2I+t/jX0FowURqZIjuTFyAHPSYNenxAE3G10zcCUn9IN
        VXXQUaclyMauCUxogpp24l/aPLEtM+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-NU7xVnh-M1OmVkmm_ha7eA-1; Tue, 04 May 2021 11:52:11 -0400
X-MC-Unique: NU7xVnh-M1OmVkmm_ha7eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD041074640;
        Tue,  4 May 2021 15:52:10 +0000 (UTC)
Received: from [172.30.42.188] (ovpn-113-225.phx2.redhat.com [10.3.113.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0064C60C0F;
        Tue,  4 May 2021 15:52:02 +0000 (UTC)
Subject: [PATCH] vfio/pci: Revert nvlink removal uAPI breakage
From:   Alex Williamson <alex.williamson@redhat.com>
To:     kvm@vger.kernel.org, groug@kaod.org, hch@lst.de,
        gregkh@linuxfoundation.org, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, linuxppc-dev@lists.ozlabs.org,
        qemu-ppc@nongnu.org
Date:   Tue, 04 May 2021 09:52:02 -0600
Message-ID: <162014341432.3807030.11054087109120670135.stgit@omen>
User-Agent: StGit/1.0-8-g6af9-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Revert the uAPI changes from the below commit with notice that these
regions and capabilities are no longer provided.

Fixes: b392a1989170 ("vfio/pci: remove vfio_pci_nvlink2")
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Greg (Kurz), please double check this resolves the issue.  Thanks!

 include/uapi/linux/vfio.h |   46 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 34b1f53a3901..ef33ea002b0b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -333,10 +333,21 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
 /* 10de vendor PCI sub-types */
-/* subtype 1 was VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM, don't use */
+/*
+ * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address space.
+ *
+ * Deprecated, region no longer provided
+ */
+#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
 
 /* 1014 vendor PCI sub-types */
-/* subtype 1 was VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD, don't use */
+/*
+ * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
+ * to do TLB invalidation on a GPU.
+ *
+ * Deprecated, region no longer provided
+ */
+#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
@@ -630,9 +641,36 @@ struct vfio_device_migration_info {
  */
 #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
 
-/* subtype 4 was VFIO_REGION_INFO_CAP_NVLINK2_SSATGT, don't use */
+/*
+ * Capability with compressed real address (aka SSA - small system address)
+ * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing
+ * and by the userspace to associate a NVLink bridge with a GPU.
+ *
+ * Deprecated, capability no longer provided
+ */
+#define VFIO_REGION_INFO_CAP_NVLINK2_SSATGT	4
+
+struct vfio_region_info_cap_nvlink2_ssatgt {
+	struct vfio_info_cap_header header;
+	__u64 tgt;
+};
 
-/* subtype 5 was VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD, don't use */
+/*
+ * Capability with an NVLink link speed. The value is read by
+ * the NVlink2 bridge driver from the bridge's "ibm,nvlink-speed"
+ * property in the device tree. The value is fixed in the hardware
+ * and failing to provide the correct value results in the link
+ * not working with no indication from the driver why.
+ *
+ * Deprecated, capability no longer provided
+ */
+#define VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD	5
+
+struct vfio_region_info_cap_nvlink2_lnkspd {
+	struct vfio_info_cap_header header;
+	__u32 link_speed;
+	__u32 __pad;
+};
 
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,


