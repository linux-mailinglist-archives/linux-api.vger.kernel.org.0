Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF43CC712
	for <lists+linux-api@lfdr.de>; Sun, 18 Jul 2021 02:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhGRAph (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Jul 2021 20:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhGRApg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Jul 2021 20:45:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68942C061762;
        Sat, 17 Jul 2021 17:42:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so14800815pgn.4;
        Sat, 17 Jul 2021 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nE+L/Xja+gxlPGZE3r8KM767jVoS3CfJjp8H3gvsYtU=;
        b=DR5rLyV1O5knGWcJzvggVVavgcLr/uK1QFJ2D3GY38KomcwkRunt2BTi92PoHQZJG3
         7XDjZgNrVd3kyuDEA2XjRwAMTSF06POe2nrSb/IS8W5wyQenkzb+BnKazoelzJl7bLkR
         KZyFASV55i2xf4BCyTrfXvJFfrvmjxjF6z1UwKJjU4VT9IftdSjPRXhOx+iM3jJc3n8S
         R3m3EsbQy+ceSGqDIa2ZqFy5SlqxmN5ozs7yaO4nDJPqCwoCRyEG54wxQ9z/addqy/RE
         gOG4KvAJonXjJbG0D5ySiCfJkdCjn/igCaV0TPL5ouDcDE66EyV3RLDOeIv32ZwGa+wJ
         qFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nE+L/Xja+gxlPGZE3r8KM767jVoS3CfJjp8H3gvsYtU=;
        b=hfXjaTq3LvSUfiubUzUCyl/i8oYqxapX3CJnSpd51I/RxiKzagSMCjQhUHK7tUliIw
         No4nloXe9l4OkVfEr/hx2yMmyeaH9Xz6JlzrNO4v178yhOjWx3pfNEqmKlzvIAQ8GbTV
         1hTvLiX7UhsjFDKaHHjZwZ9cZyTsnwY0LCvGZwaaYpks3pPUDm552Zr+BooAZ6Oa97Pa
         BHK2EY+HTYPX/5sLnfCQLtbn0swPHKJHo4sAUZpYcxIV3k4FnANsHsE16Wu5JWdO+EaH
         MEF8j0bkO22UC0cczsHNEQBRgcOp4P6tDmIp92ggJkqnqAJeTAB5YIdx9aaosOZATL8M
         TBFQ==
X-Gm-Message-State: AOAM533Qy6eWN/HuDqcpGGaOfbIDjk0IbrPlgHlif+MlI4XpJI/9rprE
        Px4vhBSsdI6jBOw777BCif0=
X-Google-Smtp-Source: ABdhPJwnHMVN3lApnkrs+/nrBY9CHlMQPq4uS3Zr9vLvMcgS5woeLjkNrSJNA/WeXhNk213TwtBUzg==
X-Received: by 2002:a63:3584:: with SMTP id c126mr17559798pga.33.1626568957780;
        Sat, 17 Jul 2021 17:42:37 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id a24sm7777228pgj.12.2021.07.17.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 17:42:37 -0700 (PDT)
Date:   Sat, 17 Jul 2021 17:38:52 -0700
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
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
Message-ID: <YPN4HNHAQy02gSbx@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <CAG48ez0jfsS=gKN0Vo_VS2EvvMBvEr+QNz0vDKPeSAzsrsRwPQ@mail.gmail.com>
 <YN648cPBDIGKYlYa@gmail.com>
 <CAG48ez2vLKGTBOmc-5AJQE=j4Uy=HprSJVmJnOR-4Exb5rbMdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2vLKGTBOmc-5AJQE=j4Uy=HprSJVmJnOR-4Exb5rbMdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 02, 2021 at 05:12:02PM +0200, Jann Horn wrote:
> On Fri, Jul 2, 2021 at 9:01 AM Andrei Vagin <avagin@gmail.com> wrote:
> > On Wed, Apr 14, 2021 at 08:46:40AM +0200, Jann Horn wrote:
> > > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > > > We already have process_vm_readv and process_vm_writev to read and write
> > > > to a process memory faster than we can do this with ptrace. And now it
> > > > is time for process_vm_exec that allows executing code in an address
> > > > space of another process. We can do this with ptrace but it is much
> > > > slower.
> > > >
> > > > = Use-cases =
> > >
> > > It seems to me like your proposed API doesn't really fit either one of
> > > those usecases well...
> > >
> > > > Here are two known use-cases. The first one is “application kernel”
> > > > sandboxes like User-mode Linux and gVisor. In this case, we have a
> > > > process that runs the sandbox kernel and a set of stub processes that
> > > > are used to manage guest address spaces. Guest code is executed in the
> > > > context of stub processes but all system calls are intercepted and
> > > > handled in the sandbox kernel. Right now, these sort of sandboxes use
> > > > PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> > > > significantly speed them up.
> > >
> > > In this case, since you really only want an mm_struct to run code
> > > under, it seems weird to create a whole task with its own PID and so
> > > on. It seems to me like something similar to the /dev/kvm API would be
> > > more appropriate here? Implementation options that I see for that
> > > would be:
> > >
> > > 1. mm_struct-based:
> > >       a set of syscalls to create a new mm_struct,
> > >       change memory mappings under that mm_struct, and switch to it
> >
> > I like the idea to have a handle for mm. Instead of pid, we will pass
> > this handle to process_vm_exec. We have pidfd for processes and we can
> > introduce mmfd for mm_struct.
> 
> I personally think that it might be quite unwieldy when it comes to
> the restrictions you get from trying to have shared memory with the
> owning process - I'm having trouble figuring out how you can implement
> copy-on-write semantics without relying on copy-on-write logic in the
> host OS and without being able to use userfaultfd.

It is easy. COW mappings are mapped to guest address spaces without the
write permission. If one of processes wants to write something, it
triggers a fault that is handled in the Sentry (supervisor/kernel).

> 
> But if that's not a problem somehow, and you can find some reasonable
> way to handle memory usage accounting and fix up everything that
> assumes that multithreaded userspace threads don't switch ->mm, I
> guess this might work for your usecase.
> 
> > > 2. pagetable-mirroring-based:
> > >       like /dev/kvm, an API to create a new pagetable, mirror parts of
> > >       the mm_struct's pagetables over into it with modified permissions
> > >       (like KVM_SET_USER_MEMORY_REGION),
> > >       and run code under that context.
> > >       page fault handling would first handle the fault against mm->pgd
> > >       as normal, then mirror the PTE over into the secondary pagetables.
> > >       invalidation could be handled with MMU notifiers.
> > >
> >
> > I found this idea interesting and decided to look at it more closely.
> > After reading the kernel code for a few days, I realized that it would
> > not be easy to implement something like this,
> 
> Yeah, it might need architecture-specific code to flip the page tables
> on userspace entry/exit, and maybe also for mirroring them. And for
> the TLB flushing logic...
> 
> > but more important is that
> > I don’t understand what problem it solves. Will it simplify the
> > user-space code? I don’t think so. Will it improve performance? It is
> > unclear for me too.
> 
> Some reasons I can think of are:
> 
>  - direct guest memory access: I imagined you'd probably want to be able to
>    directly access userspace memory from the supervisor, and
>    with this approach that'd become easy.

Right now, we use shared memory regions for that and they work fine. As
I already mentioned the most part of memory are never mapped to the
supervisor address space.

> 
>  - integration with on-demand paging of the host OS: You'd be able to
>    create things like file-backed copy-on-write mappings from the
>    host filesystem, or implement your own mappings backed by some kind
>    of storage using userfaultfd.

This isn't a problem either...

> 
>  - sandboxing: For sandboxing usecases (not your usecase), it would be
>    possible to e.g. create a read-only clone of the entire address space of a
>    process and give write access to specific parts of it, or something
>    like that.
>    These address space clones could potentially be created and destroyed
>    fairly quickly.

This is a very valid example and I would assume this is where your idea
was coming from. I have some doubts about the idea of additional
sub-page-tables in the kernel, but I know a good way how to implement
your idea with KVM. You can look at how the KVM platform is implemented in
gVisor and this sort of sandboxing can be implemented in the same way.

In a few words, we create a KVM virtual machine, repeat the process
address space in the guest ring0, implement basic operating system-level
stubs, so that the process can jump between the host ring3 and the guest
ring0.

https://github.com/google/gvisor/blob/master/pkg/ring0/
https://github.com/google/gvisor/tree/master/pkg/sentry/platform/kvm

When we have all these bits, we can create any page tables for a guest
ring3 and run untrusted code there. The sandbox process switches to
the guest ring0 and then it switches to a guest ring3 with a specified
page tables and a state.

https://cs.opensource.google/gvisor/gvisor/+/master:pkg/sentry/platform/kvm/machine_amd64.go;l=356

With this scheme, the sandbox process will have direct access to page
tables and will be able to change them.

> 
>  - accounting: memory usage would be automatically accounted to the
>    supervisor process, so even without a parasite process, you'd be able
>    to see the memory usage correctly in things like "top".
> 
>  - small (non-pageable) memory footprint in the host kernel:
>    The only things the host kernel would have to persistently store would be
>    the normal MM data structures for the supervisor plus the mappings
>    from "guest userspace" memory ranges to supervisor memory ranges;
>    userspace pagetables would be discardable, and could even be shared
>    with those of the supervisor in cases where the alignment fits.
>    So with this, large anonymous mappings with 4K granularity only cost you
>    ~0.20% overhead across host and guest address space; without this, if you
>    used shared mappings instead, you'd pay twice that for every 2MiB range
>    from which parts are accessed in both contexts, plus probably another
>    ~0.2% or so for the "struct address_space"?

If we use shared mappings, we don't map the most part of guest memory to
the supervisor address space and don't have page tables for it there. I
would say that this is a question where a memory footprint will be
smaller...

> 
>  - all memory-management-related syscalls could be directly performed
>    in the "kernel" process
> 
> But yeah, some of those aren't really relevant for your usecase, and I
> guess things like the accounting aspect could just as well be solved
> differently...
> 
> > First, in the KVM case, we have a few big linear mappings and need to
> > support one “shadow” address space. In the case of sandboxes, we can
> > have a tremendous amount of mappings and many address spaces that we
> > need to manage.  Memory mappings will be mapped with different addresses
> > in a supervisor address space and “guest” address spaces. If guest
> > address spaces will not have their mm_structs, we will need to reinvent
> > vma-s in some form. If guest address spaces have mm_structs, this will
> > look similar to https://lwn.net/Articles/830648/.
> >
> > Second, each pagetable is tied up with mm_stuct. You suggest creating
> > new pagetables that will not have their mm_struct-s (sorry if I
> > misunderstood something).
> 
> Yeah, that's what I had in mind, page tables without an mm_struct.
> 
> > I am not sure that it will be easy to
> > implement. How many corner cases will be there?
> 
> Yeah, it would require some work around TLB flushing and entry/exit
> from userspace. But from a high-level perspective it feels to me like
> a change with less systematic impact. Maybe I'm wrong about that.
> 
> > As for page faults in a secondary address space, we will need to find a
> > fault address in the main address space, handle the fault there and then
> > mirror the PTE to the secondary pagetable.
> 
> Right.
> 
> > Effectively, it means that
> > page faults will be handled in two address spaces. Right now, we use
> > memfd and shared mappings. It means that each fault is handled only in
> > one address space, and we map a guest memory region to the supervisor
> > address space only when we need to access it. A large portion of guest
> > anonymous memory is never mapped to the supervisor address space.
> > Will an overhead of mirrored address spaces be smaller than memfd shared
> > mappings? I am not sure.
> 
> But as long as the mappings are sufficiently big and aligned properly,
> or you explicitly manage the supervisor address space, some of that
> cost disappears: E.g. even if a page is mapped in both address spaces,
> you wouldn't have a memory cost for the second mapping if the page
> tables are shared.

You are right. It is interesting how many pte-s will be shared. For
example, if a guest process forks a child, all anon memory will be COW,
this means we will need to remove the W bit from pte-s and so we will
need to allocate pte-s for both processes...

> 
> > Third, this approach will not get rid of having process_vm_exec. We will
> > need to switch to a guest address space with a specified state and
> > switch back on faults or syscalls.
> 
> Yeah, you'd still need a syscall for running code under a different
> set of page tables. But that's something that KVM _almost_ already
> does.

I don't understand this analogy with KVM...

> 
> > If the main concern is the ability to
> > run syscalls on a remote mm, we can think about how to fix this. I see
> > two ways what we can do here:
> >
> > * Specify the exact list of system calls that are allowed. The first
> > three candidates are mmap, munmap, and vmsplice.
> >
> > * Instead of allowing us to run system calls, we can implement this in
> > the form of commands. In the case of sandboxes, we need to implement
> > only two commands to create and destroy memory mappings in a target
> > address space.
> 
> FWIW, there is precedent for something similar: The Android folks
> already added process_madvise() for remotely messing with the VMAs of
> another process to some degree.

I know. We tried to implement process_vm_mmap and process_vm_splice:

https://lkml.org/lkml/2018/1/9/32
https://patchwork.kernel.org/project/linux-mm/cover/155836064844.2441.10911127801797083064.stgit@localhost.localdomain/

Thanks,
Andrei
