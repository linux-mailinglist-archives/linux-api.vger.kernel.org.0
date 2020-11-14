Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832282B311F
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 23:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKNWMz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 14 Nov 2020 17:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKNWMz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 14 Nov 2020 17:12:55 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D26C0613D1
        for <linux-api@vger.kernel.org>; Sat, 14 Nov 2020 14:12:53 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id q68so4172132uaq.3
        for <linux-api@vger.kernel.org>; Sat, 14 Nov 2020 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OjP+5cGWBCk9BbSjj8EDVAtK1851f4Lffv0hXOM8z8=;
        b=irkiHpVxhHRY3MPSDQGfzoZvWp+7NxBjIluu0Dmqr94EmVXOMYupJxP/crA77YdeeT
         TGBl8NkDunJg+m5KTCrYuhyjwD3PltGKr84BCwjh0pyqyLIiUkhdnoZ8umWpMsMYRixU
         Xo5swWjIwvwUpYUKG95kFheBQLOZvGYwJqlF7qBcFsBJ9fLyFTy1x1n4/hcGCJE561qH
         VgpTHYz8OkecLHbSRMOeAcCdsu12KulOoXgAdnXy6EBYUpvMRcT98RpJ5MN0+9b5VefV
         DP4hgOrdrRCDb8gR7J38sjVfqVxl6JD2exe8u/8/6KLEr4FEPojxD191hQme+Wsfz2bR
         9NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OjP+5cGWBCk9BbSjj8EDVAtK1851f4Lffv0hXOM8z8=;
        b=e3svAtiPDEZ+EalmYc45ezfbeg1CHeG+olGQ3AWX6zZtUz7BNNVV2WRI52YmL9V8wE
         WInYEzIVZ/kV/3lHoYzIq5otczHdtb9vf1Em/bPY0pUnXhpJu8AhoykE6KtCvFpZr+7M
         BQoypjicrV0RKG9gY0+f12D71tHatOt/+AqmGly21OJvvRUVcmO6+M6sMXzh3yWAUqtN
         iGjO1O+2KkbWgmqqmSBtHAjpkW3lxV6eAKFEk+gVf6r2vLlHsONb4J/cZr1Jxdvp2YOE
         n0dQzT8YtlRXpIXSn+vGH6OEVY6a/lcbeUHuYGE3mwVlS9sANw9zzZ3TvIZsAd1eZLA2
         0Y4Q==
X-Gm-Message-State: AOAM530BK6yYRO8wJFtVZFxBy83AcQqpi5mIPSiBOs+ePYXd2jNgX6Nn
        69d6DG3uLYzov86/ZRXiPkm1y8ma4UN1d41McK1hOQ==
X-Google-Smtp-Source: ABdhPJy/B9v01IhKdrfHLsHPTm2zHqxHyHu8/Q5oALqHy3KjEXOiRoQZTntUGwJ3l4QL4WR6c4qrMf63B2hiowceTxQ=
X-Received: by 2002:ab0:6dd1:: with SMTP id r17mr4803203uaf.108.1605391972076;
 Sat, 14 Nov 2020 14:12:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605235762.git.pcc@google.com> <3581410892be6851d804bbbb84fccf06073f1262.1605235762.git.pcc@google.com>
 <878sb4nixz.fsf@x220.int.ebiederm.org>
In-Reply-To: <878sb4nixz.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Sat, 14 Nov 2020 14:12:41 -0800
Message-ID: <CAMn1gO52j4fSEn5S2GdrtyCq+iiaMK16DkKiyj=Go91Jy+xR-w@mail.gmail.com>
Subject: Re: [PATCH v16 5/6] signal: define the SA_UNSUPPORTED bit in sa_flags
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
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 14, 2020 at 5:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > Define a sa_flags bit, SA_UNSUPPORTED, which will never be supported
> > in the uapi. The purpose of this flag bit is to allow userspace to
> > distinguish an old kernel that does not clear unknown sa_flags bits
> > from a kernel that supports every flag bit.
> >
> > In other words, if userspace does something like:
> >
> >   act.sa_flags |= SA_UNSUPPORTED;
> >   sigaction(SIGSEGV, &act, 0);
> >   sigaction(SIGSEGV, 0, &oldact);
> >
> > and finds that SA_UNSUPPORTED remains set in oldact.sa_flags, it means
> > that the kernel cannot be trusted to have cleared unknown flag bits
> > from sa_flags, so no assumptions about flag bit support can be made.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Link: https://linux-review.googlesource.com/id/Ic2501ad150a3a79c1cf27fb8c99be342e9dffbcb
> > ---
> > v11:
> > - clarify the commit message
> >
> >  include/uapi/asm-generic/signal-defs.h | 7 +++++++
> >  kernel/signal.c                        | 6 ++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
> > index 493953fe319b..0126ebda4d31 100644
> > --- a/include/uapi/asm-generic/signal-defs.h
> > +++ b/include/uapi/asm-generic/signal-defs.h
> > @@ -14,6 +14,12 @@
> >   * SA_RESTART flag to get restarting signals (which were the default long ago)
> >   * SA_NODEFER prevents the current signal from being masked in the handler.
> >   * SA_RESETHAND clears the handler when the signal is delivered.
> > + * SA_UNSUPPORTED is a flag bit that will never be supported. Kernels from
> > + * before the introduction of SA_UNSUPPORTED did not clear unknown bits from
> > + * sa_flags when read using the oldact argument to sigaction and rt_sigaction,
> > + * so this bit allows flag bit support to be detected from userspace while
> > + * allowing an old kernel to be distinguished from a kernel that supports every
> > + * flag bit.
> >   *
> >   * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> >   * Unix names RESETHAND and NODEFER respectively.
> > @@ -42,6 +48,7 @@
> >  #ifndef SA_RESETHAND
> >  #define SA_RESETHAND 0x80000000
> >  #endif
> > +#define SA_UNSUPPORTED       0x00000400
>
> Why this value and why not in numerical order with the other flags?
>
> At the very least not being in order with the other bits makes it
> a little easier to overlook it and define something at that position.

The value is because this is the first bit that isn't already taken by
an architecture-specific flag bit. It seems okay to move it into
numerical order.

The taken flag bits are listed in the comment that I added in patch 3.
Do you think there would be a more prominent way to document them?
Maybe we can replace that comment with inline, in-order comments along
the lines of:

#ifndef SA_NOCLDSTOP
#define SA_NOCLDSTOP   0x00000001
#endif
#ifndef SA_NOCLDWAIT
#define SA_NOCLDWAIT   0x00000002
#endif
#ifndef SA_SIGINFO
#define SA_SIGINFO     0x00000004
#endif
/* 0x00000008 has arch-specific definition */
/* 0x00000010 has arch-specific definition */

etc.

And then this patch would add the new bit in the right place.

Peter

>
> Eric
>
>
> >  #define SA_NOMASK    SA_NODEFER
> >  #define SA_ONESHOT   SA_RESETHAND
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 8f5bd12ee41b..8f34819e80de 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3985,6 +3985,12 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
> >       if (oact)
> >               *oact = *k;
> >
> > +     /*
> > +      * Make sure that we never accidentally claim to support SA_UNSUPPORTED,
> > +      * e.g. by having an architecture use the bit in their uapi.
> > +      */
> > +     BUILD_BUG_ON(UAPI_SA_FLAGS & SA_UNSUPPORTED);
> > +
> >       /*
> >        * Clear unknown flag bits in order to allow userspace to detect missing
> >        * support for flag bits and to allow the kernel to use non-uapi bits
