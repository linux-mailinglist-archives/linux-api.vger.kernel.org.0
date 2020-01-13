Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD20138D28
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 09:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgAMIrf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 03:47:35 -0500
Received: from relay.sw.ru ([185.231.240.75]:37296 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgAMIre (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 13 Jan 2020 03:47:34 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iqvNQ-0000B7-6e; Mon, 13 Jan 2020 11:47:12 +0300
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
Date:   Mon, 13 Jan 2020 11:47:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110213433.94739-3-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11.01.2020 00:34, Minchan Kim wrote:
> There are usecases that System Management Software(SMS) want to give
> a memory hint to other processes because it's not known to the
> application. In the case of Android, ActivityManagerService daemon
> manges app's life cycle and that daemon must be able to initiate
> reclaim on its own without any app involvement.
> 
> To solve the issue, this patch introduces new syscall process_madvise(2).
> It uses pidfd of an external processs to give the hint.
> 
>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> 			unsigned long flag);
> 
> Since it could affect other process's address range, only privileged
> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> gives it the right to ptrace the process could use it successfully.
> The flag argument is reserved for future use if we need to extend the
> API.
> 
> Supporting all hints madvise has/will supported/support to process_madvise
> is rather risky. Because we are not sure all hints make sense from external
> process and implementation for the hint may rely on the caller being
> in the current context so it could be error-prone. Thus, I just limited
> hints as MADV_[COLD|PAGEOUT] in this patch.
> 
> If someone want to add other hints, we could hear hear the usecase and
> review it for each hint. It's more safe for maintainace rather than
> introducing a buggy syscall but hard to fix it later.
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
>  mm/madvise.c                                | 64 +++++++++++++++++++++
>  21 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index e56950f23b49..776c61803315 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -477,3 +477,4 @@
>  # 545 reserved for clone3
>  546	common	watch_devices			sys_watch_devices
>  547	common	openat2				sys_openat2
> +548	common	process_madvise			sys_process_madvise
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 7fb2f4d59210..a43381542276 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -451,3 +451,4 @@
>  435	common	clone3				sys_clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +438	common	process_madvise			sys_process_madvise
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 8aa00ccb0b96..b722e47377a5 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		438
> +#define __NR_compat_syscalls		439
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 31f0ce25719e..5c82557d408f 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -883,6 +883,8 @@ __SYSCALL(__NR_clone3, sys_clone3)
>  __SYSCALL(__NR_watch_devices, sys_watch_devices)
>  #define __NR_openat2 437
>  __SYSCALL(__NR_openat2, sys_openat2)
> +#define __NR_openat2 438
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
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +438	common	process_madvise			sys_process_madvise
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 868c1ef89d35..5b6034b6650f 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,4 @@
>  # 435 reserved for clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +438	common	process_madvise			sys_process_madvise
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 544b4cef18b3..4bef584af09c 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -443,3 +443,4 @@
>  435	common	clone3				sys_clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +438	common	process_madvise			sys_process_madvise
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 05e8aee5dae7..94fbd0fcccce 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -376,3 +376,4 @@
>  435	n32	clone3				__sys_clone3
>  436	n32	watch_devices			sys_watch_devices
>  437	n32	openat2				sys_openat2
> +437	n32	process_madivse			sys_process_madvise

438. And several places below has the same mistake.

> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 24d6c01328fb..4e6982c429d5 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -352,3 +352,4 @@
>  435	n64	clone3				__sys_clone3
>  436	n64	watch_devices			sys_watch_devices
>  437	n64	openat2				sys_openat2
> +437	n64	process_madvise			sys_process_madvise
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 4b5f77a4e1a2..3aa990caf9dc 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -435,3 +435,4 @@
>  435	common	clone3				sys_clone3_wrapper
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +437	common	process_madvise			sys_process_madvise
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 9716dc85a517..30e727a23f33 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -519,3 +519,4 @@
>  435	nospu	clone3				ppc_clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +437	common	process_madvise			sys_process_madvise
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 7da330f8b03e..75722e5ff496 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -440,3 +440,4 @@
>  435  common	clone3			sys_clone3			sys_clone3
>  436  common	watch_devices		sys_watch_devices		sys_watch_devices
>  437  common	openat2			sys_openat2			sys_openat2
> +437  common	process_madvise		sys_process_madvise		sys_process_madvise
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index bb7e68e25337..7d7bc7befad3 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -440,3 +440,4 @@
>  # 435 reserved for clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +437	common	process_madvise			sys_process_madvise
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 646a1fad7218..581d331ff62f 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -483,3 +483,4 @@
>  # 435 reserved for clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2			sys_openat2
> +437	common	process_madvise		sys_process_madvise
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 57c53acee290..76a2c266fe7e 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -442,3 +442,4 @@
>  435	i386	clone3			sys_clone3			__ia32_sys_clone3
>  436	i386	watch_devices		sys_watch_devices		__ia32_sys_watch_devices
>  437	i386	openat2			sys_openat2			__ia32_sys_openat2
> +438	i386	process_madvise		sys_process_madvise		__ia32_sys_process_madvise
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 1dd8d21f6500..b697cd8620cb 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -359,6 +359,7 @@
>  435	common	clone3			__x64_sys_clone3/ptregs
>  436	common	watch_devices		__x64_sys_watch_devices
>  437	common	openat2			__x64_sys_openat2
> +438	common	process_madvise		__x64_sys_process_madvise
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 0f48ab7bd75b..2e9813ecfd7d 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -408,3 +408,4 @@
>  435	common	clone3				sys_clone3
>  436	common	watch_devices			sys_watch_devices
>  437	common	openat2				sys_openat2
> +438	common	process_madvise			sys_process_madvise
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 433c8c85636e..1b58a11ff49f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -877,6 +877,8 @@ asmlinkage long sys_munlockall(void);
>  asmlinkage long sys_mincore(unsigned long start, size_t len,
>  				unsigned char __user * vec);
>  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> +asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> +			size_t len, int behavior, unsigned long flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
>  			unsigned long prot, unsigned long pgoff,
>  			unsigned long flags);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 33f3856a9c3c..4bcd8d366f38 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -856,8 +856,11 @@ __SYSCALL(__NR_watch_devices, sys_watch_devices)
>  #define __NR_openat2 437
>  __SYSCALL(__NR_openat2, sys_openat2)
>  
> +#define __NR_openat2 438
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
> index 0c901de531e4..e15dfb4df7bf 100644
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
> @@ -993,6 +994,18 @@ madvise_behavior_valid(int behavior)
>  	}
>  }
>  
> +static bool
> +process_madvise_behavior_valid(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_COLD:
> +	case MADV_PAGEOUT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * madvise_common - request behavior hint to address range of the target process
>   *
> @@ -1169,3 +1182,54 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  {
>  	return madvise_common(current, current->mm, start, len_in, behavior);
>  }
> +
> +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> +		size_t, len_in, int, behavior, unsigned long, flags)

I don't like the interface. The fact we have pidfd does not mean,
we have to use it for new syscalls always. A user may want to set
madvise for specific pid from console and pass pid as argument.
pidfd would be an overkill in this case.
We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
allow this?

I suggent to extend first argument to work with both pid and pidfd.
Look at what we have for waitid(idtype, id_t id, ...) for example:

       idtype == P_PID
              Wait for the child whose process ID matches id.

       idtype == P_PIDFD (since Linux 5.4)
              Wait for the child referred to by the PID file descriptor specified in id.  (See pidfd_open(2) for  further  information  on
              PID file descriptors.)

We may use @flags argument for this.

> +{
> +	int ret;
> +	struct fd f;
> +	struct pid *pid;
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	if (!process_madvise_behavior_valid(behavior))
> +		return -EINVAL;
> +
> +	f = fdget(pidfd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	pid = pidfd_pid(f.file);
> +	if (IS_ERR(pid)) {
> +		ret = PTR_ERR(pid);
> +		goto err;
> +	}

From here:

> +	rcu_read_lock();
> +	task = pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		rcu_read_unlock();
> +		ret = -ESRCH;
> +		goto err;
> +	}
> +
> +	get_task_struct(task);
> +	rcu_read_unlock();

to here your code is a copy of existing get_pid_task(). We should the primitive instead.

> +
> +	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +	if (IS_ERR_OR_NULL(mm)) {
> +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +		goto release_task;
> +	}
> +
> +	ret = madvise_common(task, mm, start, len_in, behavior);
> +	mmput(mm);
> +release_task:
> +	put_task_struct(task);
> +err:

Maybe s/err:/fdput:/ for uniformity with the above "release_task:"?

> +	fdput(f);
> +	return ret;
> +}
> 

