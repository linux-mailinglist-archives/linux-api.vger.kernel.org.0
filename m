Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089233252F8
	for <lists+linux-api@lfdr.de>; Thu, 25 Feb 2021 17:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhBYQCv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Feb 2021 11:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhBYQCp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Feb 2021 11:02:45 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435DC061574;
        Thu, 25 Feb 2021 08:02:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id b21so4061385pgk.7;
        Thu, 25 Feb 2021 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rh70PJnNYV7nfofat8yzOdjViZ8QnrWCFQn2EVPf0I4=;
        b=EISs5PJBbzZzeZhkVAgUfkJymYUOUmVHjgD7VUa6ls+wTz4cdA3EACcpUDm0UrHaLv
         uaLyVDwHU5JqPSjoQHzRrqwwJqQXMZiX0HbFLq6sutCH+mFfykPkL008dzXIC4u60vbF
         BfxML9V4r3IKTAM4KxnMIRc9JL1i5GmFY/VWxz84pt3aBJeXHIycaUqDek/D7DacmRwY
         ey33QID0SX3OYArTOpvs6pSd3a3/9aRc4JjLQH/G3oW3JKvF3yMcZkd12UDD0+C5zmIL
         pvzveEAEb5kO48zCDoyL5S9tWxb7lH53XrV9GMjRBWFYTUCapyBJ2+MEFjRus0R5LS3V
         QbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rh70PJnNYV7nfofat8yzOdjViZ8QnrWCFQn2EVPf0I4=;
        b=mdnZKI6i3G0ebQRrGXQ2AfkGg7F/wIbI3YhfPUEjrj9qssrfZYh3a2730zoz8sbiDZ
         U1lKbLKJEvdPcEEw8Q/K4xc7RO3xakyY9jjesZk5PsNCgKl9hz/J/ngqTphnkaV+hCUJ
         SMQvRf4HO0u4dZtZXnn9QwwmjnCw6Yxu+hUJ2qDD/tdDXdoRwh6PHjynHhF26gTY6PIE
         qz8U3gx+6tJb/yBZmhFjfg5mggxpUTpjfd4tatLVfSu6LebyuWw82MbL8UELvUUESaN0
         BRoCnRZmQwGHabqpjc5TSQBwMa+/MoPkffyyPwxBvI+OHK7F9O2s7qnF0yGIZtd2b7kq
         kT1g==
X-Gm-Message-State: AOAM530DQwaaGE3OVQ1DeGN0GXAy+eEXeyYl8DsUZOm9SPJgbwBQxUeM
        qwX5QXlLbptdUk6LxRUD9CE=
X-Google-Smtp-Source: ABdhPJyXBfl5mSKlZyvnP5mCCf/s2atGOL3XQ9+qd6c9OYR9APNWwSuNzXZ3VSeth6Qe/zMX/RpI3g==
X-Received: by 2002:a63:6606:: with SMTP id a6mr3564650pgc.310.1614268922364;
        Thu, 25 Feb 2021 08:02:02 -0800 (PST)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id k7sm6297659pjf.34.2021.02.25.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 08:02:01 -0800 (PST)
Date:   Thu, 25 Feb 2021 08:00:02 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 1/3] arm64/ptrace: don't clobber task registers on
 syscall entry/exit traps
Message-ID: <20210225160002.GA143918@gmail.com>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-2-avagin@gmail.com>
 <20210204152334.GA21058@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210204152334.GA21058@willie-the-truck>
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

This is my fault. In the previous version, the other part of this
comment was irelevant, because I always allowed to change clobbered
registers, but then I realized that we can't do that.

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

Registers were clobbered in tracehook_report_syscall,
task->ptrace_message is set in ptrace_report_syscall.

do_coredump() is called from get_signal and secure_computing, so we
always see actuall registers in core dumps with and without these
changes.

> 
> > +
> > +	ret =  membuf_write(&to, uregs, sizeof(*uregs));
> > +
> > +	uregs->regs[7] = saved_reg;
> > +
> > +	return ret;
> >  }
> >  
> >  static int gpr_set(struct task_struct *target, const struct user_regset *regset,
> > @@ -575,6 +600,17 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
> >  	if (ret)
> >  		return ret;
> >  
> > +	/*
> > +	 * Historically, x7 can't be changed if the stop has been signalled
> > +	 * from syscall-enter of syscall-exit.
> > +	 */
> > +	switch (target->ptrace_message) {
> > +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> > +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> > +		newregs.regs[7] = task_pt_regs(target)->regs[7];
> > +		break;
> > +	}
> > +
> >  	if (!valid_user_regs(&newregs, target))
> >  		return -EINVAL;
> >  
> > @@ -1206,6 +1242,20 @@ static inline compat_ulong_t compat_get_user_reg(struct task_struct *task, int i
> >  	struct pt_regs *regs = task_pt_regs(task);
> >  
> >  	switch (idx) {
> > +	case 12:
> > +		/*
> > +		 * We have some ABI weirdness here in the way that we handle
> > +		 * syscall exit stops because we indicate whether or not the
> > +		 * stop has been signalled from syscall entry or syscall exit
> > +		 * by clobbering the general purpose register r12.
> > +		 */
> > +		switch (task->ptrace_message) {
> > +		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> > +			return PTRACE_SYSCALL_ENTER;
> > +		case PTRACE_EVENTMSG_SYSCALL_EXIT:
> > +			return PTRACE_SYSCALL_EXIT;
> > +		}
> > +		return regs->regs[idx];
> >  	case 15:
> >  		return regs->pc;
> >  	case 16:
> > @@ -1282,6 +1332,17 @@ static int compat_gpr_set(struct task_struct *target,
> >  
> >  	}
> >  
> > +	/*
> > +	 * Historically, x12 can't be changed if the stop has been signalled
> > +	 * from syscall-enter of syscall-exit.
> > +	 */
> > +	switch (target->ptrace_message) {
> > +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> > +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> > +		newregs.regs[12] = task_pt_regs(target)->regs[12];
> > +		break;
> > +	}
> > +
> >  	if (valid_user_regs(&newregs.user_regs, target))
> >  		*task_pt_regs(target) = newregs;
> >  	else
> > @@ -1740,53 +1801,16 @@ long arch_ptrace(struct task_struct *child, long request,
> >  	return ptrace_request(child, request, addr, data);
> >  }
> >  
> > -enum ptrace_syscall_dir {
> > -	PTRACE_SYSCALL_ENTER = 0,
> > -	PTRACE_SYSCALL_EXIT,
> > -};
> > -
> >  static void tracehook_report_syscall(struct pt_regs *regs,
> >  				     enum ptrace_syscall_dir dir)
> >  {
> > -	int regno;
> > -	unsigned long saved_reg;
> > -
> > -	/*
> > -	 * We have some ABI weirdness here in the way that we handle syscall
> > -	 * exit stops because we indicate whether or not the stop has been
> > -	 * signalled from syscall entry or syscall exit by clobbering a general
> > -	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> > -	 * and restoring its old value after the stop. This means that:
> > -	 *
> > -	 * - Any writes by the tracer to this register during the stop are
> > -	 *   ignored/discarded.
> > -	 *
> > -	 * - The actual value of the register is not available during the stop,
> > -	 *   so the tracer cannot save it and restore it later.
> > -	 *
> > -	 * - Syscall stops behave differently to seccomp and pseudo-step traps
> > -	 *   (the latter do not nobble any registers).
> > -	 */
> > -	regno = (is_compat_task() ? 12 : 7);
> > -	saved_reg = regs->regs[regno];
> > -	regs->regs[regno] = dir;
> > -
> >  	if (dir == PTRACE_SYSCALL_ENTER) {
> >  		if (tracehook_report_syscall_entry(regs))
> >  			forget_syscall(regs);
> > -		regs->regs[regno] = saved_reg;
> > -	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
> > -		tracehook_report_syscall_exit(regs, 0);
> > -		regs->regs[regno] = saved_reg;
> >  	} else {
> > -		regs->regs[regno] = saved_reg;
> > +		int singlestep = test_thread_flag(TIF_SINGLESTEP);
> >  
> > -		/*
> > -		 * Signal a pseudo-step exception since we are stepping but
> > -		 * tracer modifications to the registers may have rewound the
> > -		 * state machine.
> > -		 */
> > -		tracehook_report_syscall_exit(regs, 1);
> > +		tracehook_report_syscall_exit(regs, singlestep);
> 
> Again, please preserve the comment in some form (maybe "... if we are
> stepping since tracer ...").

ok

> 
> That said, doesn't your change above break the pseudo-step trap? Currently,
> we report the real x7 for those.

No, it doesn't.

In case of singlestep, tracehook_report_syscall_exit calls
user_single_step_report instead of ptrace_report_syscall, so
current->ptace_message will not be set PTRACE_EVENTMSG_SYSCALL_EXIT.


> 
> Will
