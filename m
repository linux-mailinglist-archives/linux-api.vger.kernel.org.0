Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE535048B
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhCaQbu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 12:31:50 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:44908 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhCaQb2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 12:31:28 -0400
Received: by mail-ed1-f52.google.com with SMTP id j3so22984265edp.11;
        Wed, 31 Mar 2021 09:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oweZjjwop38EsR+FhQjGg4CvnspHSK7xcJXVqop9w7w=;
        b=JEvoh0jAxaeR5Fn0baKgOwx/t0QXPvOLY3OQUqE4hJeOYH99dxvj5T69vqepX2BxUS
         a6j+wN6mmI/kuSZZlKWZtzqAfJEK9woA6Z3d4vhUKeLeGjjwtyhfj0kJ/0iXIvkl35ep
         X6Cpf2WZnnD+9uNDkzqo7qRnm2gEpDjn4Hh/W2Lc0RgJCWpnR50gtBpijW2neRyHUG5A
         syIQWP5KPoVvI2LcEz4l9GeG6A/hpnIWaaC2sUyFyUbEbXAkJFnTvxTFH2fjxD8AiEUJ
         vD9PbRXQ5u/fh+RvK1bn1BV4R2i+KuU+ha8goPh14iLXxBSH6vsy0F1EMHTMBW6+D5gu
         xcPg==
X-Gm-Message-State: AOAM531yXn/+FPaiVwhSxY9Uhr10zjyD/o5ycKUV9LlVtjKTIH3Ob/S6
        +15IEm0Qr3oTSFPYmhitYC8O2RjvMDMzBiuqXrA=
X-Google-Smtp-Source: ABdhPJyx/SjornA6FNW5D3g0KangJ7zbgy74Uj8OaY2dy4QM25EW5wj+HzQ1r09VH6WBM1WGfM0CnkayxaKZfbA4+yc=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr4801329edc.94.1617208287371;
 Wed, 31 Mar 2021 09:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <d10affcb-d315-cebc-4162-084f0a1e4d43@intel.com>
 <F2653B18-239A-42BB-84EE-04F18B712279@amacapital.net> <CAJvTdKnwexRpHrLFQv+2ykK9WEqtXMwehjfa_D7T+O_8DO_CGA@mail.gmail.com>
 <4aa49572cc5f4797922352d1760f3ef4@AcuMS.aculab.com>
In-Reply-To: <4aa49572cc5f4797922352d1760f3ef4@AcuMS.aculab.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 31 Mar 2021 12:31:16 -0400
Message-ID: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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

On Tue, Mar 30, 2021 at 6:01 PM David Laight <David.Laight@aculab.com> wrote:

> > Can we leave it in live registers?  That would be the speed-of-light
> > signal handler approach.  But we'd need to teach the signal handler to
> > not clobber it.  Perhaps that could be part of the contract that a
> > fast signal handler signs?  INIT=0 AMX state could simply sit
> > patiently in the AMX registers for the duration of the signal handler.
> > You can't get any faster than doing nothing :-)
> >
> > Of course part of the contract for the fast signal handler is that it
> > knows that it can't possibly use XRESTOR of the stuff on the stack to
> > necessarily get back to the state of the signaled thread (assuming we
> > even used XSTATE format on the fast signal handler stack, it would
> > forget the contents of the AMX registers, in this example)
>
> gcc will just use the AVX registers for 'normal' code within
> the signal handler.
> So it has to have its own copy of all the registers.
> (Well, maybe you could make the TMX instructions fault,
> but that would need a nested signal delivered.)

This is true, by default, but it doesn't have to be true.

Today, gcc has an annotation for user-level interrupts
https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#x86-Function-Attributes

An analogous annotation could be created for fast signals.
gcc can be told exactly what registers and instructions it can use for
that routine.

Of course, this begs the question about what routines that handler calls,
and that would need to be constrained too.

Today signal-safety(7) advises programmers to limit what legacy signal handlers
can call.  There is no reason that a fast-signal-safety(7) could not be created
for the fast path.

> There is also the register save buffer that you need in order
> to long-jump out of a signal handler.
> Unfortunately that is required to work.
> I'm pretty sure the original setjmp/longjmp just saved the stack
> pointer - but that really doesn't work any more.
>
> OTOH most signal handlers don't care - but there isn't a flag
> to sigset() (etc) so ask for a specific register layout.

Right, the idea is to optimize for *most* signal handlers,
since making any changes to *all* signal handlers is intractable.

So the idea is that opting-in to a fast signal handler would opt-out
of some legacy signal capibilities.  Complete state is one of them,
and thus long-jump is not supported, because the complete state
may not automatically be available.

thanks,
Len Brown, Intel Open Source Technology Center
