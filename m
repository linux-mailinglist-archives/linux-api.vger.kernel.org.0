Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC78A325F2B
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 09:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBZIfr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 03:35:47 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40999 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhBZIfc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 03:35:32 -0500
Received: by mail-ot1-f45.google.com with SMTP id x9so4036693otp.8;
        Fri, 26 Feb 2021 00:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anVi8f8xZhpnXaicUu8NGo9ZJBZgATVbkVVGFC0+FhA=;
        b=WHOCL8DK4dYRLkNz9rzMFB9art2uxRMuGsz8t98fjG3BZzq2pO69qNdwl7EV3wiUZP
         S5VTyCMr646Yljg3op3h4+OIMBAHs3YiTe177p7LxtevZ8jjcyTsytMJxVAdcy/NkLSo
         c8/3sutO8Voj/6WCzf3jd4xbM6YqavorVo1ca4WNO9031iLgfAu3m7OzyttLy1n+apLk
         R8lcM6IuAB1Vy3zElQeUWO9TcdNRAC8dP1OXpA9wo0puNAyvQqNSm15FEbmHJJwhfTSC
         KO7nfJRsbK/OeyChN4zGwwtQR4XoVxDzO4xxIwc89zBa/teNWNmB8ZcchD1BQ8lfrJIc
         JWqA==
X-Gm-Message-State: AOAM530kmqqRJ/DkF7YH3DwL4w4FUTsKh/0et/mK6hYsoBbRJcQOTVNA
        Mb5SX1sR/2nfsn/WUFvmbu4JLrkNGF4TGYeEa9U=
X-Google-Smtp-Source: ABdhPJyMFMKNNdfpSdZXvr39/5ZRc5W5XBWHAjsmaPcr3kOjTgAQYpV+ielEcRCIm4oe9/t0rHnNe2PFllio2C/pbfE=
X-Received: by 2002:a9d:6382:: with SMTP id w2mr1498654otk.145.1614328491030;
 Fri, 26 Feb 2021 00:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com> <20210225225147.29920-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20210225225147.29920-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Feb 2021 09:34:39 +0100
Message-ID: <CAMuHMdX4gn2ganKyq89LNW8uV==AX9efy9+DSYJUyv-pC=qv9w@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: renesas: r8a77990: Add DAB clock
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

Hi Fabrizio,

On Thu, Feb 25, 2021 at 11:52 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> This patch adds the DAB clock to the R8A77990 SoC.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
> @@ -232,6 +232,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
>         DEF_MOD("ssi2",                 1013,   MOD_CLK_ID(1005)),
>         DEF_MOD("ssi1",                 1014,   MOD_CLK_ID(1005)),
>         DEF_MOD("ssi0",                 1015,   MOD_CLK_ID(1005)),
> +       DEF_MOD("dab",                  1016,   R8A77990_CLK_S3D1),

Unfortunately this bit is not documented in the R-Car Gen3 Hardware
User's Manual, so I have to trust you on this.

>         DEF_MOD("scu-all",              1017,   R8A77990_CLK_S3D4),
>         DEF_MOD("scu-dvc1",             1018,   MOD_CLK_ID(1017)),
>         DEF_MOD("scu-dvc0",             1019,   MOD_CLK_ID(1017)),

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
