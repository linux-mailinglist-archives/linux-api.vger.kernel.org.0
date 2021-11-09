Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6644B47E
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 22:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244936AbhKIVNj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 16:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbhKIVNh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 16:13:37 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51423C061767
        for <linux-api@vger.kernel.org>; Tue,  9 Nov 2021 13:10:51 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id a129so816172yba.10
        for <linux-api@vger.kernel.org>; Tue, 09 Nov 2021 13:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AH7epOoySOeiGksyUpz+DkEAzZgrafCUbmWIMI/CpvA=;
        b=FEbooq+2RPELhpdFibtzf+o6RtKcTzFsITeoOKt5EyoFuC6IGFQm2J3krtoSzQydLL
         B4Pw9nMMqX6DIJ7Bnd5JqWSxlAspKt1eMv9M5X1HtJLCw04QwCywzM+q6TjE2jgfix/s
         rHeJ12vkti8Qtay79gedDRZIOlkM97FadiDSjFE+Gnag9L+Ss6jFu2Nkc72Jy4tRXBbN
         9BX5jGghiz/4yAeWepqXcIAQumnvW+WM8Iev5+zUMoHf55hQQ2wKjaDwuUJOgxzNJVdC
         6/0oL4h6NQ7i5+EKT217sKfFXA1QEPmJycOwhC41A8/0aQTWLk8hKgwguQwhEvBYakwv
         QKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AH7epOoySOeiGksyUpz+DkEAzZgrafCUbmWIMI/CpvA=;
        b=Iai+JMzakimSzl0wuTjgOl6GSbTDoOEtTsPZG4zO/oyVBFr0xzAAu7fYJFXV6tAxzl
         q7767bXA8gWtpNiQ91hMZBHUgyXD/8f/QtpfASkyDc1FDH+cJ0HjMSb9poodxb7iNpoc
         WciUu9pLGRLbbOjbVHq4j1rrD52gvvkeWq1HyWE+RnZ1Ei0JIn7kJed7vYJB5/bJQPD2
         xCVTpPElb7QCg8UGtc+ZmEakfB/7eK7yLSxkvC1UatsaDdcaeNFHQr94keFyacHhbXw4
         //um86EvX8h5Owo92iLH78LJwM3OMEXTr5/huMpFL14gaP/a8wfQ91DeTI/v/TVrc8KX
         soAQ==
X-Gm-Message-State: AOAM5304YXv3/bXVL2rZiP0xXAQ91iF3wMBuIm2SfhScr0GtxmHELavL
        Z70Xy5g2h82JTskrBEUigxjWTZ/V9Ho11Vw52CSY3g==
X-Google-Smtp-Source: ABdhPJwcasPYsat4S5s+/hNloJW73tDUzzP+zsaaKSgPceFaeVymjL1QX/ZAJDT05FW5wRQnskUlnVrjQV33CM/9lHo=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr11965850ybv.487.1636492250283;
 Tue, 09 Nov 2021 13:10:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz> <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz> <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz> <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
 <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz>
In-Reply-To: <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 9 Nov 2021 13:10:38 -0800
Message-ID: <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 12:10 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 09-11-21 12:02:37, Suren Baghdasaryan wrote:
> > On Tue, Nov 9, 2021 at 11:50 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 09-11-21 11:37:06, Suren Baghdasaryan wrote:
> > > > On Tue, Nov 9, 2021 at 11:26 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > > Discussing how the patch I want to post works for maple trees that
> > > > > > Matthew is working on, I've got a question:
> > > > > >
> > > > > > IIUC, according to Michal's post here:
> > > > > > https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> > > > > > unmap_vmas() can race with other mmap_lock read holders (including
> > > > > > oom_reap_task_mm()) with no issues.
> > > > > > Maple tree patchset requires rcu read lock or the mmap semaphore be
> > > > > > held (read or write side) when walking the tree, including inside
> > > > > > unmap_vmas(). When asked, he told me that he is not sure why it's
> > > > > > currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> > > > > > another thread is reaping the mm.
> > > > > > Michal (or maybe someone else), could you please clarify why
> > > > > > unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> > > > > > understanding was wrong?
> > > > >
> > > > > I cannot really comment on the mapple tree part. But the existing
> > > > > synchronization between oom reaper and exit_mmap is based on
> > > > > - oom_reaper takes mmap_sem for reading
> > > > > - exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before
> > > > >   unmap_vmas.
> > > > >
> > > > > The oom_reaper therefore can either unmap the address space if the lock
> > > > > is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
> > > > > if it takes the lock afterwards. So the reaper cannot race with
> > > > > unmap_vmas.
> > > >
> > > > I see. So, it's the combination of MMF_OOM_SKIP and mmap_lock working
> > > > as a barrier which prevent them from racing with each other...
> > > > I wasn't sure how
> > > > https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
> > > > was implementing this synchronization because it would take mmap_sem
> > > > write side after unmap_vmas() and IIUC there was no
> > > > "mmap_lock_write(); mmap_unlock_write();" sequence in exit_mmap at
> > > > that time. I'll need to checkout the old sources to figure this out.
> > >
> > > My memory is rather dimm but AFAIR the main problem was freeing page
> > > tables and freeing vmas not unmap_vmas. That one was no modifying the
> > > vma list. Essentially it was just a slightly modified madvise don't
> > > need. So that part was allowed to race with oom_reaper.
> >
> > So, both unmap_vmas and __oom_reap_task_mm do not modify vma list and
> > therefore can execute concurrently. That makes sense, thanks.
>
> Yes, those can run concurrently. One thing I completely forgot about is
> 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> which is about interaction with the munlock.

Thanks for pointing it out. IIUC, ideally we want to get rid of all
these special cases and replace them with proper locking. If so, I'll
see what I can do here.

>
> > Then I guess, if we want to be semantically correct in exit_mmap(), we
> > would have to take mmap_read_lock before unmap_vmas, then drop it and
> > take mmap_write_lock before free_pgtables.
>
> I think it would be just more straightforward to take the exclusive lock
> for the whole operation.

Ok, but note that this will prevent concurrent memory reaping, so will
likely affect the speed at which memory is released during oom-kill. I
saw measurable difference when testing process_mrelease placing
mmap_write_lock before vs after unmap_vmas. If we take mmap_read_lock
before unmap_vmas and mmap_write_lock after it, then there won't be
such issue. You indicated that the speed of memory release should not
be the deciding factor here but I want to make it clear before
proceeding.
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
