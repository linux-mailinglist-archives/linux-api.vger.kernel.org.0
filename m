Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D495B462874
	for <lists+linux-api@lfdr.de>; Tue, 30 Nov 2021 00:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhK2XnH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 18:43:07 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:37817 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhK2XnG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 18:43:06 -0500
Received: by mail-ua1-f43.google.com with SMTP id o1so37641945uap.4
        for <linux-api@vger.kernel.org>; Mon, 29 Nov 2021 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7M8bjVkZS4Crx9n4ZGGz1oMJSYLhjEhdQ0JNSPjlt8=;
        b=V35tdCUBBDMXJ7fCiyIuqsXXPU6QrRaT/GWOg2xVg1xzv9E5BFQ9W2UkyjwlXj2KaF
         9XkB2/ifBLIKQUxvo4amGtjsEPf6PcquFjfc2/JGz/0Qgawp9Sh6ArGxEZP/v8fX1dbx
         NghpiQwCtWy/9xielIZZzVDQxmEpglv71V4Rmy99Al84IfweaGcbTjztI6rz3ObcRPqS
         nbCpI/ai5Ewqm6hXwvWFy7quXey5FxlQCjOQZGWm6l89751vvnW4xp0VivyHXIo3mCcQ
         MCZtlRJQIATPZXw8FG4Q+fMEtxyP8IswiZlyChOMOMiFNLul2jtLwfedipIcZBH5OvP4
         Iqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7M8bjVkZS4Crx9n4ZGGz1oMJSYLhjEhdQ0JNSPjlt8=;
        b=Cty5iEKgX1O+wMxS6PNol8zO3GhVAl5kV7XU91Xtw+4R2rHzvzwV7Ftqh2HMSuyqhP
         ayQvawTvo0C69R48AyGu4Op4Gh2FdD1v10qyfEt0hKW42mx9R5LyrkGKxvhjF537RLo+
         pcQh4zWKtsz0HE3XGFpZfVvIQ6xhA8gJNndnT4fDFRgjEnFpdXL2NJZNZUou/hbQqMTZ
         oBOLZDTIoDGltqJ8riU8US0NECmDkXgmJ8bFNfsva/sIaBq1WVRSjyeJZjVdNgk378jm
         UF6UE6J79i77v1iEQxsfzbok8r8JYIIMRlSdItxXzaWqA+7aSx+xBUqOwCNBp+DqdQ/r
         q+3g==
X-Gm-Message-State: AOAM531y1CReEDqttCSAlZOCdDFYUaVu+6K3BbEYP0pzRlWaAy0Gencb
        Gb+aUqN9dkkO9aF7oln/K6lsSSlj8UuFCqCREFURbA==
X-Google-Smtp-Source: ABdhPJyQvp4x5bByQwLpBEygbxk1oCfNM99yBAAEpPNfSg1xfZNjK+9yDN/dWx3ThizfuvtRLx8gzzf2dPwNKXRRRVI=
X-Received: by 2002:a9f:218c:: with SMTP id 12mr51476140uac.71.1638229128058;
 Mon, 29 Nov 2021 15:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20211122211327.5931-1-posk@google.com> <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net> <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net> <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <20211129210841.GO721624@worktop.programming.kicks-ass.net>
In-Reply-To: <20211129210841.GO721624@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 29 Nov 2021 15:38:38 -0800
Message-ID: <CAFTs51XyGDNj89+FCn4HZqMHuenjQu2wqTOW8ow4hSUbdGrGhw@mail.gmail.com>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 29, 2021 at 1:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > > > Another big concern I have is that you removed UMCG_TF_LOCKED. I
> > >
> > > OOh yes, I forgot to mention that. I couldn't figure out what it was
> > > supposed to do.
[...]
>
> So then A does:
>
>         A::next_tid = C.tid;
>         sys_umcg_wait();
>
> Which will:
>
>         pin(A);
>         pin(S0);
>
>         cmpxchg(A::state, RUNNING, RUNNABLE);

Hmm.... That's another difference between your patch and mine: my
approach was "the side that initiates the change updates the state".
So in my code the userspace changes the current task's state RUNNING
=> RUNNABLE and the next task's state, or the server's state, RUNNABLE
=> RUNNING before calling sys_umcg_wait(). The kernel changed worker
states to BLOCKED/RUNNABLE during block/wake detection, and marked
servers RUNNING when waking them during block/wake detection; but all
applicable state changes for sys_umcg_wait() happen in the userspace.

The reasoning behind this approach was:
- do in kernel only that which cannot be done in the userspace, to
make the kernel code smaller/simpler
- similar to how futexes work: futex_wait does not change the futex
value to the desired value, but just checks whether the futex value
matches the desired value
- similar to how futexes work, concurrent state changes can happen in
the userspace without calling into the kernel at all
    for example:
        - (a): worker A goes to sleep into sys_umcg_wait()
        - (b): worker B wants to context switch into worker A "a moment" later
        - due to preemption/interrupts/pagefaults/whatnot, (b) happens
in reality before (a)
    in my patchset, the situation above happily resolves in the
userspace so that worker A keeps running without ever calling
sys_umcg_wait().

Again, I don't think this is deal breaking, and your approach will
work, just a bit less efficiently in some cases :)

I'm still not sure we can live without UMCG_TF_LOCKED. What if worker
A transfers its server to worker B that A intends to context switch
into, and then worker A pagefaults or gets interrupted before calling
sys_umcg_wait()? The server will be woken up and will see that it is
assigned to worker B; now what? If worker A is "locked" before the
whole thing starts, the pagefault/interrupt will not trigger
block/wake detection, worker A will keep RUNNING for all intended
purposes, and eventually will call sys_umcg_wait() as it had
intended...

[...]
