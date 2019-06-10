Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C583B3DB
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2019 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbfFJLNe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Jun 2019 07:13:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46062 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbfFJLNe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Jun 2019 07:13:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so5101383pfm.12;
        Mon, 10 Jun 2019 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPG+ROWOzHjK16mIcQ4C+hvTtB/BQwTOXkhzxALsNDM=;
        b=NmKhfQn2/0M7QiWafaLEoMeyTHABnSvZPFy8O2V0AL4u+lJgz3njJVO5H5zxGzSy4h
         xqy2KzD/DPsBMirf/T36qYm88jTFj8X6yvNuTsL1Bi5EzG+aT6xZ3Iuqua1UWhM+k0yO
         GKY2t/Fyiv9LwekT+YjjHt3Sp5yhJKexKC6lqjeGNtd6uVcz0EntdyZo6eFsoNTHjVQX
         uu12cLDdBNqTnwdJib0hsQJdAgoElWA9sdMeGjxMzFwrJywj8p6yYGc+mjPf2MrEQ8DK
         jjyRMG/Vyt0JFVhWG1IBivNsQnuK1M/mpK5CR5Iu+DnuKJ8+3YdEGPIafurC55SsJ7PA
         We0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rPG+ROWOzHjK16mIcQ4C+hvTtB/BQwTOXkhzxALsNDM=;
        b=TSNFuYJnpKE8QsTiDOn1IyuZ0iAObReFpgaL+rspuPqBRR84DNeYCgnevaDe0t37c7
         eCTNphI4lJIbagI+I9mgOfW6YkYl6MCqrullb3w+pB+V8q0+HUcSHTLrykf40EwFSENj
         X3NZPHLP8nIi/N+/KRbdn0TxcT6wqvipnOR2OPnwHkTQ4N2KkH0SsWl6Du9/NCrkE/rO
         Ulrhw0aoqETsoN2ELzod+pU1gIMxuNAZdbA6udgBHSU11VHUi8CLAOK556h/QV9uGBXp
         IIROFLAOCiDBpe8ZIWiR7ltpCNtlZmsO5SFDZtj3EbLpdrfv3PdhATv5zB0cDYSuDpgl
         IoIQ==
X-Gm-Message-State: APjAAAXfTP7zliQw/CYDBZtMv37OgoeMduPxsQGqdxizVXS4TIYGDb78
        4saseAx7emlj/et2Xfj1KIA=
X-Google-Smtp-Source: APXvYqzY4WtiEyc3qVwXA80Fry7VpC5HipNq59JihUKhfrGRMamA0pPT4cEFDQGwJD6Cz7sjB8iumw==
X-Received: by 2002:aa7:8193:: with SMTP id g19mr67599446pfi.162.1560165213314;
        Mon, 10 Jun 2019 04:13:33 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id h14sm9224633pgj.8.2019.06.10.04.13.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 04:13:32 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christopher Lameter <cl@linux.com>
Subject: [PATCH v2 5/5] mm: factor out pmd young/dirty bit handling and THP split
Date:   Mon, 10 Jun 2019 20:12:52 +0900
Message-Id: <20190610111252.239156-6-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610111252.239156-1-minchan@kernel.org>
References: <20190610111252.239156-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Now, there are common part among MADV_COLD|PAGEOUT|FREE to reset
access/dirty bit resetting or split the THP page to handle part
of subpages in the THP page. This patch factor out the common part.

Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Christopher Lameter <cl@linux.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/huge_mm.h |   3 -
 mm/huge_memory.c        |  74 -------------
 mm/madvise.c            | 234 +++++++++++++++++++++++-----------------
 3 files changed, 135 insertions(+), 176 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c150c21d..2667e1aa3ce5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -29,9 +29,6 @@ extern struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 					  unsigned long addr,
 					  pmd_t *pmd,
 					  unsigned int flags);
-extern bool madvise_free_huge_pmd(struct mmu_gather *tlb,
-			struct vm_area_struct *vma,
-			pmd_t *pmd, unsigned long addr, unsigned long next);
 extern int zap_huge_pmd(struct mmu_gather *tlb,
 			struct vm_area_struct *vma,
 			pmd_t *pmd, unsigned long addr);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9a6b32..22e20f929463 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1668,80 +1668,6 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	return 0;
 }
 
-/*
- * Return true if we do MADV_FREE successfully on entire pmd page.
- * Otherwise, return false.
- */
-bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		pmd_t *pmd, unsigned long addr, unsigned long next)
-{
-	spinlock_t *ptl;
-	pmd_t orig_pmd;
-	struct page *page;
-	struct mm_struct *mm = tlb->mm;
-	bool ret = false;
-
-	tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
-
-	ptl = pmd_trans_huge_lock(pmd, vma);
-	if (!ptl)
-		goto out_unlocked;
-
-	orig_pmd = *pmd;
-	if (is_huge_zero_pmd(orig_pmd))
-		goto out;
-
-	if (unlikely(!pmd_present(orig_pmd))) {
-		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(orig_pmd));
-		goto out;
-	}
-
-	page = pmd_page(orig_pmd);
-	/*
-	 * If other processes are mapping this page, we couldn't discard
-	 * the page unless they all do MADV_FREE so let's skip the page.
-	 */
-	if (page_mapcount(page) != 1)
-		goto out;
-
-	if (!trylock_page(page))
-		goto out;
-
-	/*
-	 * If user want to discard part-pages of THP, split it so MADV_FREE
-	 * will deactivate only them.
-	 */
-	if (next - addr != HPAGE_PMD_SIZE) {
-		get_page(page);
-		spin_unlock(ptl);
-		split_huge_page(page);
-		unlock_page(page);
-		put_page(page);
-		goto out_unlocked;
-	}
-
-	if (PageDirty(page))
-		ClearPageDirty(page);
-	unlock_page(page);
-
-	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
-		pmdp_invalidate(vma, addr, pmd);
-		orig_pmd = pmd_mkold(orig_pmd);
-		orig_pmd = pmd_mkclean(orig_pmd);
-
-		set_pmd_at(mm, addr, pmd, orig_pmd);
-		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	}
-
-	mark_page_lazyfree(page);
-	ret = true;
-out:
-	spin_unlock(ptl);
-out_unlocked:
-	return ret;
-}
-
 static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 {
 	pgtable_t pgtable;
diff --git a/mm/madvise.c b/mm/madvise.c
index 3b9d2ba421b1..bb1906bb75fd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -310,6 +310,91 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	return 0;
 }
 
+enum madv_pmdp_reset_t {
+	MADV_PMDP_RESET,	/* pmd was reset successfully */
+	MADV_PMDP_SPLIT,	/* pmd was split */
+	MADV_PMDP_ERROR,
+};
+
+static enum madv_pmdp_reset_t madvise_pmdp_reset_or_split(struct mm_walk *walk,
+				pmd_t *pmd, spinlock_t *ptl,
+				unsigned long addr, unsigned long end,
+				bool young, bool dirty)
+{
+	pmd_t orig_pmd;
+	unsigned long next;
+	struct page *page;
+	struct mmu_gather *tlb = walk->private;
+	struct mm_struct *mm = walk->mm;
+	struct vm_area_struct *vma = walk->vma;
+	bool reset_young = false;
+	bool reset_dirty = false;
+	enum madv_pmdp_reset_t ret = MADV_PMDP_ERROR;
+
+	orig_pmd = *pmd;
+	if (is_huge_zero_pmd(orig_pmd))
+		return ret;
+
+	if (unlikely(!pmd_present(orig_pmd))) {
+		VM_BUG_ON(thp_migration_supported() &&
+				!is_pmd_migration_entry(orig_pmd));
+		return ret;
+	}
+
+	next = pmd_addr_end(addr, end);
+	page = pmd_page(orig_pmd);
+	if (next - addr != HPAGE_PMD_SIZE) {
+		/*
+		 * THP collapsing is not cheap so only split the page is
+		 * private to the this process.
+		 */
+		if (page_mapcount(page) != 1)
+			return ret;
+		get_page(page);
+		spin_unlock(ptl);
+		lock_page(page);
+		if (!split_huge_page(page))
+			ret = MADV_PMDP_SPLIT;
+		unlock_page(page);
+		put_page(page);
+		return ret;
+	}
+
+	if (young && pmd_young(orig_pmd))
+		reset_young = true;
+	if (dirty && pmd_dirty(orig_pmd))
+		reset_dirty = true;
+
+	/*
+	 * Other process could rely on the PG_dirty for data consistency,
+	 * not pte_dirty so we could reset PG_dirty only when we are owner
+	 * of the page.
+	 */
+	if (reset_dirty) {
+		if (page_mapcount(page) != 1)
+			goto out;
+		if (!trylock_page(page))
+			goto out;
+		if (PageDirty(page))
+			ClearPageDirty(page);
+		unlock_page(page);
+	}
+
+	ret = MADV_PMDP_RESET;
+	if (reset_young || reset_dirty) {
+		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
+		pmdp_invalidate(vma, addr, pmd);
+		if (reset_young)
+			orig_pmd = pmd_mkold(orig_pmd);
+		if (reset_dirty)
+			orig_pmd = pmd_mkclean(orig_pmd);
+		set_pmd_at(mm, addr, pmd, orig_pmd);
+		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+	}
+out:
+	return ret;
+}
+
 static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
@@ -319,64 +404,31 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *orig_pte, *pte, ptent;
 	spinlock_t *ptl;
 	struct page *page;
-	unsigned long next;
 
-	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd)) {
-		pmd_t orig_pmd;
-
-		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 		ptl = pmd_trans_huge_lock(pmd, vma);
 		if (!ptl)
 			return 0;
 
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
-
-			get_page(page);
+		switch (madvise_pmdp_reset_or_split(walk, pmd, ptl, addr, end,
+							true, false)) {
+		case MADV_PMDP_RESET:
 			spin_unlock(ptl);
-			lock_page(page);
-			err = split_huge_page(page);
-			unlock_page(page);
-			put_page(page);
-			if (!err)
-				goto regular_page;
-			return 0;
-		}
-
-		if (pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
-			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+			page = pmd_page(*pmd);
+			test_and_clear_page_young(page);
+			deactivate_page(page);
+			goto next;
+		case MADV_PMDP_ERROR:
+			spin_unlock(ptl);
+			goto next;
+		case MADV_PMDP_SPLIT:
+			; /* go through */
 		}
-
-		test_and_clear_page_young(page);
-		deactivate_page(page);
-huge_unlock:
-		spin_unlock(ptl);
-		return 0;
 	}
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
-regular_page:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -414,6 +466,7 @@ static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
 
 	arch_enter_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
+next:
 	cond_resched();
 
 	return 0;
@@ -464,70 +517,38 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
 	LIST_HEAD(page_list);
 	struct page *page;
 	int isolated = 0;
-	unsigned long next;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd)) {
-		pmd_t orig_pmd;
-
-		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 		ptl = pmd_trans_huge_lock(pmd, vma);
 		if (!ptl)
 			return 0;
 
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
+		switch (madvise_pmdp_reset_or_split(walk, pmd, ptl, addr, end,
+							true, false)) {
+		case MADV_PMDP_RESET:
+			page = pmd_page(*pmd);
 			spin_unlock(ptl);
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
+			if (isolate_lru_page(page))
+				return 0;
+			ClearPageReferenced(page);
+			test_and_clear_page_young(page);
+			list_add(&page->lru, &page_list);
+			reclaim_pages(&page_list);
+			goto next;
+		case MADV_PMDP_ERROR:
+			spin_unlock(ptl);
+			goto next;
+		case MADV_PMDP_SPLIT:
+			; /* go through */
 		}
-
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
-		list_add(&page->lru, &page_list);
-huge_unlock:
-		spin_unlock(ptl);
-		reclaim_pages(&page_list);
-		return 0;
 	}
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
-regular_page:
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -569,6 +590,7 @@ static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	reclaim_pages(&page_list);
+next:
 	cond_resched();
 
 	return 0;
@@ -620,12 +642,26 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *orig_pte, *pte, ptent;
 	struct page *page;
 	int nr_swap = 0;
-	unsigned long next;
 
-	next = pmd_addr_end(addr, end);
-	if (pmd_trans_huge(*pmd))
-		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
+	if (pmd_trans_huge(*pmd)) {
+		ptl = pmd_trans_huge_lock(pmd, vma);
+		if (!ptl)
+			return 0;
+
+		switch (madvise_pmdp_reset_or_split(walk, pmd, ptl, addr, end,
+							true, true)) {
+		case MADV_PMDP_RESET:
+			page = pmd_page(*pmd);
+			spin_unlock(ptl);
+			mark_page_lazyfree(page);
 			goto next;
+		case MADV_PMDP_ERROR:
+			spin_unlock(ptl);
+			goto next;
+		case MADV_PMDP_SPLIT:
+			; /* go through */
+		}
+	}
 
 	if (pmd_trans_unstable(pmd))
 		return 0;
@@ -737,8 +773,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	}
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
-	cond_resched();
 next:
+	cond_resched();
 	return 0;
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

