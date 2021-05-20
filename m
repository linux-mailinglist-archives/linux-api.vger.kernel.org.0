Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBA38B626
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhETShs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbhETShq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C788AC0613CE
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c9-20020a2580c90000b02904f86395a96dso23594779ybm.19
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=02k9PaiWF6MgIF9xV+zwKvyuH3odNOPDRaPNnuz/574=;
        b=YAYYOQV95V+Ugb3I/z2scCsMe1aDdwEnp62r/ZWJnJVZFw4raQgPaeyrGh9/UQfbut
         68CvM91QtkqhL8Wn54TbKKj24GVCa3UsdBior24N9sAFIDPicEiDb2WOP5DMJdWA5PHx
         urqTROYu+zecFVqavmBslueyGRMJvAilWGybym71Oq8UMls1gTBp8+BoOQ0pvlRDtnRR
         Pe/77pciPrY/nbYLGlysC0Ap/fMG7BgLUP0e8e3O1fVh+PzcF2vfimrYILYu10E244PD
         9UQQHADOvH8gMPnTZVQpGgrDpY5m8v1ZP8red2fCFG7AuzIROr4/3jCmzBoqJpjFPCfE
         9CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=02k9PaiWF6MgIF9xV+zwKvyuH3odNOPDRaPNnuz/574=;
        b=cJcOCYtCzXEn02453LTSzwk6SUxTpIgD68VB7gYVyo4RCzU9D2vAbLSw65IxfBCBtO
         hsqG2MnXGY1fwsM0AJWVCRowScvT3C/9KTMHF5OEQPgdHk3asu2hRyGdkA4pyHHbEVUU
         mz8PS1Weu5SisnwFTPGVn0qGOXGc07QnDmve/286LB4zATsf/4m1kLmLSbk4TJXeyyXW
         Mp/sh7H/503j0KtmcVNGBQuxuqVqLlRGZeg/5vb0+AzzW9Uf/SSeESbRDb0NPlYC7qce
         s1jd4QA7SFRWDyqlEtp4fyhCObZxxsflNLGnefvD+sq8KxeFkmnwPX95glKbOOYSSddK
         5Ebg==
X-Gm-Message-State: AOAM530fVE9MYx3USfwyuQW3NJGGb3vnqzIBcLhfZb6c7o0j7k4UM8aM
        tzv90zSKfldYeR7dZWIq43rewVcC
X-Google-Smtp-Source: ABdhPJxgN8eb3DRQfk6HFG19eRDRnhDZxtrf0DP2asfIk6BJ7uqknjGh69xP2aLV5PX/v7pe7kE9CXRw
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a25:dfc5:: with SMTP id w188mr9121045ybg.465.1621535783990;
 Thu, 20 May 2021 11:36:23 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:07 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-3-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 2/9] sched/umcg: add uapi/linux/umcg.h and sched/umcg.c
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce the uapi UMCG header file and document core UMCG API syscalls.

It is sometimes useful to separate the discussion of API from
the implementation details, and it seems to be the case here.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/syscalls.h  |   9 +++
 include/uapi/linux/umcg.h |  70 +++++++++++++++++++
 kernel/sched/Makefile     |   1 +
 kernel/sched/umcg.c       | 143 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..15de3e34ccee 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,6 +71,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct umcg_task;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1050,6 +1051,14 @@ asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr _
 asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
+asmlinkage long umcg_api_version(u32 api_version, u32 flags);
+asmlinkage long umcg_register_task(u32 api_version, u32 flags, u32 group_id,
+					struct umcg_task __user *umcg_task);
+asmlinkage long umcg_unregister_task(u32 flags);
+asmlinkage long umcg_wait(u32 flags, const struct __kernel_timespec __user *timeout);
+asmlinkage long umcg_wake(u32 flags, u32 next_tid);
+asmlinkage long umcg_swap(u32 wake_flags, u32 next_tid, u32 wait_flags,
+				const struct __kernel_timespec __user *timeout);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
new file mode 100644
index 000000000000..6c59563b41b2
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UMCG_H
+#define _UAPI_LINUX_UMCG_H
+
+#include <linux/limits.h>
+#include <linux/types.h>
+
+/*
+ * UMCG task states, the first 8 bits.
+ */
+#define UMCG_TASK_NONE			0
+/* UMCG server states. */
+#define UMCG_TASK_POLLING		1
+#define UMCG_TASK_SERVING		2
+#define UMCG_TASK_PROCESSING		3
+/* UMCG worker states. */
+#define UMCG_TASK_RUNNABLE		4
+#define UMCG_TASK_RUNNING		5
+#define UMCG_TASK_BLOCKED		6
+#define UMCG_TASK_UNBLOCKED		7
+
+/* UMCG task state flags, bits 8-15 */
+#define UMCG_TF_WAKEUP_QUEUED		(1 << 8)
+
+/*
+ * Unused at the moment flags reserved for features to be introduced
+ * in the near future.
+ */
+#define UMCG_TF_PREEMPT_DISABLED	(1 << 9)
+#define UMCG_TF_PREEMPTED		(1 << 10)
+
+#define UMCG_NOID	UINT_MAX
+
+/**
+ * struct umcg_task - controls the state of UMCG-enabled tasks.
+ *
+ * While at the moment only one field is present (@state), in future
+ * versions additional fields will be added, e.g. for the userspace to
+ * provide performance-improving hints and for the kernel to export sched
+ * stats.
+ *
+ * The struct is aligned at 32 bytes to ensure that even with future additions
+ * it fits into a single cache line.
+ */
+struct umcg_task {
+	/**
+	 * @state: the current state of the UMCG task described by this struct.
+	 *
+	 * UMCG task state:
+	 *   bits  0 -  7: task state;
+	 *   bits  8 - 15: state flags;
+	 *   bits 16 - 23: reserved; must be zeroes;
+	 *   bits 24 - 31: for userspace use.
+	 */
+	uint32_t	state;
+} __attribute((packed, aligned(4 * sizeof(uint64_t))));
+
+/**
+ * enum umcg_register_flag - flags for sys_umcg_register
+ * @UMCG_REGISTER_CORE_TASK:  Register a UMCG core task (not part of a group);
+ * @UMCG_REGISTER_WORKER:     Register a UMCG worker task;
+ * @UMCG_REGISTER_SERVER:     Register a UMCG server task.
+ */
+enum umcg_register_flag {
+	UMCG_REGISTER_CORE_TASK		= 0,
+	UMCG_REGISTER_WORKER		= 1,
+	UMCG_REGISTER_SERVER		= 2
+};
+
+#endif /* _UAPI_LINUX_UMCG_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfca5871..e4e481eee1b7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
 obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_UMCG) += umcg.o
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
new file mode 100644
index 000000000000..b8195cfdb76a
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ */
+
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/umcg.h>
+
+/**
+ * sys_umcg_api_version - query UMCG API versions that are supported.
+ * @api_version:          Requested API version.
+ * @flags:                Reserved.
+ *
+ * Return:
+ * 0                    - the @api_version is supported;
+ * > 0                  - the maximum supported version of UMCG API if
+ *                        the requested version is not supported.
+ * -EINVAL              - @flags is not zero.
+ *
+ * NOTE: the kernel may drop support for older/deprecated API versions,
+ * so a return of X does not indicate that any version less than X is
+ * supported.
+ */
+SYSCALL_DEFINE2(umcg_api_version, u32, api_version, u32, flags)
+{
+	return -ENOSYS;
+}
+
+/**
+ * sys_umcg_register_task - register the current task as a UMCG task.
+ * @api_version:       The expected/desired API version of the syscall.
+ * @flags:             One of enum umcg_register_flag.
+ * @group_id:          UMCG Group ID. UMCG_NOID for Core tasks.
+ * @umcg_task:         The control struct for the current task.
+ *                     umcg_task->state must be UMCG_TASK_NONE.
+ *
+ * Register the current task as a UMCG task. If this is a core UMCG task,
+ * the syscall marks it as RUNNING and returns immediately.
+ *
+ * If this is a UMCG worker, the syscall marks it UNBLOCKED, and proceeds
+ * with the normal UNBLOCKED worker logic.
+ *
+ * If this is a UMCG server, the syscall immediately returns.
+ *
+ * Return:
+ * 0            - Ok;
+ * -EOPNOTSUPP  - the API version is not supported;
+ * -EINVAL      - one of the parameters is wrong;
+ * -EFAULT      - failed to access @umcg_task.
+ */
+SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
+		struct umcg_task __user *, umcg_task)
+{
+	return -ENOSYS;
+}
+
+/**
+ * sys_umcg_unregister_task - unregister the current task as a UMCG task.
+ * @flags: reserved.
+ *
+ * Return:
+ * 0       - Ok;
+ * -EINVAL - the current task is not a UMCG task.
+ */
+SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
+{
+	return -ENOSYS;
+}
+
+/**
+ * sys_umcg_wait - block the current task (if all condtions are met).
+ * @flags:         Reserved.
+ * @timeout:       The absolute timeout of the wait. Not supported yet.
+ *                 Must be NULL.
+ *
+ * Sleep until woken, interrupted, or @timeout expires.
+ *
+ * Return:
+ * 0           - Ok;
+ * -EFAULT     - failed to read struct umcg_task assigned to this task
+ *               via sys_umcg_register();
+ * -EAGAIN     - try again;
+ * -EINTR      - signal pending;
+ * -EOPNOTSUPP - @timeout != NULL (not supported yet).
+ * -EINVAL     - a parameter or a member of struct umcg_task has a wrong value.
+ */
+SYSCALL_DEFINE2(umcg_wait, u32, flags,
+		const struct __kernel_timespec __user *, timeout)
+{
+	return -ENOSYS;
+}
+
+/**
+ * sys_umcg_wake - wake @next_tid task blocked in sys_umcg_wait.
+ * @flags:         Reserved.
+ * @next_tid:      The ID of the task to wake.
+ *
+ * Wake @next identified by @next_tid. @next must be either a UMCG core
+ * task or a UMCG worker task.
+ *
+ * Return:
+ * 0           - Ok;
+ * -EFAULT     - failed to read struct umcg_task assigned to next;
+ * -ESRCH      - @next_tid did not identify a task;
+ * -EAGAIN     - try again;
+ * -EINVAL     - a parameter or a member of next->umcg_task has a wrong value.
+ */
+SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
+{
+	return -ENOSYS;
+}
+
+/**
+ * sys_umcg_swap - wake next, put current to sleep.
+ * @wake_flags:    Reserved.
+ * @next_tid:      The ID of the task to wake.
+ * @wait_flags:    Reserved.
+ * @timeout:       The absolute timeout of the wait. Not supported yet.
+ *
+ * sys_umcg_swap() is semantically equivalent to this code fragment:
+ *
+ *     ret = sys_umcg_wake(wake_flags, next_tid);
+ *     if (ret)
+ *             return ret;
+ *     return sys_umcg_wait(wait_flags, timeout);
+ *
+ * The function attempts to wake @next on the current CPU.
+ *
+ * The current and the next tasks must both be either UMCG core tasks,
+ * or two UMCG workers belonging to the same UMCG group. In the latter
+ * case the UMCG server task that is "running" the current task will
+ * be transferred to the next task.
+ *
+ * Return: see the code snippet above.
+ */
+SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
+		const struct __kernel_timespec __user *, timeout)
+{
+	return -ENOSYS;
+}
-- 
2.31.1.818.g46aad6cb9e-goog

