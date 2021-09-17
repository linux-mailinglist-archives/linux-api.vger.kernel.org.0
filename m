Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE140FEF4
	for <lists+linux-api@lfdr.de>; Fri, 17 Sep 2021 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbhIQSFA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Sep 2021 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245326AbhIQSE4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Sep 2021 14:04:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E0C061764
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w6so6699396pll.3
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDs5GPxSUS2/njgfRoraCjkWwzgWX70bNHf96npeeVE=;
        b=XyfEkAzyw+xb2ozUgZ2A+8hs4JP4dz91M3FXK74hc8NfeF4TA0LveP4Kc3RpmjM18V
         ivyRHuvoXcPw8R5Ft4qkgNRW1P23dBeFXw/4uPgLo4YcPFVDNZhosgFxuOYKInHujZYG
         0GP4oZZlbtJY9LnFYzCViplaV5J5e60Xfc9KmiEPEuOz1hFdMHhQjfmFgKj8MpSmETSn
         Wnu/uf/50tZR5aK7L4rTTwJCxSwoAyM6W+5isWpLwGYhKsJnu+16X2GvLNeDmr8NPu9d
         ysjIriOQ01gTAJ4Mx0+/Sk5cRoWV7se8Snc07mo+F9n0iS87nHoB0i8pJIT1Gaax2g3R
         RMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDs5GPxSUS2/njgfRoraCjkWwzgWX70bNHf96npeeVE=;
        b=F2CBtfv566YZqUf9pDr2XiZVqYCRb3j0faHJ6vUEkMp6DrHZDQ7+FGh0qExxedIJ3j
         X4gcADy3bEhQvQsruGyTHodXthsOHFRz6G08M51lWFEqrDCHYNBsKeZ1zGYqPwCsBAy4
         8cIG7BiVZIFLu4FTEV94ZnF5oeG0S1KwnWg0SMyUiX/9Us0o7INLccSzefrNKsWN2J8l
         1aYuKVi0IERSaa073w5ihjua5qRvyxazCN958GES3wwIF8VgfmDWBL/U97gEbt2kwAQo
         LIkGFvn+LR2NnGkRxrncv50gTNH5mFsEFd6eu88zQlvU6SVoX5KEpXXdxhNYzW6Azmg8
         5T5Q==
X-Gm-Message-State: AOAM531RRFWt5Kob4ko82uPTSfRlTWM43KOVipaNewM+WaHNjT8gpDsz
        RTIyalq8JVPLd+iCHYBngpce/Q==
X-Google-Smtp-Source: ABdhPJxcC1C1BT5KaBBR0YgWpkqwVlXaFGZ3pEfSn+OPhtemY3r1Wv87ixiUQjw4YvcV4cx1nlwGdQ==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr13791773pjr.2.1631901813094;
        Fri, 17 Sep 2021 11:03:33 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b24sm5781773pfi.205.2021.09.17.11.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 11:03:32 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH 3/5 v0.6] sched/umcg: RFC: implement UMCG syscalls
Date:   Fri, 17 Sep 2021 11:03:21 -0700
Message-Id: <20210917180323.278250-4-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917180323.278250-1-posk@google.com>
References: <20210917180323.278250-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Define struct umcg_task and two syscalls: sys_umcg_ctl sys_umcg_wait.

All key operations, such as wait/wake/context-switch, as well as
timeouts and block/wake detection, are working quite reliably.

In addition, the userspace can now force the kernel to preempt
a running worker by changing its state from RUNNING to
RUNNING | PREEMPTED and sending a signal to it. This new functionality
is less well tested than the key operations above, but is working
well in the common case of the worker busy in the userspace.

These big things remain to be addressed (in no particular order):
- tracing/debugging
- faster context switches (see umcg_do_context_switch in umcg.c)
- other architectures (we will need at least arm64 in addition to amd64)
- tools/lib/umcg for userspace
- kselftests

I'm working on finalizing libumcg and kselftests.

See Documentation/userspace-api/umcg.[txt|rst] for API usage and
other details.

v0.5->v0.6 changes:
- umcg_task pages are now pinned for RUNNING workers;
- waking workers now wait for the userspace to schedule them
  in exit_to_user_mode_loop() instead of in sched_update_worker();
- added umcg_clear_child to fork and execve;
- changed current->umcg_task assignments to WRITE_ONCE;
- server/worker interactions are restricted to tasks in the same mm;

v0.4->v0.5 changes:
- handling idle workers and servers is now much simpler on the kernel
  side, thanks to Thierry Delisle's suggestion:
  https://lore.kernel.org/lkml/3530714d-125b-e0f5-45b2-72695e2fc4ee@uwaterloo.ca/
- minor tweaks to improve preemption handling;

v0.3->v0.4 changes:
- removed server_tid and api_version fields from struct umcg_task;
- added timeout handling to sys_umcg_wait();
- implemented worker preemption via signals;
- handling idle workers and servers is changed again (see umcg.rst).

v0.2->v0.3 changes:
- the overall approach is now based on peterz@'s suggestion in
  https://lore.kernel.org/patchwork/cover/1433967/
  (should I add Suggested-by?)
- new protocol for working with idle workers and servers is used, to avoid
  spinning in the kernel;
- waking a UMCG task now does not require spinning.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/exec.c                              |   1 +
 include/linux/sched.h                  |  56 ++
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 117 ++++
 init/Kconfig                           |  10 +
 kernel/entry/common.c                  |   1 +
 kernel/exit.c                          |   2 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  15 +-
 kernel/sched/umcg.c                    | 745 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   4 +
 13 files changed, 963 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ce18119ea0d0..0c6c7fd72b0b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -368,6 +368,8 @@
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
+447	common	umcg_ctl		sys_umcg_ctl
+448	common	umcg_wait		sys_umcg_wait

 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..d652ef8017b2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1835,6 +1835,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	umcg_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 549018e46801..4cf9070d1361 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -66,6 +66,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;

 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1230,6 +1231,12 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif

+#ifdef CONFIG_UMCG
+	struct umcg_task __user	*umcg_task;
+	struct page		*pinned_umcg_worker_page;  /* self */
+	struct page		*pinned_umcg_server_page;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;

 	union {
@@ -1606,6 +1613,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_UMCG_WORKER		0x01000000	/* UMCG worker */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
@@ -2191,6 +2199,54 @@ static inline void rseq_execve(struct task_struct *t)

 #endif

+#ifdef CONFIG_UMCG
+
+void umcg_handle_resuming_worker(void);
+void umcg_handle_exiting_worker(void);
+void umcg_clear_child(struct task_struct *tsk);
+
+/* Called by bprm_execve() in fs/exec.c. */
+static inline void umcg_execve(struct task_struct *tsk)
+{
+	if (tsk->umcg_task)
+		umcg_clear_child(tsk);
+}
+
+/* Called by exit_to_user_mode_loop() in kernel/entry/common.c.*/
+static inline void umcg_handle_notify_resume(void)
+{
+	if (current->flags & PF_UMCG_WORKER)
+		umcg_handle_resuming_worker();
+}
+
+/* Called by do_exit() in kernel/exit.c. */
+static inline void umcg_handle_exit(void)
+{
+	if (current->flags & PF_UMCG_WORKER)
+		umcg_handle_exiting_worker();
+}
+
+/*
+ * umcg_wq_worker_[sleeping|running] are called in core.c by
+ * sched_submit_work() and sched_update_worker().
+ */
+void umcg_wq_worker_sleeping(struct task_struct *tsk);
+void umcg_wq_worker_running(struct task_struct *tsk);
+
+#else
+
+static inline void umcg_execve(struct task_struct *tsk)
+{
+}
+static inline void umcg_handle_notify_resume(void)
+{
+}
+static inline void umcg_handle_exit(void)
+{
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_RSEQ

 void rseq_syscall(struct pt_regs *regs);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..f3e1ef8d842f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct umcg_task;

 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1050,6 +1051,9 @@ asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr _
 asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
+asmlinkage long sys_umcg_ctl(u32 flags, struct umcg_task __user *self);
+asmlinkage long sys_umcg_wait(u32 flags, u64 abs_timeout);
+

 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6de5a7fc066b..1a4c9ac0e296 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -873,8 +873,14 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 #define __NR_landlock_restrict_self 446
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)

+#define __NR_umcg_ctl 447
+__SYSCALL(__NR_umcg_ctl, sys_umcg_ctl)
+#define __NR_umcg_wait 448
+__SYSCALL(__NR_umcg_wait, sys_umcg_wait)
+
+
 #undef __NR_syscalls
-#define __NR_syscalls 447
+#define __NR_syscalls 449

 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
new file mode 100644
index 000000000000..edce804781f9
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UMCG_H
+#define _UAPI_LINUX_UMCG_H
+
+#include <linux/limits.h>
+#include <linux/types.h>
+
+/*
+ * UMCG: User Managed Concurrency Groups.
+ *
+ * Syscalls (see kernel/sched/umcg.c):
+ *      sys_umcg_ctl()  - register/unregister UMCG tasks;
+ *      sys_umcg_wait() - wait/wake/context-switch.
+ *
+ * struct umcg_task (below): controls the state of UMCG tasks.
+ *
+ * See Documentation/userspace-api/umcg.[txt|rst] for detals.
+ */
+
+/*
+ * UMCG task states, the first 8 bits. The states represent the user space
+ * point of view.
+ */
+#define UMCG_TASK_NONE			0
+#define UMCG_TASK_RUNNING		1
+#define UMCG_TASK_IDLE			2
+#define UMCG_TASK_BLOCKED		3
+
+/* The first byte: RUNNING, IDLE, or BLOCKED. */
+#define UMCG_TASK_STATE_MASK		0xff
+
+/* UMCG task state flags, bits 8-15 */
+
+/*
+ * UMCG_TF_LOCKED: locked by the userspace in preparation to calling umcg_wait.
+ */
+#define UMCG_TF_LOCKED			(1 << 8)
+
+/*
+ * UMCG_TF_PREEMPTED: the userspace indicates the worker should be preempted.
+ */
+#define UMCG_TF_PREEMPTED		(1 << 9)
+
+/**
+ * struct umcg_task - controls the state of UMCG tasks.
+ *
+ * The struct is aligned at 64 bytes to ensure that it fits into
+ * a single cache line.
+ */
+struct umcg_task {
+	/**
+	 * @state: the current state of the UMCG task described by this struct.
+	 *
+	 * Readable/writable by both the kernel and the userspace.
+	 *
+	 * UMCG task state:
+	 *   bits  0 -  7: task state;
+	 *   bits  8 - 15: state flags;
+	 *   bits 16 - 23: reserved; must be zeroes;
+	 *   bits 24 - 31: for userspace use.
+	 */
+	uint32_t	state;			/* r/w */
+
+	/**
+	 * @next_tid: the TID of the UMCG task that should be context-switched
+	 *            into in sys_umcg_wait(). Can be zero.
+	 *
+	 * Running UMCG workers must have next_tid set to point to IDLE
+	 * UMCG servers.
+	 *
+	 * Read-only for the kernel, read/write for the userspace.
+	 */
+	uint32_t	next_tid;		/* r   */
+
+	/**
+	 * @idle_workers_ptr: a single-linked list of idle workers. Can be NULL.
+	 *
+	 * Readable/writable by both the kernel and the userspace: the
+	 * kernel adds items to the list, the userspace removes them.
+	 */
+	uint64_t	idle_workers_ptr;	/* r/w */
+
+	/**
+	 * @idle_server_tid_ptr: a pointer pointing to a single idle server.
+	 *                       Readonly.
+	 */
+	uint64_t	idle_server_tid_ptr;	/* r   */
+} __attribute__((packed, aligned(8 * sizeof(__u64))));
+
+/**
+ * enum umcg_ctl_flag - flags to pass to sys_umcg_ctl
+ * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
+ * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
+ * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
+ */
+enum umcg_ctl_flag {
+	UMCG_CTL_REGISTER	= 0x00001,
+	UMCG_CTL_UNREGISTER	= 0x00002,
+	UMCG_CTL_WORKER		= 0x10000,
+};
+
+/**
+ * enum umcg_wait_flag - flags to pass to sys_umcg_wait
+ * @UMCG_WAIT_WAKE_ONLY:      wake @self->next_tid, don't put @self to sleep;
+ * @UMCG_WAIT_WF_CURRENT_CPU: wake @self->next_tid on the current CPU
+ *                            (use WF_CURRENT_CPU); @UMCG_WAIT_WAKE_ONLY
+ *                            must be set.
+ */
+enum umcg_wait_flag {
+	UMCG_WAIT_WAKE_ONLY			= 1,
+	UMCG_WAIT_WF_CURRENT_CPU		= 2,
+};
+
+/* See Documentation/userspace-api/umcg.[txt|rst].*/
+#define UMCG_IDLE_NODE_PENDING (1ULL)
+
+#endif /* _UAPI_LINUX_UMCG_H */
diff --git a/init/Kconfig b/init/Kconfig
index a61c92066c2e..c15a50a61ba6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1662,6 +1662,16 @@ config MEMBARRIER

 	  If unsure, say Y.

+config UMCG
+	bool "Enable User Managed Concurrency Groups API"
+	depends on X86_64
+	default n
+	help
+	  Enable User Managed Concurrency Groups API, which form the basis
+	  for an in-process M:N userspace scheduling framework.
+	  At the moment this is an experimental/RFC feature that is not
+	  guaranteed to be backward-compatible.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bf16395b9e13..f3cd335ab513 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -173,6 +173,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,

 		if (ti_work & _TIF_NOTIFY_RESUME) {
 			tracehook_notify_resume(regs);
+			umcg_handle_notify_resume();  /* might sleep */
 			rseq_handle_notify_resume(NULL, regs);
 		}

diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..fdd4e923cca9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -744,6 +744,8 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");

+	umcg_handle_exit();
+
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfca5871..e4e481eee1b7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
 obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_UMCG) += umcg.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12a9d053e724..c9133cf153b9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4159,6 +4159,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+#ifdef CONFIG_UMCG
+	umcg_clear_child(p);
+#endif
 }

 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6105,10 +6108,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
 	 * requires it.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		preempt_disable();
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
+#ifdef CONFIG_UMCG
+		else if (task_flags & PF_UMCG_WORKER)
+			umcg_wq_worker_sleeping(tsk);
+#endif
 		else
 			io_wq_worker_sleeping(tsk);
 		preempt_enable_no_resched();
@@ -6127,9 +6134,13 @@ static inline void sched_submit_work(struct task_struct *tsk)

 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
+#ifdef CONFIG_UMCG
+		else if (tsk->flags & PF_UMCG_WORKER)
+			umcg_wq_worker_running(tsk);
+#endif
 		else
 			io_wq_worker_running(tsk);
 	}
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
new file mode 100644
index 000000000000..aa4dbb31c425
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,745 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ *
+ * See Documentation/userspace-api/umcg.[txt|rst] for detals.
+ */
+
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/umcg.h>
+
+#include "sched.h"
+#include "umcg_uaccess.h"
+
+/**
+ * umcg_pin_pages: pin pages containing struct umcg_task of this worker
+ *                 and its server.
+ *
+ * The pages are pinned when the worker exits to the userspace and unpinned
+ * when the worker is in sched_submit_work(), i.e. when the worker is
+ * about to be removed from its runqueue. Thus at most NR_CPUS UMCG pages
+ * are pinned at any one time across the whole system.
+ */
+static int umcg_pin_pages(u32 server_tid)
+{
+	struct umcg_task __user *worker_ut = current->umcg_task;
+	struct umcg_task __user *server_ut = NULL;
+	struct task_struct *tsk;
+
+	rcu_read_lock();
+	tsk = find_task_by_vpid(server_tid);
+	if (tsk)
+		server_ut = READ_ONCE(tsk->umcg_task);
+	rcu_read_unlock();
+
+	if (!server_ut)
+		return -EINVAL;
+
+	if (READ_ONCE(current->mm) != READ_ONCE(tsk->mm))
+		return -EINVAL;
+
+	tsk = current;
+
+	/* worker_ut is stable, don't need to repin */
+	if (!tsk->pinned_umcg_worker_page)
+		if (1 != pin_user_pages_fast((unsigned long)worker_ut, 1, 0,
+					&tsk->pinned_umcg_worker_page))
+			return -EFAULT;
+
+	/* server_ut may change, need to repin */
+	if (tsk->pinned_umcg_server_page) {
+		unpin_user_page(tsk->pinned_umcg_server_page);
+		tsk->pinned_umcg_server_page = NULL;
+	}
+
+	if (1 != pin_user_pages_fast((unsigned long)server_ut, 1, 0,
+				&tsk->pinned_umcg_server_page))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void umcg_unpin_pages(void)
+{
+	struct task_struct *tsk = current;
+
+	if (tsk->pinned_umcg_worker_page)
+		unpin_user_page(tsk->pinned_umcg_worker_page);
+	if (tsk->pinned_umcg_server_page)
+		unpin_user_page(tsk->pinned_umcg_server_page);
+
+	tsk->pinned_umcg_worker_page = NULL;
+	tsk->pinned_umcg_server_page = NULL;
+}
+
+static void umcg_clear_task(struct task_struct *tsk)
+{
+	/*
+	 * This is either called for the current task, or for a newly forked
+	 * task that is not yet running, so we don't need strict atomicity
+	 * below.
+	 */
+	if (tsk->umcg_task) {
+		WRITE_ONCE(tsk->umcg_task, NULL);
+
+		/* These can be simple writes - see the commment above. */
+		tsk->pinned_umcg_worker_page = NULL;
+		tsk->pinned_umcg_server_page = NULL;
+		tsk->flags &= ~PF_UMCG_WORKER;
+	}
+}
+
+/* Called for a forked or execve-ed child. */
+void umcg_clear_child(struct task_struct *tsk)
+{
+	umcg_clear_task(tsk);
+}
+
+/* Called both by normally (unregister) and abnormally exiting workers. */
+void umcg_handle_exiting_worker(void)
+{
+	umcg_unpin_pages();
+	umcg_clear_task(current);
+}
+
+/**
+ * sys_umcg_ctl: (un)register the current task as a UMCG task.
+ * @flags:       ORed values from enum umcg_ctl_flag; see below;
+ * @self:        a pointer to struct umcg_task that describes this
+ *               task and governs the behavior of sys_umcg_wait if
+ *               registering; must be NULL if unregistering.
+ *
+ * @flags & UMCG_CTL_REGISTER: register a UMCG task:
+ *         UMCG workers:
+ *              - self->state must be UMCG_TASK_IDLE
+ *              - @flags & UMCG_CTL_WORKER
+ *         UMCG servers:
+ *              - self->state must be UMCG_TASK_RUNNING
+ *              - !(@flags & UMCG_CTL_WORKER)
+ *
+ *         All tasks:
+ *              - self->next_tid must be zero
+ *
+ *         If the conditions above are met, sys_umcg_ctl() immediately returns
+ *         if the registered task is a server; a worker will be added to
+ *         idle_workers_ptr, and the worker put to sleep; an idle server
+ *         from idle_server_tid_ptr will be woken, if present.
+ *
+ * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
+ *           is a UMCG worker, the userspace is responsible for waking its
+ *           server (before or after calling sys_umcg_ctl).
+ *
+ * Return:
+ * 0                - success
+ * -EFAULT          - failed to read @self
+ * -EINVAL          - some other error occurred
+ */
+SYSCALL_DEFINE2(umcg_ctl, u32, flags, struct umcg_task __user *, self)
+{
+	struct umcg_task ut;
+
+	if (flags == UMCG_CTL_UNREGISTER) {
+		if (self || !current->umcg_task)
+			return -EINVAL;
+
+		if (current->flags & PF_UMCG_WORKER)
+			umcg_handle_exiting_worker();
+		else
+			umcg_clear_task(current);
+
+		return 0;
+	}
+
+	/* Register the current task as a UMCG task. */
+	if (!(flags & UMCG_CTL_REGISTER))
+		return -EINVAL;
+
+	flags &= ~UMCG_CTL_REGISTER;
+	if (flags && flags != UMCG_CTL_WORKER)
+		return -EINVAL;
+
+	if (current->umcg_task || !self)
+		return -EINVAL;
+
+	if (copy_from_user(&ut, self, sizeof(ut)))
+		return -EFAULT;
+
+	if (ut.next_tid)
+		return -EINVAL;
+
+	if (flags == UMCG_CTL_WORKER) {
+		if (ut.state != UMCG_TASK_BLOCKED)
+			return -EINVAL;
+
+		WRITE_ONCE(current->umcg_task, self);
+		current->flags |= PF_UMCG_WORKER;
+
+		set_tsk_need_resched(current);
+		return 0;
+	}
+
+	/* This is a server task. */
+	if (ut.state != UMCG_TASK_RUNNING)
+		return -EINVAL;
+
+	WRITE_ONCE(current->umcg_task, self);
+	return 0;
+}
+
+/**
+ * handle_timedout_worker - make sure the worker is added to idle_workers
+ *                          upon a "clean" timeout.
+ */
+static int handle_timedout_worker(struct umcg_task __user *self)
+{
+	u32 prev_state, next_state;
+	int ret;
+
+	if (get_user(prev_state, &self->state))
+		return -EFAULT;
+
+	if ((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE) {
+		/* TODO: should we care here about TF_LOCKED or TF_PREEMPTED? */
+
+		next_state = prev_state & ~UMCG_TASK_STATE_MASK;
+		next_state |= UMCG_TASK_BLOCKED;
+
+		ret = cmpxchg_user_32(&self->state, &prev_state, next_state);
+		if (ret)
+			return ret;
+
+		return -ETIMEDOUT;
+	}
+
+	return 0;  /* Not really timed out. */
+}
+
+/**
+ * umcg_idle_loop - sleep until the current task becomes RUNNING or a timeout
+ * @abs_timeout - absolute timeout in nanoseconds; zero => no timeout
+ *
+ * The function marks the current task as INTERRUPTIBLE and calls
+ * schedule(). It returns when either the timeout expires or
+ * the UMCG state of the task becomes RUNNING.
+ *
+ * Note: because UMCG workers should not be running WITHOUT attached servers,
+ *       and because servers should not be running WITH attached workers,
+ *       the function returns only on fatal signal pending and ignores/flushes
+ *       all other signals.
+ */
+static int umcg_idle_loop(u64 abs_timeout)
+{
+	int ret;
+	struct hrtimer_sleeper timeout;
+	struct umcg_task __user *self = current->umcg_task;
+
+	if (abs_timeout) {
+		hrtimer_init_sleeper_on_stack(&timeout, CLOCK_REALTIME,
+				HRTIMER_MODE_ABS);
+
+		hrtimer_set_expires_range_ns(&timeout.timer, (s64)abs_timeout,
+				current->timer_slack_ns);
+	}
+
+	while (true) {
+		u32 umcg_state;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		smp_mb();  /* Order with set_current_state() above. */
+		ret = -EFAULT;
+		if (get_user(umcg_state, &self->state)) {
+			set_current_state(TASK_RUNNING);
+			goto out;
+		}
+
+		ret = 0;
+		if ((umcg_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_RUNNING) {
+			set_current_state(TASK_RUNNING);
+			goto out;
+		}
+
+		if (abs_timeout)
+			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
+
+		if (!abs_timeout || timeout.task) {
+			/*
+			 * Clear PF_UMCG_WORKER to elide workqueue handlers.
+			 */
+			const bool worker = current->flags & PF_UMCG_WORKER;
+
+			if (worker)
+				current->flags &= ~PF_UMCG_WORKER;
+
+			/*
+			 * Note: freezable_schedule() here is not appropriate
+			 * as umcg_idle_loop can be called from rwsem locking
+			 * context (via workqueue handlers), which may
+			 * trigger a lockdep warning for mmap_lock.
+			 */
+			schedule();
+
+			if (worker)
+				current->flags |= PF_UMCG_WORKER;
+		}
+		__set_current_state(TASK_RUNNING);
+
+		/*
+		 * Check for timeout before checking the state, as workers
+		 * are not going to return from schedule() unless
+		 * they are RUNNING.
+		 */
+		ret = -ETIMEDOUT;
+		if (abs_timeout && !timeout.task)
+			goto out;
+
+		ret = -EFAULT;
+		if (get_user(umcg_state, &self->state))
+			goto out;
+
+		ret = 0;
+		if ((umcg_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_RUNNING)
+			goto out;
+
+		ret = -EINTR;
+		if (fatal_signal_pending(current))
+			goto out;
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+out:
+	if (abs_timeout) {
+		hrtimer_cancel(&timeout.timer);
+		destroy_hrtimer_on_stack(&timeout.timer);
+	}
+
+	/* Workers must go through workqueue handlers upon wakeup. */
+	if (current->flags & PF_UMCG_WORKER) {
+		if (ret == -ETIMEDOUT)
+			ret = handle_timedout_worker(self);
+
+		set_tsk_need_resched(current);
+	}
+
+	return ret;
+}
+
+/*
+ * Try to wake up. May be called with preempt_disable set. May be called
+ * cross-process.
+ *
+ * Note: umcg_ttwu succeeds even if ttwu fails: see wait/wake state
+ *       ordering logic.
+ */
+static int umcg_ttwu(u32 next_tid, int wake_flags)
+{
+	struct task_struct *next;
+
+	rcu_read_lock();
+	next = find_task_by_vpid(next_tid);
+	if (!next || !(READ_ONCE(next->umcg_task))) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	/* Note: next does not necessarily share mm with current. */
+
+	try_to_wake_up(next, TASK_NORMAL, wake_flags);  /* Result ignored. */
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/*
+ * At the moment, umcg_do_context_switch simply wakes up @next with
+ * WF_CURRENT_CPU and puts the current task to sleep. May be called cross-mm.
+ *
+ * In the future an optimization will be added to adjust runtime accounting
+ * so that from the kernel scheduling perspective the two tasks are
+ * essentially treated as one. In addition, the context switch may be performed
+ * right here on the fast path, instead of going through the wake/wait pair.
+ */
+static int umcg_do_context_switch(u32 next_tid, u64 abs_timeout)
+{
+	struct task_struct *next;
+
+	rcu_read_lock();
+	next = find_task_by_vpid(next_tid);
+	if (!next) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	/* Note: next does not necessarily share mm with current. */
+
+	/* TODO: instead of wake + sleep, do a context switch. */
+	try_to_wake_up(next, TASK_NORMAL, WF_CURRENT_CPU);  /* Result ignored. */
+	rcu_read_unlock();
+
+	return umcg_idle_loop(abs_timeout);
+}
+
+/**
+ * sys_umcg_wait: put the current task to sleep and/or wake another task.
+ * @flags:        zero or a value from enum umcg_wait_flag.
+ * @abs_timeout:  when to wake the task, in nanoseconds; zero for no timeout.
+ *
+ * @self->state must be UMCG_TASK_IDLE (where @self is current->umcg_task)
+ * if !(@flags & UMCG_WAIT_WAKE_ONLY).
+ *
+ * If @self->next_tid is not zero, it must point to an IDLE UMCG task.
+ * The userspace must have changed its state from IDLE to RUNNING
+ * before calling sys_umcg_wait() in the current task. This "next"
+ * task will be woken (context-switched-to on the fast path) when the
+ * current task is put to sleep.
+ *
+ * See Documentation/userspace-api/umcg.[txt|rst] for detals.
+ *
+ * Return:
+ * 0             - OK;
+ * -ETIMEDOUT    - the timeout expired;
+ * -EFAULT       - failed accessing struct umcg_task __user of the current
+ *                 task;
+ * -ESRCH        - the task to wake not found or not a UMCG task;
+ * -EINVAL       - another error happened (e.g. bad @flags, or the current
+ *                 task is not a UMCG task, etc.)
+ */
+SYSCALL_DEFINE2(umcg_wait, u32, flags, u64, abs_timeout)
+{
+	struct umcg_task __user *self = current->umcg_task;
+	u32 next_tid;
+
+	if (!self)
+		return -EINVAL;
+
+	if (get_user(next_tid, &self->next_tid))
+		return -EFAULT;
+
+	if (flags & UMCG_WAIT_WAKE_ONLY) {
+		if (!next_tid || abs_timeout)
+			return -EINVAL;
+
+		flags &= ~UMCG_WAIT_WAKE_ONLY;
+		if (flags & ~UMCG_WAIT_WF_CURRENT_CPU)
+			return -EINVAL;
+
+		return umcg_ttwu(next_tid, flags & UMCG_WAIT_WF_CURRENT_CPU ?
+				WF_CURRENT_CPU : 0);
+	}
+
+	/* Unlock the worker, if locked. */
+	if (current->flags & PF_UMCG_WORKER) {
+		u32 umcg_state;
+
+		if (get_user(umcg_state, &self->state))
+			return -EFAULT;
+
+		if ((umcg_state & UMCG_TF_LOCKED) && cmpxchg_user_32(
+					&self->state, &umcg_state,
+					umcg_state & ~UMCG_TF_LOCKED))
+			return -EFAULT;
+	}
+
+	if (next_tid)
+		return umcg_do_context_switch(next_tid, abs_timeout);
+
+	return umcg_idle_loop(abs_timeout);
+}
+
+/*
+ * NOTE: all code below is called from workqueue submit/update, or
+ *       syscall exit to usermode loop, so all errors result in the
+ *       termination of the current task (via SIGKILL).
+ */
+
+/* Returns true on success, false on _any_ error. */
+static bool mark_server_running(u32 server_tid, bool may_sleep)
+{
+	struct umcg_task __user *ut_server = NULL;
+	u32 state = UMCG_TASK_IDLE;
+	struct task_struct *tsk;
+
+	rcu_read_lock();
+	tsk = find_task_by_vpid(server_tid);
+	if (tsk)
+		ut_server = READ_ONCE(tsk->umcg_task);
+	rcu_read_unlock();
+
+	if (!ut_server)
+		return false;
+
+	if (READ_ONCE(current->mm) != READ_ONCE(tsk->mm))
+		return false;
+
+	if (may_sleep)
+		return !cmpxchg_user_32(&ut_server->state, &state, UMCG_TASK_RUNNING);
+
+	return !cmpxchg_user_32_nosleep(&ut_server->state, &state, UMCG_TASK_RUNNING);
+}
+
+/*
+ * Called by sched_submit_work() for UMCG workers from within preempt_disable()
+ * context. In the common case, the worker's state changes RUNNING => BLOCKED,
+ * and its server's state changes IDLE => RUNNING, and the server is ttwu-ed.
+ *
+ * Under some conditions (e.g. the worker is "locked", see
+ * /Documentation/userspace-api/umcg.[txt|rst] for more details), the
+ * function does nothing.
+ */
+static void __umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	struct umcg_task __user *ut_worker = tsk->umcg_task;
+	u32 prev_state, next_state, server_tid;
+	bool preempted = false;
+	int ret;
+
+	if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
+		return;
+
+	/* Sometimes "locked" workers run without servers. */
+	if (unlikely(!tsk->pinned_umcg_server_page))
+		return;
+
+	smp_mb();  /* The userspace may change the state concurrently. */
+	if (get_user_nosleep(prev_state, &ut_worker->state))
+		goto die;  /* EFAULT */
+
+	if (prev_state & UMCG_TF_LOCKED)
+		return;
+
+	if ((prev_state & UMCG_TASK_STATE_MASK) != UMCG_TASK_RUNNING)
+		return;  /* the worker is in umcg_wait */
+
+retry_once:
+	next_state = prev_state & ~UMCG_TASK_STATE_MASK;
+	next_state |= UMCG_TASK_BLOCKED;
+	preempted = prev_state & UMCG_TF_PREEMPTED;
+
+	ret = cmpxchg_user_32_nosleep(&ut_worker->state, &prev_state, next_state);
+	if (ret == -EAGAIN) {
+		if (preempted)
+			goto die;  /* Preemption can only happen once. */
+
+		if (prev_state != (UMCG_TASK_RUNNING | UMCG_TF_PREEMPTED))
+			goto die;  /* Only preemption can happen. */
+
+		preempted = true;
+		goto retry_once;
+	}
+	if (ret)
+		goto die;  /* EFAULT */
+
+	if (get_user_nosleep(server_tid, &ut_worker->next_tid))
+		goto die;  /* EFAULT */
+
+	if (!server_tid)
+		return;  /* Waking a waiting worker leads here. */
+
+	/* The idle server's wait may timeout. */
+	/* TODO: make a smarter context switch below when available. */
+	if (mark_server_running(server_tid, false))
+		umcg_ttwu(server_tid, WF_CURRENT_CPU);
+
+	return;
+
+die:
+	pr_warn("umcg_wq_worker_sleeping: killing task %d\n", current->pid);
+	force_sig(SIGKILL);
+}
+
+/* Called from sched_submit_work() with preempt_disable. */
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	__umcg_wq_worker_sleeping(tsk);
+	umcg_unpin_pages();
+}
+
+/**
+ * enqueue_idle_worker - push an idle worker onto idle_workers_ptr list/stack.
+ *
+ * Returns true on success, false on a fatal failure.
+ *
+ * See Documentation/userspace-api/umcg.[txt|rst] for details.
+ */
+static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
+{
+	u64 __user *node = &ut_worker->idle_workers_ptr;
+	u64 __user *head_ptr;
+	u64 first = (u64)node;
+	u64 head;
+
+	if (get_user(head, node) || !head)
+		return false;
+
+	head_ptr = (u64 __user *)head;
+
+	if (put_user(UMCG_IDLE_NODE_PENDING, node))
+		return false;
+
+	if (xchg_user_64(head_ptr, &first))
+		return false;
+
+	if (put_user(first, node))
+		return false;
+
+	return true;
+}
+
+/**
+ * get_idle_server - retrieve an idle server, if present.
+ *
+ * Returns true on success, false on a fatal failure.
+ */
+static bool get_idle_server(struct umcg_task __user *ut_worker, u32 *server_tid)
+{
+	u64 server_tid_ptr;
+	u32 tid;
+	int ret;
+
+	*server_tid = 0;  /* Empty result is OK. */
+
+	if (get_user(server_tid_ptr, &ut_worker->idle_server_tid_ptr))
+		return false;
+
+	if (!server_tid_ptr)
+		return false;
+
+	tid = 0;
+	ret = xchg_user_32((u32 __user *)server_tid_ptr, &tid);
+
+	if (ret)
+		return false;
+
+	if (tid && mark_server_running(tid, true))
+		*server_tid = tid;
+
+	return true;
+}
+
+/*
+ * Returns true to wait for the userspace to schedule this worker, false
+ * to return to the userspace. In the common case, enqueues the worker
+ * to idle_workers_ptr list and wakes the idle server (if present).
+ */
+static bool process_waking_worker(struct task_struct *tsk, u32 *server_tid)
+{
+	struct umcg_task __user *ut_worker = tsk->umcg_task;
+	u32 prev_state, next_state;
+	int ret = 0;
+
+	*server_tid = 0;
+
+	if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
+		return false;
+
+	if (fatal_signal_pending(tsk))
+		return false;
+
+	smp_mb();  /* The userspace may concurrently modify the worker's state. */
+	if (get_user(prev_state, &ut_worker->state))
+		goto die;
+
+	if ((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_RUNNING) {
+		u32 tid;
+
+		if (prev_state & UMCG_TF_LOCKED)
+			return true;  /* Wakeup: wait but don't enqueue. */
+
+		smp_mb();  /* Order getting state and getting server_tid */
+
+		if (get_user(tid, &ut_worker->next_tid))
+			goto die;
+
+		*server_tid = tid;
+
+		if (prev_state & UMCG_TF_PREEMPTED) {
+			if (!tid)
+				goto die;  /* PREEMPTED workers must have a server. */
+
+			/* Always enqueue preempted workers. */
+			if (!mark_server_running(tid, true))
+				goto die;
+		} else if (tid)
+			return false;  /* pass-through: RUNNING with a server. */
+
+		/* If !PREEMPTED, the worker gets here via UMCG_WAIT_WAKE_ONLY */
+	} else if (unlikely((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE &&
+			(prev_state & UMCG_TF_LOCKED)))
+		return false;  /* The worker prepares to sleep or to unregister. */
+
+	if ((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE)
+		return true;  /* the worker called umcg_wait(); don't enqueue */
+
+	next_state = prev_state & ~UMCG_TASK_STATE_MASK;
+	next_state |= UMCG_TASK_IDLE;
+
+	if (prev_state != next_state)
+		ret = cmpxchg_user_32(&ut_worker->state, &prev_state, next_state);
+	if (ret)
+		goto die;
+
+	if (!enqueue_idle_worker(ut_worker))
+		goto die;
+
+	smp_mb();  /* Order enqueuing the worker with getting the server. */
+	if (!(*server_tid) && !get_idle_server(ut_worker, server_tid))
+		goto die;
+
+	return true;
+
+die:
+	pr_warn("umcg_process_waking_worker: killing task %d\n", current->pid);
+	force_sig(SIGKILL);
+	return false;
+}
+
+/*
+ * Called from sched_update_worker(): defer all work until later, as
+ * sched_update_worker() may be called with in-kernel locks held.
+ */
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+	set_tsk_thread_flag(tsk, TIF_NOTIFY_RESUME);
+}
+
+/* Called via TIF_NOTIFY_RESUME flag from exit_to_user_mode_loop. */
+void umcg_handle_resuming_worker(void)
+{
+	u32 server_tid;
+
+	/* Avoid recursion by removing PF_UMCG_WORKER */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	do {
+		bool should_wait;
+
+		should_wait = process_waking_worker(current, &server_tid);
+
+		if (!should_wait)
+			break;
+
+		if (server_tid)
+			umcg_do_context_switch(server_tid, 0);
+		else
+			umcg_idle_loop(0);
+	} while (true);
+
+	if (server_tid && umcg_pin_pages(server_tid))
+		goto die;
+
+	if (!server_tid)  /* No server => no reason to pin pages. */
+		umcg_unpin_pages();
+
+	goto out;
+
+die:
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+out:
+	current->flags |= PF_UMCG_WORKER;
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0ea8128468c3..cd1be6356e42 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -272,6 +272,10 @@ COND_SYSCALL(landlock_create_ruleset);
 COND_SYSCALL(landlock_add_rule);
 COND_SYSCALL(landlock_restrict_self);

+/* kernel/sched/umcg.c */
+COND_SYSCALL(umcg_ctl);
+COND_SYSCALL(umcg_wait);
+
 /* arch/example/kernel/sys_example.c */

 /* mm/fadvise.c */
--
2.25.1

