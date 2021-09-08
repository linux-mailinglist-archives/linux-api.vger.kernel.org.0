Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64447403F3E
	for <lists+linux-api@lfdr.de>; Wed,  8 Sep 2021 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbhIHSuZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350301AbhIHSuY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 14:50:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78792C061575
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 11:49:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v1so1861580plo.10
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCfJxlpWqyqxXKyLLCEUvuDMFphfrRDae8qQI/wazL0=;
        b=ImKAe3WAvkFhuJqsTy9eLg1miLghevgGCSTO13TL/xWtMXOgHZZh1S50Co0QvHliHB
         pC32ju/bBNKkXHiL4beZUss8qWOaLge/7/R0EGXn52CxfYHOXGkAcmQ6qXsip5qj/4Nw
         ebN3M5BxRvQ8wkj1R/JNnWB8Go+0F80v9brixUBiSKwujDcjtQzka3MK/0BdEsclsESJ
         1wpWrGAsF9nOuZeHSlLnTKbFOAOkBL1JL6ZfGrnBJrjPw3ypetzQa0KQgzs7d2p7JyCy
         H29O12SEXStxXVYP6mZEA1amnJiYdSl4lGw9SyFR0DobT/PhH/7hNUGLiI9XZ9L5kg3d
         0IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCfJxlpWqyqxXKyLLCEUvuDMFphfrRDae8qQI/wazL0=;
        b=hcpogkk0VqXLSDfNnSKNdMuP5b9KgJbxzaPqs3pxQjMUzGMaa49mO/pw72T6x8t3Uj
         jcTsb318g59LGIbDcOebnyQCt97H/w9d531nehCI4mm5SejUwdtB/MRy3YWcibrFzdbD
         0re1+V64HwDIceiRMek+lZ7C98wfEOB1ZR4igHZXc/U0LAUXKtmozdZMGWLNkwF7E8+e
         VvVCqnEFEONRPr4WgCc3RVrqrgV+oyAJVqxK0QD3Kliyh0vrlyZyuz2TIG7CR+Zdk850
         9aucTbS/pgRvXL0H5Rn9PE/QQMuXxVVk0qaLQq5u8rASqz97lo7Qs1GFnunwMlBt1LVN
         4jSQ==
X-Gm-Message-State: AOAM532svI+9kMyYBOGqhjfTqehklOiiAzZT7RfH2LUZHO1jhO8l5xis
        kBfStT9RCv2xBHCSStH6OOKOxUyyQGG9Hg==
X-Google-Smtp-Source: ABdhPJyGD7yEN86WYdRz98CKD6sT7/CTtJ01hF6mBdh0zVPxAkQ6NjSDqi4C0eNpjbj+pSxPqikM8w==
X-Received: by 2002:a17:90b:2250:: with SMTP id hk16mr5716811pjb.55.1631126955726;
        Wed, 08 Sep 2021 11:49:15 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m64sm3645640pga.55.2021.09.08.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:49:15 -0700 (PDT)
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
Subject: [PATCH 3/4 v0.5] sched/umcg: RFC: implement UMCG syscalls
Date:   Wed,  8 Sep 2021 11:49:04 -0700
Message-Id: <20210908184905.163787-4-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908184905.163787-1-posk@google.com>
References: <20210908184905.163787-1-posk@google.com>
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

Peter Z. suggested a different approach in
https://lore.kernel.org/lkml/20210713161030.GA2591@worktop.programming.kicks-ass.net/
but I'm not sure how a new syscall (called from a signal handler?)
would improve things: at least now the interrupter can be reasonably
assured that if the state change RUNNING => RUNNING | PREEMPTED
succeeded, and the signal delivered, the worker will be interrupted;
am I missing something?

These big things remain to be addressed:
- tracing/debugging
- faster context switches (see umcg_do_context_switch in umcg.c)
- other architectures (we will need at least arm64 in addition to amd64)
- tools/lib/umcg for userspace
- kselftests

I obviosly have the last two items (libumcg and selftests) to a
certain extent, but they are a bit rough at the moment - I'll
clean them up and post to LKML soon(ish).

See Documentation/userspace-api/umcg.rst for API usage and other details.

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
 include/linux/sched.h                  |   6 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 114 +++++
 init/Kconfig                           |  10 +
 kernel/exit.c                          |   7 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  17 +-
 kernel/sched/umcg.c                    | 618 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    |  13 +
 kernel/sys_ni.c                        |   4 +
 12 files changed, 801 insertions(+), 3 deletions(-)
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
index 3bb9fecfdaa1..1b38737ef0ab 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -66,6 +66,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;

 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1224,6 +1225,10 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif

+#ifdef CONFIG_UMCG
+	struct umcg_task __user *umcg_task;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;

 	union {
@@ -1600,6 +1605,7 @@ extern struct pid *cad_pid;
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
index 000000000000..2fc15c6068ad
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
index 377c4d931546..367a21fa45ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -26,6 +26,7 @@

 #include "pelt.h"
 #include "smp.h"
+#include "umcg.h"

 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
@@ -4159,6 +4160,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+#ifdef CONFIG_UMCG
+	p->umcg_task = NULL;
+	p->flags &= ~PF_UMCG_WORKER;
+#endif
 }

 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6171,10 +6176,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
@@ -6193,9 +6202,13 @@ static inline void sched_submit_work(struct task_struct *tsk)

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
index 000000000000..c833246a6bbc
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,618 @@
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
+		if (ut.state != UMCG_TASK_BLOCKED)
+			return -EINVAL;
+
+		current->umcg_task = self;
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
+	current->umcg_task = self;
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
+	if (get_user_nosleep(prev_state, &self->state))
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
+		if (get_user_nosleep(umcg_state, &self->state)) {
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
+		if (get_user_nosleep(umcg_state, &self->state))
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
+ *       errors result in the termination of the current task (via SIGKILL).
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
+		return;  /* Waking a waiting worker leads here. */
+
+	/* The idle server's wait may timeout. */
+	/* TODO: make a smarter context switch below when available. */
+	if (mark_server_running(server_tid))
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
+ * Returns true on success, false on a fatal failure.
+ */
+static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
+{
+	u64 __user *node = &ut_worker->idle_workers_ptr;
+	u64 __user *head_ptr;
+	u64 first = (u64)node;
+	u64 head;
+
+	if (get_user_nosleep(head, node) || !head)
+		return false;
+
+	head_ptr = (u64 __user *)head;
+
+	if (put_user_nosleep(1ULL, node))
+		return false;
+
+	if (xchg_user_64(head_ptr, &first))
+		return false;
+
+	if (put_user_nosleep(first, node))
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
+	if (get_user_nosleep(server_tid_ptr, &ut_worker->idle_server_tid_ptr))
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
+	if (tid && mark_server_running(tid))
+		*server_tid = tid;
+
+	return true;
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
+	pr_warn("umcg_wq_worker_running: killing task %d\n", current->pid);
+	force_sig(SIGKILL);
+	return false;
+}
+
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+	might_sleep();
+
+	/* Avoid recursion by removing PF_UMCG_WORKER */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	do {
+		bool should_wait;
+		u32 server_tid;
+
+		should_wait = process_waking_worker(tsk, &server_tid);
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
index 89ba84afa977..737c8612fb47 100644
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

