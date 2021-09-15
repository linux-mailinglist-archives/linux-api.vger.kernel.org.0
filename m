Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9479840C739
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhIOOTY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhIOOTJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CFC061768;
        Wed, 15 Sep 2021 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2TouwGuRosA9M+9D83wcAihUaqIUcvjdUETwCQK0SrQ=; b=FNfz8knk9pY6xgl97qulwEy0wK
        ayFHYUWmeUY4U9+fF0ksuj/iONIFJuGhvWg8HS1abts7242tOkoTmQBpr0fX8XVhntQBCcVLqlKCE
        fSEjzmpWykUjTWvKuXOib/O8puDTnWxVyqZiMo9yZElQ1/fvsq/Ahw+eVVK0e2X5hlBaO3fX75Kvx
        6k//GXgx3zav8oDm6Kc0ABcHntqA5D7GUXsvrRdOY8Mh1QDGxr9v+Rs8dt2zQuCPbMr14+i1LTgMx
        gF1GKkgFLiZ33BKADt7rEjO1sk9Ah+PYKNVd9e+RApIlXhmGoSzZNEyqxMgySb0bc3/HyCfEWY/dl
        t0FXIhOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVj8-003PTm-L9; Wed, 15 Sep 2021 14:17:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C2703005DD;
        Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E9DA8234E53A2; Wed, 15 Sep 2021 16:17:28 +0200 (CEST)
Message-ID: <20210915141524.864163835@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 04/20] futex: Rename futex_wait_queue_me()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/futex_wait_queue_me/futex_wait_queue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -2787,12 +2787,12 @@ static int fixup_owner(u32 __user *uaddr
 }
 
 /**
- * futex_wait_queue_me() - futex_queue() and wait for wakeup, timeout, or signal
+ * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
  * @hb:		the futex hash bucket, must be locked by the caller
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
-static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
+static void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 				struct hrtimer_sleeper *timeout)
 {
 	/*
@@ -2919,7 +2919,7 @@ int futex_wait(u32 __user *uaddr, unsign
 		goto out;
 
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
@@ -3347,7 +3347,7 @@ int handle_early_requeue_pi_wakeup(struc
  * without one, the pi logic would not know which task to boost/deboost, if
  * there was a need to.
  *
- * We call schedule in futex_wait_queue_me() when we enqueue and return there
+ * We call schedule in futex_wait_queue() when we enqueue and return there
  * via the following--
  * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
  * 2) wakeup on uaddr2 after a requeue
@@ -3427,7 +3427,7 @@ int futex_wait_requeue_pi(u32 __user *ua
 	}
 
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue(hb, &q, to);
 
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:


