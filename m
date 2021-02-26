Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D732603D
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 10:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBZJiu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 04:38:50 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39486 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhBZJir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 04:38:47 -0500
Received: by mail-oi1-f176.google.com with SMTP id z126so9134695oiz.6;
        Fri, 26 Feb 2021 01:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkuhY/EUxoDeVMzsFcTd26eNVSql+rMcTBUd/NT1nv4=;
        b=jhe5F7j891aJYZXWpPzR8qFadxOyQ+ykGBqDi336Txu3l48jg4o35xY2u0evGT0B3n
         N/vrnR5lttuqQv8azgvr5f0k9Gu9OeJWc7IaAcI+cTzNjuGXjXk6ykATYIZQZM96jzLa
         F9mgySpPTmCl/os8tQOa1ir7q7SSUc14zd6lKZOzPs1Maa7h1fHCx5WNHcdkH5Gca2lS
         VUOqwgBpDp5ZmBdg3p6ipnZTapt5528wkon4d5xDL5ikSY8zbPeq9P/ipuw78UT7z+w6
         5A97ssH0ZtLTNw+7LiMvyR96M2UNeS4O1ikLyVm75jdLsZFIMRLWSeuPrFp4tPmiFlyd
         FHLw==
X-Gm-Message-State: AOAM533OaHyVLxnNbNjXYTbG+u5khldQ72tgUQTsxO8BA0TYCsCsdGwO
        pUrLxAgRLH4VJNO0K4zAnGkXUU+fIZkpVvLpQF8=
X-Google-Smtp-Source: ABdhPJy+JyA1kvEoQU+0VvVPRZFnnnWRxQWKrSAqIPkqqvAzcS50e5p3t16qlS2f0gKqo05KgYgx6MIhs5OytiS81g8=
X-Received: by 2002:aca:d908:: with SMTP id q8mr1394693oig.148.1614332286142;
 Fri, 26 Feb 2021 01:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com> <20210225225147.29920-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20210225225147.29920-6-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Feb 2021 10:37:54 +0100
Message-ID: <CAMuHMdVg-BwAxBZ3ts4BpMMWPc88BG8TkD5JOosRg7O57EB33Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: renesas: r8a77990: Add DAB support
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

On Thu, Feb 25, 2021 at 11:53 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> R-Car E3 (a.k.a. r8a77990) comes with the DAB hardware accelerator.
> This patch adds SoC specific support.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

LGTM (ignoring clock-names bikeshedding)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
