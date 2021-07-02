Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBB3B9CAE
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 09:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGBHEA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGBHD7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 03:03:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B2C061762;
        Fri,  2 Jul 2021 00:01:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d1so5092258plg.6;
        Fri, 02 Jul 2021 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pOxwy4S8+CMaHsFPZCERpcLAZFzgkbgCU7ysS2kserA=;
        b=C7iqWm/wesRNy/TjG2rGEA+W4kQ+TyHVuuL7z1F62PhJmxaaEoArlcQc84EmSneSqz
         iznC5OCPYsOsUJxJhgRSMTidOscJf/aghiOmDfzN8vcOyS9Ktom0AAY3oZkSKKjSXO1d
         bNX6lm2SULxR5MVs+e4vybMcekoS7NI2FBZQjmcpcDVbq1yNnSJqb1zN5kPr2Z1pUbNk
         A5G6ojm9VhQ8EdJjli5tjWX9R26cjvQG9ITwcfWD6VHn+xMCAGOok6yLzhJ4HNTQ0yGZ
         /Y/LCtDHcowpYrJJLDpAoIzycnxxFSBNvQyxIEhjKJ4y6wPKqpXxQSs7x9PXOvzmkcds
         oZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pOxwy4S8+CMaHsFPZCERpcLAZFzgkbgCU7ysS2kserA=;
        b=Huu+9TsdpC67OgbLtHNe97lTzt0BMZGwO1TZvd24qV+NJdw7gnEWIp5Uwuv6LHBn6f
         c6eAxbeZtsOsoqKHPgunxvYoEpgAUd1mZ/efIr2eCOZ8wbsNFAwjpwkNsHP4Q3Wk+l7U
         nnjbYGPrvgyN0cZSeqF3e9U0hwNzHvuIk4TrJ76lXzWgt5FyggnjwpOPWs8FHdM/Fzfv
         HyA/6AG6TLYR31bbHPsLqpEwxW4MPvzPlXYg4dSZhu5KRwhSJ3ZDvyrJfmPQVVK8yMGM
         vlg4C+CUvyJJzm/PbUy2K3Bn1ULQOTfswHII3PbJMSuebLUW6T6Pa5Q5/uqqHn/2fen5
         mrVA==
X-Gm-Message-State: AOAM532/9WmDYzMI5jjeNew+IGS7zo07YLsSuNgdPUp6UtYdnqj0T2Cw
        GkHXysuYazLxjWC3VTCIoSI=
X-Google-Smtp-Source: ABdhPJyfi/fuR+AXjHafBzne+j9YCvbhOaUZINfEYssRYGLtqsbz0Nrvakl5C11G5EnSvNYHMM3PVw==
X-Received: by 2002:a17:90b:4c4b:: with SMTP id np11mr13875779pjb.125.1625209286236;
        Fri, 02 Jul 2021 00:01:26 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id p14sm2378495pgb.2.2021.07.02.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 00:01:25 -0700 (PDT)
Date:   Thu, 1 Jul 2021 23:57:53 -0700
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
Message-ID: <YN648cPBDIGKYlYa@gmail.com>
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

I like the idea to have a handle for mm. Instead of pid, we will pass
this handle to process_vm_exec. We have pidfd for processes and we can
introduce mmfd for mm_struct.


> 2. pagetable-mirroring-based:
>       like /dev/kvm, an API to create a new pagetable, mirror parts of
>       the mm_struct's pagetables over into it with modified permissions
>       (like KVM_SET_USER_MEMORY_REGION),
>       and run code under that context.
>       page fault handling would first handle the fault against mm->pgd
>       as normal, then mirror the PTE over into the secondary pagetables.
>       invalidation could be handled with MMU notifiers.
>

I found this idea interesting and decided to look at it more closely.
After reading the kernel code for a few days, I realized that it would
not be easy to implement something like this, but more important is that
I don’t understand what problem it solves. Will it simplify the
user-space code? I don’t think so. Will it improve performance? It is
unclear for me too.

First, in the KVM case, we have a few big linear mappings and need to
support one “shadow” address space. In the case of sandboxes, we can
have a tremendous amount of mappings and many address spaces that we
need to manage.  Memory mappings will be mapped with different addresses
in a supervisor address space and “guest” address spaces. If guest
address spaces will not have their mm_structs, we will need to reinvent
vma-s in some form. If guest address spaces have mm_structs, this will
look similar to https://lwn.net/Articles/830648/.

Second, each pagetable is tied up with mm_stuct. You suggest creating
new pagetables that will not have their mm_struct-s (sorry if I
misunderstood something). I am not sure that it will be easy to
implement. How many corner cases will be there?

As for page faults in a secondary address space, we will need to find a
fault address in the main address space, handle the fault there and then
mirror the PTE to the secondary pagetable. Effectively, it means that
page faults will be handled in two address spaces. Right now, we use
memfd and shared mappings. It means that each fault is handled only in
one address space, and we map a guest memory region to the supervisor
address space only when we need to access it. A large portion of guest
anonymous memory is never mapped to the supervisor address space.
Will an overhead of mirrored address spaces be smaller than memfd shared
mappings? I am not sure.

Third, this approach will not get rid of having process_vm_exec. We will
need to switch to a guest address space with a specified state and
switch back on faults or syscalls. If the main concern is the ability to
run syscalls on a remote mm, we can think about how to fix this. I see
two ways what we can do here:

* Specify the exact list of system calls that are allowed. The first
three candidates are mmap, munmap, and vmsplice.

* Instead of allowing us to run system calls, we can implement this in
the form of commands. In the case of sandboxes, we need to implement
only two commands to create and destroy memory mappings in a target
address space.

Thanks,
Andrei
