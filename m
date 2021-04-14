Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4AC35FD98
	for <lists+linux-api@lfdr.de>; Thu, 15 Apr 2021 00:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhDNWNM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 18:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhDNWNL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 18:13:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F71C061574;
        Wed, 14 Apr 2021 15:12:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a85so14247002pfa.0;
        Wed, 14 Apr 2021 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EK884MpOCBxdWk5mXA0bTv5YDCU2uHVx/oqS0Cf9P8E=;
        b=DWMXi7COl7xpo//yBLsqLpvw0K7BJ8rK2lEwFmiJavCqo0Q5eZY+Aun3FbBXr36k4a
         wx5ZVscDHGFaTJbqbYoC2bJVwhmvIaVZJx7MGLBqwlHeysC4+OZQFV6chn7dETBrgevM
         XEUgU+fsWu2idieJbhT9wYhwT2k7B8ww9lmNtvP6xJ3CWN/0K/11yc3pV7Smc4mNDhX/
         qsceulJT1j6Z0v1jvdMctDUGALow6Tgply7al77wSaBzK7wR/Z0ZMKMozbY9DHJbHgZk
         FZQ70ONIdBwCgGBub/1GhxT8nQQTdSr4pMv9s+rCSMgpLKB1mXXcuGtBPzJ0nY2j7MVV
         zrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EK884MpOCBxdWk5mXA0bTv5YDCU2uHVx/oqS0Cf9P8E=;
        b=ocANfmzc6oCsSAUk3Qt+Fs/SMgRYJ7HjOGUpm40dy6edUa5b/xf6tysSlMLOqwW/n8
         D3D19B6YJ5Ps+EctHvR4LiHhyN2/W2BK2+thvtsHy1HJ6CIPmrcrNs0lFQNJoXtl9gyR
         WU9VFLakldE4m/HJbwAvU8eMQ6b6ZwCvwBHW+7grXe8jrj5rrd2GwHrrSs/teA2j0KtP
         sfE20ZDbJGsr0LdMj3nrOkYqfb9s3QCqVNRAAiwYmojwA3VqNVNNYqNfMiRoEpour6vD
         I8/viGqUQS4q5OULbXbCT64dMlBFBX7vKq9eu+0yJJXU1tXe+sN2OiBE4/9dGxsKW759
         GsgQ==
X-Gm-Message-State: AOAM532jmUsGlyfZo9nREdm7cpVIdOgUfYJXEgMVnDpiEOFOR7zjH4I/
        fXxS5be18gx7vcc3xnI9PmU=
X-Google-Smtp-Source: ABdhPJxYihVqjxbTGniiZF0nmmXc3U5+mhPVSc6vvXqf9jKLNvxLc9QTmVoGku1gUPxZP+sHhIA+Dw==
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id z17-20020aa791d10000b02901fe2a0273b9mr247958pfa.2.1618438369166;
        Wed, 14 Apr 2021 15:12:49 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id mz20sm305131pjb.55.2021.04.14.15.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 15:12:48 -0700 (PDT)
Date:   Wed, 14 Apr 2021 15:10:12 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
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
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
Message-ID: <YHdoRAJb9VlZ5lSu@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <CAG48ez0jfsS=gKN0Vo_VS2EvvMBvEr+QNz0vDKPeSAzsrsRwPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0jfsS=gKN0Vo_VS2EvvMBvEr+QNz0vDKPeSAzsrsRwPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 08:46:40AM +0200, Jann Horn wrote:
> On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > We already have process_vm_readv and process_vm_writev to read and write
> > to a process memory faster than we can do this with ptrace. And now it
> > is time for process_vm_exec that allows executing code in an address
> > space of another process. We can do this with ptrace but it is much
> > slower.
> >
> > = Use-cases =
> 
> It seems to me like your proposed API doesn't really fit either one of
> those usecases well...

We definitely can invent more specific interfaces for each of these
problems. Sure, they will handle their use-cases a bit better than this
generic one. But do we want to have two very specific interfaces with
separate kernel implementations? My previous experiences showed that the
kernel community doesn't like interfaces that are specific for only one
narrow use-case.

So when I was working on process_vm_exec, I was thinking how to make
one interfaces that will be good enough for all these use-cases.

> 
> > Here are two known use-cases. The first one is “application kernel”
> > sandboxes like User-mode Linux and gVisor. In this case, we have a
> > process that runs the sandbox kernel and a set of stub processes that
> > are used to manage guest address spaces. Guest code is executed in the
> > context of stub processes but all system calls are intercepted and
> > handled in the sandbox kernel. Right now, these sort of sandboxes use
> > PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> > significantly speed them up.
> 
> In this case, since you really only want an mm_struct to run code
> under, it seems weird to create a whole task with its own PID and so
> on. It seems to me like something similar to the /dev/kvm API would be
> more appropriate here? Implementation options that I see for that
> would be:
> 
> 1. mm_struct-based:
>       a set of syscalls to create a new mm_struct,
>       change memory mappings under that mm_struct, and switch to it
> 2. pagetable-mirroring-based:
>       like /dev/kvm, an API to create a new pagetable, mirror parts of
>       the mm_struct's pagetables over into it with modified permissions
>       (like KVM_SET_USER_MEMORY_REGION),
>       and run code under that context.
>       page fault handling would first handle the fault against mm->pgd
>       as normal, then mirror the PTE over into the secondary pagetables.
>       invalidation could be handled with MMU notifiers.

We are ready to discuss this sort of interfaces if the community will
agree to accept it. Are there any other users except sandboxes that will
need something like this? Will the sandbox use-case enough to justify
the addition of this interface?

> 
> > Another use-case is CRIU (Checkpoint/Restore in User-space). Several
> > process properties can be received only from the process itself. Right
> > now, we use a parasite code that is injected into the process. We do
> > this with ptrace but it is slow, unsafe, and tricky.
> 
> But this API will only let you run code under the *mm* of the target
> process, not fully in the context of a target *task*, right? So you
> still won't be able to use this for accessing anything other than
> memory? That doesn't seem very generically useful to me.

You are right, this will not rid us of the need to run a parasite code.
I wrote that it will make a process of injecting a parasite code a bit
simpler.

> 
> Also, I don't doubt that anything involving ptrace is kinda tricky,
> but it would be nice to have some more detail on what exactly makes
> this slow, unsafe and tricky. Are there API additions for ptrace that
> would make this work better? I imagine you're thinking of things like
> an API for injecting a syscall into the target process without having
> to first somehow find an existing SYSCALL instruction in the target
> process?


You describe the first problem right. We need to find or inject a
syscall instruction to a target process.
Right now, we need to do these steps to execute a system call:

* inject the syscall instruction (PTRACE_PEEKDATA/PTRACE_POKEDATA).
* get origin registers
* set new registers
* get a signal mask.
* block signals
* resume the process
* stop it on the next syscall-exit
* get registers
* set origin registers
* restore a signal mask.

One of the CRIU principals is to avoid changing a process state, so if
criu is interrupted, processes must be resumed and continue running. The
procedure of injecting a system call creates a window when a process is
in an inconsistent state, and a disappearing CRIU at such moments will
be fatal for the process. We don't think that we can eliminate such
windows, but we want to make them smaller.

In CRIU, we have a self-healed parasite. The idea is to inject a
parasite code with a signal frame that contains the origin process
state. The parasite runs in an "RPC daemon mode" and gets commands from
criu via a unix socket. If it detects that criu disappeared, it calls
rt_sigreturn and resumes the origin process.

As for the performance of the ptrace, there are a few reasons why it is
slow. First, it is a number of steps what we need to do. Second, it is
two synchronious context switches. Even if we will solve the first
problem with a new ptrace command, it will be not enough to stop using a
parasite in CRIU.

> 
> > process_vm_exec can
> > simplify the process of injecting a parasite code and it will allow
> > pre-dump memory without stopping processes. The pre-dump here is when we
> > enable a memory tracker and dump the memory while a process is continue
> > running. On each interaction we dump memory that has been changed from
> > the previous iteration. In the final step, we will stop processes and
> > dump their full state. Right now the most effective way to dump process
> > memory is to create a set of pipes and splice memory into these pipes
> > from the parasite code. With process_vm_exec, we will be able to call
> > vmsplice directly. It means that we will not need to stop a process to
> > inject the parasite code.
> 
> Alternatively you could add splice support to /proc/$pid/mem or add a
> syscall similar to process_vm_readv() that splices into a pipe, right?

We send patches to introcude process_vm_splice:
https://lore.kernel.org/patchwork/cover/871116/

but they were not merged and the main reason was a lack of enough users
to justify its addition.
