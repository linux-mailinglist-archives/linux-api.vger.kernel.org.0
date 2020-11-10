Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2F2ACC03
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 04:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgKJDt2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Nov 2020 22:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJDt2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Nov 2020 22:49:28 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AFDC0613CF
        for <linux-api@vger.kernel.org>; Mon,  9 Nov 2020 19:49:28 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id k12so1034537uae.13
        for <linux-api@vger.kernel.org>; Mon, 09 Nov 2020 19:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hpui89T+fG6FT0O5Pv74mWvAOsxuQeWYZy/E1yPF4rE=;
        b=neIcP4JMmRH5W+mjAGV7fn9FtvtIS5EBn1D3tN89wTwE2GDjfB9yZycnDjGP+3SlFO
         i6n+2so2VNqDgHsKjgN/R7pXGbbRwOrPzVtyoMd0H3+sRn0f2ZMfKw9vMd1YWrRuSyGL
         lJwKOkcVTDjqHR0AP1WEnIINbiPjeG2ZsIxkW8vU8sMMcT4s8Dlmf2FspvCaSXVVxWrc
         JXsex5FUU6FdZVXCIjv7uxrHTzAjEeOHBbMe7cO4aAmpphxS7Jklegw/YmFTRzHCBIDk
         kq3EvhRrlbUN6O2kW/d8fsxCPjo/tw4Y29CR6imVEzhzwMMlJDT6BXX7Ua/RZW8giRYi
         fHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hpui89T+fG6FT0O5Pv74mWvAOsxuQeWYZy/E1yPF4rE=;
        b=uXEFI7DTxbgznQufp7Ag4hEBWoLpyH3ECsOlb4M2UAoFHrbh2pnHJkjD9EvbfQM68t
         vzjlZkT7PmjWd+z7FXgaNb+ik3vVphlfDrT+ur14Yco0z6Np9r9rcYPuVm1Ec1lmEBya
         pzKzakNrYR7pd5UIo7NT/DpRKLNa7AOevfLxPaO0AqAsVblUKLTr5pHcla9L51zCKwAc
         4/5MCJ570Pv+6QGiu5BFHabrVAdrZqO4qeNqxUnnze6/+Fs4kxvNERsdVadWOZPA93/K
         szEJe9rQ49765tgc73QcjWeUkEycWngIha69tlk8g0JTGnn6j5EW2aJq/D8c6nqGbSk8
         iyVA==
X-Gm-Message-State: AOAM5339LI/kschMii4OTki3murSgaf+apo7rYnrx4gokD24egPInxn3
        7iOUOvWR0MHLJdeK8bhoHqNVKSvk8gYt58BK81Q9tw==
X-Google-Smtp-Source: ABdhPJxF+hGi9gwIYQ9AC0SuYp1yc+HSofivlXm5gk5Zz8rrg8ExN5ImHoM8ZxTJ2vWvljX8SJF7yxKGd7yTsyqtwTM=
X-Received: by 2002:a9f:2067:: with SMTP id 94mr8256612uam.141.1604980167106;
 Mon, 09 Nov 2020 19:49:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604523707.git.pcc@google.com> <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
 <87eel2ypy3.fsf@x220.int.ebiederm.org>
In-Reply-To: <87eel2ypy3.fsf@x220.int.ebiederm.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 9 Nov 2020 19:49:16 -0800
Message-ID: <CAMn1gO6HYcLayiO3REvpr2o3FL3CT-7CTQajOjNMcYWn5MO=fw@mail.gmail.com>
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

On Mon, Nov 9, 2020 at 5:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Peter Collingbourne <pcc@google.com> writes:
>
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > We should not stop clearing these bits in the existing fault address
> > fields, because there may be existing userspace applications that are
> > expecting the tag bits to be cleared. Instead, create a new pair of
> > fields in siginfo._sigfault, and store the tag bits of FAR_EL1 there,
> > together with a mask specifying which bits are valid.
> >
> > A flag is added to si_faultflags to allow userspace to determine whether
> > the values in the fields are valid.
>
> I think I am missing some things:
>
> Today it is documented that the tag bits are cleared, and so we can't
> use the highbits to hold the tag bits by default.
>
> Why do you need to deliver which tag bits are valid?  That feels like an
> implementation detail that is needed to setup the tag bits.  It feels
> like it would be constant per process.  So I don't understand why the
> siginfo needs to report information the process should already have.

It isn't constant as it may vary depending on the specific type of
fault being delivered. For example on arm64 the architecture only
provides us with bits 56-59 of the tag for tag check faults, while all
other data aborts also provide bits 60-63. Now although the user
program may distinguish the two cases by checking the si_code, we
would also like to allow future architecture extensions to provide
bits 60-63 for tag check faults as well and allow distinguishing
between "bits 60-63 were zero" and "bits 60-63 were unknown" (which is
important when providing error reports).

I suppose that you could imagine that, if the "bits 60-63 available"
extension ever comes to pass, it could be exposed via a bit in
getauxval(AT_HWCAP2) (or maybe something like AT_HWCAP3 depending on
how long it takes to arrive) and that would provide a way for
userspace to know which bits are valid. But it seems like allowing
this to vary per signal is relatively cheap, allows the information to
be made available trivially architecture independently and keeps our
options open for the future (because we don't know if some future
architecture will actually make this a per-signal attribute).

That being said, maybe we could solve this problem at the point at
which we do encounter such an architecture though.

> Want prevents adding a sigaction sa_flag SA_EXPOSE_TABITS that when set
> causes the high bits to be set, and when clear (the default) will have
> the signal delivery code clear those bits.
>
> That should be enough for code that wants the tag bits to ask for them.
> As userspace would need to be updated to get the new bits
>
> Even if you have chained handlers.  The chaining mechanism would need to
> be updated and it could call the aware handlers first then clear the tag
> bits and call the rest of the handlers.
>
> It feels like always passing the tag bits in the address and then
> clearing them in the copy to userspace if the signal handler is
> not ready for them would be easier to maintain.

I think that approach might work. Although it may make life harder for
callers of ptrace(PTRACE_SETSIGINFO) since they may need to know the
value of the bit in order to prepare a correct siginfo structure, if
we can reasonably expect them to always be delivering an exact copy of
a signal that was received before then maybe that is okay.

Assuming that this is an alternative to introducing
si_addr_tag_bits_mask, the userspace code would need to use the flag
bit support detection protocol for SA_EXPOSE_TAGBITS in order to be
able to distinguish between "no bits valid" and "some bits valid", and
then use an architecture-specific mechanism to determine exactly which
bits are valid. Is that okay for a generic feature?

Peter
