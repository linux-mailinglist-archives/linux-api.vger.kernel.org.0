Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1503262E6
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 13:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZMsV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 07:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZMsU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 07:48:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389DC061574;
        Fri, 26 Feb 2021 04:47:40 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 47D59580;
        Fri, 26 Feb 2021 13:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614343654;
        bh=//WROYy2yrpIokeweAuXJ+Feiva/VBmtXT/9QdWXFV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXeoh41MUKm4uY1NPZ3OVkVek/zinxj0KfnlN3R+Zoq/rSdF4U/EzYzmefZt4FWBc
         8IxxuWZDX7hHWAl/HnEisplVFPjvlJfXsQar1mjr4OWASxAUoy3kkNJoGDtoQfJOnf
         YguGwpmyYFBUfq6MoNtGnus29S09gDXBnB7xCbWI=
Date:   Fri, 26 Feb 2021 14:47:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: Re: [PATCH 5/7] arm64: dts: renesas: r8a77990: Add DAB support
Message-ID: <YDjtyWUZ/rjskGGr@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-6-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225225147.29920-6-fabrizio.castro.jz@renesas.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thu, Feb 25, 2021 at 10:51:45PM +0000, Fabrizio Castro wrote:
> R-Car E3 (a.k.a. r8a77990) comes with the DAB hardware accelerator.
> This patch adds SoC specific support.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> index 5010f23fafcc..5a6b835f137a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> @@ -963,6 +963,18 @@ ipmmu_vp0: iommu@fe990000 {
>  			#iommu-cells = <1>;
>  		};
>  
> +		dab: dab@e6730000 {
> +			compatible = "renesas,dab-r8a77990",
> +				     "renesas,rcar-gen3-dab";
> +			reg = <0x00 0xe6730000 0x00 0x120>;

We often express the first cell as just 0.

			reg = <0 0xe6730000 0 0x120>;

> +			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 1016>;

As the clock isn't documented in the documentation, I can't verify this
of the resets property :-S

> +			clock-names = "dab";

I'll comment on the clock name in the DT bindings.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
> +			resets = <&cpg 1016>;
> +			status = "disabled";
> +		};
> +
>  		avb: ethernet@e6800000 {
>  			compatible = "renesas,etheravb-r8a77990",
>  				     "renesas,etheravb-rcar-gen3";

-- 
Regards,

Laurent Pinchart
