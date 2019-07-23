Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1588A710E5
	for <lists+linux-api@lfdr.de>; Tue, 23 Jul 2019 07:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbfGWFKU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jul 2019 01:10:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:1868 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfGWFKU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 23 Jul 2019 01:10:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 22:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,297,1559545200"; 
   d="scan'208";a="196992413"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2019 22:10:17 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 12/12] Documentation: fpga: dfl: add descriptions for virtualization and new interfaces.
Date:   Tue, 23 Jul 2019 12:51:35 +0800
Message-Id: <1563857495-26692-13-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch adds virtualization support description for DFL based
FPGA devices (based on PCIe SRIOV), and introductions to new
interfaces added by new dfl private feature drivers.

[mdf@kernel.org: Fixed up to make it work with new reStructuredText docs]
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 Documentation/fpga/dfl.rst | 105 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 2f125ab..6fa483f 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -87,6 +87,8 @@ The following functions are exposed through ioctls:
 - Get driver API version (DFL_FPGA_GET_API_VERSION)
 - Check for extensions (DFL_FPGA_CHECK_EXTENSION)
 - Program bitstream (DFL_FPGA_FME_PORT_PR)
+- Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
+- Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -102,6 +104,10 @@ More functions are exposed through sysfs
      one FPGA device may have more than one port, this sysfs interface indicates
      how many ports the FPGA device has.
 
+ Global error reporting management (errors/)
+     error reporting sysfs interfaces allow user to read errors detected by the
+     hardware, and clear the logged errors.
+
 
 FIU - PORT
 ==========
@@ -143,6 +149,10 @@ More functions are exposed through sysfs:
  Read Accelerator GUID (afu_id)
      afu_id indicates which PR bitstream is programmed to this AFU.
 
+ Error reporting (errors/)
+     error reporting sysfs interfaces allow user to read port/afu errors
+     detected by the hardware, and clear the logged errors.
+
 
 DFL Framework Overview
 ======================
@@ -218,6 +228,101 @@ the compat_id exposed by the target FPGA region. This check is usually done by
 userspace before calling the reconfiguration IOCTL.
 
 
+FPGA virtualization - PCIe SRIOV
+================================
+This section describes the virtualization support on DFL based FPGA device to
+enable accessing an accelerator from applications running in a virtual machine
+(VM). This section only describes the PCIe based FPGA device with SRIOV support.
+
+Features supported by the particular FPGA device are exposed through Device
+Feature Lists, as illustrated below:
+
+::
+
+    +-------------------------------+  +-------------+
+    |              PF               |  |     VF      |
+    +-------------------------------+  +-------------+
+        ^            ^         ^              ^
+        |            |         |              |
+  +-----|------------|---------|--------------|-------+
+  |     |            |         |              |       |
+  |  +-----+     +-------+ +-------+      +-------+   |
+  |  | FME |     | Port0 | | Port1 |      | Port2 |   |
+  |  +-----+     +-------+ +-------+      +-------+   |
+  |                  ^         ^              ^       |
+  |                  |         |              |       |
+  |              +-------+ +------+       +-------+   |
+  |              |  AFU  | |  AFU |       |  AFU  |   |
+  |              +-------+ +------+       +-------+   |
+  |                                                   |
+  |            DFL based FPGA PCIe Device             |
+  +---------------------------------------------------+
+
+FME is always accessed through the physical function (PF).
+
+Ports (and related AFUs) are accessed via PF by default, but could be exposed
+through virtual function (VF) devices via PCIe SRIOV. Each VF only contains
+1 Port and 1 AFU for isolation. Users could assign individual VFs (accelerators)
+created via PCIe SRIOV interface, to virtual machines.
+
+The driver organization in virtualization case is illustrated below:
+::
+
+    +-------++------++------+             |
+    | FME   || FME  || FME  |             |
+    | FPGA  || FPGA || FPGA |             |
+    |Manager||Bridge||Region|             |
+    +-------++------++------+             |
+    +-----------------------+  +--------+ |             +--------+
+    |          FME          |  |  AFU   | |             |  AFU   |
+    |         Module        |  | Module | |             | Module |
+    +-----------------------+  +--------+ |             +--------+
+          +-----------------------+       |       +-----------------------+
+          | FPGA Container Device |       |       | FPGA Container Device |
+          |  (FPGA Base Region)   |       |       |  (FPGA Base Region)   |
+          +-----------------------+       |       +-----------------------+
+            +------------------+          |         +------------------+
+            | FPGA PCIE Module |          | Virtual | FPGA PCIE Module |
+            +------------------+   Host   | Machine +------------------+
+   -------------------------------------- | ------------------------------
+             +---------------+            |          +---------------+
+             | PCI PF Device |            |          | PCI VF Device |
+             +---------------+            |          +---------------+
+
+FPGA PCIe device driver is always loaded first once a FPGA PCIe PF or VF device
+is detected. It:
+
+* Finishes enumeration on both FPGA PCIe PF and VF device using common
+  interfaces from DFL framework.
+* Supports SRIOV.
+
+The FME device driver plays a management role in this driver architecture, it
+provides ioctls to release Port from PF and assign Port to PF. After release
+a port from PF, then it's safe to expose this port through a VF via PCIe SRIOV
+sysfs interface.
+
+To enable accessing an accelerator from applications running in a VM, the
+respective AFU's port needs to be assigned to a VF using the following steps:
+
+#. The PF owns all AFU ports by default. Any port that needs to be
+   reassigned to a VF must first be released through the
+   DFL_FPGA_FME_PORT_RELEASE ioctl on the FME device.
+
+#. Once N ports are released from PF, then user can use command below
+   to enable SRIOV and VFs. Each VF owns only one Port with AFU.
+
+   ::
+
+      echo N > $PCI_DEVICE_PATH/sriov_numvfs
+
+#. Pass through the VFs to VMs
+
+#. The AFU under VF is accessible from applications in VM (using the
+   same driver inside the VF).
+
+Note that an FME can't be assigned to a VF, thus PR and other management
+functions are only available via the PF.
+
 Device enumeration
 ==================
 This section introduces how applications enumerate the fpga device from
-- 
1.8.3.1

