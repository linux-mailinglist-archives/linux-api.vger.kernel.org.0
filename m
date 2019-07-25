Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0774B3D
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbfGYKLa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 06:11:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40222 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388854AbfGYKL2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 06:11:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so49692118eds.7
        for <linux-api@vger.kernel.org>; Thu, 25 Jul 2019 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7EQ+7uYH5vJtbr6a8vV+faYrRnI6gJaVUZG7dNfidaM=;
        b=F9zrkAlZeSCmB1vNyjn/KUm7Nri3LuruI7GxPWi7eZVgv+Ax9JzHqSr4zQLzAaALur
         tp+VRZf2q75pyp6bkgcql7RQx78gSS+Jcs7p6IYK7oFavDSpZuk6KGD7WY3AXv0p506q
         pYdiWNQ9WMIex4/S3jX77xCxZ9jqEXFVAmMoxC1iR6LihcRXN+UebhpgJcE4GA1JPR8h
         JvTkiN1Y7rARjkh5KWh7j3mUdCG6U99rDjfKR8abObPiD6odsn+vKgBRh4wXcIubCNOp
         4I8F4ZtOES7Zg10RnYeDUCMYgTmv/37jLPHLUGFR/oYL5InWYV7mm9B0q5pCgzwrducU
         peuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EQ+7uYH5vJtbr6a8vV+faYrRnI6gJaVUZG7dNfidaM=;
        b=uJ3sgooBhsWMLJpjzz57RD2/5t488DNu7JZDqvvZ+G22RCEZUmEZY5MKrFf/0Sc94z
         73pKVDoNCRzPUWAbjLXiyJOowKOcxX38501/HcsYX3rXKnhK2Q/E6eCP22o6UqxEhAVK
         g31lNOBvdM+qBsqPd+4aAwL/ARQUpb6QJJGkYG78Oxl79IuNXwvNpMc/du6p4KK9RZb6
         lj7CJIE70CaxdW/a58ZuXDH2Te7M4Tmmq0A7gcauVL5IyMU0cAwUH2JMadOYyfvzYk/6
         xSEfqjNjCtQeuhL2U3kq2AhLOL1Rn+cHZSFFM+ZJVCyPh4r0/w4z1pq1IjQbhqgFR6pV
         J9Rg==
X-Gm-Message-State: APjAAAX5C6dUwHl+ljTkUFx7aXmiqSELLJXB0s07F5pEhFYUT6286tRb
        lNDlM5Uc4WPJbWzOMILJnVQ=
X-Google-Smtp-Source: APXvYqz4DfQ8A26mmuEimpmbOJ9inGa93M9bUJIo6kyIzgPdLdM3Ei4CZi2kyzVLWZXd16nohs+05g==
X-Received: by 2002:a50:e718:: with SMTP id a24mr75057729edn.91.1564049485866;
        Thu, 25 Jul 2019 03:11:25 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id n17sm3313867ejk.46.2019.07.25.03.11.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:11:25 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:11:24 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
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
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725101123.zp7y2weotyqkfsv3@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com>
 <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io>
 <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
 <DB572B9F-4D21-402F-A68B-CD193BBB166C@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB572B9F-4D21-402F-A68B-CD193BBB166C@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 24, 2019 at 09:10:20PM +0200, Christian Brauner wrote:
> On July 24, 2019 9:07:54 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> >On Wed, Jul 24, 2019 at 8:27 PM Christian Brauner
> ><christian@brauner.io> wrote:
> >> On July 24, 2019 8:14:26 PM GMT+02:00, Jann Horn <jannh@google.com>
> >wrote:
> >> >On Wed, Jul 24, 2019 at 4:48 PM Christian Brauner
> >> ><christian@brauner.io> wrote:
> >> >> If CLONE_WAIT_PID is set the newly created process will not be
> >> >> considered by process wait requests that wait generically on
> >children
> >> >> such as:
> >> >>
> >> >>         syscall(__NR_wait4, -1, wstatus, options, rusage)
> >> >>         syscall(__NR_waitpid, -1, wstatus, options)
> >> >>         syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
> >> >>         syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
> >> >>         syscall(__NR_waitpid, -pid, wstatus, options)
> >> >>         syscall(__NR_wait4, -pid, wstatus, options, rusage)
> >> >>
> >> >> A process created with CLONE_WAIT_PID can only be waited upon with
> >a
> >> >> focussed wait call. This ensures that processes can be reaped even
> >if
> >> >> all file descriptors referring to it are closed.
> >> >[...]
> >> >> diff --git a/kernel/fork.c b/kernel/fork.c
> >> >> index baaff6570517..a067f3876e2e 100644
> >> >> --- a/kernel/fork.c
> >> >> +++ b/kernel/fork.c
> >> >> @@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct
> >> >*copy_process(
> >> >>         delayacct_tsk_init(p);  /* Must remain after
> >> >dup_task_struct() */
> >> >>         p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
> >> >>         p->flags |= PF_FORKNOEXEC;
> >> >> +       if (clone_flags & CLONE_WAIT_PID)
> >> >> +               p->flags |= PF_WAIT_PID;
> >> >>         INIT_LIST_HEAD(&p->children);
> >> >>         INIT_LIST_HEAD(&p->sibling);
> >> >>         rcu_copy_process(p);
> >> >
> >> >This means that if a process with PF_WAIT_PID forks, the child
> >> >inherits the flag, right? That seems unintended? You might have to
> >add
> >> >something like "if (clone_flags & CLONE_THREAD == 0) p->flags &=
> >> >~PF_WAIT_PID;" before this. (I think threads do have to inherit the
> >> >flag so that the case where a non-leader thread of the child goes
> >> >through execve and steals the leader's identity is handled
> >properly.)
> >> >Or you could cram it somewhere into signal_struct instead of on the
> >> >task - that might be a more logical place for it?
> >>
> >> Hm, CLONE_WAIT_PID is only useable with CLONE_PIDFD which in turn is
> >> not useable with CLONE_THREAD.
> >> But we should probably make that explicit for CLONE_WAIT_PID too.
> >
> >To clarify:
> >
> >This code looks buggy to me because p->flags is inherited from the
> >parent, with the exception of flags that are explicitly stripped out.
> >Since PF_WAIT_PID is not stripped out, this means that if task A
> >creates a child B with clone(CLONE_WAIT_PID), and then task B uses
> >fork() to create a child C, then B will not be able to use
> >wait(&status) to wait for C since C inherited PF_WAIT_PID from B.
> >
> >The obvious way to fix that would be to always strip out PF_WAIT_PID;
> >but that would also be wrong, because if task B creates a thread C,
> >and then C calls execve(), the task_struct of B goes away and B's TGID
> >is taken over by C. When C eventually exits, it should still obey the
> >CLONE_WAIT_PID (since to A, it's all the same process). Therefore, if
> >p->flags is used to track whether the task was created with
> >CLONE_WAIT_PID, PF_WAIT_PID must be inherited if CLONE_THREAD is set.
> >So:
> >
> >diff --git a/kernel/fork.c b/kernel/fork.c
> >index d8ae0f1b4148..b32e1e9a6c9c 100644
> >--- a/kernel/fork.c
> >+++ b/kernel/fork.c
> >@@ -1902,6 +1902,10 @@ static __latent_entropy struct task_struct
> >*copy_process(
> >      delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
> >        p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
> >        p->flags |= PF_FORKNOEXEC;
> >+       if (!(clone_flags & CLONE_THREAD))
> >+               p->flags &= ~PF_PF_WAIT_PID;
> >+       if (clone_flags & CLONE_WAIT_PID)
> >+               p->flags |= PF_PF_WAIT_PID;
> >        INIT_LIST_HEAD(&p->children);
> >        INIT_LIST_HEAD(&p->sibling);
> >        rcu_copy_process(p);
> >
> >An alternative would be to not use p->flags at all, but instead make
> >this a property of the signal_struct - since the property is shared by
> >all threads, that might make more sense?
> 
> Yeah, thanks for clarifying.
> Now it's more obvious.
> I need to take a look at the signal struct before I can say anything about this.

I've been looking at this a bit late last night.
Putting this in the flags argument of signal_struct would indeed be
possible. But it feels misplaced to me there. I think the implied
semantics by having this part of task_struct are nicer, i.e. the intent
is clearer especially when the task is filtered later on in exit.c.
So unless anyone sees a clear problem or otherwise objects I would keep
it as a property of task_struct for now and fix it up.

Christian
