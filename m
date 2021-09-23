Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE2416408
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbhIWRNw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242578AbhIWRNs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C91C061574;
        Thu, 23 Sep 2021 10:12:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4B9A41F4460A
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
Subject: [PATCH v2 11/22] futex: Rename: match_futex()
Date:   Thu, 23 Sep 2021 14:11:00 -0300
Message-Id: <20210923171111.300673-12-andrealmeid@collabora.com>
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

  s/match_futex/futex_match/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a26045e17fac..30246e63e74b 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -324,13 +324,13 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 
 
 /**
- * match_futex - Check whether two futex keys are equal
+ * futex_match - Check whether two futex keys are equal
  * @key1:	Pointer to key1
  * @key2:	Pointer to key2
  *
  * Return 1 if two futex_keys are equal, 0 otherwise.
  */
-static inline int match_futex(union futex_key *key1, union futex_key *key2)
+static inline int futex_match(union futex_key *key1, union futex_key *key2)
 {
 	return (key1 && key2
 		&& key1->both.word == key2->both.word
@@ -381,7 +381,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
  * a new sequence number and will _NOT_ match, even though it is the exact same
  * file.
  *
- * It is important that match_futex() will never have a false-positive, esp.
+ * It is important that futex_match() will never have a false-positive, esp.
  * for PI futexes that can mess up the state. The above argues that false-negatives
  * are only possible for malformed programs.
  */
@@ -648,7 +648,7 @@ struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb, union futex_key *
 	struct futex_q *this;
 
 	plist_for_each_entry(this, &hb->chain, list) {
-		if (match_futex(&this->key, key))
+		if (futex_match(&this->key, key))
 			return this;
 	}
 	return NULL;
@@ -808,7 +808,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (match_futex (&this->key, &key)) {
+		if (futex_match (&this->key, &key)) {
 			if (this->pi_state || this->rt_waiter) {
 				ret = -EINVAL;
 				break;
@@ -928,7 +928,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	}
 
 	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (match_futex (&this->key, &key1)) {
+		if (futex_match (&this->key, &key1)) {
 			if (this->pi_state || this->rt_waiter) {
 				ret = -EINVAL;
 				goto out_unlock;
@@ -942,7 +942,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	if (op_ret > 0) {
 		op_ret = 0;
 		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (match_futex (&this->key, &key2)) {
+			if (futex_match (&this->key, &key2)) {
 				if (this->pi_state || this->rt_waiter) {
 					ret = -EINVAL;
 					goto out_unlock;
@@ -1199,7 +1199,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 		return -EINVAL;
 
 	/* Ensure we requeue to the expected futex. */
-	if (!match_futex(top_waiter->requeue_pi_key, key2))
+	if (!futex_match(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
 
 	/* Ensure that this does not race against an early wakeup */
@@ -1334,7 +1334,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (requeue_pi && match_futex(&key1, &key2))
+	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
 
 	hb1 = futex_hash(&key1);
@@ -1469,7 +1469,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		if (task_count - nr_wake >= nr_requeue)
 			break;
 
-		if (!match_futex(&this->key, &key1))
+		if (!futex_match(&this->key, &key1))
 			continue;
 
 		/*
@@ -1496,7 +1496,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		}
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!match_futex(this->requeue_pi_key, &key2)) {
+		if (!futex_match(this->requeue_pi_key, &key2)) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2033,7 +2033,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (match_futex(&q.key, &key2)) {
+	if (futex_match(&q.key, &key2)) {
 		futex_q_unlock(hb);
 		ret = -EINVAL;
 		goto out;
-- 
2.33.0

