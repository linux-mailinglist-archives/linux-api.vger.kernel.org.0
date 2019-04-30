Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB43FE7B
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3RHm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 30 Apr 2019 13:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfD3RHl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 30 Apr 2019 13:07:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95B4EC05CDFC;
        Tue, 30 Apr 2019 17:07:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AACAD171DF;
        Tue, 30 Apr 2019 17:07:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
References: <20190414201436.19502-1-christian@brauner.io>
        <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
        <20190415195911.z7b7miwsj67ha54y@yavin>
        <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
        <20190420071406.GA22257@ip-172-31-15-78>
        <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
        <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
        <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
        <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
        <CAHk-=wg73au-kvOwWpPDY+rXrz8O5gwrcPiw1FZx-Qr2PqpRFg@mail.gmail.com>
        <87r29jaoov.fsf@oldenburg2.str.redhat.com>
        <CAHk-=wiM8VQ_Ny6Y=fTqE9Aq1LuDdU5bKfnXPyYXU1bi7GtU4w@mail.gmail.com>
        <CAHk-=wgxqoH=Cztd7W67pYJyZwPPNtY5P7K66u2QTDEpEYHVAw@mail.gmail.com>
Date:   Tue, 30 Apr 2019 19:07:19 +0200
In-Reply-To: <CAHk-=wgxqoH=Cztd7W67pYJyZwPPNtY5P7K66u2QTDEpEYHVAw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 30 Apr 2019 09:26:57 -0700")
Message-ID: <871s1j777c.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 30 Apr 2019 17:07:41 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Linus Torvalds:

> On Tue, Apr 30, 2019 at 9:19 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Of course, if you *don't* need the exact vfork() semantics, clone
>> itself actually very much supports a callback model with s separate
>> stack. You can basically do this:
>>
>>  - allocate new stack for the child
>>  - in trivial asm wrapper, do:
>>     - push the callback address on the child stack
>>     - clone(CLONE_VFORK|CLONE_VM|CLONE_SIGCHLD, chld_stack, NULL, NULL,NULL)
>>     - "ret"
>>  - free new stack
>>
>> where the "ret" in the child will just go to the callback, while the
>> parent (eventually) just returns from the trivial wrapper and frees
>> the new stack (which by definition is no longer used, since the child
>> has exited or execve'd.
>
> In fact, Florian, maybe this is the solution to your "I want to use
> vfork for posix_spawn(), but I don't know if I can trust it" problem.
>
> Just use clone() directly. On WSL it will presumably just fail, and
> you can then fall back on doing the slow stupid
> fork+pipes-to-communicate.

We already use clone.  I don't know why.  We should add a comment that
provides the reason.

> On valgrind, I don't know what will happen. Maybe it will just do an
> unchecked posix_spawn() because valgrind doesn't catch it?

I think what happens with these emulators that they use fork (no shared
address space) but suspend the parent thread.  clone with CLONE_VFORK
definitely does not fail.  That mostly works, except that you do not get
back the error code from the execve.  Instead, the process is considered
launched, and the caller collects the exit status from the _exit after
the failed execve.

> Of course, if you *don't* need the exact vfork() semantics, clone
> itself actually very much supports a callback model with s separate
> stack. You can basically do this:
> 
>  - allocate new stack for the child
>  - in trivial asm wrapper, do:
>     - push the callback address on the child stack
>     - clone(CLONE_VFORK|CLONE_VM|CLONE_SIGCHLD, chld_stack, NULL, NULL,NULL)
>     - "ret"
>  - free new stack
> 
> where the "ret" in the child will just go to the callback, while the
> parent (eventually) just returns from the trivial wrapper and frees
> the new stack (which by definition is no longer used, since the child
> has exited or execve'd.
> 
> So you can most definitely create a "vfork_with_child_callback()" with
> clone, and it would arguably be a much superior interface to vfork()
> anyway (maybe you'd like to pass in some arguments to the callback too
> - add more stack setup for the child as needed), but it wouldn't be
> the right solution for programs that just want to use the standard BSD
> vfork() model.

As far as we understand the situation, we believe that we absolutely
must block all signals for both the parent thread and the new
subprocess.  Signals can be unblocked in the subprocess, but only after
setting their handlers to SIG_DFL or SIG_IGN.  (Parent signal handlers
cannot run in the subprocess because application-supplied signal
handlers generally do not expect to run with a corrupt TCB—or a
different PID.)

At that point, I wonder if we can just skip the stack setup for the
CLONE_VFORK case and reuse the existing stack.

Thanks,
Florian
