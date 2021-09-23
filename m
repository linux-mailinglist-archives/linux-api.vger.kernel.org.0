Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5942416400
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbhIWRNb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47006 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242570AbhIWRN3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 79F071F44601
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
Subject: [PATCH v2 07/22] futex: Rename hash_futex()
Date:   Thu, 23 Sep 2021 14:10:56 -0300
Message-Id: <20210923171111.300673-8-andrealmeid@collabora.com>
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
namespace; rename:

  s/hash_futex/futex_hash/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 88541fba57ea..032189fa7b7f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -279,7 +279,7 @@ struct futex_hash_bucket {
 
 /*
  * The base of the bucket array and its size are always used together
- * (after initialization only in hash_futex()), so ensure that they
+ * (after initialization only in futex_hash()), so ensure that they
  * reside in the same cacheline.
  */
 static struct {
@@ -380,13 +380,13 @@ static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
 }
 
 /**
- * hash_futex - Return the hash bucket in the global hash
+ * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
  *
  * We hash on the keys returned from get_futex_key (see below) and return the
  * corresponding hash bucket in the global hash.
  */
-static struct futex_hash_bucket *hash_futex(union futex_key *key)
+static struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
 	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
@@ -885,7 +885,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
-		hb = hash_futex(&key);
+		hb = futex_hash(&key);
 
 		/*
 		 * We can race against put_pi_state() removing itself from the
@@ -1634,7 +1634,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb = hash_futex(&key);
+	hb = futex_hash(&key);
 
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
@@ -1731,8 +1731,8 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb1 = hash_futex(&key1);
-	hb2 = hash_futex(&key2);
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
 
 retry_private:
 	double_lock_hb(hb1, hb2);
@@ -2172,8 +2172,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	if (requeue_pi && match_futex(&key1, &key2))
 		return -EINVAL;
 
-	hb1 = hash_futex(&key1);
-	hb2 = hash_futex(&key2);
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
 
 retry_private:
 	hb_waiters_inc(hb2);
@@ -2415,7 +2415,7 @@ static inline struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
-	hb = hash_futex(&q->key);
+	hb = futex_hash(&q->key);
 
 	/*
 	 * Increment the counter before taking the lock so that
@@ -3177,7 +3177,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	if (ret)
 		return ret;
 
-	hb = hash_futex(&key);
+	hb = futex_hash(&key);
 	spin_lock(&hb->lock);
 
 	/*
-- 
2.33.0

