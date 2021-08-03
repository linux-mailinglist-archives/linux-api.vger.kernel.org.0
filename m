Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257D43DF743
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhHCWKI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 18:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhHCWKI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Aug 2021 18:10:08 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80854C061757
        for <linux-api@vger.kernel.org>; Tue,  3 Aug 2021 15:09:55 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id w17so1011002ybl.11
        for <linux-api@vger.kernel.org>; Tue, 03 Aug 2021 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FiAIaMy2C3duPSFo6M7ujpZbEN7hAllZgdmnRkqo6w=;
        b=vVjM6WashkbHD78Q7dI62gTPTYZh3xyul9cjLIOm7ASBkb5EvLaD+/U8ompMvFBmxN
         xe0Ll6jDyk2e2Uf5GIAThESVRTLjS10Su7BDD/phMLLQMdxjAMZdZ2qSj9/tKiWngymU
         IIUEwKYfZMONug9gYWV1tdnmrvPy2gnLYw5aWjC5wtu8if+nABdReDQX2v4SM4FCh/NS
         vXnwI0QppM+RM5gGwDox1KYEQpDFT0FdF//xhF7DzXprTyvoP5R9HJXGtVp65qpJdFpJ
         zGzxXsfY0WBSDwHb4mKfzAZeSmW7PEfB5zHQQ/H5LkFgJRyqoi+h0TIEN+8r7D8NVO13
         bXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FiAIaMy2C3duPSFo6M7ujpZbEN7hAllZgdmnRkqo6w=;
        b=F85PVjbHp/rCU9t4ejDevyao8RDMFjUe1MtrOL7FHz4UV+xe99tn/AAnLKDIKi9SDJ
         Qe+CfcVv6na1C7oy7CtY0ony2WUxjIIatGvFDDTsXbE1TpG8CHzwt3NHxTFjwDCcyGJ+
         mEkECIt2k/pQEiMhU80bWJEUAiXEaRVCAtbI/MUlHv6UD80NegaS14IVloqqRRuKZall
         7vRKc8LBkkd86fykTMQGmqTf3MB5a4/AUyNzV6O2ndcfSEuyYP76azoNcdqkAp+uVQ+q
         9BYd5TDdrKPWI+C1qGT6UhenSr824V/hO9cV7/TD5MDMBRgSXT23cjovmVafAK6vS281
         MS2g==
X-Gm-Message-State: AOAM530H6j4xunfAjxfhP4EzTWWLeM5kq71rmKIRIe3vi9HwItp1aeLz
        YkpBCSdV0Aad4UGo/qOImCsuKu0nVu+dFUytY3gB7Q==
X-Google-Smtp-Source: ABdhPJyGshMLYtVaVG5xK6igxtN1nsvJlI+CR/QJ1sJxl0p/Bb4EbVUZJ9xHTg+hAYJNjoZTnMShcj9hfWwjLbG/WTQ=
X-Received: by 2002:a25:bc2:: with SMTP id 185mr30284331ybl.23.1628028594501;
 Tue, 03 Aug 2021 15:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210802221431.2251210-1-surenb@google.com> <YQkAqwZIF+AnpexA@dhcp22.suse.cz>
 <CAJuCfpGiYAdvOydimHbK73oKS-ZfMMBtADXxWCYpxkX2qJX08g@mail.gmail.com>
In-Reply-To: <CAJuCfpGiYAdvOydimHbK73oKS-ZfMMBtADXxWCYpxkX2qJX08g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Aug 2021 15:09:43 -0700
Message-ID: <CAJuCfpEjb+o_TuQqxYALcvpr+4kq7tVNjq7A3oahB=1=JPyWtw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
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

On Tue, Aug 3, 2021 at 10:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Aug 3, 2021 at 1:39 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 02-08-21 15:14:30, Suren Baghdasaryan wrote:
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
> >
> > Please use the msg-id based urls https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
>
> Will do. Thanks!
>
> >
> > > pidfd_send_signal to allow memory reaping using oom_reaper thread;
> > > - https://lore.kernel.org/patchwork/patch/1338196 extending
> >
> > https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> >
> > > pidfd_send_signal to reap memory of the target process synchronously from
> > > the context of the caller;
> > > - https://lore.kernel.org/patchwork/patch/1344419/ to add MADV_DONTNEED
> > > support for process_madvise implementing synchronous memory reaping.
> >
> > https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> >
> > > The end of the last discussion culminated with suggestion to introduce a
> > > dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
> >
> > https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
> >
> > > The reasoning was that the new variant of process_madvise
> > >   a) does not work on an address range
> > >   b) is destructive
> > >   c) doesn't share much code at all with the rest of process_madvise
> > > >From the userspace point of view it was awkward and inconvenient to provide
> > > memory range for this operation that operates on the entire address space.
> > > Using special flags or address values to specify the entire address space
> > > was too hacky.
> > >
> > > The API is as follows,
> > >
> > >           int process_mrelease(int pidfd, unsigned int flags);
> > >
> > >         DESCRIPTION
> > >           The process_mrelease() system call is used to free the memory of
> > >           a process which was sent a SIGKILL signal.
> >
> > This is not really precise. The implementation will allow to use the
> > syscall on any exiting or fatal signal received process. Not just those
> > that have been SIGKILLed, right? For the purpose of the man page I would
> > go with exiting process for the wording.
>
> Ack.
>
> >
> > >           The pidfd selects the process referred to by the PID file
> > >           descriptor.
> > >           (See pidofd_open(2) for further information)
> > >
> > >           The flags argument is reserved for future use; currently, this
> > >           argument must be specified as 0.
> > >
> > >         RETURN VALUE
> > >           On success, process_mrelease() returns 0. On error, -1 is
> > >           returned and errno is set to indicate the error.
> > >
> > >         ERRORS
> > >           EBADF  pidfd is not a valid PID file descriptor.
> > >
> > >           EAGAIN Failed to release part of the address space.
> > >
> > >           EINTR  The call was interrupted by a signal; see signal(7).
> > >
> > >           EINVAL flags is not 0.
> > >
> > >           EINVAL The task does not have a pending SIGKILL or its memory is
> > >                  shared with another process with no pending SIGKILL.
> >
> > again, wording here. I would go with
> >             EINVAL The memory of the task cannot be released because the
> >                    process is not exiting, the address space is shared
> >                    with an alive process or there is a core dump is in
> >                    progress..
>
> Ack.
>
> > >
> > >           ENOSYS This system call is not supported by kernels built with no
> > >                  MMU support (CONFIG_MMU=n).
> > >
> > >           ESRCH  The target process does not exist (i.e., it has terminated
> > >                  and been waited on).
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > > changes in v4:
> > > - Replaced mmap_read_lock() with mmap_read_lock_killable(), per Michal Hocko
> > > - Added EINTR error in the manual pages documentation
> > >
> > >  mm/oom_kill.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 58 insertions(+)
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index c729a4c4a1ac..86727794b0a8 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/sched/task.h>
> > >  #include <linux/sched/debug.h>
> > >  #include <linux/swap.h>
> > > +#include <linux/syscalls.h>
> > >  #include <linux/timex.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/cpuset.h>
> > > @@ -1141,3 +1142,60 @@ void pagefault_out_of_memory(void)
> > >       out_of_memory(&oc);
> > >       mutex_unlock(&oom_lock);
> > >  }
> > > +
> > > +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > > +{
> > > +#ifdef CONFIG_MMU
> > > +     struct mm_struct *mm = NULL;
> > > +     struct task_struct *task;
> > > +     unsigned int f_flags;
> > > +     struct pid *pid;
> > > +     long ret = 0;
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
> >
> > Don't we need find_lock_task_mm here?
>
> Yes, we do. Will fix in the next rev.
>
> >
> > > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> > > +             mm = task->mm;
> > > +             mmget(mm);
> > > +     }
> > > +     task_unlock(task);
> > > +     if (!mm) {
> >
> > Do we want to treat MMF_OOM_SKIP as a failure?
>
> Yeah, I don't think we want to create additional contention if
> oom-killer is already working on this mm. Should we return EBUSY in
> this case? Other possible options is ESRCH, indicating that this
> process is a goner, so don't bother. WDYT?

After considering this some more I think ESRCH would be more
appropriate. EBUSY might be understood as "I need to retry at a better
time", which is not what we want here.
I posted v5 at https://lore.kernel.org/patchwork/patch/1471926 with
suggested changes.
Thanks,
Suren.

>
> >
> > > +             ret = -EINVAL;
> > > +             goto put_task;
> > > +     }
> > > +
> > > +     if (mmap_read_lock_killable(mm)) {
> > > +             ret = -EINTR;
> > > +             goto put_mm;
> > > +     }
> > > +     if (!__oom_reap_task_mm(mm))
> > > +             ret = -EAGAIN;
> > > +     mmap_read_unlock(mm);
> > > +
> > > +put_mm:
> > > +     mmput(mm);
> > > +put_task:
> > > +     put_task_struct(task);
> > > +put_pid:
> > > +     put_pid(pid);
> > > +     return ret;
> > > +#else
> > > +     return -ENOSYS;
> > > +#endif /* CONFIG_MMU */
> > > +}
> > > --
> > > 2.32.0.554.ge1b32706d8-goog
> >
>
> Thanks for the review!
>
> > --
> > Michal Hocko
> > SUSE Labs
