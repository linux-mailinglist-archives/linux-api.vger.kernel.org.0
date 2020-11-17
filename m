Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3453A2B6D94
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgKQSkM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgKQSkM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 13:40:12 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17100C0613CF
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 10:40:12 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id j12so22282393iow.0
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJjpIWurXoKndtQsey1wE4FF0urevJ+gcZzD20BZ6GA=;
        b=DHXFz+8v9XH77JeUP6pgZbDXUB4rvNLbAeuR9Ky2JSegDJ3UDw6HblPdTkifpSS+63
         3kVrz/dSbZ7Iz5UlYJmOskYvAWs9PAexmnNl+/7HTI8aSsecgnk7wetnMUbcnj7WFWf5
         l/g0YRYVEN8n2ZklZwiEv6n1LtvchkrTJ65FhZaLDV1YSSWl6SxjF0g286do4AV5lovd
         vA0tfTpKWOWj4zBxLJrgeYiFAecynMWXcl2ZdkSJ2KgaX+bFAV5Ar9BtduhELefUWnuy
         VdvkwfXN5DchEbSFKsbqCWLsTueAsuPkCO/b1ia76HkSCbGnQf4dItSLnL6oQdrXaKAx
         YcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJjpIWurXoKndtQsey1wE4FF0urevJ+gcZzD20BZ6GA=;
        b=KE3nmydHqTXHi7zoHe7pD7CAznyCxJ8Li8mzv31Bc3a+GpbXkJjqpGod+jrF3jhNlL
         7IG3fmaXcb6SW+MBWizR8PbPp+bBq4m+jHjiuaa7mL6CNUDH9J+WPJ4LKwKTIFkJucqu
         aeC2PHpbN0jQ4O7pNTA0UIKd8kHYk0Lud6uaSArJqoVcHPvosYzG+MX0c+NXp8+YMILu
         V3S8tMYaCx2ckiY95IF6Vcr7OlygxxiR1fCGrwqVTzNDKqMLgZhx4pWE/MFQDITmpWPP
         QMdqrzPBEPRlQ4fTxOqNySpEg6xmzz/OKTC+czEKSN7uE+NmBkgBiATP85S1R2gr1Yq2
         WmWw==
X-Gm-Message-State: AOAM530uitFXi/UrPBrGY5k5Vkn/gvMGvKKX1iBRdXe+yp9zYHCljezU
        80ZjfRDzMydjy65u/zuHp1xMBEHRbXlGWT3Wt96BmA==
X-Google-Smtp-Source: ABdhPJweOknmYybC+K3gRbP2qioCOiAns0PcavbQZb0ARZAYxD8udKLes/O30Jr7eIfD5avGYJG+iPwPzJSo8JRhFUk=
X-Received: by 2002:a5d:9cc7:: with SMTP id w7mr12457759iow.202.1605638411207;
 Tue, 17 Nov 2020 10:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20201014055106.25164-1-pcc@google.com> <X7QIeRIKwd3ShByU@trantor> <20201117181431.GH15033@arm.com>
In-Reply-To: <20201117181431.GH15033@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 17 Nov 2020 10:40:00 -0800
Message-ID: <CAMn1gO7QgZihNgq7LbmVw9bcAn29Yxa-0vOAG9Ki_co6QACvFQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 10:14 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 11/17/2020 17:29, Catalin Marinas wrote:
> > Adding Szabolcs and libc-alpha. The original patch below and also here:
> >
> > https://lore.kernel.org/r/20201014055106.25164-1-pcc@google.com
> >
> > The patch looks fine to me but I'd like the glibc community to confirm
> > that they are happy with this ABI addition. I'd also like Dave Martin to
> > ack the patch since he was involved in the discussion for v1.
> >
> > Thanks.
> >
> > Catalin
> >
> > On Tue, Oct 13, 2020 at 10:51:06PM -0700, Peter Collingbourne wrote:
> > > This prctl allows the user program to control which PAC keys are enabled
> > > in a particular task. The main reason why this is useful is to enable a
> > > userspace ABI that uses PAC to sign and authenticate function pointers
> > > and other pointers exposed outside of the function, while still allowing
> > > binaries conforming to the ABI to interoperate with legacy binaries that
> > > do not sign or authenticate pointers.
> > >
> > > The idea is that a dynamic loader or early startup code would issue
> > > this prctl very early after establishing that a process may load legacy
> > > binaries, but before executing any PAC instructions.
> > >
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
> > > ---
> > > This patch must be applied on top of Catalin's MTE series:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte
> > >
> > > Alternatively the series with this patch on top may be
> > > downloaded from Gerrit by following the link above.
> ...
> > > +Enabling and disabling keys
> > > +---------------------------
> > > +
> > > +The prctl PR_PAC_SET_ENABLED_KEYS allows the user program to control which
> > > +PAC keys are enabled in a particular task. It takes two arguments, the
> > > +first being a bitmask of PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY
> > > +and PR_PAC_APDBKEY specifying which keys shall be affected by this prctl,
> > > +and the second being a bitmask of the same bits specifying whether the key
> > > +should be enabled or disabled. For example::
> > > +
> > > +  prctl(PR_PAC_SET_ENABLED_KEYS,
> > > +        PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY,
> > > +        PR_PAC_APIBKEY, 0, 0);
> > > +
> > > +disables all keys except the IB key.
> > > +
> > > +The main reason why this is useful is to enable a userspace ABI that uses PAC
> > > +instructions to sign and authenticate function pointers and other pointers
> > > +exposed outside of the function, while still allowing binaries conforming to
> > > +the ABI to interoperate with legacy binaries that do not sign or authenticate
> > > +pointers.
> > > +
> > > +The idea is that a dynamic loader or early startup code would issue this
> > > +prctl very early after establishing that a process may load legacy binaries,
> > > +but before executing any PAC instructions.
>
> which keys are enabled by default when HWCAP_PACA is
> set in AT_HWCAPS ? i think that would be useful to
> point out here.

For compatibility with previous kernel versions all keys are enabled
by default at process startup. But I agree it would be useful to point
it out here.

> per process enable/disable was deemed costly to do when
> pac support was added, did this change? (i'm happy if it
> did, because even without a new PAC specific pointer ABI,
> plain PAC-RET can cause problems if a process tries to do
> its own DWARF unwinding but does not understand the new
> opcode that toggles PAC status of the return address,
> possibly in a third party library, so a way to opt-out of
> PAC is useful. currently it's a kernel config option and
> system wide on or off.)

My understanding is that it was considered too expensive to do without
a use case, but we did come up with one. In general we only need to
update the system register on process switch as well as on entry/exit
if we need to disable IA which is also needed by in-kernel PAC. I did
benchmark a variant of the code sequences on existing non-PAC HW [1]
which showed that the entry/exit overhead in the common case where IA
is left enabled is expected to be low. But with the new Apple chips I
think it should be possible to benchmark the real entry/exit code
sequences on supporting HW in the enabled and disabled cases.

Peter

[1] https://lore.kernel.org/linux-arm-kernel/CAMn1gO7HCJiXEzDvBb-=T7znATqyaxE_t-zezqKL0dyXRCG-nQ@mail.gmail.com/
