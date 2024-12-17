Return-Path: <linux-api+bounces-2935-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B35929F5556
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575B21897CB8
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A561FAC26;
	Tue, 17 Dec 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BAhRt2z4"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8061FA24A;
	Tue, 17 Dec 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457838; cv=none; b=S2H7C7jJvZmkubM6aBGZHEtPTt1H0yMXfhmQ7lthrXBLuNjxq7PYZOzMPsLonRxfgLjTggo6jN4ZVPyWBKF+WQWcVG2M40QagCX3N1CmzdoFNl4P5ZJ7Av3LMpM9BMyrQWAQnzleR2NF9WMgiQXU0TXy5x6CtoUICM7qlmToxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457838; c=relaxed/simple;
	bh=jzrqXHPRri0P6rFE5fZgk5GvG91c3FyjXKbzeyhtRyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F80ShJciYlNy+8ecOjuRyVTtbGw/u9CxI9xZqtb0QGR0tQMWO6JLFhszvlPLiuu4Rz4QnZEKu18KBZyCBKd+gW0vKDp6OIidBgz5odyJePgjN1rHc7ntZWf5jgdssYGXZ+Il2dLfGV584bdvmZ+RvTHy9yzy64Z/Vk6jecgVWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BAhRt2z4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=en/1Agr+y3QLCPkhOQuxhb7wode+cza9tVICK+e8Xb8=; b=BAhRt2z4hzCjeoJcWY4a719C+D
	xRe0U8atujMGBepkqRCdYs8R6dnWcgev9wEBfpTgR9/Hgot6oeypWo1jSS2r9vvg7ojYPfob9W1RH
	eNFRO90Cw5NLtMBgJhriGa82FUhb6WiKgieiUF6Rzg/L79wXd7FMWQZpE3+r01Uv98CvVKU5c6WID
	mZfiWExzI0XXRgxaJ+9icYwUOvwmzGuDOw1zmD+3bxN2Q6qWzLpJBuYTlnPqze2lhN7qnCT0iATY8
	cHFh3q3Daa95gnZ6Ubp5FDQSHj4lMUco/WyG9nZqljL2xb03TekgjQGs6SLNVWcDscryw8m9XcUPU
	awlKEVXA==;
Received: from [179.193.1.214] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tNbhy-004TVV-KR; Tue, 17 Dec 2024 18:50:11 +0100
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
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 1/3] futex: Use explicit sizes for compat_exit_robust_list
Date: Tue, 17 Dec 2024 14:49:56 -0300
Message-ID: <20241217174958.477692-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217174958.477692-1-andrealmeid@igalia.com>
References: <20241217174958.477692-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are two functions for handling robust lists during the task
exit: exit_robust_list() and compat_exit_robust_list(). The first one
handles either 64bit or 32bit lists, depending if it's a 64bit or 32bit
kernel. The compat_exit_robust_list() only exists in 64bit kernels that
supports 32bit syscalls, and handles 32bit lists.

For the new syscall set_robust_list2(), 64bit kernels need to be able to
handle 32bit lists despite having or not support for 32bit syscalls, so
make compat_exit_robust_list() exist regardless of compat_ config.

Also, use explicitly sizing, otherwise in a 32bit kernel both
exit_robust_list() and compat_exit_robust_list() would be the exactly
same function, with none of them dealing with 64bit robust lists.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/compat.h  | 12 +----------
 include/linux/futex.h   | 11 +++++++++++
 include/linux/sched.h   |  2 +-
 kernel/futex/core.c     | 44 ++++++++++++++++++++++++++---------------
 kernel/futex/syscalls.c |  4 ++--
 5 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 56cebaff0c91..968a9135ff48 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -385,16 +385,6 @@ struct compat_ifconf {
 	compat_caddr_t  ifcbuf;
 };
 
-struct compat_robust_list {
-	compat_uptr_t			next;
-};
-
-struct compat_robust_list_head {
-	struct compat_robust_list	list;
-	compat_long_t			futex_offset;
-	compat_uptr_t			list_op_pending;
-};
-
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
@@ -672,7 +662,7 @@ asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
 		struct compat_rusage __user *);
 asmlinkage long
-compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
+compat_sys_set_robust_list(struct robust_list_head32 __user *head,
 			   compat_size_t len);
 asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..8217b5ebdd9c 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -53,6 +53,17 @@ union futex_key {
 #define FUTEX_KEY_INIT (union futex_key) { .both = { .ptr = 0ULL } }
 
 #ifdef CONFIG_FUTEX
+
+struct robust_list32 {
+	u32 next;
+};
+
+struct robust_list_head32 {
+	struct robust_list32	list;
+	s32			futex_offset;
+	u32			list_op_pending;
+};
+
 enum {
 	FUTEX_STATE_OK,
 	FUTEX_STATE_EXITING,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 66b311fbd5d6..da573c16e93e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1292,7 +1292,7 @@ struct task_struct {
 #ifdef CONFIG_FUTEX
 	struct robust_list_head __user	*robust_list;
 #ifdef CONFIG_COMPAT
-	struct compat_robust_list_head __user *compat_robust_list;
+	struct robust_list_head32 __user *compat_robust_list;
 #endif
 	struct list_head		pi_state_list;
 	struct futex_pi_state		*pi_state_cache;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ebdd76b4ecbb..cc2d0f00cd6b 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -768,13 +768,14 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
 	return 0;
 }
 
+#ifdef CONFIG_64BIT
 /*
  * Walk curr->robust_list (very carefully, it's a userspace list!)
  * and mark any locks found there dead, and notify any waiters.
  *
  * We silently return on any sign of list-walking problem.
  */
-static void exit_robust_list(struct task_struct *curr)
+static void exit_robust_list64(struct task_struct *curr)
 {
 	struct robust_list_head __user *head = curr->robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
@@ -835,8 +836,13 @@ static void exit_robust_list(struct task_struct *curr)
 				   curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
+#else
+static void exit_robust_list64(struct task_struct *curr)
+{
+	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
+}
+#endif
 
-#ifdef CONFIG_COMPAT
 static void __user *futex_uaddr(struct robust_list __user *entry,
 				compat_long_t futex_offset)
 {
@@ -850,13 +856,13 @@ static void __user *futex_uaddr(struct robust_list __user *entry,
  * Fetch a robust-list pointer. Bit 0 signals PI futexes:
  */
 static inline int
-compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
-		   compat_uptr_t __user *head, unsigned int *pi)
+fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
+		     u32 __user *head, unsigned int *pi)
 {
 	if (get_user(*uentry, head))
 		return -EFAULT;
 
-	*entry = compat_ptr((*uentry) & ~1);
+	*entry = (void __user *)(unsigned long)((*uentry) & ~1);
 	*pi = (unsigned int)(*uentry) & 1;
 
 	return 0;
@@ -868,21 +874,21 @@ compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **ent
  *
  * We silently return on any sign of list-walking problem.
  */
-static void compat_exit_robust_list(struct task_struct *curr)
+static void exit_robust_list32(struct task_struct *curr)
 {
-	struct compat_robust_list_head __user *head = curr->compat_robust_list;
+	struct robust_list_head32 __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	unsigned int next_pi;
-	compat_uptr_t uentry, next_uentry, upending;
-	compat_long_t futex_offset;
+	u32 uentry, next_uentry, upending;
+	s32 futex_offset;
 	int rc;
 
 	/*
 	 * Fetch the list head (which was registered earlier, via
 	 * sys_set_robust_list()):
 	 */
-	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
+	if (fetch_robust_entry32((u32 *)&uentry, &entry, (u32 *)&head->list.next, &pi))
 		return;
 	/*
 	 * Fetch the relative futex offset:
@@ -893,7 +899,7 @@ static void compat_exit_robust_list(struct task_struct *curr)
 	 * Fetch any possibly pending lock-add first, and handle it
 	 * if it exists:
 	 */
-	if (compat_fetch_robust_entry(&upending, &pending,
+	if (fetch_robust_entry32(&upending, &pending,
 			       &head->list_op_pending, &pip))
 		return;
 
@@ -903,8 +909,8 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		 * Fetch the next entry in the list before calling
 		 * handle_futex_death:
 		 */
-		rc = compat_fetch_robust_entry(&next_uentry, &next_entry,
-			(compat_uptr_t __user *)&entry->next, &next_pi);
+		rc = fetch_robust_entry32(&next_uentry, &next_entry,
+			(u32 __user *)&entry->next, &next_pi);
 		/*
 		 * A pending lock might already be on the list, so
 		 * dont process it twice:
@@ -935,7 +941,6 @@ static void compat_exit_robust_list(struct task_struct *curr)
 		handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
 	}
 }
-#endif
 
 #ifdef CONFIG_FUTEX_PI
 
@@ -1018,14 +1023,21 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
 
 static void futex_cleanup(struct task_struct *tsk)
 {
+#ifdef CONFIG_64BIT
 	if (unlikely(tsk->robust_list)) {
-		exit_robust_list(tsk);
+		exit_robust_list64(tsk);
 		tsk->robust_list = NULL;
 	}
+#else
+	if (unlikely(tsk->robust_list)) {
+		exit_robust_list32(tsk);
+		tsk->robust_list = NULL;
+	}
+#endif
 
 #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list)) {
-		compat_exit_robust_list(tsk);
+		exit_robust_list32(tsk);
 		tsk->compat_robust_list = NULL;
 	}
 #endif
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..dba193dfd216 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -440,7 +440,7 @@ SYSCALL_DEFINE4(futex_requeue,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
-		struct compat_robust_list_head __user *, head,
+		struct robust_list_head32 __user *, head,
 		compat_size_t, len)
 {
 	if (unlikely(len != sizeof(*head)))
@@ -455,7 +455,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
+	struct robust_list_head32 __user *head;
 	unsigned long ret;
 	struct task_struct *p;
 
-- 
2.47.1


