Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E22ACAF1
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 03:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgKJCTW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Nov 2020 21:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJCTV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Nov 2020 21:19:21 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B48C0613CF
        for <linux-api@vger.kernel.org>; Mon,  9 Nov 2020 18:19:21 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id h5so6177107vsp.3
        for <linux-api@vger.kernel.org>; Mon, 09 Nov 2020 18:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejYZsUMVEPBEz1Bf5UylqJkez0rDQPXxmwo7fwvyNj8=;
        b=JNykQ+TLk/9Cz6btxqhdWDnilzmPwk46N3tb1Ib0zvi9v/+i7L/UBBAzmKWgLNUtrF
         a0sVsTidJz5ziT5SbetmZCx4JjT/f4qOp9dYXAtqyKagd3o+ZzFI/qWgC9RA8K9OemK/
         syZQfz7/wFfuldiVQYZKSSzUP9HIbuWQe7jwztlelTTP0p2hkyLKMdiipYRWlqmkVNUP
         vX/P6uUAMt7JUnggp8zGa5D4vVKmAbvnOQRREEh4POZ0moLhHnPmEqRv109qTOUxvGaJ
         meCt7Zj4B2Qqe7YWWerAlkmUYWJ0klMKtoiZL4B/ragvYDgwsPADlvQHPZYLh1qQ+xIe
         AU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejYZsUMVEPBEz1Bf5UylqJkez0rDQPXxmwo7fwvyNj8=;
        b=eIVeJ1A5cP86wTu4M6Q58zRnfmZQXOj0Ywl6BIx4bQkIGQTW+pciCsmA1gsCBg9QUE
         t7kQIHFzOBeAQuEFWGn9pJm8yTY8ubCKoqcnFsn3ViPa8JYX9zrJ9VhZmeGGQOmAWRDW
         iO3w7ZNqOnz4qcMljl8nySvvWJwFpav8RQkHAuN1s5dN9v58HvTS3rxr8C7J9uxMzPUK
         3ZwdOz7QbcqhMDHiwA/phf6opKAv2mbqzm5TfPe7r9Zh104V5S/Ar6j0tsrmbT/I2weu
         Hc2JEyRvkXoeSSLYI+F8B8qvRjE0s/MlXe23qPwYnjgAoICuc2qMekLV0x6Amofphh0F
         QtPg==
X-Gm-Message-State: AOAM533hRxywbLkD9HarJGosoFZemWsNnHuxvfiviF0+tw6ql/4rtneU
        w+ktpG53smG+5e37CVmaMXpGVH/NndVXspYExSsm6Q==
X-Google-Smtp-Source: ABdhPJx2kxWl8DJQjgRLd0etePjpBXBJ77Asfsu8E6oETtWPhVnNT3UMQY3yfmMdil+ZtlMk4X3RfxqsxhICx+eJywg=
X-Received: by 2002:a67:ed4b:: with SMTP id m11mr727963vsp.14.1604974760468;
 Mon, 09 Nov 2020 18:19:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604523707.git.pcc@google.com> <039adb228822eb1f0c90cbfc716fc28fa298c58e.1604523707.git.pcc@google.com>
 <871rh22gml.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rh22gml.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 9 Nov 2020 18:19:09 -0800
Message-ID: <CAMn1gO4wZsR6Byg7AvPTxrji8GDmU3LXWKQPMnv_G2zMkkJwWA@mail.gmail.com>
Subject: Re: [PATCH v14 5/8] signal: clear non-uapi flag bits when
 passing/returning sa_flags
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
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 9, 2020 at 4:35 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> 2> Previously we were not clearing non-uapi flag bits in
> > sigaction.sa_flags when storing the userspace-provided sa_flags or
> > when returning them via oldact. Start doing so.
> >
> > This allows userspace to detect missing support for flag bits and
> > allows the kernel to use non-uapi bits internally, as we are already
> > doing in arch/x86 for two flag bits. Now that this change is in
> > place, we no longer need the code in arch/x86 that was hiding these
> > bits from userspace, so remove it.
> >
> > This is technically a userspace-visible behavior change for sigaction, as
> > the unknown bits returned via oldact.sa_flags are no longer set. However,
> > we are free to define the behavior for unknown bits exactly because
> > their behavior is currently undefined, so for now we can define the
> > meaning of each of them to be "clear the bit in oldact.sa_flags unless
> > the bit becomes known in the future". Furthermore, this behavior is
> > consistent with OpenBSD [1], illumos [2] and XNU [3] (FreeBSD [4] and
> > NetBSD [5] fail the syscall if unknown bits are set). So there is some
> > precedent for this behavior in other kernels, and in particular in XNU,
> > which is probably the most popular kernel among those that I looked at,
> > which means that this change is less likely to be a compatibility
> > issue.
>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Yes.  The x86_64 case and general good sense suggests that this patch
> will be harmless.

Thanks for the review.

> I suspect we should at least try and take this one step farther
> (with an additional patch) that causes an error if any new flags
> are passed.  Or do we know of some userspace application that
> currently passes bogus flags?

I'm not aware of any such userspace applications, but that doesn't
mean that there aren't any of course. Probably the most plausible way
in which I can see us ending up with userspace applications setting
bogus flags is if the application leaves sa_flags uninitialized and
installs a signal handler that doesn't care which flags were set as
long as the handler ends up being called somehow. I don't think it's
outside the realm of possibility that there is an application out
there on Android doing something like this, and if we discovered such
an application (which may happen long after we make the kernel
change), that may require us to change the behavior on Android at
least, which may have implications for flag support detection code
that is necessarily sensitive to sigaction's precise behavior, and may
create a divergence between Android and upstream Linux, which is
something that we really want to avoid. So I would be at least
slightly concerned about making such a change.

Another concern is that it would further complicate the flag support
detection protocol beyond what would be required if we assume success
on unknown flags. If we succeed on unknown flags we just need two
calls to sigaction (one to set the handler, and another to check
oldact), but if we fail on unknown flags I think we would need three
(or more, if the userspace code has multiple flags to test for). The
userspace code would look something like this:

// The next call will only succeed on kernels from before we started
// rejecting unknown flags. Therefore, if it succeeds, it should install the
// handler for old kernels.
struct sigaction sa = {};
sa.sa_flags = SA_SIGINFO | SA_UNSUPPORTED;
sa.sa_sigaction = old_kernel_handler;
if (sigaction(SIGSEGV, &sa, 0) < 0) {
  // Okay, we're on a kernel that rejects unknown flags.
  // The next call will only succeed if we have SA_FAULTFLAGS support,
  // so we try to install the handler for new kernels.
  sa.sa_flags = SA_SIGINFO | SA_FAULTFLAGS;
  sa.sa_sigaction = new_kernel_handler;
  if (sigaction(SIGSEGV, &sa, 0) < 0) {
    // We're on a kernel from between when we started rejecting unknown
    // flags and when we started supporting SA_FAULTFLAGS. Therefore
    // we need to install the handler for old kernels.
    sa.sa_flags = SA_SIGINFO;
    sa.sa_sigaction = old_kernel_handler;
    sigaction(SIGSEGV, &sa, 0);
  }
}

Peter

>
>
>
> > Link: [1] https://github.com/openbsd/src/blob/f634a6a4b5bf832e9c1de77f7894ae2625e74484/sys/kern/kern_sig.c#L278
> > Link: [2] https://github.com/illumos/illumos-gate/blob/76f19f5fdc974fe5be5c82a556e43a4df93f1de1/usr/src/uts/common/syscall/sigaction.c#L86
> > Link: [3] https://github.com/apple/darwin-xnu/blob/a449c6a3b8014d9406c2ddbdc81795da24aa7443/bsd/kern/kern_sig.c#L480
> > Link: [4] https://github.com/freebsd/freebsd/blob/eded70c37057857c6e23fae51f86b8f8f43cd2d0/sys/kern/kern_sig.c#L699
> > Link: [5] https://github.com/NetBSD/src/blob/3365779becdcedfca206091a645a0e8e22b2946e/sys/kern/sys_sig.c#L473
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Link: https://linux-review.googlesource.com/id/I35aab6f5be932505d90f3b3450c083b4db1eca86
> > ---
> > v10:
> > - rename SA_UAPI_FLAGS -> UAPI_SA_FLAGS
> > - refactor how we define it to avoid mentioning flags more
> >   than once
> >
> >  arch/arm/include/asm/signal.h    |  2 ++
> >  arch/parisc/include/asm/signal.h |  2 ++
> >  arch/x86/kernel/signal_compat.c  |  7 -------
> >  include/linux/signal_types.h     | 12 ++++++++++++
> >  kernel/signal.c                  | 10 ++++++++++
> >  5 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/signal.h b/arch/arm/include/asm/signal.h
> > index 65530a042009..430be7774402 100644
> > --- a/arch/arm/include/asm/signal.h
> > +++ b/arch/arm/include/asm/signal.h
> > @@ -17,6 +17,8 @@ typedef struct {
> >       unsigned long sig[_NSIG_WORDS];
> >  } sigset_t;
> >
> > +#define __ARCH_UAPI_SA_FLAGS (SA_THIRTYTWO | SA_RESTORER)
> > +
> >  #define __ARCH_HAS_SA_RESTORER
> >
> >  #include <asm/sigcontext.h>
> > diff --git a/arch/parisc/include/asm/signal.h b/arch/parisc/include/asm/signal.h
> > index 715c96ba2ec8..30dd1e43ef88 100644
> > --- a/arch/parisc/include/asm/signal.h
> > +++ b/arch/parisc/include/asm/signal.h
> > @@ -21,6 +21,8 @@ typedef struct {
> >       unsigned long sig[_NSIG_WORDS];
> >  } sigset_t;
> >
> > +#define __ARCH_UAPI_SA_FLAGS _SA_SIGGFAULT
> > +
> >  #include <asm/sigcontext.h>
> >
> >  #endif /* !__ASSEMBLY */
> > diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> > index a7f3e12cfbdb..ddfd919be46c 100644
> > --- a/arch/x86/kernel/signal_compat.c
> > +++ b/arch/x86/kernel/signal_compat.c
> > @@ -165,16 +165,9 @@ void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
> >  {
> >       signal_compat_build_tests();
> >
> > -     /* Don't leak in-kernel non-uapi flags to user-space */
> > -     if (oact)
> > -             oact->sa.sa_flags &= ~(SA_IA32_ABI | SA_X32_ABI);
> > -
> >       if (!act)
> >               return;
> >
> > -     /* Don't let flags to be set from userspace */
> > -     act->sa.sa_flags &= ~(SA_IA32_ABI | SA_X32_ABI);
> > -
> >       if (in_ia32_syscall())
> >               act->sa.sa_flags |= SA_IA32_ABI;
> >       if (in_x32_syscall())
> > diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
> > index f8a90ae9c6ec..a7887ad84d36 100644
> > --- a/include/linux/signal_types.h
> > +++ b/include/linux/signal_types.h
> > @@ -68,4 +68,16 @@ struct ksignal {
> >       int sig;
> >  };
> >
> > +#ifndef __ARCH_UAPI_SA_FLAGS
> > +#ifdef SA_RESTORER
> > +#define __ARCH_UAPI_SA_FLAGS SA_RESTORER
> > +#else
> > +#define __ARCH_UAPI_SA_FLAGS 0
> > +#endif
> > +#endif
> > +
> > +#define UAPI_SA_FLAGS                                                          \
> > +     (SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
> > +      SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
> > +
> >  #endif /* _LINUX_SIGNAL_TYPES_H */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 74e7315c24db..832b654dee8c 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3964,6 +3964,16 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
> >       if (oact)
> >               *oact = *k;
> >
> > +     /*
> > +      * Clear unknown flag bits in order to allow userspace to detect missing
> > +      * support for flag bits and to allow the kernel to use non-uapi bits
> > +      * internally.
> > +      */
> > +     if (act)
> > +             act->sa.sa_flags &= UAPI_SA_FLAGS;
> > +     if (oact)
> > +             oact->sa.sa_flags &= UAPI_SA_FLAGS;
> > +
> >       sigaction_compat_abi(act, oact);
> >
> >       if (act) {
