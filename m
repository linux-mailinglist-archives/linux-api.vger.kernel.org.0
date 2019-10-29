Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684F3E8F04
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 19:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfJ2SKs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 14:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfJ2SKs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 14:10:48 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55E9222CB
        for <linux-api@vger.kernel.org>; Tue, 29 Oct 2019 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572372647;
        bh=mmqqgcnvD3Xud8Yvhd/XeHf9l9aSOrYjKCNVmej7nv0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e94CpByjlElpCBSdGUw8LOUInMuzqLKgLsu2uwnO0r3HVjCV4JW7sUt1C6hs3eFmj
         j+vn75mvMAfROWiNwnx9nN+jLqNLHL155HSgxVTUgc1MkUhMPL0Czut3zx/MmLr8Pb
         D/TJ+hYXOpGdFFJdT8VUuj4Kba3ILPFDnGuB2pkA=
Received: by mail-wr1-f52.google.com with SMTP id z11so14670586wro.11
        for <linux-api@vger.kernel.org>; Tue, 29 Oct 2019 11:10:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXdOY0I16c41Kx6d2/e96jeJ+AZtLyEk4/E9qpq5fvkMTVY8L3E
        PJl0CjnWoOw1Tl+VWNA1nNH9fR+vvdgFlTbPJiSx7g==
X-Google-Smtp-Source: APXvYqyyGQurQRoJqssK2xQ7l0EkhvtO2ydIBS+FoKGjmrJ5tPxXAskMG/ddIaZ/DfCEvnkwuipKTQJ42JZRKo2GfSU=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr20627016wrv.149.1572372644926;
 Tue, 29 Oct 2019 11:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
 <CALCETrWN9kc+10tf7YoBp9ixqkO_KZ=b1E_cFBr_Uogxhu68PQ@mail.gmail.com> <1572371012.4812.19.camel@linux.ibm.com>
In-Reply-To: <1572371012.4812.19.camel@linux.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 29 Oct 2019 11:10:33 -0700
X-Gmail-Original-Message-ID: <CALCETrUhGqyEJtyBQWubh=5cUt2i-N-oZJqcBM5jBnGi1saxsQ@mail.gmail.com>
Message-ID: <CALCETrUhGqyEJtyBQWubh=5cUt2i-N-oZJqcBM5jBnGi1saxsQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 10:44 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2019-10-29 at 10:03 -0700, Andy Lutomirski wrote:
> > On Tue, Oct 29, 2019 at 4:25 AM Reshetova, Elena
> > <elena.reshetova@intel.com> wrote:
> > >
> > > > The patch below aims to allow applications to create mappins that
> > > > have
> > > > pages visible only to the owning process. Such mappings could be
> > > > used to
> > > > store secrets so that these secrets are not visible neither to
> > > > other
> > > > processes nor to the kernel.
> > >
> > > Hi Mike,
> > >
> > > I have actually been looking into the closely related problem for
> > > the past
> > > couple of weeks (on and off). What is common here is the need for
> > > userspace
> > > to indicate to kernel that some pages contain secrets. And then
> > > there are
> > > actually a number of things that kernel can do to try to protect
> > > these secrets
> > > better. Unmap from direct map is one of them. Another thing is to
> > > map such
> > > pages as non-cached, which can help us to prevent or considerably
> > > restrict
> > > speculation on such pages. The initial proof of concept for marking
> > > pages as
> > > "UNCACHED" that I got from Dave Hansen was actually based on
> > > mlock2()
> > > and a new flag for it for this purpose. Since then I have been
> > > thinking on what
> > > interface suits the use case better and actually selected going
> > > with new madvise()
> > > flag instead because of all possible implications for fragmentation
> > > and performance.
> >
> > Doing all of this with MAP_SECRET seems bad to me.  If user code
> > wants UC memory, it should ask for UC memory -- having the kernel
> > involved in the decision to use UC memory is a bad idea, because the
> > performance impact of using UC memory where user code wasn't
> > expecting it wil be so bad that the system might as well not work at
> > all.  (For kicks, I once added a sysctl to turn off caching in
> > CR0.  I enabled it in gnome-shell.  The system slowed down to such an
> > extent that I was unable to enter the three or so keystrokes to turn
> > it back off.)
> >
> > EXCLUSIVE makes sense.  Saying "don't ptrace this" makes sense.  UC
> > makes sense.  But having one flag to rule them all does not make
> > sense to me.
>
> So this is a usability problem.  We have a memory flag that can be used
> for "secrecy" for some userspace value of the word and we have a load
> of internal properties depending on how the hardware works, including
> potentially some hardware additions like SEV or TME, that can be used
> to implement the property.  If we expose our hardware vagaries, the
> user is really not going to know what to do ... and we have a limited
> number of flags to express this, so it stands to reason that we need to
> define "secrecy" for the user and then implement it using whatever
> flags we have.  So I think no ptrace and no direct map make sense for
> pretty much any value of "secrecy".  The UC bit seems to be an attempt
> to prevent exfiltration via L1TF or other cache side channels, so it
> looks like it should only be applied if the side channel mitigations
> aren't active ... which would tend to indicate it's a kernel decision
> as well.

I just don't think this will work in practice.  Someone will say "hey,
let's keep this giant buffer we do crypto from, or maybe even the
entire data area of some critical service, secret".  It will work
*fine* at first.  But then some kernel config changes and we can't do
DMA, and now it breaks on some configs.  Someone else will say "hey, I
don't have L1TF or whatever mitigation, let's turn on UC", and
everything goes to hell.

IMO the kernel should attempt to keep *all memory* secret.  Specific
applications that want greater levels of secrecy should opt in to more
expensive things.  Here's what's already on the table:

Exclusive / XPFO / XPO: allocation might be extremely expensive.
Overuse might hurt performance due to huge page fragmentation  DMA may
not work.  Otherwise it's peachy.

SEV: Works only in some contexts.  The current kernel implementation
is, IMO, unacceptable to the extent that I wish I could go back in
time and NAK it.

TME: it's on or it's off.  There's no room for a MAP_ flag here.

MKTME: of highly dubious value here.  The only useful thing here I can
thing it would be a MAP_NOTSECRET to opt *out* of encryption for a
specific range.  Other than that, it has all the same performance
implications that EXCLUSIVE has.

UC: Performance hit is extreme.  *Also* has the perf implications of
exclusive.  I can't imagine this making any sense except were the user
application is written in the expectation that UC might be used so
that the access patterns would be reasonable.

WC: Same issues as UC plus memory ordering issues such that
unsuspecting applications will corrupt data.

Trying to bundle these together with kernel- or admin-only config
seems like a lost cause.
