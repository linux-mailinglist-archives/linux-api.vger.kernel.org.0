Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB13DF3D1
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhHCRT1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbhHCRT0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Aug 2021 13:19:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC5C061757
        for <linux-api@vger.kernel.org>; Tue,  3 Aug 2021 10:19:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p145so20353927ybg.6
        for <linux-api@vger.kernel.org>; Tue, 03 Aug 2021 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ease6Bm6+dYO/uI5+kt9cx0YuwGkjF//n2DwGz99/N8=;
        b=TKDsSCcLpNBZT1j0QmGrbeKuBdTl/zfuIZXU6+MkSTkD7Ahdq5p9NgaW7hh9Cp99l2
         MS2VP4Gj46jIc3wOwMJUGT02Otc+5TQui50zqeXhcAvOSZNoxd7kOQCZqb+g9GnTto5W
         j2wylHxy7k5LkGkku8iHp/tUK/0w3ASWtR/IkF/XruCEOrGJPymWtUy/GZzHRmNNN6LY
         X8WVAs4CJywuFTQ70SvMhrLia7ri0lqA+vMNT6Oc2OMVRUpU6up9F+lt4AY9aakKalvN
         PCOdJXGAhDX/O+/egvR8DDnb6AjysMtWl6SK73TybIfBrJ/kh+eyxdQvP1BN1j9ax8Rk
         5emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ease6Bm6+dYO/uI5+kt9cx0YuwGkjF//n2DwGz99/N8=;
        b=aSooHX+8KHwN8UZEWElvDY/tVPYWuHH0hTVac4KLKvywYiOHXugICH1iss3+mw0Dvf
         sde2q5BDp64TqW9cb5OKLGG5h8Xkehug8P8Wlfa2izsvOg8HGpwyYqF0lVdE53Vupbg9
         e5mqLaGhtRZc2aOnN6XfKdYJKe1hCwke26/sURpTcbKhz+1Fvmvh2rEiwifYeAyQzBEF
         WmrILT/h0yABcks5q8zj3DR/Dytr8uqqyRR1iCrLm2tCaverkWx+gYSZu4zQuPuDJEsJ
         3JGZVdMxDtmw+6YiW0oeepe4lQlmQUSL2vVfet5TR7AToH2HH8zvF+puEx+pVcYvltUk
         4bsg==
X-Gm-Message-State: AOAM532UzhiURiLqIYUL4/8dREB6tTZv1Vau4zWKlPeSM/5KOXwX73l6
        T8ik3fzle3vYxBbraT+28mt7nOal0617Y2I7hg/zsg==
X-Google-Smtp-Source: ABdhPJxJ9Go27O6MYURKg3BsXlQyfpQgLOUbfQkaxflJgO/w1vwhSpIZOsObpoFRTdH7vsAUwJroozpS36h0i4WrMrk=
X-Received: by 2002:a25:49c2:: with SMTP id w185mr26981788yba.294.1628011151536;
 Tue, 03 Aug 2021 10:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210802221431.2251210-1-surenb@google.com> <95eff329-a7b1-dc2d-026c-fd61e476c846@redhat.com>
In-Reply-To: <95eff329-a7b1-dc2d-026c-fd61e476c846@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Aug 2021 10:19:00 -0700
Message-ID: <CAJuCfpFU++hzqA=ouy+G39agC0dymntadOJfLDzKC25fwM6z3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: introduce process_mrelease system call
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

On Tue, Aug 3, 2021 at 12:48 AM David Hildenbrand <david@redhat.com> wrote:
>
> [...]
>
> > Previously I proposed a number of alternatives to accomplish this:
> > - https://lore.kernel.org/patchwork/patch/1060407 extending
>
> I have no idea how stable these links are. Referencing via message id is
> the common practice. For this link, we'd use
>
> https://lkml.kernel.org/r/20190411014353.113252-3-surenb@google.com/
>
> instead.

Ack.

>
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
> >    a) does not work on an address range
> >    b) is destructive
> >    c) doesn't share much code at all with the rest of process_madvise
> >  From the userspace point of view it was awkward and inconvenient to provide
> > memory range for this operation that operates on the entire address space.
> > Using special flags or address values to specify the entire address space
> > was too hacky.
>
> I'd condense this description and only reference previous discussions to
> put a main focus on what this patch actually does. Like
>
> "
> After previous discussions [1, 2, 3] the decision was made to introduce
> a dedicated system call to cover this use case.
>
> ...
>
> [1] https://lkml.kernel.org/r/20190411014353.113252-3-surenb@google.com/
> "
>

Ack.

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
> >            EINTR  The call was interrupted by a signal; see signal(7).
> >
> >            EINVAL flags is not 0.
> >
> >            EINVAL The task does not have a pending SIGKILL or its memory is
> >                   shared with another process with no pending SIGKILL.
>
> Hm, I do wonder if it would make sense to have a mode (e.g., via a flag)
> to reap all but shared memory from a dying process. Future work.

Agree. Let's keep it simple for now and will expand when the need arises.

>
> >
> >            ENOSYS This system call is not supported by kernels built with no
> >                   MMU support (CONFIG_MMU=n).
>
> Maybe "This system call is not supported, for example, without MMU
> support built into Linux."

Ack.

>
> >
> >            ESRCH  The target process does not exist (i.e., it has terminated
> >                   and been waited on).
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > changes in v4:
> > - Replaced mmap_read_lock() with mmap_read_lock_killable(), per Michal Hocko
> > - Added EINTR error in the manual pages documentation
> >
> >   mm/oom_kill.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 58 insertions(+)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index c729a4c4a1ac..86727794b0a8 100644
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
> > @@ -1141,3 +1142,60 @@ void pagefault_out_of_memory(void)
> >       out_of_memory(&oc);
> >       mutex_unlock(&oom_lock);
> >   }
> > +
> > +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > +{
> > +#ifdef CONFIG_MMU
> > +     struct mm_struct *mm = NULL;
> > +     struct task_struct *task;
> > +     unsigned int f_flags;
> > +     struct pid *pid;
> > +     long ret = 0;
> > +
> > +     if (flags != 0)
>
> if (flags)

Ack.

>
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
> > +     task_unlock(task);
> > +     if (!mm) {
> > +             ret = -EINVAL;
> > +             goto put_task;
> > +     }
> > +
> > +     if (mmap_read_lock_killable(mm)) {
> > +             ret = -EINTR;
> > +             goto put_mm;
> > +     }
> > +     if (!__oom_reap_task_mm(mm))
> > +             ret = -EAGAIN;
>
> I'm not an expert on __oom_reap_task_mm(), but the whole approach makes
> sense to. So feel free to add my
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks! I see Michal also asked for some documentation changes and a
simple code change, so I won't roll your Acked-by automatically into
the next version but would appreciate it on the final version :)
Will post the next rev later today or tomorrow morning.
Thanks for the review!

>
> --
> Thanks,
>
> David / dhildenb
>
