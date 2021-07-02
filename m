Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6243BA29A
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhGBPPD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhGBPPD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 11:15:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A254C061762
        for <linux-api@vger.kernel.org>; Fri,  2 Jul 2021 08:12:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n14so18667004lfu.8
        for <linux-api@vger.kernel.org>; Fri, 02 Jul 2021 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=khrNN02EDjPn05bGelbS4FlmRXR9mKhe5093E+aR9GU=;
        b=a9CXomLJ4GNd0tdcmkWcR+FmNcSc2kTxEU0xtbUD6O3OGNR/M2wgP49Lq3F7YFZs38
         oqgcyEv+SagTByCN0q2uRdW5ipKECVAgViAA1aTBKmqVbTIxdE2wHLRIWLT+Q86HOTQJ
         l7+DZ2ZxNM8tloIrlk3qbkDV3HsizwWyA1s5Y7Jke8Cg98+8kvVkRtTT7kcPA0jQxjV2
         Fo0qsKh0aRE59elDr04R6kZtlvijP4PCxUS/b+q3gO5O18r21Iu26OnzX6kW2xvMx1/3
         WJqmVMes6CXVl01lfFlr/YA/HV5rd2LAvfrQh5Q0WUzS3Ty/7yHCVcUiw/Rkgd6yXlHc
         BhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=khrNN02EDjPn05bGelbS4FlmRXR9mKhe5093E+aR9GU=;
        b=QDHrlmZxHsEMKEPb3oDAwoBWfuQduxVmEAUHfXLZFBX7/pKrqhML9sc+K+Z2uNXqOJ
         Y53+HWuwYFhob3yDl54WcJWwk12usCgOwztciyAxRWJQpKOWc6eDwmmbj6eyrPAlM9IX
         9yccT70x3imJDpI887hSW4oP1SyI20D2ZftIV4t0iYmUx9iMehE2zmafDg9jJN0NMlEJ
         4bhGiTTnlFwCcZdBu6jrlsWJjEmCO/btmzT5KUjLJJVfHiTGHXpHKr950n2PwsgOjiW9
         UfM8MwSEDu4hZd4jBLBCd6Q8sESylzYW17xVHKS9F5GdVfCpN8AzyDq8VsNk3fzR7g0k
         bO1g==
X-Gm-Message-State: AOAM530bussGQivDarxN3Dd6vFP3ji4hfsT3tzYisVCnC4IG80T11NR2
        glgdSiV79fX1+2ZEPo270UFDwbs+U6wwSdbcopaEHA==
X-Google-Smtp-Source: ABdhPJxPyb01nLArk8HsphTcEK9TwKyoakG/3eUzbZINCpJhALlOZQQYpvV7hhCrYlkELzFhkQuBsnRDwBFhONDS5Fc=
X-Received: by 2002:ac2:519b:: with SMTP id u27mr94541lfi.352.1625238749175;
 Fri, 02 Jul 2021 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <CAG48ez0jfsS=gKN0Vo_VS2EvvMBvEr+QNz0vDKPeSAzsrsRwPQ@mail.gmail.com>
 <YN648cPBDIGKYlYa@gmail.com>
In-Reply-To: <YN648cPBDIGKYlYa@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Jul 2021 17:12:02 +0200
Message-ID: <CAG48ez2vLKGTBOmc-5AJQE=j4Uy=HprSJVmJnOR-4Exb5rbMdA@mail.gmail.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
To:     Andrei Vagin <avagin@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 2, 2021 at 9:01 AM Andrei Vagin <avagin@gmail.com> wrote:
> On Wed, Apr 14, 2021 at 08:46:40AM +0200, Jann Horn wrote:
> > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > > We already have process_vm_readv and process_vm_writev to read and wr=
ite
> > > to a process memory faster than we can do this with ptrace. And now i=
t
> > > is time for process_vm_exec that allows executing code in an address
> > > space of another process. We can do this with ptrace but it is much
> > > slower.
> > >
> > > =3D Use-cases =3D
> >
> > It seems to me like your proposed API doesn't really fit either one of
> > those usecases well...
> >
> > > Here are two known use-cases. The first one is =E2=80=9Capplication k=
ernel=E2=80=9D
> > > sandboxes like User-mode Linux and gVisor. In this case, we have a
> > > process that runs the sandbox kernel and a set of stub processes that
> > > are used to manage guest address spaces. Guest code is executed in th=
e
> > > context of stub processes but all system calls are intercepted and
> > > handled in the sandbox kernel. Right now, these sort of sandboxes use
> > > PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> > > significantly speed them up.
> >
> > In this case, since you really only want an mm_struct to run code
> > under, it seems weird to create a whole task with its own PID and so
> > on. It seems to me like something similar to the /dev/kvm API would be
> > more appropriate here? Implementation options that I see for that
> > would be:
> >
> > 1. mm_struct-based:
> >       a set of syscalls to create a new mm_struct,
> >       change memory mappings under that mm_struct, and switch to it
>
> I like the idea to have a handle for mm. Instead of pid, we will pass
> this handle to process_vm_exec. We have pidfd for processes and we can
> introduce mmfd for mm_struct.

I personally think that it might be quite unwieldy when it comes to
the restrictions you get from trying to have shared memory with the
owning process - I'm having trouble figuring out how you can implement
copy-on-write semantics without relying on copy-on-write logic in the
host OS and without being able to use userfaultfd.

But if that's not a problem somehow, and you can find some reasonable
way to handle memory usage accounting and fix up everything that
assumes that multithreaded userspace threads don't switch ->mm, I
guess this might work for your usecase.

> > 2. pagetable-mirroring-based:
> >       like /dev/kvm, an API to create a new pagetable, mirror parts of
> >       the mm_struct's pagetables over into it with modified permissions
> >       (like KVM_SET_USER_MEMORY_REGION),
> >       and run code under that context.
> >       page fault handling would first handle the fault against mm->pgd
> >       as normal, then mirror the PTE over into the secondary pagetables=
.
> >       invalidation could be handled with MMU notifiers.
> >
>
> I found this idea interesting and decided to look at it more closely.
> After reading the kernel code for a few days, I realized that it would
> not be easy to implement something like this,

Yeah, it might need architecture-specific code to flip the page tables
on userspace entry/exit, and maybe also for mirroring them. And for
the TLB flushing logic...

> but more important is that
> I don=E2=80=99t understand what problem it solves. Will it simplify the
> user-space code? I don=E2=80=99t think so. Will it improve performance? I=
t is
> unclear for me too.

Some reasons I can think of are:

 - direct guest memory access: I imagined you'd probably want to be able to
   directly access userspace memory from the supervisor, and
   with this approach that'd become easy.

 - integration with on-demand paging of the host OS: You'd be able to
   create things like file-backed copy-on-write mappings from the
   host filesystem, or implement your own mappings backed by some kind
   of storage using userfaultfd.

 - sandboxing: For sandboxing usecases (not your usecase), it would be
   possible to e.g. create a read-only clone of the entire address space of=
 a
   process and give write access to specific parts of it, or something
   like that.
   These address space clones could potentially be created and destroyed
   fairly quickly.

 - accounting: memory usage would be automatically accounted to the
   supervisor process, so even without a parasite process, you'd be able
   to see the memory usage correctly in things like "top".

 - small (non-pageable) memory footprint in the host kernel:
   The only things the host kernel would have to persistently store would b=
e
   the normal MM data structures for the supervisor plus the mappings
   from "guest userspace" memory ranges to supervisor memory ranges;
   userspace pagetables would be discardable, and could even be shared
   with those of the supervisor in cases where the alignment fits.
   So with this, large anonymous mappings with 4K granularity only cost you
   ~0.20% overhead across host and guest address space; without this, if yo=
u
   used shared mappings instead, you'd pay twice that for every 2MiB range
   from which parts are accessed in both contexts, plus probably another
   ~0.2% or so for the "struct address_space"?

 - all memory-management-related syscalls could be directly performed
   in the "kernel" process

But yeah, some of those aren't really relevant for your usecase, and I
guess things like the accounting aspect could just as well be solved
differently...

> First, in the KVM case, we have a few big linear mappings and need to
> support one =E2=80=9Cshadow=E2=80=9D address space. In the case of sandbo=
xes, we can
> have a tremendous amount of mappings and many address spaces that we
> need to manage.  Memory mappings will be mapped with different addresses
> in a supervisor address space and =E2=80=9Cguest=E2=80=9D address spaces.=
 If guest
> address spaces will not have their mm_structs, we will need to reinvent
> vma-s in some form. If guest address spaces have mm_structs, this will
> look similar to https://lwn.net/Articles/830648/.
>
> Second, each pagetable is tied up with mm_stuct. You suggest creating
> new pagetables that will not have their mm_struct-s (sorry if I
> misunderstood something).

Yeah, that's what I had in mind, page tables without an mm_struct.

> I am not sure that it will be easy to
> implement. How many corner cases will be there?

Yeah, it would require some work around TLB flushing and entry/exit
from userspace. But from a high-level perspective it feels to me like
a change with less systematic impact. Maybe I'm wrong about that.

> As for page faults in a secondary address space, we will need to find a
> fault address in the main address space, handle the fault there and then
> mirror the PTE to the secondary pagetable.

Right.

> Effectively, it means that
> page faults will be handled in two address spaces. Right now, we use
> memfd and shared mappings. It means that each fault is handled only in
> one address space, and we map a guest memory region to the supervisor
> address space only when we need to access it. A large portion of guest
> anonymous memory is never mapped to the supervisor address space.
> Will an overhead of mirrored address spaces be smaller than memfd shared
> mappings? I am not sure.

But as long as the mappings are sufficiently big and aligned properly,
or you explicitly manage the supervisor address space, some of that
cost disappears: E.g. even if a page is mapped in both address spaces,
you wouldn't have a memory cost for the second mapping if the page
tables are shared.

> Third, this approach will not get rid of having process_vm_exec. We will
> need to switch to a guest address space with a specified state and
> switch back on faults or syscalls.

Yeah, you'd still need a syscall for running code under a different
set of page tables. But that's something that KVM _almost_ already
does.

> If the main concern is the ability to
> run syscalls on a remote mm, we can think about how to fix this. I see
> two ways what we can do here:
>
> * Specify the exact list of system calls that are allowed. The first
> three candidates are mmap, munmap, and vmsplice.
>
> * Instead of allowing us to run system calls, we can implement this in
> the form of commands. In the case of sandboxes, we need to implement
> only two commands to create and destroy memory mappings in a target
> address space.

FWIW, there is precedent for something similar: The Android folks
already added process_madvise() for remotely messing with the VMAs of
another process to some degree.
