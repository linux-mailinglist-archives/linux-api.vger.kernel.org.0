Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61B040C754
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhIOOVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbhIOOVc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC0C0613D9;
        Wed, 15 Sep 2021 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CYuAFT8mdu+fBA//q4jUyunI56pRzWYJ1Dfc/pkfHjY=; b=b/WIAPGPjTG7S9G8Uruu3cWNf0
        utcevgYn1lVLptVI3wlEZAWDxhxENjDz1JZ08ibVoIpik5xWiUp40Cu+z/bVRfAjEbkjVek9EerdH
        nuMDkeW7EkblGE53a35qmBr4jGilLTj1IjuLIjtZbhhSRO6lVx8rOsZP6Zs+bBT5x9p8kb1dXdze2
        TwjN7ONC2XqkaM3nHOFsXFDdxihGfvIqAw4qVv9u1+LGV3OVsHhf+b0TD9O83ls5wAj5in/vRmxgD
        dNEkVBfsRRGJ5546pk72YfBTZDG8ebqOBivsYrpnHEZMfntTYJaHsreVFCfMKvemTYSVkX72eIuyD
        IEhxRY9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj8-00Fk3i-Jc; Wed, 15 Sep 2021 14:17:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27F0630058F;
        Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E231E210771D2; Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Message-ID: <20210915141524.741141552@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 02/20] futex: Split out syscalls
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Put the syscalls in their own little file.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/Makefile   |    2 
 kernel/futex/core.c     |  532 ++++++++++--------------------------------------
 kernel/futex/futex.h    |   58 +++++
 kernel/futex/syscalls.c |  279 +++++++++++++++++++++++++
 4 files changed, 453 insertions(+), 418 deletions(-)

--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o
+obj-y += core.o syscalls.o
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
@@ -329,7 +310,7 @@ static int __init setup_fail_futex(char
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
@@ -1647,8 +1619,7 @@ double_unlock_hb(struct futex_hash_bucke
 /*
  * Wake up waiters matching bitset queued on this futex (uaddr).
  */
-static int
-futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
@@ -1743,9 +1714,8 @@ static int futex_atomic_op_inuser(unsign
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
@@ -2124,9 +2094,8 @@ futex_proxy_trylock_atomic(u32 __user *p
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
@@ -2926,8 +2895,7 @@ static int futex_wait_setup(u32 __user *
 	return ret;
 }
 
-static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset)
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
@@ -3015,8 +2983,7 @@ static long futex_wait_restart(struct re
  *
  * Also serves as futex trylock_pi()'ing, and due semantics.
  */
-static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
-			 ktime_t *time, int trylock)
+int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct task_struct *exiting = NULL;
@@ -3186,7 +3153,7 @@ static int futex_lock_pi(u32 __user *uad
  * This is the in-kernel slowpath: we look up the PI state (if any),
  * and do the rt-mutex unlock.
  */
-static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
+int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
 	u32 curval, uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
@@ -3403,9 +3370,9 @@ int handle_early_requeue_pi_wakeup(struc
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
@@ -3539,87 +3506,6 @@ static int futex_wait_requeue_pi(u32 __u
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
@@ -3821,227 +3707,16 @@ static void exit_robust_list(struct task
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
@@ -4058,15 +3733,6 @@ compat_fetch_robust_entry(compat_uptr_t
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
@@ -4143,83 +3809,115 @@ static void compat_exit_robust_list(stru
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


