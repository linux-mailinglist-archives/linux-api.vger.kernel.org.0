Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8D409B3D
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhIMRyY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbhIMRyX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 13:54:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFAC061574;
        Mon, 13 Sep 2021 10:53:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B783C1F42CE6
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
Subject: [PATCH v3 1/6] futex: Prepare for futex_wait_multiple()
Date:   Mon, 13 Sep 2021 14:52:44 -0300
Message-Id: <20210913175249.81074-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913175249.81074-1-andrealmeid@collabora.com>
References: <20210913175249.81074-1-andrealmeid@collabora.com>
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
 kernel/futex.c | 134 +---------------------------------------------
 kernel/futex.h | 140 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 132 deletions(-)
 create mode 100644 kernel/futex.h

diff --git a/kernel/futex.c b/kernel/futex.c
index c15ad276fd15..32c91f9d7385 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -34,14 +34,11 @@
 #include <linux/compat.h>
 #include <linux/jhash.h>
 #include <linux/pagemap.h>
-#include <linux/syscalls.h>
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
-#include <linux/time_namespace.h>
-
-#include <asm/futex.h>
 
+#include "futex.h"
 #include "locking/rtmutex_common.h"
 
 /*
@@ -150,22 +147,6 @@
 static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 
-/*
- * Futex flags used to encode options to functions and preserve them across
- * restarts.
- */
-#ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x01
-#else
-/*
- * NOMMU does not have per process address space. Let the compiler optimize
- * code away.
- */
-# define FLAGS_SHARED		0x00
-#endif
-#define FLAGS_CLOCKRT		0x02
-#define FLAGS_HAS_TIMEOUT	0x04
-
 /*
  * Priority Inheritance state:
  */
@@ -187,103 +168,6 @@ struct futex_pi_state {
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
- * @requeue_state:	State field for futex_requeue_pi()
- * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
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
-	atomic_t requeue_state;
-#ifdef CONFIG_PREEMPT_RT
-	struct rcuwait requeue_wait;
-#endif
-} __randomize_layout;
-
-/*
- * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
- * underlying rtmutex. The task which is about to be requeued could have
- * just woken up (timeout, signal). After the wake up the task has to
- * acquire hash bucket lock, which is held by the requeue code.  As a task
- * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
- * and the hash bucket lock blocking would collide and corrupt state.
- *
- * On !PREEMPT_RT this is not a problem and everything could be serialized
- * on hash bucket lock, but aside of having the benefit of common code,
- * this allows to avoid doing the requeue when the task is already on the
- * way out and taking the hash bucket lock of the original uaddr1 when the
- * requeue has been completed.
- *
- * The following state transitions are valid:
- *
- * On the waiter side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
- *
- * On the requeue side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
- *
- * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
- * signals that the waiter is already on the way out. It also means that
- * the waiter is still on the 'wait' futex, i.e. uaddr1.
- *
- * The waiter side signals early wakeup to the requeue side either through
- * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
- * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
- * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
- * which means the wakeup is interleaving with a requeue in progress it has
- * to wait for the requeue side to change the state. Either to DONE/LOCKED
- * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
- * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
- * the requeue side when the requeue attempt failed via deadlock detection
- * and therefore the waiter q is still on the uaddr1 futex.
- */
-enum {
-	Q_REQUEUE_PI_NONE		=  0,
-	Q_REQUEUE_PI_IGNORE,
-	Q_REQUEUE_PI_IN_PROGRESS,
-	Q_REQUEUE_PI_WAIT,
-	Q_REQUEUE_PI_DONE,
-	Q_REQUEUE_PI_LOCKED,
-};
-
-static const struct futex_q futex_q_init = {
-	/* list gets initialized in queue_me()*/
-	.key		= FUTEX_KEY_INIT,
-	.bitset		= FUTEX_BITSET_MATCH_ANY,
-	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
-};
 
 /*
  * Hash buckets are shared by all the futex_keys that hash to the same
@@ -453,7 +337,7 @@ enum futex_access {
  * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
  *	   value given
  */
-static inline struct hrtimer_sleeper *
+inline struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns)
 {
@@ -4005,20 +3889,6 @@ static __always_inline bool futex_cmd_has_timeout(u32 cmd)
 	return false;
 }
 
-static __always_inline int
-futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
-{
-	if (!timespec64_valid(ts))
-		return -EINVAL;
-
-	*t = timespec64_to_ktime(*ts);
-	if (cmd == FUTEX_WAIT)
-		*t = ktime_add_safe(ktime_get(), *t);
-	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
-		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
-	return 0;
-}
-
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		const struct __kernel_timespec __user *, utime,
 		u32 __user *, uaddr2, u32, val3)
diff --git a/kernel/futex.h b/kernel/futex.h
new file mode 100644
index 000000000000..c914e0080cf1
--- /dev/null
+++ b/kernel/futex.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FUTEX_H
+#define _FUTEX_H
+
+#include <asm/futex.h>
+
+#include <linux/syscalls.h>
+#include <linux/time_namespace.h>
+
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
+	atomic_t requeue_state;
+#ifdef CONFIG_PREEMPT_RT
+	struct rcuwait requeue_wait;
+#endif
+} __randomize_layout;
+
+/*
+ * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
+ * underlying rtmutex. The task which is about to be requeued could have
+ * just woken up (timeout, signal). After the wake up the task has to
+ * acquire hash bucket lock, which is held by the requeue code.  As a task
+ * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
+ * and the hash bucket lock blocking would collide and corrupt state.
+ *
+ * On !PREEMPT_RT this is not a problem and everything could be serialized
+ * on hash bucket lock, but aside of having the benefit of common code,
+ * this allows to avoid doing the requeue when the task is already on the
+ * way out and taking the hash bucket lock of the original uaddr1 when the
+ * requeue has been completed.
+ *
+ * The following state transitions are valid:
+ *
+ * On the waiter side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
+ *
+ * On the requeue side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
+ *
+ * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
+ * signals that the waiter is already on the way out. It also means that
+ * the waiter is still on the 'wait' futex, i.e. uaddr1.
+ *
+ * The waiter side signals early wakeup to the requeue side either through
+ * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
+ * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
+ * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
+ * which means the wakeup is interleaving with a requeue in progress it has
+ * to wait for the requeue side to change the state. Either to DONE/LOCKED
+ * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
+ * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
+ * the requeue side when the requeue attempt failed via deadlock detection
+ * and therefore the waiter q is still on the uaddr1 futex.
+ */
+enum {
+	Q_REQUEUE_PI_NONE		=  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
+static const struct futex_q futex_q_init = {
+	/* list gets initialized in queue_me()*/
+	.key            = FUTEX_KEY_INIT,
+	.bitset         = FUTEX_BITSET_MATCH_ANY,
+	.requeue_state  = ATOMIC_INIT(Q_REQUEUE_PI_NONE),
+};
+
+inline struct hrtimer_sleeper *
+futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
+		  int flags, u64 range_ns);
+
+static __always_inline int
+futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
+{
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+
+	*t = timespec64_to_ktime(*ts);
+	if (cmd == FUTEX_WAIT)
+		*t = ktime_add_safe(ktime_get(), *t);
+	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
+		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
+	return 0;
+}
+
+#endif
-- 
2.33.0

