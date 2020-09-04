Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6023425D7A0
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgIDLle (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 07:41:34 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49528 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728263AbgIDLlU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 07:41:20 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 07:41:18 EDT
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id CD72B30747C8;
        Fri,  4 Sep 2020 14:31:06 +0300 (EEST)
Received: from localhost.localdomain (unknown [195.189.155.252])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id 041833072787;
        Fri,  4 Sep 2020 14:31:05 +0300 (EEST)
From:   =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To:     linux-mm@kvack.org
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RESEND RFC PATCH 2/5] mm: let the VMA decide how zap_pte_range() acts on mapped pages
Date:   Fri,  4 Sep 2020 14:31:13 +0300
Message-Id: <20200904113116.20648-3-alazar@bitdefender.com>
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mircea Cirjaliu <mcirjaliu@bitdefender.com>

Instead of having one big function to handle all cases of page unmapping,
have multiple implementation-defined callbacks, each for its own VMA type.
In the future, exotic VMA implementations won't have to bloat the unique
zapping function with another case of mappings.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/linux/mm.h |  16 ++++
 mm/memory.c        | 182 +++++++++++++++++++++++++--------------------
 2 files changed, 116 insertions(+), 82 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1be4482a7b81..39e55467aa49 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@ struct file_ra_state;
 struct user_struct;
 struct writeback_control;
 struct bdi_writeback;
+struct zap_details;
 
 void init_mm_internals(void);
 
@@ -601,6 +602,14 @@ struct vm_operations_struct {
 	 */
 	struct page *(*find_special_page)(struct vm_area_struct *vma,
 					  unsigned long addr);
+
+	/*
+	 * Called by zap_pte_range() for use by special VMAs that implement
+	 * custom zapping behavior.
+	 */
+	int (*zap_pte)(struct vm_area_struct *vma, unsigned long addr,
+		       pte_t *pte, int rss[], struct mmu_gather *tlb,
+		       struct zap_details *details);
 };
 
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
@@ -1594,6 +1603,13 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct user_struct *);
 extern void user_shm_unlock(size_t, struct user_struct *);
 
+/*
+ * Flags returned by zap_pte implementations
+ */
+#define ZAP_PTE_CONTINUE	0
+#define ZAP_PTE_FLUSH		(1 << 0)	/* Ask for TLB flush. */
+#define ZAP_PTE_BREAK		(1 << 1)	/* Break PTE iteration. */
+
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
diff --git a/mm/memory.c b/mm/memory.c
index 8e78fb151f8f..a225bfd01417 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1031,18 +1031,109 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	return ret;
 }
 
+static int zap_pte_common(struct vm_area_struct *vma, unsigned long addr,
+			  pte_t *pte, int rss[], struct mmu_gather *tlb,
+			  struct zap_details *details)
+{
+	struct mm_struct *mm = tlb->mm;
+	pte_t ptent = *pte;
+	swp_entry_t entry;
+	int flags = 0;
+
+	if (pte_present(ptent)) {
+		struct page *page;
+
+		page = vm_normal_page(vma, addr, ptent);
+		if (unlikely(details) && page) {
+			/*
+			 * unmap_shared_mapping_pages() wants to
+			 * invalidate cache without truncating:
+			 * unmap shared but keep private pages.
+			 */
+			if (details->check_mapping &&
+			    details->check_mapping != page_rmapping(page))
+				return 0;
+		}
+		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		tlb_remove_tlb_entry(tlb, pte, addr);
+		if (unlikely(!page))
+			return 0;
+
+		if (!PageAnon(page)) {
+			if (pte_dirty(ptent)) {
+				flags |= ZAP_PTE_FLUSH;
+				set_page_dirty(page);
+			}
+			if (pte_young(ptent) &&
+			    likely(!(vma->vm_flags & VM_SEQ_READ)))
+				mark_page_accessed(page);
+		}
+		rss[mm_counter(page)]--;
+		page_remove_rmap(page, false);
+		if (unlikely(page_mapcount(page) < 0))
+			print_bad_pte(vma, addr, ptent, page);
+		if (unlikely(__tlb_remove_page(tlb, page)))
+			flags |= ZAP_PTE_FLUSH | ZAP_PTE_BREAK;
+		return flags;
+	}
+
+	entry = pte_to_swp_entry(ptent);
+	if (non_swap_entry(entry) && is_device_private_entry(entry)) {
+		struct page *page = device_private_entry_to_page(entry);
+
+		if (unlikely(details && details->check_mapping)) {
+			/*
+			 * unmap_shared_mapping_pages() wants to
+			 * invalidate cache without truncating:
+			 * unmap shared but keep private pages.
+			 */
+			if (details->check_mapping != page_rmapping(page))
+				return 0;
+		}
+
+		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		rss[mm_counter(page)]--;
+		page_remove_rmap(page, false);
+		put_page(page);
+		return 0;
+	}
+
+	/* If details->check_mapping, we leave swap entries. */
+	if (unlikely(details))
+		return 0;
+
+	if (!non_swap_entry(entry))
+		rss[MM_SWAPENTS]--;
+	else if (is_migration_entry(entry)) {
+		struct page *page;
+
+		page = migration_entry_to_page(entry);
+		rss[mm_counter(page)]--;
+	}
+	if (unlikely(!free_swap_and_cache(entry)))
+		print_bad_pte(vma, addr, ptent, NULL);
+	pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+
+	return flags;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
 	struct mm_struct *mm = tlb->mm;
-	int force_flush = 0;
+	int flags = 0;
 	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
-	swp_entry_t entry;
+
+	int (*zap_pte)(struct vm_area_struct *vma, unsigned long addr,
+		       pte_t *pte, int rss[], struct mmu_gather *tlb,
+		       struct zap_details *details) = zap_pte_common;
+	if (vma->vm_ops && vma->vm_ops->zap_pte)
+		zap_pte = vma->vm_ops->zap_pte;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1058,92 +1149,19 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 		if (!zap_is_atomic(details) && need_resched())
 			break;
-
-		if (pte_present(ptent)) {
-			struct page *page;
-
-			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(details) && page) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping &&
-				    details->check_mapping != page_rmapping(page))
-					continue;
-			}
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-			if (unlikely(!page))
-				continue;
-
-			if (!PageAnon(page)) {
-				if (pte_dirty(ptent)) {
-					force_flush = 1;
-					set_page_dirty(page);
-				}
-				if (pte_young(ptent) &&
-				    likely(!(vma->vm_flags & VM_SEQ_READ)))
-					mark_page_accessed(page);
-			}
-			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
-			if (unlikely(page_mapcount(page) < 0))
-				print_bad_pte(vma, addr, ptent, page);
-			if (unlikely(__tlb_remove_page(tlb, page))) {
-				force_flush = 1;
-				addr += PAGE_SIZE;
-				break;
-			}
-			continue;
-		}
-
-		entry = pte_to_swp_entry(ptent);
-		if (non_swap_entry(entry) && is_device_private_entry(entry)) {
-			struct page *page = device_private_entry_to_page(entry);
-
-			if (unlikely(details && details->check_mapping)) {
-				/*
-				 * unmap_shared_mapping_pages() wants to
-				 * invalidate cache without truncating:
-				 * unmap shared but keep private pages.
-				 */
-				if (details->check_mapping !=
-				    page_rmapping(page))
-					continue;
-			}
-
-			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
-			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
-			put_page(page);
-			continue;
+		if (flags & ZAP_PTE_BREAK) {
+			flags &= ~ZAP_PTE_BREAK;
+			break;
 		}
 
-		/* If details->check_mapping, we leave swap entries. */
-		if (unlikely(details))
-			continue;
-
-		if (!non_swap_entry(entry))
-			rss[MM_SWAPENTS]--;
-		else if (is_migration_entry(entry)) {
-			struct page *page;
-
-			page = migration_entry_to_page(entry);
-			rss[mm_counter(page)]--;
-		}
-		if (unlikely(!free_swap_and_cache(entry)))
-			print_bad_pte(vma, addr, ptent, NULL);
-		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		flags |= zap_pte(vma, addr, pte, rss, tlb, details);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush)
+	if (flags & ZAP_PTE_FLUSH)
 		tlb_flush_mmu_tlbonly(tlb);
 	pte_unmap_unlock(start_pte, ptl);
 
@@ -1153,8 +1171,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 * entries before releasing the ptl), free the batched
 	 * memory too. Restart if we didn't do everything.
 	 */
-	if (force_flush) {
-		force_flush = 0;
+	if (flags & ZAP_PTE_FLUSH) {
+		flags &= ~ZAP_PTE_FLUSH;
 		tlb_flush_mmu(tlb);
 	}
 
