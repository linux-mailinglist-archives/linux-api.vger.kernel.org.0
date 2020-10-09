Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C4288D42
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgJIPsE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Oct 2020 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIPsD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Oct 2020 11:48:03 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D8DC0613D2
        for <linux-api@vger.kernel.org>; Fri,  9 Oct 2020 08:48:02 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l6so4334505vsr.7
        for <linux-api@vger.kernel.org>; Fri, 09 Oct 2020 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s7SFVVtG+zkirZ7bkWpAc7gUPf2lUPf5PGcrM42htU=;
        b=EJ7O+uLcJf6nvUr9EC1/Doka02Isx4ZQYUCXQAYp1Tru8iYKcouB20EP7Jhdo1VTBp
         MzMIjT8m8U2GEXCPuroaOvHt688rkRmUkPe/LaaRGzNHNbpLv8C+i2AichO+8LC9X72X
         RFJPVKDpct7h36VPjAovZCcN96vpRRWbzhvfr+7hrVNbNQbd02ssSKuouy2jPz7jyAda
         CzzV2XsKZJotwPzs6JjTJUmlh7d4ZPxNSqfZKrm1f6UaTNG+NvMd4moQsIiG4BeY7i/+
         8T7wVPchh9HnlsX2ett7hs5cvIU9QltNjItmk4LFalacluRaWGnIvya5XQ7aHHxhm4Cx
         9NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s7SFVVtG+zkirZ7bkWpAc7gUPf2lUPf5PGcrM42htU=;
        b=LmxCwT8JwDD3N61tc7eyuf3zod/gvNBDeI3ErR6P+NVVYp6WwL0cGlItZ9ahnBzM55
         kUgjLsyR2uf6xQ8UdihwIAA3F3bgSJzZjpMJuaZCON5So5ZzEG/OX2Q7qjbPVPoiDV71
         QYyCOlkXWoU0R0HZ4Wxcbb0vFJQ/6zntaSQjel8BLhi/JAUwjJgIUqNDurzox/l4789O
         3mmbxPF0NqKirxB6m9kON0EVfSwVifTUdBgXqcqvFdWS4uLdwRrnS6X1tifLLB8+Wa+B
         ML7lDnvy7SFelUa+MZJAEBWfOhPp1pgz2lFZt9PL7Yl2BZuF8IRQC5qEgvEBEtv4jZvL
         c2oA==
X-Gm-Message-State: AOAM530y7ygzrVBwRx2cG09xe+hPU1WcBNnk0F4rTjihDONA0CaHH7tQ
        Q0t/xkRUv6+RtAtZrB7LTWQeuEtAvEOLYQr9z/eeHQ==
X-Google-Smtp-Source: ABdhPJxp7f+60/J6JDUzJ/c6E3vSsWzH0hIeWTKliprDTgEl22Tdcq/Rz2OXjb1KSbM+q+Ha6kQveXeCp1Vy5WCEs28=
X-Received: by 2002:a67:fb96:: with SMTP id n22mr8234444vsr.13.1602258481302;
 Fri, 09 Oct 2020 08:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602204097.git.pcc@google.com> <19c5900e71a386eae3f00d90bb243bd385d9c6df.1602204097.git.pcc@google.com>
 <CAMuHMdXAA4kukQSzkSBJBTPLUfVGYKRMAxE_ezGGM=Hw_WFPVQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXAA4kukQSzkSBJBTPLUfVGYKRMAxE_ezGGM=Hw_WFPVQ@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 9 Oct 2020 08:47:50 -0700
Message-ID: <CAMn1gO4yZEshEYXg0G5h6csHO6UaqHTR-KGtdGdioQ3mcTArFg@mail.gmail.com>
Subject: Re: [PATCH v11 3/8] arch: move SA_* definitions to generic headers
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Helge Deller <deller@gmx.de>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        David Spickett <david.spickett@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 9, 2020 at 12:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Fri, Oct 9, 2020 at 2:51 AM Peter Collingbourne <pcc@google.com> wrote:
> > Most architectures with the exception of alpha, mips, parisc and
> > sparc use the same values for these flags. Move their definitions into
> > asm-generic/signal-defs.h and allow the architectures with non-standard
> > values to override them. Also, document the non-standard flag values
> > in order to make it easier to add new generic flags in the future.
> >
> > A consequence of this change is that on powerpc and x86, the constants'
> > values aside from SA_RESETHAND change signedness from unsigned
> > to signed. This is not expected to impact realistic use of these
> > constants. In particular the typical use of the constants where they
> > are or'ed together and assigned to sa_flags (or another int variable)
> > would not be affected.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/Ia3849f18b8009bf41faca374e701cdca36974528
>
> >  arch/m68k/include/uapi/asm/signal.h    | 24 -------------
>
> Please preserve my
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> given on v9 when posting new versions.

Sorry about that, I've applied your Acked-by locally and I'll include
it in future patches.

Peter
