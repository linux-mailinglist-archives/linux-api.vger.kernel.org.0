Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5464B938
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSM4Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:56:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731757AbfFSM4P (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 19 Jun 2019 08:56:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78E24AFE9;
        Wed, 19 Jun 2019 12:56:13 +0000 (UTC)
Date:   Wed, 19 Jun 2019 14:56:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 1/5] mm: introduce MADV_COLD
Message-ID: <20190619125611.GO2968@dhcp22.suse.cz>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610111252.239156-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 10-06-19 20:12:48, Minchan Kim wrote:
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
> file LRU's head because MADV_COLD is a little bit different symantic.
> MADV_FREE means it's okay to discard when the memory pressure because
> the content of the page is *garbage* so freeing such pages is almost zero
> overhead since we don't need to swap out and access afterward causes just
> minor fault. Thus, it would make sense to put those freeable pages in
> inactive file LRU to compete other used-once pages. It makes sense for
> implmentaion point of view, too because it's not swapbacked memory any
> longer until it would be re-dirtied. Even, it could give a bonus to make
> them be reclaimed on swapless system. However, MADV_COLD doesn't mean
> garbage so reclaiming them requires swap-out/in in the end so it's bigger
> cost. Since we have designed VM LRU aging based on cost-model, anonymous
> cold pages would be better to position inactive anon's LRU list, not file
> LRU. Furthermore, it would help to avoid unnecessary scanning if system
> doesn't have a swap device. Let's start simpler way without adding
> complexity at this moment.

I would only add that it is a caveat that workloads with a lot of page
cache are likely to ignore MADV_COLD on anonymous memory because we
rarely age anonymous LRU lists.

[...]
> +static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> +				unsigned long end, struct mm_walk *walk)
> +{

This is duplicating a large part of madvise_free_pte_range with some
subtle differences which are not explained anywhere (e.g. why does
madvise_free_huge_pmd need try_lock on a page while not here? etc.).

Why cannot we reuse a large part of that code and differ essentially on
the reclaim target check and action? Have you considered to consolidate
the code to share as much as possible? Maybe that is easier said than
done because the devil is always in details...

I would definitely feel much more comfortable to review the code without
thinking about all those subtle details that have been already solved
before. Especially all the THP ones.

Other than that the patch looks sane to me.

> +	struct mmu_gather *tlb = walk->private;
> +	struct mm_struct *mm = tlb->mm;
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t *orig_pte, *pte, ptent;
> +	spinlock_t *ptl;
> +	struct page *page;
> +	unsigned long next;
> +
> +	next = pmd_addr_end(addr, end);
> +	if (pmd_trans_huge(*pmd)) {
> +		pmd_t orig_pmd;
> +
> +		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
> +		ptl = pmd_trans_huge_lock(pmd, vma);
> +		if (!ptl)
> +			return 0;
> +
> +		orig_pmd = *pmd;
> +		if (is_huge_zero_pmd(orig_pmd))
> +			goto huge_unlock;
> +
> +		if (unlikely(!pmd_present(orig_pmd))) {
> +			VM_BUG_ON(thp_migration_supported() &&
> +					!is_pmd_migration_entry(orig_pmd));
> +			goto huge_unlock;
> +		}
> +
> +		page = pmd_page(orig_pmd);
> +		if (next - addr != HPAGE_PMD_SIZE) {
> +			int err;
> +
> +			if (page_mapcount(page) != 1)
> +				goto huge_unlock;
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
> +		if (pmd_young(orig_pmd)) {
> +			pmdp_invalidate(vma, addr, pmd);
> +			orig_pmd = pmd_mkold(orig_pmd);
> +
> +			set_pmd_at(mm, addr, pmd, orig_pmd);
> +			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> +		}
> +
> +		test_and_clear_page_young(page);
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
> +	tlb_change_page_size(tlb, PAGE_SIZE);
> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	flush_tlb_batched_pending(mm);
> +	arch_enter_lazy_mmu_mode();
> +	for (; addr < end; pte++, addr += PAGE_SIZE) {
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
> +		if (pte_young(ptent)) {
> +			ptent = ptep_get_and_clear_full(mm, addr, pte,
> +							tlb->fullmm);
> +			ptent = pte_mkold(ptent);
> +			set_pte_at(mm, addr, pte, ptent);
> +			tlb_remove_tlb_entry(tlb, pte, addr);
> +		}
> +
> +		/*
> +		 * We are deactivating a page for accelerating reclaiming.
> +		 * VM couldn't reclaim the page unless we clear PG_young.
> +		 * As a side effect, it makes confuse idle-page tracking
> +		 * because they will miss recent referenced history.
> +		 */
> +		test_and_clear_page_young(page);
> +		deactivate_page(page);
> +	}
> +
> +	arch_enter_lazy_mmu_mode();
> +	pte_unmap_unlock(orig_pte, ptl);
> +	cond_resched();
> +
> +	return 0;
> +}
-- 
Michal Hocko
SUSE Labs
