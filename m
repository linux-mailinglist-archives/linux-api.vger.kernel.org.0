Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06C23CBC15
	for <lists+linux-api@lfdr.de>; Fri, 16 Jul 2021 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhGPSup (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhGPSul (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 14:50:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9DDC0613DC
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h4so10816018pgp.5
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2xrGWC5ax9dYaoviTXFXJBezIMD1M+T9xDtDjSWzSo=;
        b=cii2xlAm7iBG3S02WDoXl2EWQU9rOJnEZBng0MfesydbxchSJ1D5X4tYCq36dv/cpw
         sScD5irG0vIKml7xkEOSsArjhrpBo+t0d/Rntfo2yei0yqbczyjK9rCh8sbxXyWQ2S13
         bAQzTV/PxvHnC+Fj+thDCx29Hamy2lJ7yufthY9kNVA3Mo5eUESw/tCk5UmQzSVRwJPg
         k3cfIb35zsfp9dNt4dCZ4mXSn2q2LuG/wndloLfzTZcOYcBtPwnZnVX2gqkxHWkeg3Iq
         teCLdx93XaLkSVJ58Xqn5Xcu4TymkQm/BJsvJfpRLAtAmfFznWVyGid5yZOs6HhAn91p
         ka1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2xrGWC5ax9dYaoviTXFXJBezIMD1M+T9xDtDjSWzSo=;
        b=udFbFbILPLqoPvjkW+gqCacJcoWLvwyJFbsJur9bKfT3d+6oNK5f0WgO6pw79XRx6j
         2zvIZqds0thTarXGbT0PXDKjgev228kIyWsjpAZ0GNQu6w5v2EctAwhzi0pOe+ySQ1eo
         AzM4gT2QcFKFE94+YMTcySNlX+aKberuLWTbah0UpyMW/k5emgHkPw0wFf9WIZIWf+NH
         OT1I2epiP9enIOCc4UtKeflhwQPoVevVCFoft6TL0kzt0KuEhBULiOk44/icuUoqGWl5
         vi2OCEFamvwbl9pYZMUZVfReli1gamseWNArtM4LHU5kjHKHBwBDPPOWpwXBT27MU4T0
         BomA==
X-Gm-Message-State: AOAM531E6AovCd2M/tp8naBjxHlF+WVODahENPC1p3YM8EeJR8qcJ1zK
        bJ9B3TAcqVLsH9pVZaUAK3k3Ug==
X-Google-Smtp-Source: ABdhPJwX4kUARFtjkxkAiFJtTB8f/989ioKBAHF5Dw4Eo7Q/5NskbUWanF+32biZomLjhZPYwY4Vsw==
X-Received: by 2002:a63:f348:: with SMTP id t8mr11163994pgj.23.1626461254495;
        Fri, 16 Jul 2021 11:47:34 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id q125sm3170240pga.87.2021.07.16.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:47:34 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
Date:   Fri, 16 Jul 2021 11:47:19 -0700
Message-Id: <20210716184719.269033-5-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716184719.269033-1-posk@google.com>
References: <20210716184719.269033-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Define struct umcg_task and sys_umcg_ctl/sys_umcg_wait syscalls.

This is another attempt at implementing UMCG, based on
discussion in https://lore.kernel.org/patchwork/cover/1433967/

Most of the "why" is covered here (some details are obsolete):
https://lore.kernel.org/patchwork/cover/1433967/#1632328

I'll update this commit message with more "why" when the general
approach is ACKed at a high level.

In this patch I used the approach suggested by peterz@ (should I add
a Suggested-by: tag?) in the discussion linked above;
specifically, only a single

struct umcg_task __user *umcg_task

pointer is added to struct task_struct.

Comments in include/uapi/linux/umcg.h and kernel/sched/umcg.c
provide many details on how UMCG syscalls are to be used.

What is NOT implemented yet:
- timeouts;
- preemption.

All the basics (wait/wake/swap, block/wake detection) seem to be
working.

v0.2->v0.3 changes:
- new protocol for working with idle workers and servers is used, to avoid
  spinning in the kernel;
- waking a UMCG task now does not require spinning.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/sched.h                  |   6 +
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/umcg.h              | 259 +++++++++++++
 init/Kconfig                           |  10 +
 kernel/exit.c                          |   7 +
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |  17 +-
 kernel/sched/umcg.c                    | 485 +++++++++++++++++++++++++
 kernel/sched/umcg.h                    |  13 +
 kernel/sys_ni.c                        |   4 +
 12 files changed, 813 insertions(+), 3 deletions(-)
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
index 000000000000..402974b475bf
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,259 @@
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
+ */
+
+/*
+ * UMCG task states, the first 8 bits. The states represent the user space
+ * point of view.
+ *
+ * UMCG tasks can be either RUNNING, i.e. doing useful work, or IDLE,
+ * i.e. have no work assigned to them and blocked in sys_umcg_wait().
+ *
+ * In addition, when a UMCG worker blocks in the kernel (e.g. on I/O),
+ * it is marked as BLOCKED; when a BLOCKED worker completes its blocking
+ * operation, it is marked as IDLE and added to idle_workers list (see
+ * struct umcg_task below), until a server "runs" it.
+ *
+ * UMCG servers continue to be considered as RUNNING even if they are blocked
+ * in the kernel in any way other than in sys_umcg_wait().
+ *
+ * State transitions:
+ *
+ * RUNNING => IDLE:   the current RUNNING task becomes IDLE by calling
+ *                    sys_umcg_wait();
+ * IDLE => RUNNING:   - another worker or server task called
+ *                      sys_umcg_wait() with self->next_tid pointing to the
+ *                      task transitioning from IDLE to RUNNING (mostly
+ *                      applies to workers and basic tasks);
+ *                    - the userspace marked and IDLE task as RUNNING and
+ *                      sent a signal to it (thus interrupting sys_umcg_wait);
+ *                    - servers: the kernel wakes an IDLE server from
+ *                      idle_servers list when a BLOCKED worker becomes IDLE
+ *                      (see below);
+ *                    - servers: the kernel wakes and IDLE server that
+ *                      is "attached" to a RUNNING worker when the worker
+ *                      becomes BLOCKED;
+ * RUNNING => BLOCKED: when a RUNNING UMCG worker blocks in the kernel,
+ *                     the kernel marks it as BLOCKED (and wakes its server);
+ * BLOCKED => IDLE:    when a BLOCKED UMCG worker finishes its blocking
+ *                     operation, the kernel marks it as IDLE, adds it to
+ *                     the list of idle workers (see struct umcg_task) and
+ *                     wakes an idle server from the list of idle servers, if
+ *                     available.
+ *
+ * Note 1: only the transitions listed above are possible; these state
+ *         transitions never happen:
+ *         - IDLE => BLOCKED         (never happen)
+ *         - BLOCKED => RUNNING      (never happen)
+ *
+ * Note 2: only UMCG workers (UMCG tasks registered with UMCG_CTL_WORKER
+ *         flag set) are subject to block/wake detection logic;
+ *
+ * Note 3: if a worker has UMC_TF_LOCKED state flag set, it behaves as
+ *         a server, i.e. the block/wake detection is disabled (this is a UMCG
+ *         equivalent of task_lock() or preempt_disable()). UMCG_TF_LOCKED
+ *         flag is cleared by the kernel when the worker goes to sleep in
+ *         umcg_wait().
+ *
+ * Note 4: changing the value of umcg_task.state field is the responsibility
+ *         of the party initiating the state change: when a state transition
+ *         is initiated by the userspace via a call to sys_umcg_wait(), it
+ *         is the userspace's responsibility to change the value of the
+ *         umcg_task.state field; when a state transition is initiated
+ *         by the kernel during worker block/wake handling, it is the kernel
+ *         who marks the worker as BLOCKED or IDLE, and the server as RUNNING.
+ */
+#define UMCG_TASK_NONE			0
+#define UMCG_TASK_RUNNING		1
+#define UMCG_TASK_IDLE			2
+#define UMCG_TASK_BLOCKED		3
+
+#define UMCG_TF_STATE_MASK		0xff
+
+/* UMCG task state flags, bits 8-15 */
+
+/*
+ * UMCG_TF_LOCKED: locked by the userspace; workers with UMCG_TF_LOCKED set
+ * do not become BLOCKED and do not wake their attached server.
+ */
+#define UMCG_TF_LOCKED			(1 << 8)
+
+/**
+ * struct umcg_task - controls the state of UMCG tasks.
+ *
+ * UMCG tasks can be:
+ *
+ * - UMCG workers: must have a UMCG server assigned when running (unless
+ *                 UMCG_TF_LOCKED flag is set); the server is woken when
+ *                 the worker blocks; has PF_UMCG_WORKER task flag set
+ *                 in task_struct.
+ *
+ *                 Both @idle_servers_ptr and @idle_workes_ptr are !NULL
+ *                 when running or calling sys_umcg_wait().
+ *
+ *                 A worker's state can be:
+ *                 - RUNNING: is schedulable by the kernel, has a server
+ *                            assigned in @server_tid;
+ *                 - IDLE: not schedulable by the kernel; can be
+ *                         context-switched into via sys_umcg_wait;
+ *                 - BLOCKED: blocked in the kernel (e.g. on I/O).
+ *
+ * - UMCG servers: A server's state can be:
+ *                 - RUNNING: behaves like a "normal" task: is schedulable
+ *                            by the kernel, can block on I/O, etc.
+ *                 - IDLE: not schedulable by the kernel.
+ *
+ * See sys_umcg_ctl() documentation in kernel/sched/umcg.c for a detailed
+ * explanation of how UMCG task types are determined.
+ *
+ * See sys_umcg_wait() documentation in kernel/sched/ucmg.c for a detailed
+ * explanation of server/worker interactions.
+ *
+ * Once a UMCG task is registered, it may not change its type.
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
+	 * @api_version: the version of UMCG API the userspace would like
+	 *               to use. Must be set before calling umcg_ctl
+	 *               and must not be changed afterwards.
+	 */
+	uint32_t	api_version;		/* r   */
+
+	/**
+	 * @server_tid: the TID of the server UMCG task that should be
+	 *              woken when this WORKER becomes BLOCKED. Can be zero.
+	 *
+	 *              If this is a UMCG server, @server_tid should
+	 *              contain the TID of @self - it will be used to find
+	 *              the task_struct to wake when pulled from
+	 *              @idle_servers.
+	 *
+	 * Read-only for the kernel, read/write for the userspace.
+	 */
+	uint32_t	server_tid;		/* r   */
+
+	/**
+	 * @next_tid: the TID of the UMCG task that should be context-switched
+	 *            into in sys_umcg_wait(). Can be zero.
+	 *
+	 * Read-only for the kernel, read/write for the userspace.
+	 */
+	uint32_t	next_tid;		/* r   */
+
+	/**
+	 * @idle_servers_ptr: a single-linked list pointing to the list
+	 *                    of idle servers. Can be NULL.
+	 *
+	 * Readable/writable by both the kernel and the userspace: the
+	 * userspace adds items to the list, the kernel removes them.
+	 *
+	 * This is a single-linked list (stack): head->next->next->next->NULL.
+	 * "next" nodes are idle_servers_ptr fields in struct umcg_task.
+	 *
+	 * Example:
+	 *
+	 *  a running worker             idle server 1        idle server 2
+	 *
+	 * struct umct_task:             struct umcg_task:    struct umcg_task:
+	 *    state                         state                state
+	 *    api_version                   api_version          api_version
+	 *    ...                           ...                  ...
+	 *    idle_servers_ptr --> head --> idle_servers_ptr --> idle_servers_ptr --> NULL
+	 *    ...                           ...                  ...
+	 *
+	 *
+	 * Due to the way struct umcg_task is aligned, idle_servers_ptr
+	 * is aligned at 8 byte boundary, and so has its first byte as zero
+	 * when it holds a valid pointer.
+	 *
+	 * When pulling idle servers from the list, the kernel marks nodes as
+	 * "deleted" by ORing the node value (the pointer) with 1UL atomically.
+	 * If a node is "deleted" (i.e. its value AND 1UL is not zero),
+	 * the kernel proceeds to the next node.
+	 *
+	 * The kernel checks at most [nr_cpu_ids * 2] first nodes in the list.
+	 *
+	 * It is NOT considered an error if the kernel cannot find an idle
+	 * server.
+	 *
+	 * The userspace is responsible for cleanup/gc (i.e. for actually
+	 * removing nodes marked as "deleted" from the list).
+	 */
+	uint64_t	idle_servers_ptr;	/* r/w */
+
+	/**
+	 * @idle_workers_ptr: a single-linked list pointing to the list
+	 *                    of idle workers. Can be NULL.
+	 *
+	 * Readable/writable by both the kernel and the userspace: the
+	 * kernel adds items to the list, the userspace removes them.
+	 *
+	 * The list (stack) is structured the same way as idle_servers_ptr
+	 * above. The kernel pushes new nodes to the beginning of the list
+	 * by assigning the current head value to the node's idle_workers_ptr
+	 * and trying to atomically change the head to point to the new node.
+	 *
+	 * The kernel tries at most [nr_cpu_ids + 1] times to push a node
+	 * onto the stack, after which the idle worker will sleep a short
+	 * while before attempting to do so again. After several failed
+	 * attempts the kernel will SIGKILL the worker.
+	 */
+	uint64_t	idle_workers_ptr;	/* r/w */
+} __attribute__((packed, aligned(8 * sizeof(__u64))));
+
+/**
+ * enum umcg_ctl_flag - flags to pass to sys_umcg_ctl
+ * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
+ * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
+ * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
+ *
+ * See sys_umcg_ctl documentation for more details.
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
index 000000000000..f87c32974882
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ *
+ * See include/uapi/linux/umcg.h for more documentation.
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
+static int umcg_validate_version(u32 api_version)
+{
+	if (api_version == 1)
+		return 0;
+	return 1;
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
+ *              - self->api_version must match one of the supported API
+ *                versions
+ *              - self->server_tid must be zero
+ *              - self->next_tid must be zero
+ *
+ *         If the conditions above are met, sys_umcg_ctl() immediately returns
+ *         if the registered task is a server; a worker will be added to
+ *         idle_workers_ptr, and the worker put to sleep; an idle server
+ *         from idle_servers_ptr will be woken, if any.
+ *
+ * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
+ *           is a UMCG worker, the userspace is responsible for waking its
+ *           server (before or after calling sys_umcg_ctl).
+ *
+ * Return:
+ * 0                - success
+ * > 0              - the highest supported API version if @self->api_version
+ *                    is not supported (when registering)
+ * -EFAULT          - failed to read @self
+ * -EINVAL          - some other error occurred
+ */
+SYSCALL_DEFINE2(umcg_ctl, u32, flags, struct umcg_task __user *, self)
+{
+	struct umcg_task ut;
+	int ret;
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
+	if (current->umcg_task)
+		return -EINVAL;
+
+	if (copy_from_user(&ut, self, sizeof(ut)))
+		return -EFAULT;
+
+	ret = umcg_validate_version(ut.api_version);
+	if (ret)
+		return ret;
+
+	if (ut.server_tid || ut.next_tid)
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
+/* Sleep until interrupted or self.state becomes RUNNING or timeout expires. */
+static int umcg_idle_loop(u64 abs_timeout)
+{
+	struct umcg_task __user *self = current->umcg_task;
+
+	if (abs_timeout)
+		return -EOPNOTSUPP;
+
+	/* Unlock the worker, if locked. */
+	if (current->flags & PF_UMCG_WORKER) {
+		u32 umcg_state;
+
+		smp_mb();  /* Protect the read below. */
+		if (get_user(umcg_state, &self->state))
+			return -EFAULT;
+
+		if ((umcg_state & UMCG_TF_LOCKED) && cmpxchg_user_32(
+					&self->state, &umcg_state,
+					umcg_state & ~UMCG_TF_LOCKED))
+			return -EFAULT;
+	}
+
+	while (true) {
+		u32 umcg_state;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		smp_mb();  /* Order with set_current_state() above. */
+		if (get_user(umcg_state, &self->state)) {
+			set_current_state(TASK_RUNNING);
+			return -EFAULT;
+		}
+
+		if ((umcg_state & UMCG_TF_STATE_MASK) ==
+				UMCG_TASK_RUNNING) {
+			set_current_state(TASK_RUNNING);
+			return 0;
+		}
+
+		freezable_schedule();
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		if (get_user(umcg_state, &self->state))
+			return -EFAULT;
+
+		if ((umcg_state & UMCG_TF_STATE_MASK) == UMCG_TASK_RUNNING)
+			return 0;
+	}
+}
+
+/*
+ * Try to wake up. May be called with preempt_disable set.
+ *
+ * Note: umcg_ttwu succeeds even if ttwu fails: see wait/wake state
+ *       ordering logic documented in sys_umcg_wait() below.
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
+ * essentially treated as one.
+ */
+static int umcg_do_context_switch(u32 next_tid, u64 abs_timeout)
+{
+	struct task_struct *next;
+
+	if (abs_timeout)
+		return -EOPNOTSUPP;
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
+ * sys_umcg_wait: sleep the current task and/or wake another task.
+ * @flags:        zero or a value from enum umcg_wait_flag.
+ * @abs_timeout:  when to wake the task; zero for no timeout. NOT SUPPORTED yet.
+ *
+ * @self->state must be UMCG_TASK_IDLE (where @self is current->umcg_task
+ * if !(@flags & UMCG_WAIT_WAKE_ONLY).
+ *
+ * If @self->next_tid is not zero, it must point to an IDLE UMCG task blocked
+ * in sys_umcg_wait(). The userspace must have changed its state from IDLE to
+ * RUNNING before calling sys_umcg_wait() in the current task. This "next"
+ * task will be woken (context-switched-to on the fast path) when the current
+ * task is put to sleep.
+ *
+ * If this is a worker (PF_UMCG_WORKER is set), and @self->next_tid is zero,
+ * the server assigned to this worker (@self->server_tid) will be
+ * woken/switched-to; same rules apply (the server must be waiting in
+ * sys_umcg_wait(); its state must be RUNNING now).
+ *
+ * If @self->next_tid points to a UMCG worker, it must have its server_tid
+ * set, with the server blocked in sys_umcg_wait().
+ *
+ *
+ * Note: wait/wake ordering: to avoid missing wakeups, the following
+ *       state changes order is required:
+ *
+ *       wait: the userspace marks the current task's UMCG state as IDLE
+ *             and calls sys_umcg_wait().
+ *       wake: the userspace marks the wakee's UMCG state as RUNNING and
+ *             calls sys_umcg_wait() with the wakee's TID in self->next_tid;
+ *
+ *       To wake a umcg task, the kernel issues a single ttwu() call, ignoring
+ *       the result. On the wait path the kernel carefully orders task
+ *       state changes with umcg state checks to ensure the wakeup above
+ *       is not lost. See umcg_idle_loop for details.
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
+	if (!next_tid && current->flags & PF_UMCG_WORKER) {
+		if (get_user(next_tid, &self->server_tid))
+			return -EFAULT;
+	}
+
+	if (next_tid)
+		return umcg_do_context_switch(next_tid, abs_timeout);
+
+	return umcg_idle_loop(abs_timeout);
+}
+
+#define umcg_die() \
+{                                                                \
+	pr_warn("UMCG: umcg_die: %s:%d\n", __FILE__, __LINE__);  \
+	force_sig(SIGSEGV);                                      \
+}
+
+/* Try to wake the server; may be called within preempt_disable section. */
+static bool try_to_wake_server(struct umcg_task __user *ut_server, u32 server_tid)
+{
+	u32 state = UMCG_TASK_IDLE;
+
+	if (WARN_ON(!(ut_server || server_tid)))
+		return false;
+
+	if (!ut_server) {
+		struct task_struct *tsk;
+
+		rcu_read_lock();
+		tsk = find_task_by_vpid(server_tid);
+		if (tsk)
+			ut_server = READ_ONCE(tsk->umcg_task);
+		rcu_read_unlock();
+
+		if (!ut_server)
+			return false;
+	}
+
+	if (!server_tid && get_user(server_tid, &ut_server->server_tid))
+		return false;
+
+	if (cmpxchg_user_32(&ut_server->state, &state, UMCG_TASK_RUNNING)) {
+		if (state != UMCG_TASK_RUNNING)
+			umcg_die();  /* The userspace broke the contract. */
+		return false;
+	}
+
+	/* TODO: make a smarter context switch when available. */
+	return umcg_ttwu(server_tid, WF_CURRENT_CPU) == 0;
+}
+
+/*
+ * Change the worker's state RUNNING => BLOCKED or BLOCKED => IDLE, depending
+ * on context (@sleeping).
+ *
+ * May be called with preempt_disable.
+ *
+ * Returns true to continue; false to abort.
+ */
+static bool wq_worker_change_state(struct umcg_task __user *ut_worker,
+		bool sleeping)
+{
+	u32 prev_state, next_state;
+	int ret;
+
+	smp_mb();  /* Guard the read below. */
+	if (get_user_nosleep(prev_state, &ut_worker->state)) {
+		umcg_die();
+		return false;
+	}
+
+	if (prev_state & UMCG_TF_LOCKED)
+		return false;
+
+	if (sleeping) {
+		if ((prev_state & UMCG_TF_STATE_MASK) !=
+				UMCG_TASK_RUNNING)
+			return false;
+	} else {
+		if ((prev_state & UMCG_TF_STATE_MASK) ==
+				UMCG_TASK_RUNNING) {
+			/*
+			 * Workers with servers attached should
+			 * pass through; workers without servers
+			 * should wait.
+			 */
+			u32 server_tid;
+
+			if (get_user_nosleep(server_tid,
+						&ut_worker->server_tid)) {
+				umcg_die();  /* The userspace broke the conract. */
+				return false;
+			}
+
+			if (server_tid)
+				return false;
+		}
+	}
+
+	next_state = prev_state & ~UMCG_TF_STATE_MASK;
+	next_state |= sleeping ? UMCG_TASK_BLOCKED : UMCG_TASK_IDLE;
+
+	ret = cmpxchg_user_32(&ut_worker->state, &prev_state, next_state);
+
+	if (!ret)
+		return true;
+
+	umcg_die(); /* The userspace broke the contract. */
+	return false;
+}
+
+/* Called from sched_submit_work() with preempt_disable. */
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	struct umcg_task __user *ut_worker = tsk->umcg_task;
+	u32 server_tid;
+
+	if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
+		return;
+
+	/* Step one: mark the worker as BLOCKED. */
+	if (!wq_worker_change_state(ut_worker, true))
+		return;
+
+	/* Step two: wake the server, if any. */
+	if (get_user_nosleep(server_tid, &ut_worker->server_tid)) {
+		umcg_die();  /* EFAULT */
+		return;
+	}
+
+	if (!server_tid)
+		return;
+
+	/* TODO: make a smarter context switch when available. */
+	try_to_wake_server(NULL, server_tid);
+}
+
+/* Called from sched_update_worker(). May sleep. */
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+	struct umcg_task __user *ut_worker = tsk->umcg_task;
+	u64 head, popped_server;
+
+	if (WARN_ONCE((tsk != current) || !ut_worker, "Invalid umcg worker"))
+		return;
+
+	/*
+	 * Remove the workqueue flag to avoid triggering
+	 * umcg_wq_worker_sleeping.
+	 */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	/* Step 1: mark the worker as IDLE and add to the idle workers list. */
+	if (!wq_worker_change_state(ut_worker, false))
+		goto out;
+
+	if (get_user(head, &ut_worker->idle_workers_ptr))
+		goto die;  /* EFAULT */
+
+	if (!head)
+		goto die;  /* The userspace broke the conract. */
+
+	if (umcg_sll_push((u64 __user *)head,
+			(u64 __user *)&ut_worker->idle_workers_ptr,
+			nr_cpu_ids * 2 /* max number of times to push */))
+		goto die;  /* TODO: sleep+retry several times before dying. */
+
+	smp_mb();  /* Make sure steps 1 and 2 are ordered. */
+
+	/* Step 2: wake an idle server, if any. */
+	if (get_user(head, &ut_worker->idle_servers_ptr))
+		goto die;
+
+	/* The number of servers should not exceed the number of CPUs much. */
+	if (head && umcg_sll_pop((u64 __user *)head, &popped_server,
+				nr_cpu_ids * 2 /* max number of nodes to check*/))
+		goto die;
+
+	if (popped_server) {
+		struct umcg_task __user *ut_server = container_of(
+				(u64 *)popped_server,
+				struct umcg_task, idle_servers_ptr);
+
+		try_to_wake_server(ut_server, 0);
+	}
+
+	/* Step 3: sleep until woken by a server */
+	umcg_idle_loop(0);
+
+out:
+	current->flags |= PF_UMCG_WORKER;
+	return;
+
+die:
+	umcg_die();
+}
diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
index 435531d751f2..619ba02be1d4 100644
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

