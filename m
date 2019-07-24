Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0473666
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGXSOy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 14:14:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35636 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbfGXSOx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 14:14:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so10375204otq.2
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBB4NIUezJfffKo6WArQqxSmCR6R1iK7nA9Imt65nrA=;
        b=lWNkNy2HocdqrSPSjM86VbsoPLqsarjkWdpIa+rbyfMi2VVwhNVXgnmJbHOpO1W7FT
         LQMzXGrgksgL9tGb50G9TiUwzlVWVbhzfAN6YgzYvj9m0yrQTGiGJQ6UBv0FRFiUeI0Y
         0Pu6bKOZZAfkCCJlOZkDOX7Sot7v/XhX7gKi7M6McIRW/+SPegOlDe8lp/F2tcsjSooD
         yoc081wlkW7WCUVG3wHzzrnhXOxIHoMB4QEeSlGWs5yVG93jDJsFjxlbNrryYK6ptn6i
         6hV19p7RkJbrSN7B0r9AaIRRx/7XrpljhjtHs8tAhBqO1U4zdzM1POwxhMmkzWwsle0x
         TalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBB4NIUezJfffKo6WArQqxSmCR6R1iK7nA9Imt65nrA=;
        b=dJhTG733A6Cdbn/tRe1P86g9W+dNXkWTCloVlu5Qo3x/jPX+tJHxA088X94CX4xGtz
         Cwr/T/MykTl3vIyyoGT15O9pHw87HIIfRcakkTZ2jUEyLuzfvBe25nsUhrh7brWNeJdx
         CgMlDO/claiAUpHSr4sMkA5ntVyGWtTsxYJ5fnrRBGmHo0B4a4PqDxaUce96Ip8RemDg
         pkvLx/rbBnJAKpCrz7/DWspHNoJ4qh8fc58BkBRU0e12P65NsucyYpbFx12FneCIz/Rb
         ndMvREzpall7IOkHkleokZuxA/Q+/gOTkAGquIhwJh4x0CwnmXH1VAfqSueJKSGDyzzN
         nThA==
X-Gm-Message-State: APjAAAUa6ADh0b+0VECPNeMjqOJpuwq+HZDfUr7NwgBBS/UeuVNCncv0
        8EhiGW+JnmhuXDyVQbndtOl2Ab5+U0sZNE9yIXgKQg==
X-Google-Smtp-Source: APXvYqwHy5zLM+W8es+5EDo+pppJ0LUeZRmJbRYgUyIKhGpRl4E7tMR2+zkmduhMX/+diAhhSgIEktJcOUDM+vPLN9k=
X-Received: by 2002:a05:6830:15cd:: with SMTP id j13mr44476599otr.110.1563992092278;
 Wed, 24 Jul 2019 11:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-5-christian@brauner.io>
In-Reply-To: <20190724144651.28272-5-christian@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 24 Jul 2019 20:14:26 +0200
Message-ID: <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com>
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

On Wed, Jul 24, 2019 at 4:48 PM Christian Brauner <christian@brauner.io> wrote:
> If CLONE_WAIT_PID is set the newly created process will not be
> considered by process wait requests that wait generically on children
> such as:
>
>         syscall(__NR_wait4, -1, wstatus, options, rusage)
>         syscall(__NR_waitpid, -1, wstatus, options)
>         syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
>         syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
>         syscall(__NR_waitpid, -pid, wstatus, options)
>         syscall(__NR_wait4, -pid, wstatus, options, rusage)
>
> A process created with CLONE_WAIT_PID can only be waited upon with a
> focussed wait call. This ensures that processes can be reaped even if
> all file descriptors referring to it are closed.
[...]
> diff --git a/kernel/fork.c b/kernel/fork.c
> index baaff6570517..a067f3876e2e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct *copy_process(
>         delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
>         p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
>         p->flags |= PF_FORKNOEXEC;
> +       if (clone_flags & CLONE_WAIT_PID)
> +               p->flags |= PF_WAIT_PID;
>         INIT_LIST_HEAD(&p->children);
>         INIT_LIST_HEAD(&p->sibling);
>         rcu_copy_process(p);

This means that if a process with PF_WAIT_PID forks, the child
inherits the flag, right? That seems unintended? You might have to add
something like "if (clone_flags & CLONE_THREAD == 0) p->flags &=
~PF_WAIT_PID;" before this. (I think threads do have to inherit the
flag so that the case where a non-leader thread of the child goes
through execve and steals the leader's identity is handled properly.)
Or you could cram it somewhere into signal_struct instead of on the
task - that might be a more logical place for it?
