Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F03DE88C
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhHCIjW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 04:39:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhHCIjV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Aug 2021 04:39:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C4A521F2C;
        Tue,  3 Aug 2021 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627979949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMMIqngp44OTuqTueUK6qbrRh7OeIMoHp5ZvzTcwQAk=;
        b=SW4ZCWdloq+8uqcLLICJrlrrcmbDHxn1aoNHAVys0V8v7TibNPDd/QEFlGb4pf0XI+JjZc
        mYZ6xcO5mX9riOG8i2ztH9JcCyK3r2OMHisB5CBNd2VSWulO8GV2gbqnyqxVGdl/xixR/e
        4MDQgAjFDWWgRUD6vCU/N/zeSR7JQxI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12B9EA3BD1;
        Tue,  3 Aug 2021 08:39:09 +0000 (UTC)
Date:   Tue, 3 Aug 2021 10:39:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 1/2] mm: introduce process_mrelease system call
Message-ID: <YQkAqwZIF+AnpexA@dhcp22.suse.cz>
References: <20210802221431.2251210-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802221431.2251210-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 02-08-21 15:14:30, Suren Baghdasaryan wrote:
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_mrelease system call that releases memory of a dying
> process from the context of the caller. This way the memory is freed in
> a more controllable way with CPU affinity and priority of the caller.
> The workload of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.
> 
> Previously I proposed a number of alternatives to accomplish this:
> - https://lore.kernel.org/patchwork/patch/1060407 extending

Please use the msg-id based urls https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/

> pidfd_send_signal to allow memory reaping using oom_reaper thread;
> - https://lore.kernel.org/patchwork/patch/1338196 extending

https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/

> pidfd_send_signal to reap memory of the target process synchronously from
> the context of the caller;
> - https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
> support for process_madvise implementing synchronous memory reaping.

https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/

> The end of the last discussion culminated with suggestion to introduce a
> dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)

https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/

> The reasoning was that the new variant of process_madvise
>   a) does not work on an address range
>   b) is destructive
>   c) doesn't share much code at all with the rest of process_madvise
> >From the userspace point of view it was awkward and inconvenient to provide
> memory range for this operation that operates on the entire address space.
> Using special flags or address values to specify the entire address space
> was too hacky.
> 
> The API is as follows,
> 
>           int process_mrelease(int pidfd, unsigned int flags);
> 
>         DESCRIPTION
>           The process_mrelease() system call is used to free the memory of
>           a process which was sent a SIGKILL signal.

This is not really precise. The implementation will allow to use the
syscall on any exiting or fatal signal received process. Not just those
that have been SIGKILLed, right? For the purpose of the man page I would
go with exiting process for the wording.
 
>           The pidfd selects the process referred to by the PID file
>           descriptor.
>           (See pidofd_open(2) for further information)
> 
>           The flags argument is reserved for future use; currently, this
>           argument must be specified as 0.
> 
>         RETURN VALUE
>           On success, process_mrelease() returns 0. On error, -1 is
>           returned and errno is set to indicate the error.
> 
>         ERRORS
>           EBADF  pidfd is not a valid PID file descriptor.
> 
>           EAGAIN Failed to release part of the address space.
> 
>           EINTR  The call was interrupted by a signal; see signal(7).
> 
>           EINVAL flags is not 0.
> 
>           EINVAL The task does not have a pending SIGKILL or its memory is
>                  shared with another process with no pending SIGKILL.

again, wording here. I would go with
	    EINVAL The memory of the task cannot be released because the
	           process is not exiting, the address space is shared
		   with an alive process or there is a core dump is in
		   progress..
> 
>           ENOSYS This system call is not supported by kernels built with no
>                  MMU support (CONFIG_MMU=n).
> 
>           ESRCH  The target process does not exist (i.e., it has terminated
>                  and been waited on).
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v4:
> - Replaced mmap_read_lock() with mmap_read_lock_killable(), per Michal Hocko
> - Added EINTR error in the manual pages documentation
> 
>  mm/oom_kill.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c729a4c4a1ac..86727794b0a8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -28,6 +28,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/debug.h>
>  #include <linux/swap.h>
> +#include <linux/syscalls.h>
>  #include <linux/timex.h>
>  #include <linux/jiffies.h>
>  #include <linux/cpuset.h>
> @@ -1141,3 +1142,60 @@ void pagefault_out_of_memory(void)
>  	out_of_memory(&oc);
>  	mutex_unlock(&oom_lock);
>  }
> +
> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = NULL;
> +	struct task_struct *task;
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	long ret = 0;
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd, &f_flags);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +
> +	/*
> +	 * If the task is dying and in the process of releasing its memory
> +	 * then get its mm.
> +	 */
> +	task_lock(task);

Don't we need find_lock_task_mm here?

> +	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> +		mm = task->mm;
> +		mmget(mm);
> +	}
> +	task_unlock(task);
> +	if (!mm) {

Do we want to treat MMF_OOM_SKIP as a failure?

> +		ret = -EINVAL;
> +		goto put_task;
> +	}
> +
> +	if (mmap_read_lock_killable(mm)) {
> +		ret = -EINTR;
> +		goto put_mm;
> +	}
> +	if (!__oom_reap_task_mm(mm))
> +		ret = -EAGAIN;
> +	mmap_read_unlock(mm);
> +
> +put_mm:
> +	mmput(mm);
> +put_task:
> +	put_task_struct(task);
> +put_pid:
> +	put_pid(pid);
> +	return ret;
> +#else
> +	return -ENOSYS;
> +#endif /* CONFIG_MMU */
> +}
> -- 
> 2.32.0.554.ge1b32706d8-goog

-- 
Michal Hocko
SUSE Labs
