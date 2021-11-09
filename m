Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2844B380
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 20:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbhKITxR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 14:53:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53278 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbhKITxM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 14:53:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C65EA1FD59;
        Tue,  9 Nov 2021 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636487424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awGgikCcmG5Q9uvwRDWjFJOu9leSXSXoZmpjAiB6OE4=;
        b=C200SsgYdZzGjjytf/rGpcc89zyYDSrrGooc26WR7Ojvg3bhvpW5RZRhB6Epg4ccZ+hr9n
        K+NYVMBYh3zsS64ih65iwhALam+wh8QJmk7jghrEusclUI96T0QskQ++8TCDOT4gMaEeF9
        gKLma+A/j/SsLlJURTVCfyi2Uz3v1kw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7A1A8A3B83;
        Tue,  9 Nov 2021 19:50:24 +0000 (UTC)
Date:   Tue, 9 Nov 2021 20:50:22 +0100
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
Message-ID: <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz>
References: <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
 <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
 <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
 <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
 <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 09-11-21 11:37:06, Suren Baghdasaryan wrote:
> On Tue, Nov 9, 2021 at 11:26 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
> > [...]
> > > Discussing how the patch I want to post works for maple trees that
> > > Matthew is working on, I've got a question:
> > >
> > > IIUC, according to Michal's post here:
> > > https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> > > unmap_vmas() can race with other mmap_lock read holders (including
> > > oom_reap_task_mm()) with no issues.
> > > Maple tree patchset requires rcu read lock or the mmap semaphore be
> > > held (read or write side) when walking the tree, including inside
> > > unmap_vmas(). When asked, he told me that he is not sure why it's
> > > currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> > > another thread is reaping the mm.
> > > Michal (or maybe someone else), could you please clarify why
> > > unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> > > understanding was wrong?
> >
> > I cannot really comment on the mapple tree part. But the existing
> > synchronization between oom reaper and exit_mmap is based on
> > - oom_reaper takes mmap_sem for reading
> > - exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before
> >   unmap_vmas.
> >
> > The oom_reaper therefore can either unmap the address space if the lock
> > is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
> > if it takes the lock afterwards. So the reaper cannot race with
> > unmap_vmas.
> 
> I see. So, it's the combination of MMF_OOM_SKIP and mmap_lock working
> as a barrier which prevent them from racing with each other...
> I wasn't sure how
> https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
> was implementing this synchronization because it would take mmap_sem
> write side after unmap_vmas() and IIUC there was no
> "mmap_lock_write(); mmap_unlock_write();" sequence in exit_mmap at
> that time. I'll need to checkout the old sources to figure this out.

My memory is rather dimm but AFAIR the main problem was freeing page
tables and freeing vmas not unmap_vmas. That one was no modifying the
vma list. Essentially it was just a slightly modified madvise don't
need. So that part was allowed to race with oom_reaper.
-- 
Michal Hocko
SUSE Labs
