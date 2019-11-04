Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2224DED69D
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2019 01:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfKDA04 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 3 Nov 2019 19:26:56 -0500
Received: from git.icu ([163.172.180.134]:33480 "EHLO git.icu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfKDA04 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 3 Nov 2019 19:26:56 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Nov 2019 19:26:54 EST
Received: from shawn-LENOVO-FLEX-5-1570.guest.marinet.local (unknown [209.129.65.42])
        by git.icu (Postfix) with ESMTPSA id 35AB52202F1;
        Mon,  4 Nov 2019 00:20:09 +0000 (UTC)
From:   Shawn Landden <shawn@git.icu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shawn Landden <shawn@git.icu>,
        Keith Packard <keithp@keithp.com>
Subject: [RFC PATCH] futex: extend set_robust_list to allow 2 locking ABIs at the same time.
Date:   Sun,  3 Nov 2019 16:20:04 -0800
Message-Id: <20191104002004.25038-1-shawn@git.icu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The robust futexes ABI was designed to be flexible to changing ABIs in
glibc, however it did not take into consideration that this ABI is
particularly sticky, and suffers from lock-step problems, due to the
fact that the ABI is shared between processes. This introduces a new
size in set_robust_list that takes an additional futex_offset2 value
so that two locking ABIs can be used at the same time.

If this new ABI is used, then bit 1 of the *next pointer of the
user-space robust_list indicates that the futex_offset2 value should
be used in place of the existing futex_offset.

The use case for this is sharing locks between 32-bit and 64-bit
processes, which Linux supports, but glibc does not, and is difficult
to implement with the current Linux support because of mix-matched
ABIs. Keith Packard has complained about this:
https://keithp.com/blogs/Shared_Memory_Fences/

This can also be used to add a new ABI that uses smaller structs,
as the existing ABI on x86_64 is a minimum of 32 bytes, and 20 bytes
would suffice. (12 on 32-bit systems)

If you wants 3 ABIs (perhaps existing 32-bit, existing 64-bit, and
small) then with this patch you are out of luck, as bit 0 is already
taken to indicate PI locks.
---
 include/linux/compat.h     |   7 ++
 include/linux/sched.h      |   6 ++
 include/uapi/linux/futex.h |  31 +++++++
 kernel/futex.c             | 182 ++++++++++++++++++++++++-------------
 4 files changed, 162 insertions(+), 64 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16dafd9f4b86..4a9e6a1c2af0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -379,10 +379,17 @@ struct compat_robust_list_head {
 	struct compat_robust_list	list;
 	compat_long_t			futex_offset;
 	compat_uptr_t			list_op_pending;
 };
 
+struct compat_extended_robust_list_head {
+	struct compat_robust_list_head list_head;
+	compat_long_t			futex_offset2;
+	compat_long_t			futex_offset3;
+	compat_long_t			futex_offset4;
+};
+
 #ifdef CONFIG_COMPAT_OLD_SIGACTION
 struct compat_old_sigaction {
 	compat_uptr_t			sa_handler;
 	compat_old_sigset_t		sa_mask;
 	compat_ulong_t			sa_flags;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f51932bd543..894258fd44ac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1057,10 +1057,16 @@ struct task_struct {
 #ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
 #ifdef CONFIG_FUTEX
+    /*
+     * bottom two bits are masked
+     * 0: struct extended_robust_list_head
+     * 1: struct robust_list_head
+     * same for compat_robust_list
+     */
 	struct robust_list_head __user	*robust_list;
 #ifdef CONFIG_COMPAT
 	struct compat_robust_list_head __user *compat_robust_list;
 #endif
 	struct list_head		pi_state_list;
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..30c08e07f26b 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -92,10 +92,41 @@ struct robust_list_head {
 	 * so only truly owned locks will be handled.
 	 */
 	struct robust_list __user *list_op_pending;
 };
 
+/*
+ * Extensible per-thread list head:
+ *
+ * As locks are shared between processes, the futex_offset field
+ * has ABI lock-stepping issues, which the original robust_list_head
+ * structure did not anticipate. (And which prevents 32-bit/64-bit
+ * interoperability, as well as shrinking of mutex structures).
+ * This new extensible_robust_list_head allows multiple
+ * concurrent futex_offset values, chosen using the bottom 2 bits of the
+ * robust_list *next pointer, which are now masked in BOTH the old and
+ * new ABI.
+ *
+ * Note: this structure is part of the syscall ABI like
+ * robust_list_head above, and must have a different size than
+ * robust_list_head.
+ *
+ */
+struct extended_robust_list_head {
+	struct robust_list_head list_head;
+
+	/*
+	 * These relative offsets are set by user-space. They give the kernel
+	 * the relative position of the futex field to examine, based on the
+	 * bit 1 *next pointer.
+	 * The original version was insufficiently flexible. Locks are held
+	 * in shared memory between processes, and a process might want to hold
+	 * locks of two ABIs at the same time.
+	 */
+	long futex_offset2;
+};
+
 /*
  * Are there any waiters for this robust futex:
  */
 #define FUTEX_WAITERS		0x80000000
 
diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..b63af0fcecfc 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3396,17 +3396,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 SYSCALL_DEFINE2(set_robust_list, struct robust_list_head __user *, head,
 		size_t, len)
 {
 	if (!futex_cmpxchg_enabled)
 		return -ENOSYS;
-	/*
-	 * The kernel knows only one size for now:
-	 */
-	if (unlikely(len != sizeof(*head)))
+
+	if (unlikely(len != sizeof(struct robust_list_head) &&
+		     len != sizeof(struct extensible_robust_list_head)))
 		return -EINVAL;
 
-	current->robust_list = head;
+	current->robust_list = head & 0b11;
+	BUILD_BUG_ON(sizeof(struct robust_list_head) ==
+		     sizeof(struct extended_robust_list_head));
+	if (len == sizeof(struct robust_list_head))
+		current->robust_list |= 1;
 
 	return 0;
 }
 
 /**
@@ -3419,10 +3422,11 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
 	struct robust_list_head __user *head;
 	unsigned long ret;
+	size_t len;
 	struct task_struct *p;
 
 	if (!futex_cmpxchg_enabled)
 		return -ENOSYS;
 
@@ -3439,14 +3443,18 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->robust_list;
+	head = p->robust_list & ~0b11;
+	if (p->robust_list & 0b11 == 0b1)
+		len = sizeof(struct robust_list_head);
+	else
+		len = sizeof(struct extended_robust_list_head);
 	rcu_read_unlock();
 
-	if (put_user(sizeof(*head), len_ptr))
+	if (put_user(len, len_ptr))
 		return -EFAULT;
 	return put_user(head, head_ptr);
 
 err_unlock:
 	rcu_read_unlock();
@@ -3524,23 +3532,26 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
 
 	return 0;
 }
 
 /*
- * Fetch a robust-list pointer. Bit 0 signals PI futexes:
+ * Fetch a robust-list pointer. Bit 0 signals PI futexes. Bit 1 choses which
+ * futex_offset to use:
  */
 static inline int fetch_robust_entry(struct robust_list __user **entry,
 				     struct robust_list __user * __user *head,
-				     unsigned int *pi)
+				     unsigned int *pi,
+				     *unsigned int *second_abi)
 {
 	unsigned long uentry;
 
 	if (get_user(uentry, (unsigned long __user *)head))
 		return -EFAULT;
 
-	*entry = (void __user *)(uentry & ~1UL);
+	*entry = (void __user *)(uentry & ~0b11UL);
 	*pi = uentry & 1;
+	*second_abi = uentry & 0b10;
 
 	return 0;
 }
 
 /*
@@ -3549,69 +3560,84 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  *
  * We silently return on any sign of list-walking problem.
  */
 void exit_robust_list(struct task_struct *curr)
 {
-	struct robust_list_head __user *head = curr->robust_list;
-	struct robust_list __user *entry, *next_entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
-	unsigned long futex_offset;
+	struct robust_list_head __user *head_ptr = curr->robust_list & ~1UL;
+	unsigned int is_extended_list = curr->robust_list & 1 == 0;
+	struct extended_robust_list_head head;
+	struct robust_list __user *entry = &head->list_head.list.next,
+					   *next_entry, *pending;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip, second_abi,
+			     second_abip;
+	unsigned int uninitialized_var(next_pi),
+		     uninitialized_var(next_second_abi);
 	int rc;
 
 	if (!futex_cmpxchg_enabled)
 		return;
 
 	/*
-	 * Fetch the list head (which was registered earlier, via
-	 * sys_set_robust_list()):
+	 * fetch_robust_entry code is duplicated here to avoid excessive calls
+	 * to get_user()
 	 */
-	if (fetch_robust_entry(&entry, &head->list.next, &pi))
-		return;
-	/*
-	 * Fetch the relative futex offset:
-	 */
-	if (get_user(futex_offset, &head->futex_offset))
-		return;
-	/*
-	 * Fetch any possibly pending lock-add first, and handle it
-	 * if it exists:
-	 */
-	if (fetch_robust_entry(&pending, &head->list_op_pending, &pip))
-		return;
+	if (is_extended_list) {
+		if (get_user(head, (struct extended_robust_list_head *)
+			     head_ptr))
+			return;
+	} else {
+		if (get_user(head.list_head, head_ptr))
+			return;
+	}
+
+	pi = head.list_head.list.next & 1;
+	second_abi = head.list_head.list.next & 0b10;
+	head.list_head.list.next &= ~0b11UL;
+	pip = head.list_head.list_op_pending & 1;
+	second_abip = head.list_head.list_op_pending & 0b10;
+	head.list_head.list_op_pending &= ~0b11UL;
 
 	next_entry = NULL;	/* avoid warning with gcc */
-	while (entry != &head->list) {
+	while (entry != &head->list_head.list) {
 		/*
 		 * Fetch the next entry in the list before calling
 		 * handle_futex_death:
 		 */
-		rc = fetch_robust_entry(&next_entry, &entry->next, &next_pi);
+		rc = fetch_robust_entry(&next_entry, &entry->next, &next_pi,
+					&next_second_abi);
 		/*
 		 * A pending lock might already be on the list, so
 		 * don't process it twice:
 		 */
-		if (entry != pending)
+		if (entry != pending) {
+			long futex_offset = second_abi ?
+					    head.futex_offset2 :
+					    head.list_head.futex_offset;
 			if (handle_futex_death((void __user *)entry + futex_offset,
 						curr, pi))
 				return;
+		}
 		if (rc)
 			return;
 		entry = next_entry;
 		pi = next_pi;
+		second_abi = next_second_abi;
 		/*
 		 * Avoid excessively long or circular lists:
 		 */
 		if (!--limit)
 			break;
 
 		cond_resched();
 	}
 
-	if (pending)
+	if (pending) {
+		long futex_offset = second_abip ? head.futex_offset2 :
+						  head.list_head.futex_offset;
 		handle_futex_death((void __user *)pending + futex_offset,
 				   curr, pip);
+	}
 }
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
@@ -3707,21 +3733,25 @@ SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
 }
 
 #ifdef CONFIG_COMPAT
 /*
- * Fetch a robust-list pointer. Bit 0 signals PI futexes:
+ * Fetch a robust-list pointer. Bit 0 signals PI futexes.
+ * Bit 1 choses which futex_offset to use:
  */
 static inline int
-compat_fetch_robust_entry(compat_uptr_t *uentry, struct robust_list __user **entry,
-		   compat_uptr_t __user *head, unsigned int *pi)
+compat_fetch_robust_entry(compat_uptr_t *uentry,
+			  struct robust_list __user **entry,
+			  compat_uptr_t __user *head, unsigned int *pi,
+			  unsigned int *second_abi)
 {
 	if (get_user(*uentry, head))
 		return -EFAULT;
 
-	*entry = compat_ptr((*uentry) & ~1);
+	*entry = compat_ptr((*uentry) & ~0b11);
 	*pi = (unsigned int)(*uentry) & 1;
+	*second_abi = (unsigned int)(*uentry) & 0b10;
 
 	return 0;
 }
 
 static void __user *futex_uaddr(struct robust_list __user *entry,
@@ -3739,72 +3769,86 @@ static void __user *futex_uaddr(struct robust_list __user *entry,
  *
  * We silently return on any sign of list-walking problem.
  */
 void compat_exit_robust_list(struct task_struct *curr)
 {
-	struct compat_robust_list_head __user *head = curr->compat_robust_list;
-	struct robust_list __user *entry, *next_entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
-	unsigned int uninitialized_var(next_pi);
+	struct compat_robust_list_head __user *head = curr->compat_robust_list &
+						      ~1UL;
+	unsigned int is_extended_list = curr->compat_robust_list & 1 == 0;
+	struct compat_extended_robust_list_head head;
+	struct robust_list __user *entry = &head->list_head.list.next,
+					   *next_entry, *pending;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip, second_abi,
+			     second_abip;
+	unsigned int uninitialized_var(next_pi),
+		     uninitialized_var(next_second_abi);
 	compat_uptr_t uentry, next_uentry, upending;
-	compat_long_t futex_offset;
 	int rc;
 
 	if (!futex_cmpxchg_enabled)
 		return;
 
 	/*
-	 * Fetch the list head (which was registered earlier, via
-	 * sys_set_robust_list()):
-	 */
-	if (compat_fetch_robust_entry(&uentry, &entry, &head->list.next, &pi))
-		return;
-	/*
-	 * Fetch the relative futex offset:
-	 */
-	if (get_user(futex_offset, &head->futex_offset))
-		return;
-	/*
-	 * Fetch any possibly pending lock-add first, and handle it
-	 * if it exists:
+	 * compat_fetch_robust_entry code is duplicated here to avoid excessive
+	 * calls to get_user()
 	 */
-	if (compat_fetch_robust_entry(&upending, &pending,
-			       &head->list_op_pending, &pip))
-		return;
+	if (is_extended_list) {
+		if (get_user(head, (struct compat_extended_robust_list_head *)
+			     head_ptr))
+			return;
+	} else {
+		if (get_user(head.list_head, head_ptr))
+			return;
+	}
+
+	pi = head.list_head.list.next & 1;
+	second_abi = head.list_head.list.next & 0b10;
+	head.list_head.list.next &= ~0b11UL;
+	pip = head.list_head.list_op_pending & 1;
+	second_abip = head.list_head.list_op_pending & 0b10;
+	head.list_head.list_op_pending &= ~0b11UL;
 
 	next_entry = NULL;	/* avoid warning with gcc */
 	while (entry != (struct robust_list __user *) &head->list) {
 		/*
 		 * Fetch the next entry in the list before calling
 		 * handle_futex_death:
 		 */
 		rc = compat_fetch_robust_entry(&next_uentry, &next_entry,
-			(compat_uptr_t __user *)&entry->next, &next_pi);
+			(compat_uptr_t __user *)&entry->next, &next_pi,
+			&next_second_abi);
 		/*
 		 * A pending lock might already be on the list, so
 		 * dont process it twice:
 		 */
 		if (entry != pending) {
+			compat_long_t futex_offset = second_abi ?
+				head.futex_offset2 :
+				head.list_head.futex_offset;
 			void __user *uaddr = futex_uaddr(entry, futex_offset);
 
 			if (handle_futex_death(uaddr, curr, pi))
 				return;
 		}
 		if (rc)
 			return;
 		uentry = next_uentry;
 		entry = next_entry;
 		pi = next_pi;
+		second_abi = next_second_abi;
 		/*
 		 * Avoid excessively long or circular lists:
 		 */
 		if (!--limit)
 			break;
 
 		cond_resched();
 	}
 	if (pending) {
+		compat_long_t futex_offset = second_abip ?
+					     head.futex_offset2 :
+					     head.list_head.futex_offset;
 		void __user *uaddr = futex_uaddr(pending, futex_offset);
 
 		handle_futex_death(uaddr, curr, pip);
 	}
 }
@@ -3814,23 +3858,29 @@ COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		compat_size_t, len)
 {
 	if (!futex_cmpxchg_enabled)
 		return -ENOSYS;
 
-	if (unlikely(len != sizeof(*head)))
+	if (unlikely(len != sizeof(struct compat_robust_list_head) &&
+		     len != sizeof(struct compat_extended_robust_list_head)))
 		return -EINVAL;
 
-	current->compat_robust_list = head;
+	current->compat_robust_list = head & ~0b11;
+	BUILD_BUG_ON(sizeof(compat_robust_list_head) ==
+		     sizeof(compat_extended_robust_list_head));
+	if (len == sizeof(compat_robust_list_head))
+		current->compat_robust_list |= 0b1;
 
 	return 0;
 }
 
 COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
 	struct compat_robust_list_head __user *head;
+	size_t len;
 	unsigned long ret;
 	struct task_struct *p;
 
 	if (!futex_cmpxchg_enabled)
 		return -ENOSYS;
@@ -3848,14 +3898,18 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
 		goto err_unlock;
 
-	head = p->compat_robust_list;
+	head = p->compat_robust_list & ~0b11;
+	if (p->compat_robust_list & 0b11 == 0b1)
+		len = sizeof(struct compat_robust_list_head);
+	else
+		len = sizeof(struct compat_extended_robust_list_head);
 	rcu_read_unlock();
 
-	if (put_user(sizeof(*head), len_ptr))
+	if (put_user(len, len_ptr))
 		return -EFAULT;
 	return put_user(ptr_to_compat(head), head_ptr);
 
 err_unlock:
 	rcu_read_unlock();
-- 
2.20.1

