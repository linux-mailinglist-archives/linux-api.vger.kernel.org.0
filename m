Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE03D935E
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG1Qm1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 12:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhG1Qm0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Jul 2021 12:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60D5860F01;
        Wed, 28 Jul 2021 16:42:23 +0000 (UTC)
Date:   Wed, 28 Jul 2021 17:42:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: allow TCR_EL1.TBID0 to be configured
Message-ID: <20210728164219.GC7408@arm.com>
References: <20210622051204.3682580-1-pcc@google.com>
 <20210727165109.GB13920@arm.com>
 <CAMn1gO7DcY4tWu0Q7XsZAt-pEmD-4S64sMzu_gARH7Pvc8sP8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO7DcY4tWu0Q7XsZAt-pEmD-4S64sMzu_gARH7Pvc8sP8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 27, 2021 at 03:00:10PM -0700, Peter Collingbourne wrote:
> On Tue, Jul 27, 2021 at 9:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Jun 21, 2021 at 10:12:04PM -0700, Peter Collingbourne wrote:
> > > Introduce a command line flag that controls whether TCR_EL1.TBID0
> > > is set at boot time. Since this is a change to the userspace ABI the
> > > option defaults to off for now, although it seems likely that we'll
> > > be able to change the default at some future point.
> > >
> > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > the pointer authentication instructions for instruction addresses by 8,
> > > which improves the security of pointer authentication, but it also has
> > > the consequence of changing the operation of the branch instructions
> > > so that they no longer ignore the top byte of the target address but
> > > instead fault if they are non-zero.
> >
> > I'm a bit uneasy about the ABI change and not so keen on constraining
> > the ABI through the kernel command line. Ideally we should make this an
> > opt-in per application (prctl()) but that has some aspects to address
> 
> This doesn't necessarily need to be the end state, we can enhance this
> based on need. For example, we could choose to take this patch now and
> later implement the per-process opt-in where the default is controlled
> by the command line.

What's the risk of an application becoming reliant on the new mode
(TBID0) and breaking with the old one? Probably very small but I haven't
figured out if it's zero. Depending on whether we have PAC or PAC2 (the
latter came with 8.6 but optional in 8.3) with TBID0, there are some
differences on how the PAC/AUT instructions work and the code generated
(XOR with the top bits).

> Or just implement the software-only per-process
> TBID0 almost-disablement which would be much simpler than doing it in
> hardware, if that is enough to satisfy future needs.

I don't entirely follow this.

> Otherwise we risk adding "unused" complexity to the kernel that we can
> never remove due to API stability guarantees.

We've had other debates over the years and, in general, if a kernel
change causes apps to break, we'd have to keep the original behaviour.
Are there any plans to fix the JITs tools you discovered?

Talking to Will about this he was wondering whether we could make TBID0
on by default and clear the tag in PC if we take a fault (on tagged PC),
restarting the context. PAC shouldn't be affected since we would only
branch to an authenticated (PAC code removed) pointer. If this works,
we'd only affect performance slightly on such apps but don't completely
break them.

> > first: (a) this bit is permitted to be cached in the TLB so we'd need
> > some TLBI when setting it (and a clarification in the specs that it is
> > tagged by ASID/VMID, probably fine) and (b) we'd need to context-switch
> > TCR_EL1, with a small performance penalty (I don't think it's
> > significant but worth testing).
> 
> So TLBI all of the CPUs on prctl() and context-switch TCR_EL1? I
> thought there would be DOS concerns with the first part of that?

The DoS problem appears if we need to issue an IPI to all CPUs (like
stop_machine). The TLBI with broadcast handled in hardware should be OK
as it's targeted to a specific ASID. But this would have to be issued
before any app threads are started, otherwise we'd need to synchronise
TCR_EL1. Given that TBID0 toggling affects PAC, this can only be done
safely very early in the application before return addresses get a PAC
code.

> > Unfortunately, we can't turn TBID0 off dynamically when we detect a
> > tagged PC since this would break authentication of already encoded
> > pointers.
> >
> > Prior to hwasan and MTE, I doubt anyone would have noticed this change
> > but once malloc() and friends started returning tagged pointers,
> > programs executing code from malloc()'ed regions would fall apart with
> > TBID0. I think it's a bit of stretch to argue that it's hwasan and MTE
> > causing the application breakage rather than a user-kernel ABI change,
> > since that's already working currently (though such programs should be
> > re-written).
> >
> > Longer term, I'd like the TBID0 to be the default but transitioning
> > without breaking the user is tricky, hence my first option would be
> > per-application with an opt-in.
> 
> If we want to transition to TBID0 being the default, it seems better
> to not let it be controlled by the application, if we can get away
> with it. Otherwise applications may start implicitly disabling it, or
> assuming it to be disabled by default. For example if we made it a bit
> in tagged_addr_ctrl then a call such as:
> 
> prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0);
> 
> will disable TBID0 even if the default is for it to be enabled. (So
> it's a bit unfortunate that we didn't adopt the
> PR_PAC_SET_ENABLED_KEYS scheme for PR_SET_TAGGED_ADDR_CTRL.)

At the time, we didn't see a need for it ;). But if it's an opt-in, the
default should be off anyway.

> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 871c82ab0a30..9ee32afe121c 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -529,11 +529,23 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
> > >       vm_fault_t fault;
> > >       unsigned long vm_flags;
> > >       unsigned int mm_flags = FAULT_FLAG_DEFAULT;
> > > -     unsigned long addr = untagged_addr(far);
> > > +     unsigned long addr;
> > >
> > >       if (kprobe_page_fault(regs, esr))
> > >               return 0;
> > >
> > > +     /*
> > > +      * If TBID0 is set then we may get an IABT with a tagged address here as
> > > +      * a result of branching to a tagged address. In this case we want to
> > > +      * avoid untagging the address, let the VMA lookup fail and get a
> > > +      * SIGSEGV. Leaving the address as is will also work if TBID0 is clear
> > > +      * or unsupported because the tag bits of FAR_EL1 will be clear.
> > > +      */
> > > +     if (is_el0_instruction_abort(esr))
> > > +             addr = far;
> > > +     else
> > > +             addr = untagged_addr(far);
> >
> > Should this also check for tcr_tbid0_enabled() before deciding not to
> > untag the address?
> 
> No, if TBID0 is disabled then by this point the hardware would have
> untagged the PC for us.

Ah, ok, didn't realise that the tag is removed by the hardware.

-- 
Catalin
