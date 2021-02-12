Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF6319959
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 05:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBLExe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Feb 2021 23:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhBLExd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Feb 2021 23:53:33 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35660C061574
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 20:52:53 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u8so8059021ior.13
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 20:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Hmdx3DzTf15y6aRrp12SgSO6/3WpbjIoxuZSXcMidE=;
        b=fEE1UX30WhpGPW3qjDkzNl9PhFqkWlZl5LxGY58o2Njy73N2q5dPO0IdKbE+ufjiyt
         462EeG8h0oPCUrE9yd7g5kyxUL1grx3eQiUS2a4vL4covEG+BAsy+gMU9oA7clFQWD5l
         XyxUMtwQyem7YhxUP0lsaw8dlFtzJFTMAevA+F/FuOsYKk+dPJ0ApYqjeVvYuWDNHV5H
         3gJ8/eVl93CRTDRYaKNPdP6+Ef75BmeWHKkqOQVW8Sgz0DVy6zLYg64DNyuwnv/5lU4F
         kPShASBDIhQP10yiLPACRtOZh2ZTUPiJjDiShZBqEt7d/L+B10Fz6pxfpcD+5zpuXof6
         rcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Hmdx3DzTf15y6aRrp12SgSO6/3WpbjIoxuZSXcMidE=;
        b=lQevzZnnxXDxuTKld2O0Oh87XpfeihraZjbxvKQ5Mqvb09etrHmxqlgJTMbhj+3xMA
         Q0DZIFPl+KWXDzuXJxJBYMBCapgPYsymoM891vQ6sHoKC/iYzJz5jd1g1S3NCHa+VG+D
         G2lEeJZZaAUcGm2/2/Pd/WwxtNlQ4Fx0DURH4sHnUIJq/17E+fwyTlqeQV0TfLCZv1Cc
         5cV1opVS6QzxjEHFRn4BE8gkBGS/tnPq2OCEjnpQ33KxXcRlE2maTFnb/qbSaNTsz7at
         3nFpUMZEfYHKvcOaWIn0nEDTnblsBzrBT58QHc7BVM/7fZNKgXGcrCxmv8qfHLt3+l7/
         4wXw==
X-Gm-Message-State: AOAM5305ilFN81mDSGlaeknLiMZah0sYfQdy3+llW5PpN3ElQ1bHo+Ai
        cPTGWvMjAaEEgX0WyV7bPmA4L8ZbJac4U6tM4ZH36g==
X-Google-Smtp-Source: ABdhPJymbk4/TALO5dMw+WB3Tj5MtdJkmxBdzmTe0nPdI45j3UdD1t2O0XEPwauyM+uhJwhRUCzFKp7LakfbmDVqS48=
X-Received: by 2002:a6b:5110:: with SMTP id f16mr860189iob.89.1613105572478;
 Thu, 11 Feb 2021 20:52:52 -0800 (PST)
MIME-Version: 1.0
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <295aec08a383cb9cb4a6062cf2ab21b4f59082b9.1609311499.git.pcc@google.com> <20210126124945.GB29702@willie-the-truck>
In-Reply-To: <20210126124945.GB29702@willie-the-truck>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 11 Feb 2021 20:52:41 -0800
Message-ID: <CAMn1gO7exUSRm7E42bmA+ZtnyOHzLHR5sNebL42gyBPCtzygYw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 26, 2021 at 4:49 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Dec 29, 2020 at 10:59:14PM -0800, Peter Collingbourne wrote:
> > This change introduces a prctl that allows the user program to control
> > which PAC keys are enabled in a particular task. The main reason
> > why this is useful is to enable a userspace ABI that uses PAC to
> > sign and authenticate function pointers and other pointers exposed
> > outside of the function, while still allowing binaries conforming
> > to the ABI to interoperate with legacy binaries that do not sign or
> > authenticate pointers.
> >
> > The idea is that a dynamic loader or early startup code would issue
> > this prctl very early after establishing that a process may load legacy
> > binaries, but before executing any PAC instructions.
> >
> > This change adds a small amount of overhead to kernel entry and exit
> > due to additional required instruction sequences.
> >
> > On a DragonBoard 845c (Cortex-A75) with the powersave governor, the
> > overhead of similar instruction sequences was measured as 4.9ns when
> > simulating the common case where IA is left enabled, or 43.7ns when
> > simulating the uncommon case where IA is disabled. These numbers can
> > be seen as the worst case scenario, since in more realistic scenarios
> > a better performing governor would be used and a newer chip would be
> > used that would support PAC unlike Cortex-A75 and would be expected
> > to be faster than Cortex-A75.
> >
> > On an Apple M1 under a hypervisor, the overhead of the entry/exit
> > instruction sequences introduced by this patch was measured as 0.3ns
> > in the case where IA is left enabled, and 33.0ns in the case where
> > IA is disabled.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> > Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
>
> [...]
>
> > diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> > index adb955fd9bdd..f03e5bfe4490 100644
> > --- a/arch/arm64/kernel/pointer_auth.c
> > +++ b/arch/arm64/kernel/pointer_auth.c
> > @@ -46,3 +46,65 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
> >
> >       return 0;
> >  }
> > +
> > +static u64 arg_to_enxx_mask(unsigned long arg)
> > +{
> > +     u64 sctlr_enxx_mask = 0;
> > +
> > +     WARN_ON(arg & ~PR_PAC_ENABLED_KEYS_MASK);
> > +     if (arg & PR_PAC_APIAKEY)
> > +             sctlr_enxx_mask |= SCTLR_ELx_ENIA;
> > +     if (arg & PR_PAC_APIBKEY)
> > +             sctlr_enxx_mask |= SCTLR_ELx_ENIB;
> > +     if (arg & PR_PAC_APDAKEY)
> > +             sctlr_enxx_mask |= SCTLR_ELx_ENDA;
> > +     if (arg & PR_PAC_APDBKEY)
> > +             sctlr_enxx_mask |= SCTLR_ELx_ENDB;
> > +     return sctlr_enxx_mask;
> > +}
> > +
> > +int ptrauth_set_enabled_keys(struct task_struct *tsk, unsigned long keys,
> > +                          unsigned long enabled)
> > +{
> > +     u64 sctlr = tsk->thread.sctlr_user;
> > +
> > +     if (!system_supports_address_auth())
> > +             return -EINVAL;
> > +
> > +     if (is_compat_thread(task_thread_info(tsk)))
> > +             return -EINVAL;
> > +
> > +     if ((keys & ~PR_PAC_ENABLED_KEYS_MASK) || (enabled & ~keys))
> > +             return -EINVAL;
> > +
> > +     sctlr &= ~arg_to_enxx_mask(keys);
> > +     sctlr |= arg_to_enxx_mask(enabled);
> > +     if (tsk == current)
> > +             set_task_sctlr_el1(sctlr);
> > +     else
> > +             tsk->thread.sctlr_user = sctlr;
>
> Who synchronizes all these modifications to 'sctlr_user'? Seems like it gets
> hit by two independent prctl()s as well as ptrace.

The prctls can only affect the current task, so I believe that they
are naturally synchronized (since a task cannot run on multiple CPUs
at once as far as I'm aware). As for ptrace, I believe the tracee must
be stopped in order for the tracer to issue PTRACE_SETREGS (so it
wouldn't be able to issue prctls of its own) and a process can only
have one tracer at a time, so there is again natural synchronization.

Peter
