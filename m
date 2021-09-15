Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4340C751
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhIOOVc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhIOOVb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:21:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0045EC061764;
        Wed, 15 Sep 2021 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FIg7Q2J/vp2ylpBzJVo856CPHzZwuzD/X3i3oTcfYII=; b=SLQbYRAWNK3aiMluXohJrY3ekU
        XZC5TgYBiC6VUNJx3EBRsJuIY2sA/Xs+A5FeIWDpw074kxtGlBM3heeafiGE7L/Ir8XCtMQ/E54T/
        cHvAkZ1CYb25WISi+em6CazPmam27wiQEC1PhTA8hw8iZUU2K8+OsY+QcSq9x2imiQGBARB8ecZAu
        yLsVfS+qWllgq1NUpkgZVQKmYaVuWCg5PAbnPNhsLd4avCEl4u2hsTZBLvaBkCOV0TdysnaKvjV8t
        s7RR36d9xRx5o+JHi/2PxQtpJvGYiBIelIF/8JY7Ry815Ul+1nU0EiIReAi6bXopS1XE2c3A5mhfR
        LP92nbTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj9-00Fk3k-F0; Wed, 15 Sep 2021 14:17:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DB5B300BE6;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0F9B1285DCA98; Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Message-ID: <20210915141525.232684270@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 10/20] futex: Rename: hb_waiter_{inc,dec,pending}()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/hb_waiters_/futex_&/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

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
@@ -287,14 +287,14 @@ static inline void hb_waiters_inc(struct
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
@@ -723,7 +723,7 @@ static void __futex_unqueue(struct futex
 
 	hb = container_of(q->lock_ptr, struct futex_hash_bucket, lock);
 	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 }
 
 /*
@@ -802,7 +802,7 @@ int futex_wake(u32 __user *uaddr, unsign
 	hb = futex_hash(&key);
 
 	/* Make sure we really have tasks to wakeup */
-	if (!hb_waiters_pending(hb))
+	if (!futex_hb_waiters_pending(hb))
 		return ret;
 
 	spin_lock(&hb->lock);
@@ -979,8 +979,8 @@ void requeue_futex(struct futex_q *q, st
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
@@ -1341,7 +1341,7 @@ int futex_requeue(u32 __user *uaddr1, un
 	hb2 = futex_hash(&key2);
 
 retry_private:
-	hb_waiters_inc(hb2);
+	futex_hb_waiters_inc(hb2);
 	double_lock_hb(hb1, hb2);
 
 	if (likely(cmpval != NULL)) {
@@ -1351,7 +1351,7 @@ int futex_requeue(u32 __user *uaddr1, un
 
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 
 			ret = get_user(curval, uaddr1);
 			if (ret)
@@ -1437,7 +1437,7 @@ int futex_requeue(u32 __user *uaddr1, un
 		 */
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 			ret = fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -1451,7 +1451,7 @@ int futex_requeue(u32 __user *uaddr1, un
 			 * - EAGAIN: The user space value changed.
 			 */
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -1570,7 +1570,7 @@ int futex_requeue(u32 __user *uaddr1, un
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-	hb_waiters_dec(hb2);
+	futex_hb_waiters_dec(hb2);
 	return ret ? ret : task_count;
 }
 
@@ -1600,7 +1600,7 @@ struct futex_hash_bucket *futex_q_lock(s
 	 * decrement the counter at futex_q_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
-	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
+	futex_hb_waiters_inc(hb); /* implies smp_mb(); (A) */
 
 	q->lock_ptr = &hb->lock;
 
@@ -1612,7 +1612,7 @@ void futex_q_unlock(struct futex_hash_bu
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 }
 
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
@@ -1942,7 +1942,7 @@ int handle_early_requeue_pi_wakeup(struc
 	 * Unqueue the futex_q and determine which it was.
 	 */
 	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 
 	/* Handle spurious wakeups gracefully */
 	ret = -EWOULDBLOCK;


