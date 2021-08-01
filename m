Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914D73DCD8E
	for <lists+linux-api@lfdr.de>; Sun,  1 Aug 2021 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhHAUGp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Aug 2021 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhHAUGh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Aug 2021 16:06:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947BC061799
        for <linux-api@vger.kernel.org>; Sun,  1 Aug 2021 13:06:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q2so17196873plr.11
        for <linux-api@vger.kernel.org>; Sun, 01 Aug 2021 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqbZn4vkJQGKPICsvVkiNRC+EApOcPiFndAEfIVYrCQ=;
        b=B+0JLLeICxlZ2q/Dfzo+O8CONZ/18baI1Hlqor5pC48z6YSyU9qVqK8xi2YmIdYZ7t
         cZKQGQ4pCu42R4TlDQdsXnrDahvnhe1yjxPgN80h7xCfrHiSltKWV1D7sW/ZM9COsWF+
         8vXxbdJ4hOBKUCPnjt/n7N2UfwmYyZ/xqNZb4IYLRnS5dRqVMY5IPP1fpTaqxaybcdXm
         4OgHyKD4vod88QO/KiF+gppM9GigQ0ek3czuf7635Bj449a0zoDAw6lnxe5xP3bYj6QU
         7lmkJsYP4BNrt8tGOXTY7u3whP4H8KMdGj2ZaoGBOILSWxxWSwUokmQ0cycj6lvi9+cQ
         YC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqbZn4vkJQGKPICsvVkiNRC+EApOcPiFndAEfIVYrCQ=;
        b=StJpTEy633l8dwHZ8o2ysN4bzxbhqfGK7ACXtgm3bvN4LG6GlHCX+fGmWaBjydBbuz
         Btb/5fYS6uXcH/c+s0Fs3UqZZ0ibj91iUhyiD9InwGBM9uxCjX0K3lwhf3RSb2V+F4yq
         GT+PuGI/IubwWyd/GXRTRADwXpuIKgQKd7nKniDqTYeMdlx8bkSB/P3s1RRzgSo/9HDP
         sPmdukvQR4JWjnPKrqcsZfHDDtwtC2+dGkSaH3jaGhqMH82np6kO0ATQSZ6/USkyGx+N
         ikj981bSKVBcfMJTwCF/cBzZTfhfDeyh1hL4zC23Eo7GRp1+RsYkYaoDgO8jDcu+ZzA2
         ptHg==
X-Gm-Message-State: AOAM530ykNE14VsLbaObNkZZ7YNCY8/fDnbr3xt2Qro2Xi7Hmmdf1OWr
        hOr0suz47OL8AZI0FTTFhIP6PA==
X-Google-Smtp-Source: ABdhPJx7v8bUrFD6qu1Bf35Ni3rys7leBetBas293tdXCFwG0LMAmF6rVzut/02mLUO26JgF7/hP1A==
X-Received: by 2002:a63:ee0a:: with SMTP id e10mr3576780pgi.385.1627848387188;
        Sun, 01 Aug 2021 13:06:27 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b3sm9293714pfi.179.2021.08.01.13.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:06:26 -0700 (PDT)
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
Subject: [PATCH 4/4 v0.4] sched/umcg: RFC: implement UMCG syscalls
Date:   Sun,  1 Aug 2021 13:06:17 -0700
Message-Id: <20210801200617.623745-5-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210801200617.623745-1-posk@google.com>
References: <20210801200617.623745-1-posk@google.com>
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

The main challenge with preemption is to carefully navigate the
race when (1) the worker goes to block in the kernel via e.g.
calling nanosleep and (2) the userspace tries to preempt the worker
simultaneously: there is a brief time window when the worker
is already in INTERRUPTIBLE task state but still has its UMCG
state as RUNNING (not yet changed to BLOCKED); the _state_ change
is handled robustly; but if the actual signal arrives when the
state change is handled, things go wild.

At the moment this is dealt with by wrapping the state-change-handling
code in local_irq_disable/enable calls and completely ignoring non-fatal
signals, but probably a better, more direct handling of signals is
possible. Any suggestions here are welcome.

Peter Z. suggested a different approach in
https://lore.kernel.org/lkml/20210713161030.GA2591@worktop.programming.kicks-ass.net/
but I'm not sure how a new syscall (called from a signal handler?)
would improve things: at least now the interrupter can be reasonably
assured that if the state change RUNNING => RUNNING | PREEMPTED
succeeded, and the signal delivered, the worker will be interrupted;
am I missing something?

Other than making signal/preemption handling more thought-out and
robust, these big things remain to be addressed:
- tracing/debugging
- faster context switches (see umcg_do_context_switch in umcg.c)
- other architectures (we will need at least arm64 in addition to amd64)
- tools/lib/umcg for userspace
- kselftests

I obviosly have the last two items (libumcg and selftests) to a
certain extent, but they are a bit rough at the moment - I'll
clean them up and post to LKML once things on the kernel side are
in good shape.

See Documentation/userspace-api/umcg.rst for API usage and other details.

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
 include/linux/sched.h                  |   6 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 114 +++++
 init/Kconfig                           |  10 +
 kernel/exit.c                          |   7 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  17 +-
 kernel/sched/umcg.c                    | 601 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    |  13 +
 kernel/sys_ni.c                        |   4 +
 12 files changed, 784 insertions(+), 3 deletions(-)
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 50db9496c99d..185ad1cdde77 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -66,6 +66,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;

 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1223,6 +1224,10 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif

+#ifdef CONFIG_UMCG
+	struct umcg_task __user *umcg_task;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;

 	union {
@@ -1599,6 +1604,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_UMCG_WORKER		0x01000000	/* UMCG worker */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
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
index 000000000000..4faeb77b393c
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,114 @@
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
+ * See Documentation/userspace-api/umcg.rst for detals.
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
+	 * @idle_server_tid_ptr: a pointer pointing to a pointer pointing to a
+	 *                       single idle server. Readonly.
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
diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c04193e18..dc8398558d87 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -744,6 +744,13 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");

+#ifdef CONFIG_UMCG
+	if (unlikely(tsk->flags & PF_UMCG_WORKER))
+		tsk->flags &= ~PF_UMCG_WORKER;
+
+	tsk->umcg_task = NULL;
+#endif
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
index 293f5801bf81..f7ddeed72e30 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -26,6 +26,7 @@

 #include "pelt.h"
 #include "smp.h"
+#include "umcg.h"

 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
@@ -3961,6 +3962,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+#ifdef CONFIG_UMCG
+	p->umcg_task = NULL;
+	p->flags &= ~PF_UMCG_WORKER;
+#endif
 }

 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -5975,10 +5980,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
@@ -5997,9 +6006,13 @@ static inline void sched_submit_work(struct task_struct *tsk)

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
index 000000000000..c36902ffef5e
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ *
+ * See Documentation/userspace-api/umcg.rst for detals.
+ */
+
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/umcg.h>
+#include <linux/freezer.h>
+
+#include "sched.h"
+#include "umcg.h"
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
+			current->flags &= ~PF_UMCG_WORKER;
+
+		current->umcg_task = NULL;
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
+		if (ut.state != UMCG_TASK_IDLE)
+			return -EINVAL;
+
+		current->umcg_task = self;
+		current->flags |= PF_UMCG_WORKER;
+
+		umcg_wq_worker_running(current);  /* Will sleep. */
+		return 0;
+	}
+
+	/* This is a server task. */
+	if (ut.state != UMCG_TASK_RUNNING)
+		return -EINVAL;
+
+	current->umcg_task = self;
+	return 0;
+}
+
+/**
+ * umcg_idle_loop - sleep until the current task becomes RUNNING or a timeout
+ * @abs_timeout - absolute timeout in nanoseconds; zero => no timeout
+ *
+ * The function marks the current task as INTERRUPTIBLE and calls
+ * freezable_schedule(). It returns when either the timeout expires or
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
+		if (abs_timeout) {
+			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
+
+			if (!timeout.task) {
+				ret = -ETIMEDOUT;
+				__set_current_state(TASK_RUNNING);
+
+				if (current->flags & PF_UMCG_WORKER)
+					umcg_wq_worker_running(current);
+				break;
+			}
+		}
+
+		freezable_schedule();
+
+		/*
+		 * Check for timeout before checking the state, as workers
+		 * are not going to return from freezable_schedule() unless
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
+	return ret;
+}
+
+/*
+ * Try to wake up. May be called with preempt_disable set.
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
+	try_to_wake_up(next, TASK_NORMAL, wake_flags);  /* Result ignored. */
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/*
+ * At the moment, umcg_do_context_switch simply wakes up @next with
+ * WF_CURRENT_CPU and puts the current task to sleep.
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
+ * See Documentation/userspace-api/umcg.rst for detals.
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
+ * NOTE: all code below is called from workqueue submit/update, so all
+ *       errors result in the termination of the current task (via SIGSEGV).
+ */
+
+/* Returns true on success, false on _any_ error. */
+static bool mark_server_running(u32 server_tid)
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
+	return !cmpxchg_user_32(&ut_server->state, &state, UMCG_TASK_RUNNING);
+}
+
+/*
+ * In the common case, change @tsk RUNNING => BLOCKED. Called from
+ * preempt_disable() and local_irq_disable() context.
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
+	smp_mb();  /* Guard the read below. */
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
+	ret = cmpxchg_user_32(&ut_worker->state, &prev_state, next_state);
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
+		goto die;  /* The user broke the contract. */
+
+	if (!mark_server_running(server_tid))
+		goto die;  /* The user broke the contract. */
+
+	/* TODO: make a smarter context switch when available. */
+	umcg_ttwu(server_tid, WF_CURRENT_CPU);
+	return;
+
+die:
+	force_sig(SIGSEGV);
+}
+
+/* Called from sched_submit_work() with preempt_disable. */
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	/*
+	 * Although UMCG preemption state change (UMCG_TF_PREEMPTED) racing
+	 * with the worker blocking in a syscall is handled correctly in
+	 * __umcg_wq_worker_sleeping() above, actual signal to the worker
+	 * during the execution of this function might be causing
+	 * isuses, based on some observed test failures. Disabling IRQs
+	 * make the failures go away.
+	 */
+	local_irq_disable();
+	__umcg_wq_worker_sleeping(tsk);
+	local_irq_enable();
+}
+
+/**
+ * enqueue_idle_worker - push an idle worker onto idle_workers_ptr list/stack.
+ *
+ * The function tries several times to enqueue the worker; if all attempts
+ * fail due to contention, the function sleeps with a timeout (exponential
+ * back-off).
+ *
+ * Note: the function is called from local_irq_disable() context; so it
+ *       re-enables IRQs becore calling imcg_idle_loop().
+ *
+ * Returns true on success, false on a fatal failure.
+ */
+static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
+{
+	u64 __user *node = &ut_worker->idle_workers_ptr;
+	u64 sleep_timeout = 500;  /* ns */
+	u64 __user *head_ptr;
+	u64 head;
+
+	if (get_user_nosleep(head, node) || !head)
+		return false;
+
+	head_ptr = (u64 __user *)head;
+
+	while (true) {
+		int step, ret;
+
+		for (step = 0; step < nr_cpu_ids; ++step) {
+			u64 first;
+
+			if (get_user_nosleep(first, head_ptr))
+				return false;
+
+			if (put_user_nosleep(first, node))
+				return false;
+
+			ret = cmpxchg_user_64(head_ptr, &first, (u64)node);
+			if (!ret)
+				return true;
+
+			if (ret != -EAGAIN)
+				return false;
+		}
+
+		local_irq_enable();  /* This is called with IRQs disabled. */
+		ret = umcg_idle_loop(ktime_get_real() + sleep_timeout);
+		local_irq_disable();
+		if (fatal_signal_pending(current))
+			return false;
+
+		if (ret != -ETIMEDOUT)
+			return false;
+
+		if (sleep_timeout < 50000)
+			sleep_timeout += sleep_timeout;
+	}
+}
+
+/**
+ * get_idle_server - retrieve an idle server, if present.
+ *
+ * Returns true on success, false on a fatal failure.
+ */
+static bool get_idle_server(struct umcg_task __user *ut_worker, u32 *server_tid)
+{
+	u64 head;
+	u32 tid;
+	int ret;
+
+	*server_tid = 0;  /* Empty result is OK. */
+
+	if (get_user_nosleep(head, &ut_worker->idle_server_tid_ptr))
+		return false;
+
+	if (!head)
+		return false;
+
+	if (get_user(tid, (u32 __user *)head))
+		return false;
+
+	if (!tid)
+		return true;  /* No idle servers. */
+
+	ret = cmpxchg_user_32((u32 __user *)head, &tid, 0ULL);
+	if (ret == -EAGAIN)
+		return true;  /* Another worker got it. */
+
+	if (ret)
+		return false;
+
+	*server_tid = tid;
+	return mark_server_running(tid);
+}
+
+/*
+ * Returns true to wait, false to return to the userspace. Called with IRQs
+ * disabled. In the common case, enqueues the worker to idle_workers_ptr list
+ * and wakes the idle server (if present).
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
+	smp_mb();  /* Guard the read below. */
+	if (get_user_nosleep(prev_state, &ut_worker->state))
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
+		if (get_user_nosleep(tid, &ut_worker->next_tid))
+			goto die;
+
+		if (prev_state & UMCG_TF_PREEMPTED) {
+			if (!tid)
+				goto die;  /* PREEMPTED workers must have a server. */
+
+			/* Always enqueue preempted workers. */
+			if (!mark_server_running(tid))
+				goto die;
+
+			*server_tid = tid;
+		} else if (tid)
+			return false;  /* pass-through: RUNNING with a server. */
+
+		/* If !PREEMPTED, the worker gets here via UMCG_WAIT_WAKE_ONLY */
+	} else if (unlikely((prev_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE &&
+			(prev_state & UMCG_TF_LOCKED)))
+		return false;  /* The worker prepares to sleep or to unregister. */
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
+	force_sig(SIGSEGV);
+	return false;
+}
+
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+	/* Avoid recursion by removing PF_UMCG_WORKER */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	do {
+		bool should_wait;
+		u32 server_tid;
+
+		local_irq_disable();  /* See comment in umcg_wq_worker_sleeping */
+		should_wait = process_waking_worker(tsk, &server_tid);
+		local_irq_enable();
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
+	current->flags |= PF_UMCG_WORKER;
+}
diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
index 1db283071ca6..8129db57df20 100644
--- a/kernel/sched/umcg.h
+++ b/kernel/sched/umcg.h
@@ -9,6 +9,19 @@
 #include <asm/asm.h>
 #include <linux/atomic.h>

+#ifdef CONFIG_UMCG
+
+struct task_struct;
+
+/*
+ * umcg_wq_worker_[sleeping|running] are called in core.c by
+ * sched_submit_work() and sched_update_worker().
+ */
+void umcg_wq_worker_sleeping(struct task_struct *tsk);
+void umcg_wq_worker_running(struct task_struct *tsk);
+
+#endif  /* CONFIG_UMCG */
+
 /* TODO: move atomic operations below into arch/ headers */
 static inline int __try_cmpxchg_user_32(u32 *uval, u32 __user *uaddr,
 						u32 oldval, u32 newval)
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

