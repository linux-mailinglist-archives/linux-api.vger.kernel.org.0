Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6144B3AF
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 21:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbhKIUFf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 15:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbhKIUFf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 15:05:35 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE6C061766
        for <linux-api@vger.kernel.org>; Tue,  9 Nov 2021 12:02:48 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v7so586042ybq.0
        for <linux-api@vger.kernel.org>; Tue, 09 Nov 2021 12:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNY0y0eA9QFjzP9md2u0evK0gJlRjiM1T7nvr0z7Y1Q=;
        b=XmpMSGbHisj1bMTeQbWzpoXd566Jd6dd6n20risBDuCFlvhGz1Ka37xSb6eLO7mRqN
         dSvFoXkqF9JJBFcNtoERd2otIAhGLqbzoceEQ3s/4nOQ2UmJlgxshmVUUOhqIDxl06aZ
         xxhWUPxXyfRoUQKtl59qgidqVSmuqkJv0g/bjs8k1cAhiUvE7AYVOcPdfiWI5BEZqoSG
         Ajd2B8TFW80hBcaWql6Q94xBAjmpqzebr7BLvJQKnbMKZ06kvtdK/KRH33IOwF0vB6Yo
         1AeYbMUsaBh3erYO3q4ir7rN1eQx3rCn83oc3ohBa2X1s+VqxcFWxrl15cMiIq3Z4VxF
         3iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNY0y0eA9QFjzP9md2u0evK0gJlRjiM1T7nvr0z7Y1Q=;
        b=F7JLkfT+7X6MAVbbPMVKwITJlYMH08E6J9DU2gENIQ2o+Q44Fmidc7AzjRaXQ6qVM5
         XdbDbHvX0noBvgp2HhjHsHWLCR9EjGy2dGhygARPUWvXfCByPXkQm198fStolRhCpU8S
         70NTnISiEgbokR+sy6+9nF0hDr7tZeSB4Yk1WsezDVVTU3q0+HjuvkZLRvkjn08Dws80
         Gi6B982Txq98tQ4D2iRZpBcacCNgbU5SVLF2fJz5UFXQt8n0Y+hyXt45ZCd+pXsf602Q
         erMt0fkajYlxzOJX1I0+t/myKV9WqtuQMDKHCP5f7yL4Crsl/IvnPyj6bdU7CZ05GSsS
         orZw==
X-Gm-Message-State: AOAM531lN3IW3Usiuwz5VesP7pusK2lnEs4v567HWSECmHYIYfKFrw4P
        6HML3fS1r8pDhRPOOEwtyLiyD6WFxVZhX8StzmuMqA==
X-Google-Smtp-Source: ABdhPJz66wXBO27AG+ywplv4qSiNKTGTTq3yywP5yCUsTUbLTry0vfQQUkbxdnDAz/wUa9ds4L+wp+VX+HKAUUXChRk=
X-Received: by 2002:a25:d4d5:: with SMTP id m204mr12480331ybf.418.1636488167925;
 Tue, 09 Nov 2021 12:02:47 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz> <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz> <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
 <YYrLe2u2zbmu4LfL@dhcp22.suse.cz> <CAJuCfpG0d34yRhuvOj9NX9zMp=6jWLqFPfUGV0sOO6OrwNC89A@mail.gmail.com>
 <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz>
In-Reply-To: <YYrQ/hENQPn6Mk3v@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 9 Nov 2021 12:02:37 -0800
Message-ID: <CAJuCfpFT4-mdHHZ2i43hyJQ4dRKb7sRwnAL8GfRnZu3ecE26Ew@mail.gmail.com>
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

On Tue, Nov 9, 2021 at 11:50 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 09-11-21 11:37:06, Suren Baghdasaryan wrote:
> > On Tue, Nov 9, 2021 at 11:26 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
> > > [...]
> > > > Discussing how the patch I want to post works for maple trees that
> > > > Matthew is working on, I've got a question:
> > > >
> > > > IIUC, according to Michal's post here:
> > > > https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> > > > unmap_vmas() can race with other mmap_lock read holders (including
> > > > oom_reap_task_mm()) with no issues.
> > > > Maple tree patchset requires rcu read lock or the mmap semaphore be
> > > > held (read or write side) when walking the tree, including inside
> > > > unmap_vmas(). When asked, he told me that he is not sure why it's
> > > > currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> > > > another thread is reaping the mm.
> > > > Michal (or maybe someone else), could you please clarify why
> > > > unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> > > > understanding was wrong?
> > >
> > > I cannot really comment on the mapple tree part. But the existing
> > > synchronization between oom reaper and exit_mmap is based on
> > > - oom_reaper takes mmap_sem for reading
> > > - exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before
> > >   unmap_vmas.
> > >
> > > The oom_reaper therefore can either unmap the address space if the lock
> > > is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
> > > if it takes the lock afterwards. So the reaper cannot race with
> > > unmap_vmas.
> >
> > I see. So, it's the combination of MMF_OOM_SKIP and mmap_lock working
> > as a barrier which prevent them from racing with each other...
> > I wasn't sure how
> > https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
> > was implementing this synchronization because it would take mmap_sem
> > write side after unmap_vmas() and IIUC there was no
> > "mmap_lock_write(); mmap_unlock_write();" sequence in exit_mmap at
> > that time. I'll need to checkout the old sources to figure this out.
>
> My memory is rather dimm but AFAIR the main problem was freeing page
> tables and freeing vmas not unmap_vmas. That one was no modifying the
> vma list. Essentially it was just a slightly modified madvise don't
> need. So that part was allowed to race with oom_reaper.

So, both unmap_vmas and __oom_reap_task_mm do not modify vma list and
therefore can execute concurrently. That makes sense, thanks.

Then I guess, if we want to be semantically correct in exit_mmap(), we
would have to take mmap_read_lock before unmap_vmas, then drop it and
take mmap_write_lock before free_pgtables.

> --
> Michal Hocko
> SUSE Labs
