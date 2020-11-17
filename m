Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD522B72B0
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKQXwf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 18:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKQXwf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 18:52:35 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A82C0613CF
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 15:52:35 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id m9so60397iox.10
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 15:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gk1CMu3dtFst57e5bJf5rsNpJ7gvtB9mEDWZEDCN6ko=;
        b=MbgcJf7gS5AZJIWTUiEzNxurPub3nIfRbGt89vIT6m1hchqMWtHCztShdcJBKw9frB
         agsBq1H05UCxG/qa9REarQ6DF/nvYQUaHYJzqw474thcJogcG99D7SOn928wD8JGnNXN
         axlEZRKIdz6NovwkqM04CUJbGJUTT4fzmKtew+IAE7OkmHvizReMS0gosjK0iF4SuyyP
         GsVJm8hnClXpNnSRHZOoQa3MMJKaOxWVZuUbRWlXMOBqthBnZ6p84JrhfoRX4imS0imh
         8zz3NkinYFtw0JvtUFGRsPKWdxxXnFiaotN2x/c559qb6w1yC3cWyW6ALwGhB+Os4uoM
         jYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk1CMu3dtFst57e5bJf5rsNpJ7gvtB9mEDWZEDCN6ko=;
        b=dqZqhm80D0ZpOH2tt6lOVYUn9sCv29QFYmmtrCA8SNqtx5zgUlGjZp9JlGqrkoI0ba
         xj7HcGDZPqtvFWGCFN4lxnm0cqZX7TSIwc9kIrXzjnOZC8/pwylftpfG1vIuZwnqS8fv
         D/wmxcZNFLiHG6aUAf6O+SnT5LlAf9fRbS4MF218CvMtJ81c706gn1GrAfkH8SQk7Qdd
         qR9s/xkCgQNb2N24Dkm2qHVY8X8wcJFMRQIC3SavacucTMK3+nTHdFsy1x1wJmdN6IOD
         d8aqd32qGpZPhrO/0M64bARkjhU7zRYH6V+9REzKc2AU78Vnk7fEL8FiIltx3kj/FOk1
         JrIQ==
X-Gm-Message-State: AOAM530taK0m5USkjhVBGdZQgfeKw5Oeey0B4MTH47tYcZSHI2a75AYG
        LDDiyMxVyRHs2/16gxRvkh0a1z9KfNvob0AiD4wuiIuHh9bhrYpbyVM=
X-Google-Smtp-Source: ABdhPJwqwjfOLJCu4GWXfntJzb3c+bRxVFmS5CkSM4EicmFs724+CmgiYRiH9n3bTui4yZzgVvkHWxZfH7iFKDxkrqA=
X-Received: by 2002:a05:6638:1035:: with SMTP id n21mr5768577jan.107.1605657154127;
 Tue, 17 Nov 2020 15:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20201114014132.2439310-1-pcc@google.com> <20201116125709.GV6882@arm.com>
In-Reply-To: <20201116125709.GV6882@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 17 Nov 2020 15:52:23 -0800
Message-ID: <CAMn1gO7-bfs+srjxG7Jxk7yq1C1iTar0tEb8TJV9giLOOdr=fA@mail.gmail.com>
Subject: Re: [PATCH] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
To:     Dave Martin <Dave.Martin@arm.com>
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
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 16, 2020 at 4:57 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Fri, Nov 13, 2020 at 05:41:32PM -0800, Peter Collingbourne wrote:
> > ---
> > These features are implemented in this patch series:
> >   https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
> > which is still under review, so the patch should not be applied
> > yet.
>
> Good to see this -- I was vaguely intending to write something when the
> patch landed, so this saves me a job :)
>
> >  man2/sigaction.2 | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >
> > diff --git a/man2/sigaction.2 b/man2/sigaction.2
> > index 6a8142324..82fb69e26 100644
> > --- a/man2/sigaction.2
> > +++ b/man2/sigaction.2
> > @@ -250,6 +250,19 @@ This flag is meaningful only when establishing a signal handler.
> >  .\" .I sa_sigaction
> >  .\" field was added in Linux 2.1.86.)
> >  .\"
> > +.TP
> > +.BR SA_UNSUPPORTED " (since Linux 5.x)"
> > +This flag bit will never be supported by the kernel. It is used as
> > +part of the flag support detection protocol described below.
>
> It is supported, just with a special behaviour that only affects the
> sa_flags field of oact.
>
> It's also a bit wried to say that SA_UNSUPPORTED is supported "since some
> specific version of Linux."  If we define the special behaviour for this
> flag as "being supported", then saying "since Linux 5.x" just works
> naturally.

If we define SA_UNSUPPORTED using something like the language that you
suggest below, maybe we can retroactively consider SA_UNSUPPORTED to
have been supported since the beginning of time, so we don't need a
"since" clause here.

> Can we make a concise statement here about what the flag does and how to
> use it?
>
> It's preferable not to bury specification details in wordy rationale
> sections unless there's really no way to describe the behaviour
> concisely.
>
> Maybe: --8<--
>
> Check for extended sa_flags support.
>
> If the attempt to register a handler with this flag set in
> act->sa_flags succeeds, and an immediately subsequent sigaction() call
> specifying the same signal number n and with non-NULL oact yields
> SA_UNSUPPORTED
> .I clear
> in oact->sa_flags, then extended sa_flags are supported.
>
> If the handler registration attempt fails, or if the subsequent
> sigaction() call yields SA_UNSUPPORTED
> .I set
> in oact->sa_flags, then the caller must not assume that extended
> sa_flags are supported.
>
> -->8--

I'm not sure about saying "extended sa_flags are supported" here since
it could be read to mean that all of the extended sa_flags are
supported, which won't be accurate if we add a new sa_flag in the
future for example (but I'm not sure that we should talk about
'extended sa_flags" anyway, see below).

I would just say that what this flag allows you to do is dynamically
probe for flag bit support. I've taken your wording, tried to make it
more concise and inserted it here.

> Also, would it be a good idea to add something like the following?
>
> --8<--
>
> This flag may be specified alongside extended sa_flags whose meaning
> depends on the result of the check.  Since the behaviour of the signal
> handler cannot be guaranteed unless the check passes, it is wise to
> block the affected signal while registering the handler and performing
> the check in this case.
>
> -->8--

That would be good to mention in the "Dynamically probing for flag bit
support" section, so I've done it. The language needed to be adjusted
because you can't always block a synchronous signal such as SIGSEGV,
so I recommend issuing the second sigaction in the signal handler
itself in that case.

>
>
> Also, can we reference the "Detecting flag support in sa_flags" by name?
> It may be hard for people to find otherwise...

Done.

>
>
> > +.TP
> > +.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
>
> Shouldn't we mention the probe requirement here?
>
> --8<--
>
> Requires extended sa_flags support; otherwise, the effect of this flag
> is unpecified.  See <section> [or SA_UNSUPPORTED if we think that's the
> more concise description to refer to] for details.

I wouldn't say "unspecified" here. In non-supporting kernels, the
behavior is as if the flag is not set, and I've documented it in the
"Dynamically probing for flag bit support" section.

I'd probably leave this part as short as possible (just a reference to
SA_UNSUPPORTED) because it will be copy-pasted into the description of
any new flags.

>
> -->8--
>
> > +Normally, when delivering a signal, an architecture-specific
> > +set of tag bits are cleared from the
>
> Maybe "address tag bits", to make it clearer which bits we're talking
> about.  (But you're about to mention si_addr anyway, so perhaps this
> clarification is redundant.)

I think it's redundant, so I prefer to leave it as is.

> > +.I si_addr
> > +field of
> > +.IR siginfo_t .
> > +If this flag is set, the tag bits will be preserved in
>
> Should we say "any available tag bits" or "an architecture-specific
> subset of the tag bits" or similar?
>
> This would cover us for the case where some arch can't always provide
> them all (which I think is the case for MTE on arm64? ... but my memory
> is hazy).

Right, SIGSEGV/SEGV_MTESERR is the case where we don't have all the
bits. I updated this to say that it's architecture specific.

> > +.IR si_addr .
> >  .SS The siginfo_t argument to a SA_SIGINFO handler
> >  When the
> >  .B SA_SIGINFO
> > @@ -833,6 +846,55 @@ Triggered by a
> >  .BR seccomp (2)
> >  filter rule.
> >  .RE
> > +.SS Detecting flag support in sa_flags
>
> (Could be renamed to "Extended sa_flags support" if we want to be more
> concise.)

I'm not sure about calling these "extended sa_flags". Maybe in 10
years from now, some programs will be able to rely on
SA_EXPOSE_TAGBITS being supported, so from that perspective it would
be the same as any other flag and not really an "extended" flag.

> > +The Linux kernel supports a mechanism for programs to detect kernel
> > +support for
> > +.B SA_*
> > +flags in
> > +.IR sa_flags .
> > +This mechanism is quite subtle for backwards compatibility reasons
> > +related to the historical behavior of the kernel.
>
> Can we avoid the word "subtle"?  To me, this suggests a euphemism for
> "doesn't work reliably", or "nobody knows whether it works".

Okay, I removed this part.

> Being more explicit about the actual reason for this design might help,
> since the reason is actually fairly simple.  Maybe:
>
> --8<--
>
> Historically, the sigaction(2) call on Linux accepted unknown bits set
> in act->sa_flags without error, and a second sigaction() call would
> typically leave those bits set in oact->sa_flags.
>
> This means that support for new flags cannot be detected simply by
> setting a flag in sa_flags.
>
> -->8--

Yes, something like this would work. I reworded it to describe the old
and new behavior in the same paragraph.

>
> > +
> > +Starting with Linux 5.x, the kernel will clear any unrecognized bits
> > +from the
> > +.I sa_flags
> > +value returned via
> > +.I oldact
> > +if those bits were set when the signal handler was originally installed.
> > +Therefore, a program that only needs to be compatible with Linux 5.x
> > +and above may test for flag bit support by issuing a second call to
> > +.BR sigaction ()
> > +and testing whether the bit remains set in
> > +.IR oldact.sa_flags .
> > +
> > +Prior to Linux 5.x, unrecognized flag bits were preserved in
> > +.I oldact.sa_flags
> > +so this protocol on its own would not be sufficient to allow a
> > +userspace program to test for flag bit support if it needs to be
> > +compatible with kernel versions older than 5.x. Therefore, the
> > +.B SA_UNSUPPORTED
> > +flag bit was defined, which the kernel will always consider to be
> > +unknown. A userspace program that sets this flag bit in
> > +.I act.sa_flags
> > +and finds that it has been cleared in
> > +.I oldact.sa_flags
> > +in a subsequent call to
> > +.BR sigaction ()
> > +may trust that any other unknown flag bits have been cleared.
>
> Is this a bit too much rationale?  I don't think we have to justify the
> choice of design here -- describing the design and hinting at the reason
> for it seems enough.
>
> If you go with my suggestions for the SA_UNSUPPORTED section, then we
> can probably thin out some duplicate details here.

Okay, I removed most of this.

> > +
> > +A reasonably modern program may trust that the flags
>
> What does "reasonably modern" mean?

By this I meant a program that may assume that it is running on Linux
2.6 or above. I will drop the "reasonably modern" part and say "in
general, programs may assume support".

> > +.BR SA_NOCLDSTOP ,
> > +.BR SA_NOCLDWAIT ,
> > +.BR SA_SIGINFO ,
> > +.BR SA_ONSTACK ,
> > +.BR SA_RESTART ,
> > +.BR SA_NODEFER ,
> > +.B SA_RESETHAND
> > +and, if defined by the architecture,
> > +.B SA_RESTORER
> > +are supported by the kernel, without relying on the flag bit support
> > +detection protocol, since these flags have all been supported
> > +since Linux 2.6.
>
> I think it's best just to leave these unspecified, as today.  Software
> seems to get on just fine without SA_UNSUPPORTED for these.

It's probably not useful to document this from the perspective of "you
don't need to probe for these", but I think we should say something
about these flags, since the new documentation may otherwise mislead
developers into thinking that they might want to probe for the old
flags (either because they don't think the flags are that old or just
out of a desire to follow best practices) which would give them the
wrong answer on old kernels, which they may never notice if the kernel
on their machine is new enough. I've reworded to document from the
perspective of "you can't reliably probe for these", and only then say
that you don't normally need to probe for them.

> Also, can we have a code example here?  The description may leave people
> scratching their heads a bit, so I think a basic implementation would
> help.

That seems like a good idea. I've added one.

Peter
