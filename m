Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1BF2883E7
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgJIHtS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Oct 2020 03:49:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46508 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbgJIHtS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Oct 2020 03:49:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id m11so8152063otk.13
        for <linux-api@vger.kernel.org>; Fri, 09 Oct 2020 00:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyy7NhubXPz5y7apyDWUO7dynXfnWfHbBgVemYH8exI=;
        b=lkx7l/OEhLoiaJ1BUe6zWlz6dOhwxyndpH3wjlQ6SrOzV+ga0FUiEF8yF2Mvh9fOBQ
         RL6nP4MNcULEZqmDv9R0r154TTNirHM01ED1bc66Vn2v//qfrABmJKltiCpCVsrc5Ui0
         CyS5cN4vtW26dBQjG+iNpj7SC61uS4oMPR1rqDvpN2E9Yc6t0muSofrGp5pOfAWqJdFs
         Ihl81nyHDbGt7v8YLrprORith4l35BH0sIUkBqBfDLVlXTRLxnROz4PnkhVcue6DBBSQ
         w3CKwQTKb3E2Rvb4lIpnqF7tR8t/2nHRk3FFCeSxfZqFj9X5kNEUAf/va1GdoTrD59k3
         PThA==
X-Gm-Message-State: AOAM530CLax1v/tef9e2dCeN9Kmrv3Gm5DLYcHaRwroG2ZOiOYZ5Z3Fm
        g7KW9HKvH5rm9oi7wjArXsF/X8Qbqfvtml1Z7zmtx7WzT/k=
X-Google-Smtp-Source: ABdhPJwSf6PrTwrCaovmY3tHGM4gdHkiWC/eo+z9uAbsXdz6/trDtasu/gYulgq6+1+xHvTOhDTpy+qROOPh/OtjjHc=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr7790693otc.145.1602229757295;
 Fri, 09 Oct 2020 00:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602204097.git.pcc@google.com> <19c5900e71a386eae3f00d90bb243bd385d9c6df.1602204097.git.pcc@google.com>
In-Reply-To: <19c5900e71a386eae3f00d90bb243bd385d9c6df.1602204097.git.pcc@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Oct 2020 09:49:06 +0200
Message-ID: <CAMuHMdXAA4kukQSzkSBJBTPLUfVGYKRMAxE_ezGGM=Hw_WFPVQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/8] arch: move SA_* definitions to generic headers
To:     Peter Collingbourne <pcc@google.com>
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

On Fri, Oct 9, 2020 at 2:51 AM Peter Collingbourne <pcc@google.com> wrote:
> Most architectures with the exception of alpha, mips, parisc and
> sparc use the same values for these flags. Move their definitions into
> asm-generic/signal-defs.h and allow the architectures with non-standard
> values to override them. Also, document the non-standard flag values
> in order to make it easier to add new generic flags in the future.
>
> A consequence of this change is that on powerpc and x86, the constants'
> values aside from SA_RESETHAND change signedness from unsigned
> to signed. This is not expected to impact realistic use of these
> constants. In particular the typical use of the constants where they
> are or'ed together and assigned to sa_flags (or another int variable)
> would not be affected.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ia3849f18b8009bf41faca374e701cdca36974528

>  arch/m68k/include/uapi/asm/signal.h    | 24 -------------

Please preserve my
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
given on v9 when posting new versions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
