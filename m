Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9028133A0F
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 23:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFCVrI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 17:47:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44059 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCVrG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 17:47:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so2535892pfe.11
        for <linux-api@vger.kernel.org>; Mon, 03 Jun 2019 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9LPKxd1nI0ZUtX3abWKWE3c/1njFqcKECDTFnlPGL2o=;
        b=FKzf7YDb4qFfQZg6nrRvW4ycRM0/BZA6wFJ1vLs7IldrWmXI3xJqN0FlXgOQuQtP3w
         iOoOuxKQT7vJoEYXgkm50Y9hp80Pmxe+shwuUB2Ha8D0dFvrbw5EAmGRXa3yKpuykMQh
         /CppskyHBegOtPKxkPQ7roJoyW89VLBsMI0Bfo6B2vlNLav5Dco6HA8KDsSFZZi5OQ5Z
         il27slw+3ar1ciVjpOeX4xK/PenlX19YM86soJ9NsAQy3ikiOc6C3ehQyzUxB5b//hfS
         dYp8IKidYk9ktoLayJxda7dxkdAexm0k6mkAj4XUyG4mrXnHZTQF7Q5Yu31yVOH6NfVZ
         p/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9LPKxd1nI0ZUtX3abWKWE3c/1njFqcKECDTFnlPGL2o=;
        b=g2ewYlGwzd6+LDzcjdRGVs/G2ZNcxNVsc+9roYxHN8BqO6sL6NQ1LMqgNwLaO9uR9O
         881/fVjUpoFOU+Q9vMcEaRVRwDHMsy6cbYjbeHS5GBwxW0ErcYsNQe38Vp9cciQelFi5
         PP8BDoByvZCOrItRv1D9ScIIm2MelDL95am1mw+oNtHaTBQuJxWs89wZzSW9k0dMt100
         Y7ZftF4ORQCGOM6lQ5D2mGQVHOEd6sWDW3JpH4fUbYjVp7X/Zp22301WhiBPxRXiq5iS
         UdmtyLGWvVk9nCY7w5HYz1X+2iFlr7jeGtHeWPlbB68r+cTs9Uaj8LM1suVyRbEnT88z
         3fEQ==
X-Gm-Message-State: APjAAAWMSZwpSy/bwYqMaarOgDJc0rUT1u9WJ68ztXBbuEmSX1LbTWkv
        nE1c5rLq3wWcJ5DS991iWBLZ8g==
X-Google-Smtp-Source: APXvYqyM2Y0sae+nSGLXKThpQney4UrZWsYqt8jVPmg5YWX93aNmlOJcmKBPnSemkZt8jdJU4q+2Dg==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr11770806pja.104.1559594353536;
        Mon, 03 Jun 2019 13:39:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id l21sm15463318pff.40.2019.06.03.13.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 13:39:12 -0700 (PDT)
Date:   Mon, 3 Jun 2019 16:39:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH v1 4/4] mm: introduce MADV_PAGEOUT
Message-ID: <20190603203911.GA14953@cmpxchg.org>
References: <20190603053655.127730-1-minchan@kernel.org>
 <20190603053655.127730-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603053655.127730-5-minchan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 03, 2019 at 02:36:55PM +0900, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range
> for a long time, it could hint kernel that the pages can be
> reclaimed instantly but data should be preserved for future use.
> This could reduce workingset eviction so it ends up increasing
> performance.
> 
> This patch introduces the new MADV_PAGEOUT hint to madvise(2)
> syscall. MADV_PAGEOUT can be used by a process to mark a memory
> range as not expected to be used for a long time so that kernel
> reclaims *any LRU* pages instantly. The hint can help kernel in deciding
> which pages to evict proactively.
> 
> All of error rule is same with MADV_DONTNEED.
> 
> Note:
>     This hint works with only private pages(IOW, page_mapcount(page) < 2)
>     because shared page could have more chance to be accessed from other
>     processes sharing the page so that it could cause major fault soon,
>     which is inefficient.
> 
> * RFC v2
>  * make reclaim_pages simple via factoring out isolate logic - hannes
> 
> * RFCv1
>  * rename from MADV_COLD to MADV_PAGEOUT - hannes
>  * bail out if process is being killed - Hillf
>  * fix reclaim_pages bugs - Hillf
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/swap.h                   |   1 +
>  include/uapi/asm-generic/mman-common.h |   1 +
>  mm/madvise.c                           | 126 +++++++++++++++++++++++++
>  mm/vmscan.c                            |  34 +++++++
>  4 files changed, 162 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0ce997edb8bb..063c0c1e112b 100644
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
> index 1190f4e7f7b9..92e347a89ddc 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -44,6 +44,7 @@
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
>  #define MADV_COLD	5		/* deactivatie these pages */
> +#define MADV_PAGEOUT	6		/* reclaim these pages */
>  
>  /* common parameters: try to keep these consistent across architectures */
>  #define MADV_FREE	8		/* free pages only if memory pressure */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index ab158766858a..b010249cb8b6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -41,6 +41,7 @@ static int madvise_need_mmap_write(int behavior)
>  	case MADV_WILLNEED:
>  	case MADV_DONTNEED:
>  	case MADV_COLD:
> +	case MADV_PAGEOUT:
>  	case MADV_FREE:
>  		return 0;
>  	default:
> @@ -415,6 +416,128 @@ static long madvise_cold(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> +static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
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
> +	if (fatal_signal_pending(current))
> +		return -EINTR;
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
> +static void madvise_pageout_page_range(struct mmu_gather *tlb,
> +			     struct vm_area_struct *vma,
> +			     unsigned long addr, unsigned long end)
> +{
> +	struct mm_walk warm_walk = {
> +		.pmd_entry = madvise_pageout_pte_range,
> +		.mm = vma->vm_mm,
> +	};
> +
> +	tlb_start_vma(tlb, vma);
> +	walk_page_range(addr, end, &warm_walk);
> +	tlb_end_vma(tlb, vma);
> +}
> +
> +
> +static long madvise_pageout(struct vm_area_struct *vma,
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
> +	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +	tlb_finish_mmu(&tlb, start_addr, end_addr);
> +
> +	return 0;
> +}
> +
>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  				unsigned long end, struct mm_walk *walk)
>  
> @@ -805,6 +928,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		return madvise_willneed(vma, prev, start, end);
>  	case MADV_COLD:
>  		return madvise_cold(vma, prev, start, end);
> +	case MADV_PAGEOUT:
> +		return madvise_pageout(vma, prev, start, end);
>  	case MADV_FREE:
>  	case MADV_DONTNEED:
>  		return madvise_dontneed_free(vma, prev, start, end, behavior);
> @@ -827,6 +952,7 @@ madvise_behavior_valid(int behavior)
>  	case MADV_DONTNEED:
>  	case MADV_FREE:
>  	case MADV_COLD:
> +	case MADV_PAGEOUT:
>  #ifdef CONFIG_KSM
>  	case MADV_MERGEABLE:
>  	case MADV_UNMERGEABLE:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 56df55e8afcd..2c2cf442db58 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2136,6 +2136,40 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  			nr_deactivate, nr_rotated, sc->priority, file);
>  }
>  
> +unsigned long reclaim_pages(struct list_head *page_list)
> +{
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
> +		list_move(&page->lru, &node_page_list);
> +		nr_reclaimed += shrink_page_list(&node_page_list,
> +						page_pgdat(page),
> +						&sc, TTU_IGNORE_ACCESS,
> +						&dummy_stat, true);
> +		if (!list_empty(&node_page_list)) {
> +			struct page *page = lru_to_page(&node_page_list);
> +
> +			list_del(&page->lru);
> +			putback_lru_page(page);
> +
> +		}
> +	}

Awesome, this is way more readable now. Thanks for the cleanup!

Regarding the loop, for the vast majority of instances, pages on
page_list will actually be from the same node. It would make sense to
do batching here and collect pages until last_pgdat != pgdat. That
should reduce the number of tlb flushes and memcg uncharge flushes in
shrink_page_list().
