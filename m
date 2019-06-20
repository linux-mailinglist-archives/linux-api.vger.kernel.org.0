Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091544C7D5
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 09:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFTHEt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 03:04:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:43250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfFTHEt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 20 Jun 2019 03:04:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A60D3AE34;
        Thu, 20 Jun 2019 07:04:46 +0000 (UTC)
Date:   Thu, 20 Jun 2019 09:04:44 +0200
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
Subject: Re: [PATCH v2 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190620070444.GB12083@dhcp22.suse.cz>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-5-minchan@kernel.org>
 <20190619132450.GQ2968@dhcp22.suse.cz>
 <20190620041620.GB105727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620041620.GB105727@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 20-06-19 13:16:20, Minchan Kim wrote:
> On Wed, Jun 19, 2019 at 03:24:50PM +0200, Michal Hocko wrote:
> > On Mon 10-06-19 20:12:51, Minchan Kim wrote:
> > [...]
> > > +static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> > > +				unsigned long end, struct mm_walk *walk)
> > 
> > Again the same question about a potential code reuse...
> > [...]
> > > +regular_page:
> > > +	tlb_change_page_size(tlb, PAGE_SIZE);
> > > +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > > +	flush_tlb_batched_pending(mm);
> > > +	arch_enter_lazy_mmu_mode();
> > > +	for (; addr < end; pte++, addr += PAGE_SIZE) {
> > > +		ptent = *pte;
> > > +		if (!pte_present(ptent))
> > > +			continue;
> > > +
> > > +		page = vm_normal_page(vma, addr, ptent);
> > > +		if (!page)
> > > +			continue;
> > > +
> > > +		if (isolate_lru_page(page))
> > > +			continue;
> > > +
> > > +		isolated++;
> > > +		if (pte_young(ptent)) {
> > > +			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > > +							tlb->fullmm);
> > > +			ptent = pte_mkold(ptent);
> > > +			set_pte_at(mm, addr, pte, ptent);
> > > +			tlb_remove_tlb_entry(tlb, pte, addr);
> > > +		}
> > > +		ClearPageReferenced(page);
> > > +		test_and_clear_page_young(page);
> > > +		list_add(&page->lru, &page_list);
> > > +		if (isolated >= SWAP_CLUSTER_MAX) {
> > 
> > Why do we need SWAP_CLUSTER_MAX batching? Especially when we need ...
> > [...]
> 
> It aims for preventing early OOM kill since we isolate too many LRU
> pages concurrently.

This is a good point. For some reason I thought that we consider
isolated pages in should_reclaim_retry but we do not anymore (since we
move from zone to node LRUs I guess). Please stick a comment there.

> > > +unsigned long reclaim_pages(struct list_head *page_list)
> > > +{
> > > +	int nid = -1;
> > > +	unsigned long nr_reclaimed = 0;
> > > +	LIST_HEAD(node_page_list);
> > > +	struct reclaim_stat dummy_stat;
> > > +	struct scan_control sc = {
> > > +		.gfp_mask = GFP_KERNEL,
> > > +		.priority = DEF_PRIORITY,
> > > +		.may_writepage = 1,
> > > +		.may_unmap = 1,
> > > +		.may_swap = 1,
> > > +	};
> > > +
> > > +	while (!list_empty(page_list)) {
> > > +		struct page *page;
> > > +
> > > +		page = lru_to_page(page_list);
> > > +		if (nid == -1) {
> > > +			nid = page_to_nid(page);
> > > +			INIT_LIST_HEAD(&node_page_list);
> > > +		}
> > > +
> > > +		if (nid == page_to_nid(page)) {
> > > +			list_move(&page->lru, &node_page_list);
> > > +			continue;
> > > +		}
> > > +
> > > +		nr_reclaimed += shrink_page_list(&node_page_list,
> > > +						NODE_DATA(nid),
> > > +						&sc, 0,
> > > +						&dummy_stat, false);
> > 
> > per-node batching in fact. Other than that nothing really jumped at me.
> > Except for the shared page cache side channel timing aspect not being
> > considered AFAICS. To be more specific. Pushing out a shared page cache
> > is possible even now but this interface gives a much easier tool to
> > evict shared state and perform all sorts of timing attacks. Unless I am
> > missing something we should be doing something similar to mincore and
> > ignore shared pages without a writeable access or at least document why
> > we do not care.
> 
> I'm not sure IIUC side channel attach. As you mentioned, without this syscall,
> 1. they already can do that simply by memory hogging

This is way much more harder for practical attacks because the reclaim
logic is not fully under the attackers control. Having a direct tool to
reclaim memory directly then just opens doors to measure the other
consumers of that memory and all sorts of side channel.

> 2. If we need fix MADV_PAGEOUT, that means we need to fix MADV_DONTNEED, too?

nope because MADV_DONTNEED doesn't unmap from other processes.
-- 
Michal Hocko
SUSE Labs
