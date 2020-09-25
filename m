Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADCE27903D
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgIYSZK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 14:25:10 -0400
Received: from mail.efficios.com ([167.114.26.124]:44828 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYSZK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Sep 2020 14:25:10 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 14:25:07 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5052A2D0D2C;
        Fri, 25 Sep 2020 14:15:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pLC5afMjhLv0; Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3604C2D0F13;
        Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3604C2D0F13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601057729;
        bh=KBzjrwcEoWRVsOmvH2sliPBK4GYYXZVXbROeIPsB0Ac=;
        h=From:To:Date:Message-Id;
        b=ALdYEUMYidTLIZUyN706D2eCf3KW/gQfcrKuFBdIFX9tA+UCa/EQmZ7t+y8x999EB
         GiDe6FmjBBLI+7lt1YPW0663I6p3cKdLuAAYKtDvUDIzVpQYSciohcaVIN3Jn2pqPW
         Rht0lgHzbPWTaBelpm2BVHgGMI4+mpL57TZF/gTgtkPemiE27YekZ07h8YHpIsUlqk
         FBkOpsNgrHn2doiZL1Sueq8QJ08PV104GnI/o+ODzN2sy2OoKU1hpZWnViYYWN8UvA
         gzb7JkWz7ADTOftPBXDOSx8OhMc0/3/cZKrJQe2SiQvVBUmpHwEqJfbOYNK2ccb9Zz
         JYBhZtVYSpYyg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iIXTSJi0yRE1; Fri, 25 Sep 2020 14:15:29 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id C0F232D0C70;
        Fri, 25 Sep 2020 14:15:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
Date:   Fri, 25 Sep 2020 14:15:17 -0400
Message-Id: <20200925181518.4141-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Upstreaming efforts aiming to integrate rseq support into glibc led to
interesting discussions, where we identified a clear need to extend the
size of the per-thread structure shared between kernel and user-space
(struct rseq).  This is something that is not possible with the current
rseq ABI.  The fact that the current non-extensible rseq kernel ABI
would also prevent glibc's ABI to be extended prevents its integration
into glibc.

Discussions with glibc maintainers led to the following design, which we
are calling "Kernel Thread Local Storage" or KTLS:

- at glibc library init:
  - glibc queries the size and alignment of the KTLS area supported by the
    kernel,
  - glibc reserves the memory area required by the kernel for main
    thread,
  - glibc registers the offset from thread pointer where the KTLS area
    will be placed for all threads belonging to the threads group which
    are created with clone3 CLONE_RSEQ_KTLS,
- at nptl thread creation:
  - glibc reserves the memory area required by the kernel,
- application/libraries can query glibc for the offset/size of the
  KTLS area, and offset from the thread pointer to access that area.

The basic idea is that the kernel UAPI will define the layout of that
per-thread area, and glibc only deals with its allocation.

It should fulfill the extensibility needs for many extensions which can
benefit from a per-thread shared memory area between kernel and
user-space, e.g.:

- Exposing:
  - current NUMA node number,
  - current cpu number,
  - current user id, group id, thread id, process id, process group id, ...
  - signal block flag (fast-path for signal blocking),
  - pretty much anything a vDSO can be used for, without requiring the
    function call.

This patch implements a crude prototype of extensible rseq ABI to show
what interfaces we need to expose.  It's currently wired up using rseq
flags, turning rseq into a system call multiplexer, which was easy for a
prototype.

It should be ready for some bikeshedding on how that ABI should look
like. Is this extension using flags OK, or should this appear as new
system calls instead ?

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: "Florian Weimer <fweimer@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/kernel/process_64.c |   1 +
 include/linux/sched.h        | 122 +-----------------------
 include/linux/sched/signal.h | 150 +++++++++++++++++++++++++++++
 include/uapi/linux/rseq.h    |  16 +++-
 include/uapi/linux/sched.h   |   1 +
 kernel/fork.c                |  14 ++-
 kernel/rseq.c                | 177 +++++++++++++++++++++++++++--------
 7 files changed, 321 insertions(+), 160 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9a97415b2139..f0c822a78d01 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -670,6 +670,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 			task->thread.fsindex = 0;
 			x86_fsbase_write_task(task, arg2);
 		}
+		rseq_set_thread_pointer(task, arg2);
 		preempt_enable();
 		break;
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 683372943093..7b11ee7dee1a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1148,6 +1148,8 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+	unsigned long rseq_thread_pointer;
+	unsigned int rseq_ktls:1;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
@@ -1907,114 +1909,6 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
-#ifdef CONFIG_RSEQ
-
-/*
- * Map the event mask on the user-space ABI enum rseq_cs_flags
- * for direct mask checks.
- */
-enum rseq_event_mask_bits {
-	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
-	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
-	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
-};
-
-enum rseq_event_mask {
-	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
-	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
-	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
-};
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-	if (t->rseq)
-		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
-}
-
-void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
-
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-	if (current->rseq)
-		__rseq_handle_notify_resume(ksig, regs);
-}
-
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-	preempt_disable();
-	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	preempt_enable();
-	rseq_handle_notify_resume(ksig, regs);
-}
-
-/* rseq_preempt() requires preemption to be disabled. */
-static inline void rseq_preempt(struct task_struct *t)
-{
-	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
-}
-
-/* rseq_migrate() requires preemption to be disabled. */
-static inline void rseq_migrate(struct task_struct *t)
-{
-	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
-	rseq_set_notify_resume(t);
-}
-
-/*
- * If parent process has a registered restartable sequences area, the
- * child inherits. Unregister rseq for a clone with CLONE_VM set.
- */
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
-{
-	if (clone_flags & CLONE_VM) {
-		t->rseq = NULL;
-		t->rseq_sig = 0;
-		t->rseq_event_mask = 0;
-	} else {
-		t->rseq = current->rseq;
-		t->rseq_sig = current->rseq_sig;
-		t->rseq_event_mask = current->rseq_event_mask;
-	}
-}
-
-static inline void rseq_execve(struct task_struct *t)
-{
-	t->rseq = NULL;
-	t->rseq_sig = 0;
-	t->rseq_event_mask = 0;
-}
-
-#else
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-}
-static inline void rseq_preempt(struct task_struct *t)
-{
-}
-static inline void rseq_migrate(struct task_struct *t)
-{
-}
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
-{
-}
-static inline void rseq_execve(struct task_struct *t)
-{
-}
-
-#endif
-
 void __exit_umh(struct task_struct *tsk);
 
 static inline void exit_umh(struct task_struct *tsk)
@@ -2023,18 +1917,6 @@ static inline void exit_umh(struct task_struct *tsk)
 		__exit_umh(tsk);
 }
 
-#ifdef CONFIG_DEBUG_RSEQ
-
-void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
-{
-}
-
-#endif
-
 const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
 char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
 int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0ee5e696c5d8..22fc2a73f679 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -234,6 +234,11 @@ struct signal_struct {
 					 * updated during exec, and may have
 					 * inconsistent permissions.
 					 */
+#ifdef CONFIG_RSEQ
+	long rseq_ktls_offset;
+	unsigned int rseq_has_sig;
+	u32 rseq_sig;
+#endif
 } __randomize_layout;
 
 /*
@@ -715,4 +720,149 @@ static inline unsigned long rlimit_max(unsigned int limit)
 	return task_rlimit_max(current, limit);
 }
 
+#ifdef CONFIG_RSEQ
+
+/*
+ * Map the event mask on the user-space ABI enum rseq_cs_flags
+ * for direct mask checks.
+ */
+enum rseq_event_mask_bits {
+	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
+	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
+	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
+};
+
+enum rseq_event_mask {
+	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
+	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
+	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
+};
+
+static inline void rseq_set_notify_resume(struct task_struct *t)
+{
+	if (t->rseq_ktls || t->rseq)
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+}
+
+void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
+
+static inline void rseq_handle_notify_resume(struct ksignal *ksig,
+					     struct pt_regs *regs)
+{
+	if (current->rseq_ktls || current->rseq)
+		__rseq_handle_notify_resume(ksig, regs);
+}
+
+static inline void rseq_signal_deliver(struct ksignal *ksig,
+				       struct pt_regs *regs)
+{
+	preempt_disable();
+	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+	preempt_enable();
+	rseq_handle_notify_resume(ksig, regs);
+}
+
+/* rseq_preempt() requires preemption to be disabled. */
+static inline void rseq_preempt(struct task_struct *t)
+{
+	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
+	rseq_set_notify_resume(t);
+}
+
+/* rseq_migrate() requires preemption to be disabled. */
+static inline void rseq_migrate(struct task_struct *t)
+{
+	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
+	rseq_set_notify_resume(t);
+}
+
+/*
+ * If parent process has a registered restartable sequences area, the
+ * child inherits. Unregister rseq for a clone with CLONE_VM set.
+ */
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags,
+			     unsigned long tls)
+{
+	if (clone_flags & CLONE_VM) {
+		t->rseq = NULL;
+		t->rseq_sig = 0;
+		t->rseq_event_mask = 0;
+	} else {
+		t->rseq = current->rseq;
+		t->rseq_sig = current->rseq_sig;
+		t->rseq_event_mask = current->rseq_event_mask;
+	}
+	/*
+	 * TODO: we should also set t->rseq_thread_pointer for architectures
+	 * implementing set_thread_area.
+	 */
+	if (clone_flags & CLONE_SETTLS)
+		t->rseq_thread_pointer = tls;
+	else
+		t->rseq_thread_pointer = 0;
+	t->rseq_ktls = !!(clone_flags & CLONE_RSEQ_KTLS);
+}
+
+static inline void rseq_execve(struct task_struct *t)
+{
+	t->rseq = NULL;
+	t->rseq_sig = 0;
+	t->rseq_event_mask = 0;
+	t->rseq_ktls = false;
+	t->signal->rseq_ktls_offset = 0;
+	t->signal->rseq_has_sig = 0;
+	t->signal->rseq_sig = 0;
+}
+
+static inline void rseq_set_thread_pointer(struct task_struct *t,
+					   unsigned long thread_pointer)
+{
+	t->rseq_thread_pointer = thread_pointer;
+}
+
+#else
+
+static inline void rseq_set_notify_resume(struct task_struct *t)
+{
+}
+static inline void rseq_handle_notify_resume(struct ksignal *ksig,
+					     struct pt_regs *regs)
+{
+}
+static inline void rseq_signal_deliver(struct ksignal *ksig,
+				       struct pt_regs *regs)
+{
+}
+static inline void rseq_preempt(struct task_struct *t)
+{
+}
+static inline void rseq_migrate(struct task_struct *t)
+{
+}
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags,
+			     unsigned long tls)
+{
+}
+static inline void rseq_execve(struct task_struct *t)
+{
+}
+static inline void rseq_set_thread_pointer(struct task_struct *t,
+					   unsigned long thread_pointer)
+{
+}
+
+#endif
+
+#ifdef CONFIG_DEBUG_RSEQ
+
+void rseq_syscall(struct pt_regs *regs);
+
+#else
+
+static inline void rseq_syscall(struct pt_regs *regs)
+{
+}
+
+#endif
+
 #endif /* _LINUX_SCHED_SIGNAL_H */
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..f0fa947d6344 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -18,8 +18,22 @@ enum rseq_cpu_id_state {
 	RSEQ_CPU_ID_REGISTRATION_FAILED		= -2,
 };
 
+struct rseq_ktls_layout {
+	__u32 size;
+	__u32 alignment;
+	__u64 offset;	/* 0 if not set. */
+};
+
+struct rseq_ktls_offset {
+	__s64 offset;
+};
+
 enum rseq_flags {
-	RSEQ_FLAG_UNREGISTER = (1 << 0),
+	RSEQ_FLAG_UNREGISTER		= (1 << 0),
+	RSEQ_FLAG_GET_KTLS_LAYOUT	= (1 << 1),	/* Get ktls size, alignment, offset from thread pointer (if set). */
+	RSEQ_FLAG_SET_KTLS_OFFSET	= (1 << 2),	/* Set ktls offset from thread pointer for process. */
+	RSEQ_FLAG_SET_SIG		= (1 << 3),	/* Set rseq signature for process. */
+	RSEQ_FLAG_SET_KTLS_THREAD	= (1 << 4),	/* Set ktls enabled for thread (same as done by CLONE_RSEQ_KTLS). */
 };
 
 enum rseq_cs_flags_bit {
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..96a88899c9b4 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_RSEQ_KTLS 0x400000000ULL /* Child has rseq ktls area. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index efc5493203ae..8a68601e4384 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1604,6 +1604,12 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	sig->oom_score_adj = current->signal->oom_score_adj;
 	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
 
+#ifdef CONFIG_RSEQ
+	sig->rseq_ktls_offset = current->signal->rseq_ktls_offset;
+	sig->rseq_has_sig = current->signal->rseq_has_sig;
+	sig->rseq_sig = current->signal->rseq_sig;
+#endif
+
 	mutex_init(&sig->cred_guard_mutex);
 	mutex_init(&sig->exec_update_mutex);
 
@@ -2237,7 +2243,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
-	rseq_fork(p, clone_flags);
+	rseq_fork(p, clone_flags, args->tls);
 
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
@@ -2712,7 +2718,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP | CLONE_RSEQ_KTLS))
 		return false;
 
 	/*
@@ -2730,6 +2736,10 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	    kargs->exit_signal)
 		return false;
 
+	if ((kargs->flags & CLONE_RSEQ_KTLS) &&
+	    (!(kargs->flags & CLONE_THREAD) || !(kargs->flags & CLONE_SETTLS)))
+		return false;
+
 	if (!clone3_stack_valid(kargs))
 		return false;
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937..40d24d3e404e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -21,6 +21,18 @@
 #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
 				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
 
+static struct rseq __user *rseq_get_ktls(struct task_struct *t)
+{
+	unsigned long thread_pointer;
+	long ktls_offset;
+
+	thread_pointer = t->rseq_thread_pointer;
+	ktls_offset = t->signal->rseq_ktls_offset;
+	if (!thread_pointer || !ktls_offset)
+		return NULL;
+	return (struct rseq __user *) (thread_pointer + ktls_offset);
+}
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -117,7 +129,7 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	struct rseq_cs __user *urseq_cs;
 	u64 ptr;
 	u32 __user *usig;
-	u32 sig;
+	u32 sig, ksig;
 	int ret;
 
 	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
@@ -149,10 +161,12 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	if (ret)
 		return ret;
 
-	if (current->rseq_sig != sig) {
+	ksig = current->signal->rseq_has_sig ?
+	       current->signal->rseq_sig : current->rseq_sig;
+	if (ksig != sig) {
 		printk_ratelimited(KERN_WARNING
 			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
-			sig, current->rseq_sig, current->pid, usig);
+			sig, ksig, current->pid, usig);
 		return -EINVAL;
 	}
 	return 0;
@@ -266,7 +280,9 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
-	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
+	if (unlikely(!t->rseq && t->rseq_ktls))
+		t->rseq = rseq_get_ktls(t);
+	if (unlikely(!access_ok(t->rseq, offsetofend(struct rseq, flags))))
 		goto error;
 	ret = rseq_ip_fixup(regs);
 	if (unlikely(ret < 0))
@@ -292,44 +308,19 @@ void rseq_syscall(struct pt_regs *regs)
 	struct task_struct *t = current;
 	struct rseq_cs rseq_cs;
 
-	if (!t->rseq)
-		return;
-	if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
-	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
-		force_sig(SIGSEGV);
+	if (!t->rseq && t->rseq_ktls)
+		t->rseq = rseq_get_ktls(t);
+	if (t->rseq) {
+		if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
+		    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+			force_sig(SIGSEGV);
+	}
 }
 
 #endif
 
-/*
- * sys_rseq - setup restartable sequences for caller thread.
- */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
-		int, flags, u32, sig)
+static int rseq_register(struct rseq __user *rseq, u32 rseq_len, u32 sig)
 {
-	int ret;
-
-	if (flags & RSEQ_FLAG_UNREGISTER) {
-		if (flags & ~RSEQ_FLAG_UNREGISTER)
-			return -EINVAL;
-		/* Unregister rseq for current thread. */
-		if (current->rseq != rseq || !current->rseq)
-			return -EINVAL;
-		if (rseq_len != sizeof(*rseq))
-			return -EINVAL;
-		if (current->rseq_sig != sig)
-			return -EPERM;
-		ret = rseq_reset_rseq_cpu_id(current);
-		if (ret)
-			return ret;
-		current->rseq = NULL;
-		current->rseq_sig = 0;
-		return 0;
-	}
-
-	if (unlikely(flags))
-		return -EINVAL;
-
 	if (current->rseq) {
 		/*
 		 * If rseq is already registered, check whether
@@ -353,6 +344,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+
 	current->rseq = rseq;
 	current->rseq_sig = sig;
 	/*
@@ -364,3 +356,114 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 
 	return 0;
 }
+
+static int rseq_unregister(struct rseq __user *rseq, u32 rseq_len, u32 sig)
+{
+	int ret;
+
+	/* Unregister rseq for current thread. */
+	if (current->rseq != rseq || !current->rseq)
+		return -EINVAL;
+	if (rseq_len != sizeof(*rseq))
+		return -EINVAL;
+	if (current->rseq_sig != sig)
+		return -EPERM;
+	ret = rseq_reset_rseq_cpu_id(current);
+	if (ret)
+		return ret;
+	current->rseq = NULL;
+	current->rseq_sig = 0;
+	return 0;
+}
+
+static int rseq_get_ktls_layout(struct rseq_ktls_layout __user *ktls_layout)
+{
+	u32 size, alignment;
+	u64 offset;
+
+	size = offsetofend(struct rseq, flags);
+	alignment = __alignof__(struct rseq);
+	offset = (u64) current->signal->rseq_ktls_offset;
+
+	if (put_user(size, &ktls_layout->size))
+		return -EFAULT;
+	if (put_user(alignment, &ktls_layout->alignment))
+		return -EFAULT;
+	if (put_user(offset, &ktls_layout->offset))
+		return -EFAULT;
+	return 0;
+}
+
+static int rseq_set_ktls_offset(struct rseq_ktls_offset __user *ktls_offset)
+{
+	s64 offset;
+	int ret = 0;
+
+	if (get_user(offset, &ktls_offset->offset))
+		return -EFAULT;
+	/*
+	 * TODO: do we want to return EINVAL if a compat syscall provides
+	 * an offset larger than INT_MAX/smaller than INT_MIN on a 64-bit kernel ?
+	 */
+	if (offset > LONG_MAX || offset < LONG_MIN)
+		return -EINVAL;
+	/* Only allow setting ktls offset when single-threaded. */
+	if (get_nr_threads(current) != 1)
+		return -EBUSY;
+	if (current->signal->rseq_ktls_offset)
+		return -EBUSY;
+	current->signal->rseq_ktls_offset = (long) offset;
+	current->rseq_ktls = true;
+	/*
+	 * If rseq was previously inactive, and has just been
+	 * registered, ensure the cpu_id_start and cpu_id fields
+	 * are updated before returning to user-space.
+	 */
+	rseq_set_notify_resume(current);
+
+	return ret;
+}
+
+static int rseq_set_sig(u32 sig)
+{
+	/* Only allow setting signature when single-threaded. */
+	if (get_nr_threads(current) != 1)
+		return -EBUSY;
+	if (current->signal->rseq_has_sig)
+		return -EPERM;
+	current->signal->rseq_sig = sig;
+	current->signal->rseq_has_sig = true;
+	return 0;
+}
+
+static int rseq_set_ktls_thread(void)
+{
+	if (!rseq_get_ktls(current))
+		return -EFAULT;
+	current->rseq_ktls = true;
+	return 0;
+}
+
+/*
+ * sys_rseq - setup restartable sequences for caller thread.
+ */
+SYSCALL_DEFINE4(rseq, void __user *, uptr, u32, rseq_len,
+		int, flags, u32, sig)
+{
+	switch (flags) {
+	case 0:
+		return rseq_register((struct rseq __user *) uptr, rseq_len, sig);
+	case RSEQ_FLAG_UNREGISTER:
+		return rseq_unregister((struct rseq __user *) uptr, rseq_len, sig);
+	case RSEQ_FLAG_GET_KTLS_LAYOUT:
+		return rseq_get_ktls_layout((struct rseq_ktls_layout __user *) uptr);
+	case RSEQ_FLAG_SET_KTLS_OFFSET:
+		return rseq_set_ktls_offset((struct rseq_ktls_offset __user *) uptr);
+	case RSEQ_FLAG_SET_SIG:
+		return rseq_set_sig(sig);
+	case RSEQ_FLAG_SET_KTLS_THREAD:
+		return rseq_set_ktls_thread();
+	default:
+		return -EINVAL;
+	}
+}
-- 
2.17.1

