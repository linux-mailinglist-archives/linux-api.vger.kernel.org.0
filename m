Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44AAEBD2
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfD2UuG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 29 Apr 2019 16:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfD2UuG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 29 Apr 2019 16:50:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24B673092661;
        Mon, 29 Apr 2019 20:50:06 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-123.ams2.redhat.com [10.36.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA2D719089;
        Mon, 29 Apr 2019 20:49:57 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Mon, 29 Apr 2019 22:49:55 +0200
In-Reply-To: <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
        (Jann Horn's message of "Mon, 29 Apr 2019 15:55:11 -0400")
Message-ID: <87v9ywbkp8.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 20:50:06 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Jann Horn:

>> int clone_temporary(int (*fn)(void *arg), void *arg, pid_t *child_pid,
>> <clone flags and arguments, maybe in a struct>)
>>
>> and then you'd use it like this to fork off a child process:
>>
>> int spawn_shell_subprocess_(void *arg) {
>>   char *cmdline = arg;
>>   execl("/bin/sh", "sh", "-c", cmdline);
>>   return -1;
>> }
>> pid_t spawn_shell_subprocess(char *cmdline) {
>>   pid_t child_pid;
>>   int res = clone_temporary(spawn_shell_subprocess_, cmdline,
>> &child_pid, [...]);
>>   if (res == 0) return child_pid;
>>   return res;
>> }
>>
>> clone_temporary() could be implemented roughly as follows by the libc
>> (or other userspace code):
>>
>> sigset_t sigset, sigset_old;
>> sigfillset(&sigset);
>> sigprocmask(SIG_SETMASK, &sigset, &sigset_old);
>> int child_pid;
>> int result = 0;
>> /* starting here, use inline assembly to ensure that no stack
>> allocations occur */
>> long child = syscall(__NR_clone,
>> CLONE_VM|CLONE_CHILD_SETTID|CLONE_CHILD_CLEARTID|SIGCHLD, $RSP -
>> ABI_STACK_REDZONE_SIZE, NULL, &child_pid, 0);
>> if (child == -1) { result = -1; goto reset_sigmask; }
>> if (child == 0) {
>>   result = fn(arg);
>>   syscall(__NR_exit, 0);
>> }
>> futex(&child_pid, FUTEX_WAIT, child, NULL);
>> /* end of no-stack-allocations zone */
>> reset_sigmask:
>> sigprocmask(SIG_SETMASK, &sigset_old, NULL);
>> return result;
>
> ... I guess that already has a name, and it's called vfork(). (Well,
> except that the Linux vfork() isn't a real vfork().)
>
> So I guess my question is: Why not vfork()?

Mainly because some users want access to the clone flags, and that's not
possible with the current userspace wrappers.  The stack setup for the
undocumented clone wrapper is also cumbersome, and the ia64 pecularity
annoying.

For the stack sharing, the callback-based interface looks like the
absolutely right thing to do to me.  It enforces the notion that you can
safely return on the child path from a function calling vfork.

> And if vfork() alone isn't flexible enough, alternatively: How about
> an API that forks a new child in the same address space, and then
> allows the parent to invoke arbitrary syscalls in the context of the
> child?

As long it's not an eBPF script …

> You could also build that in userspace if you wanted, I think - just
> let the child run an assembly loop that reads registers from a unix
> seqpacket socket, invokes the syscall instruction, and writes the
> value of the result register back into the seqpacket socket. As long
> as you use CLONE_VM, you don't have to worry about moving the pointer
> targets of syscalls. The user-visible API could look like this:

People already use a variant of this, execve'ing twice.  See
jspawnhelper.

Thanks,
Florian
