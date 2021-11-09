Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8336E44B351
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 20:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhKITkF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 14:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhKITkE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 14:40:04 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF18C061764
        for <linux-api@vger.kernel.org>; Tue,  9 Nov 2021 11:37:18 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v7so417976ybq.0
        for <linux-api@vger.kernel.org>; Tue, 09 Nov 2021 11:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQprVm+3qzu3dZEgfzO0O6Slbj/WjUJyb02QjMT9Eas=;
        b=SrO7kkz0GdY4VvmfhvtWo2O0vzZDq5YOBSr9XsZJEV3iK1f3RmY36DnsqZg+NgboLx
         wtNxrG4NX2VdfMmljAXeEkr4cGAq3Z4rl+XNbdMrZ5aQ44K6lr0tBW6kLFUrM/9zoRc+
         urTz8KcHWEAaylDlPGfuTQZhVvffy8iZr0bZp+jNzaZahSrwBunJuphW6xi0PgdbC/Vt
         K7nBwjZ0/thjuEhFeSnF4EN6FzKWb5NocwhE0V2YMQEjDJrTD4CPjTl5LgVJGKNTrcJG
         z6rNnLYs5BODTzogjYlDR3/qd7HUkFuOjuCbn+LAJ5HXpPP2xSFZq7HJ7sY9nVXvVSTf
         7H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQprVm+3qzu3dZEgfzO0O6Slbj/WjUJyb02QjMT9Eas=;
        b=qkYups1gXyHUD3z8OGuEdzmqNPCMxTGjS2u47rI5vFgdLuZn/1M76GpOg37y206ujq
         k75denU/9hqPx8vhzm/+DNe2tHkKw+SfpONuy7ZM06xnoTW8xxvTaL8721KICqThyOt6
         csQM2u6YyxtLbgBHKweQhvDjEqusLZwZosTv/fo9Q1+zpygutcOIN/L0WHciWkZJSkgz
         XKaot1ByaNVkbupySbEtsuS5y50nVljrqS0vcROqal5airI+UkvjJJ4MULPT7G07vVbB
         2PZmCK7zEGuoPdIU6EfyCjq6wMUvhZdTJ3Ml+l8/4eAF0CuckNGiHVCNoj3ehJxWslN0
         l1tw==
X-Gm-Message-State: AOAM533X13EY6dyvqzz+uqWBGkcPJVou7Dcd0vib9lx31rQsBVmj16dQ
        zRunexhZD/qvfSjZyzdDj5Yy+1ch+nW7n9RUXn8txA==
X-Google-Smtp-Source: ABdhPJxU75C9fcuW8uYWKXj+MUN9NRQwAfY7318XA4p/9zFwRGBY+kpjk9UHdNU9CUXomL9Q5fmwM8CO8aELT+WipXs=
X-Received: by 2002:a25:d4d5:: with SMTP id m204mr12272621ybf.418.1636486637539;
 Tue, 09 Nov 2021 11:37:17 -0800 (PST)
MIME-Version: 1.0
References: <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz> <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz> <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz> <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com> <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
In-Reply-To: <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 9 Nov 2021 11:37:06 -0800
Message-ID: <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 11:26 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
> [...]
> > Discussing how the patch I want to post works for maple trees that
> > Matthew is working on, I've got a question:
> >
> > IIUC, according to Michal's post here:
> > https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> > unmap_vmas() can race with other mmap_lock read holders (including
> > oom_reap_task_mm()) with no issues.
> > Maple tree patchset requires rcu read lock or the mmap semaphore be
> > held (read or write side) when walking the tree, including inside
> > unmap_vmas(). When asked, he told me that he is not sure why it's
> > currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> > another thread is reaping the mm.
> > Michal (or maybe someone else), could you please clarify why
> > unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> > understanding was wrong?
>
> I cannot really comment on the mapple tree part. But the existing
> synchronization between oom reaper and exit_mmap is based on
> - oom_reaper takes mmap_sem for reading
> - exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before
>   unmap_vmas.
>
> The oom_reaper therefore can either unmap the address space if the lock
> is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
> if it takes the lock afterwards. So the reaper cannot race with
> unmap_vmas.

I see. So, it's the combination of MMF_OOM_SKIP and mmap_lock working
as a barrier which prevent them from racing with each other...
I wasn't sure how
https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
was implementing this synchronization because it would take mmap_sem
write side after unmap_vmas() and IIUC there was no
"mmap_lock_write(); mmap_unlock_write();" sequence in exit_mmap at
that time. I'll need to checkout the old sources to figure this out.
Thanks,
Suren.

>
> --
> Michal Hocko
> SUSE Labs
