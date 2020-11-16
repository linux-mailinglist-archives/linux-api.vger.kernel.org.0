Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA542B54F5
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgKPX2m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 18:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgKPX2m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 18:28:42 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D74C0613CF
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 15:28:42 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s24so19211641ioj.13
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 15:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8sHvnbqERzq+hspDvN6Xf1Dxv+J3VXaVu7iUFkVbts=;
        b=XSiI3im5+VC/kJM58XubBMsJzzaxI8MpGBeMyJyP4cYs83ZwSwJDUPBWx29RWExaGx
         E/VXViEQoABjVUGGBnF1gB81VxkZjXnZAIeb+bOp1NdaySOHhn9nQHx3MDu3pmM+7GNW
         l//ul60rheqwMLsVV1pZZ0ps0vf7THdSBE70Dlp0wUnWpRdHKgqrNJBW8nG/9CBC7GJL
         i4AmEQeFJTWySSUO+DWOrX2tNrppdWevx4shcZoH5lSr8+Q3TFPTqrSMSX3EN6paAgaF
         QE/PY+fxzWe7NOWcvdVfMFjID7SFHFa2FZ19ugyJivmG1wxVCLQm8CDtFtKW4Qi81KKC
         Agag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8sHvnbqERzq+hspDvN6Xf1Dxv+J3VXaVu7iUFkVbts=;
        b=uHfkT5jjFqkeW2HF2vaiFxkcMwt3flN92oWFKVTVpeUKA4Lp7nL8rQm8c1wCCS00Ym
         yE82IN4XLS5FWvERXa0F99qoXwTtrqHNiL3QXP3LBOQKCdx6M0TfOHGC7QMc7d5lDgaW
         tZ9qB+gL92pL1pMrGJRtDRtuYGMoB2nYUV8gcUzXzceLGoD10/D5RUdC3B3KyAWvTzRS
         x+ZUVpMXgL4G0/AmqA7kMKsZ0ZauOiBEEY1Om/WXsH1eP5Hp7AtgyIn+5W1FsKCfWAEK
         o3En+X4d2R+Ki+rpXOLOMFGhvwQYRPcjZOT7uGo3sI78mOkGUiS3EjezkCy/baE9yY3+
         4/tw==
X-Gm-Message-State: AOAM531KMf7223udZbV+br8Yjsk6lllaazxyg8qeBjTuiJgT8z6O3V0C
        HrZ0YHWSFWzVylmcgWFWfBTQQ315OOr2tFOjLEOpzg==
X-Google-Smtp-Source: ABdhPJwzLMT5oL6MUUQ2GgEEMn2atIqIBIYDhdL8ctlVdUVOqCnP4VQCEQCTGYroanFIgrd/ieByhQI89yPvvSRcMKE=
X-Received: by 2002:a05:6602:20c7:: with SMTP id 7mr9432702ioz.170.1605569321505;
 Mon, 16 Nov 2020 15:28:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605235762.git.pcc@google.com> <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
 <X7LMfrl/vQ8vA+Va@trantor> <87d00dge6e.fsf@x220.int.ebiederm.org>
In-Reply-To: <87d00dge6e.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 16 Nov 2020 15:28:29 -0800
Message-ID: <CAMn1gO7wU1FS5wf0Nz+pO7oNGErub-gJucG6XX8QS6JMq+P84A@mail.gmail.com>
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

On Mon, Nov 16, 2020 at 1:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Catalin Marinas <catalin.marinas@arm.com> writes:
>
> > On Thu, Nov 12, 2020 at 06:53:36PM -0800, Peter Collingbourne wrote:
> >> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
> >> index eab4323609b9..19d284b70384 100644
> >> --- a/Documentation/arm64/tagged-pointers.rst
> >> +++ b/Documentation/arm64/tagged-pointers.rst
> >> @@ -53,12 +53,25 @@ visibility.
> >>  Preserving tags
> >>  ---------------
> >>
> >> -Non-zero tags are not preserved when delivering signals. This means that
> >> -signal handlers in applications making use of tags cannot rely on the
> >> -tag information for user virtual addresses being maintained for fields
> >> -inside siginfo_t. One exception to this rule is for signals raised in
> >> -response to watchpoint debug exceptions, where the tag information will
> >> -be preserved.
> >> +When delivering signals, non-zero tags are not preserved in
> >> +siginfo.si_addr unless the flag SA_EXPOSE_TAGBITS was set in
> >> +sigaction.sa_flags when the signal handler was installed. This means
> >> +that signal handlers in applications making use of tags cannot rely
> >> +on the tag information for user virtual addresses being maintained
> >> +in these fields unless the flag was set.
> >> +
> >> +Due to architecture limitations, bits 63:60 of the fault address
> >> +are not preserved in response to synchronous tag check faults
> >> +(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
> >> +treat the values of these bits as undefined in order to accommodate
> >> +future architecture revisions which may preserve the bits.
> >
> > If future architecture versions will preserve these bits, most likely
> > we'll add a new HWCAP bit so that the user knows what's going on. But
> > the user shouldn't rely on them being 0, just in case.
> >
> >> +For signals raised in response to watchpoint debug exceptions, the
> >> +tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
> >> +flag setting.
> >> +
> >> +Non-zero tags are never preserved in sigcontext.fault_address
> >> +regardless of the SA_EXPOSE_TAGBITS flag setting.
> >
> > We could've done it the other way around (fault_address tagged, si_addr
> > untagged) but that would be specific to arm64, so I think we should
> > solve it for other architectures that implement (or plan to) tagging.
> > The fault_address in the arm64 sigcontext was an oversight, we should
> > have removed it but when we realised it was already ABI.
> >
> > Anyway, I'm fine with the arm64 changes here:
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > With Eric's ack, I'm happy to take the series through the arm64 tree,
> > otherwise Eric's tree is fine as well.
>
> In general I am fine with the last two patches.
>
> I want to understand where the value for SA_UNSUPPORTED comes from, and

I hope I explained it well enough in [1]. If documenting the
arch-specific bits that way looks good to you let me know and I will
update patch 3.

> while I have good answers I am still digesting the question of if
> SA_EXPOSE_TAGBITS should be implemented in the arch specific header or
> in a generic header.  I quite agree it should have a generic
> definition/implementation.  I just don't know if it makes sense to make
> the value available to userspace if the architecture does not have
> tagbits.  Mostly my concern is about bit consumption as we only have
> 30ish sigaction bits.

As mentioned in [2] I would favor making the bits generic as that
would simplify the client code. And I would personally not be too
concerned about consuming bits here. Our historical rate of adding new
bits is very low (as far as I know these are the first new bits to be
added in about 20 years!) And once we are at the point where we are
close to running out of bits it would be a good time to consider a new
sigaction API anyway that addresses some of the historical warts of
the existing one, and at that point we should be able to come up with
a way to add more bits.

Peter

[1] https://lore.kernel.org/linux-arm-kernel/CAMn1gO52j4fSEn5S2GdrtyCq+iiaMK16DkKiyj=Go91Jy+xR-w@mail.gmail.com/
[2] https://lore.kernel.org/linux-arm-kernel/CAMn1gO6n7NrM8A+vkMt=ixvbSzUJbrr2s6Ko3WENPoT-84J15w@mail.gmail.com/
