Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E03E1C11
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 21:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhHETFQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbhHETEy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 15:04:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9031C0617A2;
        Thu,  5 Aug 2021 12:04:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D15201F44325
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/4] futex2: Implement vectorized wait
Date:   Thu,  5 Aug 2021 16:04:03 -0300
Message-Id: <20210805190405.59110-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805190405.59110-1-andrealmeid@collabora.com>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
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
	void *uaddr;
	unsigned int flags;
};

Given an array of struct futex_waitv, wait on each uaddr. The thread
wakes if a futex_wake() is performed at any uaddr. The syscall returns
immediately if any waiter has *uaddr != val. *timo is an optional
timeout value for the operation. The flags argument of the syscall
should be used solely for specifying the timeout clock as realtime, if
needed.  Flags for shared futexes, sizes, etc. should be used on the
individual flags of each waiter.

Returns the array index of one of the awakened futexes. There’s no given
information of how many were awakened, or any particular attribute of it
(if it’s the first awakened, if it is of the smaller index...).

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/compat.h                 |   9 ++
 include/linux/futex.h                  |  15 ++
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/futex.h             |  17 +++
 init/Kconfig                           |   7 +
 kernel/Makefile                        |   1 +
 kernel/futex.c                         | 182 +++++++++++++++++++++++
 kernel/futex2.c                        | 192 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   4 +
 11 files changed, 433 insertions(+), 1 deletion(-)
 create mode 100644 kernel/futex2.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ce763a12311c..de4053104ffa 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -452,3 +452,4 @@
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
+448	i386	futex_waitv		sys_futex_waitv			compat_sys_futex_waitv
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f6b57799c1ea..ec8659eba1f3 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -369,6 +369,7 @@
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
+448	common	futex_waitv		sys_futex_waitv
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/compat.h b/include/linux/compat.h
index c270124e4402..0c38adfc40a2 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -368,6 +368,12 @@ struct compat_robust_list_head {
 	compat_uptr_t			list_op_pending;
 };
 
+struct compat_futex_waitv {
+	compat_u64 val;
+	compat_uptr_t uaddr;
+	compat_uint_t flags;
+};
+
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
@@ -690,6 +696,9 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
+asmlinkage long compat_sys_futex_waitv(struct compat_futex_waitv *waiters,
+				       compat_uint_t nr_futexes, compat_uint_t flags,
+				       struct __kernel_timespec __user *timo);
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct old_itimerval32 __user *it);
diff --git a/include/linux/futex.h b/include/linux/futex.h
index f7a0f4a4b5f0..f7ba0577e0e8 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -100,6 +100,18 @@ struct futex_q {
 	u32 bitset;
 } __randomize_layout;
 
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
 #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = 0ULL } }
 
 static const struct futex_q futex_q_init = {
@@ -112,6 +124,9 @@ inline struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
 
+int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			struct hrtimer_sleeper *to);
+
 #ifdef CONFIG_FUTEX
 enum {
 	FUTEX_STATE_OK,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a9d6fcd95f42..17cebd1e9384 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -878,8 +878,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
 
+#define __NR_futex_waitv 448
+__SC_COMP(__NR_futex_waitv, sys_futex_waitv, compat_sys_futex_waitv)
+
 #undef __NR_syscalls
-#define __NR_syscalls 448
+#define __NR_syscalls 449
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index 235e5b2facaa..daa135bdedda 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -42,6 +42,23 @@
 					 FUTEX_PRIVATE_FLAG)
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
+#define FUTEX_32	2
+#define FUTEX_SHARED_FLAG 8
+#define FUTEX_SIZE_MASK	0x3
+
+#define FUTEX_WAITV_MAX 128
+
+/**
+ * struct futex_waitv - A waiter for vectorized wait
+ * @val:   Expected value at uaddr
+ * @uaddr: User address to wait on
+ * @flags: Flags for this waiter
+ */
+struct futex_waitv {
+	__u64 val;
+	void __user *uaddr;
+	unsigned int flags;
+};
 
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
diff --git a/init/Kconfig b/init/Kconfig
index 55f9f7738ebb..4cfc315182ac 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1558,6 +1558,13 @@ config FUTEX
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
index c07cb0f747ac..a3d4d9f52a3a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2564,6 +2564,188 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	__set_current_state(TASK_RUNNING);
 }
 
+/**
+ * unqueue_multiple() - Remove various futexes from their futex_hash_bucket
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
+ * futex_wait_multiple_setup() - Prepare to wait and enqueue multiple futexes
+ * @vs:		The corresponding futex list
+ * @count:	The size of the list
+ * @awaken:	Index of the last awoken futex (return parameter)
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
+	int ret, i;
+	u32 uval;
+
+	/*
+	 * Enqueuing multiple futexes is tricky, because we need to
+	 * enqueue each futex in the list before dealing with the next
+	 * one to avoid deadlocking on the hash bucket.  But, before
+	 * enqueuing, we need to make sure that current->state is
+	 * TASK_INTERRUPTIBLE, so we don't absorb any awake events, which
+	 * cannot be done before the get_futex_key of the next key,
+	 * because it calls get_user_pages, which can sleep.  Thus, we
+	 * fetch the list of futexes keys in two steps, by first pinning
+	 * all the memory keys in the futex key, and only then we read
+	 * each key and queue the corresponding futex.
+	 */
+retry:
+	for (i = 0; i < count; i++) {
+		ret = get_futex_key(vs[i].w.uaddr,
+				    vs[i].w.flags & FUTEX_SHARED_FLAG,
+				    &vs[i].q.key, FUTEX_READ);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	for (i = 0; i < count; i++) {
+		struct futex_q *q = &vs[i].q;
+		struct futex_waitv *waitv = &vs[i].w;
+
+		hb = queue_lock(q);
+		ret = get_futex_value_locked(&uval, waitv->uaddr);
+		if (ret) {
+			/*
+			 * We need to try to handle the fault, which
+			 * cannot be done without sleep, so we need to
+			 * undo all the work already done, to make sure
+			 * we don't miss any wake ups.  Therefore, clean
+			 * up, handle the fault and retry from the
+			 * beginning.
+			 */
+			queue_unlock(hb);
+			__set_current_state(TASK_RUNNING);
+
+			*awaken = unqueue_multiple(vs, i);
+			if (*awaken >= 0)
+				return 1;
+
+			if (get_user(uval, (u32 __user *)waitv->uaddr))
+				return -EINVAL;
+
+			goto retry;
+		}
+
+		if (uval != waitv->val) {
+			queue_unlock(hb);
+			__set_current_state(TASK_RUNNING);
+
+			/*
+			 * If something was already awaken, we can
+			 * safely ignore the error and succeed.
+			 */
+			*awaken = unqueue_multiple(vs, i);
+			if (*awaken >= 0)
+				return 1;
+
+			return -EWOULDBLOCK;
+		}
+
+		/*
+		 * The bucket lock can't be held while dealing with the
+		 * next futex. Queue each futex at this moment so hb can
+		 * be unlocked.
+		 */
+		queue_me(&vs[i].q, hb);
+	}
+	return 0;
+}
+
+/**
+ * futex_wait_multiple() - Prepare to wait on and enqueue several futexes
+ * @vs:		The list of futexes to wait on
+ * @count:	The number of objects
+ * @to:		Timeout before giving up and returning to userspace
+ *
+ * Entry point for the FUTEX_WAIT_MULTIPLE futex operation, this function
+ * sleeps on a group of futexes and returns on the first futex that
+ * triggered, or after the timeout has elapsed.
+ *
+ * Return:
+ *  - >=0 - Hint to the futex that was awoken
+ *  - <0  - On error
+ */
+int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			struct hrtimer_sleeper *to)
+{
+	int ret, hint = 0;
+	unsigned int i;
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
+		if (to)
+			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
+
+		/*
+		 * Avoid sleeping if another thread already tried to
+		 * wake us.
+		 */
+		for (i = 0; i < count; i++) {
+			if (plist_node_empty(&vs[i].q.list))
+				break;
+		}
+
+		if (i == count && (!to || to->task))
+			freezable_schedule();
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
diff --git a/kernel/futex2.c b/kernel/futex2.c
new file mode 100644
index 000000000000..19bbd4bf7187
--- /dev/null
+++ b/kernel/futex2.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex2 system call interface by André Almeida <andrealmeid@collabora.com>
+ *
+ * Copyright 2021 Collabora Ltd.
+ */
+
+#include <asm/futex.h>
+
+#include <linux/freezer.h>
+#include <linux/syscalls.h>
+
+/* Mask for each futex in futex_waitv list */
+#define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)
+
+/* Mask for sys_futex_waitv flag */
+#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
+
+#ifdef CONFIG_COMPAT
+/**
+ * compat_futex_parse_waitv - Parse a waitv array from userspace
+ * @futexv:	Kernel side list of waiters to be filled
+ * @uwaitv:     Userspace list to be parsed
+ * @nr_futexes: Length of futexv
+ *
+ * Return: Error code on failure, pointer to a prepared futexv otherwise
+ */
+static int compat_futex_parse_waitv(struct futex_vector *futexv,
+				    struct compat_futex_waitv __user *uwaitv,
+				    unsigned int nr_futexes)
+{
+	struct compat_futex_waitv aux;
+	unsigned int i;
+
+	for (i = 0; i < nr_futexes; i++) {
+		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
+			return -EFAULT;
+
+		if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
+		    (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
+			return -EINVAL;
+
+		futexv[i].w.flags = aux.flags;
+		futexv[i].w.val = aux.val;
+		futexv[i].w.uaddr = compat_ptr(aux.uaddr);
+		futexv[i].q = futex_q_init;
+	}
+
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE4(futex_waitv, struct compat_futex_waitv __user *, waiters,
+		       unsigned int, nr_futexes, unsigned int, flags,
+		       struct __kernel_timespec __user *, timo)
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
+		int flag_clkid = 0;
+
+		if (get_timespec64(&ts, timo))
+			return -EFAULT;
+
+		if (!timespec64_valid(&ts))
+			return -EINVAL;
+
+		if (flags & FUTEX_CLOCK_REALTIME)
+			flag_clkid = FLAGS_CLOCKRT;
+
+		time = timespec64_to_ktime(ts);
+		futex_setup_timer(&time, &to, flag_clkid, 0);
+	}
+
+	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
+	if (!futexv)
+		return -ENOMEM;
+
+	ret = compat_futex_parse_waitv(futexv, waiters, nr_futexes);
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
+#endif
+
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
+		if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
+		    (aux.flags & FUTEX_SIZE_MASK) != FUTEX_32)
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
+ * sys_futex_waitv - Wait on a list of futexes
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
+SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
+		unsigned int, nr_futexes, unsigned int, flags,
+		struct __kernel_timespec __user *, timo)
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
+		int flag_clkid = 0;
+
+		if (get_timespec64(&ts, timo))
+			return -EFAULT;
+
+		if (!timespec64_valid(&ts))
+			return -EINVAL;
+
+		if (flags & FUTEX_CLOCK_REALTIME)
+			flag_clkid = FLAGS_CLOCKRT;
+
+		time = timespec64_to_ktime(ts);
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
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 30971b1dd4a9..03062eb03669 100644
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
2.32.0

