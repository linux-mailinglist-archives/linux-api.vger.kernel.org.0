Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB241640F
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbhIWROF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242574AbhIWROB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:14:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA2C06175F;
        Thu, 23 Sep 2021 10:12:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7EC491F4460A
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
Subject: [PATCH v2 14/22] futex: Split out wait/wake
Date:   Thu, 23 Sep 2021 14:11:03 -0300
Message-Id: <20210923171111.300673-15-andrealmeid@collabora.com>
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

Move the wait/wake bits into their own file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/Makefile   |   2 +-
 kernel/futex/core.c     | 536 +---------------------------------------
 kernel/futex/futex.h    |  34 +++
 kernel/futex/waitwake.c | 507 +++++++++++++++++++++++++++++++++++++
 4 files changed, 543 insertions(+), 536 deletions(-)
 create mode 100644 kernel/futex/waitwake.c

diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
index c0409419fe8d..b77188d1fa07 100644
--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o syscalls.o pi.o requeue.o
+obj-y += core.o syscalls.o pi.o requeue.o waitwake.o
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 42f2735e9abf..25d8a88b32e5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -34,7 +34,6 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
-#include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
@@ -42,106 +41,6 @@
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
 
-/*
- * READ this before attempting to hack on futexes!
- *
- * Basic futex operation and ordering guarantees
- * =============================================
- *
- * The waiter reads the futex value in user space and calls
- * futex_wait(). This function computes the hash bucket and acquires
- * the hash bucket lock. After that it reads the futex user space value
- * again and verifies that the data has not changed. If it has not changed
- * it enqueues itself into the hash bucket, releases the hash bucket lock
- * and schedules.
- *
- * The waker side modifies the user space value of the futex and calls
- * futex_wake(). This function computes the hash bucket and acquires the
- * hash bucket lock. Then it looks for waiters on that futex in the hash
- * bucket and wakes them.
- *
- * In futex wake up scenarios where no tasks are blocked on a futex, taking
- * the hb spinlock can be avoided and simply return. In order for this
- * optimization to work, ordering guarantees must exist so that the waiter
- * being added to the list is acknowledged when the list is concurrently being
- * checked by the waker, avoiding scenarios like the following:
- *
- * CPU 0                               CPU 1
- * val = *futex;
- * sys_futex(WAIT, futex, val);
- *   futex_wait(futex, val);
- *   uval = *futex;
- *                                     *futex = newval;
- *                                     sys_futex(WAKE, futex);
- *                                       futex_wake(futex);
- *                                       if (queue_empty())
- *                                         return;
- *   if (uval == val)
- *      lock(hash_bucket(futex));
- *      queue();
- *     unlock(hash_bucket(futex));
- *     schedule();
- *
- * This would cause the waiter on CPU 0 to wait forever because it
- * missed the transition of the user space value from val to newval
- * and the waker did not find the waiter in the hash bucket queue.
- *
- * The correct serialization ensures that a waiter either observes
- * the changed user space value before blocking or is woken by a
- * concurrent waker:
- *
- * CPU 0                                 CPU 1
- * val = *futex;
- * sys_futex(WAIT, futex, val);
- *   futex_wait(futex, val);
- *
- *   waiters++; (a)
- *   smp_mb(); (A) <-- paired with -.
- *                                  |
- *   lock(hash_bucket(futex));      |
- *                                  |
- *   uval = *futex;                 |
- *                                  |        *futex = newval;
- *                                  |        sys_futex(WAKE, futex);
- *                                  |          futex_wake(futex);
- *                                  |
- *                                  `--------> smp_mb(); (B)
- *   if (uval == val)
- *     queue();
- *     unlock(hash_bucket(futex));
- *     schedule();                         if (waiters)
- *                                           lock(hash_bucket(futex));
- *   else                                    wake_waiters(futex);
- *     waiters--; (b)                        unlock(hash_bucket(futex));
- *
- * Where (A) orders the waiters increment and the futex value read through
- * atomic operations (see futex_hb_waiters_inc) and where (B) orders the write
- * to futex and the waiters read (see futex_hb_waiters_pending()).
- *
- * This yields the following case (where X:=waiters, Y:=futex):
- *
- *	X = Y = 0
- *
- *	w[X]=1		w[Y]=1
- *	MB		MB
- *	r[Y]=y		r[X]=x
- *
- * Which guarantees that x==0 && y==0 is impossible; which translates back into
- * the guarantee that we cannot both miss the futex variable change and the
- * enqueue.
- *
- * Note that a new waiter is accounted for in (a) even when it is possible that
- * the wait call can return error, in which case we backtrack from it in (b).
- * Refer to the comment in futex_q_lock().
- *
- * Similarly, in order to account for waiters being requeued on another
- * address we always increment the waiters for the destination bucket before
- * acquiring the lock. It then decrements them again  after releasing it -
- * the code that actually moves the futex(es) between hash buckets (requeue_futex)
- * will do the additional required waiter count housekeeping. This is done for
- * double_lock_hb() and double_unlock_hb(), respectively.
- */
-
 #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
 int  __read_mostly futex_cmpxchg_enabled;
 #endif
@@ -211,19 +110,6 @@ late_initcall(fail_futex_debugfs);
 
 #endif /* CONFIG_FAIL_FUTEX */
 
-static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
-{
-#ifdef CONFIG_SMP
-	/*
-	 * Full barrier (B), see the ordering comment above.
-	 */
-	smp_mb();
-	return atomic_read(&hb->waiters);
-#else
-	return 1;
-#endif
-}
-
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -628,217 +514,6 @@ void __futex_unqueue(struct futex_q *q)
 	futex_hb_waiters_dec(hb);
 }
 
-/*
- * The hash bucket lock must be held when this is called.
- * Afterwards, the futex_q must not be accessed. Callers
- * must ensure to later call wake_up_q() for the actual
- * wakeups to occur.
- */
-void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
-{
-	struct task_struct *p = q->task;
-
-	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
-		return;
-
-	get_task_struct(p);
-	__futex_unqueue(q);
-	/*
-	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
-	 * is written, without taking any locks. This is possible in the event
-	 * of a spurious wakeup, for example. A memory barrier is required here
-	 * to prevent the following store to lock_ptr from getting ahead of the
-	 * plist_del in __futex_unqueue().
-	 */
-	smp_store_release(&q->lock_ptr, NULL);
-
-	/*
-	 * Queue the task for later wakeup for after we've released
-	 * the hb->lock.
-	 */
-	wake_q_add_safe(wake_q, p);
-}
-
-/*
- * Wake up waiters matching bitset queued on this futex (uaddr).
- */
-int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
-{
-	struct futex_hash_bucket *hb;
-	struct futex_q *this, *next;
-	union futex_key key = FUTEX_KEY_INIT;
-	int ret;
-	DEFINE_WAKE_Q(wake_q);
-
-	if (!bitset)
-		return -EINVAL;
-
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
-	if (unlikely(ret != 0))
-		return ret;
-
-	hb = futex_hash(&key);
-
-	/* Make sure we really have tasks to wakeup */
-	if (!futex_hb_waiters_pending(hb))
-		return ret;
-
-	spin_lock(&hb->lock);
-
-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (futex_match (&this->key, &key)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret = -EINVAL;
-				break;
-			}
-
-			/* Check if one of the bits is set in both bitsets */
-			if (!(this->bitset & bitset))
-				continue;
-
-			futex_wake_mark(&wake_q, this);
-			if (++ret >= nr_wake)
-				break;
-		}
-	}
-
-	spin_unlock(&hb->lock);
-	wake_up_q(&wake_q);
-	return ret;
-}
-
-static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
-{
-	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
-	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
-	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 11);
-	int cmparg = sign_extend32(encoded_op & 0x00000fff, 11);
-	int oldval, ret;
-
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
-		if (oparg < 0 || oparg > 31) {
-			char comm[sizeof(current->comm)];
-			/*
-			 * kill this print and return -EINVAL when userspace
-			 * is sane again
-			 */
-			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this program\n",
-					get_task_comm(comm, current), oparg);
-			oparg &= 31;
-		}
-		oparg = 1 << oparg;
-	}
-
-	pagefault_disable();
-	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
-	pagefault_enable();
-	if (ret)
-		return ret;
-
-	switch (cmp) {
-	case FUTEX_OP_CMP_EQ:
-		return oldval == cmparg;
-	case FUTEX_OP_CMP_NE:
-		return oldval != cmparg;
-	case FUTEX_OP_CMP_LT:
-		return oldval < cmparg;
-	case FUTEX_OP_CMP_GE:
-		return oldval >= cmparg;
-	case FUTEX_OP_CMP_LE:
-		return oldval <= cmparg;
-	case FUTEX_OP_CMP_GT:
-		return oldval > cmparg;
-	default:
-		return -ENOSYS;
-	}
-}
-
-/*
- * Wake up all waiters hashed on the physical page that is mapped
- * to this virtual address:
- */
-int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
-		  int nr_wake, int nr_wake2, int op)
-{
-	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb1, *hb2;
-	struct futex_q *this, *next;
-	int ret, op_ret;
-	DEFINE_WAKE_Q(wake_q);
-
-retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
-	if (unlikely(ret != 0))
-		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
-	if (unlikely(ret != 0))
-		return ret;
-
-	hb1 = futex_hash(&key1);
-	hb2 = futex_hash(&key2);
-
-retry_private:
-	double_lock_hb(hb1, hb2);
-	op_ret = futex_atomic_op_inuser(op, uaddr2);
-	if (unlikely(op_ret < 0)) {
-		double_unlock_hb(hb1, hb2);
-
-		if (!IS_ENABLED(CONFIG_MMU) ||
-		    unlikely(op_ret != -EFAULT && op_ret != -EAGAIN)) {
-			/*
-			 * we don't get EFAULT from MMU faults if we don't have
-			 * an MMU, but we might get them from range checking
-			 */
-			ret = op_ret;
-			return ret;
-		}
-
-		if (op_ret == -EFAULT) {
-			ret = fault_in_user_writeable(uaddr2);
-			if (ret)
-				return ret;
-		}
-
-		cond_resched();
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-		goto retry;
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (futex_match (&this->key, &key1)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret = -EINVAL;
-				goto out_unlock;
-			}
-			futex_wake_mark(&wake_q, this);
-			if (++ret >= nr_wake)
-				break;
-		}
-	}
-
-	if (op_ret > 0) {
-		op_ret = 0;
-		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (futex_match (&this->key, &key2)) {
-				if (this->pi_state || this->rt_waiter) {
-					ret = -EINVAL;
-					goto out_unlock;
-				}
-				futex_wake_mark(&wake_q, this);
-				if (++op_ret >= nr_wake2)
-					break;
-			}
-		}
-		ret += op_ret;
-	}
-
-out_unlock:
-	double_unlock_hb(hb1, hb2);
-	wake_up_q(&wake_q);
-	return ret;
-}
-
 /* The key must be already stored in q->key. */
 struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
@@ -889,25 +564,6 @@ void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
 	q->task = current;
 }
 
-/**
- * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
- * @q:	The futex_q to enqueue
- * @hb:	The destination hash bucket
- *
- * The hb->lock must be held by the caller, and is released here. A call to
- * futex_queue() is typically paired with exactly one call to futex_unqueue().  The
- * exceptions involve the PI related operations, which may use futex_unqueue_pi()
- * or nothing if the unqueue is done as part of the wake process and the unqueue
- * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
- * an example).
- */
-static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
-	__releases(&hb->lock)
-{
-	__futex_queue(q, hb);
-	spin_unlock(&hb->lock);
-}
-
 /**
  * futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
@@ -919,7 +575,7 @@ static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
  *  - 1 - if the futex_q was still queued (and we removed unqueued it);
  *  - 0 - if the futex_q was already removed by the waking thread
  */
-static int futex_unqueue(struct futex_q *q)
+int futex_unqueue(struct futex_q *q)
 {
 	spinlock_t *lock_ptr;
 	int ret = 0;
@@ -975,196 +631,6 @@ void futex_unqueue_pi(struct futex_q *q)
 	q->pi_state = NULL;
 }
 
-static long futex_wait_restart(struct restart_block *restart);
-
-/**
- * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
- * @hb:		the futex hash bucket, must be locked by the caller
- * @q:		the futex_q to queue up on
- * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
- */
-void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
-			    struct hrtimer_sleeper *timeout)
-{
-	/*
-	 * The task state is guaranteed to be set before another task can
-	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
-	 * access to the hash list and forcing another memory barrier.
-	 */
-	set_current_state(TASK_INTERRUPTIBLE);
-	futex_queue(q, hb);
-
-	/* Arm the timer */
-	if (timeout)
-		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
-
-	/*
-	 * If we have been removed from the hash list, then another task
-	 * has tried to wake us, and we can skip the call to schedule().
-	 */
-	if (likely(!plist_node_empty(&q->list))) {
-		/*
-		 * If the timer has already expired, current will already be
-		 * flagged for rescheduling. Only call schedule if there
-		 * is no timeout, or if it has yet to expire.
-		 */
-		if (!timeout || timeout->task)
-			freezable_schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-}
-
-/**
- * futex_wait_setup() - Prepare to wait on a futex
- * @uaddr:	the futex userspace address
- * @val:	the expected value
- * @flags:	futex flags (FLAGS_SHARED, etc.)
- * @q:		the associated futex_q
- * @hb:		storage for hash_bucket pointer to be returned to caller
- *
- * Setup the futex_q and locate the hash_bucket.  Get the futex value and
- * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held on success, and unlocked on failure.
- *
- * Return:
- *  -  0 - uaddr contains val and hb has been locked;
- *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is unlocked
- */
-int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-		     struct futex_q *q, struct futex_hash_bucket **hb)
-{
-	u32 uval;
-	int ret;
-
-	/*
-	 * Access the page AFTER the hash-bucket is locked.
-	 * Order is important:
-	 *
-	 *   Userspace waiter: val = var; if (cond(val)) futex_wait(&var, val);
-	 *   Userspace waker:  if (cond(var)) { var = new; futex_wake(&var); }
-	 *
-	 * The basic logical guarantee of a futex is that it blocks ONLY
-	 * if cond(var) is known to be true at the time of blocking, for
-	 * any cond.  If we locked the hash-bucket after testing *uaddr, that
-	 * would open a race condition where we could block indefinitely with
-	 * cond(var) false, which would violate the guarantee.
-	 *
-	 * On the other hand, we insert q and release the hash-bucket only
-	 * after testing *uaddr.  This guarantees that futex_wait() will NOT
-	 * absorb a wakeup if *uaddr does not match the desired values
-	 * while the syscall executes.
-	 */
-retry:
-	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
-	if (unlikely(ret != 0))
-		return ret;
-
-retry_private:
-	*hb = futex_q_lock(q);
-
-	ret = futex_get_value_locked(&uval, uaddr);
-
-	if (ret) {
-		futex_q_unlock(*hb);
-
-		ret = get_user(uval, uaddr);
-		if (ret)
-			return ret;
-
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-
-		goto retry;
-	}
-
-	if (uval != val) {
-		futex_q_unlock(*hb);
-		ret = -EWOULDBLOCK;
-	}
-
-	return ret;
-}
-
-int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
-{
-	struct hrtimer_sleeper timeout, *to;
-	struct restart_block *restart;
-	struct futex_hash_bucket *hb;
-	struct futex_q q = futex_q_init;
-	int ret;
-
-	if (!bitset)
-		return -EINVAL;
-	q.bitset = bitset;
-
-	to = futex_setup_timer(abs_time, &timeout, flags,
-			       current->timer_slack_ns);
-retry:
-	/*
-	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
-	 * is initialized.
-	 */
-	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
-	if (ret)
-		goto out;
-
-	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue(hb, &q, to);
-
-	/* If we were woken (and unqueued), we succeeded, whatever. */
-	ret = 0;
-	if (!futex_unqueue(&q))
-		goto out;
-	ret = -ETIMEDOUT;
-	if (to && !to->task)
-		goto out;
-
-	/*
-	 * We expect signal_pending(current), but we might be the
-	 * victim of a spurious wakeup as well.
-	 */
-	if (!signal_pending(current))
-		goto retry;
-
-	ret = -ERESTARTSYS;
-	if (!abs_time)
-		goto out;
-
-	restart = &current->restart_block;
-	restart->futex.uaddr = uaddr;
-	restart->futex.val = val;
-	restart->futex.time = *abs_time;
-	restart->futex.bitset = bitset;
-	restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
-
-	ret = set_restart_fn(restart, futex_wait_restart);
-
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
-	}
-	return ret;
-}
-
-
-static long futex_wait_restart(struct restart_block *restart)
-{
-	u32 __user *uaddr = restart->futex.uaddr;
-	ktime_t t, *tp = NULL;
-
-	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
-		t = restart->futex.time;
-		tp = &t;
-	}
-	restart->fn = do_no_restart_syscall;
-
-	return (long)futex_wait(uaddr, restart->futex.flags,
-				restart->futex.val, tp, restart->futex.bitset);
-}
-
-
 /* Constants for the pending_op argument of handle_futex_death */
 #define HANDLE_DEATH_PENDING	true
 #define HANDLE_DEATH_LIST	false
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 840302aefdfc..fe847f57dad5 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -154,6 +154,27 @@ extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union fute
 
 extern void __futex_unqueue(struct futex_q *q);
 extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
+extern int futex_unqueue(struct futex_q *q);
+
+/**
+ * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
+ * @q:	The futex_q to enqueue
+ * @hb:	The destination hash bucket
+ *
+ * The hb->lock must be held by the caller, and is released here. A call to
+ * futex_queue() is typically paired with exactly one call to futex_unqueue().  The
+ * exceptions involve the PI related operations, which may use futex_unqueue_pi()
+ * or nothing if the unqueue is done as part of the wake process and the unqueue
+ * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
+ * an example).
+ */
+static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
+	__releases(&hb->lock)
+{
+	__futex_queue(q, hb);
+	spin_unlock(&hb->lock);
+}
+
 extern void futex_unqueue_pi(struct futex_q *q);
 
 extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
@@ -183,6 +204,19 @@ static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
 #endif
 }
 
+static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Full barrier (B), see the ordering comment above.
+	 */
+	smp_mb();
+	return atomic_read(&hb->waiters);
+#else
+	return 1;
+#endif
+}
+
 extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
 extern void futex_q_unlock(struct futex_hash_bucket *hb);
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
new file mode 100644
index 000000000000..36880784aa11
--- /dev/null
+++ b/kernel/futex/waitwake.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/sched/task.h>
+#include <linux/sched/signal.h>
+#include <linux/freezer.h>
+
+#include "futex.h"
+
+/*
+ * READ this before attempting to hack on futexes!
+ *
+ * Basic futex operation and ordering guarantees
+ * =============================================
+ *
+ * The waiter reads the futex value in user space and calls
+ * futex_wait(). This function computes the hash bucket and acquires
+ * the hash bucket lock. After that it reads the futex user space value
+ * again and verifies that the data has not changed. If it has not changed
+ * it enqueues itself into the hash bucket, releases the hash bucket lock
+ * and schedules.
+ *
+ * The waker side modifies the user space value of the futex and calls
+ * futex_wake(). This function computes the hash bucket and acquires the
+ * hash bucket lock. Then it looks for waiters on that futex in the hash
+ * bucket and wakes them.
+ *
+ * In futex wake up scenarios where no tasks are blocked on a futex, taking
+ * the hb spinlock can be avoided and simply return. In order for this
+ * optimization to work, ordering guarantees must exist so that the waiter
+ * being added to the list is acknowledged when the list is concurrently being
+ * checked by the waker, avoiding scenarios like the following:
+ *
+ * CPU 0                               CPU 1
+ * val = *futex;
+ * sys_futex(WAIT, futex, val);
+ *   futex_wait(futex, val);
+ *   uval = *futex;
+ *                                     *futex = newval;
+ *                                     sys_futex(WAKE, futex);
+ *                                       futex_wake(futex);
+ *                                       if (queue_empty())
+ *                                         return;
+ *   if (uval == val)
+ *      lock(hash_bucket(futex));
+ *      queue();
+ *     unlock(hash_bucket(futex));
+ *     schedule();
+ *
+ * This would cause the waiter on CPU 0 to wait forever because it
+ * missed the transition of the user space value from val to newval
+ * and the waker did not find the waiter in the hash bucket queue.
+ *
+ * The correct serialization ensures that a waiter either observes
+ * the changed user space value before blocking or is woken by a
+ * concurrent waker:
+ *
+ * CPU 0                                 CPU 1
+ * val = *futex;
+ * sys_futex(WAIT, futex, val);
+ *   futex_wait(futex, val);
+ *
+ *   waiters++; (a)
+ *   smp_mb(); (A) <-- paired with -.
+ *                                  |
+ *   lock(hash_bucket(futex));      |
+ *                                  |
+ *   uval = *futex;                 |
+ *                                  |        *futex = newval;
+ *                                  |        sys_futex(WAKE, futex);
+ *                                  |          futex_wake(futex);
+ *                                  |
+ *                                  `--------> smp_mb(); (B)
+ *   if (uval == val)
+ *     queue();
+ *     unlock(hash_bucket(futex));
+ *     schedule();                         if (waiters)
+ *                                           lock(hash_bucket(futex));
+ *   else                                    wake_waiters(futex);
+ *     waiters--; (b)                        unlock(hash_bucket(futex));
+ *
+ * Where (A) orders the waiters increment and the futex value read through
+ * atomic operations (see futex_hb_waiters_inc) and where (B) orders the write
+ * to futex and the waiters read (see futex_hb_waiters_pending()).
+ *
+ * This yields the following case (where X:=waiters, Y:=futex):
+ *
+ *	X = Y = 0
+ *
+ *	w[X]=1		w[Y]=1
+ *	MB		MB
+ *	r[Y]=y		r[X]=x
+ *
+ * Which guarantees that x==0 && y==0 is impossible; which translates back into
+ * the guarantee that we cannot both miss the futex variable change and the
+ * enqueue.
+ *
+ * Note that a new waiter is accounted for in (a) even when it is possible that
+ * the wait call can return error, in which case we backtrack from it in (b).
+ * Refer to the comment in futex_q_lock().
+ *
+ * Similarly, in order to account for waiters being requeued on another
+ * address we always increment the waiters for the destination bucket before
+ * acquiring the lock. It then decrements them again  after releasing it -
+ * the code that actually moves the futex(es) between hash buckets (requeue_futex)
+ * will do the additional required waiter count housekeeping. This is done for
+ * double_lock_hb() and double_unlock_hb(), respectively.
+ */
+
+/*
+ * The hash bucket lock must be held when this is called.
+ * Afterwards, the futex_q must not be accessed. Callers
+ * must ensure to later call wake_up_q() for the actual
+ * wakeups to occur.
+ */
+void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
+{
+	struct task_struct *p = q->task;
+
+	if (WARN(q->pi_state || q->rt_waiter, "refusing to wake PI futex\n"))
+		return;
+
+	get_task_struct(p);
+	__futex_unqueue(q);
+	/*
+	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
+	 * is written, without taking any locks. This is possible in the event
+	 * of a spurious wakeup, for example. A memory barrier is required here
+	 * to prevent the following store to lock_ptr from getting ahead of the
+	 * plist_del in __futex_unqueue().
+	 */
+	smp_store_release(&q->lock_ptr, NULL);
+
+	/*
+	 * Queue the task for later wakeup for after we've released
+	 * the hb->lock.
+	 */
+	wake_q_add_safe(wake_q, p);
+}
+
+/*
+ * Wake up waiters matching bitset queued on this futex (uaddr).
+ */
+int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
+{
+	struct futex_hash_bucket *hb;
+	struct futex_q *this, *next;
+	union futex_key key = FUTEX_KEY_INIT;
+	int ret;
+	DEFINE_WAKE_Q(wake_q);
+
+	if (!bitset)
+		return -EINVAL;
+
+	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	if (unlikely(ret != 0))
+		return ret;
+
+	hb = futex_hash(&key);
+
+	/* Make sure we really have tasks to wakeup */
+	if (!futex_hb_waiters_pending(hb))
+		return ret;
+
+	spin_lock(&hb->lock);
+
+	plist_for_each_entry_safe(this, next, &hb->chain, list) {
+		if (futex_match (&this->key, &key)) {
+			if (this->pi_state || this->rt_waiter) {
+				ret = -EINVAL;
+				break;
+			}
+
+			/* Check if one of the bits is set in both bitsets */
+			if (!(this->bitset & bitset))
+				continue;
+
+			futex_wake_mark(&wake_q, this);
+			if (++ret >= nr_wake)
+				break;
+		}
+	}
+
+	spin_unlock(&hb->lock);
+	wake_up_q(&wake_q);
+	return ret;
+}
+
+static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
+{
+	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
+	unsigned int cmp =	  (encoded_op & 0x0f000000) >> 24;
+	int oparg = sign_extend32((encoded_op & 0x00fff000) >> 12, 11);
+	int cmparg = sign_extend32(encoded_op & 0x00000fff, 11);
+	int oldval, ret;
+
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
+		if (oparg < 0 || oparg > 31) {
+			char comm[sizeof(current->comm)];
+			/*
+			 * kill this print and return -EINVAL when userspace
+			 * is sane again
+			 */
+			pr_info_ratelimited("futex_wake_op: %s tries to shift op by %d; fix this program\n",
+					get_task_comm(comm, current), oparg);
+			oparg &= 31;
+		}
+		oparg = 1 << oparg;
+	}
+
+	pagefault_disable();
+	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
+	pagefault_enable();
+	if (ret)
+		return ret;
+
+	switch (cmp) {
+	case FUTEX_OP_CMP_EQ:
+		return oldval == cmparg;
+	case FUTEX_OP_CMP_NE:
+		return oldval != cmparg;
+	case FUTEX_OP_CMP_LT:
+		return oldval < cmparg;
+	case FUTEX_OP_CMP_GE:
+		return oldval >= cmparg;
+	case FUTEX_OP_CMP_LE:
+		return oldval <= cmparg;
+	case FUTEX_OP_CMP_GT:
+		return oldval > cmparg;
+	default:
+		return -ENOSYS;
+	}
+}
+
+/*
+ * Wake up all waiters hashed on the physical page that is mapped
+ * to this virtual address:
+ */
+int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
+		  int nr_wake, int nr_wake2, int op)
+{
+	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
+	struct futex_hash_bucket *hb1, *hb2;
+	struct futex_q *this, *next;
+	int ret, op_ret;
+	DEFINE_WAKE_Q(wake_q);
+
+retry:
+	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	if (unlikely(ret != 0))
+		return ret;
+	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	if (unlikely(ret != 0))
+		return ret;
+
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
+
+retry_private:
+	double_lock_hb(hb1, hb2);
+	op_ret = futex_atomic_op_inuser(op, uaddr2);
+	if (unlikely(op_ret < 0)) {
+		double_unlock_hb(hb1, hb2);
+
+		if (!IS_ENABLED(CONFIG_MMU) ||
+		    unlikely(op_ret != -EFAULT && op_ret != -EAGAIN)) {
+			/*
+			 * we don't get EFAULT from MMU faults if we don't have
+			 * an MMU, but we might get them from range checking
+			 */
+			ret = op_ret;
+			return ret;
+		}
+
+		if (op_ret == -EFAULT) {
+			ret = fault_in_user_writeable(uaddr2);
+			if (ret)
+				return ret;
+		}
+
+		cond_resched();
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+		goto retry;
+	}
+
+	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+		if (futex_match (&this->key, &key1)) {
+			if (this->pi_state || this->rt_waiter) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+			futex_wake_mark(&wake_q, this);
+			if (++ret >= nr_wake)
+				break;
+		}
+	}
+
+	if (op_ret > 0) {
+		op_ret = 0;
+		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
+			if (futex_match (&this->key, &key2)) {
+				if (this->pi_state || this->rt_waiter) {
+					ret = -EINVAL;
+					goto out_unlock;
+				}
+				futex_wake_mark(&wake_q, this);
+				if (++op_ret >= nr_wake2)
+					break;
+			}
+		}
+		ret += op_ret;
+	}
+
+out_unlock:
+	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
+	return ret;
+}
+
+static long futex_wait_restart(struct restart_block *restart);
+
+/**
+ * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
+ * @hb:		the futex hash bucket, must be locked by the caller
+ * @q:		the futex_q to queue up on
+ * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
+ */
+void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
+			    struct hrtimer_sleeper *timeout)
+{
+	/*
+	 * The task state is guaranteed to be set before another task can
+	 * wake it. set_current_state() is implemented using smp_store_mb() and
+	 * futex_queue() calls spin_unlock() upon completion, both serializing
+	 * access to the hash list and forcing another memory barrier.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	futex_queue(q, hb);
+
+	/* Arm the timer */
+	if (timeout)
+		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
+
+	/*
+	 * If we have been removed from the hash list, then another task
+	 * has tried to wake us, and we can skip the call to schedule().
+	 */
+	if (likely(!plist_node_empty(&q->list))) {
+		/*
+		 * If the timer has already expired, current will already be
+		 * flagged for rescheduling. Only call schedule if there
+		 * is no timeout, or if it has yet to expire.
+		 */
+		if (!timeout || timeout->task)
+			freezable_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+}
+
+/**
+ * futex_wait_setup() - Prepare to wait on a futex
+ * @uaddr:	the futex userspace address
+ * @val:	the expected value
+ * @flags:	futex flags (FLAGS_SHARED, etc.)
+ * @q:		the associated futex_q
+ * @hb:		storage for hash_bucket pointer to be returned to caller
+ *
+ * Setup the futex_q and locate the hash_bucket.  Get the futex value and
+ * compare it with the expected value.  Handle atomic faults internally.
+ * Return with the hb lock held on success, and unlocked on failure.
+ *
+ * Return:
+ *  -  0 - uaddr contains val and hb has been locked;
+ *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is unlocked
+ */
+int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+		     struct futex_q *q, struct futex_hash_bucket **hb)
+{
+	u32 uval;
+	int ret;
+
+	/*
+	 * Access the page AFTER the hash-bucket is locked.
+	 * Order is important:
+	 *
+	 *   Userspace waiter: val = var; if (cond(val)) futex_wait(&var, val);
+	 *   Userspace waker:  if (cond(var)) { var = new; futex_wake(&var); }
+	 *
+	 * The basic logical guarantee of a futex is that it blocks ONLY
+	 * if cond(var) is known to be true at the time of blocking, for
+	 * any cond.  If we locked the hash-bucket after testing *uaddr, that
+	 * would open a race condition where we could block indefinitely with
+	 * cond(var) false, which would violate the guarantee.
+	 *
+	 * On the other hand, we insert q and release the hash-bucket only
+	 * after testing *uaddr.  This guarantees that futex_wait() will NOT
+	 * absorb a wakeup if *uaddr does not match the desired values
+	 * while the syscall executes.
+	 */
+retry:
+	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
+	if (unlikely(ret != 0))
+		return ret;
+
+retry_private:
+	*hb = futex_q_lock(q);
+
+	ret = futex_get_value_locked(&uval, uaddr);
+
+	if (ret) {
+		futex_q_unlock(*hb);
+
+		ret = get_user(uval, uaddr);
+		if (ret)
+			return ret;
+
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+
+		goto retry;
+	}
+
+	if (uval != val) {
+		futex_q_unlock(*hb);
+		ret = -EWOULDBLOCK;
+	}
+
+	return ret;
+}
+
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct restart_block *restart;
+	struct futex_hash_bucket *hb;
+	struct futex_q q = futex_q_init;
+	int ret;
+
+	if (!bitset)
+		return -EINVAL;
+	q.bitset = bitset;
+
+	to = futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
+retry:
+	/*
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
+	 */
+	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
+	if (ret)
+		goto out;
+
+	/* futex_queue and wait for wakeup, timeout, or a signal. */
+	futex_wait_queue(hb, &q, to);
+
+	/* If we were woken (and unqueued), we succeeded, whatever. */
+	ret = 0;
+	if (!futex_unqueue(&q))
+		goto out;
+	ret = -ETIMEDOUT;
+	if (to && !to->task)
+		goto out;
+
+	/*
+	 * We expect signal_pending(current), but we might be the
+	 * victim of a spurious wakeup as well.
+	 */
+	if (!signal_pending(current))
+		goto retry;
+
+	ret = -ERESTARTSYS;
+	if (!abs_time)
+		goto out;
+
+	restart = &current->restart_block;
+	restart->futex.uaddr = uaddr;
+	restart->futex.val = val;
+	restart->futex.time = *abs_time;
+	restart->futex.bitset = bitset;
+	restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
+
+	ret = set_restart_fn(restart, futex_wait_restart);
+
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
+	return ret;
+}
+
+static long futex_wait_restart(struct restart_block *restart)
+{
+	u32 __user *uaddr = restart->futex.uaddr;
+	ktime_t t, *tp = NULL;
+
+	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
+		t = restart->futex.time;
+		tp = &t;
+	}
+	restart->fn = do_no_restart_syscall;
+
+	return (long)futex_wait(uaddr, restart->futex.flags,
+				restart->futex.val, tp, restart->futex.bitset);
+}
+
-- 
2.33.0

