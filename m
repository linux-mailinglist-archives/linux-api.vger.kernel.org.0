Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48D838B629
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhETShx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhETShu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E152C061574
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o6-20020a5b06460000b02905004326697dso23637301ybq.22
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DkD6dRL9pPi31IZp6ay7HU3Ui4pp5CgTsh9u19rIlr8=;
        b=br7j3zuEc2OPTkox4dQQnvJhTJj4Y39xHW5ytrGzorJ9MFmRwWCT6kQUxzitJo04pj
         08VTHxSap8zf6cto0sqCBwRgEQBl2dkW3aDoxr200Sp+Za6Akda67UI4tmJS/xspN5JY
         EMKrG5xlrS6yjAKASY0Vc6M5JNdkkrvzXVeKJYb/n5r9J7ox4fsKcP66Ghy1TofDVYaA
         paQAZLl1c61iwqTZgU67SFO2kXXdpnhkqe3kEBkKe+/S6qqjyWqV+XPBsy3RRccjX2HQ
         ki1PRBfeDsKM52HMEfI0+1GjK8XqxgX5/6krDFUe1h2ClR4XEF66aKgEYE5Cmszb60F7
         AUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DkD6dRL9pPi31IZp6ay7HU3Ui4pp5CgTsh9u19rIlr8=;
        b=LUMYFXZZTAHgkMR4woTg+WN0UdoCTqb42VtTt43OTwIQYvOkDbfPysNuPRrBwSI6ek
         /KBXy1w/uKIz8Fi/vdRzFHWutjL3pSIa3Byrjjcou0oyUc/BpxOVbRUOAmm1uePht4uJ
         1CKwv2fEYE4GtzMZTGmi3xNnTskmag+tIVV+rBI1FoPIlIFqnZ6HPmQ8/m1bzCDh9xOe
         3KDUiGBgQaLADkMcWFh/8+Eq5/i6VCstMRGa26ua3o6JQI1jl6FV7CF0+g6nW2Y3Qzl3
         57PpAvAY9G9f8MqxG740+zvFepy98uzNzKqr0FjgTK2j9E5SiYLFiWmUVOE4xEv1F/f3
         MS4Q==
X-Gm-Message-State: AOAM533kg9enG/6vr8bKC/RnWJ6gQTwze2lur6lhmr7ZNJTOO3QD2J6D
        iMXnDXYzrcA1A/T8P7MGsHYxZxCr
X-Google-Smtp-Source: ABdhPJzmz+kJc13zQaE4gHasPbtb0poIQoBlrNO6CB4xtseDWpQTgjQri0Rrwz86Ki3PZlEW3wjV+HuY
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a25:bd83:: with SMTP id f3mr9426410ybh.353.1621535787841;
 Thu, 20 May 2021 11:36:27 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:09 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-5-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
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

Implement version 1 of core UMCG API (wait/wake/swap).

As has been outlined in
https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/,
efficient and synchronous on-CPU context switching is key
to enabling two broad use cases: in-process M:N userspace scheduling
and fast X-process RPCs for security wrappers.

High-level design considerations/approaches used:
- wait & wake can race with each other;
- offload as much work as possible to libumcg in tools/lib/umcg,
  specifically:
  - most state changes, e.g. RUNNABLE <=> RUNNING, are done in
    the userspace (libumcg);
  - retries are offloaded to the userspace.

This implementation misses timeout handling in sys_umcg_wait
and sys_umcg_swap, which will be added in version 2.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/sched.h |   7 +-
 kernel/sched/core.c   |   3 +
 kernel/sched/umcg.c   | 237 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/umcg.h   |  42 ++++++++
 4 files changed, 282 insertions(+), 7 deletions(-)
 create mode 100644 kernel/sched/umcg.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c7e7d50e2fdc..fc4b8775f514 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -66,6 +66,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task_data;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -778,6 +779,10 @@ struct task_struct {
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
 
+#ifdef CONFIG_UMCG
+	struct umcg_task_data __rcu	*umcg_task_data;
+#endif
+
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
 
@@ -1022,7 +1027,7 @@ struct task_struct {
 	u64				parent_exec_id;
 	u64				self_exec_id;
 
-	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy: */
+	/* Protection against (de-)allocation: mm, files, fs, tty, keyrings, mems_allowed, mempolicy, umcg: */
 	spinlock_t			alloc_lock;
 
 	/* Protection of the PI data structures: */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88506bc2617f..462104f13c28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3964,6 +3964,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+#ifdef CONFIG_UMCG
+	rcu_assign_pointer(p->umcg_task_data, NULL);
+#endif
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
index b8195cfdb76a..2d718433c773 100644
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -4,11 +4,23 @@
  * User Managed Concurrency Groups (UMCG).
  */
 
+#include <linux/freezer.h>
 #include <linux/syscalls.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/umcg.h>
 
+#include "sched.h"
+#include "umcg.h"
+
+static int __api_version(u32 requested)
+{
+	if (requested == 1)
+		return 0;
+
+	return 1;
+}
+
 /**
  * sys_umcg_api_version - query UMCG API versions that are supported.
  * @api_version:          Requested API version.
@@ -26,7 +38,52 @@
  */
 SYSCALL_DEFINE2(umcg_api_version, u32, api_version, u32, flags)
 {
-	return -ENOSYS;
+	if (flags)
+		return -EINVAL;
+
+	return __api_version(api_version);
+}
+
+static int get_state(struct umcg_task __user *ut, u32 *state)
+{
+	return get_user(*state, (u32 __user *)ut);
+}
+
+static int put_state(struct umcg_task __user *ut, u32 state)
+{
+	return put_user(state, (u32 __user *)ut);
+}
+
+static int register_core_task(u32 api_version, struct umcg_task __user *umcg_task)
+{
+	struct umcg_task_data *utd;
+	u32 state;
+
+	if (get_state(umcg_task, &state))
+		return -EFAULT;
+
+	if (state != UMCG_TASK_NONE)
+		return -EINVAL;
+
+	utd = kzalloc(sizeof(struct umcg_task_data), GFP_KERNEL);
+	if (!utd)
+		return -EINVAL;
+
+	utd->self = current;
+	utd->umcg_task = umcg_task;
+	utd->task_type = UMCG_TT_CORE;
+	utd->api_version = api_version;
+
+	if (put_state(umcg_task, UMCG_TASK_RUNNING)) {
+		kfree(utd);
+		return -EFAULT;
+	}
+
+	task_lock(current);
+	rcu_assign_pointer(current->umcg_task_data, utd);
+	task_unlock(current);
+
+	return 0;
 }
 
 /**
@@ -54,7 +111,20 @@ SYSCALL_DEFINE2(umcg_api_version, u32, api_version, u32, flags)
 SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
 		struct umcg_task __user *, umcg_task)
 {
-	return -ENOSYS;
+	if (__api_version(api_version))
+		return -EOPNOTSUPP;
+
+	if (rcu_access_pointer(current->umcg_task_data) || !umcg_task)
+		return -EINVAL;
+
+	switch (flags) {
+	case UMCG_REGISTER_CORE_TASK:
+		if (group_id != UMCG_NOID)
+			return -EINVAL;
+		return register_core_task(api_version, umcg_task);
+	default:
+		return -EINVAL;
+	}
 }
 
 /**
@@ -67,7 +137,75 @@ SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
  */
 SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
 {
-	return -ENOSYS;
+	struct umcg_task_data *utd;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+	utd = rcu_dereference(current->umcg_task_data);
+
+	if (!utd || flags)
+		goto out;
+
+	task_lock(current);
+	rcu_assign_pointer(current->umcg_task_data, NULL);
+	task_unlock(current);
+
+	ret = 0;
+
+out:
+	rcu_read_unlock();
+	if (!ret && utd) {
+		synchronize_rcu();
+		kfree(utd);
+	}
+	return ret;
+}
+
+static int do_context_switch(struct task_struct *next)
+{
+	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
+
+	/*
+	 * It is important to set_current_state(TASK_INTERRUPTIBLE) before
+	 * waking @next, as @next may immediately try to wake current back
+	 * (e.g. current is a server, @next is a worker that immediately
+	 * blocks or waits), and this next wakeup must not be lost.
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	WRITE_ONCE(utd->in_wait, true);
+
+	if (!try_to_wake_up(next, TASK_NORMAL, WF_CURRENT_CPU))
+		return -EAGAIN;
+
+	freezable_schedule();
+
+	WRITE_ONCE(utd->in_wait, false);
+
+	if (signal_pending(current))
+		return -EINTR;
+
+	return 0;
+}
+
+static int do_wait(void)
+{
+	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
+
+	if (!utd)
+		return -EINVAL;
+
+	WRITE_ONCE(utd->in_wait, true);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	freezable_schedule();
+
+	WRITE_ONCE(utd->in_wait, false);
+
+	if (signal_pending(current))
+		return -EINTR;
+
+	return 0;
 }
 
 /**
@@ -90,7 +228,23 @@ SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
 SYSCALL_DEFINE2(umcg_wait, u32, flags,
 		const struct __kernel_timespec __user *, timeout)
 {
-	return -ENOSYS;
+	struct umcg_task_data *utd;
+
+	if (flags)
+		return -EINVAL;
+	if (timeout)
+		return -EOPNOTSUPP;
+
+	rcu_read_lock();
+	utd = rcu_dereference(current->umcg_task_data);
+	if (!utd) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	rcu_read_unlock();
+
+	return do_wait();
 }
 
 /**
@@ -110,7 +264,39 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags,
  */
 SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
 {
-	return -ENOSYS;
+	struct umcg_task_data *next_utd;
+	struct task_struct *next;
+	int ret = -EINVAL;
+
+	if (!next_tid)
+		return -EINVAL;
+	if (flags)
+		return -EINVAL;
+
+	next = find_get_task_by_vpid(next_tid);
+	if (!next)
+		return -ESRCH;
+
+	rcu_read_lock();
+	next_utd = rcu_dereference(next->umcg_task_data);
+	if (!next_utd)
+		goto out;
+
+	if (!READ_ONCE(next_utd->in_wait)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	ret = wake_up_process(next);
+	put_task_struct(next);
+	if (ret)
+		ret = 0;
+	else
+		ret = -EAGAIN;
+
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 /**
@@ -139,5 +325,44 @@ SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
 SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
 		const struct __kernel_timespec __user *, timeout)
 {
-	return -ENOSYS;
+	struct umcg_task_data *curr_utd;
+	struct umcg_task_data *next_utd;
+	struct task_struct *next;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+	curr_utd = rcu_dereference(current->umcg_task_data);
+
+	if (!next_tid || wake_flags || wait_flags || !curr_utd)
+		goto out;
+
+	if (timeout) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	next = find_get_task_by_vpid(next_tid);
+	if (!next) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	next_utd = rcu_dereference(next->umcg_task_data);
+	if (!next_utd) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!READ_ONCE(next_utd->in_wait)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	rcu_read_unlock();
+
+	return do_context_switch(next);
+
+out:
+	rcu_read_unlock();
+	return ret;
 }
diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
new file mode 100644
index 000000000000..6791d570f622
--- /dev/null
+++ b/kernel/sched/umcg.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_SCHED_UMCG_H
+#define _KERNEL_SCHED_UMCG_H
+
+#ifdef CONFIG_UMCG
+
+#include <linux/sched.h>
+#include <linux/umcg.h>
+
+enum umcg_task_type {
+	UMCG_TT_CORE	= 1,
+	UMCG_TT_SERVER	= 2,
+	UMCG_TT_WORKER	= 3
+};
+
+struct umcg_task_data {
+	/* umcg_task != NULL. Never changes. */
+	struct umcg_task __user		*umcg_task;
+
+	/* The task that owns this umcg_task_data. Never changes. */
+	struct task_struct		*self;
+
+	/* Core task, server, or worker. Never changes. */
+	enum umcg_task_type		task_type;
+
+	/*
+	 * The API version used to register this task. If this is a
+	 * worker or a server, must equal group->api_version.
+	 *
+	 * Never changes.
+	 */
+	u32 api_version;
+
+	/*
+	 * Used by wait/wake routines to handle races. Written only by current.
+	 */
+	bool				in_wait;
+};
+
+#endif  /* CONFIG_UMCG */
+#endif  /* _KERNEL_SCHED_UMCG_H */
-- 
2.31.1.818.g46aad6cb9e-goog

