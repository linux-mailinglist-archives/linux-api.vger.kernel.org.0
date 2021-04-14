Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3615A35EEDA
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 10:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhDNHzV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 03:55:21 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:34512 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349171AbhDNHzP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 03:55:15 -0400
X-Greylist: delayed 1900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 03:55:14 EDT
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lWZr5-0004AT-4T; Wed, 14 Apr 2021 07:22:35 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lWZr2-0003Qz-Ki; Wed, 14 Apr 2021 08:22:30 +0100
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
To:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210414055217.543246-1-avagin@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <78cdee11-1923-595f-90d2-e236efbafa6a@cambridgegreys.com>
Date:   Wed, 14 Apr 2021 08:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 14/04/2021 06:52, Andrei Vagin wrote:
> We already have process_vm_readv and process_vm_writev to read and write
> to a process memory faster than we can do this with ptrace. And now it
> is time for process_vm_exec that allows executing code in an address
> space of another process. We can do this with ptrace but it is much
> slower.
> 
> = Use-cases =
> 
> Here are two known use-cases. The first one is “application kernel”
> sandboxes like User-mode Linux and gVisor. In this case, we have a
> process that runs the sandbox kernel and a set of stub processes that
> are used to manage guest address spaces. Guest code is executed in the
> context of stub processes but all system calls are intercepted and
> handled in the sandbox kernel. Right now, these sort of sandboxes use
> PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> significantly speed them up.

Certainly interesting, but will require um to rework most of its memory 
management and we will most likely need extra mm support to make use of 
it in UML. We are not likely to get away just with one syscall there.

> 
> Another use-case is CRIU (Checkpoint/Restore in User-space). Several
> process properties can be received only from the process itself. Right
> now, we use a parasite code that is injected into the process. We do
> this with ptrace but it is slow, unsafe, and tricky. process_vm_exec can
> simplify the process of injecting a parasite code and it will allow
> pre-dump memory without stopping processes. The pre-dump here is when we
> enable a memory tracker and dump the memory while a process is continue
> running. On each interaction we dump memory that has been changed from
> the previous iteration. In the final step, we will stop processes and
> dump their full state. Right now the most effective way to dump process
> memory is to create a set of pipes and splice memory into these pipes
> from the parasite code. With process_vm_exec, we will be able to call
> vmsplice directly. It means that we will not need to stop a process to
> inject the parasite code.
> 
> = How it works =
> 
> process_vm_exec has two modes:
> 
> * Execute code in an address space of a target process and stop on any
>    signal or system call.
> 
> * Execute a system call in an address space of a target process.
> 
> int process_vm_exec(pid_t pid, struct sigcontext uctx,
> 		    unsigned long flags, siginfo_t siginfo,
> 		    sigset_t  *sigmask, size_t sizemask)
> 
> PID - target process identification. We can consider to use pidfd
> instead of PID here.
> 
> sigcontext contains a process state with what the process will be
> resumed after switching the address space and then when a process will
> be stopped, its sate will be saved back to sigcontext.
> 
> siginfo is information about a signal that has interrupted the process.
> If a process is interrupted by a system call, signfo will contain a
> synthetic siginfo of the SIGSYS signal.
> 
> sigmask is a set of signals that process_vm_exec returns via signfo.
> 
> # How fast is it
> 
> In the fourth patch, you can find two benchmarks that execute a function
> that calls system calls in a loop. ptrace_vm_exe uses ptrace to trap
> system calls, proces_vm_exec uses the process_vm_exec syscall to do the
> same thing.
> 
> ptrace_vm_exec:   1446 ns/syscall
> ptrocess_vm_exec:  289 ns/syscall
> 
> PS: This version is just a prototype. Its goal is to collect the initial
> feedback, to discuss the interfaces, and maybe to get some advice on
> implementation..
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Andrei Vagin (4):
>    signal: add a helper to restore a process state from sigcontex
>    arch/x86: implement the process_vm_exec syscall
>    arch/x86: allow to execute syscalls via process_vm_exec
>    selftests: add tests for process_vm_exec
> 
>   arch/Kconfig                                  |  15 ++
>   arch/x86/Kconfig                              |   1 +
>   arch/x86/entry/common.c                       |  19 +++
>   arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>   arch/x86/include/asm/sigcontext.h             |   2 +
>   arch/x86/kernel/Makefile                      |   1 +
>   arch/x86/kernel/process_vm_exec.c             | 160 ++++++++++++++++++
>   arch/x86/kernel/signal.c                      | 125 ++++++++++----
>   include/linux/entry-common.h                  |   2 +
>   include/linux/process_vm_exec.h               |  17 ++
>   include/linux/sched.h                         |   7 +
>   include/linux/syscalls.h                      |   6 +
>   include/uapi/asm-generic/unistd.h             |   4 +-
>   include/uapi/linux/process_vm_exec.h          |   8 +
>   kernel/entry/common.c                         |   2 +-
>   kernel/fork.c                                 |   9 +
>   kernel/sys_ni.c                               |   2 +
>   .../selftests/process_vm_exec/Makefile        |   7 +
>   tools/testing/selftests/process_vm_exec/log.h |  26 +++
>   .../process_vm_exec/process_vm_exec.c         | 105 ++++++++++++
>   .../process_vm_exec/process_vm_exec_fault.c   | 111 ++++++++++++
>   .../process_vm_exec/process_vm_exec_syscall.c |  81 +++++++++
>   .../process_vm_exec/ptrace_vm_exec.c          | 111 ++++++++++++
>   23 files changed, 785 insertions(+), 37 deletions(-)
>   create mode 100644 arch/x86/kernel/process_vm_exec.c
>   create mode 100644 include/linux/process_vm_exec.h
>   create mode 100644 include/uapi/linux/process_vm_exec.h
>   create mode 100644 tools/testing/selftests/process_vm_exec/Makefile
>   create mode 100644 tools/testing/selftests/process_vm_exec/log.h
>   create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec.c
>   create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec_fault.c
>   create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec_syscall.c
>   create mode 100644 tools/testing/selftests/process_vm_exec/ptrace_vm_exec.c
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
