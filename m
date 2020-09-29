Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBCB27D553
	for <lists+linux-api@lfdr.de>; Tue, 29 Sep 2020 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgI2SBq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Sep 2020 14:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgI2SBo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Sep 2020 14:01:44 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF58D21548
        for <linux-api@vger.kernel.org>; Tue, 29 Sep 2020 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601402503;
        bh=qHGaWE5xeSFtQ38W8/1bcT9r0GT5DWk3xHCTe2Q+VyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GmhvtEAKgfmvplao8J2xA3KgrSoqxRB/gFNKpQxz2OVUJFFlv8lpJaqfWSeu6pBDD
         TzZxyLhXE5exJbeZ0HzFrwP37VSRejRhecommvSf6BUONsw3Voj/EcXn/cjteOEXLD
         D8Izj1Qf9NupVuv5YuKwQtTAHHzQ4qmxttVJkjE0=
Received: by mail-wr1-f54.google.com with SMTP id z4so6459793wrr.4
        for <linux-api@vger.kernel.org>; Tue, 29 Sep 2020 11:01:42 -0700 (PDT)
X-Gm-Message-State: AOAM532fNq5WW3AbXBjJD6/0v8yJmoixVPKxaZ+vGGo+Dp5RfbcKo+ZQ
        WNx+jCe19/sjHiW62C0NWMgScL5BekLmz25HGMNRwA==
X-Google-Smtp-Source: ABdhPJxuWgqQxEb9c//1fSJnomNu4Zi/ZcMkSNz00D7Sda+rKAu/GSSRaNKweGN4USIvCiXeS2KnXbl5FFLdwM/MeuM=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr5626947wrb.70.1601402501271;
 Tue, 29 Sep 2020 11:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com> <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 29 Sep 2020 11:01:29 -0700
X-Gmail-Original-Message-ID: <CALCETrU5eu+TBs4rs_vF28rP=46nPF8-=hANdRb7QuBLqkCQBg@mail.gmail.com>
Message-ID: <CALCETrU5eu+TBs4rs_vF28rP=46nPF8-=hANdRb7QuBLqkCQBg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 28, 2020 at 8:14 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Mathieu Desnoyers:
>
> > Upstreaming efforts aiming to integrate rseq support into glibc led to
> > interesting discussions, where we identified a clear need to extend the
> > size of the per-thread structure shared between kernel and user-space
> > (struct rseq).  This is something that is not possible with the current
> > rseq ABI.  The fact that the current non-extensible rseq kernel ABI
> > would also prevent glibc's ABI to be extended prevents its integration
> > into glibc.
> >
> > Discussions with glibc maintainers led to the following design, which we
> > are calling "Kernel Thread Local Storage" or KTLS:
> >
> > - at glibc library init:
> >   - glibc queries the size and alignment of the KTLS area supported by the
> >     kernel,
> >   - glibc reserves the memory area required by the kernel for main
> >     thread,
> >   - glibc registers the offset from thread pointer where the KTLS area
> >     will be placed for all threads belonging to the threads group which
> >     are created with clone3 CLONE_RSEQ_KTLS,
> > - at nptl thread creation:
> >   - glibc reserves the memory area required by the kernel,
> > - application/libraries can query glibc for the offset/size of the
> >   KTLS area, and offset from the thread pointer to access that area.
>
> One remaining challenge see is that we want to use vDSO functions to
> abstract away the exact layout of the KTLS area.  For example, there are
> various implementation strategies for getuid optimizations, some of them
> exposing a shared struct cred in a thread group, and others not doing
> that.
>
> The vDSO has access to the thread pointer because it's ABI (something
> that we recently (and quite conveniently) clarified for x86).  What it
> does not know is the offset of the KTLS area from the thread pointer.
> In the original rseq implementation, this offset could vary from thread
> to thread in a process, although the submitted glibc implementation did
> not use this level of flexibility and the offset is constant.  The vDSO
> is not relocated by the run-time dynamic loader, so it can't use ELF TLS
> data.

I assume that, by "thread pointer", you mean the pointer stored in
GSBASE on x86_32, FSBASE on x86_64, and elsewhere on other
architectures?

The vDSO has done pretty well so far having the vDSO not touch FS, GS,
or their bases at all.  If we want to change that, I would be very
nervous about doing so in existing vDSO functions.  Regardless of
anything an ABI document might say and anything that existing or
previous glibc versions may or may not have done, there are plenty of
bizarre programs out there that don't really respect the psABI
document.  Go and various not-ready-for-prime-time-but-released-anyway
Bionic branches come to mind.  So we would need to tread very, very
carefully.

One way to side-step much of this would be to make the interface explicit:

long __vdso_do_whatever(void *ktls_ptr, ...);

Sadly, on x86, actually generating the ktls ptr is bit nasty due to
the fact that lea %fs:(offset) doesn't do what one might have liked it
to do.  I suppose this could also be:

long __vdso_do_whatever(unsigned long ktls_offset);

which will generate quite nice code on x86_64.  I can't speak for the
asm capabilities of other architectures.

What I *don't* want to do is to accidentally repeat anything like the
%gs:0x28 mess we have with the stack cookie on x86_32.  (The stack
cookie is, in kernel code, in a completely nonsensical location.  I'm
quite surprised that any of the maintainers ever accepted the current
stack cookie implementation.  I assume there's some history there, but
I don't know it.  The end result is a festering mess in the x86_32
kernel code that only persists because no one cares quite enough about
x86_32 to fix it.)  We obviously won't end up with precisely the same
type of mistake here, but a mis-step here certainly does have the
possibility of promoting an unfortunate-in-hindsight design decision
in glibc and/or psABI to something that every other x86_64 Linux
software stack has to copy to be compatible with the vDSO.

As for errno itself, with all due respect to those who designed errno
before I was born, IMO it was a mistake.  Why exactly should the vDSO
know about errno?
