Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F132B6F60
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 20:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgKQTwy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 14:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgKQTwy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 14:52:54 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9949C0613CF
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 11:52:52 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so20074671ybx.9
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX3yksTObGdOkNyPbHBadkI3vaA0uVJFPSi9URyFSNY=;
        b=sUUOkdO0M169HDxBvBaC6fmaS18TRTdFr59znKUmzXYOfH3Ww7SFYixnERAPZWCzTg
         SYr6HG1tIRk0jhRSKEaMmkEi0w41Wfw33RVbeRd4EYw/8OcLoMlyMiBBABsGAjuk89lf
         FkgyTUog3KfVBD/inXDHmw4eWpCvyzN/3i+8BqDjlfNcagUBbkqDNgKyhpgdKsUpIv4T
         3GovaefQjWX/P/guLuIpcpsgKdAg4vfjf3UVTuAuggTrDUmIXXVjruQmWkCMf6z0ttZn
         w6rKooAUKE9A7AzsIjAe20UD+whj4D/3BVaIfzRk7UVhxP7OVzRoXQNrfbaY1bgu44wI
         olLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX3yksTObGdOkNyPbHBadkI3vaA0uVJFPSi9URyFSNY=;
        b=IoGpMSGeBXZHBp69suJr/DnlN1fcL/mWfRlbttJtw4ic5sdipBNzOtgnlDbYDgLsob
         ZLMmvFIdPc4KZkBvWA5OQEfTzkymk3p8nA+GEkcvQ3h9Fg9tTeP/OSBEzGNq9m4KOKBV
         oJfoV09t5JRapVM4LMx37dqHwVzmcs8ukUu7xPP9e83mG2uPtwShAtL+pTI8LhH/TT9e
         aSaaTF6wVhNTn6ikH/NgrgbAUVaj5pGU18YJiLy0aBq6HdLIjA5oKgIflkaH5H9jaEoc
         Nt+rgBj5/1MFG4mlVi2GdPc7BWuYhNxzo9CZlawpDVT2g51mdDvKEcJW/Is3l8I5Dcl5
         8tQg==
X-Gm-Message-State: AOAM5300uQnRa0sBnXKe9giXmevILE2tIDnaycnsRcO4QdqAjfd5GgXy
        M/3WvrmfdORBXTxSLY4Ukbn/3/25IUG6z3Ma+pCy1w==
X-Google-Smtp-Source: ABdhPJwreoOOucyLOR4uVVPP4ZtQHhQ1B9MRI4peSDauwnIt4obfzNRiJAK7mxkIHKpqU6HWs7qOm0pR5kWiTtfvohU=
X-Received: by 2002:a25:60d6:: with SMTP id u205mr1342320ybb.401.1605642771710;
 Tue, 17 Nov 2020 11:52:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605582887.git.pcc@google.com> <87a6vfdf24.fsf@x220.int.ebiederm.org>
In-Reply-To: <87a6vfdf24.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 17 Nov 2020 11:52:40 -0800
Message-ID: <CAMn1gO5tpcEoDAGiA7w5d72Dpk2GTBgbkOOaWk87co7jXcyB8w@mail.gmail.com>
Subject: Re: [PATCH v17 0/3] arm64: expose FAR_EL1 tag bits in siginfo
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

On Tue, Nov 17, 2020 at 10:17 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > We should not stop clearing these bits in the existing fault address
> > fields, because there may be existing userspace applications that are
> > expecting the tag bits to be cleared. Instead, introduce a flag in
> > sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> > there if the signal handler has this flag set.
> >
> > In order to allow userspace to determine whether SA_EXPOSE_TAGBITS
> > is supported, we first introduce a mechanism for userspace to detect
> > kernel support for SA_* flags.
> >
> > These patches need to be applied on top of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11
>
> The first two patches look good and I have applied them.
>
> While I was at it I added Link tags to the LKML postings to the entire
> series.  I don't think anyone has merged my branch into another so it
> should still be safe.

Thanks!

Peter
