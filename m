Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2086935122
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFDUip (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 16:38:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45180 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfFDUip (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 16:38:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so13375746pfm.12
        for <linux-api@vger.kernel.org>; Tue, 04 Jun 2019 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vmtKd7pXCUoo21JdwkU/alve0IMksDE1qVB9HK93KUM=;
        b=NH+zeQoAkCXNrr5hzhwpxS62fI/HeUnphmwpIyIBMJXL49cc/GqDRmPRRUZnYXE2Jw
         owomvWsN+VmZ5DMZM2FYWH04v7pnPJPLA82wjOCqAY8ZhB+xB3B/8uaaaDBlCOY2ZAqh
         oVNO2E424p6mlfJ6759JaYearaNnWMK+1mFg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmtKd7pXCUoo21JdwkU/alve0IMksDE1qVB9HK93KUM=;
        b=YPINfjB7VJ+2u1PA3d4JXJuqAppqmoNQ/IvhUHLvxegp7K7NYyotNp6IYJ9DLFjwbE
         yiaYRc63TTDCzIC+3hq/W1abGfsw1Q+4Ay2LRNaxKWXdAdIl5vK4+6sK9oUF1Q6dENPV
         unrDJhnfF5Th14pdNt3b0oTn9RLnvlfYuGkod7wWxM0vy1Ygy2MJRLH0KEuqA/6k2bVI
         tx4XGJPTQ5mxalHUT+2hBREZ9TTFce0FYmvEkbMA2c0xxypDXOtdjVwfmO/X7UPs1ZmD
         D9gritLF+cQhY/8hTdAfP3xpnhZ+nttDArwi0hxzpdE2977ozVWKTMUjoci96dil+tzX
         tP5Q==
X-Gm-Message-State: APjAAAWlU2LC0TYegU743GCqX3hm+dYC1gDOAQFyqY78EDnIba5g3sqH
        NsTKufhaj9qVhCilg1GMC6xrjg==
X-Google-Smtp-Source: APXvYqwYHfl45p29nmprOdyveIj26VWleTZ66ckx+7+TLMff5VtLrd8nsByKgtMPUTdhjZFxGTszdQ==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr2256203pjd.72.1559680724047;
        Tue, 04 Jun 2019 13:38:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm25508699pgs.87.2019.06.04.13.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 13:38:43 -0700 (PDT)
Date:   Tue, 4 Jun 2019 16:38:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH v1 1/4] mm: introduce MADV_COLD
Message-ID: <20190604203841.GC228607@google.com>
References: <20190603053655.127730-1-minchan@kernel.org>
 <20190603053655.127730-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603053655.127730-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 03, 2019 at 02:36:52PM +0900, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range, it could
> give a hint to kernel that the pages can be reclaimed when memory pressure
> happens but data should be preserved for future use.  This could reduce
> workingset eviction so it ends up increasing performance.
> 
> This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> MADV_COLD can be used by a process to mark a memory range as not expected
> to be used in the near future. The hint can help kernel in deciding which
> pages to evict early during memory pressure.
> 
> It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> 
> 	active file page -> inactive file LRU
> 	active anon page -> inacdtive anon LRU
> 
> Unlike MADV_FREE, it doesn't move active anonymous pages to inactive
> files's head because MADV_COLD is a little bit different symantic.
> MADV_FREE means it's okay to discard when the memory pressure because
> the content of the page is *garbage* so freeing such pages is almost zero
> overhead since we don't need to swap out and access afterward causes just
> minor fault. Thus, it would make sense to put those freeable pages in
> inactive file LRU to compete other used-once pages. Even, it could
> give a bonus to make them be reclaimed on swapless system. However,
> MADV_COLD doesn't mean garbage so reclaiming them requires swap-out/in
> in the end. So it's better to move inactive anon's LRU list, not file LRU.
> Furthermore, it would help to avoid unnecessary scanning of cold anonymous
> if system doesn't have a swap device.
> 
> All of error rule is same with MADV_DONTNEED.
> 
> Note:
> This hint works with only private pages(IOW, page_mapcount(page) < 2)
> because shared page could have more chance to be accessed from other
> processes sharing the page although the caller reset the reference bits.
> It ends up preventing the reclaim of the page and wastes CPU cycle.
> 
> * RFCv2
>  * add more description - mhocko
> 
> * RFCv1
>  * renaming from MADV_COOL to MADV_COLD - hannes
> 
> * internal review
>  * use clear_page_youn in deactivate_page - joelaf
>  * Revise the description - surenb
>  * Renaming from MADV_WARM to MADV_COOL - surenb
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/page-flags.h             |   1 +
>  include/linux/page_idle.h              |  15 ++++
>  include/linux/swap.h                   |   1 +
>  include/uapi/asm-generic/mman-common.h |   1 +
>  mm/internal.h                          |   2 +-
>  mm/madvise.c                           | 115 ++++++++++++++++++++++++-
>  mm/oom_kill.c                          |   2 +-
>  mm/swap.c                              |  43 +++++++++
>  8 files changed, 176 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 9f8712a4b1a5..58b06654c8dd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -424,6 +424,7 @@ static inline bool set_hwpoison_free_buddy_page(struct page *page)
>  TESTPAGEFLAG(Young, young, PF_ANY)
>  SETPAGEFLAG(Young, young, PF_ANY)
>  TESTCLEARFLAG(Young, young, PF_ANY)
> +CLEARPAGEFLAG(Young, young, PF_ANY)
>  PAGEFLAG(Idle, idle, PF_ANY)
>  #endif
>  
> diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
> index 1e894d34bdce..f3f43b317150 100644
> --- a/include/linux/page_idle.h
> +++ b/include/linux/page_idle.h
> @@ -19,6 +19,11 @@ static inline void set_page_young(struct page *page)
>  	SetPageYoung(page);
>  }
>  
> +static inline void clear_page_young(struct page *page)
> +{
> +	ClearPageYoung(page);
> +}
> +
>  static inline bool test_and_clear_page_young(struct page *page)
>  {
>  	return TestClearPageYoung(page);
> @@ -65,6 +70,16 @@ static inline void set_page_young(struct page *page)
>  	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
>  }
>  
> +static void clear_page_young(struct page *page)
> +{
> +	struct page_ext *page_ext = lookup_page_ext(page);
> +
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
> +}
> +
>  static inline bool test_and_clear_page_young(struct page *page)
>  {
>  	struct page_ext *page_ext = lookup_page_ext(page);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index de2c67a33b7e..0ce997edb8bb 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -340,6 +340,7 @@ extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_all(void);
>  extern void rotate_reclaimable_page(struct page *page);
>  extern void deactivate_file_page(struct page *page);
> +extern void deactivate_page(struct page *page);
>  extern void mark_page_lazyfree(struct page *page);
>  extern void swap_setup(void);
>  
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index bea0278f65ab..1190f4e7f7b9 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -43,6 +43,7 @@
>  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
> +#define MADV_COLD	5		/* deactivatie these pages */
>  
>  /* common parameters: try to keep these consistent across architectures */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
> diff --git a/mm/internal.h b/mm/internal.h
> index 9eeaf2b95166..75a4f96ec0fb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -43,7 +43,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  		unsigned long floor, unsigned long ceiling);
>  
> -static inline bool can_madv_dontneed_vma(struct vm_area_struct *vma)
> +static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
>  {
>  	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
>  }
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 628022e674a7..ab158766858a 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -40,6 +40,7 @@ static int madvise_need_mmap_write(int behavior)
>  	case MADV_REMOVE:
>  	case MADV_WILLNEED:
>  	case MADV_DONTNEED:
> +	case MADV_COLD:
>  	case MADV_FREE:
>  		return 0;
>  	default:
> @@ -307,6 +308,113 @@ static long madvise_willneed(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> +static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> +				unsigned long end, struct mm_walk *walk)
> +{
> +	pte_t *orig_pte, *pte, ptent;
> +	spinlock_t *ptl;
> +	struct page *page;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long next;
> +
> +	next = pmd_addr_end(addr, end);
> +	if (pmd_trans_huge(*pmd)) {
> +		ptl = pmd_trans_huge_lock(pmd, vma);
> +		if (!ptl)
> +			return 0;
> +
> +		if (is_huge_zero_pmd(*pmd))
> +			goto huge_unlock;
> +
> +		page = pmd_page(*pmd);
> +		if (page_mapcount(page) > 1)
> +			goto huge_unlock;
> +
> +		if (next - addr != HPAGE_PMD_SIZE) {
> +			int err;
> +
> +			get_page(page);
> +			spin_unlock(ptl);
> +			lock_page(page);
> +			err = split_huge_page(page);
> +			unlock_page(page);
> +			put_page(page);
> +			if (!err)
> +				goto regular_page;
> +			return 0;
> +		}
> +
> +		pmdp_test_and_clear_young(vma, addr, pmd);
> +		deactivate_page(page);
> +huge_unlock:
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
> +	if (pmd_trans_unstable(pmd))
> +		return 0;
> +
> +regular_page:
> +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> +		ptent = *pte;
> +
> +		if (pte_none(ptent))
> +			continue;
> +
> +		if (!pte_present(ptent))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, ptent);
> +		if (!page)
> +			continue;
> +
> +		if (page_mapcount(page) > 1)
> +			continue;
> +
> +		ptep_test_and_clear_young(vma, addr, pte);

Wondering here how it interacts with idle page tracking. Here since young
flag is cleared by the cold hint, page_referenced_one() or
page_idle_clear_pte_refs_one() will not be able to clear the page-idle flag
if it was previously set since it does not know any more that a page was
actively referenced.

Should you also be clearing the page-idle flag here if the ptep young/accessed
bit was previously set, just so that page-idle tracking works smoothly when
this hint is concurrently applied?

> +		deactivate_page(page);
> +	}
> +
> +	pte_unmap_unlock(orig_pte, ptl);
> +	cond_resched();
> +
> +	return 0;
> +}
> +
> +static void madvise_cold_page_range(struct mmu_gather *tlb,
> +			     struct vm_area_struct *vma,
> +			     unsigned long addr, unsigned long end)
> +{
> +	struct mm_walk cool_walk = {
> +		.pmd_entry = madvise_cold_pte_range,
> +		.mm = vma->vm_mm,
> +	};
> +
> +	tlb_start_vma(tlb, vma);
> +	walk_page_range(addr, end, &cool_walk);
> +	tlb_end_vma(tlb, vma);
> +}
> +
> +static long madvise_cold(struct vm_area_struct *vma,
> +			struct vm_area_struct **prev,
> +			unsigned long start_addr, unsigned long end_addr)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct mmu_gather tlb;
> +
> +	*prev = vma;
> +	if (!can_madv_lru_vma(vma))
> +		return -EINVAL;
> +
> +	lru_add_drain();
> +	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> +	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
> +	tlb_finish_mmu(&tlb, start_addr, end_addr);
> +
> +	return 0;
> +}
> +
>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  				unsigned long end, struct mm_walk *walk)
>  
> @@ -519,7 +627,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  				  int behavior)
>  {
>  	*prev = vma;
> -	if (!can_madv_dontneed_vma(vma))
> +	if (!can_madv_lru_vma(vma))
>  		return -EINVAL;
>  
>  	if (!userfaultfd_remove(vma, start, end)) {
> @@ -541,7 +649,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  			 */
>  			return -ENOMEM;
>  		}
> -		if (!can_madv_dontneed_vma(vma))
> +		if (!can_madv_lru_vma(vma))
>  			return -EINVAL;
>  		if (end > vma->vm_end) {
>  			/*
> @@ -695,6 +803,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		return madvise_remove(vma, prev, start, end);
>  	case MADV_WILLNEED:
>  		return madvise_willneed(vma, prev, start, end);
> +	case MADV_COLD:
> +		return madvise_cold(vma, prev, start, end);
>  	case MADV_FREE:
>  	case MADV_DONTNEED:
>  		return madvise_dontneed_free(vma, prev, start, end, behavior);
> @@ -716,6 +826,7 @@ madvise_behavior_valid(int behavior)
>  	case MADV_WILLNEED:
>  	case MADV_DONTNEED:
>  	case MADV_FREE:
> +	case MADV_COLD:
>  #ifdef CONFIG_KSM
>  	case MADV_MERGEABLE:
>  	case MADV_UNMERGEABLE:
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5a58778c91d4..f73d5f5145f0 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -515,7 +515,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  	set_bit(MMF_UNSTABLE, &mm->flags);
>  
>  	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
> -		if (!can_madv_dontneed_vma(vma))
> +		if (!can_madv_lru_vma(vma))
>  			continue;
>  
>  		/*
> diff --git a/mm/swap.c b/mm/swap.c
> index 7b079976cbec..cebedab15aa2 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -47,6 +47,7 @@ int page_cluster;
>  static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
>  static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
>  static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
> +static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
>  static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
>  #ifdef CONFIG_SMP
>  static DEFINE_PER_CPU(struct pagevec, activate_page_pvecs);
> @@ -538,6 +539,23 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  	update_page_reclaim_stat(lruvec, file, 0);
>  }
>  
> +static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
> +			    void *arg)
> +{
> +	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> +		int file = page_is_file_cache(page);
> +		int lru = page_lru_base_type(page);
> +
> +		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
> +		ClearPageActive(page);
> +		ClearPageReferenced(page);
> +		clear_page_young(page);

I was curious, how does the above interact with clear_refs?

It appears that a range that is marked as cold will appear to be unreferenced
(since referenced flag is cleared) even though it may have been referenced in
the past. Very least, I believe this behavior should be documented somewhere.

I believe it is best for us to make the clear_refs technique behave similar
to the idle-page tracking for the purposes of figuring out which pages are
referenced, so that clear_refs is more immune to this hint.

thanks,

 - Joel

