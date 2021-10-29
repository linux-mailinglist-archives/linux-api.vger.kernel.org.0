Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FE43FCDF
	for <lists+linux-api@lfdr.de>; Fri, 29 Oct 2021 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJ2NFf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Oct 2021 09:05:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59330 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJ2NFf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 Oct 2021 09:05:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DA9F521637;
        Fri, 29 Oct 2021 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635512585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8vLN54XXV66/B0xEIvXjyPVMcsjYtcUPtaomk/kyRyw=;
        b=q/cjJq3HGhz/DPOoA9xxBDQkZPcz2A5xyMaznmQke8Iqbb/pwIfxSyfrposz8WKg7O18CO
        HlMROzace7Hgab5C2CRzOQSFImkvxQ2rZfD0jYxIg6+1rXNEmJaWSpvc0GLbiD4uzdTCr8
        bWuV0dCq9v2lcmD1P6ulUJBV0kbKbhI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F71FA3B84;
        Fri, 29 Oct 2021 13:03:04 +0000 (UTC)
Date:   Fri, 29 Oct 2021 15:03:01 +0200
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
Message-ID: <YXvxBSzA2YIxbwVC@dhcp22.suse.cz>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 27-10-21 09:08:21, Suren Baghdasaryan wrote:
> On Fri, Oct 22, 2021 at 10:38 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Oct 22, 2021 at 1:03 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 21-10-21 18:46:58, Suren Baghdasaryan wrote:
> > > > Race between process_mrelease and exit_mmap, where free_pgtables is
> > > > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > > > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > > > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > > > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > > > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > > > fix this race, however that would be considered a hack. Fix this race
> > > > by elevating mm->mm_users and preventing exit_mmap from executing until
> > > > process_mrelease is finished. Patch slightly refactors the code to adapt
> > > > for a possible mmget_not_zero failure.
> > > > This fix has considerable negative impact on process_mrelease performance
> > > > and will likely need later optimization.
> > >
> > > I am not sure there is any promise that process_mrelease will run in
> > > parallel with the exiting process. In fact the primary purpose of this
> > > syscall is to provide a reliable way to oom kill from user space. If you
> > > want to optimize process exit resp. its exit_mmap part then you should
> > > be using other means. So I would be careful calling this a regression.
> > >
> > > I do agree that taking the reference count is the right approach here. I
> > > was wrong previously [1] when saying that pinning the mm struct is
> > > sufficient. I have completely forgot about the subtle sync in exit_mmap.
> > > One way we can approach that would be to take exclusive mmap_sem
> > > throughout the exit_mmap unconditionally.
> >
> > I agree, that would probably be the cleanest way.
> >
> > > There was a push back against
> > > that though so arguments would have to be re-evaluated.
> >
> > I'll review that discussion to better understand the reasons for the
> > push back. Thanks for the link.
> 
> Adding Kirill and Andrea.
> 
> I had some time to dig some more. The latency increase is definitely
> coming due to process_mrelease calling the last mmput and exit_aio is
> especially problematic. So, currently process_mrelease not only
> releases memory but does more, including waiting for io to finish.

Well, I still do not see why that is a problem. This syscall is meant to
release the address space not to do it fast.

> Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
> to me the most semantically correct way forward and the pushback is on
> the basis of regressing performance of the exit path. I would like to
> measure that regression to confirm this. I don't have access to a big
> machine but will ask someone in another Google team to try the test
> Michal wrote here
> https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
> a server with and without a custom patch.

Well, I do not remember all the details of the discussion but I believe
a rather large part of that discussion was a bit misled. The exist
path - and the last mmput in particular - shouldn't trigger mmap_sem
contention. There are only rare cases where somebody can race and take a
lock then (e.g. proc interfaces taking the lock before mmget_notzero).
Certainly not something to optimize for and I believe a correct and
robust code should have a preference. As we can see a lack of proper
synchronization has led to 2 very similar problem nobody revealed during
review because the code is just too tricky.

Btw. the above code will not really tell you much on a larger machine
unless you manage to trigger mmap_sem contection. Otherwise you are
measuring the mmap_sem writelock fast path and that should be really
within a noise comparing to the whole address space destruction time. If
that is not the case then we have a real problem with the locking...
-- 
Michal Hocko
SUSE Labs
