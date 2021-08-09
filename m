Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB33E451A
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhHILzl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 07:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhHILzl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 9 Aug 2021 07:55:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB3C260F55;
        Mon,  9 Aug 2021 11:55:15 +0000 (UTC)
Date:   Mon, 9 Aug 2021 13:55:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 1/2] mm: introduce process_mrelease system call
Message-ID: <20210809115512.hdpj2cxqkmd3myee@wittgenstein>
References: <20210808160823.3553954-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210808160823.3553954-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 08, 2021 at 09:08:22AM -0700, Suren Baghdasaryan wrote:
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
> After previous discussions [1, 2, 3] the decision was made [4] to introduce
> a dedicated system call to cover this use case.
> 
> The API is as follows,
> 
>           int process_mrelease(int pidfd, unsigned int flags);
> 
>         DESCRIPTION
>           The process_mrelease() system call is used to free the memory of
>           an exiting process.
> 
>           The pidfd selects the process referred to by the PID file
>           descriptor.
>           (See pidfd_open(2) for further information)
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
>           EINVAL The memory of the task cannot be released because the
>                  process is not exiting, the address space is shared
>                  with another live process or there is a core dump in
>                  progress.
> 
>           ENOSYS This system call is not supported, for example, without
>                  MMU support built into Linux.
> 
>           ESRCH  The target process does not exist (i.e., it has terminated
>                  and been waited on).
> 
> [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
> 
> Link: https://lore.kernel.org/r/20210808160823.3553954-1-surenb@google.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> changes in v8:
> - Replaced mmget with mmgrab, per Shakeel Butt
> - Refactored the code to simplify and fix the task_lock release issue,
> per Michal Hocko
> 
>  mm/oom_kill.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c729a4c4a1ac..f8acc26f7300 100644
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
> @@ -1141,3 +1142,72 @@ void pagefault_out_of_memory(void)
>  	out_of_memory(&oc);
>  	mutex_unlock(&oom_lock);
>  }
> +
> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = NULL;
> +	struct task_struct *task;
> +	struct task_struct *p;
> +	unsigned int f_flags;
> +	bool reap = true;
> +	struct pid *pid;
> +	long ret = 0;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd, &f_flags);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);

Technically, we really want PIDTYPE_TGID here. Currently, a pidfd can't
be created for a thread that isn't a thread-group leader. And while we
do make sure that when a pidfd is created the thread is a thread-group
leader, i.e. has a PIDTYPE_TGID entry in its struct pid we might in the
future not carry this restriction and will allow pidfds to refer to a
single thread. When we do that we need to take a good look at all users
carefully. So I'd prefer if this is changed to

task = get_pid_task(pid, PIDTYPE_TGID);

to clearly express that the assumption is that this is a thread-group
leader.

Otherwise,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
