Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD3EBDB
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfD2UxE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 16:53:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45815 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfD2UxE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 16:53:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so8962349lfl.12
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3qA2gnh3WCYTM8Z8LwSdNcpUBBLD5ma7h/mHJ94b/Z4=;
        b=D9Ez8JKMsqbiIul/T3ZCGg8YZL5W573M9HFx64cRKPToTZ+/XbvxRJjy/hT8aFkks+
         NjPilGNY4l4+hUf8q9D5txLxa8XPZ/toXOTUPNJHlNl4kjVcG2dDk1UIYrVqrM8dzkPb
         +MJtLuJ+YpN+dPEDOH9CJS+tZP+ChfHmXazmErwjJCBvIo5bZX26GHZfPMAu3U0T0auN
         Uslws8h29oq1Wvcu4amBhMWvUGPr58kJu/DTHA67GVH0rt8S9txOWyHnA32NAiMZmQmQ
         Xp6EvSuzgztcJfOCahbps/1iFUTBJpCMkwWNIpzVEuMWKBLKzx/kvDiJ8yf5CDouge3w
         ARDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3qA2gnh3WCYTM8Z8LwSdNcpUBBLD5ma7h/mHJ94b/Z4=;
        b=ETEpo8jeZQdP/wqaBn/RpYGjhCq5O6/ftMfc04Ulo8Ea+cv4euGDSzLQIasf/6M1i+
         LXq7pPmKSBYwE9uG5lmwPGDmK5UWMrACp0oqbTdEsCqWb/lLOqTfg8ABaYgqFzTU1b7W
         Sr/Mo8sDIsWwK9ZKe923vK+72hAXQKyKrlRiTapZxDvGFI9xJLCGRQGB+4l3en5p1ax+
         oGC3kcWP5+T+e9qDP5Ad46iEfluwwmJSJ6YuDllUDrJio2+wv63K2ZFLSZI+NIiUug58
         ancdqLvqfgjICmvRhgij4JAPH9qYopI3vXP9/ORe5h3aVmv/2c0IJwEP6s8p3LLkda06
         5oJg==
X-Gm-Message-State: APjAAAWSNEjJbq0Hv0E/0im1EKBA9Y0kc8xw+7RUsA3/ZdI9AE367/25
        PuPzymOateMEPJcmhcHC2+GiKj0KiFwVRPum6p5NEQ==
X-Google-Smtp-Source: APXvYqxFBGjeAWwB5tyYA6QNJKlnN8uvPrVeE/FIMCz8lWPmbtyjKvHzPDTgD3B6JRpL+LJB4uB125WXlQX14XZrF14=
X-Received: by 2002:a19:7406:: with SMTP id v6mr9658592lfe.9.1556571181274;
 Mon, 29 Apr 2019 13:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com> <87v9ywbkp8.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87v9ywbkp8.fsf@oldenburg2.str.redhat.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Mon, 29 Apr 2019 22:52:50 +0200
Message-ID: <CAHrFyr5QNTb-y4wO0vph4u7LZtEdr5A+KtvxPokAUrkUQgb-5A@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 10:50 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Jann Horn:
>
> >> int clone_temporary(int (*fn)(void *arg), void *arg, pid_t *child_pid,
> >> <clone flags and arguments, maybe in a struct>)
> >>
> >> and then you'd use it like this to fork off a child process:
> >>
> >> int spawn_shell_subprocess_(void *arg) {
> >>   char *cmdline =3D arg;
> >>   execl("/bin/sh", "sh", "-c", cmdline);
> >>   return -1;
> >> }
> >> pid_t spawn_shell_subprocess(char *cmdline) {
> >>   pid_t child_pid;
> >>   int res =3D clone_temporary(spawn_shell_subprocess_, cmdline,
> >> &child_pid, [...]);
> >>   if (res =3D=3D 0) return child_pid;
> >>   return res;
> >> }
> >>
> >> clone_temporary() could be implemented roughly as follows by the libc
> >> (or other userspace code):
> >>
> >> sigset_t sigset, sigset_old;
> >> sigfillset(&sigset);
> >> sigprocmask(SIG_SETMASK, &sigset, &sigset_old);
> >> int child_pid;
> >> int result =3D 0;
> >> /* starting here, use inline assembly to ensure that no stack
> >> allocations occur */
> >> long child =3D syscall(__NR_clone,
> >> CLONE_VM|CLONE_CHILD_SETTID|CLONE_CHILD_CLEARTID|SIGCHLD, $RSP -
> >> ABI_STACK_REDZONE_SIZE, NULL, &child_pid, 0);
> >> if (child =3D=3D -1) { result =3D -1; goto reset_sigmask; }
> >> if (child =3D=3D 0) {
> >>   result =3D fn(arg);
> >>   syscall(__NR_exit, 0);
> >> }
> >> futex(&child_pid, FUTEX_WAIT, child, NULL);
> >> /* end of no-stack-allocations zone */
> >> reset_sigmask:
> >> sigprocmask(SIG_SETMASK, &sigset_old, NULL);
> >> return result;
> >
> > ... I guess that already has a name, and it's called vfork(). (Well,
> > except that the Linux vfork() isn't a real vfork().)
> >
> > So I guess my question is: Why not vfork()?
>
> Mainly because some users want access to the clone flags, and that's not
> possible with the current userspace wrappers.  The stack setup for the
> undocumented clone wrapper is also cumbersome, and the ia64 pecularity
> annoying.
>
> For the stack sharing, the callback-based interface looks like the
> absolutely right thing to do to me.  It enforces the notion that you can
> safely return on the child path from a function calling vfork.
>
> > And if vfork() alone isn't flexible enough, alternatively: How about
> > an API that forks a new child in the same address space, and then
> > allows the parent to invoke arbitrary syscalls in the context of the
> > child?
>
> As long it's not an eBPF script =E2=80=A6

You shouldn't even joke about this (I'm serious.).
I'm very certain there are people who'd think this is a good idea.

>
> > You could also build that in userspace if you wanted, I think - just
> > let the child run an assembly loop that reads registers from a unix
> > seqpacket socket, invokes the syscall instruction, and writes the
> > value of the result register back into the seqpacket socket. As long
> > as you use CLONE_VM, you don't have to worry about moving the pointer
> > targets of syscalls. The user-visible API could look like this:
>
> People already use a variant of this, execve'ing twice.  See
> jspawnhelper.
>
> Thanks,
> Florian
