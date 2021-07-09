Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB813C1DFC
	for <lists+linux-api@lfdr.de>; Fri,  9 Jul 2021 06:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhGIEEi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Jul 2021 00:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhGIEEi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Jul 2021 00:04:38 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0663C06175F
        for <linux-api@vger.kernel.org>; Thu,  8 Jul 2021 21:01:54 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id e7so3071883uaj.11
        for <linux-api@vger.kernel.org>; Thu, 08 Jul 2021 21:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kU7mIahdf17uc/YUxP3/0m6kQxo6m6etwzXnDCR7CzU=;
        b=d25FxB+l0wty8se7vQosoH5VYN4iNgiic8jmqqiJz6ikwHXvxPF3wL2cPGhwXOvyYN
         y6Rvp2rv/0bOsDxyG5yjvJ2vvBwmVcMAivDY6LEF/RxV2P2RC76BKHq0OoIWodAf7BaT
         MV+XMWVfgKK+lld3ebA4Yo5eqPH9PpPj1E63zfTDmTXEo0g/+mrYKCIzia2ZBH+6PBmb
         0MdZTgzYCWgK+U3NK78dEFQbqp4gLVFjwru7VY8wXJ9h4HbGVUQqaOiwx9o6A3Kkg8Xb
         TOmV9fBTeB4LmQX1GpxyiNrADk1AVkjpiBd/kGbMs66zc3nAtN/NcT3tdm8LCyD/iWVc
         qUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kU7mIahdf17uc/YUxP3/0m6kQxo6m6etwzXnDCR7CzU=;
        b=gKYGa4M0LHWvMSPiH/ICioZdiwb/CCIl/retgNzOCKayvyUqB3/MhP+h6bD3DI5jvy
         dJbWjK2HcUlBOj0+yn6R5C/fbrAMLGzJVzfvgwU1iTSwM+rAPlTFhMXE2Yr2rIRMK+uY
         7eih5nXNIPfGQx5ve4jegmmatce9i2LV4D1zminUEKNQx8L0NPM9qY3oKrtwJNEp+S4c
         54nDpMGLYH9qKERWkzcj6z7ZyFUryUA4nzQmQ9QY0lQTVPaQLEJWv9dX7J1JHvOMZ3tW
         ul5oAkWRQvsQl4cgvNOPlDub8sUtSMc/jX9HaljrIUnwBtjBzJCQwDPCd7vXLDfNe0a+
         p3qQ==
X-Gm-Message-State: AOAM5302Xtu3qDOcSe6eReOTM+UhBxTSrB4rj4YCRxTZh4lI5jgXlXK5
        l9MqDF2NX1bFQ+gZmEisAe0NcG/HHaQtKSnwAPZKpw==
X-Google-Smtp-Source: ABdhPJyPBPd4XFihdoaexkTWrpSigqRxb/D6xuBsTNUhAr1VAHuP7lnokUWbxpgiPMSMD1mLeQvQ02oTYqe/YR8l7q8=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr33621682uak.120.1625803313687;
 Thu, 08 Jul 2021 21:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-3-posk@google.com>
 <CAG48ez3LxrPva9Kxtn1DVhJWxhn3hvJ5oeDwXcrEeK_UvGh0UA@mail.gmail.com>
In-Reply-To: <CAG48ez3LxrPva9Kxtn1DVhJWxhn3hvJ5oeDwXcrEeK_UvGh0UA@mail.gmail.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Thu, 8 Jul 2021 21:01:43 -0700
Message-ID: <CAFTs51Ws=ChjNT4S1A1UVXBOGz9O074QWgyRsG+pSj=ba8VNzg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic helpers
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 8, 2021 at 2:12 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jul 8, 2021 at 9:46 PM Peter Oskolkov <posk@posk.io> wrote:
> > Add helper functions to work atomically with userspace 32/64 bit values -
> > there are some .*futex.* named helpers, but they are not exactly
> > what is needed for UMCG; I haven't found what else I could use, so I
> > rolled these.
> >
> > At the moment only X86_64 is supported.
> >
> > Note: the helpers should probably go into arch/ somewhere; I have
> > them in kernel/sched/umcg.h temporarily for convenience. Please
> > let me know where I should put them and how to name them.
>
> Instead of open-coding spinlocks in userspace memory like this (which
> some of the reviewers will probably dislike because it will have
> issues around priority inversion and such), I wonder whether you could
> use an actual futex as your underlying locking primitive?
>
> The most straightforward way to do that would probably be to make the
> head structure in userspace look roughly like this?
>
> struct umcg_head {
>   u64 head_ptr;
>   u32 lock;
> };
>
> and then from kernel code, you could build a fastpath that directly
> calls cmpxchg_futex_value_locked() and build a fallback based on
> do_futex(), or something like that.
>
> There is precedent for using futex from inside the kernel to
> communicate with userspace: See mm_release(), which calls do_futex()
> with FUTEX_WAKE for the clear_child_tid feature.

Hi Jann,

Thanks for the note!

The approach you suggest will require locking every operation, I
believe, while in the scheme I have pushes/inserts are lock-free if
there are no concurrent pops/deletes. And the kernel does mostly
pushes (waking workers, and there can be a lot of workers), while pops
are rare (idle servers, and there is no reason for the number of
servers to exceed the number of CPUs substantially, and if there is
contention here, it will be very short-lived), while the userspace
will pop the entire stack of idle workers in one op (so a short lock
as well). So I think my approach scales better. And priority inversion
should not matter here, because this is for userspace scheduling, and
so the userspace scheduler should worry about it, not the kernel.

Am I missing something?

Thanks,
Peter
