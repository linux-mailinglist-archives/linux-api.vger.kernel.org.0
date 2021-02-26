Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F6325FA4
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZJID (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 04:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBZJHh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 04:07:37 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39151C061574;
        Fri, 26 Feb 2021 01:06:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z11so12758581lfb.9;
        Fri, 26 Feb 2021 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxphfiSU/hPgYpEuMw/gJ3hatW3zgGJH56KQDhxkLH8=;
        b=d5y1ZGNdeZ2H2HfVMxJ9RF6kP70gycTbW/Ug6uETrHZM+Wfv92Ic1xy5IO7K7/cFhb
         de/BqRkWW/9j301hhpc2er++kymQHQqqvPuiZ3w/xPCZ0MLA0B0YqcYb38Netq/axb8G
         5laX3kWHRaYp15cj2evqHrC0oaYZni3gY6u4OxO/5OnhLO2yL6cP/dZRe2YiZwrLvUJl
         kLRTyI7mxleAGrWJ9jp2u4IKGG91KQqr1vq/51NaaIx5k6nLT0fn5v+1hxYmc5v+04eB
         jUkLTqh16GnG7HK3Wv5/GM9lSXUuf88iiqN5Db7BzXrLSpH4W0fKQb+7HcdQRoA26+Ju
         EZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uxphfiSU/hPgYpEuMw/gJ3hatW3zgGJH56KQDhxkLH8=;
        b=qrEZfdNlG9q+DdGZvnzHEk3wkaEdKIJG5xt6hZey+5qOygp1UazHoKznz33icmIB8h
         4o6YjoVXaqMERw4F4VbYwS14cNJuEhk5JIzjevgUoPjcEeAOOeoMxztBCQfiVUYEmmS2
         DVdumRyhwDQMwXdXx8B8SwBJLTdwUjUG3DP/VLK0ipTwIoZpNzNpb3jyd7tp5u7TcDUB
         DW3lwdRnaJ3xsKsM6PqMutY+1fhlpqid4xOAeQy51vIZ7ascTYTC4BzbVjxMD2zzwNvc
         8F5mRO7lH2ARFXEgAzWhrtX3xYOSdUxcD3TEDZRXyTmA/r8VSnk3fzj3KCIa5EoaNyM0
         jI6g==
X-Gm-Message-State: AOAM531+UMcsxax14K2/AVDn576AFiPNU4oFWgRsfSoBfaTsfGrtQQ6P
        dUaB/lpOO6DBsLKKTKnRGHo=
X-Google-Smtp-Source: ABdhPJwu/DorbxTb3m5ijFUSJF1Akr2qiI1JIQ/MJ9bEjQnb0mDgggLzP1FkObDPpiP8QELARcobnw==
X-Received: by 2002:a05:6512:1284:: with SMTP id u4mr1278416lfs.175.1614330401667;
        Fri, 26 Feb 2021 01:06:41 -0800 (PST)
Received: from [192.168.1.100] ([31.173.85.164])
        by smtp.gmail.com with ESMTPSA id 12sm1318201ljc.106.2021.02.26.01.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 01:06:41 -0800 (PST)
Subject: Re: [PATCH 3/7] dt-bindings: misc: Add binding for R-Car DAB
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <c907737b-dffd-e5f3-6e4f-2e8a7781bc95@gmail.com>
Date:   Fri, 26 Feb 2021 12:06:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225225147.29920-4-fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello!

On 26.02.2021 1:51, Fabrizio Castro wrote:

> Document bindings for R-Car DAB hardware accelerator, currently
> found on the r8a77990 SoC (a.k.a. R-Car E3) and on the r8a77965
> SoC (a.k.a. R-Car M3-N).
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>   .../devicetree/bindings/misc/renesas,dab.yaml | 75 +++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/misc/renesas,dab.yaml
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

    Why not renesas,<soc>-dab?

> +      - const: renesas,rcar-gen3-dab # Generic fallback for R-Car Gen3 devices
[...]

MBR, Sergei
