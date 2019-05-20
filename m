Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8F23914
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbfETOAy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 10:00:54 -0400
Received: from relay.sw.ru ([185.231.240.75]:39782 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbfETOAy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 10:00:54 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hSipu-00082u-48; Mon, 20 May 2019 17:00:18 +0300
Subject: [PATCH v2 3/7] mm: Extend copy_page_range()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 20 May 2019 17:00:17 +0300
Message-ID: <155836081774.2441.16449538600904205092.stgit@localhost.localdomain>
In-Reply-To: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This allows to copy pages not only to the same addreses
in another process, but also to a specified address.
Huge pages and unaligned address cases are handled
by splitting.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/huge_mm.h |    6 +-
 include/linux/mm.h      |    3 +
 kernel/fork.c           |    5 +
 mm/huge_memory.c        |   30 ++++++---
 mm/memory.c             |  165 +++++++++++++++++++++++++++++++----------------
 5 files changed, 141 insertions(+), 68 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c150c21d..1e6002ee7c44 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -9,11 +9,13 @@
 
 extern vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 extern int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-			 pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+			 pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long dst_addr,
+			 unsigned long src_addr, unsigned long len,
 			 struct vm_area_struct *vma);
 extern void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd);
 extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-			 pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
+			 pud_t *dst_pud, pud_t *src_pud, unsigned long dst_addr,
+			 unsigned long src_addr, unsigned long len,
 			 struct vm_area_struct *vma);
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
diff --git a/include/linux/mm.h b/include/linux/mm.h
index afe07e4a76f8..54328d08dbdd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1485,7 +1485,8 @@ int walk_page_vma(struct vm_area_struct *vma, struct mm_walk *walk);
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
-			struct vm_area_struct *vma);
+			struct vm_area_struct *vma, unsigned long dst_addr,
+			unsigned long src_addr, unsigned long src_end);
 int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   struct mmu_notifier_range *range,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
diff --git a/kernel/fork.c b/kernel/fork.c
index 45fde571c5dd..35f7240ed5c9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -584,7 +584,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(mm, oldmm, mpnt);
+			retval = copy_page_range(mm, oldmm, mpnt,
+						 mpnt->vm_start,
+						 mpnt->vm_start,
+						 mpnt->vm_end);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9a6b32..f338b06f42c6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -956,7 +956,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 }
 
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long dst_addr,
+		  unsigned long src_addr, unsigned long len,
 		  struct vm_area_struct *vma)
 {
 	spinlock_t *dst_ptl, *src_ptl;
@@ -969,6 +970,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (!vma_is_anonymous(vma))
 		return 0;
 
+	if (len != HPAGE_PMD_SIZE) {
+		split_huge_pmd(vma, src_pmd, src_addr);
+		return -EAGAIN;
+	}
+
 	pgtable = pte_alloc_one(dst_mm);
 	if (unlikely(!pgtable))
 		goto out;
@@ -990,12 +996,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			pmd = swp_entry_to_pmd(entry);
 			if (pmd_swp_soft_dirty(*src_pmd))
 				pmd = pmd_swp_mksoft_dirty(pmd);
-			set_pmd_at(src_mm, addr, src_pmd, pmd);
+			set_pmd_at(src_mm, src_addr, src_pmd, pmd);
 		}
 		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(dst_mm);
 		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+		set_pmd_at(dst_mm, dst_addr, dst_pmd, pmd);
 		ret = 0;
 		goto out_unlock;
 	}
@@ -1018,7 +1024,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * reference.
 		 */
 		zero_page = mm_get_huge_zero_page(dst_mm);
-		set_huge_zero_page(pgtable, dst_mm, vma, addr, dst_pmd,
+		set_huge_zero_page(pgtable, dst_mm, vma, dst_addr, dst_pmd,
 				zero_page);
 		ret = 0;
 		goto out_unlock;
@@ -1032,9 +1038,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	mm_inc_nr_ptes(dst_mm);
 	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
 
-	pmdp_set_wrprotect(src_mm, addr, src_pmd);
+	pmdp_set_wrprotect(src_mm, src_addr, src_pmd);
 	pmd = pmd_mkold(pmd_wrprotect(pmd));
-	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+	set_pmd_at(dst_mm, dst_addr, dst_pmd, pmd);
 
 	ret = 0;
 out_unlock:
@@ -1096,13 +1102,19 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 }
 
 int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
+		  pud_t *dst_pud, pud_t *src_pud, unsigned long dst_addr,
+		  unsigned long src_addr, unsigned long len,
 		  struct vm_area_struct *vma)
 {
 	spinlock_t *dst_ptl, *src_ptl;
 	pud_t pud;
 	int ret;
 
+	if (len != HPAGE_PUD_SIZE) {
+		split_huge_pud(vma, src_pud, src_addr);
+		return -EAGAIN;
+	}
+
 	dst_ptl = pud_lock(dst_mm, dst_pud);
 	src_ptl = pud_lockptr(src_mm, src_pud);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -1121,9 +1133,9 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		/* No huge zero pud yet */
 	}
 
-	pudp_set_wrprotect(src_mm, addr, src_pud);
+	pudp_set_wrprotect(src_mm, src_addr, src_pud);
 	pud = pud_mkold(pud_wrprotect(pud));
-	set_pud_at(dst_mm, addr, dst_pud, pud);
+	set_pud_at(dst_mm, dst_addr, dst_pud, pud);
 
 	ret = 0;
 out_unlock:
diff --git a/mm/memory.c b/mm/memory.c
index 0d0711a912de..9d0fe2aee5f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -699,7 +699,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 static inline unsigned long
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+		unsigned long src_addr, int *rss, unsigned long dst_addr)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -737,7 +737,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(*src_pte))
 					pte = pte_swp_mksoft_dirty(pte);
-				set_pte_at(src_mm, addr, src_pte, pte);
+				set_pte_at(src_mm, src_addr, src_pte, pte);
 			}
 		} else if (is_device_private_entry(entry)) {
 			page = device_private_entry_to_page(entry);
@@ -766,7 +766,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			    is_cow_mapping(vm_flags)) {
 				make_device_private_entry_read(&entry);
 				pte = swp_entry_to_pte(entry);
-				set_pte_at(src_mm, addr, src_pte, pte);
+				set_pte_at(src_mm, src_addr, src_pte, pte);
 			}
 		}
 		goto out_set_pte;
@@ -777,7 +777,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
+		ptep_set_wrprotect(src_mm, src_addr, src_pte);
 		pte = pte_wrprotect(pte);
 	}
 
@@ -789,7 +789,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
-	page = vm_normal_page(vma, addr, pte);
+	page = vm_normal_page(vma, src_addr, pte);
 	if (page) {
 		get_page(page);
 		page_dup_rmap(page, false);
@@ -810,13 +810,14 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 out_set_pte:
-	set_pte_at(dst_mm, addr, dst_pte, pte);
+	set_pte_at(dst_mm, dst_addr, dst_pte, pte);
 	return 0;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
-		   unsigned long addr, unsigned long end)
+		   unsigned long src_addr, unsigned long src_end,
+		   unsigned long dst_addr)
 {
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
@@ -828,10 +829,10 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 again:
 	init_rss_vec(rss);
 
-	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
+	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, dst_addr, &dst_ptl);
 	if (!dst_pte)
 		return -ENOMEM;
-	src_pte = pte_offset_map(src_pmd, addr);
+	src_pte = pte_offset_map(src_pmd, src_addr);
 	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 	orig_src_pte = src_pte;
@@ -854,11 +855,12 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			continue;
 		}
 		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-							vma, addr, rss);
+					 vma, src_addr, rss, dst_addr);
 		if (entry.val)
 			break;
 		progress += 8;
-	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
+	} while (dst_pte++, src_pte++, dst_addr += PAGE_SIZE,
+		 src_addr += PAGE_SIZE, src_addr != src_end);
 
 	arch_leave_lazy_mmu_mode();
 	spin_unlock(src_ptl);
@@ -872,108 +874,147 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			return -ENOMEM;
 		progress = 0;
 	}
-	if (addr != end)
+	if (src_addr != src_end)
 		goto again;
 	return 0;
 }
 
 static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pud_t *dst_pud, pud_t *src_pud, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long src_addr, unsigned long src_end, unsigned long dst_addr)
 {
+	unsigned long src_next, dst_next, src_len, dst_len, dst_end, len;
 	pmd_t *src_pmd, *dst_pmd;
-	unsigned long next;
 
-	dst_pmd = pmd_alloc(dst_mm, dst_pud, addr);
+	dst_pmd = pmd_alloc(dst_mm, dst_pud, dst_addr);
 	if (!dst_pmd)
 		return -ENOMEM;
-	src_pmd = pmd_offset(src_pud, addr);
+	src_pmd = pmd_offset(src_pud, src_addr);
+	dst_end = dst_addr + (src_end - src_addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		src_next = pmd_addr_end(src_addr, src_end);
+		dst_next = pmd_addr_end(dst_addr, dst_end);
+		src_len = src_next - src_addr;
+		dst_len = dst_next - dst_addr;
+
+		len = min(src_len, dst_len);
+		src_next = src_addr + len;
+		dst_next = dst_addr + len;
 		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
 			|| pmd_devmap(*src_pmd)) {
 			int err;
-			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, vma);
-			err = copy_huge_pmd(dst_mm, src_mm,
-					    dst_pmd, src_pmd, addr, vma);
+			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
+					    dst_addr, src_addr, len, vma);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
-				continue;
+				goto next;
 			/* fall through */
 		}
 		if (pmd_none_or_clear_bad(src_pmd))
-			continue;
+			goto next;
 		if (copy_pte_range(dst_mm, src_mm, dst_pmd, src_pmd,
-						vma, addr, next))
+				   vma, src_addr, src_next, dst_addr))
 			return -ENOMEM;
-	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
+next:
+		if (src_len == len)
+			src_pmd++;
+		if (dst_len == len)
+			dst_pmd++;
+	} while (src_addr = src_next, dst_addr = dst_next, src_addr != src_end);
 	return 0;
 }
 
 static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		p4d_t *dst_p4d, p4d_t *src_p4d, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long src_addr, unsigned long src_end, unsigned long dst_addr)
 {
+	unsigned long src_next, dst_next, src_len, dst_len, dst_end, len;
 	pud_t *src_pud, *dst_pud;
-	unsigned long next;
 
-	dst_pud = pud_alloc(dst_mm, dst_p4d, addr);
+	dst_pud = pud_alloc(dst_mm, dst_p4d, dst_addr);
 	if (!dst_pud)
 		return -ENOMEM;
-	src_pud = pud_offset(src_p4d, addr);
+	src_pud = pud_offset(src_p4d, src_addr);
+	dst_end = dst_addr + (src_end - src_addr);
 	do {
-		next = pud_addr_end(addr, end);
+		src_next = pud_addr_end(src_addr, src_end);
+		dst_next = pud_addr_end(dst_addr, dst_end);
+		src_len = src_next - src_addr;
+		dst_len = dst_next - dst_addr;
+
+		len = min(src_len, dst_len);
+		src_next = src_addr + len;
+		dst_next = dst_addr + len;
+
 		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
 			int err;
 
-			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, vma);
-			err = copy_huge_pud(dst_mm, src_mm,
-					    dst_pud, src_pud, addr, vma);
+			err = copy_huge_pud(dst_mm, src_mm, dst_pud, src_pud,
+					    dst_addr, src_addr, len, vma);
 			if (err == -ENOMEM)
 				return -ENOMEM;
 			if (!err)
-				continue;
+				goto next;
 			/* fall through */
 		}
 		if (pud_none_or_clear_bad(src_pud))
-			continue;
+			goto next;
 		if (copy_pmd_range(dst_mm, src_mm, dst_pud, src_pud,
-						vma, addr, next))
+				   vma, src_addr, src_next, dst_addr))
 			return -ENOMEM;
-	} while (dst_pud++, src_pud++, addr = next, addr != end);
+next:
+		if (src_len == len)
+			src_pud++;
+		if (dst_len == len)
+			dst_pud++;
+	} while (src_addr = src_next, dst_addr = dst_next, src_addr != src_end);
 	return 0;
 }
 
 static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pgd_t *dst_pgd, pgd_t *src_pgd, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end)
+		unsigned long src_addr, unsigned long src_end, unsigned long dst_addr)
 {
+	unsigned long src_next, dst_next, src_len, dst_len, dst_end, len;
 	p4d_t *src_p4d, *dst_p4d;
-	unsigned long next;
 
-	dst_p4d = p4d_alloc(dst_mm, dst_pgd, addr);
+	dst_p4d = p4d_alloc(dst_mm, dst_pgd, dst_addr);
 	if (!dst_p4d)
 		return -ENOMEM;
-	src_p4d = p4d_offset(src_pgd, addr);
+
+	src_p4d = p4d_offset(src_pgd, src_addr);
+	dst_end = dst_addr + (src_end - src_addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		src_next = p4d_addr_end(src_addr, src_end);
+		dst_next = p4d_addr_end(dst_addr, dst_end);
+		src_len = src_next - src_addr;
+		dst_len = dst_next - dst_addr;
+
+		len = min(src_len, dst_len);
+		src_next = src_addr + len;
+		dst_next = dst_addr + len;
+
 		if (p4d_none_or_clear_bad(src_p4d))
-			continue;
+			goto next;
 		if (copy_pud_range(dst_mm, src_mm, dst_p4d, src_p4d,
-						vma, addr, next))
+				   vma, src_addr, src_next, dst_addr))
 			return -ENOMEM;
-	} while (dst_p4d++, src_p4d++, addr = next, addr != end);
+next:
+		if (src_len == len)
+			src_p4d++;
+		if (dst_len == len)
+			dst_p4d++;
+	} while (src_addr = src_next, dst_addr = dst_next, src_addr != src_end);
 	return 0;
 }
 
 int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long dst_addr,
+		unsigned long src_addr, unsigned long src_end)
 {
 	pgd_t *src_pgd, *dst_pgd;
-	unsigned long next;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
+	unsigned long src_next, dst_next, src_len, dst_len, dst_end, len;
 	struct mmu_notifier_range range;
 	bool is_cow;
 	int ret;
@@ -1011,23 +1052,37 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	if (is_cow) {
 		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
-					0, vma, src_mm, addr, end);
+					0, vma, src_mm, src_addr, src_end);
 		mmu_notifier_invalidate_range_start(&range);
 	}
 
 	ret = 0;
-	dst_pgd = pgd_offset(dst_mm, addr);
-	src_pgd = pgd_offset(src_mm, addr);
+	dst_pgd = pgd_offset(dst_mm, dst_addr);
+	src_pgd = pgd_offset(src_mm, src_addr);
+	dst_end = dst_addr + (src_end - src_addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		src_next = pgd_addr_end(src_addr, src_end);
+		dst_next = pgd_addr_end(dst_addr, dst_end);
+		src_len = src_next - src_addr;
+		dst_len = dst_next - dst_addr;
+
+		len = min(src_len, dst_len);
+		src_next = src_addr + len;
+		dst_next = dst_addr + len;
+
 		if (pgd_none_or_clear_bad(src_pgd))
-			continue;
+			goto next;
 		if (unlikely(copy_p4d_range(dst_mm, src_mm, dst_pgd, src_pgd,
-					    vma, addr, next))) {
+					vma, src_addr, src_next, dst_addr))) {
 			ret = -ENOMEM;
 			break;
 		}
-	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+next:
+		if (src_len == len)
+			src_pgd++;
+		if (dst_len == len)
+			dst_pgd++;
+	} while (src_addr = src_next, dst_addr = dst_next, src_addr != src_end);
 
 	if (is_cow)
 		mmu_notifier_invalidate_range_end(&range);

