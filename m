Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA22C30A9
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbgKXTSY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390909AbgKXTSX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 14:18:23 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35314C0613D6
        for <linux-api@vger.kernel.org>; Tue, 24 Nov 2020 11:18:22 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id r9so23077298ioo.7
        for <linux-api@vger.kernel.org>; Tue, 24 Nov 2020 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idnE1XctnHORDhoVgx9a3wcMOuTd731MfJaNiFOgDGc=;
        b=ndHjZYZpz2yu7J6YDta1R5hJ5LCSMOcnfs+RGsdu3nu2FChgZUUi/Kh4I87wMJGYQs
         pu7NlEPA+AdrsVOI2AdFuoh2ndhqVkNuJev2dguIyKOr4bFrCr3wRilu0s6/IaKgOl6A
         r0nQhUB8JcPJu+eGTY3GSXSQ2NTYtyvzQiRrD7Y7r7GBV8GGdUeOW/2DAc7LcHuBz8Pw
         i+7mJX0NofR3VxmJ29astiujoKdk121hWlNlZxF8Pquii8CTjWT6aah3TqlbQIvbrPYT
         ANI2A7Y/IXVPtqZWLzaRPrqIt2R6SsttAROm9s6pkUhBoQeaSnbiiGy3aFI+RvXjXMzO
         SDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idnE1XctnHORDhoVgx9a3wcMOuTd731MfJaNiFOgDGc=;
        b=X3Hp16hDYVqA5NH+aErKNPESXhiuv5gZ8D2HPu7iTGWyGF99E8RNCvRORJuxoXP3So
         jnfxWKvzBAPuhcoaUUUxGG42lL797Ad5i8YJ/0fg3MmeBBS5eMsezQrWRZnybOSfDQ+G
         urpQXdyM3yz1FkarzhaUqocEhH7+pMLDLg+Ghs2MK0tUDPhl3RhtyTFktyNQin97bQSr
         ZKySzuy9+VVeup0GNUDcZZbMtDqSoEjgfM8FDUwgCMchG4VuxRauXhTSMC2RpHW28VfR
         Pi/24crlCaE96Rd0K/JZPYUVRbEVuDq4Nfp3DYrs/mgj0cQS4cmK7ry46hsMmhh07TDr
         YJfw==
X-Gm-Message-State: AOAM5303JOkrOsIwvvrglVVzvMqqR6U+WSuLX9l0FU6J+ovTXve5E2wu
        oZ692bXvbfNByj5yMZldqjsaG5xyYq5KLEplJmUfvA==
X-Google-Smtp-Source: ABdhPJw6kPUI6xlqBM7Q5gnoG0UQ6OveDVdIORc+4W3t6zjSJ1J4E0O4gHw7a/b/iZXE95B2zvxa5dT05ILVdizAbTo=
X-Received: by 2002:a02:ccbc:: with SMTP id t28mr43442jap.97.1606245501446;
 Tue, 24 Nov 2020 11:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
 <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com> <20201124184742.GC42276@C02TF0J2HF1T.local>
In-Reply-To: <20201124184742.GC42276@C02TF0J2HF1T.local>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 24 Nov 2020 11:18:10 -0800
Message-ID: <CAMn1gO7G=s7pHFf3jNLj6tZyRuRDvpC2_o=oNWEi4h902hnj6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allow TCR_EL1.TBID0 to be configured
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 10:47 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Sat, Nov 21, 2020 at 01:59:03AM -0800, Peter Collingbourne wrote:
> > Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
> > set at boot time.
> >
> > Setting TCR_EL1.TBID0 increases the number of signature bits used by
> > the pointer authentication instructions for instruction addresses by 8,
> > which improves the security of pointer authentication, but it also has
> > the consequence of changing the operation of the branch instructions
> > so that they no longer ignore the top byte of the target address but
> > instead fault if they are non-zero. Since this is a change to the
> > userspace ABI the option defaults to off.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
> > ---
> > This is more of an RFC. An open question is how to expose this.
> > Having it be a build-time flag is probably the simplest option
> > but I guess it could also be a boot flag. Since it involves an
> > ABI change we may also want a prctl() so that userspace can
> > figure out which mode it is in.
> >
> > I think we should try to avoid it being a per-task property
> > so that we don't need to swap yet another system register on
> > task switch.
>
> Having it changed per task at run-time is problematic as this bit may be
> cached in the TLB, so it would require a synchronisation across all CPUs
> followed by TLBI. It's not even clear to me from the ARM ARM whether
> this bit is tagged by ASID, which, if not, would make a per-process
> setting impossible.
>
> So this leaves us with a cmdline option. If we are confident that no
> software makes use of tagged instruction pointers, we could have it
> default on.

I would be concerned about turning it on by default because tagged
instruction pointers may end up being used unintentionally as a result
of emergent behavior. For example, when booting Android under FVP with
this enabled I discovered that SwiftShader would crash when entering
JITed code because the code was being stored at a tagged address
(tagged because it had been allocated using Scudo's MTE allocator).
Arguably software shouldn't be storing executable code in memory owned
by the allocator as this would require changing the permissions of
memory that it doesn't own, but from the kernel's perspective it is
valid.

Peter

> Adding Szabolcs on the gcc/glibc side.
>
> --
> Catalin
