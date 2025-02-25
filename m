Return-Path: <linux-api+bounces-3345-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B6A44A90
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2025 19:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8677A43F5
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2025 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1A1A4E98;
	Tue, 25 Feb 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o9wu0x/Z"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE56189F57;
	Tue, 25 Feb 2025 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508573; cv=none; b=gFL71+Q9MAr1WBptP/xyr/tajqk8aWiOzx7SS8U7apbNeIJ3Vd4egLsiSS7b+9eoNgr0pS5yiGsXEDhBiDtd96pJ/QRA41jqHDFDUaBIZ/AE9YPWKRLtjXr3ComX+5a6Wjgt27wlCUvQMmmU/fXN52BfuXxsh7fTb1V20WhIgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508573; c=relaxed/simple;
	bh=XprEHY1PKqcJl864Alch3vme7EJ4cRy0TdihnbUJR0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFO3PW4EF7jwmul83HkZAsaqkAv3Jc7w9ZdI2YIjFM7hZ5lLLvaGtg0ljX3I1dxY68vePYmcnpqRqeJyUUjdi4k9iMaLNifgRFzB6D3uphtV1DotsJ+K24pvSRiwsNPh3GYvYQmadhswcIX6adpz6PvXSXaccAy4cZNDt9JlHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o9wu0x/Z; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O4EGBN0wCJHx90+QKkOJ4zGeEp3LzQZKoYRjto0MbmM=; b=o9wu0x/ZYIpoODJP0/c6aqM1Le
	VHV5kql7FS1nNFtniZAlPpfiTCsx+hSFhX89lvxsCANvB2je1qkltaxQzZZpaqUMqMf/YaZwgMX4b
	lFnKwIv6s8rLI6M2HFqBAgDhIwQwo6yrSSb1xheSy6n6tlfUcVFaEv5UVB2QL5+6NpTjzxZCArQUu
	LxobXoYmfmDz/C3BAdwjsTaX06IqRVO2ZAFrquYLPXPJFhaRDRgEZBm5wHqw01Cpn4EcZMJ6I80Ei
	/DTHOz5H72nUnSAmCz+u2BN0K7FiMrH78Rf/sqButL309V2DOjqoH5RPS6sK7c1vrkVIH/pTU03ns
	su3wbEhg==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmzmO-000WtH-KQ; Tue, 25 Feb 2025 19:35:47 +0100
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
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 2/5] futex: Create set_robust_list2
Date: Tue, 25 Feb 2025 15:35:28 -0300
Message-ID: <20250225183531.682556-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225183531.682556-1-andrealmeid@igalia.com>
References: <20250225183531.682556-1-andrealmeid@igalia.com>
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

Unaligned `head` addresses are refused by the kernel with -EINVAL.

User cannot remove lists.

* Implementation

The old syscall's set/get_robust_list() are converted to use the linked
list as well. When using only the old syscalls user shouldn't any
difference as the internal code will handle the linked list insertion as
usual. When mixing old and new interfaces users should be aware that one
of the elements of the list was created by another syscall and they
should have special care handling this element index.

On exit, the linked list is parsed and all robust lists regardless of
which interface it was used to create them are handled.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/futex.h             |   5 +-
 include/linux/sched.h             |   5 +-
 include/uapi/asm-generic/unistd.h |   4 +-
 include/uapi/linux/futex.h        |  24 +++++++
 kernel/futex/core.c               | 111 ++++++++++++++++++++++++------
 kernel/futex/futex.h              |   5 ++
 kernel/futex/syscalls.c           |  81 ++++++++++++++++++++--
 7 files changed, 205 insertions(+), 30 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 8217b5ebdd9c..39335f21aea6 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -72,10 +72,11 @@ enum {
 
 static inline void futex_init_task(struct task_struct *tsk)
 {
-	tsk->robust_list = NULL;
+	tsk->robust_list_index = -1;
 #ifdef CONFIG_COMPAT
-	tsk->compat_robust_list = NULL;
+	tsk->compat_robust_list_index = -1;
 #endif
+	INIT_LIST_HEAD(&tsk->robust_list2);
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
 	tsk->futex_state = FUTEX_STATE_OK;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 29e500d8d19d..903c1aedbe07 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1297,10 +1297,11 @@ struct task_struct {
 	u32				rmid;
 #endif
 #ifdef CONFIG_FUTEX
-	struct robust_list_head __user	*robust_list;
+	int				robust_list_index;
 #ifdef CONFIG_COMPAT
-	struct robust_list_head32 __user *compat_robust_list;
+	int				compat_robust_list_index;
 #endif
+	struct list_head		robust_list2;
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
 	struct mutex			futex_exit_mutex;
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 88dc393c2bca..477cce02ed72 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,8 +850,10 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 
+#define __NR_set_robust_list2 467
+
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 468
 
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
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3d81a53c114c..07a7e5e9bc8d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -776,9 +776,9 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
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
@@ -838,7 +838,8 @@ static void exit_robust_list64(struct task_struct *curr)
 	}
 }
 #else
-static void exit_robust_list64(struct task_struct *curr)
+static void exit_robust_list64(struct task_struct *curr,
+			      struct robust_list_head __user *head)
 {
 	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
 }
@@ -875,9 +876,9 @@ fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
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
@@ -943,6 +944,70 @@ static void exit_robust_list32(struct task_struct *curr)
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
+struct robust_list_head __user *get_robust_list2(int index, struct task_struct *task)
+{
+	struct list_head *list2 = &task->robust_list2;
+	struct robust_list2_entry *curr;
+
+	if (list_empty(list2) || index == -1)
+		return NULL;
+
+	list_for_each_entry(curr, list2, list) {
+		if (index == curr->index)
+			return curr->head;
+	}
+
+	return NULL;
+}
+
 #ifdef CONFIG_FUTEX_PI
 
 /*
@@ -1024,24 +1089,28 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 
 static void futex_cleanup(struct task_struct *tsk)
 {
-#ifdef CONFIG_64BIT
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list64(tsk);
-		tsk->robust_list = NULL;
-	}
-#else
-	if (unlikely(tsk->robust_list)) {
-		exit_robust_list32(tsk);
-		tsk->robust_list = NULL;
-	}
-#endif
+	struct robust_list2_entry *curr, *n;
+	struct list_head *list2 = &tsk->robust_list2;
 
-#ifdef CONFIG_COMPAT
-	if (unlikely(tsk->compat_robust_list)) {
-		exit_robust_list32(tsk);
-		tsk->compat_robust_list = NULL;
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
 	}
-#endif
+
+	tsk->robust_list_index = -1;
 
 	if (unlikely(!list_empty(&tsk->pi_state_list)))
 		exit_pi_state_list(tsk);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 6b2f4c7eb720..b8c20deb5552 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -409,6 +409,11 @@ extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
+extern long do_set_robust_list2(struct robust_list_head __user *head,
+			 int index, unsigned int type);
+
+extern struct robust_list_head __user *get_robust_list2(int index, struct task_struct *task);
+
 /**
  * struct futex_vector - Auxiliary struct for futex_waitv()
  * @w: Userspace provided data
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index dba193dfd216..56ee1123cbd8 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -20,6 +20,18 @@
  * the list. There can only be one such pending lock.
  */
 
+#ifdef CONFIG_64BIT
+static inline int robust_list_native_type(void)
+{
+	return ROBUST_LIST_64BIT;
+}
+#else
+static inline int robust_list_native_type(void)
+{
+	return ROBUST_LIST_32BIT;
+}
+#endif
+
 /**
  * sys_set_robust_list() - Set the robust-futex list head of a task
  * @head:	pointer to the list-head
@@ -28,17 +40,63 @@
 SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 		size_t, len)
 {
+	unsigned int type = robust_list_native_type();
+	int ret;
+
 	/*
 	 * The kernel knows only one size for now:
 	 */
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->robust_list = head;
+	ret = do_set_robust_list2(head, current->robust_list_index, type);
+	if (ret < 0)
+		return ret;
+
+	current->robust_list_index = ret;
 
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
+	if (((uintptr_t) head % sizeof(u32)) != 0)
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
@@ -52,6 +110,7 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	struct robust_list_head __user *head;
 	unsigned long ret;
 	struct task_struct *p;
+	int index;
 
 	rcu_read_lock();
 
@@ -68,9 +127,11 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->robust_list;
+	index = p->robust_list_index;
 	rcu_read_unlock();
 
+	head = get_robust_list2(index, p);
+
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(head, head_ptr);
@@ -443,10 +504,19 @@ COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct robust_list_head32 __user *, head,
 		compat_size_t, len)
 {
+	unsigned int type = ROBUST_LIST_32BIT;
+	int ret;
+
 	if (unlikely(len != sizeof(*head)))
 		return -EINVAL;
 
-	current->compat_robust_list = head;
+	ret = do_set_robust_list2((struct robust_list_head __user *) head,
+				  current->robust_list_index, type);
+	if (ret < 0)
+		return ret;
+
+	current->robust_list_index = ret;
+
 
 	return 0;
 }
@@ -458,6 +528,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	struct robust_list_head32 __user *head;
 	unsigned long ret;
 	struct task_struct *p;
+	int index;
 
 	rcu_read_lock();
 
@@ -474,9 +545,11 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->compat_robust_list;
+	index = p->compat_robust_list_index;
 	rcu_read_unlock();
 
+	head = (struct robust_list_head32 __user *) get_robust_list2(index, p);
+
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(ptr_to_compat(head), head_ptr);
-- 
2.48.1


