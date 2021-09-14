Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09BE40A249
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 03:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhINBFS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 13 Sep 2021 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhINBFS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 21:05:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32FC061574;
        Mon, 13 Sep 2021 18:04:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:f4d2:afff:fe2b:18b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6F63E1F41636;
        Tue, 14 Sep 2021 02:03:59 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/6] futex2: Implement vectorized wait
Organization: Collabora
References: <20210913175249.81074-1-andrealmeid@collabora.com>
        <20210913175249.81074-3-andrealmeid@collabora.com>
Date:   Mon, 13 Sep 2021 21:03:56 -0400
In-Reply-To: <20210913175249.81074-3-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Mon, 13 Sep 2021 14:52:45 -0300")
Message-ID: <875yv4ge83.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Add support to wait on multiple futexes. This is the interface
> implemented by this syscall:
>
> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
> 	    unsigned int flags, struct timespec *timo)
>
> struct futex_waitv {
> 	__u64 val;
> 	__u64 uaddr;
> 	__u32 flags;
> 	__u32 __reserved;
> };
>
> Given an array of struct futex_waitv, wait on each uaddr. The thread
> wakes if a futex_wake() is performed at any uaddr. The syscall returns
> immediately if any waiter has *uaddr != val. *timo is an optional
> absolute timeout value for the operation. This syscall supports only
> 64bit sized timeout structs. The flags argument of the syscall should be
> used solely for specifying the timeout clock as realtime, if needed.
> Flags for shared futexes, sizes, etc. should be used on the individual
> flags of each waiter.
>
> __reserved is used for explicit padding and should be 0, but it might be
> used for future extensions. If the userspace uses 32-bit pointers, it
> should make sure to explicitly cast it when assigning to waitv::uaddr.
>
> Returns the array index of one of the awakened futexes. There’s no given
> information of how many were awakened, or any particular attribute of it
> (if it’s the first awakened, if it is of the smaller index...).
>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  MAINTAINERS                       |   3 +-
>  include/linux/syscalls.h          |   6 +
>  include/uapi/asm-generic/unistd.h |   5 +-
>  include/uapi/linux/futex.h        |  25 ++++
>  init/Kconfig                      |   7 ++
>  kernel/Makefile                   |   1 +
>  kernel/futex.c                    | 201 ++++++++++++++++++++++++++++++
>  kernel/futex.h                    |  15 +++
>  kernel/futex2.c                   | 117 +++++++++++++++++

Hi,

If you were to keep this implementation inside futex.c, your patchset
would be much simpler, patch 1 would immediately disappear.  Since we
are just taking about a multiple wait operation and the code is tiny, I
don't see why it couldn't go inside futex.c


>  kernel/sys_ni.c                   |   3 +
>  10 files changed, 381 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/futex2.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..7b756d96f09f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7718,6 +7718,7 @@ M:	Ingo Molnar <mingo@redhat.com>
>  R:	Peter Zijlstra <peterz@infradead.org>
>  R:	Darren Hart <dvhart@infradead.org>
>  R:	Davidlohr Bueso <dave@stgolabs.net>
> +R:	André Almeida <andrealmeid@collabora.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> locking/core

This goes in a separate commit.

> @@ -7725,7 +7726,7 @@ F:	Documentation/locking/*futex*
>  F:	include/asm-generic/futex.h
>  F:	include/linux/futex.h
>  F:	include/uapi/linux/futex.h
> -F:	kernel/futex.c
> +F:	kernel/futex*
>  F:	tools/perf/bench/futex*
>  F:	tools/testing/selftests/futex/
>  
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 252243c7783d..a30083ec4bd5 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -58,6 +58,7 @@ struct mq_attr;
>  struct compat_stat;
>  struct old_timeval32;
>  struct robust_list_head;
> +struct futex_waitv;
>  struct getcpu_cache;
>  struct old_linux_dirent;
>  struct perf_event_attr;
> @@ -623,6 +624,11 @@ asmlinkage long sys_get_robust_list(int pid,
>  asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
>  				    size_t len);
>  
> +/* kernel/futex2.c */
> +asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
> +				unsigned int nr_futexes, unsigned int flags,
> +				struct __kernel_timespec __user *timo);
> +
>  /* kernel/hrtimer.c */
>  asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
>  			      struct __kernel_timespec __user *rmtp);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 1c5fb86d455a..ebafbb27cc41 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -880,8 +880,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
>  #define __NR_process_mrelease 448
>  __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
>  
> +#define __NR_futex_waitv 449
> +__SC_COMP(__NR_futex_waitv, sys_futex_waitv)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 449
> +#define __NR_syscalls 450
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index 235e5b2facaa..71a5df8d2689 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -43,6 +43,31 @@
>  #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
>  					 FUTEX_PRIVATE_FLAG)
>  
> +/*
> + * Flags to specify the bit length of the futex word for futex2 syscalls.
> + * Currently, only 32 is supported.
> + */
> +#define FUTEX_32		2

Why start at 2?

> +
> +/*
> + * Max numbers of elements in a futex_waitv array
> + */
> +#define FUTEX_WAITV_MAX		128
> +
> +/**
> + * struct futex_waitv - A waiter for vectorized wait
> + * @val:	Expected value at uaddr
> + * @uaddr:	User address to wait on
> + * @flags:	Flags for this waiter
> + * @__reserved:	Reserved member to preserve data alignment. Should be 0.
> + */
> +struct futex_waitv {
> +	__u64 val;
> +	__u64 uaddr;
> +	__u32 flags;
> +	__u32 __reserved;
> +};

why force uaddr  to be __u64, even for 32-bit?  uaddr could be a (void*) for
all we care, no?  Also, by adding a reserved field, you are wasting 32
bits even on 32-bit architectures.

> +
>  /*
>   * Support for robust futexes: the kernel cleans up held futexes at
>   * thread exit time.
> diff --git a/init/Kconfig b/init/Kconfig
> index 11f8a845f259..a5c9300f9000 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1581,6 +1581,13 @@ config FUTEX
>  	  support for "fast userspace mutexes".  The resulting kernel may not
>  	  run glibc-based applications correctly.
>  
> +config FUTEX2
> +	bool "Enable futex2 support" if EXPERT
> +	depends on FUTEX
> +	default y
> +	help
> +	  Support for futex2 interface.
> +

This also seems unnecessary.  why not just reuse CONFIG_FUTEX?  It isn't
really a bunch of code you are adding anyway.

>  config FUTEX_PI
>  	bool
>  	depends on FUTEX && RT_MUTEXES
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 4df609be42d0..1eaf2af50283 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_PROFILING) += profile.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
>  obj-y += time/
>  obj-$(CONFIG_FUTEX) += futex.o
> +obj-$(CONFIG_FUTEX2) += futex2.o
>  obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
>  obj-$(CONFIG_SMP) += smp.o
>  ifneq ($(CONFIG_SMP),y)
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 32c91f9d7385..858465f97d9b 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2739,6 +2739,207 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
>  	__set_current_state(TASK_RUNNING);
>  }
>  
> +/**
> + * unqueue_multiple - Remove various futexes from their hash bucket

What about: "Remove an array of futexes from the hash table."

> + * @v:	   The list of futexes to unqueue
> + * @count: Number of futexes in the list
> + *
> + * Helper to unqueue a list of futexes. This can't fail.
> + *
> + * Return:
> + *  - >=0 - Index of the last futex that was awoken;
> + *  - -1  - No futex was awoken
> + */
> +static int unqueue_multiple(struct futex_vector *v, int count)
> +{
> +	int ret = -1, i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (!unqueue_me(&v[i].q))
> +			ret = i;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
> + * @vs:		The futex list to wait on
> + * @count:	The size of the list
> + * @awaken:	Index of the last awoken futex, if any. Used to notify the
> + *		caller that it can return this index to userspace (return parameter)
> + *
> + * Prepare multiple futexes in a single step and enqueue them. This may fail if
> + * the futex list is invalid or if any futex was already awoken. On success the
> + * task is ready to interruptible sleep.
> + *
> + * Return:
> + *  -  1 - One of the futexes was awaken by another thread
> + *  -  0 - Success
> + *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
> + */
> +static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *awaken)
> +{
> +	struct futex_hash_bucket *hb;
> +	bool retry = false;
> +	int ret, i;
> +	u32 uval;
> +
> +	/*
> +	 * Enqueuing multiple futexes is tricky, because we need to enqueue
> +	 * each futex in the list before dealing with the next one to avoid
> +	 * deadlocking on the hash bucket. But, before enqueuing, we need to
> +	 * make sure that current->state is TASK_INTERRUPTIBLE, so we don't
> +	 * absorb any awake events, which cannot be done before the
> +	 * get_futex_key of the next key, because it calls get_user_pages,
> +	 * which can sleep. Thus, we fetch the list of futexes keys in two
> +	 * steps, by first pinning all the memory keys in the futex key, and
> +	 * only then we read each key and queue the corresponding futex.
> +	 *
> +	 * Private futexes doesn't need to recalculate hash in retry, so skip
> +	 * get_futex_key() when retrying.
> +	 */
> +retry:
> +	for (i = 0; i < count; i++) {
> +		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
> +			continue;
> +
> +		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
> +				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
> +				    &vs[i].q.key, FUTEX_READ);
> +
> +		if (unlikely(ret))
> +			return ret;
> +	}
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i = 0; i < count; i++) {
> +		u32 __user *uaddr = (u32 __user *)vs[i].w.uaddr;
> +		struct futex_q *q = &vs[i].q;
> +		u32 val = (u32)vs[i].w.val;
> +
> +		hb = queue_lock(q);
> +		ret = get_futex_value_locked(&uval, uaddr);
> +
> +		if (!ret && uval == val) {
> +			/*
> +			 * The bucket lock can't be held while dealing with the
> +			 * next futex. Queue each futex at this moment so hb can
> +			 * be unlocked.
> +			 */
> +			queue_me(q, hb);
> +			continue;
> +		}
> +
> +		queue_unlock(hb);
> +		__set_current_state(TASK_RUNNING);
> +
> +		/*
> +		 * Even if something went wrong, if we find out that a futex
> +		 * was awaken, we don't return error and return this index to
> +		 * userspace
> +		 */
> +		*awaken = unqueue_multiple(vs, i);
> +		if (*awaken >= 0)
> +			return 1;

if user feed us a bogus key and get_futex_value_locked throws an EFAULT,
I think we should error out (after failing the get_user() also), instead
of ignoring it if a futex was awaken.  If this happens, we are helping
to hide application errors.

This means you should need to do the get_user() below before returning.

> +
> +		if (uval != val)
> +			return -EWOULDBLOCK;
> +
> +		if (ret) {
> +			/*
> +			 * If we need to handle a page fault, we need to do so
> +			 * without any lock and any enqueued futex (otherwise
> +			 * we could lose some wakeup). So we do it here, after
> +			 * undoing all the work done so far. In success, we
> +			 * retry all the work.
> +			 */
> +			if (get_user(uval, uaddr))
> +				return -EFAULT;
> +
> +			retry = true;
> +			goto retry;
> +		}

My nit is that this in an error path, but it doesn't look like it.  it
could benefit from making it more obvious.

> +	}
> +
> +	return 0;
> +}
> +
> +/**

...

> diff --git a/kernel/futex.h b/kernel/futex.h
> index c914e0080cf1..bcd0142c3f6e 100644
> --- a/kernel/futex.h
> +++ b/kernel/futex.h
> @@ -137,4 +137,19 @@ futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
>  	return 0;
>  }
>  
> +/**
> + * struct futex_vector - Auxiliary struct for futex_waitv()
> + * @w: Userspace provided data
> + * @q: Kernel side data
> + *
> + * Struct used to build an array with all data need for futex_waitv()
> + */
> +struct futex_vector {
> +	struct futex_waitv w;
> +	struct futex_q q;
> +};
> +
> +int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
> +			struct hrtimer_sleeper *to);
> +
>  #endif
> diff --git a/kernel/futex2.c b/kernel/futex2.c
> new file mode 100644
> index 000000000000..f724ecf40f3e
> --- /dev/null
> +++ b/kernel/futex2.c

Now I'm confused.  Why is the implementation split in two files?  I feel this just messes
up with a bunch of declarations and headers, making it much harder to review.

> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * futex2 interface system calls
> + *
> + * futex_waitv by André Almeida <andrealmeid@collabora.com>
> + *
> + * Copyright 2021 Collabora Ltd.
> + */
> +
> +#include "futex.h"
> +
> +/* Mask of available flags for each futex in futex_waitv list */
> +#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
> +
> +/* Mask of available flags for sys_futex_waitv flag */
> +#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
> +
> +/**
> + * futex_parse_waitv - Parse a waitv array from userspace
> + * @futexv:	Kernel side list of waiters to be filled
> + * @uwaitv:     Userspace list to be parsed
> + * @nr_futexes: Length of futexv
> + *
> + * Return: Error code on failure, 0 on success
> + */
> +static int futex_parse_waitv(struct futex_vector *futexv,
> +			     struct futex_waitv __user *uwaitv,
> +			     unsigned int nr_futexes)
> +{
> +	struct futex_waitv aux;
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_futexes; i++) {
> +		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
> +			return -EFAULT;
> +
> +		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
> +			return -EINVAL;
> +
> +		futexv[i].w.flags = aux.flags;
> +		futexv[i].w.val = aux.val;
> +		futexv[i].w.uaddr = aux.uaddr;
> +		futexv[i].q = futex_q_init;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * sys_futex_waitv - Wait on a list of futexes
> + * @waiters:    List of futexes to wait on
> + * @nr_futexes: Length of futexv
> + * @flags:      Flag for timeout (monotonic/realtime)
> + * @timo:	Optional absolute timeout.
> + *
> + * Given an array of `struct futex_waitv`, wait on each uaddr. The thread wakes
> + * if a futex_wake() is performed at any uaddr. The syscall returns immediately
> + * if any waiter has *uaddr != val. *timo is an optional timeout value for the
> + * operation. Each waiter has individual flags. The `flags` argument for the
> + * syscall should be used solely for specifying the timeout as realtime, if
> + * needed. Flags for shared futexes, sizes, etc. should be used on the
> + * individual flags of each waiter.
> + *
> + * Returns the array index of one of the awaken futexes. There's no given
> + * information of how many were awakened, or any particular attribute of it (if
> + * it's the first awakened, if it is of the smaller index...).
> + */
> +
> +SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
> +		unsigned int, nr_futexes, unsigned int, flags,
> +		struct __kernel_timespec __user *, timo)
> +{
> +	struct hrtimer_sleeper to;
> +	struct futex_vector *futexv;
> +	struct timespec64 ts;
> +	ktime_t time;
> +	int ret;
> +
> +	if (flags & ~FUTEXV_MASK)
> +		return -EINVAL;
> +
> +	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
> +		return -EINVAL;
> +
> +	if (timo) {
> +		int flag_clkid = (flags & FUTEX_CLOCK_REALTIME) ? FLAGS_CLOCKRT : 0;
> +
> +		if (get_timespec64(&ts, timo))
> +			return -EFAULT;
> +
> +		/*
> +		 * Since there's no opcode for futex_waitv, use
> +		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
> +		 */
> +		ret = futex_init_timeout(FUTEX_WAIT_BITSET, flags, &ts, &time);
> +		if (ret)
> +			return ret;
> +
> +		futex_setup_timer(&time, &to, flag_clkid, 0);
> +	}
> +
> +	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
> +	if (!futexv)
> +		return -ENOMEM;
> +
> +	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
> +	if (!ret)
> +		ret = futex_wait_multiple(futexv, nr_futexes, timo ? &to : NULL);
> +
> +	if (timo) {
> +		hrtimer_cancel(&to.timer);
> +		destroy_hrtimer_on_stack(&to.timer);
> +	}
> +
> +	kfree(futexv);
> +	return ret;
> +}
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index f43d89d92860..3d0b94f6b88d 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -151,6 +151,9 @@ COND_SYSCALL_COMPAT(set_robust_list);
>  COND_SYSCALL(get_robust_list);
>  COND_SYSCALL_COMPAT(get_robust_list);
>  
> +/* kernel/futex2.c */
> +COND_SYSCALL(futex_waitv);
> +

This should go into a syscall wiring patch, if possible.

>  /* kernel/hrtimer.c */
>  
>  /* kernel/itimer.c */
> -- 
>
> 2.33.0

-- 
Gabriel Krisman Bertazi
