Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733053E1C0C
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 21:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhHETEy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 15:04:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242712AbhHETEq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 15:04:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 363781F4431D
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/4] futex: Prepare for futex_wait_multiple()
Date:   Thu,  5 Aug 2021 16:04:02 -0300
Message-Id: <20210805190405.59110-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805190405.59110-1-andrealmeid@collabora.com>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Make public functions and defines that will be used for
futex_wait_multiple() function in next commit.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 include/linux/futex.h | 60 +++++++++++++++++++++++++++++++++++++++++++
 kernel/futex.c        | 42 +-----------------------------
 2 files changed, 61 insertions(+), 41 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..f7a0f4a4b5f0 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -11,6 +11,22 @@ struct inode;
 struct mm_struct;
 struct task_struct;
 
+/*
+ * Futex flags used to encode options to functions and preserve them across
+ * restarts.
+ */
+#ifdef CONFIG_MMU
+# define FLAGS_SHARED		0x01
+#else
+/*
+ * NOMMU does not have per process address space. Let the compiler optimize
+ * code away.
+ */
+# define FLAGS_SHARED		0x00
+#endif
+#define FLAGS_CLOCKRT		0x02
+#define FLAGS_HAS_TIMEOUT	0x04
+
 /*
  * Futexes are matched on equal values of this key.
  * The key type depends on whether it's a shared or private mapping.
@@ -50,8 +66,52 @@ union futex_key {
 	} both;
 };
 
+/**
+ * struct futex_q - The hashed futex queue entry, one per waiting task
+ * @list:		priority-sorted list of tasks waiting on this futex
+ * @task:		the task waiting on the futex
+ * @lock_ptr:		the hash bucket lock
+ * @key:		the key the futex is hashed on
+ * @pi_state:		optional priority inheritance state
+ * @rt_waiter:		rt_waiter storage for use with requeue_pi
+ * @requeue_pi_key:	the requeue_pi target futex key
+ * @bitset:		bitset for the optional bitmasked wakeup
+ *
+ * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
+ * we can wake only the relevant ones (hashed queues may be shared).
+ *
+ * A futex_q has a woken state, just like tasks have TASK_RUNNING.
+ * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
+ * The order of wakeup is always to make the first condition true, then
+ * the second.
+ *
+ * PI futexes are typically woken before they are removed from the hash list via
+ * the rt_mutex code. See unqueue_me_pi().
+ */
+struct futex_q {
+	struct plist_node list;
+
+	struct task_struct *task;
+	spinlock_t *lock_ptr;
+	union futex_key key;
+	struct futex_pi_state *pi_state;
+	struct rt_mutex_waiter *rt_waiter;
+	union futex_key *requeue_pi_key;
+	u32 bitset;
+} __randomize_layout;
+
 #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = 0ULL } }
 
+static const struct futex_q futex_q_init = {
+	/* list gets initialized in queue_me()*/
+	.key = FUTEX_KEY_INIT,
+	.bitset = FUTEX_BITSET_MATCH_ANY
+};
+
+inline struct hrtimer_sleeper *
+futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
+		  int flags, u64 range_ns);
+
 #ifdef CONFIG_FUTEX
 enum {
 	FUTEX_STATE_OK,
diff --git a/kernel/futex.c b/kernel/futex.c
index 2ecb07575055..c07cb0f747ac 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -187,46 +187,6 @@ struct futex_pi_state {
 	union futex_key key;
 } __randomize_layout;
 
-/**
- * struct futex_q - The hashed futex queue entry, one per waiting task
- * @list:		priority-sorted list of tasks waiting on this futex
- * @task:		the task waiting on the futex
- * @lock_ptr:		the hash bucket lock
- * @key:		the key the futex is hashed on
- * @pi_state:		optional priority inheritance state
- * @rt_waiter:		rt_waiter storage for use with requeue_pi
- * @requeue_pi_key:	the requeue_pi target futex key
- * @bitset:		bitset for the optional bitmasked wakeup
- *
- * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
- * we can wake only the relevant ones (hashed queues may be shared).
- *
- * A futex_q has a woken state, just like tasks have TASK_RUNNING.
- * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
- * The order of wakeup is always to make the first condition true, then
- * the second.
- *
- * PI futexes are typically woken before they are removed from the hash list via
- * the rt_mutex code. See unqueue_me_pi().
- */
-struct futex_q {
-	struct plist_node list;
-
-	struct task_struct *task;
-	spinlock_t *lock_ptr;
-	union futex_key key;
-	struct futex_pi_state *pi_state;
-	struct rt_mutex_waiter *rt_waiter;
-	union futex_key *requeue_pi_key;
-	u32 bitset;
-} __randomize_layout;
-
-static const struct futex_q futex_q_init = {
-	/* list gets initialized in queue_me()*/
-	.key = FUTEX_KEY_INIT,
-	.bitset = FUTEX_BITSET_MATCH_ANY
-};
-
 /*
  * Hash buckets are shared by all the futex_keys that hash to the same
  * location.  Each key may have multiple futex_q structures, one for each task
@@ -395,7 +355,7 @@ enum futex_access {
  * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
  *	   value given
  */
-static inline struct hrtimer_sleeper *
+inline struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns)
 {
-- 
2.32.0

