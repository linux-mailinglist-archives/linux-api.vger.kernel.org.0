Return-Path: <linux-api+bounces-2655-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD6C9B952F
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2024 17:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A741F22BD0
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2024 16:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FF51CB51F;
	Fri,  1 Nov 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MHyMrJcK"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A71DA53;
	Fri,  1 Nov 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478150; cv=none; b=k6CzQsRsxWnJGJac3NFfXgK4hHz69Pfug6oBUh8jEhQWaNzpBlwemxcMLXms33udJASdqJcHu8Be2R/i+ix9E0SBn+MijVd5HjLH/EsrkcIjZuJsk+Z82IISnNlL0bLOBBX3KAahRIRkMh1VH1Ijwhn9/xW+2VawOtzR49FuloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478150; c=relaxed/simple;
	bh=FVyZ7eBuxWRN1YC2s9Hb1Rk8ZThQS9W1LOo/mSM4scM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euvOCfHZLI/CBx03QoTypy+ZahH7dnKBcUqRAYU9q7D4oWeeZ28vgS/1fQZ6SKxfqb2LHVAnGF4I9/JgZtG3p24RWGL+9xYrwhtm/Ch7mir4nGmSAIJ1f0Sfp5gkEoM3LCWTqbRMWjLdeA8xFm4ti6IWeiQo+vfUSEKx5oy2KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MHyMrJcK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BRMLY+YGywDTXYOJD65N5/JKgnbdcNU20/19myILcu8=; b=MHyMrJcKbVPgCUFm4LNs2yRcfS
	E72E1Lc6bvw/fQujQhVfX+jnbmW3oPk5DY8s05/OHhsKsYsd2cS+jBwnK2z+v/uLLkHYLelS19vOY
	YSTpjQ+FlrwHDH4/KQJEhGTgAktl4TX8MtOV7U6dxe2UqGb/Cg7j2id9RVEm7HdAHH4apPPlLrLJN
	LTMU70xaKzQ5P/mrqR2IY4G+n1Wg1vgCBR4vJ1Q1rU5h90xrlw1ArWI/XxHvoPgl3g4qgRzhCB+CT
	SwSj1htmjTEb+dZheW0zcJ6zZvNtHc+POBylWCYADXKhxFpIWDcHfTFT8TCkK7rRcJW3sUL4SrVdd
	6J39y9kw==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uPT-000UVX-Pn; Fri, 01 Nov 2024 17:22:04 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 2/3] futex: Create set_robust_list2
Date: Fri,  1 Nov 2024 13:21:46 -0300
Message-ID: <20241101162147.284993-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101162147.284993-1-andrealmeid@igalia.com>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a new robust_list() syscall. The current syscall can't be
expanded to cover the following use case, so a new one is needed. This
new syscall allows users to set multiple robust lists per process and to
have either 32bit or 64bit pointers in the list.

* Interface

This is the proposed interface:

	long set_robust_list2(void *head, int index, unsigned int flags)

`head` is the head of the userspace struct robust_list_head, just as old
set_robust_list(). It needs to be a void pointer since it can point to a
normal robust_list_head or a compat_robust_list_head.

`flags` can be used for defining the list type:

	enum robust_list_type {
	 	ROBUST_LIST_32BIT,
		ROBUST_LIST_64BIT,
	 };

`index` is the index in the internal robust_list's linked list (the
naming starts to get confusing, I reckon). If `index == -1`, that means
that user wants to set a new robust_list, and the kernel will append it
in the end of the list, assign a new index and return this index to the
user. If `index >= 0`, that means that user wants to re-set `*head` of
an already existing list (similarly to what happens when you call
set_robust_list() twice with different `*head`).

If `index` is out of range, or it points to a non-existing robust_list,
or if the internal list is full, an error is returned.

User cannot remove lists.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/futex.h             |  1 +
 include/linux/sched.h             |  1 +
 include/uapi/asm-generic/unistd.h |  5 +-
 include/uapi/linux/futex.h        | 24 +++++++++
 init/init_task.c                  |  3 ++
 kernel/futex/core.c               | 85 ++++++++++++++++++++++++++++---
 kernel/futex/futex.h              |  3 ++
 kernel/futex/syscalls.c           | 36 +++++++++++++
 8 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 8217b5ebdd9c..997fe0013bc0 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -76,6 +76,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 #ifdef CONFIG_COMPAT
 	tsk->compat_robust_list = NULL;
 #endif
+	INIT_LIST_HEAD(&tsk->robust_list2);
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
 	tsk->futex_state = FUTEX_STATE_OK;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8f20b703557d..4a2455f1b07c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1284,6 +1284,7 @@ struct task_struct {
 #ifdef CONFIG_COMPAT
 	struct robust_list_head32 __user *compat_robust_list;
 #endif
+	struct list_head		robust_list2;
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
 	struct mutex			futex_exit_mutex;
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 5bf6148cac2b..c1f5c9635c07 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -841,8 +841,11 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
 
+#define __NR_set_robust_list2 463
+__SYSCALL(__NR_set_robust_list2, sys_set_robust_list2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625ea189..13903a278b71 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -146,6 +146,30 @@ struct robust_list_head {
 	struct robust_list __user *list_op_pending;
 };
 
+#define ROBUST_LISTS_PER_TASK 10
+
+enum robust_list2_type {
+	ROBUST_LIST_32BIT,
+	ROBUST_LIST_64BIT,
+};
+
+#define ROBUST_LIST_TYPE_MASK (ROBUST_LIST_32BIT | ROBUST_LIST_64BIT)
+
+/*
+ * This is an entry of a linked list of robust lists.
+ *
+ * @head: can point to a 64bit list or a 32bit list
+ * @list_type: determine the size of the futex pointers in the list
+ * @index: the index of this entry in the list
+ * @list: linked list element
+ */
+struct robust_list2_entry {
+	void __user *head;
+	enum robust_list2_type list_type;
+	unsigned int index;
+	struct list_head list;
+};
+
 /*
  * Are there any waiters for this robust futex:
  */
diff --git a/init/init_task.c b/init/init_task.c
index 136a8231355a..1b08e745c47d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -219,6 +219,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_FUTEX
+	.robust_list2 = LIST_HEAD_INIT(init_task.robust_list2),
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index bcd0e2a7ba65..f74476d0bcc1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -797,9 +797,9 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list64(struct task_struct *curr)
+static void exit_robust_list64(struct task_struct *curr,
+			       struct robust_list_head __user *head)
 {
-	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -859,7 +859,8 @@ static void exit_robust_list64(struct task_struct *curr)
 	}
 }
 #else
-static void exit_robust_list64(struct task_struct *curr)
+static void exit_robust_list64(struct task_struct *curr,
+			      struct robust_list_head __user *head)
 {
 	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
 	return;
@@ -897,9 +898,9 @@ fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list32(struct task_struct *curr)
+static void exit_robust_list32(struct task_struct *curr,
+			       struct robust_list_head32 __user *head)
 {
-	struct robust_list_head32 __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -965,6 +966,54 @@ static void exit_robust_list32(struct task_struct *curr)
 	}
 }
 
+long do_set_robust_list2(struct robust_list_head __user *head,
+			 int index, unsigned int type)
+{
+	struct list_head *list2 = &current->robust_list2;
+	struct robust_list2_entry *prev, *new = NULL;
+
+	if (index == -1) {
+		if (list_empty(list2)) {
+			index = 0;
+		} else {
+			prev = list_last_entry(list2, struct robust_list2_entry, list);
+			index = prev->index + 1;
+		}
+
+		if (index >= ROBUST_LISTS_PER_TASK)
+			return -EINVAL;
+
+		new = kmalloc(sizeof(struct robust_list2_entry), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		list_add_tail(&new->list, list2);
+		new->index = index;
+
+	} else if (index >= 0) {
+		struct robust_list2_entry *curr;
+
+		if (list_empty(list2))
+			return -ENOENT;
+
+		list_for_each_entry(curr, list2, list) {
+			if (index == curr->index) {
+				new = curr;
+				break;
+			}
+		}
+
+		if (!new)
+			return -ENOENT;
+	}
+
+	BUG_ON(!new);
+	new->head = head;
+	new->list_type = type;
+
+	return index;
+}
+
 #ifdef CONFIG_FUTEX_PI
 
 /*
@@ -1046,24 +1095,44 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 
 static void futex_cleanup(struct task_struct *tsk)
 {
+	struct robust_list2_entry *curr, *n;
+	struct list_head *list2 = &tsk->robust_list2;
+
 #ifdef CONFIG_64BIT
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list64(tsk);
+		exit_robust_list64(tsk, tsk->robust_list);
 		tsk->robust_list = NULL;
 	}
 #else
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list32(tsk);
+		exit_robust_list32(tsk, (struct robust_list_head32 *) tsk->robust_list);
 		tsk->robust_list = NULL;
 	}
 #endif
 
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list)) {
-		exit_robust_list32(tsk);
+		exit_robust_list32(tsk, tsk->compat_robust_list);
 		tsk->compat_robust_list = NULL;
 	}
 #endif
+	/*
+	 * Walk through the linked list, parsing robust lists and freeing the
+	 * allocated lists
+	 */
+	if (unlikely(!list_empty(list2))) {
+		list_for_each_entry_safe(curr, n, list2, list) {
+			if (curr->head != NULL) {
+				if (curr->list_type == ROBUST_LIST_64BIT)
+					exit_robust_list64(tsk, curr->head);
+				else if (curr->list_type == ROBUST_LIST_32BIT)
+					exit_robust_list32(tsk, curr->head);
+				curr->head = NULL;
+			}
+			list_del_init(&curr->list);
+			kfree(curr);
+		}
+	}
 
 	if (unlikely(!list_empty(&tsk->pi_state_list)))
 		exit_pi_state_list(tsk);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 8b195d06f4e8..7247d5c583d5 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -349,6 +349,9 @@ extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
+extern long do_set_robust_list2(struct robust_list_head __user *head,
+			 int index, unsigned int type);
+
 /**
  * struct futex_vector - Auxiliary struct for futex_waitv()
  * @w: Userspace provided data
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index dba193dfd216..ff61570bb9c8 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,42 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 	return 0;
 }
 
+#define ROBUST_LIST_FLAGS ROBUST_LIST_TYPE_MASK
+
+/*
+ * sys_set_robust_list2()
+ *
+ * When index == -1, create a new list for user. When index >= 0, try to find
+ * the corresponding list and re-set the head there.
+ *
+ * Return values:
+ *  >= 0: success, index of the robust list
+ *  -EINVAL: invalid flags, invalid index
+ *  -ENOENT: requested index no where to be found
+ *  -ENOMEM: error allocating new list
+ *  -ESRCH: too many allocated lists
+ */
+SYSCALL_DEFINE3(set_robust_list2, struct robust_list_head __user *, head,
+		int, index, unsigned int, flags)
+{
+	unsigned int type;
+
+	type = flags & ROBUST_LIST_TYPE_MASK;
+
+	if (index < -1 || index >= ROBUST_LISTS_PER_TASK)
+		return -EINVAL;
+
+	if ((flags & ~ROBUST_LIST_FLAGS) != 0)
+		return -EINVAL;
+
+#ifndef CONFIG_64BIT
+	if (type == ROBUST_LIST_64BIT)
+		return -EINVAL;
+#endif
+
+	return do_set_robust_list2(head, index, type);
+}
+
 /**
  * sys_get_robust_list() - Get the robust-futex list head of a task
  * @pid:	pid of the process [zero for current task]
-- 
2.47.0


