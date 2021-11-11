Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2910B44CF3E
	for <lists+linux-api@lfdr.de>; Thu, 11 Nov 2021 02:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhKKBwi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Nov 2021 20:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhKKBwh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Nov 2021 20:52:37 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D115C061767
        for <linux-api@vger.kernel.org>; Wed, 10 Nov 2021 17:49:49 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id a129so11105121yba.10
        for <linux-api@vger.kernel.org>; Wed, 10 Nov 2021 17:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1s9PkiERHgtuRIYjlT0cC/lRcZ1Ijv9dEf4nsTsVJ8=;
        b=VltbIgLFxDPzIAW2CmTfeHSs7ehAUsviU5Q1FD60b6AjC51mqJMt2X+Hz2+AvTfZTG
         pm/chewIr4uLrNTj70XrevyFEoA1TVPPhnlzdHy8Al02DbtKWnABw9Xr9pl6DDD0hL2r
         zuR+MYXTU+IreVRs7YEhcPZ0SdMxfYK4A00ko0GkvoCCLA/gWCbPUOBLFFIYX2GUybqb
         XL146uOQkZ76dMPTZquuYvfcW3tzI9mHvfEhIa5cmaUnP65nKH+Cx7G+5KfOM3frlkqb
         dPQbvGlbLZSvQLkXIOeBXihr9gOVtYliIljlnvRUSAKAWec/K1g+2+dHMecLrar644n/
         jkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1s9PkiERHgtuRIYjlT0cC/lRcZ1Ijv9dEf4nsTsVJ8=;
        b=jvqx6uFX9ZAVUsCAtgxEmRtc+APcHzOg+o0PYt6df/n0KOhDVEmGL32N5g60oW+ZBK
         9dv4BRlGuLo45IGfJDdA5NIpzQ5+vuZCiOFe1eGX3U50lvK6Zz90xhy01yCTJYmZhYVC
         4tdDznMWMnmCTL7WLkVbHWs2yy4KxJv6PglQQ9dqd7gvm1PJgYbpS0MY5TR/owesT2ya
         lWF0FVJb2jErXYfIWBpjKk6+nCEVC7GgS+YuTfDVZTR/RmhK1fxlhd2Ibuk6QioiJrEo
         HvvJPFgotch7szQDeRxqhxh6oIg8qrKkYOfHd0BkgQca8BLm21If8YJWkr8NYT1DkZXm
         5RUQ==
X-Gm-Message-State: AOAM530g+cccXs//Hp3hU3Osd7Ol1sL9vOA5v1ZKTIc7ciKlMJqRlT/4
        v4lqqUSuMSioSykBuVeW58hzL1C1Qff49aYEQk2cKg==
X-Google-Smtp-Source: ABdhPJxgZTY6W7XHkwpQfbf+hVyqBDB8aB3GEphK/+RWg874X6qi8/vaVjIpK0gxgnSgTo/tUlDmHDN1y/4iHwzvpYQ=
X-Received: by 2002:a25:ae12:: with SMTP id a18mr4071732ybj.412.1636595388273;
 Wed, 10 Nov 2021 17:49:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz> <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz> <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz> <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
 <YYrVmi2xdo1Gr2Bb@dhcp22.suse.cz> <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGrYa2Ws4GrVp_nRqVEw8j_cGXk+gprLYUx7NWUOC-uRQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 10 Nov 2021 17:49:37 -0800
Message-ID: <CAJuCfpHJnVG7PMhKW-Snz38az-Bv=QCFXa7DxD=KgEMbHJOi6A@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 1:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Nov 9, 2021 at 12:10 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 09-11-21 12:02:37, Suren Baghdasaryan wrote:
> > > On Tue, Nov 9, 2021 at 11:50 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Tue 09-11-21 11:37:06, Suren Baghdasaryan wrote:
> > > > > On Tue, Nov 9, 2021 at 11:26 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
> > > > > > [...]
> > > > > > > Discussing how the patch I want to post works for maple trees that
> > > > > > > Matthew is working on, I've got a question:
> > > > > > >
> > > > > > > IIUC, according to Michal's post here:
> > > > > > > https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> > > > > > > unmap_vmas() can race with other mmap_lock read holders (including
> > > > > > > oom_reap_task_mm()) with no issues.
> > > > > > > Maple tree patchset requires rcu read lock or the mmap semaphore be
> > > > > > > held (read or write side) when walking the tree, including inside
> > > > > > > unmap_vmas(). When asked, he told me that he is not sure why it's
> > > > > > > currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> > > > > > > another thread is reaping the mm.
> > > > > > > Michal (or maybe someone else), could you please clarify why
> > > > > > > unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> > > > > > > understanding was wrong?
> > > > > >
> > > > > > I cannot really comment on the mapple tree part. But the existing
> > > > > > synchronization between oom reaper and exit_mmap is based on
> > > > > > - oom_reaper takes mmap_sem for reading
> > > > > > - exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before
> > > > > >   unmap_vmas.
> > > > > >
> > > > > > The oom_reaper therefore can either unmap the address space if the lock
> > > > > > is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
> > > > > > if it takes the lock afterwards. So the reaper cannot race with
> > > > > > unmap_vmas.
> > > > >
> > > > > I see. So, it's the combination of MMF_OOM_SKIP and mmap_lock working
> > > > > as a barrier which prevent them from racing with each other...
> > > > > I wasn't sure how
> > > > > https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
> > > > > was implementing this synchronization because it would take mmap_sem
> > > > > write side after unmap_vmas() and IIUC there was no
> > > > > "mmap_lock_write(); mmap_unlock_write();" sequence in exit_mmap at
> > > > > that time. I'll need to checkout the old sources to figure this out.
> > > >
> > > > My memory is rather dimm but AFAIR the main problem was freeing page
> > > > tables and freeing vmas not unmap_vmas. That one was no modifying the
> > > > vma list. Essentially it was just a slightly modified madvise don't
> > > > need. So that part was allowed to race with oom_reaper.
> > >
> > > So, both unmap_vmas and __oom_reap_task_mm do not modify vma list and
> > > therefore can execute concurrently. That makes sense, thanks.
> >
> > Yes, those can run concurrently. One thing I completely forgot about is
> > 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > which is about interaction with the munlock.

Agrh! This interaction with the munlock you mentioned requires us to
take mmap_write_lock before munlock_vma_pages_all and that prevents
__oom_reap_task_mm from running concurrently with unmap_vmas. The
reapers would not be as effective as they are now after such a change
:(

>
> Thanks for pointing it out. IIUC, ideally we want to get rid of all
> these special cases and replace them with proper locking. If so, I'll
> see what I can do here.
>
> >
> > > Then I guess, if we want to be semantically correct in exit_mmap(), we
> > > would have to take mmap_read_lock before unmap_vmas, then drop it and
> > > take mmap_write_lock before free_pgtables.
> >
> > I think it would be just more straightforward to take the exclusive lock
> > for the whole operation.
>
> Ok, but note that this will prevent concurrent memory reaping, so will
> likely affect the speed at which memory is released during oom-kill. I
> saw measurable difference when testing process_mrelease placing
> mmap_write_lock before vs after unmap_vmas. If we take mmap_read_lock
> before unmap_vmas and mmap_write_lock after it, then there won't be
> such issue. You indicated that the speed of memory release should not
> be the deciding factor here but I want to make it clear before
> proceeding.
> Thanks,
> Suren.
>
> > --
> > Michal Hocko
> > SUSE Labs
