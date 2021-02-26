Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0E3262A7
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 13:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBZMV7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 07:21:59 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48842 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZMV6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 07:21:58 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73C2C580;
        Fri, 26 Feb 2021 13:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614342075;
        bh=nWbkyCTRl2N2loenx0RpKhmqgsTqWZeI/+24sE7lDhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcSjq8cDB3hjPdLb7dogNwqtilbbkVTw7X/DrsU17Nz9vFs3rx7+oez0CY5jLi9Ec
         fMxcT0nUdoyjfSX1ngWRDP/xDrdl7tjSaqoYZY0ARG5pHHlrSSGv09J/8Kr+QU59Ij
         r1ntDap30ZQLLhMtaGisDIueCD1Qw7F2yCzYFczY=
Date:   Fri, 26 Feb 2021 14:20:48 +0200
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
Subject: Re: [PATCH 0/7] Add FFT Support for R-Car Gen3 devices
Message-ID: <YDjnoGDOCXm86ffW@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

On Thu, Feb 25, 2021 at 10:51:40PM +0000, Fabrizio Castro wrote:
> The DAB hardware accelerator found on R-Car E3 (a.k.a. r8a77990)
> and R-Car M3-N (a.k.a. r8a77965) devices is a hardware accelerator
> for software DAB demodulators.
> It consists of one FFT (Fast Fourier Transform) module and one
> decoder module, compatible with DAB specification (ETSI EN 300 401
> and ETSI TS 102 563).
> The decoder module can perform FIC decoding and MSC decoding
> processing from de-puncture to final decoded result.
> 
> This series adds FFT support only for R-Car E3 and R-Car M3-N,
> FIC and MSC support will be added later on.

Out of curiosity, could the FFT module be used as an accelerator for 2D
FFT on images ?

> Fabrizio Castro (7):
>   clk: renesas: r8a77990: Add DAB clock
>   clk: renesas: r8a77965: Add DAB clock
>   dt-bindings: misc: Add binding for R-Car DAB
>   misc: Add driver for DAB IP found on Renesas R-Car devices
>   arm64: dts: renesas: r8a77990: Add DAB support
>   arm64: dts: renesas: r8a77965: Add DAB support
>   arm64: configs: Add R-Car DAB support
> 
>  .../devicetree/bindings/misc/renesas,dab.yaml |  75 ++++++++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi     |  12 ++
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi     |  12 ++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/renesas/r8a77965-cpg-mssr.c       |   1 +
>  drivers/clk/renesas/r8a77990-cpg-mssr.c       |   1 +
>  drivers/misc/Kconfig                          |   1 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/rcar_dab/Kconfig                 |  11 ++
>  drivers/misc/rcar_dab/Makefile                |   8 +
>  drivers/misc/rcar_dab/rcar_dev.c              | 176 ++++++++++++++++++
>  drivers/misc/rcar_dab/rcar_dev.h              | 116 ++++++++++++
>  drivers/misc/rcar_dab/rcar_fft.c              | 160 ++++++++++++++++
>  include/uapi/linux/rcar_dab.h                 |  35 ++++
>  15 files changed, 617 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/renesas,dab.yaml
>  create mode 100644 drivers/misc/rcar_dab/Kconfig
>  create mode 100644 drivers/misc/rcar_dab/Makefile
>  create mode 100644 drivers/misc/rcar_dab/rcar_dev.c
>  create mode 100644 drivers/misc/rcar_dab/rcar_dev.h
>  create mode 100644 drivers/misc/rcar_dab/rcar_fft.c
>  create mode 100644 include/uapi/linux/rcar_dab.h

-- 
Regards,

Laurent Pinchart
