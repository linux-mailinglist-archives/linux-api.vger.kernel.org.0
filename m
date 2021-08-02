Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9463DE24E
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhHBWOs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHBWOq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Aug 2021 18:14:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D811FC061798
        for <linux-api@vger.kernel.org>; Mon,  2 Aug 2021 15:14:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so14062091qki.15
        for <linux-api@vger.kernel.org>; Mon, 02 Aug 2021 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cDcDQEZ+ELX7MhcOwNzOOCGfAe7NRcZ5bpy6u2xYIHI=;
        b=eAZElcb2hIX+9OSTDxDxtO5eY2wmjEdDv4MqPXygDCO3Oy4E/ZGHfTyDlp1YG3IBIj
         quLjsPL3ih7cF0Ng916kfFiwEwCPlCnFnXbTM+QEXALovJLz3sM8F0r9FIceOKDSahJY
         6qUd5UvTfknowyGSsSdKGcJhg3BMVP2QfGRnRG6IGoSus4GN95TYmNI14ZqEf6txgyof
         S4Qn41DcwfSew8F/9Rrc4QJf1BnBoGOmo6MewE84VktQH70/VeGoXzEdQmW+4oHXHrNr
         qEjzV9bAhQBInPPWmWfoomR87P01C8FgQgBg2zqTYppXgDj/HCvpZ88wHpxGgRqrtx1J
         Z4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cDcDQEZ+ELX7MhcOwNzOOCGfAe7NRcZ5bpy6u2xYIHI=;
        b=q/vkxSHOXu7VZAiMQEK24I0yX7Nem4VyRa/1lvFSl4Vkp0zB85T1WyshvIe3eemZDE
         jbT+p4/bmhib46ik7Vfq9I32pj3dt5bh0XcR6jIv0W9CK64tqHE5V2e2NPKq8f+pgsT8
         yRwYYEqas/NB4rnczxvYab7ufQfXFokqSJGJj/eiz1W9DzsvPbGSL8hCNXoO3s4j335t
         LPvPFmvG3LwDp2XBs2w01SfDHa2K7o8gwGFNUIAvYrnYrseCR0D862ATorc4hf6jI5SA
         4K0jp95rDB+1ANwHvlZvQmnLKZKLEKKaHwf2CKHHhJgkIMHUtrXsxUgtQq8h2ZK6glP9
         lGcw==
X-Gm-Message-State: AOAM533QidNKkutrm/fRVGhEVNmchudjOgx98grOeGtYTRAqi91TiMKK
        NJk8DCQrqsMwxIz1BBhqFfK0f1wFGo4=
X-Google-Smtp-Source: ABdhPJxVUAfHAWT7elLTQxSRi9zIVge8Lt1ionWnShx1zlnB2Cl/0LdieBS0MUYeJnC/RXusu0FkvwAptoE=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f862:f0be:225a:c68d])
 (user=surenb job=sendgmr) by 2002:a05:6214:2a45:: with SMTP id
 jf5mr12445893qvb.25.1627942474989; Mon, 02 Aug 2021 15:14:34 -0700 (PDT)
Date:   Mon,  2 Aug 2021 15:14:30 -0700
Message-Id: <20210802221431.2251210-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v4 1/2] mm: introduce process_mrelease system call
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

          EINTR  The call was interrupted by a signal; see signal(7).

          EINVAL flags is not 0.

          EINVAL The task does not have a pending SIGKILL or its memory is
                 shared with another process with no pending SIGKILL.

          ENOSYS This system call is not supported by kernels built with no
                 MMU support (CONFIG_MMU=n).

          ESRCH  The target process does not exist (i.e., it has terminated
                 and been waited on).

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v4:
- Replaced mmap_read_lock() with mmap_read_lock_killable(), per Michal Hocko
- Added EINTR error in the manual pages documentation

 mm/oom_kill.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..86727794b0a8 100644
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
@@ -1141,3 +1142,60 @@ void pagefault_out_of_memory(void)
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
+	if (mmap_read_lock_killable(mm)) {
+		ret = -EINTR;
+		goto put_mm;
+	}
+	if (!__oom_reap_task_mm(mm))
+		ret = -EAGAIN;
+	mmap_read_unlock(mm);
+
+put_mm:
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
2.32.0.554.ge1b32706d8-goog

