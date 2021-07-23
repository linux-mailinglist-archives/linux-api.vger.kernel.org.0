Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E43F3D3125
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 03:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhGWAeG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 20:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhGWAeG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jul 2021 20:34:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF902C061575
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 18:14:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h7-20020a5b0a870000b029054c59edf217so9673025ybq.3
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w//jlFLX9+ZSHdVn9vUWOdr1tmIhHkNEpty1jGjHcPU=;
        b=AbCwBH20jw8sBTAhoQfNhqS0EsIpCOiubspGKg1TWwuX0H89dxlBwzFv6r/HFhDdIp
         giDC4FXWje/YEdEPkumtvMsZiP5AkYnXgBsVOhLQhq3ubkYfNut0l+/CzUE+0KTICXbN
         fiTZK1HC0eeOi7mLLbBksjOAND5sOrEnSqfjDfqK202Zp4HvgsDVTf/JIehBdmTT0C+m
         t/XlfSy1qbVP/ZEAUoVsWMG7MPuKvdHe+zn88RdWzoGUeOdUT3jEdANBFffdlRQh6i6F
         s/nxk0TRg8a2sMpyxuNFASfvHxoAuJaRnTXeoZuhgjGdqrgI9uaTrTUUhJYcOrfZ7fIu
         kJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w//jlFLX9+ZSHdVn9vUWOdr1tmIhHkNEpty1jGjHcPU=;
        b=XmStUORgDCoVrehtRGHoqIN0Y2FZBlfRrWYvkUZ2Xrn+jQ9V3etJO2znqUmf1sSY2G
         M77A9HsKn2v5d9B+H+EgXIkpYXjJ7VJcsJ+Ru/fpizehEWqYhNkLTU5/QcI1EVZxrRsR
         Z4yPExL8HOt1g72Ew+Ak7mHYmXi2jhK2gNhR7lq6d9tDcLtFAP+seYdTY5zrtipO17b4
         umU7EUmnVpAAxra5/MOvrVz+Zjz6UnObQiO2hWBbIHgb30+H7h+DTPgMxHgdp3OhMU+5
         yj22/zNvBgXfzbkIkX2FdT2VmVhUrNLu6ACfO4AFWgizRFgPVJzbLxuKxNK3kr2eXJ5s
         JquA==
X-Gm-Message-State: AOAM533BzrmRZvQkjpCzwOyHeZwukI6m62xiL/3B9tt9sqs65XCePC/b
        aZ5Lnwi2NJKIubscAgVFfug2aFJghZY=
X-Google-Smtp-Source: ABdhPJy3vTo4OqL+wNFslFerv8aSMyArHFXBtxkLN8ueXa396MQ+DdZ/X6m3w95usWbDX14N98UzxULLgHo=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9b49:cc32:b051:fd83])
 (user=surenb job=sendgmr) by 2002:a25:afcd:: with SMTP id d13mr3206313ybj.504.1627002879922;
 Thu, 22 Jul 2021 18:14:39 -0700 (PDT)
Date:   Thu, 22 Jul 2021 18:14:35 -0700
Message-Id: <20210723011436.60960-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 1/2] mm: introduce process_mrelease system call
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
changes in v3:
- Added #ifdef CONFIG_MMU inside process_mrelease to keep task_will_free_mem in
the same place, per David Hildenbrand
- Reordered variable definitions in process_mrelease, per David Hildenbrand

 mm/oom_kill.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..8bf7a1020ac5 100644
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
@@ -1141,3 +1142,56 @@ void pagefault_out_of_memory(void)
 	out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 }
+
+SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm = NULL;
+	struct task_struct *task;
+	unsigned int f_flags;
+	struct pid *pid;
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
+#else
+	return -ENOSYS;
+#endif /* CONFIG_MMU */
+}
-- 
2.32.0.432.gabb21c7263-goog

