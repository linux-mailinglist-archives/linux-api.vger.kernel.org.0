Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606AA3BA4DF
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhGBU7k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhGBU7k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 16:59:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E61C061764
        for <linux-api@vger.kernel.org>; Fri,  2 Jul 2021 13:57:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so20246681lfv.13
        for <linux-api@vger.kernel.org>; Fri, 02 Jul 2021 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hDmjhh4CEc7tcPs29BDsOViDcQQOe2tkj/fgDDj4a8=;
        b=WK38xMCuVpfUrGEjMntGywHqdXgVFuWSivGvWFJymCFPCO9Ml/kPCWA6DekIoIMQ/D
         kZNRHf7S0mKDYkX1xvAyT8n7OUP1MQlFZLadK+qUubLFBPuZsgv/gJy1tovcgSjchPQO
         1zkMQe147Ckwr5W5S2YvW2sygH/bGmwrv+rLpTHnI37KxoaCvULHquOLvIuMcdkwIkZ5
         yZi+eV3R3hu9FJxtC6KMCLBrgP9x7Xno2W3HnohpYj89P+L6H1eVmcEzmnA1gkx5V7yv
         rsGL3DkQGuRbG0+OTmk3xxv5IB1PV6/45GJu2NPlAroTtBnSwOtfQ0LuQv8zvrPCWAFt
         jbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hDmjhh4CEc7tcPs29BDsOViDcQQOe2tkj/fgDDj4a8=;
        b=OFurnv1p3+HhQpAtpgd7jhI33cnW+Qe6Pp3n5WgaERa0/mzJu+Z7yNjQwSZL48lefN
         IG4G+TvgAuZp2vFlk72PYxt0YEeN9GNMLcKor5fqkd2ZzpxgE3m/Kw4yj7BO1WfO5yoJ
         unfcg+8jUHw36tNwhmsxBYl2uUobcpxeSlHtsR3l3hI4SBKbO6ficnmUM6ggrr9FpjEb
         LtrNCMgDTHpLthLXbRzIRfEUeHAOmGNyjSDS6+AGq+0sO3SYkRs6tMXhcQSvAywk5eIN
         zy4gtt/9RA024mkjI9nIg75g8st9QfOIVKG11RlWvwjeUVoD7Dvv0HWEe58RTifuKzTL
         0dhg==
X-Gm-Message-State: AOAM530WtMy47h05jhPQ8kg8vhsq6jOROIMmUzA5bPwVLqXU/DjsJNRX
        +EHETFCOQJluHQeRg35X5/5zPYex1LNVcwW6zr4XUQ==
X-Google-Smtp-Source: ABdhPJwInonwQ2eFAluymRJg+OzibVAdAH9rjiGeegy/PBQqyDo3Lz9bheVoB3rtWdelqiuYYIjZmdtKHRWINk99MoU=
X-Received: by 2002:a05:6512:210e:: with SMTP id q14mr1061425lfr.356.1625259424639;
 Fri, 02 Jul 2021 13:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <20210414055217.543246-3-avagin@gmail.com>
In-Reply-To: <20210414055217.543246-3-avagin@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Jul 2021 22:56:38 +0200
Message-ID: <CAG48ez37ZUNvWy1eOvrW13kFRM-_ZW175x99Nyjq43w4Qz1qJQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
To:     Andrei Vagin <avagin@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> This change introduces the new system call:
> process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
>                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
>
> process_vm_exec allows to execute the current process in an address
> space of another process.
>
> process_vm_exec swaps the current address space with an address space of
> a specified process, sets a state from sigcontex and resumes the process.
> When a process receives a signal or calls a system call,
> process_vm_exec saves the process state back to sigcontext, restores the
> origin address space, restores the origin process state, and returns to
> userspace.
>
> If it was interrupted by a signal and the signal is in the user_mask,
> the signal is dequeued and information about it is saved in uinfo.
> If process_vm_exec is interrupted by a system call, a synthetic siginfo
> for the SIGSYS signal is generated.
>
> The behavior of this system call is similar to PTRACE_SYSEMU but
> everything is happing in the context of one process, so
> process_vm_exec shows a better performance.
>
> PTRACE_SYSEMU is primarily used to implement sandboxes (application
> kernels) like User-mode Linux or gVisor. These type of sandboxes
> intercepts applications system calls and acts as the guest kernel.
> A simple benchmark, where a "tracee" process executes systems calls in a
> loop and a "tracer" process traps syscalls and handles them just
> incrementing the tracee instruction pointer to skip the syscall
> instruction shows that process_vm_exec works more than 5 times faster
> than PTRACE_SYSEMU.
[...]
> +long swap_vm_exec_context(struct sigcontext __user *uctx)
> +{
> +       struct sigcontext ctx = {};
> +       sigset_t set = {};
> +
> +
> +       if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> +               return -EFAULT;
> +       /* A floating point state is managed from user-space. */
> +       if (ctx.fpstate != 0)
> +               return -EINVAL;
> +       if (!user_access_begin(uctx, sizeof(*uctx)))
> +               return -EFAULT;
> +       unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> +       user_access_end();
> +
> +       if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> +               goto badframe;
> +
> +       return 0;
> +Efault:
> +       user_access_end();
> +badframe:
> +       signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> +       return -EFAULT;
> +}

Comparing the pieces of context that restore_sigcontext() restores
with what a normal task switch does (see __switch_to() and callees), I
noticed: On CPUs with FSGSBASE support, I think sandboxed code could
overwrite FSBASE/GSBASE using the WRFSBASE/WRGSBASE instructions,
causing the supervisor to access attacker-controlled addresses when it
tries to access a thread-local variable like "errno"? Signal handling
saves the segment registers, but not the FS/GS base addresses.


jannh@laptop:~/test$ cat signal_gsbase.c
// compile with -mfsgsbase
#include <stdio.h>
#include <signal.h>
#include <immintrin.h>

void signal_handler(int sig, siginfo_t *info, void *ucontext_) {
  puts("signal handler");
  _writegsbase_u64(0x12345678);
}

int main(void) {
  struct sigaction new_act = {
    .sa_sigaction = signal_handler,
    .sa_flags = SA_SIGINFO
  };
  sigaction(SIGUSR1, &new_act, NULL);

  printf("original gsbase is 0x%lx\n", _readgsbase_u64());
  raise(SIGUSR1);
  printf("post-signal gsbase is 0x%lx\n", _readgsbase_u64());
}
jannh@laptop:~/test$ gcc -o signal_gsbase signal_gsbase.c -mfsgsbase
jannh@laptop:~/test$ ./signal_gsbase
original gsbase is 0x0
signal handler
post-signal gsbase is 0x12345678
jannh@laptop:~/test$


So to make this usable for a sandboxing usecase, you'd also have to
save and restore FSBASE/GSBASE, just like __switch_to().
