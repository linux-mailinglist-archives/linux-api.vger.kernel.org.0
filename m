Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F635EC96
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 07:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhDNFzQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 01:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhDNFzP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 01:55:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF3C061574;
        Tue, 13 Apr 2021 22:54:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y2so9491533plg.5;
        Tue, 13 Apr 2021 22:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SS7TfLcX3MlIeFX8w3xQCLk3KlSKpLv7cvdIhmhAbc=;
        b=ryrnYW3p7SbZXMlLv9/ra9F8bIuoQScZP8/IV4eEUXZJOgKi6d17pjW9ydO2tX7sG3
         WM+wB6LxDHlLBoaQ/Zg1IssqZF2qTiFs7X2rU28fUOWr2KJ9Bu+9JKO5VGTSciz8MuG0
         4Mo1WbZMAOVvV1tR17zDsXH0EnN1f8eWXZQEQQHBOIF3uq3Z/pTEMIiqB0r5P58R69gH
         pNx7edjzHG6ifFSfqF+c/9TRL8fNKHbPMhNW+s0c1MPvaDL2t0xFEQIDvSfuEpfbgl/c
         gzMzkiPnavry8jrMjHFmtJqpNVbHV/7nfPYuDLpgA5edMNZQCdBdwE5abkAi+/6VhUpO
         xMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SS7TfLcX3MlIeFX8w3xQCLk3KlSKpLv7cvdIhmhAbc=;
        b=hACWXQldygsqbNYHkAFJ7aMz5vLYhTS/Cnsuip0JakSUMbVCHB6ODenHicbrmpkmbd
         WXQ03rhBVUNan1R7gQsPSaKe7wFZGVzliC43IP4iy6D5xU+At0vs66aXAX2Ous+GYXA5
         1jo1V61w1rU7Xqgb7BjfpfDMnciW5dtUJgVo8CGRWLs5VGOOwZCfJX1l4rFBoSR7V7XK
         M43lhLYdPksZjcobPR97D5h5alXkfMdT3FJsEp+wGn2QusLhzvc8fa3R3wC0sFvVhTAj
         tZOSxSJILDCgGjVy3H/tPdVFxCHBInun6WvsZ4oib0TCHgvmN6pAy5sRohyVkhgZQnWR
         a3Pw==
X-Gm-Message-State: AOAM5307v7gpDxdz9DvfRnLSeZ4JFsZ4kZJJ7A5GYP1mIhKjdf9nI6Y8
        Uge52jnKwb9NHNJYEEhG38K/FsmZgXpvbahq
X-Google-Smtp-Source: ABdhPJz8mixwYF1iRmYLcpc7Q+i79Q2AdDqqW3lovuPkYLGs61jcUK2d5F0vgOQn1ifaPyACOC6ewA==
X-Received: by 2002:a17:903:2309:b029:e7:1063:e6aa with SMTP id d9-20020a1709032309b02900e71063e6aamr36310484plh.52.1618379693978;
        Tue, 13 Apr 2021 22:54:53 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u17sm13728969pfm.113.2021.04.13.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:54:53 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
Date:   Tue, 13 Apr 2021 22:52:13 -0700
Message-Id: <20210414055217.543246-1-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

We already have process_vm_readv and process_vm_writev to read and write
to a process memory faster than we can do this with ptrace. And now it
is time for process_vm_exec that allows executing code in an address
space of another process. We can do this with ptrace but it is much
slower.

= Use-cases =

Here are two known use-cases. The first one is “application kernel”
sandboxes like User-mode Linux and gVisor. In this case, we have a
process that runs the sandbox kernel and a set of stub processes that
are used to manage guest address spaces. Guest code is executed in the
context of stub processes but all system calls are intercepted and
handled in the sandbox kernel. Right now, these sort of sandboxes use
PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
significantly speed them up.

Another use-case is CRIU (Checkpoint/Restore in User-space). Several
process properties can be received only from the process itself. Right
now, we use a parasite code that is injected into the process. We do
this with ptrace but it is slow, unsafe, and tricky. process_vm_exec can
simplify the process of injecting a parasite code and it will allow
pre-dump memory without stopping processes. The pre-dump here is when we
enable a memory tracker and dump the memory while a process is continue
running. On each interaction we dump memory that has been changed from
the previous iteration. In the final step, we will stop processes and
dump their full state. Right now the most effective way to dump process
memory is to create a set of pipes and splice memory into these pipes
from the parasite code. With process_vm_exec, we will be able to call
vmsplice directly. It means that we will not need to stop a process to
inject the parasite code.

= How it works =

process_vm_exec has two modes:

* Execute code in an address space of a target process and stop on any
  signal or system call.

* Execute a system call in an address space of a target process.

int process_vm_exec(pid_t pid, struct sigcontext uctx,
		    unsigned long flags, siginfo_t siginfo,
		    sigset_t  *sigmask, size_t sizemask)

PID - target process identification. We can consider to use pidfd
instead of PID here.

sigcontext contains a process state with what the process will be
resumed after switching the address space and then when a process will
be stopped, its sate will be saved back to sigcontext.

siginfo is information about a signal that has interrupted the process.
If a process is interrupted by a system call, signfo will contain a
synthetic siginfo of the SIGSYS signal.

sigmask is a set of signals that process_vm_exec returns via signfo.

# How fast is it

In the fourth patch, you can find two benchmarks that execute a function
that calls system calls in a loop. ptrace_vm_exe uses ptrace to trap
system calls, proces_vm_exec uses the process_vm_exec syscall to do the
same thing.

ptrace_vm_exec:   1446 ns/syscall
ptrocess_vm_exec:  289 ns/syscall

PS: This version is just a prototype. Its goal is to collect the initial
feedback, to discuss the interfaces, and maybe to get some advice on
implementation..

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>

Andrei Vagin (4):
  signal: add a helper to restore a process state from sigcontex
  arch/x86: implement the process_vm_exec syscall
  arch/x86: allow to execute syscalls via process_vm_exec
  selftests: add tests for process_vm_exec

 arch/Kconfig                                  |  15 ++
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/common.c                       |  19 +++
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/include/asm/sigcontext.h             |   2 +
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/process_vm_exec.c             | 160 ++++++++++++++++++
 arch/x86/kernel/signal.c                      | 125 ++++++++++----
 include/linux/entry-common.h                  |   2 +
 include/linux/process_vm_exec.h               |  17 ++
 include/linux/sched.h                         |   7 +
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |   4 +-
 include/uapi/linux/process_vm_exec.h          |   8 +
 kernel/entry/common.c                         |   2 +-
 kernel/fork.c                                 |   9 +
 kernel/sys_ni.c                               |   2 +
 .../selftests/process_vm_exec/Makefile        |   7 +
 tools/testing/selftests/process_vm_exec/log.h |  26 +++
 .../process_vm_exec/process_vm_exec.c         | 105 ++++++++++++
 .../process_vm_exec/process_vm_exec_fault.c   | 111 ++++++++++++
 .../process_vm_exec/process_vm_exec_syscall.c |  81 +++++++++
 .../process_vm_exec/ptrace_vm_exec.c          | 111 ++++++++++++
 23 files changed, 785 insertions(+), 37 deletions(-)
 create mode 100644 arch/x86/kernel/process_vm_exec.c
 create mode 100644 include/linux/process_vm_exec.h
 create mode 100644 include/uapi/linux/process_vm_exec.h
 create mode 100644 tools/testing/selftests/process_vm_exec/Makefile
 create mode 100644 tools/testing/selftests/process_vm_exec/log.h
 create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec.c
 create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec_fault.c
 create mode 100644 tools/testing/selftests/process_vm_exec/process_vm_exec_syscall.c
 create mode 100644 tools/testing/selftests/process_vm_exec/ptrace_vm_exec.c

-- 
2.29.2

