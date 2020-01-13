Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467991398C8
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 19:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMSXA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 13:23:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54154 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgAMSW7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 13:22:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so10845614wmc.3;
        Mon, 13 Jan 2020 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=HvtNipEFRvSqP3jaFfF+/gzI7x9srFsAsvwnNexCPMc=;
        b=nOHgIXNYeLFlLcv0Fue8Gotajx+Py8tA/okmELVAncD7GUCeDe5V09UonLz2xSctXU
         7si/5XixaR2TvwewBS73rb5PmMe4cs5H7pJBhfske3AVX8tyv+2kUNHZ18MfjV0mtW/K
         Jw+LQ36CaKPWgbOanQfM+f8+PrC7sGM3NMUzx1Q9DtFpsF62AWd77IH4H4LjsDrLb6Rq
         vGDGC2KwYmKhGnC3b4uhQVmxiolQ2+P+W7qAw3utEwEwcJE852c0UKpDZNJN6hKR+iCb
         CSvEBfj3wS1IBxW8dt43cOWssAg0wq0kCP6Bv+OfgnNMysBeq6F3py27cZEk9TMDPtu8
         NcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=HvtNipEFRvSqP3jaFfF+/gzI7x9srFsAsvwnNexCPMc=;
        b=fTzt80l5iqPOxVhDO08v5zO9pCcTRNbMZcSJmISQ9YxluFJlzLPkzR6Dw4C7H47d/a
         LhjIxsDmd3CIC+Jn++vJIc95hYW/H6hv+gji7L09BoDswmwZGMWkJ6CAlgK4PKDuCX65
         HOpDG1RIARr99n33p1hxbtHHmsx9CFSx2gPyIWoerB/sggqwIhwd37Rsw9ArYM7rrP1G
         fYVHyZ/DrLeJh3Ux1pZB8IXfgr94Am8C4ypclhz74M6YDkxrobvAGOqJtdSAli+EZRAg
         JDzRClUacYl3EaC8W28LISIAa+Cm+P/XJ6Ev1BmxP62c9l2KAFOV0LxosQK3JWDfDjlA
         2erQ==
X-Gm-Message-State: APjAAAVYNtszgYFTsLM4Wn9Scuu6GUdyu5dKPE3smkzyXhYtLWCVG5yg
        8+ssnR3ORqfrPeybUfWAJVk=
X-Google-Smtp-Source: APXvYqxbJXaeJAkyiPwUvQZXmSaI4fr5dpfHpmQFKjKeS0kg9B4Eph7t9CzIDCbzgj3EYt3LgqrSgA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr21892071wmb.80.1578939777017;
        Mon, 13 Jan 2020 10:22:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:b860:a52e:b647:77fe])
        by smtp.gmail.com with ESMTPSA id c2sm16021893wrp.46.2020.01.13.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:22:56 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: Re: [PATCH 1/4] mm: factor out madvise's core functionality
Date:   Mon, 13 Jan 2020 19:22:45 +0100
Message-Id: <20200113182245.30455-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113181118.GB110363@google.com> (raw)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 13 Jan 2020 10:11:18 -0800 Minchan Kim <minchan@kernel.org> wrote:

> On Sat, Jan 11, 2020 at 08:37:37AM +0100, SeongJae Park wrote:
> > On Fri, 10 Jan 2020 13:34:30 -0800 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > This patch factor out madvise's core functionality so that upcoming
> > > patch can reuse it without duplication. It shouldn't change any behavior.
> > > 
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  mm/madvise.c | 194 +++++++++++++++++++++++++++++----------------------
> > >  1 file changed, 111 insertions(+), 83 deletions(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index bcdb6a042787..0c901de531e4 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -35,6 +35,7 @@
> > >  struct madvise_walk_private {
> > >  	struct mmu_gather *tlb;
> > >  	bool pageout;
> > > +	struct task_struct *task;
> > >  };
> > >  
> > >  /*
> > > @@ -306,12 +307,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> > >  	bool pageout = private->pageout;
> > >  	struct mm_struct *mm = tlb->mm;
> > >  	struct vm_area_struct *vma = walk->vma;
> > > +	struct task_struct *task = private->task;
> > >  	pte_t *orig_pte, *pte, ptent;
> > >  	spinlock_t *ptl;
> > >  	struct page *page = NULL;
> > >  	LIST_HEAD(page_list);
> > >  
> > > -	if (fatal_signal_pending(current))
> > > +	if (fatal_signal_pending(task))
> > >  		return -EINTR;
> > >  
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > @@ -469,12 +471,14 @@ static const struct mm_walk_ops cold_walk_ops = {
> > >  };
> > >  
> > >  static void madvise_cold_page_range(struct mmu_gather *tlb,
> > > +			     struct task_struct *task,
> > >  			     struct vm_area_struct *vma,
> > >  			     unsigned long addr, unsigned long end)
> > >  {
> > >  	struct madvise_walk_private walk_private = {
> > >  		.pageout = false,
> > >  		.tlb = tlb,
> > > +		.task = task,
> > >  	};
> > >  
> > >  	tlb_start_vma(tlb, vma);
> > > @@ -482,7 +486,7 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
> > >  	tlb_end_vma(tlb, vma);
> > >  }
> > >  
> > > -static long madvise_cold(struct vm_area_struct *vma,
> > > +static long madvise_cold(struct task_struct *task, struct vm_area_struct *vma,
> > >  			struct vm_area_struct **prev,
> > >  			unsigned long start_addr, unsigned long end_addr)
> > >  {
> > > @@ -495,19 +499,21 @@ static long madvise_cold(struct vm_area_struct *vma,
> > >  
> > >  	lru_add_drain();
> > >  	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> > > -	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
> > > +	madvise_cold_page_range(&tlb, task, vma, start_addr, end_addr);
> > >  	tlb_finish_mmu(&tlb, start_addr, end_addr);
> > >  
> > >  	return 0;
> > >  }
> > >  
> > >  static void madvise_pageout_page_range(struct mmu_gather *tlb,
> > > +			     struct task_struct *task,
> > >  			     struct vm_area_struct *vma,
> > >  			     unsigned long addr, unsigned long end)
> > >  {
> > >  	struct madvise_walk_private walk_private = {
> > >  		.pageout = true,
> > >  		.tlb = tlb,
> > > +		.task = task,
> > >  	};
> > >  
> > >  	tlb_start_vma(tlb, vma);
> > > @@ -531,9 +537,9 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
> > >  		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
> > >  }
> > >  
> > > -static long madvise_pageout(struct vm_area_struct *vma,
> > > -			struct vm_area_struct **prev,
> > > -			unsigned long start_addr, unsigned long end_addr)
> > > +static long madvise_pageout(struct task_struct *task,
> > > +		struct vm_area_struct *vma, struct vm_area_struct **prev,
> > > +		unsigned long start_addr, unsigned long end_addr)
> > >  {
> > >  	struct mm_struct *mm = vma->vm_mm;
> > >  	struct mmu_gather tlb;
> > > @@ -547,7 +553,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
> > >  
> > >  	lru_add_drain();
> > >  	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> > > -	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> > > +	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
> > >  	tlb_finish_mmu(&tlb, start_addr, end_addr);
> > >  
> > >  	return 0;
> > > @@ -751,7 +757,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> > >  	return 0;
> > >  }
> > >  
> > > -static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > +static long madvise_dontneed_free(struct mm_struct *mm,
> > > +				  struct vm_area_struct *vma,
> > >  				  struct vm_area_struct **prev,
> > >  				  unsigned long start, unsigned long end,
> > >  				  int behavior)
> > > @@ -763,8 +770,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >  	if (!userfaultfd_remove(vma, start, end)) {
> > >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> > >  
> > > -		down_read(&current->mm->mmap_sem);
> > > -		vma = find_vma(current->mm, start);
> > > +		down_read(&mm->mmap_sem);
> > > +		vma = find_vma(mm, start);
> > >  		if (!vma)
> > >  			return -ENOMEM;
> > >  		if (start < vma->vm_start) {
> > > @@ -811,7 +818,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >   * Application wants to free up the pages and associated backing store.
> > >   * This is effectively punching a hole into the middle of a file.
> > >   */
> > > -static long madvise_remove(struct vm_area_struct *vma,
> > > +static long madvise_remove(struct mm_struct *mm,
> > > +				struct vm_area_struct *vma,
> > >  				struct vm_area_struct **prev,
> > >  				unsigned long start, unsigned long end)
> > >  {
> > > @@ -845,13 +853,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> > >  	get_file(f);
> > >  	if (userfaultfd_remove(vma, start, end)) {
> > >  		/* mmap_sem was not released by userfaultfd_remove() */
> > > -		up_read(&current->mm->mmap_sem);
> > > +		up_read(&mm->mmap_sem);
> > >  	}
> > >  	error = vfs_fallocate(f,
> > >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > >  				offset, end - start);
> > >  	fput(f);
> > > -	down_read(&current->mm->mmap_sem);
> > > +	down_read(&mm->mmap_sem);
> > >  	return error;
> > >  }
> > >  
> > > @@ -925,21 +933,23 @@ static int madvise_inject_error(int behavior,
> > >  #endif
> > >  
> > >  static long
> > > -madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
> > > +madvise_vma(struct task_struct *task, struct mm_struct *mm,
> > > +		struct vm_area_struct *vma, struct vm_area_struct **prev,
> > >  		unsigned long start, unsigned long end, int behavior)
> > >  {
> > >  	switch (behavior) {
> > >  	case MADV_REMOVE:
> > > -		return madvise_remove(vma, prev, start, end);
> > > +		return madvise_remove(mm, vma, prev, start, end);
> > >  	case MADV_WILLNEED:
> > >  		return madvise_willneed(vma, prev, start, end);
> > >  	case MADV_COLD:
> > > -		return madvise_cold(vma, prev, start, end);
> > > +		return madvise_cold(task, vma, prev, start, end);
> > >  	case MADV_PAGEOUT:
> > > -		return madvise_pageout(vma, prev, start, end);
> > > +		return madvise_pageout(task, vma, prev, start, end);
> > >  	case MADV_FREE:
> > >  	case MADV_DONTNEED:
> > > -		return madvise_dontneed_free(vma, prev, start, end, behavior);
> > > +		return madvise_dontneed_free(mm, vma, prev, start,
> > > +						end, behavior);
> > >  	default:
> > >  		return madvise_behavior(vma, prev, start, end, behavior);
> > >  	}
> > > @@ -984,67 +994,19 @@ madvise_behavior_valid(int behavior)
> > >  }
> > >  
> > >  /*
> > > - * The madvise(2) system call.
> > > + * madvise_common - request behavior hint to address range of the target process
> > >   *
> > > - * Applications can use madvise() to advise the kernel how it should
> > > - * handle paging I/O in this VM area.  The idea is to help the kernel
> > > - * use appropriate read-ahead and caching techniques.  The information
> > > - * provided is advisory only, and can be safely disregarded by the
> > > - * kernel without affecting the correct operation of the application.
> > > + * @task: task_struct got behavior hint, not giving the hint
> > > + * @mm: mm_struct got behavior hint, not giving the hint
> > > + * @start: base address of the hinted range
> > > + * @len_in: length of the hinted range
> > > + * @behavior: requested hint
> > >   *
> > > - * behavior values:
> > > - *  MADV_NORMAL - the default behavior is to read clusters.  This
> > > - *		results in some read-ahead and read-behind.
> > > - *  MADV_RANDOM - the system should read the minimum amount of data
> > > - *		on any access, since it is unlikely that the appli-
> > > - *		cation will need more than what it asks for.
> > > - *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
> > > - *		once, so they can be aggressively read ahead, and
> > > - *		can be freed soon after they are accessed.
> > > - *  MADV_WILLNEED - the application is notifying the system to read
> > > - *		some pages ahead.
> > > - *  MADV_DONTNEED - the application is finished with the given range,
> > > - *		so the kernel can free resources associated with it.
> > > - *  MADV_FREE - the application marks pages in the given range as lazy free,
> > > - *		where actual purges are postponed until memory pressure happens.
> > > - *  MADV_REMOVE - the application wants to free up the given range of
> > > - *		pages and associated backing store.
> > > - *  MADV_DONTFORK - omit this area from child's address space when forking:
> > > - *		typically, to avoid COWing pages pinned by get_user_pages().
> > > - *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
> > > - *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
> > > - *              range after a fork.
> > > - *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
> > > - *  MADV_HWPOISON - trigger memory error handler as if the given memory range
> > > - *		were corrupted by unrecoverable hardware memory failure.
> > > - *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
> > > - *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
> > > - *		this area with pages of identical content from other such areas.
> > > - *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
> > > - *  MADV_HUGEPAGE - the application wants to back the given range by transparent
> > > - *		huge pages in the future. Existing pages might be coalesced and
> > > - *		new pages might be allocated as THP.
> > > - *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
> > > - *		transparent huge pages so the existing pages will not be
> > > - *		coalesced into THP and new pages will not be allocated as THP.
> > > - *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> > > - *		from being included in its core dump.
> > > - *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> > > - *
> > > - * return values:
> > > - *  zero    - success
> > > - *  -EINVAL - start + len < 0, start is not page-aligned,
> > > - *		"behavior" is not a valid value, or application
> > > - *		is attempting to release locked or shared pages,
> > > - *		or the specified address range includes file, Huge TLB,
> > > - *		MAP_SHARED or VMPFNMAP range.
> > > - *  -ENOMEM - addresses in the specified range are not currently
> > > - *		mapped, or are outside the AS of the process.
> > > - *  -EIO    - an I/O error occurred while paging in data.
> > > - *  -EBADF  - map exists, but area maps something that isn't a file.
> > > - *  -EAGAIN - a kernel resource was temporarily unavailable.
> > > + * @task could be a zombie leader if it calls sys_exit so accessing mm_struct
> > > + * via task->mm is prohibited. Please use @mm instead of task->mm.
> > >   */
> > > -SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > > +static int madvise_common(struct task_struct *task, struct mm_struct *mm,
> > > +			unsigned long start, size_t len_in, int behavior)
> > >  {
> > >  	unsigned long end, tmp;
> > >  	struct vm_area_struct *vma, *prev;
> > > @@ -1082,10 +1044,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > >  
> > >  	write = madvise_need_mmap_write(behavior);
> > >  	if (write) {
> > > -		if (down_write_killable(&current->mm->mmap_sem))
> > > +		if (down_write_killable(&mm->mmap_sem))
> > >  			return -EINTR;
> > >  	} else {
> > > -		down_read(&current->mm->mmap_sem);
> > > +		down_read(&mm->mmap_sem);
> > >  	}
> > >  
> > >  	/*
> > > @@ -1093,7 +1055,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > >  	 * ranges, just ignore them, but return -ENOMEM at the end.
> > >  	 * - different from the way of handling in mlock etc.
> > >  	 */
> > > -	vma = find_vma_prev(current->mm, start, &prev);
> > > +	vma = find_vma_prev(mm, start, &prev);
> > >  	if (vma && start > vma->vm_start)
> > >  		prev = vma;
> > >  
> > > @@ -1118,7 +1080,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > >  			tmp = end;
> > >  
> > >  		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> > > -		error = madvise_vma(vma, &prev, start, tmp, behavior);
> > > +		error = madvise_vma(task, mm, vma, &prev, start, tmp, behavior);
> > >  		if (error)
> > >  			goto out;
> > >  		start = tmp;
> > > @@ -1130,14 +1092,80 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > >  		if (prev)
> > >  			vma = prev->vm_next;
> > >  		else	/* madvise_remove dropped mmap_sem */
> > > -			vma = find_vma(current->mm, start);
> > > +			vma = find_vma(mm, start);
> > >  	}
> > >  out:
> > >  	blk_finish_plug(&plug);
> > >  	if (write)
> > > -		up_write(&current->mm->mmap_sem);
> > > +		up_write(&mm->mmap_sem);
> > >  	else
> > > -		up_read(&current->mm->mmap_sem);
> > > +		up_read(&mm->mmap_sem);
> > >  
> > >  	return error;
> > >  }
> > > +
> > > +/*
> > > + * The madvise(2) system call.
> > > + *
> > > + * Applications can use madvise() to advise the kernel how it should
> > > + * handle paging I/O in this VM area.  The idea is to help the kernel
> > > + * use appropriate read-ahead and caching techniques.  The information
> > > + * provided is advisory only, and can be safely disregarded by the
> > > + * kernel without affecting the correct operation of the application.
> > > + *
> > > + * behavior values:
> > > + *  MADV_NORMAL - the default behavior is to read clusters.  This
> > > + *		results in some read-ahead and read-behind.
> > > + *  MADV_RANDOM - the system should read the minimum amount of data
> > > + *		on any access, since it is unlikely that the appli-
> > > + *		cation will need more than what it asks for.
> > > + *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
> > > + *		once, so they can be aggressively read ahead, and
> > > + *		can be freed soon after they are accessed.
> > > + *  MADV_WILLNEED - the application is notifying the system to read
> > > + *		some pages ahead.
> > > + *  MADV_DONTNEED - the application is finished with the given range,
> > > + *		so the kernel can free resources associated with it.
> > > + *  MADV_FREE - the application marks pages in the given range as lazy free,
> > > + *		where actual purges are postponed until memory pressure happens.
> > > + *  MADV_REMOVE - the application wants to free up the given range of
> > > + *		pages and associated backing store.
> > > + *  MADV_DONTFORK - omit this area from child's address space when forking:
> > > + *		typically, to avoid COWing pages pinned by get_user_pages().
> > > + *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
> > > + *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
> > > + *              range after a fork.
> > > + *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
> > > + *  MADV_HWPOISON - trigger memory error handler as if the given memory range
> > > + *		were corrupted by unrecoverable hardware memory failure.
> > > + *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
> > > + *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
> > > + *		this area with pages of identical content from other such areas.
> > > + *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
> > > + *  MADV_HUGEPAGE - the application wants to back the given range by transparent
> > > + *		huge pages in the future. Existing pages might be coalesced and
> > > + *		new pages might be allocated as THP.
> > > + *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
> > > + *		transparent huge pages so the existing pages will not be
> > > + *		coalesced into THP and new pages will not be allocated as THP.
> > > + *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> > > + *		from being included in its core dump.
> > > + *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> > 
> > Just a trivial suggestion.  How about adding brief descriptions for the
> > 'MADV_COLD' and 'MADV_PAGEOUT' here, probably with another patch?
> 
> How about this?
> Feel free to suggest better wording.
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 3aa9aec6bfd9..78b3ab789486 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1169,6 +1169,10 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *  MADV_COLD - the application uses the memory less so the kernel can deactivate
> + *  		the memory to evict them quickly when the memory pressure happen.
> + *  MADV_PAGEOUT - the application uses the memroy very rarely so kernel can
> + *  		page out the memory instantly.

Looks good to me :)


Thanks,
SeongJae Park

>   *
>   * return values:
>   *  zero    - success
> 
> Thanks.
> 
