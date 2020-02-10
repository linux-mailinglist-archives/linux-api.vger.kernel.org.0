Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E11581B0
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgBJRuf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 12:50:35 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40591 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJRuf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 12:50:35 -0500
Received: by mail-ua1-f67.google.com with SMTP id g13so2792375uab.7
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAXsZl2SzAzSJYO5kScTkxz3GtohhKBgystGXx6Vpys=;
        b=v+nDl8wZDB9qVX7JGKl9E+436JV3yCKjZ+UA+EKy0C8u+V55pKqXqx7LuFG7ztC8GE
         PrRLmwLO/OZyG5gw8SL7TWDs4DGELfWj++drN3L5oPEoq6sRaAcbpM+Gx2MEozPU1rZz
         pz57umBI32C6sZzmreiaoKt3Js/qyc5LWCLlkRqjCa85wyMh7JZpuKnaSvxT7A/WG4Tk
         DI7FoxHtGLPpau6PxbLuGCL1/iHX67bErKvXUsyIq0mKL8HTjuprBrMrGleghlqzXoMk
         dfbr3FOTTY/lTtm+PhMqczxt9Ltjri44dxYdlkm12dcSE8x5YIQW/C/z+Zw3qc+fwsRG
         4Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAXsZl2SzAzSJYO5kScTkxz3GtohhKBgystGXx6Vpys=;
        b=aJa0lQuiQ7bDW32hJIk/pTt2+G6EOnFy66vpMq7ZoEApsvd/tpY/jkO1wkElATaVuY
         GhxCW3bxa9y95fMpaYq6JDAFbHTIEBh4uLYZiN5Ir2astU+HEnhIxGdKbgVHAxKtS43P
         3elzFyIHUcXt3NgzWaz5ZZ/CThTPTdQOjP2PkN/G1uhdYWn8FTQnc5xxFM1bSxZDn2xx
         68DbCBXT25+0y1/6vp0LQyRlzuP2D5rux6JK4BOxHhzlXgaGmAHkTEx1pEUnFiFGbdjd
         qBkmdH2pnPRESyk9uUo7uZm3d6/UaYKDgYDY+Toa2fINkVnN/oZ1WOcqXaXte2xUeQIt
         4o0g==
X-Gm-Message-State: APjAAAVUhOd3Osog13VjmDiudWaiWwXrn7WC/H6Ob/iJ2+m3ki/XMnaK
        IjccbaHLw8+rXnE5HmKKQwBU+8mpyWtIjXrgy+YxaA==
X-Google-Smtp-Source: APXvYqwPrGwn8XacGCahljIXA+sEzV3DSBjYN/vKOnMVQZwUQDHZrRSsG6bRQ34J6pH3nqu+UmZW7ntoAHYcRqwhuC0=
X-Received: by 2002:ab0:74ce:: with SMTP id f14mr1440687uaq.118.1581357032717;
 Mon, 10 Feb 2020 09:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20200128001641.5086-1-minchan@kernel.org> <20200128001641.5086-3-minchan@kernel.org>
In-Reply-To: <20200128001641.5086-3-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 10 Feb 2020 09:50:20 -0800
Message-ID: <CAJuCfpFOBUYfxyQZZCvKjD0pyh_D-ZEpJP9kLD8xav+hVHZWYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 27, 2020 at 4:17 PM Minchan Kim <minchan@kernel.org> wrote:
>
> There is usecase that System Management Software(SMS) want to give
> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> in the case of Android, it is the ActivityManagerService.
>
> It's similar in spirit to madvise(MADV_WONTNEED), but the information
> required to make the reclaim decision is not known to the app. Instead,
> it is known to the centralized userspace daemon(ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without
> any app involvement.
>
> To solve the issue, this patch introduces a new syscall process_madvise(2).
> It uses pidfd of an external process to give the hint.
>
>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
>                         unsigned long flag);
>
> Since it could affect other process's address range, only privileged
> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> gives it the right to ptrace the process could use it successfully.
> The flag argument is reserved for future use if we need to extend the
> API.
>
> I think supporting all hints madvise has/will supported/support to
> process_madvise is rather risky. Because we are not sure all hints make
> sense from external process and implementation for the hint may rely on
> the caller being in the current context so it could be error-prone.
> Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
>
> If someone want to add other hints, we could hear hear the usecase and
> review it for each hint. It's safer for maintenance rather than
> introducing a buggy syscall but hard to fix it later.

I would definitely be interested in adding MADV_DONTNEED support for
process_madvise() to allow quick memory reclaim after a kill. The
scenario is that userspace daemon can kill a process and try to help
reclaim its memory. Having process_madvise(MADV_DONTNEED) support
helps in the following cases:
1. Process issuing process_madvise has a higher CPU bandwidth
allowance than the victim process, therefore can reclaim victim's
memory quicker.
2. In case the victim occupies large amounts of memory the process
issuing process_madvise can spawn multiple (possibly high priority)
threads each reclaiming portions of the victim's memory.
Such an extension will add a destructive kind of madvise into the set
supported by process_madvise and I want to make sure we can accomodate
for that in the future. Do you see any issues with supporting
MADV_DONTNEED in the future?

>
> Q.1 - Why does any external entity have better knowledge?
>
> Quote from Sandeep
> "For Android, every application (including the special SystemServer) are forked
> from Zygote. The reason of course is to share as many libraries and classes between
> the two as possible to benefit from the preloading during boot.
>
> After applications start, (almost) all of the APIs  end up calling into this
> SystemServer process over IPC (binder) and back to the application.
>
> In a fully running system, the SystemServer monitors every single process
> periodically to calculate their PSS / RSS and also decides which process is
> "important" to the user for interactivity.
>
> So, because of how these processes start _and_ the fact that the SystemServer
> is looping to monitor each process, it does tend to *know* which address
> range of the application is not used / useful.
>
> Besides, we can never rely on applications to clean things up themselves.
> We've had the "hey app1, the system is low on memory, please trim your
> memory usage down" notifications for a long time[1]. They rely on
> applications honoring the broadcasts and very few do.
>
> So, if we want to avoid the inevitable killing of the application and
> restarting it, some way to be able to tell the OS about unimportant memory in
> these applications will be useful.
>
> - ssp
>
> Q.2 - How to guarantee the race(i.e., object validation) between when giving a
> hint from an external process and get the hint from the target process?
>
> process_madvise operates on the target process's address space as it exists
> at the instant that process_madvise is called. If the space target process
> can run between the time the process_madvise process inspects the target
> process address space and the time that process_madvise is actually called,
> process_madvise may operate on memory regions that the calling process does
> not expect. It's the responsibility of the process calling process_madvise
> to close this race condition. For example, the calling process can suspend
> the target process with ptrace, SIGSTOP, or the freezer cgroup so that it
> doesn't have an opportunity to change its own address space before
> process_madvise is called. Another option is to operate on memory regions
> that the caller knows a priori will be unchanged in the target process.
> Yet another option is to accept the race for certain process_madvise calls
> after reasoning that mistargeting will do no harm. The suggested API itself
> does not provide synchronization. It also apply other APIs like move_pages,
> process_vm_write.
>
> The race isn't really a problem though. Why is it so wrong to require
> that callers do their own synchronization in some manner? Nobody objects
> to write(2) merely because it's possible for two processes to open the same
> file and clobber each other's writes --- instead, we tell people to use
> flock or something. Think about mmap. It never guarantees newly allocated
> address space is still valid when the user tries to access it because other
> threads could unmap the memory right before. That's where we need
> synchronization by using other API or design from userside. It shouldn't
> be part of API itself. If someone needs more fine-grained synchronization
> rather than process level, there were two ideas suggested - cookie[2] and
> anon-fd[3]. Both are applicable via using last reserved argument of the API
> but I don't think it's necessary right now since we have already ways to
> prevent the race so don't want to add additional complexity with more
> fine-grained optimization model.
>
> To make the API extend, it reserved an unsigned long as last argument
> so we could support it in future if someone really needs it.
>
> Q.3 - Why doesn't ptrace work?
>
> Injecting an madvise in the target process using ptrace would not work for us
> because such injected madvise would have to be executed by the target process,
> which means that process would have to be runnable and that creates the risk
> of the abovementioned race and hinting a wrong VMA. Furthermore, we want to
> act the hint in caller's context, not calle because calle is usually limited
> in cpuset/cgroups or even freezed state so they can't act by themselves
> quick enough, which causes more thrashing/kill. It doesn't work if the
> target process are ptraced(e.g., strace, debugger, minidump) because  a
> process can have at most one ptracer.
>
> [1] https://developer.android.com/topic/performance/memory"
> [2] process_getinfo for getting the cookie which is updated whenever
>     vma of process address layout are changed - Daniel Colascione
> - https://lore.kernel.org/lkml/20190520035254.57579-1-minchan@kernel.org/T/#m7694416fd179b2066a2c62b5b139b14e3894e224
> [3] anonymous fd which is used for the object(i.e., address range)
>     validation - Michal Hocko
> - https://lore.kernel.org/lkml/20200120112722.GY18451@dhcp22.suse.cz/
>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
>  arch/arm/tools/syscall.tbl                  |  1 +
>  arch/arm64/include/asm/unistd.h             |  2 +-
>  arch/arm64/include/asm/unistd32.h           |  2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
>  include/linux/syscalls.h                    |  2 +
>  include/uapi/asm-generic/unistd.h           |  5 +-
>  kernel/sys_ni.c                             |  1 +
>  mm/madvise.c                                | 66 +++++++++++++++++++++
>  21 files changed, 91 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index e56950f23b49..776c61803315 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -477,3 +477,4 @@
>  # 545 reserved for clone3
>  546    common  watch_devices                   sys_watch_devices
>  547    common  openat2                         sys_openat2
> +548    common  process_madvise                 sys_process_madvise
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 7fb2f4d59210..a43381542276 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -451,3 +451,4 @@
>  435    common  clone3                          sys_clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 8aa00ccb0b96..b722e47377a5 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls                (__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END            (__ARM_NR_COMPAT_BASE + 0x800)
>
> -#define __NR_compat_syscalls           438
> +#define __NR_compat_syscalls           439
>  #endif
>
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 31f0ce25719e..e3643d7fecc3 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -883,6 +883,8 @@ __SYSCALL(__NR_clone3, sys_clone3)
>  __SYSCALL(__NR_watch_devices, sys_watch_devices)
>  #define __NR_openat2 437
>  __SYSCALL(__NR_openat2, sys_openat2)
> +#define __NR_process_madvise 438
> +__SYSCALL(__NR_process_madvise, process_madvise)
>
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index b9aa59931905..c156abc9a298 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -358,3 +358,4 @@
>  # 435 reserved for clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 868c1ef89d35..5b6034b6650f 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,4 @@
>  # 435 reserved for clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 544b4cef18b3..4bef584af09c 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -443,3 +443,4 @@
>  435    common  clone3                          sys_clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 05e8aee5dae7..7061b2103438 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -376,3 +376,4 @@
>  435    n32     clone3                          __sys_clone3
>  436    n32     watch_devices                   sys_watch_devices
>  437    n32     openat2                         sys_openat2
> +438    n32     process_madivse                 sys_process_madvise
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 24d6c01328fb..84042d57fbfb 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -352,3 +352,4 @@
>  435    n64     clone3                          __sys_clone3
>  436    n64     watch_devices                   sys_watch_devices
>  437    n64     openat2                         sys_openat2
> +438    n64     process_madvise                 sys_process_madvise
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 4b5f77a4e1a2..5bfd359c7e6f 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -435,3 +435,4 @@
>  435    common  clone3                          sys_clone3_wrapper
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 9716dc85a517..ffa0e679aca0 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -519,3 +519,4 @@
>  435    nospu   clone3                          ppc_clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 7da330f8b03e..c301717216ca 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -440,3 +440,4 @@
>  435  common    clone3                  sys_clone3                      sys_clone3
>  436  common    watch_devices           sys_watch_devices               sys_watch_devices
>  437  common    openat2                 sys_openat2                     sys_openat2
> +438  common    process_madvise         sys_process_madvise             sys_process_madvise
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index bb7e68e25337..b8f15701f69f 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -440,3 +440,4 @@
>  # 435 reserved for clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 646a1fad7218..7ea95f37b222 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -483,3 +483,4 @@
>  # 435 reserved for clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                 sys_openat2
> +438    common  process_madvise         sys_process_madvise
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 57c53acee290..76a2c266fe7e 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -442,3 +442,4 @@
>  435    i386    clone3                  sys_clone3                      __ia32_sys_clone3
>  436    i386    watch_devices           sys_watch_devices               __ia32_sys_watch_devices
>  437    i386    openat2                 sys_openat2                     __ia32_sys_openat2
> +438    i386    process_madvise         sys_process_madvise             __ia32_sys_process_madvise
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 1dd8d21f6500..b697cd8620cb 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -359,6 +359,7 @@
>  435    common  clone3                  __x64_sys_clone3/ptregs
>  436    common  watch_devices           __x64_sys_watch_devices
>  437    common  openat2                 __x64_sys_openat2
> +438    common  process_madvise         __x64_sys_process_madvise
>
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 0f48ab7bd75b..2e9813ecfd7d 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -408,3 +408,4 @@
>  435    common  clone3                          sys_clone3
>  436    common  watch_devices                   sys_watch_devices
>  437    common  openat2                         sys_openat2
> +438    common  process_madvise                 sys_process_madvise
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 433c8c85636e..1b58a11ff49f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -877,6 +877,8 @@ asmlinkage long sys_munlockall(void);
>  asmlinkage long sys_mincore(unsigned long start, size_t len,
>                                 unsigned char __user * vec);
>  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> +asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> +                       size_t len, int behavior, unsigned long flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
>                         unsigned long prot, unsigned long pgoff,
>                         unsigned long flags);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 33f3856a9c3c..4a49fbaea013 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -856,8 +856,11 @@ __SYSCALL(__NR_watch_devices, sys_watch_devices)
>  #define __NR_openat2 437
>  __SYSCALL(__NR_openat2, sys_openat2)
>
> +#define __NR_process_madvise 438
> +__SYSCALL(__NR_process_madvise, sys_process_madvise)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 438
> +#define __NR_syscalls 439
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 0e9b275260f8..10ce5eac8b4b 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -281,6 +281,7 @@ COND_SYSCALL(mlockall);
>  COND_SYSCALL(munlockall);
>  COND_SYSCALL(mincore);
>  COND_SYSCALL(madvise);
> +COND_SYSCALL(process_madvise);
>  COND_SYSCALL(remap_file_pages);
>  COND_SYSCALL(mbind);
>  COND_SYSCALL_COMPAT(mbind);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0c901de531e4..00ffa7e92f79 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -17,6 +17,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fadvise.h>
>  #include <linux/sched.h>
> +#include <linux/sched/mm.h>
>  #include <linux/ksm.h>
>  #include <linux/fs.h>
>  #include <linux/file.h>
> @@ -315,6 +316,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>
>         if (fatal_signal_pending(task))
>                 return -EINTR;
> +       else if (current != task && fatal_signal_pending(current))
> +               return -EINTR;

I think this can be simplified as:

+       if (fatal_signal_pending(current))
+               return -EINTR;

current != task condition is not needed because if current == task
then you would return earlier after checking
fatal_signal_pending(task).


>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (pmd_trans_huge(*pmd)) {
> @@ -993,6 +996,18 @@ madvise_behavior_valid(int behavior)
>         }
>  }
>
> +static bool
> +process_madvise_behavior_valid(int behavior)
> +{
> +       switch (behavior) {
> +       case MADV_COLD:
> +       case MADV_PAGEOUT:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  /*
>   * madvise_common - request behavior hint to address range of the target process
>   *
> @@ -1151,6 +1166,11 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *             from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *  MADV_COLD - the application uses the memory less so the kernel can
> + *             deactivate the memory to evict them quickly when the memory
> + *             pressure happen.
> + *  MADV_PAGEOUT - the application uses the memroy very rarely so kernel can
> + *             page out the memory instantly.
>   *
>   * return values:
>   *  zero    - success
> @@ -1169,3 +1189,49 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  {
>         return madvise_common(current, current->mm, start, len_in, behavior);
>  }
> +
> +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> +               size_t, len_in, int, behavior, unsigned long, flags)
> +{
> +       int ret;
> +       struct fd f;
> +       struct pid *pid;
> +       struct task_struct *task;
> +       struct mm_struct *mm;
> +
> +       if (flags != 0)
> +               return -EINVAL;
> +
> +       if (!process_madvise_behavior_valid(behavior))
> +               return -EINVAL;
> +
> +       f = fdget(pidfd);
> +       if (!f.file)
> +               return -EBADF;
> +
> +       pid = pidfd_pid(f.file);
> +       if (IS_ERR(pid)) {
> +               ret = PTR_ERR(pid);
> +               goto fdput;
> +       }
> +
> +       task = get_pid_task(pid, PIDTYPE_PID);
> +       if (!task) {
> +               ret = -ESRCH;
> +               goto fdput;
> +       }
> +
> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +       if (IS_ERR_OR_NULL(mm)) {
> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +               goto release_task;
> +       }
> +
> +       ret = madvise_common(task, mm, start, len_in, behavior);
> +       mmput(mm);
> +release_task:
> +       put_task_struct(task);
> +fdput:
> +       fdput(f);
> +       return ret;
> +}
> --
> 2.25.0.341.g760bfbb309-goog
>
