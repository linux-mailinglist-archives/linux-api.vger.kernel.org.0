Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23653D12B3
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhGUPC5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbhGUPCz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 11:02:55 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A86C061575
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 08:43:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i18so3812898yba.13
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSQuChGU6tQxqfm5TWusep8hq6ZmIB+zOQ9/zhsm9m0=;
        b=RLnulxEIKc6/HHiZPGnMsW/NWTGGd+/02XHxpoueIRWPlwZcUimrZ71r6IThuWxOXg
         75KNKayV2leW/+yS0L4WBHTKpKY4j1WS52QVEg124GIyUeTj6KzIJco4wRwNGmCyJ4Tv
         vi1oSDfpMZTvOEsY7+ixaGnwfvhJwtNjI5sW34qUnmEaXNUr6I9zozPSGkd3uUPfybUy
         1whWB2HJyFVLi9nb7TbW2pwIG51esbwS1i32iCl5PtaBmjZInP4f9CabTblWM8gDe0/1
         eA4LN4i+dtFecOnHVR1jDRwZAf4wpZpoTupMnRanwXgdBLm7KwfAnfyX7FPam37v0FyK
         km5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSQuChGU6tQxqfm5TWusep8hq6ZmIB+zOQ9/zhsm9m0=;
        b=eLXBuVzVJLkJd0GMU7g19lPwaw0jkAXoKzvc31imkH99gjMK3kQ0AfdlVkfCSxEz8r
         qEI6AiWZyE26d83oAGfUM90cNZnDRzTh65YyQKLoSADHSVjv4wRCcl0J1QiCl5Z9bBpa
         idskBHfEC2HMYPyHNdgLGylfVVw930/mXGaz06ncuIjlGrjDNGv/0w1M17mcvyFy0Ice
         PiME5iPar2I1zicuFTYHMPfGkQM9bYVgYIhpvZvBAaI/mNRnlNREkldd/e+UkL7YcMjB
         o+H30b6RlVAk9nBgGcpNY1kXjDgcTzQuynH+97KoAp4yx/0I8Xth3EBiaQbNJUQgYmx0
         FgbQ==
X-Gm-Message-State: AOAM530F7pLjHXpc2jP3lyIbYfnKkLHeFhx0O3/5Xhkxg+HUmmapHmH9
        X7DPlvQESlK/aY3toPN44wRpz00Qo/aRgro/megdDw==
X-Google-Smtp-Source: ABdhPJzM/OQSfrNn9MjFL2p5RV9t3hMxfHHij+8DcfFovPESSzpJ5AdB4Nl0Gw/KVUh6Vbgch08Axn4qft8+xWhpwGo=
X-Received: by 2002:a25:83ca:: with SMTP id v10mr47053164ybm.84.1626882210451;
 Wed, 21 Jul 2021 08:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <20210718214134.2619099-2-surenb@google.com>
 <6ab82426-ddbd-7937-3334-468f16ceedab@redhat.com>
In-Reply-To: <6ab82426-ddbd-7937-3334-468f16ceedab@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Jul 2021 08:43:18 -0700
Message-ID: <CAJuCfpEGexDf0=Lfc66d8puUOf5FXxO3aUWffMhRFLPsiYs91A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: introduce process_mrelease system call
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 21, 2021 at 1:02 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 18.07.21 23:41, Suren Baghdasaryan wrote:
> > In modern systems it's not unusual to have a system component monitoring
> > memory conditions of the system and tasked with keeping system memory
> > pressure under control. One way to accomplish that is to kill
> > non-essential processes to free up memory for more important ones.
> > Examples of this are Facebook's OOM killer daemon called oomd and
> > Android's low memory killer daemon called lmkd.
> > For such system component it's important to be able to free memory
> > quickly and efficiently. Unfortunately the time process takes to free
> > up its memory after receiving a SIGKILL might vary based on the state
> > of the process (uninterruptible sleep), size and OPP level of the core
> > the process is running. A mechanism to free resources of the target
> > process in a more predictable way would improve system's ability to
> > control its memory pressure.
> > Introduce process_mrelease system call that releases memory of a dying
> > process from the context of the caller. This way the memory is freed in
> > a more controllable way with CPU affinity and priority of the caller.
> > The workload of freeing the memory will also be charged to the caller.
> > The operation is allowed only on a dying process.
> >
> > Previously I proposed a number of alternatives to accomplish this:
> > - https://lore.kernel.org/patchwork/patch/1060407 extending
> > pidfd_send_signal to allow memory reaping using oom_reaper thread;
> > - https://lore.kernel.org/patchwork/patch/1338196 extending
> > pidfd_send_signal to reap memory of the target process synchronously from
> > the context of the caller;
> > - https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
> > support for process_madvise implementing synchronous memory reaping.
>
> To me, this looks a lot cleaner. Although I do wonder why we need two
> separate mechanisms to achieve the end goal
>
> 1. send sigkill
> 2. process_mrelease
>
> As 2. doesn't make sense without 1. it somehow feels like it would be
> optimal to achieve both steps in a single syscall. But I remember there
> were discussions around that.

Yep, we recently discussed the approach in this thread:
https://lore.kernel.org/patchwork/patch/1450952/#1652452

>
> >
> > The end of the last discussion culminated with suggestion to introduce a
> > dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
> > The reasoning was that the new variant of process_madvise
> >    a) does not work on an address range
> >    b) is destructive
> >    c) doesn't share much code at all with the rest of process_madvise
> >  From the userspace point of view it was awkward and inconvenient to provide
> > memory range for this operation that operates on the entire address space.
> > Using special flags or address values to specify the entire address space
> > was too hacky.
> >
> > The API is as follows,
> >
> >            int process_mrelease(int pidfd, unsigned int flags);
> >
> >          DESCRIPTION
> >            The process_mrelease() system call is used to free the memory of
> >            a process which was sent a SIGKILL signal.
> >
> >            The pidfd selects the process referred to by the PID file
> >            descriptor.
> >            (See pidofd_open(2) for further information)
> >
> >            The flags argument is reserved for future use; currently, this
> >            argument must be specified as 0.
> >
> >          RETURN VALUE
> >            On success, process_mrelease() returns 0. On error, -1 is
> >            returned and errno is set to indicate the error.
> >
> >          ERRORS
> >            EBADF  pidfd is not a valid PID file descriptor.
> >
> >            EAGAIN Failed to release part of the address space.
> >
> >            EINVAL flags is not 0.
> >
> >            EINVAL The task does not have a pending SIGKILL or its memory is
> >                   shared with another process with no pending SIGKILL.
> >
> >            ENOSYS This system call is not supported by kernels built with no
> >                   MMU support (CONFIG_MMU=n).
> >
> >            ESRCH  The target process does not exist (i.e., it has terminated
> >                   and been waited on).
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   mm/oom_kill.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 55 insertions(+)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index d04a13dc9fde..7fbfa70d4e97 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -28,6 +28,7 @@
> >   #include <linux/sched/task.h>
> >   #include <linux/sched/debug.h>
> >   #include <linux/swap.h>
> > +#include <linux/syscalls.h>
> >   #include <linux/timex.h>
> >   #include <linux/jiffies.h>
> >   #include <linux/cpuset.h>
> > @@ -755,10 +756,64 @@ static int __init oom_init(void)
> >       return 0;
> >   }
> >   subsys_initcall(oom_init)
> > +
> > +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > +{
> > +     struct pid *pid;
> > +     struct task_struct *task;
> > +     struct mm_struct *mm = NULL;
> > +     unsigned int f_flags;
> > +     long ret = 0;
>
> Nit: reverse Christmas tree.

Ack. Will reorder like this:

struct mm_struct *mm = NULL;
struct task_struct *task;
unsigned int f_flags;
struct pid *pid;
long ret = 0;

>
> > +
> > +     if (flags != 0)
> > +             return -EINVAL;
> > +
> > +     pid = pidfd_get_pid(pidfd, &f_flags);
> > +     if (IS_ERR(pid))
> > +             return PTR_ERR(pid);
> > +
> > +     task = get_pid_task(pid, PIDTYPE_PID);
> > +     if (!task) {
> > +             ret = -ESRCH;
> > +             goto put_pid;
> > +     }
> > +
> > +     /*
> > +      * If the task is dying and in the process of releasing its memory
> > +      * then get its mm.
> > +      */
> > +     task_lock(task);
> > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> > +             mm = task->mm;
> > +             mmget(mm);
> > +     }
>
> AFAIU, while holding the task_lock, task->mm won't change and we cannot
> see a concurrent exit_mm()->mmput(). So the mm structure and the VMAs
> won't go away while holding the task_lock(). I do wonder if we need the
> mmget() at all here.
>
> Also, I wonder if it would be worth dropping the task_lock() while
> reaping - to unblock anybody else wanting to lock the task. Getting a
> hold of the mm and locking the mmap_lock would be sufficient I guess.

Let me take a closer look at the locking sequence here and will follow
up afterwards.
Thanks for the review!

>
>
> In general, looks quite good to me.
>
> --
> Thanks,
>
> David / dhildenb
>
