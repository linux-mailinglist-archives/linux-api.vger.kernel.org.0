Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17C44000D
	for <lists+linux-api@lfdr.de>; Fri, 29 Oct 2021 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2QKY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Oct 2021 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhJ2QKU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 Oct 2021 12:10:20 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB53C061714
        for <linux-api@vger.kernel.org>; Fri, 29 Oct 2021 09:07:51 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a129so12319386yba.10
        for <linux-api@vger.kernel.org>; Fri, 29 Oct 2021 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErSQ5CrQeSkmLUbZHQvgt43whunrTwbaNcEcHojj/F0=;
        b=r13mojvJ6IxO/MNCwqjQIRl2GnGDxLpJDNBQ3Jf8Txoh9BXENinQKzMfyhu2t+R34Q
         XaYNUIOISw7NVtii3HqpVPoYUstJaeOIWGm4Pj4x05NuuzDT8UGH/25/txTXbu2B8JBj
         Ypqx9W3CyM3Gs0InNIieqvyefufKQJ8HVmG8kxON7/IT8O4hH/OIyikQnw/X9sXTsfVj
         ZhhxqXJFk8HyTyk8paxVtgpt1YUowPq1Kf3IwB2JHg42qzYi91mH+vEtZg3DkJOHoVxC
         Io8KK/VSaIWIT2snrGuPBQXCMo0miHT6J7R9Y6ztme3aNVbIj9g5V5mRx5G1yvcvX0iN
         Slcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErSQ5CrQeSkmLUbZHQvgt43whunrTwbaNcEcHojj/F0=;
        b=aZjKBkyF3lsJp74OeQ/PSMvy++nhQU7Eusc3HZejwJJyekVejzaylyrNEc335vE/Hz
         5zVoz7R4fpjUuZW5EajZ/Isf5qYXP1JnotqEh5n/eRgFPHhqAYfgKRMNNDSpqygsCMVE
         pdqaO3ZY3/i8GGcPf8XSjl9VgAJ5pdsP2nqOxqcY9my5IHCbtvikmW2WVIH13DDhCZgk
         n+CzOX0HMl9Scmk7P08AmB774WzhEFlytylBsJfNLYp+Mjm8zgiprJkQXp+qzHPLik9i
         3Ox4PrZn5EXt631OrPvw0QCCaH3z0BmKo9NysmgkQypxHI1TsVlx2eIzMwQYCmWqd5s7
         cH+g==
X-Gm-Message-State: AOAM533bDRQBAtnlTgrQ5MOaATmnNN8nPqwrqOITAg0kN7QtSElAHL15
        N9WXKXgiyKR407Grgu8LJ8XT0ziR0lr13E72YWmG+A==
X-Google-Smtp-Source: ABdhPJyFooqk3QJhmp9xEqMlJWlYya+dgKhKFj39pBOPgPsVPxI0OQtOdHjIYjwZ9h/nmENxRVtkMKSYNvX1hUyq2xc=
X-Received: by 2002:a25:b3c7:: with SMTP id x7mr2296339ybf.34.1635523670005;
 Fri, 29 Oct 2021 09:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com> <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
In-Reply-To: <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 29 Oct 2021 09:07:39 -0700
Message-ID: <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
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

On Fri, Oct 29, 2021 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 27-10-21 09:08:21, Suren Baghdasaryan wrote:
> > On Fri, Oct 22, 2021 at 10:38 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Fri, Oct 22, 2021 at 1:03 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Thu 21-10-21 18:46:58, Suren Baghdasaryan wrote:
> > > > > Race between process_mrelease and exit_mmap, where free_pgtables is
> > > > > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > > > > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > > > > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > > > > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > > > > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > > > > fix this race, however that would be considered a hack. Fix this race
> > > > > by elevating mm->mm_users and preventing exit_mmap from executing until
> > > > > process_mrelease is finished. Patch slightly refactors the code to adapt
> > > > > for a possible mmget_not_zero failure.
> > > > > This fix has considerable negative impact on process_mrelease performance
> > > > > and will likely need later optimization.
> > > >
> > > > I am not sure there is any promise that process_mrelease will run in
> > > > parallel with the exiting process. In fact the primary purpose of this
> > > > syscall is to provide a reliable way to oom kill from user space. If you
> > > > want to optimize process exit resp. its exit_mmap part then you should
> > > > be using other means. So I would be careful calling this a regression.
> > > >
> > > > I do agree that taking the reference count is the right approach here. I
> > > > was wrong previously [1] when saying that pinning the mm struct is
> > > > sufficient. I have completely forgot about the subtle sync in exit_mmap.
> > > > One way we can approach that would be to take exclusive mmap_sem
> > > > throughout the exit_mmap unconditionally.
> > >
> > > I agree, that would probably be the cleanest way.
> > >
> > > > There was a push back against
> > > > that though so arguments would have to be re-evaluated.
> > >
> > > I'll review that discussion to better understand the reasons for the
> > > push back. Thanks for the link.
> >
> > Adding Kirill and Andrea.
> >
> > I had some time to dig some more. The latency increase is definitely
> > coming due to process_mrelease calling the last mmput and exit_aio is
> > especially problematic. So, currently process_mrelease not only
> > releases memory but does more, including waiting for io to finish.
>
> Well, I still do not see why that is a problem. This syscall is meant to
> release the address space not to do it fast.

It's the same problem for a userspace memory reaper as for the
oom-reaper. The goal is to release the memory of the victim and to
quickly move on to the next one if needed.

>
> > Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
> > to me the most semantically correct way forward and the pushback is on
> > the basis of regressing performance of the exit path. I would like to
> > measure that regression to confirm this. I don't have access to a big
> > machine but will ask someone in another Google team to try the test
> > Michal wrote here
> > https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
> > a server with and without a custom patch.
>
> Well, I do not remember all the details of the discussion but I believe
> a rather large part of that discussion was a bit misled. The exist
> path - and the last mmput in particular - shouldn't trigger mmap_sem
> contention. There are only rare cases where somebody can race and take a
> lock then (e.g. proc interfaces taking the lock before mmget_notzero).
> Certainly not something to optimize for and I believe a correct and
> robust code should have a preference. As we can see a lack of proper
> synchronization has led to 2 very similar problem nobody revealed during
> review because the code is just too tricky.

I totally agree that this locking is tricky and mmap_sem contention
should be very rare in the exit_mmap path and not worth optimizing.

>
> Btw. the above code will not really tell you much on a larger machine
> unless you manage to trigger mmap_sem contection. Otherwise you are
> measuring the mmap_sem writelock fast path and that should be really
> within a noise comparing to the whole address space destruction time. If
> that is not the case then we have a real problem with the locking...

My understanding of that discussion is that the concern was that even
taking uncontended mmap_sem writelock would regress the exit path.
That was what I wanted to confirm. Am I misreading it?
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
