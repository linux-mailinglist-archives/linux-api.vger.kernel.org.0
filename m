Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70873766
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfGXTIW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 15:08:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37631 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGXTIW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 15:08:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so35842390oih.4
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ2NVnXSi8ebOI8TCeX+KEiumjRr37taJEiDBtLAzIw=;
        b=ay7nQDJto1uXe3PyisCCQ4jh0O1tS2wQekngxDHnkudc+mm443mhyxwIylnVi04ikq
         p+0MRA6sMLXHIiw/hlRdeEzcIyX0AQkLLglriGAU52YI7GUxDDL3uP7O8MbdaG5x324/
         s1IQjOXptoKEECbr2VtO00HQSZl+DWrRVKCPcaWpsiz6AkLZW3DHJTI1mI76g4GCPhrP
         uohpgu8+vHc5tGBhon5LNnF9mroUP4HVW7iavecvv1zAtnAu+zBPOqE1k1qppbUtbE9V
         CNbTUQ1m1b1++BkjeJrUj6Gkwei+gseZ/u8ExpXPnBE+5vHE2NJCJ2+XGnA32KgepmdE
         /ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ2NVnXSi8ebOI8TCeX+KEiumjRr37taJEiDBtLAzIw=;
        b=o3nlEFQWC63s9pi7E8mBOFhHcVnFcP7mW2Jzb9T/Z8kkLbgQ+7yG35c9CavGGj2VDY
         6z9DYzJtyv3OpjK4tLq9dJhTemPQaKqd46a89INbESZZsYceDbbNj6VA/TEEoZBSTCxG
         fn9VLwbafR/1zc3jfiuktFTjADHuLTwInj9DLxuKpCv/+sCnyqbFex7hwavEKthyh3Tp
         qlmSkzZkW2Xk+1IkKtfjbkYWBWCp6bMEeLZzESPYxtcSLFTJm7TV/bwVj8I7CJjCgKyP
         0eS2uIST2PezrSxpO2QxwEUgnMkWjQczFr2ZfphzfqXn+w+DnvZRahTuX35rVPHyntsn
         ECmw==
X-Gm-Message-State: APjAAAWHqS/xJrMBAm6lJcKLAVb2TzwzuANN6bg7mqcElJbDaAWh480I
        igR+5Xpmq9NCVFfytQemS616Pd09sAhXHbMPWriO0w==
X-Google-Smtp-Source: APXvYqya48iVqoqwk4kONppwXP1DXBm/5PjXHOXJTQ4D06+WTxrfuvoiUNL7MT9p6MSQpW48esX92p8qWTHWS+W8MI0=
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr37653038oia.47.1563995300490;
 Wed, 24 Jul 2019 12:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-5-christian@brauner.io>
 <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com> <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io>
In-Reply-To: <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 24 Jul 2019 21:07:54 +0200
Message-ID: <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
To:     Christian Brauner <christian@brauner.io>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel-team <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 24, 2019 at 8:27 PM Christian Brauner <christian@brauner.io> wrote:
> On July 24, 2019 8:14:26 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> >On Wed, Jul 24, 2019 at 4:48 PM Christian Brauner
> ><christian@brauner.io> wrote:
> >> If CLONE_WAIT_PID is set the newly created process will not be
> >> considered by process wait requests that wait generically on children
> >> such as:
> >>
> >>         syscall(__NR_wait4, -1, wstatus, options, rusage)
> >>         syscall(__NR_waitpid, -1, wstatus, options)
> >>         syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
> >>         syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
> >>         syscall(__NR_waitpid, -pid, wstatus, options)
> >>         syscall(__NR_wait4, -pid, wstatus, options, rusage)
> >>
> >> A process created with CLONE_WAIT_PID can only be waited upon with a
> >> focussed wait call. This ensures that processes can be reaped even if
> >> all file descriptors referring to it are closed.
> >[...]
> >> diff --git a/kernel/fork.c b/kernel/fork.c
> >> index baaff6570517..a067f3876e2e 100644
> >> --- a/kernel/fork.c
> >> +++ b/kernel/fork.c
> >> @@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct
> >*copy_process(
> >>         delayacct_tsk_init(p);  /* Must remain after
> >dup_task_struct() */
> >>         p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
> >>         p->flags |= PF_FORKNOEXEC;
> >> +       if (clone_flags & CLONE_WAIT_PID)
> >> +               p->flags |= PF_WAIT_PID;
> >>         INIT_LIST_HEAD(&p->children);
> >>         INIT_LIST_HEAD(&p->sibling);
> >>         rcu_copy_process(p);
> >
> >This means that if a process with PF_WAIT_PID forks, the child
> >inherits the flag, right? That seems unintended? You might have to add
> >something like "if (clone_flags & CLONE_THREAD == 0) p->flags &=
> >~PF_WAIT_PID;" before this. (I think threads do have to inherit the
> >flag so that the case where a non-leader thread of the child goes
> >through execve and steals the leader's identity is handled properly.)
> >Or you could cram it somewhere into signal_struct instead of on the
> >task - that might be a more logical place for it?
>
> Hm, CLONE_WAIT_PID is only useable with CLONE_PIDFD which in turn is
> not useable with CLONE_THREAD.
> But we should probably make that explicit for CLONE_WAIT_PID too.

To clarify:

This code looks buggy to me because p->flags is inherited from the
parent, with the exception of flags that are explicitly stripped out.
Since PF_WAIT_PID is not stripped out, this means that if task A
creates a child B with clone(CLONE_WAIT_PID), and then task B uses
fork() to create a child C, then B will not be able to use
wait(&status) to wait for C since C inherited PF_WAIT_PID from B.

The obvious way to fix that would be to always strip out PF_WAIT_PID;
but that would also be wrong, because if task B creates a thread C,
and then C calls execve(), the task_struct of B goes away and B's TGID
is taken over by C. When C eventually exits, it should still obey the
CLONE_WAIT_PID (since to A, it's all the same process). Therefore, if
p->flags is used to track whether the task was created with
CLONE_WAIT_PID, PF_WAIT_PID must be inherited if CLONE_THREAD is set.
So:

diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..b32e1e9a6c9c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1902,6 +1902,10 @@ static __latent_entropy struct task_struct *copy_process(
        delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
        p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
        p->flags |= PF_FORKNOEXEC;
+       if (!(clone_flags & CLONE_THREAD))
+               p->flags &= ~PF_PF_WAIT_PID;
+       if (clone_flags & CLONE_WAIT_PID)
+               p->flags |= PF_PF_WAIT_PID;
        INIT_LIST_HEAD(&p->children);
        INIT_LIST_HEAD(&p->sibling);
        rcu_copy_process(p);

An alternative would be to not use p->flags at all, but instead make
this a property of the signal_struct - since the property is shared by
all threads, that might make more sense?
