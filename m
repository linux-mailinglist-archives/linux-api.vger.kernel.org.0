Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC94163FA
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbhIWRNX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbhIWRNS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:13:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF0C061757;
        Thu, 23 Sep 2021 10:11:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C74871F44601
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
Subject: [PATCH v2 04/22] futex: Rename futex_wait_queue_me()
Date:   Thu, 23 Sep 2021 14:10:53 -0300
Message-Id: <20210923171111.300673-5-andrealmeid@collabora.com>
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

  s/futex_wait_queue_me/futex_wait_queue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 91f94b45c2e8..e70e81c61ea2 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -2787,12 +2787,12 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
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
@@ -2919,7 +2919,7 @@ int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time
 		goto out;
 
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
@@ -3347,7 +3347,7 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
  * without one, the pi logic would not know which task to boost/deboost, if
  * there was a need to.
  *
- * We call schedule in futex_wait_queue_me() when we enqueue and return there
+ * We call schedule in futex_wait_queue() when we enqueue and return there
  * via the following--
  * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
  * 2) wakeup on uaddr2 after a requeue
@@ -3427,7 +3427,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	}
 
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue(hb, &q, to);
 
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
-- 
2.33.0

