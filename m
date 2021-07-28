Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC923D99C1
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhG1XuY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG1XuW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 19:50:22 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85EC061757
        for <linux-api@vger.kernel.org>; Wed, 28 Jul 2021 16:50:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s48so6893279ybi.7
        for <linux-api@vger.kernel.org>; Wed, 28 Jul 2021 16:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ri7dkKO6h5RV/Ibe3NWL4402v4LTTBbbSPPGdrr9EWA=;
        b=JXqLLLKQ9B7Aib4nfyynUM9ac2AoEGdFAEcPjQMIKwvDcgOLzVYdf+qjF7FgO+/h9h
         +zYlReGNpSP0ophDpBZ0yGZPPsp7BeFOnQ+/m6ObpExwEA8SmdbkK2wSAwcwEXbWlKjt
         tboOqc29hiWTaGpc15cex24JduRM19DLsxcMfxQTIpOrecAVRnnQmAQdG/aaADAIEPlC
         gUq1eRL+K13UJtoBot6QOz5oMrq46S6mGevRYdYsmGjFBUVn4nYbRIS3PnKLfXF5ELn2
         IYVOUBqdv8EFBIq//hQWUCvaO0EMzjoLycStVNkm5wPV50xaycsHzEoWo3YytDAgJKqf
         6D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ri7dkKO6h5RV/Ibe3NWL4402v4LTTBbbSPPGdrr9EWA=;
        b=egqk4We30sBQ4h7GtHv8oa4p7u7dWPgs02OVcxadgbINm5s2jAiW8BVgXP+XDiuH6T
         mR279F9bxKRLyu2Xnpov/LwZJSsYvvPAkHLcvK3DryyNLrcCChHyGoJs/OttyWevjvrt
         U1yTIGsmoxvs6P2mMqZY6EmblTsR8vP3d/3VtwIDPnCA99dM/GPVy16mOTdTtYWahmF/
         f55+qtnmXSQeRcP1DodTSeyFSYzSGqaxQBq/Rw+GX3UBbnGly/CZcGz1V+ODcRTTPZys
         LEXMQw3n5HK9j8TcBSibO8UXYIi4x+WgTlTQv/FCjpwzFjcSgxUZGzgfxKk6Ub3Wlix4
         Zj0A==
X-Gm-Message-State: AOAM532jXN4YhPcIQoYQgE6UZTZIAEtU3Bf6MdtpIUbg4yGNlXY3MeUw
        8E0E10F/90VWqjAjhnA5+VyyA1RZnhiI6lp8ro2g2g==
X-Google-Smtp-Source: ABdhPJwaWRA1sv94hlkOc3Y+gpCGthbwr9k9FCG8Qb/Bs8BGo0KCxMQgxJPIc5XqICNw82VbJOR+Ix3caEe0YlKrUfM=
X-Received: by 2002:a5b:648:: with SMTP id o8mr3120806ybq.260.1627516218334;
 Wed, 28 Jul 2021 16:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210622051204.3682580-1-pcc@google.com> <20210727165109.GB13920@arm.com>
 <CAMn1gO7DcY4tWu0Q7XsZAt-pEmD-4S64sMzu_gARH7Pvc8sP8g@mail.gmail.com> <20210728164219.GC7408@arm.com>
In-Reply-To: <20210728164219.GC7408@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 28 Jul 2021 16:50:07 -0700
Message-ID: <CAMn1gO4zkXBdW-qzY+15Q=Pk7E-x3vR-PXmKRakyE4Wr87Xhdg@mail.gmail.com>
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

On Wed, Jul 28, 2021 at 9:42 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Jul 27, 2021 at 03:00:10PM -0700, Peter Collingbourne wrote:
> > On Tue, Jul 27, 2021 at 9:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, Jun 21, 2021 at 10:12:04PM -0700, Peter Collingbourne wrote:
> > > > Introduce a command line flag that controls whether TCR_EL1.TBID0
> > > > is set at boot time. Since this is a change to the userspace ABI the
> > > > option defaults to off for now, although it seems likely that we'll
> > > > be able to change the default at some future point.
> > > >
> > > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > > the pointer authentication instructions for instruction addresses by 8,
> > > > which improves the security of pointer authentication, but it also has
> > > > the consequence of changing the operation of the branch instructions
> > > > so that they no longer ignore the top byte of the target address but
> > > > instead fault if they are non-zero.
> > >
> > > I'm a bit uneasy about the ABI change and not so keen on constraining
> > > the ABI through the kernel command line. Ideally we should make this an
> > > opt-in per application (prctl()) but that has some aspects to address
> >
> > This doesn't necessarily need to be the end state, we can enhance this
> > based on need. For example, we could choose to take this patch now and
> > later implement the per-process opt-in where the default is controlled
> > by the command line.
>
> What's the risk of an application becoming reliant on the new mode
> (TBID0) and breaking with the old one? Probably very small but I haven't
> figured out if it's zero. Depending on whether we have PAC or PAC2 (the
> latter came with 8.6 but optional in 8.3) with TBID0, there are some
> differences on how the PAC/AUT instructions work and the code generated
> (XOR with the top bits).

I think it would be quite small. On Android, at least to begin with
there would be a mixture of devices with different TBID0 settings
(devices without PAC support and devices with older kernels would all
have this disabled), so I think it would be difficult for an
application to depend on it being enabled.

> > Or just implement the software-only per-process
> > TBID0 almost-disablement which would be much simpler than doing it in
> > hardware, if that is enough to satisfy future needs.
>
> I don't entirely follow this.

Sorry, I was referring to my earlier proposal for recovering from
tagged PC in the kernel by clearing the tag bits:
https://lore.kernel.org/linux-arm-kernel/CAMn1gO7+_JhTUw2gS6jnyRV+TCqprmpuCAfee3RCAhNjoVyy9w@mail.gmail.com/

> > Otherwise we risk adding "unused" complexity to the kernel that we can
> > never remove due to API stability guarantees.
>
> We've had other debates over the years and, in general, if a kernel
> change causes apps to break, we'd have to keep the original behaviour.
> Are there any plans to fix the JITs tools you discovered?

Yes, we would definitely want to fix the JIT issue in the Android
platform before rolling out a forward PAC ABI. This would be separate
from fixing apps, which would need to opt into MTE (or address tagging
via the target API level) anyway. But if it turns out that there are
too many apps with these JITs that use MTE or address tagging, I think
we would need to come back to the kernel to figure out some way to let
these programs run.

> Talking to Will about this he was wondering whether we could make TBID0
> on by default and clear the tag in PC if we take a fault (on tagged PC),
> restarting the context. PAC shouldn't be affected since we would only
> branch to an authenticated (PAC code removed) pointer. If this works,
> we'd only affect performance slightly on such apps but don't completely
> break them.

Right, this sounds exactly like my earlier proposal.

> > > first: (a) this bit is permitted to be cached in the TLB so we'd need
> > > some TLBI when setting it (and a clarification in the specs that it is
> > > tagged by ASID/VMID, probably fine) and (b) we'd need to context-switch
> > > TCR_EL1, with a small performance penalty (I don't think it's
> > > significant but worth testing).
> >
> > So TLBI all of the CPUs on prctl() and context-switch TCR_EL1? I
> > thought there would be DOS concerns with the first part of that?
>
> The DoS problem appears if we need to issue an IPI to all CPUs (like
> stop_machine). The TLBI with broadcast handled in hardware should be OK
> as it's targeted to a specific ASID. But this would have to be issued

I see -- I hadn't realised that this instruction is implemented as a
broadcast. So we would just need to issue the instruction from any CPU
and we should be good.

> before any app threads are started, otherwise we'd need to synchronise
> TCR_EL1. Given that TBID0 toggling affects PAC, this can only be done

Right, so this would be different from everything currently in
tagged_addr_ctrl because it would be per-process rather than
per-thread. So if this were a true TBID0 control we may even want it
as a separate prctl() since there are certainly use cases for changing
the other bits of tagged_addr_ctrl while the other threads are
running.

> safely very early in the application before return addresses get a PAC
> code.

Right, so maybe the "almost-disablement" would work better since all
of the signatures would then still be valid, and you could even have
different settings for different threads if you wanted to (e.g. if you
arranged to run legacy code only on a specific thread).

Peter
