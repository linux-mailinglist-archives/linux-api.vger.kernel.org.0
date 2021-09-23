Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EAD416406
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbhIWRNq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47062 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbhIWRNn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E67B61F44602
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
Subject: [PATCH v2 10/22] futex: Rename: hb_waiter_{inc,dec,pending}()
Date:   Thu, 23 Sep 2021 14:10:59 -0300
Message-Id: <20210923171111.300673-11-andrealmeid@collabora.com>
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

  s/hb_waiters_/futex_&/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a8ca5b5cbc99..a26045e17fac 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -115,8 +115,8 @@
  *     waiters--; (b)                        unlock(hash_bucket(futex));
  *
  * Where (A) orders the waiters increment and the futex value read through
- * atomic operations (see hb_waiters_inc) and where (B) orders the write
- * to futex and the waiters read (see hb_waiters_pending()).
+ * atomic operations (see futex_hb_waiters_inc) and where (B) orders the write
+ * to futex and the waiters read (see futex_hb_waiters_pending()).
  *
  * This yields the following case (where X:=waiters, Y:=futex):
  *
@@ -272,7 +272,7 @@ late_initcall(fail_futex_debugfs);
 /*
  * Reflects a new waiter being added to the waitqueue.
  */
-static inline void hb_waiters_inc(struct futex_hash_bucket *hb)
+static inline void futex_hb_waiters_inc(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
 	atomic_inc(&hb->waiters);
@@ -287,14 +287,14 @@ static inline void hb_waiters_inc(struct futex_hash_bucket *hb)
  * Reflects a waiter being removed from the waitqueue by wakeup
  * paths.
  */
-static inline void hb_waiters_dec(struct futex_hash_bucket *hb)
+static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
 	atomic_dec(&hb->waiters);
 #endif
 }
 
-static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
+static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
 	/*
@@ -723,7 +723,7 @@ static void __futex_unqueue(struct futex_q *q)
 
 	hb = container_of(q->lock_ptr, struct futex_hash_bucket, lock);
 	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 }
 
 /*
@@ -802,7 +802,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	hb = futex_hash(&key);
 
 	/* Make sure we really have tasks to wakeup */
-	if (!hb_waiters_pending(hb))
+	if (!futex_hb_waiters_pending(hb))
 		return ret;
 
 	spin_lock(&hb->lock);
@@ -979,8 +979,8 @@ void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
 	 */
 	if (likely(&hb1->chain != &hb2->chain)) {
 		plist_del(&q->list, &hb1->chain);
-		hb_waiters_dec(hb1);
-		hb_waiters_inc(hb2);
+		futex_hb_waiters_dec(hb1);
+		futex_hb_waiters_inc(hb2);
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr = &hb2->lock;
 	}
@@ -1341,7 +1341,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	hb2 = futex_hash(&key2);
 
 retry_private:
-	hb_waiters_inc(hb2);
+	futex_hb_waiters_inc(hb2);
 	double_lock_hb(hb1, hb2);
 
 	if (likely(cmpval != NULL)) {
@@ -1351,7 +1351,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 
 			ret = get_user(curval, uaddr1);
 			if (ret)
@@ -1437,7 +1437,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		 */
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 			ret = fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -1451,7 +1451,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 			 * - EAGAIN: The user space value changed.
 			 */
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -1570,7 +1570,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-	hb_waiters_dec(hb2);
+	futex_hb_waiters_dec(hb2);
 	return ret ? ret : task_count;
 }
 
@@ -1590,7 +1590,7 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	 * decrement the counter at futex_q_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
-	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
+	futex_hb_waiters_inc(hb); /* implies smp_mb(); (A) */
 
 	q->lock_ptr = &hb->lock;
 
@@ -1602,7 +1602,7 @@ void futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 }
 
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
@@ -1932,7 +1932,7 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
 	 * Unqueue the futex_q and determine which it was.
 	 */
 	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 
 	/* Handle spurious wakeups gracefully */
 	ret = -EWOULDBLOCK;
-- 
2.33.0

