Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33D334BA45
	for <lists+linux-api@lfdr.de>; Sun, 28 Mar 2021 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhC1Axh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Mar 2021 20:53:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhC1Axh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 27 Mar 2021 20:53:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616892795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1guLZj0UITC98wYsVvLolqRYd4jIEoTDNUlR+FmfJjs=;
        b=SmryalnVWhdpqm8CIozQtnSbU3FCWSSHTHXoSQntHpFtQ1imKPlqzSD5Es8lm+qd5SmIw5
        /GW4PfGZDyTctGPqdqMisQPD29vDfKiaI6u5hhzhu8WAdMmW3vCxjKs9fjOVxAHOL92v6G
        rAODmxMGcrRHPu7b95XqBjsd+TzmSS0RQ3u8eoOm9gtZE/63nf0T6IpLMRjuOYQaKezApq
        xmLMHk6vG4uVzeAQRCh9ot+VikfnMXLyMTZhxqvwpnrt2nxnZ/bdt1IqS7FzdFBzG4hrvL
        z4vLf5Qe8o1HgDdlb2k2+DvymyNX1oEnn8HUl0OORnTGg4tNvO3PZfzbAHWm+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616892795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1guLZj0UITC98wYsVvLolqRYd4jIEoTDNUlR+FmfJjs=;
        b=NwGciNTxluXoyiIZdf85vrM+gEDVaEp+26tYWa/edLEgdvq7LQ0R5fykGoyPyOp3SNIa/F
        Ch3BtCa+1Uk5sdBg==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com> <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
Date:   Sun, 28 Mar 2021 01:53:15 +0100
Message-ID: <87o8f4cd50.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andy,

On Fri, Mar 26 2021 at 16:18, Andy Lutomirski wrote:
> arch_prctl(ARCH_SET_XCR0, xcr0, lazy_states, sigsave_states,
> sigclear_states, 0);
>
> Sets xcr0.  All states are preallocated except that states in
> lazy_states may be unallocated in the kernel until used.  (Not
> supported at all in v1.  lazy_states & ~xcr0 != 0 is illegal.)  States
> in sigsave_states are saved in the signal frame.  States in
> sigclear_states are reset to the init state on signal delivery.
> States in sigsave_states are restored by sigreturn, and states not in
> sigsave_states are left alone by sigreturn.

I like the idea in principle.

> Optionally we come up with a new format for new features in the signal
> frame, since the current format is showing its age.  Taking 8kB for a
> signal with AMX is one thing.  Taking another 8kB for a nested signal
> if AMX is not in use is worse.

I don't think that we should make that optional to begin with. Sizing
sigaltstack is lottery as of today and making it more so does not help
at all.

> Optionally we make AVX-512 also default off, which fixes what is
> arguably a serious ABI break with AVX-512: lots of programs, following
> POSIX (!), seem to think that they know much much space to allocate
> for sigaltstack().   AVX-512 is too big.

I really wish we could do that. That AVX512 disaster is not trivial to
sort.

Let's focus on AMX first. That ship at least has not sailed yet, but if
it does without a proper resolution then it's going to sail deep south.
Maybe we end up with some ideas about the AVX512 issue as well that way.

The main problem I see is simply historical. Every other part of the
user stack space from libraries to applications tries to be "smart"
about utilizing the assumed best instruction set, feature extensions
which are detected when something is initialized. I can sing a song of
that because I was casually involved porting debian to an unsupported
architecture. Magic all over the place. Now add the whole pile of
proprietary software stacks, libraries on top of that picture and things
get completely out of control.

Why? Simply because user space has absolutely no concept about
orchestrating these things at all. That worked for a while by some
definition of works and this model is still proliferated today even by
players who should know better.

Even if you expected that some not so distant events and the experience
with fleet consistency would have stopped the 'performance first,
features first' chorus in some way, that's not what reality is.

Linux is not necessarily innocent. For years we just crammed features
into the kernel without thinking too hard about the big picture. But,
yes we realized the hard way that there is a problem and just adding yet
another magic 'make it work' hack for AMX is definitely the wrong
approach.

What are the possible problems when we make it a hard requirement for
AMX to be requested by an application/task in order to use it?

For the kernel itself. Not really any consequence I can think off
aside of unhappy campers in user space.

For user space this is disruptive and we have at least to come up with
some reasonable model how all involved components with different ideas
of how to best utilize a given CPU can be handled.

That starts at the very simple problem of feature enumeration. Up to now
CPUID is non-priviledged and a large amount of user space just takes
that as the ultimate reference. We can change that when CPUID faulting
in CPL3 is supported by the CPU which we can't depend on because it is
not architectural.

Though the little devil in my head tells me, that making AMX support
depend on the CPUID faulting capability might be not the worst thing.

Then we actually enforce CPUID faulting (finally) on CPUs which support
it, which would be a first step into the right direction simply because
then random library X has to go to the kernel and ask for it explicitely
or just shrug and use whatever the kernel is willing to hand out in
CPUID.

Now take that one step further. When the first part of some user space
application asks for it, then you can register that with the process and
make sane decisions for all other requesters which come after it, which
is an important step into the direction of having a common orchestration
for this.

Sure you can do that via XCR0 as well to some extent, but that CPUID
fault would solve a whole class of other problems which people who care
about feature consistency face today at least to some extent.

And contrary to XCR0, which is orthogonal and obviously still required
for the AMX (and hint AVX512) problem, CPUID faulting would just hand
out the feature bits which the kernel want's to hand out.

If the app, library or whatever still tries to use them, then they get
the #UD, #GP or whatever penalty is associated to that particular XCR0
disabled piece. It's not there, you tried, keep the pieces.

Making it solely depend on XCR0 and fault if not requested upfront is
bringing you into the situation that you broke 'legacy code' which
relied on the CPUID bit and that worked until now which gets you
in the no-regression trap.

I haven't thought this through obviously, but depending solely on XCR0
faults did not really sum up, so I thought I share that evil idea for
broader discussion.

Thanks,

        tglx
