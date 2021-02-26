Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFB3262F0
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZMuC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 07:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZMt6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 07:49:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F752C061574;
        Fri, 26 Feb 2021 04:49:18 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD370580;
        Fri, 26 Feb 2021 13:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614343757;
        bh=x5nZBQVf0wlRzwxr5wF1qzN/XY/UC6gmCNzOn6eKkyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eugQ5CXUG/1ciTyosRm7hWzCJsd7tzZ178f+djJByvIgxhyY2EdKTvBOivgrse29M
         uRYT6b2uwtmrP3RiQ7VdqUhDLkd20KVTjhheJ0HligW+KOgKqj2hRa6oXKK9E+exLn
         tbEIxBiLELWhg5mCw2YhhFvvkzWpa5C2vZWB43I4=
Date:   Fri, 26 Feb 2021 14:48:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH 2/7] clk: renesas: r8a77965: Add DAB clock
Message-ID: <YDjuMRkU+g52I1gm@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Fri, Feb 26, 2021 at 09:45:20AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 25, 2021 at 11:53 PM Fabrizio Castro wrote:
> > This patch adds the DAB clock to the R8A77965 SoC.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
> > +++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
> > @@ -250,6 +250,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
> >         DEF_MOD("ssi2",                 1013,   MOD_CLK_ID(1005)),
> >         DEF_MOD("ssi1",                 1014,   MOD_CLK_ID(1005)),
> >         DEF_MOD("ssi0",                 1015,   MOD_CLK_ID(1005)),
> > +       DEF_MOD("dab",                  1016,   R8A77965_CLK_S0D6),
> 
> Unfortunately this bit is not documented in the R-Car Gen3 Hardware
> User's Manual, so I have to trust you on this.
> 
> While it's not unusual that the same module on R-Car E3 and M3-N
> has different parent clocks, it does strike me as odd that S0D6 on M3-N
> runs at 133 MHz, while S3D1 on E3 runs at 266 MHz.
> Probably it doesn't matter that much, as your driver doesn't care
> about the actual clock rate.

I have the exact same concerns, here and for 1/7.

> >         DEF_MOD("scu-all",              1017,   R8A77965_CLK_S3D4),
> >         DEF_MOD("scu-dvc1",             1018,   MOD_CLK_ID(1017)),
> >         DEF_MOD("scu-dvc0",             1019,   MOD_CLK_ID(1017)),

-- 
Regards,

Laurent Pinchart
