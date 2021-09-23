Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB44163F6
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbhIWRNJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIWRNH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id CF7691F445FD
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
Subject: [PATCH v2 02/22] futex: Split out syscalls
Date:   Thu, 23 Sep 2021 14:10:51 -0300
Message-Id: <20210923171111.300673-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Put the syscalls in their own little file.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 include/linux/syscalls.h |   2 +-
 kernel/futex/Makefile    |   2 +-
 kernel/futex/core.c      | 532 +++++++++------------------------------
 kernel/futex/futex.h     |  58 +++++
 kernel/futex/syscalls.c  | 279 ++++++++++++++++++++
 kernel/sys_ni.c          |   2 +-
 6 files changed, 455 insertions(+), 420 deletions(-)
 create mode 100644 kernel/futex/futex.h
 create mode 100644 kernel/futex/syscalls.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 252243c7783d..25979682ade5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -610,7 +610,7 @@ asmlinkage long sys_waitid(int which, pid_t pid,
 asmlinkage long sys_set_tid_address(int __user *tidptr);
 asmlinkage long sys_unshare(unsigned long unshare_flags);
 
-/* kernel/futex.c */
+/* kernel/futex/syscalls.c */
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
 			  const struct __kernel_timespec __user *utime,
 			  u32 __user *uaddr2, u32 val3);
diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
index b89ba3fba343..ff9a9605a8d6 100644
--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o
+obj-y += core.o syscalls.o
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index f9bc9aa0ce1e..69d98929f2f5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -34,14 +34,12 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
-#include <linux/syscalls.h>
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
-#include <linux/time_namespace.h>
-
-#include <asm/futex.h>
+#include <linux/slab.h>
 
+#include "futex.h"
 #include "../locking/rtmutex_common.h"
 
 /*
@@ -144,27 +142,10 @@
  * double_lock_hb() and double_unlock_hb(), respectively.
  */
 
-#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
-#define futex_cmpxchg_enabled 1
-#else
-static int  __read_mostly futex_cmpxchg_enabled;
+#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
+int  __read_mostly futex_cmpxchg_enabled;
 #endif
 
-/*
- * Futex flags used to encode options to functions and preserve them across
- * restarts.
- */
-#ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x01
-#else
-/*
- * NOMMU does not have per process address space. Let the compiler optimize
- * code away.
- */
-# define FLAGS_SHARED		0x00
-#endif
-#define FLAGS_CLOCKRT		0x02
-#define FLAGS_HAS_TIMEOUT	0x04
 
 /*
  * Priority Inheritance state:
@@ -329,7 +310,7 @@ static int __init setup_fail_futex(char *str)
 }
 __setup("fail_futex=", setup_fail_futex);
 
-static bool should_fail_futex(bool fshared)
+bool should_fail_futex(bool fshared)
 {
 	if (fail_futex.ignore_private && !fshared)
 		return false;
@@ -358,17 +339,8 @@ late_initcall(fail_futex_debugfs);
 
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
 
-#else
-static inline bool should_fail_futex(bool fshared)
-{
-	return false;
-}
 #endif /* CONFIG_FAIL_FUTEX */
 
-#ifdef CONFIG_COMPAT
-static void compat_exit_robust_list(struct task_struct *curr);
-#endif
-
 /*
  * Reflects a new waiter being added to the waitqueue.
  */
@@ -1647,8 +1619,7 @@ double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
 /*
  * Wake up waiters matching bitset queued on this futex (uaddr).
  */
-static int
-futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
@@ -1743,9 +1714,8 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int
-futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
-	      int nr_wake, int nr_wake2, int op)
+int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+		  int nr_wake, int nr_wake2, int op)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb1, *hb2;
@@ -2124,9 +2094,8 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
  *  - >=0 - on success, the number of tasks requeued or woken;
  *  -  <0 - on error
  */
-static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
-			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
-			 u32 *cmpval, int requeue_pi)
+int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+		  int nr_wake, int nr_requeue, u32 *cmpval, int requeue_pi)
 {
 	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
 	int task_count = 0, ret;
@@ -2926,8 +2895,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	return ret;
 }
 
-static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset)
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
@@ -3015,8 +2983,7 @@ static long futex_wait_restart(struct restart_block *restart)
  *
  * Also serves as futex trylock_pi()'ing, and due semantics.
  */
-static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
-			 ktime_t *time, int trylock)
+int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct task_struct *exiting = NULL;
@@ -3186,7 +3153,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
  * This is the in-kernel slowpath: we look up the PI state (if any),
  * and do the rt-mutex unlock.
  */
-static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
+int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
 	u32 curval, uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
@@ -3403,9 +3370,9 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
  *  -  0 - On success;
  *  - <0 - On error
  */
-static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
-				 u32 val, ktime_t *abs_time, u32 bitset,
-				 u32 __user *uaddr2)
+int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
+			  u32 val, ktime_t *abs_time, u32 bitset,
+			  u32 __user *uaddr2)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct rt_mutex_waiter rt_waiter;
@@ -3539,87 +3506,6 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	return ret;
 }
 
-/*
- * Support for robust futexes: the kernel cleans up held futexes at
- * thread exit time.
- *
- * Implementation: user-space maintains a per-thread list of locks it
- * is holding. Upon do_exit(), the kernel carefully walks this list,
- * and marks all locks that are owned by this thread with the
- * FUTEX_OWNER_DIED bit, and wakes up a waiter (if any). The list is
- * always manipulated with the lock held, so the list is private and
- * per-thread. Userspace also maintains a per-thread 'list_op_pending'
- * field, to allow the kernel to clean up if the thread dies after
- * acquiring the lock, but just before it could have added itself to
- * the list. There can only be one such pending lock.
- */
-
-/**
- * sys_set_robust_list() - Set the robust-futex list head of a task
- * @head:	pointer to the list-head
- * @len:	length of the list-head, as userspace expects
- */
-SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
-		size_t, len)
-{
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-	/*
-	 * The kernel knows only one size for now:
-	 */
-	if (unlikely(len != sizeof(*head)))
-		return -EINVAL;
-
-	current->robust_list = head;
-
-	return 0;
-}
-
-/**
- * sys_get_robust_list() - Get the robust-futex list head of a task
- * @pid:	pid of the process [zero for current task]
- * @head_ptr:	pointer to a list-head pointer, the kernel fills it in
- * @len_ptr:	pointer to a length field, the kernel fills in the header size
- */
-SYSCALL_DEFINE3(get_robust_list, int, pid,
-		struct robust_list_head __user * __user *, head_ptr,
-		size_t __user *, len_ptr)
-{
-	struct robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
-	rcu_read_lock();
-
-	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
-
-	head = p->robust_list;
-	rcu_read_unlock();
-
-	if (put_user(sizeof(*head), len_ptr))
-		return -EFAULT;
-	return put_user(head, head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 /* Constants for the pending_op argument of handle_futex_death */
 #define HANDLE_DEATH_PENDING	true
 #define HANDLE_DEATH_LIST	false
@@ -3821,227 +3707,16 @@ static void exit_robust_list(struct task_struct *curr)
 	}
 }
 
-static void futex_cleanup(struct task_struct *tsk)
-{
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
-		tsk->robust_list = NULL;
-	}
-
 #ifdef CONFIG_COMPAT
-	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
-		tsk->compat_robust_list = NULL;
-	}
-#endif
-
-	if (unlikely(!list_empty(&tsk->pi_state_list)))
-		exit_pi_state_list(tsk);
-}
-
-/**
- * futex_exit_recursive - Set the tasks futex state to FUTEX_STATE_DEAD
- * @tsk:	task to set the state on
- *
- * Set the futex exit state of the task lockless. The futex waiter code
- * observes that state when a task is exiting and loops until the task has
- * actually finished the futex cleanup. The worst case for this is that the
- * waiter runs through the wait loop until the state becomes visible.
- *
- * This is called from the recursive fault handling path in do_exit().
- *
- * This is best effort. Either the futex exit code has run already or
- * not. If the OWNER_DIED bit has been set on the futex then the waiter can
- * take it over. If not, the problem is pushed back to user space. If the
- * futex exit code did not run yet, then an already queued waiter might
- * block forever, but there is nothing which can be done about that.
- */
-void futex_exit_recursive(struct task_struct *tsk)
-{
-	/* If the state is FUTEX_STATE_EXITING then futex_exit_mutex is held */
-	if (tsk->futex_state == FUTEX_STATE_EXITING)
-		mutex_unlock(&tsk->futex_exit_mutex);
-	tsk->futex_state = FUTEX_STATE_DEAD;
-}
-
-static void futex_cleanup_begin(struct task_struct *tsk)
-{
-	/*
-	 * Prevent various race issues against a concurrent incoming waiter
-	 * including live locks by forcing the waiter to block on
-	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
-	 * attach_to_pi_owner().
-	 */
-	mutex_lock(&tsk->futex_exit_mutex);
-
-	/*
-	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
-	 *
-	 * This ensures that all subsequent checks of tsk->futex_state in
-	 * attach_to_pi_owner() must observe FUTEX_STATE_EXITING with
-	 * tsk->pi_lock held.
-	 *
-	 * It guarantees also that a pi_state which was queued right before
-	 * the state change under tsk->pi_lock by a concurrent waiter must
-	 * be observed in exit_pi_state_list().
-	 */
-	raw_spin_lock_irq(&tsk->pi_lock);
-	tsk->futex_state = FUTEX_STATE_EXITING;
-	raw_spin_unlock_irq(&tsk->pi_lock);
-}
-
-static void futex_cleanup_end(struct task_struct *tsk, int state)
-{
-	/*
-	 * Lockless store. The only side effect is that an observer might
-	 * take another loop until it becomes visible.
-	 */
-	tsk->futex_state = state;
-	/*
-	 * Drop the exit protection. This unblocks waiters which observed
-	 * FUTEX_STATE_EXITING to reevaluate the state.
-	 */
-	mutex_unlock(&tsk->futex_exit_mutex);
-}
-
-void futex_exec_release(struct task_struct *tsk)
-{
-	/*
-	 * The state handling is done for consistency, but in the case of
-	 * exec() there is no way to prevent further damage as the PID stays
-	 * the same. But for the unlikely and arguably buggy case that a
-	 * futex is held on exec(), this provides at least as much state
-	 * consistency protection which is possible.
-	 */
-	futex_cleanup_begin(tsk);
-	futex_cleanup(tsk);
-	/*
-	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
-	 * exec a new binary.
-	 */
-	futex_cleanup_end(tsk, FUTEX_STATE_OK);
-}
-
-void futex_exit_release(struct task_struct *tsk)
-{
-	futex_cleanup_begin(tsk);
-	futex_cleanup(tsk);
-	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
-}
-
-long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
-		u32 __user *uaddr2, u32 val2, u32 val3)
-{
-	int cmd = op & FUTEX_CMD_MASK;
-	unsigned int flags = 0;
-
-	if (!(op & FUTEX_PRIVATE_FLAG))
-		flags |= FLAGS_SHARED;
-
-	if (op & FUTEX_CLOCK_REALTIME) {
-		flags |= FLAGS_CLOCKRT;
-		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
-		    cmd != FUTEX_LOCK_PI2)
-			return -ENOSYS;
-	}
-
-	switch (cmd) {
-	case FUTEX_LOCK_PI:
-	case FUTEX_LOCK_PI2:
-	case FUTEX_UNLOCK_PI:
-	case FUTEX_TRYLOCK_PI:
-	case FUTEX_WAIT_REQUEUE_PI:
-	case FUTEX_CMP_REQUEUE_PI:
-		if (!futex_cmpxchg_enabled)
-			return -ENOSYS;
-	}
-
-	switch (cmd) {
-	case FUTEX_WAIT:
-		val3 = FUTEX_BITSET_MATCH_ANY;
-		fallthrough;
-	case FUTEX_WAIT_BITSET:
-		return futex_wait(uaddr, flags, val, timeout, val3);
-	case FUTEX_WAKE:
-		val3 = FUTEX_BITSET_MATCH_ANY;
-		fallthrough;
-	case FUTEX_WAKE_BITSET:
-		return futex_wake(uaddr, flags, val, val3);
-	case FUTEX_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, NULL, 0);
-	case FUTEX_CMP_REQUEUE:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 0);
-	case FUTEX_WAKE_OP:
-		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
-	case FUTEX_LOCK_PI:
-		flags |= FLAGS_CLOCKRT;
-		fallthrough;
-	case FUTEX_LOCK_PI2:
-		return futex_lock_pi(uaddr, flags, timeout, 0);
-	case FUTEX_UNLOCK_PI:
-		return futex_unlock_pi(uaddr, flags);
-	case FUTEX_TRYLOCK_PI:
-		return futex_lock_pi(uaddr, flags, NULL, 1);
-	case FUTEX_WAIT_REQUEUE_PI:
-		val3 = FUTEX_BITSET_MATCH_ANY;
-		return futex_wait_requeue_pi(uaddr, flags, val, timeout, val3,
-					     uaddr2);
-	case FUTEX_CMP_REQUEUE_PI:
-		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
-	}
-	return -ENOSYS;
-}
-
-static __always_inline bool futex_cmd_has_timeout(u32 cmd)
-{
-	switch (cmd) {
-	case FUTEX_WAIT:
-	case FUTEX_LOCK_PI:
-	case FUTEX_LOCK_PI2:
-	case FUTEX_WAIT_BITSET:
-	case FUTEX_WAIT_REQUEUE_PI:
-		return true;
-	}
-	return false;
-}
-
-static __always_inline int
-futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
-{
-	if (!timespec64_valid(ts))
-		return -EINVAL;
-
-	*t = timespec64_to_ktime(*ts);
-	if (cmd == FUTEX_WAIT)
-		*t = ktime_add_safe(ktime_get(), *t);
-	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
-		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
-	return 0;
-}
-
-SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
-		const struct __kernel_timespec __user *, utime,
-		u32 __user *, uaddr2, u32, val3)
+static void __user *futex_uaddr(struct robust_list __user *entry,
+				compat_long_t futex_offset)
 {
-	int ret, cmd = op & FUTEX_CMD_MASK;
-	ktime_t t, *tp = NULL;
-	struct timespec64 ts;
-
-	if (utime && futex_cmd_has_timeout(cmd)) {
-		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
-			return -EFAULT;
-		if (get_timespec64(&ts, utime))
-			return -EFAULT;
-		ret = futex_init_timeout(cmd, op, &ts, &t);
-		if (ret)
-			return ret;
-		tp = &t;
-	}
+	compat_uptr_t base = ptr_to_compat(entry);
+	void __user *uaddr = compat_ptr(base + futex_offset);
 
-	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
+	return uaddr;
 }
 
-#ifdef CONFIG_COMPAT
 /*
  * Fetch a robust-list pointer. Bit 0 signals PI futexes:
  */
@@ -4058,15 +3733,6 @@ compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **ent
 	return 0;
 }
 
-static void __user *futex_uaddr(struct robust_list __user *entry,
-				compat_long_t futex_offset)
-{
-	compat_uptr_t base = ptr_to_compat(entry);
-	void __user *uaddr = compat_ptr(base + futex_offset);
-
-	return uaddr;
-}
-
 /*
  * Walk curr->robust_list (very carefully, it's a userspace list!)
  * and mark any locks found there dead, and notify any waiters.
@@ -4143,83 +3809,115 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
+#endif
 
-COMPAT_SYSCALL_DEFINE2(set_robust_list,
-		struct compat_robust_list_head __user *, head,
-		compat_size_t, len)
+static void futex_cleanup(struct task_struct *tsk)
 {
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
-	if (unlikely(len != sizeof(*head)))
-		return -EINVAL;
+	if (unlikely(tsk->robust_list)) {
+		exit_robust_list(tsk);
+		tsk->robust_list = NULL;
+	}
 
-	current->compat_robust_list = head;
+#ifdef CONFIG_COMPAT
+	if (unlikely(tsk->compat_robust_list)) {
+		compat_exit_robust_list(tsk);
+		tsk->compat_robust_list = NULL;
+	}
+#endif
 
-	return 0;
+	if (unlikely(!list_empty(&tsk->pi_state_list)))
+		exit_pi_state_list(tsk);
 }
 
-COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
-			compat_uptr_t __user *, head_ptr,
-			compat_size_t __user *, len_ptr)
+/**
+ * futex_exit_recursive - Set the tasks futex state to FUTEX_STATE_DEAD
+ * @tsk:	task to set the state on
+ *
+ * Set the futex exit state of the task lockless. The futex waiter code
+ * observes that state when a task is exiting and loops until the task has
+ * actually finished the futex cleanup. The worst case for this is that the
+ * waiter runs through the wait loop until the state becomes visible.
+ *
+ * This is called from the recursive fault handling path in do_exit().
+ *
+ * This is best effort. Either the futex exit code has run already or
+ * not. If the OWNER_DIED bit has been set on the futex then the waiter can
+ * take it over. If not, the problem is pushed back to user space. If the
+ * futex exit code did not run yet, then an already queued waiter might
+ * block forever, but there is nothing which can be done about that.
+ */
+void futex_exit_recursive(struct task_struct *tsk)
 {
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	if (!futex_cmpxchg_enabled)
-		return -ENOSYS;
-
-	rcu_read_lock();
-
-	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret = -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
-
-	head = p->compat_robust_list;
-	rcu_read_unlock();
-
-	if (put_user(sizeof(*head), len_ptr))
-		return -EFAULT;
-	return put_user(ptr_to_compat(head), head_ptr);
+	/* If the state is FUTEX_STATE_EXITING then futex_exit_mutex is held */
+	if (tsk->futex_state == FUTEX_STATE_EXITING)
+		mutex_unlock(&tsk->futex_exit_mutex);
+	tsk->futex_state = FUTEX_STATE_DEAD;
+}
 
-err_unlock:
-	rcu_read_unlock();
+static void futex_cleanup_begin(struct task_struct *tsk)
+{
+	/*
+	 * Prevent various race issues against a concurrent incoming waiter
+	 * including live locks by forcing the waiter to block on
+	 * tsk->futex_exit_mutex when it observes FUTEX_STATE_EXITING in
+	 * attach_to_pi_owner().
+	 */
+	mutex_lock(&tsk->futex_exit_mutex);
 
-	return ret;
+	/*
+	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
+	 *
+	 * This ensures that all subsequent checks of tsk->futex_state in
+	 * attach_to_pi_owner() must observe FUTEX_STATE_EXITING with
+	 * tsk->pi_lock held.
+	 *
+	 * It guarantees also that a pi_state which was queued right before
+	 * the state change under tsk->pi_lock by a concurrent waiter must
+	 * be observed in exit_pi_state_list().
+	 */
+	raw_spin_lock_irq(&tsk->pi_lock);
+	tsk->futex_state = FUTEX_STATE_EXITING;
+	raw_spin_unlock_irq(&tsk->pi_lock);
 }
-#endif /* CONFIG_COMPAT */
 
-#ifdef CONFIG_COMPAT_32BIT_TIME
-SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
-		const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
-		u32, val3)
+static void futex_cleanup_end(struct task_struct *tsk, int state)
 {
-	int ret, cmd = op & FUTEX_CMD_MASK;
-	ktime_t t, *tp = NULL;
-	struct timespec64 ts;
+	/*
+	 * Lockless store. The only side effect is that an observer might
+	 * take another loop until it becomes visible.
+	 */
+	tsk->futex_state = state;
+	/*
+	 * Drop the exit protection. This unblocks waiters which observed
+	 * FUTEX_STATE_EXITING to reevaluate the state.
+	 */
+	mutex_unlock(&tsk->futex_exit_mutex);
+}
 
-	if (utime && futex_cmd_has_timeout(cmd)) {
-		if (get_old_timespec32(&ts, utime))
-			return -EFAULT;
-		ret = futex_init_timeout(cmd, op, &ts, &t);
-		if (ret)
-			return ret;
-		tp = &t;
-	}
+void futex_exec_release(struct task_struct *tsk)
+{
+	/*
+	 * The state handling is done for consistency, but in the case of
+	 * exec() there is no way to prevent further damage as the PID stays
+	 * the same. But for the unlikely and arguably buggy case that a
+	 * futex is held on exec(), this provides at least as much state
+	 * consistency protection which is possible.
+	 */
+	futex_cleanup_begin(tsk);
+	futex_cleanup(tsk);
+	/*
+	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
+	 * exec a new binary.
+	 */
+	futex_cleanup_end(tsk, FUTEX_STATE_OK);
+}
 
-	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
+void futex_exit_release(struct task_struct *tsk)
+{
+	futex_cleanup_begin(tsk);
+	futex_cleanup(tsk);
+	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
-#endif /* CONFIG_COMPAT_32BIT_TIME */
 
 static void __init futex_detect_cmpxchg(void)
 {
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
new file mode 100644
index 000000000000..7bb4ca8bf32f
--- /dev/null
+++ b/kernel/futex/futex.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FUTEX_H
+#define _FUTEX_H
+
+#include <asm/futex.h>
+
+/*
+ * Futex flags used to encode options to functions and preserve them across
+ * restarts.
+ */
+#ifdef CONFIG_MMU
+# define FLAGS_SHARED		0x01
+#else
+/*
+ * NOMMU does not have per process address space. Let the compiler optimize
+ * code away.
+ */
+# define FLAGS_SHARED		0x00
+#endif
+#define FLAGS_CLOCKRT		0x02
+#define FLAGS_HAS_TIMEOUT	0x04
+
+#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
+#define futex_cmpxchg_enabled 1
+#else
+extern int  __read_mostly futex_cmpxchg_enabled;
+#endif
+
+#ifdef CONFIG_FAIL_FUTEX
+extern bool should_fail_futex(bool fshared);
+#else
+static inline bool should_fail_futex(bool fshared)
+{
+	return false;
+}
+#endif
+
+extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags, u32
+				 val, ktime_t *abs_time, u32 bitset, u32 __user
+				 *uaddr2);
+
+extern int futex_requeue(u32 __user *uaddr1, unsigned int flags,
+			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
+			 u32 *cmpval, int requeue_pi);
+
+extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+		      ktime_t *abs_time, u32 bitset);
+
+extern int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset);
+
+extern int futex_wake_op(u32 __user *uaddr1, unsigned int flags,
+			 u32 __user *uaddr2, int nr_wake, int nr_wake2, int op);
+
+extern int futex_unlock_pi(u32 __user *uaddr, unsigned int flags);
+
+extern int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock);
+
+#endif /* _FUTEX_H */
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
new file mode 100644
index 000000000000..6e7e36c640a1
--- /dev/null
+++ b/kernel/futex/syscalls.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/compat.h>
+#include <linux/syscalls.h>
+#include <linux/time_namespace.h>
+
+#include "futex.h"
+
+/*
+ * Support for robust futexes: the kernel cleans up held futexes at
+ * thread exit time.
+ *
+ * Implementation: user-space maintains a per-thread list of locks it
+ * is holding. Upon do_exit(), the kernel carefully walks this list,
+ * and marks all locks that are owned by this thread with the
+ * FUTEX_OWNER_DIED bit, and wakes up a waiter (if any). The list is
+ * always manipulated with the lock held, so the list is private and
+ * per-thread. Userspace also maintains a per-thread 'list_op_pending'
+ * field, to allow the kernel to clean up if the thread dies after
+ * acquiring the lock, but just before it could have added itself to
+ * the list. There can only be one such pending lock.
+ */
+
+/**
+ * sys_set_robust_list() - Set the robust-futex list head of a task
+ * @head:	pointer to the list-head
+ * @len:	length of the list-head, as userspace expects
+ */
+SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
+		size_t, len)
+{
+	if (!futex_cmpxchg_enabled)
+		return -ENOSYS;
+	/*
+	 * The kernel knows only one size for now:
+	 */
+	if (unlikely(len != sizeof(*head)))
+		return -EINVAL;
+
+	current->robust_list = head;
+
+	return 0;
+}
+
+/**
+ * sys_get_robust_list() - Get the robust-futex list head of a task
+ * @pid:	pid of the process [zero for current task]
+ * @head_ptr:	pointer to a list-head pointer, the kernel fills it in
+ * @len_ptr:	pointer to a length field, the kernel fills in the header size
+ */
+SYSCALL_DEFINE3(get_robust_list, int, pid,
+		struct robust_list_head __user * __user *, head_ptr,
+		size_t __user *, len_ptr)
+{
+	struct robust_list_head __user *head;
+	unsigned long ret;
+	struct task_struct *p;
+
+	if (!futex_cmpxchg_enabled)
+		return -ENOSYS;
+
+	rcu_read_lock();
+
+	ret = -ESRCH;
+	if (!pid)
+		p = current;
+	else {
+		p = find_task_by_vpid(pid);
+		if (!p)
+			goto err_unlock;
+	}
+
+	ret = -EPERM;
+	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		goto err_unlock;
+
+	head = p->robust_list;
+	rcu_read_unlock();
+
+	if (put_user(sizeof(*head), len_ptr))
+		return -EFAULT;
+	return put_user(head, head_ptr);
+
+err_unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
+		u32 __user *uaddr2, u32 val2, u32 val3)
+{
+	int cmd = op & FUTEX_CMD_MASK;
+	unsigned int flags = 0;
+
+	if (!(op & FUTEX_PRIVATE_FLAG))
+		flags |= FLAGS_SHARED;
+
+	if (op & FUTEX_CLOCK_REALTIME) {
+		flags |= FLAGS_CLOCKRT;
+		if (cmd != FUTEX_WAIT_BITSET && cmd != FUTEX_WAIT_REQUEUE_PI &&
+		    cmd != FUTEX_LOCK_PI2)
+			return -ENOSYS;
+	}
+
+	switch (cmd) {
+	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
+	case FUTEX_UNLOCK_PI:
+	case FUTEX_TRYLOCK_PI:
+	case FUTEX_WAIT_REQUEUE_PI:
+	case FUTEX_CMP_REQUEUE_PI:
+		if (!futex_cmpxchg_enabled)
+			return -ENOSYS;
+	}
+
+	switch (cmd) {
+	case FUTEX_WAIT:
+		val3 = FUTEX_BITSET_MATCH_ANY;
+		fallthrough;
+	case FUTEX_WAIT_BITSET:
+		return futex_wait(uaddr, flags, val, timeout, val3);
+	case FUTEX_WAKE:
+		val3 = FUTEX_BITSET_MATCH_ANY;
+		fallthrough;
+	case FUTEX_WAKE_BITSET:
+		return futex_wake(uaddr, flags, val, val3);
+	case FUTEX_REQUEUE:
+		return futex_requeue(uaddr, flags, uaddr2, val, val2, NULL, 0);
+	case FUTEX_CMP_REQUEUE:
+		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 0);
+	case FUTEX_WAKE_OP:
+		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
+	case FUTEX_LOCK_PI:
+		flags |= FLAGS_CLOCKRT;
+		fallthrough;
+	case FUTEX_LOCK_PI2:
+		return futex_lock_pi(uaddr, flags, timeout, 0);
+	case FUTEX_UNLOCK_PI:
+		return futex_unlock_pi(uaddr, flags);
+	case FUTEX_TRYLOCK_PI:
+		return futex_lock_pi(uaddr, flags, NULL, 1);
+	case FUTEX_WAIT_REQUEUE_PI:
+		val3 = FUTEX_BITSET_MATCH_ANY;
+		return futex_wait_requeue_pi(uaddr, flags, val, timeout, val3,
+					     uaddr2);
+	case FUTEX_CMP_REQUEUE_PI:
+		return futex_requeue(uaddr, flags, uaddr2, val, val2, &val3, 1);
+	}
+	return -ENOSYS;
+}
+
+static __always_inline bool futex_cmd_has_timeout(u32 cmd)
+{
+	switch (cmd) {
+	case FUTEX_WAIT:
+	case FUTEX_LOCK_PI:
+	case FUTEX_LOCK_PI2:
+	case FUTEX_WAIT_BITSET:
+	case FUTEX_WAIT_REQUEUE_PI:
+		return true;
+	}
+	return false;
+}
+
+static __always_inline int
+futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
+{
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+
+	*t = timespec64_to_ktime(*ts);
+	if (cmd == FUTEX_WAIT)
+		*t = ktime_add_safe(ktime_get(), *t);
+	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
+		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
+	return 0;
+}
+
+SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
+		const struct __kernel_timespec __user *, utime,
+		u32 __user *, uaddr2, u32, val3)
+{
+	int ret, cmd = op & FUTEX_CMD_MASK;
+	ktime_t t, *tp = NULL;
+	struct timespec64 ts;
+
+	if (utime && futex_cmd_has_timeout(cmd)) {
+		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
+			return -EFAULT;
+		if (get_timespec64(&ts, utime))
+			return -EFAULT;
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
+		tp = &t;
+	}
+
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE2(set_robust_list,
+		struct compat_robust_list_head __user *, head,
+		compat_size_t, len)
+{
+	if (!futex_cmpxchg_enabled)
+		return -ENOSYS;
+
+	if (unlikely(len != sizeof(*head)))
+		return -EINVAL;
+
+	current->compat_robust_list = head;
+
+	return 0;
+}
+
+COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
+			compat_uptr_t __user *, head_ptr,
+			compat_size_t __user *, len_ptr)
+{
+	struct compat_robust_list_head __user *head;
+	unsigned long ret;
+	struct task_struct *p;
+
+	if (!futex_cmpxchg_enabled)
+		return -ENOSYS;
+
+	rcu_read_lock();
+
+	ret = -ESRCH;
+	if (!pid)
+		p = current;
+	else {
+		p = find_task_by_vpid(pid);
+		if (!p)
+			goto err_unlock;
+	}
+
+	ret = -EPERM;
+	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		goto err_unlock;
+
+	head = p->compat_robust_list;
+	rcu_read_unlock();
+
+	if (put_user(sizeof(*head), len_ptr))
+		return -EFAULT;
+	return put_user(ptr_to_compat(head), head_ptr);
+
+err_unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+#endif /* CONFIG_COMPAT */
+
+#ifdef CONFIG_COMPAT_32BIT_TIME
+SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
+		const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
+		u32, val3)
+{
+	int ret, cmd = op & FUTEX_CMD_MASK;
+	ktime_t t, *tp = NULL;
+	struct timespec64 ts;
+
+	if (utime && futex_cmd_has_timeout(cmd)) {
+		if (get_old_timespec32(&ts, utime))
+			return -EFAULT;
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
+		tp = &t;
+	}
+
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
+}
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f43d89d92860..13ee8334ab6e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -143,7 +143,7 @@ COND_SYSCALL(capset);
 /* __ARCH_WANT_SYS_CLONE3 */
 COND_SYSCALL(clone3);
 
-/* kernel/futex.c */
+/* kernel/futex/syscalls.c */
 COND_SYSCALL(futex);
 COND_SYSCALL(futex_time32);
 COND_SYSCALL(set_robust_list);
-- 
2.33.0

