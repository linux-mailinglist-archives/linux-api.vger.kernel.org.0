Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE7326319
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 14:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZNGr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 08:06:47 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39314 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZNGo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 08:06:44 -0500
Received: by mail-oi1-f180.google.com with SMTP id z126so9629126oiz.6;
        Fri, 26 Feb 2021 05:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZK9juosIuq3XEEjS85Gkc10UOB2AvIHrhQ9IE5cwX4=;
        b=b7xV/cemgn/YUGx9rtfu1Yo7W4tpf53tKvUv/9ParhHQZhP5f9giTCwIWCCnDVa/xC
         iBEnFLIsq1ko3jYHZ5rN+qatlC8y1qEvpZiwE2R4dMjeAv24tgFbB7WO4Bvr2N/GJQF4
         ugmCF6201MQ74tvZ+ccjC1AHpaigkt8LNQjRYQHhvb4ldxXmN665L1PSna4hAl8xPDbE
         BVHzVt5KL3ACHH/86w3KXFBIpWEESWIMw4nTvwcGniWf4ZzoWFiO4b82APDvO9RAEUEU
         av7z07nNLNEH7GnZYLdLyIDaBOExcD+XSRA64vlXvGyo9aP0Kpftz22DuwALXa6A/QSh
         wfJA==
X-Gm-Message-State: AOAM5322gK8SkfQgSKYlN0M1ZcjzJ0ndrZM7j2XP21l+4q/FM5T3pKTX
        44TzI0I6lVPO/GRIrrphpmzO0+6iIZa7t/BjlJI=
X-Google-Smtp-Source: ABdhPJyUwiO27BDEHitYM2O30SRD5q0CzttvCGUI3vKaFoD39PpB1Glpe7FDQQDtFvJYn9dTvVd1W2TRL3Fy7kULf50=
X-Received: by 2002:aca:d908:: with SMTP id q8mr1878070oig.148.1614344763783;
 Fri, 26 Feb 2021 05:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-8-fabrizio.castro.jz@renesas.com> <YDjvI6DTcBfWdA3G@pendragon.ideasonboard.com>
In-Reply-To: <YDjvI6DTcBfWdA3G@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Feb 2021 14:05:52 +0100
Message-ID: <CAMuHMdXWv2FdJ84XoQQiVFuSoLhdzdAdHwT5Zg-n8cSWBVVdFQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: configs: Add R-Car DAB support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Laurent,

On Fri, Feb 26, 2021 at 1:53 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Feb 25, 2021 at 10:51:47PM +0000, Fabrizio Castro wrote:
> > Make sure that the R-Car DAB device driver gets compiled as a
> > module since R-Car E3 and R-Car M3-N come with the DAB IP.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>
> Do we need this in the defconfig ? It's not required to have a bootable
> E3 or M3-N with the set of standard features, and would result in all

That's why it's modular.

> ARM64 platforms having one module they don't care about.

We typically add all drivers used by all supported platforms, to
increase build coverage.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
