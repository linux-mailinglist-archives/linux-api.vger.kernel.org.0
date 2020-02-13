Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17A15C90B
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 18:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgBMRCb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 12:02:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42037 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBMRCb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 12:02:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so2560181plt.9;
        Thu, 13 Feb 2020 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5h9X3VFi6xhlRHuTPAyEerLqIyzkUxZqW+GmcZBhm8o=;
        b=beTMeDP49Gq6nr0oG2b1D+YU/K/L0dyhdD65gObRsusfOu+UocYorhBdiYZmxyj/tW
         RcGwgFcbzxKikM0J5NUI5rF6jrKR8lankzDOZuBgs+LkbRr9nBZCuFuZly3dW0kOZ8Y1
         22DpHJgp7H0r8JtmX1y5/CrHnK4XPLe9Wzge5DTr8DJGZIBjTMYG6iEjbWEvi3MHncFM
         ReVKqVaaevPKlVuYjKpOq9C+gTmzcxXLYL88ugkvF33XNbzUufc3eDhg+8UkrZ8WixC5
         pqTaqSSxgTvb1xS79y9hc4pDKGfc7GoTXSS/IOKdiIrGHN6m7ldGcyetmylYfHKIOXQM
         XNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5h9X3VFi6xhlRHuTPAyEerLqIyzkUxZqW+GmcZBhm8o=;
        b=BkI0rdgWZXmVK/ErWzp3mz3S7fK9uvx2vA8JZkV3JZnj/nqf0n+LJ2JGRkW7bIWnWW
         Hy0zK489pl9rJUg1XUeL60ExueJCY70XXDBBixAxh9yTYEChVpPyGoHU8P8YXemohQVl
         Y2Z6OdeGbiroSrbxDHLaP19RA3gou2EBBQxMOg3ydGgR5g4aUv8dmt4b55K6v4Q9WFg8
         RjzgbrrasY097Ghh2iSeb5KlSaTGNJfaeQYjDIzzZhQjnJXE5JdN4uKFeW7bOqvldzW3
         sWarhlp83EfOMbZXvVK47h6vNascFqeg6KwqJ8lY1uETffmGySCYGe026/4i872EyGzX
         GtwQ==
X-Gm-Message-State: APjAAAWt+LlDR3d02yufnVxc+S3XzESBsx5P5SgZlbDKg2hlUwZu1J32
        I4fcDRGP3R6rkbf4utd6Tz4Z1Mxy
X-Google-Smtp-Source: APXvYqwG2LlSBtyxAUb0B7Y+dZ2h+PHIw+IqAi63BjBuanZADnssLcd9lj+bP81buTrfQx8f+0zwrA==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr29125638plp.110.1581613349038;
        Thu, 13 Feb 2020 09:02:29 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id 196sm3835881pfy.86.2020.02.13.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:02:27 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:02:24 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, jannh@google.com
Subject: Re: [PATCH v4 1/8] mm: pass task to do_madvise
Message-ID: <20200213170224.GA27817@google.com>
References: <20200212233946.246210-1-minchan@kernel.org>
 <20200212233946.246210-2-minchan@kernel.org>
 <3f0218093e2d19fa0f24ceff635cbb9ec5ba69ec.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f0218093e2d19fa0f24ceff635cbb9ec5ba69ec.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 04:21:59PM -0800, Alexander Duyck wrote:
> On Wed, 2020-02-12 at 15:39 -0800, Minchan Kim wrote:
> > In upcoming patches, do_madvise will be called from external process
> > context so it shouldn't asssume "current" is always hinted process's
> > task_struct. Thus, let's get the mm_struct from vma->vm_mm, not
> > current because vma is always hinted process's one. And let's pass
> > *current* as new task argument of do_madvise so it shouldn't change
> > existing behavior.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  fs/io_uring.c      |  2 +-
> >  include/linux/mm.h |  3 ++-
> >  mm/madvise.c       | 37 ++++++++++++++++++++-----------------
> >  3 files changed, 23 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index 63beda9bafc5..6307206b970f 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
> >  	if (force_nonblock)
> >  		return -EAGAIN;
> >  
> > -	ret = do_madvise(ma->addr, ma->len, ma->advice);
> > +	ret = do_madvise(current, ma->addr, ma->len, ma->advice);
> >  	if (ret < 0)
> >  		req_set_fail_links(req);
> >  	io_cqring_add_event(req, ret);
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 52269e56c514..8cb41131ec96 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2323,7 +2323,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
> >  		       struct list_head *uf, bool downgrade);
> >  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
> >  		     struct list_head *uf);
> > -extern int do_madvise(unsigned long start, size_t len_in, int behavior);
> > +extern int do_madvise(struct task_struct *task, unsigned long start,
> > +			size_t len_in, int behavior);
> >  
> >  static inline unsigned long
> >  do_mmap_pgoff(struct file *file, unsigned long addr,
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 43b47d3fae02..ab4011ba2d9e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -256,6 +256,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
> >  {
> >  	struct file *file = vma->vm_file;
> >  	loff_t offset;
> > +	struct mm_struct *mm = vma->vm_mm;
> >  
> >  	*prev = vma;
> >  #ifdef CONFIG_SWAP
> 
> I would probably move the declaration of the mm variable to the top just
> so you don't have the large "offset" valley between the two long variable
> declarations.

No problem.

> 
> > @@ -288,12 +289,12 @@ static long madvise_willneed(struct vm_area_struct *vma,
> >  	 */
> >  	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
> >  	get_file(file);
> > -	up_read(&current->mm->mmap_sem);
> > +	up_read(&mm->mmap_sem);
> >  	offset = (loff_t)(start - vma->vm_start)
> >  			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> >  	vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
> >  	fput(file);
> > -	down_read(&current->mm->mmap_sem);
> > +	down_read(&mm->mmap_sem);
> >  	return 0;
> >  }
> >  
> > @@ -674,9 +675,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >  	}
> >  out:
> >  	if (nr_swap) {
> > -		if (current->mm == mm)
> > -			sync_mm_rss(mm);
> > -
> > +		sync_mm_rss(mm);
> >  		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
> >  	}
> >  	arch_leave_lazy_mmu_mode();
> 
> This seems like it is taking things in the opposite direction of the other
> changes. sync_mm_rss will operate on current if I am not mistaken. I don't
> think you would want to add the stats from current to the stats of the
> task you are updating.
> 
> It might make sense to add a new function that would allow you to sync the
> remote task stats by creaing a version of sync_mm_rss that also takes a
> task pointer.

Sorry, that part was intended for other patch regardless of this patchset but
squeezed into this version by my mistake. I wanted to remove those part
from madvise_free because currently madvise_free is always done in current context.
I will drop it in next revision since it's not related to this patchset.

> 
> > @@ -756,6 +755,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  				  unsigned long start, unsigned long end,
> >  				  int behavior)
> >  {
> > +	struct mm_struct *mm = vma->vm_mm;
> >  	*prev = vma;
> >  	if (!can_madv_lru_vma(vma))
> >  		return -EINVAL;
> > @@ -763,8 +763,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> >  	if (!userfaultfd_remove(vma, start, end)) {
> >  		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
> >  
> > -		down_read(&current->mm->mmap_sem);
> > -		vma = find_vma(current->mm, start);
> > +		down_read(&mm->mmap_sem);
> > +		vma = find_vma(mm, start);
> >  		if (!vma)
> >  			return -ENOMEM;
> >  		if (start < vma->vm_start) {
> 
> This piece of code has me wondering if it is valid to be using vma->mm at
> the start of the function. I assume we are probably safe since we read the
> mm value before the semaphore was released in userfaultfd_remove. It might
> make more sense to just pass the task to the function and use task->mm-
> >mmap_sem instead. 

As Jann pointed out, we couldn't use task->mm once we verified it via
access_mm. However, I believe vma->vm_mm is safe(Ccing Jann for double
check).

> 
> It might be simpler, safer, and easier to review to just go through and
> add the task struct as needed and then simply replace references to
> current->mm with task->mm.
> 
> > @@ -818,6 +818,7 @@ static long madvise_remove(struct vm_area_struct *vma,
> >  	loff_t offset;
> >  	int error;
> >  	struct file *f;
> > +	struct mm_struct *mm = vma->vm_mm;
> >  
> >  	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
> >  
> > @@ -845,13 +846,13 @@ static long madvise_remove(struct vm_area_struct *vma,
> >  	get_file(f);
> >  	if (userfaultfd_remove(vma, start, end)) {
> >  		/* mmap_sem was not released by userfaultfd_remove() */
> > -		up_read(&current->mm->mmap_sem);
> > +		up_read(&mm->mmap_sem);
> >  	}
> >  	error = vfs_fallocate(f,
> >  				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> >  				offset, end - start);
> >  	fput(f);
> > -	down_read(&current->mm->mmap_sem);
> > +	down_read(&mm->mmap_sem);
> >  	return error;
> >  }
> >  
> > @@ -1044,7 +1045,8 @@ madvise_behavior_valid(int behavior)
> >   *  -EBADF  - map exists, but area maps something that isn't a file.
> >   *  -EAGAIN - a kernel resource was temporarily unavailable.
> >   */
> > -int do_madvise(unsigned long start, size_t len_in, int behavior)
> > +int do_madvise(struct task_struct *task, unsigned long start,
> > +					size_t len_in, int behavior)
> >  {
> >  	unsigned long end, tmp;
> >  	struct vm_area_struct *vma, *prev;
> > @@ -1053,6 +1055,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
> >  	int write;
> >  	size_t len;
> >  	struct blk_plug plug;
> > +	struct mm_struct *mm = task->mm;
> >  
> >  	start = untagged_addr(start);
> >  
> > @@ -1082,10 +1085,10 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
> >  
> >  	write = madvise_need_mmap_write(behavior);
> >  	if (write) {
> > -		if (down_write_killable(&current->mm->mmap_sem))
> > +		if (down_write_killable(&mm->mmap_sem))
> >  			return -EINTR;
> >  	} else {
> > -		down_read(&current->mm->mmap_sem);
> > +		down_read(&mm->mmap_sem);
> >  	}
> >  
> >  	/*
> > @@ -1093,7 +1096,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
> >  	 * ranges, just ignore them, but return -ENOMEM at the end.
> >  	 * - different from the way of handling in mlock etc.
> >  	 */
> > -	vma = find_vma_prev(current->mm, start, &prev);
> > +	vma = find_vma_prev(mm, start, &prev);
> >  	if (vma && start > vma->vm_start)
> >  		prev = vma;
> >  
> > @@ -1130,19 +1133,19 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
> >  		if (prev)
> >  			vma = prev->vm_next;
> >  		else	/* madvise_remove dropped mmap_sem */
> > -			vma = find_vma(current->mm, start);
> > +			vma = find_vma(mm, start);
> >  	}
> >  out:
> >  	blk_finish_plug(&plug);
> >  	if (write)
> > -		up_write(&current->mm->mmap_sem);
> > +		up_write(&mm->mmap_sem);
> >  	else
> > -		up_read(&current->mm->mmap_sem);
> > +		up_read(&mm->mmap_sem);
> >  
> >  	return error;
> >  }
> >  
> >  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >  {
> > -	return do_madvise(start, len_in, behavior);
> > +	return do_madvise(current, start, len_in, behavior);
> >  }
> 
> 
