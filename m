Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD444B331
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 20:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbhKIT3o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 14:29:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48542 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbhKIT3n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 14:29:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4615B21B19;
        Tue,  9 Nov 2021 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636486016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dGLWLZhyTaoqPqSWizn7MZ7b7JNExdc0p33R4AoZluI=;
        b=XGbQQD7iF3W3OgSIc7k+qW8NoNf27eaW15sdDSxSnftbbymcGMf1yUsP3ebgnYs8kpcER2
        VRedNeDLlTDGPupMMX2GkyQu+VOesN9nwXkjL3lMR3Qjk9S7yiEWF342VfbnYstSFwXNib
        DMo33bC2sgwjtpXYRMh0uFpZsBk2biM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0E5A2A3B84;
        Tue,  9 Nov 2021 19:26:55 +0000 (UTC)
Date:   Tue, 9 Nov 2021 20:26:51 +0100
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
Message-ID: <YYrLe2u2zbmu4LfL@dhcp22.suse.cz>
References: <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
 <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
 <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
 <YYDvm9c/7cGtBvw6@dhcp22.suse.cz>
 <CAJuCfpFX8FRynoK29h8tpRXRT-Kk+sHboiBnc7N-8MY6AAqVLw@mail.gmail.com>
 <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFOOgs9uZSW2Tp6uBW23rLHFeSA8o5WYQ_D_ykUcKL64Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 09-11-21 11:01:02, Suren Baghdasaryan wrote:
[...]
> Discussing how the patch I want to post works for maple trees that
> Matthew is working on, I've got a question:
> 
> IIUC, according to Michal's post here:
> https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz,
> unmap_vmas() can race with other mmap_lock read holders (including
> oom_reap_task_mm()) with no issues.
> Maple tree patchset requires rcu read lock or the mmap semaphore be
> held (read or write side) when walking the tree, including inside
> unmap_vmas(). When asked, he told me that he is not sure why it's
> currently "safe" to walk the vma->vm_next list in unmap_vmas() while
> another thread is reaping the mm.
> Michal (or maybe someone else), could you please clarify why
> unmap_vmas() can safely race with oom_reap_task_mm()? Or maybe my
> understanding was wrong?

I cannot really comment on the mapple tree part. But the existing
synchronization between oom reaper and exit_mmap is based on
- oom_reaper takes mmap_sem for reading
- exit_mmap sets MMF_OOM_SKIP and takes the exclusive mmap_sem before 
  unmap_vmas.

The oom_reaper therefore can either unmap the address space if the lock
is taken before exit_mmap or it would it would bale out on MMF_OOM_SKIP
if it takes the lock afterwards. So the reaper cannot race with
unmap_vmas.

-- 
Michal Hocko
SUSE Labs
