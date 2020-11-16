Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3802B4FC7
	for <lists+linux-api@lfdr.de>; Mon, 16 Nov 2020 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbgKPSdM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 13:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbgKPSdL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 13:33:11 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB437C0613CF
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 10:33:10 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y73so9683760vsc.5
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2WSvPQ6g5CDujfyxzpumoxkxQx2SLmMpxeYzRIHHFE=;
        b=TElt3EbosbrOPvv1wYfNmSX7mcM/9Hpdo9kbN9y6LuNkJAi9MStsC9tFn6mWqSOG/o
         nl7U2/Z764VMUVG6Wu4IdLTz886PCFmZRqdzGq17VdVNJdqFhU6VGYB0/hWZ55NnuUil
         UlSbvOhzhQEWW6FVPboOef6Y2IzpenOHkSpuXqhj8TUA9enU8RiRCg6wWmRju5I5TWmt
         VtC+E5IBrhZxVx39iD3pmqLRPlpVENXP3qGCKv5SSKSBHJ+LENeyZphjmqkzsC8y05o/
         0uQi/BMPKNlaXbrJtmDChSndruSWzYZOa9fCLc/z9TydtelbEcP3olol7LuIdf+3aHFP
         R9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2WSvPQ6g5CDujfyxzpumoxkxQx2SLmMpxeYzRIHHFE=;
        b=G+RLhi94FBCoN8detF1r50ombQckzpSrQze9PGjPwb2wBQtsguoSfeWy0Ze0ElOU/m
         lrIQErEQzkEsN9VM/kW6/BElih1lvwRJJ+nTYYgiyuulQ1QZbur1cB9UVS1Qs3uDOqY+
         sSPLioqMNxLge3cxWO1MWJuXTk2Ai7uVcaN9Z5pl92rY7AnBFicQizRR8fYNYO5W155V
         W7/sPM5eh38ho0Mq6U9EgofD9LiTfUGlaHdrwmX9fnheeWrzkBkpe14atos/qb2PSP0u
         bLQJQcNsb/HyE4bwTOsnxTl+Q3DbILcaHsteE1aZTSWGku5KBi+DtVvxnF2lZpMReI/j
         DD3A==
X-Gm-Message-State: AOAM530lXrinXkQktik+lDC3fO2lRt7QbcERiZz9pm0+t93Aj704WJhz
        +Pwak87IFv4s6qepgZi5vlqISLWIJ9aqQPV1n9l4dg==
X-Google-Smtp-Source: ABdhPJwEpzs8wrF//6FwHmTAhC7OKDIOQvNtJyYspElJZbun0vkofRttY6to9XYaYxnYuoHyXJIcIvDSlieW/11vE2k=
X-Received: by 2002:a05:6102:1173:: with SMTP id k19mr8794428vsg.51.1605551589729;
 Mon, 16 Nov 2020 10:33:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605235762.git.pcc@google.com> <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
 <87ft5an257.fsf@x220.int.ebiederm.org> <20201116133600.GY6882@arm.com>
In-Reply-To: <20201116133600.GY6882@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 16 Nov 2020 10:32:57 -0800
Message-ID: <CAMn1gO6n7NrM8A+vkMt=ixvbSzUJbrr2s6Ko3WENPoT-84J15w@mail.gmail.com>
Subject: Re: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Mon, Nov 16, 2020 at 5:36 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Sun, Nov 15, 2020 at 08:08:36AM -0600, Eric W. Biederman wrote:
> > Peter Collingbourne <pcc@google.com> writes:
> >
> > > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > > the tag bits may be needed by tools in order to accurately diagnose
> > > memory errors, such as HWASan [1] or future tools based on the Memory
> > > Tagging Extension (MTE).
> > >
> > > We should not stop clearing these bits in the existing fault address
> > > fields, because there may be existing userspace applications that are
> > > expecting the tag bits to be cleared. Instead, introduce a flag in
> > > sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> > > there if the signal handler has this flag set.
> >
> > For future architectures that implement something similar does it make
> > sense that to hide tag bits by default?
>
> I think on arm64 this comes from the fact that the tag bits information
> is not available in all scenarios.  To keep things clean, the decision
> was taken early on to just zero them all the time in si_addr to avoid
> software getting confused.  Possibly other arches do something similar,
> but that would need digging into.
>
> There seems to be debate on whether these bits are part of the address
> or not.  For si_addr I think they probably _should_ be regarded as part
> of the address in general, and arches that can always report all these
> bits in si_addr should probably do so IMHO.
>
> > I am wondering if SA_EXPOSE_TABGITS might make sense as an architecture
> > specific sa bit.
>
> Perhaps.  Peter, do you see other arches masking out bits in si_addr?

I think it's possible, since it seems likely to me that the bits would
only be able to be exposed unconditionally if the architecture with
the tag bits is new. For existing architectures that are being
extended with tag bits (e.g. RISC-V), I can see folks running into the
same problem of software getting confused by the tag bits, so they
would want to put them behind a flag, ideally the same one.

Another point in favor of making it generic is that in many cases
where you want these bits your signal handler will for the most part
not be arch-specific. In Android's case for example we have a
tombstone signal handler which is mostly generic with the
arch-specific parts hidden behind an abstraction, and the libsigchain
signal handler that needs to hide the bits if the flag is not set, but
is otherwise generic. Making it generic avoids an #ifdef around the
points where we need to refer to the flag. Please see my AOSP
userspace changes [1] for reference. As you can see there is no #ifdef
__aarch64__ required at all except for tests (there is already a
helper function for untagging addresses that has the required #ifdef),
but there are several points at which we need to refer to the flag.
With an arch-specific flag the #ifdef would become more pervasive.

Peter

[1] https://android-review.googlesource.com/id/I57f24c07c01ceb3e5b81cfc15edf559ef7dfc740
