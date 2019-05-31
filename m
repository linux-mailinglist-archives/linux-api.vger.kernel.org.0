Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F2317F6
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2019 01:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEaXaK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 19:30:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36024 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfEaXaJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 19:30:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so4598166plr.3;
        Fri, 31 May 2019 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNhsBgywa5VuU8Hn6YMSdSM+AD/LEdQUoRBioHXvAlc=;
        b=u1rSZYVmjf7bHH4JfjlmBuUK66jXbkbA2RYGdtNPg3LFcwcku2c27Vs7dwh+2FNxnb
         YuHQgYn0Arq6e0DXg098JSW1sWeNXNPdR4A6uU5KMBOxHG3n2KqJHKc5YF0zcdDkiBl1
         QnQIy/asYhQ/n7YRK5B/YdEE8QuqZr50UIa6P5BFs/Bou5i1y3wKsxVUlSKooM4WFttt
         XxFbUvyibDR1BGPom3B1AXnje8ytlGY6ScuhJx+OrzqOA8lSdKRCaR4jVkQ3mTErc2+a
         NYTLpSH0wLFpvLV9+rk6URFU3pkibJxh/SGaz8NMF8KGA919Hb069l++AjqUiMc6tHuh
         q/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNhsBgywa5VuU8Hn6YMSdSM+AD/LEdQUoRBioHXvAlc=;
        b=eNPoe7rc8u/PdUCKxSdu+d1vPkD/Yzwkc03gWVHl3eoYezgSAK938m/DlHpAoQDDxk
         KcQeleeFnU7DFXATFrNZcVkmEf3GFnNAE8KmAvjpcOeaG207R6eXgLVE8BxtmasRhzuu
         HyjXBIXtS+DTopt7IoDeasPAdIj2+eeMk/QVtcls57vasjsFOrCTYR7Idi7liV1QV1zB
         1VKUgg6uLRcw2vF3Zz0z9JL+o2eyxWj80hzluk+BI5hEj+j+XITSV/WYodqhX0Zx0I0s
         QQGK+79sRNYytZaS7YqwtlGCOBWj2Vgy6j/KxVjVQKRsTaxsu51jic1UKStSxIIt/moQ
         XYxQ==
X-Gm-Message-State: APjAAAXhgErPdGxJdiljID2VBePp8PyM8RUWb38CQ5DVztpvqEX48sYV
        +WvB9OhmmkcYE4WxR8LqdZU=
X-Google-Smtp-Source: APXvYqxAtz0MFD1upsWV5QXvIt/vyYzVuKAGrC62mpgUpbcIN49hT9YhP98Dkq2Gezy0zUrSmey4tA==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr8347051plp.305.1559345408709;
        Fri, 31 May 2019 16:30:08 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id p63sm6318428pgp.65.2019.05.31.16.30.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 16:30:07 -0700 (PDT)
Date:   Sat, 1 Jun 2019 08:29:59 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, hdanton@sina.com
Subject: Re: [RFCv2 4/6] mm: factor out madvise's core functionality
Message-ID: <20190531232959.GC248371@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-5-minchan@kernel.org>
 <20190531070420.m7sxybbzzayig44o@butterfly.localdomain>
 <20190531131226.GA195463@google.com>
 <20190531143545.jwmgzaigd4rbw2wy@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531143545.jwmgzaigd4rbw2wy@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 04:35:45PM +0200, Oleksandr Natalenko wrote:
> On Fri, May 31, 2019 at 10:12:26PM +0900, Minchan Kim wrote:
> > On Fri, May 31, 2019 at 09:04:20AM +0200, Oleksandr Natalenko wrote:
> > > On Fri, May 31, 2019 at 03:43:11PM +0900, Minchan Kim wrote:
> > > > This patch factor out madvise's core functionality so that upcoming
> > > > patch can reuse it without duplication. It shouldn't change any behavior.
> > > > 
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > ---
> > > >  mm/madvise.c | 188 +++++++++++++++++++++++++++------------------------
> > > >  1 file changed, 101 insertions(+), 87 deletions(-)
> > > > 
> > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > index 9d749a1420b4..466623ea8c36 100644
> > > > --- a/mm/madvise.c
> > > > +++ b/mm/madvise.c
> > > > @@ -425,9 +425,10 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> > > >  	struct page *page;
> > > >  	int isolated = 0;
> > > >  	struct vm_area_struct *vma = walk->vma;
> > > > +	struct task_struct *task = walk->private;
> > > >  	unsigned long next;
> > > >  
> > > > -	if (fatal_signal_pending(current))
> > > > +	if (fatal_signal_pending(task))
> > > >  		return -EINTR;
> > > >  
> > > >  	next = pmd_addr_end(addr, end);
> > > > @@ -505,12 +506,14 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> > > >  }
> > > >  
> > > >  static void madvise_pageout_page_range(struct mmu_gather *tlb,
> > > > -			     struct vm_area_struct *vma,
> > > > -			     unsigned long addr, unsigned long end)
> > > > +				struct task_struct *task,
> > > > +				struct vm_area_struct *vma,
> > > > +				unsigned long addr, unsigned long end)
> > > >  {
> > > >  	struct mm_walk warm_walk = {
> > > >  		.pmd_entry = madvise_pageout_pte_range,
> > > >  		.mm = vma->vm_mm,
> > > > +		.private = task,
> > > >  	};
> > > >  
> > > >  	tlb_start_vma(tlb, vma);
> > > > @@ -519,9 +522,9 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
> > > >  }
> > > >  
> > > >  
> > > > -static long madvise_pageout(struct vm_area_struct *vma,
> > > > -			struct vm_area_struct **prev,
> > > > -			unsigned long start_addr, unsigned long end_addr)
> > > > +static long madvise_pageout(struct task_struct *task,
> > > > +		struct vm_area_struct *vma, struct vm_area_struct **prev,
> > > > +		unsigned long start_addr, unsigned long end_addr)
> > > >  {
> > > >  	struct mm_struct *mm = vma->vm_mm;
> > > >  	struct mmu_gather tlb;
> > > > @@ -532,7 +535,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
> > > >  
> > > >  	lru_add_drain();
> > > >  	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> > > > -	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> > > > +	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
> > > >  	tlb_finish_mmu(&tlb, start_addr, end_addr);
> > > >  
> > > >  	return 0;
> > > > @@ -744,7 +747,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > > +static long madvise_dontneed_free(struct mm_struct *mm,
> > > > +				  struct vm_area_struct *vma,
> > > >  				  struct vm_area_struct **prev,
> > > >  				  unsigned long start, unsigned long end,
> > > >  				  int behavior)
> > > > @@ -756,8 +760,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > >  	if (!userfaultfd_remove(vma, start, end)) {
> > > >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> > > >  
> > > > -		down_read(&current->mm->mmap_sem);
> > > > -		vma = find_vma(current->mm, start);
> > > > +		down_read(&mm->mmap_sem);
> > > > +		vma = find_vma(mm, start);
> > > >  		if (!vma)
> > > >  			return -ENOMEM;
> > > >  		if (start < vma->vm_start) {
> > > > @@ -804,7 +808,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > > >   * Application wants to free up the pages and associated backing store.
> > > >   * This is effectively punching a hole into the middle of a file.
> > > >   */
> > > > -static long madvise_remove(struct vm_area_struct *vma,
> > > > +static long madvise_remove(struct mm_struct *mm,
> > > > +				struct vm_area_struct *vma,
> > > >  				struct vm_area_struct **prev,
> > > >  				unsigned long start, unsigned long end)
> > > >  {
> > > > @@ -838,13 +843,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> > > >  	get_file(f);
> > > >  	if (userfaultfd_remove(vma, start, end)) {
> > > >  		/* mmap_sem was not released by userfaultfd_remove() */
> > > > -		up_read(&current->mm->mmap_sem);
> > > > +		up_read(&mm->mmap_sem);
> > > >  	}
> > > >  	error = vfs_fallocate(f,
> > > >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > > >  				offset, end - start);
> > > >  	fput(f);
> > > > -	down_read(&current->mm->mmap_sem);
> > > > +	down_read(&mm->mmap_sem);
> > > >  	return error;
> > > >  }
> > > >  
> > > > @@ -918,21 +923,23 @@ static int madvise_inject_error(int behavior,
> > > >  #endif
> > > >  
> > > >  static long
> > > > -madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
> > > > +madvise_vma(struct task_struct *task, struct mm_struct *mm,
> > > > +		struct vm_area_struct *vma, struct vm_area_struct **prev,
> > > >  		unsigned long start, unsigned long end, int behavior)
> > > >  {
> > > >  	switch (behavior) {
> > > >  	case MADV_REMOVE:
> > > > -		return madvise_remove(vma, prev, start, end);
> > > > +		return madvise_remove(mm, vma, prev, start, end);
> > > >  	case MADV_WILLNEED:
> > > >  		return madvise_willneed(vma, prev, start, end);
> > > >  	case MADV_COLD:
> > > >  		return madvise_cold(vma, prev, start, end);
> > > >  	case MADV_PAGEOUT:
> > > > -		return madvise_pageout(vma, prev, start, end);
> > > > +		return madvise_pageout(task, vma, prev, start, end);
> > > >  	case MADV_FREE:
> > > >  	case MADV_DONTNEED:
> > > > -		return madvise_dontneed_free(vma, prev, start, end, behavior);
> > > > +		return madvise_dontneed_free(mm, vma, prev, start,
> > > > +						end, behavior);
> > > >  	default:
> > > >  		return madvise_behavior(vma, prev, start, end, behavior);
> > > >  	}
> > > > @@ -976,68 +983,8 @@ madvise_behavior_valid(int behavior)
> > > >  	}
> > > >  }
> > > >  
> > > > -/*
> > > > - * The madvise(2) system call.
> > > > - *
> > > > - * Applications can use madvise() to advise the kernel how it should
> > > > - * handle paging I/O in this VM area.  The idea is to help the kernel
> > > > - * use appropriate read-ahead and caching techniques.  The information
> > > > - * provided is advisory only, and can be safely disregarded by the
> > > > - * kernel without affecting the correct operation of the application.
> > > > - *
> > > > - * behavior values:
> > > > - *  MADV_NORMAL - the default behavior is to read clusters.  This
> > > > - *		results in some read-ahead and read-behind.
> > > > - *  MADV_RANDOM - the system should read the minimum amount of data
> > > > - *		on any access, since it is unlikely that the appli-
> > > > - *		cation will need more than what it asks for.
> > > > - *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
> > > > - *		once, so they can be aggressively read ahead, and
> > > > - *		can be freed soon after they are accessed.
> > > > - *  MADV_WILLNEED - the application is notifying the system to read
> > > > - *		some pages ahead.
> > > > - *  MADV_DONTNEED - the application is finished with the given range,
> > > > - *		so the kernel can free resources associated with it.
> > > > - *  MADV_FREE - the application marks pages in the given range as lazy free,
> > > > - *		where actual purges are postponed until memory pressure happens.
> > > > - *  MADV_REMOVE - the application wants to free up the given range of
> > > > - *		pages and associated backing store.
> > > > - *  MADV_DONTFORK - omit this area from child's address space when forking:
> > > > - *		typically, to avoid COWing pages pinned by get_user_pages().
> > > > - *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
> > > > - *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
> > > > - *              range after a fork.
> > > > - *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
> > > > - *  MADV_HWPOISON - trigger memory error handler as if the given memory range
> > > > - *		were corrupted by unrecoverable hardware memory failure.
> > > > - *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
> > > > - *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
> > > > - *		this area with pages of identical content from other such areas.
> > > > - *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
> > > > - *  MADV_HUGEPAGE - the application wants to back the given range by transparent
> > > > - *		huge pages in the future. Existing pages might be coalesced and
> > > > - *		new pages might be allocated as THP.
> > > > - *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
> > > > - *		transparent huge pages so the existing pages will not be
> > > > - *		coalesced into THP and new pages will not be allocated as THP.
> > > > - *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> > > > - *		from being included in its core dump.
> > > > - *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> > > > - *
> > > > - * return values:
> > > > - *  zero    - success
> > > > - *  -EINVAL - start + len < 0, start is not page-aligned,
> > > > - *		"behavior" is not a valid value, or application
> > > > - *		is attempting to release locked or shared pages,
> > > > - *		or the specified address range includes file, Huge TLB,
> > > > - *		MAP_SHARED or VMPFNMAP range.
> > > > - *  -ENOMEM - addresses in the specified range are not currently
> > > > - *		mapped, or are outside the AS of the process.
> > > > - *  -EIO    - an I/O error occurred while paging in data.
> > > > - *  -EBADF  - map exists, but area maps something that isn't a file.
> > > > - *  -EAGAIN - a kernel resource was temporarily unavailable.
> > > > - */
> > > > -SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > > > +static int madvise_core(struct task_struct *task, struct mm_struct *mm,
> > > > +			unsigned long start, size_t len_in, int behavior)
> > > 
> > > Just a minor nitpick, but can we please have it named madvise_common,
> > > not madvise_core? This would follow a usual naming scheme, when some
> > > common functionality is factored out (like, for mutexes, semaphores
> > > etc), and within the kernel "core" usually means something completely
> > > different.
> > 
> > Sure.
> > 
> > > 
> > > >  {
> > > >  	unsigned long end, tmp;
> > > >  	struct vm_area_struct *vma, *prev;
> > > > @@ -1068,15 +1015,16 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> > > >  
> > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > >  	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> > > > -		return madvise_inject_error(behavior, start, start + len_in);
> > > > +		return madvise_inject_error(behavior,
> > > > +					start, start + len_in);
> > > 
> > > Not sure what this change is about except changing the line length.
> > > Note, madvise_inject_error() still operates on "current" through
> > > get_user_pages_fast() and gup_pgd_range(), but that was not changed
> > > here. I Know you've filtered out this hint later, so technically this
> > > is not an issue, but, maybe, this needs some attention too since we've
> > > already spotted it?
> > 
> > It is leftover I had done. I actually modified it to handle remote
> > task but changed my mind not to fix it because process_madvise
> > will not support it at this moment. I'm not sure it's a good idea
> > to change it for *might-be-done-in-future* at this moment even though
> > we have spotted.
> 
> I'd expect to have at least some comments in code on why other hints
> are disabled, so if we already know some shortcomings, this information
> would not be lost.

Okay, I will add some comment but do not want to fix code piece until
someone want to expose the poisoning to external process.

> 
> Of course, I don't care much about memory poisoning, but if it can be
> addressed now, let's address it now.
> 
> > 
> > > 
> > > >  #endif
> > > >  
> > > >  	write = madvise_need_mmap_write(behavior);
> > > >  	if (write) {
> > > > -		if (down_write_killable(&current->mm->mmap_sem))
> > > > +		if (down_write_killable(&mm->mmap_sem))
> > > >  			return -EINTR;
> > > 
> > > Do you still need that trick with mmget_still_valid() here?
> > > Something like:
> > 
> > Since MADV_COLD|PAGEOUT doesn't change address space layout or
> > vma->vm_flags, technically, we don't need it if I understand
> > correctly. Right?
> 
> I'd expect so, yes. But.
> 
> Since we want this interface to be universal and to be able to cover
> various needs, and since my initial intention with working in this
> direction involved KSM, I'd ask you to enable KSM hints too, and once
> (and if) that happens, the work there is done under write lock, and
> you'll need this trick to be applied.
> 
> Of course, I can do that myself later in a subsequent patch series once
> (and, again, if) your series is merged, but, maybe, we can cover this
> already especially given the fact that KSM hinting is a relatively easy
> task in this pile. I did some preliminary tests with it, and so far no
> dragons have started to roar.

Then, do you mind sending a patch based upon this series to expose
MADV_MERGEABLE to process_madvise? It will have the right description
why you want to have such feature which I couldn't provide since I don't
have enough material to write the motivation. And the patch also could
include the logic to prevent coredump race, which is more proper since
finally we need to hold mmap_sem write-side lock, finally.
I will pick it up and will rebase since then.

Thanks.
