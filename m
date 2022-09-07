Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F95B0753
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiIGOpx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIGOpk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:40 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6FB86D
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m5-20020a170902f64500b0016d313f3ce7so10088056plg.23
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=mwUyQsXXnuzgRC80f4Ko1g3FBHdD3PmOleWr3+725FQ=;
        b=HpLkWKmGYyap1p31IVtoIU+ngo4Pg/gFeu24PJplCjOKwxvfVoaXtv8uNO7Mmf+CIp
         Nznc2CZ5ZRZ3Ln0JJWMSOaw23HODU6ahxs6xNQ7kWnDwfVpUXlWdyVk/SEQWjYzrTt2L
         pQ8U3yVLzwmKB8XHOYiUE9iPb6hL3rQWe0CZ1cbWf6JTiPZCbWGRfMPs4IdMbneW/6qO
         RCJZcZXrjdEHfBWFGu/a6YwfLCSmVLla1MFtmPDoTSKSGkmVM7294qBbdJSp2TRkcoUx
         /ysFdjZ0wvxwCZaQBnrM9F0e9muLQwWZnPLZREuc6y8B11rcNtvcTmbQ4OwaJbHDZi+r
         L25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=mwUyQsXXnuzgRC80f4Ko1g3FBHdD3PmOleWr3+725FQ=;
        b=dgw0r+xnho5c/R0HMAvR9ZkO2x2HcfZ7hohid4rHjyMckj1BqJ0i7zbrldihZNESvP
         YUTyS5oQGMf0Us2lMsR125ypT1es8IXNX5dED59gATZyoqr07Hm9gaVUyh5ID/HFPv8y
         b09nEZ/BtOC+Rvq3uPEvoKmFHWrqmj/xOiK+rESZf5tpTUXHYdLyWlBz2RezwGYPKTFg
         NWs31Je44ECk7S9KYBm7MTeCVhX+dtQkHmyybitciF3tib5KqzTL2Xna3xgBFRprxmby
         4GUXYZ7+NQ/AL3cr5/qkVr8l8jxf3mnGPEoxlfxgZLZKHrJXfhHw9W83nYE6jhI7ILEK
         WujA==
X-Gm-Message-State: ACgBeo1Yda3SrPdtWmS2moVTx34SpRwkW4EF9ps0aDmRZeomF+mGt+Xg
        SPyx7y99yb9SFXV/KbmgPD8AB9hK9wvC
X-Google-Smtp-Source: AA6agR5tCW73dc7xRpTqLBr5637+l/XhHqtTAOqlHeR9e1be6e5YuZvx8XQpZgaTJdXJmgqVDgGdQDl0JqXV
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:8349:b0:176:a034:ec76 with SMTP id
 z9-20020a170902834900b00176a034ec76mr4370392pln.73.1662561938325; Wed, 07 Sep
 2022 07:45:38 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:13 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-3-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 02/10] mm/khugepaged: attempt to map
 file/shmem-backed pte-mapped THPs by pmds
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

The main benefit of THPs are that they can be mapped at the pmd level,
increasing the likelihood of TLB hit and spending less cycles in page
table walks.  pte-mapped hugepages - that is - hugepage-aligned compound
pages of order HPAGE_PMD_ORDER mapped by ptes - although being
contiguous in physical memory, don't have this advantage.  In fact, one
could argue they are detrimental to system performance overall since
they occupy a precious hugepage-aligned/sized region of physical memory
that could otherwise be used more effectively.  Additionally, pte-mapped
hugepages can be the cheapest memory to collapse for khugepaged since no
new hugepage allocation or copying of memory contents is necessary - we
only need to update the mapping page tables.

In the anonymous collapse path, we are able to collapse pte-mapped
hugepages (albeit, perhaps suboptimally), but the file/shmem path makes no
effort when compound pages (of any order) are encountered.

Identify pte-mapped hugepages in the file/shmem collapse path.  The
final step of which makes a racy check of the value of the pmd to ensure
it maps a pte table.  This should be fine, since races that result in
false-positive (i.e. attempt collapse even though we sholdn't) will fail
later in collapse_pte_mapped_thp() once we actually lock mmap_lock and
reinspect the pmd value.  Races that result in false-negatives (i.e.
where we decide to not attempt collapse, but should have) shouldn't be
an issue, since in the worst case, we do nothing - which is what we've
done up to this point.  We make a similar check in retract_page_tables().
If we do think we've found a pte-mapped hugepgae in khugepaged context,
attempt to update page tables mapping this hugepage.

Note that these collapses still count towards the
/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed counter, and
if the pte-mapped hugepage was also mapped into multiple process' address
spaces, could be incremented for each page table update.  Since we
increment the counter when a pte-mapped hugepage is successfully added to
the list of to-collapse pte-mapped THPs, it's possible that we never
actually update the page table either.  This is different from how
file/shmem pages_collapsed accounting works today where only a successful
page cache update is counted (it's also possible here that no page tables
are actually changed).  Though it incurs some slop, this is preferred to
either not accounting for the event at all, or plumbing through data in
struct mm_slot on whether to account for the collapse or not.

Also note that work still needs to be done to support arbitrary compound
pages, and that this should all be converted to using folios.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 include/trace/events/huge_memory.h |  1 +
 mm/khugepaged.c                    | 67 +++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 55392bf30a03..fbbb25494d60 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -17,6 +17,7 @@
 	EM( SCAN_EXCEED_SHARED_PTE,	"exceed_shared_pte")		\
 	EM( SCAN_PTE_NON_PRESENT,	"pte_non_present")		\
 	EM( SCAN_PTE_UFFD_WP,		"pte_uffd_wp")			\
+	EM( SCAN_PTE_MAPPED_HUGEPAGE,	"pte_mapped_hugepage")		\
 	EM( SCAN_PAGE_RO,		"no_writable_page")		\
 	EM( SCAN_LACK_REFERENCED_PAGE,	"lack_referenced_page")		\
 	EM( SCAN_PAGE_NULL,		"page_null")			\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 55c8625ed950..31ccf49cf279 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -35,6 +35,7 @@ enum scan_result {
 	SCAN_EXCEED_SHARED_PTE,
 	SCAN_PTE_NON_PRESENT,
 	SCAN_PTE_UFFD_WP,
+	SCAN_PTE_MAPPED_HUGEPAGE,
 	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
@@ -1318,20 +1319,24 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
  * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
  * khugepaged should try to collapse the page table.
  */
-static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 					  unsigned long addr)
 {
 	struct khugepaged_mm_slot *mm_slot;
 	struct mm_slot *slot;
+	bool ret = false;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
 
 	spin_lock(&khugepaged_mm_lock);
 	slot = mm_slot_lookup(mm_slots_hash, mm);
 	mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
-	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
+	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP)) {
 		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
+		ret = true;
+	}
 	spin_unlock(&khugepaged_mm_lock);
+	return ret;
 }
 
 static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -1368,9 +1373,16 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
 	spinlock_t *ptl;
-	int count = 0;
+	int count = 0, result = SCAN_FAIL;
 	int i;
 
+	mmap_assert_write_locked(mm);
+
+	/* Fast check before locking page if already PMD-mapped  */
+	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
+	if (result != SCAN_SUCCEED)
+		return;
+
 	if (!vma || !vma->vm_file ||
 	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
 		return;
@@ -1721,9 +1733,16 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
 		/*
 		 * If file was truncated then extended, or hole-punched, before
 		 * we locked the first page, then a THP might be there already.
+		 * This will be discovered on the first iteration.
 		 */
 		if (PageTransCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
+			struct page *head = compound_head(page);
+
+			result = compound_order(head) == HPAGE_PMD_ORDER &&
+					head->index == start
+					/* Maybe PMD-mapped */
+					? SCAN_PTE_MAPPED_HUGEPAGE
+					: SCAN_PAGE_COMPOUND;
 			goto out_unlock;
 		}
 
@@ -1961,7 +1980,19 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
 		 * into a PMD sized page
 		 */
 		if (PageTransCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
+			struct page *head = compound_head(page);
+
+			result = compound_order(head) == HPAGE_PMD_ORDER &&
+					head->index == start
+					/* Maybe PMD-mapped */
+					? SCAN_PTE_MAPPED_HUGEPAGE
+					: SCAN_PAGE_COMPOUND;
+			/*
+			 * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
+			 * by the caller won't touch the page cache, and so
+			 * it's safe to skip LRU and refcount checks before
+			 * returning.
+			 */
 			break;
 		}
 
@@ -2021,6 +2052,12 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
 static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
 {
 }
+
+static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+					  unsigned long addr)
+{
+	return false;
+}
 #endif
 
 static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
@@ -2115,8 +2152,26 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 								  &mmap_locked,
 								  cc);
 			}
-			if (*result == SCAN_SUCCEED)
+			switch (*result) {
+			case SCAN_PTE_MAPPED_HUGEPAGE: {
+				pmd_t *pmd;
+
+				*result = find_pmd_or_thp_or_none(mm,
+								  khugepaged_scan.address,
+								  &pmd);
+				if (*result != SCAN_SUCCEED)
+					break;
+				if (!khugepaged_add_pte_mapped_thp(mm,
+								   khugepaged_scan.address))
+					break;
+			} fallthrough;
+			case SCAN_SUCCEED:
 				++khugepaged_pages_collapsed;
+				break;
+			default:
+				break;
+			}
+
 			/* move to next address */
 			khugepaged_scan.address += HPAGE_PMD_SIZE;
 			progress += HPAGE_PMD_NR;
-- 
2.37.2.789.g6183377224-goog

