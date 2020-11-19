Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE22B9A5C
	for <lists+linux-api@lfdr.de>; Thu, 19 Nov 2020 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgKSSID (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Nov 2020 13:08:03 -0500
Received: from foss.arm.com ([217.140.110.172]:36718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKSSID (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Nov 2020 13:08:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D4AD1396;
        Thu, 19 Nov 2020 10:08:01 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1030A3F70D;
        Thu, 19 Nov 2020 10:07:59 -0800 (PST)
Date:   Thu, 19 Nov 2020 18:07:56 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
Message-ID: <20201119180754.GM6882@arm.com>
References: <20201119052011.3307433-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119052011.3307433-1-pcc@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 18, 2020 at 09:20:11PM -0800, Peter Collingbourne wrote:
> This prctl allows the user program to control which PAC keys are enabled

(Nit: you know what's coming ;)  What prctl?  What does this patch do?)

> in a particular task. The main reason why this is useful is to enable a
> userspace ABI that uses PAC to sign and authenticate function pointers
> and other pointers exposed outside of the function, while still allowing
> binaries conforming to the ABI to interoperate with legacy binaries that
> do not sign or authenticate pointers.
> 
> The idea is that a dynamic loader or early startup code would issue
> this prctl very early after establishing that a process may load legacy
> binaries, but before executing any PAC instructions.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(but with various nits and caveats noted below, if there is time to
address them before this needs to be picked up.  I don't see any actual
bug though.)

> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
> ---
> v3:
> - fix some style nits
> - move kernel entry ISB to after setting EnIA
> - rename sctlr -> sctlr_user
> - remove init_sctlr
> 
> v2:
> - added prctl(PR_PAC_GET_ENABLED_KEYS)
> - added ptrace APIs for getting and setting the set of enabled
>   keys
> - optimized the instruction sequence for kernel entry/exit
> - rebased on top of MTE series
> 
>  .../arm64/pointer-authentication.rst          | 27 +++++++++
>  arch/arm64/include/asm/mte.h                  |  4 +-
>  arch/arm64/include/asm/pointer_auth.h         | 26 ++++++++-
>  arch/arm64/include/asm/processor.h            | 19 ++++++-
>  arch/arm64/include/asm/sysreg.h               |  4 +-
>  arch/arm64/kernel/asm-offsets.c               |  1 +
>  arch/arm64/kernel/entry.S                     | 30 +++++++++-
>  arch/arm64/kernel/mte.c                       | 42 ++++----------
>  arch/arm64/kernel/pointer_auth.c              | 55 +++++++++++++++++++
>  arch/arm64/kernel/process.c                   | 39 ++++++++++++-
>  arch/arm64/kernel/ptrace.c                    | 41 ++++++++++++++
>  include/uapi/linux/elf.h                      |  1 +
>  include/uapi/linux/prctl.h                    |  4 ++
>  kernel/sys.c                                  | 16 ++++++
>  14 files changed, 267 insertions(+), 42 deletions(-)
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
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 1c99fcadb58c..adbb05ece04c 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -37,7 +37,7 @@ void mte_free_tag_storage(char *storage);
>  
>  void mte_sync_tags(pte_t *ptep, pte_t pte);
>  void mte_copy_page_tags(void *kto, const void *kfrom);
> -void flush_mte_state(void);
> +void mte_thread_init_user(void);
>  void mte_thread_switch(struct task_struct *next);
>  void mte_suspend_exit(void);
>  long set_mte_ctrl(struct task_struct *task, unsigned long arg);
> @@ -56,7 +56,7 @@ static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
>  static inline void mte_copy_page_tags(void *kto, const void *kfrom)
>  {
>  }
> -static inline void flush_mte_state(void)
> +static inline void mte_thread_init_user(void)

I'm finding some of the refactoring a bit difficult to follow.

If respinning this patch, please consider splitting it into two:
the SCTLR_EL1 management refactoring can come first, followed by the new
prctl functionality.

>  {
>  }
>  static inline void mte_thread_switch(struct task_struct *next)
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index c6b4f0603024..8346f6e60736 100644
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
> @@ -71,13 +72,27 @@ static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kerne
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
>  }
>  
> -#define ptrauth_thread_init_user(tsk)					\
> -	ptrauth_keys_init_user(&(tsk)->thread.keys_user)
> +#define ptrauth_thread_init_user()                                             \

Argument mysteriously dropped.  Was this because there are in fact no
uses of this macro specifying a task other than current?

> +	do {                                                                   \
> +		ptrauth_keys_init_user(&current->thread.keys_user);            \
> +									       \
> +		/* enable all keys */                                          \
> +		if (system_supports_address_auth())                            \
> +			set_task_sctlr_el1(current->thread.sctlr_user |        \
> +					   SCTLR_ELx_ENIA | SCTLR_ELx_ENIB |   \
> +					   SCTLR_ELx_ENDA | SCTLR_ELx_ENDB);   \
> +	} while (0)
> +
>  #define ptrauth_thread_init_kernel(tsk)					\
>  	ptrauth_keys_init_kernel(&(tsk)->thread.keys_kernel)
>  #define ptrauth_thread_switch_kernel(tsk)				\
> @@ -85,10 +100,15 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
>  
>  #else /* CONFIG_ARM64_PTR_AUTH */
>  #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
> +#define ptrauth_prctl_set_enabled_keys(tsk, keys, enabled)	(-EINVAL)
> +#define ptrauth_prctl_get_enabled_keys(tsk)	(-EINVAL)
>  #define ptrauth_strip_insn_pac(lr)	(lr)
> -#define ptrauth_thread_init_user(tsk)
> +#define ptrauth_thread_init_user()
>  #define ptrauth_thread_init_kernel(tsk)
>  #define ptrauth_thread_switch_kernel(tsk)
>  #endif /* CONFIG_ARM64_PTR_AUTH */
>  
> +#define PR_PAC_ENABLED_KEYS_MASK                                               \
> +	(PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY)
> +
>  #endif /* __ASM_POINTER_AUTH_H */
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fce8cbecd6bc..f430dd2fb61a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -153,11 +153,15 @@ struct thread_struct {
>  	struct ptrauth_keys_kernel	keys_kernel;
>  #endif
>  #ifdef CONFIG_ARM64_MTE
> -	u64			sctlr_tcf0;
>  	u64			gcr_user_incl;
>  #endif
> +	u64			sctlr_user;

Strange, isn't all the logic for handling this conditional?

(Similarly in asm-offsets.c.)

>  };
>  
> +#define SCTLR_USER_MASK                                                        \
> +	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
> +	 SCTLR_EL1_TCF0_MASK)
> +
>  static inline void arch_thread_struct_whitelist(unsigned long *offset,
>  						unsigned long *size)
>  {
> @@ -249,6 +253,14 @@ extern void release_thread(struct task_struct *);
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
> @@ -303,6 +315,11 @@ extern void __init minsigstksz_setup(void);
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
> index e2ef4c2edf06..96e3337ca7b3 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -554,8 +554,10 @@
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
> index 7d32fc959b1a..062d3e37edb5 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -48,6 +48,7 @@ int main(void)
>    DEFINE(THREAD_KEYS_USER,	offsetof(struct task_struct, thread.keys_user));
>    DEFINE(THREAD_KEYS_KERNEL,	offsetof(struct task_struct, thread.keys_kernel));
>  #endif
> +  DEFINE(THREAD_SCTLR_USER,	offsetof(struct task_struct, thread.sctlr_user));
>    BLANK();
>    DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
>    DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index b295fb912b12..c8c1a284a76a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -210,7 +210,20 @@ alternative_else_nop_endif
>  	check_mte_async_tcf x19, x22
>  	apply_ssbd 1, x22, x23
>  
> -	ptrauth_keys_install_kernel tsk, x20, x22, x23
> +	ptrauth_keys_install_kernel_nosync tsk, x20, x22, x23
> +
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +alternative_if ARM64_HAS_ADDRESS_AUTH
> +	/* Enable IA for in-kernel PAC if the task had it disabled. */
> +	ldr	x0, [tsk, THREAD_SCTLR_USER]
> +	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
> +	mrs	x0, sctlr_el1
> +	orr	x0, x0, SCTLR_ELx_ENIA
> +	msr	sctlr_el1, x0

Was it slower to do

	mrs	x0, sctlr_el1
	tbz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
	orr	x0, x0, SCTLR_ELx_ENIA
	msr	sctlr_el1, x0

This gets rid of a load feels a bit less fragile, since we don't rely on
thread->sctlr_user being correct any more.

(If the performance of testing the result of MRS is worse, it would be
good to have a comment explaining why the code it the way it is.)


> +1:
> +	isb
> +alternative_else_nop_endif
> +#endif
>  
>  	scs_load tsk, x20
>  	.else
> @@ -330,6 +343,21 @@ alternative_else_nop_endif
>  	/* No kernel C function calls after this as user keys are set. */
>  	ptrauth_keys_install_user tsk, x0, x1, x2
>  
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +alternative_if ARM64_HAS_ADDRESS_AUTH
> +	/*
> +	 * IA was enabled for in-kernel PAC. Disable it now if needed.
> +	 * All other per-task SCTLR bits were updated on task switch.
> +	 */

Might be worth commenting that the kernel must not use ptrauth
instructions from here on in.

> +	ldr	x0, [tsk, THREAD_SCTLR_USER]
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
> index 52a0638ed967..16040a1e0fd1 100644
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
> @@ -111,7 +91,7 @@ static void set_gcr_el1_excl(u64 incl)
>  	update_gcr_el1_excl(incl);
>  }
>  
> -void flush_mte_state(void)
> +void mte_thread_init_user(void)
>  {
>  	if (!system_supports_mte())
>  		return;
> @@ -121,7 +101,8 @@ void flush_mte_state(void)
>  	write_sysreg_s(0, SYS_TFSRE0_EL1);
>  	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
>  	/* disable tag checking */
> -	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
> +	set_task_sctlr_el1((current->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK) |
> +			   SCTLR_EL1_TCF0_NONE);

This (and the corresponding ptrauth init code) feels fragile.

We modify some random bits in bits of code that aren't next to each
other, and hope that they add up to the complete set of bits that are
under user control.

Can we add code to purge thread->sctlr_el1 to 0 before making these
modifications or (perhaps simpler) just set it to a constant mask of the
wanted bits?

Failing that, can we at least move the relevant bits of code next to
each other?

>  	/* reset tag generation mask */
>  	set_gcr_el1_excl(0);
>  }
> @@ -131,9 +112,6 @@ void mte_thread_switch(struct task_struct *next)
>  	if (!system_supports_mte())
>  		return;
>  
> -	/* avoid expensive SCTLR_EL1 accesses if no change */
> -	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> -		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
>  	update_gcr_el1_excl(next->thread.gcr_user_incl);
>  }
>  
> @@ -147,7 +125,7 @@ void mte_suspend_exit(void)
>  
>  long set_mte_ctrl(struct task_struct *task, unsigned long arg)
>  {
> -	u64 tcf0;
> +	u64 sctlr = task->thread.sctlr_user & ~SCTLR_EL1_TCF0_MASK;
>  	u64 gcr_incl = (arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT;
>  
>  	if (!system_supports_mte())
> @@ -155,23 +133,23 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
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
> +		task->thread.sctlr_user = sctlr;
>  		task->thread.gcr_user_incl = gcr_incl;
>  	} else {
> -		set_sctlr_el1_tcf0(tcf0);
> +		set_task_sctlr_el1(sctlr);
>  		set_gcr_el1_excl(gcr_incl);
>  	}
>  
> @@ -187,7 +165,7 @@ long get_mte_ctrl(struct task_struct *task)
>  
>  	ret = task->thread.gcr_user_incl << PR_MTE_TAG_SHIFT;
>  
> -	switch (task->thread.sctlr_tcf0) {
> +	switch (task->thread.sctlr_user & SCTLR_EL1_TCF0_MASK) {
>  	case SCTLR_EL1_TCF0_NONE:
>  		return PR_MTE_TCF_NONE;
>  	case SCTLR_EL1_TCF0_SYNC:
> diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> index adb955fd9bdd..025f38dff464 100644
> --- a/arch/arm64/kernel/pointer_auth.c
> +++ b/arch/arm64/kernel/pointer_auth.c
> @@ -46,3 +46,58 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
>  
>  	return 0;
>  }
> +
> +static u64 arg_to_enxx_mask(unsigned long arg)
> +{
> +	u64 sctlr_enxx_mask = 0;

BUILD_BUG_ON(arg & ~PR_PAC_ENABLED_KEYS_MASK) perhaps.

(I'm concerned other calls to this helper might eventually get added
elsewhere that don't do the necessary policing before passing arg in.)

> +
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

Can we drop the _prctl_ here?  This is used by ptrace too (I was bemused
by the presence of the task == current check before I realised this.)

> +{
> +	u64 sctlr = tsk->thread.sctlr_user;
> +
> +	if (!system_supports_address_auth() || is_compat_task())
> +		return -EINVAL;
> +
> +	if ((keys & ~PR_PAC_ENABLED_KEYS_MASK) || (enabled & ~keys))
> +		return -EINVAL;
> +
> +	sctlr &= ~arg_to_enxx_mask(keys);
> +	sctlr |= arg_to_enxx_mask(enabled);
> +	if (tsk == current)
> +		set_task_sctlr_el1(sctlr);
> +	else
> +		tsk->thread.sctlr_user = sctlr;
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
> +	if (tsk->thread.sctlr_user & SCTLR_ELx_ENIA)
> +		retval |= PR_PAC_APIAKEY;
> +	if (tsk->thread.sctlr_user & SCTLR_ELx_ENIB)
> +		retval |= PR_PAC_APIBKEY;
> +	if (tsk->thread.sctlr_user & SCTLR_ELx_ENDA)
> +		retval |= PR_PAC_APDAKEY;
> +	if (tsk->thread.sctlr_user & SCTLR_ELx_ENDB)
> +		retval |= PR_PAC_APDBKEY;
> +
> +	return retval;
> +}
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index a47a40ec6ad9..aa8bf0294c5d 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -339,7 +339,6 @@ void flush_thread(void)
>  	tls_thread_flush();
>  	flush_ptrace_hw_breakpoint(current);
>  	flush_tagged_addr_state();
> -	flush_mte_state();

See __switch_to().

>  }
>  
>  void release_thread(struct task_struct *dead_task)
> @@ -541,6 +540,37 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
>  	write_sysreg(val, cntkctl_el1);
>  }
>  
> +#if defined(CONFIG_ARM64_PTR_AUTH) || defined(CONFIG_ARM64_MTE)

Can we have a dedicated Kconfig symbol for this and have
CONFIG_ARM64_PTR_AUTH and CONFIG_ARM64_MTE depend on it?  Otherwise, we
duplicate this condition all over the place, inviting future
mis-maintenance.

Having a single config option should also make it easier to rip out the
old behaviour in the future if we want to simplify the code later on.

> +static void update_sctlr_el1(u64 sctlr)
> +{
> +	/*
> +	 * EnIA must not be cleared while in the kernel as this is necessary for
> +	 * in-kernel PAC. It will be cleared on kernel exit if needed.
> +	 */
> +	sysreg_clear_set(sctlr_el1, SCTLR_USER_MASK & ~SCTLR_ELx_ENIA, sctlr);

Any reason why we don't just set everything during the return to
userspace -- since we must modify SCTLR_EL1 there anyway?

> +
> +	/* ISB required for the kernel uaccess routines when setting TCF0. */
> +	isb();

If this the reason?  i.e., TCF0 affects uaccess, not just user execution?

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
> +	current->thread.sctlr_user = sctlr;
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
> @@ -566,6 +596,10 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  	dsb(ish);
>  
> +	/* avoid expensive SCTLR_EL1 accesses if no change */
> +	if (prev->thread.sctlr_user != next->thread.sctlr_user)
> +		update_sctlr_el1(next->thread.sctlr_user);
> +
>  	/*
>  	 * MTE thread switching must happen after the DSB above to ensure that
>  	 * any asynchronous tag check faults have been logged in the TFSR*_EL1
> @@ -621,7 +655,8 @@ void arch_setup_new_exec(void)
>  {
>  	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>  
> -	ptrauth_thread_init_user(current);
> +	ptrauth_thread_init_user();
> +	mte_thread_init_user();

By moving the MTE thread init from flush_thread() to here, we're moving
it (earlier?) during the exec.  Does this matter?  Is it necessary?

>  
>  	if (task_spec_ssb_noexec(current)) {
>  		arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
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

Why's this a long?  The value must fit in a (nonnegative) int, since it
is also exposed as the return value of prctl().

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

IMHO it's better to avoid the "-1" here in new code and specify the size
of the transferred object explicitly.

We're relying on the regset descriptor magically having the correct
values to match the size of enabled_keys here in order to avoid buffer
overflows, but the compiler can't understand that and won't check it for
us here.

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
> index a730c03ee607..b7f2878f053b 100644
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
> 2.29.2.299.gdc1121823c-goog
> 
