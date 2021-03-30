Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C036734E0DD
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 07:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC3Fu5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC3Fuk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 01:50:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD8C061762;
        Mon, 29 Mar 2021 22:50:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h3so11379229pfr.12;
        Mon, 29 Mar 2021 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QgWRK0H9F9FB1R751FgExYN4ePd5p4FsNL0/UDyqTls=;
        b=WkkxguVZJtrd2uX4cPxZtr9Iv+Ez7Kw+L9B7miD0gpmSUlkPiStFu1ylcjbfeGfJSo
         9vw7rg6aDq3Dv3mD7FwQiI/XyzqT+oieBP4E99z6VSf4yxfKRxRKYRgyx7Wz4B5veRYq
         +N0b47c89cA+geWKF27eerVU59KGAQUAo02fOZowa9DFSiq+y6WpNkC43X1vUlgxOtya
         XIKtD4AohoquaPY3XxzQlz3tWCgaQeRro6yhNdtTJzsvjCCYhTmOxEcH+vIKk4wGD8U+
         h+shmAlHNcI+pN0aFBYBVw0bNpHA9mBS5de5eIVmMJ+M8h16J4yl3QEAJfb+zwt9Pr+Y
         I+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QgWRK0H9F9FB1R751FgExYN4ePd5p4FsNL0/UDyqTls=;
        b=VwMidhU8MTiHrAIA+MCqtrq/Kn7CsD2ONuVYwMg/XVjIRMDFA4aqQgJGdXdFu3lyzC
         XXJxfJV8zwKfoLsg6x2PzTB0IOy3Lz0rMawutPL/QYO0ZjpVCcXDQGEAY9J+TJ0CGk5a
         tvR965O8NOE6PkOQkj+4/XK2FUDNPcQGdktdyUhqBXRB7vk/tRBmB0LxMMIklCs2C/Wn
         s1H/RFvp15RaueMqOldtY1iN+7dT1w1019ibuTJv1zdfHNtA0Orztq0k4lAgT8c4uKDR
         rz90DiWGjUCm96S1RB4K7Dn4K5tH/te5/k9TBCO4laZXmZXWPYRV7LDJPkT5ZG/BENU7
         hTqA==
X-Gm-Message-State: AOAM532et8UAupBqAs0o8Fj4Z5Gy2JCBnQm6EeSV+QgU5RE6KB4rj6PE
        0FN1q9g1WpMxKubISvSqXDWHQPYVei2FBYixV+M=
X-Google-Smtp-Source: ABdhPJwC9MaSrmqVdstRsWGqcB7W5wBHUvEy9zYjjuYDf9NT8zYkFyCVwmjvFm6006wG9MPq+LmtBIkltoqyynt/1jc=
X-Received: by 2002:aa7:9619:0:b029:1fa:ed79:b724 with SMTP id
 q25-20020aa796190000b02901faed79b724mr28117319pfg.38.1617083439910; Mon, 29
 Mar 2021 22:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
 <5F98327E-8EC4-455E-B9E1-74D2F13578C5@amacapital.net> <CAJvTdKkP=A4+gOoa+pDwinBf=dBKpe9=_ZFcpx_cFWjqG3p-XQ@mail.gmail.com>
 <CALCETrV_sQnu0u+wKZrAL2-500EHoQ6d4LgRhCWwRhK-4Z3X7A@mail.gmail.com>
In-Reply-To: <CALCETrV_sQnu0u+wKZrAL2-500EHoQ6d4LgRhCWwRhK-4Z3X7A@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Tue, 30 Mar 2021 01:50:29 -0400
Message-ID: <CAFUsyfK=kfvMW9Ug2t36hfV+OAbVHJ7dwy9dEvE3LMXYEvtmYQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Linux API <linux-api@vger.kernel.org>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Forgive if this is silly but would it be possible to do something
simliar to rseq where the user can register a set of features for a
program counter region and then on interrupt check that to determine
what needs to be saved?

For example if a user doesn't use any AMX but loads a library that
does, for all ip in the users code AMX state won't be saved but an
interrupt in ip range of the library will save AMX state.

One advantage of this is it would be pretty easy silently do this
right with compiler support and to preserve old code the "ip not found
in table" case could default to the worst case the CPU supports.

On Tue, Mar 30, 2021 at 1:09 AM Andy Lutomirski via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
> On Mon, Mar 29, 2021 at 3:38 PM Len Brown <lenb@kernel.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 2:16 PM Andy Lutomirski <luto@amacapital.net> w=
rote:
> > >
>
> > Hi Andy,
> >
> > Can you provide a concise definition of the exact problemI(s) this thre=
ad
> > is attempting to address?
>
> The AVX-512 state, all by itself, is more than 2048 bytes.  Quoting
> the POSIX sigaltstack page (man 3p sigaltstack):
>
>        The  value  SIGSTKSZ is a system default specifying the number of =
bytes
>        that would be used to cover the usual case when manually allocatin=
g  an
>        alternate  stack area. The value MINSIGSTKSZ is defined to be the =
mini=E2=80=90
>        mum stack size for a signal handler. In computing  an  alternate  =
stack
>        size, a program should add that amount to its stack requirements t=
o al=E2=80=90
>        low for the system implementation overhead. The  constants  SS_ONS=
TACK,
>        SS_DISABLE, SIGSTKSZ, and MINSIGSTKSZ are defined in <signal.h>.
>
> arch/x86/include/uapi/asm/signal.h:#define MINSIGSTKSZ    2048
> arch/x86/include/uapi/asm/signal.h:#define SIGSTKSZ    8192
>
> Regrettably, the Linux signal frame format is the uncompacted format
> and, also regrettably, the uncompacted format has the nasty property
> that its format depends on XCR0 but not on the set of registers that
> are actually used or wanted, so, with the current ABI, the signal
> frame is stuck being quite large for all programs on a machine that
> supports avx512 and has it enabled by the kernel.  And it's even
> larger for AMX and violates SIGSTKSZ as well as MINSTKSZ.
>
> There are apparently real programs that break as a result.  We need to
> find a way to handle new, large extended states without breaking user
> ABI.  We should also find a way to handle them without consuming silly
> amounts of stack space for programs that don't use them.
>
> Sadly, if the solution we settle on involves context switching XCR0,
> performance on first-generation hardware will suffer because VMX does
> not have any way to allow guests to write XCR0 without exiting.  I
> don't consider this to be a showstopper -- if we end up having this
> problem, fixing it in subsequent CPUs is straightforward.
>
> >
> > Thank ahead-of-time for excluding "blow up power consumption",
> > since that paranoia is not grounded in fact.
> >
>
> I will gladly exclude power consumption from this discussion, since
> that's a separate issue that has nothing to do with the user<->kernel
> ABI.
