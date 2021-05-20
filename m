Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C438B62D
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhETSh6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhETSh4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:56 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0196C061760
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w14-20020a056214012eb02901f3a4388530so5654590qvs.17
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MufDMzmIE4kExolJ/hVaiYVlok6nlWNNX5PFkp0AfBs=;
        b=bKtdnyXWmN1Y+RRdVQCsNM9WDo8rzPWLYB7XrYMGt46q0Xnq2uWvGrFbQnHMcR5rBh
         5jk4c4OG9IownmyVRk48UkuiZLDkAoDjzgRtYCkPEivuN6+HyY0l+oOVg0vmzC40FKMm
         FzzVoCijQ2XUvkR+EdTD5PCCBnQfRfkNVpZ2r0Nfb+3rB/pmp2Wt+ysVeE2kCGQueoY0
         z6qEeZRBxuNg/6hy+7zOa2utEOUc6ghwO7FNOJTobERsu4CL+8BwzpfvV2O0LK74Q93n
         sknWYJ1i5v55FN3y2/cV0n0gydYGjzxnvOvs8i55WrVxhBNYS1XTDW5Rk9gUPYRPwHQX
         Ring==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MufDMzmIE4kExolJ/hVaiYVlok6nlWNNX5PFkp0AfBs=;
        b=UK+P/bmPgR0kmS5Q/OWxZ1BJK+RUobyj9POIWEKb1EAXvpECTqTYeNfCCIUzKYZsua
         Woga36XoyMYOKmSkNGfg1K+jpRwDv2pXh2hq9ClhOtVByR4kltAnFjoHZfE+b/prbuhZ
         rB7VKT0bj1Jy6wZbAbVi7VSVOWpccGTT/sTVD8PZv3CPN1wgk+p5ijXhW6qpaTk0A4tT
         fS6WrgnDuoU9DTkOFaj3jQ50q8VLyWdNKdmx5B/GvsKcfKPD+goFGaNX2FvkKPv0Gss8
         wt2REkjEq529g4AqNzfiqX85f977Q1hXSA9iFzcimkKKaeF0Yr/qVUVmX+DKQkGWu1zO
         UcVw==
X-Gm-Message-State: AOAM532XMRcySgjUonlwMj5b5oo9btkffM91PtQm38oO/HRAH12Q5cEw
        8AQN3ckGdqfutKigxddN728lqKhO
X-Google-Smtp-Source: ABdhPJwWhkDw+22iu2zplCyGb2ok7YScjUwbsiWBs4iM1qJB2i5wyRQ6JJLlzejdM8kJq1ZE22/RyQAD
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a0c:ee62:: with SMTP id n2mr7455095qvs.20.1621535793834;
 Thu, 20 May 2021 11:36:33 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:12 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-8-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 7/9] sched/umcg: add UMCG server/worker API (early RFC)
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

Implement UMCG server/worker API.

This is an early RFC patch - the code seems working, but
more testing is needed. Gaps I plan to address before this
is ready for a detailed review:

- preemption/interrupt handling;
- better documentation/comments;
- tracing;
- additional testing;
- corner cases like abnormal process/task termination;
- in some cases where I kill the task (umcg_segv), returning
an error may be more appropriate.

All in all, please focus more on the high-level approach
and less on things like variable names, (doc) comments, or indentation.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/mm_types.h |   5 +
 include/linux/syscalls.h |   5 +
 kernel/fork.c            |  11 +
 kernel/sched/core.c      |  11 +
 kernel/sched/umcg.c      | 764 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/umcg.h      |  54 +++
 mm/init-mm.c             |   4 +
 7 files changed, 845 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a8894..5ca7b7d55775 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -562,6 +562,11 @@ struct mm_struct {
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
 #endif
+
+#ifdef CONFIG_UMCG
+	spinlock_t umcg_lock;
+	struct list_head umcg_groups;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 15de3e34ccee..2781659daaf1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1059,6 +1059,11 @@ asmlinkage long umcg_wait(u32 flags, const struct __kernel_timespec __user *time
 asmlinkage long umcg_wake(u32 flags, u32 next_tid);
 asmlinkage long umcg_swap(u32 wake_flags, u32 next_tid, u32 wait_flags,
 				const struct __kernel_timespec __user *timeout);
+asmlinkage long umcg_create_group(u32 api_version, u64, flags);
+asmlinkage long umcg_destroy_group(u32 group_id);
+asmlinkage long umcg_poll_worker(u32 flags, struct umcg_task __user **ut);
+asmlinkage long umcg_run_worker(u32 flags, u32 worker_tid,
+		struct umcg_task __user **ut);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/fork.c b/kernel/fork.c
index ace4631b5b54..3a2a7950df8e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1026,6 +1026,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
+#ifdef CONFIG_UMCG
+	spin_lock_init(&mm->umcg_lock);
+	INIT_LIST_HEAD(&mm->umcg_groups);
+#endif
 	mm->core_state = NULL;
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
@@ -1102,6 +1106,13 @@ static inline void __mmput(struct mm_struct *mm)
 		list_del(&mm->mmlist);
 		spin_unlock(&mmlist_lock);
 	}
+#ifdef CONFIG_UMCG
+	if (!list_empty(&mm->umcg_groups)) {
+		spin_lock(&mm->umcg_lock);
+		list_del(&mm->umcg_groups);
+		spin_unlock(&mm->umcg_lock);
+	}
+#endif
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
 	mmdrop(mm);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 462104f13c28..e657a35655b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -26,6 +26,7 @@
 
 #include "pelt.h"
 #include "smp.h"
+#include "umcg.h"
 
 /*
  * Export tracepoints that act as a bare tracehook (ie: have no trace event
@@ -6012,10 +6013,20 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 */
 	if (blk_needs_flush_plug(tsk))
 		blk_schedule_flush_plug(tsk);
+
+#ifdef CONFIG_UMCG
+	if (rcu_access_pointer(tsk->umcg_task_data))
+		umcg_on_block();
+#endif
 }
 
 static void sched_update_worker(struct task_struct *tsk)
 {
+#ifdef CONFIG_UMCG
+	if (rcu_access_pointer(tsk->umcg_task_data))
+		umcg_on_wake();
+#endif
+
 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
index 2d718433c773..38cba772322d 100644
--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -21,6 +21,12 @@ static int __api_version(u32 requested)
 	return 1;
 }
 
+static int umcg_segv(int res)
+{
+	force_sig(SIGSEGV);
+	return res;
+}
+
 /**
  * sys_umcg_api_version - query UMCG API versions that are supported.
  * @api_version:          Requested API version.
@@ -54,6 +60,78 @@ static int put_state(struct umcg_task __user *ut, u32 state)
 	return put_user(state, (u32 __user *)ut);
 }
 
+static void umcg_lock_pair(struct task_struct *server,
+		struct task_struct *worker)
+{
+	spin_lock(&server->alloc_lock);
+	spin_lock_nested(&worker->alloc_lock, SINGLE_DEPTH_NESTING);
+}
+
+static void umcg_unlock_pair(struct task_struct *server,
+		struct task_struct *worker)
+{
+	spin_unlock(&worker->alloc_lock);
+	spin_unlock(&server->alloc_lock);
+}
+
+static void umcg_detach_peer(void)
+{
+	struct task_struct *server, *worker;
+	struct umcg_task_data *utd;
+
+	rcu_read_lock();
+	task_lock(current);
+	utd = rcu_dereference(current->umcg_task_data);
+
+	if (!utd || !rcu_dereference(utd->peer)) {
+		task_unlock(current);
+		goto out;
+	}
+
+	switch (utd->task_type) {
+	case UMCG_TT_SERVER:
+		server = current;
+		worker = rcu_dereference(utd->peer);
+		break;
+
+	case UMCG_TT_WORKER:
+		worker = current;
+		server = rcu_dereference(utd->peer);
+		break;
+
+	default:
+		task_unlock(current);
+		printk(KERN_WARNING "umcg_detach_peer: unexpected task type");
+		umcg_segv(0);
+		goto out;
+	}
+	task_unlock(current);
+
+	if (!server || !worker)
+		goto out;
+
+	umcg_lock_pair(server, worker);
+
+	utd = rcu_dereference(server->umcg_task_data);
+	if (WARN_ON(!utd)) {
+		umcg_segv(0);
+		goto out_pair;
+	}
+	rcu_assign_pointer(utd->peer, NULL);
+
+	utd = rcu_dereference(worker->umcg_task_data);
+	if (WARN_ON(!utd)) {
+		umcg_segv(0);
+		goto out_pair;
+	}
+	rcu_assign_pointer(utd->peer, NULL);
+
+out_pair:
+	umcg_unlock_pair(server, worker);
+out:
+	rcu_read_unlock();
+}
+
 static int register_core_task(u32 api_version, struct umcg_task __user *umcg_task)
 {
 	struct umcg_task_data *utd;
@@ -73,6 +151,7 @@ static int register_core_task(u32 api_version, struct umcg_task __user *umcg_tas
 	utd->umcg_task = umcg_task;
 	utd->task_type = UMCG_TT_CORE;
 	utd->api_version = api_version;
+	RCU_INIT_POINTER(utd->peer, NULL);
 
 	if (put_state(umcg_task, UMCG_TASK_RUNNING)) {
 		kfree(utd);
@@ -86,6 +165,105 @@ static int register_core_task(u32 api_version, struct umcg_task __user *umcg_tas
 	return 0;
 }
 
+static int add_task_to_group(u32 api_version, u32 group_id,
+		struct umcg_task __user *umcg_task,
+		enum umcg_task_type task_type, u32 new_state)
+{
+	struct mm_struct *mm = current->mm;
+	struct umcg_task_data *utd = NULL;
+	struct umcg_group *group = NULL;
+	struct umcg_group *list_entry;
+	int ret = -EINVAL;
+	u32 state;
+
+	if (get_state(umcg_task, &state))
+		return -EFAULT;
+
+	if (state != UMCG_TASK_NONE)
+		return -EINVAL;
+
+	if (put_state(umcg_task, new_state))
+		return -EFAULT;
+
+retry_once:
+	rcu_read_lock();
+	list_for_each_entry_rcu(list_entry, &mm->umcg_groups, list) {
+		if (list_entry->group_id == group_id) {
+			group = list_entry;
+			break;
+		}
+	}
+
+	if (!group || group->api_version != api_version)
+		goto out_rcu;
+
+	spin_lock(&group->lock);
+	if (group->nr_tasks < 0)  /* The groups is being destroyed. */
+		goto out_group;
+
+	if (!utd) {
+		utd = kzalloc(sizeof(struct umcg_task_data), GFP_NOWAIT);
+		if (!utd) {
+			spin_unlock(&group->lock);
+			rcu_read_unlock();
+
+			utd = kzalloc(sizeof(struct umcg_task_data), GFP_KERNEL);
+			if (!utd) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			goto retry_once;
+		}
+	}
+
+	utd->self = current;
+	utd->group = group;
+	utd->umcg_task = umcg_task;
+	utd->task_type = task_type;
+	utd->api_version = api_version;
+	RCU_INIT_POINTER(utd->peer, NULL);
+
+	INIT_LIST_HEAD(&utd->list);
+	group->nr_tasks++;
+
+	task_lock(current);
+	rcu_assign_pointer(current->umcg_task_data, utd);
+	task_unlock(current);
+
+	ret = 0;
+
+out_group:
+	spin_unlock(&group->lock);
+
+out_rcu:
+	rcu_read_unlock();
+	if (ret && utd)
+		kfree(utd);
+
+out:
+	if (ret)
+		put_state(umcg_task, UMCG_TASK_NONE);
+	else
+		schedule();  /* Trigger umcg_on_wake(). */
+
+	return ret;
+}
+
+static int register_worker(u32 api_version, u32 group_id,
+		struct umcg_task __user *umcg_task)
+{
+	return add_task_to_group(api_version, group_id, umcg_task,
+				UMCG_TT_WORKER, UMCG_TASK_UNBLOCKED);
+}
+
+static int register_server(u32 api_version, u32 group_id,
+		struct umcg_task __user *umcg_task)
+{
+	return add_task_to_group(api_version, group_id, umcg_task,
+				UMCG_TT_SERVER, UMCG_TASK_PROCESSING);
+}
+
 /**
  * sys_umcg_register_task - register the current task as a UMCG task.
  * @api_version:       The expected/desired API version of the syscall.
@@ -122,6 +300,10 @@ SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
 		if (group_id != UMCG_NOID)
 			return -EINVAL;
 		return register_core_task(api_version, umcg_task);
+	case UMCG_REGISTER_WORKER:
+		return register_worker(api_version, group_id, umcg_task);
+	case UMCG_REGISTER_SERVER:
+		return register_server(api_version, group_id, umcg_task);
 	default:
 		return -EINVAL;
 	}
@@ -146,9 +328,39 @@ SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
 	if (!utd || flags)
 		goto out;
 
+	if (!utd->group) {
+		ret = 0;
+		goto out;
+	}
+
+	if (utd->task_type == UMCG_TT_WORKER) {
+		struct task_struct *server = rcu_dereference(utd->peer);
+
+		if (server) {
+			umcg_detach_peer();
+			if (WARN_ON(!wake_up_process(server))) {
+				umcg_segv(0);
+				goto out;
+			}
+		}
+	} else {
+		if (WARN_ON(utd->task_type != UMCG_TT_SERVER)) {
+			umcg_segv(0);
+			goto out;
+		}
+
+		umcg_detach_peer();
+	}
+
+	spin_lock(&utd->group->lock);
 	task_lock(current);
+
 	rcu_assign_pointer(current->umcg_task_data, NULL);
+
+	--utd->group->nr_tasks;
+
 	task_unlock(current);
+	spin_unlock(&utd->group->lock);
 
 	ret = 0;
 
@@ -164,6 +376,7 @@ SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
 static int do_context_switch(struct task_struct *next)
 {
 	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
+	bool prev_wait_flag;  /* See comment in do_wait() below. */
 
 	/*
 	 * It is important to set_current_state(TASK_INTERRUPTIBLE) before
@@ -173,34 +386,51 @@ static int do_context_switch(struct task_struct *next)
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	WRITE_ONCE(utd->in_wait, true);
-
+	prev_wait_flag = utd->in_wait;
+	if (!prev_wait_flag)
+		WRITE_ONCE(utd->in_wait, true);
+	
 	if (!try_to_wake_up(next, TASK_NORMAL, WF_CURRENT_CPU))
 		return -EAGAIN;
 
 	freezable_schedule();
 
-	WRITE_ONCE(utd->in_wait, false);
+	if (!prev_wait_flag)
+		WRITE_ONCE(utd->in_wait, false);
 
 	if (signal_pending(current))
 		return -EINTR;
 
+	/* TODO: deal with non-fatal interrupts. */
 	return 0;
 }
 
 static int do_wait(void)
 {
 	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
+	/*
+	 * freezable_schedule() below can recursively call do_wait() if
+	 * this is a worker that needs a server. As the wait flag is only
+	 * used by the outermost wait/wake (and swap) syscalls, modify it only
+	 * in the outermost do_wait() instead of using a counter.
+	 *
+	 * Note that the nesting level is at most two, as utd->in_workqueue
+	 * is used to prevent further nesting.
+	 */
+	bool prev_wait_flag;
 
 	if (!utd)
 		return -EINVAL;
 
-	WRITE_ONCE(utd->in_wait, true);
+	prev_wait_flag = utd->in_wait;
+	if (!prev_wait_flag)
+		WRITE_ONCE(utd->in_wait, true);
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	freezable_schedule();
 
-	WRITE_ONCE(utd->in_wait, false);
+	if (!prev_wait_flag)
+		WRITE_ONCE(utd->in_wait, false);
 
 	if (signal_pending(current))
 		return -EINTR;
@@ -214,7 +444,7 @@ static int do_wait(void)
  * @timeout:       The absolute timeout of the wait. Not supported yet.
  *                 Must be NULL.
  *
- * Sleep until woken, interrupted, or @timeout expires.
+ * Sleep until woken or @timeout expires.
  *
  * Return:
  * 0           - Ok;
@@ -229,6 +459,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags,
 		const struct __kernel_timespec __user *, timeout)
 {
 	struct umcg_task_data *utd;
+	struct task_struct *server = NULL;
 
 	if (flags)
 		return -EINVAL;
@@ -242,8 +473,14 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags,
 		return -EINVAL;
 	}
 
+	if (utd->task_type == UMCG_TT_WORKER)
+		server = rcu_dereference(utd->peer);
+
 	rcu_read_unlock();
 
+	if (server)
+		return do_context_switch(server);
+
 	return do_wait();
 }
 
@@ -252,7 +489,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags,
  * @flags:         Reserved.
  * @next_tid:      The ID of the task to wake.
  *
- * Wake @next identified by @next_tid. @next must be either a UMCG core
+ * Wake task next identified by @next_tid. @next must be either a UMCG core
  * task or a UMCG worker task.
  *
  * Return:
@@ -265,7 +502,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags,
 SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
 {
 	struct umcg_task_data *next_utd;
-	struct task_struct *next;
+	struct task_struct *next, *next_peer;
 	int ret = -EINVAL;
 
 	if (!next_tid)
@@ -282,11 +519,29 @@ SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
 	if (!next_utd)
 		goto out;
 
+	if (next_utd->task_type == UMCG_TT_SERVER)
+		goto out;
+
 	if (!READ_ONCE(next_utd->in_wait)) {
 		ret = -EAGAIN;
 		goto out;
 	}
 
+	next_peer = rcu_dereference(next_utd->peer);
+	if (next_peer) {
+		if (next_peer == current)
+			umcg_detach_peer();
+		else {
+			/*
+			 * Waking a worker with an assigned server is not
+			 * permitted, unless the waking is done by the assigned
+			 * server.
+			 */
+			umcg_segv(0);
+			goto out;
+		}
+	}
+
 	ret = wake_up_process(next);
 	put_task_struct(next);
 	if (ret)
@@ -348,7 +603,7 @@ SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
 	}
 
 	next_utd = rcu_dereference(next->umcg_task_data);
-	if (!next_utd) {
+	if (!next_utd || next_utd->group != curr_utd->group) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -358,6 +613,25 @@ SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
 		goto out;
 	}
 
+	/* Move the server from curr to next, if appropriate. */
+	if (curr_utd->task_type == UMCG_TT_WORKER) {
+		struct task_struct *server = rcu_dereference(curr_utd->peer);
+		if (server) {
+			struct umcg_task_data *server_utd =
+				rcu_dereference(server->umcg_task_data);
+
+			if (rcu_access_pointer(next_utd->peer)) {
+				ret = -EAGAIN;
+				goto out;
+			}
+			umcg_detach_peer();
+			umcg_lock_pair(server, next);
+			rcu_assign_pointer(server_utd->peer, next);
+			rcu_assign_pointer(next_utd->peer, server);
+			umcg_unlock_pair(server, next);
+		}
+	}
+
 	rcu_read_unlock();
 
 	return do_context_switch(next);
@@ -366,3 +640,475 @@ SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
 	rcu_read_unlock();
 	return ret;
 }
+
+/**
+ * sys_umcg_create_group - create a UMCG group
+ * @api_version:           Requested API version.
+ * @flags:                 Reserved.
+ *
+ * Return:
+ * >= 0                - the group ID
+ * -EOPNOTSUPP         - @api_version is not supported
+ * -EINVAL             - @flags is not valid
+ * -ENOMEM             - not enough memory
+ */
+SYSCALL_DEFINE2(umcg_create_group, u32, api_version, u64, flags)
+{
+	int ret;
+	struct umcg_group *group;
+	struct umcg_group *list_entry;
+	struct mm_struct *mm = current->mm;
+
+	if (flags)
+		return -EINVAL;
+
+	if (__api_version(api_version))
+		return -EOPNOTSUPP;
+
+	group = kzalloc(sizeof(struct umcg_group), GFP_KERNEL);
+	if (!group)
+		return -ENOMEM;
+
+	spin_lock_init(&group->lock);
+	INIT_LIST_HEAD(&group->list);
+	INIT_LIST_HEAD(&group->waiters);
+	group->flags = flags;
+	group->api_version = api_version;
+
+	spin_lock(&mm->umcg_lock);
+
+	list_for_each_entry_rcu(list_entry, &mm->umcg_groups, list) {
+		if (list_entry->group_id >= group->group_id)
+			group->group_id = list_entry->group_id + 1;
+	}
+
+	list_add_rcu(&mm->umcg_groups, &group->list);
+
+	ret = group->group_id;
+	spin_unlock(&mm->umcg_lock);
+
+	return ret;
+}
+
+/**
+ * sys_umcg_destroy_group - destroy a UMCG group
+ * @group_id: The ID of the group to destroy.
+ *
+ * The group must be empty, i.e. have no registered servers or workers.
+ *
+ * Return:
+ * 0       - success;
+ * -ESRCH  - group not found;
+ * -EBUSY  - the group has registered workers or servers.
+ */
+SYSCALL_DEFINE1(umcg_destroy_group, u32, group_id)
+{
+	int ret = 0;
+	struct umcg_group *group = NULL;
+	struct umcg_group *list_entry;
+	struct mm_struct *mm = current->mm;
+
+	spin_lock(&mm->umcg_lock);
+	list_for_each_entry_rcu(list_entry, &mm->umcg_groups, list) {
+		if (list_entry->group_id == group_id) {
+			group = list_entry;
+			break;
+		}
+	}
+
+	if (group == NULL) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	spin_lock(&group->lock);
+
+	if (group->nr_tasks > 0) {
+		ret = -EBUSY;
+		spin_unlock(&group->lock);
+		goto out;
+	}
+
+	/* Tell group rcu readers that the group is going to be deleted. */
+	group->nr_tasks = -1;
+
+	spin_unlock(&group->lock);
+
+	list_del_rcu(&group->list);
+	kfree_rcu(group, rcu);
+
+out:
+	spin_unlock(&mm->umcg_lock);
+	return ret;
+}
+
+/**
+ * sys_umcg_poll_worker - poll an UNBLOCKED worker
+ * @flags: reserved;
+ * @ut:    the control struct umcg_task of the polled worker.
+ *
+ * The current task must be a UMCG server in POLLING state; if there are
+ * UNBLOCKED workers in the server's group, take the earliest queued,
+ * mark the worker as RUNNABLE.and return.
+ *
+ * If there are no unblocked workers, the syscall waits for one to become
+ * available.
+ *
+ * Return:
+ * 0       - Ok;
+ * -EINTR  - a signal was received;
+ * -EINVAL - one of the parameters is wrong, or a precondition was not met.
+ */
+SYSCALL_DEFINE2(umcg_poll_worker, u32, flags, struct umcg_task __user **, ut)
+{
+	struct umcg_group *group;
+	struct task_struct *worker;
+	struct task_struct *server = current;
+	struct umcg_task __user *result;
+	struct umcg_task_data *worker_utd, *server_utd;
+
+	if (flags)
+		return -EINVAL;
+
+	rcu_read_lock();
+
+	server_utd = rcu_dereference(server->umcg_task_data);
+
+	if (!server_utd || server_utd->task_type != UMCG_TT_SERVER) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+
+	umcg_detach_peer();
+
+	group = server_utd->group;
+
+	spin_lock(&group->lock);
+
+	if (group->nr_waiting_workers == 0) {  /* Queue the server. */
+		++group->nr_waiting_pollers;
+		list_add_tail(&server_utd->list, &group->waiters);
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock(&group->lock);
+		rcu_read_unlock();
+
+		freezable_schedule();
+
+		rcu_read_lock();
+		server_utd = rcu_dereference(server->umcg_task_data);
+
+		if (!list_empty(&server_utd->list)) {
+			spin_lock(&group->lock);
+			list_del_init(&server_utd->list);
+			--group->nr_waiting_pollers;
+			spin_unlock(&group->lock);
+		}
+
+		if (signal_pending(current)) {
+			rcu_read_unlock();
+			return -EINTR;
+		}
+
+		worker = rcu_dereference(server_utd->peer);
+		if (worker) {
+			worker_utd = rcu_dereference(worker->umcg_task_data);
+			result = worker_utd->umcg_task;
+		} else
+			result = NULL;
+
+		rcu_read_unlock();
+
+		if (put_user(result, ut))
+			return umcg_segv(-EFAULT);
+		return 0;
+	}
+
+	/* Pick up the first worker. */
+	worker_utd = list_first_entry(&group->waiters, struct umcg_task_data,
+					list);
+	list_del_init(&worker_utd->list);
+	worker = worker_utd->self;
+	--group->nr_waiting_workers;
+
+	umcg_lock_pair(server, worker);
+	spin_unlock(&group->lock);
+
+	if (WARN_ON(rcu_access_pointer(server_utd->peer) ||
+			rcu_access_pointer(worker_utd->peer))) {
+		/* This is unexpected. */
+		rcu_read_unlock();
+		return umcg_segv(-EINVAL);
+	}
+	rcu_assign_pointer(server_utd->peer, worker);
+	rcu_assign_pointer(worker_utd->peer, current);
+
+	umcg_unlock_pair(server, worker);
+
+	result = worker_utd->umcg_task;
+	rcu_read_unlock();
+
+	if (put_state(result, UMCG_TASK_RUNNABLE))
+		return umcg_segv(-EFAULT);
+
+	if (put_user(result, ut))
+		return umcg_segv(-EFAULT);
+
+	return 0;
+}
+
+/**
+ * sys_umcg_run_worker - "run" a RUNNABLE worker as a server
+ * @flags:       reserved;
+ * @worker_tid:  tid of the worker to run;
+ * @ut:          the control struct umcg_task of the worker that blocked
+ *               during this "run".
+ *
+ * The worker must be in RUNNABLE state. The server (=current task)
+ * wakes the worker and blocks; when the worker, or one of the workers
+ * in umcg_swap chain, blocks, the server is woken and the syscall returns
+ * with ut indicating the blocked worker.
+ *
+ * If the worker exits or unregisters itself, the syscall succeeds with
+ * ut == NULL.
+ *
+ * Return:
+ * 0       - Ok;
+ * -EINTR  - a signal was received;
+ * -EINVAL - one of the parameters is wrong, or a precondition was not met.
+ */
+SYSCALL_DEFINE3(umcg_run_worker, u32, flags, u32, worker_tid,
+		struct umcg_task __user **, ut)
+{
+	int ret = -EINVAL;
+	struct task_struct *worker;
+	struct task_struct *server = current;
+	struct umcg_task __user *result = NULL;
+	struct umcg_task_data *worker_utd;
+	struct umcg_task_data *server_utd;
+	struct umcg_task __user *server_ut;
+	struct umcg_task __user *worker_ut;
+
+	if (!ut)
+		return -EINVAL;
+
+	rcu_read_lock();
+	server_utd = rcu_dereference(server->umcg_task_data);
+
+	if (!server_utd || server_utd->task_type != UMCG_TT_SERVER)
+		goto out_rcu;
+
+	if (flags)
+		goto out_rcu;
+
+	worker = find_get_task_by_vpid(worker_tid);
+	if (!worker) {
+		ret = -ESRCH;
+		goto out_rcu;
+	}
+
+	worker_utd = rcu_dereference(worker->umcg_task_data);
+	if (!worker_utd)
+		goto out_rcu;
+
+	if (!READ_ONCE(worker_utd->in_wait)) {
+		ret = -EAGAIN;
+		goto out_rcu;
+	}
+
+	if (server_utd->group != worker_utd->group)
+		goto out_rcu;
+
+	if (rcu_access_pointer(server_utd->peer) != worker)
+		umcg_detach_peer();
+
+	if (!rcu_access_pointer(server_utd->peer)) {
+		umcg_lock_pair(server, worker);
+		WARN_ON(worker_utd->peer);
+		rcu_assign_pointer(server_utd->peer, worker);
+		rcu_assign_pointer(worker_utd->peer, server);
+		umcg_unlock_pair(server, worker);
+	}
+
+	server_ut = server_utd->umcg_task;
+	worker_ut = server_utd->umcg_task;
+
+	rcu_read_unlock();
+
+	ret = do_context_switch(worker);
+	if (ret)
+		return ret;
+
+	rcu_read_lock();
+	worker = rcu_dereference(server_utd->peer);
+	if (worker) {
+		worker_utd = rcu_dereference(worker->umcg_task_data);
+		if (worker_utd)
+			result = worker_utd->umcg_task;
+	}
+	rcu_read_unlock();
+
+	if (put_user(result, ut))
+		return -EFAULT;
+	return 0;
+
+out_rcu:
+	rcu_read_unlock();
+	return ret;
+}
+
+void umcg_on_block(void)
+{
+	struct umcg_task_data *utd = rcu_access_pointer(current->umcg_task_data);
+	struct umcg_task __user *ut;
+	struct task_struct *server;
+	u32 state;
+
+	if (utd->task_type != UMCG_TT_WORKER || utd->in_workqueue)
+		return;
+
+	ut = utd->umcg_task;
+
+	if (get_user(state, (u32 __user *)ut)) {
+		if (signal_pending(current))
+			return;
+		umcg_segv(0);
+		return;
+	}
+
+	if (state != UMCG_TASK_RUNNING)
+		return;
+
+	state = UMCG_TASK_BLOCKED;
+	if (put_user(state, (u32 __user *)ut)) {
+		umcg_segv(0);
+		return;
+	}
+
+	rcu_read_lock();
+	server = rcu_dereference(utd->peer);
+	rcu_read_unlock();
+
+	if (server)
+		WARN_ON(!try_to_wake_up(server, TASK_NORMAL, WF_CURRENT_CPU));
+}
+
+/* Return true to return to the user, false to keep waiting. */
+static bool process_unblocked_worker(void)
+{
+	struct umcg_task_data *utd;
+	struct umcg_group *group;
+
+	rcu_read_lock();
+
+	utd = rcu_dereference(current->umcg_task_data);
+	group = utd->group;
+
+	spin_lock(&group->lock);
+	if (!list_empty(&utd->list)) {
+		/* This was a spurious wakeup or an interrupt, do nothing. */
+		spin_unlock(&group->lock);
+		rcu_read_unlock();
+		do_wait();
+		return false;
+	}
+
+	if (group->nr_waiting_pollers > 0) {  /* Wake a server. */
+		struct task_struct *server;
+		struct umcg_task_data *server_utd = list_first_entry(
+				&group->waiters, struct umcg_task_data, list);
+
+		list_del_init(&server_utd->list);
+		server = server_utd->self;
+		--group->nr_waiting_pollers;
+
+		umcg_lock_pair(server, current);
+		spin_unlock(&group->lock);
+
+		if (WARN_ON(server_utd->peer || utd->peer)) {
+			umcg_segv(0);
+			return true;
+		}
+		rcu_assign_pointer(server_utd->peer, current);
+		rcu_assign_pointer(utd->peer, server);
+
+		umcg_unlock_pair(server, current);
+		rcu_read_unlock();
+
+		if (put_state(utd->umcg_task, UMCG_TASK_RUNNABLE)) {
+			umcg_segv(0);
+			return true;
+		}
+
+		do_context_switch(server);
+		return false;
+	}
+
+	/* Add to the queue. */
+	++group->nr_waiting_workers;
+	list_add_tail(&utd->list, &group->waiters);
+	spin_unlock(&group->lock);
+	rcu_read_unlock();
+
+	do_wait();
+
+	smp_rmb();
+	if (!list_empty(&utd->list)) {
+		spin_lock(&group->lock);
+		list_del_init(&utd->list);
+		--group->nr_waiting_workers;
+		spin_unlock(&group->lock);
+	}
+
+	return false;
+}
+
+void umcg_on_wake(void)
+{
+	struct umcg_task_data *utd;
+	struct umcg_task __user *ut;
+	bool should_break = false;
+
+	/* current->umcg_task_data is modified only from current. */
+	utd = rcu_access_pointer(current->umcg_task_data);
+	if (utd->task_type != UMCG_TT_WORKER || utd->in_workqueue)
+		return;
+
+	do {
+		u32 state;
+
+		if (fatal_signal_pending(current))
+			return;
+
+		if (signal_pending(current))
+			return;
+
+		ut = utd->umcg_task;
+
+		if (get_state(ut, &state)) {
+			if (signal_pending(current))
+				return;
+			goto segv;
+		}
+
+		if (state == UMCG_TASK_RUNNING && rcu_access_pointer(utd->peer))
+			return;
+
+		if (state == UMCG_TASK_BLOCKED || state == UMCG_TASK_RUNNING) {
+			state = UMCG_TASK_UNBLOCKED;
+			if (put_state(ut, state))
+				goto segv;
+		} else if (state != UMCG_TASK_UNBLOCKED) {
+			goto segv;
+		}
+
+		utd->in_workqueue = true;
+		should_break = process_unblocked_worker();
+		utd->in_workqueue = false;
+		if (should_break)
+			return;
+
+	} while (!should_break);
+
+segv:
+	umcg_segv(0);
+}
diff --git a/kernel/sched/umcg.h b/kernel/sched/umcg.h
index 6791d570f622..92012a1674ab 100644
--- a/kernel/sched/umcg.h
+++ b/kernel/sched/umcg.h
@@ -8,6 +8,34 @@
 #include <linux/sched.h>
 #include <linux/umcg.h>
 
+struct umcg_group {
+	struct list_head list;
+	u32 group_id;     /* Never changes. */
+	u32 api_version;  /* Never changes. */
+	u64 flags;        /* Never changes. */
+
+	spinlock_t lock;
+
+	/*
+	 * One of the counters below is always zero. The non-zero counter
+	 * indicates the number of elements in @waiters below.
+	 */
+	int nr_waiting_workers;
+	int nr_waiting_pollers;
+
+	/*
+	 * The list below either contains UNBLOCKED workers waiting
+	 * for the userspace to poll or run them if nr_waiting_workers > 0,
+	 *  or polling servers waiting for unblocked workers if
+	 *  nr_waiting_pollers > 0.
+	 */
+	struct list_head waiters;
+
+	int nr_tasks;  /* The total number of tasks registered. */
+
+	struct rcu_head rcu;
+};
+
 enum umcg_task_type {
 	UMCG_TT_CORE	= 1,
 	UMCG_TT_SERVER	= 2,
@@ -32,11 +60,37 @@ struct umcg_task_data {
 	 */
 	u32 api_version;
 
+	/* NULL for core API tasks. Never changes. */
+	struct umcg_group		*group;
+
+	/*
+	 * If this is a server task, points to its assigned worker, if any;
+	 * if this is a worker task, points to its assigned server, if any.
+	 *
+	 * Protected by alloc_lock of the task owning this struct.
+	 *
+	 * Always either NULL, or the server and the worker point to each other.
+	 * Locking order: first lock the server, then the worker.
+	 *
+	 * Either the worker or the server should be the current task when
+	 * this field is changed, with the exception of sys_umcg_swap.
+	 */
+	struct task_struct __rcu	*peer;
+
+	/* Used in umcg_group.waiters. */
+	struct list_head		list;
+
+	/* Used by curr in umcg_on_block/wake to prevent nesting/recursion. */
+	bool				in_workqueue;
+
 	/*
 	 * Used by wait/wake routines to handle races. Written only by current.
 	 */
 	bool				in_wait;
 };
 
+void umcg_on_block(void);
+void umcg_on_wake(void);
+
 #endif  /* CONFIG_UMCG */
 #endif  /* _KERNEL_SCHED_UMCG_H */
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 153162669f80..85e4a8ecfd91 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -36,6 +36,10 @@ struct mm_struct init_mm = {
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
+#ifdef CONFIG_UMCG
+	.umcg_lock	= __SPIN_LOCK_UNLOCKED(init_mm.umcg_lock),
+	.umcg_groups	= LIST_HEAD_INIT(init_mm.umcg_groups),
+#endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
-- 
2.31.1.818.g46aad6cb9e-goog

