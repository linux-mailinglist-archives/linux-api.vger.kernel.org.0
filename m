Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6FBD65F96
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2019 20:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfGKSm2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jul 2019 14:42:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47052 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfGKSm1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jul 2019 14:42:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so3454283plz.13
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2019 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ye/ueaLSHeuUbF2UmwC3qi+L8ppesjqbY1zG1QqAhZE=;
        b=LczJZj1LMI38wtffmfcB6+DCfMF5aokwVwquBj7rOFWJQgRco8bf3jn7Y7DRGU5AKV
         eyjU2kDty+AJg5gmH7znkDUWdSkh2RLvTYYxEUHfUOHIABMuT/zxz26VO2fWPMLpbI42
         Q0nKfVbhqRFEaZHRqg01t1RLn3rSDiadjybENTkR+xzCP5NkdrHC11Iih4QtXXJJEJ+2
         wAnVn52naxG/hzDpgjqUVpVG8nvWNFb9Nm9+54eKFTwbHQZW+h21HGKmNMQL9ThFb9Vb
         wu6ijN+pWhsut8bcnEO8hAL8JYSaTWFrXUY1xJwZBT5S2jLMFydUdVKuRZGN4kxI/tkg
         glJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ye/ueaLSHeuUbF2UmwC3qi+L8ppesjqbY1zG1QqAhZE=;
        b=ZtZCDy9qWd6q8i4y+hTd1hrLN6YmsAnWiQoFK159Cyf+nvFrQUq86YGJziH09095cc
         0+sRqY1sm7jAr/DQgruUNHbt/hzA4WM74NZU8GptGy00HgvNdh1mb8VzPMfGwUyZlPsK
         dLgiqdOV2zRBNFdMBWfYWUUCaMvMzy4IST2AyKszZh1Ek4GkisDI+6HitYDH73Iq333m
         mBfvholw9iZfyoCN9lvsZRzS1gYIpt7J9H/8cKmQAbTY7dkAvHaD2lrxuveqqNK6pfKk
         7658xVE4CJY+JUY+9Vd6W0Ao+0hYev0XdcVSN2Cbny4hSSZmrUi9FvOP1IOwzC3l91uf
         pLYQ==
X-Gm-Message-State: APjAAAVewsVL2DXzYjGZKfkePId7OTcWAcqKAoW9Kee7FXqxYeSsQVmj
        NupJilKBRzjn8oqcaeQmbfw=
X-Google-Smtp-Source: APXvYqyaXVTrExLmUq7EZsqLnA7MmMx/jzEwrsO/Wn15ERbU1WlzrYFkuyZ9jcRvlFh1JKkaVAl1hw==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr5969327plr.274.1562870546389;
        Thu, 11 Jul 2019 11:42:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5385])
        by smtp.gmail.com with ESMTPSA id 85sm6717518pfv.130.2019.07.11.11.42.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 11:42:25 -0700 (PDT)
Date:   Thu, 11 Jul 2019 14:42:23 -0400
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 4/4] mm: introduce MADV_PAGEOUT
Message-ID: <20190711184223.GD20341@cmpxchg.org>
References: <20190711012528.176050-1-minchan@kernel.org>
 <20190711012528.176050-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711012528.176050-5-minchan@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 11, 2019 at 10:25:28AM +0900, Minchan Kim wrote:
> @@ -480,6 +482,198 @@ static long madvise_cold(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> +static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> +				unsigned long end, struct mm_walk *walk)
> +{
> +	struct mmu_gather *tlb = walk->private;
> +	struct mm_struct *mm = tlb->mm;
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t *orig_pte, *pte, ptent;
> +	spinlock_t *ptl;
> +	LIST_HEAD(page_list);
> +	struct page *page;
> +	unsigned long next;
> +
> +	if (fatal_signal_pending(current))
> +		return -EINTR;
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
> +		if (pmd_young(orig_pmd)) {
> +			pmdp_invalidate(vma, addr, pmd);
> +			orig_pmd = pmd_mkold(orig_pmd);
> +
> +			set_pmd_at(mm, addr, pmd, orig_pmd);
> +			tlb_remove_tlb_entry(tlb, pmd, addr);
> +		}
> +
> +		ClearPageReferenced(page);
> +		test_and_clear_page_young(page);
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
> +	tlb_change_page_size(tlb, PAGE_SIZE);
> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	flush_tlb_batched_pending(mm);
> +	arch_enter_lazy_mmu_mode();
> +	for (; addr < end; pte++, addr += PAGE_SIZE) {
> +		ptent = *pte;
> +		if (!pte_present(ptent))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, ptent);
> +		if (!page)
> +			continue;
> +
> +		/*
> +		 * creating a THP page is expensive so split it only if we
> +		 * are sure it's worth. Split it if we are only owner.
> +		 */
> +		if (PageTransCompound(page)) {
> +			if (page_mapcount(page) != 1)
> +				break;
> +			get_page(page);
> +			if (!trylock_page(page)) {
> +				put_page(page);
> +				break;
> +			}
> +			pte_unmap_unlock(orig_pte, ptl);
> +			if (split_huge_page(page)) {
> +				unlock_page(page);
> +				put_page(page);
> +				pte_offset_map_lock(mm, pmd, addr, &ptl);
> +				break;
> +			}
> +			unlock_page(page);
> +			put_page(page);
> +			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +			pte--;
> +			addr -= PAGE_SIZE;
> +			continue;
> +		}
> +
> +		VM_BUG_ON_PAGE(PageTransCompound(page), page);
> +
> +		if (isolate_lru_page(page))
> +			continue;
> +
> +		if (pte_young(ptent)) {
> +			ptent = ptep_get_and_clear_full(mm, addr, pte,
> +							tlb->fullmm);
> +			ptent = pte_mkold(ptent);
> +			set_pte_at(mm, addr, pte, ptent);
> +			tlb_remove_tlb_entry(tlb, pte, addr);
> +		}
> +		ClearPageReferenced(page);
> +		test_and_clear_page_young(page);
> +		list_add(&page->lru, &page_list);
> +	}
> +
> +	arch_leave_lazy_mmu_mode();
> +	pte_unmap_unlock(orig_pte, ptl);
> +	reclaim_pages(&page_list);
> +	cond_resched();
> +
> +	return 0;
> +}

I know you have briefly talked about code sharing already.

While I agree that sharing with MADV_FREE is maybe a stretch, I
applied these patches and compared the pageout and the cold page table
functions, and they are line for line the same EXCEPT for 2-3 lines at
the very end, where one reclaims and the other deactivates. It would
be good to share here, it shouldn't be hard or result in fragile code.

Something like int madvise_cold_or_pageout_range(..., bool pageout)?
