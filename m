Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519F62AE27B
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 23:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKJWGf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Nov 2020 17:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJWGf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Nov 2020 17:06:35 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC8C0613D1
        for <linux-api@vger.kernel.org>; Tue, 10 Nov 2020 14:06:34 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id b67so22258vsc.3
        for <linux-api@vger.kernel.org>; Tue, 10 Nov 2020 14:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yF4pXSKnNLj/96d32GM57pDMqXUaJ1nDXdzQa5VbUg=;
        b=mlqhyMylQBVhX8E16TgqTcwm+DQdCCPRXboRjnmG2MjJjKob5hXQwulYec3c3Uvmng
         XPiR8DTXQ4rSz01COlD7fDpJ18BX4+SrNW6uVo5bIrbC6Gc0pzsyDUCaIKSGXrKwf1nU
         MHdqKQNsbqV0CjMxhp1KKwXRzVxEgmsqF5e5K65PSKakMDq5RMPZyWpKSRnTH4szZ4Ha
         HrwCIncI6ViZa/6b8pJYXUtZVy7cy7OoNoyevD8hJFOo/0VFqz4b/Jxco4tVzzmnW+cQ
         MEuGGzKOIFKfQR9mCU39xtqrzlaUNdKEK+rrSlhHgoWqzKMaLUfkPWBEyyla7dn1x6gv
         G7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yF4pXSKnNLj/96d32GM57pDMqXUaJ1nDXdzQa5VbUg=;
        b=gy7czVHLkzB2b/M/JZTVePqhAD//cQKVGRQL14D7FKA9k98N7SlqBn+c9hNdWVbGtO
         YzoFZOSF5h54Z63UyyZ7Tb1s5WmQxjzNTJSA3auYffHBwUbzaoXK9zCzXdLQBGiC9wEx
         I8IG+3tS7z+Am0YQBdWiiDNaVhIJ4WSDkesHNFIyxOGa74+O7QJ48PdHAV7AvcBtU53O
         AN47+Pn5F+H2HqycPRCPTzGDA6SZOZBRB+WhE1XgzsUdwRe0E1rYuZoNfYwMQkCeMQ+k
         lA61FZNvZAW4RSMxCl2PEkXE2wvGr8INRekML2UjFaQqMZJywewLb0GpOs+QBpswbdVi
         Z3sw==
X-Gm-Message-State: AOAM530fEH4qIUDjxX17b3kvAWF5GqxAv7wLYAlBy6HPSjqJDy8NAQIk
        wDa86lLKLjKgSQvt0/CeaJQTr/muTOHM1h0Bi2r6Og==
X-Google-Smtp-Source: ABdhPJySDtPM0HMtzLXHuIdErMFSHqR19UgA8QAUKAHUK5L3+Mk1JiOm2XiiW+XKUGvK/UMByI81QXZr0fZQ0zqP1qc=
X-Received: by 2002:a67:ed4b:: with SMTP id m11mr4035299vsp.14.1605045993169;
 Tue, 10 Nov 2020 14:06:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604523707.git.pcc@google.com> <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
 <87eel2ypy3.fsf@x220.int.ebiederm.org> <CAMn1gO6HYcLayiO3REvpr2o3FL3CT-7CTQajOjNMcYWn5MO=fw@mail.gmail.com>
 <87blg5tfdt.fsf@x220.int.ebiederm.org>
In-Reply-To: <87blg5tfdt.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 10 Nov 2020 14:06:21 -0800
Message-ID: <CAMn1gO5mddTr2afkK7EOyfN7+S=AC-ah15nn9mqhJehD-GpWFQ@mail.gmail.com>
Subject: Re: [PATCH v14 8/8] arm64: expose FAR_EL1 tag bits in siginfo
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
        Richard Henderson <rth@twiddle.net>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 10, 2020 at 7:12 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > On Mon, Nov 9, 2020 at 5:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Peter Collingbourne <pcc@google.com> writes:
> >>
> >> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> >> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> >> > the tag bits may be needed by tools in order to accurately diagnose
> >> > memory errors, such as HWASan [1] or future tools based on the Memory
> >> > Tagging Extension (MTE).
> >> >
> >> > We should not stop clearing these bits in the existing fault address
> >> > fields, because there may be existing userspace applications that are
> >> > expecting the tag bits to be cleared. Instead, create a new pair of
> >> > fields in siginfo._sigfault, and store the tag bits of FAR_EL1 there,
> >> > together with a mask specifying which bits are valid.
> >> >
> >> > A flag is added to si_faultflags to allow userspace to determine whether
> >> > the values in the fields are valid.
> >>
> >> I think I am missing some things:
> >>
> >> Today it is documented that the tag bits are cleared, and so we can't
> >> use the highbits to hold the tag bits by default.
> >>
> >> Why do you need to deliver which tag bits are valid?  That feels like an
> >> implementation detail that is needed to setup the tag bits.  It feels
> >> like it would be constant per process.  So I don't understand why the
> >> siginfo needs to report information the process should already have.
> >
> > It isn't constant as it may vary depending on the specific type of
> > fault being delivered. For example on arm64 the architecture only
> > provides us with bits 56-59 of the tag for tag check faults, while all
> > other data aborts also provide bits 60-63. Now although the user
> > program may distinguish the two cases by checking the si_code, we
> > would also like to allow future architecture extensions to provide
> > bits 60-63 for tag check faults as well and allow distinguishing
> > between "bits 60-63 were zero" and "bits 60-63 were unknown" (which is
> > important when providing error reports).
>
> Does that mean that bits 60-63 are effectively unusable as tag bits
> if the tag check fault won't report them?

The hardware doesn't support tag checking on bits 60-63, only on bits
56-59, so in terms of hardware enforced memory tag checking they can't
be used as tag bits. But they are still subject to address tagging aka
top-byte-ignore so they could be used by userspace for other purposes
(e.g. if the allocator adds entropy to all 8 bits instead of just bits
56-59 they could in theory be used to allow better diagnostics with
more precise matching of an invalid access to a previous allocation).

> If you can use bits 60-63 as tag bits how does that work if they aren't
> reported?

It still works but we're limited in how many allocations we can match
accesses to (16 vs 256).

> > I suppose that you could imagine that, if the "bits 60-63 available"
> > extension ever comes to pass, it could be exposed via a bit in
> > getauxval(AT_HWCAP2) (or maybe something like AT_HWCAP3 depending on
> > how long it takes to arrive) and that would provide a way for
> > userspace to know which bits are valid. But it seems like allowing
> > this to vary per signal is relatively cheap, allows the information to
> > be made available trivially architecture independently and keeps our
> > options open for the future (because we don't know if some future
> > architecture will actually make this a per-signal attribute).
> >
> > That being said, maybe we could solve this problem at the point at
> > which we do encounter such an architecture though.
>
> My goal would be to extend things to the minimum extent necessary to
> handle today's reality well.  Usually architectures evolve in
> unanticipated directions so simple and straight forward usually wins for
> handling future evolution.  As there is simply less old baggage to carry
> around.
>
> However I don't understand if reporting the valid bits on a signal by
> signal basis has a real advantage today or not.  If it helps today we
> will find room for the field.

Okay, that makes sense. With the architecture as specified today I
don't think we would need it, since you can write a function that
operates on the siginfo and tells you what the si_addr_tag_bits_mask
would be without it.

> >> Want prevents adding a sigaction sa_flag SA_EXPOSE_TABITS that when set
> >> causes the high bits to be set, and when clear (the default) will have
> >> the signal delivery code clear those bits.
> >>
> >> That should be enough for code that wants the tag bits to ask for them.
> >> As userspace would need to be updated to get the new bits
> >>
> >> Even if you have chained handlers.  The chaining mechanism would need to
> >> be updated and it could call the aware handlers first then clear the tag
> >> bits and call the rest of the handlers.
> >>
> >> It feels like always passing the tag bits in the address and then
> >> clearing them in the copy to userspace if the signal handler is
> >> not ready for them would be easier to maintain.
> >
> > I think that approach might work. Although it may make life harder for
> > callers of ptrace(PTRACE_SETSIGINFO) since they may need to know the
> > value of the bit in order to prepare a correct siginfo structure, if
> > we can reasonably expect them to always be delivering an exact copy of
> > a signal that was received before then maybe that is okay.
>
> I think we can reasonably expect callers of PTRACE_SETSIGINFO to be able
> to either deal the full reality of what is going on, or to only generate
> signals that they fully understand.
>
> Other than the use by CRIU it is a debugging facility and it is not
> expected for ordinary usage.  The non-CRIU use case would really seem to
> be what happens if I inject arbitrary signal X into process Y.  For that
> you need the ability to inject an arbitrary signal.
>
> My real sense with PTRACE_SETSIGINFO is that if we wind up with a
> regression we can deal with it then.

Okay, that works for me.

> > Assuming that this is an alternative to introducing
> > si_addr_tag_bits_mask, the userspace code would need to use the flag
> > bit support detection protocol for SA_EXPOSE_TAGBITS in order to be
> > able to distinguish between "no bits valid" and "some bits valid", and
> > then use an architecture-specific mechanism to determine exactly which
> > bits are valid. Is that okay for a generic feature?
>
> Unless I am mistaken setting the bits is already architecture specific
> so having some architecture specific code in there should not be a big
> problem.
>
> But I really don't understand the arm case well enough to know if we can
> get away without si_addr_tag_bits_mask, and in turn without the flags
> field that indicates the si_addr_tag_bits_mask is present.
>
> So I am asking questions so I can understand just what we get from
> si_addr_tag_bits_mask.

If we allow the derivation of the mask to be architecture-specific
(which I'd be comfortable with) then I don't think we need it. What we
would end up with is:

- The tag bits mask is constant and architecturally defined (in
arm64's case it would be 0xff << 56).
- The valid tag bits mask specifies which bits of the tag bits mask in
the fault address are propagated to si_addr. It is defined in an
architecture-specific way based on the signal handler's
SA_EXPOSE_TAGBITS bit, the contents of siginfo and possibly global
information such as getauxval(AT_HWCAP*).
  - on arm64 this would currently be defined as:
    - if SA_EXPOSE_TAGBITS is not set then the mask is 0xff << 56 for
SIGTRAP/TRAP_BRKPT, 0 otherwise
    - if SA_EXPOSE_TAGBITS is set then the mask is 0xf << 56 for
SIGSEGV/SEGV_MTESERR, 0xff << 56 otherwise
- If SA_EXPOSE_TAGBITS is set then the bits in the tag bits mask that
are not also in the valid tag bits mask have an undefined value (this
would e.g. allow future expansion of arm64 to expose bits 60-63 on tag
check faults).
- If the kernel does not support SA_EXPOSE_TAGBITS (as determined
using the flag bit support detection protocol) then the behavior is as
if SA_EXPOSE_TAGBITS is not set.

So I think I'd be fine with dropping it but let me experiment with the
new approach so that I can confirm that it's practical on Android and
I'll get back to you.

Peter
