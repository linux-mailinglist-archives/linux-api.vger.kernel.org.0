Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9966611
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2019 07:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfGLFSh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jul 2019 01:18:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGLFSg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Jul 2019 01:18:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so3773391pfg.10;
        Thu, 11 Jul 2019 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VItVr8C26X7oKiq3PyPjuTyczQ5pJSkwOv602rHoM+E=;
        b=YXU5UvnnaK9CIPLODlJPRz3uj2RWJMBPylz1UIvfypYMc4rdIZ89FL83uLZPSNEpfH
         JxRFcvakfFrbpQOQBNQNGVpEfjWFmZgwO2pRn7VZUwPzyToMpxjfW4bdb40ZgWoOLCrS
         1t6VtP4dFeco1iFnj2d+Pvur31tQp8TXyP32oBDBn7+pGIRGe7APGJ2p3SOhNTJZkdb3
         jPF2r0Kdz5YwMpYTGTqmF/5l+xFynG7b3JirkYx3tDlQ4oPqUFYe+mM7HAQFbtSwehSA
         uXrIh1eTQkQNH7P2wKNv4awt0XOSQamUkZqO0r4BU/a8rqjUjaD5QwJTAeRnfuVyzUTL
         J1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VItVr8C26X7oKiq3PyPjuTyczQ5pJSkwOv602rHoM+E=;
        b=n6FQOB0vU6LdNGfAzBOI1/otmzuL68bM8mh7h/fnCeKJD+nAKZ4et8CiSvqlxD1Rpj
         zzEMY3H8BMyEzofwIoZb3N2BS+xWDqfGrmvcfFJ4zgxct0rc2t77mgI3YNIXfoNmcW5S
         oWkw23HO7TbodvBKFxRkGIP2qiVCpyVXZux1mO2kZqAxOs5w7XUkSw6iyAsSymagQyLa
         0RhCqprgYfo8mkpCqay3mXyDkY5XbUejGrxNx7blskV8LveGti92/cNuRM2ng7wG2Ugp
         moDPHT5iOY6zwg1bY/B0w+dKiBrYujBXwYQN9hj32Tgbz1FRCg6+jlNquZ/Nf2niAaWc
         PzjQ==
X-Gm-Message-State: APjAAAX66RvgkCWWN9NUbCwPWwALC8+XHThsPDmGJNQaNtsr+QCUv/6n
        3pIL+pjNs5TZs0Q8j1uaSrM=
X-Google-Smtp-Source: APXvYqyUHPkgetdPO5gYX8XKUT99yPfOLYbGxfqf76GmZisnbA4eSD5u4ygkKBJ7uWnNWz6mks/HCQ==
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr9587673pjz.72.1562908715757;
        Thu, 11 Jul 2019 22:18:35 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id v12sm6482169pgr.86.2019.07.11.22.18.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 22:18:34 -0700 (PDT)
Date:   Fri, 12 Jul 2019 14:18:28 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <20190712051828.GA128252@google.com>
References: <20190711012528.176050-1-minchan@kernel.org>
 <20190711012528.176050-5-minchan@kernel.org>
 <20190711184223.GD20341@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711184223.GD20341@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Johannes,

On Thu, Jul 11, 2019 at 02:42:23PM -0400, Johannes Weiner wrote:
> On Thu, Jul 11, 2019 at 10:25:28AM +0900, Minchan Kim wrote:
> > @@ -480,6 +482,198 @@ static long madvise_cold(struct vm_area_struct *vma,
> >  	return 0;
> >  }
> >  
> > +static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> > +				unsigned long end, struct mm_walk *walk)
> > +{
> > +	struct mmu_gather *tlb = walk->private;
> > +	struct mm_struct *mm = tlb->mm;
> > +	struct vm_area_struct *vma = walk->vma;
> > +	pte_t *orig_pte, *pte, ptent;
> > +	spinlock_t *ptl;
> > +	LIST_HEAD(page_list);
> > +	struct page *page;
> > +	unsigned long next;
> > +
> > +	if (fatal_signal_pending(current))
> > +		return -EINTR;
> > +
> > +	next = pmd_addr_end(addr, end);
> > +	if (pmd_trans_huge(*pmd)) {
> > +		pmd_t orig_pmd;
> > +
> > +		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
> > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > +		if (!ptl)
> > +			return 0;
> > +
> > +		orig_pmd = *pmd;
> > +		if (is_huge_zero_pmd(orig_pmd))
> > +			goto huge_unlock;
> > +
> > +		if (unlikely(!pmd_present(orig_pmd))) {
> > +			VM_BUG_ON(thp_migration_supported() &&
> > +					!is_pmd_migration_entry(orig_pmd));
> > +			goto huge_unlock;
> > +		}
> > +
> > +		page = pmd_page(orig_pmd);
> > +		if (next - addr != HPAGE_PMD_SIZE) {
> > +			int err;
> > +
> > +			if (page_mapcount(page) != 1)
> > +				goto huge_unlock;
> > +			get_page(page);
> > +			spin_unlock(ptl);
> > +			lock_page(page);
> > +			err = split_huge_page(page);
> > +			unlock_page(page);
> > +			put_page(page);
> > +			if (!err)
> > +				goto regular_page;
> > +			return 0;
> > +		}
> > +
> > +		if (isolate_lru_page(page))
> > +			goto huge_unlock;
> > +
> > +		if (pmd_young(orig_pmd)) {
> > +			pmdp_invalidate(vma, addr, pmd);
> > +			orig_pmd = pmd_mkold(orig_pmd);
> > +
> > +			set_pmd_at(mm, addr, pmd, orig_pmd);
> > +			tlb_remove_tlb_entry(tlb, pmd, addr);
> > +		}
> > +
> > +		ClearPageReferenced(page);
> > +		test_and_clear_page_young(page);
> > +		list_add(&page->lru, &page_list);
> > +huge_unlock:
> > +		spin_unlock(ptl);
> > +		reclaim_pages(&page_list);
> > +		return 0;
> > +	}
> > +
> > +	if (pmd_trans_unstable(pmd))
> > +		return 0;
> > +regular_page:
> > +	tlb_change_page_size(tlb, PAGE_SIZE);
> > +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	flush_tlb_batched_pending(mm);
> > +	arch_enter_lazy_mmu_mode();
> > +	for (; addr < end; pte++, addr += PAGE_SIZE) {
> > +		ptent = *pte;
> > +		if (!pte_present(ptent))
> > +			continue;
> > +
> > +		page = vm_normal_page(vma, addr, ptent);
> > +		if (!page)
> > +			continue;
> > +
> > +		/*
> > +		 * creating a THP page is expensive so split it only if we
> > +		 * are sure it's worth. Split it if we are only owner.
> > +		 */
> > +		if (PageTransCompound(page)) {
> > +			if (page_mapcount(page) != 1)
> > +				break;
> > +			get_page(page);
> > +			if (!trylock_page(page)) {
> > +				put_page(page);
> > +				break;
> > +			}
> > +			pte_unmap_unlock(orig_pte, ptl);
> > +			if (split_huge_page(page)) {
> > +				unlock_page(page);
> > +				put_page(page);
> > +				pte_offset_map_lock(mm, pmd, addr, &ptl);
> > +				break;
> > +			}
> > +			unlock_page(page);
> > +			put_page(page);
> > +			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> > +			pte--;
> > +			addr -= PAGE_SIZE;
> > +			continue;
> > +		}
> > +
> > +		VM_BUG_ON_PAGE(PageTransCompound(page), page);
> > +
> > +		if (isolate_lru_page(page))
> > +			continue;
> > +
> > +		if (pte_young(ptent)) {
> > +			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > +							tlb->fullmm);
> > +			ptent = pte_mkold(ptent);
> > +			set_pte_at(mm, addr, pte, ptent);
> > +			tlb_remove_tlb_entry(tlb, pte, addr);
> > +		}
> > +		ClearPageReferenced(page);
> > +		test_and_clear_page_young(page);
> > +		list_add(&page->lru, &page_list);
> > +	}
> > +
> > +	arch_leave_lazy_mmu_mode();
> > +	pte_unmap_unlock(orig_pte, ptl);
> > +	reclaim_pages(&page_list);
> > +	cond_resched();
> > +
> > +	return 0;
> > +}
> 
> I know you have briefly talked about code sharing already.
> 
> While I agree that sharing with MADV_FREE is maybe a stretch, I
> applied these patches and compared the pageout and the cold page table
> functions, and they are line for line the same EXCEPT for 2-3 lines at
> the very end, where one reclaims and the other deactivates. It would
> be good to share here, it shouldn't be hard or result in fragile code.

Fair enough if we leave MADV_FREE.

> 
> Something like int madvise_cold_or_pageout_range(..., bool pageout)?

How about this?

From 41592f23e876ec21e49dc3c76dc89538e2bb16be Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 12 Jul 2019 14:05:36 +0900
Subject: [PATCH] mm: factor out common parts between MADV_COLD and
 MADV_PAGEOUT

There are many common parts between MADV_COLD and MADV_PAGEOUT.
This patch factor them out to save code duplication.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 201 +++++++++++++--------------------------------------
 1 file changed, 52 insertions(+), 149 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index bc2f0138982e..3d3d14517cc8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -30,6 +30,11 @@
 
 #include "internal.h"
 
+struct madvise_walk_private {
+	struct mmu_gather *tlb;
+	bool pageout;
+};
+
 /*
  * Any behaviour which results in changes to the vma->vm_flags needs to
  * take mmap_sem for writing. Others, which simply traverse vmas, need
@@ -310,16 +315,23 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	return 0;
 }
 
-static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
-				unsigned long end, struct mm_walk *walk)
+static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				struct mm_walk *walk)
 {
-	struct mmu_gather *tlb = walk->private;
+	struct madvise_walk_private *private = walk->private;
+	struct mmu_gather *tlb = private->tlb;
+	bool pageout = private->pageout;
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
-	struct page *page;
 	unsigned long next;
+	struct page *page = NULL;
+	LIST_HEAD(page_list);
+
+	if (fatal_signal_pending(current))
+		return -EINTR;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd)) {
@@ -358,6 +370,12 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 			return 0;
 		}
 
+		if (pageout) {
+			if (isolate_lru_page(page))
+				goto huge_unlock;
+			list_add(&page->lru, &page_list);
+		}
+
 		if (pmd_young(orig_pmd)) {
 			pmdp_invalidate(vma, addr, pmd);
 			orig_pmd = pmd_mkold(orig_pmd);
@@ -366,10 +384,14 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
+		ClearPageReferenced(page);
 		test_and_clear_page_young(page);
-		deactivate_page(page);
 huge_unlock:
 		spin_unlock(ptl);
+		if (pageout)
+			reclaim_pages(&page_list);
+		else
+			deactivate_page(page);
 		return 0;
 	}
 
@@ -423,6 +445,12 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
+		if (pageout) {
+			if (isolate_lru_page(page))
+				continue;
+			list_add(&page->lru, &page_list);
+		}
+
 		if (pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
@@ -437,12 +465,16 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 		 * As a side effect, it makes confuse idle-page tracking
 		 * because they will miss recent referenced history.
 		 */
+		ClearPageReferenced(page);
 		test_and_clear_page_young(page);
-		deactivate_page(page);
+		if (!pageout)
+			deactivate_page(page);
 	}
 
 	arch_enter_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+	if (pageout)
+		reclaim_pages(&page_list);
 	cond_resched();
 
 	return 0;
@@ -452,10 +484,15 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end)
 {
+	struct madvise_walk_private walk_private = {
+		.tlb = tlb,
+		.pageout = false,
+	};
+
 	struct mm_walk cold_walk = {
-		.pmd_entry = madvise_cold_pte_range,
+		.pmd_entry = madvise_cold_or_pageout_pte_range,
 		.mm = vma->vm_mm,
-		.private = tlb,
+		.private = &walk_private,
 	};
 
 	tlb_start_vma(tlb, vma);
@@ -482,153 +519,19 @@ static long madvise_cold(struct vm_area_struct *vma,
 	return 0;
 }
 
-static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
-				unsigned long end, struct mm_walk *walk)
-{
-	struct mmu_gather *tlb = walk->private;
-	struct mm_struct *mm = tlb->mm;
-	struct vm_area_struct *vma = walk->vma;
-	pte_t *orig_pte, *pte, ptent;
-	spinlock_t *ptl;
-	LIST_HEAD(page_list);
-	struct page *page;
-	unsigned long next;
-
-	if (fatal_signal_pending(current))
-		return -EINTR;
-
-	next = pmd_addr_end(addr, end);
-	if (pmd_trans_huge(*pmd)) {
-		pmd_t orig_pmd;
-
-		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
-		ptl = pmd_trans_huge_lock(pmd, vma);
-		if (!ptl)
-			return 0;
-
-		orig_pmd = *pmd;
-		if (is_huge_zero_pmd(orig_pmd))
-			goto huge_unlock;
-
-		if (unlikely(!pmd_present(orig_pmd))) {
-			VM_BUG_ON(thp_migration_supported() &&
-					!is_pmd_migration_entry(orig_pmd));
-			goto huge_unlock;
-		}
-
-		page = pmd_page(orig_pmd);
-		if (next - addr != HPAGE_PMD_SIZE) {
-			int err;
-
-			if (page_mapcount(page) != 1)
-				goto huge_unlock;
-			get_page(page);
-			spin_unlock(ptl);
-			lock_page(page);
-			err = split_huge_page(page);
-			unlock_page(page);
-			put_page(page);
-			if (!err)
-				goto regular_page;
-			return 0;
-		}
-
-		if (isolate_lru_page(page))
-			goto huge_unlock;
-
-		if (pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
-			tlb_remove_tlb_entry(tlb, pmd, addr);
-		}
-
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
-		list_add(&page->lru, &page_list);
-huge_unlock:
-		spin_unlock(ptl);
-		reclaim_pages(&page_list);
-		return 0;
-	}
-
-	if (pmd_trans_unstable(pmd))
-		return 0;
-regular_page:
-	tlb_change_page_size(tlb, PAGE_SIZE);
-	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	flush_tlb_batched_pending(mm);
-	arch_enter_lazy_mmu_mode();
-	for (; addr < end; pte++, addr += PAGE_SIZE) {
-		ptent = *pte;
-		if (!pte_present(ptent))
-			continue;
-
-		page = vm_normal_page(vma, addr, ptent);
-		if (!page)
-			continue;
-
-		/*
-		 * creating a THP page is expensive so split it only if we
-		 * are sure it's worth. Split it if we are only owner.
-		 */
-		if (PageTransCompound(page)) {
-			if (page_mapcount(page) != 1)
-				break;
-			get_page(page);
-			if (!trylock_page(page)) {
-				put_page(page);
-				break;
-			}
-			pte_unmap_unlock(orig_pte, ptl);
-			if (split_huge_page(page)) {
-				unlock_page(page);
-				put_page(page);
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-				break;
-			}
-			unlock_page(page);
-			put_page(page);
-			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-			pte--;
-			addr -= PAGE_SIZE;
-			continue;
-		}
-
-		VM_BUG_ON_PAGE(PageTransCompound(page), page);
-
-		if (isolate_lru_page(page))
-			continue;
-
-		if (pte_young(ptent)) {
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			ptent = pte_mkold(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-		}
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
-		list_add(&page->lru, &page_list);
-	}
-
-	arch_leave_lazy_mmu_mode();
-	pte_unmap_unlock(orig_pte, ptl);
-	reclaim_pages(&page_list);
-	cond_resched();
-
-	return 0;
-}
-
 static void madvise_pageout_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end)
 {
+	struct madvise_walk_private walk_private = {
+		.pageout = true,
+		.tlb = tlb,
+	};
+
 	struct mm_walk pageout_walk = {
-		.pmd_entry = madvise_pageout_pte_range,
+		.pmd_entry = madvise_cold_or_pageout_pte_range,
 		.mm = vma->vm_mm,
-		.private = tlb,
+		.private = &walk_private,
 	};
 
 	tlb_start_vma(tlb, vma);
-- 
2.22.0.410.gd8fdbe21b5-goog

