Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EB5E6FD3
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 00:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIVWlB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 18:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIVWk5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 18:40:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364FFB30A
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:40:52 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 2-20020a621502000000b00541081df73eso6072697pfv.9
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=eUAUkrxHu4GQgGruUF7dEalZrbHhi5PUx17XipEP8M4=;
        b=Kcl2tYPwasVx5odrwrwR0bkMEAW3Cq74RZkT7uxl+KiElKu3LQoE4hIUXcP/adHGP7
         HivspBLdS3TBrzJr5Bd+XE6jJ1gQIkycUd+wcpqK4H1hnXBkFHbbO5DxB73ZnuIqgX3K
         bAZ9MOTpclPWIrpoM+1Q1mVVdliSxOD9iPI7y0oCLkWd3tBm1Zgf0aboa71i+TSt+dYV
         W3gE+54np4fAvjYYmXjSMUMRdlqZgpO4s1txQB2U9RkXc35SOc2hDZGPGa1CI7QVdarf
         eNHPsmA3VNcLREHgFDCuWFnjM2eDg0F7f3smb/QqEpEOLSdCRyluAhl2ECIumxaw0vTf
         lo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=eUAUkrxHu4GQgGruUF7dEalZrbHhi5PUx17XipEP8M4=;
        b=KTuHiU/C4Y7nOxdCBt0gO0DjMUpf3L7BlDe6m7ghqqC7T05vPPeKzAwqZoZIjO4ghX
         CqANig98n3KU2OlWhbRBMrqQpCBmaWHikZ/BtKvN2rawH8PbxTzSJfJe78YbIG2K3LHt
         iNLzbZK0OsSmBI0iwyxlCzoE4mKU6hHjQ3smOzq0z7SKsmxTgc0JJnBoX3NlJV6ge85E
         +viEYHRlmg0ya+k5I5WGuBC/6emh+0u9zE8MEzpywREJF0MsHkfi+aphdhqmiV74re67
         HBc2tCrJZCm8NG6N3RD6GcYKRftYUw7y9aMc0trxIKZTUI7ea3RkPdnoOeRXkdjeDVIA
         t5vA==
X-Gm-Message-State: ACrzQf1m9nLBrilRUTWIbL5Foq6WK5fEFgC+XwuPAEsj+8FSQ3cZX8FB
        I42QK6+WoxRzJ2bC/75lS51gs00VkRIT
X-Google-Smtp-Source: AMsMyM4dezoNRKufxLVTgdgSHHY+kCUdh19dMCibhuub7s6xrEb3KuB6lP7fatolqmTcRYFbqem0yAuAHDRI
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr414304pju.0.1663886451993; Thu, 22 Sep
 2022 15:40:51 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:40:38 -0700
In-Reply-To: <20220922224046.1143204-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922224046.1143204-3-zokeefe@google.com>
Subject: [PATCH mm-unstable v4 02/10] mm/khugepaged: attempt to map
 file/shmem-backed pte-mapped THPs by pmds
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
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
        Patrick Xia <patrickx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The main benefit of THPs are that they can be mapped at the pmd level,
increasing the likelihood of TLB hit and spending less cycles in page
table walks.  pte-mapped hugepages - that is - hugepage-aligned compound
pages of order HPAGE_PMD_ORDER mapped by ptes - although being contiguous
in physical memory, don't have this advantage.  In fact, one could argue
they are detrimental to system performance overall since they occupy a
precious hugepage-aligned/sized region of physical memory that could
otherwise be used more effectively.  Additionally, pte-mapped hugepages
can be the cheapest memory to collapse for khugepaged since no new
hugepage allocation or copying of memory contents is necessary - we only
need to update the mapping page tables.

In the anonymous collapse path, we are able to collapse pte-mapped
hugepages (albeit, perhaps suboptimally), but the file/shmem path makes no
effort when compound pages (of any order) are encountered.

Identify pte-mapped hugepages in the file/shmem collapse path.  The
final step of which makes a racy check of the value of the pmd to
ensure it maps a pte table.  This should be fine, since races that
result in false-positive (i.e.  attempt collapse even though we
shouldn't) will fail later in collapse_pte_mapped_thp() once we
actually lock mmap_lock and reinspect the pmd value.  Races that result
in false-negatives (i.e.  where we decide to not attempt collapse, but
should have) shouldn't be an issue, since in the worst case, we do
nothing - which is what we've done up to this point.  We make a similar
check in retract_page_tables().  If we do think we've found a
pte-mapped hugepgae in khugepaged context, attempt to update page
tables mapping this hugepage.

Note that these collapses still count towards the
/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed counter,
and if the pte-mapped hugepage was also mapped into multiple process'
address spaces, could be incremented for each page table update.  Since we
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

[shy828301@gmail.com: Spelling mistake, update comment, and add Documentation]
  Link: https://lore.kernel.org/linux-mm/CAHbLzkpHwZxFzjfX9nxVoRhzup8WMjMfyL6Xiq8mZ9M-N3ombw@mail.gmail.com/
Link: https://lkml.kernel.org/r/20220907144521.3115321-3-zokeefe@google.com
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Kennelly <ckennelly@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/admin-guide/mm/transhuge.rst |  9 ++-
 include/trace/events/huge_memory.h         |  1 +
 mm/khugepaged.c                            | 69 +++++++++++++++++++---
 3 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 8e3418ec4503..8ee78ec232eb 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -191,7 +191,14 @@ allocation failure to throttle the next allocation attempt::
 
 	/sys/kernel/mm/transparent_hugepage/khugepaged/alloc_sleep_millisecs
 
-The khugepaged progress can be seen in the number of pages collapsed::
+The khugepaged progress can be seen in the number of pages collapsed (note
+that this counter may not be an exact count of the number of pages
+collapsed, since "collapsed" could mean multiple things: (1) A PTE mapping
+being replaced by a PMD mapping, or (2) All 4K physical pages replaced by
+one 2M hugepage. Each may happen independently, or together, depending on
+the type of memory and the failures that occur. As such, this value should
+be interpreted roughly as a sign of progress, and counters in /proc/vmstat
+consulted for more accurate accounting)::
 
 	/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed
 
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
index b3ebe90a66d9..b1e3f83c4eb2 100644
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
@@ -1320,20 +1321,24 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
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
@@ -1370,9 +1375,16 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
 	spinlock_t *ptl;
-	int count = 0;
+	int count = 0, result = SCAN_FAIL;
 	int i;
 
+	mmap_assert_write_locked(mm);
+
+	/* Fast check before locking page if not PMD mapping PTE table */
+	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
+	if (result != SCAN_SUCCEED)
+		return;
+
 	if (!vma || !vma->vm_file ||
 	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
 		return;
@@ -1726,9 +1738,16 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
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
 
@@ -1962,11 +1981,23 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
 		}
 
 		/*
-		 * XXX: khugepaged should compact smaller compound pages
+		 * TODO: khugepaged should compact smaller compound pages
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
 
@@ -2026,6 +2057,12 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
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
@@ -2118,8 +2155,26 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
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
2.37.3.998.g577e59143f-goog

