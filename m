Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D823319952
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 05:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBLEs3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Feb 2021 23:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhBLEs0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Feb 2021 23:48:26 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10E2C061756
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 20:47:45 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e7so7192746ile.7
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yjxZTrkFOIJ3VLsNEo3eBWqJR5dLEWmhK2AxjD3KzI=;
        b=OjNx3uce8BvxKfn3loshFedZyeUB41Lnwk5oh+/0LXYpomph6zW0IohgGvKenqHZTS
         V2v9BnXBbpyqQ0jN31YDVZcCBHjuHi0Q7YCtIvCWaXUJn8Kyxba44kEFvja9Hg+UXjKX
         KkROSLZM88L7DebNUT4whMfXP6JSHJuItJhaVeWxowkL9SdOkthGPJFQ9LsUF1sFT0XP
         rPcBcAUHhujurXDIsUypg761qvxNXCsyW0VvYXWmoHgnlt08x8ip3CwZWFiV4NGlQztP
         /sGZEe1fqA9l/gNDNHZxoFJVxu1prjRi74iiWvc/Dideo0i9kRjuucG21k8Yvw63PAGD
         XQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yjxZTrkFOIJ3VLsNEo3eBWqJR5dLEWmhK2AxjD3KzI=;
        b=PFhnoEVBju1KmnoSsvQWuF5XcJtAux7PLxvUkQ9eXuIQwrbbmaCSy54p4HYO9LyV0R
         1f2Z0B5H910jbLT7Ifhj8k65npR4jS/qvwpUtBP/YH4S6oUCLn9nfKMiQmg2c6ylaXqF
         pISMWz70Nf/Jnd4OCm4Fu00ojgIcG9qQG5TvdE7QvJ0r2d/p01tyA+R0yRlS21/g8BS/
         jy2DNi6BjffV6oi245lsZwretAHWV5LI4/Oid83EE0trOqxqso3bEjP8N+HkftogZR7L
         dx9Kvwah5BB78mu1SCx6hJiYNYSB+OqKE/BwMOYvUk12eiI8QYkA34zwzIEi7reK0s0Z
         ZIwQ==
X-Gm-Message-State: AOAM530rAyVU6lW2ATSWcVxjWH3ZxxPRo5nXD0sE6I6Wyo6zyAUVOiOd
        fI2g+F2ioQGamFN4zaSrInJk6CJW4gq/OER/q4xO7A==
X-Google-Smtp-Source: ABdhPJwpGfWXE7Cc1t4vapsgBB8v0cvymu1B/CoWXaSTlSM4cGf4JqxOYCvqQ1YTH7H4+LvSLtHA4TdGeZia0je6tuY=
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr1023157ilv.145.1613105265173;
 Thu, 11 Feb 2021 20:47:45 -0800 (PST)
MIME-Version: 1.0
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <20210126124958.GC29702@willie-the-truck>
In-Reply-To: <20210126124958.GC29702@willie-the-truck>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 11 Feb 2021 20:47:33 -0800
Message-ID: <CAMn1gO4PkzwY+pkLVR85Qp1VUYybZ9dMG-E_f1SP3cOE4FOfqQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] arm64: mte: make the per-task SCTLR_EL1 field
 usable elsewhere
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 26, 2021 at 4:50 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Dec 29, 2020 at 10:59:13PM -0800, Peter Collingbourne wrote:
> > In an upcoming change we are going to introduce per-task SCTLR_EL1
> > bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> > MTE-specific code so that we will be able to use it from both the
> > PAC and MTE code paths and make the task switching code more efficient.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/Ic65fac78a7926168fa68f9e8da591c9e04ff7278
> > ---
> >  arch/arm64/Kconfig                 |  4 +++
> >  arch/arm64/include/asm/mte.h       |  4 ---
> >  arch/arm64/include/asm/processor.h | 10 ++++++-
> >  arch/arm64/kernel/mte.c            | 47 ++++++------------------------
> >  arch/arm64/kernel/process.c        | 34 +++++++++++++++++----
> >  5 files changed, 50 insertions(+), 49 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 05e17351e4f3..82e38d1ca012 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -348,6 +348,9 @@ config KASAN_SHADOW_OFFSET
> >       default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
> >       default 0xffffffffffffffff
> >
> > +config ARM64_NEED_SCTLR_USER
> > +     bool
> > +
> >  source "arch/arm64/Kconfig.platforms"
> >
> >  menu "Kernel Features"
> > @@ -1653,6 +1656,7 @@ config ARM64_MTE
> >       # Required for tag checking in the uaccess routines
> >       depends on ARM64_PAN
> >       select ARCH_USES_HIGH_VMA_FLAGS
> > +     select ARM64_NEED_SCTLR_USER
>
> I'm not sure I'd bother with this; is it the end of the world if we do this
> unconditionally?

I think I'd be fine with doing it unconditionally. If both PAC and MTE
are disabled then I believe that the only additional code that we
would end up executing is the comparison between prev and next
sctlr_user on task switch in process.c (which would always yield
false) and since task switch is much less common than entry/exit it
seems acceptable to me.

Peter
