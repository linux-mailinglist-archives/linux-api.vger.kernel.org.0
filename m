Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C23AFC83
	for <lists+linux-api@lfdr.de>; Tue, 22 Jun 2021 07:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhFVFPz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Jun 2021 01:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhFVFPy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Jun 2021 01:15:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3289EC061574
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 22:13:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g22so4732242iom.1
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4+FLmgAcVIbYng0Zq//r7lTVpC32qFGml2erBkSda8=;
        b=vHzVXIuTLguZr+QGlDcnXpEr24/OzhMbqZjT8sozpTHkaqatquBCyHIw9dCh2eF937
         ulDn1V7jIxrgwzh1gatmp3MDFLUjTFTvB1qCjb2ryhsxl8T1HNmYzu85awrW7g19sKed
         RZfv7oKFkY6oYH7F3Qf6JvbnvRvmiGRuQwWnrRgAaL7Qe7M0TCkP2o2TVCL6KXuxbUnX
         qkFB34d4dLKq6ToFTYWZB2/F8P48LYONlBrjWft08ghDg+rVU3mLTUSqfJfforMCI1PE
         ZEX/FRYrtLoDT8SG42tNjRM9atDbRtrzxggTq+7t1HbkwrqSb0A90qwELSdpkWgtAmXD
         WViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4+FLmgAcVIbYng0Zq//r7lTVpC32qFGml2erBkSda8=;
        b=lj8SXlLHf+nGOI9ixwdwvk+q20X3p2hyigOhQlRgTY/vJ+uDoLrYFxdWkf8duEPJRn
         u1tm4dRZodm6MsDkYq2s8eVZ4tHY2oJtGwnAAbdQEArLjolsnREJtx0EKy7QiW6XmBn9
         bL2cEZZA+GcFojsXCXcXtSWj1MbTB65uxx+VrD570eJ7DB4u73o7P675WM8GGNA11AYV
         tuVp/H0QqLUDEuiFqKGxC2UdvNSYGl3MSTC7RxPemEFJkOom9EQOkzswmCAdEV2xetmG
         1X1ysgyphHgXiYXeQj11yyfivkckW8ch+KqPz5q+27LuNFD3sbhN4vAq5TJAo5Vjg4FP
         /UBw==
X-Gm-Message-State: AOAM533fk2kXTD+gf2X5aEhflVanD8vs18Ezj6zdNzrPX1mhyYFvTXEC
        OG5TUdv6OIjI4lhtZx9ishSN/eiM9eG6YTuJw6WqVw==
X-Google-Smtp-Source: ABdhPJzna1/UWZ08FDGEpZbmMrxz1cYB33ohJqvHD0YU5uOqjmtbDPz6/UxpQZevD1EI1XlcXeTRUOiDzUb1SjRiMeU=
X-Received: by 2002:a05:6638:140c:: with SMTP id k12mr2155841jad.126.1624338817339;
 Mon, 21 Jun 2021 22:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
 <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
 <20201124184742.GC42276@C02TF0J2HF1T.local> <CAMn1gO7G=s7pHFf3jNLj6tZyRuRDvpC2_o=oNWEi4h902hnj6g@mail.gmail.com>
 <20201125143753.GO20578@arm.com> <CAMn1gO7r2EYN0VPxpHJwTV5dVOtbKGhC2GsXHBbNnr4NTvt37Q@mail.gmail.com>
 <20210616125543.GE12580@arm.com>
In-Reply-To: <20210616125543.GE12580@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 21 Jun 2021 22:13:25 -0700
Message-ID: <CAMn1gO7+_JhTUw2gS6jnyRV+TCqprmpuCAfee3RCAhNjoVyy9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allow TCR_EL1.TBID0 to be configured
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>, nd@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 16, 2021 at 5:56 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 06/15/2021 16:41, Peter Collingbourne wrote:
> > On Wed, Nov 25, 2020 at 6:38 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> > >
> > > The 11/24/2020 11:18, Peter Collingbourne wrote:
> > > > On Tue, Nov 24, 2020 at 10:47 AM Catalin Marinas
> > > > <catalin.marinas@arm.com> wrote:
> > > > > On Sat, Nov 21, 2020 at 01:59:03AM -0800, Peter Collingbourne wrote:
> > > > > > Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
> > > > > > set at boot time.
> > > > > >
> > > > > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > > > > the pointer authentication instructions for instruction addresses by 8,
> > > > > > which improves the security of pointer authentication, but it also has
> > > > > > the consequence of changing the operation of the branch instructions
> > > > > > so that they no longer ignore the top byte of the target address but
> > > > > > instead fault if they are non-zero. Since this is a change to the
> > > > > > userspace ABI the option defaults to off.
> > > > > >
> > > > > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > > > > Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
> > > > > > ---
> > > > > > This is more of an RFC. An open question is how to expose this.
> > > > > > Having it be a build-time flag is probably the simplest option
> > > > > > but I guess it could also be a boot flag. Since it involves an
> > > > > > ABI change we may also want a prctl() so that userspace can
> > > > > > figure out which mode it is in.
> > > > > >
> > > > > > I think we should try to avoid it being a per-task property
> > > > > > so that we don't need to swap yet another system register on
> > > > > > task switch.
> > > > >
> > > > > Having it changed per task at run-time is problematic as this bit may be
> > > > > cached in the TLB, so it would require a synchronisation across all CPUs
> > > > > followed by TLBI. It's not even clear to me from the ARM ARM whether
> > > > > this bit is tagged by ASID, which, if not, would make a per-process
> > > > > setting impossible.
> > > > >
> > > > > So this leaves us with a cmdline option. If we are confident that no
> > > > > software makes use of tagged instruction pointers, we could have it
> > > > > default on.
> > > >
> > > > I would be concerned about turning it on by default because tagged
> > > > instruction pointers may end up being used unintentionally as a result
> > > > of emergent behavior. For example, when booting Android under FVP with
> > > > this enabled I discovered that SwiftShader would crash when entering
> > > > JITed code because the code was being stored at a tagged address
> > > > (tagged because it had been allocated using Scudo's MTE allocator).
> > > > Arguably software shouldn't be storing executable code in memory owned
> > > > by the allocator as this would require changing the permissions of
> > > > memory that it doesn't own, but from the kernel's perspective it is
> > > > valid.
> > >
> > > it might be still possible to change this abi on linux by
> > > default, but i don't know what's the right way to manage the
> > > abi transition. i will have to think about it.
> > >
> > > i dont think PROT_MTE|PROT_EXEC is architecturally well
> > > supported (e.g. to have different colored functions or
> > > similar, pc relative addressing doesn't work right).
> > >
> > > (tbi for instruction pointers is unlikely to be useful, but
> > > extra 8 bits for pac is useful. i think we should be able to
> > > move to an abi that is compatible with either setting.)
> > >
> > > (i think supporting mmap/munmap/madvise/mprotect on malloced
> > > memory is problematic in general not just with heap tagging
> > > so it would be nice to fix whatever jit that marks malloced
> > > memory as executable.)
> >
> > Hi Szabolcs,
> >
> > Did you get a chance to think about this?
> >
> > I propose that we start with a command line option that defaults to
> > off. If/when any ABI transition happens we can change the default.
>
> a default off per boot option sounds safe even if
> there are some incompatible binaries.

Okay, let's start with that then, although I'm about 75% sure we
should be able to change the default if we push for it. I've sent a v2
with that implemented.

> (i assume virtualization works: host and guest can
> have different settings, so users can always run
> old systems in kvm.)
>
> however it would be nice to make this part of the
> linux platform abi and avoid fragmentation.
> the difficult bits are
>
> - unclear trade-off: does the abi change have
>   adverse effect on potential tbi/mte/.. use?
>   or even existing usage? (data only tbi is a
>   more complicated concept than plain tbi)

I think it's unlikely that there will be such an effect, at least for
existing usage. Note that Apple has been shipping kernels that enable
TBID0 for several years now and I'm not aware of any consequent
breakage as a result (and as far as I know Apple is a more heavy user
of TBI than anything in the Linux world, sanitizers excepted, given
that e.g. the Swift implementation relies on it).

> - incompatibility cannot be statically detected.
>   (toolchain cannot diagnose or enforce it,
>   it is only detectable at runtime, on a system
>   with the changed setting.)

That is unfortunate, although it later occurred to me that in most
cases the incompatibility should manifest in a particular form, where
the program sets a tagged PC and we enter an instruction abort. This
puts us in the kernel, which may choose to handle the abort by
clearing the tag and resuming the program. At that point, the TBID
feature is basically unobservable for programs that do not use PAC
instructions.

This would of course slow down programs that rely on tagged
instruction pointers, and basically destroys the security of PAC for
instruction pointers by making the hardware error code ineffective (at
least on machines that do not implement enhanced PAC2), so I would
view this as purely an opt-in compatibility scheme to keep old
programs (which by virtue of being old wouldn't be using PAC
instructions) working (albeit more slowly and less securely) rather
than something that new programs should use.

I'm not sure if we should implement this scheme straight away. But I
think the more important thing is that it can be done, which means
that I think it should be relatively safe to turn on the ABI
system-wide and rely on such a scheme to keep old programs working (if
any).

> i think in c the usability of tbi is very limited
> now. the libc and compiler needs a tbi abi for it
> to work (e.g. different tags on pointers to the
> same object break pointer comparision). if tagged
> pointers are not dereferenced and don't escape
> then tbi is not needed. so only custom runtimes
> and implementation internal tooling like hwasan
> or heap tagging can use it. arbitrary user tagged
> pointer is not supported in libc now.

Yes, I think that's a good reason why this is unlikely to break anything.

Peter
