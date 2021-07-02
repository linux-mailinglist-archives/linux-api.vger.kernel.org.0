Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3035A3BA623
	for <lists+linux-api@lfdr.de>; Sat,  3 Jul 2021 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhGBWzD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhGBWzD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 18:55:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA8C0613DC;
        Fri,  2 Jul 2021 15:52:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h4so11251562pgp.5;
        Fri, 02 Jul 2021 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzYui5CDCvLLizazsQOkN6edSWGW6uu2jy4hUi8JxHk=;
        b=D6KCveS8qD/8/9oQ572ukRoV9GeALdkWxGMgqJu1ERthxpyYAY4lIyl3+/nbQzt/g5
         WNbtwhU66276Y7ZEAKnaLeOV9uiSP4aFl9yWXdzo3Lk8OKGsGAhWSPN60UedTaLGZqi9
         EwhqvQp6HEzIoMgXt4PobxFeyejOsQr1ZRmxSwY0F/S16IqHwI7FaK15WYGJ0u7OKeRA
         M+KJtaA5dZUt668z7eUOn154PVrfyX4v2BeSQZ5wZboVk3pzYbKvvstU7psRj3/g29Uz
         7av24zpEbir9LSZb6enw1ZVsfMEbHmPXh7RrkKSlBbejxIF4vxcOOdbm3EaLzhe+Pgly
         PnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzYui5CDCvLLizazsQOkN6edSWGW6uu2jy4hUi8JxHk=;
        b=hCybtjP347WANnn6lX8vcEwq/9t66CsLcwuJ7SbUt4AZDBZTyvLH4vGSdXhgPC5PVS
         34lDV7Itb6B82oV99k2CKgv/aOozqydsTakHk1ROelx+Aiuvugeskk+t/0Q0wf9TPzIG
         SGPQQYTfX/RMiYSdWa/OPMJ1n1QGGTcfom22anqPUtJSsK1Ms+pk/e5qhJpXd45B+a8C
         4qvOX1ssTg8LKO3vp8QBiCcb/iQMy4ULPT6GV2+fh16cnUWLRRLdVcPHeO7tl83PC/D5
         lkI3fIfhmZI7FWkd7xaAFzOn+FWdRIdqbWC5xARrKLfmNX0gsFwE3rBW8e9Yoi5jv2re
         jkWg==
X-Gm-Message-State: AOAM533mCL/06K22nxp+20Q+88qFIY8LGJesc2coQv2nDwiAjLxjAFWo
        5wQB12ut+hyQQTHB9YPrzlc=
X-Google-Smtp-Source: ABdhPJwJpAgVBXVnAF908U+e6JpkS94dlCu6OIp7vqU4kQWjVOAS6jE2vORRhBtsjee7rPfFSObtmg==
X-Received: by 2002:a63:5414:: with SMTP id i20mr2263074pgb.5.1625266348875;
        Fri, 02 Jul 2021 15:52:28 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id z1sm1757068pfn.126.2021.07.02.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:52:28 -0700 (PDT)
Date:   Fri, 2 Jul 2021 15:48:53 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN+X1QKWQOKekK4E@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez37ZUNvWy1eOvrW13kFRM-_ZW175x99Nyjq43w4Qz1qJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CAG48ez37ZUNvWy1eOvrW13kFRM-_ZW175x99Nyjq43w4Qz1qJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 02, 2021 at 10:56:38PM +0200, Jann Horn wrote:
> On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > This change introduces the new system call:
> > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
> >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
> >
> > process_vm_exec allows to execute the current process in an address
> > space of another process.
> >
> > process_vm_exec swaps the current address space with an address space of
> > a specified process, sets a state from sigcontex and resumes the process.
> > When a process receives a signal or calls a system call,
> > process_vm_exec saves the process state back to sigcontext, restores the
> > origin address space, restores the origin process state, and returns to
> > userspace.
> >
> > If it was interrupted by a signal and the signal is in the user_mask,
> > the signal is dequeued and information about it is saved in uinfo.
> > If process_vm_exec is interrupted by a system call, a synthetic siginfo
> > for the SIGSYS signal is generated.
> >
> > The behavior of this system call is similar to PTRACE_SYSEMU but
> > everything is happing in the context of one process, so
> > process_vm_exec shows a better performance.
> >
> > PTRACE_SYSEMU is primarily used to implement sandboxes (application
> > kernels) like User-mode Linux or gVisor. These type of sandboxes
> > intercepts applications system calls and acts as the guest kernel.
> > A simple benchmark, where a "tracee" process executes systems calls in a
> > loop and a "tracer" process traps syscalls and handles them just
> > incrementing the tracee instruction pointer to skip the syscall
> > instruction shows that process_vm_exec works more than 5 times faster
> > than PTRACE_SYSEMU.
> [...]
> > +long swap_vm_exec_context(struct sigcontext __user *uctx)
> > +{
> > +       struct sigcontext ctx = {};
> > +       sigset_t set = {};
> > +
> > +
> > +       if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> > +               return -EFAULT;
> > +       /* A floating point state is managed from user-space. */
> > +       if (ctx.fpstate != 0)
> > +               return -EINVAL;
> > +       if (!user_access_begin(uctx, sizeof(*uctx)))
> > +               return -EFAULT;
> > +       unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> > +       user_access_end();
> > +
> > +       if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> > +               goto badframe;
> > +
> > +       return 0;
> > +Efault:
> > +       user_access_end();
> > +badframe:
> > +       signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> > +       return -EFAULT;
> > +}
> 
> Comparing the pieces of context that restore_sigcontext() restores
> with what a normal task switch does (see __switch_to() and callees), I
> noticed: On CPUs with FSGSBASE support, I think sandboxed code could
> overwrite FSBASE/GSBASE using the WRFSBASE/WRGSBASE instructions,
> causing the supervisor to access attacker-controlled addresses when it
> tries to access a thread-local variable like "errno"? Signal handling
> saves the segment registers, but not the FS/GS base addresses.
> 
> 
> jannh@laptop:~/test$ cat signal_gsbase.c
> // compile with -mfsgsbase
> #include <stdio.h>
> #include <signal.h>
> #include <immintrin.h>
> 
> void signal_handler(int sig, siginfo_t *info, void *ucontext_) {
>   puts("signal handler");
>   _writegsbase_u64(0x12345678);
> }
> 
> int main(void) {
>   struct sigaction new_act = {
>     .sa_sigaction = signal_handler,
>     .sa_flags = SA_SIGINFO
>   };
>   sigaction(SIGUSR1, &new_act, NULL);
> 
>   printf("original gsbase is 0x%lx\n", _readgsbase_u64());
>   raise(SIGUSR1);
>   printf("post-signal gsbase is 0x%lx\n", _readgsbase_u64());
> }
> jannh@laptop:~/test$ gcc -o signal_gsbase signal_gsbase.c -mfsgsbase
> jannh@laptop:~/test$ ./signal_gsbase
> original gsbase is 0x0
> signal handler
> post-signal gsbase is 0x12345678
> jannh@laptop:~/test$
> 
> 
> So to make this usable for a sandboxing usecase, you'd also have to
> save and restore FSBASE/GSBASE, just like __switch_to().

You are right. I've found this too when I implemented the gviosr user-space
part.

Here is the tree whether this problem has been fixed:
https://github.com/avagin/linux-task-diag/commits/wip/gvisor-5.10

