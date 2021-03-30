Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252D034E091
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 07:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhC3FJZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 01:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC3FJM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 30 Mar 2021 01:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10C0061927
        for <linux-api@vger.kernel.org>; Tue, 30 Mar 2021 05:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617080952;
        bh=eRihny9hogI295O5z040VauExeekQ3CI+ExVGM94lUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F3lF1/CsZHRFJwWUN+rbXGJUv0dzn3oDgjLKQcuY4EDCEm/Cs/Mp2WP9iGYlWgtDX
         /I/jejvf1oksy6390dlc67/C16VSuz86LVJ6cQoRmgY6x0oVaIIX/WpeCF2rswywwA
         k9cLwRgncO9Cl6+4BI8ayNC1SymtBhoSAeIZ4FPoBz6GoKiMwpQLBaRk2hBZEcu0sc
         H7VmSIsmjE+I+5dbgb7GrWykvAgVzeBLOptRIfmgptqUEMIzs1z2i4tqPr/If3hxGE
         sXjXJhDbpofSFnrpvhR0l3C/+UvsIVAJwlSfUxbG6nmkSH41g9oKvVxvfmEg3i0gAd
         Hkdj+Qoc7w4pA==
Received: by mail-ej1-f43.google.com with SMTP id e14so22768257ejz.11
        for <linux-api@vger.kernel.org>; Mon, 29 Mar 2021 22:09:11 -0700 (PDT)
X-Gm-Message-State: AOAM532EnY0pZmzNyTvSSr99zeHi0ggbicbyvj2BMttZvvd2SnFympQb
        3MCfeY2R67ZwdeRYZR5zBTaZzQ6r4zKjlfYrA4ShFw==
X-Google-Smtp-Source: ABdhPJz/SFX5v5j9802t2y+m7lzns1hxQxZ1GiDwvEHCIsmJFKimY0Pc8R7ohG9BdboZBKmeH4OjUU9PhySzHTPZ5Kc=
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr31343851ejb.503.1617080950596;
 Mon, 29 Mar 2021 22:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
 <5F98327E-8EC4-455E-B9E1-74D2F13578C5@amacapital.net> <CAJvTdKkP=A4+gOoa+pDwinBf=dBKpe9=_ZFcpx_cFWjqG3p-XQ@mail.gmail.com>
In-Reply-To: <CAJvTdKkP=A4+gOoa+pDwinBf=dBKpe9=_ZFcpx_cFWjqG3p-XQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Mar 2021 22:08:59 -0700
X-Gmail-Original-Message-ID: <CALCETrV_sQnu0u+wKZrAL2-500EHoQ6d4LgRhCWwRhK-4Z3X7A@mail.gmail.com>
Message-ID: <CALCETrV_sQnu0u+wKZrAL2-500EHoQ6d4LgRhCWwRhK-4Z3X7A@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 29, 2021 at 3:38 PM Len Brown <lenb@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 2:16 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> >

> Hi Andy,
>
> Can you provide a concise definition of the exact problemI(s) this thread
> is attempting to address?

The AVX-512 state, all by itself, is more than 2048 bytes.  Quoting
the POSIX sigaltstack page (man 3p sigaltstack):

       The  value  SIGSTKSZ is a system default specifying the number of by=
tes
       that would be used to cover the usual case when manually allocating =
 an
       alternate  stack area. The value MINSIGSTKSZ is defined to be the mi=
ni=E2=80=90
       mum stack size for a signal handler. In computing  an  alternate  st=
ack
       size, a program should add that amount to its stack requirements to =
al=E2=80=90
       low for the system implementation overhead. The  constants  SS_ONSTA=
CK,
       SS_DISABLE, SIGSTKSZ, and MINSIGSTKSZ are defined in <signal.h>.

arch/x86/include/uapi/asm/signal.h:#define MINSIGSTKSZ    2048
arch/x86/include/uapi/asm/signal.h:#define SIGSTKSZ    8192

Regrettably, the Linux signal frame format is the uncompacted format
and, also regrettably, the uncompacted format has the nasty property
that its format depends on XCR0 but not on the set of registers that
are actually used or wanted, so, with the current ABI, the signal
frame is stuck being quite large for all programs on a machine that
supports avx512 and has it enabled by the kernel.  And it's even
larger for AMX and violates SIGSTKSZ as well as MINSTKSZ.

There are apparently real programs that break as a result.  We need to
find a way to handle new, large extended states without breaking user
ABI.  We should also find a way to handle them without consuming silly
amounts of stack space for programs that don't use them.

Sadly, if the solution we settle on involves context switching XCR0,
performance on first-generation hardware will suffer because VMX does
not have any way to allow guests to write XCR0 without exiting.  I
don't consider this to be a showstopper -- if we end up having this
problem, fixing it in subsequent CPUs is straightforward.

>
> Thank ahead-of-time for excluding "blow up power consumption",
> since that paranoia is not grounded in fact.
>

I will gladly exclude power consumption from this discussion, since
that's a separate issue that has nothing to do with the user<->kernel
ABI.
