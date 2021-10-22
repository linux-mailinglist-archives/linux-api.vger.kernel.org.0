Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4F43765B
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 14:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJVMGs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Oct 2021 08:06:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhJVMGr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Oct 2021 08:06:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8F9C21983;
        Fri, 22 Oct 2021 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634904268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9x+TRkgC4tzH4TgjCK7sVhgC5F3Aew81sGEOoXA6tA=;
        b=eZzyWW/49xz88I+SIQPEwgELpiQoeI9/I+zOzwBJVBEH/J14rcGLCeXWMYvCMY8J/TqlWX
        h5ip56Oqg9Y/ke4gBsG6qvzh4Ip9YH5+aFC0Ga0PC9rAK5PEIa6bVV9Cgmtk0PwFd1nB10
        Cxh/zeJeWu4BYF6jGD9MnYbgCMMwGRc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 769ACA3B81;
        Fri, 22 Oct 2021 12:04:27 +0000 (UTC)
Date:   Fri, 22 Oct 2021 14:04:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YXKoyAKe7xCqk7gW@dhcp22.suse.cz>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <YXKhOKIIngIuJaYi@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXKhOKIIngIuJaYi@casper.infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 22-10-21 12:32:08, Matthew Wilcox wrote:
> On Fri, Oct 22, 2021 at 10:03:29AM +0200, Michal Hocko wrote:
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
> > throughout the exit_mmap unconditionally. There was a push back against
> > that though so arguments would have to be re-evaluated.
> 
> I have another reason for wanting to take the mmap_sem throughout
> exit_mmap.  Liam and I are working on using the Maple tree to replace
> the rbtree & vma linked list.  It uses lockdep to check that you haven't
> forgotten to take a lock (as of two days ago, that mean the mmap_sem
> or the RCU read lock) when walking the tree.
> 
> So I'd like to hold it over:
> 
>  - unlock_range()
>  - unmap_vmas()
>  - free_pgtables()
>  - while (vma) remove_vma()
> 
> Which is basically the whole of exit_mmap().  I'd like to know more
> about why there was pushback on holding the mmap_lock across this
> -- we're exiting, so nobody else should have a reference to the mm?

https://lore.kernel.org/all/20170724072332.31903-1-mhocko@kernel.org/
-- 
Michal Hocko
SUSE Labs
