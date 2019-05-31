Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50C03091D
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEaHEZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 03:04:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaHEY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 03:04:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id h1so5726937wro.4
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 00:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXimqhuQPzjSkDlJHKh1//Q0lTKWoHaSFZeB2nOGzeI=;
        b=aAhzkCXm77v3/Vx732jrWmAtu/HMW/T3p3I4U+yNrg5EEtfu/QH8YkEKne7YAl68lY
         PPm2x5sEPMM7xE9kDpC6qHwPrn2Erkrj11+db2xf78Y1R0c2V5E3myZMIBoGU3E+KM3Z
         Iaxy2MkxqYJT/piLPjXeFZnbs663hBbT25whRDPITdqjVizLysn7P3KyOE+Y1EhFN5It
         M23i7ojh5fmWZ7fPrnPvth4KsbTg5u3jtnD5WR+q9OgrSUjxL/8oLQdOXWhqyasBB2vq
         UjxIzK1Qq3CJWVKDUsrcJBI7KDhvC/ZgZEQKLepLvYIEIoA37/HtAZmu5pPjakAOlLUL
         7a+A==
X-Gm-Message-State: APjAAAXj3C1K8zYmO4/X+CLT6UP6NuL2Olcpq9ZEcrFRJf5z5vPG+oAb
        P28NH/PO1nA6m7x5/feLU6FxmQ==
X-Google-Smtp-Source: APXvYqzsJhT+/CHF5/K0KNhw8/u8ablPLk0JjlecKo2lucgE8d/pqM7hcXEW/WM5r8bWML+giSwXWA==
X-Received: by 2002:a5d:45c7:: with SMTP id b7mr5094124wrs.176.1559286262505;
        Fri, 31 May 2019 00:04:22 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 205sm5755127wmd.43.2019.05.31.00.04.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 00:04:21 -0700 (PDT)
Date:   Fri, 31 May 2019 09:04:20 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20190531070420.m7sxybbzzayig44o@butterfly.localdomain>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531064313.193437-5-minchan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 03:43:11PM +0900, Minchan Kim wrote:
> This patch factor out madvise's core functionality so that upcoming
> patch can reuse it without duplication. It shouldn't change any behavior.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 188 +++++++++++++++++++++++++++------------------------
>  1 file changed, 101 insertions(+), 87 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9d749a1420b4..466623ea8c36 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -425,9 +425,10 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
>  	struct page *page;
>  	int isolated = 0;
>  	struct vm_area_struct *vma = walk->vma;
> +	struct task_struct *task = walk->private;
>  	unsigned long next;
>  
> -	if (fatal_signal_pending(current))
> +	if (fatal_signal_pending(task))
>  		return -EINTR;
>  
>  	next = pmd_addr_end(addr, end);
> @@ -505,12 +506,14 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
>  }
>  
>  static void madvise_pageout_page_range(struct mmu_gather *tlb,
> -			     struct vm_area_struct *vma,
> -			     unsigned long addr, unsigned long end)
> +				struct task_struct *task,
> +				struct vm_area_struct *vma,
> +				unsigned long addr, unsigned long end)
>  {
>  	struct mm_walk warm_walk = {
>  		.pmd_entry = madvise_pageout_pte_range,
>  		.mm = vma->vm_mm,
> +		.private = task,
>  	};
>  
>  	tlb_start_vma(tlb, vma);
> @@ -519,9 +522,9 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
>  }
>  
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
> @@ -532,7 +535,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> -	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
>  	tlb_finish_mmu(&tlb, start_addr, end_addr);
>  
>  	return 0;
> @@ -744,7 +747,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> -static long madvise_dontneed_free(struct vm_area_struct *vma,
> +static long madvise_dontneed_free(struct mm_struct *mm,
> +				  struct vm_area_struct *vma,
>  				  struct vm_area_struct **prev,
>  				  unsigned long start, unsigned long end,
>  				  int behavior)
> @@ -756,8 +760,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
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
> @@ -804,7 +808,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>   * Application wants to free up the pages and associated backing store.
>   * This is effectively punching a hole into the middle of a file.
>   */
> -static long madvise_remove(struct vm_area_struct *vma,
> +static long madvise_remove(struct mm_struct *mm,
> +				struct vm_area_struct *vma,
>  				struct vm_area_struct **prev,
>  				unsigned long start, unsigned long end)
>  {
> @@ -838,13 +843,13 @@ static long madvise_remove(struct vm_area_struct *vma,
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
> @@ -918,21 +923,23 @@ static int madvise_inject_error(int behavior,
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
>  		return madvise_cold(vma, prev, start, end);
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
> @@ -976,68 +983,8 @@ madvise_behavior_valid(int behavior)
>  	}
>  }
>  
> -/*
> - * The madvise(2) system call.
> - *
> - * Applications can use madvise() to advise the kernel how it should
> - * handle paging I/O in this VM area.  The idea is to help the kernel
> - * use appropriate read-ahead and caching techniques.  The information
> - * provided is advisory only, and can be safely disregarded by the
> - * kernel without affecting the correct operation of the application.
> - *
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
> - */
> -SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> +static int madvise_core(struct task_struct *task, struct mm_struct *mm,
> +			unsigned long start, size_t len_in, int behavior)

Just a minor nitpick, but can we please have it named madvise_common,
not madvise_core? This would follow a usual naming scheme, when some
common functionality is factored out (like, for mutexes, semaphores
etc), and within the kernel "core" usually means something completely
different.

>  {
>  	unsigned long end, tmp;
>  	struct vm_area_struct *vma, *prev;
> @@ -1068,15 +1015,16 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  	if (behavior == MADV_HWPOISON || behavior == MADV_SOFT_OFFLINE)
> -		return madvise_inject_error(behavior, start, start + len_in);
> +		return madvise_inject_error(behavior,
> +					start, start + len_in);

Not sure what this change is about except changing the line length.
Note, madvise_inject_error() still operates on "current" through
get_user_pages_fast() and gup_pgd_range(), but that was not changed
here. I Know you've filtered out this hint later, so technically this
is not an issue, but, maybe, this needs some attention too since we've
already spotted it?

>  #endif
>  
>  	write = madvise_need_mmap_write(behavior);
>  	if (write) {
> -		if (down_write_killable(&current->mm->mmap_sem))
> +		if (down_write_killable(&mm->mmap_sem))
>  			return -EINTR;

Do you still need that trick with mmget_still_valid() here?
Something like:

if (current->mm != mm && !mmget_still_valid(mm))
   goto skip_mm;

and that skip_mm label would be before

if (write)
   up_write(&mm->mmap_sem);

below.

(see 04f5866e41fb70690e28397487d8bd8eea7d712a for details on this)

>  	} else {
> -		down_read(&current->mm->mmap_sem);
> +		down_read(&mm->mmap_sem);
>  	}
>  
>  	/*
> @@ -1084,7 +1032,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  	 * ranges, just ignore them, but return -ENOMEM at the end.
>  	 * - different from the way of handling in mlock etc.
>  	 */
> -	vma = find_vma_prev(current->mm, start, &prev);
> +	vma = find_vma_prev(mm, start, &prev);
>  	if (vma && start > vma->vm_start)
>  		prev = vma;
>  
> @@ -1109,7 +1057,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  			tmp = end;
>  
>  		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> -		error = madvise_vma(vma, &prev, start, tmp, behavior);
> +		error = madvise_vma(task, mm, vma, &prev, start, tmp, behavior);
>  		if (error)
>  			goto out;
>  		start = tmp;
> @@ -1121,14 +1069,80 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  		if (prev)
>  			vma = prev->vm_next;
>  		else	/* madvise_remove dropped mmap_sem */
> -			vma = find_vma(current->mm, start);
> +			vma = find_vma(mm, start);
>  	}
>  out:
>  	blk_finish_plug(&plug);

skip_mm:

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
> +	return madvise_core(current, current->mm, start, len_in, behavior);
> +}
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
