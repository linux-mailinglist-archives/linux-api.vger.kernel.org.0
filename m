Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDD4163F8
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbhIWRNN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbhIWRNL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 7071C1F445FF
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
Subject: [PATCH v2 03/22] futex: Rename {,__}{,un}queue_me()
Date:   Thu, 23 Sep 2021 14:10:52 -0300
Message-Id: <20210923171111.300673-4-andrealmeid@collabora.com>
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

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/\<\(__\)*\(un\)*queue_me/\1futex_\2queue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 46 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 69d98929f2f5..91f94b45c2e8 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -190,7 +190,7 @@ struct futex_pi_state {
  * the second.
  *
  * PI futexes are typically woken before they are removed from the hash list via
- * the rt_mutex code. See unqueue_me_pi().
+ * the rt_mutex code. See futex_unqueue_pi().
  */
 struct futex_q {
 	struct plist_node list;
@@ -260,7 +260,7 @@ enum {
 };
 
 static const struct futex_q futex_q_init = {
-	/* list gets initialized in queue_me()*/
+	/* list gets initialized in futex_queue()*/
 	.key		= FUTEX_KEY_INIT,
 	.bitset		= FUTEX_BITSET_MATCH_ANY,
 	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
@@ -1047,7 +1047,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	/*
 	 * We get here with hb->lock held, and having found a
 	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
-	 * has dropped the hb->lock in between queue_me() and unqueue_me_pi(),
+	 * has dropped the hb->lock in between futex_queue() and futex_unqueue_pi(),
 	 * which in turn means that futex_lock_pi() still has a reference on
 	 * our pi_state.
 	 *
@@ -2421,7 +2421,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
 	 * waiting for the spinlock. This is safe as all queue_lock()
-	 * users end up calling queue_me(). Similarly, for housekeeping,
+	 * users end up calling futex_queue(). Similarly, for housekeeping,
 	 * decrement the counter at queue_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
@@ -2441,7 +2441,7 @@ queue_unlock(struct futex_hash_bucket *hb)
 	hb_waiters_dec(hb);
 }
 
-static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
+static inline void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
 {
 	int prio;
 
@@ -2461,36 +2461,36 @@ static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 }
 
 /**
- * queue_me() - Enqueue the futex_q on the futex_hash_bucket
+ * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
  * @q:	The futex_q to enqueue
  * @hb:	The destination hash bucket
  *
  * The hb->lock must be held by the caller, and is released here. A call to
- * queue_me() is typically paired with exactly one call to unqueue_me().  The
- * exceptions involve the PI related operations, which may use unqueue_me_pi()
+ * futex_queue() is typically paired with exactly one call to futex_unqueue().  The
+ * exceptions involve the PI related operations, which may use futex_unqueue_pi()
  * or nothing if the unqueue is done as part of the wake process and the unqueue
  * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
  * an example).
  */
-static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
+static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	__queue_me(q, hb);
+	__futex_queue(q, hb);
 	spin_unlock(&hb->lock);
 }
 
 /**
- * unqueue_me() - Remove the futex_q from its futex_hash_bucket
+ * futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
  *
- * The q->lock_ptr must not be held by the caller. A call to unqueue_me() must
- * be paired with exactly one earlier call to queue_me().
+ * The q->lock_ptr must not be held by the caller. A call to futex_unqueue() must
+ * be paired with exactly one earlier call to futex_queue().
  *
  * Return:
  *  - 1 - if the futex_q was still queued (and we removed unqueued it);
  *  - 0 - if the futex_q was already removed by the waking thread
  */
-static int unqueue_me(struct futex_q *q)
+static int futex_unqueue(struct futex_q *q)
 {
 	spinlock_t *lock_ptr;
 	int ret = 0;
@@ -2537,7 +2537,7 @@ static int unqueue_me(struct futex_q *q)
  * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
-static void unqueue_me_pi(struct futex_q *q)
+static void futex_unqueue_pi(struct futex_q *q)
 {
 	__unqueue_futex(q);
 
@@ -2787,7 +2787,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 }
 
 /**
- * futex_wait_queue_me() - queue_me() and wait for wakeup, timeout, or signal
+ * futex_wait_queue_me() - futex_queue() and wait for wakeup, timeout, or signal
  * @hb:		the futex hash bucket, must be locked by the caller
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
@@ -2798,11 +2798,11 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls spin_unlock() upon completion, both serializing
+	 * futex_queue() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
-	queue_me(q, hb);
+	futex_queue(q, hb);
 
 	/* Arm the timer */
 	if (timeout)
@@ -2918,12 +2918,12 @@ int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time
 	if (ret)
 		goto out;
 
-	/* queue_me and wait for wakeup, timeout, or a signal. */
+	/* futex_queue and wait for wakeup, timeout, or a signal. */
 	futex_wait_queue_me(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
-	if (!unqueue_me(&q))
+	if (!futex_unqueue(&q))
 		goto out;
 	ret = -ETIMEDOUT;
 	if (to && !to->task)
@@ -3049,7 +3049,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	/*
 	 * Only actually queue now that the atomic ops are done:
 	 */
-	__queue_me(&q, hb);
+	__futex_queue(&q, hb);
 
 	if (trylock) {
 		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
@@ -3121,7 +3121,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	if (res)
 		ret = (res < 0) ? res : 0;
 
-	unqueue_me_pi(&q);
+	futex_unqueue_pi(&q);
 	spin_unlock(q.lock_ptr);
 	goto out;
 
@@ -3479,7 +3479,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (res)
 			ret = (res < 0) ? res : 0;
 
-		unqueue_me_pi(&q);
+		futex_unqueue_pi(&q);
 		spin_unlock(q.lock_ptr);
 
 		if (ret == -EINTR) {
-- 
2.33.0

