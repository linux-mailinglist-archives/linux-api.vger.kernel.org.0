Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9AD1763C6
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCBTXd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 14:23:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45161 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBTXd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 14:23:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so158823pls.12;
        Mon, 02 Mar 2020 11:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fX2Aei7xiQwIHHM7cuDD9mmHopxJvdd5QvDnEUqFw38=;
        b=H/3CJ6rT+2Wsfz9ESdDWi3Xs8JbHfqLCzsju/DeoR106JaCeVs3NPpedySWUJCcWcG
         1QrBZZcPlfz78ukYB6jDtkYs2dBXky/ZzXD9UePnBGnrxu1qkPkSby6zc/c5dx3NgTz4
         Hrle3AckDUi+BagbjBdxOeQsMNibcwBAJ2j4rKro+2y2fx101FEpkBGsG+0/RSuPgdzR
         tTOIshi3WMwtaMzG2cqpUUd4NUV5NR/QoDboCimIxFPZJNmik39gSE4dfSDDh79cGwdK
         s88conD3d8G/SnDTJWBOgr/BAVwgk0CjL8UuVJMOAR/nrhxelZSwrnPrN6Oexxspzdiy
         vRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fX2Aei7xiQwIHHM7cuDD9mmHopxJvdd5QvDnEUqFw38=;
        b=HI97ZBtFEXnIAfA3DoEsUp7GccYgu2PKSqRk4eewMCPs9drKSWqZBbA5yodyDDF5lK
         L9KL1WqMezS08OhfmM/ERfZh5kJv2FJHPjKpuSZKJACuYyts6bbfSiG14KxGbjcXVrz9
         VT+Mn+CxY1DVGZG8x+J+ksE7WuB4PUUjEqIkFGVFiD1nGcHhyZFV5OGAibIsba3DdnLv
         PEYwzFGYnAssWjjS6x90xytURKADwGBXiTtE9p8s0BDOqhUGzN8m3MC4qNjiD3BfniZ/
         IOnjHQ2zUgIVrgew+q2ZX6Be8xXAyjH1YKPvkXTX/WK8bFaOs7TO6Dp6wW1aATwwY03Y
         njXg==
X-Gm-Message-State: ANhLgQ2n098zR5AwI272q1fbJtt9AZmCweerQhAUkoWky3SBycyLc2ur
        i1xaqHovyOt350VxqDFRKv8=
X-Google-Smtp-Source: ADFU+vueVFAHx0zsc6sIl0jBwr/4HNzm/aldo/a4k2JtVvrzDpTzNLo/NnD26xP9n+iWUxjv+2/I/A==
X-Received: by 2002:a17:90a:1546:: with SMTP id y6mr27255pja.26.1583177011513;
        Mon, 02 Mar 2020 11:23:31 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b18sm22286150pfd.63.2020.03.02.11.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:23:30 -0800 (PST)
Date:   Mon, 2 Mar 2020 11:23:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH v6 5/7] mm: support both pid and pidfd for process_madvise
Message-ID: <20200302192328.GB234476@google.com>
References: <20200219014433.88424-1-minchan@kernel.org>
 <20200219014433.88424-6-minchan@kernel.org>
 <CAJuCfpE_T1UG_eSQMa6y7n0GXQBOQ8sE=0fcWmSo2ZhHoj4mCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE_T1UG_eSQMa6y7n0GXQBOQ8sE=0fcWmSo2ZhHoj4mCg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 28, 2020 at 02:41:07PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > There is a demand[1] to support pid as well pidfd for process_madvise
> > to reduce unnecessary syscall to get pidfd if the user has control of
> > the target process(ie, they could guarantee the process is not gone
> > or pid is not reused. Or, it might be okay to give a hint to wrong
> > process).
> 
> nit: When would "give a hint to wrong process" be ok? I would just
> remove this part.

I wanted to say non destructive hints. It's already true for other
some hints because they are just best effort so it's not critical
to be failed. If you mind it, I will remove the phrase.

Thanks.

> 
> >
> > This patch aims for supporting both options like waitid(2). So, the
> > syscall is currently,
> >
> >         int process_madvise(int which, pid_t pid, void *addr,
> >                 size_t length, int advise, unsigned long flag);
> >
> > @which is actually idtype_t for userspace libray and currently,
> > it supports P_PID and P_PIDFD.
> >
> > [1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> >
> > Cc: Christian Brauner <christian@brauner.io>
> > Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/linux/syscalls.h |  3 ++-
> >  mm/madvise.c             | 34 ++++++++++++++++++++++------------
> >  2 files changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index e4cd2c2f8bb4..f5ada20e2943 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -876,7 +876,8 @@ asmlinkage long sys_munlockall(void);
> >  asmlinkage long sys_mincore(unsigned long start, size_t len,
> >                                 unsigned char __user * vec);
> >  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> > -asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> > +
> > +asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
> >                         size_t len, int behavior, unsigned long flags);
> >  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
> >                         unsigned long prot, unsigned long pgoff,
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index def1507c2030..f6d9b9e66243 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1182,11 +1182,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >         return do_madvise(current, current->mm, start, len_in, behavior);
> >  }
> >
> > -SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > +SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid, unsigned long, start,
> >                 size_t, len_in, int, behavior, unsigned long, flags)
> >  {
> >         int ret;
> > -       struct fd f;
> >         struct pid *pid;
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> > @@ -1197,20 +1196,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> >         if (!process_madvise_behavior_valid(behavior))
> >                 return -EINVAL;
> >
> > -       f = fdget(pidfd);
> > -       if (!f.file)
> > -               return -EBADF;
> > +       switch (which) {
> > +       case P_PID:
> > +               if (upid <= 0)
> > +                       return -EINVAL;
> > +
> > +               pid = find_get_pid(upid);
> > +               if (!pid)
> > +                       return -ESRCH;
> > +               break;
> > +       case P_PIDFD:
> > +               if (upid < 0)
> > +                       return -EINVAL;
> >
> > -       pid = pidfd_pid(f.file);
> > -       if (IS_ERR(pid)) {
> > -               ret = PTR_ERR(pid);
> > -               goto fdput;
> > +               pid = pidfd_get_pid(upid);
> > +               if (IS_ERR(pid))
> > +                       return PTR_ERR(pid);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> >         }
> >
> >         task = get_pid_task(pid, PIDTYPE_PID);
> >         if (!task) {
> >                 ret = -ESRCH;
> > -               goto fdput;
> > +               goto put_pid;
> >         }
> >
> >         mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > @@ -1223,7 +1233,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> >         mmput(mm);
> >  release_task:
> >         put_task_struct(task);
> > -fdput:
> > -       fdput(f);
> > +put_pid:
> > +       put_pid(pid);
> >         return ret;
> >  }
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
