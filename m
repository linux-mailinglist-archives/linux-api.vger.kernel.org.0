Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5702A4FD4
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCTRG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 14:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgKCTRF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Nov 2020 14:17:05 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C2C0613D1
        for <linux-api@vger.kernel.org>; Tue,  3 Nov 2020 11:17:05 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x11so7478026vsx.12
        for <linux-api@vger.kernel.org>; Tue, 03 Nov 2020 11:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeNKq+RMVF7+FugpeajXKON6Yw6JicmbbU/YCmxJF/4=;
        b=vsDlH0BcD7RvY9U9jVneQk/PcoxdAGtG3Z94NpEDaYmlVCjwOcbs5TUcjwicJ8i6Uw
         h8aokdIpJyALfxCOKt0bYErLJu85M81x/CDh6CVd6BsPSeNMiB3KINYJAQf/8uMbidf+
         5Mr6C8WcUY0eQvzzskwSvQ5bTj4IQFYBbMx+5+z01AKHUcSRIXM6wUq86K5KfwZjBhux
         YgxrAF8n1uGxs6o9wSfr48Vt/0j/X8Lr7ZaHGScl4SIFbH/Ulg4TrTeU70vQCWnhDacW
         1nEVsH3Uejg1V4whyS/j4XNs0hSDbByR3jjPD6SSv8VcCevH9qOg2ld8b6qp3roT3Qvw
         AqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeNKq+RMVF7+FugpeajXKON6Yw6JicmbbU/YCmxJF/4=;
        b=axHLZ4AfTAYcWS4bS3/ccMmpL5ai0YCi57dRuHn4oFzmqBtVPOkFpbpgtL/y1OnmiI
         1R7kajO5wyiZgR7FAFjbDF2VOrDhRmIZ99EDVoPk5Rdlizqqk9nXeDLP2yuHNEEEPFb/
         WchMoJw70LnQILPC5c+h9wK6AHLE4kBRm9mrnY3POIAkyIZ3CXeKjDv6iodtki7gkHn0
         uLvupfB/EaMFTyqWUR+/3YEa0OT8Fjzb5UjyvxKJ05NDaIQ35FKKaH3TCceJroLAgkTu
         pkInZDnAdYTCj+rasLQo3rQZaelcs4mYJKH1OkbckZhFN9JL3co5YLBAWvj0M/oWHmr4
         dcQA==
X-Gm-Message-State: AOAM532M1s19FBoIJqUSbmUruv/6AyLJHIrBN8nUHGejvBRlwpyJ4mu8
        KV47JGsCrA7OAkv3OfOnTpoP2m3VLuhE4L3RFKLBiA==
X-Google-Smtp-Source: ABdhPJzFZyE3265r1fZ1qG/AYxY7Z43Yhrj/YFrqoivZ4MpnwO+l/L4km2KQhr2xW6Mj88zeBkqyeYOQwOGfrHL1k0E=
X-Received: by 2002:a67:e210:: with SMTP id g16mr3922213vsa.28.1604431024493;
 Tue, 03 Nov 2020 11:17:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604376407.git.pcc@google.com> <c8a229473591a7bf98dc79e92403fe2de854ffef.1604376407.git.pcc@google.com>
 <20201103183321.GB81026@C02TF0J2HF1T.local>
In-Reply-To: <20201103183321.GB81026@C02TF0J2HF1T.local>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 3 Nov 2020 11:16:53 -0800
Message-ID: <CAMn1gO4q-7dEnCeF-PaL6K48jcpV-sJwnOSbT6JdL9NAd0XBWA@mail.gmail.com>
Subject: Re: [PATCH v13 8/8] arm64: expose FAR_EL1 tag bits in siginfo
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

On Tue, Nov 3, 2020 at 10:33 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Nov 02, 2020 at 08:09:44PM -0800, Peter Collingbourne wrote:
> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> > the tag bits may be needed by tools in order to accurately diagnose
> > memory errors, such as HWASan [1] or future tools based on the Memory
> > Tagging Extension (MTE).
> >
> > We should not stop clearing these bits in the existing fault address
> > fields, because there may be existing userspace applications that are
> > expecting the tag bits to be cleared. Instead, create a new pair of
> > union fields in siginfo._sigfault, and store the tag bits of FAR_EL1
> > there, together with a mask specifying which bits are valid.
>
> This comment is slightly confusing as they are not union fields in
> _sigfault.

Good catch, I will remove the word "union" here.

> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index f43778355b77..2b2ed0394457 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -94,6 +94,8 @@ union __sifields {
> >                       void *_pad[6];
> >               };
> >               __u32 _faultflags;
> > +             unsigned long _addr_tag_bits;
> > +             unsigned long _addr_tag_bits_mask;
> >       } _sigfault;
>
> Can we not actually add these as a struct to the union? Do we expect the
> other fields to be valid?

The idea is that the fields would be available for all si_codes,
including SEGV_MAPERR (which is important as I mention below). There's
no fundamental reason why the information shouldn't be made available
for BUS_MCEERR_*, SEGV_BNDERR or SEGV_PKUERR either, or other union
members that we may introduce in the future, just because they happen
to use a union member. Although we could retroactively add a union
member for currently non-union si_codes, and add new fields to the
current union members, that would basically be the same thing as
adding the new struct fields that I am adding here.

> Also there's a 32-bit gap I mentioned on the previous patch between
> _faultflags and _addr_tag_bits.

As I mentioned on the previous patch, I think the gap is unavoidable.

> That said, I wonder whether we could solve this for MTE without new
> fields by always setting the tag in si_addr when si_code is SEGV_MTE*.

This wouldn't solve the problem for MTE in the case where there is a
non-linear buffer overflow that extends into an unmapped page, in
which case we would get a SEGV_MAPERR that we would still need the tag
bits for.

> Alternatively, we could add a prctl() bit to require tagged si_addr.

It's an option that we considered but I would be concerned about the
compatibility implications of this. In practice, on Android we would
always have this bit set, so applications would be exposed to the tag
bits in si_addr. If applications have previously relied on the
documented behavior that the tag bits are unset, they may get confused
by them now being set. It also wouldn't provide a way for the kernel
to communicate which tag bits are valid.

Peter

> Well, I don't mind the _addr_tag_bits* fields if they are part of the
> union and keep si_addr intact.
>
> --
> Catalin
