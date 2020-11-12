Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDBE2B12A8
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 00:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgKLXU7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 18:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgKLXU7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 18:20:59 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375DC0613D1
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 15:20:58 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id f7so4227207vsh.10
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 15:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ViedX+JtxfZ5AAIneiGBi+Jerri1V2Lpa9QlbkGkg+I=;
        b=Gve2UJ/yVbVlFp9eaj8SqcFfoev9roU/AvqI5NtsDNnPxlVq/nN/mnTg11JEDImzrM
         hYGaw0rHglQbC0oDmeqEbFkvFGfa8sgf+FpMHhB9hcC+gr2xAO5EneSQt3PKQ6zYrity
         gaW057Z0FBM+CMNoANOIYcf4WVCl22zsGe1PZck7LK6ne9hLYs2OsT9k4KQqc1tA1NTE
         e3mVZLNvm/gnY8rZP9dHk0DERHpWwrrw0kraHADnG8QiwwTRU47p41ldKKQV/cUC9B5/
         +KsbDl/U2mWdGLwvmT7240M16CWGPPuCPRALoBroQtoaYsitjVGLcXI86l/ZOPw3odPZ
         xgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ViedX+JtxfZ5AAIneiGBi+Jerri1V2Lpa9QlbkGkg+I=;
        b=PSSM98syfYGfkY+1jAqOsJmIqgoB/agWxm0m/cmxbHghG0iSBeW2QEuU+LjdUzT+hP
         MezRoEI0kEDORVqqrpVZj4642DdyVrF1w7P7TcJtOB/EQbdw0R2Udi22SopMJ+e6cM5f
         tcPAojN3ChZ7HGARSI0tO+cH6drMDjmUvwfFatrdFxxDOA6R1T/ugZWeOqELPT3avrQ3
         VaraOPfBuTe1ZYI3PjteYq6JMwKQTpfrH1WsSDG1NVGhAR9+LKaq2tMy81eG7RUjcM1Q
         w+Gn/l8iOg/i5nF9+KOjvzMwT/j32UsU2bWg+xjNmFLfi/GRI8gRrtdXzYgAmR7RvE4k
         OSBw==
X-Gm-Message-State: AOAM530cPf7ymfPS8mbpvlho9yHg16IhRocYm1QcS1uhCCM7+hWXTFEm
        i816E6EYZfKhtngEvhtSdJRhcoDOjgcgHO0F57SpCw==
X-Google-Smtp-Source: ABdhPJyNEEeoLrLbPBMldTjvDXQXxJbfBMFsLA9UsrrKze0iGZjP8yzo4lgMGElWijHjvoAZtJr7h5Njg/F77JkZgY8=
X-Received: by 2002:a67:ce0e:: with SMTP id s14mr1574567vsl.13.1605223256952;
 Thu, 12 Nov 2020 15:20:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604523707.git.pcc@google.com> <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
 <87eel2ypy3.fsf@x220.int.ebiederm.org> <CAMn1gO6HYcLayiO3REvpr2o3FL3CT-7CTQajOjNMcYWn5MO=fw@mail.gmail.com>
 <87blg5tfdt.fsf@x220.int.ebiederm.org> <CAMn1gO5mddTr2afkK7EOyfN7+S=AC-ah15nn9mqhJehD-GpWFQ@mail.gmail.com>
 <20201111174604.GQ6882@arm.com>
In-Reply-To: <20201111174604.GQ6882@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 12 Nov 2020 15:20:45 -0800
Message-ID: <CAMn1gO7G3BxZEnZA4A9uQBnpthpk9uLdye3q2pETZpTMaP+CtQ@mail.gmail.com>
Subject: Re: [PATCH v14 8/8] arm64: expose FAR_EL1 tag bits in siginfo
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Wed, Nov 11, 2020 at 9:46 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, Nov 10, 2020 at 02:06:21PM -0800, Peter Collingbourne wrote:
> > On Tue, Nov 10, 2020 at 7:12 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >
> > > Peter Collingbourne <pcc@google.com> writes:
> > >
> > > > On Mon, Nov 9, 2020 at 5:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > >>
> > > >> Peter Collingbourne <pcc@google.com> writes:
> > > >>
> > > >> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > > >> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > > >> > the tag bits may be needed by tools in order to accurately diagnose
> > > >> > memory errors, such as HWASan [1] or future tools based on the Memory
> > > >> > Tagging Extension (MTE).
> > > >> >
> > > >> > We should not stop clearing these bits in the existing fault address
> > > >> > fields, because there may be existing userspace applications that are
> > > >> > expecting the tag bits to be cleared. Instead, create a new pair of
> > > >> > fields in siginfo._sigfault, and store the tag bits of FAR_EL1 there,
> > > >> > together with a mask specifying which bits are valid.
> > > >> >
> > > >> > A flag is added to si_faultflags to allow userspace to determine whether
> > > >> > the values in the fields are valid.
> > > >>
> > > >> I think I am missing some things:
> > > >>
> > > >> Today it is documented that the tag bits are cleared, and so we can't
> > > >> use the highbits to hold the tag bits by default.
> > > >>
> > > >> Why do you need to deliver which tag bits are valid?  That feels like an
> > > >> implementation detail that is needed to setup the tag bits.  It feels
> > > >> like it would be constant per process.  So I don't understand why the
> > > >> siginfo needs to report information the process should already have.
> > > >
> > > > It isn't constant as it may vary depending on the specific type of
> > > > fault being delivered. For example on arm64 the architecture only
> > > > provides us with bits 56-59 of the tag for tag check faults, while all
> > > > other data aborts also provide bits 60-63. Now although the user
> > > > program may distinguish the two cases by checking the si_code, we
> > > > would also like to allow future architecture extensions to provide
> > > > bits 60-63 for tag check faults as well and allow distinguishing
> > > > between "bits 60-63 were zero" and "bits 60-63 were unknown" (which is
> > > > important when providing error reports).
> > >
> > > Does that mean that bits 60-63 are effectively unusable as tag bits
> > > if the tag check fault won't report them?
> >
> > The hardware doesn't support tag checking on bits 60-63, only on bits
> > 56-59, so in terms of hardware enforced memory tag checking they can't
> > be used as tag bits. But they are still subject to address tagging aka
> > top-byte-ignore so they could be used by userspace for other purposes
> > (e.g. if the allocator adds entropy to all 8 bits instead of just bits
> > 56-59 they could in theory be used to allow better diagnostics with
> > more precise matching of an invalid access to a previous allocation).
> >
> > > If you can use bits 60-63 as tag bits how does that work if they aren't
> > > reported?
> >
> > It still works but we're limited in how many allocations we can match
> > accesses to (16 vs 256).
>
> Not matching/reporting all the bits still has some value: if all 8 bits
> are random per allocation, then it is statistically likely that the
> hardware will detect mismatches.  Once you know there's a bug, you can
> turn on software instrumentation to debug the issue further, which may
> check the rest of the bits without relying on the signal mechansism,
> though at a higher runtime cost.
>
> (I'm not saying software will definitely do things this way, but it
> seems a reasonable use case.)

I suppose that it's possible that you could do the tag checks in
software just so that you can get the upper 4 bits, but if you're
prepared to do something this elaborate then there may be a lower cost
overall approach (e.g. look for GPRs whose bits 56-59 matches bits
56-59 of the fault address, then your upper 4 bits will likely be
those of one of the registers where they match).

> > > > I suppose that you could imagine that, if the "bits 60-63 available"
> > > > extension ever comes to pass, it could be exposed via a bit in
> > > > getauxval(AT_HWCAP2) (or maybe something like AT_HWCAP3 depending on
> > > > how long it takes to arrive) and that would provide a way for
> > > > userspace to know which bits are valid. But it seems like allowing
> > > > this to vary per signal is relatively cheap, allows the information to
> > > > be made available trivially architecture independently and keeps our
> > > > options open for the future (because we don't know if some future
> > > > architecture will actually make this a per-signal attribute).
> > > >
> > > > That being said, maybe we could solve this problem at the point at
> > > > which we do encounter such an architecture though.
> > >
> > > My goal would be to extend things to the minimum extent necessary to
> > > handle today's reality well.  Usually architectures evolve in
> > > unanticipated directions so simple and straight forward usually wins for
> > > handling future evolution.  As there is simply less old baggage to carry
> > > around.
> > >
> > > However I don't understand if reporting the valid bits on a signal by
> > > signal basis has a real advantage today or not.  If it helps today we
> > > will find room for the field.
> >
> > Okay, that makes sense. With the architecture as specified today I
> > don't think we would need it, since you can write a function that
> > operates on the siginfo and tells you what the si_addr_tag_bits_mask
> > would be without it.
> >
> > > >> Want prevents adding a sigaction sa_flag SA_EXPOSE_TABITS that when set
> > > >> causes the high bits to be set, and when clear (the default) will have
> > > >> the signal delivery code clear those bits.
> > > >>
> > > >> That should be enough for code that wants the tag bits to ask for them.
> > > >> As userspace would need to be updated to get the new bits
> > > >>
> > > >> Even if you have chained handlers.  The chaining mechanism would need to
> > > >> be updated and it could call the aware handlers first then clear the tag
> > > >> bits and call the rest of the handlers.
> > > >>
> > > >> It feels like always passing the tag bits in the address and then
> > > >> clearing them in the copy to userspace if the signal handler is
> > > >> not ready for them would be easier to maintain.
> > > >
> > > > I think that approach might work. Although it may make life harder for
> > > > callers of ptrace(PTRACE_SETSIGINFO) since they may need to know the
> > > > value of the bit in order to prepare a correct siginfo structure, if
> > > > we can reasonably expect them to always be delivering an exact copy of
> > > > a signal that was received before then maybe that is okay.
> > >
> > > I think we can reasonably expect callers of PTRACE_SETSIGINFO to be able
> > > to either deal the full reality of what is going on, or to only generate
> > > signals that they fully understand.
> > >
> > > Other than the use by CRIU it is a debugging facility and it is not
> > > expected for ordinary usage.  The non-CRIU use case would really seem to
> > > be what happens if I inject arbitrary signal X into process Y.  For that
> > > you need the ability to inject an arbitrary signal.
> > >
> > > My real sense with PTRACE_SETSIGINFO is that if we wind up with a
> > > regression we can deal with it then.
> >
> > Okay, that works for me.
> >
> > > > Assuming that this is an alternative to introducing
> > > > si_addr_tag_bits_mask, the userspace code would need to use the flag
> > > > bit support detection protocol for SA_EXPOSE_TAGBITS in order to be
> > > > able to distinguish between "no bits valid" and "some bits valid", and
> > > > then use an architecture-specific mechanism to determine exactly which
> > > > bits are valid. Is that okay for a generic feature?
> > >
> > > Unless I am mistaken setting the bits is already architecture specific
> > > so having some architecture specific code in there should not be a big
> > > problem.
> > >
> > > But I really don't understand the arm case well enough to know if we can
> > > get away without si_addr_tag_bits_mask, and in turn without the flags
> > > field that indicates the si_addr_tag_bits_mask is present.
> > >
> > > So I am asking questions so I can understand just what we get from
> > > si_addr_tag_bits_mask.
> >
> > If we allow the derivation of the mask to be architecture-specific
> > (which I'd be comfortable with) then I don't think we need it. What we
> > would end up with is:
>
> Note, the architecture-specificness can always be hidden under
> sysconf(3) or similar, so it's probably not a huge deal if there's no
> generic way of reporting that at the kernel level.

That makes sense, and it could also accommodate architectures like
RISC-V which didn't start out with tag bits but may receive them later
as a result of architecture changes.

> > - The tag bits mask is constant and architecturally defined (in
> > arm64's case it would be 0xff << 56).
> > - The valid tag bits mask specifies which bits of the tag bits mask in
> > the fault address are propagated to si_addr. It is defined in an
> > architecture-specific way based on the signal handler's
> > SA_EXPOSE_TAGBITS bit, the contents of siginfo and possibly global
> > information such as getauxval(AT_HWCAP*).
> >   - on arm64 this would currently be defined as:
> >     - if SA_EXPOSE_TAGBITS is not set then the mask is 0xff << 56 for
> > SIGTRAP/TRAP_BRKPT, 0 otherwise
> >     - if SA_EXPOSE_TAGBITS is set then the mask is 0xf << 56 for
> > SIGSEGV/SEGV_MTESERR, 0xff << 56 otherwise
>
> This feels very obscure, but since the use cases are equally obscure
> this may not be a big problem.  I do sympathise with Eric's view that it
> may be best not to over-abstract this.
>
> An sa_flags based mechanism still won't play nice with interposition
> frameworks where library registers a proxy handler and chains the user's
> handler from it -- the xflags approach is potentially better there.  But
> it would only be one more in a long list of existing issues.  People will
> only be using SA_EXPOSE_TAGBITS if they explicitly need it (i.e.,
> rarely).

I think this is likely to work with interceptors, as long as the
interceptor either stashes the sa_flags unchanged (detected by callers
as an old kernel via SA_UNSUPPORTED) or passes them verbatim to the
kernel (detection will be consistent with the kernel version). Both
behaviors are likely to be safe (and the former is what libsigchain
implements), although I suppose that an interceptor that replaces
sa_sigaction but not sa_flags may now be exposed to the tag bits, but
odds of the stars aligning and causing a problem this way are much
less than for random userspace applications being exposed to the bits
unconditionally. As I've said before "likely to work" is probably the
best that we can hope for with unaware interceptors.

Of course, the user program may attempt to rely on SA_EXPOSE_TAGBITS
behavior without checking for support, but that's the case with or
without interceptors.

> > - If SA_EXPOSE_TAGBITS is set then the bits in the tag bits mask that
> > are not also in the valid tag bits mask have an undefined value (this
> > would e.g. allow future expansion of arm64 to expose bits 60-63 on tag
> > check faults).
> > - If the kernel does not support SA_EXPOSE_TAGBITS (as determined
> > using the flag bit support detection protocol) then the behavior is as
> > if SA_EXPOSE_TAGBITS is not set.
> >
> > So I think I'd be fine with dropping it but let me experiment with the
> > new approach so that I can confirm that it's practical on Android and
> > I'll get back to you.
>
>
> Is the xflags mechanism still required if we follow this model?
>
> If not, that would be a significant simplification.

No, it will not be necessary. In fact, no changes to the siginfo
structure are required, the only change is to the semantics of the
si_addr field.

After doing some experimentation on Android (including implementing
the change itself, and consequent changes to the tombstone signal
handler and libsigchain) I'm happy with the new approach and I'll send
a v15 with the new patches shortly.

Peter
