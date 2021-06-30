Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05913B88AB
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhF3Sqi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhF3Sqg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 14:46:36 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBDC0617A8
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 11:44:06 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p15so6613774ybe.6
        for <linux-api@vger.kernel.org>; Wed, 30 Jun 2021 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIoChI/UV1Z7a7XrKG/VZSLZ/TPMwf39BXQMXIxOAwA=;
        b=btIXHyRiBkK956T8OwjWkekMNvzo/mZJOPFcrvBEKbeBejlWmlRMlznuchf2pWPWqe
         a9Ag692CKOfxzD8GcEQEhZ/3Jr9LS22bkN+lCYbP2wrWkSf2MsmKL4vpgoFibTmfwJ7H
         WFzEIGgzeQ191/Pt+a+5pUMDz7AToSI7RmYpEEpOhySN6UKbpUGg6FJzgKiotqZ0wfoE
         Z2pLW/YB01A6w0jwOMzklxNWBxb+4Iv3srIzg7zlfMxeQ8dentmx7j/x5pLBCq+TEp30
         dHGD2ns9TvW0TXws3V8QruPNTAt1lQT+kuX399Eg3WT2x5Px+0CSkxk2UwoGc4fN5w0A
         khMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIoChI/UV1Z7a7XrKG/VZSLZ/TPMwf39BXQMXIxOAwA=;
        b=JaYcbQUxd5/nT7HrucoCBFPVzf+1FGZWl1GRiMScwxFYQeSFfE3qIHfNITONav9hk0
         TDmAf10nPxrKla/XTHtsFUMBpQAVVTfYcXGKvlxFMEaWC0ER1YLpQr18yrJgFHZJfrq9
         iEZMlumt+VeHmwpoCbsr+3sOT8mfocspUafTc4kPEHYIDnGYz0T3U3Hkp0lLJAUItKYp
         4R1yq+38hR9rOC/kFllPHmFdUVFPFAqDjvyHYoSs6g/dMbXpC2jfrmIg/VTYvBC5M04t
         3gay1gzaEXaXRVZlb/YgSS7fEF7Tu6LPKcJ0cUwI8/BY/ke7ZzOCDmK4WjSX4C5V6L8/
         xPdQ==
X-Gm-Message-State: AOAM533iDAXnQDTPQQlaZnQnMidAGUXXnPIaFxQKDUdby2+WRkAwZAcn
        46PVqAMX31aRXxnnes8vVdbCryLBEDR5vTtJ86M/zQ==
X-Google-Smtp-Source: ABdhPJxsqqO39vuA3mf7rpViczVY8A/5U4GcNWz8KEEHm4mV92UeEkuUnoskpseoiZc3iaG2Xq6Wb09osZVU7EYQjpI=
X-Received: by 2002:a25:d913:: with SMTP id q19mr48066209ybg.397.1625078645669;
 Wed, 30 Jun 2021 11:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <CALvZod7GPeB6ArrU8oBPx-1NT-ZDBQzTiJHJDojjO2kAgALkHw@mail.gmail.com>
In-Reply-To: <CALvZod7GPeB6ArrU8oBPx-1NT-ZDBQzTiJHJDojjO2kAgALkHw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 30 Jun 2021 11:43:54 -0700
Message-ID: <CAJuCfpG4M=ZnqR9D9MPNB88nwWgQ9qA9Z9a6dymZ5abOxNucGg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Shakeel Butt <shakeelb@google.com>
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
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 30, 2021 at 11:01 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Hi Suren,
>
> On Wed, Jun 23, 2021 at 12:28 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
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
> > Introduce process_reap system call that reclaims memory of a dying process
> > from the context of the caller. This way the memory in freed in a more
> > controllable way with CPU affinity and priority of the caller. The workload
> > of freeing the memory will also be charged to the caller.
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
> >
> > The end of the last discussion culminated with suggestion to introduce a
> > dedicated system call (https://lore.kernel.org/patchwork/patch/1344418/#1553875)
> > The reasoning was that the new variant of process_madvise
> >   a) does not work on an address range
> >   b) is destructive
> >   c) doesn't share much code at all with the rest of process_madvise
> > From the userspace point of view it was awkward and inconvenient to provide
> > memory range for this operation that operates on the entire address space.
> > Using special flags or address values to specify the entire address space
> > was too hacky.
> >
> > The API is as follows,
> >
> >           int process_reap(int pidfd, unsigned int flags);
> >
> >         DESCRIPTION
> >           The process_reap() system call is used to free the memory of a
> >           dying process.
> >
> >           The pidfd selects the process referred to by the PID file
> >           descriptor.
> >           (See pidofd_open(2) for further information)
>
> *pidfd_open

Ack

>
> >
> >           The flags argument is reserved for future use; currently, this
> >           argument must be specified as 0.
> >
> >         RETURN VALUE
> >           On success, process_reap() returns 0. On error, -1 is returned
> >           and errno is set to indicate the error.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks for continuously pushing this. One question I have is how do
> you envision this syscall to be used for the cgroup based workloads.
> Traverse the target tree, read pids from cgroup.procs files,
> pidfd_open them, send SIGKILL and then process_reap them. Is that
> right?

Yes, at least that's how Android does that. It's a bit more involved
but it's a technical detail. Userspace low memory killer kills a
process (sends SIGKILL and calls process_reap) and another system
component detects that a process died and will kill all processes
belonging to the same cgroup (that's how we identify related
processes).

>
> Orthogonal to this patch I wonder if we should have an optimized way
> to reap processes from a cgroup. Something similar to cgroup.kill (or
> maybe overload cgroup.kill with reaping as well).

Seems reasonable to me. We could use that in the above scenario.

>
> [...]
>
> > +
> > +SYSCALL_DEFINE2(process_reap, int, pidfd, unsigned int, flags)
> > +{
> > +       struct pid *pid;
> > +       struct task_struct *task;
> > +       struct mm_struct *mm = NULL;
> > +       unsigned int f_flags;
> > +       long ret = 0;
> > +
> > +       if (flags != 0)
> > +               return -EINVAL;
> > +
> > +       pid = pidfd_get_pid(pidfd, &f_flags);
> > +       if (IS_ERR(pid))
> > +               return PTR_ERR(pid);
> > +
> > +       task = get_pid_task(pid, PIDTYPE_PID);
> > +       if (!task) {
> > +               ret = -ESRCH;
> > +               goto put_pid;
> > +       }
> > +
> > +       /*
> > +        * If the task is dying and in the process of releasing its memory
> > +        * then get its mm.
> > +        */
> > +       task_lock(task);
> > +       if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
>
> task_will_free_mem() is fine here but I think in parallel we should
> optimize this function. At the moment it is traversing all the
> processes on the machine. It is very normal to have tens of thousands
> of processes on big machines, so it would be really costly when
> reaping a bunch of processes.

Hmm. But I think we still need to make sure that the mm is not shared
with another non-dying process. IIUC that's the point of that
traversal. Am I mistaken?
