Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA92ACB2E
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 03:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKJChs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Nov 2020 21:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKJChs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Nov 2020 21:37:48 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582CC0613CF
        for <linux-api@vger.kernel.org>; Mon,  9 Nov 2020 18:37:48 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id w3so3493881uau.2
        for <linux-api@vger.kernel.org>; Mon, 09 Nov 2020 18:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W083W3zrh3QY6OTjhs2qYwv31txh8X4qSe/AUSBbO3k=;
        b=tegnM0xTqMsZgdhH/hg6wNF48E5hhyAI/dAcxG3lfN2zUqZZGqu/3MhB2R1UQVNyPw
         5MJXO4pi9phvJQHhtg9ZYa5g04rig/25YaNMOS/cUNn6cb2KuvNyLMwMbYs//HCd4bu6
         n4LAloqvUdn4JJefC0C71O4aAwcxgeuQyHupetLaDyU/AUuhr2PnfKBWYRHw7yXdWzOu
         ipCmr1GBpS9tGtbNvS29nLgWXCZGIcWVje4NToDRdgfoKfHRqs5KGdMhupDE9j2BsGvN
         LaMnN8rLgyYwfGfar+yUErXabjUJZSVyg2EkxuhwJWKgOQZGJWarqb0H/sRuERFDUf+A
         JKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W083W3zrh3QY6OTjhs2qYwv31txh8X4qSe/AUSBbO3k=;
        b=Oi3ih7/+PhR+2jPRTKIwDiqPlHivQNCyisTn8viBSO92iCG9WIIwy9T94GCXHQSwQy
         XIk6UHwskDpehO4wY4LcgKd04XrI7N9aJPwZmVCpAcpQ4qHHII4CPfgszHcwCtpXbq3x
         7YX0lUSgJdjgNn2Btahv/r1LfudKXNN/1QCOOooRi+sjh4++HeJPrSnZ9wFnD+bkG7Gf
         BE6ENxdNeJECCFxkYa/Y4DSTDusNLdrW+TnHrFbKHvJbbZbkYqkRmNUe36tQIdRoy+KD
         rM79RhGXSVUP6w6B8xWG3auEZEPjyv1EqqqCPSbf4erICGfqSE7PTfeSLJAZk1SAjt6B
         qPbQ==
X-Gm-Message-State: AOAM530vjkzO46HQsc2c8GESHPcCW00Rc04Qf41XFeioM1LIT6gSGlBR
        VWr+d89vuwCgh0h3dORhZJpZQeQyEnoDC9XhG1W6dg==
X-Google-Smtp-Source: ABdhPJzWAF5I1nhNhIu8BYn8Mn4LdyKxjywlIK1RFymwVV/JQB+sc3IDDviFFvvxWikjVBgZZqTbD0yDffSUlMf35z0=
X-Received: by 2002:a9f:28a7:: with SMTP id d36mr9388703uad.37.1604975867093;
 Mon, 09 Nov 2020 18:37:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604523707.git.pcc@google.com> <4d826a62121153d54d7e36fc8a402c97e2106764.1604523707.git.pcc@google.com>
 <87lffa11sa.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lffa11sa.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 9 Nov 2020 18:37:36 -0800
Message-ID: <CAMn1gO63+7ZxcvSyHt1nrTQ+N=zk=xGYNiToRxwRcP5=UsQmsQ@mail.gmail.com>
Subject: Re: [PATCH v14 4/8] signal: deduplicate code dealing with common
 _sigfault fields
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

On Mon, Nov 9, 2020 at 4:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > We're about to add more common _sigfault fields, so deduplicate the
> > existing code for initializing _sigfault fields in {send,force}_sig_*,
> > and for copying _sigfault fields in copy_siginfo_to_external32 and
> > post_copy_siginfo_from_user32, to reduce the number of places that
> > will need to be updated by upcoming changes.
>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks for the review.

> No real objection but I am wondering if it might be better to
> introduce two small inline functions for setting common fields
> instead of:
>
> > +     if (siginfo_layout_is_fault(layout)) {
> > +             to->si_addr = ptr_to_compat(from->si_addr);
> > +#ifdef __ARCH_SI_TRAPNO
> > +             to->si_trapno = from->si_trapno;
> > +#endif
> > +     }
>
> and
>
> > +     if (siginfo_layout_is_fault(layout)) {
> > +             to->si_addr = compat_ptr(from->si_addr);
> > +#ifdef __ARCH_SI_TRAPNO
> > +             to->si_trapno = from->si_trapno;
> > +#endif
> > +     }
>
> perhaps called:
> copy_sigfault_common_to_external32
> post_copy_sigfault_common_from_user32
>
> I have not benchmarked or anything but my gut says one less conditional
> branch to worry about makes dealing with spectre easier and probably
> produces faster code as well.  Possibly even smaller code.

Dave made the same proposal on an earlier version of the patch which I
responded to in [1]. The main reason for keeping things as I
implemented them was because of the ptrace handling but if we do end
up dropping that as you proposed on the other patch then I think I'd
be happy to move the code into helper functions.

Peter

[1] https://lore.kernel.org/linux-parisc/CAMn1gO42arQKGBj1Nnbs86TGYyogpRR_t73H=GbTmQrbAbV30A@mail.gmail.com/

>
> Eric
>
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/I4f56174e1b7b2bf4a3c8139e6879cbfd52750a24
> > ---
> >  include/linux/signal.h |  13 ++++++
> >  kernel/signal.c        | 101 ++++++++++++++++-------------------------
> >  2 files changed, 53 insertions(+), 61 deletions(-)
> >
> > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > index b256f9c65661..e9fb05041e7a 100644
> > --- a/include/linux/signal.h
> > +++ b/include/linux/signal.h
> > @@ -50,6 +50,19 @@ enum siginfo_layout {
> >
> >  enum siginfo_layout siginfo_layout(unsigned sig, int si_code);
> >
> > +static inline bool siginfo_layout_is_fault(enum siginfo_layout layout)
> > +{
> > +     switch (layout) {
> > +     case SIL_FAULT:
> > +     case SIL_FAULT_MCEERR:
> > +     case SIL_FAULT_BNDERR:
> > +     case SIL_FAULT_PKUERR:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> >  /*
> >   * Define some primitives to manipulate sigset_t.
> >   */
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index ef8f2a28d37c..74e7315c24db 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1650,6 +1650,15 @@ void force_sigsegv(int sig)
> >       force_sig(SIGSEGV);
> >  }
> >
> > +static void set_sigfault_common_fields(struct kernel_siginfo *info, int sig,
> > +                                    int code, void __user *addr)
> > +{
> > +     info->si_signo = sig;
> > +     info->si_errno = 0;
> > +     info->si_code = code;
> > +     info->si_addr = addr;
> > +}
> > +
> >  int force_sig_fault_to_task(int sig, int code, void __user *addr
> >       ___ARCH_SI_TRAPNO(int trapno)
> >       ___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
> > @@ -1658,10 +1667,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
> >       struct kernel_siginfo info;
> >
> >       clear_siginfo(&info);
> > -     info.si_signo = sig;
> > -     info.si_errno = 0;
> > -     info.si_code  = code;
> > -     info.si_addr  = addr;
> > +     set_sigfault_common_fields(&info, sig, code, addr);
> >  #ifdef __ARCH_SI_TRAPNO
> >       info.si_trapno = trapno;
> >  #endif
> > @@ -1690,10 +1696,7 @@ int send_sig_fault(int sig, int code, void __user *addr
> >       struct kernel_siginfo info;
> >
> >       clear_siginfo(&info);
> > -     info.si_signo = sig;
> > -     info.si_errno = 0;
> > -     info.si_code  = code;
> > -     info.si_addr  = addr;
> > +     set_sigfault_common_fields(&info, sig, code, addr);
> >  #ifdef __ARCH_SI_TRAPNO
> >       info.si_trapno = trapno;
> >  #endif
> > @@ -1711,10 +1714,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
> >
> >       WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
> >       clear_siginfo(&info);
> > -     info.si_signo = SIGBUS;
> > -     info.si_errno = 0;
> > -     info.si_code = code;
> > -     info.si_addr = addr;
> > +     set_sigfault_common_fields(&info, SIGBUS, code, addr);
> >       info.si_addr_lsb = lsb;
> >       return force_sig_info(&info);
> >  }
> > @@ -1725,10 +1725,7 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
> >
> >       WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
> >       clear_siginfo(&info);
> > -     info.si_signo = SIGBUS;
> > -     info.si_errno = 0;
> > -     info.si_code = code;
> > -     info.si_addr = addr;
> > +     set_sigfault_common_fields(&info, SIGBUS, code, addr);
> >       info.si_addr_lsb = lsb;
> >       return send_sig_info(info.si_signo, &info, t);
> >  }
> > @@ -1739,10 +1736,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
> >       struct kernel_siginfo info;
> >
> >       clear_siginfo(&info);
> > -     info.si_signo = SIGSEGV;
> > -     info.si_errno = 0;
> > -     info.si_code  = SEGV_BNDERR;
> > -     info.si_addr  = addr;
> > +     set_sigfault_common_fields(&info, SIGSEGV, SEGV_BNDERR, addr);
> >       info.si_lower = lower;
> >       info.si_upper = upper;
> >       return force_sig_info(&info);
> > @@ -1754,10 +1748,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
> >       struct kernel_siginfo info;
> >
> >       clear_siginfo(&info);
> > -     info.si_signo = SIGSEGV;
> > -     info.si_errno = 0;
> > -     info.si_code  = SEGV_PKUERR;
> > -     info.si_addr  = addr;
> > +     set_sigfault_common_fields(&info, SIGSEGV, SEGV_PKUERR, addr);
> >       info.si_pkey  = pkey;
> >       return force_sig_info(&info);
> >  }
> > @@ -1771,10 +1762,8 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
> >       struct kernel_siginfo info;
> >
> >       clear_siginfo(&info);
> > -     info.si_signo = SIGTRAP;
> > +     set_sigfault_common_fields(&info, SIGTRAP, TRAP_HWBKPT, addr);
> >       info.si_errno = errno;
> > -     info.si_code  = TRAP_HWBKPT;
> > -     info.si_addr  = addr;
> >       return force_sig_info(&info);
> >  }
> >
> > @@ -3267,12 +3256,23 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
> >  void copy_siginfo_to_external32(struct compat_siginfo *to,
> >               const struct kernel_siginfo *from)
> >  {
> > +     enum siginfo_layout layout =
> > +             siginfo_layout(from->si_signo, from->si_code);
> > +
> >       memset(to, 0, sizeof(*to));
> >
> >       to->si_signo = from->si_signo;
> >       to->si_errno = from->si_errno;
> >       to->si_code  = from->si_code;
> > -     switch(siginfo_layout(from->si_signo, from->si_code)) {
> > +
> > +     if (siginfo_layout_is_fault(layout)) {
> > +             to->si_addr = ptr_to_compat(from->si_addr);
> > +#ifdef __ARCH_SI_TRAPNO
> > +             to->si_trapno = from->si_trapno;
> > +#endif
> > +     }
> > +
> > +     switch (layout) {
> >       case SIL_KILL:
> >               to->si_pid = from->si_pid;
> >               to->si_uid = from->si_uid;
> > @@ -3287,31 +3287,15 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
> >               to->si_fd   = from->si_fd;
> >               break;
> >       case SIL_FAULT:
> > -             to->si_addr = ptr_to_compat(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               break;
> >       case SIL_FAULT_MCEERR:
> > -             to->si_addr = ptr_to_compat(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               to->si_addr_lsb = from->si_addr_lsb;
> >               break;
> >       case SIL_FAULT_BNDERR:
> > -             to->si_addr = ptr_to_compat(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               to->si_lower = ptr_to_compat(from->si_lower);
> >               to->si_upper = ptr_to_compat(from->si_upper);
> >               break;
> >       case SIL_FAULT_PKUERR:
> > -             to->si_addr = ptr_to_compat(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               to->si_pkey = from->si_pkey;
> >               break;
> >       case SIL_CHLD:
> > @@ -3348,11 +3332,22 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
> >  static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
> >                                        const struct compat_siginfo *from)
> >  {
> > +     enum siginfo_layout layout =
> > +             siginfo_layout(from->si_signo, from->si_code);
> > +
> >       clear_siginfo(to);
> >       to->si_signo = from->si_signo;
> >       to->si_errno = from->si_errno;
> >       to->si_code  = from->si_code;
> > -     switch(siginfo_layout(from->si_signo, from->si_code)) {
> > +
> > +     if (siginfo_layout_is_fault(layout)) {
> > +             to->si_addr = compat_ptr(from->si_addr);
> > +#ifdef __ARCH_SI_TRAPNO
> > +             to->si_trapno = from->si_trapno;
> > +#endif
> > +     }
> > +
> > +     switch (layout) {
> >       case SIL_KILL:
> >               to->si_pid = from->si_pid;
> >               to->si_uid = from->si_uid;
> > @@ -3367,31 +3362,15 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
> >               to->si_fd   = from->si_fd;
> >               break;
> >       case SIL_FAULT:
> > -             to->si_addr = compat_ptr(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               break;
> >       case SIL_FAULT_MCEERR:
> > -             to->si_addr = compat_ptr(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               to->si_addr_lsb = from->si_addr_lsb;
> >               break;
> >       case SIL_FAULT_BNDERR:
> > -             to->si_addr = compat_ptr(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               to->si_lower = compat_ptr(from->si_lower);
> >               to->si_upper = compat_ptr(from->si_upper);
> >               break;
> >       case SIL_FAULT_PKUERR:
> > -             to->si_addr = compat_ptr(from->si_addr);
> > -#ifdef __ARCH_SI_TRAPNO
> > -             to->si_trapno = from->si_trapno;
> > -#endif
> >               to->si_pkey = from->si_pkey;
> >               break;
> >       case SIL_CHLD:
