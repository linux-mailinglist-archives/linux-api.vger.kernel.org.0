Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED73262EB
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 13:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBZMs6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 07:48:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49078 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBZMs5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 07:48:57 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AC38C580;
        Fri, 26 Feb 2021 13:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614343694;
        bh=rrLpCYkJ5JwjMm7tTb6U1oQtp1SJVFjnAKeQrFXlxdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNsZyv1yKpHH+uaUyjyU4iZvC6Sjp8pQ6lMMS3CMLW5dC9STGwKaPhwqfi+6s6CnB
         VyeBGpfJV3wwFC0AJ0wD2z7zXoBHGZP9ZzdlLR5QB/i0G/JW1oV00/0vNxotVLUN8A
         H/Onn9pGwyPZVPhGMVprj1+A5gdgrnGiDuiQgAdc=
Date:   Fri, 26 Feb 2021 14:47:47 +0200
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
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
Message-ID: <YDjt83Yri6jiEq6B@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thu, Feb 25, 2021 at 10:51:46PM +0000, Fabrizio Castro wrote:
> R-Car M3-N (a.k.a. r8a77965) comes with the DAB hardware accelerator.
> This patch adds SoC specific support.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> index 657b20d3533b..b6176fd5b703 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -1013,6 +1013,18 @@ ipmmu_vp0: iommu@fe990000 {
>  			#iommu-cells = <1>;
>  		};
>  
> +		dab: dab@e6730000 {
> +			compatible = "renesas,dab-r8a77965",
> +				     "renesas,rcar-gen3-dab";
> +			reg = <0x00 0xe6730000 0x00 0x120>;
> +			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 1016>;
> +			clock-names = "dab";
> +			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +			resets = <&cpg 1016>;

Same comments as for r8a77990.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			status = "disabled";
> +		};
> +
>  		avb: ethernet@e6800000 {
>  			compatible = "renesas,etheravb-r8a77965",
>  				     "renesas,etheravb-rcar-gen3";

-- 
Regards,

Laurent Pinchart
