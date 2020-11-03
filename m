Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF4D2A446F
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 12:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgKCLoP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 06:44:15 -0500
Received: from foss.arm.com ([217.140.110.172]:47464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgKCLoO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Nov 2020 06:44:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98CE1101E;
        Tue,  3 Nov 2020 03:44:13 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C1B63F66E;
        Tue,  3 Nov 2020 03:44:11 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:44:08 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Helge Deller <deller@gmx.de>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        David Spickett <david.spickett@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH v12 7/8] signal: define the field siginfo.si_xflags
Message-ID: <20201103114407.GK6882@arm.com>
References: <cover.1602892799.git.pcc@google.com>
 <7cc72abf960871135bc6e7fb11c8fc747401957b.1602892799.git.pcc@google.com>
 <20201102173751.GE6882@arm.com>
 <CAMn1gO4TogDpYHvZpZkGN01brcOviGHDDvbe-RRxDfBPV-GSEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO4TogDpYHvZpZkGN01brcOviGHDDvbe-RRxDfBPV-GSEA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 02, 2020 at 08:10:57PM -0800, Peter Collingbourne wrote:
> On Mon, Nov 2, 2020 at 9:38 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 05:12:32PM -0700, Peter Collingbourne wrote:
> > > This field will contain flags that may be used by signal handlers to
> > > determine whether other fields in the _sigfault portion of siginfo are
> > > valid. An example use case is the following patch, which introduces
> > > the si_addr_tag_bits{,_mask} fields.
> > >
> > > A new sigcontext flag, SA_XFLAGS, is introduced in order to allow
> > > a signal handler to require the kernel to set the field (but note
> > > that the field will be set anyway if the kernel supports the flag,
> > > regardless of its value). In combination with the previous patches,
> > > this allows a userspace program to determine whether the kernel will
> > > set the field.
> >
> > Apologies for this coming rather late:
> >
> > It occurs to me that we might want a more specific name, since this only
> > applies to fault signals -- say, SA_FAULTFLAGS.
> >
> > If we end up wanting to add flags fields for other signal types, then we
> > might end up needing a SA_ flag for each, which would be a bit annoying.
> >
> > So, alternatively. I wonder whether it's worth preemptively adding an
> > extra flags to every kind of kernel-generated siginfo.  If so, then
> > having a single SA_XFLAGS would be fine.
> >
> >
> > If added flags fields all over the place is considered overkill, then I
> > guess it's sufficient to rename this flag.
> >
> > If renaming, the actual flags field in siginfo should also be renamed to
> > match.
> 
> I'd prefer not to add flags fields to every union member at this
> point. I agree that faultflags is a better name, and I guess it's one
> more reason not to try and reuse the ia64 field. Renamed in v13.

Ack -- I thought I should make the point, but we've got enough spare
sa_flags bits for now to make this one SIL_FAULT-specific, providing the
SA_foo name looks equally specific -- so just renaming that should be OK.

If we end up adding a flags field to another siginfo union member in the
future, it's probably worth adding all the rest at the same time ... but
it may never happen.

[...]

> > > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > > index 43d6179508d6..85b5b4e38661 100644
> > > --- a/kernel/ptrace.c
> > > +++ b/kernel/ptrace.c
> > > @@ -687,18 +687,32 @@ static int ptrace_getsiginfo(struct task_struct *child, kernel_siginfo_t *info)
> > >       return error;
> > >  }
> > >
> > > -static int ptrace_setsiginfo(struct task_struct *child, const kernel_siginfo_t *info)
> > > +static int ptrace_setsiginfo(struct task_struct *child, unsigned long flags,
> > > +                          kernel_siginfo_t *info)
> > >  {
> > > -     unsigned long flags;
> > > +     unsigned long lock_flags;
> > >       int error = -ESRCH;
> > >
> > > -     if (lock_task_sighand(child, &flags)) {
> > > +     if (flags & ~PTRACE_SIGINFO_XFLAGS) {
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     /*
> > > +      * If the caller is unaware of si_xflags and we're using a layout that
> > > +      * requires it, set it to 0 which means "no fields are available".
> > > +      */
> > > +     if (!(flags & PTRACE_SIGINFO_XFLAGS) &&
> > > +         siginfo_layout_is_fault(
> > > +                 siginfo_layout(info->si_signo, info->si_code)))
> > > +             info->si_xflags = 0;
> > > +
> > > +     if (lock_task_sighand(child, &lock_flags)) {
> > >               error = -EINVAL;
> > >               if (likely(child->last_siginfo != NULL)) {
> > >                       copy_siginfo(child->last_siginfo, info);
> > >                       error = 0;
> > >               }
> > > -             unlock_task_sighand(child, &flags);
> > > +             unlock_task_sighand(child, &lock_flags);
> > >       }
> > >       return error;
> > >  }
> > > @@ -1038,9 +1052,12 @@ int ptrace_request(struct task_struct *child, long request,
> > >               break;
> > >
> > >       case PTRACE_SETSIGINFO:
> > > +             addr = 0;
> >
> > If this is intended to fall through, please add a
> >
> >                 /* fall through */
> >
> > comment here (newer GCC has warnings to catch this; not sure about
> > clang, but I'd be surprised if no version warns).
> 
> Yes, clang has this warning, but it looks like it is currently
> disabled in clang due to differences between the compilers [1] so I
> didn't see it.
> 
> It looks like the kernel is moving towards using the fallthrough
> macro/attribute defined in include/linux/compiler_attributes.h (and to
> me this personally seems better than relying on parsing comments), so
> I've used that macro in v13.

Ah, I wasn't aware of that.  Sounds better!

Cheers
---Dave
