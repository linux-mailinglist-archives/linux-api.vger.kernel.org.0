Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49A2A448B
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgKCLuG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 06:50:06 -0500
Received: from foss.arm.com ([217.140.110.172]:47546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKCLuG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Nov 2020 06:50:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5F21042;
        Tue,  3 Nov 2020 03:50:04 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEB633F718;
        Tue,  3 Nov 2020 03:50:02 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:49:59 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: Re: [PATCH v12 8/8] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <20201103114959.GL6882@arm.com>
References: <cover.1602892799.git.pcc@google.com>
 <2dec46a70da175478932d034ebe74d0b4f5133c4.1602892799.git.pcc@google.com>
 <20201102175451.GF6882@arm.com>
 <CAMn1gO7aKYASsKLgp-6NtOxJOPxoKUFGPSasNKkh+RwJUVvGCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO7aKYASsKLgp-6NtOxJOPxoKUFGPSasNKkh+RwJUVvGCA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 02, 2020 at 07:59:25PM -0800, Peter Collingbourne wrote:
> On Mon, Nov 2, 2020 at 9:55 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 05:12:33PM -0700, Peter Collingbourne wrote:
> > > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > > the tag bits may be needed by tools in order to accurately diagnose
> > > memory errors, such as HWASan [1] or future tools based on the Memory
> > > Tagging Extension (MTE).
> > >
> > > We should not stop clearing these bits in the existing fault address
> > > fields, because there may be existing userspace applications that are
> > > expecting the tag bits to be cleared. Instead, create a new pair of
> > > union fields in siginfo._sigfault, and store the tag bits of FAR_EL1
> > > there, together with a mask specifying which bits are valid.
> > >
> > > A flag is added to si_xflags to allow userspace to determine whether
> > > the values in the fields are valid.
> > >
> > > [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> > >
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446
> > > ---
> > > v12:
> > > - add new fields to signal_compat.c test cases
> > > - rebased to 5.10-rc1
> > > - mask out bits 63:60 for tag check faults
> > >
> > > v11:
> > > - add a comment explaining what the arch hook should do
> > > - rename ignored bits to tag bits
> > >
> > > v10:
> > > - rename the flag to SIXFLAG_ADDR_IGNORED_BITS
> > > - use an arch hook to specify which bits are ignored, instead
> > >   of passing them explicitly
> > > - while refactoring for the arch hook, noticed that my previous
> > >   patches missed a case involving cache maintenance instructions,
> > >   so expose the tag bits for that signal as well
> > >
> > > v9:
> > > - make the ignored bits fields generic
> > > - add some new dependent patches that prepare us to store the
> > >   field in such a way that userspace can detect their presence
> > >
> > > v8:
> > > - rebase onto 5.8rc2
> > >
> > > v7:
> > > - switch to a new siginfo field instead of using sigcontext
> > > - merge the patch back into one since the other patches are now
> > >   unnecessary
> > >
> > > v6:
> > > - move fault address and fault code into the kernel_siginfo data structure
> > > - split the patch in three since it was getting large and now has
> > >   generic and arch-specific parts
> > >
> > > v5:
> > > - add padding to fault_addr_top_byte_context in order to ensure the correct
> > >   size and preserve sp alignment
> > >
> > > v4:
> > > - expose only the tag bits in the context instead of the entire FAR_EL1
> > > - remove mention of the new context from the sigcontext.__reserved[] note
> > >
> > > v3:
> > > - add documentation to tagged-pointers.rst
> > > - update comments in sigcontext.h
> > >
> > > v2:
> > > - revert changes to hw_breakpoint.c
> > > - rename set_thread_esr to set_thread_far_esr
> > >
> > >  Documentation/arm64/tagged-pointers.rst | 21 +++++---
> > >  arch/arm64/include/asm/exception.h      |  2 +-
> > >  arch/arm64/include/asm/signal.h         | 19 +++++++
> > >  arch/arm64/include/asm/system_misc.h    |  2 +-
> > >  arch/arm64/include/asm/traps.h          |  6 +--
> > >  arch/arm64/kernel/debug-monitors.c      |  5 +-
> > >  arch/arm64/kernel/entry-common.c        |  2 -
> > >  arch/arm64/kernel/ptrace.c              |  7 +--
> > >  arch/arm64/kernel/sys_compat.c          |  5 +-
> > >  arch/arm64/kernel/traps.c               | 29 ++++++-----
> > >  arch/arm64/mm/fault.c                   | 68 ++++++++++++++-----------
> > >  arch/x86/kernel/signal_compat.c         |  9 +++-
> > >  include/linux/compat.h                  |  2 +
> > >  include/linux/signal.h                  | 16 ++++++
> > >  include/uapi/asm-generic/siginfo.h      | 10 ++++
> > >  kernel/signal.c                         | 18 ++++++-
> > >  16 files changed, 148 insertions(+), 73 deletions(-)
> > >  create mode 100644 arch/arm64/include/asm/signal.h
> > >
> > > diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> > > index eab4323609b9..032c09a876f4 100644
> > > --- a/Documentation/arm64/tagged-pointers.rst
> > > +++ b/Documentation/arm64/tagged-pointers.rst
> > > @@ -53,12 +53,21 @@ visibility.
> > >  Preserving tags
> > >  ---------------
> > >
> > > -Non-zero tags are not preserved when delivering signals. This means that
> > > -signal handlers in applications making use of tags cannot rely on the
> > > -tag information for user virtual addresses being maintained for fields
> > > -inside siginfo_t. One exception to this rule is for signals raised in
> > > -response to watchpoint debug exceptions, where the tag information will
> > > -be preserved.
> > > +Non-zero tags are not preserved in the fault address fields
> > > +siginfo.si_addr or sigcontext.fault_address when delivering
> > > +signals. This means that signal handlers in applications making use
> > > +of tags cannot rely on the tag information for user virtual addresses
> > > +being maintained in these fields. One exception to this rule is for
> > > +signals raised in response to watchpoint debug exceptions, where the
> > > +tag information will be preserved.
> > > +
> > > +The fault address tag is preserved in the si_addr_tag_bits field
> > > +of siginfo, which is set for signals raised in response to data aborts
> > > +and instruction aborts. The si_addr_tag_bits_mask field indicates
> > > +which bits of the field are valid. The validity of these fields is
> > > +indicated by the SIXFLAG_ADDR_TAG_BITS flag in siginfo.si_xflags,
> > > +and the validity of si_xflags in turn is indicated by the kernel
> > > +indicating support for the sigaction.sa_flags flag SA_XFLAGS.
> > >
> > >  The architecture prevents the use of a tagged PC, so the upper byte will
> > >  be set to a sign-extension of bit 55 on exception return.
> > > diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
> > > index 99b9383cd036..2a8aa1884d8a 100644
> > > --- a/arch/arm64/include/asm/exception.h
> > > +++ b/arch/arm64/include/asm/exception.h
> > > @@ -32,7 +32,7 @@ static inline u32 disr_to_esr(u64 disr)
> > >  }
> > >
> > >  asmlinkage void enter_from_user_mode(void);
> > > -void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
> > > +void do_mem_abort(unsigned long far, unsigned int esr, struct pt_regs *regs);
> > >  void do_undefinstr(struct pt_regs *regs);
> > >  void do_bti(struct pt_regs *regs);
> > >  asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
> > > diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
> > > new file mode 100644
> > > index 000000000000..46f9b3c61896
> > > --- /dev/null
> > > +++ b/arch/arm64/include/asm/signal.h
> > > @@ -0,0 +1,19 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ARM64_ASM_SIGNAL_H
> > > +#define __ARM64_ASM_SIGNAL_H
> > > +
> > > +#include <uapi/asm/signal.h>
> > > +#include <uapi/asm/siginfo.h>
> > > +
> > > +static inline unsigned long arch_addr_tag_bits_mask(unsigned long sig,
> > > +                                                 unsigned long si_code)
> > > +{
> > > +     if (sig == SIGTRAP && si_code == TRAP_BRKPT)
> > > +             return 0;
> > > +     if (sig == SIGSEGV && si_code == SEGV_MTESERR)
> > > +             return 0xfUL << 56;
> >
> > Should this be 0xffUL << 56?
> >
> > I thought MTE ignored bits 63:60, rather than requiring them to be 0?
> 
> Yes, but the architecture defines FAR_EL1[63:60] as UNKNOWN for tag
> check faults. As such the bits are masked out in do_tag_check_fault
> and excluded from the mask here to indicate that they are not present.

Ah, OK.  I'd forgotten that.

So long as these bits are also zeroed in si_addr, I guess that's fine.

> 
> > The whole tag byte may be relevant for debugging purposes, even if only
> > some of the bits are checked in hardware.
> 
> Yes and that's why it's a bit of a shame that the bits were defined as
> UNKNOWN. We had an idea for how to improve error reports by using
> those bits to link tag check faults to previous allocations, which was
> precluded by the missing bits.

Presumably if some future arch version propagated this information, we
could add those bits into the tag bits mask when running on new enough
hardware?

Either way, I think we could do with a comment here.

> 
> Hopefully a future revision of the architecture will define these bits
> for tag check faults (at least optionally). If that ever happens and
> support for the architecture extension is detected we could stop
> masking the bits out in do_tag_check_fault and set
> si_addr_tag_bits_mask to 0xffUL << 56, which would let userspace know
> that the bits are now present.
> 
> > For consistency, I wonder whether it makes sense to expose the bits as
> > tag bits for watchpoint execeptions, even if they are left un-cleared in
> > si_addr for historical reasons.
> 
> I don't have a strong opinion on whether to do this or not, but it
> seems like a nice property that the bits are either defined in si_addr
> or in si_addr_tag_bits. I think we could leave the watchpoint
> exception on arm64 as "weird for historical reasons" and insist that
> any future architectures adopting tagged addresses handle the tag bits
> uniformly.

Ack -- I guess I don't have a strong opinion either.

There's a risk of inventing problems here in order to solve them, so I
agree we should keep things as simple and follow your current design.

Cheers
---Dave
