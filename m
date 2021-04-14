Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9A35F252
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350279AbhDNLZw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350284AbhDNLZW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 07:25:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA39C06138C
        for <linux-api@vger.kernel.org>; Wed, 14 Apr 2021 04:24:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so2155370lfa.2
        for <linux-api@vger.kernel.org>; Wed, 14 Apr 2021 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuhKmn9FYt80c9ROH/y1oStEmOA02E9r2ZFVc64O4vU=;
        b=h8GWyIwQyu60pOCe4C60MthHMqT5pMO47tMHYURZaLLnjuqqmRLPPW3NxTj3zmgCkq
         J9MJdes7wg290CO9mdRjSDufx1MJ88id5lkJr9CrTxpgHv7xmqwSq4HV/wDPoLhiLN3I
         Zjgr9bP+xMv1I85lpUGUO6rdq+4JRxq2NMzd9rxJD5kq/BEGlCxTHtSMhZtJgvZTgSx2
         bl/VKJ7ykaGdB5iExvBHq0VwnYzGl8AH1TfgUwPqcMFyGrgg5I3pGLUqiUVWXnLRpkGS
         Iavi/tLjCf/cv1wGSfges1YuQVHuiVRsVl0V6Ds2Lkhu5rUQlPEKdH7YLOGzzGPQwSXk
         DEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuhKmn9FYt80c9ROH/y1oStEmOA02E9r2ZFVc64O4vU=;
        b=Pvm2hemHWOAnKH2FDiNL32djPCx2LoK3YvueufLpxL+bcbPV+CPtaJR7KAIHe2p423
         SISifciCIbANkI6kw6v5bTKbzSef0fBCBR1y3rddSQpsL21lmtq+AGlNDw8yUpKXZ/Sq
         7k15yuI1u1GlqrGLF27hUm1T0bdIxbZMQAPaR9vcedOLWqExIhsu17AVeN4YueBYifFL
         bWmWzr7MCSi7Zk0QuiRyfYIzFkyiHOqdO3f/7XzUhETWj16o4iffxxBYzzYFB4awEumK
         Ot/klQkgNhyMBVm+m53KNUlBxgPPPithDxY25gj3WToWc921NWZZD00lVDVh7gj38xih
         z7pA==
X-Gm-Message-State: AOAM531A6OFiZniZR1Xu9VKZ7sgGUWUyEMCVBW/NV/cdFX311NLh1DWf
        Ctl3H/zt4mtMKS/2rl5OzRtkZ4JAvW3bQ+RLMd0uCg==
X-Google-Smtp-Source: ABdhPJypOoKb7zY0yopEiDor+KdM+gPLg/z4FR7SXyJJUzfRhluH65oC8mcVTQMJQu7oVHUsLhEKzfAVrRZWsg1i2G0=
X-Received: by 2002:ac2:5cae:: with SMTP id e14mr11595625lfq.69.1618399497182;
 Wed, 14 Apr 2021 04:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <87blahb1pr.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87blahb1pr.fsf@oldenburg.str.redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 14 Apr 2021 13:24:30 +0200
Message-ID: <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org,
        Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 12:27 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Andrei Vagin:
>
> > We already have process_vm_readv and process_vm_writev to read and write
> > to a process memory faster than we can do this with ptrace. And now it
> > is time for process_vm_exec that allows executing code in an address
> > space of another process. We can do this with ptrace but it is much
> > slower.
> >
> > = Use-cases =
>
> We also have some vaguely related within the same address space: running
> code on another thread, without modifying its stack, while it has signal
> handlers blocked, and without causing system calls to fail with EINTR.
> This can be used to implement certain kinds of memory barriers.

That's what the membarrier() syscall is for, right? Unless you don't
want to register all threads for expedited membarrier use?

> It is
> also necessary to implement set*id with POSIX semantics in userspace.
> (Linux only changes the current thread credentials, POSIX requires
> process-wide changes.)  We currently use a signal for set*id, but it has
> issues (it can be blocked, the signal could come from somewhere, etc.).
> We can't use signals for barriers because of the EINTR issue, and
> because the signal context is stored on the stack.

This essentially becomes a question of "how much is set*id allowed to
block and what level of guarantee should there be by the time it
returns that no threads will perform privileged actions anymore after
it returns", right?

Like, if some piece of kernel code grabs a pointer to the current
credentials or acquires a temporary reference to some privileged
resource, then blocks on reading an argument from userspace, and then
performs a privileged action using the previously-grabbed credentials
or resource, what behavior do you want? Should setuid() block until
that privileged action has completed? Should it abort that action
(which is kinda what you get with the signals approach)? Should it
just return immediately even though an attacker who can write to
process memory at that point might still be able to influence a
privileged operation that hasn't read all its inputs yet? Should the
kernel be designed to keep track of whether it is currently holding a
privileged resource? Or should the kernel just specifically permit
credential changes in specific places where it is known that a task
might block for a long time and it is not holding any privileged
resources (kinda like the approach taken for freezer stuff)?

If userspace wants multithreaded setuid() without syscall aborting,
things get gnarly really fast; and having an interface to remotely
perform operations under another task's context isn't really relevant
to the core problem here, I think.
