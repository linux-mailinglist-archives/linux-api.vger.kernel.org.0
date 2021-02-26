Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96632630E
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 14:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBZND1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 08:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhBZNDB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 08:03:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602B1C061574;
        Fri, 26 Feb 2021 05:02:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B496F580;
        Fri, 26 Feb 2021 14:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614344539;
        bh=mZ0IYxBSn6iMGXpB0SlinpEe79W+pKlloE1WRBX6Gxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pEhF8ZmT0ZwoEDSrw4uNlN9be8rkJOLn78EQDQxzgnSxLfUY+itfRXOmy46UEtFzi
         hN0mSgQWWOUz6KRxbnmfabtTFx+EWHqlfETKxiDEJ4MS/LKyJC3ofWROC0ChVgO6/8
         IqhCV3tp8+LpXo/f7oXVKsJgRSb/gJmIEYK774lM=
Date:   Fri, 26 Feb 2021 15:01:52 +0200
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
Subject: Re: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
Message-ID: <YDjxQOx9bDXLjk6E@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thu, Feb 25, 2021 at 10:51:43PM +0000, Fabrizio Castro wrote:
> Document bindings for R-Car DAB hardware accelerator, currently
> found on the r8a77990 SoC (a.k.a. R-Car E3) and on the r8a77965
> SoC (a.k.a. R-Car M3-N).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../devicetree/bindings/misc/renesas,dab.yaml | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/renesas,dab.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/renesas,dab.yaml b/Documentation/devicetree/bindings/misc/renesas,dab.yaml
> new file mode 100644
> index 000000000000..e9494add13d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/renesas,dab.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Renesas Electronics Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/renesas,dab.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car DAB Hardware Accelerator
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +
> +description:
> +  The DAB hardware accelerator found on some R-Car devices is a hardware
> +  accelerator for software DAB demodulators.
> +  It consists of one FFT (Fast Fourier Transform) module and one decoder module,
> +  compatible with DAB specification (ETSI EN 300 401 and ETSI TS 102 563).
> +  The decoder module can perform FIC decoding and MSC decoding processing from
> +  de-puncture to final decoded result.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,dab-r8a77965     # R-Car M3-N
> +          - renesas,dab-r8a77990     # R-Car E3
> +      - const: renesas,rcar-gen3-dab # Generic fallback for R-Car Gen3 devices
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

I usually try to describe clocks:

  clocks:
    items:
      - description: The module functional clock

but as there's a single clock, it may not be worth it. Up to you.

> +
> +  clock-names:
> +    const: dab

With Geert's and Sergei's comments addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  # R8A77990 (R-Car E3)
> +  - |
> +    #include <dt-bindings/clock/r8a77990-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a77990-sysc.h>
> +
> +    dab: dab@e6730000 {
> +        compatible = "renesas,dab-r8a77990",
> +                     "renesas,rcar-gen3-dab";
> +        reg = <0xe6730000 0x120>;
> +        interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&cpg CPG_MOD 1016>;
> +        clock-names = "dab";
> +        power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
> +        resets = <&cpg 1016>;
> +        status = "disabled";
> +    };

-- 
Regards,

Laurent Pinchart
