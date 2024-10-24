Return-Path: <linux-api+bounces-2557-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD29AEA31
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8831F23C92
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C801DD0E6;
	Thu, 24 Oct 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eNaGIIhP"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9921E3788;
	Thu, 24 Oct 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783112; cv=none; b=aAEIvKx9BMrc6ybphWu3htMboVdCZTRzZEzRIRHPaSBeURuReV2n3sCldUsRzZ5yed6fAfW7mlJMua+4Mql2KZwmsu3OzNT8oewA2RR+CbvQ1YQsRc52468Z2LGP9QY3dT5EorlCGiZQniAD5v5j+A07x3CyoRJQGjw/5N8WN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783112; c=relaxed/simple;
	bh=pmLwSYLVGlIs8FHAU3boUHgfaoGHuLvTW+0az+sFLJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCbGDwMLrwodEhAnnyUk3kJ6cBS23aBKFVsQTBZZckGgdxdLDHDVeaoQQdvbzecxObDf6Qr7tMhWGLmFLrsGz1bawjHWkWhgAX/HEAJS3nk1hmcWvjUo1jAqhsIiwR74Z6EAm9V84z2OEBXftvYc/gLhoKwrYI1VmoWN+1ivIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eNaGIIhP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1TPp39SYM1KkiaD08U+lIvA39BF8Qe5aRQcbu/ubRGY=; b=eNaGIIhPk1uFcJbivQomQZ84UP
	TGbAXqPyZpSTZRC5G9TWFJ7o4hel2V7xmlpRudb/V63WmIPWEJjgjmya+Ip8IDMwr/7cuqO6qUlN7
	wE0XdG+9wSQ7/UuBKVl1G23QFcqafOEXQs+0Z57kaCrCKLKAONorsWnFtQp7DftIrfuEgHradnTuP
	XVYDzk1Kpc1Xb8z7vn0uE33imILZXIb3rOPRfmEnBGH4cQFe7p73b2J1Pt3upJIfMJ7xHals/yYye
	+VnUl9036XuLCADwyeabU9WcYRSFWUczG95ZHBzzsT8AmofIegHvvegUurcEDmbqNNd27odXl7Ml4
	l9LcNnhg==;
Received: from [177.172.124.83] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t3zHe-00EXrz-Nx; Thu, 24 Oct 2024 16:57:55 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RFC 1/1] futex: Create set_robust_list2
Date: Thu, 24 Oct 2024 11:57:35 -0300
Message-ID: <20241024145735.162090-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024145735.162090-1-andrealmeid@igalia.com>
References: <20241024145735.162090-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This new syscall allows to set multiple list to the same process. There
are two list types: 32 and 64 bit lists.

It supports up to 10 lists per process (see ROBUST_LISTS_PER_TASK). The
lists are dynamically allocated on demand, as part of a linked list.
This is the proposed interface:

	long set_robust_list2(void *head, int index, unsigned int flags)

Userspace can ask to set the head of a new list using (index = -1).
Kernel will allocate a new list, place in the linked list and return the
new index to userspace.

Userspace can modify an existing head by using an index >= 0. If the
requested list doesn't exist, an error is returned.

Userspace cannot remove a robust list.

For now, flag is for the list type:

	enum robust_list_type {
	 	ROBUST_LIST_32BIT,
		ROBUST_LIST_64BIT,
	 };

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm/tools/syscall.tbl             |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/futex.h                  |  1 +
 include/linux/sched.h                  |  1 +
 include/uapi/asm-generic/unistd.h      |  5 +-
 include/uapi/linux/futex.h             | 24 +++++++++
 init/init_task.c                       |  3 ++
 kernel/futex/core.c                    | 34 +++++++++---
 kernel/futex/syscalls.c                | 72 ++++++++++++++++++++++++++
 scripts/syscall.tbl                    |  1 +
 10 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 23c98203c40f..31070d427ea2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -477,3 +477,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	set_robust_list2		sys_set_robust_list2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7093ee21c0d1..fbc0cef1a97c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -386,6 +386,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	common	set_robust_list2	sys_set_robust_list2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..9c5ab84f86a9 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -65,6 +65,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 #ifdef CONFIG_COMPAT
 	tsk->compat_robust_list = NULL;
 #endif
+	INIT_LIST_HEAD(&tsk->robust_list2);
 	INIT_LIST_HEAD(&tsk->pi_state_list);
 	tsk->pi_state_cache = NULL;
 	tsk->futex_state = FUTEX_STATE_OK;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 449dd64ed9ac..5f72fe66add6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1284,6 +1284,7 @@ struct task_struct {
 #ifdef CONFIG_COMPAT
 	struct compat_robust_list_head __user *compat_robust_list;
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
index 136768ae2637..d71b4b9630f7 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -796,9 +796,8 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list(struct task_struct *curr)
+static void exit_robust_list(struct task_struct *curr, struct robust_list_head __user *head)
 {
-	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -858,7 +857,6 @@ static void exit_robust_list(struct task_struct *curr)
 	}
 }
 
-#ifdef CONFIG_COMPAT
 static void __user *futex_uaddr(struct robust_list __user *entry,
 				compat_long_t futex_offset)
 {
@@ -890,9 +888,9 @@ compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **ent
  *
  * We silently return on any sign of list-walking problem.
  */
-static void compat_exit_robust_list(struct task_struct *curr)
+static void compat_exit_robust_list(struct task_struct *curr,
+				    struct compat_robust_list_head __user *head)
 {
-	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
@@ -957,7 +955,6 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
-#endif
 
 #ifdef CONFIG_FUTEX_PI
 
@@ -1040,14 +1037,35 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 
 static void futex_cleanup(struct task_struct *tsk)
 {
+	struct robust_list2_entry *curr, *n;
+	struct list_head *list2 = &tsk->robust_list2;
+
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
+		exit_robust_list(tsk, tsk->robust_list);
 		tsk->robust_list = NULL;
 	}
 
+	/*
+	 * Walk through the linked list, parsing robust lists and freeing the
+	 * allocated lists
+	 */
+	if (unlikely(!list_empty(list2))) {
+		list_for_each_entry_safe(curr, n, list2, list) {
+			if (curr->head != NULL) {
+				if (curr->list_type == ROBUST_LIST_64BIT)
+					exit_robust_list(tsk, curr->head);
+				else if (curr->list_type == ROBUST_LIST_32BIT)
+					compat_exit_robust_list(tsk, curr->head);
+				curr->head = NULL;
+			}
+			list_del_init(&curr->list);
+			kfree(curr);
+		}
+	}
+
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
+		compat_exit_robust_list(tsk, tsk->compat_robust_list);
 		tsk->compat_robust_list = NULL;
 	}
 #endif
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..2853de204f9b 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,78 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
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
+	struct list_head *list2 = &current->robust_list2;
+	struct robust_list2_entry *prev, *new = NULL;
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
 /**
  * sys_get_robust_list() - Get the robust-futex list head of a task
  * @pid:	pid of the process [zero for current task]
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 845e24eb372e..e174f6e2d521 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -403,3 +403,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	set_robust_list2		sys_set_robust_list2
-- 
2.47.0


