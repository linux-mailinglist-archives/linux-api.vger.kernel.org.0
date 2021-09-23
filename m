Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD56A4163FD
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbhIWRN1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbhIWRNZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2CC061574;
        Thu, 23 Sep 2021 10:11:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 041D81F44603
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
Subject: [PATCH v2 06/22] futex: Rename __unqueue_futex()
Date:   Thu, 23 Sep 2021 14:10:55 -0300
Message-Id: <20210923171111.300673-7-andrealmeid@collabora.com>
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

  s/__unqueue_futex/__futex_unqueue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 63cf0da2e413..88541fba57ea 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1470,12 +1470,12 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
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
 
@@ -1502,13 +1502,13 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
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
 
@@ -1958,7 +1958,7 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 {
 	q->key = *key;
 
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter = NULL;
@@ -2522,7 +2522,7 @@ static int futex_unqueue(struct futex_q *q)
 			spin_unlock(lock_ptr);
 			goto retry;
 		}
-		__unqueue_futex(q);
+		__futex_unqueue(q);
 
 		BUG_ON(q->pi_state);
 
@@ -2539,7 +2539,7 @@ static int futex_unqueue(struct futex_q *q)
  */
 static void futex_unqueue_pi(struct futex_q *q)
 {
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
-- 
2.33.0

