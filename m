Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847EB2BB732
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 21:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbgKTUfq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 15:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbgKTUfp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 15:35:45 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD3C0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 12:35:45 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id g15so9740857ybq.6
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 12:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcPNSSzyjTcRWDntyOFLj6zm15LYtZG/U41vunYqYi4=;
        b=AMlAp7NyJu/clw8KZlatjQeFUswrYW0WeQbq3Ja1esjpk2uVxDQ7S6tKpt0tw1VCmF
         Uc0qqB1roz0qLgySiP8EcvxFEAF/fNhQtkqUrLUgi4Z6Wao8o1fM4hGdbmLWEjhqPwiZ
         oC5YPRjfT2BYZrMN9bg8LQ+Hz32dZqaU9/ww8cZxVmTYjqpIARlPCL8mcxDeixHunZmB
         WUtHadN+mzTtp5a54nPO0SH5r+mmyn+N8hFY2Z1WZSU5FWWIni3gYd9+ylfZzyvL6/mv
         y7nl1UWfguExkzGTSc+jV9keHVVIq6I1Z9z8LvHAHHJWXIl3XmPDPKulw1w//g0yeDvl
         QD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcPNSSzyjTcRWDntyOFLj6zm15LYtZG/U41vunYqYi4=;
        b=apAIl/Mu/5pwb0BgAG2W5dJEsdtGU9DOuWovGQTbNcjgzhx+2ekpbRamwDGXlVbfwg
         JQ/ZWdnqywsmqqg6HiRq3xIenW9pAOX2cjQBwu/GMLEZWVgpDtqjsYNtNW5FCBGiPX7i
         QcYfFqEXsLLL79T21cglicoV5lREnFBlo+VPTtBJF7MuLYSSYyZk+T4GwLmcFMjUGJon
         OBDLpaHBbiDT4Tyw7Hg/2qznl47xKwaKFD+VnEh1sxYTBlyeGZkgb0G1FdDUgQqJ8qcJ
         0BknQR2yWoIMlhLPq/Vdlx1hDijqaK8/yvpX+nafEkCsKCPkd/kDfs7Gl4A2qhVMkoUK
         H5aA==
X-Gm-Message-State: AOAM531SL0mXNdFob6qvCwjJeAFZYEE4ESeNEWSs5pDEDPUn7ysFSyMC
        gPE7qKGHYcvg7N5qfD+ebAuA9g/s7+RxUzsncxGkTg==
X-Google-Smtp-Source: ABdhPJyF/k2oZ8ksH74iVV64qUWqGsyzyt15TDX5Q6gGNlV6ST6YumivJCHhDOsDcrIx3d3qmNksCqW3qzcnRRGNvN4=
X-Received: by 2002:a25:61c9:: with SMTP id v192mr28075612ybb.354.1605904544664;
 Fri, 20 Nov 2020 12:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20201119190921.3589081-1-pcc@google.com> <87wnyf3ovs.fsf@x220.int.ebiederm.org>
 <CAMn1gO6mzzpnYbKfn3gXAwX2tejD-g+2S_ShkyWVCLskFWSqvg@mail.gmail.com> <878sav3k88.fsf@x220.int.ebiederm.org>
In-Reply-To: <878sav3k88.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 20 Nov 2020 12:35:32 -0800
Message-ID: <CAMn1gO7A3tVU2epT7A0AADgJ4nZ6LL5jdp0c=_7wTjMCPimpUQ@mail.gmail.com>
Subject: Re: [PATCH v20] arm64: expose FAR_EL1 tag bits in siginfo
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 20, 2020 at 11:24 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > On Fri, Nov 20, 2020 at 9:44 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Peter Collingbourne <pcc@google.com> writes:
> >>
> >> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> >> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> >> > the tag bits may be needed by tools in order to accurately diagnose
> >> > memory errors, such as HWASan [1] or future tools based on the Memory
> >> > Tagging Extension (MTE).
> >> >
> >> > We should not stop clearing these bits in the existing fault address
> >> > fields, because there may be existing userspace applications that are
> >> > expecting the tag bits to be cleared. Instead, introduce a flag in
> >> > sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> >> > there if the signal handler has this flag set.
> >> >
> >> > [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
> >>
> >> For the generic bits:
> >> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > Thanks for the review.
> >
> >> Some of the arm bits look wrong.  There are a couple of cases where
> >> it looks like you are deliberately passing an untagged address into
> >> functions that normally take tagged addresses.
> >>
> >> It might be a good idea to have a type distinction between the two.
> >> Perhaps "(void __user *)" vs "(unsigned long)" so that accidentally
> >> using the wrong one generates a type error.
> >>
> >> I don't think I am really qualified to review all of the arm details,
> >> and I certainly don't want to be in the middle of any arm bugs this
> >> code might introduce.  If you will split out the generic bits of this
> >> patch I will take it.  The this whole thing can be merged into the arm
> >
> > Okay, I'll do that.
>
> Thank you.

Sent out v21 with the generic parts split out.

> >> tree and you can ensure the arm bits are correct.
> >
> > So you want Catalin to merge your signal-for-v5.11 branch with the
> > generic patches into the arm64 tree and then add the arm64-specific
> > patch on top? Works for me.
>
> I think that is what we discussed.  Unless he has objections I would
> prefer that.  I based the branch on -rc3 in hopes that I would
> not cause problems for his process.
>
> In the cases where I was confused you probably want comments describing
> why the tag bits are being cleared.  It may be obvious when you know the
> architecture intimately but it certainly was not for me.  I certainly
> don't know the details of arm64 well enough to understand the
> architecture specific nuances.

I think that makes sense. I've added comments to those two cases.

Peter
