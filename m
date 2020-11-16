Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDB2B441A
	for <lists+linux-api@lfdr.de>; Mon, 16 Nov 2020 13:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgKPM5S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 07:57:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgKPM5S (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Nov 2020 07:57:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4239101E;
        Mon, 16 Nov 2020 04:57:17 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DAF23F70D;
        Mon, 16 Nov 2020 04:57:15 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:57:11 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
Message-ID: <20201116125709.GV6882@arm.com>
References: <20201114014132.2439310-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114014132.2439310-1-pcc@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 13, 2020 at 05:41:32PM -0800, Peter Collingbourne wrote:
> ---
> These features are implemented in this patch series:
>   https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
> which is still under review, so the patch should not be applied
> yet.

Good to see this -- I was vaguely intending to write something when the
patch landed, so this saves me a job :)

>  man2/sigaction.2 | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/man2/sigaction.2 b/man2/sigaction.2
> index 6a8142324..82fb69e26 100644
> --- a/man2/sigaction.2
> +++ b/man2/sigaction.2
> @@ -250,6 +250,19 @@ This flag is meaningful only when establishing a signal handler.
>  .\" .I sa_sigaction
>  .\" field was added in Linux 2.1.86.)
>  .\"
> +.TP
> +.BR SA_UNSUPPORTED " (since Linux 5.x)"
> +This flag bit will never be supported by the kernel. It is used as
> +part of the flag support detection protocol described below.

It is supported, just with a special behaviour that only affects the
sa_flags field of oact.

It's also a bit wried to say that SA_UNSUPPORTED is supported "since some
specific version of Linux."  If we define the special behaviour for this
flag as "being supported", then saying "since Linux 5.x" just works
naturally.

Can we make a concise statement here about what the flag does and how to
use it?

It's preferable not to bury specification details in wordy rationale
sections unless there's really no way to describe the behaviour
concisely.

Maybe: --8<--

Check for extended sa_flags support.

If the attempt to register a handler with this flag set in
act->sa_flags succeeds, and an immediately subsequent sigaction() call
specifying the same signal number n and with non-NULL oact yields
SA_UNSUPPORTED
.I clear
in oact->sa_flags, then extended sa_flags are supported.

If the handler registration attempt fails, or if the subsequent
sigaction() call yields SA_UNSUPPORTED
.I set
in oact->sa_flags, then the caller must not assume that extended
sa_flags are supported.

-->8--

Also, would it be a good idea to add something like the following?

--8<--

This flag may be specified alongside extended sa_flags whose meaning
depends on the result of the check.  Since the behaviour of the signal
handler cannot be guaranteed unless the check passes, it is wise to
block the affected signal while registering the handler and performing
the check in this case.

-->8--


Also, can we reference the "Detecting flag support in sa_flags" by name?
It may be hard for people to find otherwise...


> +.TP
> +.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"

Shouldn't we mention the probe requirement here?

--8<--

Requires extended sa_flags support; otherwise, the effect of this flag
is unpecified.  See <section> [or SA_UNSUPPORTED if we think that's the
more concise description to refer to] for details.  

-->8--

> +Normally, when delivering a signal, an architecture-specific
> +set of tag bits are cleared from the

Maybe "address tag bits", to make it clearer which bits we're talking
about.  (But you're about to mention si_addr anyway, so perhaps this
clarification is redundant.)

> +.I si_addr
> +field of
> +.IR siginfo_t .
> +If this flag is set, the tag bits will be preserved in

Should we say "any available tag bits" or "an architecture-specific
subset of the tag bits" or similar?

This would cover us for the case where some arch can't always provide
them all (which I think is the case for MTE on arm64? ... but my memory
is hazy).

> +.IR si_addr .
>  .SS The siginfo_t argument to a SA_SIGINFO handler
>  When the
>  .B SA_SIGINFO
> @@ -833,6 +846,55 @@ Triggered by a
>  .BR seccomp (2)
>  filter rule.
>  .RE
> +.SS Detecting flag support in sa_flags

(Could be renamed to "Extended sa_flags support" if we want to be more
concise.)

> +The Linux kernel supports a mechanism for programs to detect kernel
> +support for
> +.B SA_*
> +flags in
> +.IR sa_flags .
> +This mechanism is quite subtle for backwards compatibility reasons
> +related to the historical behavior of the kernel.

Can we avoid the word "subtle"?  To me, this suggests a euphemism for
"doesn't work reliably", or "nobody knows whether it works".

Being more explicit about the actual reason for this design might help,
since the reason is actually fairly simple.  Maybe:

--8<--

Historically, the sigaction(2) call on Linux accepted unknown bits set
in act->sa_flags without error, and a second sigaction() call would
typically leave those bits set in oact->sa_flags.

This means that support for new flags cannot be detected simply by
setting a flag in sa_flags.

-->8--


> +
> +Starting with Linux 5.x, the kernel will clear any unrecognized bits
> +from the
> +.I sa_flags
> +value returned via
> +.I oldact
> +if those bits were set when the signal handler was originally installed.
> +Therefore, a program that only needs to be compatible with Linux 5.x
> +and above may test for flag bit support by issuing a second call to
> +.BR sigaction ()
> +and testing whether the bit remains set in
> +.IR oldact.sa_flags .
> +
> +Prior to Linux 5.x, unrecognized flag bits were preserved in
> +.I oldact.sa_flags
> +so this protocol on its own would not be sufficient to allow a
> +userspace program to test for flag bit support if it needs to be
> +compatible with kernel versions older than 5.x. Therefore, the
> +.B SA_UNSUPPORTED
> +flag bit was defined, which the kernel will always consider to be
> +unknown. A userspace program that sets this flag bit in
> +.I act.sa_flags
> +and finds that it has been cleared in
> +.I oldact.sa_flags
> +in a subsequent call to
> +.BR sigaction ()
> +may trust that any other unknown flag bits have been cleared.

Is this a bit too much rationale?  I don't think we have to justify the
choice of design here -- describing the design and hinting at the reason
for it seems enough.

If you go with my suggestions for the SA_UNSUPPORTED section, then we
can probably thin out some duplicate details here.

> +
> +A reasonably modern program may trust that the flags

What does "reasonably modern" mean?

> +.BR SA_NOCLDSTOP ,
> +.BR SA_NOCLDWAIT ,
> +.BR SA_SIGINFO ,
> +.BR SA_ONSTACK ,
> +.BR SA_RESTART ,
> +.BR SA_NODEFER ,
> +.B SA_RESETHAND
> +and, if defined by the architecture,
> +.B SA_RESTORER
> +are supported by the kernel, without relying on the flag bit support
> +detection protocol, since these flags have all been supported
> +since Linux 2.6.

I think it's best just to leave these unspecified, as today.  Software
seems to get on just fine without SA_UNSUPPORTED for these.


Also, can we have a code example here?  The description may leave people
scratching their heads a bit, so I think a basic implementation would
help.

[...]

Cheers
---Dave
