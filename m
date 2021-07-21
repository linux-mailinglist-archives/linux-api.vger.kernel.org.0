Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B13D1A10
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGUWSl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 18:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGUWSk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 18:18:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E7C061575
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 15:59:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v189so1700325ybg.3
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dwxVRcNkN7Kn6Ao7jrDfweXBuqFRProuph1jkdsgR0=;
        b=j/+JjdRwnShpGM6r3Al+598YIV7XWN2RZmLcvd42dfXfMcpmDLYDR2nc3GQT7Vr9p5
         efFAB9i40J5LblI0W2ugC4KR9wbVs3RBpPt/Fr9eI9raJTXjBNmWzcW4+FXT1qVlh0z6
         hTrrV12yT64eO1L2VhoXFAehv/liLzHkMqjhX6DYucjQlJrdToNi2aRqg7a0bUuRvD0z
         cc8SPIvpp/5HbDPdAuPgPNqtjP690EsinwaSB+WtAhGjZe9Sfr1Mgf8oGpUaRcpGklnV
         ZIomwa4dg5E8/1PcbkfI1CfYRJjpr3laNhjcFAvwCdHw8zPunqdz9PChQ5miFov/aZvB
         uBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dwxVRcNkN7Kn6Ao7jrDfweXBuqFRProuph1jkdsgR0=;
        b=bYgIdT/hfUoKYOaIUXMbJfoyjIH4rEiLre1IhA643fNHBH/eUsXVp1KJKD70oLWe7h
         K+zvSO9jrAPEApsyAHgfeFKeZffNnSLvyJnA57Psvy2A/a0xNbDbkb14A+Z+++BYXs6X
         MK/QzTIaRL4SfaFV4ujLUbSDgGnb0J6NaHN7dQXISBlSMBvwmb69tLBkUjk/wpby+txR
         zwhquOV7tLgn06YsYdfn/JARa/CHPZjMUH75O9d2zOxxVT4FNUu7O/8RBlAN5VQ32+eN
         3RTZwTsDZXIyNBg2u8iYUiQAbh2Jm4Jy7gMPUKfa3YdCMq+x8uR7cRGle4KcGS6hvAPW
         v20w==
X-Gm-Message-State: AOAM532Gtcw3WcwTx8S75twcGc3rAT7an6rZLqE7nADNbpRNmyyAM8jS
        bh3iMOp10a+SMolpWYRokSiL9epO5FBaepsD+dFhJA==
X-Google-Smtp-Source: ABdhPJwPew/QlG/QdMpfIAldcZ6LbgkHdbIJPlxvO+OzU2VGnY9bbAj9isXfNtN6ohi/Xr9O0YCcCgTVoaxj5LfcPGc=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr50641996ybn.250.1626908354832;
 Wed, 21 Jul 2021 15:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <20210718214134.2619099-2-surenb@google.com>
 <6ab82426-ddbd-7937-3334-468f16ceedab@redhat.com> <CAJuCfpEGexDf0=Lfc66d8puUOf5FXxO3aUWffMhRFLPsiYs91A@mail.gmail.com>
In-Reply-To: <CAJuCfpEGexDf0=Lfc66d8puUOf5FXxO3aUWffMhRFLPsiYs91A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Jul 2021 15:59:03 -0700
Message-ID: <CAJuCfpHWTA+bGfg=aaRzmiszpo1pphJDL2T7=XSzzjfekSgW8w@mail.gmail.com>
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

On Wed, Jul 21, 2021 at 8:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Jul 21, 2021 at 1:02 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 18.07.21 23:41, Suren Baghdasaryan wrote:
> > > In modern systems it's not unusual to have a system component monitoring
> > > memory conditions of the system and tasked with keeping system memory
> > > pressure under control. One way to accomplish that is to kill
> > > non-essential processes to free up memory for more important ones.
> > > Examples of this are Facebook's OOM killer daemon called oomd and
> > > Android's low memory killer daemon called lmkd.
> > > For such system component it's important to be able to free memory
> > > quickly and efficiently. Unfortunately the time process takes to free
> > > up its memory after receiving a SIGKILL might vary based on the state
> > > of the process (uninterruptible sleep), size and OPP level of the core
> > > the process is running. A mechanism to free resources of the target
> > > process in a more predictable way would improve system's ability to
> > > control its memory pressure.
> > > Introduce process_mrelease system call that releases memory of a dying
> > > process from the context of the caller. This way the memory is freed in
> > > a more controllable way with CPU affinity and priority of the caller.
> > > The workload of freeing the memory will also be charged to the caller.
> > > The operation is allowed only on a dying process.
> > >
> > > Previously I proposed a number of alternatives to accomplish this:
> > > - https://lore.kernel.org/patchwork/patch/1060407 extending
> > > pidfd_send_signal to allow memory reaping using oom_reaper thread;
> > > - https://lore.kernel.org/patchwork/patch/1338196 extending
> > > pidfd_send_signal to reap memory of the target process synchronously from
> > > the context of the caller;
> > > - https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
> > > support for process_madvise implementing synchronous memory reaping.
> >
> > To me, this looks a lot cleaner. Although I do wonder why we need two
> > separate mechanisms to achieve the end goal
> >
> > 1. send sigkill
> > 2. process_mrelease
> >
> > As 2. doesn't make sense without 1. it somehow feels like it would be
> > optimal to achieve both steps in a single syscall. But I remember there
> > were discussions around that.
>
> Yep, we recently discussed the approach in this thread:
> https://lore.kernel.org/patchwork/patch/1450952/#1652452
>
> >
> > >
> > > The end of the last discussion culminated with suggestion to introduce a
> > > dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
> > > The reasoning was that the new variant of process_madvise
> > >    a) does not work on an address range
> > >    b) is destructive
> > >    c) doesn't share much code at all with the rest of process_madvise
> > >  From the userspace point of view it was awkward and inconvenient to provide
> > > memory range for this operation that operates on the entire address space.
> > > Using special flags or address values to specify the entire address space
> > > was too hacky.
> > >
> > > The API is as follows,
> > >
> > >            int process_mrelease(int pidfd, unsigned int flags);
> > >
> > >          DESCRIPTION
> > >            The process_mrelease() system call is used to free the memory of
> > >            a process which was sent a SIGKILL signal.
> > >
> > >            The pidfd selects the process referred to by the PID file
> > >            descriptor.
> > >            (See pidofd_open(2) for further information)
> > >
> > >            The flags argument is reserved for future use; currently, this
> > >            argument must be specified as 0.
> > >
> > >          RETURN VALUE
> > >            On success, process_mrelease() returns 0. On error, -1 is
> > >            returned and errno is set to indicate the error.
> > >
> > >          ERRORS
> > >            EBADF  pidfd is not a valid PID file descriptor.
> > >
> > >            EAGAIN Failed to release part of the address space.
> > >
> > >            EINVAL flags is not 0.
> > >
> > >            EINVAL The task does not have a pending SIGKILL or its memory is
> > >                   shared with another process with no pending SIGKILL.
> > >
> > >            ENOSYS This system call is not supported by kernels built with no
> > >                   MMU support (CONFIG_MMU=n).
> > >
> > >            ESRCH  The target process does not exist (i.e., it has terminated
> > >                   and been waited on).
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >   mm/oom_kill.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 55 insertions(+)
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index d04a13dc9fde..7fbfa70d4e97 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -28,6 +28,7 @@
> > >   #include <linux/sched/task.h>
> > >   #include <linux/sched/debug.h>
> > >   #include <linux/swap.h>
> > > +#include <linux/syscalls.h>
> > >   #include <linux/timex.h>
> > >   #include <linux/jiffies.h>
> > >   #include <linux/cpuset.h>
> > > @@ -755,10 +756,64 @@ static int __init oom_init(void)
> > >       return 0;
> > >   }
> > >   subsys_initcall(oom_init)
> > > +
> > > +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > > +{
> > > +     struct pid *pid;
> > > +     struct task_struct *task;
> > > +     struct mm_struct *mm = NULL;
> > > +     unsigned int f_flags;
> > > +     long ret = 0;
> >
> > Nit: reverse Christmas tree.
>
> Ack. Will reorder like this:
>
> struct mm_struct *mm = NULL;
> struct task_struct *task;
> unsigned int f_flags;
> struct pid *pid;
> long ret = 0;
>
> >
> > > +
> > > +     if (flags != 0)
> > > +             return -EINVAL;
> > > +
> > > +     pid = pidfd_get_pid(pidfd, &f_flags);
> > > +     if (IS_ERR(pid))
> > > +             return PTR_ERR(pid);
> > > +
> > > +     task = get_pid_task(pid, PIDTYPE_PID);
> > > +     if (!task) {
> > > +             ret = -ESRCH;
> > > +             goto put_pid;
> > > +     }
> > > +
> > > +     /*
> > > +      * If the task is dying and in the process of releasing its memory
> > > +      * then get its mm.
> > > +      */
> > > +     task_lock(task);
> > > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> > > +             mm = task->mm;
> > > +             mmget(mm);
> > > +     }
> >
> > AFAIU, while holding the task_lock, task->mm won't change and we cannot
> > see a concurrent exit_mm()->mmput(). So the mm structure and the VMAs
> > won't go away while holding the task_lock(). I do wonder if we need the
> > mmget() at all here.

We do mmget() here to ensure mm is stable when it is passed later to
__oom_reap_task_mm(mm)/mmap_read_lock(mm)/mmap_read_unlock(mm). Note
that during those calls we do not hold task_lock anymore.

> >
> > Also, I wonder if it would be worth dropping the task_lock() while
> > reaping - to unblock anybody else wanting to lock the task.

As I mentioned above, we do not hold task_lock during reaping. We
release it right after we call task_will_free_mem(), which checks that
the task is exiting. task_lock is held during the call to
task_will_free_mem() to satisfy the requirement listed in that
function's comment: "Caller has to make sure that task->mm is stable
(hold task_lock or it operates on the current)".

> > Getting a hold of the mm and locking the mmap_lock would be sufficient I guess.

That's exactly what I do here. The simplified sequence is:

       task_lock
       if (task_will_free_mem())
               mm=mmget()
       task_unlock
       if (!mm) return;

       mmap_read_lock(mm)
       __oom_reap_task_mm(mm)
       mmap_read_unlock(mm)
       mmput(mm)

Or did I misunderstand your comments?

>
> Let me take a closer look at the locking sequence here and will follow
> up afterwards.
> Thanks for the review!
>
> >
> >
> > In general, looks quite good to me.
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
