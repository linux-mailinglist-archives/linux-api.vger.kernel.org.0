Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7943CE4F
	for <lists+linux-api@lfdr.de>; Wed, 27 Oct 2021 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhJ0QLA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Oct 2021 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbhJ0QK7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Oct 2021 12:10:59 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567CC061570
        for <linux-api@vger.kernel.org>; Wed, 27 Oct 2021 09:08:33 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v64so1156448ybi.5
        for <linux-api@vger.kernel.org>; Wed, 27 Oct 2021 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7yM+AHVg6/RWwPVXoUMFU+BAoYxNZ6FELdoFv8vPVY=;
        b=jam13Ei0ZH0rmnEJQGz2oG7g5UJE6hddfGqNF9ht5JQ+AMTvawIvs2IlZEP15mrB8I
         4Vb2WELl2sb+a8KiVkJxo21BQb8RmLmCXaAG3RZVsaWXnfLYRZBgE+NYnDb7fylVrVW+
         aVveT6W+Z5ExMRWMYTo1j2GEkQK+b6zBHkgEzEB6XwHBRw98PDkazY5vkMfnt/uKBgJ+
         k+ZG/MFiLjtd8w4m1+CBAn413mqp2pPJrigcXqzuwjTfe1S0J8GMx5VqnQWaMknlleuX
         pTHNvzis3he35IfamTHEUyzyNdSqAOGalCHjxrvlRJ2iQ6AaYVWgIBi7JdokemJnsocR
         h6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7yM+AHVg6/RWwPVXoUMFU+BAoYxNZ6FELdoFv8vPVY=;
        b=WfMLgbx3GI4Km+OunGn/sKq/TFr2Ik5G/s9ljGbpaM3UbdHA6Ya/4ejWhGcjVdGqxV
         QbAHDHl0OQ24HLe3GDjNAo7tBrzCGo5Qwx7mHa0HVs3w46lHaZQyphAb36Dgw4Eg5H+S
         Hr7J1QhflL34snkXA4cZta5nG5jFeRxIqElV+iQoJIXgDoQHdEFfI/l5R76T+g2F8amk
         aV9BcKDyG7EaZXoSxlhzP/ROSOwKkncXZ4rOmHAKmuFqswuaBpUN0IH6K8g1oWr4PmQt
         aSJmnifn1hPuwV+zs7mWRbqzlrHRyOZoLC9zSCB2oTRQtT5OroDTfQtX6ZAON3cDlQXO
         yLmQ==
X-Gm-Message-State: AOAM5330g9K2pYpsTr/iDT4SpbEHjFsX84FS4VlwXFtPQa/CCpxkyJyo
        mgSyo+bk493hKw3WDqVZAYlIQw4xzOXUz+QU9JrfXA==
X-Google-Smtp-Source: ABdhPJw/n7XwHkFkI9fOQmbZIV5nvoItVjlZ5jw4xeYJ3ZltRS5KLuUCkRrnZKnwCUWhrxfvAaiFxm6E/iWN3dKdn7k=
X-Received: by 2002:a25:8411:: with SMTP id u17mr33162493ybk.376.1635350912546;
 Wed, 27 Oct 2021 09:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
In-Reply-To: <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Oct 2021 09:08:21 -0700
Message-ID: <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
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
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 22, 2021 at 10:38 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Oct 22, 2021 at 1:03 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 21-10-21 18:46:58, Suren Baghdasaryan wrote:
> > > Race between process_mrelease and exit_mmap, where free_pgtables is
> > > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > > fix this race, however that would be considered a hack. Fix this race
> > > by elevating mm->mm_users and preventing exit_mmap from executing until
> > > process_mrelease is finished. Patch slightly refactors the code to adapt
> > > for a possible mmget_not_zero failure.
> > > This fix has considerable negative impact on process_mrelease performance
> > > and will likely need later optimization.
> >
> > I am not sure there is any promise that process_mrelease will run in
> > parallel with the exiting process. In fact the primary purpose of this
> > syscall is to provide a reliable way to oom kill from user space. If you
> > want to optimize process exit resp. its exit_mmap part then you should
> > be using other means. So I would be careful calling this a regression.
> >
> > I do agree that taking the reference count is the right approach here. I
> > was wrong previously [1] when saying that pinning the mm struct is
> > sufficient. I have completely forgot about the subtle sync in exit_mmap.
> > One way we can approach that would be to take exclusive mmap_sem
> > throughout the exit_mmap unconditionally.
>
> I agree, that would probably be the cleanest way.
>
> > There was a push back against
> > that though so arguments would have to be re-evaluated.
>
> I'll review that discussion to better understand the reasons for the
> push back. Thanks for the link.

Adding Kirill and Andrea.

I had some time to dig some more. The latency increase is definitely
coming due to process_mrelease calling the last mmput and exit_aio is
especially problematic. So, currently process_mrelease not only
releases memory but does more, including waiting for io to finish.

Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
to me the most semantically correct way forward and the pushback is on
the basis of regressing performance of the exit path. I would like to
measure that regression to confirm this. I don't have access to a big
machine but will ask someone in another Google team to try the test
Michal wrote here
https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
a server with and without a custom patch.
If the regression is real, then I think we could keep the "if
(unlikely(mm_is_oom_victim(mm)))" condition but wrap free_pgtables
with conditional mmap_write_lock. To me this is cleaner because it
clearly shows that we are trying to prevent free_pgtables from racing
with any mm readers (current mmap_write_lock(); mmap_write_unlock()
sequence needs a comment section to explain why this is needed). In
that case I would need to reuse MMF_OOM_VICTIM in process_mrelease to
avoid postponing the exit_mmap, like oom-reaper does. Maybe we could
rename MMF_OOM_VICTIM / MMF_OOM_SKIP to something like MMF_RELEASING /
MMF_RELEASED to make them more generic and allow their use outside of
oom-killer? Again, this is a fallback plan in case unconditional
mmap_write_lock indeed regresses the exit path.
Any comments/suggestions?


>
> >
> > [1] http://lkml.kernel.org/r/YQzZqFwDP7eUxwcn@dhcp22.suse.cz
> >
> > That being said
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
>
> >
> > Thanks!
> >
> > > Fixes: 884a7e5964e0 ("mm: introduce process_mrelease system call")
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/oom_kill.c | 23 ++++++++++++-----------
> > >  1 file changed, 12 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 831340e7ad8b..989f35a2bbb1 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -1150,7 +1150,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > >       struct task_struct *task;
> > >       struct task_struct *p;
> > >       unsigned int f_flags;
> > > -     bool reap = true;
> > > +     bool reap = false;
> > >       struct pid *pid;
> > >       long ret = 0;
> > >
> > > @@ -1177,15 +1177,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > >               goto put_task;
> > >       }
> > >
> > > -     mm = p->mm;
> > > -     mmgrab(mm);
> > > -
> > > -     /* If the work has been done already, just exit with success */
> > > -     if (test_bit(MMF_OOM_SKIP, &mm->flags))
> > > -             reap = false;
> > > -     else if (!task_will_free_mem(p)) {
> > > -             reap = false;
> > > -             ret = -EINVAL;
> > > +     if (mmget_not_zero(p->mm)) {
> > > +             mm = p->mm;
> > > +             if (task_will_free_mem(p))
> > > +                     reap = true;
> > > +             else {
> > > +                     /* Error only if the work has not been done already */
> > > +                     if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> > > +                             ret = -EINVAL;
> > > +             }
> > >       }
> > >       task_unlock(p);
> > >
> > > @@ -1201,7 +1201,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > >       mmap_read_unlock(mm);
> > >
> > >  drop_mm:
> > > -     mmdrop(mm);
> > > +     if (mm)
> > > +             mmput(mm);
> > >  put_task:
> > >       put_task_struct(task);
> > >  put_pid:
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> >
> > --
> > Michal Hocko
> > SUSE Labs
