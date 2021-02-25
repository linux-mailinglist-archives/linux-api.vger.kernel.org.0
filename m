Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B753259EF
	for <lists+linux-api@lfdr.de>; Thu, 25 Feb 2021 23:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhBYWys (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Feb 2021 17:54:48 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:45423 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232748AbhBYWyo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Feb 2021 17:54:44 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610377200"; 
   d="scan'208";a="73418621"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Feb 2021 07:53:25 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B27D140083F0;
        Fri, 26 Feb 2021 07:53:21 +0900 (JST)
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
Subject: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
Date:   Thu, 25 Feb 2021 22:51:46 +0000
Message-Id: <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

R-Car M3-N (a.k.a. r8a77965) comes with the DAB hardware accelerator.
This patch adds SoC specific support.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 657b20d3533b..b6176fd5b703 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -1013,6 +1013,18 @@ ipmmu_vp0: iommu@fe990000 {
 			#iommu-cells = <1>;
 		};
 
+		dab: dab@e6730000 {
+			compatible = "renesas,dab-r8a77965",
+				     "renesas,rcar-gen3-dab";
+			reg = <0x00 0xe6730000 0x00 0x120>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1016>;
+			clock-names = "dab";
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 1016>;
+			status = "disabled";
+		};
+
 		avb: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a77965",
 				     "renesas,etheravb-rcar-gen3";
-- 
2.25.1

