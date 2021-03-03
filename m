Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A491032C66A
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449162AbhCDA2q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:46 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:45340 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbhCCK1s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 05:27:48 -0500
Received: by mail-vs1-f50.google.com with SMTP id z65so9944732vsz.12;
        Wed, 03 Mar 2021 02:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6F2sKkucvRUzH0kZNIJI7Gtlcb3Ai64bOEnUMx1W6o=;
        b=b6VYhps3dpScIBtb+sZVIXQFnvPvygq62Vp/8IAZG+RlWgsK1EvvM4LGSkZxF6wCUW
         5jMOHdKo21DeahcF8NmHwd7RtYXesLG2FHLqAmAXR6+DzPDE+nm739PdBRiNi7AQuti4
         hrbrYRibNWzsLRjKa8QaAd+vljgl1KADmWPXf1sNwHGCXLKATKUGRmN9cWGNHOQOQhGT
         b/KYS6h/phnv/z/BFboKIk/qtK/nbIVeeUhguEzB2ZGfZ2WrbYydzLxKg1YMbvX0Hk0t
         911z6QxIMQJheKjWDccJ47Gc2nTAx+Fa0TeqeH/D5AAGP6lWQv2u8jAw6BsNjTxzYIyB
         NGxQ==
X-Gm-Message-State: AOAM531FHoqPq9mc4FXjRClb2zAiP7ffCuThUM7kgEojhPt6m9D87uqN
        TgPZHhMtezYS/KqO0qg5IlmVROnLDcsSTccw6Hc=
X-Google-Smtp-Source: ABdhPJyqjrQ4AcZnbXYYgKTyxEx4u41HA8z4SDf3BMtiC7ZSiwpCjZAsreCbK07V/5CeOSxzi7+IMbgoWC7SDMLnwBg=
X-Received: by 2002:a67:f7c6:: with SMTP id a6mr118635vsp.42.1614767225946;
 Wed, 03 Mar 2021 02:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com> <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
 <OSAPR01MB2737666F47174B68A8EC8DD8C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
 <CAAEAJfDDhN4btecUzu=3ZYxP=amnOD=vq0bhhetx7voKdeMZ9Q@mail.gmail.com>
 <OSAPR01MB2737169C686080958657D65AC2999@OSAPR01MB2737.jpnprd01.prod.outlook.com>
 <YD4wWYc7/pDucm3s@pendragon.ideasonboard.com> <OSAPR01MB2737B061973D4D29729AB17BC2989@OSAPR01MB2737.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB2737B061973D4D29729AB17BC2989@OSAPR01MB2737.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Mar 2021 11:26:54 +0100
Message-ID: <CAMuHMdXROq_C0bS8tNVjiWE_zrEt2+jfBiCSFuK6b2snSXg9EQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car devices
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

On Wed, Mar 3, 2021 at 11:20 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Sent: 02 March 2021 12:32
> > Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-
> > Car devices
> >
> > On Tue, Mar 02, 2021 at 12:20:17PM +0000, Fabrizio Castro wrote:
> > > On 02 March 2021 11:17, Ezequiel Garcia wrote:
> > > > On Mon, 1 Mar 2021 at 14:36, Fabrizio Castro wrote:
> > > > > On 26 February 2021 10:38, Arnd Bergmann wrote:
> > > > > > On Thu, Feb 25, 2021 at 11:51 PM Fabrizio Castro wrote:
> > > > > > >
> > > > > > > The DAB hardware accelerator found on R-Car E3 and R-Car M3-N
> > devices is
> > > > > > > a hardware accelerator for software DAB demodulators.
> > > > > > > It consists of one FFT (Fast Fourier Transform) module and one
> > decoder
> > > > > > > module, compatible with DAB specification (ETSI EN 300 401 and
> > > > > > > ETSI TS 102 563).
> > > > > > > The decoder module can perform FIC decoding and MSC decoding
> > processing
> > > > > > > from de-puncture to final decoded result.
> > > > > > >
> > > > > > > This patch adds a device driver to support the FFT module only.
> > > > > > >
> > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[...]

> I think the clock related patches are worth merging.

Indeed. I had already marked them to be applied, after you received
confirmation about the parent clocks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
