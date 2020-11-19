Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989882B8ACE
	for <lists+linux-api@lfdr.de>; Thu, 19 Nov 2020 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgKSFVJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Nov 2020 00:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSFVI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Nov 2020 00:21:08 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37C8C0613D4
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 21:21:08 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id q1so4191665ilt.6
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 21:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ze6q76ySJczvZTXBsLeWoVDFw3m38wjAvnl1Bi6LPpE=;
        b=XBm3berXvTpQN63TgxpqPgzPTq1UQh4I/hjAaDsX+JQzKTT5+aIoIeyuZBQdznSWNd
         fN4QhFz+hiLrFRVCHVHRO1wVk5UmDPUMUdyKiQ6qY10fftMno5WnPw+LHjwW/NHviP7w
         pVLsy43lqZZ3kLps298ntM1griEM5cMkRmgWmPm18LevIHQqm8KfrEeotdmbMiLHk64s
         z9JmgAjh7NGQ49mIkzTL1IQFmu2NdQMJvOhit/ph8R24MfOn4QmnrCVQzgcvqek15fGn
         4QGBTurq9hGrUSKo0oFB+KIxBzV2MaK9o+f9B//BCrqcMSNuAF5IBdRusYdFlzTDwp5i
         xyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze6q76ySJczvZTXBsLeWoVDFw3m38wjAvnl1Bi6LPpE=;
        b=cFv8EVF1XBlQA0SGuDSguKZAHy25YIFGUEXMeSzAhC06aeioUBt9wUBqcpTN8IqjMp
         KTJRccSiw34UJp5/tyFDgl0wp5fOXRpMeunXYHxCy8VQAvrRHaCrphEh6xggPjsynOZU
         /UBIIvFpMCZ472350i2xkWXb4nifewjXIdE6wAY8UM9c22QQcV0zKTvWwfIDW07+yNKX
         0vroeRDmNLqm3yuKVGsIK9+m1OWMGMKIB2BtvJjZRPLyKAj+adx7jeh5iAhLNr3Jz0Re
         KX7SStAfl9/6ibTu0iMAD2+nVFdz3aFwUCR6Ej02fKEbMFH247ZrLhJxYOPVkPEXzIJw
         /8sw==
X-Gm-Message-State: AOAM533MCHY/wGfYhK92WtD0MYKEkT5sem5M5bFYx6Y0Jt1pfiqWot84
        aZMyY69Dx9+KyeWy0tsYYRxrFHyslTQj3GfatExsYg==
X-Google-Smtp-Source: ABdhPJzekWUbylZxkPpy7n9nLe+9ww+QoS86IVrY7OxDNV29dgJNWxNer1M2vdBR5LoxGHy/nzh6cXSV6YowxvA1+LE=
X-Received: by 2002:a92:d18a:: with SMTP id z10mr19148660ilz.61.1605763267883;
 Wed, 18 Nov 2020 21:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20201014055106.25164-1-pcc@google.com> <X7USqgzzyAWrHoXf@trantor>
In-Reply-To: <X7USqgzzyAWrHoXf@trantor>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 18 Nov 2020 21:20:56 -0800
Message-ID: <CAMn1gO5L=b3RBrMHJ7ULXAf_hU+aLAe1y3TN8TyObZzs92NBng@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 18, 2020 at 4:25 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Oct 13, 2020 at 10:51:06PM -0700, Peter Collingbourne wrote:
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index ff34461524d4..19d24666b529 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -214,6 +214,18 @@ alternative_else_nop_endif
> >
> >       ptrauth_keys_install_kernel tsk, x20, x22, x23
> >
> > +#ifdef CONFIG_ARM64_PTR_AUTH
> > +alternative_if ARM64_HAS_ADDRESS_AUTH
>
> If we get too many instructions, we might as well do (same further
> down):
>
> alternative_if_not ARM64_HAS_ADDRESS_AUTH
>         b       1f
> alternative_else_nop_endif

I benchmarked this on the DragonBoard 845c and the nops were faster
(461.4ns vs 463.8ns) so I left it as is.

> > +     /* Enable IA for in-kernel PAC if the task had it disabled. */
> > +     ldr     x0, [tsk, THREAD_SCTLR]
> > +     tbnz    x0, SCTLR_ELx_ENIA_SHIFT, 1f
> > +     mrs     x0, sctlr_el1
> > +     orr     x0, x0, SCTLR_ELx_ENIA
> > +     msr     sctlr_el1, x0
>
> I now realised that this is missing an ISB. Writes to system registers
> in general are not visible until the context is synchronised. I suggest
> you change the line above your hunk to
> ptrauth_keys_install_kernel_nosync followed by an explicit isb here.
>
> Note that this ISB may affect your benchmark results slightly. I think
> you only used MSR without ISB.

Okay, so for these benchmarks we need to simulate what's happening
after we install the kernel keys (that part we can't do on existing
HW). So we need to compare ISB against conditionally enabling EnIA
followed by ISB. Again I simulate conditional enabling using
conditional disabling to make it compatible with existing HW. I also
measured conditional disabling where the branches are not taken (i.e.
slow path). On the DragonBoard I get:

ISB: 488.1ns
EnIA+ISB (fast path): 493.0ns
EnIA+ISB (slow path): 531.8ns

So the delta between ISB and fast path turns out to be a little bit
less than what I measured before.

The exact changes that I tested are here:
https://github.com/pcc/linux/tree/pac-enabled-keys-bench

> > +1:
> > +alternative_else_nop_endif
> > +#endif
> > +
> >       scs_load tsk, x20
> >       .else
> >       add     x21, sp, #S_FRAME_SIZE
> > @@ -332,6 +344,21 @@ alternative_else_nop_endif
> >       /* No kernel C function calls after this as user keys are set. */
> >       ptrauth_keys_install_user tsk, x0, x1, x2
> >
> > +#ifdef CONFIG_ARM64_PTR_AUTH
> > +alternative_if ARM64_HAS_ADDRESS_AUTH
> > +     /*
> > +      * IA was enabled for in-kernel PAC. Disable it now if needed.
> > +      * All other per-task SCTLR bits were updated on task switch.
> > +      */
> > +     ldr     x0, [tsk, THREAD_SCTLR]
> > +     tbnz    x0, SCTLR_ELx_ENIA_SHIFT, 1f
> > +     mrs     x0, sctlr_el1
> > +     bic     x0, x0, SCTLR_ELx_ENIA
> > +     msr     sctlr_el1, x0
>
> That's correct, no need for context synchronisation here as we are soon
> doing an ERET.

Ack.

> > +1:
> > +alternative_else_nop_endif
> > +#endif
> > +
> >       apply_ssbd 0, x0, x1
> >       .endif
> >
> [...]
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 05a9cdd0b471..7fb28ccdf862 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -552,6 +552,37 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
> >       write_sysreg(val, cntkctl_el1);
> >  }
> >
> > +#if defined(CONFIG_ARM64_PTR_AUTH) || defined(CONFIG_ARM64_MTE)
> > +static void update_sctlr_el1(u64 sctlr)
> > +{
> > +     /*
> > +      * EnIA must not be cleared while in the kernel as this is necessary for
> > +      * in-kernel PAC. It will be cleared on kernel exit if needed.
> > +      */
> > +     sysreg_clear_set(sctlr_el1, SCTLR_TASK_MASK & ~SCTLR_ELx_ENIA, sctlr);
> > +
> > +     /* ISB required for the kernel uaccess routines when setting TCF0. */
> > +     isb();
> > +}
> > +
> > +void set_task_sctlr_el1(u64 sctlr)
> > +{
> > +     /*
> > +      * __switch_to() checks current->thread.sctlr as an
> > +      * optimisation. Disable preemption so that it does not see
> > +      * the variable update before the SCTLR_EL1 one.
> > +      */
> > +     preempt_disable();
> > +     current->thread.sctlr = sctlr;
> > +     update_sctlr_el1(sctlr);
> > +     preempt_enable();
> > +}
> > +#else
> > +static void update_sctlr_el1(u64 sctlr)
> > +{
> > +}
> > +#endif  /* defined(CONFIG_ARM64_PTR_AUTH) || defined(CONFIG_ARM64_MTE) */
> > +
> >  /*
> >   * Thread switching.
> >   */
> > @@ -577,6 +608,10 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
> >        */
> >       dsb(ish);
> >
> > +     /* avoid expensive SCTLR_EL1 accesses if no change */
> > +     if (prev->thread.sctlr != next->thread.sctlr)
> > +             update_sctlr_el1(next->thread.sctlr);
> > +
> >       /*
> >        * MTE thread switching must happen after the DSB above to ensure that
> >        * any asynchronous tag check faults have been logged in the TFSR*_EL1
> > @@ -631,6 +666,8 @@ unsigned long arch_align_stack(unsigned long sp)
> >  void arch_setup_new_exec(void)
> >  {
> >       current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
> > +     if (current->thread.sctlr != init_sctlr)
> > +             set_task_sctlr_el1(init_sctlr);
>
> init_sctlr may not have the full information when initialised in
> setup_arch(). We probably get away with this for the current features
> but it may have unexpected behaviour in the long run.
>
> I think we could start from the existing current->thread.sctlr and just
> set the PAC enable bits via ptrauth_thread_init_user(). Similarly, we
> could call a mte_thread_init_user() (just rename flush_mte_state() and
> move its call place) which sets the current->thread.stclr bits that we
> need.
>
> Since we set the bits explicitly within the SCTLR_TASK_MASK, I don't
> think we need any init_sctlr.

Okay, I've changed the code to work like that and removed init_sctlr in v3.

> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 77c4c9bad1b8..91932215a6dd 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -282,6 +282,8 @@ u64 cpu_logical_map(int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(cpu_logical_map);
> >
> > +u64 init_sctlr;
> > +
> >  void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >  {
> >       init_mm.start_code = (unsigned long) _text;
> > @@ -370,6 +372,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >       init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
> >  #endif
> >
> > +     /*
> > +      * Stash a task's initial SCTLR_EL1 per-task bits, which is the same as
> > +      * the value that it was set to by the early startup code.
> > +      */
> > +     asm("mrs %0, sctlr_el1" : "=r"(init_sctlr));
>
> We have a read_sysreg(sctlr_el1) but I don't think we need it.
>
> > +     init_sctlr &= SCTLR_TASK_MASK;
> > +     init_task.thread.sctlr = init_sctlr;
>
> At this point we have the full SCTLR_EL1. The cpufeature framework may
> turn on additional bits when SMP is fully operational. Also, a user
> thread is not interested in bits that are specific to the kernel only.
>
> As I mentioned above, if we set the bits explicitly when creating a user
> thread, we can just leave init_task.thread.sctlr to 0.
>
> Also, I'd rename thread.sctlr to sctlr_user so that it's clearer that it
> doesn't affect the kernel settings.

Renamed in v3.

Peter
