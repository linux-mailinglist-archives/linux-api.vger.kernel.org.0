Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545EA3259E3
	for <lists+linux-api@lfdr.de>; Thu, 25 Feb 2021 23:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBYWyI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Feb 2021 17:54:08 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:26370 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229491AbhBYWyG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Feb 2021 17:54:06 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610377200"; 
   d="scan'208";a="73172359"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2021 07:53:07 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3F666400C73A;
        Fri, 26 Feb 2021 07:53:04 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Dirk Behme <Dirk.Behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Subject: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
Date:   Thu, 25 Feb 2021 22:51:43 +0000
Message-Id: <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Document bindings for R-Car DAB hardware accelerator, currently
found on the r8a77990 SoC (a.k.a. R-Car E3) and on the r8a77965
SoC (a.k.a. R-Car M3-N).

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../devicetree/bindings/misc/renesas,dab.yaml | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/renesas,dab.yaml

diff --git a/Documentation/devicetree/bindings/misc/renesas,dab.yaml b/Documentation/devicetree/bindings/misc/renesas,dab.yaml
new file mode 100644
index 000000000000..e9494add13d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/renesas,dab.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Renesas Electronics Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/renesas,dab.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car DAB Hardware Accelerator
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+description:
+  The DAB hardware accelerator found on some R-Car devices is a hardware
+  accelerator for software DAB demodulators.
+  It consists of one FFT (Fast Fourier Transform) module and one decoder module,
+  compatible with DAB specification (ETSI EN 300 401 and ETSI TS 102 563).
+  The decoder module can perform FIC decoding and MSC decoding processing from
+  de-puncture to final decoded result.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,dab-r8a77965     # R-Car M3-N
+          - renesas,dab-r8a77990     # R-Car E3
+      - const: renesas,rcar-gen3-dab # Generic fallback for R-Car Gen3 devices
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: dab
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+additionalProperties: false
+
+examples:
+  # R8A77990 (R-Car E3)
+  - |
+    #include <dt-bindings/clock/r8a77990-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a77990-sysc.h>
+
+    dab: dab@e6730000 {
+        compatible = "renesas,dab-r8a77990",
+                     "renesas,rcar-gen3-dab";
+        reg = <0xe6730000 0x120>;
+        interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 1016>;
+        clock-names = "dab";
+        power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+        resets = <&cpg 1016>;
+        status = "disabled";
+    };
-- 
2.25.1

