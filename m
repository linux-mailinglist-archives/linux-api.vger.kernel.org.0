Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6D4163FC
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbhIWRN0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbhIWRNV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 959631F44602
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
Subject: [PATCH v2 05/22] futex: Rename: queue_{,un}lock()
Date:   Thu, 23 Sep 2021 14:10:54 -0300
Message-Id: <20210923171111.300673-6-andrealmeid@collabora.com>
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

  s/queue_\(un\)*lock/futex_q_\1lock/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e70e81c61ea2..63cf0da2e413 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -132,7 +132,7 @@
  *
  * Note that a new waiter is accounted for in (a) even when it is possible that
  * the wait call can return error, in which case we backtrack from it in (b).
- * Refer to the comment in queue_lock().
+ * Refer to the comment in futex_q_lock().
  *
  * Similarly, in order to account for waiters being requeued on another
  * address we always increment the waiters for the destination bucket before
@@ -2410,7 +2410,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 }
 
 /* The key must be already stored in q->key. */
-static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
+static inline struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
 {
 	struct futex_hash_bucket *hb;
@@ -2420,9 +2420,9 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 	/*
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
-	 * waiting for the spinlock. This is safe as all queue_lock()
+	 * waiting for the spinlock. This is safe as all futex_q_lock()
 	 * users end up calling futex_queue(). Similarly, for housekeeping,
-	 * decrement the counter at queue_unlock() when some error has
+	 * decrement the counter at futex_q_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
 	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
@@ -2434,7 +2434,7 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 }
 
 static inline void
-queue_unlock(struct futex_hash_bucket *hb)
+futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
@@ -2870,12 +2870,12 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 		return ret;
 
 retry_private:
-	*hb = queue_lock(q);
+	*hb = futex_q_lock(q);
 
 	ret = get_futex_value_locked(&uval, uaddr);
 
 	if (ret) {
-		queue_unlock(*hb);
+		futex_q_unlock(*hb);
 
 		ret = get_user(uval, uaddr);
 		if (ret)
@@ -2888,7 +2888,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	}
 
 	if (uval != val) {
-		queue_unlock(*hb);
+		futex_q_unlock(*hb);
 		ret = -EWOULDBLOCK;
 	}
 
@@ -3006,7 +3006,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 		goto out;
 
 retry_private:
-	hb = queue_lock(&q);
+	hb = futex_q_lock(&q);
 
 	ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
 				   &exiting, 0);
@@ -3030,7 +3030,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 			 *   exit to complete.
 			 * - EAGAIN: The user space value changed.
 			 */
-			queue_unlock(hb);
+			futex_q_unlock(hb);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -3126,7 +3126,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	goto out;
 
 out_unlock_put_key:
-	queue_unlock(hb);
+	futex_q_unlock(hb);
 
 out:
 	if (to) {
@@ -3136,7 +3136,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	return ret != -EINTR ? ret : -ERESTARTNOINTR;
 
 uaddr_faulted:
-	queue_unlock(hb);
+	futex_q_unlock(hb);
 
 	ret = fault_in_user_writeable(uaddr);
 	if (ret)
@@ -3421,7 +3421,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * shared futexes. We need to compare the keys:
 	 */
 	if (match_futex(&q.key, &key2)) {
-		queue_unlock(hb);
+		futex_q_unlock(hb);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.33.0

