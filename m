Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B90326039
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhBZJia (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 04:38:30 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34030 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZJi0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 04:38:26 -0500
Received: by mail-ot1-f54.google.com with SMTP id b16so8571327otq.1;
        Fri, 26 Feb 2021 01:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oXl8ORRvWkZn3Q+NSTU0JhocFy4MrasRQfZ9lV0v1w=;
        b=OojPfXgKKRXC2SAbmSozTH2EkYAsa8V+wS7lFMj0ajWiWwlhqcefsip2nXMqOfbjUe
         6IKrK8SzMCfTZjgLFTMEIFgtXRrxUyOnJ6rTPOIusvAIN21TPZ83HycouAjnWvmBbxFm
         alY7pRertPzCgmaVr6oh9tfwAmYuiCpu920yWpknBZ7kGgS65kUXdw8BPprVrC4CGLbu
         dpmvWFYJCaJAdBOKZt0uR13D7i1MxtYiK8/mFyfEQCQyIatF1Qhw4c3eryR3vlu5nX4O
         G/zvwwNL6Wz11CSESTvsBozT5ugbTe57qgR30QwGPxKEK9LgjlZ+IbMZfZ9mvsmUdDno
         dNfw==
X-Gm-Message-State: AOAM531twhw55c+a9WNX7W5zfYcYL2UM6Khz44haahTo+o2OjyulOyo4
        Vxjm2rdnZEhueBs/x9KAZE+hjjYWTHJaH392btcxH7PO
X-Google-Smtp-Source: ABdhPJx3ZV0e1g8mRwwnnPs6tUQkBIvym+xQhYnauXPYD/rkw5Y4oUKpyPzY9dH9Ez60j8qK6s7xUIKqoSHIycEyYvg=
X-Received: by 2002:a9d:328:: with SMTP id 37mr1589640otv.250.1614332253635;
 Fri, 26 Feb 2021 01:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com> <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20210225225147.29920-7-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Feb 2021 10:37:22 +0100
Message-ID: <CAMuHMdUN49Tee2_50037jPvXGh-55bZG03guC1vxkU1TnAaLZQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: renesas: r8a77965: Add DAB support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Dirk Behme <Dirk.Behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

On Thu, Feb 25, 2021 at 11:53 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> R-Car M3-N (a.k.a. r8a77965) comes with the DAB hardware accelerator.
> This patch adds SoC specific support.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

LGTM (ignoring clock-names bikeshedding)

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -1013,6 +1013,18 @@ ipmmu_vp0: iommu@fe990000 {
>                         #iommu-cells = <1>;
>                 };
>
> +               dab: dab@e6730000 {
> +                       compatible = "renesas,dab-r8a77965",
> +                                    "renesas,rcar-gen3-dab";
> +                       reg = <0x00 0xe6730000 0x00 0x120>;
> +                       interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 1016>;
> +                       clock-names = "dab";
> +                       power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +                       resets = <&cpg 1016>;
> +                       status = "disabled";
> +               };
> +
>                 avb: ethernet@e6800000 {
>                         compatible = "renesas,etheravb-r8a77965",
>                                      "renesas,etheravb-rcar-gen3";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
