Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847033D823A
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhG0WAX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhG0WAW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Jul 2021 18:00:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC08C061757
        for <linux-api@vger.kernel.org>; Tue, 27 Jul 2021 15:00:22 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f11so542074ioj.3
        for <linux-api@vger.kernel.org>; Tue, 27 Jul 2021 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tz27L2xymBSA/ePNcx9XWRL9ZWND6PMR5qj+3yVjmw0=;
        b=DeiunGFvQdsNF5MhgwXhvQ090t0D91mrc2h/B9XIa2jr3YsI8WWGi4rcEW5VaJOo8z
         f7RMH7YWOgr17iNfgF2nn9WeTRRHBpOuiWohbO3WHtwuNQTBLqMLlkMCAzUIiCuzB3of
         loWmijMSDuo/xRf72dAVBk6Lial2XBlgw4v/rkL4FNsyVrsBhfbAsA3YiUv7md2hGQi9
         HYcCmhVcOXJU7pyOV0cO7+c7jCE0VfXp15nNPmmfLsTkTAzQlI24t1I5iHnh+PE2PxmR
         WxjRZXl3n/O1j5zFT2/uPJabI699ktQOcn9mZ3eIsaeAN+tWsQiPc73xzZSprJoauN8K
         kF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tz27L2xymBSA/ePNcx9XWRL9ZWND6PMR5qj+3yVjmw0=;
        b=RAStB9m60oGPC3IlBKlmE+RqEZ1Wm9+rRxnfPq8fgNDjGnoKEkJdCj0SPfv6OWjOqa
         HxwK0QGg8WvWzPhNIfSqhXBZfCvfAVkjKqGiRpXdTDcyGXavY4FM/NLXRu5SWOfqRT9a
         QAFKM8TSMH5L3W51kzVA7eDG1oHa+BfSx20bQnIxxz7VNRIUTvWWaklqtGdk2OXl77ya
         L0c3hCK9BH+IW8qlzVb1lpsZ4cY6pFXiTHh2GUhPAfa80npKm0pRhEz5WPpqun/1vIOx
         TWn0RlAHHH4DX2gYj9+Nec0+0EWFll7JyIrj6EAeav0m8sAOG7jCPNBvFEtHVaik364W
         hcWA==
X-Gm-Message-State: AOAM533FJnT+V2rNPLYNzSsAzrDNulsvb0iJ6vT0uasXuBFbLpKpLlfA
        Fgnf58o512eaUyroIe3IRcba/uxpRO8yZc9nZAA+ew==
X-Google-Smtp-Source: ABdhPJxhQnt23Ae+G6XB/6Dh2n6rSWmDYhKd2XuDo5k61vLPlH8zwrPR7PH9fHKyFaOd2JNFbzt1XpEGVXofMLIMoyU=
X-Received: by 2002:a02:cab9:: with SMTP id e25mr23050058jap.25.1627423221533;
 Tue, 27 Jul 2021 15:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210622051204.3682580-1-pcc@google.com> <20210727165109.GB13920@arm.com>
In-Reply-To: <20210727165109.GB13920@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 27 Jul 2021 15:00:10 -0700
Message-ID: <CAMn1gO7DcY4tWu0Q7XsZAt-pEmD-4S64sMzu_gARH7Pvc8sP8g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: allow TCR_EL1.TBID0 to be configured
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 27, 2021 at 9:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Peter,
>
> On Mon, Jun 21, 2021 at 10:12:04PM -0700, Peter Collingbourne wrote:
> > Introduce a command line flag that controls whether TCR_EL1.TBID0
> > is set at boot time. Since this is a change to the userspace ABI the
> > option defaults to off for now, although it seems likely that we'll
> > be able to change the default at some future point.
> >
> > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > the pointer authentication instructions for instruction addresses by 8,
> > which improves the security of pointer authentication, but it also has
> > the consequence of changing the operation of the branch instructions
> > so that they no longer ignore the top byte of the target address but
> > instead fault if they are non-zero.
>
> I'm a bit uneasy about the ABI change and not so keen on constraining
> the ABI through the kernel command line. Ideally we should make this an
> opt-in per application (prctl()) but that has some aspects to address

This doesn't necessarily need to be the end state, we can enhance this
based on need. For example, we could choose to take this patch now and
later implement the per-process opt-in where the default is controlled
by the command line. Or just implement the software-only per-process
TBID0 almost-disablement which would be much simpler than doing it in
hardware, if that is enough to satisfy future needs. Otherwise we risk
adding "unused" complexity to the kernel that we can never remove due
to API stability guarantees.

> first: (a) this bit is permitted to be cached in the TLB so we'd need
> some TLBI when setting it (and a clarification in the specs that it is
> tagged by ASID/VMID, probably fine) and (b) we'd need to context-switch
> TCR_EL1, with a small performance penalty (I don't think it's
> significant but worth testing).

So TLBI all of the CPUs on prctl() and context-switch TCR_EL1? I
thought there would be DOS concerns with the first part of that?

I hope it would be a straightforward spec clarification. Maybe Cortex
tags TBID0 by ASID/VMID but what about Apple?

If we can resolve these concerns I suppose that would work. But as
mentioned above I'm not sure we should do it straight away.

> Unfortunately, we can't turn TBID0 off dynamically when we detect a
> tagged PC since this would break authentication of already encoded
> pointers.
>
> Prior to hwasan and MTE, I doubt anyone would have noticed this change
> but once malloc() and friends started returning tagged pointers,
> programs executing code from malloc()'ed regions would fall apart with
> TBID0. I think it's a bit of stretch to argue that it's hwasan and MTE
> causing the application breakage rather than a user-kernel ABI change,
> since that's already working currently (though such programs should be
> re-written).
>
> Longer term, I'd like the TBID0 to be the default but transitioning
> without breaking the user is tricky, hence my first option would be
> per-application with an opt-in.

If we want to transition to TBID0 being the default, it seems better
to not let it be controlled by the application, if we can get away
with it. Otherwise applications may start implicitly disabling it, or
assuming it to be disabled by default. For example if we made it a bit
in tagged_addr_ctrl then a call such as:

prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0);

will disable TBID0 even if the default is for it to be enabled. (So
it's a bit unfortunate that we didn't adopt the
PR_PAC_SET_ENABLED_KEYS scheme for PR_SET_TAGGED_ADDR_CTRL.)

> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 871c82ab0a30..9ee32afe121c 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -529,11 +529,23 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
> >       vm_fault_t fault;
> >       unsigned long vm_flags;
> >       unsigned int mm_flags = FAULT_FLAG_DEFAULT;
> > -     unsigned long addr = untagged_addr(far);
> > +     unsigned long addr;
> >
> >       if (kprobe_page_fault(regs, esr))
> >               return 0;
> >
> > +     /*
> > +      * If TBID0 is set then we may get an IABT with a tagged address here as
> > +      * a result of branching to a tagged address. In this case we want to
> > +      * avoid untagging the address, let the VMA lookup fail and get a
> > +      * SIGSEGV. Leaving the address as is will also work if TBID0 is clear
> > +      * or unsupported because the tag bits of FAR_EL1 will be clear.
> > +      */
> > +     if (is_el0_instruction_abort(esr))
> > +             addr = far;
> > +     else
> > +             addr = untagged_addr(far);
>
> Should this also check for tcr_tbid0_enabled() before deciding not to
> untag the address?

No, if TBID0 is disabled then by this point the hardware would have
untagged the PC for us.

Peter
