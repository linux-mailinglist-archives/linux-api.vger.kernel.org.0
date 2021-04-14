Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F235EDA9
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbhDNGra (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhDNGra (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 02:47:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE6C061574
        for <linux-api@vger.kernel.org>; Tue, 13 Apr 2021 23:47:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x19so935930lfa.2
        for <linux-api@vger.kernel.org>; Tue, 13 Apr 2021 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o7YUQsFXpVVzDPEGdF/U6Rn3Tg4j4C3osu9eHf3orK8=;
        b=XFdPNvxHWkKqyNvtRYRixrne43Ud5Nv45e7x2J2k1gwoawHyEst2zAorc/4jV6vHD1
         oyXh7R900sVsURqzY9z5CF9GdkWfPWZBTZqjaLkdE+ZOtopofHjjAdYzCXioCmykjnvF
         +1pYiMxqkkSP8v9lYZAzGbskYFWnEcuw7NyeylG0jbp/LC0agt2r/lo+yHJ8bwLCYupV
         eb/9FJUNPS1ay4ujpaR1YQfm4qOxruB9WA0oGJjROfcSRJex5azES4JtqykbhYmKt8rW
         QA2UEneBNegtkiA4ckUfJ6uBsw1Q555Bx3vZ97CDQps9ybNI3bz1X40h03mZHwgE56hC
         npqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o7YUQsFXpVVzDPEGdF/U6Rn3Tg4j4C3osu9eHf3orK8=;
        b=RKSbpJHP4A/mVURjMs42xk9CwoYIedBLaM2fuywzOEojZhz8pA+kOiyJpSxVfPbxwG
         9/NDzGzfi+g+wy5AK7Rzx/m/H4L/nme9tol6h6u6UM0iMkqapIq0yU15IyGNxD20Gk8V
         hR6Nnmz8Wx0YiylMV3Bg89ujt6ig69SjEyJ9jTCJjcpCxOB8z5HRBP3Y7Jwtnv6QT9ZZ
         lVswwrLh/R0/tFk5qsHMFjfoIefDLzGeifHy0wvAtyXv0xujtT6DardgRmByVXHlUVX2
         w/s3wynIteyJR+nh1tdnrHW+MbrV3LL0eGiGXpHsCMFxT5gD0KZBVOfZ0R7NeuczPW2C
         gldQ==
X-Gm-Message-State: AOAM531LRq9kvXkoMruHidQrZ8Cpcl3umKjSOMLw0B3YGejITsMarREb
        fUOaZBS2XpvAuGsrD206CTiPQd1Ira6z88N7TMnHuA==
X-Google-Smtp-Source: ABdhPJzLne3z/hFVoU9gPpwPkGPHfCAenskPK5svCrkqJUaNsYIIt5zqjrr8wnjLp78YEG8UCr7QefSS/zpN7U3t21g=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr24510963lfu.356.1618382827311;
 Tue, 13 Apr 2021 23:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com>
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 14 Apr 2021 08:46:40 +0200
Message-ID: <CAG48ez0jfsS=gKN0Vo_VS2EvvMBvEr+QNz0vDKPeSAzsrsRwPQ@mail.gmail.com>
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
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> We already have process_vm_readv and process_vm_writev to read and write
> to a process memory faster than we can do this with ptrace. And now it
> is time for process_vm_exec that allows executing code in an address
> space of another process. We can do this with ptrace but it is much
> slower.
>
> =3D Use-cases =3D

It seems to me like your proposed API doesn't really fit either one of
those usecases well...

> Here are two known use-cases. The first one is =E2=80=9Capplication kerne=
l=E2=80=9D
> sandboxes like User-mode Linux and gVisor. In this case, we have a
> process that runs the sandbox kernel and a set of stub processes that
> are used to manage guest address spaces. Guest code is executed in the
> context of stub processes but all system calls are intercepted and
> handled in the sandbox kernel. Right now, these sort of sandboxes use
> PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> significantly speed them up.

In this case, since you really only want an mm_struct to run code
under, it seems weird to create a whole task with its own PID and so
on. It seems to me like something similar to the /dev/kvm API would be
more appropriate here? Implementation options that I see for that
would be:

1. mm_struct-based:
      a set of syscalls to create a new mm_struct,
      change memory mappings under that mm_struct, and switch to it
2. pagetable-mirroring-based:
      like /dev/kvm, an API to create a new pagetable, mirror parts of
      the mm_struct's pagetables over into it with modified permissions
      (like KVM_SET_USER_MEMORY_REGION),
      and run code under that context.
      page fault handling would first handle the fault against mm->pgd
      as normal, then mirror the PTE over into the secondary pagetables.
      invalidation could be handled with MMU notifiers.

> Another use-case is CRIU (Checkpoint/Restore in User-space). Several
> process properties can be received only from the process itself. Right
> now, we use a parasite code that is injected into the process. We do
> this with ptrace but it is slow, unsafe, and tricky.

But this API will only let you run code under the *mm* of the target
process, not fully in the context of a target *task*, right? So you
still won't be able to use this for accessing anything other than
memory? That doesn't seem very generically useful to me.

Also, I don't doubt that anything involving ptrace is kinda tricky,
but it would be nice to have some more detail on what exactly makes
this slow, unsafe and tricky. Are there API additions for ptrace that
would make this work better? I imagine you're thinking of things like
an API for injecting a syscall into the target process without having
to first somehow find an existing SYSCALL instruction in the target
process?

> process_vm_exec can
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

Alternatively you could add splice support to /proc/$pid/mem or add a
syscall similar to process_vm_readv() that splices into a pipe, right?
