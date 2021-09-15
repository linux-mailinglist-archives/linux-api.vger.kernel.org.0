Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DCE40C738
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhIOOTY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhIOOTJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD89C061767;
        Wed, 15 Sep 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VrroTDTwM4RqFgB0GaKTnqAE2sLybUVZaM8+76ZHCJ8=; b=K9HGLVhlEHla6KwuXqDyxV790F
        BbimmY2aZWN4rwv2XRXzfjdNDtvFTllVFrMBXXYjWcipgEp+/F0wEAOg9As10qh+wXKHvLM/vqMRd
        KoNbC9JpU63zJvC0WMi6VSjul3VUwb0KST3/rz+Yhko1GsmbhFPT8RStpj3nTSsXpAAaTtOtxEonw
        1T2mLZV79J8fshQlXvJ8NwOF7mgzXGTo6zHyy7zBzLuyTcqQTF6sIv3OycYp5xX2PNvtc3NOLueko
        aQToFjU4lez1fC7AicfH9SHVrkx29Q42vtL7qblYgUlGoDnaSeutUkOlFeq0thxYo+ZI6Tf9FkFv5
        UVi7E++Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj9-003PTt-Fl; Wed, 15 Sep 2021 14:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 188A7300772;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F1FD2234E53A4; Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Message-ID: <20210915141524.985747253@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 06/20] futex: Rename __unqueue_futex()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename:

  s/__unqueue_futex/__futex_unqueue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1470,12 +1470,12 @@ static int futex_lock_pi_atomic(u32 __us
 }
 
 /**
- * __unqueue_futex() - Remove the futex_q from its futex_hash_bucket
+ * __futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
  *
  * The q->lock_ptr must not be NULL and must be held by the caller.
  */
-static void __unqueue_futex(struct futex_q *q)
+static void __futex_unqueue(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
@@ -1502,13 +1502,13 @@ static void mark_wake_futex(struct wake_
 		return;
 
 	get_task_struct(p);
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr = NULL
 	 * is written, without taking any locks. This is possible in the event
 	 * of a spurious wakeup, for example. A memory barrier is required here
 	 * to prevent the following store to lock_ptr from getting ahead of the
-	 * plist_del in __unqueue_futex().
+	 * plist_del in __futex_unqueue().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
 
@@ -1958,7 +1958,7 @@ void requeue_pi_wake_futex(struct futex_
 {
 	q->key = *key;
 
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter = NULL;
@@ -2522,7 +2522,7 @@ static int futex_unqueue(struct futex_q
 			spin_unlock(lock_ptr);
 			goto retry;
 		}
-		__unqueue_futex(q);
+		__futex_unqueue(q);
 
 		BUG_ON(q->pi_state);
 
@@ -2539,7 +2539,7 @@ static int futex_unqueue(struct futex_q
  */
 static void futex_unqueue_pi(struct futex_q *q)
 {
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);


