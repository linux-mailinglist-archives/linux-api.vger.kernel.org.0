Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658835B0754
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiIGOpy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIGOpm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9296157558
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:40 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a6-20020a17090abe0600b00200303ba903so6951117pjs.2
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=l4DpUA5zTvH8JuhS3o8ErHHoRmdAY/EBnbYJ4/jdWhE=;
        b=tAVgIySvZbPZIhr/aoR0edFP9UHv/WwkbPkuED2luWIIYQ6MSSqnIM3ys679bP8PyU
         y5kKliW1x0/czb6UnSeTw8QQDPUBMUKmhn/vtql2n1KDbrSbA6BX4e8mRYGhHoxn4l8a
         zvmox2f4hykrwZjkiUM77RQ4AhpUW5WHDSC2QWuLiFglc9T+50lcBUH/yCpNb1Ql6rA5
         uB6xTuLPgijQ2tWJsYvagXO+IU4MDUke8KOYf89GS+ahwJSgz6xU3kTp1gjSkgbMdV/q
         5YV5nf4qMtXBgQechDQdT9HnEwUjIEhj3IDf35K5eJNcYyPMtRmohlYpqTOSyeSAUjpz
         7Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=l4DpUA5zTvH8JuhS3o8ErHHoRmdAY/EBnbYJ4/jdWhE=;
        b=CRvwanv3U2XSjI8j5eeSyUPilobqv3hh64EC7gFFnudi4EYHn294EehLdKXxQJB/Xh
         P9iFao9YW72n37ZGW7omNfRRTp3iy8yCyjOGv2wewenSG3kj3FRSLmJmh5Twbq53bzfb
         jkHOn7KsnTUJEFAQ2epVNUfd9hm/4Iu2j66H1ZUu5yrPLhwgi0NpC12abYah4oWPnq+S
         IW2fwpWGsiVOi5KNuRDiYuhGyCPlHolk+yg3oECdKjROKh/17sR45u0KdYRGw17XsWxq
         mqIzZP2CmXd5ZV03uBQcP4qCdWS86OX5eJk0Qw+rwJp7dVSrNHereVT5/WF5jcNfG4xU
         Ix1w==
X-Gm-Message-State: ACgBeo1jdxCyBRScyxjzqXfwYTeFJ/mZxTcr51d1DOjVNQOpY2FTqOGs
        HPTqPTlq9sR3jnu51RNIIbQ+2ibhjs8K
X-Google-Smtp-Source: AA6agR64U68199UM8wf505T0CYqGzuUeLc8jJ6+XrJfod4lM0Q2h6lIHhK99A6uQL/mscv6/8f2IzMuiDGCn
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:903:24e:b0:172:6d84:301b with SMTP id
 j14-20020a170903024e00b001726d84301bmr4106062plh.6.1662561940024; Wed, 07 Sep
 2022 07:45:40 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:14 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-4-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 03/10] mm/madvise: add file and shmem support
 to MADV_COLLAPSE
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add support for MADV_COLLAPSE to collapse shmem-backed and file-backed
memory into THPs (requires CONFIG_READ_ONLY_THP_FOR_FS=y).

On success, the backing memory will be a hugepage.  For the memory range
and process provided, the page tables will synchronously have a huge pmd
installed, mapping the THP.  Other mappings of the file extent mapped by
the memory range may be added to a set of entries that khugepaged will
later process and attempt update their page tables to map the THP by a pmd.

This functionality unlocks two important uses:

(1)	Immediately back executable text by THPs.  Current support provided
	by CONFIG_READ_ONLY_THP_FOR_FS may take a long time on a large
	system which might impair services from serving at their full rated
	load after (re)starting.  Tricks like mremap(2)'ing text onto
	anonymous memory to immediately realize iTLB performance prevents
	page sharing and demand paging, both of which increase steady state
	memory footprint.  Now, we can have the best of both worlds: Peak
	upfront performance and lower RAM footprints.

(2)	userfaultfd-based live migration of virtual machines satisfy UFFD
	faults by fetching native-sized pages over the network (to avoid
	latency of transferring an entire hugepage).  However, after guest
	memory has been fully copied to the new host, MADV_COLLAPSE can
	be used to immediately increase guest performance.

Since khugepaged is single threaded, this change now introduces
possibility of collapse contexts racing in file collapse path.  There a
important few places to consider:

(1)	hpage_collapse_scan_file(), when we xas_pause() and drop RCU.
	We could have the memory collapsed out from under us, but
	the next xas_for_each() iteration will correctly pick up the
	hugepage.  The hugepage might not be up to date (insofar as
	copying of small page contents might not have completed - the
	page still may be locked), but regardless what small page index
	we were iterating over, we'll find the hugepage and identify it
	as a suitably aligned compound page of order HPAGE_PMD_ORDER.

	In khugepaged path, we locklessly check the value of the pmd,
	and only add it to deferred collapse array if we find pmd
	mapping pte table. This is fine, since other values that could
	have raced in right afterwards denote failure, or that the
	memory was successfully collapsed, so we don't need further
	processing.

	In madvise path, we'll take mmap_lock() in write to serialize
	against page table updates and will know what to do based on the
	true value of the pmd: recheck all ptes if we point to a pte table,
	directly install the pmd, if the pmd has been cleared, but
	memory not yet faulted, or nothing at all if we find a huge pmd.

	It's worth putting emphasis here on how we treat the none pmd
	here.  If khugepaged has processed this mm's page tables
	already, it will have left the pmd cleared (ready for refault by
	the process).  Depending on the VMA flags and sysfs settings,
	amount of RAM on the machine, and the current load, could be a
	relatively common occurrence - and as such is one we'd like to
	handle successfully in MADV_COLLAPSE.  When we see the none pmd
	in collapse_pte_mapped_thp(), we've locked mmap_lock in write
	and checked (a) huepaged_vma_check() to see if the backing
	memory is appropriate still, along with VMA sizing and
	appropriate hugepage alignment within the file, and (b) we've
	found a hugepage head of order HPAGE_PMD_ORDER at the offset
	in the file mapped by our hugepage-aligned virtual address.
	Even though the common-case is likely race with khugepaged,
	given these checks (regardless how we got here - we could be
	operating on a completely different file than originally checked
	in hpage_collapse_scan_file() for all we know) it should be safe
	to directly make the pmd a huge pmd pointing to this hugepage.

(2)	collapse_file() is mostly serialized on the same file extent by
	lock sequence:

		|	lock hupepage
		|		lock mapping->i_pages
		|			lock 1st page
		|		unlock mapping->i_pages
		|				<page checks>
		|		lock mapping->i_pages
		|				page_ref_freeze(3)
		|				xas_store(hugepage)
		|		unlock mapping->i_pages
		|				page_ref_unfreeze(1)
		|			unlock 1st page
		V	unlock hugepage

	Once a context (who already has their fresh hugepage locked)
	locks mapping->i_pages exclusively, it will hold said lock
	until it locks the first page, and it will hold that lock until
	the after the hugepage has been added to the page cache (and
	will unlock the hugepage after page table update, though that
	isn't important here).

	A racing context that loses the race for mapping->i_pages will
	then lose the race to locking the first page.  Here - depending
	on how far the other racing context has gotten - we might find
	the new hugepage (in which case we'll exit cleanly when we
	check PageTransCompound()), or we'll find the "old" 1st small
	page (in which we'll exit cleanly when we discover unexpected
	refcount of 2 after isolate_lru_page()).  This is assuming we
	are able to successfully lock the page we find - in shmem path,
	we could just fail the trylock and exit cleanly anyways.

	Failure path in collapse_file() is similar: once we hold lock
	on 1st small page, we are serialized against other collapse
	contexts.  Before the 1st small page is unlocked, we add it
	back to the pagecache and unfreeze the refcount appropriately.
	Contexts who lost the race to the 1st small page will then find
	the same 1st small page with the correct refcount and will be
	able to proceed.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 include/linux/khugepaged.h         |  13 +-
 include/trace/events/huge_memory.h |   1 +
 kernel/events/uprobes.c            |   2 +-
 mm/khugepaged.c                    | 238 ++++++++++++++++++++++-------
 4 files changed, 194 insertions(+), 60 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 384f034ae947..70162d707caf 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -16,11 +16,13 @@ extern void khugepaged_enter_vma(struct vm_area_struct *vma,
 				 unsigned long vm_flags);
 extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
-extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
+extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
+				   bool install_pmd);
 #else
-static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
-					   unsigned long addr)
+static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
+					  unsigned long addr, bool install_pmd)
 {
+	return 0;
 }
 #endif
 
@@ -46,9 +48,10 @@ static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
 					unsigned long vm_flags)
 {
 }
-static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
-					   unsigned long addr)
+static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
+					  unsigned long addr, bool install_pmd)
 {
+	return 0;
 }
 
 static inline void khugepaged_min_free_kbytes_update(void)
diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index fbbb25494d60..df33453b70fc 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -11,6 +11,7 @@
 	EM( SCAN_FAIL,			"failed")			\
 	EM( SCAN_SUCCEED,		"succeeded")			\
 	EM( SCAN_PMD_NULL,		"pmd_null")			\
+	EM( SCAN_PMD_NONE,		"pmd_none")			\
 	EM( SCAN_PMD_MAPPED,		"page_pmd_mapped")		\
 	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
 	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e0a9b945e7bc..d9e357b7e17c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -555,7 +555,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	/* try collapse pmd for compound page */
 	if (!ret && orig_page_huge)
-		collapse_pte_mapped_thp(mm, vaddr);
+		collapse_pte_mapped_thp(mm, vaddr, false);
 
 	return ret;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 31ccf49cf279..66457a06b4e7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -29,6 +29,7 @@ enum scan_result {
 	SCAN_FAIL,
 	SCAN_SUCCEED,
 	SCAN_PMD_NULL,
+	SCAN_PMD_NONE,
 	SCAN_PMD_MAPPED,
 	SCAN_EXCEED_NONE_PTE,
 	SCAN_EXCEED_SWAP_PTE,
@@ -838,6 +839,18 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false,
 				cc->is_khugepaged))
 		return SCAN_VMA_CHECK;
+	return SCAN_SUCCEED;
+}
+
+static int hugepage_vma_revalidate_anon(struct mm_struct *mm,
+					unsigned long address,
+					struct vm_area_struct **vmap,
+					struct collapse_control *cc)
+{
+	int ret = hugepage_vma_revalidate(mm, address, vmap, cc);
+
+	if (ret != SCAN_SUCCEED)
+		return ret;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
 	 * remapped to file after khugepaged reaquired the mmap_lock.
@@ -845,8 +858,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	 * hugepage_vma_check may return true for qualified file
 	 * vmas.
 	 */
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
-		return SCAN_VMA_CHECK;
+	if (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap))
+		return SCAN_PAGE_ANON;
 	return SCAN_SUCCEED;
 }
 
@@ -866,8 +879,8 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 	/* See comments in pmd_none_or_trans_huge_or_clear_bad() */
 	barrier();
 #endif
-	if (!pmd_present(pmde))
-		return SCAN_PMD_NULL;
+	if (pmd_none(pmde))
+		return SCAN_PMD_NONE;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
 	if (pmd_bad(pmde))
@@ -995,7 +1008,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		goto out_nolock;
 
 	mmap_read_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, &vma, cc);
+	result = hugepage_vma_revalidate_anon(mm, address, &vma, cc);
 	if (result != SCAN_SUCCEED) {
 		mmap_read_unlock(mm);
 		goto out_nolock;
@@ -1026,7 +1039,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * handled by the anon_vma lock + PG_lock.
 	 */
 	mmap_write_lock(mm);
-	result = hugepage_vma_revalidate(mm, address, &vma, cc);
+	result = hugepage_vma_revalidate_anon(mm, address, &vma, cc);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
@@ -1332,13 +1345,44 @@ static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 	slot = mm_slot_lookup(mm_slots_hash, mm);
 	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
 	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP)) {
+		int i;
+		/*
+		 * Multiple callers may be adding entries here.  Do a quick
+		 * check to see the entry hasn't already been added by someone
+		 * else.
+		 */
+		for (i = 0; i < mm_slot->nr_pte_mapped_thp; ++i)
+			if (mm_slot->pte_mapped_thp[i] == addr)
+				goto out;
 		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
 		ret = true;
 	}
+out:
 	spin_unlock(&khugepaged_mm_lock);
 	return ret;
 }
 
+/* hpage must be locked, and mmap_lock must be held in write */
+static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
+			pmd_t *pmdp, struct page *hpage)
+{
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = addr,
+		.flags = 0,
+		.pmd = pmdp,
+	};
+
+	VM_BUG_ON(!PageTransHuge(hpage));
+	mmap_assert_write_locked(vma->vm_mm);
+
+	if (do_set_pmd(&vmf, hpage))
+		return SCAN_FAIL;
+
+	get_page(hpage);
+	return SCAN_SUCCEED;
+}
+
 static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t *pmdp)
 {
@@ -1360,12 +1404,14 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
  *
  * @mm: process address space where collapse happens
  * @addr: THP collapse address
+ * @install_pmd: If a huge PMD should be installed
  *
  * This function checks whether all the PTEs in the PMD are pointing to the
  * right THP. If so, retract the page table so the THP can refault in with
- * as pmd-mapped.
+ * as pmd-mapped. Possibly install a huge PMD mapping the THP.
  */
-void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
+int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
+			    bool install_pmd)
 {
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
 	struct vm_area_struct *vma = vma_lookup(mm, haddr);
@@ -1380,12 +1426,12 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 
 	/* Fast check before locking page if already PMD-mapped  */
 	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
-	if (result != SCAN_SUCCEED)
-		return;
+	if (result == SCAN_PMD_MAPPED)
+		return result;
 
 	if (!vma || !vma->vm_file ||
 	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
-		return;
+		return SCAN_VMA_CHECK;
 
 	/*
 	 * If we are here, we've succeeded in replacing all the native pages
@@ -1395,24 +1441,39 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	 * analogously elide sysfs THP settings here.
 	 */
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
-		return;
+		return SCAN_VMA_CHECK;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
 	if (userfaultfd_wp(vma))
-		return;
+		return SCAN_PTE_UFFD_WP;
 
 	hpage = find_lock_page(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
 	if (!hpage)
-		return;
+		return SCAN_PAGE_NULL;
 
-	if (!PageHead(hpage))
+	if (!PageHead(hpage)) {
+		result = SCAN_FAIL;
 		goto drop_hpage;
+	}
 
-	if (find_pmd_or_thp_or_none(mm, haddr, &pmd) != SCAN_SUCCEED)
+	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
+	switch (result) {
+	case SCAN_SUCCEED:
+		break;
+	case SCAN_PMD_NONE:
+		/*
+		 * In MADV_COLLAPSE path, possible race with khugepaged where
+		 * all pte entries have been removed and pmd cleared.  If so,
+		 * skip all the pte checks and just update the pmd mapping.
+		 */
+		goto maybe_install_pmd;
+	default:
 		goto drop_hpage;
+	}
 
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
+	result = SCAN_FAIL;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
 	for (i = 0, addr = haddr, pte = start_pte;
@@ -1424,8 +1485,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 			continue;
 
 		/* page swapped out, abort */
-		if (!pte_present(*pte))
+		if (!pte_present(*pte)) {
+			result = SCAN_PTE_NON_PRESENT;
 			goto abort;
+		}
 
 		page = vm_normal_page(vma, addr, *pte);
 		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
@@ -1460,12 +1523,19 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
 	}
 
-	/* step 4: collapse pmd */
+	/* step 4: remove pte entries */
 	collapse_and_free_pmd(mm, vma, haddr, pmd);
+
+maybe_install_pmd:
+	/* step 5: install pmd entry */
+	result = install_pmd
+			? set_huge_pmd(vma, haddr, pmd, hpage)
+			: SCAN_SUCCEED;
+
 drop_hpage:
 	unlock_page(hpage);
 	put_page(hpage);
-	return;
+	return result;
 
 abort:
 	pte_unmap_unlock(start_pte, ptl);
@@ -1488,22 +1558,29 @@ static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_sl
 		goto out;
 
 	for (i = 0; i < mm_slot->nr_pte_mapped_thp; i++)
-		collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i]);
+		collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i], false);
 
 out:
 	mm_slot->nr_pte_mapped_thp = 0;
 	mmap_write_unlock(mm);
 }
 
-static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
+static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
+			       struct mm_struct *target_mm,
+			       unsigned long target_addr, struct page *hpage,
+			       struct collapse_control *cc)
 {
 	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-	unsigned long addr;
-	pmd_t *pmd;
+	int target_result = SCAN_FAIL;
 
 	i_mmap_lock_write(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
+		int result = SCAN_FAIL;
+		struct mm_struct *mm = NULL;
+		unsigned long addr = 0;
+		pmd_t *pmd;
+		bool is_target = false;
+
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
 		 * got written to. These VMAs are likely not worth investing
@@ -1520,24 +1597,34 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * ptl. It has higher chance to recover THP for the VMA, but
 		 * has higher cost too.
 		 */
-		if (vma->anon_vma)
-			continue;
+		if (vma->anon_vma) {
+			result = SCAN_PAGE_ANON;
+			goto next;
+		}
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-		if (addr & ~HPAGE_PMD_MASK)
-			continue;
-		if (vma->vm_end < addr + HPAGE_PMD_SIZE)
-			continue;
+		if (addr & ~HPAGE_PMD_MASK ||
+		    vma->vm_end < addr + HPAGE_PMD_SIZE) {
+			result = SCAN_VMA_CHECK;
+			goto next;
+		}
 		mm = vma->vm_mm;
-		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
-			continue;
+		is_target = mm == target_mm && addr == target_addr;
+		result = find_pmd_or_thp_or_none(mm, addr, &pmd);
+		if (result != SCAN_SUCCEED)
+			goto next;
 		/*
 		 * We need exclusive mmap_lock to retract page table.
 		 *
 		 * We use trylock due to lock inversion: we need to acquire
 		 * mmap_lock while holding page lock. Fault path does it in
 		 * reverse order. Trylock is a way to avoid deadlock.
+		 *
+		 * Also, it's not MADV_COLLAPSE's job to collapse other
+		 * mappings - let khugepaged take care of them later.
 		 */
-		if (mmap_write_trylock(mm)) {
+		result = SCAN_PTE_MAPPED_HUGEPAGE;
+		if ((cc->is_khugepaged || is_target) &&
+		    mmap_write_trylock(mm)) {
 			/*
 			 * When a vma is registered with uffd-wp, we can't
 			 * recycle the pmd pgtable because there can be pte
@@ -1546,22 +1633,45 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			 * it'll always mapped in small page size for uffd-wp
 			 * registered ranges.
 			 */
-			if (!hpage_collapse_test_exit(mm) &&
-			    !userfaultfd_wp(vma))
-				collapse_and_free_pmd(mm, vma, addr, pmd);
+			if (hpage_collapse_test_exit(mm)) {
+				result = SCAN_ANY_PROCESS;
+				goto unlock_next;
+			}
+			if (userfaultfd_wp(vma)) {
+				result = SCAN_PTE_UFFD_WP;
+				goto unlock_next;
+			}
+			collapse_and_free_pmd(mm, vma, addr, pmd);
+			if (!cc->is_khugepaged && is_target)
+				result = set_huge_pmd(vma, addr, pmd, hpage);
+			else
+				result = SCAN_SUCCEED;
+
+unlock_next:
 			mmap_write_unlock(mm);
-		} else {
-			/* Try again later */
+			goto next;
+		}
+		/*
+		 * Calling context will handle target mm/addr. Otherwise, let
+		 * khugepaged try again later.
+		 */
+		if (!is_target) {
 			khugepaged_add_pte_mapped_thp(mm, addr);
+			continue;
 		}
+next:
+		if (is_target)
+			target_result = result;
 	}
 	i_mmap_unlock_write(mapping);
+	return target_result;
 }
 
 /**
  * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
  *
  * @mm: process address space where collapse happens
+ * @addr: virtual collapse start address
  * @file: file that collapse on
  * @start: collapse start address
  * @cc: collapse context and scratchpad
@@ -1581,8 +1691,9 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
  *    + restore gaps in the page cache;
  *    + unlock and free huge page;
  */
-static int collapse_file(struct mm_struct *mm, struct file *file,
-			 pgoff_t start, struct collapse_control *cc)
+static int collapse_file(struct mm_struct *mm, unsigned long addr,
+			 struct file *file, pgoff_t start,
+			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
 	struct page *hpage;
@@ -1890,7 +2001,8 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
 		 */
-		retract_page_tables(mapping, start);
+		result = retract_page_tables(mapping, start, mm, addr, hpage,
+					     cc);
 		unlock_page(hpage);
 		hpage = NULL;
 	} else {
@@ -1946,8 +2058,9 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
 	return result;
 }
 
-static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
-				pgoff_t start, struct collapse_control *cc)
+static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
+				    struct file *file, pgoff_t start,
+				    struct collapse_control *cc)
 {
 	struct page *page = NULL;
 	struct address_space *mapping = file->f_mapping;
@@ -2035,7 +2148,7 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
 			result = SCAN_EXCEED_NONE_PTE;
 			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 		} else {
-			result = collapse_file(mm, file, start, cc);
+			result = collapse_file(mm, addr, file, start, cc);
 		}
 	}
 
@@ -2043,8 +2156,9 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
 	return result;
 }
 #else
-static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
-				pgoff_t start, struct collapse_control *cc)
+static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
+				    struct file *file, pgoff_t start,
+				    struct collapse_control *cc)
 {
 	BUILD_BUG();
 }
@@ -2142,8 +2256,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 						khugepaged_scan.address);
 
 				mmap_read_unlock(mm);
-				*result = khugepaged_scan_file(mm, file, pgoff,
-							       cc);
+				*result = hpage_collapse_scan_file(mm,
+								   khugepaged_scan.address,
+								   file, pgoff, cc);
 				mmap_locked = false;
 				fput(file);
 			} else {
@@ -2449,10 +2564,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 
 	*prev = vma;
 
-	/* TODO: Support file/shmem */
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
-		return -EINVAL;
-
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
 		return -EINVAL;
 
@@ -2483,16 +2594,35 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		}
 		mmap_assert_locked(mm);
 		memset(cc->node_load, 0, sizeof(cc->node_load));
-		result = hpage_collapse_scan_pmd(mm, vma, addr, &mmap_locked,
-						 cc);
+		if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
+			struct file *file = get_file(vma->vm_file);
+			pgoff_t pgoff = linear_page_index(vma, addr);
+
+			mmap_read_unlock(mm);
+			mmap_locked = false;
+			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
+							  cc);
+			fput(file);
+		} else {
+			result = hpage_collapse_scan_pmd(mm, vma, addr,
+							 &mmap_locked, cc);
+		}
 		if (!mmap_locked)
 			*prev = NULL;  /* Tell caller we dropped mmap_lock */
 
+handle_result:
 		switch (result) {
 		case SCAN_SUCCEED:
 		case SCAN_PMD_MAPPED:
 			++thps;
 			break;
+		case SCAN_PTE_MAPPED_HUGEPAGE:
+			BUG_ON(mmap_locked);
+			BUG_ON(*prev);
+			mmap_write_lock(mm);
+			result = collapse_pte_mapped_thp(mm, addr, true);
+			mmap_write_unlock(mm);
+			goto handle_result;
 		/* Whitelisted set of results where continuing OK */
 		case SCAN_PMD_NULL:
 		case SCAN_PTE_NON_PRESENT:
-- 
2.37.2.789.g6183377224-goog

