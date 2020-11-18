Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A978F2B836E
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 18:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgKRRzr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 12:55:47 -0500
Received: from foss.arm.com ([217.140.110.172]:60934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgKRRzq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Nov 2020 12:55:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9397E1534;
        Wed, 18 Nov 2020 09:55:45 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 296053F718;
        Wed, 18 Nov 2020 09:55:44 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:55:40 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-api@vger.kernel.org, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201118175539.GH6882@arm.com>
References: <20201014055106.25164-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014055106.25164-1-pcc@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 13, 2020 at 10:51:06PM -0700, Peter Collingbourne wrote:
> This prctl allows the user program to control which PAC keys are enabled
> in a particular task. The main reason why this is useful is to enable a
> userspace ABI that uses PAC to sign and authenticate function pointers
> and other pointers exposed outside of the function, while still allowing
> binaries conforming to the ABI to interoperate with legacy binaries that
> do not sign or authenticate pointers.

Does this boil down to using the B key(s) to sign pointers that flow
across library boundaries?

ld.so would then need a control to turn off the B key off if, say,
the main program or some random library it uses hasn't been rebuilt
to enable this signing.

(I think we discussed this before, but I keep forgetting the exact
rationale.)

> The idea is that a dynamic loader or early startup code would issue
> this prctl very early after establishing that a process may load legacy
> binaries, but before executing any PAC instructions.

We probably need a new program property in ELF to describe this.

Currently, there is GNU_PROPERTY_AARCH64_FEATURE_1_PAC, which does not
specify a key -- but I think it could be defined retrospectively to
apply to just the APIA key, say.

This raises the question of whether the kernel should actually turn the
keys on or off based on these flags.  For historical compatibility,
probably not -- but we could perhaps do that for the B key since the ABI
for use of the B key is entirely unstandardised so far.


I'll take a look at the patch tomorrow -- my brain isn't functioning
right now.

Cheers
---Dave

> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
> ---
> This patch must be applied on top of Catalin's MTE series:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte
> 
> Alternatively the series with this patch on top may be
> downloaded from Gerrit by following the link above.
> 
> v2:
> - added prctl(PR_PAC_GET_ENABLED_KEYS)
> - added ptrace APIs for getting and setting the set of enabled
>   keys
> - optimized the instruction sequence for kernel entry/exit
> - rebased on top of MTE series
> 
>  .../arm64/pointer-authentication.rst          | 27 +++++++++
>  arch/arm64/include/asm/pointer_auth.h         | 11 ++++
>  arch/arm64/include/asm/processor.h            | 21 ++++++-
>  arch/arm64/include/asm/sysreg.h               |  4 +-
>  arch/arm64/kernel/asm-offsets.c               |  1 +
>  arch/arm64/kernel/entry.S                     | 27 +++++++++
>  arch/arm64/kernel/mte.c                       | 39 +++----------
>  arch/arm64/kernel/pointer_auth.c              | 56 +++++++++++++++++++
>  arch/arm64/kernel/process.c                   | 37 ++++++++++++
>  arch/arm64/kernel/ptrace.c                    | 41 ++++++++++++++
>  arch/arm64/kernel/setup.c                     | 10 ++++
>  include/uapi/linux/elf.h                      |  1 +
>  include/uapi/linux/prctl.h                    |  4 ++
>  kernel/sys.c                                  | 16 ++++++
>  14 files changed, 261 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
> index 30b2ab06526b..1f7e064deeb3 100644
> --- a/Documentation/arm64/pointer-authentication.rst
> +++ b/Documentation/arm64/pointer-authentication.rst
> @@ -107,3 +107,30 @@ filter out the Pointer Authentication system key registers from
>  KVM_GET/SET_REG_* ioctls and mask those features from cpufeature ID
>  register. Any attempt to use the Pointer Authentication instructions will
>  result in an UNDEFINED exception being injected into the guest.
> +
> +
> +Enabling and disabling keys
> +---------------------------
> +
> +The prctl PR_PAC_SET_ENABLED_KEYS allows the user program to control which
> +PAC keys are enabled in a particular task. It takes two arguments, the
> +first being a bitmask of PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY
> +and PR_PAC_APDBKEY specifying which keys shall be affected by this prctl,
> +and the second being a bitmask of the same bits specifying whether the key
> +should be enabled or disabled. For example::
> +
> +  prctl(PR_PAC_SET_ENABLED_KEYS,
> +        PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY,
> +        PR_PAC_APIBKEY, 0, 0);
> +
> +disables all keys except the IB key.
> +
> +The main reason why this is useful is to enable a userspace ABI that uses PAC
> +instructions to sign and authenticate function pointers and other pointers
> +exposed outside of the function, while still allowing binaries conforming to
> +the ABI to interoperate with legacy binaries that do not sign or authenticate
> +pointers.
> +
> +The idea is that a dynamic loader or early startup code would issue this
> +prctl very early after establishing that a process may load legacy binaries,
> +but before executing any PAC instructions.
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index c6b4f0603024..662a005d9070 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -3,6 +3,7 @@
>  #define __ASM_POINTER_AUTH_H
>  
>  #include <linux/bitops.h>
> +#include <linux/prctl.h>
>  #include <linux/random.h>
>  
>  #include <asm/cpufeature.h>
> @@ -71,6 +72,11 @@ static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kerne
>  
>  extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
>  
> +extern int ptrauth_prctl_set_enabled_keys(struct task_struct *tsk,
> +					  unsigned long keys,
> +					  unsigned long enabled);
> +extern int ptrauth_prctl_get_enabled_keys(struct task_struct *tsk);
> +
>  static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
>  {
>  	return ptrauth_clear_pac(ptr);
> @@ -85,10 +91,15 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
>  
>  #else /* CONFIG_ARM64_PTR_AUTH */
>  #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
> +#define ptrauth_prctl_set_enabled_keys(tsk, keys, enabled)	(-EINVAL)
> +#define ptrauth_prctl_get_enabled_keys(tsk)	(-EINVAL)
>  #define ptrauth_strip_insn_pac(lr)	(lr)
>  #define ptrauth_thread_init_user(tsk)
>  #define ptrauth_thread_init_kernel(tsk)
>  #define ptrauth_thread_switch_kernel(tsk)
>  #endif /* CONFIG_ARM64_PTR_AUTH */
>  
> +#define PR_PAC_ENABLED_KEYS_MASK                                               \
> +	(PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY)
> +
>  #endif /* __ASM_POINTER_AUTH_H */
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fec204d28fce..68c9d8064759 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -152,11 +152,17 @@ struct thread_struct {
>  	struct ptrauth_keys_kernel	keys_kernel;
>  #endif
>  #ifdef CONFIG_ARM64_MTE
> -	u64			sctlr_tcf0;
>  	u64			gcr_user_incl;
>  #endif
> +	u64			sctlr;
>  };
>  
> +extern u64 init_sctlr;
> +
> +#define SCTLR_TASK_MASK                                                        \
> +	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
> +	 SCTLR_EL1_TCF0_MASK)
> +
>  static inline void arch_thread_struct_whitelist(unsigned long *offset,
>  						unsigned long *size)
>  {
> @@ -263,6 +269,14 @@ extern void release_thread(struct task_struct *);
>  
>  unsigned long get_wchan(struct task_struct *p);
>  
> +#if defined(CONFIG_ARM64_PTR_AUTH) || defined(CONFIG_ARM64_MTE)
> +void set_task_sctlr_el1(u64 sctlr);
> +#else
> +static inline void set_task_sctlr_el1(u64 sctlr)
> +{
> +}
> +#endif
> +
>  /* Thread switching */
>  extern struct task_struct *cpu_switch_to(struct task_struct *prev,
>  					 struct task_struct *next);
> @@ -317,6 +331,11 @@ extern void __init minsigstksz_setup(void);
>  /* PR_PAC_RESET_KEYS prctl */
>  #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
>  
> +/* PR_PAC_{SET,GET}_ENABLED_KEYS prctl */
> +#define PAC_SET_ENABLED_KEYS(tsk, keys, enabled)				\
> +	ptrauth_prctl_set_enabled_keys(tsk, keys, enabled)
> +#define PAC_GET_ENABLED_KEYS(tsk) ptrauth_prctl_get_enabled_keys(tsk)
> +
>  #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
>  /* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
>  long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 52eefe2f7d95..912150361338 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -548,8 +548,10 @@
>  #define SCTLR_ELx_TCF_ASYNC	(UL(0x2) << SCTLR_ELx_TCF_SHIFT)
>  #define SCTLR_ELx_TCF_MASK	(UL(0x3) << SCTLR_ELx_TCF_SHIFT)
>  
> +#define SCTLR_ELx_ENIA_SHIFT	31
> +
>  #define SCTLR_ELx_ITFSB	(BIT(37))
> -#define SCTLR_ELx_ENIA	(BIT(31))
> +#define SCTLR_ELx_ENIA	(BIT(SCTLR_ELx_ENIA_SHIFT))
>  #define SCTLR_ELx_ENIB	(BIT(30))
>  #define SCTLR_ELx_ENDA	(BIT(27))
>  #define SCTLR_ELx_EE    (BIT(25))
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 7d32fc959b1a..cb49d4f31540 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -48,6 +48,7 @@ int main(void)
>    DEFINE(THREAD_KEYS_USER,	offsetof(struct task_struct, thread.keys_user));
>    DEFINE(THREAD_KEYS_KERNEL,	offsetof(struct task_struct, thread.keys_kernel));
>  #endif
> +  DEFINE(THREAD_SCTLR,		offsetof(struct task_struct, thread.sctlr));
>    BLANK();
>    DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
>    DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ff34461524d4..19d24666b529 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -214,6 +214,18 @@ alternative_else_nop_endif
>  
>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>  
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +alternative_if ARM64_HAS_ADDRESS_AUTH
> +	/* Enable IA for in-kernel PAC if the task had it disabled. */
> +	ldr	x0, [tsk, THREAD_SCTLR]
> +	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
> +	mrs	x0, sctlr_el1
> +	orr	x0, x0, SCTLR_ELx_ENIA
> +	msr	sctlr_el1, x0
> +1:
> +alternative_else_nop_endif
> +#endif
> +
>  	scs_load tsk, x20
>  	.else
>  	add	x21, sp, #S_FRAME_SIZE
> @@ -332,6 +344,21 @@ alternative_else_nop_endif
>  	/* No kernel C function calls after this as user keys are set. */
>  	ptrauth_keys_install_user tsk, x0, x1, x2
>  
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +alternative_if ARM64_HAS_ADDRESS_AUTH
> +	/*
> +	 * IA was enabled for in-kernel PAC. Disable it now if needed.
> +	 * All other per-task SCTLR bits were updated on task switch.
> +	 */
> +	ldr	x0, [tsk, THREAD_SCTLR]
> +	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
> +	mrs	x0, sctlr_el1
> +	bic	x0, x0, SCTLR_ELx_ENIA
> +	msr	sctlr_el1, x0
> +1:
> +alternative_else_nop_endif
> +#endif
> +
>  	apply_ssbd 0, x0, x1
>  	.endif
>  
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 52a0638ed967..60238a5e3c82 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -72,26 +72,6 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  	return ret;
>  }
>  
> -static void update_sctlr_el1_tcf0(u64 tcf0)
> -{
> -	/* ISB required for the kernel uaccess routines */
> -	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
> -	isb();
> -}
> -
> -static void set_sctlr_el1_tcf0(u64 tcf0)
> -{
> -	/*
> -	 * mte_thread_switch() checks current->thread.sctlr_tcf0 as an
> -	 * optimisation. Disable preemption so that it does not see
> -	 * the variable update before the SCTLR_EL1.TCF0 one.
> -	 */
> -	preempt_disable();
> -	current->thread.sctlr_tcf0 = tcf0;
> -	update_sctlr_el1_tcf0(tcf0);
> -	preempt_enable();
> -}
> -
>  static void update_gcr_el1_excl(u64 incl)
>  {
>  	u64 excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
> @@ -120,8 +100,6 @@ void flush_mte_state(void)
>  	dsb(ish);
>  	write_sysreg_s(0, SYS_TFSRE0_EL1);
>  	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> -	/* disable tag checking */
> -	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
>  	/* reset tag generation mask */
>  	set_gcr_el1_excl(0);
>  }
> @@ -131,9 +109,6 @@ void mte_thread_switch(struct task_struct *next)
>  	if (!system_supports_mte())
>  		return;
>  
> -	/* avoid expensive SCTLR_EL1 accesses if no change */
> -	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> -		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
>  	update_gcr_el1_excl(next->thread.gcr_user_incl);
>  }
>  
> @@ -147,7 +122,7 @@ void mte_suspend_exit(void)
>  
>  long set_mte_ctrl(struct task_struct *task, unsigned long arg)
>  {
> -	u64 tcf0;
> +	u64 sctlr = task->thread.sctlr & ~SCTLR_EL1_TCF0_MASK;
>  	u64 gcr_incl = (arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT;
>  
>  	if (!system_supports_mte())
> @@ -155,23 +130,23 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
>  
>  	switch (arg & PR_MTE_TCF_MASK) {
>  	case PR_MTE_TCF_NONE:
> -		tcf0 = SCTLR_EL1_TCF0_NONE;
> +		sctlr |= SCTLR_EL1_TCF0_NONE;
>  		break;
>  	case PR_MTE_TCF_SYNC:
> -		tcf0 = SCTLR_EL1_TCF0_SYNC;
> +		sctlr |= SCTLR_EL1_TCF0_SYNC;
>  		break;
>  	case PR_MTE_TCF_ASYNC:
> -		tcf0 = SCTLR_EL1_TCF0_ASYNC;
> +		sctlr |= SCTLR_EL1_TCF0_ASYNC;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
>  	if (task != current) {
> -		task->thread.sctlr_tcf0 = tcf0;
> +		task->thread.sctlr = sctlr;
>  		task->thread.gcr_user_incl = gcr_incl;
>  	} else {
> -		set_sctlr_el1_tcf0(tcf0);
> +		set_task_sctlr_el1(sctlr);
>  		set_gcr_el1_excl(gcr_incl);
>  	}
>  
> @@ -187,7 +162,7 @@ long get_mte_ctrl(struct task_struct *task)
>  
>  	ret = task->thread.gcr_user_incl << PR_MTE_TAG_SHIFT;
>  
> -	switch (task->thread.sctlr_tcf0) {
> +	switch (task->thread.sctlr & SCTLR_EL1_TCF0_MASK) {
>  	case SCTLR_EL1_TCF0_NONE:
>  		return PR_MTE_TCF_NONE;
>  	case SCTLR_EL1_TCF0_SYNC:
> diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> index 1e77736a4f66..0e763e8babd8 100644
> --- a/arch/arm64/kernel/pointer_auth.c
> +++ b/arch/arm64/kernel/pointer_auth.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/compat.h>
>  #include <linux/errno.h>
>  #include <linux/prctl.h>
>  #include <linux/random.h>
> @@ -42,3 +43,58 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
>  
>  	return 0;
>  }
> +
> +static u64 arg_to_enxx_mask(unsigned long arg)
> +{
> +	u64 sctlr_enxx_mask = 0;
> +	if (arg & PR_PAC_APIAKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENIA;
> +	if (arg & PR_PAC_APIBKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENIB;
> +	if (arg & PR_PAC_APDAKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENDA;
> +	if (arg & PR_PAC_APDBKEY)
> +		sctlr_enxx_mask |= SCTLR_ELx_ENDB;
> +	return sctlr_enxx_mask;
> +}
> +
> +int ptrauth_prctl_set_enabled_keys(struct task_struct *tsk, unsigned long keys,
> +				   unsigned long enabled)
> +{
> +	u64 sctlr = tsk->thread.sctlr;
> +
> +	if (!system_supports_address_auth() || is_compat_task())
> +		return -EINVAL;
> +
> +	if ((keys & ~PR_PAC_ENABLED_KEYS_MASK) || (enabled & ~keys))
> +		return -EINVAL;
> +
> +	sctlr &= ~arg_to_enxx_mask(keys);
> +	sctlr |= arg_to_enxx_mask(enabled);
> +	if (tsk == current) {
> +		set_task_sctlr_el1(sctlr);
> +	} else {
> +		tsk->thread.sctlr = sctlr;
> +	}
> +
> +	return 0;
> +}
> +
> +int ptrauth_prctl_get_enabled_keys(struct task_struct *tsk)
> +{
> +	int retval = 0;
> +
> +	if (!system_supports_address_auth() || is_compat_task())
> +		return -EINVAL;
> +
> +	if (tsk->thread.sctlr & SCTLR_ELx_ENIA)
> +		retval |= PR_PAC_APIAKEY;
> +	if (tsk->thread.sctlr & SCTLR_ELx_ENIB)
> +		retval |= PR_PAC_APIBKEY;
> +	if (tsk->thread.sctlr & SCTLR_ELx_ENDA)
> +		retval |= PR_PAC_APDAKEY;
> +	if (tsk->thread.sctlr & SCTLR_ELx_ENDB)
> +		retval |= PR_PAC_APDBKEY;
> +
> +	return retval;
> +}
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 05a9cdd0b471..7fb28ccdf862 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -552,6 +552,37 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
>  	write_sysreg(val, cntkctl_el1);
>  }
>  
> +#if defined(CONFIG_ARM64_PTR_AUTH) || defined(CONFIG_ARM64_MTE)
> +static void update_sctlr_el1(u64 sctlr)
> +{
> +	/*
> +	 * EnIA must not be cleared while in the kernel as this is necessary for
> +	 * in-kernel PAC. It will be cleared on kernel exit if needed.
> +	 */
> +	sysreg_clear_set(sctlr_el1, SCTLR_TASK_MASK & ~SCTLR_ELx_ENIA, sctlr);
> +
> +	/* ISB required for the kernel uaccess routines when setting TCF0. */
> +	isb();
> +}
> +
> +void set_task_sctlr_el1(u64 sctlr)
> +{
> +	/*
> +	 * __switch_to() checks current->thread.sctlr as an
> +	 * optimisation. Disable preemption so that it does not see
> +	 * the variable update before the SCTLR_EL1 one.
> +	 */
> +	preempt_disable();
> +	current->thread.sctlr = sctlr;
> +	update_sctlr_el1(sctlr);
> +	preempt_enable();
> +}
> +#else
> +static void update_sctlr_el1(u64 sctlr)
> +{
> +}
> +#endif  /* defined(CONFIG_ARM64_PTR_AUTH) || defined(CONFIG_ARM64_MTE) */
> +
>  /*
>   * Thread switching.
>   */
> @@ -577,6 +608,10 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  	dsb(ish);
>  
> +	/* avoid expensive SCTLR_EL1 accesses if no change */
> +	if (prev->thread.sctlr != next->thread.sctlr)
> +		update_sctlr_el1(next->thread.sctlr);
> +
>  	/*
>  	 * MTE thread switching must happen after the DSB above to ensure that
>  	 * any asynchronous tag check faults have been logged in the TFSR*_EL1
> @@ -631,6 +666,8 @@ unsigned long arch_align_stack(unsigned long sp)
>  void arch_setup_new_exec(void)
>  {
>  	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
> +	if (current->thread.sctlr != init_sctlr)
> +		set_task_sctlr_el1(init_sctlr);
>  
>  	ptrauth_thread_init_user(current);
>  }
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index f49b349e16a3..2ed17fb07666 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -911,6 +911,38 @@ static int pac_mask_get(struct task_struct *target,
>  	return membuf_write(&to, &uregs, sizeof(uregs));
>  }
>  
> +static int pac_enabled_keys_get(struct task_struct *target,
> +				const struct user_regset *regset,
> +				struct membuf to)
> +{
> +	long enabled_keys = ptrauth_prctl_get_enabled_keys(target);
> +
> +	if (IS_ERR_VALUE(enabled_keys))
> +		return enabled_keys;
> +
> +	return membuf_write(&to, &enabled_keys, sizeof(enabled_keys));
> +}
> +
> +static int pac_enabled_keys_set(struct task_struct *target,
> +				const struct user_regset *regset,
> +				unsigned int pos, unsigned int count,
> +				const void *kbuf, const void __user *ubuf)
> +{
> +	int ret;
> +	long enabled_keys = ptrauth_prctl_get_enabled_keys(target);
> +
> +	if (IS_ERR_VALUE(enabled_keys))
> +		return enabled_keys;
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				 &enabled_keys, 0, -1);
> +	if (ret)
> +		return ret;
> +
> +	return ptrauth_prctl_set_enabled_keys(target, PR_PAC_ENABLED_KEYS_MASK,
> +					      enabled_keys);
> +}
> +
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  static __uint128_t pac_key_to_user(const struct ptrauth_key *key)
>  {
> @@ -1076,6 +1108,7 @@ enum aarch64_regset {
>  #endif
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  	REGSET_PAC_MASK,
> +	REGSET_PAC_ENABLED_KEYS,
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	REGSET_PACA_KEYS,
>  	REGSET_PACG_KEYS,
> @@ -1162,6 +1195,14 @@ static const struct user_regset aarch64_regsets[] = {
>  		.regset_get = pac_mask_get,
>  		/* this cannot be set dynamically */
>  	},
> +	[REGSET_PAC_ENABLED_KEYS] = {
> +		.core_note_type = NT_ARM_PAC_ENABLED_KEYS,
> +		.n = 1,
> +		.size = sizeof(long),
> +		.align = sizeof(long),
> +		.regset_get = pac_enabled_keys_get,
> +		.set = pac_enabled_keys_set,
> +	},
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	[REGSET_PACA_KEYS] = {
>  		.core_note_type = NT_ARM_PACA_KEYS,
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 77c4c9bad1b8..91932215a6dd 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -282,6 +282,8 @@ u64 cpu_logical_map(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpu_logical_map);
>  
> +u64 init_sctlr;
> +
>  void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  {
>  	init_mm.start_code = (unsigned long) _text;
> @@ -370,6 +372,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
>  #endif
>  
> +	/*
> +	 * Stash a task's initial SCTLR_EL1 per-task bits, which is the same as
> +	 * the value that it was set to by the early startup code.
> +	 */
> +	asm("mrs %0, sctlr_el1" : "=r"(init_sctlr));
> +	init_sctlr &= SCTLR_TASK_MASK;
> +	init_task.thread.sctlr = init_sctlr;
> +
>  	if (boot_args[1] || boot_args[2] || boot_args[3]) {
>  		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
>  			"\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 30f68b42eeb5..61bf4774b8f2 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -426,6 +426,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
>  #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
>  #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
> +#define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
>  #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
>  #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
>  #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 7f0827705c9a..0d1bb3a2e59a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -247,4 +247,8 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +/* Set/get enabled arm64 pointer authentication keys */
> +#define PR_PAC_SET_ENABLED_KEYS		59
> +#define PR_PAC_GET_ENABLED_KEYS		60
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ab6c409b1159..0cbd5841e521 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -119,6 +119,12 @@
>  #ifndef PAC_RESET_KEYS
>  # define PAC_RESET_KEYS(a, b)	(-EINVAL)
>  #endif
> +#ifndef PAC_SET_ENABLED_KEYS
> +# define PAC_SET_ENABLED_KEYS(a, b, c)	(-EINVAL)
> +#endif
> +#ifndef PAC_GET_ENABLED_KEYS
> +# define PAC_GET_ENABLED_KEYS(a)	(-EINVAL)
> +#endif
>  #ifndef SET_TAGGED_ADDR_CTRL
>  # define SET_TAGGED_ADDR_CTRL(a)	(-EINVAL)
>  #endif
> @@ -2497,6 +2503,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = PAC_RESET_KEYS(me, arg2);
>  		break;
> +	case PR_PAC_SET_ENABLED_KEYS:
> +		if (arg4 || arg5)
> +			return -EINVAL;
> +		error = PAC_SET_ENABLED_KEYS(me, arg2, arg3);
> +		break;
> +	case PR_PAC_GET_ENABLED_KEYS:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = PAC_GET_ENABLED_KEYS(me);
> +		break;
>  	case PR_SET_TAGGED_ADDR_CTRL:
>  		if (arg3 || arg4 || arg5)
>  			return -EINVAL;
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
