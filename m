Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0474D73781
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfGXTKa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 15:10:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33652 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfGXTKa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 15:10:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so12452372pgj.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=3c55STgphphZ74Tkr7e0DO52Xm8oc23hN7JygFwylXY=;
        b=Lqx8OPn1aLHQ/uSUcziIbWBa43ionTq0dyMamtLFcU251mVHo88+e4KPRuKF5mh0Y9
         RMG/jOpGnVXotjfZqOT+yo4G54408UcJX3uQdUXVeG8e4NQlqW4DjYACataDsRvCuTtP
         bTTXl59Zcu1C2zFiXSHTJkEa1Aq44TdaUEqqaLExRWz1inh64BnxCWfssojvzfYi9rFN
         WwCrsI8V/kAQEo2BAdX0XdavW5Bzgce81ABKccC41F7wc1WZe25N5jmQ+Fj67MgZ70JM
         GKEn0ofQhfMD1Hcr8tEO7oL2769tDeLi0f6akIZxZP/WGRMZFJr3ZyuVAv0gGh4RwwUH
         aXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=3c55STgphphZ74Tkr7e0DO52Xm8oc23hN7JygFwylXY=;
        b=P5w1HjfYPShRzquKAYijCoFxya9RogNKdTWz3/O4BjvlQIo6dNhfT2HQ32WwaNd129
         sdIfvU9ovwDkjFSbJ2Q1Ag+E0wG/9M3SjMa56dk2jMSQWUZELPk9JFEln/WFbSKBGg2U
         c8UvP90l/zB9cJV6lGpIb29chxZo+blgO11wKY9209gS9BDraPM3ubksFMssRHzl9thu
         0dVQUUlT05SAOGLPZfDJaQ73+zcIzK6NH9kg/b9J+R7y2eRbWTu5WhUC4uiyBcQn+Osb
         XtrmLY76tnk+LdIaz6ua+nV+M9EYxXJDr8vNvizBR+Fx1AskFyUFhnF0uQgNtlU7cXNV
         vxzw==
X-Gm-Message-State: APjAAAXeMv6HCzXJaSOvdllVLuUdCWC1s2CDZyM3pd/HZFpM+ivRAih1
        IzjKEHM6i5Ug8dV/LAZd0lI=
X-Google-Smtp-Source: APXvYqywU853m9H6EfajxKiEtQpFA9Hog8e5mn6u5MDixpfJK9EqFYRFg5ObWMEzY5XemUtkbU7ajw==
X-Received: by 2002:a65:6081:: with SMTP id t1mr83803190pgu.9.1563995429178;
        Wed, 24 Jul 2019 12:10:29 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id i124sm87012408pfe.61.2019.07.24.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:10:28 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:10:20 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-5-christian@brauner.io> <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com> <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io> <CAG48ez1vd4Yhd3DqHVjTWM-N0MaNnX9n8MNV7MEyU5m3XDu+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
To:     Jann Horn <jannh@google.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
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
From:   Christian Brauner <christian@brauner.io>
Message-ID: <DB572B9F-4D21-402F-A68B-CD193BBB166C@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On July 24, 2019 9:07:54 PM GMT+02:00, Jann Horn <jannh@google=2Ecom> wrote=
:
>On Wed, Jul 24, 2019 at 8:27 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> On July 24, 2019 8:14:26 PM GMT+02:00, Jann Horn <jannh@google=2Ecom>
>wrote:
>> >On Wed, Jul 24, 2019 at 4:48 PM Christian Brauner
>> ><christian@brauner=2Eio> wrote:
>> >> If CLONE_WAIT_PID is set the newly created process will not be
>> >> considered by process wait requests that wait generically on
>children
>> >> such as:
>> >>
>> >>         syscall(__NR_wait4, -1, wstatus, options, rusage)
>> >>         syscall(__NR_waitpid, -1, wstatus, options)
>> >>         syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
>> >>         syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
>> >>         syscall(__NR_waitpid, -pid, wstatus, options)
>> >>         syscall(__NR_wait4, -pid, wstatus, options, rusage)
>> >>
>> >> A process created with CLONE_WAIT_PID can only be waited upon with
>a
>> >> focussed wait call=2E This ensures that processes can be reaped even
>if
>> >> all file descriptors referring to it are closed=2E
>> >[=2E=2E=2E]
>> >> diff --git a/kernel/fork=2Ec b/kernel/fork=2Ec
>> >> index baaff6570517=2E=2Ea067f3876e2e 100644
>> >> --- a/kernel/fork=2Ec
>> >> +++ b/kernel/fork=2Ec
>> >> @@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct
>> >*copy_process(
>> >>         delayacct_tsk_init(p);  /* Must remain after
>> >dup_task_struct() */
>> >>         p->flags &=3D ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
>> >>         p->flags |=3D PF_FORKNOEXEC;
>> >> +       if (clone_flags & CLONE_WAIT_PID)
>> >> +               p->flags |=3D PF_WAIT_PID;
>> >>         INIT_LIST_HEAD(&p->children);
>> >>         INIT_LIST_HEAD(&p->sibling);
>> >>         rcu_copy_process(p);
>> >
>> >This means that if a process with PF_WAIT_PID forks, the child
>> >inherits the flag, right? That seems unintended? You might have to
>add
>> >something like "if (clone_flags & CLONE_THREAD =3D=3D 0) p->flags &=3D
>> >~PF_WAIT_PID;" before this=2E (I think threads do have to inherit the
>> >flag so that the case where a non-leader thread of the child goes
>> >through execve and steals the leader's identity is handled
>properly=2E)
>> >Or you could cram it somewhere into signal_struct instead of on the
>> >task - that might be a more logical place for it?
>>
>> Hm, CLONE_WAIT_PID is only useable with CLONE_PIDFD which in turn is
>> not useable with CLONE_THREAD=2E
>> But we should probably make that explicit for CLONE_WAIT_PID too=2E
>
>To clarify:
>
>This code looks buggy to me because p->flags is inherited from the
>parent, with the exception of flags that are explicitly stripped out=2E
>Since PF_WAIT_PID is not stripped out, this means that if task A
>creates a child B with clone(CLONE_WAIT_PID), and then task B uses
>fork() to create a child C, then B will not be able to use
>wait(&status) to wait for C since C inherited PF_WAIT_PID from B=2E
>
>The obvious way to fix that would be to always strip out PF_WAIT_PID;
>but that would also be wrong, because if task B creates a thread C,
>and then C calls execve(), the task_struct of B goes away and B's TGID
>is taken over by C=2E When C eventually exits, it should still obey the
>CLONE_WAIT_PID (since to A, it's all the same process)=2E Therefore, if
>p->flags is used to track whether the task was created with
>CLONE_WAIT_PID, PF_WAIT_PID must be inherited if CLONE_THREAD is set=2E
>So:
>
>diff --git a/kernel/fork=2Ec b/kernel/fork=2Ec
>index d8ae0f1b4148=2E=2Eb32e1e9a6c9c 100644
>--- a/kernel/fork=2Ec
>+++ b/kernel/fork=2Ec
>@@ -1902,6 +1902,10 @@ static __latent_entropy struct task_struct
>*copy_process(
>      delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
>        p->flags &=3D ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
>        p->flags |=3D PF_FORKNOEXEC;
>+       if (!(clone_flags & CLONE_THREAD))
>+               p->flags &=3D ~PF_PF_WAIT_PID;
>+       if (clone_flags & CLONE_WAIT_PID)
>+               p->flags |=3D PF_PF_WAIT_PID;
>        INIT_LIST_HEAD(&p->children);
>        INIT_LIST_HEAD(&p->sibling);
>        rcu_copy_process(p);
>
>An alternative would be to not use p->flags at all, but instead make
>this a property of the signal_struct - since the property is shared by
>all threads, that might make more sense?

Yeah, thanks for clarifying=2E
Now it's more obvious=2E
I need to take a look at the signal struct before I can say anything about=
 this=2E
