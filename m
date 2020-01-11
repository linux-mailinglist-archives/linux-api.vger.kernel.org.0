Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3292B137C2C
	for <lists+linux-api@lfdr.de>; Sat, 11 Jan 2020 08:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgAKHfO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Jan 2020 02:35:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAKHfO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 11 Jan 2020 02:35:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so4294084wmj.5;
        Fri, 10 Jan 2020 23:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=kHjNGv68InysubTxzi0IgNvAOQ/D4GJa7tcO8O72Rsc=;
        b=W4f8TfdayRKdwzqTeKb/Ad/+l/nyzuUR6lSoNT9IPepDI8kjB8HFiuV4qzA/YyIYtt
         qMdLhmhTJJbWWcdbj3PbAo45YK0dvg2NBCX/Za0O9WPrqDyBZPc5rjucQFVvHXp1uz1D
         uBuKpFhZhG+1sJCSQ+YJgRiXBwnYIZYHTBOg6jTDOhF1GlVc0Re2RCGGdr3c8nyfMRFY
         EBpOOijqVELSlOh558GO0OmGLsdI7m9jnhb8Sw3dSouYKQ1Iduf4Agx+re3TAgSYiAj3
         S1VLZ+BHrKO+44WmGjOtNVw9Ny2T+FmWVpdeAvX4rE0yxmwS3KcVUsrXlOAK/8pgaBgl
         +z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=kHjNGv68InysubTxzi0IgNvAOQ/D4GJa7tcO8O72Rsc=;
        b=jR7sui4s9naanuVRnkveocM5hz5nBEofvXB7RU9nbLWetO2ONXiXYr+hENbUF4hH9W
         /YHkT5zEE8X3nZssDAB3RPpCNsq+d9hL9ZbnrTw6tjZIhfFfHZ5k69pKWjTgm0P8Z08v
         rXNKZ2DUQUv0gaEavV/Mx2SiihaiNFe44877EM8R7JOmXyx98X3x0yX2m4h2SXeY1HrQ
         /qeIaj7AF6KsAWUPJ4yPpTCcgeSJSyG02GrytavzoCcMgeLEiEFIxIVi9hgZpgn8rC7D
         OZcffnWb0nkCojIN+9XLPXfOVYpaXjDwJGykD+SKO2zA6dPoPHJBz16XtDrgJ95nn+wK
         ckUw==
X-Gm-Message-State: APjAAAUoxERw76/iyPaMoiQ03HzCv+B/JFvJc9OyVYewkEzsZknb/P2Z
        aXOpTAhVUeY3LF59urj5rQk=
X-Google-Smtp-Source: APXvYqwgnqsUoiatwpM/a9r9XJOE5uujM1SrGC8vyZeZOjqkCia8Y6utRlI5+8mk/2Eicf+GQ7jCGw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr8784319wmc.21.1578728111218;
        Fri, 10 Jan 2020 23:35:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:d1f3:c74b:f29c:a970])
        by smtp.gmail.com with ESMTPSA id d16sm5606323wrg.27.2020.01.10.23.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 23:35:10 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Date:   Sat, 11 Jan 2020 08:34:52 +0100
Message-Id: <20200111073452.25182-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110213433.94739-3-minchan@kernel.org> (raw)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 10 Jan 2020 13:34:31 -0800 Minchan Kim <minchan@kernel.org> wrote:

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

Shouldn't this be '#define __NR_process_madvise 438'?

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

Shouldn't the number for the 'process_madvise' be '438' instead of '437'?

> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 24d6c01328fb..4e6982c429d5 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -352,3 +352,4 @@
>  435	n64	clone3				__sys_clone3
>  436	n64	watch_devices			sys_watch_devices
>  437	n64	openat2				sys_openat2
> +437	n64	process_madvise			sys_process_madvise

438?  Same for below 5 changes.

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

Shouldn't this be '#define __NR_process_madvise 438'?


Thanks,
SeongJae Park

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
> +
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
> +	fdput(f);
> +	return ret;
> +}
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 
