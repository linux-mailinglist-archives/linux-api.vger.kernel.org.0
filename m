Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDE2B228E
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 18:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMRey (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 12:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgKMRex (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 12:34:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC19C0613D1
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 09:34:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o5so9941062ybe.12
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 09:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZsQdeBNMv7hOETc9fSaUWVVeMIm9t9MNudq+U9YvmqU=;
        b=X54a4os3itmD5YQrBTHoM5/2Axj5Oh+y4MRUkEe8kEiXGcKlKTdMpz6ijG482PgJAJ
         E6+9pSELboav2zygBsxNl771+cdUDqS+Pg4C9wj+aXbA1G+ec/xWjOB/07eCM0ER8UEm
         nrzurd205gkbSWKTpzV9PTTnsZPh61zNMUC1tZdsK4VykBDeo9Ngf/yFypgO0PDVNzHn
         HPNF0Hlqvt6Ly1oIVqe+FhX3hCaqVOrPf+fCMT6m3Jl8bEwh2RziliVNqBtSLlk4T47T
         7vzVc4/o5AVAtbJlSxwo9fAFD6RydC3bzlAn/eTO6MOC4O0zMS2Ly3viF7IClIvcrWk4
         b/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZsQdeBNMv7hOETc9fSaUWVVeMIm9t9MNudq+U9YvmqU=;
        b=ol+NUA7iBvpRwbAkqHDhAWAcMCgQSCzAq+MgDrQD/up9Let8OXgFxs6n94djSdf2fk
         OIG0G55k4wm+2q1ph65IVNWjUSWJeDtO0en7If1uBut6f0K2dTDsb2szBAr52zoauIJV
         r5E0rWhIGquFjCTJ6OJhNerWTdAyn+trKWAePMAkwaFeS0A31u+5LqDT1wFZUjTaRWTF
         cbwxSKnw0EPML3cOEW3Z8x5EFir+e3mAqU0dC+7PaUQ+Mz51ZdFaQ0F8hyG74oxU8iUJ
         SEQyWZm0Mtt0vl7DiHpDyD0EMI94hXLjTqlhxdacJzLGnsSGaEt3b93RbGtjez3p5MDp
         BehQ==
X-Gm-Message-State: AOAM530qytqjBf4tVO35JSUgAm8UrIxTUK0qU2zM7LMNtGwp1/TAoC2U
        g2AwsAO77L68QfDZUrDI8s+oCJ54O6c=
X-Google-Smtp-Source: ABdhPJz0e6m8NgCQdlJ9lY/OcnFz+0tvqR2+7WCYCq1mGUncy7h2VBfmZqJioqhT/TIB0FJtbNToj2B5CdE=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([100.98.240.136]) (user=surenb
 job=sendgmr) by 2002:a5b:c08:: with SMTP id f8mr3997350ybq.398.1605288892382;
 Fri, 13 Nov 2020 09:34:52 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:34:48 -0800
Message-Id: <20201113173448.1863419-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        oleg@redhat.com, timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When a process is being killed it might be in an uninterruptible sleep
which leads to an unpredictable delay in its memory reclaim. In low memory
situations, when it's important to free up memory quickly, such delay is
problematic. Kernel solves this problem with oom-reaper thread which
performs memory reclaim even when the victim process is not runnable.
Userspace currently lacks such mechanisms and the need and potential
solutions were discussed before (see links below).
This patch provides a mechanism to perform memory reclaim in the context
of the process that sends SIGKILL signal. New SYNC_REAP_MM flag for
pidfd_send_signal syscall can be used only when sending SIGKILL signal
and will lead to the caller synchronously reclaiming the memory that
belongs to the victim and can be easily reclaimed.

1. https://patchwork.kernel.org/cover/10894999
2. https://lwn.net/Articles/787217
3. https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/oom.h    |  2 ++
 include/linux/signal.h |  7 ++++
 kernel/signal.c        | 73 ++++++++++++++++++++++++++++++++++++++++--
 mm/oom_kill.c          |  2 +-
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..9a8dcabdfdf1 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -111,6 +111,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm);
 long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
 
+extern bool task_will_free_mem(struct task_struct *task);
+
 extern bool out_of_memory(struct oom_control *oc);
 
 extern void exit_oom_victim(void);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index b256f9c65661..5deafc99035d 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -449,6 +449,13 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
 	(!siginmask(signr, SIG_KERNEL_IGNORE_MASK|SIG_KERNEL_STOP_MASK) && \
 	 (t)->sighand->action[(signr)-1].sa.sa_handler == SIG_DFL)
 
+/*
+ * Flag values used in pidfd_send_signal:
+ *
+ * SYNC_REAP_MM indicates request to reclaim mm after SIGKILL.
+ */
+#define SYNC_REAP_MM	0x1
+
 void signals_init(void);
 
 int restore_altstack(const stack_t __user *);
diff --git a/kernel/signal.c b/kernel/signal.c
index ef8f2a28d37c..15d4be5600a3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -46,6 +46,7 @@
 #include <linux/livepatch.h>
 #include <linux/cgroup.h>
 #include <linux/audit.h>
+#include <linux/oom.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -3711,6 +3712,63 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	return tgid_pidfd_to_pid(file);
 }
 
+static int reap_mm(struct pid *pid)
+{
+	struct task_struct *task;
+	struct mm_struct *mm;
+	int ret = 0;
+
+	/* Get the task_struct */
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		ret = -ESRCH;
+		goto out;
+	}
+
+	task_lock(task);
+
+	/* Check if memory can be easily reclaimed */
+	if (!task_will_free_mem(task)) {
+		task_unlock(task);
+		ret = -EBUSY;
+		goto release_task;
+	}
+
+	/* Get mm to prevent exit_mmap */
+	mm = task->mm;
+	mmget(mm);
+
+	/* Ensure no competition with OOM-killer to prevent contention */
+	if (unlikely(mm_is_oom_victim(mm)) ||
+	    unlikely(test_bit(MMF_OOM_SKIP, &mm->flags))) {
+		/* Already being reclaimed */
+		task_unlock(task);
+		goto drop_mm;
+	}
+	/*
+	 * Prevent OOM-killer or other pidfd_send_signal from considering
+	 * this task
+	 */
+	set_bit(MMF_OOM_SKIP, &mm->flags);
+
+	task_unlock(task);
+
+	mmap_read_lock(mm);
+	if (!__oom_reap_task_mm(mm)) {
+		/* Failed to reap part of the address space. User can retry */
+		ret = -EAGAIN;
+		clear_bit(MMF_OOM_SKIP, &mm->flags);
+	}
+	mmap_read_unlock(mm);
+
+drop_mm:
+	mmput(mm);
+release_task:
+	put_task_struct(task);
+out:
+	return ret;
+}
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -3737,10 +3795,16 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	struct pid *pid;
 	kernel_siginfo_t kinfo;
 
-	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags)
+	/* Enforce only valid flags. */
+	if (flags) {
+		/* Allow SYNC_REAP_MM only with SIGKILL. */
+		if (flags == SYNC_REAP_MM && sig == SIGKILL)
+			goto valid;
+
 		return -EINVAL;
+	}
 
+valid:
 	f = fdget(pidfd);
 	if (!f.file)
 		return -EBADF;
@@ -3775,6 +3839,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	}
 
 	ret = kill_pid_info(sig, &kinfo, pid);
+	if (unlikely(ret))
+		goto err;
+
+	if (flags & SYNC_REAP_MM)
+		ret = reap_mm(pid);
 
 err:
 	fdput(f);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8b84661a6410..66c90bca25bc 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -808,7 +808,7 @@ static inline bool __task_will_free_mem(struct task_struct *task)
  * Caller has to make sure that task->mm is stable (hold task_lock or
  * it operates on the current).
  */
-static bool task_will_free_mem(struct task_struct *task)
+bool task_will_free_mem(struct task_struct *task)
 {
 	struct mm_struct *mm = task->mm;
 	struct task_struct *p;
-- 
2.29.2.299.gdc1121823c-goog

