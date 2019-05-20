Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA10F22ECD
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfETI1H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 04:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbfETI1G (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 04:27:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82BF1AC0C;
        Mon, 20 May 2019 08:27:04 +0000 (UTC)
Date:   Mon, 20 May 2019 10:27:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 3/7] mm: introduce MADV_COLD
Message-ID: <20190520082703.GX6836@dhcp22.suse.cz>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-4-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api]

On Mon 20-05-19 12:52:50, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range
> for a long time, it could hint kernel that the pages can be
> reclaimed instantly but data should be preserved for future use.
> This could reduce workingset eviction so it ends up increasing
> performance.
> 
> This patch introduces the new MADV_COLD hint to madvise(2)
> syscall. MADV_COLD can be used by a process to mark a memory range
> as not expected to be used for a long time. The hint can help
> kernel in deciding which pages to evict proactively.

As mentioned in other email this looks like a non-destructive
MADV_DONTNEED alternative.

> Internally, it works via reclaiming memory in process context
> the syscall is called. If the page is dirty but backing storage
> is not synchronous device, the written page will be rotate back
> into LRU's tail once the write is done so they will reclaim easily
> when memory pressure happens. If backing storage is
> synchrnous device(e.g., zram), hte page will be reclaimed instantly.

Why do we special case async backing storage? Please always try to
explain _why_ the decision is made.

I haven't checked the implementation yet so I cannot comment on that.

> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/swap.h                   |   1 +
>  include/uapi/asm-generic/mman-common.h |   1 +
>  mm/madvise.c                           | 123 +++++++++++++++++++++++++
>  mm/vmscan.c                            |  74 +++++++++++++++
>  4 files changed, 199 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 64795abea003..7f32a948fc6a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -365,6 +365,7 @@ extern int vm_swappiness;
>  extern int remove_mapping(struct address_space *mapping, struct page *page);
>  extern unsigned long vm_total_pages;
>  
> +extern unsigned long reclaim_pages(struct list_head *page_list);
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim_mode;
>  extern int sysctl_min_unmapped_ratio;
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f7a4a5d4b642..b9b51eeb8e1a 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -43,6 +43,7 @@
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
>  #define MADV_COOL	5		/* deactivatie these pages */
> +#define MADV_COLD	6		/* reclaim these pages */
>  
>  /* common parameters: try to keep these consistent across architectures */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c05817fb570d..9a6698b56845 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -42,6 +42,7 @@ static int madvise_need_mmap_write(int behavior)
>  	case MADV_WILLNEED:
>  	case MADV_DONTNEED:
>  	case MADV_COOL:
> +	case MADV_COLD:
>  	case MADV_FREE:
>  		return 0;
>  	default:
> @@ -416,6 +417,125 @@ static long madvise_cool(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> +static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> +				unsigned long end, struct mm_walk *walk)
> +{
> +	pte_t *orig_pte, *pte, ptent;
> +	spinlock_t *ptl;
> +	LIST_HEAD(page_list);
> +	struct page *page;
> +	int isolated = 0;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long next;
> +
> +	next = pmd_addr_end(addr, end);
> +	if (pmd_trans_huge(*pmd)) {
> +		spinlock_t *ptl;
> +
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
> +		if (isolate_lru_page(page))
> +			goto huge_unlock;
> +
> +		list_add(&page->lru, &page_list);
> +huge_unlock:
> +		spin_unlock(ptl);
> +		reclaim_pages(&page_list);
> +		return 0;
> +	}
> +
> +	if (pmd_trans_unstable(pmd))
> +		return 0;
> +regular_page:
> +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> +		ptent = *pte;
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
> +		if (isolate_lru_page(page))
> +			continue;
> +
> +		isolated++;
> +		list_add(&page->lru, &page_list);
> +		if (isolated >= SWAP_CLUSTER_MAX) {
> +			pte_unmap_unlock(orig_pte, ptl);
> +			reclaim_pages(&page_list);
> +			isolated = 0;
> +			pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +			orig_pte = pte;
> +		}
> +	}
> +
> +	pte_unmap_unlock(orig_pte, ptl);
> +	reclaim_pages(&page_list);
> +	cond_resched();
> +
> +	return 0;
> +}
> +
> +static void madvise_cold_page_range(struct mmu_gather *tlb,
> +			     struct vm_area_struct *vma,
> +			     unsigned long addr, unsigned long end)
> +{
> +	struct mm_walk warm_walk = {
> +		.pmd_entry = madvise_cold_pte_range,
> +		.mm = vma->vm_mm,
> +	};
> +
> +	tlb_start_vma(tlb, vma);
> +	walk_page_range(addr, end, &warm_walk);
> +	tlb_end_vma(tlb, vma);
> +}
> +
> +
> +static long madvise_cold(struct vm_area_struct *vma,
> +			unsigned long start_addr, unsigned long end_addr)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct mmu_gather tlb;
> +
> +	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP))
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
> @@ -806,6 +926,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		return madvise_willneed(vma, prev, start, end);
>  	case MADV_COOL:
>  		return madvise_cool(vma, start, end);
> +	case MADV_COLD:
> +		return madvise_cold(vma, start, end);
>  	case MADV_FREE:
>  	case MADV_DONTNEED:
>  		return madvise_dontneed_free(vma, prev, start, end, behavior);
> @@ -828,6 +950,7 @@ madvise_behavior_valid(int behavior)
>  	case MADV_DONTNEED:
>  	case MADV_FREE:
>  	case MADV_COOL:
> +	case MADV_COLD:
>  #ifdef CONFIG_KSM
>  	case MADV_MERGEABLE:
>  	case MADV_UNMERGEABLE:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a28e5d17b495..1701b31f70a8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2096,6 +2096,80 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  			nr_deactivate, nr_rotated, sc->priority, file);
>  }
>  
> +unsigned long reclaim_pages(struct list_head *page_list)
> +{
> +	int nid = -1;
> +	unsigned long nr_isolated[2] = {0, };
> +	unsigned long nr_reclaimed = 0;
> +	LIST_HEAD(node_page_list);
> +	struct reclaim_stat dummy_stat;
> +	struct scan_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +		.priority = DEF_PRIORITY,
> +		.may_writepage = 1,
> +		.may_unmap = 1,
> +		.may_swap = 1,
> +	};
> +
> +	while (!list_empty(page_list)) {
> +		struct page *page;
> +
> +		page = lru_to_page(page_list);
> +		list_del(&page->lru);
> +
> +		if (nid == -1) {
> +			nid = page_to_nid(page);
> +			INIT_LIST_HEAD(&node_page_list);
> +			nr_isolated[0] = nr_isolated[1] = 0;
> +		}
> +
> +		if (nid == page_to_nid(page)) {
> +			list_add(&page->lru, &node_page_list);
> +			nr_isolated[!!page_is_file_cache(page)] +=
> +						hpage_nr_pages(page);
> +			continue;
> +		}
> +
> +		nid = page_to_nid(page);
> +
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					nr_isolated[1]);
> +		nr_reclaimed += shrink_page_list(&node_page_list,
> +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> +				&dummy_stat, true);
> +		while (!list_empty(&node_page_list)) {
> +			struct page *page = lru_to_page(page_list);
> +
> +			list_del(&page->lru);
> +			putback_lru_page(page);
> +		}
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					-nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					-nr_isolated[1]);
> +		nr_isolated[0] = nr_isolated[1] = 0;
> +		INIT_LIST_HEAD(&node_page_list);
> +	}
> +
> +	if (!list_empty(&node_page_list)) {
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					nr_isolated[1]);
> +		nr_reclaimed += shrink_page_list(&node_page_list,
> +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> +				&dummy_stat, true);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					-nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					-nr_isolated[1]);
> +	}
> +
> +	return nr_reclaimed;
> +}
> +
>  /*
>   * The inactive anon list should be small enough that the VM never has
>   * to do too much work.
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Michal Hocko
SUSE Labs
