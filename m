Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDB40C73B
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhIOOTZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhIOOTK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE9C061575;
        Wed, 15 Sep 2021 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=okI2FK1N300YT0sokvHtq1dM4yskPwK72COTI7AEgXE=; b=hCKy1PJJ6Khpy8uofJWpBoGe+a
        qwzXluoQaCs/5tjj1puxi1YK5VjnTQrGQTg2usfdDRm86FSTvmjRxGuZB91n6y/wm/HPj73P0qO5t
        92VH9F1lmn0Xt510WVwtuNmC+v3jv6M4wOw513maxADrkyokf6QN2ebWKu/L5XpLKH2+OKB5s2/25
        TMmFO7Zu/4rQPPgrP6y5vbnEtu92B9dW0asIbmcYM9L4IGx9bnOnuTOltBQKiglbYIdRxdxxjTAGH
        4V7/s8WGA4FZKkmPWNATJQHFnkX6dVGTmkxgt/bfomAiCq1jYckNgpX+wrBDnv+hM7ChlyV5fzKYf
        PhH+sGxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVjA-003PU0-6P; Wed, 15 Sep 2021 14:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 229B3300BFA;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 12F4D28B2AE83; Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Message-ID: <20210915141525.292466778@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 11/20] futex: Rename: match_futex()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename:

  s/match_futex/futex_match/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -324,13 +324,13 @@ static struct futex_hash_bucket *futex_h
 
 
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
@@ -381,7 +381,7 @@ futex_setup_timer(ktime_t *time, struct
  * a new sequence number and will _NOT_ match, even though it is the exact same
  * file.
  *
- * It is important that match_futex() will never have a false-positive, esp.
+ * It is important that futex_match() will never have a false-positive, esp.
  * for PI futexes that can mess up the state. The above argues that false-negatives
  * are only possible for malformed programs.
  */
@@ -648,7 +648,7 @@ struct futex_q *futex_top_waiter(struct
 	struct futex_q *this;
 
 	plist_for_each_entry(this, &hb->chain, list) {
-		if (match_futex(&this->key, key))
+		if (futex_match(&this->key, key))
 			return this;
 	}
 	return NULL;
@@ -808,7 +808,7 @@ int futex_wake(u32 __user *uaddr, unsign
 	spin_lock(&hb->lock);
 
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (match_futex (&this->key, &key)) {
+		if (futex_match (&this->key, &key)) {
 			if (this->pi_state || this->rt_waiter) {
 				ret = -EINVAL;
 				break;
@@ -928,7 +928,7 @@ int futex_wake_op(u32 __user *uaddr1, un
 	}
 
 	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (match_futex (&this->key, &key1)) {
+		if (futex_match (&this->key, &key1)) {
 			if (this->pi_state || this->rt_waiter) {
 				ret = -EINVAL;
 				goto out_unlock;
@@ -942,7 +942,7 @@ int futex_wake_op(u32 __user *uaddr1, un
 	if (op_ret > 0) {
 		op_ret = 0;
 		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (match_futex (&this->key, &key2)) {
+			if (futex_match (&this->key, &key2)) {
 				if (this->pi_state || this->rt_waiter) {
 					ret = -EINVAL;
 					goto out_unlock;
@@ -1199,7 +1199,7 @@ futex_proxy_trylock_atomic(u32 __user *p
 		return -EINVAL;
 
 	/* Ensure we requeue to the expected futex. */
-	if (!match_futex(top_waiter->requeue_pi_key, key2))
+	if (!futex_match(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
 
 	/* Ensure that this does not race against an early wakeup */
@@ -1334,7 +1334,7 @@ int futex_requeue(u32 __user *uaddr1, un
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (requeue_pi && match_futex(&key1, &key2))
+	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
 
 	hb1 = futex_hash(&key1);
@@ -1469,7 +1469,7 @@ int futex_requeue(u32 __user *uaddr1, un
 		if (task_count - nr_wake >= nr_requeue)
 			break;
 
-		if (!match_futex(&this->key, &key1))
+		if (!futex_match(&this->key, &key1))
 			continue;
 
 		/*
@@ -1496,7 +1496,7 @@ int futex_requeue(u32 __user *uaddr1, un
 		}
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!match_futex(this->requeue_pi_key, &key2)) {
+		if (!futex_match(this->requeue_pi_key, &key2)) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2043,7 +2043,7 @@ int futex_wait_requeue_pi(u32 __user *ua
 	 * The check above which compares uaddrs is not sufficient for
 	 * shared futexes. We need to compare the keys:
 	 */
-	if (match_futex(&q.key, &key2)) {
+	if (futex_match(&q.key, &key2)) {
 		futex_q_unlock(hb);
 		ret = -EINVAL;
 		goto out;


