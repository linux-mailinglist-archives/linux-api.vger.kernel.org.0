Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1E3259D9
	for <lists+linux-api@lfdr.de>; Thu, 25 Feb 2021 23:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBYWxy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Feb 2021 17:53:54 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:45423 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229491AbhBYWxx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Feb 2021 17:53:53 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610377200"; 
   d="scan'208";a="73418583"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Feb 2021 07:53:02 +0900
Received: from devel.example.org?044ree.adwin.renesas.com (unknown [10.226.36.120])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7C235400C73A;
        Fri, 26 Feb 2021 07:52:58 +0900 (JST)
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
Subject: [PATCH 2/7] clk: renesas: r8a77965: Add DAB clock
Date:   Thu, 25 Feb 2021 22:51:42 +0000
Message-Id: <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch adds the DAB clock to the R8A77965 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 46a157732759..bc1be8bcbbe4 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -250,6 +250,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("ssi2",			1013,	MOD_CLK_ID(1005)),
 	DEF_MOD("ssi1",			1014,	MOD_CLK_ID(1005)),
 	DEF_MOD("ssi0",			1015,	MOD_CLK_ID(1005)),
+	DEF_MOD("dab",			1016,	R8A77965_CLK_S0D6),
 	DEF_MOD("scu-all",		1017,	R8A77965_CLK_S3D4),
 	DEF_MOD("scu-dvc1",		1018,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-dvc0",		1019,	MOD_CLK_ID(1017)),
-- 
2.25.1

