Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE153E4C6C
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhHISxZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbhHISxY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 14:53:24 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98613C0613D3
        for <linux-api@vger.kernel.org>; Mon,  9 Aug 2021 11:53:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h5-20020a05620a0525b02903b861bec838so13373224qkh.7
        for <linux-api@vger.kernel.org>; Mon, 09 Aug 2021 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ywM/Xx2WoSrklXYQ+qGHDsBP/6PxFFUaXmUO4ywj3C8=;
        b=dC5FGoRYQBrQmEh1n/oqJCImjvo/gRH651cSk3+XrTSgapBJQsHnCZtGmhFmVEe+1c
         AQ8zQeee2kw/+p8S76GvU6pnmbTQuRmI7s/ggpni0zUkYnW/7kkBgzsfSX/+MNavPTtW
         msxW6Avn3jhgQ9c1pk7nfXJAOFsNoSKUT6BW4NEfkEfMLs4akACoMNlvdzAKDdIWakuP
         WYQ0jKNciB1S/1yzDmoOkHPhd+UhLkHdzK2DMPlkzvcHRN8QNDZ6I+NlEar1yvUY74V7
         IF5HtwGuE4s/f+i+fWh7KrOI+stz60yayESp4aV7mZVxT7Wgz2izBGst9l6nbLS+ozXv
         AKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ywM/Xx2WoSrklXYQ+qGHDsBP/6PxFFUaXmUO4ywj3C8=;
        b=A57nr6MpG9wJurDyOZla5dtTEvoDe2Mw10udjbrDoLM2ovQ5O0OMaOy5yY+vnZJpnO
         CAZqASjTxAkpnm2tZiNl+1LwNgzD8FV2m9BVXUVjEGJkE+Z6bEGQ1GW596RrP3SSb30v
         NSW3Wy0EL4/85ViPzrNgklIHHI6B4w+TXD/KOvTjiLdd/6flobMr6Pynates8BV2KnI+
         or+BdYlcqhdIxk/XLByDWZPFQR6i2SXcbj6mscoDBPAC01kdqNiMCNp2wVQAFHnp6LEc
         N4xSMc+fLx05+qL6B9MhusTbiqROK8MvP3TLWoDCaPHpkea77h6Gd8NAw3rync77J3B5
         X99A==
X-Gm-Message-State: AOAM532lQZf/EJT2mNZxm8Pt/GBTfM2S869qrdrBe35aJaKtqY0PhFp/
        CYqbTVP3aBlP+Is4MfjLgy+Rzf6BIjE=
X-Google-Smtp-Source: ABdhPJwiQF8NwHXdMwNZmBEQw5JxirhPVsoHFH9/CrfilF/vN/QZPl3B2BWzVjQMYdqDvH0pepiK1BXxuHc=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:cd66:472e:bb3:568])
 (user=surenb job=sendgmr) by 2002:ad4:5de1:: with SMTP id jn1mr13910131qvb.62.1628535182750;
 Mon, 09 Aug 2021 11:53:02 -0700 (PDT)
Date:   Mon,  9 Aug 2021 11:52:58 -0700
Message-Id: <20210809185259.405936-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v9 1/2] mm: introduce process_mrelease system call
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, geert@linux-m68k.org,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-api@vger.kernel.org,
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
          (See pidfd_open(2) for further information)

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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
changes in v9:
- Replaced PIDTYPE_PID with PIDTYPE_TGID in get_pid_task(),
per Christian Brauner

 mm/oom_kill.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..831340e7ad8b 100644
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
@@ -1141,3 +1142,72 @@ void pagefault_out_of_memory(void)
 	out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 }
+
+SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm = NULL;
+	struct task_struct *task;
+	struct task_struct *p;
+	unsigned int f_flags;
+	bool reap = true;
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
+	task = get_pid_task(pid, PIDTYPE_TGID);
+	if (!task) {
+		ret = -ESRCH;
+		goto put_pid;
+	}
+
+	/*
+	 * Make sure to choose a thread which still has a reference to mm
+	 * during the group exit
+	 */
+	p = find_lock_task_mm(task);
+	if (!p) {
+		ret = -ESRCH;
+		goto put_task;
+	}
+
+	mm = p->mm;
+	mmgrab(mm);
+
+	/* If the work has been done already, just exit with success */
+	if (test_bit(MMF_OOM_SKIP, &mm->flags))
+		reap = false;
+	else if (!task_will_free_mem(p)) {
+		reap = false;
+		ret = -EINVAL;
+	}
+	task_unlock(p);
+
+	if (!reap)
+		goto drop_mm;
+
+	if (mmap_read_lock_killable(mm)) {
+		ret = -EINTR;
+		goto drop_mm;
+	}
+	if (!__oom_reap_task_mm(mm))
+		ret = -EAGAIN;
+	mmap_read_unlock(mm);
+
+drop_mm:
+	mmdrop(mm);
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
2.32.0.605.g8dce9f2422-goog

