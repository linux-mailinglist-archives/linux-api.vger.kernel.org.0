Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE22B0B32
	for <lists+linux-api@lfdr.de>; Thu, 12 Nov 2020 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgKLRVj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 12:21:39 -0500
Received: from foss.arm.com ([217.140.110.172]:54626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgKLRVj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Nov 2020 12:21:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5CCC139F;
        Thu, 12 Nov 2020 09:21:38 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B203F73C;
        Thu, 12 Nov 2020 09:21:36 -0800 (PST)
Date:   Thu, 12 Nov 2020 17:21:33 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v14 7/8] signal: define the field siginfo.si_faultflags
Message-ID: <20201112172130.GT6882@arm.com>
References: <cover.1604523707.git.pcc@google.com>
 <0eb601a5d1906fadd7099149eb605181911cfc04.1604523707.git.pcc@google.com>
 <87zh3qug6q.fsf@x220.int.ebiederm.org>
 <20201111172703.GP6882@arm.com>
 <87imabr6p8.fsf@x220.int.ebiederm.org>
 <87sg9fprih.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg9fprih.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 11, 2020 at 02:28:38PM -0600, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Dave Martin <Dave.Martin@arm.com> writes:
> >
> >> On Mon, Nov 09, 2020 at 07:57:33PM -0600, Eric W. Biederman wrote:
> >>> Peter Collingbourne <pcc@google.com> writes:
> >>> 
> >>> > This field will contain flags that may be used by signal handlers to
> >>> > determine whether other fields in the _sigfault portion of siginfo are
> >>> > valid. An example use case is the following patch, which introduces
> >>> > the si_addr_tag_bits{,_mask} fields.
> >>> >
> >>> > A new sigcontext flag, SA_FAULTFLAGS, is introduced in order to allow
> >>> > a signal handler to require the kernel to set the field (but note
> >>> > that the field will be set anyway if the kernel supports the flag,
> >>> > regardless of its value). In combination with the previous patches,
> >>> > this allows a userspace program to determine whether the kernel will
> >>> > set the field.
> >>> >
> >>> > It is possible for an si_faultflags-unaware program to cause a signal
> >>> > handler in an si_faultflags-aware program to be called with a provided
> >>> > siginfo data structure by using one of the following syscalls:
> >>> >
> >>> > - ptrace(PTRACE_SETSIGINFO)
> >>> > - pidfd_send_signal
> >>> > - rt_sigqueueinfo
> >>> > - rt_tgsigqueueinfo
> >>> >
> >>> > So we need to prevent the si_faultflags-unaware program from causing an
> >>> > uninitialized read of si_faultflags in the si_faultflags-aware program when
> >>> > it uses one of these syscalls.
> >>> >
> >>> > The last three cases can be handled by observing that each of these
> >>> > syscalls fails if si_code >= 0. We also observe that kill(2) and
> >>> > tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
> >>> > so we define si_faultflags to only be valid if si_code > 0.
> >>> >
> >>> > There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
> >>> > we make ptrace(PTRACE_SETSIGINFO) clear the si_faultflags field if it
> >>> > detects that the signal would use the _sigfault layout, and introduce
> >>> > a new ptrace request type, PTRACE_SETSIGINFO2, that a si_faultflags-aware
> >>> > program may use to opt out of this behavior.
> >>> 
> >>> So I think while well intentioned this is misguided.
> >>> 
> >>> gdb and the like may use this but I expect the primary user is CRIU
> >>> which simply reads the signal out of one process saves it on disk
> >>> and then restores the signal as read into the new process (possibly
> >>> on a different machine).
> >>> 
> >>> At least for the CRIU usage PTRACE_SETSIGINFO need to remain a raw
> >>> pass through kind of operation.
> >>
> >> This is a problem, though.
> >>
> >> How can we tell the difference between a siginfo that was generated by
> >> the kernel and a siginfo that was generated (or altered) by a non-xflags
> >> aware userspace?
> >>
> >> Short of revving the whole API, I don't see a simple solution to this.
> >
> > Unlike receiving a signal.  We do know that userspace old and new
> > always sends unused fields as zero into PTRACE_SETSIGINFO.
> >
> > The split into kernel_siginfo verifies this and fails userspace if it
> > does something different.  No problems have been reported.
> >
> > So in the case of xflags a non-xflags aware userspace would either pass
> > the siginfo from through from somewhere else (such as
> > PTRACE_GETSIGINFO), or it would simply generate a signal with all of
> > the xflags bits clear.  So everything should work regardless.
> >
> >> Although a bit of a hack, could we include some kind of checksum in the
> >> siginfo?  If the checksum matches during PTRACE_SETSIGINFO, we could
> >> accept the whole thing; xflags included.  Otherwise, we could silently
> >> drop non-self-describing extensions.
> >>
> >> If we only need to generate the checksum when PTRACE_GETSIGINFO is
> >> called then it might be feasible to use a strong hash; otherwise, this
> >> mechanism will be far from bulletproof.
> >>
> >> A hash has the advantage that we don't need any other information
> >> to validate it beyond a salt: if the hash matches, it's self-
> >> validating.  We could also package other data with it to describe the
> >> presence of extensions, but relying on this for regular sigaction()/
> >> signal delivery use feels too high-overhead.
> >>
> >> For debuggers, I suspect that PTRACE_SETSIGINFO2 is still useful:
> >> userspace callers that want to write an extension field that they
> >> knowingly generated themselves should have a way to express that.
> >>
> >> Thoughts?
> >
> > I think there are two cases:
> > 1) CRIU  -- It is just a passthrough of PTRACE_GETSIGINFO
> > 2) Creating a signal from nowhere -- Code that does not know about
> >    xflags would leave xflags at 0 so no problem.
> >
> > Does anyone see any other cases I am missing?
> >
> 
> Zoinks.  I forgot to read and double check the code I wrote.
> 
> copy_siginfo_from_user only verifies against 0 when we don't know the
> layout.  So I don't know if we can count on userspace providing the
> extra data as 0 or not.
> 
> So if we do indeed continue to need xflags we might care.
>
> It is currently an undefined non-sense case to provide non-zero fields
> there.  So I think it is reasonable to expect even debuggers generating
> signals to set those fields to know values such as 0.

You may well be right that the only time extra fields coming from
userspace should be deliberately nonzero is in the passthrough case.

I'm still concerned about padding or type-punning issues causing
unallocated fields to be initialised with junk, even in the presence of
a memset(0).  I haven't actually seen this happen, but the language
standards seem to allow it and compilers may get more aggressive in the
future.

This is why I think we still want an explicit way for userspace to
indicate what extension fields initialised.

Am I missing something that eliminates the danger today?

> Further I expect it is rare for debuggers to generate pretend faults.

That seems a reasonable assumption.  Hand-rolling a fault siginfo seems
a pretty fragile thing to do, if it works reliably at all.

> So I would say perform whatever testing we can, so that there are no
> obvious problem users of PTRACE_SETSIGINFO and then to simply not worry
> about the PTRACE_SETSIGINFO unless someone reports a regression.
> 
> But fist let's see if we really need xflags at all.
> 
> Eric

Ack

Cheers
---Dave
