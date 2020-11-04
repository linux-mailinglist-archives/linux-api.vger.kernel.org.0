Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66B72A6C9D
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKDSX0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 13:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKDSX0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Nov 2020 13:23:26 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF02206BE;
        Wed,  4 Nov 2020 18:23:21 +0000 (UTC)
Date:   Wed, 4 Nov 2020 18:23:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
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
Subject: Re: [PATCH v13 7/8] signal: define the field siginfo.si_faultflags
Message-ID: <20201104182318.GH28902@gaia>
References: <cover.1604376407.git.pcc@google.com>
 <743fef80a8617378027d5d2b0538cfc36ea106a1.1604376407.git.pcc@google.com>
 <20201103175352.GA22573@gaia>
 <CAMn1gO71zhxp692t6GKCRazNb-cF45OcdUSUjavzHZUki6VpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO71zhxp692t6GKCRazNb-cF45OcdUSUjavzHZUki6VpiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 03, 2020 at 10:39:52AM -0800, Peter Collingbourne wrote:
> On Tue, Nov 3, 2020 at 9:54 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Nov 02, 2020 at 08:09:43PM -0800, Peter Collingbourne wrote:
> > > This field will contain flags that may be used by signal handlers to
> > > determine whether other fields in the _sigfault portion of siginfo are
> > > valid. An example use case is the following patch, which introduces
> > > the si_addr_tag_bits{,_mask} fields.
> > >
> > > A new sigcontext flag, SA_FAULTFLAGS, is introduced in order to allow
> > > a signal handler to require the kernel to set the field (but note
> > > that the field will be set anyway if the kernel supports the flag,
> > > regardless of its value). In combination with the previous patches,
> > > this allows a userspace program to determine whether the kernel will
> > > set the field.
> >
> > As per patch 5, a user is supposed to call sigaction() twice to figure
> > out whether _faultflags is meaningful. That's the part I'm not
> > particularly fond of. Are the unused parts of siginfo always zeroed when
> > the kernel delivers a signal? If yes, we could simply check the new
> > field for non-zero bits.
> 
> The unused parts of siginfo are zeroed in current kernels, but
> unfortunately not in older kernels. The zeroing behavior was
> introduced in commit c999b933faa5e281e3af2e110eccaf91698b0a81 which
> first appeared in kernel version 4.18, and at least in Android land we
> do need to support kernel versions older than that.

I see. I was hoping for an easy way out.

Now, with always populating the si_faultflags field, you are going back
to writing non-zero stuff in siginfo for unaware apps. I don't think
that's an issue (the alternative is to only write it of SA_FAULTFLAGS
was set).

Yet another option would be to pass a new AT_ZEROED_SI via AT_FLAGS (we
don't use them for anything) so that the user can infer whether
si_faultflags has meaningful information without two sigaction() calls.

> > > It is possible for an si_faultflags-unaware program to cause a signal
> > > handler in an si_faultflags-aware program to be called with a provided
> > > siginfo data structure by using one of the following syscalls:
> > >
> > > - ptrace(PTRACE_SETSIGINFO)
> > > - pidfd_send_signal
> > > - rt_sigqueueinfo
> > > - rt_tgsigqueueinfo
> > >
> > > So we need to prevent the si_faultflags-unaware program from causing an
> > > uninitialized read of si_faultflags in the si_faultflags-aware program when
> > > it uses one of these syscalls.
> > >
> > > The last three cases can be handled by observing that each of these
> > > syscalls fails if si_code >= 0. We also observe that kill(2) and
> > > tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
> > > so we define si_faultflags to only be valid if si_code > 0.
> > >
> > > There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
> > > we make ptrace(PTRACE_SETSIGINFO) clear the si_faultflags field if it
> > > detects that the signal would use the _sigfault layout, and introduce
> > > a new ptrace request type, PTRACE_SETSIGINFO2, that a si_faultflags-aware
> > > program may use to opt out of this behavior.
> >
> > I find this pretty fragile but maybe I have to read it a few more times
> > to fully understand the implications ;).
> >
> > Could we instead copy all the fields, potentially uninitialised, and
> > instead filter them when delivering the signal based on the
> > SA_FAULTFLAGS? That means that the kernel only writes si_faultflags if
> > the user requested it.
> 
> I don't see how that would help. The goal is to protect new signal
> handlers from old signal "injectors" that will have potentially
> uninitialized data where the si_faultflags field is. The new signal
> handler will have SA_FAULTFLAGS set so that wouldn't prevent the
> signal handler from seeing the uninitialized data.

You are right, it doesn't help if the handler will have set
SA_FAULTFLAGS.

> > > v12:
> > > - Change type of si_xflags to u32 to avoid increasing alignment
> > [...]
> > > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > > index 7aacf9389010..f43778355b77 100644
> > > --- a/include/uapi/asm-generic/siginfo.h
> > > +++ b/include/uapi/asm-generic/siginfo.h
> > > @@ -91,7 +91,9 @@ union __sifields {
> > >                               char _dummy_pkey[__ADDR_BND_PKEY_PAD];
> > >                               __u32 _pkey;
> > >                       } _addr_pkey;
> > > +                     void *_pad[6];
> > >               };
> > > +             __u32 _faultflags;
> > >  } _sigfault;
> >
> > Sorry, I haven't checked the previous discussion on alignment here but
> > don't we already require 64-bit alignment because of other members in
> > the _sigfault union? We already have void * throughout this and with the
> > next patch we just have a gap (unless I miscalculated the offsets).
> 
> This is about avoiding increasing alignment on 32-bit platforms.
> Currently the alignment is 4 but a u64 field would bump it to 8.
> 
> Unfortunately we can't do much about the gap on 64-bit platforms. This
> was previously a uintptr_t but that would mean that the upper 32 bits
> cannot be used safely on all platforms so we would effectively end up
> with a gap anyway.

We could add a dummy pad on 64-bit. BTW, the tags only make sense on
64-bit hardware, 32-bit doesn't have enough room.

-- 
Catalin
