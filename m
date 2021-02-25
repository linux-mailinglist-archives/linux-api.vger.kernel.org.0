Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44803259D6
	for <lists+linux-api@lfdr.de>; Thu, 25 Feb 2021 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBYWxf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Feb 2021 17:53:35 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:7678 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229966AbhBYWxf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Feb 2021 17:53:35 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610377200"; 
   d="scan'208";a="73172325"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Feb 2021 07:52:42 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0DCB64002643;
        Fri, 26 Feb 2021 07:52:38 +0900 (JST)
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
Subject: [PATCH 0/7] Add FFT Support for R-Car Gen3 devices
Date:   Thu, 25 Feb 2021 22:51:40 +0000
Message-Id: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The DAB hardware accelerator found on R-Car E3 (a.k.a. r8a77990)
and R-Car M3-N (a.k.a. r8a77965) devices is a hardware accelerator
for software DAB demodulators.
It consists of one FFT (Fast Fourier Transform) module and one
decoder module, compatible with DAB specification (ETSI EN 300 401
and ETSI TS 102 563).
The decoder module can perform FIC decoding and MSC decoding
processing from de-puncture to final decoded result.

This series adds FFT support only for R-Car E3 and R-Car M3-N,
FIC and MSC support will be added later on.

Thanks,
Fab

Fabrizio Castro (7):
  clk: renesas: r8a77990: Add DAB clock
  clk: renesas: r8a77965: Add DAB clock
  dt-bindings: misc: Add binding for R-Car DAB
  misc: Add driver for DAB IP found on Renesas R-Car devices
  arm64: dts: renesas: r8a77990: Add DAB support
  arm64: dts: renesas: r8a77965: Add DAB support
  arm64: configs: Add R-Car DAB support

 .../devicetree/bindings/misc/renesas,dab.yaml |  75 ++++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi     |  12 ++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi     |  12 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c       |   1 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c       |   1 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/rcar_dab/Kconfig                 |  11 ++
 drivers/misc/rcar_dab/Makefile                |   8 +
 drivers/misc/rcar_dab/rcar_dev.c              | 176 ++++++++++++++++++
 drivers/misc/rcar_dab/rcar_dev.h              | 116 ++++++++++++
 drivers/misc/rcar_dab/rcar_fft.c              | 160 ++++++++++++++++
 include/uapi/linux/rcar_dab.h                 |  35 ++++
 15 files changed, 617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/renesas,dab.yaml
 create mode 100644 drivers/misc/rcar_dab/Kconfig
 create mode 100644 drivers/misc/rcar_dab/Makefile
 create mode 100644 drivers/misc/rcar_dab/rcar_dev.c
 create mode 100644 drivers/misc/rcar_dab/rcar_dev.h
 create mode 100644 drivers/misc/rcar_dab/rcar_fft.c
 create mode 100644 include/uapi/linux/rcar_dab.h

-- 
2.25.1

