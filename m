Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF81416414
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhIWROS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:14:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47168 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbhIWROJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:14:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4229C1F44610
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
Subject: [PATCH v2 16/22] futex: Implement sys_futex_waitv()
Date:   Thu, 23 Sep 2021 14:11:05 -0300
Message-Id: <20210923171111.300673-17-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add support to wait on multiple futexes. This is the interface
implemented by this syscall:

futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
	    unsigned int flags, struct timespec *timeout, clockid_t clockid)

struct futex_waitv {
	__u64 val;
	__u64 uaddr;
	__u32 flags;
	__u32 __reserved;
};

Given an array of struct futex_waitv, wait on each uaddr. The thread
wakes if a futex_wake() is performed at any uaddr. The syscall returns
immediately if any waiter has *uaddr != val. *timeout is an optional
absolute timeout value for the operation. This syscall supports only
64bit sized timeout structs. The flags argument of the syscall should be
empty, but it can be used for future extensions. Flags for shared
futexes, sizes, etc. should be used on the individual flags of each
waiter.

__reserved is used for explicit padding and should be 0, but it might be
used for future extensions. If the userspace uses 32-bit pointers, it
should make sure to explicitly cast it when assigning to waitv::uaddr.

Returns the array index of one of the awakened futexes. There’s no given
information of how many were awakened, or any particular attribute of it
(if it’s the first awakened, if it is of the smaller index...).

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 MAINTAINERS                       |   1 +
 include/linux/syscalls.h          |   5 +
 include/uapi/asm-generic/unistd.h |   5 +-
 include/uapi/linux/futex.h        |  25 ++++
 kernel/futex/futex.h              |  15 +++
 kernel/futex/syscalls.c           | 117 +++++++++++++++++
 kernel/futex/waitwake.c           | 201 ++++++++++++++++++++++++++++++
 kernel/sys_ni.c                   |   1 +
 8 files changed, 369 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcf4d307fce1..cb77dd389f4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7718,6 +7718,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
 R:	Davidlohr Bueso <dave@stgolabs.net>
+R:	André Almeida <andrealmeid@collabora.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 25979682ade5..528a478dbda8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -58,6 +58,7 @@ struct mq_attr;
 struct compat_stat;
 struct old_timeval32;
 struct robust_list_head;
+struct futex_waitv;
 struct getcpu_cache;
 struct old_linux_dirent;
 struct perf_event_attr;
@@ -623,6 +624,10 @@ asmlinkage long sys_get_robust_list(int pid,
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
+				unsigned int nr_futexes, unsigned int flags,
+				struct __kernel_timespec __user *timeout, clockid_t clockid);
+
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c5fb86d455a..4557a8b6086f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -880,8 +880,11 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 
+#define __NR_futex_waitv 449
+__SYSCALL(__NR_futex_waitv, sys_futex_waitv)
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
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 465f7bd5caef..948fcf317681 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -268,6 +268,21 @@ extern int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
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
+extern int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
+			       struct hrtimer_sleeper *to);
+
 extern int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset);
 
 extern int futex_wake_op(u32 __user *uaddr1, unsigned int flags,
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 6e7e36c640a1..368e9c17fa20 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -199,6 +199,123 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
+/* Mask of available flags for each futex in futex_waitv list */
+#define FUTEXV_WAITER_MASK (FUTEX_32 | FUTEX_PRIVATE_FLAG)
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
+		if (!(aux.flags & FUTEX_32))
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
+ * @timeout:	Optional absolute timeout.
+ * @clockid:	Clock to be used for the timeout, realtime or monotonic.
+ *
+ * Given an array of `struct futex_waitv`, wait on each uaddr. The thread wakes
+ * if a futex_wake() is performed at any uaddr. The syscall returns immediately
+ * if any waiter has *uaddr != val. *timeout is an optional timeout value for the
+ * operation. Each waiter has individual flags. The `flags` argument for the
+ * syscall should be used solely for specifying the timeout as realtime, if
+ * needed. Flags for private futexes, sizes, etc. should be used on the
+ * individual flags of each waiter.
+ *
+ * Returns the array index of one of the awaken futexes. There's no given
+ * information of how many were awakened, or any particular attribute of it (if
+ * it's the first awakened, if it is of the smaller index...).
+ */
+
+SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
+		unsigned int, nr_futexes, unsigned int, flags,
+		struct __kernel_timespec __user *, timeout, clockid_t, clockid)
+{
+	struct hrtimer_sleeper to;
+	struct futex_vector *futexv;
+	struct timespec64 ts;
+	ktime_t time;
+	int ret;
+
+	/* This syscall supports no flags for now */
+	if (flags)
+		return -EINVAL;
+
+	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
+		return -EINVAL;
+
+	if (timeout) {
+		int flag_clkid = 0, flag_init = 0;
+
+		if (clockid == CLOCK_REALTIME) {
+			flag_clkid = FLAGS_CLOCKRT;
+			flag_init = FUTEX_CLOCK_REALTIME;
+		}
+
+		if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC)
+			return -EINVAL;
+
+		if (get_timespec64(&ts, timeout))
+			return -EFAULT;
+
+		/*
+		 * Since there's no opcode for futex_waitv, use
+		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
+		 */
+		ret = futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
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
+		ret = futex_wait_multiple(futexv, nr_futexes, timeout ? &to : NULL);
+
+	if (timeout) {
+		hrtimer_cancel(&to.timer);
+		destroy_hrtimer_on_stack(&to.timer);
+	}
+
+	kfree(futexv);
+	return ret;
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 36880784aa11..b45597aab472 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -357,6 +357,207 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
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
+		if (!futex_unqueue(&v[i].q))
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
+		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
+		struct futex_q *q = &vs[i].q;
+		u32 val = (u32)vs[i].w.val;
+
+		hb = futex_q_lock(q);
+		ret = futex_get_value_locked(&uval, uaddr);
+
+		if (!ret && uval == val) {
+			/*
+			 * The bucket lock can't be held while dealing with the
+			 * next futex. Queue each futex at this moment so hb can
+			 * be unlocked.
+			 */
+			futex_queue(q, hb);
+			continue;
+		}
+
+		futex_q_unlock(hb);
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
+
+		if (uval != val)
+			return -EWOULDBLOCK;
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
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 13ee8334ab6e..d1944258cfc0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -150,6 +150,7 @@ COND_SYSCALL(set_robust_list);
 COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
+COND_SYSCALL(futex_waitv);
 
 /* kernel/hrtimer.c */
 
-- 
2.33.0

