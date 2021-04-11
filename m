Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B9435B6AE
	for <lists+linux-api@lfdr.de>; Sun, 11 Apr 2021 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhDKTH7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 11 Apr 2021 15:07:59 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:46851 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhDKTH6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 11 Apr 2021 15:07:58 -0400
Received: by mail-ej1-f47.google.com with SMTP id u21so16634910ejo.13;
        Sun, 11 Apr 2021 12:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TW+53pU0SSNZyt861ObPAXcQvuwTrue+FqiP7XKvTw=;
        b=k7Nthq7lhgCg3svMmtCoiZM4/Sc9LJTua9eFHUfyIBj+s1K7JkZuaj8VV4/kOVVkIE
         C52yrJVhMqBmrxAPALnjRingGr5GtZKUjKfh+f8282VwPmwRHPBpPgxYw90Tt/z25u2H
         7wx4XSRpBkR4RzXHFkMS1bVtibMRP3HY/ShXC7FTKK+W5DJrKPsyWc2dnlgq/0OsH25L
         naE54wle5Avci6nuXjui19SpTgZ4Xuf/TAtrVyrXE/Gbtzp1HKkdsSrJGoN/sSGFKgeq
         DDEdngmX26cOVJwR80xpU+Y+XU+NFnK2xfoeG2QWQBto90tsXQeWFKGxnaj64ilEcNNO
         LKxw==
X-Gm-Message-State: AOAM530VH1tu8vTyPzafq/hjZxRK1xtr5EEcL9svOIQMLLho6DrKzo8H
        PGgjV9aveab2mOgql7CqMmTm0AzOBxZ95g9x5nk=
X-Google-Smtp-Source: ABdhPJzbxMwGRczCtMgGVtPjUOng/+WWIt5HsThydCPcsCnIbnkQNDSnhJiwIOiQ6RmM4ylYXSi2sjv3dDZMnORXQeE=
X-Received: by 2002:a17:906:6dd9:: with SMTP id j25mr23984185ejt.507.1618168060968;
 Sun, 11 Apr 2021 12:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net> <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com>
 <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com> <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
In-Reply-To: <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Sun, 11 Apr 2021 15:07:29 -0400
Message-ID: <CAJvTdK=RFei+b0W89ZTtqoiiR_M0wAJz_EuBTijgEHpacfZS7Q@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 9, 2021 at 5:44 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Apr 9, 2021 at 1:53 PM Len Brown <lenb@kernel.org> wrote:
> >
> > On Wed, Mar 31, 2021 at 6:45 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 3:28 PM Len Brown <lenb@kernel.org> wrote:
> > >
> > > > We added compiler annotation for user-level interrupt handlers.
> > > > I'm not aware of it failing, or otherwise being confused.
> > >
> > > I followed your link and found nothing. Can you elaborate?  In the
> > > kernel, we have noinstr, and gcc gives approximately no help toward
> > > catching problems.
> >
> > A search for the word "interrupt" on this page
> > https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#x86-Function-Attributes
> > comes to the description of this attribute:
> >
> > __attribute__ ((interrupt))
> >
>
> I read that and I see no mention of anything saying "this will
> generate code that does not touch extended state".  Instead I see,
> paraphrasing, "this will generate code with an ABI that is completely
> inappropriate for use in a user space signal handler".  Am I missing
> something?

Again...

An analogous annotation could be created for fast signals.
gcc can be told exactly what registers and instructions it can use for
that routine.

If somebody can suggest a way to make fast signal handers faster
than saving only the state that they-themselves actually use, I'm all ears.

> > > > dynamic XCR0 breaks the installed base, I thought we had established that.
> > >
> > > I don't think this is at all established.  If some code thinks it
> > > knows the uncompacted XSTATE size and XCR0 changes, it crashes.  This
> > > is not necessarily a showstopper.
> >
> > My working assumption is that crashing applications actually *is* a showstopper.
> > Please clarify.
>
> I think you're presuming that some program actually does this.  If no
> program does this, it's not an ABI break.

So you agree that for a program that uses xgetbv to read XCR0 and compute
XSTATE size for user-space use of XSAVE can break if XCR0 changes
during its lifetime.
But you don't believe such software exists?

> More relevantly, this can only happen in a process that uses XSAVE and
> thinks it knows the size that *also* does the prctl to change XCR0.
> By construction, existing programs can't break unless they load new
> dynamic libraries that break them.

Let's say that a program does math.
It calls a library to do that math.
It doesn't know or care what instructions the library uses to do math.
eg. the library uses SSE on an Atom, and uses AVX512 on a Xeon.

Who calls the new prctl, the program, or the library?

If it is the program, how does it know that the library wants to use
what instructions?

If it is the library, then you have just changed XCR0 at run-time and
you expose breakage of the thread library that has computed XSAVE size.

> > > > We've also established that when running in a VMM, every update to
> > > > XCR0 causes a VMEXIT.
> > >
> > > This is true, it sucks, and Intel could fix it going forward.
> >
> > What hardware fix do you suggest?
> > If a guest is permitted to set XCR0 bits without notifying the VMM,
> > what happens when it sets bits that the VMM doesn't know about?
>
> The VM could have a mask of allowed XCR0 bits that don't exist.
>
> TDX solved this problem *somehow* -- XSETBV doesn't (visibly?) exit on
> TDX.  Surely plain VMX could fix it too.

There are two cases.

1. Hardware that exists today and in the foreseeable future.

VM modification of XCR0 results in VMEXIT to VMM.
The VMM sees bits set by the guest, and so it can accept what
it supports, or send the VM a fault for non-support.

Here it is not possible for the VMM to change XCR0 without the VMM knowing.

2. Future Hardware that allows guests to write XCR0 w/o VMEXIT.

Not sure I follow your proposal.

Yes, the VM effectively has a mask of what is supported,
because it can issue CPUID.

The VMM virtualizes CPUID, and needs to know it must not
expose to the VM any state features it doesn't support.
Also, the VMM needs to audit XCR0 before it uses XSAVE,
else the guest could attack or crash the VMM through
buffer overrun.  Is this what you suggest?

If yes, what do you suggest in the years between now and when
that future hardware and VMM exist?

> > > > I thought the goal was to allow new programs to have fast signal handlers.
> > > > By default, those fast signal handlers would have a stable state
> > > > image, and would
> > > > not inherit large architectural state on their stacks, and could thus
> > > > have minimal overhead on all hardware.
> > >
> > > That is *a* goal, but not necessarily the only goal.
> >
> > I fully support coming up with a scheme for fast future-proof signal handlers,
> > and I'm willing to back that up by putting work into it.
> >
> > I don't see any other goals articulated in this thread.
>
> Before we get too carried away with *fast* signal handlers, something
> that works with existing programs is also a pretty strong goal.  RIght
> now AVX-512 breaks existing programs, even if they don't use AVX-512.

Re: "AVX-512 breaks existing programs, even if they don't use AVX-512"

Perhaps it would be useful to review how that breakage can happen,
recognize when it is a problem,  when it is not a problem, and what we
are doing to address it today.

The "ABI" here, is the signal.h definition of the MIN and SIG
stacksize to 2KB and 8KB
(on all architectures).  These hard coded constants may be used by
programs that choose
to manually allocate and register alternative signal stacks.

The signal delivery ABI we use today, where all x86 architecture state
is XSAVED onto
the signal stack will exceed 2KB when running on hardware that supports AVX-512.

This issue is real.  There do exist programs that use alternative stacks,
and of those, there do exist programs that use these constants, and if they
do take a signal on that size stack on that hardware, they do fail.

As evidenced that AVX-512 shipped several years ago, and the world didn't stop,
however, there are not a lot of programs with this exposure.
That said, adding 8KB to the architecture state on systems that support AMX/TMUL
makes this existing issue significantly more acute.

Glibc 2.34, to be released in July, re-defines these constants into
run-time values.
It uses CPUID to compute values that work, and so a program that uses this ABI
and is compiled with glibc 2.34 or later will not fail.

Further, Chang's kernel patch series does two important things.
First, it inspects the destination stack and computes the stack frame size
and it refuses to write onto a stack that will overflow.  We should have always
been making that check.

Second, it exports the kernel's notion of how big the signal stack needs to be
via the altvec, and glibc 2.34 picks this up and uses it in preference over
its own CPUID calculation, above.

So in a perfect world, you have AMX hardware, and the OS that supports your
AMX hardware has a kernel and glibc that support it.  Everything that comes
with that OS, or is built on that OS, uses that new library.
This mechanism similarly addresses the AVX-512 stack issue.

Granted, if you have an application that is statically linked and run
on new hardware
and new OS, it can still fail.

Granted, you have an application that creates small signal stacks
without using the ABI,
even a re-compile with the new library will not help it.

Granted, signal stacks -- whether they be normal or these alternative
signal stacks,
are bigger on hardware that has more hardware architecgture state.

But applications that use the ABI do not need to be modified.

I believe that this plan is sane.

I acknowledge that it doesn't address the desire for minimum size fast
signal handlers
that are minimal and fast on all hardware. I think we can address that
with a NEW ABI,
but not the old one.

thanks,
Len Brown, Intel Open Source Technology Center





-- 
Len Brown, Intel Open Source Technology Center
