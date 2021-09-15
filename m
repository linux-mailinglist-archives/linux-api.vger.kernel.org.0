Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE11540C747
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhIOOTK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbhIOOTJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48365C061766;
        Wed, 15 Sep 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wGwnfmVB8J/pD1hIQzPzTJDsxXTsDjjDexYsCFtlKJI=; b=emD/isRTsRaWl3MRZ9nVVG6pV2
        WT4hx39lJKS5DpupdlUYMwN3mmFxwbGjReHzRdv1iz5MiHORQMTBZ4RmyNxzNn6REuCCVMYRG264u
        LqKyBuOa6JSmHIq8fCfl/czx8+RDXYLmYvVxZQX3rDyGb7UMbcBWvdGmHlUlInguzeGMUUmwolLtm
        QVKLIOD/asbcX1m4Q4nuNMr2luPA9YhrolXREwf/vJTE+sEYonM0tL5aN6XZ35Z1x7Dt267dgxEWM
        dltL7Fy2aC5dgGTdlZ+uVK/rTnsEuO0+e9MbdDF4KqknBFZamk2U/uQo6rcc5rR66KqREZveTDlNS
        u1EZvKFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj9-003PTv-E7; Wed, 15 Sep 2021 14:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 188B630077D;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EDEB1234E53A3; Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Message-ID: <20210915141524.924939336@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 05/20] futex: Rename: queue_{,un}lock()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/queue_\(un\)*lock/futex_q_\1lock/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

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
@@ -2410,7 +2410,7 @@ int futex_requeue(u32 __user *uaddr1, un
 }
 
 /* The key must be already stored in q->key. */
-static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
+static inline struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
 {
 	struct futex_hash_bucket *hb;
@@ -2420,9 +2420,9 @@ static inline struct futex_hash_bucket *
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
@@ -2434,7 +2434,7 @@ static inline struct futex_hash_bucket *
 }
 
 static inline void
-queue_unlock(struct futex_hash_bucket *hb)
+futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
@@ -2870,12 +2870,12 @@ static int futex_wait_setup(u32 __user *
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
@@ -2888,7 +2888,7 @@ static int futex_wait_setup(u32 __user *
 	}
 
 	if (uval != val) {
-		queue_unlock(*hb);
+		futex_q_unlock(*hb);
 		ret = -EWOULDBLOCK;
 	}
 
@@ -3006,7 +3006,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 		goto out;
 
 retry_private:
-	hb = queue_lock(&q);
+	hb = futex_q_lock(&q);
 
 	ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
 				   &exiting, 0);
@@ -3030,7 +3030,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 			 *   exit to complete.
 			 * - EAGAIN: The user space value changed.
 			 */
-			queue_unlock(hb);
+			futex_q_unlock(hb);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -3126,7 +3126,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	goto out;
 
 out_unlock_put_key:
-	queue_unlock(hb);
+	futex_q_unlock(hb);
 
 out:
 	if (to) {
@@ -3136,7 +3136,7 @@ int futex_lock_pi(u32 __user *uaddr, uns
 	return ret != -EINTR ? ret : -ERESTARTNOINTR;
 
 uaddr_faulted:
-	queue_unlock(hb);
+	futex_q_unlock(hb);
 
 	ret = fault_in_user_writeable(uaddr);
 	if (ret)
@@ -3421,7 +3421,7 @@ int futex_wait_requeue_pi(u32 __user *ua
 	 * shared futexes. We need to compare the keys:
 	 */
 	if (match_futex(&q.key, &key2)) {
-		queue_unlock(hb);
+		futex_q_unlock(hb);
 		ret = -EINVAL;
 		goto out;
 	}


