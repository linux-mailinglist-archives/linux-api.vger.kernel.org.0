Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7173573687
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfGXS1g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 14:27:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfGXS1f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 14:27:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so21624415pgb.9
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Pi27TSJDt8GKyGPcjDTgwBHJabaSZ/R4N9AQi2co5xo=;
        b=L38IH0U2uOdre/SqxB1q+vFmdlXXIZ91o9vOAMixpfxg9cWLU0KqxQkwH1FIVknwid
         M3/e2KnUXdQY7dk+36jHhTchxKtXbj71BMBRs4C7mZlo3FnkTul4dN2ms8IoDggupcUa
         2q1MUS0oySaVM9/AVx4ae9GuKwXKihh6uxYD1CvpqRn7aFi/Syp3088M4V86KIa0Tt8V
         PdNdUZnJTqKyIWEGLlT+vPFrNrTzRa3WBKYkDiwrLm6fdiIXL5YgA0zFRashnqmB1Tj8
         iocEu/ykrE19zp/hG6chypOXH20Oy9wLTigDGztxXEfg1PjPINAqGW5HolOAdEew8CVg
         Y8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Pi27TSJDt8GKyGPcjDTgwBHJabaSZ/R4N9AQi2co5xo=;
        b=aH/rrCLF9C16GxAJQ2ps0ZLnfegxB55H4VWIVdhvfeBOG0Hnx1kgjMfuYEfea/k7pd
         WB5FKOV25kuCTR/1VwZX95yyvLvfBZi6cPKCfJx/9v1fQgFyKWZXJY0GBOflqBQiKvIM
         cvGoEAfofFwYpc6oixEcDsH2isfeti0ebyfQhPxnsTynVyGdVC/NogeC+PmWAsGhBRyZ
         FS6+i1PqRWL0g93taaEawqDoKrIZJZ1qLi/m2QqtmHW3zIWtHWrI8b8q+Qxx073REMr0
         uLmgVtcNZzFDv4n24SCIfaVVHRemVp6GYfzELIv+MOB6r6s2tpOmc935rRjLUP68ApYz
         9P9w==
X-Gm-Message-State: APjAAAUkkuWpoqSVfi6XxHd3CcRY7mfzVkrkmrgU4JxLKVIi8+oxr6ii
        Lncwp+7PlK+AJJhuKTjbBYc=
X-Google-Smtp-Source: APXvYqzougESyeo37gKOUeBfbTsvHZF6uXxjIXjAao7/yCJIkM/47veWImZC5SVsFZ2WERjQowYvYQ==
X-Received: by 2002:a65:4948:: with SMTP id q8mr24453057pgs.214.1563992854927;
        Wed, 24 Jul 2019 11:27:34 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id i9sm46556196pgo.46.2019.07.24.11.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 11:27:34 -0700 (PDT)
Date:   Wed, 24 Jul 2019 20:27:21 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-5-christian@brauner.io> <CAG48ez3nuY__qvctoOnX7mQbjjP4chEs4K-OPxSQficiPLS18w@mail.gmail.com>
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
Message-ID: <CFB4D39F-24B9-4AD9-B19C-E2D14D38A808@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On July 24, 2019 8:14:26 PM GMT+02:00, Jann Horn <jannh@google=2Ecom> wrote=
:
>On Wed, Jul 24, 2019 at 4:48 PM Christian Brauner
><christian@brauner=2Eio> wrote:
>> If CLONE_WAIT_PID is set the newly created process will not be
>> considered by process wait requests that wait generically on children
>> such as:
>>
>>         syscall(__NR_wait4, -1, wstatus, options, rusage)
>>         syscall(__NR_waitpid, -1, wstatus, options)
>>         syscall(__NR_waitid, P_ALL, -1, siginfo, options, rusage)
>>         syscall(__NR_waitid, P_PGID, -1, siginfo, options, rusage)
>>         syscall(__NR_waitpid, -pid, wstatus, options)
>>         syscall(__NR_wait4, -pid, wstatus, options, rusage)
>>
>> A process created with CLONE_WAIT_PID can only be waited upon with a
>> focussed wait call=2E This ensures that processes can be reaped even if
>> all file descriptors referring to it are closed=2E
>[=2E=2E=2E]
>> diff --git a/kernel/fork=2Ec b/kernel/fork=2Ec
>> index baaff6570517=2E=2Ea067f3876e2e 100644
>> --- a/kernel/fork=2Ec
>> +++ b/kernel/fork=2Ec
>> @@ -1910,6 +1910,8 @@ static __latent_entropy struct task_struct
>*copy_process(
>>         delayacct_tsk_init(p);  /* Must remain after
>dup_task_struct() */
>>         p->flags &=3D ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
>>         p->flags |=3D PF_FORKNOEXEC;
>> +       if (clone_flags & CLONE_WAIT_PID)
>> +               p->flags |=3D PF_WAIT_PID;
>>         INIT_LIST_HEAD(&p->children);
>>         INIT_LIST_HEAD(&p->sibling);
>>         rcu_copy_process(p);
>
>This means that if a process with PF_WAIT_PID forks, the child
>inherits the flag, right? That seems unintended? You might have to add
>something like "if (clone_flags & CLONE_THREAD =3D=3D 0) p->flags &=3D
>~PF_WAIT_PID;" before this=2E (I think threads do have to inherit the
>flag so that the case where a non-leader thread of the child goes
>through execve and steals the leader's identity is handled properly=2E)
>Or you could cram it somewhere into signal_struct instead of on the
>task - that might be a more logical place for it?

Hm, CLONE_WAIT_PID is only useable with CLONE_PIDFD which in turn is
not useable with CLONE_THREAD=2E
But we should probably make that explicit for CLONE_WAIT_PID too=2E
