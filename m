Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C723B3D0
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2019 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbfFJLNK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Jun 2019 07:13:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46725 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbfFJLNK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Jun 2019 07:13:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so3158947pgr.13;
        Mon, 10 Jun 2019 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVb+RK9HpdqgjRFPqEqYP4eUpeiWX6FbBcFPVfvZWbM=;
        b=CbTXbXRgrmo+QMwdGcPr+mtk35N+mI2OXBuFin4aGreM+RZux3GfHClxnjtOW5ZuhP
         5yjaSnBgmWtX+sVwqhNh5Jv/QFq4VwyYDqOspXjjHN/KRBDAmqJSxLTNvfxdG4cFqOc6
         B5vo7ARsDGCk0ODSdTHxFBZqmrM3/yw7qUZatAboTHPBtgRMFBx75n1K4BZU5GJUncdN
         ZhnFDEy2iS1fG0QeX+djTZuJISIpA9IdxwelJ7gJOwoieSKIfJfie2WZMS+Pt6S8yVVf
         x7l7sr3nFLgreq24qLTDfRIMSGtFJ1DY4zf9zZ7+zKOH81DUJaffIOnshusBFWS9x9AH
         cK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LVb+RK9HpdqgjRFPqEqYP4eUpeiWX6FbBcFPVfvZWbM=;
        b=CkPkRJZbbDK5ONU9Q/BSUd1AfTMvPHis9ZtEX54NPW5oqPdV5svjtO7nZObjI0k18S
         GzKgNceKYWBQzGkDYTfU5OJC5+NqwalRzr11F70v4TGZnCo7H6re7LfL2Mdsf9pEunF+
         ILFAgy57zAwZ2GnCjELKIBXCIYOZ1ozp8TOHB5qzKhN8T/ll/vmuxFbe59Y/DT1Ipazq
         cFGbTY4SWnhAhWJUwoGZINOx6qTgFLODIrH3gQAyCYjxArhBUsx1qwOnB5uyYWk/6hl6
         tc0k1PBnMg2KNAXbrFhuE1mi0/xhuuA6Yq3bOqNgFkZVpIOucd4rwLOxRfxZ/K51szia
         LwLg==
X-Gm-Message-State: APjAAAUtY9sdHwaf56lwd3d3XGaUPUx9DfsikuQl0lTeQmP4rlS4EQoo
        BY26xeFcrpXfS8CozwEyNic=
X-Google-Smtp-Source: APXvYqySeM+HZBTI11B6RovghcMCND58FiVz2JND6vULdAIVKkw5DAT68mAXRa0UoXrA0udL/FTkLw==
X-Received: by 2002:a63:70f:: with SMTP id 15mr14875676pgh.432.1560165189062;
        Mon, 10 Jun 2019 04:13:09 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id h14sm9224633pgj.8.2019.06.10.04.13.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 04:13:07 -0700 (PDT)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 1/5] mm: introduce MADV_COLD
Date:   Mon, 10 Jun 2019 20:12:48 +0900
Message-Id: <20190610111252.239156-2-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190610111252.239156-1-minchan@kernel.org>
References: <20190610111252.239156-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When a process expects no accesses to a certain memory range, it could
give a hint to kernel that the pages can be reclaimed when memory pressure
happens but data should be preserved for future use.  This could reduce
workingset eviction so it ends up increasing performance.

This patch introduces the new MADV_COLD hint to madvise(2) syscall.
MADV_COLD can be used by a process to mark a memory range as not expected
to be used in the near future. The hint can help kernel in deciding which
pages to evict early during memory pressure.

It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves

	active file page -> inactive file LRU
	active anon page -> inacdtive anon LRU

Unlike MADV_FREE, it doesn't move active anonymous pages to inactive
file LRU's head because MADV_COLD is a little bit different symantic.
MADV_FREE means it's okay to discard when the memory pressure because
the content of the page is *garbage* so freeing such pages is almost zero
overhead since we don't need to swap out and access afterward causes just
minor fault. Thus, it would make sense to put those freeable pages in
inactive file LRU to compete other used-once pages. It makes sense for
implmentaion point of view, too because it's not swapbacked memory any
longer until it would be re-dirtied. Even, it could give a bonus to make
them be reclaimed on swapless system. However, MADV_COLD doesn't mean
garbage so reclaiming them requires swap-out/in in the end so it's bigger
cost. Since we have designed VM LRU aging based on cost-model, anonymous
cold pages would be better to position inactive anon's LRU list, not file
LRU. Furthermore, it would help to avoid unnecessary scanning if system
doesn't have a swap device. Let's start simpler way without adding
complexity at this moment.

All of error rule is same with MADV_DONTNEED.

* v1
 * remove page_mapcount filter - hannes, mhocko
 * fix idle page handling - joelaf

* RFCv2
 * add more description - mhocko

* RFCv1
 * renaming from MADV_COOL to MADV_COLD - hannes

* internal review
 * use clear_page_youn in deactivate_page - joelaf
 * Revise the description - surenb
 * Renaming from MADV_WARM to MADV_COOL - surenb

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/swap.h                   |   1 +
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/internal.h                          |   2 +-
 mm/madvise.c                           | 151 ++++++++++++++++++++++++-
 mm/oom_kill.c                          |   2 +-
 mm/swap.c                              |  42 +++++++
 6 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index de2c67a33b7e..0ce997edb8bb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -340,6 +340,7 @@ extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_all(void);
 extern void rotate_reclaimable_page(struct page *page);
 extern void deactivate_file_page(struct page *page);
+extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ef4623f03156..d7b4231eea63 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -47,6 +47,7 @@
 #define MADV_SEQUENTIAL	2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
+#define MADV_COLD	5		/* deactivatie these pages */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_FREE	8		/* free pages only if memory pressure */
diff --git a/mm/internal.h b/mm/internal.h
index e32390802fd3..0d5f720c75ab 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -39,7 +39,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
 
-static inline bool can_madv_dontneed_vma(struct vm_area_struct *vma)
+static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
 	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 628022e674a7..67c0379f64a7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -40,6 +40,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_REMOVE:
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
+	case MADV_COLD:
 	case MADV_FREE:
 		return 0;
 	default:
@@ -307,6 +308,149 @@ static long madvise_willneed(struct vm_area_struct *vma,
 	return 0;
 }
 
+static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
+				unsigned long end, struct mm_walk *walk)
+{
+	struct mmu_gather *tlb = walk->private;
+	struct mm_struct *mm = tlb->mm;
+	struct vm_area_struct *vma = walk->vma;
+	pte_t *orig_pte, *pte, ptent;
+	spinlock_t *ptl;
+	struct page *page;
+	unsigned long next;
+
+	next = pmd_addr_end(addr, end);
+	if (pmd_trans_huge(*pmd)) {
+		pmd_t orig_pmd;
+
+		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
+		ptl = pmd_trans_huge_lock(pmd, vma);
+		if (!ptl)
+			return 0;
+
+		orig_pmd = *pmd;
+		if (is_huge_zero_pmd(orig_pmd))
+			goto huge_unlock;
+
+		if (unlikely(!pmd_present(orig_pmd))) {
+			VM_BUG_ON(thp_migration_supported() &&
+					!is_pmd_migration_entry(orig_pmd));
+			goto huge_unlock;
+		}
+
+		page = pmd_page(orig_pmd);
+		if (next - addr != HPAGE_PMD_SIZE) {
+			int err;
+
+			if (page_mapcount(page) != 1)
+				goto huge_unlock;
+
+			get_page(page);
+			spin_unlock(ptl);
+			lock_page(page);
+			err = split_huge_page(page);
+			unlock_page(page);
+			put_page(page);
+			if (!err)
+				goto regular_page;
+			return 0;
+		}
+
+		if (pmd_young(orig_pmd)) {
+			pmdp_invalidate(vma, addr, pmd);
+			orig_pmd = pmd_mkold(orig_pmd);
+
+			set_pmd_at(mm, addr, pmd, orig_pmd);
+			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+		}
+
+		test_and_clear_page_young(page);
+		deactivate_page(page);
+huge_unlock:
+		spin_unlock(ptl);
+		return 0;
+	}
+
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
+regular_page:
+	tlb_change_page_size(tlb, PAGE_SIZE);
+	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	flush_tlb_batched_pending(mm);
+	arch_enter_lazy_mmu_mode();
+	for (; addr < end; pte++, addr += PAGE_SIZE) {
+		ptent = *pte;
+
+		if (pte_none(ptent))
+			continue;
+
+		if (!pte_present(ptent))
+			continue;
+
+		page = vm_normal_page(vma, addr, ptent);
+		if (!page)
+			continue;
+
+		if (pte_young(ptent)) {
+			ptent = ptep_get_and_clear_full(mm, addr, pte,
+							tlb->fullmm);
+			ptent = pte_mkold(ptent);
+			set_pte_at(mm, addr, pte, ptent);
+			tlb_remove_tlb_entry(tlb, pte, addr);
+		}
+
+		/*
+		 * We are deactivating a page for accelerating reclaiming.
+		 * VM couldn't reclaim the page unless we clear PG_young.
+		 * As a side effect, it makes confuse idle-page tracking
+		 * because they will miss recent referenced history.
+		 */
+		test_and_clear_page_young(page);
+		deactivate_page(page);
+	}
+
+	arch_enter_lazy_mmu_mode();
+	pte_unmap_unlock(orig_pte, ptl);
+	cond_resched();
+
+	return 0;
+}
+
+static void madvise_cold_page_range(struct mmu_gather *tlb,
+			     struct vm_area_struct *vma,
+			     unsigned long addr, unsigned long end)
+{
+	struct mm_walk cold_walk = {
+		.pmd_entry = madvise_cold_pte_range,
+		.mm = vma->vm_mm,
+		.private = tlb,
+	};
+
+	tlb_start_vma(tlb, vma);
+	walk_page_range(addr, end, &cold_walk);
+	tlb_end_vma(tlb, vma);
+}
+
+static long madvise_cold(struct vm_area_struct *vma,
+			struct vm_area_struct **prev,
+			unsigned long start_addr, unsigned long end_addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_gather tlb;
+
+	*prev = vma;
+	if (!can_madv_lru_vma(vma))
+		return -EINVAL;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
+	tlb_finish_mmu(&tlb, start_addr, end_addr);
+
+	return 0;
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
@@ -519,7 +663,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  int behavior)
 {
 	*prev = vma;
-	if (!can_madv_dontneed_vma(vma))
+	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -541,7 +685,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_dontneed_vma(vma))
+		if (!can_madv_lru_vma(vma))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
@@ -695,6 +839,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		return madvise_remove(vma, prev, start, end);
 	case MADV_WILLNEED:
 		return madvise_willneed(vma, prev, start, end);
+	case MADV_COLD:
+		return madvise_cold(vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
@@ -716,6 +862,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
 	case MADV_FREE:
+	case MADV_COLD:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5a58778c91d4..f73d5f5145f0 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -515,7 +515,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
 	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
-		if (!can_madv_dontneed_vma(vma))
+		if (!can_madv_lru_vma(vma))
 			continue;
 
 		/*
diff --git a/mm/swap.c b/mm/swap.c
index 6d153ce4cb8c..7e44f5b50774 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -47,6 +47,7 @@ int page_cluster;
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
 static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
+static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_lazyfree_pvecs);
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct pagevec, activate_page_pvecs);
@@ -538,6 +539,22 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	update_page_reclaim_stat(lruvec, file, 0);
 }
 
+static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
+			    void *arg)
+{
+	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
+		int file = page_is_file_cache(page);
+		int lru = page_lru_base_type(page);
+
+		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
+		ClearPageActive(page);
+		ClearPageReferenced(page);
+		add_page_to_lru_list(page, lruvec, lru);
+
+		__count_vm_events(PGDEACTIVATE, hpage_nr_pages(page));
+		update_page_reclaim_stat(lruvec, file, 0);
+	}
+}
 
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 			    void *arg)
@@ -590,6 +607,10 @@ void lru_add_drain_cpu(int cpu)
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn, NULL);
 
+	pvec = &per_cpu(lru_deactivate_pvecs, cpu);
+	if (pagevec_count(pvec))
+		pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+
 	pvec = &per_cpu(lru_lazyfree_pvecs, cpu);
 	if (pagevec_count(pvec))
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn, NULL);
@@ -623,6 +644,26 @@ void deactivate_file_page(struct page *page)
 	}
 }
 
+/*
+ * deactivate_page - deactivate a page
+ * @page: page to deactivate
+ *
+ * deactivate_page() moves @page to the inactive list if @page was on the active
+ * list and was not an unevictable page.  This is done to accelerate the reclaim
+ * of @page.
+ */
+void deactivate_page(struct page *page)
+{
+	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
+		struct pagevec *pvec = &get_cpu_var(lru_deactivate_pvecs);
+
+		get_page(page);
+		if (!pagevec_add(pvec, page) || PageCompound(page))
+			pagevec_lru_move_fn(pvec, lru_deactivate_fn, NULL);
+		put_cpu_var(lru_deactivate_pvecs);
+	}
+}
+
 /**
  * mark_page_lazyfree - make an anon page lazyfree
  * @page: page to deactivate
@@ -687,6 +728,7 @@ void lru_add_drain_all(void)
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
 		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
+		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_lazyfree_pvecs, cpu)) ||
 		    need_activate_page_drain(cpu)) {
 			INIT_WORK(work, lru_add_drain_per_cpu);
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

