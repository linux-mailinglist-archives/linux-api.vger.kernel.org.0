Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8062144B3C9
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 21:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbhKIUMx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 15:12:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbhKIUMv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 15:12:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7037021639;
        Tue,  9 Nov 2021 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636488604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRosq4IEc3vzV1AepmH5jntOjodFoOJx31yQM2dMSH4=;
        b=OalPnZ8BgGymwMmDUxlG6/MtLgcCXS+5oyL6Iq1AmWHTFUV2cyE8uwZQwEqF7qCP5jwNYS
        6ZDedyCTV70VsOCkgzq2YZX4FNUrO23obCUnilfIpJr16s1/bCsTNCmVUucmdf6FOO/yOV
        zAWraPWz2E4+F2BGKzTWoScZwfxY3pg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B9DBA3B81;
        Tue,  9 Nov 2021 20:10:04 +0000 (UTC)
Date:   Tue, 9 Nov 2021 21:10:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz>
References: <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
 <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
 <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
 <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz>
 <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 09-11-21 12:02:37, Suren Baghdasaryan wrote:
> On Tue, Nov 9, 2021 at 11:50 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 09-11-21 11:37:06, Suren Baghdasaryan wrote:
> > > On Tue, Nov 9, 2021 at 11:26 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
> > > > [...]
> > > > > Discussing how the patch I want to post works for maple trees that
> > > > > Matthew is working on, I've got a question:
> > > > >
> > > > > IIUC, according to Michal's post here:
> > > > > https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> > > > > unmap_vmas() can race with other mmap_lock read holders (including
> > > > > oom_reap_task_mm()) with no issues.
> > > > > Maple tree patchset requires rcu read lock or the mmap semaphore be
> > > > > held (read or write side) when walking the tree, including inside
> > > > > unmap_vmas(). When asked, he told me that he is not sure why it's
> > > > > currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> > > > > another thread is reaping the mm.
> > > > > Michal (or maybe someone else), could you please clarify why
> > > > > unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> > > > > understanding was wrong?
> > > >
> > > > I cannot really comment on the mapple tree part. But the existing
> > > > synchronization between oom reaper and exit_mmap is based on
> > > > - oom_reaper takes mmap_sem for reading
> > > > - exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before
> > > >   unmap_vmas.
> > > >
> > > > The oom_reaper therefore can either unmap the address space if the lock
> > > > is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
> > > > if it takes the lock afterwards. So the reaper cannot race with
> > > > unmap_vmas.
> > >
> > > I see. So, it's the combination of MMF_OOM_SKIP and mmap_lock working
> > > as a barrier which prevent them from racing with each other...
> > > I wasn't sure how
> > > https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
> > > was implementing this synchronization because it would take mmap_sem
> > > write side after unmap_vmas() and IIUC there was no
> > > "mmap_lock_write(); mmap_unlock_write();" sequence in exit_mmap at
> > > that time. I'll need to checkout the old sources to figure this out.
> >
> > My memory is rather dimm but AFAIR the main problem was freeing page
> > tables and freeing vmas not unmap_vmas. That one was no modifying the
> > vma list. Essentially it was just a slightly modified madvise don't
> > need. So that part was allowed to race with oom_reaper.
> 
> So, both unmap_vmas and __oom_reap_task_mm do not modify vma list and
> therefore can execute concurrently. That makes sense, thanks.

Yes, those can run concurrently. One thing I completely forgot about is 
27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
which is about interaction with the munlock.
 
> Then I guess, if we want to be semantically correct in exit_mmap(), we
> would have to take mmap_read_lock before unmap_vmas, then drop it and
> take mmap_write_lock before free_pgtables.

I think it would be just more straightforward to take the exclusive lock
for the whole operation.
-- 
Michal Hocko
SUSE Labs
