Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FC30F8D7
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbhBDQ6m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 11:58:42 -0500
Received: from foss.arm.com ([217.140.110.172]:33412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237943AbhBDQm4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 4 Feb 2021 11:42:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BE411D4;
        Thu,  4 Feb 2021 08:42:08 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFDA33F718;
        Thu,  4 Feb 2021 08:42:06 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:41:46 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 1/3] arm64/ptrace: don't clobber task registers on
 syscall entry/exit traps
Message-ID: <20210204164145.GB21837@arm.com>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-2-avagin@gmail.com>
 <20210204152334.GA21058@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204152334.GA21058@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 04, 2021 at 03:23:34PM +0000, Will Deacon wrote:
> On Mon, Feb 01, 2021 at 11:40:10AM -0800, Andrei Vagin wrote:
> > ip/r12 for AArch32 and x7 for AArch64 is used to indicate whether or not
> > the stop has been signalled from syscall entry or syscall exit. This
> > means that:
> > 
> > - Any writes by the tracer to this register during the stop are
> >   ignored/discarded.
> > 
> > - The actual value of the register is not available during the stop,
> >   so the tracer cannot save it and restore it later.
> > 
> > Right now, these registers are clobbered in tracehook_report_syscall.
> > This change moves the logic to gpr_get and compat_gpr_get where
> > registers are copied into a user-space buffer.
> > 
> > This will allow to change these registers and to introduce a new
> > ptrace option to get the full set of registers.
> > 
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  arch/arm64/include/asm/ptrace.h |   5 ++
> >  arch/arm64/kernel/ptrace.c      | 104 ++++++++++++++++++++------------
> >  2 files changed, 69 insertions(+), 40 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index e58bca832dff..0a9552b4f61e 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -170,6 +170,11 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
> >  	return psr;
> >  }
> >  
> > +enum ptrace_syscall_dir {
> > +	PTRACE_SYSCALL_ENTER = 0,
> > +	PTRACE_SYSCALL_EXIT,
> > +};
> > +
> >  /*
> >   * This struct defines the way the registers are stored on the stack during an
> >   * exception. Note that sizeof(struct pt_regs) has to be a multiple of 16 (for
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 8ac487c84e37..39da03104528 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/syscall.h>
> >  #include <asm/traps.h>
> >  #include <asm/system_misc.h>
> > +#include <asm/ptrace.h>
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/syscalls.h>
> > @@ -561,7 +562,31 @@ static int gpr_get(struct task_struct *target,
> >  		   struct membuf to)
> >  {
> >  	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
> > -	return membuf_write(&to, uregs, sizeof(*uregs));
> > +	unsigned long saved_reg;
> > +	int ret;
> > +
> > +	/*
> > +	 * We have some ABI weirdness here in the way that we handle syscall
> > +	 * exit stops because we indicate whether or not the stop has been
> > +	 * signalled from syscall entry or syscall exit by clobbering the general
> > +	 * purpose register x7.
> > +	 */
> 
> When you move a comment, please don't truncate it!
> 
> > +	saved_reg = uregs->regs[7];
> > +
> > +	switch (target->ptrace_message) {
> > +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> > +		uregs->regs[7] = PTRACE_SYSCALL_ENTER;
> > +		break;
> > +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> > +		uregs->regs[7] = PTRACE_SYSCALL_EXIT;
> > +		break;
> > +	}
> 
> I'm wary of checking target->ptrace_message here, as I seem to recall the
> regset code also being used for coredumps. What guarantees we don't break
> things there?

For a coredump, is there any way to know whether a given thread was
inside a traced syscall when the coredump was generated?  If so, x7 in
the dump may already unreliable and we only need to make best efforts to
get it "right".

Since triggering of the coredump and death of other threads all require
dequeueing of some signal, I think all threads must always outside the
syscall-enter...syscall-exit path before any of the coredump runs anyway,
in which case the above should never matter...  Though somone else ought
to eyeball the coredump code before we agree on that.

ptrace_message doesn't seem absolutely the wrong thing to check, but
we'd need to be sure that it can't be stale (say, left over from some
previous trap).


Out of interest, where did this arm64 ptrace feature come from?  Was it
just pasted from 32-bit and thinly adapted?  It looks like an
arch-specific attempt to do what PTRACE_O_TRACESYSGOOD does, in which
case it may have been obsolete even before it was upstreamed.  I wonder
whether anyone is actually relying on it at all...  

Doesn't mean we can definitely fix it safely, but it's annoying.

[...]

Cheers
---Dave
