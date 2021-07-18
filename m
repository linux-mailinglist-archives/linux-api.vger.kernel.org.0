Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAF63CCB03
	for <lists+linux-api@lfdr.de>; Sun, 18 Jul 2021 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhGRVom (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Jul 2021 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhGRVol (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Jul 2021 17:44:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABA6C061762
        for <linux-api@vger.kernel.org>; Sun, 18 Jul 2021 14:41:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s186-20020a252cc30000b029055bc7fcfebdso22364201ybs.12
        for <linux-api@vger.kernel.org>; Sun, 18 Jul 2021 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4bkV6cSD+g94olJaPFyf8RuKGT1BVzA1s5RfVT46Hu8=;
        b=NgBO8GgNyqB53CZUM197rPIo0ec5jiBD9ju8nCJMERKsldbarR2Hz70KoJFhFg8p9q
         iRwCxKjmJWb7azY3+CpRsIr9VHlOH7j/ESu17lnL334qL64gaASuuetvd1ZWm7qjDAlC
         Yv/tp8+L0g7oaWnsUizrG5wRCn+v+YydpMYBu+9XvIur/fehduGKbGrQaW9S1Lv+QDzd
         JWAsq3nxzy/zAq54POc6Mxya+yzlq8PBF93flUZJskOJYwtg2ItNLmdpc5XpMoDsRmym
         ESyqLyTC76U8JPmZLuAG3orgDWlLfR+MoBtFzQ/l7DJdHotidq12XuASKKqanMjEZpcq
         YuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4bkV6cSD+g94olJaPFyf8RuKGT1BVzA1s5RfVT46Hu8=;
        b=sTAXVBbXZTDNt5crmubF5BFwYS+UpbiwGkwVMieJRXT5NFBRISSoG28IQex/JEKBbc
         AnPFEl6Aw/sKhIxWfwgcG/0XYTmpXGaA9wAXvFJ4yIahyVUDU6Z9s9oJ+957NjVwOCk3
         OXQGattaKzjFrk2fXRx/750wpi9+P9QsyAJnqTs0Z+H2oCd/XcuuJ4ANMp/84TYn7wrw
         aFKKRIZRlU7oVRr3Qc1Gq2sDk4aVaowxVKkQPeiZSLfedqzUgDZhSS0oZkPgwV5gsZ1A
         fl235jWlXJO2shjyMOd2B2gB81NqCL09GoSwVGJb6aMXPXWJaGck4S2l9rgMfowr7qlp
         1Zsg==
X-Gm-Message-State: AOAM530v9SYL8H8n36ieAUs+MG8kViNgs87C8XFpiYTZj/WiwBANHvIa
        QUB43TQiLgVACsh1MLrJFNPoAqYynFA=
X-Google-Smtp-Source: ABdhPJxxwY1gumWEC5yk+3pKo0btgGJRkcAaLRdr99ZEo1zw3r96875ZkhvEX2ovtrUo7844Smdl4CwpMhU=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:b347:cf97:e43a:9891])
 (user=surenb job=sendgmr) by 2002:a25:ca88:: with SMTP id a130mr28146682ybg.4.1626644501504;
 Sun, 18 Jul 2021 14:41:41 -0700 (PDT)
Date:   Sun, 18 Jul 2021 14:41:33 -0700
In-Reply-To: <20210718214134.2619099-1-surenb@google.com>
Message-Id: <20210718214134.2619099-2-surenb@google.com>
Mime-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v2 2/3] mm: introduce process_mrelease system call
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In modern systems it's not unusual to have a system component monitoring
memory conditions of the system and tasked with keeping system memory
pressure under control. One way to accomplish that is to kill
non-essential processes to free up memory for more important ones.
Examples of this are Facebook's OOM killer daemon called oomd and
Android's low memory killer daemon called lmkd.
For such system component it's important to be able to free memory
quickly and efficiently. Unfortunately the time process takes to free
up its memory after receiving a SIGKILL might vary based on the state
of the process (uninterruptible sleep), size and OPP level of the core
the process is running. A mechanism to free resources of the target
process in a more predictable way would improve system's ability to
control its memory pressure.
Introduce process_mrelease system call that releases memory of a dying
process from the context of the caller. This way the memory is freed in
a more controllable way with CPU affinity and priority of the caller.
The workload of freeing the memory will also be charged to the caller.
The operation is allowed only on a dying process.

Previously I proposed a number of alternatives to accomplish this:
- https://lore.kernel.org/patchwork/patch/1060407 extending
pidfd_send_signal to allow memory reaping using oom_reaper thread;
- https://lore.kernel.org/patchwork/patch/1338196 extending
pidfd_send_signal to reap memory of the target process synchronously from
the context of the caller;
- https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
support for process_madvise implementing synchronous memory reaping.

The end of the last discussion culminated with suggestion to introduce a
dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
The reasoning was that the new variant of process_madvise
  a) does not work on an address range
  b) is destructive
  c) doesn't share much code at all with the rest of process_madvise
From the userspace point of view it was awkward and inconvenient to provide
memory range for this operation that operates on the entire address space.
Using special flags or address values to specify the entire address space
was too hacky.

The API is as follows,

          int process_mrelease(int pidfd, unsigned int flags);

        DESCRIPTION
          The process_mrelease() system call is used to free the memory of
          a process which was sent a SIGKILL signal.

          The pidfd selects the process referred to by the PID file
          descriptor.
          (See pidofd_open(2) for further information)

          The flags argument is reserved for future use; currently, this
          argument must be specified as 0.

        RETURN VALUE
          On success, process_mrelease() returns 0. On error, -1 is
          returned and errno is set to indicate the error.

        ERRORS
          EBADF  pidfd is not a valid PID file descriptor.

          EAGAIN Failed to release part of the address space.

          EINVAL flags is not 0.

          EINVAL The task does not have a pending SIGKILL or its memory is
                 shared with another process with no pending SIGKILL.

          ENOSYS This system call is not supported by kernels built with no
                 MMU support (CONFIG_MMU=n).

          ESRCH  The target process does not exist (i.e., it has terminated
                 and been waited on).

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/oom_kill.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index d04a13dc9fde..7fbfa70d4e97 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -28,6 +28,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/debug.h>
 #include <linux/swap.h>
+#include <linux/syscalls.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/cpuset.h>
@@ -755,10 +756,64 @@ static int __init oom_init(void)
 	return 0;
 }
 subsys_initcall(oom_init)
+
+SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
+{
+	struct pid *pid;
+	struct task_struct *task;
+	struct mm_struct *mm = NULL;
+	unsigned int f_flags;
+	long ret = 0;
+
+	if (flags != 0)
+		return -EINVAL;
+
+	pid = pidfd_get_pid(pidfd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
+
+	/*
+	 * If the task is dying and in the process of releasing its memory
+	 * then get its mm.
+	 */
+	task_lock(task);
+	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
+		mm = task->mm;
+		mmget(mm);
+	}
+	task_unlock(task);
+	if (!mm) {
+		ret = -EINVAL;
+		goto put_task;
+	}
+
+	mmap_read_lock(mm);
+	if (!__oom_reap_task_mm(mm))
+		ret = -EAGAIN;
+	mmap_read_unlock(mm);
+
+	mmput(mm);
+put_task:
+	put_task_struct(task);
+put_pid:
+	put_pid(pid);
+	return ret;
+}
 #else
 static inline void wake_oom_reaper(struct task_struct *tsk)
 {
 }
+
+SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
+{
+	return -ENOSYS;
+}
 #endif /* CONFIG_MMU */
 
 /**
-- 
2.32.0.402.g57bb445576-goog

