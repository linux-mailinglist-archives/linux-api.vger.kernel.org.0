Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBB3E212C
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbhHFBso (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhHFBso (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 21:48:44 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE0FC061798
        for <linux-api@vger.kernel.org>; Thu,  5 Aug 2021 18:48:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m13so9254585iol.7
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJBur7NC033qbyjuThVrinxWhK/c5J8DRHReEwHjMwY=;
        b=emd+WLpxelM6aCNy5oifj93guso46pp7L9Es3HBjISXjyL1yqLQWY4BQCj5wxm9750
         tJcp6hWsMPjf/SzwAhXz8bmkhPqBWWjgB4pxaji45FHBGhnAQGSYscNE4ktJYDehXF6i
         vPufdOjdaOFEYa+5uVewCoEhOcTWYPBYZFTFBoxowMygQ/zKJWWaE3nJ7ZolA//zXIy1
         y3ewVTIzkxq/c4Qhz9k8yA42nzQfIvF15BJsQICom2bIfXxTfgY/dOSADR0mgngRQu9V
         nF83WYagvjfAjpPff/HM8XN+xjGupi2TQrUJqmoMkxdVli2OcSG9zzM9afrKPCblH4Fw
         rSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJBur7NC033qbyjuThVrinxWhK/c5J8DRHReEwHjMwY=;
        b=Ut/yDW5bve4RTEzO2Uyklm7ABWgcu4g2UROFBWZhBjtRfNwYYR+xymhYvfJEWLWcLc
         OgnDRCJZkGSX/OvV5twux8+qs5BKhY2kIdafkDRCjAS4d30owSJCKzKNBJhEeivVzN42
         bLzo6rTEzFAo3sDsoKPs2JapmagaKa3w9Euevm4T5A9V+LoksxKVZSA1JuFs6mz18DPF
         Oizh2EInZvNkylmnZEs9M2TwQMedP/xPowQ0FrZ+/Sq9pxpkcmFYysrcG522R5tBiz4p
         shAupBcs0zWVCb4F97L0R9LAwoiba7WwRdBvYl5T8Kdvi88u9MbJNJ8iG1WfeJhlAkr3
         JEUA==
X-Gm-Message-State: AOAM533v127b3qPIPZKh/R11oeSlu6tmPKq4mcPuX2PIpvpVUhoCJu3l
        CT0OlxXFLOT8a9AYCdfeu9tELPBHWIiGAGL4Ytu9SttwAU7LfIY/
X-Google-Smtp-Source: ABdhPJxe8hobSEkS8JWK81RU0+XSH86Vtu6W/Oc5LC6int2fubrHKcNId58htaPOOHaa84vbn1YZ3axUw3VjxTtIlNU=
X-Received: by 2002:a05:6638:606:: with SMTP id g6mr6932421jar.126.1628214507646;
 Thu, 05 Aug 2021 18:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210622051204.3682580-1-pcc@google.com> <20210727165109.GB13920@arm.com>
 <CAMn1gO7DcY4tWu0Q7XsZAt-pEmD-4S64sMzu_gARH7Pvc8sP8g@mail.gmail.com>
 <20210728164219.GC7408@arm.com> <CAMn1gO4zkXBdW-qzY+15Q=Pk7E-x3vR-PXmKRakyE4Wr87Xhdg@mail.gmail.com>
 <20210729174409.GC31848@arm.com>
In-Reply-To: <20210729174409.GC31848@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 5 Aug 2021 18:48:16 -0700
Message-ID: <CAMn1gO52j=m=vxdh2GFLH57pcPmqoorXQsT9YM7jWNGFL4wr9Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: allow TCR_EL1.TBID0 to be configured
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 29, 2021 at 10:44 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Wed, Jul 28, 2021 at 04:50:07PM -0700, Peter Collingbourne wrote:
> > On Wed, Jul 28, 2021 at 9:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Tue, Jul 27, 2021 at 03:00:10PM -0700, Peter Collingbourne wrote:
> > > > On Tue, Jul 27, 2021 at 9:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > On Mon, Jun 21, 2021 at 10:12:04PM -0700, Peter Collingbourne wrote:
> > > > > > Introduce a command line flag that controls whether TCR_EL1.TBID0
> > > > > > is set at boot time. Since this is a change to the userspace ABI the
> > > > > > option defaults to off for now, although it seems likely that we'll
> > > > > > be able to change the default at some future point.
> > > > > >
> > > > > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > > > > the pointer authentication instructions for instruction addresses by 8,
> > > > > > which improves the security of pointer authentication, but it also has
> > > > > > the consequence of changing the operation of the branch instructions
> > > > > > so that they no longer ignore the top byte of the target address but
> > > > > > instead fault if they are non-zero.
> > > > >
> > > > > I'm a bit uneasy about the ABI change and not so keen on constraining
> > > > > the ABI through the kernel command line. Ideally we should make this an
> > > > > opt-in per application (prctl()) but that has some aspects to address
> > > >
> > > > This doesn't necessarily need to be the end state, we can enhance this
> > > > based on need. For example, we could choose to take this patch now and
> > > > later implement the per-process opt-in where the default is controlled
> > > > by the command line.
> > >
> > > What's the risk of an application becoming reliant on the new mode
> > > (TBID0) and breaking with the old one? Probably very small but I haven't
> > > figured out if it's zero. Depending on whether we have PAC or PAC2 (the
> > > latter came with 8.6 but optional in 8.3) with TBID0, there are some
> > > differences on how the PAC/AUT instructions work and the code generated
> > > (XOR with the top bits).
> >
> > I think it would be quite small. On Android, at least to begin with
> > there would be a mixture of devices with different TBID0 settings
> > (devices without PAC support and devices with older kernels would all
> > have this disabled), so I think it would be difficult for an
> > application to depend on it being enabled.
> >
> > > > Or just implement the software-only per-process
> > > > TBID0 almost-disablement which would be much simpler than doing it in
> > > > hardware, if that is enough to satisfy future needs.
> > >
> > > I don't entirely follow this.
> >
> > Sorry, I was referring to my earlier proposal for recovering from
> > tagged PC in the kernel by clearing the tag bits:
> > https://lore.kernel.org/linux-arm-kernel/CAMn1gO7+_JhTUw2gS6jnyRV+TCqprmpuCAfee3RCAhNjoVyy9w@mail.gmail.com/
>
> Ah, sorry, I missed this one (or just paged it out entirely over the
> holiday).
>
> > > > Otherwise we risk adding "unused" complexity to the kernel that we can
> > > > never remove due to API stability guarantees.
> > >
> > > We've had other debates over the years and, in general, if a kernel
> > > change causes apps to break, we'd have to keep the original behaviour.
> > > Are there any plans to fix the JITs tools you discovered?
> >
> > Yes, we would definitely want to fix the JIT issue in the Android
> > platform before rolling out a forward PAC ABI. This would be separate
> > from fixing apps, which would need to opt into MTE (or address tagging
> > via the target API level) anyway. But if it turns out that there are
> > too many apps with these JITs that use MTE or address tagging, I think
> > we would need to come back to the kernel to figure out some way to let
> > these programs run.
>
> OK, I guess we don't yet have a clear view on how many such apps are
> affected.
>
> > > Talking to Will about this he was wondering whether we could make TBID0
> > > on by default and clear the tag in PC if we take a fault (on tagged PC),
> > > restarting the context. PAC shouldn't be affected since we would only
> > > branch to an authenticated (PAC code removed) pointer. If this works,
> > > we'd only affect performance slightly on such apps but don't completely
> > > break them.
> >
> > Right, this sounds exactly like my earlier proposal.
>
> Indeed. Something I haven't figured out yet is whether such handling in
> the kernel would weaken PAC. For example, following a failed AUT (the
> old style which does not trap), the resulting address would cause a
> translation fault. Would the kernel clearing the top byte result in a
> potentially valid address?

Yes, as I mentioned in my earlier message, without enhanced PAC2 the
error code will go to bit 61 or 62, and those would be cleared by the
kernel in the almost-disablement mode. So instruction PAC would be
ineffective on CPUs without that feature.

With enhanced PAC2 and without FPAC the computed PAC will be XORed
with the pointer, so you still have a chance of faulting on a
corrupted pointer (if the PAC bits below 55 do not match) -- basically
the same chance as if TBID0 were disabled.

> > > > > first: (a) this bit is permitted to be cached in the TLB so we'd need
> > > > > some TLBI when setting it (and a clarification in the specs that it is
> > > > > tagged by ASID/VMID, probably fine) and (b) we'd need to context-switch
> > > > > TCR_EL1, with a small performance penalty (I don't think it's
> > > > > significant but worth testing).
> > > >
> > > > So TLBI all of the CPUs on prctl() and context-switch TCR_EL1? I
> > > > thought there would be DOS concerns with the first part of that?
> > >
> > > The DoS problem appears if we need to issue an IPI to all CPUs (like
> > > stop_machine). The TLBI with broadcast handled in hardware should be OK
> > > as it's targeted to a specific ASID. But this would have to be issued
> >
> > I see -- I hadn't realised that this instruction is implemented as a
> > broadcast. So we would just need to issue the instruction from any CPU
> > and we should be good.
>
> Well, as long as it's single-threaded when the prctl() is issued. If
> there are multiple threads, we'd have to synchronise all the CPUs. Such
> requirement is probably not a big deal anyway as it affects the return
> addresses, so it would have to be done early.
>
> > > before any app threads are started, otherwise we'd need to synchronise
> > > TCR_EL1. Given that TBID0 toggling affects PAC, this can only be done
> >
> > Right, so this would be different from everything currently in
> > tagged_addr_ctrl because it would be per-process rather than
> > per-thread. So if this were a true TBID0 control we may even want it
> > as a separate prctl() since there are certainly use cases for changing
> > the other bits of tagged_addr_ctrl while the other threads are
> > running.
>
> Since it's permitted to be cached in the TLB, switching it between
> threads would require TLBI on each switch, so not feasible.
>
> How early is the prctl(PR_TAGGED_ADDR_ENABLE) called? Anyway, it
> probably makes more sense to have a separate control since TBID0 is not
> necessarily linked to hwasan or MTE. We'd want more PAC bits even if
> hwasan or MTE are not deployed.

The prctl is called before any threads are created, so it would be
feasible to turn on TBID0 there as well. Agreed about the separate
control.

> > > safely very early in the application before return addresses get a PAC
> > > code.
> >
> > Right, so maybe the "almost-disablement" would work better since all
> > of the signatures would then still be valid, and you could even have
> > different settings for different threads if you wanted to (e.g. if you
> > arranged to run legacy code only on a specific thread).
>
> Yes, if (a) it doesn't weaken PAC and (b) there are no future plans to
> use code TBI as trapping would make it slower.

As mentioned above it does weaken it, but only on certain CPUs.
According to their technical reference manuals, Cortex-A78C implements
enhanced PAC2, and Cortex-A710 implements both that and FPAC. So the
only publicly known CPU where the almost-disablement would also weaken
PAC is the Apple M1, which doesn't implement FPAC or enhanced PAC2.

I wouldn't put much weight on the fact that PAC is weakened though
anyway -- this mode would just be a way to get legacy applications
running even if slower/less secure.

> I think we need to decide whether full TBI would be any useful going
> forward. One comment from Szabolcs on the previous version was that
> "data only tbi is a more complicated concept than plain tbi". Are there
> any tooling plans to benefit from code TBI? Or any use-cases that would
> be affected? For example, if we decide mmap() to return tagged pointers
> (with a new flag), would JITs want to benefit?

At least on the Android side we have no plans to use those bits, not
even for debugging tools like HWASan. Indeed we would much rather put
those bits to use for PAC. I suppose that it's possible that JITs may
want to use them, but that's not something that we would want to
support on Android. And if such a JIT is portable to Apple platforms
it would need an alternative code path to avoid using the bits anyway
due to TBID0 being enabled on those platforms.

> If we need both data and code TBI to coexist, we should look into a
> per-process control.

It doesn't seem necessary at this point IMHO.

So can we start with the patch that makes this a boot-time control for now?

Peter
