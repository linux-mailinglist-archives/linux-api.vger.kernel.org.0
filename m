Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22934DBF6
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 00:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhC2Wic convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 29 Mar 2021 18:38:32 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39826 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhC2WiZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Mar 2021 18:38:25 -0400
Received: by mail-ed1-f51.google.com with SMTP id bf3so15953079edb.6;
        Mon, 29 Mar 2021 15:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H/vOEpWo/fUM47hOEde/opJk1H2zdUydMbYSM1IgaM0=;
        b=M6Dr8L4C6ex7PjTm4CWhvefKp16ZN3AdnKszxRRBklUWrz8bsWKpiz8VBioi/le6Gl
         IyQqGpauPnJF9eT5V4T/av+gm4gCxR0xPsSsZcAYaNRbpfXea6X9QXNnRzGQXY8yZ66A
         PrOOjIVzAu9U0LNSuPn2khLGxPmrV1Hfd7SCJD9lxgtE9oYyPZi7BN7CN4qpWtV+etbB
         OcqtAW2a1IEDkBfWAZFnD3NRKOpVpu8JBOeJGU7+EPUWp3svmUuPSqG5PG+R/Ssr0Z8S
         hAz8wjJrGE4OIWTG8dxvHN9d7/hXkOQg4dnvfSgavCJ0gIsmX69XAPsVharXhwDyO6VA
         TNDQ==
X-Gm-Message-State: AOAM5322PVaR353rvFbhbL7lPfIBuk+FooQNz+9g81grJcXIp9KhzJ7W
        YDJrdcML7S0fmHzipc7NhLKaEgx4+E7HlyE29qY=
X-Google-Smtp-Source: ABdhPJzzQA34H03pyldj1iynnSyadZmeba9NOdtM0YjOuxa42OL5jWafWTOJ6lF9dyrTXGAqjyYqLQpfMtwcyL4eZSs=
X-Received: by 2002:aa7:d917:: with SMTP id a23mr30782097edr.122.1617057504671;
 Mon, 29 Mar 2021 15:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
 <5F98327E-8EC4-455E-B9E1-74D2F13578C5@amacapital.net>
In-Reply-To: <5F98327E-8EC4-455E-B9E1-74D2F13578C5@amacapital.net>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 18:38:13 -0400
Message-ID: <CAJvTdKkP=A4+gOoa+pDwinBf=dBKpe9=_ZFcpx_cFWjqG3p-XQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 29, 2021 at 2:16 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Mar 29, 2021, at 8:47 AM, Len Brown <lenb@kernel.org> wrote:
> >
> > ﻿On Sat, Mar 27, 2021 at 5:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>> On Fri, Mar 26, 2021 at 11:39:18PM -0400, Len Brown wrote:
> >>> Hi Andy,
> >>> Say a mainline links with a math library that uses AMX without the
> >>> knowledge of the mainline.
> >
> > sorry for the confusion.
> >
> > mainline = main().
> >
> > ie. the part of the program written by you, and not the library you linked with.
> >
> > In particular, the library may use instructions that main() doesn't know exist.
>
> If we pretend for a bit that AMX were a separate device instead of a part of the CPU, this would be a no brainer: something would be responsible for opening a device node or otherwise requesting access to the device.
>
> Real AMX isn’t so different. Programs acquire access either by syscall or by a fault, they use it, and (hopefully) they release it again using TILERELEASE. The only thing special about it is that, supposedly, acquiring and releasing access (at least after the first time) is quite fast.  But holding access is *not* free — despite all your assertions to the contrary, the kernel *will* correctly context switch it to avoid blowing up power consumption, and this will have overhead.
>
> We’ve seen the pattern of programs thinking that, just because something is a CPU insn, it’s free and no thought is needed before using it. This happened with AVX and AVX512, and it will happen again with AMX. We *still* have a significant performance regression in the kernel due to screwing up the AVX state machine, and the only way I know about any of the details is that I wrote silly test programs to try to reverse engineer the nonsensical behavior of the CPUs.
>
> I might believe that Intel has figured out how to make a well behaved XSTATE feature after Intel demonstrates at least once that it’s possible.  That means full documentation of all the weird issues, no new special cases, and the feature actually making sense in the context of XSTATE.  This has not happened.  Let’s list all of them:
>
> - SSE.  Look for all the MXCSR special cases in the pseudocode and tell me with a straight face that this one works sensibly.
>
> - AVX.  Also has special cases in the pseudocode. And has transition issues that are still problems and still not fully documented. L
>
> - AVX2.  Horrible undocumented performance issues.  Otherwise maybe okay?
>
> - MPX: maybe the best example, but the compat mode part got flubbed and it’s MPX.
>
> - PKRU: Should never have been in XSTATE. (Also, having WRPKRU in the ISA was a major mistake, now unfixable, that seriously limits the usefulness of the whole feature.  I suppose Intel could release PKRU2 with a better ISA and deprecate the original PKRU, but I’m not holding my breath.)
>
> - AVX512: Yet more uarch-dependent horrible performance issues, and Intel has still not responded about documentation.  The web is full of people speculating differently about when, exactly, using AVX512 breaks performance. This is NAKked in kernel until docs arrive. Also, it broke old user programs.  If we had noticed a few years ago, AVX512 enablement would have been reverted.
>
> - AMX: This mess.
>
> The current system of automatic user enablement does not work. We need something better.

Hi Andy,

Can you provide a concise definition of the exact problemI(s) this thread
is attempting to address?

Thank ahead-of-time for excluding "blow up power consumption",
since that paranoia is not grounded in fact.

thanks,
-Len
