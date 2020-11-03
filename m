Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6325B2A4F16
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 19:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgKCSkE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 13:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgKCSkE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Nov 2020 13:40:04 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F665C0613D1
        for <linux-api@vger.kernel.org>; Tue,  3 Nov 2020 10:40:04 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id w3so2182271uau.2
        for <linux-api@vger.kernel.org>; Tue, 03 Nov 2020 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULKIvxrNpd5zn26DlY8vICA83b3Cs4JhT9FujjHQoKo=;
        b=JOUWZPxECYGp2JkjKMED2PcjIoOQBffCThz5pA7bxCDjNz6T6mkkgbevDDA3Yft7X/
         8gXRmhdbP3aPXFXxv9Uf+Koo87rc9I6ILW5soE2PNuxMdsEo10HOIywCKQpEHU5W8JOk
         ENPTJVdvIhDxllKG5KyPXyDakEmeFk1pIysLw6M1th8Nwzry2Lh+LOFI6UPovXc1hSj6
         EcF6zhALcJML0boPcmMwz6JlMSJFNVSXYBg9jecnB2DsiIzSkynU9CJZlakCXiRf1UVU
         PeXGrb+zEPkGqKm57FRrgo7d5RtVTfNO2aqH6CFMEjd4c4/iwP5pb14iIFAeZirJoZVR
         uRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULKIvxrNpd5zn26DlY8vICA83b3Cs4JhT9FujjHQoKo=;
        b=PaNOkQnFxBfFPLRctiK3BY+3U0aoutpLbJtvZnVBqqVY3GIxFb9+v1d3/v1zUNtuZd
         o52gTnlDNi7T8Wvwko6qOdg5RwwcVL1lWMzHjVlaEGdiIgbA6bFG9SpB8hFdhmgc/gVW
         3ByOAid+6jtgH6ImIaEWn8Gbx7MB2tNrgQ0SmZlNc9SzjsN+sbZBHyxtHFbc27QEg3Th
         ozviyY3u3kYVf8k3PCa798ZjIPH21MAVZ6j76qYHNz+5Rnh7ET9sF9X4Y2byo7qZPwS0
         nmcqWOTDP1/58uB3Cn5OVgirYoaIGWrz/0z/IgjLPxCaSs8ly4hUE3G1pH85d2nYuW+D
         +Nwg==
X-Gm-Message-State: AOAM532I0NJcqPA8RwafKvYJxuBydHv5ZsVN4Tnfm5xv6E4ptsLGtQuQ
        S6kDNBHMLdIzIzq5LDfDsnr7wWEbT5MZxVXShmXIRg==
X-Google-Smtp-Source: ABdhPJyG4Q2CZTsk+cC95WFgO2getVEsiM+/olGtZEyNBlRFIBhlD1MLrOb8b4kN8f4S7Vm2pmGakiJouozetcTSV30=
X-Received: by 2002:ab0:6156:: with SMTP id w22mr11557971uan.122.1604428802947;
 Tue, 03 Nov 2020 10:40:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604376407.git.pcc@google.com> <743fef80a8617378027d5d2b0538cfc36ea106a1.1604376407.git.pcc@google.com>
 <20201103175352.GA22573@gaia>
In-Reply-To: <20201103175352.GA22573@gaia>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 3 Nov 2020 10:39:52 -0800
Message-ID: <CAMn1gO71zhxp692t6GKCRazNb-cF45OcdUSUjavzHZUki6VpiA@mail.gmail.com>
Subject: Re: [PATCH v13 7/8] signal: define the field siginfo.si_faultflags
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 3, 2020 at 9:54 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Peter,
>
> On Mon, Nov 02, 2020 at 08:09:43PM -0800, Peter Collingbourne wrote:
> > This field will contain flags that may be used by signal handlers to
> > determine whether other fields in the _sigfault portion of siginfo are
> > valid. An example use case is the following patch, which introduces
> > the si_addr_tag_bits{,_mask} fields.
> >
> > A new sigcontext flag, SA_FAULTFLAGS, is introduced in order to allow
> > a signal handler to require the kernel to set the field (but note
> > that the field will be set anyway if the kernel supports the flag,
> > regardless of its value). In combination with the previous patches,
> > this allows a userspace program to determine whether the kernel will
> > set the field.
>
> As per patch 5, a user is supposed to call sigaction() twice to figure
> out whether _faultflags is meaningful. That's the part I'm not
> particularly fond of. Are the unused parts of siginfo always zeroed when
> the kernel delivers a signal? If yes, we could simply check the new
> field for non-zero bits.

The unused parts of siginfo are zeroed in current kernels, but
unfortunately not in older kernels. The zeroing behavior was
introduced in commit c999b933faa5e281e3af2e110eccaf91698b0a81 which
first appeared in kernel version 4.18, and at least in Android land we
do need to support kernel versions older than that.

> > It is possible for an si_faultflags-unaware program to cause a signal
> > handler in an si_faultflags-aware program to be called with a provided
> > siginfo data structure by using one of the following syscalls:
> >
> > - ptrace(PTRACE_SETSIGINFO)
> > - pidfd_send_signal
> > - rt_sigqueueinfo
> > - rt_tgsigqueueinfo
> >
> > So we need to prevent the si_faultflags-unaware program from causing an
> > uninitialized read of si_faultflags in the si_faultflags-aware program when
> > it uses one of these syscalls.
> >
> > The last three cases can be handled by observing that each of these
> > syscalls fails if si_code >= 0. We also observe that kill(2) and
> > tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
> > so we define si_faultflags to only be valid if si_code > 0.
> >
> > There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
> > we make ptrace(PTRACE_SETSIGINFO) clear the si_faultflags field if it
> > detects that the signal would use the _sigfault layout, and introduce
> > a new ptrace request type, PTRACE_SETSIGINFO2, that a si_faultflags-aware
> > program may use to opt out of this behavior.
>
> I find this pretty fragile but maybe I have to read it a few more times
> to fully understand the implications ;).
>
> Could we instead copy all the fields, potentially uninitialised, and
> instead filter them when delivering the signal based on the
> SA_FAULTFLAGS? That means that the kernel only writes si_faultflags if
> the user requested it.

I don't see how that would help. The goal is to protect new signal
handlers from old signal "injectors" that will have potentially
uninitialized data where the si_faultflags field is. The new signal
handler will have SA_FAULTFLAGS set so that wouldn't prevent the
signal handler from seeing the uninitialized data.

> > v12:
> > - Change type of si_xflags to u32 to avoid increasing alignment
> [...]
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index 7aacf9389010..f43778355b77 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -91,7 +91,9 @@ union __sifields {
> >                               char _dummy_pkey[__ADDR_BND_PKEY_PAD];
> >                               __u32 _pkey;
> >                       } _addr_pkey;
> > +                     void *_pad[6];
> >               };
> > +             __u32 _faultflags;
> >  } _sigfault;
>
> Sorry, I haven't checked the previous discussion on alignment here but
> don't we already require 64-bit alignment because of other members in
> the _sigfault union? We already have void * throughout this and with the
> next patch we just have a gap (unless I miscalculated the offsets).

This is about avoiding increasing alignment on 32-bit platforms.
Currently the alignment is 4 but a u64 field would bump it to 8.

Unfortunately we can't do much about the gap on 64-bit platforms. This
was previously a uintptr_t but that would mean that the upper 32 bits
cannot be used safely on all platforms so we would effectively end up
with a gap anyway.

Peter
