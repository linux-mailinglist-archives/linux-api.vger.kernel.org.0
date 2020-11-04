Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F52A6CA7
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 19:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgKDS1m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 13:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgKDS1m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 13:27:42 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E854C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 10:27:42 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id t8so9212774vsr.2
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHCMKto039+DBUmnK8zShsgth/7uXjcbXQ7/AnHF/98=;
        b=Qz2HVsd1hU88ljX3VsSYtwRSt9RD1W4LSfK/6SPGLz+Yv+1bna6reKL38kiCSq5QCR
         7/TvbL+CKGBxV9SOrgOYW+lXtC+ZV4JbfpJ9MKQLkPHqlDRO1do2zF6QWsxMGSnvzh2o
         h0PBpN+OCUlaqlwT0BXz0x8QiqIeTLnVP6U2cnRJlQ454uLPJ3H9hmYTEtsrQPqlxY5M
         YYi8QVL3cPqAD5Q1Hbqi+TkwS23+45x+GbotGwjcWirLU1lyQGt2HytgiKP+SE8fHbbv
         iOG2TFipndea5u7GmTwkyOwO28PqncldhtqT6I/DpllWz1o4mbo53T9xDMZj/pA6AINo
         Gbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHCMKto039+DBUmnK8zShsgth/7uXjcbXQ7/AnHF/98=;
        b=ODwiMiyx1yUZklDIj0nZ9qrmLZqQZlpjKhUb82MVKqaJaPp7N3qPDx5DSnhm2jBUkK
         v7iN0O/6eCQ61GPemPql4rvY8tHxA7B0ajT1tm5vs5BFqw/Dx8Wv1ZDrcM3/a//Tezix
         nIUUxpaEj3/mCP5YyDSWAj85exIXhMqmVUqANHwlEVHRhgFeolJolwOxZT+Iz80SbzJf
         izFUBVs4d99C4bMVJR1WDuPOB0WBvczt+ZaDRdA+kANkNxYfHqpqGH7FnAePDlu1e8/Y
         38Vskp5Hnxta/eOFnT49eXze6FzvFi8wxQle0pFFjltz255eYCHw/++SVgRVoo8XKm+O
         a+9A==
X-Gm-Message-State: AOAM5330lqHuYKpBK9AAOsdXsTqnV0bjlqfICSO2gIF4aXq3v2Ik5RXL
        sbrE6VN1G9ocaUbRSJ9CSn6lnAfw9HR4F1YYf3TeUA==
X-Google-Smtp-Source: ABdhPJzFkfebih9/bD2kHxGrVIugt6ZagphAhUQkwlwsC2AIAmePsUpva6DvymfQDHwu74eijBFrM3UWHDrDRUIfl84=
X-Received: by 2002:a05:6102:240f:: with SMTP id j15mr13725379vsi.22.1604514461240;
 Wed, 04 Nov 2020 10:27:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604376407.git.pcc@google.com> <c8a229473591a7bf98dc79e92403fe2de854ffef.1604376407.git.pcc@google.com>
 <20201103183321.GB81026@C02TF0J2HF1T.local> <CAMn1gO4q-7dEnCeF-PaL6K48jcpV-sJwnOSbT6JdL9NAd0XBWA@mail.gmail.com>
 <20201104174549.GG28902@gaia>
In-Reply-To: <20201104174549.GG28902@gaia>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 4 Nov 2020 10:27:30 -0800
Message-ID: <CAMn1gO7JzVGyf-1W19=wocMDwg7CDRYjhd2vOmEMUz-287JmEg@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] arm64: expose FAR_EL1 tag bits in siginfo
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 4, 2020 at 9:45 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Tue, Nov 03, 2020 at 11:16:53AM -0800, Peter Collingbourne wrote:
> > On Tue, Nov 3, 2020 at 10:33 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > That said, I wonder whether we could solve this for MTE without new
> > > fields by always setting the tag in si_addr when si_code is SEGV_MTE*.
> >
> > This wouldn't solve the problem for MTE in the case where there is a
> > non-linear buffer overflow that extends into an unmapped page, in
> > which case we would get a SEGV_MAPERR that we would still need the tag
> > bits for.
>
> What I was thinking of is to only present the tags for SEGV_MTE* faults
> (tag check faults). Is the tag relevant for a SEGV_MAPERR fault?

Yes, because in the case that I mentioned with a non-linear buffer
overflow into an unmapped page, the error reporting mechanism would
still need to know the address tag in order to associate the access
with an allocation.

> > > Alternatively, we could add a prctl() bit to require tagged si_addr.
> >
> > It's an option that we considered but I would be concerned about the
> > compatibility implications of this. In practice, on Android we would
> > always have this bit set, so applications would be exposed to the tag
> > bits in si_addr. If applications have previously relied on the
> > documented behavior that the tag bits are unset, they may get confused
> > by them now being set. It also wouldn't provide a way for the kernel
> > to communicate which tag bits are valid.
>
> It depends what you mean by application. If the MTE enabling and signal
> handling is done from zygote, I suspect the rest of the app won't
> install its own signal handlers, so they can't get confused.

This isn't the case for every Android application. For example, some
applications, such as Chrome, have their own crash reporting mechanism
(Crashpad in Chrome's case) and install their own signal handlers.
Google also offers Firebase Crashlytics for third-party applications
to use. Although the systems that I've mentioned are open source
and/or owned by Google so we could fix them if necessary, there's
nothing stopping apps from using their own third-party crash reporting
systems.

It's also possible for application-supplied language implementations,
such as Mono and Unity, to install their own signal handler to
implement fast null checks. You could also imagine a userspace page
fault handler being implemented this way as an alternative to using
userfaultfd.

> For standard Linux processes and glibc, the feature wouldn't be enabled
> by default even if MTE was turned on (we'd add a new prctl() bit).

Regardless of whether it's Android or not, you might still run into a
situation where one part of the system needs the bits and another gets
confused by them. (This could be something like two libraries sharing
a signal handler with something like Android's libsigchain, or one
process monitoring another's signals via ptrace.) Having this
controlled by a prctl seems like a global solution to a local problem,
which is the sort of thing that should be avoided if possible.

Peter

> Anyway, I'm not saying we should go for this approach, just making sure
> that we explored all the options (sorry, should have read the previous
> 12 series ;)).
>
> --
> Catalin
