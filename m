Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213AD3A8CC9
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 01:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOXoO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 15 Jun 2021 19:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhFOXoO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 Jun 2021 19:44:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9BC061574
        for <linux-api@vger.kernel.org>; Tue, 15 Jun 2021 16:42:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t8so280000ybt.10
        for <linux-api@vger.kernel.org>; Tue, 15 Jun 2021 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51SQJUUdrtceWrZfyTDJ3oCUrGR+lEBEx/AFET6iFTo=;
        b=ZZQeA1sWSgHUa9oG9gWyFuz8RsVmGpnM/XHYTH80P/0tqkmSgLmIhwIeTIWOWOxHP1
         LFuti0l+6Y8TKSIqTQklwsnw3FMHlocHWlNUZC4+C4CqfsMaBAFnn7EdKVxRxJyPDuvc
         GdzGTPuWuZMdNMU6wRXCddbutd/1FWfujGOHsZWHSITeTvKghOdU7Do5geIl8S52hnOE
         jUMBC2+Rbm5sNipCWF1mce957QRUTNzyMZGwR1/+W/UxPEz0perbPpQjkmdRsu3eI5GR
         2kK1vfjAvPF2rwxnPGqRTLBrJzU877e30zU/Rq7wnM6TtOklf6gFfli/IvdY1PJcMCjc
         hnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51SQJUUdrtceWrZfyTDJ3oCUrGR+lEBEx/AFET6iFTo=;
        b=GTJ9Xafy/DAJ0kIvNHDDZv6BWyOCTy3dMeQj8IZccyFZsF1ToK6Rqu8rlQsq3+h8+0
         Bv6Lrc3FQ+HGONlFJdl5qnnqe5jqe4RAw9T8dKJzmF3yFFgRZthSI0fm4/rCx6yoNtti
         RIhDTMqk07KtuNC4F6Lzw8KVlbOr8QQhqyRahgPfH6Yc279UQb1+QKZyo6RVljmK1d0k
         D0wktY8xA8Li2AFK2qcETECgZP/YbZTw3J69H9QeJ6rHTQigK14XaIPodsiopEuIktdT
         ki4S7821oS9IDs9bp6T2yZWuBy3W3JrIc3dEn/sQwP4zNHowLGopBiisHYTvYL3ezvns
         lfhA==
X-Gm-Message-State: AOAM533073vIzXyRC0JqDxC+Ze0VP0yVuG5JhJd0uJGqcvpHsw0e1YEJ
        Vc6JUgbPZRU7LXN+61iwsIF5XWMuEaAuBOB3ACOpTg==
X-Google-Smtp-Source: ABdhPJwzohdTnE/Jm1aqL4wVs6Fmovvrsv6Fi788ohPxyAiGM3Xd1uGRqKfMXyz1FLjKq4Vrl3x8TzHPougr3N2Js1Y=
X-Received: by 2002:a25:d441:: with SMTP id m62mr216350ybf.213.1623800527202;
 Tue, 15 Jun 2021 16:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
 <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
 <20201124184742.GC42276@C02TF0J2HF1T.local> <CAMn1gO7G=s7pHFf3jNLj6tZyRuRDvpC2_o=oNWEi4h902hnj6g@mail.gmail.com>
 <20201125143753.GO20578@arm.com>
In-Reply-To: <20201125143753.GO20578@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 15 Jun 2021 16:41:55 -0700
Message-ID: <CAMn1gO7r2EYN0VPxpHJwTV5dVOtbKGhC2GsXHBbNnr4NTvt37Q@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 6:38 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 11/24/2020 11:18, Peter Collingbourne wrote:
> > On Tue, Nov 24, 2020 at 10:47 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Sat, Nov 21, 2020 at 01:59:03AM -0800, Peter Collingbourne wrote:
> > > > Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
> > > > set at boot time.
> > > >
> > > > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > > > the pointer authentication instructions for instruction addresses by 8,
> > > > which improves the security of pointer authentication, but it also has
> > > > the consequence of changing the operation of the branch instructions
> > > > so that they no longer ignore the top byte of the target address but
> > > > instead fault if they are non-zero. Since this is a change to the
> > > > userspace ABI the option defaults to off.
> > > >
> > > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > > Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
> > > > ---
> > > > This is more of an RFC. An open question is how to expose this.
> > > > Having it be a build-time flag is probably the simplest option
> > > > but I guess it could also be a boot flag. Since it involves an
> > > > ABI change we may also want a prctl() so that userspace can
> > > > figure out which mode it is in.
> > > >
> > > > I think we should try to avoid it being a per-task property
> > > > so that we don't need to swap yet another system register on
> > > > task switch.
> > >
> > > Having it changed per task at run-time is problematic as this bit may be
> > > cached in the TLB, so it would require a synchronisation across all CPUs
> > > followed by TLBI. It's not even clear to me from the ARM ARM whether
> > > this bit is tagged by ASID, which, if not, would make a per-process
> > > setting impossible.
> > >
> > > So this leaves us with a cmdline option. If we are confident that no
> > > software makes use of tagged instruction pointers, we could have it
> > > default on.
> >
> > I would be concerned about turning it on by default because tagged
> > instruction pointers may end up being used unintentionally as a result
> > of emergent behavior. For example, when booting Android under FVP with
> > this enabled I discovered that SwiftShader would crash when entering
> > JITed code because the code was being stored at a tagged address
> > (tagged because it had been allocated using Scudo's MTE allocator).
> > Arguably software shouldn't be storing executable code in memory owned
> > by the allocator as this would require changing the permissions of
> > memory that it doesn't own, but from the kernel's perspective it is
> > valid.
>
> it might be still possible to change this abi on linux by
> default, but i don't know what's the right way to manage the
> abi transition. i will have to think about it.
>
> i dont think PROT_MTE|PROT_EXEC is architecturally well
> supported (e.g. to have different colored functions or
> similar, pc relative addressing doesn't work right).
>
> (tbi for instruction pointers is unlikely to be useful, but
> extra 8 bits for pac is useful. i think we should be able to
> move to an abi that is compatible with either setting.)
>
> (i think supporting mmap/munmap/madvise/mprotect on malloced
> memory is problematic in general not just with heap tagging
> so it would be nice to fix whatever jit that marks malloced
> memory as executable.)

Hi Szabolcs,

Did you get a chance to think about this?

I propose that we start with a command line option that defaults to
off. If/when any ABI transition happens we can change the default.

Peter
