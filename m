Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20AA3527AC
	for <lists+linux-api@lfdr.de>; Fri,  2 Apr 2021 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBI71 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Apr 2021 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhDBI7U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Apr 2021 04:59:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F23C0613E6;
        Fri,  2 Apr 2021 01:59:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s17so4978043ljc.5;
        Fri, 02 Apr 2021 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HywOIhb5prU0SvgCATKvH+ZBrrrzKF5XQkM0MZqr0LA=;
        b=K58phw+IpQ//OZE32Gwyp+hDyT7tu3gNVxEMtandIn2kAiffLXdmEdS04bVlL12zRL
         3Ll05xL2x9/Gk+5wivRKbqrgR3LpQX0vyVTpJ69ZwbzSUeBmc2PKqPI6MKznUgBhI/Z5
         6ei4DP+DUVX4r6T4Cb+PdXQWv0olcT9mOewLrjdl4pA2deoUzXoSDrNBwAImjMo8/q/v
         RlMq/+aPVcFbNJQjRQ7XrCzv6wcTnjmm2dpsciA1HKIKMp+qf36tyl4KBeDJIK1iwFCc
         CBIe9O1zsPBiX7cYdtK+nVIP3tr2MzJS7DIaCW1+LORojLEFSCg9UKN1WXHWls0FqOkm
         Ks2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HywOIhb5prU0SvgCATKvH+ZBrrrzKF5XQkM0MZqr0LA=;
        b=KxIZG03I8U4sHiC8JIgaKrKcgsbOD6HkB7EjRJjXP4gviYymLGiWgnQyg4O+nSq7on
         WDtxImH4qPsjp8PyOCarK4P1hhu/qv6JmfBlggVgwDW6LPEnrq6Ez1gnmC5sa6LkYrM3
         QVG5SIcUhGLScfBTMKSCbT2b89iLC/5DakPdiGWAkAGMlaSFLxWKUP8pGbr5rhZoOqgK
         F3fgQCSSg6OE1W7oirS2f5RpNmIC1Jo0Y8hSD5Y5XgfzZHrxH1fQGqkw0AZuSihjJSDs
         7GLn2QOgvHfKQuELU5JP0WZJ7TotlX5Un6W3EV6POPygCmvAe1fy9MLgtxyl28lyi4JR
         qiYg==
X-Gm-Message-State: AOAM5318wHIn5zPT8IeCN66qB0ofMqbzhjvwSIWYihUEI9H7qJJuewBR
        OoP2qO9rdO76M2oMiVbVvaStmXZw6W1QmbkgX9W1yWKQrjY=
X-Google-Smtp-Source: ABdhPJw8cpfvx6+g3xC+Ja1aMlvho4dmtsu+dGUtAgfwKzdxVgHhaVnDtPlWS7DxXgJ74G2bNz/qvwTyG1+eZ5ifgLo=
X-Received: by 2002:a05:651c:384:: with SMTP id e4mr7528065ljp.500.1617353956993;
 Fri, 02 Apr 2021 01:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2103302221590.18977@angie.orcam.me.uk>
 <mhng-08e5e4fb-8a42-4f7b-8ceb-ff549784100e@palmerdabbelt-glaptop> <CACT4Y+Z0PaAuUFrOBenztWkw8OV=J-qaeD1FASPM4ufcLg5a5A@mail.gmail.com>
In-Reply-To: <CACT4Y+Z0PaAuUFrOBenztWkw8OV=J-qaeD1FASPM4ufcLg5a5A@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 2 Apr 2021 11:58:40 +0300
Message-ID: <CAEn-LTqTXCEC=bXTvGyo8SNL0JMWRKtiSwQB7R=Pc4uhxZUruA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, macro@orcam.me.uk,
        Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 2, 2021 at 11:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Apr 2, 2021 at 6:37 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Tue, 30 Mar 2021 13:31:45 PDT (-0700), macro@orcam.me.uk wrote:
> > > On Mon, 29 Mar 2021, Palmer Dabbelt wrote:
> > >
> > >> > --- /dev/null
> > >> > +++ b/arch/riscv/include/uapi/asm/setup.h
> > >> > @@ -0,0 +1,8 @@
> > >> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > >> > +
> > >> > +#ifndef _UAPI_ASM_RISCV_SETUP_H
> > >> > +#define _UAPI_ASM_RISCV_SETUP_H
> > >> > +
> > >> > +#define COMMAND_LINE_SIZE 1024
> > >> > +
> > >> > +#endif /* _UAPI_ASM_RISCV_SETUP_H */
> > >>
> > >> I put this on fixes, but it seemes like this should really be a Kconfig
> > >> enttry.  Either way, ours was quite a bit smaller than most architectures and
> > >> it's great that syzbot has started to find bugs, so I'd rather get this in
> > >> sooner.
> > >
> > >  This macro is exported as a part of the user API so it must not depend on
> > > Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or
> > > switching to an entirely new data object that has its dimension set in a
> > > different way) requires careful evaluation as external binaries have and
> > > will have the value it expands to compiled in, so it's a part of the ABI
> > > too.
> >
> > Thanks, I didn't realize this was part of the user BI.  In that case we
> > really can't chage it, so we'll have to sort out some other way do fix
> > whatever is going on.
> >
> > I've dropped this from fixes.
>
> Does increasing COMMAND_LINE_SIZE break user-space binaries? I would
> expect it to work the same way as adding new enum values, or adding
> fields at the end of versioned structs, etc.
> I would assume the old bootloaders/etc will only support up to the
> old, smaller max command line size, while the kernel will support
> larger command line size, which is fine.
> However, if something copies /proc/cmdline into a fixed-size buffer
> and expects that to work, that will break... that's quite unfortunate
> user-space code... is it what we afraid of?
>
> Alternatively, could expose the same COMMAND_LINE_SIZE, but internally
> support a larger command line?

Looking at kernel commit history I see PowerPC switched from 512 to
2048, and I don't see complaints about the ABI on the mailing list.

If COMMAND_LINE_SIZE is used by user space applications and we
increase it there shouldn't be problems. I would expect things to
work, but just get truncated boot args? That is the application will
continue only to look at the initial 512 chars.

https://linuxppc-dev.ozlabs.narkive.com/m4cj8nBa/patch-1-1-powerpc-increase-command-line-size-to-2048-from-512
