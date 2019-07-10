Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01F64577
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2019 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGJK4g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Jul 2019 06:56:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44940 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJK4g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Jul 2019 06:56:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so1031184plr.11;
        Wed, 10 Jul 2019 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LtvVB22HZe1NLIHBDYeQjQYGhyZXxbvEfnkYynIiSq4=;
        b=BwET3NaNDF/Fk1Y9cENEjnRd6W5M+5LlZOgJcefC4VnZQ1Mr7HxkbuOa3kwzexcL/Q
         gdKqv1Ub34k6VxkjjWXIpxRGdeNdtcrQ7Q1MNdyDgH/tpGEwBEHhRUT8I8oMxUbfJH+O
         gRJkjzF1S9NPWGVEBLIz5+apyeQSeiRvaQaNu8KHyXeG43OQRCZxjKtU6juLOBrz0Z4l
         i871O9fV9sh9GKDF8za6sCPV5ttq2Be+arDlUhG6yV96q9KoMM3FlczpRUf/bWpmxvV4
         vAM2wmmEZXfxd2CYNMfz4QmRy+2ZgI8wajiGD0OoiT4X+q/HxJO+tX5YzWZW8ZJWx1/O
         DOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtvVB22HZe1NLIHBDYeQjQYGhyZXxbvEfnkYynIiSq4=;
        b=hfUUxlQqMDha1XngSj6uWVXrQJ2KoBdGaaJ+a6BzWiJn15r0r+nm6V0yIJsC2i1iD/
         y4+rMaQF7jqVZdqWp+sXXNYgBr7mdLW3Ed2AnswqeRRET9Qgd+a8IRHPyaf48RipPUGv
         HTb6pql1l53dG5vI7J1p+asQ1M8gEuAjJLQRf7oROGHhnvHoDooo+rW27iO06ylOaL2b
         U+BYUS++GKFvJDumXamsOJaYv/9N4PfNbOaKMjc7FXvMNH70BOcLGqKva/5nmWc3IvPV
         CHLM659UvOwALAqkcYkC23SV1NkeofQaXVLjbJpxLzLTR9RklVW/Bm7TBz8PRDzK+8qT
         eqhA==
X-Gm-Message-State: APjAAAXrAmMUNTjGT99vqMnOxhPcxdsEl5R9JUPBKrgbnNic9VEkYrmK
        jIg2K+Iilx5sWusIjkuK+sQ=
X-Google-Smtp-Source: APXvYqwbgT43Vsl/g18GPn0t3uieRIJn/nRm7tURu3uXCgREZtKiXrqzqyK/uohFuAZR7FH405TXUQ==
X-Received: by 2002:a17:902:7894:: with SMTP id q20mr36881365pll.339.1562756195335;
        Wed, 10 Jul 2019 03:56:35 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l15sm1870293pgf.5.2019.07.10.03.56.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 03:56:34 -0700 (PDT)
Date:   Wed, 10 Jul 2019 19:56:27 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 5/5] mm: factor out pmd young/dirty bit handling and
 THP split
Message-ID: <20190710105627.GB186559@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-6-minchan@kernel.org>
 <20190709141019.GN26380@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709141019.GN26380@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 09, 2019 at 04:10:19PM +0200, Michal Hocko wrote:
> On Thu 27-06-19 20:54:05, Minchan Kim wrote:
> > Now, there are common part among MADV_COLD|PAGEOUT|FREE to reset
> > access/dirty bit resetting or split the THP page to handle part
> > of subpages in the THP page. This patch factor out the common part.
> 
> While this reduces the code duplication to some degree I suspect it only
> goes half way. I haven't tried that myself due to lack of time but I
> believe this has a potential to reduce even more. All those madvise
> calls are doing the same thing essentially. What page tables and apply
> an operation on ptes and/or a page that is mapped. And that suggests
> that the specific operation should be good with defining two - pte and
> page operations on each entry. All the rest should be a common code.
> 
> That being said, I do not feel strongly about this patch. The rest of
> the series should be good enough even without it and I wouldn't delay it
> just by discussing a potential of the cleanup.

I totally agree with you. For several cycles, some people asked me to
factor common part out. I understand them why they wanted it. However,
when I tried it, it's not trivial to clean it out due to subtle
difference of them. If I couldn't make it clean at this moment, I want to
keep them without factoing out since it's more readable, at least.

I will drop this patch next submit unless someone pop with better idea.

> 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/linux/huge_mm.h |   3 -
> >  mm/huge_memory.c        |  74 -------------
> >  mm/madvise.c            | 234 +++++++++++++++++++++++-----------------
> >  3 files changed, 135 insertions(+), 176 deletions(-)
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 7cd5c150c21d..2667e1aa3ce5 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -29,9 +29,6 @@ extern struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
> >  					  unsigned long addr,
> >  					  pmd_t *pmd,
> >  					  unsigned int flags);
> > -extern bool madvise_free_huge_pmd(struct mmu_gather *tlb,
> > -			struct vm_area_struct *vma,
> > -			pmd_t *pmd, unsigned long addr, unsigned long next);
> >  extern int zap_huge_pmd(struct mmu_gather *tlb,
> >  			struct vm_area_struct *vma,
> >  			pmd_t *pmd, unsigned long addr);
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 93f531b63a45..e4b9a06788f3 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1671,80 +1671,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Return true if we do MADV_FREE successfully on entire pmd page.
> > - * Otherwise, return false.
> > - */
> > -bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > -		pmd_t *pmd, unsigned long addr, unsigned long next)
> > -{
> > -	spinlock_t *ptl;
> > -	pmd_t orig_pmd;
> > -	struct page *page;
> > -	struct mm_struct *mm = tlb->mm;
> > -	bool ret = false;
> > -
> > -	tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
> > -
> > -	ptl = pmd_trans_huge_lock(pmd, vma);
> > -	if (!ptl)
> > -		goto out_unlocked;
> > -
> > -	orig_pmd = *pmd;
> > -	if (is_huge_zero_pmd(orig_pmd))
> > -		goto out;
> > -
> > -	if (unlikely(!pmd_present(orig_pmd))) {
> > -		VM_BUG_ON(thp_migration_supported() &&
> > -				  !is_pmd_migration_entry(orig_pmd));
> > -		goto out;
> > -	}
> > -
> > -	page = pmd_page(orig_pmd);
> > -	/*
> > -	 * If other processes are mapping this page, we couldn't discard
> > -	 * the page unless they all do MADV_FREE so let's skip the page.
> > -	 */
> > -	if (page_mapcount(page) != 1)
> > -		goto out;
> > -
> > -	if (!trylock_page(page))
> > -		goto out;
> > -
> > -	/*
> > -	 * If user want to discard part-pages of THP, split it so MADV_FREE
> > -	 * will deactivate only them.
> > -	 */
> > -	if (next - addr != HPAGE_PMD_SIZE) {
> > -		get_page(page);
> > -		spin_unlock(ptl);
> > -		split_huge_page(page);
> > -		unlock_page(page);
> > -		put_page(page);
> > -		goto out_unlocked;
> > -	}
> > -
> > -	if (PageDirty(page))
> > -		ClearPageDirty(page);
> > -	unlock_page(page);
> > -
> > -	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
> > -		pmdp_invalidate(vma, addr, pmd);
> > -		orig_pmd = pmd_mkold(orig_pmd);
> > -		orig_pmd = pmd_mkclean(orig_pmd);
> > -
> > -		set_pmd_at(mm, addr, pmd, orig_pmd);
> > -		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> > -	}
> > -
> > -	mark_page_lazyfree(page);
> > -	ret = true;
> > -out:
> > -	spin_unlock(ptl);
> > -out_unlocked:
> > -	return ret;
> > -}
> > -
> >  static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
> >  {
> >  	pgtable_t pgtable;
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index ee210473f639..13b06dc8d402 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -310,6 +310,91 @@ static long madvise_willneed(struct vm_area_struct *vma,
> >  	return 0;
> >  }
> >  
> > +enum madv_pmdp_reset_t {
> > +	MADV_PMDP_RESET,	/* pmd was reset successfully */
> > +	MADV_PMDP_SPLIT,	/* pmd was split */
> > +	MADV_PMDP_ERROR,
> > +};
> > +
> > +static enum madv_pmdp_reset_t madvise_pmdp_reset_or_split(struct mm_walk *walk,
> > +				pmd_t *pmd, spinlock_t *ptl,
> > +				unsigned long addr, unsigned long end,
> > +				bool young, bool dirty)
> > +{
> > +	pmd_t orig_pmd;
> > +	unsigned long next;
> > +	struct page *page;
> > +	struct mmu_gather *tlb = walk->private;
> > +	struct mm_struct *mm = walk->mm;
> > +	struct vm_area_struct *vma = walk->vma;
> > +	bool reset_young = false;
> > +	bool reset_dirty = false;
> > +	enum madv_pmdp_reset_t ret = MADV_PMDP_ERROR;
> > +
> > +	orig_pmd = *pmd;
> > +	if (is_huge_zero_pmd(orig_pmd))
> > +		return ret;
> > +
> > +	if (unlikely(!pmd_present(orig_pmd))) {
> > +		VM_BUG_ON(thp_migration_supported() &&
> > +				!is_pmd_migration_entry(orig_pmd));
> > +		return ret;
> > +	}
> > +
> > +	next = pmd_addr_end(addr, end);
> > +	page = pmd_page(orig_pmd);
> > +	if (next - addr != HPAGE_PMD_SIZE) {
> > +		/*
> > +		 * THP collapsing is not cheap so only split the page is
> > +		 * private to the this process.
> > +		 */
> > +		if (page_mapcount(page) != 1)
> > +			return ret;
> > +		get_page(page);
> > +		spin_unlock(ptl);
> > +		lock_page(page);
> > +		if (!split_huge_page(page))
> > +			ret = MADV_PMDP_SPLIT;
> > +		unlock_page(page);
> > +		put_page(page);
> > +		return ret;
> > +	}
> > +
> > +	if (young && pmd_young(orig_pmd))
> > +		reset_young = true;
> > +	if (dirty && pmd_dirty(orig_pmd))
> > +		reset_dirty = true;
> > +
> > +	/*
> > +	 * Other process could rely on the PG_dirty for data consistency,
> > +	 * not pte_dirty so we could reset PG_dirty only when we are owner
> > +	 * of the page.
> > +	 */
> > +	if (reset_dirty) {
> > +		if (page_mapcount(page) != 1)
> > +			goto out;
> > +		if (!trylock_page(page))
> > +			goto out;
> > +		if (PageDirty(page))
> > +			ClearPageDirty(page);
> > +		unlock_page(page);
> > +	}
> > +
> > +	ret = MADV_PMDP_RESET;
> > +	if (reset_young || reset_dirty) {
> > +		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
> > +		pmdp_invalidate(vma, addr, pmd);
> > +		if (reset_young)
> > +			orig_pmd = pmd_mkold(orig_pmd);
> > +		if (reset_dirty)
> > +			orig_pmd = pmd_mkclean(orig_pmd);
> > +		set_pmd_at(mm, addr, pmd, orig_pmd);
> > +		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> > +	}
> > +out:
> > +	return ret;
> > +}
> > +
> >  static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> >  				unsigned long end, struct mm_walk *walk)
> >  {
> > @@ -319,64 +404,31 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> >  	pte_t *orig_pte, *pte, ptent;
> >  	spinlock_t *ptl;
> >  	struct page *page;
> > -	unsigned long next;
> >  
> > -	next = pmd_addr_end(addr, end);
> >  	if (pmd_trans_huge(*pmd)) {
> > -		pmd_t orig_pmd;
> > -
> > -		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
> >  		ptl = pmd_trans_huge_lock(pmd, vma);
> >  		if (!ptl)
> >  			return 0;
> >  
> > -		orig_pmd = *pmd;
> > -		if (is_huge_zero_pmd(orig_pmd))
> > -			goto huge_unlock;
> > -
> > -		if (unlikely(!pmd_present(orig_pmd))) {
> > -			VM_BUG_ON(thp_migration_supported() &&
> > -					!is_pmd_migration_entry(orig_pmd));
> > -			goto huge_unlock;
> > -		}
> > -
> > -		page = pmd_page(orig_pmd);
> > -		if (next - addr != HPAGE_PMD_SIZE) {
> > -			int err;
> > -
> > -			if (page_mapcount(page) != 1)
> > -				goto huge_unlock;
> > -
> > -			get_page(page);
> > +		switch (madvise_pmdp_reset_or_split(walk, pmd, ptl, addr, end,
> > +							true, false)) {
> > +		case MADV_PMDP_RESET:
> >  			spin_unlock(ptl);
> > -			lock_page(page);
> > -			err = split_huge_page(page);
> > -			unlock_page(page);
> > -			put_page(page);
> > -			if (!err)
> > -				goto regular_page;
> > -			return 0;
> > -		}
> > -
> > -		if (pmd_young(orig_pmd)) {
> > -			pmdp_invalidate(vma, addr, pmd);
> > -			orig_pmd = pmd_mkold(orig_pmd);
> > -
> > -			set_pmd_at(mm, addr, pmd, orig_pmd);
> > -			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> > +			page = pmd_page(*pmd);
> > +			test_and_clear_page_young(page);
> > +			deactivate_page(page);
> > +			goto next;
> > +		case MADV_PMDP_ERROR:
> > +			spin_unlock(ptl);
> > +			goto next;
> > +		case MADV_PMDP_SPLIT:
> > +			; /* go through */
> >  		}
> > -
> > -		test_and_clear_page_young(page);
> > -		deactivate_page(page);
> > -huge_unlock:
> > -		spin_unlock(ptl);
> > -		return 0;
> >  	}
> >  
> >  	if (pmd_trans_unstable(pmd))
> >  		return 0;
> >  
> > -regular_page:
> >  	tlb_change_page_size(tlb, PAGE_SIZE);
> >  	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> >  	flush_tlb_batched_pending(mm);
> > @@ -443,6 +495,7 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> >  
> >  	arch_enter_lazy_mmu_mode();
> >  	pte_unmap_unlock(orig_pte, ptl);
> > +next:
> >  	cond_resched();
> >  
> >  	return 0;
> > @@ -493,70 +546,38 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> >  	LIST_HEAD(page_list);
> >  	struct page *page;
> >  	int isolated = 0;
> > -	unsigned long next;
> >  
> >  	if (fatal_signal_pending(current))
> >  		return -EINTR;
> >  
> > -	next = pmd_addr_end(addr, end);
> >  	if (pmd_trans_huge(*pmd)) {
> > -		pmd_t orig_pmd;
> > -
> > -		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
> >  		ptl = pmd_trans_huge_lock(pmd, vma);
> >  		if (!ptl)
> >  			return 0;
> >  
> > -		orig_pmd = *pmd;
> > -		if (is_huge_zero_pmd(orig_pmd))
> > -			goto huge_unlock;
> > -
> > -		if (unlikely(!pmd_present(orig_pmd))) {
> > -			VM_BUG_ON(thp_migration_supported() &&
> > -					!is_pmd_migration_entry(orig_pmd));
> > -			goto huge_unlock;
> > -		}
> > -
> > -		page = pmd_page(orig_pmd);
> > -		if (next - addr != HPAGE_PMD_SIZE) {
> > -			int err;
> > -
> > -			if (page_mapcount(page) != 1)
> > -				goto huge_unlock;
> > -			get_page(page);
> > +		switch (madvise_pmdp_reset_or_split(walk, pmd, ptl, addr, end,
> > +							true, false)) {
> > +		case MADV_PMDP_RESET:
> > +			page = pmd_page(*pmd);
> >  			spin_unlock(ptl);
> > -			lock_page(page);
> > -			err = split_huge_page(page);
> > -			unlock_page(page);
> > -			put_page(page);
> > -			if (!err)
> > -				goto regular_page;
> > -			return 0;
> > -		}
> > -
> > -		if (isolate_lru_page(page))
> > -			goto huge_unlock;
> > -
> > -		if (pmd_young(orig_pmd)) {
> > -			pmdp_invalidate(vma, addr, pmd);
> > -			orig_pmd = pmd_mkold(orig_pmd);
> > -
> > -			set_pmd_at(mm, addr, pmd, orig_pmd);
> > -			tlb_remove_tlb_entry(tlb, pmd, addr);
> > +			if (isolate_lru_page(page))
> > +				return 0;
> > +			ClearPageReferenced(page);
> > +			test_and_clear_page_young(page);
> > +			list_add(&page->lru, &page_list);
> > +			reclaim_pages(&page_list);
> > +			goto next;
> > +		case MADV_PMDP_ERROR:
> > +			spin_unlock(ptl);
> > +			goto next;
> > +		case MADV_PMDP_SPLIT:
> > +			; /* go through */
> >  		}
> > -
> > -		ClearPageReferenced(page);
> > -		test_and_clear_page_young(page);
> > -		list_add(&page->lru, &page_list);
> > -huge_unlock:
> > -		spin_unlock(ptl);
> > -		reclaim_pages(&page_list);
> > -		return 0;
> >  	}
> >  
> >  	if (pmd_trans_unstable(pmd))
> >  		return 0;
> > -regular_page:
> > +
> >  	tlb_change_page_size(tlb, PAGE_SIZE);
> >  	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> >  	flush_tlb_batched_pending(mm);
> > @@ -631,6 +652,7 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> >  	arch_leave_lazy_mmu_mode();
> >  	pte_unmap_unlock(orig_pte, ptl);
> >  	reclaim_pages(&page_list);
> > +next:
> >  	cond_resched();
> >  
> >  	return 0;
> > @@ -700,12 +722,26 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >  	pte_t *orig_pte, *pte, ptent;
> >  	struct page *page;
> >  	int nr_swap = 0;
> > -	unsigned long next;
> >  
> > -	next = pmd_addr_end(addr, end);
> > -	if (pmd_trans_huge(*pmd))
> > -		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
> > +	if (pmd_trans_huge(*pmd)) {
> > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > +		if (!ptl)
> > +			return 0;
> > +
> > +		switch (madvise_pmdp_reset_or_split(walk, pmd, ptl, addr, end,
> > +							true, true)) {
> > +		case MADV_PMDP_RESET:
> > +			page = pmd_page(*pmd);
> > +			spin_unlock(ptl);
> > +			mark_page_lazyfree(page);
> >  			goto next;
> > +		case MADV_PMDP_ERROR:
> > +			spin_unlock(ptl);
> > +			goto next;
> > +		case MADV_PMDP_SPLIT:
> > +			; /* go through */
> > +		}
> > +	}
> >  
> >  	if (pmd_trans_unstable(pmd))
> >  		return 0;
> > @@ -817,8 +853,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >  	}
> >  	arch_leave_lazy_mmu_mode();
> >  	pte_unmap_unlock(orig_pte, ptl);
> > -	cond_resched();
> >  next:
> > +	cond_resched();
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.22.0.410.gd8fdbe21b5-goog
> 
> -- 
> Michal Hocko
> SUSE Labs
