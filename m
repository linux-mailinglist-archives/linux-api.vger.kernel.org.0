Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485F325F65
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZIqQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 03:46:16 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36144 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhBZIqM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 03:46:12 -0500
Received: by mail-ot1-f52.google.com with SMTP id 105so8438128otd.3;
        Fri, 26 Feb 2021 00:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F36M/9eYWxF4USYUtVvAtqyb6eg9gU0Qrr2Aewe/K8c=;
        b=YVUiFF7jdvtOuBeL3MgUX0c4xUB2ffiH1DKlXFBBoLDb+lFkpwcrOGh80iuA5VMkZc
         Pv6RoGYAOIwb4oOXgAkl5qII28uJh1RdDlopohwusGpb82clWDIlxufXtTr7JfOXCuY5
         maE7YH/ST28D5eQqLutbf6qMV+7sMixVWUwxizx9XZYrGt7axWOiehJXw5UOGvFsH+Va
         vHF4rjOva7O1UTgK53+Oj8JE/g/ajZv7DurB+MafURVOATVU1i+FTHQJ+DjWSyaHM/ii
         GNlju1tekblm/VliruJkOwYfZ4re3T6zW/NcIp1WrY9VcO02Fett2ahmTe3avYA1hZ4h
         xfsQ==
X-Gm-Message-State: AOAM532MCLliazzm0YMnNaJG8JIv+JzKcJ7tueF0fw6ikYV0C5chKMFV
        WB4AiFCdtK10+WLc91tig39APx7OnVvj5iXkHZEiqjHf
X-Google-Smtp-Source: ABdhPJyJJvroqSxowcJeL+lDs0oTjerURyQSh7F2XxCJmPc9nJ/uCEBaytxjFFYzbnkPYsyT2pMjSoxwiSaomGGpP+w=
X-Received: by 2002:a9d:328:: with SMTP id 37mr1462410otv.250.1614329131806;
 Fri, 26 Feb 2021 00:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com> <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20210225225147.29920-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Feb 2021 09:45:20 +0100
Message-ID: <CAMuHMdXNBeVK0ze8HSA=t5TTfhyuRz=+yLHMBioUbsuBxUoWyA@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: renesas: r8a77965: Add DAB clock
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
> This patch adds the DAB clock to the R8A77965 SoC.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
> @@ -250,6 +250,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
>         DEF_MOD("ssi2",                 1013,   MOD_CLK_ID(1005)),
>         DEF_MOD("ssi1",                 1014,   MOD_CLK_ID(1005)),
>         DEF_MOD("ssi0",                 1015,   MOD_CLK_ID(1005)),
> +       DEF_MOD("dab",                  1016,   R8A77965_CLK_S0D6),

Unfortunately this bit is not documented in the R-Car Gen3 Hardware
User's Manual, so I have to trust you on this.

While it's not unusual that the same module on R-Car E3 and M3-N
has different parent clocks, it does strike me as odd that S0D6 on M3-N
runs at 133 MHz, while S3D1 on E3 runs at 266 MHz.
Probably it doesn't matter that much, as your driver doesn't care
about the actual clock rate.

>         DEF_MOD("scu-all",              1017,   R8A77965_CLK_S3D4),
>         DEF_MOD("scu-dvc1",             1018,   MOD_CLK_ID(1017)),
>         DEF_MOD("scu-dvc0",             1019,   MOD_CLK_ID(1017)),

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
