Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5780240C750
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhIOOVc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbhIOOVb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:21:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FAC061767;
        Wed, 15 Sep 2021 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=La+hf0vJBNy6S7MTvtjn6LOMAENF5HinzPbs7/AaNU4=; b=ICa1Opq2c+gyCikBEoG4JLBNo2
        oKrugn+1jPCjvzCNlO3l9ImQesRAYQsXvCuwY37wKdtH/sAQU31XriJvfoXo8P85ySGtE0ND3kjSK
        0YV+YMVD+AgyfHwjWsj48wK0gJfqxZJjnE/ocRTEZ4qhcDbleiHEUJlLz4kPeFwEjiZecE4t5CHN7
        0/nwc3aRASp1UiAild1mduyzZjTcMrSDjeZlgqUmBDlUft0MH2ZAwz4Nmfrk/pJRd/MjulY2cOKz9
        +zcbeidkIeToNzpvV0xrlA6F2DxSlR2R+1uob66iL2s0PCEriaJ1ln0jXIFEi0sA74/6X1iXIhdmQ
        KXM0rXaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj9-00Fk3j-Ec; Wed, 15 Sep 2021 14:17:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A40300B7B;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 01E22234E53A5; Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Message-ID: <20210915141525.047819744@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 07/20] futex: Rename hash_futex()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename:

  s/hash_futex/hash_futex/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

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
@@ -380,13 +380,13 @@ static inline int hb_waiters_pending(str
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
@@ -885,7 +885,7 @@ static void exit_pi_state_list(struct ta
 		next = head->next;
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
-		hb = hash_futex(&key);
+		hb = futex_hash(&key);
 
 		/*
 		 * We can race against put_pi_state() removing itself from the
@@ -1634,7 +1634,7 @@ int futex_wake(u32 __user *uaddr, unsign
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb = hash_futex(&key);
+	hb = futex_hash(&key);
 
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
@@ -1731,8 +1731,8 @@ int futex_wake_op(u32 __user *uaddr1, un
 	if (unlikely(ret != 0))
 		return ret;
 
-	hb1 = hash_futex(&key1);
-	hb2 = hash_futex(&key2);
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
 
 retry_private:
 	double_lock_hb(hb1, hb2);
@@ -2172,8 +2172,8 @@ int futex_requeue(u32 __user *uaddr1, un
 	if (requeue_pi && match_futex(&key1, &key2))
 		return -EINVAL;
 
-	hb1 = hash_futex(&key1);
-	hb2 = hash_futex(&key2);
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
 
 retry_private:
 	hb_waiters_inc(hb2);
@@ -2415,7 +2415,7 @@ static inline struct futex_hash_bucket *
 {
 	struct futex_hash_bucket *hb;
 
-	hb = hash_futex(&q->key);
+	hb = futex_hash(&q->key);
 
 	/*
 	 * Increment the counter before taking the lock so that
@@ -3177,7 +3177,7 @@ int futex_unlock_pi(u32 __user *uaddr, u
 	if (ret)
 		return ret;
 
-	hb = hash_futex(&key);
+	hb = futex_hash(&key);
 	spin_lock(&hb->lock);
 
 	/*


