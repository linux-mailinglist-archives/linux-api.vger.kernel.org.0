Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35494F513
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 13:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfD3LKB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Apr 2019 07:10:01 -0400
Received: from foss.arm.com ([217.140.101.70]:44570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfD3LKB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 30 Apr 2019 07:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DC7680D;
        Tue, 30 Apr 2019 04:10:00 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F8A3F5C1;
        Tue, 30 Apr 2019 04:09:59 -0700 (PDT)
Date:   Tue, 30 Apr 2019 12:09:58 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Blundell <pb@pbcl.net>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v5 1/6] arm64: HWCAP: add support for AT_HWCAP2
Message-ID: <20190430110957.GA33049@e119886-lin.cambridge.arm.com>
References: <20190409095245.42524-1-andrew.murray@arm.com>
 <20190409095245.42524-2-andrew.murray@arm.com>
 <20190416135157.GH3313@fuggles.cambridge.arm.com>
 <20190416163041.GU3567@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416163041.GU3567@e103592.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 16, 2019 at 05:30:41PM +0100, Dave Martin wrote:
> On Tue, Apr 16, 2019 at 02:51:57PM +0100, Will Deacon wrote:
> > On Tue, Apr 09, 2019 at 10:52:40AM +0100, Andrew Murray wrote:
> > > As we will exhaust the first 32 bits of AT_HWCAP let's start
> > > exposing AT_HWCAP2 to userspace to give us up to 64 caps.
> > > 
> > > Whilst it's possible to use the remaining 32 bits of AT_HWCAP, we
> > > prefer to expand into AT_HWCAP2 in order to provide a consistent
> > > view to userspace between ILP32 and LP64. However internal to the
> > > kernel we prefer to continue to use the full space of elf_hwcap.
> > > 
> > > To reduce complexity and allow for future expansion, we now
> > > represent hwcaps in the kernel as ordinals and use a
> > > KERNEL_HWCAP_ prefix. This allows us to support automatic feature
> > > based module loading for all our hwcaps.
> > > 
> > > We introduce cpu_set_feature to set hwcaps which complements the
> > > existing cpu_have_feature helper. These helpers allow us to clean
> > > up existing direct uses of elf_hwcap and reduce any future effort
> > > required to move beyond 64 caps.
> > > 
> > > For convenience we also introduce cpu_{have,set}_named_feature which
> > > makes use of the cpu_feature macro to allow providing a hwcap name
> > > without a {KERNEL_}HWCAP_ prefix.
> > > 
> > > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > > ---
> > >  Documentation/arm64/elf_hwcaps.txt       | 14 +++--
> > >  arch/arm64/crypto/aes-ce-ccm-glue.c      |  2 +-
> > >  arch/arm64/crypto/aes-neonbs-glue.c      |  2 +-
> > >  arch/arm64/crypto/chacha-neon-glue.c     |  2 +-
> > >  arch/arm64/crypto/crct10dif-ce-glue.c    |  4 +-
> > >  arch/arm64/crypto/ghash-ce-glue.c        |  8 +--
> > >  arch/arm64/crypto/nhpoly1305-neon-glue.c |  2 +-
> > >  arch/arm64/crypto/sha256-glue.c          |  4 +-
> > >  arch/arm64/include/asm/cpufeature.h      | 22 ++++----
> > >  arch/arm64/include/asm/hwcap.h           | 52 ++++++++++++++++++-
> > >  arch/arm64/include/uapi/asm/hwcap.h      |  2 +-
> > >  arch/arm64/kernel/cpufeature.c           | 66 ++++++++++++------------
> > >  arch/arm64/kernel/cpuinfo.c              |  2 +-
> > >  arch/arm64/kernel/fpsimd.c               |  4 +-
> > >  drivers/clocksource/arm_arch_timer.c     |  8 +++
> > >  15 files changed, 131 insertions(+), 63 deletions(-)
> > > 
> > > diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
> > > index 13d6691b37be..c04f8e87bab8 100644
> > > --- a/Documentation/arm64/elf_hwcaps.txt
> > > +++ b/Documentation/arm64/elf_hwcaps.txt
> > > @@ -13,9 +13,9 @@ architected discovery mechanism available to userspace code at EL0. The
> > >  kernel exposes the presence of these features to userspace through a set
> > >  of flags called hwcaps, exposed in the auxilliary vector.
> > >  
> > > -Userspace software can test for features by acquiring the AT_HWCAP entry
> > > -of the auxilliary vector, and testing whether the relevant flags are
> > > -set, e.g.
> > > +Userspace software can test for features by acquiring the AT_HWCAP or
> > > +AT_HWCAP2 entry of the auxiliary vector, and testing whether the relevant
> > > +flags are set, e.g.
> > >  
> > >  bool floating_point_is_present(void)
> > >  {
> > > @@ -194,3 +194,11 @@ HWCAP_PACG
> > >      Functionality implied by ID_AA64ISAR1_EL1.GPA == 0b0001 or
> > >      ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
> > >      Documentation/arm64/pointer-authentication.txt.
> > > +
> > > +
> > > +4. Unused AT_HWCAP bits
> > > +-----------------------
> > > +
> > > +Each AT_HWCAP and AT_HWCAP2 entry provides for up to 32 hwcaps contained
> > > +in bits [31:0]. For interoperation with userspace we guarantee that bits
> > > +62 and 63 of AT_HWCAP will always be returned as 0.
> > 
> > I'm a little nervous about the first sentence here, since it could be
> > taken to mean that we will never allocate 61:32. Mind if I drop it?
> 
> Ack: I don't think we want to say explicitly that we will never use
> those bits, apart from AT_HWCAP[63:62] for which there are specific
> reasons.

No problem with me. Thanks for making this change (and const_ilog2).

> 
> (For now of course, we won't use them.)
> 
> > > diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> > > index aa4ec53281ce..6cc8aff83805 100644
> > > --- a/drivers/clocksource/arm_arch_timer.c
> > > +++ b/drivers/clocksource/arm_arch_timer.c
> > > @@ -833,7 +833,11 @@ static void arch_timer_evtstrm_enable(int divider)
> > >  	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
> > >  			| ARCH_TIMER_VIRT_EVT_EN;
> > >  	arch_timer_set_cntkctl(cntkctl);
> > > +#ifdef CONFIG_ARM64
> > > +	cpu_set_named_feature(EVTSTRM);
> > > +#else
> > >  	elf_hwcap |= HWCAP_EVTSTRM;
> > > +#endif
> > >  #ifdef CONFIG_COMPAT
> > >  	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
> > >  #endif
> > > @@ -1055,7 +1059,11 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
> > >  	} else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
> > >  		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
> > >  
> > > +#ifdef CONFIG_ARM64
> > > +		if (cpu_have_named_feature(EVTSTRM))
> > > +#else
> > >  		if (elf_hwcap & HWCAP_EVTSTRM)
> > > +#endif
> > 
> > I think this is an indication that the abstraction isn't quite right and
> > should probably be done in an arch-helped via asm/arch_timer.h. However,
> > that can be done as a separate patch later on.
> 
> It probably does make sense to add an arch-specific helper for that.
> 
> Given that we don't want to encourage this kind of poking about in
> elf_hwcap.  It might make sense to have a single-purpose helper just for
> checking this flag.

I'll propose something in a separate patch.

Thanks,

Andrew Murray

> 
> Cheers
> ---Dave
