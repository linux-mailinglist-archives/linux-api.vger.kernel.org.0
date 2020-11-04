Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869682A6F29
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 21:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgKDUsR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgKDUsR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 15:48:17 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B526C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 12:48:16 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id t15so6466942ual.6
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQFKKJ0jwEvb5HtGVv3T5qfpIvoMpHBjQqBvgTgf7qg=;
        b=vbqr9wh4U+6JXMawmDaRBryxGNm1CGkOoZ24ybOvPAIBk+Ehtnb214CTEQlnbH97FL
         c+eGSe1zijzNs1xvOie6qYLjSsiy4dT4spjIVizFJIWBVgWip5ak1RFZGEUJHU7OvZW0
         D7C6Xt/E0Y0BDTWznIV7a0M12i9Geyc9sDfFqOyUvetR+oVBpc9CHtOUJFU9tBue9VeP
         043xya3sdI8A4+SB3WX0c64ItgQ9tmLmGHmto92/ScT+aC/+s94WPMpaBpq68x/nkPBQ
         B+4+RWlo6ekeyNRjmtZyx4PsC6W4dtkAUnGLDFkFfqaWedxrHGIeS4sy5LZtX3mxk7dj
         7ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQFKKJ0jwEvb5HtGVv3T5qfpIvoMpHBjQqBvgTgf7qg=;
        b=ZZDER8AbdWmk4T+vheqmBJ6n6YxWUyRi1T1AAMZuqn8kA5Ko0k5MnJJpwp0wUWh8wm
         QhI/6weNwd5c4cA0o93UQekEK8pZKcIyaDtfDq/aMtiNn0yaYz1GdYMDGzoa8ZdchfFS
         0IOwBA9/82eCVGlc/HcHUvxaGdaAkCKlBsv1WeEk7bumxJTqID3M/d+HOYkk6L8XGuz+
         /ksUO35QvjfPfTwcpKmrMEr+8nF2CYqZLXkem+St9+91mRg7b9YMF8/Ry+pVle3evp8M
         RMrvNofDHAG5gxrDvjmMrMKHG7OMTtz4hwf1iTL20Ct0XF6j4siWDU+RpgGReAqbZwXD
         Un8Q==
X-Gm-Message-State: AOAM533MXiJWXJRKYvob1QFZe3vHynuAHGv/fMTe9olqD22hLKl7PmhT
        MHNk5PPvhqyZKWG/PQf6QHBuoAgFZEqlgTpVELmAYQ==
X-Google-Smtp-Source: ABdhPJzeFxIrN+4FyHYdzHsax2JoF/TeoS8dQHsnw+jFgH9vY8OyslB9vtVsEbQ6/xhDjpi9txcrh8gWlzcOA4KnVGw=
X-Received: by 2002:a9f:28a7:: with SMTP id d36mr10661610uad.37.1604522895429;
 Wed, 04 Nov 2020 12:48:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604376407.git.pcc@google.com> <a309f8baa7c342536c17832cf604fad00aac486c.1604376407.git.pcc@google.com>
 <87h7q55584.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7q55584.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 4 Nov 2020 12:48:04 -0800
Message-ID: <CAMn1gO5gTwhkvSKzSeEGEBuZebfO6ZbhrggwcSBD2-5OobE=qA@mail.gmail.com>
Subject: Re: [PATCH v13 3/8] arch: move SA_* definitions to generic headers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 4, 2020 at 10:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
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
>
> Except for the removal of SA_RESTORER on arm (see below).
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks for the review.

> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Link: https://linux-review.googlesource.com/id/Ia3849f18b8009bf41faca374e701cdca36974528
> > ---
> > v11:
> > - tweak the commit message to point out the change from unsigned
> >   to signed
> >
> > v10:
> > - move the comments around and add one for SA_SIGINFO
> >
>
> > diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
> > index 9b4185ba4f8a..7727f0984d26 100644
> > --- a/arch/arm/include/uapi/asm/signal.h
> > +++ b/arch/arm/include/uapi/asm/signal.h
> > @@ -60,33 +60,11 @@ typedef unsigned long sigset_t;
> >  #define SIGSWI               32
> >
> >  /*
> > - * SA_FLAGS values:
> > - *
> > - * SA_NOCLDSTOP              flag to turn off SIGCHLD when children stop.
> > - * SA_NOCLDWAIT              flag on SIGCHLD to inhibit zombies.
> > - * SA_SIGINFO                deliver the signal with SIGINFO structs
> > - * SA_THIRTYTWO              delivers the signal in 32-bit mode, even if the task
> > - *                   is running in 26-bit.
> > - * SA_ONSTACK                allows alternate signal stacks (see sigaltstack(2)).
> > - * SA_RESTART                flag to get restarting signals (which were the default long ago)
> > - * SA_NODEFER                prevents the current signal from being masked in the handler.
> > - * SA_RESETHAND              clears the handler when the signal is delivered.
> > - *
> > - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> > - * Unix names RESETHAND and NODEFER respectively.
> > + * SA_THIRTYTWO historically meant deliver the signal in 32-bit mode, even if
> > + * the task is running in 26-bit. But since the kernel no longer supports
> > + * 26-bit mode, the flag has no effect.
> >   */
> > -#define SA_NOCLDSTOP 0x00000001
> > -#define SA_NOCLDWAIT 0x00000002
> > -#define SA_SIGINFO   0x00000004
> >  #define SA_THIRTYTWO 0x02000000
>
> > -#define SA_RESTORER  0x04000000
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Was removing SA_RESTOER from arm a typo?
> If not it is probably better to move the removal into a separate patch.

Yes, that was a mistake, thanks for the catch. I'll fix it in v14.

Peter
