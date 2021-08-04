Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2422B3E0846
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhHDSuW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHDSuV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 14:50:21 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED8C061799
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 11:50:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w11-20020ac857cb0000b029024e7e455d67so1425625qta.16
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OjvUMyrIcQ79ddCEFAKmTzo0Fl6Wl/yaJu1sqvdsG9Y=;
        b=PfZAaQztIk56Rc/axzBkhPLBWZZ27/gOeZblbSSzfjXlU4/1i+GJranNYgpzgB4kYk
         1I8LXjuN7gG9izjLC1Ue5lAmCvGg1YGCb7YnRrK/k7+fDKAONx+txuJmC0kqTS2cPLxu
         ySSh9ahBxrXVGXAAWRdTkfesk9GEj2D38kPRdluNHbQN2d3zoCZgHVVrQAiaGG45oyv3
         R6fbnFEOM4lAP0NDzihNQvMEinRg++/mTxu0GU8VR67Ie1bJLCHbHA1DSm3TySEbOvst
         f//L9nzJJNvYHRZMlfZCGAD8xZRJgiE6reJr3pEUyjAhM0H4t/Oy95OfIT/jETwGSJ8S
         hvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OjvUMyrIcQ79ddCEFAKmTzo0Fl6Wl/yaJu1sqvdsG9Y=;
        b=J+Ks9wZ9ZGEmA4Cv7EJIFhfKPYNNTl9bW4k4Q3s8Cg0kXwIRTa9kpsvFODwVCgAjSY
         SnOausUenHqskuiKLp6hOwVLyzIaXOF779J6JeLNZfRUUmzbsp4UZ4DW2652ME1vu8kH
         T1WepvgFuP/H9biiPCpB/Sw8Q1dI9Kfv0A/1cE+JrKO+7YhrQzSWkPJaejpNvIyHKcdd
         NiYiOopmI/7bwurs61i+f9ZMeGOfaVN+n8Y4zRRASzsZyLud/Mx4sEpS1oHhBZMTNl6H
         CJMw7/EreF/fiDplYQJw7ON+zATI/dPxhr7jCZdoRFbVaH3WsZffBsyIMkd3LPwPoaUH
         ms9Q==
X-Gm-Message-State: AOAM533tOn24LcU26yHG4Qr2UuTf7OtntLJ5wdY0YJWIeyLQJzNBDo5Q
        qqY9fRvM5B2xapfKe2iVHSFMKt1skME=
X-Google-Smtp-Source: ABdhPJxo93gn3ak30iiaIg5R0agZ+Wb/CR6Hf+gAkozkfekNg9zGSj1+2y1MsBeEyGQBBpY8jpBlKfn2/cA=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:b576:f4a3:d948:a503])
 (user=surenb job=sendgmr) by 2002:a05:6214:7f2:: with SMTP id
 bp18mr874299qvb.9.1628103008061; Wed, 04 Aug 2021 11:50:08 -0700 (PDT)
Date:   Wed,  4 Aug 2021 11:50:03 -0700
Message-Id: <20210804185004.1304692-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v6 1/2] mm: introduce process_mrelease system call
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

After previous discussions [1, 2, 3] the decision was made [4] to introduce
a dedicated system call to cover this use case.

The API is as follows,

          int process_mrelease(int pidfd, unsigned int flags);

        DESCRIPTION
          The process_mrelease() system call is used to free the memory of
          an exiting process.

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

          EINVAL The memory of the task cannot be released because the
                 process is not exiting, the address space is shared
                 with another live process or there is a core dump in
                 progress.

          ENOSYS This system call is not supported, for example, without
                 MMU support built into Linux.

          ESRCH  The target process does not exist (i.e., it has terminated
                 and been waited on).

[1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
[2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
[3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
[4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v5:
- Changed links, per David Hildenbrand and Michal Hocko
- Condensed the background section in the description, per David Hildenbrand
- Changed flags check, per David Hildenbrand
- Changed description for ENOSYS in the manual pages, per David Hildenbrand
- Changed wording from "SIGKILLed" to "exiting" process in the manual pages
description, per Michal Hocko
- Used find_lock_task_mm() to lock the task_struct, per Michal Hocko
- Added check for MMF_OOM_SKIP, per Michal Hocko

changes in v6:
- Changed MMF_OOM_SKIP handling by returning success, per Michal Hocko

 mm/oom_kill.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..4f43ee79f663 100644
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
@@ -1141,3 +1142,67 @@ void pagefault_out_of_memory(void)
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
+	if (flags)
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
+	task = find_lock_task_mm(task);
+	if (!task) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
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
+	if (test_bit(MMF_OOM_SKIP, &mm->flags))
+		goto put_mm;
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

