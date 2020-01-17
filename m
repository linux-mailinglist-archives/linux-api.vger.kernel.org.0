Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35CB140740
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAQKDJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 05:03:09 -0500
Received: from relay.sw.ru ([185.231.240.75]:50980 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgAQKDJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 17 Jan 2020 05:03:09 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1isOSZ-00068G-7R; Fri, 17 Jan 2020 13:02:35 +0300
Subject: Re: [PATCH v2 1/5] mm: factor out madvise's core functionality
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de, "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-2-minchan@kernel.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d3b8431d-fa3d-6a16-8af1-a68b3ac8ca58@virtuozzo.com>
Date:   Fri, 17 Jan 2020 13:02:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116235953.163318-2-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17.01.2020 02:59, Minchan Kim wrote:
> This patch factor out madvise's core functionality so that upcoming
> patch can reuse it without duplication. It shouldn't change any behavior.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 194 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 111 insertions(+), 83 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bcdb6a042787..0c901de531e4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -35,6 +35,7 @@
>  struct madvise_walk_private {
>  	struct mmu_gather *tlb;
>  	bool pageout;
> +	struct task_struct *task;
>  };
>  
>  /*
> @@ -306,12 +307,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	bool pageout = private->pageout;
>  	struct mm_struct *mm = tlb->mm;
>  	struct vm_area_struct *vma = walk->vma;
> +	struct task_struct *task = private->task;
>  	pte_t *orig_pte, *pte, ptent;
>  	spinlock_t *ptl;
>  	struct page *page = NULL;
>  	LIST_HEAD(page_list);
>  
> -	if (fatal_signal_pending(current))
> +	if (fatal_signal_pending(task))
>  		return -EINTR;

This EINTR may confuse userspace. Users will think the syscall was interrupted,
and it may be restarted, but this is not true.

What we care here? Current task received fatal signal, while walk_page_range(..&cold_walk_ops..)
is a long cycle. So, this check allows to break the cycle faster.

Iteration over remote task's mm may also be long, and we still may need to break
it if current received a signal.

So, we'd better left fatal_signal_pending(current) here.

Maybe we need both tasks fatal_signal_pending() checks and different retvals here,
but it's up to you.

>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -469,12 +471,14 @@ static const struct mm_walk_ops cold_walk_ops = {
>  };
>  
>  static void madvise_cold_page_range(struct mmu_gather *tlb,
> +			     struct task_struct *task,
>  			     struct vm_area_struct *vma,
>  			     unsigned long addr, unsigned long end)
>  {
>  	struct madvise_walk_private walk_private = {
>  		.pageout = false,
>  		.tlb = tlb,
> +		.task = task,
>  	};
>  
>  	tlb_start_vma(tlb, vma);
> @@ -482,7 +486,7 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
>  	tlb_end_vma(tlb, vma);
>  }
>  
> -static long madvise_cold(struct vm_area_struct *vma,
> +static long madvise_cold(struct task_struct *task, struct vm_area_struct *vma,
>  			struct vm_area_struct **prev,
>  			unsigned long start_addr, unsigned long end_addr)
>  {
> @@ -495,19 +499,21 @@ static long madvise_cold(struct vm_area_struct *vma,
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> -	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
> +	madvise_cold_page_range(&tlb, task, vma, start_addr, end_addr);
>  	tlb_finish_mmu(&tlb, start_addr, end_addr);
>  
>  	return 0;
>  }
>  
>  static void madvise_pageout_page_range(struct mmu_gather *tlb,
> +			     struct task_struct *task,
>  			     struct vm_area_struct *vma,
>  			     unsigned long addr, unsigned long end)
>  {
>  	struct madvise_walk_private walk_private = {
>  		.pageout = true,
>  		.tlb = tlb,
> +		.task = task,
>  	};
>  
>  	tlb_start_vma(tlb, vma);
> @@ -531,9 +537,9 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
>  		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
>  }
>  
> -static long madvise_pageout(struct vm_area_struct *vma,
> -			struct vm_area_struct **prev,
> -			unsigned long start_addr, unsigned long end_addr)
> +static long madvise_pageout(struct task_struct *task,
> +		struct vm_area_struct *vma, struct vm_area_struct **prev,
> +		unsigned long start_addr, unsigned long end_addr)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_gather tlb;
> @@ -547,7 +553,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> -	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);

This is new remote VMA iteration.

I found Kirill Shutemov is not in CC. CC Kirill.

>  	tlb_finish_mmu(&tlb, start_addr, end_addr);
>  
>  	return 0;
> @@ -751,7 +757,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> -static long madvise_dontneed_free(struct vm_area_struct *vma,
> +static long madvise_dontneed_free(struct mm_struct *mm,
> +				  struct vm_area_struct *vma,
>  				  struct vm_area_struct **prev,
>  				  unsigned long start, unsigned long end,
>  				  int behavior)
> @@ -763,8 +770,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  	if (!userfaultfd_remove(vma, start, end)) {
>  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
>  
> -		down_read(&current->mm->mmap_sem);
> -		vma = find_vma(current->mm, start);
> +		down_read(&mm->mmap_sem);
> +		vma = find_vma(mm, start);
>  		if (!vma)
>  			return -ENOMEM;
>  		if (start < vma->vm_start) {
> @@ -811,7 +818,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>   * Application wants to free up the pages and associated backing store.
>   * This is effectively punching a hole into the middle of a file.
>   */
> -static long madvise_remove(struct vm_area_struct *vma,
> +static long madvise_remove(struct mm_struct *mm,
> +				struct vm_area_struct *vma,
>  				struct vm_area_struct **prev,
>  				unsigned long start, unsigned long end)
>  {
> @@ -845,13 +853,13 @@ static long madvise_remove(struct vm_area_struct *vma,
>  	get_file(f);
>  	if (userfaultfd_remove(vma, start, end)) {
>  		/* mmap_sem was not released by userfaultfd_remove() */
> -		up_read(&current->mm->mmap_sem);
> +		up_read(&mm->mmap_sem);
>  	}
>  	error = vfs_fallocate(f,
>  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>  				offset, end - start);
>  	fput(f);
> -	down_read(&current->mm->mmap_sem);
> +	down_read(&mm->mmap_sem);
>  	return error;
>  }
>  
> @@ -925,21 +933,23 @@ static int madvise_inject_error(int behavior,
>  #endif
>  
>  static long
> -madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
> +madvise_vma(struct task_struct *task, struct mm_struct *mm,
> +		struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		unsigned long start, unsigned long end, int behavior)
>  {
>  	switch (behavior) {
>  	case MADV_REMOVE:
> -		return madvise_remove(vma, prev, start, end);
> +		return madvise_remove(mm, vma, prev, start, end);
>  	case MADV_WILLNEED:
>  		return madvise_willneed(vma, prev, start, end);
>  	case MADV_COLD:
> -		return madvise_cold(vma, prev, start, end);
> +		return madvise_cold(task, vma, prev, start, end);
>  	case MADV_PAGEOUT:
> -		return madvise_pageout(vma, prev, start, end);
> +		return madvise_pageout(task, vma, prev, start, end);
>  	case MADV_FREE:
>  	case MADV_DONTNEED:
> -		return madvise_dontneed_free(vma, prev, start, end, behavior);
> +		return madvise_dontneed_free(mm, vma, prev, start,
> +						end, behavior);
>  	default:
>  		return madvise_behavior(vma, prev, start, end, behavior);
>  	}
> @@ -984,67 +994,19 @@ madvise_behavior_valid(int behavior)
>  }
>  
>  /*
> - * The madvise(2) system call.
> + * madvise_common - request behavior hint to address range of the target process
>   *
> - * Applications can use madvise() to advise the kernel how it should
> - * handle paging I/O in this VM area.  The idea is to help the kernel
> - * use appropriate read-ahead and caching techniques.  The information
> - * provided is advisory only, and can be safely disregarded by the
> - * kernel without affecting the correct operation of the application.
> + * @task: task_struct got behavior hint, not giving the hint
> + * @mm: mm_struct got behavior hint, not giving the hint
> + * @start: base address of the hinted range
> + * @len_in: length of the hinted range
> + * @behavior: requested hint
>   *
> - * behavior values:
> - *  MADV_NORMAL - the default behavior is to read clusters.  This
> - *		results in some read-ahead and read-behind.
> - *  MADV_RANDOM - the system should read the minimum amount of data
> - *		on any access, since it is unlikely that the appli-
> - *		cation will need more than what it asks for.
> - *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
> - *		once, so they can be aggressively read ahead, and
> - *		can be freed soon after they are accessed.
> - *  MADV_WILLNEED - the application is notifying the system to read
> - *		some pages ahead.
> - *  MADV_DONTNEED - the application is finished with the given range,
> - *		so the kernel can free resources associated with it.
> - *  MADV_FREE - the application marks pages in the given range as lazy free,
> - *		where actual purges are postponed until memory pressure happens.
> - *  MADV_REMOVE - the application wants to free up the given range of
> - *		pages and associated backing store.
> - *  MADV_DONTFORK - omit this area from child's address space when forking:
> - *		typically, to avoid COWing pages pinned by get_user_pages().
> - *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
> - *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
> - *              range after a fork.
> - *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
> - *  MADV_HWPOISON - trigger memory error handler as if the given memory range
> - *		were corrupted by unrecoverable hardware memory failure.
> - *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
> - *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
> - *		this area with pages of identical content from other such areas.
> - *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
> - *  MADV_HUGEPAGE - the application wants to back the given range by transparent
> - *		huge pages in the future. Existing pages might be coalesced and
> - *		new pages might be allocated as THP.
> - *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
> - *		transparent huge pages so the existing pages will not be
> - *		coalesced into THP and new pages will not be allocated as THP.
> - *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> - *		from being included in its core dump.
> - *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> - *
> - * return values:
> - *  zero    - success
> - *  -EINVAL - start + len < 0, start is not page-aligned,
> - *		"behavior" is not a valid value, or application
> - *		is attempting to release locked or shared pages,
> - *		or the specified address range includes file, Huge TLB,
> - *		MAP_SHARED or VMPFNMAP range.
> - *  -ENOMEM - addresses in the specified range are not currently
> - *		mapped, or are outside the AS of the process.
> - *  -EIO    - an I/O error occurred while paging in data.
> - *  -EBADF  - map exists, but area maps something that isn't a file.
> - *  -EAGAIN - a kernel resource was temporarily unavailable.
> + * @task could be a zombie leader if it calls sys_exit so accessing mm_struct
> + * via task->mm is prohibited. Please use @mm instead of task->mm.
>   */
> -SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> +static int madvise_common(struct task_struct *task, struct mm_struct *mm,
> +			unsigned long start, size_t len_in, int behavior)
>  {
>  	unsigned long end, tmp;
>  	struct vm_area_struct *vma, *prev;
> @@ -1082,10 +1044,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  
>  	write = madvise_need_mmap_write(behavior);
>  	if (write) {
> -		if (down_write_killable(&current->mm->mmap_sem))
> +		if (down_write_killable(&mm->mmap_sem))
>  			return -EINTR;
>  	} else {
> -		down_read(&current->mm->mmap_sem);
> +		down_read(&mm->mmap_sem);
>  	}
>  
>  	/*
> @@ -1093,7 +1055,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  	 * ranges, just ignore them, but return -ENOMEM at the end.
>  	 * - different from the way of handling in mlock etc.
>  	 */
> -	vma = find_vma_prev(current->mm, start, &prev);
> +	vma = find_vma_prev(mm, start, &prev);
>  	if (vma && start > vma->vm_start)
>  		prev = vma;
>  
> @@ -1118,7 +1080,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  			tmp = end;
>  
>  		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> -		error = madvise_vma(vma, &prev, start, tmp, behavior);
> +		error = madvise_vma(task, mm, vma, &prev, start, tmp, behavior);
>  		if (error)
>  			goto out;
>  		start = tmp;
> @@ -1130,14 +1092,80 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  		if (prev)
>  			vma = prev->vm_next;
>  		else	/* madvise_remove dropped mmap_sem */
> -			vma = find_vma(current->mm, start);
> +			vma = find_vma(mm, start);
>  	}
>  out:
>  	blk_finish_plug(&plug);
>  	if (write)
> -		up_write(&current->mm->mmap_sem);
> +		up_write(&mm->mmap_sem);
>  	else
> -		up_read(&current->mm->mmap_sem);
> +		up_read(&mm->mmap_sem);
>  
>  	return error;
>  }
> +
> +/*
> + * The madvise(2) system call.
> + *
> + * Applications can use madvise() to advise the kernel how it should
> + * handle paging I/O in this VM area.  The idea is to help the kernel
> + * use appropriate read-ahead and caching techniques.  The information
> + * provided is advisory only, and can be safely disregarded by the
> + * kernel without affecting the correct operation of the application.
> + *
> + * behavior values:
> + *  MADV_NORMAL - the default behavior is to read clusters.  This
> + *		results in some read-ahead and read-behind.
> + *  MADV_RANDOM - the system should read the minimum amount of data
> + *		on any access, since it is unlikely that the appli-
> + *		cation will need more than what it asks for.
> + *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
> + *		once, so they can be aggressively read ahead, and
> + *		can be freed soon after they are accessed.
> + *  MADV_WILLNEED - the application is notifying the system to read
> + *		some pages ahead.
> + *  MADV_DONTNEED - the application is finished with the given range,
> + *		so the kernel can free resources associated with it.
> + *  MADV_FREE - the application marks pages in the given range as lazy free,
> + *		where actual purges are postponed until memory pressure happens.
> + *  MADV_REMOVE - the application wants to free up the given range of
> + *		pages and associated backing store.
> + *  MADV_DONTFORK - omit this area from child's address space when forking:
> + *		typically, to avoid COWing pages pinned by get_user_pages().
> + *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
> + *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
> + *              range after a fork.
> + *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
> + *  MADV_HWPOISON - trigger memory error handler as if the given memory range
> + *		were corrupted by unrecoverable hardware memory failure.
> + *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
> + *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
> + *		this area with pages of identical content from other such areas.
> + *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
> + *  MADV_HUGEPAGE - the application wants to back the given range by transparent
> + *		huge pages in the future. Existing pages might be coalesced and
> + *		new pages might be allocated as THP.
> + *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
> + *		transparent huge pages so the existing pages will not be
> + *		coalesced into THP and new pages will not be allocated as THP.
> + *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> + *		from being included in its core dump.
> + *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *
> + * return values:
> + *  zero    - success
> + *  -EINVAL - start + len < 0, start is not page-aligned,
> + *		"behavior" is not a valid value, or application
> + *		is attempting to release locked or shared pages,
> + *		or the specified address range includes file, Huge TLB,
> + *		MAP_SHARED or VMPFNMAP range.
> + *  -ENOMEM - addresses in the specified range are not currently
> + *		mapped, or are outside the AS of the process.
> + *  -EIO    - an I/O error occurred while paging in data.
> + *  -EBADF  - map exists, but area maps something that isn't a file.
> + *  -EAGAIN - a kernel resource was temporarily unavailable.
> + */
> +SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> +{
> +	return madvise_common(current, current->mm, start, len_in, behavior);
> +}
> 

