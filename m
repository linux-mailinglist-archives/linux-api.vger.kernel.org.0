Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6585C2B57D3
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgKQDYU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 22:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgKQDYU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 22:24:20 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD98C0613CF
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:24:19 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id x11so10290681vsx.12
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bUE7eowWyTAfTCkBC54YowXOHCPhLYjgh4SWAH3er4=;
        b=SoCpXYdKaMfUey5hz/0ORT5wWigeWdqjVHjkfuPTxmcw1eGFtOQoqEn9jpISPl4OBP
         IqLy4G1bPAa+U9/pajJm8GZgaAwX2dxfOfyrUm4eyA0lgqkOjInYcNW+xY/k/WzY9x4K
         bajGMHrEIH4kWY+OL7hL3rg9R/Ja4R+XslK/y+dBIwUTzu6DW0QkPQW5Sew2XGzV0hpH
         5cSLx0yk4XOgIpPn2LbGcoV5yrKcV7VY2Jemm264LKFzH/IGLArLsIiVKgQ978fskC69
         Jni1J+jnj3iIRmCaKPXmUK8F/Dv+VA/zPL5bAoaSwb1newfq+N39aiNpYS3gCyxEMcmi
         G2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bUE7eowWyTAfTCkBC54YowXOHCPhLYjgh4SWAH3er4=;
        b=fSf7C9GDBcLxYIPwt9R05niLmlkB/MSupx+x/oIaKwPV7ImmNhcWOKBz54Kiaaf27J
         eonI+JDL2TAVCym1swk+5hc/OfFFo8kCLIsD5LcF6lZPGVOyPJsthKGrPPvNfsvePvlk
         zHN09tHUHAM31iPW2dSAkChvNFhyVNXdJBoL1RugII5hdeDnsEla51os5uMIo+TEERtr
         iGGdWTUZq2d89kBq3HVsHiUrkOBOL5KatP2J0x4AdBEpHBPhkSRKrilPk5PbXBCbJDDo
         oY+daHB3ZJnwxo6sqJYGlT+bJYoLVgcVdQDd1P4pBL/1eNHI/pufXyw1AleKF0Fy+3Bt
         J9SA==
X-Gm-Message-State: AOAM530RA4PfM0Uc8Z+g26q3kQnDG5GZEhFQplhZg8y5I5fJPPNp9Dc0
        St4bi4mEAorcQYiiWbNTEhlbfwzCZmxG4do0vHR/KA==
X-Google-Smtp-Source: ABdhPJz6Bb0nsQlOEK8y9bK6IdZPCfKqAzP+ygzodz5EeSxj9Aa/a2hOAzmMp83idVzYIAk1vUr4/fUXqqm1HOkM0Bk=
X-Received: by 2002:a05:6102:1173:: with SMTP id k19mr9859636vsg.51.1605583458850;
 Mon, 16 Nov 2020 19:24:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605235762.git.pcc@google.com> <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
 <X7LMfrl/vQ8vA+Va@trantor> <87d00dge6e.fsf@x220.int.ebiederm.org>
 <CAMn1gO7wU1FS5wf0Nz+pO7oNGErub-gJucG6XX8QS6JMq+P84A@mail.gmail.com> <878sb0g8ek.fsf@x220.int.ebiederm.org>
In-Reply-To: <878sb0g8ek.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 16 Nov 2020 19:24:07 -0800
Message-ID: <CAMn1gO4xbFRi1_VgNbyYLjDvpV1yCHFxjVUY1Vn4nHq5h50RkQ@mail.gmail.com>
Subject: Re: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
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

On Mon, Nov 16, 2020 at 4:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > On Mon, Nov 16, 2020 at 1:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Catalin Marinas <catalin.marinas@arm.com> writes:
> >>
> >> > On Thu, Nov 12, 2020 at 06:53:36PM -0800, Peter Collingbourne wrote:
> >> >> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> >> >> index eab4323609b9..19d284b70384 100644
> >> >> --- a/Documentation/arm64/tagged-pointers.rst
> >> >> +++ b/Documentation/arm64/tagged-pointers.rst
> >> >> @@ -53,12 +53,25 @@ visibility.
> >> >>  Preserving tags
> >> >>  ---------------
> >> >>
> >> >> -Non-zero tags are not preserved when delivering signals. This means that
> >> >> -signal handlers in applications making use of tags cannot rely on the
> >> >> -tag information for user virtual addresses being maintained for fields
> >> >> -inside siginfo_t. One exception to this rule is for signals raised in
> >> >> -response to watchpoint debug exceptions, where the tag information will
> >> >> -be preserved.
> >> >> +When delivering signals, non-zero tags are not preserved in
> >> >> +siginfo.si_addr unless the flag SA_EXPOSE_TAGBITS was set in
> >> >> +sigaction.sa_flags when the signal handler was installed. This means
> >> >> +that signal handlers in applications making use of tags cannot rely
> >> >> +on the tag information for user virtual addresses being maintained
> >> >> +in these fields unless the flag was set.
> >> >> +
> >> >> +Due to architecture limitations, bits 63:60 of the fault address
> >> >> +are not preserved in response to synchronous tag check faults
> >> >> +(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
> >> >> +treat the values of these bits as undefined in order to accommodate
> >> >> +future architecture revisions which may preserve the bits.
> >> >
> >> > If future architecture versions will preserve these bits, most likely
> >> > we'll add a new HWCAP bit so that the user knows what's going on. But
> >> > the user shouldn't rely on them being 0, just in case.
> >> >
> >> >> +For signals raised in response to watchpoint debug exceptions, the
> >> >> +tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
> >> >> +flag setting.
> >> >> +
> >> >> +Non-zero tags are never preserved in sigcontext.fault_address
> >> >> +regardless of the SA_EXPOSE_TAGBITS flag setting.
> >> >
> >> > We could've done it the other way around (fault_address tagged, si_addr
> >> > untagged) but that would be specific to arm64, so I think we should
> >> > solve it for other architectures that implement (or plan to) tagging.
> >> > The fault_address in the arm64 sigcontext was an oversight, we should
> >> > have removed it but when we realised it was already ABI.
> >> >
> >> > Anyway, I'm fine with the arm64 changes here:
> >> >
> >> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >> >
> >> > With Eric's ack, I'm happy to take the series through the arm64 tree,
> >> > otherwise Eric's tree is fine as well.
> >>
> >> In general I am fine with the last two patches.
> >>
> >> I want to understand where the value for SA_UNSUPPORTED comes from, and
> >
> > I hope I explained it well enough in [1]. If documenting the
> > arch-specific bits that way looks good to you let me know and I will
> > update patch 3.
>
> Bah.  I missed your reply.
>
> Please send me an incremental patch against:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11
>
> As I have already applied your first 4 patches and have them in
> linux-next.

Okay, I've sent a v17 to be applied on top of your branch.

> >> while I have good answers I am still digesting the question of if
> >> SA_EXPOSE_TAGBITS should be implemented in the arch specific header or
> >> in a generic header.  I quite agree it should have a generic
> >> definition/implementation.  I just don't know if it makes sense to make
> >> the value available to userspace if the architecture does not have
> >> tagbits.  Mostly my concern is about bit consumption as we only have
> >> 30ish sigaction bits.
> >
> > As mentioned in [2] I would favor making the bits generic as that
> > would simplify the client code. And I would personally not be too
> > concerned about consuming bits here. Our historical rate of adding new
> > bits is very low (as far as I know these are the first new bits to be
> > added in about 20 years!) And once we are at the point where we are
> > close to running out of bits it would be a good time to consider a new
> > sigaction API anyway that addresses some of the historical warts of
> > the existing one, and at that point we should be able to come up with
> > a way to add more bits.
>
> It is a good point that this areay hasn't seen much action in ages.  So
> there is not too much need to be concerned.
>
> In general portable code will need to do "#ifdef SA_EXPOSE_TAGBITS"
> somewhere.  But certainly it should be at least as generic as

Sure. It's worth noting though that if you know that you are targeting
Linux and have the latest kernel headers (which is the case for
Android platform code for example) you would be able to use new
#defines unconditionally.

> SA_RESTORER.  With the same meaning everywhere it is defined.
> And certainly it makes sense for the implementation to live
> in the generic signal code for to ensure all architectures implement
> it with the same semantics.
>
> I am going to sleep on this one and then see if I see any real concerns.
>
> This is bike-shedding I know, and you have done a very nice job gettin
> this far.  So I don't expect I will come up with any compelling reasons
> to change after sleeping on it, but I am going to sleep on it.

Okay, let me know if you find any concerns.

Peter
