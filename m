Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E66437C0D
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhJVRlQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Oct 2021 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhJVRlP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Oct 2021 13:41:15 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E6C061764
        for <linux-api@vger.kernel.org>; Fri, 22 Oct 2021 10:38:57 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id o17so8687443ybq.4
        for <linux-api@vger.kernel.org>; Fri, 22 Oct 2021 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/8J8TR4uHJ1X4W6TznT1rAj7h/OTN7aNlkEVgGiT3k=;
        b=LP7en/nydEvtAFRctjt7frpaybeS3xAVyS4NXj3p3ir55MZBGyzoBHMEyWvi+VW6PT
         BwXDhkwDH07ax89kj2XT2dNMx4ckyVZan4DxLHH2lIjIHbWMqvq/EbTqniXG7EwtSvS4
         +CfXvJsgsY20ATw2fvtp/OyXy4SPk0ONvFKzV5hf2GBwbGKks6vtz1+DTPq9IzbICuYI
         kqS/klK5DiAvNo6refJCuZJZ9kMLNEf2EmQnAMmyrHFplSCk/4Q1IdGi7GrKSN/kyvPW
         rR3yW1l0MXUB3MAV4mE8gq4QHsCO+8bqIAkwVWFRD5Jgpo4wmosHJ7JGffPBxY3ScHba
         nlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/8J8TR4uHJ1X4W6TznT1rAj7h/OTN7aNlkEVgGiT3k=;
        b=xiaMWPjjnSkZXDlxfnxODdQ+r1C0UqdQC/VNAsDChlQeMv699wcXDkYmAZ9PjeAhXU
         KpC5GY7m15kNInaEmwheq+bIEURh4IWFpZKDLs1jnZPqMYGqm3/Em1MZmYWHJL14rHL8
         BCGYCtH6ml4YuvhFuH2kLciAPh/mfpflYxvZhO4mvLzphXhL8G9Vl3q56xbhaoX5SRDi
         crH9T9vn+4sh5Db3MGFUvDZv1SbzDVqzBZHNAej9F4iMyhbQf1vyK+S61isD+vcKn2YZ
         i/bwvRIDMx32R1vYcociR/QoHO24PAOi7r5Ndkz8MrDHoJMcWXCU2qxXhJTXFDdiTs/K
         BHhw==
X-Gm-Message-State: AOAM533larZw4Vdh0l8iy2XF0NjCktKLsOp2dgOR/cn5BjkVfsmGXdNj
        S/DbzTtz7uFZHDVBcyCyim54X8nUgKuBKNm50QBFZQ==
X-Google-Smtp-Source: ABdhPJzqy77u6YQ7w9HgETig0ZT17flo890EWUfxm8QGQC6SHPCyKeC6hHbuYdXWUpWZZMOnfP5nxkD02ITzgvHJkBo=
X-Received: by 2002:a25:81c6:: with SMTP id n6mr1180149ybm.412.1634924336836;
 Fri, 22 Oct 2021 10:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
In-Reply-To: <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 22 Oct 2021 10:38:45 -0700
Message-ID: <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
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
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 22, 2021 at 1:03 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 21-10-21 18:46:58, Suren Baghdasaryan wrote:
> > Race between process_mrelease and exit_mmap, where free_pgtables is
> > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > fix this race, however that would be considered a hack. Fix this race
> > by elevating mm->mm_users and preventing exit_mmap from executing until
> > process_mrelease is finished. Patch slightly refactors the code to adapt
> > for a possible mmget_not_zero failure.
> > This fix has considerable negative impact on process_mrelease performance
> > and will likely need later optimization.
>
> I am not sure there is any promise that process_mrelease will run in
> parallel with the exiting process. In fact the primary purpose of this
> syscall is to provide a reliable way to oom kill from user space. If you
> want to optimize process exit resp. its exit_mmap part then you should
> be using other means. So I would be careful calling this a regression.
>
> I do agree that taking the reference count is the right approach here. I
> was wrong previously [1] when saying that pinning the mm struct is
> sufficient. I have completely forgot about the subtle sync in exit_mmap.
> One way we can approach that would be to take exclusive mmap_sem
> throughout the exit_mmap unconditionally.

I agree, that would probably be the cleanest way.

> There was a push back against
> that though so arguments would have to be re-evaluated.

I'll review that discussion to better understand the reasons for the
push back. Thanks for the link.

>
> [1] http://lkml.kernel.org/r/YQzZqFwDP7eUxwcn@dhcp22.suse.cz
>
> That being said
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> Thanks!
>
> > Fixes: 884a7e5964e0 ("mm: introduce process_mrelease system call")
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/oom_kill.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 831340e7ad8b..989f35a2bbb1 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1150,7 +1150,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >       struct task_struct *task;
> >       struct task_struct *p;
> >       unsigned int f_flags;
> > -     bool reap = true;
> > +     bool reap = false;
> >       struct pid *pid;
> >       long ret = 0;
> >
> > @@ -1177,15 +1177,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >               goto put_task;
> >       }
> >
> > -     mm = p->mm;
> > -     mmgrab(mm);
> > -
> > -     /* If the work has been done already, just exit with success */
> > -     if (test_bit(MMF_OOM_SKIP, &mm->flags))
> > -             reap = false;
> > -     else if (!task_will_free_mem(p)) {
> > -             reap = false;
> > -             ret = -EINVAL;
> > +     if (mmget_not_zero(p->mm)) {
> > +             mm = p->mm;
> > +             if (task_will_free_mem(p))
> > +                     reap = true;
> > +             else {
> > +                     /* Error only if the work has not been done already */
> > +                     if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> > +                             ret = -EINVAL;
> > +             }
> >       }
> >       task_unlock(p);
> >
> > @@ -1201,7 +1201,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> >       mmap_read_unlock(mm);
> >
> >  drop_mm:
> > -     mmdrop(mm);
> > +     if (mm)
> > +             mmput(mm);
> >  put_task:
> >       put_task_struct(task);
> >  put_pid:
> > --
> > 2.33.0.1079.g6e70778dc9-goog
>
> --
> Michal Hocko
> SUSE Labs
