Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C630F636
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhBDPZH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 10:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237174AbhBDPYT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 4 Feb 2021 10:24:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C50C764E08;
        Thu,  4 Feb 2021 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612452219;
        bh=eI7vt2zb4HubE2xKuw37xGNu67VWBeg2YwuiOZuteS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLennbJoZ2D94Iw5qgL6zRfKPxIlRHUXKetaltld3CilKY5z7GygMXjDIgOxtudHi
         4zPXarNpoCosokeTx+SXkDYK5nCk0wb9mmqN7ktijEZ7heyNremUkAQjLO/nSQAyyU
         0dUUQlYm4l6AfK2d6qE1zyAwcI1VQM+ZXvZi1eJEr9kDPkXtiIpU/nRxjpLLGHrWxI
         kGQ1h2wArFF+FpM6UFbRNfisIhWOUTzd1xjmABUtQ7V3Px8qrUM6BFeCn1EigEtwku
         pcKPJkQeKkGBPYvB8UArz/X0G69LHrLHb/OR4JNfu5Gd3XPqQ42Ld57XAwCrWc/ujq
         Omp3WPAOCefLA==
Date:   Thu, 4 Feb 2021 15:23:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 1/3] arm64/ptrace: don't clobber task registers on
 syscall entry/exit traps
Message-ID: <20210204152334.GA21058@willie-the-truck>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-2-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201194012.524831-2-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 01, 2021 at 11:40:10AM -0800, Andrei Vagin wrote:
> ip/r12 for AArch32 and x7 for AArch64 is used to indicate whether or not
> the stop has been signalled from syscall entry or syscall exit. This
> means that:
> 
> - Any writes by the tracer to this register during the stop are
>   ignored/discarded.
> 
> - The actual value of the register is not available during the stop,
>   so the tracer cannot save it and restore it later.
> 
> Right now, these registers are clobbered in tracehook_report_syscall.
> This change moves the logic to gpr_get and compat_gpr_get where
> registers are copied into a user-space buffer.
> 
> This will allow to change these registers and to introduce a new
> ptrace option to get the full set of registers.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  arch/arm64/include/asm/ptrace.h |   5 ++
>  arch/arm64/kernel/ptrace.c      | 104 ++++++++++++++++++++------------
>  2 files changed, 69 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index e58bca832dff..0a9552b4f61e 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -170,6 +170,11 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
>  	return psr;
>  }
>  
> +enum ptrace_syscall_dir {
> +	PTRACE_SYSCALL_ENTER = 0,
> +	PTRACE_SYSCALL_EXIT,
> +};
> +
>  /*
>   * This struct defines the way the registers are stored on the stack during an
>   * exception. Note that sizeof(struct pt_regs) has to be a multiple of 16 (for
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 8ac487c84e37..39da03104528 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -40,6 +40,7 @@
>  #include <asm/syscall.h>
>  #include <asm/traps.h>
>  #include <asm/system_misc.h>
> +#include <asm/ptrace.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
> @@ -561,7 +562,31 @@ static int gpr_get(struct task_struct *target,
>  		   struct membuf to)
>  {
>  	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
> -	return membuf_write(&to, uregs, sizeof(*uregs));
> +	unsigned long saved_reg;
> +	int ret;
> +
> +	/*
> +	 * We have some ABI weirdness here in the way that we handle syscall
> +	 * exit stops because we indicate whether or not the stop has been
> +	 * signalled from syscall entry or syscall exit by clobbering the general
> +	 * purpose register x7.
> +	 */

When you move a comment, please don't truncate it!

> +	saved_reg = uregs->regs[7];
> +
> +	switch (target->ptrace_message) {
> +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> +		uregs->regs[7] = PTRACE_SYSCALL_ENTER;
> +		break;
> +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> +		uregs->regs[7] = PTRACE_SYSCALL_EXIT;
> +		break;
> +	}

I'm wary of checking target->ptrace_message here, as I seem to recall the
regset code also being used for coredumps. What guarantees we don't break
things there?

> +
> +	ret =  membuf_write(&to, uregs, sizeof(*uregs));
> +
> +	uregs->regs[7] = saved_reg;
> +
> +	return ret;
>  }
>  
>  static int gpr_set(struct task_struct *target, const struct user_regset *regset,
> @@ -575,6 +600,17 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Historically, x7 can't be changed if the stop has been signalled
> +	 * from syscall-enter of syscall-exit.
> +	 */
> +	switch (target->ptrace_message) {
> +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> +		newregs.regs[7] = task_pt_regs(target)->regs[7];
> +		break;
> +	}
> +
>  	if (!valid_user_regs(&newregs, target))
>  		return -EINVAL;
>  
> @@ -1206,6 +1242,20 @@ static inline compat_ulong_t compat_get_user_reg(struct task_struct *task, int i
>  	struct pt_regs *regs = task_pt_regs(task);
>  
>  	switch (idx) {
> +	case 12:
> +		/*
> +		 * We have some ABI weirdness here in the way that we handle
> +		 * syscall exit stops because we indicate whether or not the
> +		 * stop has been signalled from syscall entry or syscall exit
> +		 * by clobbering the general purpose register r12.
> +		 */
> +		switch (task->ptrace_message) {
> +		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> +			return PTRACE_SYSCALL_ENTER;
> +		case PTRACE_EVENTMSG_SYSCALL_EXIT:
> +			return PTRACE_SYSCALL_EXIT;
> +		}
> +		return regs->regs[idx];
>  	case 15:
>  		return regs->pc;
>  	case 16:
> @@ -1282,6 +1332,17 @@ static int compat_gpr_set(struct task_struct *target,
>  
>  	}
>  
> +	/*
> +	 * Historically, x12 can't be changed if the stop has been signalled
> +	 * from syscall-enter of syscall-exit.
> +	 */
> +	switch (target->ptrace_message) {
> +	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
> +	case PTRACE_EVENTMSG_SYSCALL_EXIT:
> +		newregs.regs[12] = task_pt_regs(target)->regs[12];
> +		break;
> +	}
> +
>  	if (valid_user_regs(&newregs.user_regs, target))
>  		*task_pt_regs(target) = newregs;
>  	else
> @@ -1740,53 +1801,16 @@ long arch_ptrace(struct task_struct *child, long request,
>  	return ptrace_request(child, request, addr, data);
>  }
>  
> -enum ptrace_syscall_dir {
> -	PTRACE_SYSCALL_ENTER = 0,
> -	PTRACE_SYSCALL_EXIT,
> -};
> -
>  static void tracehook_report_syscall(struct pt_regs *regs,
>  				     enum ptrace_syscall_dir dir)
>  {
> -	int regno;
> -	unsigned long saved_reg;
> -
> -	/*
> -	 * We have some ABI weirdness here in the way that we handle syscall
> -	 * exit stops because we indicate whether or not the stop has been
> -	 * signalled from syscall entry or syscall exit by clobbering a general
> -	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> -	 * and restoring its old value after the stop. This means that:
> -	 *
> -	 * - Any writes by the tracer to this register during the stop are
> -	 *   ignored/discarded.
> -	 *
> -	 * - The actual value of the register is not available during the stop,
> -	 *   so the tracer cannot save it and restore it later.
> -	 *
> -	 * - Syscall stops behave differently to seccomp and pseudo-step traps
> -	 *   (the latter do not nobble any registers).
> -	 */
> -	regno = (is_compat_task() ? 12 : 7);
> -	saved_reg = regs->regs[regno];
> -	regs->regs[regno] = dir;
> -
>  	if (dir == PTRACE_SYSCALL_ENTER) {
>  		if (tracehook_report_syscall_entry(regs))
>  			forget_syscall(regs);
> -		regs->regs[regno] = saved_reg;
> -	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
> -		tracehook_report_syscall_exit(regs, 0);
> -		regs->regs[regno] = saved_reg;
>  	} else {
> -		regs->regs[regno] = saved_reg;
> +		int singlestep = test_thread_flag(TIF_SINGLESTEP);
>  
> -		/*
> -		 * Signal a pseudo-step exception since we are stepping but
> -		 * tracer modifications to the registers may have rewound the
> -		 * state machine.
> -		 */
> -		tracehook_report_syscall_exit(regs, 1);
> +		tracehook_report_syscall_exit(regs, singlestep);

Again, please preserve the comment in some form (maybe "... if we are
stepping since tracer ...").

That said, doesn't your change above break the pseudo-step trap? Currently,
we report the real x7 for those.

Will
