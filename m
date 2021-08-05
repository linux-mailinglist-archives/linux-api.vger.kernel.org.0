Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93803E1B6C
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbhHEShd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbhHEShd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 14:37:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF59C061765
        for <linux-api@vger.kernel.org>; Thu,  5 Aug 2021 11:37:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a201so10557726ybg.12
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNuZ1c9nREEnXSl8bt5cLKPIgLWVSMm+LixG9EWvnFY=;
        b=fsjk5vdqb3cLg2uKGgjO/Oe/tphZynj/18hayb1IAWVTXxV1DvuaXBFm1EImDNo6zG
         U2crnR5O94yydOGh6kl6NJNPtEeYyRu91x5tk/hM6WXOXNrGJXWB49+5eIGepgv5RYZb
         qwgsumpPs9gmmWEBIrOJjQuxoapXVPPkp8QNoIEh4hvdwfEv5rj7+ie3PBlnjOITHpuG
         gZDXiF9JacbaxGaUfHjFOyPQsBOZxQVJN2wcYzWytbeGqDaBevlbpvsTJIi+s8iI/eqU
         yYQA1hO44Fdb+OUrnT/TlH3H2vDiUg77roIEFz6bHk0BUp9H9R5Mj3dg9P9fw6ZymLM6
         urbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNuZ1c9nREEnXSl8bt5cLKPIgLWVSMm+LixG9EWvnFY=;
        b=dDa+Ts0etnalNd1DI1WrSdg/oAEat7Fgd9M067OOH+BDsLLBDqYQANjFnlf9//CKS4
         BqdnjK5nLgmXPl0MrOckStAcb5hsOMY/90c/7CaGNP4wTco3o9ZJGR8dp3wu2JfyzyV+
         jOSZPR4Uuovbq68ET55vdfLavLD4zo2uQ1dkNJaggLEH4Gsnd0WvkJP/u9hH5ZMtGpFp
         Cs4WFzDn4r2Q5RHcMhF+Iwlad9MhN94WfK3scqmIiHEZ6nVqpVnVsYXoRjf1utlSCUTG
         BuYcI5fpptQMjtzW/HnF73EGAs9Rcxj/JG3Vrh7AQ7qYOG2eSfogjvUX0gPGswiE8afv
         lsjw==
X-Gm-Message-State: AOAM533fQVHkqWctVeOgOsgqihd5QkogOS1phY9kvgXH8HIb7bDuGvqU
        LsYZhdhAqt63bFOKAX89rTa8a0fnwRQdw84ATqRhvw==
X-Google-Smtp-Source: ABdhPJzyMfY76OcuYfrzOxc0CqSwpbeqeRxrUs2YZeAuXHjdq5oFOm4vVWVKmrN4l8tpC0P+2z9roxxgQHZhkqtGw1s=
X-Received: by 2002:a25:14d6:: with SMTP id 205mr8415464ybu.250.1628188637501;
 Thu, 05 Aug 2021 11:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210805170859.2389276-1-surenb@google.com> <46998d10-d0ca-aeeb-8dcd-41b8130fb756@redhat.com>
 <CAJuCfpGvqgUWpdL_KNE1tnqH2OjqX64QjBYttoPRtGgXWfONRQ@mail.gmail.com> <CALvZod5ANyddJJVmyrzArH5Z--PAufpt1DyTgipQixbpe3Du7Q@mail.gmail.com>
In-Reply-To: <CALvZod5ANyddJJVmyrzArH5Z--PAufpt1DyTgipQixbpe3Du7Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Aug 2021 11:37:06 -0700
Message-ID: <CAJuCfpEgXh96WEpqn5aPE8mmmpW28j4KHoBkDQN-ob0vNOVHoQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Aug 5, 2021 at 10:56 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Aug 5, 2021 at 10:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Aug 5, 2021 at 10:29 AM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 05.08.21 19:08, Suren Baghdasaryan wrote:
> > > > In modern systems it's not unusual to have a system component monitoring
> > > > memory conditions of the system and tasked with keeping system memory
> > > > pressure under control. One way to accomplish that is to kill
> > > > non-essential processes to free up memory for more important ones.
> > > > Examples of this are Facebook's OOM killer daemon called oomd and
> > > > Android's low memory killer daemon called lmkd.
> > > > For such system component it's important to be able to free memory
> > > > quickly and efficiently. Unfortunately the time process takes to free
> > > > up its memory after receiving a SIGKILL might vary based on the state
> > > > of the process (uninterruptible sleep), size and OPP level of the core
> > > > the process is running. A mechanism to free resources of the target
> > > > process in a more predictable way would improve system's ability to
> > > > control its memory pressure.
> > > > Introduce process_mrelease system call that releases memory of a dying
> > > > process from the context of the caller. This way the memory is freed in
> > > > a more controllable way with CPU affinity and priority of the caller.
> > > > The workload of freeing the memory will also be charged to the caller.
> > > > The operation is allowed only on a dying process.
> > > >
> > > > After previous discussions [1, 2, 3] the decision was made [4] to introduce
> > > > a dedicated system call to cover this use case.
> > > >
> > > > The API is as follows,
> > > >
> > > >            int process_mrelease(int pidfd, unsigned int flags);
> > > >
> > > >          DESCRIPTION
> > > >            The process_mrelease() system call is used to free the memory of
> > > >            an exiting process.
> > > >
> > > >            The pidfd selects the process referred to by the PID file
> > > >            descriptor.
> > > >            (See pidfd_open(2) for further information)
> > > >
> > > >            The flags argument is reserved for future use; currently, this
> > > >            argument must be specified as 0.
> > > >
> > > >          RETURN VALUE
> > > >            On success, process_mrelease() returns 0. On error, -1 is
> > > >            returned and errno is set to indicate the error.
> > > >
> > > >          ERRORS
> > > >            EBADF  pidfd is not a valid PID file descriptor.
> > > >
> > > >            EAGAIN Failed to release part of the address space.
> > > >
> > > >            EINTR  The call was interrupted by a signal; see signal(7).
> > > >
> > > >            EINVAL flags is not 0.
> > > >
> > > >            EINVAL The memory of the task cannot be released because the
> > > >                   process is not exiting, the address space is shared
> > > >                   with another live process or there is a core dump in
> > > >                   progress.
> > > >
> > > >            ENOSYS This system call is not supported, for example, without
> > > >                   MMU support built into Linux.
> > > >
> > > >            ESRCH  The target process does not exist (i.e., it has terminated
> > > >                   and been waited on).
> > > >
> > > > [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> > > > [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> > > > [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> > > > [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > > changes in v7:
> > > > - Fixed pidfd_open misspelling, per Andrew Morton
> > > > - Fixed wrong task pinning after find_lock_task_mm() issue, per Michal Hocko
> > > > - Moved MMF_OOM_SKIP check before task_will_free_mem(), per Michal Hocko
> > > >
> > > >   mm/oom_kill.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 73 insertions(+)
> > > >
> > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > index c729a4c4a1ac..a4d917b43c73 100644
> > > > --- a/mm/oom_kill.c
> > > > +++ b/mm/oom_kill.c
> > > > @@ -28,6 +28,7 @@
> > > >   #include <linux/sched/task.h>
> > > >   #include <linux/sched/debug.h>
> > > >   #include <linux/swap.h>
> > > > +#include <linux/syscalls.h>
> > > >   #include <linux/timex.h>
> > > >   #include <linux/jiffies.h>
> > > >   #include <linux/cpuset.h>
> > > > @@ -1141,3 +1142,75 @@ void pagefault_out_of_memory(void)
> > > >       out_of_memory(&oc);
> > > >       mutex_unlock(&oom_lock);
> > > >   }
> > > > +
> > > > +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > > > +{
> > > > +#ifdef CONFIG_MMU
> > > > +     struct mm_struct *mm = NULL;
> > > > +     struct task_struct *task;
> > > > +     struct task_struct *p;
> > > > +     unsigned int f_flags;
> > > > +     struct pid *pid;
> > > > +     long ret = 0;
> > > > +
> > > > +     if (flags)
> > > > +             return -EINVAL;
> > > > +
> > > > +     pid = pidfd_get_pid(pidfd, &f_flags);
> > > > +     if (IS_ERR(pid))
> > > > +             return PTR_ERR(pid);
> > > > +
> > > > +     task = get_pid_task(pid, PIDTYPE_PID);
> > > > +     if (!task) {
> > > > +             ret = -ESRCH;
> > > > +             goto put_pid;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * If the task is dying and in the process of releasing its memory
> > > > +      * then get its mm.
> > > > +      */
> > > > +     p = find_lock_task_mm(task);
> > > > +     if (!p) {
> > > > +             ret = -ESRCH;
> > > > +             goto put_pid;
> > > > +     }
> > > > +     if (task != p) {
> > > > +             get_task_struct(p);
> > >
> > >
> > > Wouldn't we want to obtain the mm from p ? I thought that was the whole
> > > exercise of going via find_lock_task_mm().
> >
> > Yes, that's what we do after checking task_will_free_mem().
> > task_will_free_mem() requires us to hold task_lock and
> > find_lock_task_mm() achieves that ensuring that mm is still valid, but
> > it might return a task other than the original one. That's why we do
> > this dance with pinning the new task and unpinning the original one.
> > The same dance is performed in __oom_kill_process(). I was
> > contemplating adding a parameter to find_lock_task_mm() to request
> > this unpin/pin be done within that function but then decided to keep
> > it simple for now.
> > Did I address your question or did I misunderstand it?
> >
>
> One question I have is why mmget() and not mmgrab()? I see mmgrab() in
> oom_kill.c.

You are likely right here. The caller's context probably can't be
considered a "real user" when reaping the mm. However, we take an
mmap_lock shortly after, so not sure if in practice there is much
difference.
Michal, WDYT?
