Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939872E819
	for <lists+linux-api@lfdr.de>; Thu, 30 May 2019 00:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE2WYU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 18:24:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43186 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WYU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 18:24:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so699841pgv.10;
        Wed, 29 May 2019 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DroDB4KvwkuMY68upQQ5ymSM7D0H7IwBSjfRZ/Mbdsg=;
        b=o1LbggJ5FgAJuehayhB7RxJi/RdLZkxWpFTFTS5X6NQcNJIlet1ViTbCUL9XArgVvz
         0791J7ok/Y+kriMOz4ZniX/Q+8EfCEMbgTHOpl8uwL3GrnfQnLYR9CWCFf3X6Ski45Fk
         GGsR0OIg6BxW+KRIDg6K4HpsiSN998udK8LdZb9rHMOy09UiE72MkhgptksxVDr2UqS9
         R43dBfffx8nW7SnaQO02S278pk0cjiIxEIgiaTthmpev5qiIUaF7H2SNLBgMqJeZLY4F
         qS9jej0RcBgkPIxDcPzJNh7Q+W+mmrRj1HQzhmVGU3fFx53K3aVpw/BltBOpww2ziZNN
         lMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DroDB4KvwkuMY68upQQ5ymSM7D0H7IwBSjfRZ/Mbdsg=;
        b=nCzfRHK4habZy5cystUDmLWMvTGd+ZNZUxC6ZdLFhLlEhIMDuk+7+9blQr83EnMoVv
         n+Jgsef+7bGX3NuCNgWKSpKvltA53YaEGL3IOvL0RiO/2st99Fk0nV7+vTNNcYQuJzxx
         m3eK7mbwrYeRrDOzol22r62Q3LTQ1046r8WjFlCF7+5GA3tJxy8Eg9r1n9e37tyG1fT1
         Th32CjXuiFTiLSeSf0O4lX2KH/2Rvyh+8kCvYYXA0JwzGF1cIvrh2e2hZ4/2p8itI3Vk
         Pxm4wgVEkIcIX42rABiAwZ+Km7LKHJly2YnCmDXvt4TGXplE3ve7hhaGvTGmy5nyauX3
         cofg==
X-Gm-Message-State: APjAAAXBT3UKJxt42d030AFNd6Oj0gwGVp6lPt/TvE0Z2t8zv50b3Acf
        ii/csGPdn08FW3aOqrplZg0=
X-Google-Smtp-Source: APXvYqy0h7IlqtoGu+PbHJq+q0k6AXgoGTKt+9llmZNuK9ip8YJK8EM7J7fI1OVto5feteO6PeE9Jw==
X-Received: by 2002:a65:430a:: with SMTP id j10mr353927pgq.133.1559168658888;
        Wed, 29 May 2019 15:24:18 -0700 (PDT)
Received: from gmail.com ([2a00:79e1:abc:1e04:de9a:68c:c1e8:7e8f])
        by smtp.gmail.com with ESMTPSA id u14sm716647pfc.31.2019.05.29.15.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:24:18 -0700 (PDT)
Date:   Wed, 29 May 2019 15:24:15 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>, linux-api@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fork: add clone3
Message-ID: <20190529222414.GA6492@gmail.com>
References: <20190529152237.10719-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190529152237.10719-1-christian@brauner.io>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 29, 2019 at 05:22:36PM +0200, Christian Brauner wrote:
> This adds the clone3 system call.
> 
> As mentioned several times already (cf. [7], [8]) here's the promised
> patchset for clone3().
> 
> We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
> free flag from clone().
> 
> Independent of the CLONE_PIDFD patchset a time namespace has been discussed
> at Linux Plumber Conference last year and has been sent out and reviewed
> (cf. [5]). It is expected that it will go upstream in the not too distant
> future. However, it relies on the addition of the CLONE_NEWTIME flag to
> clone(). The only other good candidate - CLONE_DETACHED - is currently not
> recyclable as we have identified at least two large or widely used
> codebases that currently pass this flag (cf. [2], [3], and [4]). Given that
> CLONE_PIDFD grabbed the last clone() flag the time namespace is effectively
> blocked. clone3() has the advantage that it will unblock this patchset
> again.

Hi Christian,

Thank you for thinking about time namespaces. I looked at this patch
quickly and I would suggest to move a termination signal out of flags. I
think we can add a separate field (exit_signal) into clone_args. Does it
make sense? For me, exit_signal in flags always looked weird...

I will look at this patch more detailed later this week. Thanks.

> 
> The idea is to keep clone3() very simple and close to the original clone(),
> specifically, to keep on supporting old clone()-based workloads.
> We know there have been various creative proposals how a new process
> creation syscall or even api is supposed to look like. Some people even
> going so far as to argue that the traditional fork()+exec() split should be
> abandoned in favor of an in-kernel version of spawn(). Independent of
> whether or not we personally think spawn() is a good idea this patchset has
> and does not want to have anything to do with this.
> One stance we take is that there's no real good alternative to
> clone()+exec() and we need and want to support this model going forward;
> independent of spawn().
> The following requirements guided clone3():
> - bump the number of available flags
> - move arguments that are currently passed as separate arguments
>   in clone() into a dedicated struct clone_args
>   - choose a struct layout that is easy to handle on 32 and on 64 bit
>   - choose a struct layout that is extensible
>   - give new flags that currently need to abuse another flag's dedicated
>     return argument in clone() their own dedicated return argument
>     (e.g. CLONE_PIDFD)
>   - use a separate kernel internal struct kernel_clone_args that is
>     properly typed according to current kernel conventions in fork.c and is
>     different from  the uapi struct clone_args
> - port _do_fork() to use kernel_clone_args so that all process creation
>   syscalls such as fork(), vfork(), clone(), and clone3() behave identical
>   (Arnd suggested, that we can probably also port do_fork() itself in a
>    separate patchset.)
> - ease of transition for userspace from clone() to clone3()
>   This very much means that we do *not* remove functionality that userspace
>   currently relies on as the latter is a good way of creating a syscall
>   that won't be adopted.
> - do not try to be clever or complex: keep clone3() as dumb as possible
> 
> In accordance with Linus suggestions, clone3() has the following signature:
> 
> /* uapi */
> struct clone_args {
>         __aligned_u64 flags;
>         __aligned_u64 pidfd;
>         __aligned_u64 parent_tidptr;
>         __aligned_u64 child_tidptr;
>         __aligned_u64 stack;
>         __aligned_u64 stack_size;
>         __aligned_u64 tls;
> };
> 
> /* kernel internal */
> struct kernel_clone_args {
>         u64 flags;
>         int __user *pidfd;
>         int __user *parent_tidptr;
>         int __user *child_tidptr;
>         unsigned long stack;
>         unsigned long stack_size;
>         unsigned long tls;
> };
> 
> long sys_clone3(struct clone_args __user *uargs, size_t size)
> 
> clone3() cleanly supports all of the supported flags from clone() and thus
> all legacy workloads.
> The advantage of sticking close to the old clone() is the low cost for
> userspace to switch to this new api. Quite a lot of userspace apis (e.g.
> pthreads) are based on the clone() syscall. With the new clone3() syscall
> supporting all of the old workloads and opening up the ability to add new
> features should make switching to it for userspace more appealing. In
> essence, glibc can just write a simple wrapper to switch from clone() to
> clone3().
> 
> There has been some interest in this patchset already. We have received a
> patch from the CRIU corner for clone3() that would set the PID/TID of a
> restored process without /proc/sys/kernel/ns_last_pid to eliminate a race.
> 
> /* References */
> [1]: b3e5838252665ee4cfa76b82bdf1198dca81e5be
> [2]: https://dxr.mozilla.org/mozilla-central/source/security/sandbox/linux/SandboxFilter.cpp#343
> [3]: https://git.musl-libc.org/cgit/musl/tree/src/thread/pthread_create.c#n233
> [4]: https://sources.debian.org/src/blcr/0.8.5-2.3/cr_module/cr_dump_self.c/?hl=740#L740
> [5]: https://lore.kernel.org/lkml/20190425161416.26600-1-dima@arista.com/
> [6]: https://lore.kernel.org/lkml/20190425161416.26600-2-dima@arista.com/
> [7]: https://lore.kernel.org/lkml/CAHrFyr5HxpGXA2YrKza-oB-GGwJCqwPfyhD-Y5wbktWZdt0sGQ@mail.gmail.com/
> [8]: https://lore.kernel.org/lkml/20190524102756.qjsjxukuq2f4t6bo@brauner.io/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Pavel Emelyanov <xemul@virtuozzo.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Adrian Reber <adrian@lisas.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: linux-api@vger.kernel.org
> --
> v1:
> - Linus Torvalds <torvalds@linux-foundation.org>:
>   - redesign based on Linus proposal
>   - switch from arg-based to revision-based naming scheme: s/clone6/clone3/
> - Arnd Bergmann <arnd@arndb.de>:
>   - use a single copy_from_user() instead of multiple get_user() calls
>     since the latter have a constant overhead on some architectures
>   - a range of other tweaks and suggestions
> ---
>  arch/x86/ia32/sys_ia32.c   |  11 ++-
>  include/linux/sched/task.h |  13 ++-
>  include/linux/syscalls.h   |   6 ++
>  include/uapi/linux/sched.h |  16 ++++
>  kernel/fork.c              | 176 ++++++++++++++++++++++++++++---------
>  5 files changed, 177 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
> index a43212036257..1fd5c4594a8e 100644
> --- a/arch/x86/ia32/sys_ia32.c
> +++ b/arch/x86/ia32/sys_ia32.c
> @@ -237,6 +237,13 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
>  		       unsigned long, newsp, int __user *, parent_tidptr,
>  		       unsigned long, tls_val, int __user *, child_tidptr)
>  {
> -	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr,
> -			tls_val);
> +	struct kernel_clone_args args = {
> +		.flags = clone_flags,
> +		.stack = newsp,
> +		.parent_tidptr = parent_tidptr,
> +		.tls = tls_val,
> +		.child_tidptr = child_tidptr,
> +	};
> +
> +	return _do_fork(&args);
>  }
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index f1227f2c38a4..818696626a0d 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -8,11 +8,22 @@
>   */
>  
>  #include <linux/sched.h>
> +#include <linux/compiler_types.h>
>  
>  struct task_struct;
>  struct rusage;
>  union thread_union;
>  
> +struct kernel_clone_args {
> +	u64 flags;
> +	int __user *pidfd;
> +	int __user *parent_tidptr;
> +	int __user *child_tidptr;
> +	unsigned long stack;
> +	unsigned long stack_size;
> +	unsigned long tls;
> +};
> +
>  /*
>   * This serializes "schedule()" and also protects
>   * the run-queue from deletions/modifications (but
> @@ -73,7 +84,7 @@ extern void do_group_exit(int);
>  extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
> -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> +extern long _do_fork(struct kernel_clone_args *kargs);
>  extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
>  struct task_struct *fork_idle(int);
>  struct mm_struct *copy_init_mm(void);
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e2870fe1be5b..254db24af0cd 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -70,6 +70,7 @@ struct sigaltstack;
>  struct rseq;
>  union bpf_attr;
>  struct io_uring_params;
> +struct clone_args;
>  
>  #include <linux/types.h>
>  #include <linux/aio_abi.h>
> @@ -852,6 +853,11 @@ asmlinkage long sys_clone(unsigned long, unsigned long, int __user *,
>  	       int __user *, unsigned long);
>  #endif
>  #endif
> +
> +#ifdef __ARCH_WANT_SYS_CLONE
> +asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
> +#endif
> +
>  asmlinkage long sys_execve(const char __user *filename,
>  		const char __user *const __user *argv,
>  		const char __user *const __user *envp);
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index ed4ee170bee2..d426ef382a6e 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -2,6 +2,8 @@
>  #ifndef _UAPI_LINUX_SCHED_H
>  #define _UAPI_LINUX_SCHED_H
>  
> +#include <linux/types.h>
> +
>  /*
>   * cloning flags:
>   */
> @@ -30,6 +32,20 @@
>  #define CLONE_NEWPID		0x20000000	/* New pid namespace */
>  #define CLONE_NEWNET		0x40000000	/* New network namespace */
>  #define CLONE_IO		0x80000000	/* Clone io context */
> +#define CLONE_MAX ~0U
> +
> +/*
> + * Arguments for the clone3 syscall
> + */
> +struct clone_args {
> +	__aligned_u64 flags;
> +	__aligned_u64 pidfd;
> +	__aligned_u64 parent_tidptr;
> +	__aligned_u64 child_tidptr;
> +	__aligned_u64 stack;
> +	__aligned_u64 stack_size;
> +	__aligned_u64 tls;
> +};
>  
>  /*
>   * Scheduling policies
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b4cba953040a..6bc3e3d17150 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1760,19 +1760,19 @@ static __always_inline void delayed_free_task(struct task_struct *tsk)
>   * flags). The actual kick-off is left to the caller.
>   */
>  static __latent_entropy struct task_struct *copy_process(
> -					unsigned long clone_flags,
> -					unsigned long stack_start,
> -					unsigned long stack_size,
> -					int __user *parent_tidptr,
> -					int __user *child_tidptr,
>  					struct pid *pid,
>  					int trace,
> -					unsigned long tls,
> -					int node)
> +					int node,
> +					struct kernel_clone_args *args)
>  {
>  	int pidfd = -1, retval;
>  	struct task_struct *p;
>  	struct multiprocess_signals delayed;
> +	u64 clone_flags = args->flags;
> +	int __user *child_tidptr = args->child_tidptr;
> +	unsigned long tls = args->tls;
> +	unsigned long stack_start = args->stack;
> +	unsigned long stack_size = args->stack_size;
>  
>  	/*
>  	 * Don't allow sharing the root directory with processes in a different
> @@ -1821,27 +1821,12 @@ static __latent_entropy struct task_struct *copy_process(
>  	}
>  
>  	if (clone_flags & CLONE_PIDFD) {
> -		int reserved;
> -
>  		/*
> -		 * - CLONE_PARENT_SETTID is useless for pidfds and also
> -		 *   parent_tidptr is used to return pidfds.
>  		 * - CLONE_DETACHED is blocked so that we can potentially
>  		 *   reuse it later for CLONE_PIDFD.
>  		 * - CLONE_THREAD is blocked until someone really needs it.
>  		 */
> -		if (clone_flags &
> -		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
> -			return ERR_PTR(-EINVAL);
> -
> -		/*
> -		 * Verify that parent_tidptr is sane so we can potentially
> -		 * reuse it later.
> -		 */
> -		if (get_user(reserved, parent_tidptr))
> -			return ERR_PTR(-EFAULT);
> -
> -		if (reserved != 0)
> +		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
>  			return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -2062,7 +2047,7 @@ static __latent_entropy struct task_struct *copy_process(
>  			goto bad_fork_free_pid;
>  
>  		pidfd = retval;
> -		retval = put_user(pidfd, parent_tidptr);
> +		retval = put_user(pidfd, args->pidfd);
>  		if (retval)
>  			goto bad_fork_put_pidfd;
>  	}
> @@ -2313,8 +2298,11 @@ static inline void init_idle_pids(struct task_struct *idle)
>  struct task_struct *fork_idle(int cpu)
>  {
>  	struct task_struct *task;
> -	task = copy_process(CLONE_VM, 0, 0, NULL, NULL, &init_struct_pid, 0, 0,
> -			    cpu_to_node(cpu));
> +	struct kernel_clone_args args = {
> +		.flags = CLONE_VM,
> +	};
> +
> +	task = copy_process(&init_struct_pid, 0, cpu_to_node(cpu), &args);
>  	if (!IS_ERR(task)) {
>  		init_idle_pids(task);
>  		init_idle(task, cpu);
> @@ -2334,18 +2322,15 @@ struct mm_struct *copy_init_mm(void)
>   * It copies the process, and if successful kick-starts
>   * it and waits for it to finish using the VM if required.
>   */
> -long _do_fork(unsigned long clone_flags,
> -	      unsigned long stack_start,
> -	      unsigned long stack_size,
> -	      int __user *parent_tidptr,
> -	      int __user *child_tidptr,
> -	      unsigned long tls)
> +long _do_fork(struct kernel_clone_args *args)
>  {
> +	u64 clone_flags = args->flags;
>  	struct completion vfork;
>  	struct pid *pid;
>  	struct task_struct *p;
>  	int trace = 0;
>  	long nr;
> +	int __user *parent_tidptr = args->parent_tidptr;
>  
>  	/*
>  	 * Determine whether and which event to report to ptracer.  When
> @@ -2365,8 +2350,7 @@ long _do_fork(unsigned long clone_flags,
>  			trace = 0;
>  	}
>  
> -	p = copy_process(clone_flags, stack_start, stack_size, parent_tidptr,
> -			 child_tidptr, NULL, trace, tls, NUMA_NO_NODE);
> +	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
>  	add_latent_entropy();
>  
>  	if (IS_ERR(p))
> @@ -2414,8 +2398,15 @@ long do_fork(unsigned long clone_flags,
>  	      int __user *parent_tidptr,
>  	      int __user *child_tidptr)
>  {
> -	return _do_fork(clone_flags, stack_start, stack_size,
> -			parent_tidptr, child_tidptr, 0);
> +	struct kernel_clone_args args = {
> +		.flags = clone_flags,
> +		.stack = stack_start,
> +		.stack_size = stack_size,
> +		.parent_tidptr = parent_tidptr,
> +		.child_tidptr = child_tidptr,
> +	};
> +
> +	return _do_fork(&args);
>  }
>  #endif
>  
> @@ -2424,15 +2415,24 @@ long do_fork(unsigned long clone_flags,
>   */
>  pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
>  {
> -	return _do_fork(flags|CLONE_VM|CLONE_UNTRACED, (unsigned long)fn,
> -		(unsigned long)arg, NULL, NULL, 0);
> +	struct kernel_clone_args args = {
> +		.flags = flags | CLONE_VM | CLONE_UNTRACED,
> +		.stack = (unsigned long)fn,
> +		.stack_size = (unsigned long)arg,
> +	};
> +
> +	return _do_fork(&args);
>  }
>  
>  #ifdef __ARCH_WANT_SYS_FORK
>  SYSCALL_DEFINE0(fork)
>  {
>  #ifdef CONFIG_MMU
> -	return _do_fork(SIGCHLD, 0, 0, NULL, NULL, 0);
> +	struct kernel_clone_args args = {
> +		.flags = SIGCHLD,
> +	};
> +
> +	return _do_fork(&args);
>  #else
>  	/* can not support in nommu mode */
>  	return -EINVAL;
> @@ -2443,8 +2443,11 @@ SYSCALL_DEFINE0(fork)
>  #ifdef __ARCH_WANT_SYS_VFORK
>  SYSCALL_DEFINE0(vfork)
>  {
> -	return _do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0,
> -			0, NULL, NULL, 0);
> +	struct kernel_clone_args args = {
> +		.flags = CLONE_VFORK | CLONE_VM | SIGCHLD,
> +	};
> +
> +	return _do_fork(&args);
>  }
>  #endif
>  
> @@ -2472,7 +2475,96 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  		 unsigned long, tls)
>  #endif
>  {
> -	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
> +	struct kernel_clone_args args = {
> +		.flags = clone_flags,
> +		.stack = newsp,
> +		.pidfd = parent_tidptr,
> +		.parent_tidptr = parent_tidptr,
> +		.tls = tls,
> +		.child_tidptr = child_tidptr,
> +	};
> +
> +	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
> +	if ((clone_flags & CLONE_PIDFD) && (clone_flags & CLONE_PARENT_SETTID))
> +		return -EINVAL;
> +
> +	return _do_fork(&args);
> +}
> +
> +static bool clone3_flags_valid(u64 flags)
> +{
> +	if (flags & CLONE_DETACHED)
> +		return false;
> +
> +	if (flags & ~CLONE_MAX)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> +				     struct clone_args __user *uargs,
> +				     size_t size)
> +{
> +	struct clone_args args;
> +
> +	if (unlikely(size > PAGE_SIZE))
> +		return -E2BIG;
> +
> +	if (unlikely(size < sizeof(struct clone_args)))
> +		return -EINVAL;
> +
> +	if (unlikely(!access_ok(uargs, size)))
> +		return -EFAULT;
> +
> +	if (size > sizeof(struct clone_args)) {
> +		unsigned char __user *addr;
> +		unsigned char __user *end;
> +		unsigned char val;
> +
> +		addr = (void __user *)uargs + sizeof(struct clone_args);
> +		end = (void __user *)uargs + size;
> +
> +		for (; addr < end; addr++) {
> +			if (get_user(val, addr))
> +				return -EFAULT;
> +			if (val)
> +				return -E2BIG;
> +		}
> +
> +		size = sizeof(struct clone_args);
> +	}
> +
> +	if (copy_from_user(&args, uargs, size))
> +		return -EFAULT;
> +
> +	if (!clone3_flags_valid(args.flags))
> +		return -EINVAL;
> +
> +	memset(kargs, 0, sizeof(*kargs));
> +
> +	kargs->flags = args.flags;
> +	kargs->child_tidptr = u64_to_user_ptr(args.child_tidptr);
> +	kargs->parent_tidptr = u64_to_user_ptr(args.parent_tidptr);
> +	kargs->pidfd = u64_to_user_ptr(args.pidfd);
> +	kargs->stack = args.stack;
> +	kargs->stack_size = args.stack_size;
> +	kargs->tls = args.tls;
> +
> +	return 0;
> +}
> +
> +SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
> +{
> +	int err;
> +
> +	struct kernel_clone_args kargs;
> +
> +	err = copy_clone_args_from_user(&kargs, uargs, size);
> +	if (err)
> +		return err;
> +
> +	return _do_fork(&kargs);
>  }
>  #endif
>  
> -- 
> 2.21.0
> 
