Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533B4437607
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 13:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJVLir (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Oct 2021 07:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVLir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Oct 2021 07:38:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A6FC061764;
        Fri, 22 Oct 2021 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gsZ+nLWyBIna108xOOIecsn9ocyuHW1CISzlhCPjGmQ=; b=a0AtMxlGdNPTYSiaTp/erPdbqC
        gdMR/KLJvKWzX+zunQTaU1yLMWrigF8O48qeteOI0+CpUzHkmq/2DOD9GK8uVdv1mjQtmbyPX3Gmf
        980FB3ES2jlGfBPINIf3iezq8aKAzx54e0HrHTVE6mmsEs1GGlpKIYdeEgAU/Mvx6MRIT/YKGKw1f
        tz4ctcn1hTnpsZFGIecQzTUMNpPWyCQbSq4Tln/nDDmcI08f/f4FeLctGLSUuhGt0fbRf2E83we3H
        W/8LSHjsILlCto+tGLm1MnD0Xa/pC4KToNWXss63p/rU52AlEtq2ut8qtvi+FZ5GX5nlYWQ7B0lZq
        k+nfTT5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdsmO-00DsIl-IS; Fri, 22 Oct 2021 11:32:22 +0000
Date:   Fri, 22 Oct 2021 12:32:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <YXKhOKIIngIuJaYi@casper.infradead.org>
References: <20211022014658.263508-1-surenb@google.com>
 <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 22, 2021 at 10:03:29AM +0200, Michal Hocko wrote:
> On Thu 21-10-21 18:46:58, Suren Baghdasaryan wrote:
> > Race between process_mrelease and exit_mmap, where free_pgtables is
> > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > fix this race, however that would be considered a hack. Fix this race
> > by elevating mm->mm_users and preventing exit_mmap from executing until
> > process_mrelease is finished. Patch slightly refactors the code to adapt
> > for a possible mmget_not_zero failure.
> > This fix has considerable negative impact on process_mrelease performance
> > and will likely need later optimization.
> 
> I am not sure there is any promise that process_mrelease will run in
> parallel with the exiting process. In fact the primary purpose of this
> syscall is to provide a reliable way to oom kill from user space. If you
> want to optimize process exit resp. its exit_mmap part then you should
> be using other means. So I would be careful calling this a regression.
> 
> I do agree that taking the reference count is the right approach here. I
> was wrong previously [1] when saying that pinning the mm struct is
> sufficient. I have completely forgot about the subtle sync in exit_mmap.
> One way we can approach that would be to take exclusive mmap_sem
> throughout the exit_mmap unconditionally. There was a push back against
> that though so arguments would have to be re-evaluated.

I have another reason for wanting to take the mmap_sem throughout
exit_mmap.  Liam and I are working on using the Maple tree to replace
the rbtree & vma linked list.  It uses lockdep to check that you haven't
forgotten to take a lock (as of two days ago, that mean the mmap_sem
or the RCU read lock) when walking the tree.

So I'd like to hold it over:

 - unlock_range()
 - unmap_vmas()
 - free_pgtables()
 - while (vma) remove_vma()

Which is basically the whole of exit_mmap().  I'd like to know more
about why there was pushback on holding the mmap_lock across this
-- we're exiting, so nobody else should have a reference to the mm?
