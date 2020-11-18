Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00172B7338
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 01:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKRAjf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 19:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRAje (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 19:39:34 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594CC061A48
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 16:39:34 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z14so375263ilp.11
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 16:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sbfjxw3pC8MpPSWm9cZSPR2YSBmckPurKQMcUUNsl30=;
        b=awh9T6J45mhdENvEZi2f1eOsV0Oa07/5ufXvh2qn22YqqZ8oQXcRIwyAUlqLfwnYjn
         hgmRArxYc3Khl9EsFqPP4It/MCNNQ4fXgCHKDjgPbWYQW7IdL3r2TVk2G4No9XzgYayJ
         KO33VFI4O2LbAaTF5veC0F6GPouRA7Aq9udue6nYtaQwEKJLYSbOi6SI4DqVw/Yh2XiZ
         6OIxVa0Nm3Udyzuc2pA8+LJ0lqmP5czaKPjclEjwws9EWjCbbZh4K44tm07z0dTnfyE9
         oGFmwVEmpVi2dvKgMbUQrbzXpCMdNXLBFFnivkTwn5esU4WnPYYwU3QWZe9way43xmHf
         lXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sbfjxw3pC8MpPSWm9cZSPR2YSBmckPurKQMcUUNsl30=;
        b=IIPtwnVgIJ7+WLBw4CUUFaJLWKCEnuhK9NkZ01AWWK6nENw6IYHr0DTpJB3n/6Rums
         ufzS88pumTri4LwRfZ7Wb5HtWkGPwQtik4YcRHnNMNp2gUfLCX1aHovU8gaGyaCIRC/C
         SkBJ7ZkiLaAK0PPIJGRzKWYqDJ+LjhgVxkqTGby32ZSocFyQpgtk7EPSikQ+acCn0Wm3
         TZ9JLAg+2hBzrvTm+ebtrOP0tzal5H+erOw9I/8uDKtE1SJAMdsuxFKNQUv0Om0zIuoE
         hdDZBstRBDlMEgtc1BZwajIFET24gNVyRm4anFVNI03j84XU3wOQjCIMc8f/IueRe1Oa
         tsiA==
X-Gm-Message-State: AOAM531ZAYmKCLqp6fYKOCtaVONJQoI7vTcM8wPs/mgxCcfEMJrZ8cbJ
        1GmPELrCf7jod2BMLOy4paF1xUrjl7FE9kmIB6vALw==
X-Google-Smtp-Source: ABdhPJx3CDcEugJ9oT+32RRhq8HiobubRR5EAMaBIWAeRUsFyNY1tki1dz14QrKvIT8Oa6/vnb4iY7qtqZ9P+SBpFN0=
X-Received: by 2002:a92:d18a:: with SMTP id z10mr13666668ilz.61.1605659973810;
 Tue, 17 Nov 2020 16:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20201117195205.645925-1-pcc@google.com> <877dqj8y2n.fsf@x220.int.ebiederm.org>
In-Reply-To: <877dqj8y2n.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 17 Nov 2020 16:39:23 -0800
Message-ID: <CAMn1gO5NKS6vUvYFHGHxscgXmy_oSSgYZpShCzmoLCEoT6swvA@mail.gmail.com>
Subject: Re: [PATCH v18] arm64: expose FAR_EL1 tag bits in siginfo
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

On Tue, Nov 17, 2020 at 1:37 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
> > index c790f67304ba..fe929e7b77ca 100644
> > --- a/include/uapi/asm-generic/signal-defs.h
> > +++ b/include/uapi/asm-generic/signal-defs.h
> > @@ -20,6 +20,8 @@
> >   * so this bit allows flag bit support to be detected from userspace while
> >   * allowing an old kernel to be distinguished from a kernel that supports every
> >   * flag bit.
> > + * SA_EXPOSE_TAGBITS exposes an architecture-defined set of tag bits in
> > + * siginfo.si_addr.
>
> Do we perhaps want to say the high bits of si_addr?

I wouldn't want to make any specific claims about which bits of
si_addr are involved here since they would not necessarily be the high
bits. For example, imagine a software implementation of tagged
addresses that works by constructing a fake top-level page table such
that it contains N identical references to what from the kernel's
perspective would be the true top-level page table. Assuming that your
architecture does not give you the full 64 bits of address space to
use with page tables your tag bits would be somewhere in the middle.

> >   *
> >   * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> >   * Unix names RESETHAND and NODEFER respectively.
> > @@ -41,6 +43,7 @@
> >  /* 0x00000100 used on sparc */
> >  /* 0x00000200 used on sparc */
> >  #define SA_UNSUPPORTED       0x00000400
> > +#define SA_EXPOSE_TAGBITS    0x00000800
> >  /* 0x00010000 used on mips */
> >  /* 0x01000000 used on x86 */
> >  /* 0x02000000 used on x86 */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 8f34819e80de..576de3d9bd86 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2658,6 +2658,26 @@ bool get_signal(struct ksignal *ksig)
> >
> >               ka = &sighand->action[signr-1];
> >
> > +             if (!(ka->sa.sa_flags & SA_EXPOSE_TAGBITS)) {
> > +                     switch (siginfo_layout(signr, ksig->info.si_code)) {
> > +                     case SIL_FAULT:
> > +                     case SIL_FAULT_MCEERR:
> > +                     case SIL_FAULT_BNDERR:
> > +                     case SIL_FAULT_PKUERR:
> > +                             ksig->info.si_addr = arch_untagged_si_addr(
> > +                                     ksig->info.si_addr, signr,
> > +                                     ksig->info.si_code);
> > +                             break;
> > +                     case SIL_KILL:
> > +                     case SIL_TIMER:
> > +                     case SIL_POLL:
> > +                     case SIL_CHLD:
> > +                     case SIL_RT:
> > +                     case SIL_SYS:
> > +                             break;
> > +                     }
> > +             }
> > +
> >               /* Trace actually delivered signals. */
> >               trace_signal_deliver(signr, &ksig->info, ka);
>
> Overall this looks good.
>
> It is a common path so I wonder about the generated code, and how close
> to a noop this becomes on x86 and other architetures without tag bits.

I would in general expect compilers to be able to optimize all of this
away on non-arm64 architectures because the compiler has enough
information to know that the code isn't doing anything. Indeed I
compiled the kernel for x86_64 with and without this change and the
size of kernel/signal.o was the same.

> Can you put this blob of code in it's own function (perhaps called
> hide_si_addr_tag_bits) and call it right after "ksig->sig = signr" line?
>
> Effectively that is the same place in the code but it gets it outside of
> the sighand lock.  The tracing code does not care as it does not look at
> si_addr.
>
> I am concerned with the complexity of reading get_signal and using a
> well named inline function should make it unnecessary to read that
> code unless you care about what is going on.
>
> Further having the code outside of the lock at the end of get_signal
> with nothing else going on seems much easier to reason about.  The code
> is get_signal is something that needs reading and reasoning about.

Okay, done in v19.

Peter
