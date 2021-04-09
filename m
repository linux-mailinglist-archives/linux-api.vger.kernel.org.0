Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC13335A873
	for <lists+linux-api@lfdr.de>; Fri,  9 Apr 2021 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhDIVor (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Apr 2021 17:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234719AbhDIVor (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Apr 2021 17:44:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81AEE61006
        for <linux-api@vger.kernel.org>; Fri,  9 Apr 2021 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618004673;
        bh=a/kaeUNYcF7//ieh1oEiBXj+7BcjAHHvsNrMfouzdE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gGDF6qDj9ZJHa9yBOkUCJ6974hheYKKbt3iUUFcq1AsOyPzmTc8H5nyB4HCaPaMJ/
         yvWJzb3WbVEkME0X8tB9hRl3MJVfIBpkWCIGSroVxgYz9ZoSWzhqIEPEseRsDEN2xw
         jsbuM4TPGz+LuDUHwA0HdWQhjDbohdpRZ2wwLE3ZbxI7JbojOlYou9X9ILxxpCl8vk
         jF6yFFUlC5dSr70E+pwM5acAFAgRh9xcLB9g9OJVRov1LnTPKX07zJQhZf23AEFa8v
         xtAKx76fjAXvuI2ADjd6xuCjArcHdmxgEe31Do4CURbKitgHDSG3+UhtXk6NBYbDte
         g3/6kO9ROgZZQ==
Received: by mail-ed1-f45.google.com with SMTP id ba6so8173507edb.1
        for <linux-api@vger.kernel.org>; Fri, 09 Apr 2021 14:44:33 -0700 (PDT)
X-Gm-Message-State: AOAM533/Cgn2ya1rJq6M1InbysfYYqMZ+7GsfTKyOm1/Cm/FanTAlhlc
        p/784d0ewPl9zF1Kd/lCQFjV0vExVm1BSMR2tqf+ig==
X-Google-Smtp-Source: ABdhPJz6NU2aDEU9x5zPavuQ8sQx+9aDxNPWx+FWEIMpOS/YBBpEmDZIIGjBEjb7+oPf7OwX9apqM1I0ObUbiBvRBS8=
X-Received: by 2002:aa7:c144:: with SMTP id r4mr4310485edp.222.1618004672078;
 Fri, 09 Apr 2021 14:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
 <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net> <CAJvTdK=Lqbzy6bs8qiE8MZ5LSzyZJ-FMUTcNPD4MxYJGEMBW3g@mail.gmail.com>
 <CALCETrW_5QDSo2sfEjBZSJ=Q3EsXTc03Unztn0Rq1caxqwtWpw@mail.gmail.com> <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com>
In-Reply-To: <CAJvTdKkDUywOUxb8Toth-7d4U4_S_9_EYHO38XqAPKc2_MXtdA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 9 Apr 2021 14:44:20 -0700
X-Gmail-Original-Message-ID: <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
Message-ID: <CALCETrXA-JzBWKdzBZJA8P+pPNKEkxNRPqLganWMpvm6KEUmCw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 9, 2021 at 1:53 PM Len Brown <lenb@kernel.org> wrote:
>
> On Wed, Mar 31, 2021 at 6:45 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Mar 31, 2021 at 3:28 PM Len Brown <lenb@kernel.org> wrote:
> >
> > > We added compiler annotation for user-level interrupt handlers.
> > > I'm not aware of it failing, or otherwise being confused.
> >
> > I followed your link and found nothing. Can you elaborate?  In the
> > kernel, we have noinstr, and gcc gives approximately no help toward
> > catching problems.
>
> A search for the word "interrupt" on this page
> https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#x86-Function-Attributes
> comes to the description of this attribute:
>
> __attribute__ ((interrupt))
>

I read that and I see no mention of anything saying "this will
generate code that does not touch extended state".  Instead I see,
paraphrasing, "this will generate code with an ABI that is completely
inappropriate for use in a user space signal handler".  Am I missing
something?

> > > dynamic XCR0 breaks the installed base, I thought we had established that.
> >
> > I don't think this is at all established.  If some code thinks it
> > knows the uncompacted XSTATE size and XCR0 changes, it crashes.  This
> > is not necessarily a showstopper.
>
> My working assumption is that crashing applications actually *is* a showstopper.
> Please clarify.

I think you're presuming that some program actually does this.  If no
program does this, it's not an ABI break.

More relevantly, this can only happen in a process that uses XSAVE and
thinks it knows the size that *also* does the prctl to change XCR0.
By construction, existing programs can't break unless they load new
dynamic libraries that break them.

>
> > > We've also established that when running in a VMM, every update to
> > > XCR0 causes a VMEXIT.
> >
> > This is true, it sucks, and Intel could fix it going forward.
>
> What hardware fix do you suggest?
> If a guest is permitted to set XCR0 bits without notifying the VMM,
> what happens when it sets bits that the VMM doesn't know about?

The VM could have a mask of allowed XCR0 bits that don't exist.

TDX solved this problem *somehow* -- XSETBV doesn't (visibly?) exit on
TDX.  Surely plain VMX could fix it too.

>
> > > I thought the goal was to allow new programs to have fast signal handlers.
> > > By default, those fast signal handlers would have a stable state
> > > image, and would
> > > not inherit large architectural state on their stacks, and could thus
> > > have minimal overhead on all hardware.
> >
> > That is *a* goal, but not necessarily the only goal.
>
> I fully support coming up with a scheme for fast future-proof signal handlers,
> and I'm willing to back that up by putting work into it.
>
> I don't see any other goals articulated in this thread.

Before we get too carried away with *fast* signal handlers, something
that works with existing programs is also a pretty strong goal.  RIght
now AVX-512 breaks existing programs, even if they don't use AVX-512.
