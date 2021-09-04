Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAE400D76
	for <lists+linux-api@lfdr.de>; Sun,  5 Sep 2021 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhIDXN1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 4 Sep 2021 19:13:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52030 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbhIDXNY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 4 Sep 2021 19:13:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id CCC681F41D9B
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 2/5] futex2: Implement vectorized wait
Date:   Sat,  4 Sep 2021 20:11:56 -0300
Message-Id: <20210904231159.13292-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904231159.13292-1-andrealmeid@collabora.com>
References: <20210904231159.13292-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add support to wait on multiple futexes. This is the interface
implemented by this syscall:

futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
	    unsigned int flags, struct timespec *timo)

struct futex_waitv {
	__u64 val;
	__u64 uaddr;
	__u32 flags;
	__u32 __reserved;
};

Given an array of struct futex_waitv, wait on each uaddr. The thread
wakes if a futex_wake() is performed at any uaddr. The syscall returns
immediately if any waiter has *uaddr != val. *timo is an optional
absolute timeout value for the operation. This syscall supports only
64bit sized timeout structs. The flags argument of the syscall should be
used solely for specifying the timeout clock as realtime, if needed.
Flags for shared futexes, sizes, etc. should be used on the individual
flags of each waiter.

__reserved is used for explicit padding and should be 0, but it might be
used for future extensions. If the userspace uses 32-bit pointers, it
should make sure to explicitly cast it when assigning to waitv::uaddr.

Returns the array index of one of the awakened futexes. There’s no given
information of how many were awakened, or any particular attribute of it
(if it’s the first awakened, if it is of the smaller index...).

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 MAINTAINERS                       |   3 +-
 include/linux/compat.h            |   3 +
 include/uapi/asm-generic/unistd.h |   5 +-
 include/uapi/linux/futex.h        |  25 ++++
 init/Kconfig                      |   7 ++
 kernel/Makefile                   |   1 +
 kernel/futex.c                    | 201 ++++++++++++++++++++++++++++++
 kernel/futex.h                    |  15 +++
 kernel/futex2.c                   | 131 +++++++++++++++++++
 kernel/sys_ni.c                   |   4 +
 10 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 kernel/futex2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e4bdea045e85..69b1de05a12a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7701,6 +7701,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
 R:	Davidlohr Bueso <dave@stgolabs.net>
+R:	André Almeida <andrealmeid@collabora.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
@@ -7708,7 +7709,7 @@ F:	Documentation/locking/*futex*
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
-F:	kernel/futex.c
+F:	kernel/futex*
 F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8e0598c7d1d1..f833587e93db 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -688,6 +688,9 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
+asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
+				compat_uint_t nr_futexes, compat_uint_t flags,
+				struct __kernel_timespec __user *timo);
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 14c8fe863c6d..90748493c582 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -880,8 +880,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 
+#define __NR_futex_waitv 449
+__SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 449
+#define __NR_syscalls 450
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 235e5b2facaa..71a5df8d2689 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -43,6 +43,31 @@
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
 
+/*
+ * Flags to specify the bit length of the futex word for futex2 syscalls.
+ * Currently, only 32 is supported.
+ */
+#define FUTEX_32		2
+
+/*
+ * Max numbers of elements in a futex_waitv array
+ */
+#define FUTEX_WAITV_MAX		128
+
+/**
+ * struct futex_waitv - A waiter for vectorized wait
+ * @val:	Expected value at uaddr
+ * @uaddr:	User address to wait on
+ * @flags:	Flags for this waiter
+ * @__reserved:	Reserved member to preserve data alignment. Should be 0.
+ */
+struct futex_waitv {
+	__u64 val;
+	__u64 uaddr;
+	__u32 flags;
+	__u32 __reserved;
+};
+
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
diff --git a/init/Kconfig b/init/Kconfig
index e708180e9a59..802f5f7be905 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1567,6 +1567,13 @@ config FUTEX
 	  support for "fast userspace mutexes".  The resulting kernel may not
 	  run glibc-based applications correctly.
 
+config FUTEX2
+	bool "Enable futex2 support" if EXPERT
+	depends on FUTEX
+	default y
+	help
+	  Support for futex2 interface.
+
 config FUTEX_PI
 	bool
 	depends on FUTEX && RT_MUTEXES
diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..1eaf2af50283 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
 obj-$(CONFIG_FUTEX) += futex.o
+obj-$(CONFIG_FUTEX2) += futex2.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += smp.o
 ifneq ($(CONFIG_SMP),y)
diff --git a/kernel/futex.c b/kernel/futex.c
index 58f2dc29c408..ab3d513fceb1 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2707,6 +2707,207 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	__set_current_state(TASK_RUNNING);
 }
 
+/**
+ * unqueue_multiple - Remove various futexes from their hash bucket
+ * @v:	   The list of futexes to unqueue
+ * @count: Number of futexes in the list
+ *
+ * Helper to unqueue a list of futexes. This can't fail.
+ *
+ * Return:
+ *  - >=0 - Index of the last futex that was awoken;
+ *  - -1  - No futex was awoken
+ */
+static int unqueue_multiple(struct futex_vector *v, int count)
+{
+	int ret = -1, i;
+
+	for (i = 0; i < count; i++) {
+		if (!unqueue_me(&v[i].q))
+			ret = i;
+	}
+
+	return ret;
+}
+
+/**
+ * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
+ * @vs:		The futex list to wait on
+ * @count:	The size of the list
+ * @awaken:	Index of the last awoken futex, if any. Used to notify the
+ *		caller that it can return this index to userspace (return parameter)
+ *
+ * Prepare multiple futexes in a single step and enqueue them. This may fail if
+ * the futex list is invalid or if any futex was already awoken. On success the
+ * task is ready to interruptible sleep.
+ *
+ * Return:
+ *  -  1 - One of the futexes was awaken by another thread
+ *  -  0 - Success
+ *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
+ */
+static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *awaken)
+{
+	struct futex_hash_bucket *hb;
+	bool retry = false;
+	int ret, i;
+	u32 uval;
+
+	/*
+	 * Enqueuing multiple futexes is tricky, because we need to enqueue
+	 * each futex in the list before dealing with the next one to avoid
+	 * deadlocking on the hash bucket. But, before enqueuing, we need to
+	 * make sure that current->state is TASK_INTERRUPTIBLE, so we don't
+	 * absorb any awake events, which cannot be done before the
+	 * get_futex_key of the next key, because it calls get_user_pages,
+	 * which can sleep. Thus, we fetch the list of futexes keys in two
+	 * steps, by first pinning all the memory keys in the futex key, and
+	 * only then we read each key and queue the corresponding futex.
+	 *
+	 * Private futexes doesn't need to recalculate hash in retry, so skip
+	 * get_futex_key() when retrying.
+	 */
+retry:
+	for (i = 0; i < count; i++) {
+		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
+			continue;
+
+		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
+				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
+				    &vs[i].q.key, FUTEX_READ);
+
+		if (unlikely(ret))
+			return ret;
+	}
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	for (i = 0; i < count; i++) {
+		u32 __user *uaddr = (u32 __user *)vs[i].w.uaddr;
+		struct futex_q *q = &vs[i].q;
+		u32 val = (u32)vs[i].w.val;
+
+		hb = queue_lock(q);
+		ret = get_futex_value_locked(&uval, uaddr);
+
+		if (!ret && uval == val) {
+			/*
+			 * The bucket lock can't be held while dealing with the
+			 * next futex. Queue each futex at this moment so hb can
+			 * be unlocked.
+			 */
+			queue_me(q, hb);
+			continue;
+		}
+
+		queue_unlock(hb);
+		__set_current_state(TASK_RUNNING);
+
+		/*
+		 * Even if something went wrong, if we find out that a futex
+		 * was awaken, we don't return error and return this index to
+		 * userspace
+		 */
+		*awaken = unqueue_multiple(vs, i);
+		if (*awaken >= 0)
+			return 1;
+
+		if (uval != val)
+			return -EWOULDBLOCK;
+
+		if (ret) {
+			/*
+			 * If we need to handle a page fault, we need to do so
+			 * without any lock and any enqueued futex (otherwise
+			 * we could lose some wakeup). So we do it here, after
+			 * undoing all the work done so far. In success, we
+			 * retry all the work.
+			 */
+			if (get_user(uval, uaddr))
+				return -EFAULT;
+
+			retry = true;
+			goto retry;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * futex_sleep_multiple - Check sleeping conditions and sleep
+ * @vs:    List of futexes to wait for
+ * @count: Length of vs
+ * @to:    Timeout
+ *
+ * Sleep if and only if the timeout hasn't expired and no futex on the list has
+ * been awaken.
+ */
+static void futex_sleep_multiple(struct futex_vector *vs, unsigned int count,
+				 struct hrtimer_sleeper *to)
+{
+	if (to && !to->task)
+		return;
+
+	for (; count; count--, vs++) {
+		if (!READ_ONCE(vs->q.lock_ptr))
+			return;
+	}
+
+	freezable_schedule();
+}
+
+/**
+ * futex_wait_multiple - Prepare to wait on and enqueue several futexes
+ * @vs:		The list of futexes to wait on
+ * @count:	The number of objects
+ * @to:		Timeout before giving up and returning to userspace
+ *
+ * Entry point for the FUTEX_WAIT_MULTIPLE futex operation, this function
+ * sleeps on a group of futexes and returns on the first futex that is
+ * wake, or after the timeout has elapsed.
+ *
+ * Return:
+ *  - >=0 - Hint to the futex that was awoken
+ *  - <0  - On error
+ */
+int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			struct hrtimer_sleeper *to)
+{
+	int ret, hint = 0;
+
+	if (to)
+		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
+
+	while (1) {
+		ret = futex_wait_multiple_setup(vs, count, &hint);
+		if (ret) {
+			if (ret > 0) {
+				/* A futex was awaken during setup */
+				ret = hint;
+			}
+			return ret;
+		}
+
+		futex_sleep_multiple(vs, count, to);
+
+		__set_current_state(TASK_RUNNING);
+
+		ret = unqueue_multiple(vs, count);
+		if (ret >= 0)
+			return ret;
+
+		if (to && !to->task)
+			return -ETIMEDOUT;
+		else if (signal_pending(current))
+			return -ERESTARTSYS;
+		/*
+		 * The final case is a spurious wakeup, for
+		 * which just retry.
+		 */
+	}
+}
+
 /**
  * futex_wait_setup() - Prepare to wait on a futex
  * @uaddr:	the futex userspace address
diff --git a/kernel/futex.h b/kernel/futex.h
index c914e0080cf1..bcd0142c3f6e 100644
--- a/kernel/futex.h
+++ b/kernel/futex.h
@@ -137,4 +137,19 @@ futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
 	return 0;
 }
 
+/**
+ * struct futex_vector - Auxiliary struct for futex_waitv()
+ * @w: Userspace provided data
+ * @q: Kernel side data
+ *
+ * Struct used to build an array with all data need for futex_waitv()
+ */
+struct futex_vector {
+	struct futex_waitv w;
+	struct futex_q q;
+};
+
+int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			struct hrtimer_sleeper *to);
+
 #endif
diff --git a/kernel/futex2.c b/kernel/futex2.c
new file mode 100644
index 000000000000..34e4b1b85387
--- /dev/null
+++ b/kernel/futex2.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex2 interface system calls
+ *
+ * futex_waitv by André Almeida <andrealmeid@collabora.com>
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+
+#include "futex.h"
+
+/* Mask of available flags for each futex in futex_waitv list */
+#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
+
+/* Mask of available flags for sys_futex_waitv flag */
+#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
+
+/**
+ * futex_parse_waitv - Parse a waitv array from userspace
+ * @futexv:	Kernel side list of waiters to be filled
+ * @uwaitv:     Userspace list to be parsed
+ * @nr_futexes: Length of futexv
+ *
+ * Return: Error code on failure, 0 on success
+ */
+static int futex_parse_waitv(struct futex_vector *futexv,
+			     struct futex_waitv __user *uwaitv,
+			     unsigned int nr_futexes)
+{
+	struct futex_waitv aux;
+	unsigned int i;
+
+	for (i = 0; i < nr_futexes; i++) {
+		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
+			return -EFAULT;
+
+		if ((aux.flags & ~FUTEXV_WAITER_MASK) || aux.__reserved)
+			return -EINVAL;
+
+		futexv[i].w.flags = aux.flags;
+		futexv[i].w.val = aux.val;
+		futexv[i].w.uaddr = aux.uaddr;
+		futexv[i].q = futex_q_init;
+	}
+
+	return 0;
+}
+
+/**
+ * futex_waitv - Wait on a list of futexes
+ * @waiters:    List of futexes to wait on
+ * @nr_futexes: Length of futexv
+ * @flags:      Flag for timeout (monotonic/realtime)
+ * @timo:	Optional absolute timeout.
+ *
+ * Given an array of `struct futex_waitv`, wait on each uaddr. The thread wakes
+ * if a futex_wake() is performed at any uaddr. The syscall returns immediately
+ * if any waiter has *uaddr != val. *timo is an optional timeout value for the
+ * operation. Each waiter has individual flags. The `flags` argument for the
+ * syscall should be used solely for specifying the timeout as realtime, if
+ * needed. Flags for shared futexes, sizes, etc. should be used on the
+ * individual flags of each waiter.
+ *
+ * Returns the array index of one of the awaken futexes. There's no given
+ * information of how many were awakened, or any particular attribute of it (if
+ * it's the first awakened, if it is of the smaller index...).
+ */
+static long futex_waitv(struct futex_waitv __user *waiters, unsigned int nr_futexes,
+			unsigned int flags, struct __kernel_timespec __user *timo)
+{
+	struct hrtimer_sleeper to;
+	struct futex_vector *futexv;
+	struct timespec64 ts;
+	ktime_t time;
+	int ret;
+
+	if (flags & ~FUTEXV_MASK)
+		return -EINVAL;
+
+	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
+		return -EINVAL;
+
+	if (timo) {
+		int flag_clkid = (flags & FUTEX_CLOCK_REALTIME) ? FLAGS_CLOCKRT : 0;
+
+		if (get_timespec64(&ts, timo))
+			return -EFAULT;
+
+		/*
+		 * Since there's no opcode for futex_waitv, use
+		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
+		 */
+		ret = futex_init_timeout(FUTEX_WAIT_BITSET, flags, &ts, &time);
+		if (ret)
+			return ret;
+
+		futex_setup_timer(&time, &to, flag_clkid, 0);
+	}
+
+	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
+	if (!futexv)
+		return -ENOMEM;
+
+	ret = futex_parse_waitv(futexv, waiters, nr_futexes);
+	if (!ret)
+		ret = futex_wait_multiple(futexv, nr_futexes, timo ? &to : NULL);
+
+	if (timo) {
+		hrtimer_cancel(&to.timer);
+		destroy_hrtimer_on_stack(&to.timer);
+	}
+
+	kfree(futexv);
+	return ret;
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
+		       unsigned int, nr_futexes, unsigned int, flags,
+		       struct __kernel_timespec __user *, timo)
+{
+	return futex_waitv(waiters, nr_futexes, flags, timo);
+}
+#endif
+
+SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
+		unsigned int, nr_futexes, unsigned int, flags,
+		struct __kernel_timespec __user *, timo)
+{
+	return futex_waitv(waiters, nr_futexes, flags, timo);
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 64578adfe115..55f07c8feaf6 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -151,6 +151,10 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 
+/* kernel/futex2.c */
+COND_SYSCALL(futex_waitv);
+COND_SYSCALL_COMPAT(futex_waitv);
+
 /* kernel/hrtimer.c */
 
 /* kernel/itimer.c */
-- 
2.33.0

