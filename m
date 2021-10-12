Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B142B01C
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 01:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbhJLX1k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhJLX1i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 19:27:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7E5C061749
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e7so546474pgk.2
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35uByDXPQM5rlAc+bIqLvmfiTnpmREcdo54IGFE0CPM=;
        b=HNDjPGJi0pbKgMn37LgzzpBLoOuL/WvUBq7KPNMqACN0M2ck5eT45da3G1oZOBL/t6
         4gw4lP/Mo2vcV2Zv2O1KP8PDqnZvwL2pXgEiEjtNe3tOxqfKlYzOMh6O6jMhrhOsX7cc
         SEfOZP6rs/wxlta3n9mCY68BnDMMTtb0PZK3miSxQPttz7vC60y8wjdYe70uQW6KrE1u
         6mijchmsxhoIG91RrzaoCVJQmtO7nMc0RcLvbe7FpV157PU+a035+/1DGpa7H/kzvody
         xvtbKB+BaXIDyAY13IylTcPb65K2uuNb/zuqaKgm//BW8pIi6cTwP6hOTwkQfWmgvpkF
         MgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35uByDXPQM5rlAc+bIqLvmfiTnpmREcdo54IGFE0CPM=;
        b=2+bll52AxQDc4oxQ64R51nHIubiosQUg2Y2hmI/MZK7KoiB+bRfxfAoVLiPHtD3h98
         YpSiQmxHREWUNx0ttEVrnCtlHeSy3n62+c604nO6rCktKvs8esP6yGqN3mpE97E7hese
         w1a0RVWdL4NTboWuw/mJPazk26oNAdDpXgVnLtrY1xgN9t+tUSLDPp2vOHTK/ifAfjgg
         ChMn+rFIC1O2j6d/xVexDkbRZUwMDg+hv4evRarq3tpJdl1HbzqOWLqrWgHVIXUvaErp
         9aaPoHJ9NhyFGCQJXseOJ7MjJd8OKiPfY8EORJ1GmN5fiF8mSVwkOZdLE7aMH0sq72SU
         JUWg==
X-Gm-Message-State: AOAM530035RhMoOeCRkN0zSAR6jXUlpcNPnFD8C883+NPbHn5/5nuA3m
        conC611jHpGp9+HZAjaGRmblnw==
X-Google-Smtp-Source: ABdhPJyC5NFcyhMPUsjC3ZYwVPcGr6jfJNgGEDM6dQrdaSqP76RN0u2izCE87sMN3UYov2c4lWGbBA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr24831429pgs.219.1634081135307;
        Tue, 12 Oct 2021 16:25:35 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v20sm12675026pgc.38.2021.10.12.16.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:25:34 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.7 3/5] sched/umcg: implement UMCG syscalls
Date:   Tue, 12 Oct 2021 16:25:20 -0700
Message-Id: <20211012232522.714898-4-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012232522.714898-1-posk@google.com>
References: <20211012232522.714898-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Define struct umcg_task and two syscalls: sys_umcg_ctl sys_umcg_wait.

User Managed Concurrency Groups is an M:N threading toolkit that allows
constructing user space schedulers designed to efficiently manage
heterogeneous in-process workloads while maintaining high CPU
utilization (95%+).

In addition, M:N threading and cooperative user space scheduling
enables synchronous coding style and better cache locality when
compared to asynchronous callback/continuation style of programming.

UMCG kernel API is build around the following ideas:

* UMCG server: a task/thread representing "kernel threads", or (v)CPUs;
* UMCG worker: a task/thread representing "application threads", to be
  scheduled over servers;
* UMCG task state: (NONE), RUNNING, BLOCKED, IDLE: states a UMCG task (a
  server or a worker) can be in;
* UMCG task state flag: LOCKED, PREEMPTED: additional state flags that
  can be ORed with the task state to communicate additional information to
  the kernel;
* struct umcg_task: a per-task userspace set of data fields, usually
  residing in the TLS, that fully reflects the current task's UMCG state
  and controls the way the kernel manages the task;
* sys_umcg_ctl(): a syscall used to register the current task/thread as a
  server or a worker, or to unregister a UMCG task;
* sys_umcg_wait(): a syscall used to put the current task to sleep and/or
  wake another task, pontentially context-switching between the two tasks
  on-CPU synchronously.

In short, servers can be thought of as CPUs over which application
threads (workers) are scheduled; at any one time a worker is either:
- RUNNING: has a server and is schedulable by the kernel;
- BLOCKED: blocked in the kernel (e.g. on I/O, or a futex);
- IDLE: is not blocked, but cannot be scheduled by the kernel to
  run because it has no server assigned to it (e.g. because all
  available servers are busy "running" other workers).

Usually the number of servers in a process is equal to the number of
CPUs available to the kernel if the process is supposed to consume
the whole machine, or less than the number of CPUs available if the
process is sharing the machine with other workloads. The number of
workers in a process can grow very large: tens of thousands is normal;
hundreds of thousands and more (millions) is something that would
be desirable to achieve in the future, as lightweight userspace
threads in Java and Go easily scale to millions, and UMCG workers
are (intended to be) conceptually similar to those.

Detailed use cases and API behavior are provided in
Documentation/userspace-api/umcg.[txt|rst] (see sibling patches).

Some high-level implementation notes:

UMCG tasks (workers and servers) are "tagged" with struct umcg_task
residing in userspace (usually in TLS) to facilitate kernel/userspace
communication. This makes the kernel-side code much simpler (see e.g.
the implementation of sys_umcg_wait), but also requires some careful
uaccess handling and page pinning (see below).

The main UMCG server/worker interaction looks like:

a. worker W1 is RUNNING, with a server S attached to it sleeping
   in IDLE state;
b. worker W1 blocks in the kernel, e.g. on I/O;
c. the kernel marks W1 as BLOCKED, the attached server S
   as RUNNING, and wakes S (the "block detection" event);
d. the server now picks another IDLE worker W2 to run: marks
   W2 as RUNNING, itself as IDLE, ands calls sys_umcg_wait();
e. when the blocking operation of W1 completes, the worker
   is marked by the kernel as IDLE and added to idle workers list
   (see struct umcg_task) for the userspace to pick up and
   later run (the "wake detection" event).

While there are additional operations such as worker-to-worker
context switch, preemption, workers "yielding", etc., the "workflow"
above is the main worker/server interaction that drives the
implementation.

Specifically:

- most operations are conceptually context switches:
    - scheduling a worker: a running server goes to sleep and "runs"
      a worker in its place;
    - block detection: worker is descheduled, and its server is woken;
    - wake detection: woken worker, running in the kernel, is descheduled,
      and if there is an idle server, it is woken to process the wake
      detection event;
- to faciliate low scheduling latencies and cache locality, most
  server/worker interactions described above are performed synchronously
  "on CPU" via WF_CURRENT_CPU flag passed to ttwu; while at the moment
  the context switches are simulated by putting the switch-out task to
  sleep and waking the switch-into task on the same cpu, it is very much
  the long-term goal of this project to make the context switch much
  lighter, by tweaking runtime accounting and, maybe, even bypassing
  __schedule();
- worker blocking is detected in a hook to sched_submit_work; as mentioned
  above, the server is to be woken on the same CPU, synchronously;
  this code may not pagefault, so to access worker's and server's
  userspace memory (struct umcg_task), memory pages containing the worker's
  and the server's structs umcg_task are pinned when the worker is
  exiting to the userspace, and unpinned when the worker is descheduled;
- worker wakeup is detected in a hook to sched_update_worker, and processed
  in the exit to usermode loop (via TIF_NOTIFY_RESUME); workers CAN
  pagefault on the wakeup path;
- worker preemption is implemented by the userspace tagging the worker
  with UMCG_TF_PREEMPTED state flag and sending a NOOP signal to it;
  on the exit to usermode the worker is intercepted and its server is woken
  (see Documentation/userspace-api/umcg.[txt|rst] for more details);
- each state change is tagged with a unique timestamp (of MONOTONIC
  variety), so that
    - scheduling instrumentation is naturally available;
    - racing state changes are easily detected and ABA issues are
      avoided;
  see umcg_update_state() in umcg.c for implementation details, and
  Documentation/userspace-api/umcg.[txt|rst] for a higher-level
  description.

The previous version of the patchset can be found at
https://lore.kernel.org/all/20210917180323.278250-1-posk@google.com/
containing some additional context and links to earlier discussions.

More details are available in Documentation/userspace-api/umcg.[txt|rst]
in sibling patches, and in doc-comments in the code.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/exec.c                              |   1 +
 include/linux/sched.h                  |  71 ++
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   6 +-
 include/uapi/linux/umcg.h              | 137 ++++
 init/Kconfig                           |  10 +
 kernel/entry/common.c                  |   4 +-
 kernel/exit.c                          |   5 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |   9 +-
 kernel/sched/umcg.c                    | 926 +++++++++++++++++++++++++
 kernel/sys_ni.c                        |   4 +
 13 files changed, 1175 insertions(+), 4 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 18b5500ea8bf..cb71f383060f 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -370,6 +370,8 @@
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
+449	common	umcg_ctl		sys_umcg_ctl
+450	common	umcg_wait		sys_umcg_wait

 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..dfa24bb99a97 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1840,6 +1840,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	umcg_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 343603f77f8b..c7e812ceec3c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -67,6 +67,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;

 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1296,6 +1297,12 @@ struct task_struct {
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
@@ -1688,6 +1695,13 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+
+#ifdef CONFIG_UMCG
+#define PF_UMCG_WORKER		0x01000000	/* UMCG worker */
+#else
+#define PF_UMCG_WORKER		0x00000000
+#endif
+
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
@@ -2275,6 +2289,63 @@ static inline void rseq_execve(struct task_struct *t)

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
+#else  /* CONFIG_UMCG */
+
+static inline void umcg_clear_child(struct task_struct *tsk)
+{
+}
+static inline void umcg_execve(struct task_struct *tsk)
+{
+}
+static inline void umcg_handle_notify_resume(void)
+{
+}
+static inline void umcg_handle_exit(void)
+{
+}
+static inline void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+}
+static inline void umcg_wq_worker_running(struct task_struct *tsk)
+{
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_RSEQ

 void rseq_syscall(struct pt_regs *regs);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 252243c7783d..97a05879da41 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct umcg_task;

 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1052,6 +1053,8 @@ asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type ru
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
+asmlinkage long sys_umcg_ctl(u32 flags, struct umcg_task __user *self);
+asmlinkage long sys_umcg_wait(u32 flags, u64 abs_timeout);

 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c5fb86d455a..3e3d50de5137 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -879,9 +879,13 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
+#define __NR_umcg_ctl 449
+__SYSCALL(__NR_umcg_ctl, sys_umcg_ctl)
+#define __NR_umcg_wait 450
+__SYSCALL(__NR_umcg_wait, sys_umcg_wait)

 #undef __NR_syscalls
-#define __NR_syscalls 449
+#define __NR_syscalls 451

 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
new file mode 100644
index 000000000000..ce4c7980b837
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,137 @@
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
+ * UMCG task states, the first 6 bits of struct umcg_task.state_ts.
+ * The states represent the user space point of view.
+ */
+#define UMCG_TASK_NONE			0ULL
+#define UMCG_TASK_RUNNING		1ULL
+#define UMCG_TASK_IDLE			2ULL
+#define UMCG_TASK_BLOCKED		3ULL
+
+/* UMCG task state flags, bits 7-8 */
+
+/*
+ * UMCG_TF_LOCKED: locked by the userspace in preparation to calling umcg_wait.
+ */
+#define UMCG_TF_LOCKED			(1ULL << 6)
+
+/*
+ * UMCG_TF_PREEMPTED: the userspace indicates the worker should be preempted.
+ */
+#define UMCG_TF_PREEMPTED		(1ULL << 7)
+
+/* The first six bits: RUNNING, IDLE, or BLOCKED. */
+#define UMCG_TASK_STATE_MASK		0x3fULL
+
+/* The full kernel state mask: the first 13 bits. */
+#define UMCG_TASK_STATE_MASK_FULL	0x1fffULL
+
+/*
+ * The number of bits reserved for UMCG state timestamp in
+ * struct umcg_task.state_ts.
+ */
+#define UMCG_STATE_TIMESTAMP_BITS	46
+
+/* The number of bits truncated from UMCG state timestamp. */
+#define UMCG_STATE_TIMESTAMP_GRANULARITY	4
+
+/**
+ * struct umcg_task - controls the state of UMCG tasks.
+ *
+ * The struct is aligned at 64 bytes to ensure that it fits into
+ * a single cache line.
+ */
+struct umcg_task {
+	/**
+	 * @state_ts: the current state of the UMCG task described by
+	 *            this struct, with a unique timestamp indicating
+	 *            when the last state change happened.
+	 *
+	 * Readable/writable by both the kernel and the userspace.
+	 *
+	 * UMCG task state:
+	 *   bits  0 -  5: task state;
+	 *   bits  6 -  7: state flags;
+	 *   bits  8 - 12: reserved; must be zeroes;
+	 *   bits 13 - 17: for userspace use;
+	 *   bits 18 - 63: timestamp (see below).
+	 *
+	 * Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.
+	 * See Documentation/userspace-api/umcg.[txt|rst] for detals.
+	 */
+	uint64_t	state_ts;		/* r/w */
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
+	uint32_t	flags;			/* Reserved; must be zero. */
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
index 11f8a845f259..b52a79cfb130 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1688,6 +1688,16 @@ config MEMBARRIER

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
index d5a61d565ad5..62453772a0c7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -171,8 +171,10 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			handle_signal_work(regs, ti_work);

-		if (ti_work & _TIF_NOTIFY_RESUME)
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			umcg_handle_notify_resume();
 			tracehook_notify_resume(regs);
+		}

 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
diff --git a/kernel/exit.c b/kernel/exit.c
index 63851320ae73..c55f9df430c8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -745,6 +745,10 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");

+	/* Turn off UMCG sched hooks. */
+	if (unlikely(tsk->flags & PF_UMCG_WORKER))
+		tsk->flags &= ~PF_UMCG_WORKER;
+
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
@@ -781,6 +785,7 @@ void __noreturn do_exit(long code)

 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
+	umcg_handle_exit();

 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
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
index d6da1efb5ce6..9ff63e32544a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4236,6 +4236,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+	umcg_clear_child(p);
 }

 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6265,9 +6266,11 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
+		else if (task_flags & PF_UMCG_WORKER)
+			umcg_wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
 	}
@@ -6285,9 +6288,11 @@ static inline void sched_submit_work(struct task_struct *tsk)

 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
+		else if (tsk->flags & PF_UMCG_WORKER)
+			umcg_wq_worker_running(tsk);
 		else
 			io_wq_worker_running(tsk);
 	}
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
new file mode 100644
index 000000000000..bc4eeb3f5dd7
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,926 @@
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
+
+/**
+ * get_user_nofault - get user value without sleeping.
+ *
+ * get_user() might sleep and therefore cannot be used in preempt-disabled
+ * regions.
+ */
+#define get_user_nofault(out, uaddr)			\
+({							\
+	int ret = -EFAULT;				\
+							\
+	if (access_ok((uaddr), sizeof(*(uaddr)))) {	\
+		pagefault_disable();			\
+							\
+		if (!__get_user((out), (uaddr)))	\
+			ret = 0;			\
+							\
+		pagefault_enable();			\
+	}						\
+	ret;						\
+})
+
+/**
+ * umcg_pin_pages: pin pages containing struct umcg_task of this worker
+ *                 and its server.
+ *
+ * The pages are pinned when the worker exits to the userspace and unpinned
+ * when the worker is in sched_submit_work(), i.e. when the worker is
+ * about to be removed from its runqueue. Thus at most NR_CPUS UMCG pages
+ * are pinned at any one time across the whole system.
+ *
+ * The pinning is needed so that going-to-sleep workers can access
+ * their and their servers' userspace umcg_task structs without page faults,
+ * as the code path can be executed in the context of a pagefault, with
+ * mm lock held.
+ */
+static int umcg_pin_pages(u32 server_tid)
+{
+	struct umcg_task __user *worker_ut = current->umcg_task;
+	struct umcg_task __user *server_ut = NULL;
+	struct task_struct *tsk;
+
+	rcu_read_lock();
+	tsk = find_task_by_vpid(server_tid);
+	/* Server/worker interaction is allowed only within the same mm. */
+	if (tsk && current->mm == tsk->mm)
+		server_ut = READ_ONCE(tsk->umcg_task);
+	rcu_read_unlock();
+
+	if (!server_ut)
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
+ * umcg_update_state: atomically update umcg_task.state_ts, set new timestamp.
+ * @state_ts   - points to the state_ts member of struct umcg_task to update;
+ * @expected   - the expected value of state_ts, including the timestamp;
+ * @desired    - the desired value of state_ts, state part only;
+ * @may_fault  - whether to use normal or _nofault cmpxchg.
+ *
+ * The function is basically cmpxchg(state_ts, expected, desired), with extra
+ * code to set the timestamp in @desired.
+ */
+static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
+				bool may_fault)
+{
+	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
+	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
+
+	/* Cut higher order bits. */
+	next_ts &= ((1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1);
+
+	if (next_ts == curr_ts)
+		++next_ts;
+
+	/* Remove an old timestamp, if any. */
+	desired &= ((1ULL << (64 - UMCG_STATE_TIMESTAMP_BITS)) - 1);
+
+	/* Set the new timestamp. */
+	desired |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
+
+	if (may_fault)
+		return cmpxchg_user_64(state_ts, expected, desired);
+
+	return cmpxchg_user_64_nofault(state_ts, expected, desired);
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
+ *              - @flags & UMCG_CTL_WORKER
+ *         UMCG servers:
+ *              - !(@flags & UMCG_CTL_WORKER)
+ *
+ *         All tasks:
+ *              - self->state must be UMCG_TASK_RUNNING
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
+	if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING)
+		return -EINVAL;
+
+	WRITE_ONCE(current->umcg_task, self);
+
+	if (flags == UMCG_CTL_WORKER) {
+		current->flags |= PF_UMCG_WORKER;
+
+		/* Trigger umcg_handle_resuming_worker() */
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	}
+
+	return 0;
+}
+
+/**
+ * handle_timedout_worker - make sure the worker is added to idle_workers
+ *                          upon a "clean" timeout.
+ */
+static int handle_timedout_worker(struct umcg_task __user *self)
+{
+	u64 curr_state, next_state;
+	int ret;
+
+	if (get_user(curr_state, &self->state_ts))
+		return -EFAULT;
+
+	if ((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE) {
+		/* TODO: should we care here about TF_LOCKED or TF_PREEMPTED? */
+
+		next_state = curr_state & ~UMCG_TASK_STATE_MASK;
+		next_state |= UMCG_TASK_BLOCKED;
+
+		ret = umcg_update_state(&self->state_ts, &curr_state, next_state, true);
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
+	struct page *pinned_page = NULL;
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
+		u64 umcg_state;
+
+		/*
+		 * We need to read from userspace _after_ the task is marked
+		 * TASK_INTERRUPTIBLE, to properly handle concurrent wakeups;
+		 * but faulting is not allowed; so we try a fast no-fault read,
+		 * and if it fails, pin the page temporarily.
+		 */
+retry_once:
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/* Order set_current_state above with get_user_nofault below. */
+		smp_mb();
+		ret = -EFAULT;
+		if (get_user_nofault(umcg_state, &self->state_ts)) {
+			set_current_state(TASK_RUNNING);
+
+			if (pinned_page)
+				goto out;
+			else if (1 != pin_user_pages_fast((unsigned long)self,
+						1, 0, &pinned_page))
+					goto out;
+
+			goto retry_once;
+		}
+
+		if (pinned_page) {
+			unpin_user_page(pinned_page);
+			pinned_page = NULL;
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
+			/* Clear PF_UMCG_WORKER to elide workqueue handlers. */
+			const bool worker = current->flags & PF_UMCG_WORKER;
+
+			if (worker)
+				current->flags &= ~PF_UMCG_WORKER;
+
+			freezable_schedule();
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
+		if (get_user(umcg_state, &self->state_ts))
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
+	if (pinned_page) {
+		unpin_user_page(pinned_page);
+		pinned_page = NULL;
+	}
+
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
+/**
+ * umcg_wakeup_allowed - check whether @current can wake @tsk.
+ *
+ * Currently a placeholder that allows wakeups within a single process
+ * only (same mm). In the future the requirement will be relaxed (securely).
+ */
+static bool umcg_wakeup_allowed(struct task_struct *tsk)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (tsk->mm && tsk->mm == current->mm && READ_ONCE(tsk->umcg_task))
+		return true;
+
+	return false;
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
+	if (!next || !umcg_wakeup_allowed(next)) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	/* The result of ttwu below is ignored. */
+	try_to_wake_up(next, TASK_NORMAL, wake_flags);
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
+	int ret;
+
+	ret = umcg_ttwu(next_tid, WF_CURRENT_CPU);
+	if (ret)
+		return ret;
+
+	return umcg_idle_loop(abs_timeout);
+}
+
+/**
+ * sys_umcg_wait: put the current task to sleep and/or wake another task.
+ * @flags:        zero or a value from enum umcg_wait_flag.
+ * @abs_timeout:  when to wake the task, in nanoseconds; zero for no timeout.
+ *
+ * @self->state_ts must be UMCG_TASK_IDLE (where @self is current->umcg_task)
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
+					WF_CURRENT_CPU : 0);
+	}
+
+	/* Unlock the worker, if locked. */
+	if (current->flags & PF_UMCG_WORKER) {
+		u64 umcg_state;
+
+		if (get_user(umcg_state, &self->state_ts))
+			return -EFAULT;
+
+		if ((umcg_state & UMCG_TF_LOCKED) && umcg_update_state(
+					&self->state_ts, &umcg_state,
+					umcg_state & ~UMCG_TF_LOCKED, true))
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
+/*
+ * Wake idle server: find the task, change its state IDLE=>RUNNING, ttwu.
+ */
+static int umcg_wake_idle_server_nofault(u32 server_tid)
+{
+	struct umcg_task __user *ut_server = NULL;
+	struct task_struct *tsk;
+	int ret = -EINVAL;
+	u64 state;
+
+	rcu_read_lock();
+
+	tsk = find_task_by_vpid(server_tid);
+	/* Server/worker interaction is allowed only within the same mm. */
+	if (tsk && current->mm == tsk->mm)
+		ut_server = READ_ONCE(tsk->umcg_task);
+
+	if (!ut_server)
+		goto out_rcu;
+
+	ret = -EFAULT;
+	if (get_user_nofault(state, &ut_server->state_ts))
+		goto out_rcu;
+
+	ret = -EAGAIN;
+	if ((state & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_IDLE)
+		goto out_rcu;
+
+	ret = umcg_update_state(&ut_server->state_ts, &state,
+			UMCG_TASK_RUNNING, false);
+
+	if (ret)
+		goto out_rcu;
+
+	try_to_wake_up(tsk, TASK_NORMAL, WF_CURRENT_CPU);
+	ret = 0;
+
+out_rcu:
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
+ * Wake idle server: find the task, change its state IDLE=>RUNNING, ttwu.
+ */
+static int umcg_wake_idle_server_may_fault(u32 server_tid)
+{
+	struct umcg_task __user *ut_server = NULL;
+	struct task_struct *tsk;
+	int ret = -EINVAL;
+	u64 state;
+
+	rcu_read_lock();
+	tsk = find_task_by_vpid(server_tid);
+	if (tsk && current->mm == tsk->mm)
+		ut_server = READ_ONCE(tsk->umcg_task);
+	rcu_read_unlock();
+
+	if (!ut_server)
+		return -EINVAL;
+
+	if (get_user(state, &ut_server->state_ts))
+		return -EFAULT;
+
+	if ((state & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_IDLE)
+		return -EAGAIN;
+
+	ret = umcg_update_state(&ut_server->state_ts, &state,
+			UMCG_TASK_RUNNING, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * umcg_ttwu will call find_task_by_vpid again; but we cannot
+	 * elide this, as we cannot do get_user() from an rcu-locked
+	 * code block.
+	 */
+	return umcg_ttwu(server_tid, WF_CURRENT_CPU);
+}
+
+/*
+ * Wake idle server: find the task, change its state IDLE=>RUNNING, ttwu.
+ */
+static int umcg_wake_idle_server(u32 server_tid, bool may_fault)
+{
+	int ret = umcg_wake_idle_server_nofault(server_tid);
+
+	if (!ret)
+		return 0;
+
+	if (!may_fault || ret != -EFAULT)
+		return ret;
+
+	return umcg_wake_idle_server_may_fault(server_tid);
+}
+
+/*
+ * Called in sched_submit_work() context for UMCG workers. In the common case,
+ * the worker's state changes RUNNING => BLOCKED, and its server's state
+ * changes IDLE => RUNNING, and the server is ttwu-ed.
+ *
+ * Under some conditions (e.g. the worker is "locked", see
+ * /Documentation/userspace-api/umcg.[txt|rst] for more details), the
+ * function does nothing.
+ *
+ * The function is called with preempt disabled to make sure the retry_once
+ * logic below works correctly.
+ */
+static void process_sleeping_worker(struct task_struct *tsk, u32 *server_tid)
+{
+	struct umcg_task __user *ut_worker = tsk->umcg_task;
+	u64 curr_state, next_state;
+	bool retried = false;
+	u32 tid;
+	int ret;
+
+	*server_tid = 0;
+
+	if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid UMCG worker."))
+		return;
+
+	/* If the worker has no server, do nothing. */
+	if (unlikely(!tsk->pinned_umcg_server_page))
+		return;
+
+	if (get_user_nofault(curr_state, &ut_worker->state_ts))
+		goto die;
+
+	/*
+	 * The userspace is allowed to concurrently change a RUNNING worker's
+	 * state only once in a "short" period of time, so we retry state
+	 * change at most once. As this retry block is within a
+	 * preempt_disable region, "short" is truly short here.
+	 *
+	 * See Documentation/userspace-api/umcg.[txt|rst] for details.
+	 */
+retry_once:
+	if (curr_state & UMCG_TF_LOCKED)
+		return;
+
+	if (WARN_ONCE((curr_state & UMCG_TASK_STATE_MASK) != UMCG_TASK_RUNNING,
+			"Unexpected UMCG worker state."))
+		goto die;
+
+	next_state = curr_state & ~UMCG_TASK_STATE_MASK;
+	next_state |= UMCG_TASK_BLOCKED;
+
+	ret = umcg_update_state(&ut_worker->state_ts, &curr_state, next_state, false);
+	if (ret == -EAGAIN) {
+		if (retried)
+			goto die;
+
+		retried = true;
+		goto retry_once;
+	}
+	if (ret)
+		goto die;
+
+	if (get_user_nofault(tid, &ut_worker->next_tid))
+		goto die;
+
+	*server_tid = tid;
+	return;
+
+die:
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+}
+
+/* Called from sched_submit_work(). Must not fault/sleep. */
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	u32 server_tid;
+
+	/*
+	 * Disable preemption so that retry_once in process_sleeping_worker
+	 * works properly.
+	 */
+	preempt_disable();
+	process_sleeping_worker(tsk, &server_tid);
+	preempt_enable();
+
+	if (server_tid) {
+		int ret = umcg_wake_idle_server_nofault(server_tid);
+
+		if (ret && ret != -EAGAIN)
+			goto die;
+	}
+
+	goto out;
+
+die:
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+out:
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
+
+	/* Empty result is OK. */
+	*server_tid = 0;
+
+	if (get_user(server_tid_ptr, &ut_worker->idle_server_tid_ptr))
+		return false;
+
+	if (!server_tid_ptr)
+		return false;
+
+	tid = 0;
+	if (xchg_user_32((u32 __user *)server_tid_ptr, &tid))
+		return false;
+
+	*server_tid = tid;
+	return true;
+}
+
+/*
+ * Returns true to wait for the userspace to schedule this worker, false
+ * to return to the userspace.
+ *
+ * In the common case, a BLOCKED worker is marked IDLE and enqueued
+ * to idle_workers_ptr list. The idle server is woken (if present).
+ *
+ * If a RUNNING worker is preempted, this function will trigger, in which
+ * case the worker is moved to IDLE state and its server is woken.
+ *
+ * Sets @server_tid to point to the server to be woken if the worker
+ * is going to sleep; sets @server_tid to point to the server assigned
+ * to this RUNNING worker if the worker is to return to the userspace.
+ */
+static bool process_waking_worker(struct task_struct *tsk, u32 *server_tid)
+{
+	struct umcg_task __user *ut_worker = tsk->umcg_task;
+	u64 curr_state, next_state;
+
+	*server_tid = 0;
+
+	if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
+		return false;
+
+	if (fatal_signal_pending(tsk))
+		return false;
+
+	if (get_user(curr_state, &ut_worker->state_ts))
+		goto die;
+
+	if ((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_RUNNING) {
+		u32 tid;
+
+		/* Wakeup: wait but don't enqueue. */
+		if (curr_state & UMCG_TF_LOCKED)
+			return true;
+
+		smp_rmb();  /* Order getting state and getting server_tid */
+		if (get_user(tid, &ut_worker->next_tid))
+			goto die;
+
+		if (tid) {
+			*server_tid = tid;
+
+			/* pass-through: RUNNING with a server. */
+			if (!(curr_state & UMCG_TF_PREEMPTED))
+				return false;
+		} else if (curr_state & UMCG_TF_PREEMPTED)
+			/* PREEMPTED workers must have servers. */
+			goto die;
+
+		/*
+		 * Fallthrough to mark the worker IDLE: the worker is
+		 * PREEMPTED, or the worker is RUNNING, but has no server
+		 * (which happens via UMCG_WAIT_WAKE_ONLY).
+		 */
+	} else if (unlikely((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE &&
+			(curr_state & UMCG_TF_LOCKED)))
+		/* The worker prepares to sleep or to unregister. */
+		return false;
+
+	if (unlikely((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE))
+		goto die;
+
+	next_state = curr_state & ~UMCG_TASK_STATE_MASK;
+	next_state |= UMCG_TASK_IDLE;
+
+	if (umcg_update_state(&ut_worker->state_ts, &curr_state,
+			next_state, true))
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
+		if (server_tid) {
+			int ret = umcg_wake_idle_server(server_tid, true);
+
+			if (ret && ret != -EAGAIN)
+				goto die;
+		}
+
+		umcg_idle_loop(0);
+	} while (true);
+
+	if (!server_tid)
+		/* No server => no reason to pin pages. */
+		umcg_unpin_pages();
+	else if (umcg_pin_pages(server_tid))
+		goto die;
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
index f43d89d92860..682261d78ee7 100644
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

