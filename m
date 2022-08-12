Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D925909D6
	for <lists+linux-api@lfdr.de>; Fri, 12 Aug 2022 03:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiHLB3Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Aug 2022 21:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLB3Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Aug 2022 21:29:16 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EB9BB5E
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:14 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id jx17-20020a17090b46d100b001f33b230098so9256155pjb.7
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=D+0/ITQwVbItb/OQYiw4XC83AjMLteP3+8N2xJTlJLM=;
        b=JxIJCzYb4mqrXGnra1dLEIm/ZgGM4ezcWBnJd0BPhnAVnf4tubR1FM1HOwi6lXF8b0
         YyH11+U5hlCuW7KotDYIkd3TtlK2N45WNofPGDxKmqD48KicxtC6WEsODSAGkaqOF3XJ
         fX+OYpxq8bORNmlGIyz/7acJ8OU696zip1NhD/ptYoKzqbO1Wr7dtqs8AqjaXTQE8EQh
         4fNMmdGHGGF0QihvgwppmgIC3/xbUtBElv5rWa6OHAyAz0Ic9R7maYJJlBSRvbGRPXzz
         ZX338W3+2nx5B9Amh0yZeM2AFgsA2jfgF4ufFSscgMnCZOh7CKP+bXA2+M/OfgPCOeaa
         33Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=D+0/ITQwVbItb/OQYiw4XC83AjMLteP3+8N2xJTlJLM=;
        b=taRQBg6mvwqBW5AEhUA5BcR4emF13dL2UFhyAMmKVFsCSEJR+cen+f9GYSHpfYkZbN
         4QLQnStbUCPwbZTUqY22yw+gzuhZja9aDp3oJA8MYFIZM3Oy/ETkrDeVndFVJ5MtJ3YR
         /n9pRiZfI7fK9pxMcGzoyXtiVsOWnHvGdWzVrOyCap5VvNvnXQ05yI0Fyg38szYJNzmt
         xzJxYZD7BM+mqfjT6zdg0DUn6/D+SUn7K4q8AFXEFZh6pClX51gug9f6J2/9WgzqfV7Z
         MnWHovqubghwcdR451TMPz5drThGhlZt2Wg7sSL8j1CaT8nx6AIcwbjTiiVPK3oIV/JF
         cnaQ==
X-Gm-Message-State: ACgBeo1At5zhFlCkQNpZwdRWMFVRpeGi+RY+c7S7OHAEVjYFkYI3O9km
        b1YvGZqTKaeQj2briAEuVAr1VTfTG9Vm
X-Google-Smtp-Source: AA6agR7zHRajCDohYZv9JxhzN9Yk3zD3QF7QSD8xFWdUETseqcvu4alImf31npPy5xjvP5q7sC7NitUEyedo
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90b:4aca:b0:1f4:ea26:f589 with SMTP id
 mh10-20020a17090b4aca00b001f4ea26f589mr11221304pjb.142.1660267754356; Thu, 11
 Aug 2022 18:29:14 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:28:36 -0700
In-Reply-To: <20220812012843.3948330-1-zokeefe@google.com>
Message-Id: <20220812012843.3948330-3-zokeefe@google.com>
Mime-Version: 1.0
References: <20220812012843.3948330-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH mm-unstable 2/9] mm/khugepaged: attempt to map
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
pages of order HPAGE_PMD_ORDER - although being contiguous in physical
memory, don't have this advantage.  In fact, one could argue they are
detrimental to system performance overall since they occupy a precious
hugepage-aligned/sized region of physical memory that could otherwise
be used more effectively.  Additionally, pte-mapped hugepages can be the
cheapest memory to collapse for khugepaged since no new hugepage
allocation or copying of memory contents is necessary - we only need to
update the mapping page tables.

In the anonymous collapse path, we are able to collapse pte-mapped
hugepages (albeit, perhaps suboptimally), but the file/shmem path makes no
effort when compound pages (of any order) are encountered.

Identify pte-mapped hugepages in the file/shmem collapse path.  In
khugepaged context, attempt to update page tables mapping this hugepage.
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

Note that work still needs to be done to support arbitrary compound
pages, and that this should all be converted to using folios.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 include/trace/events/huge_memory.h |  1 +
 mm/khugepaged.c                    | 43 +++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 6 deletions(-)

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
index 3e64105398c3..8165a1fc42dd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -34,6 +34,7 @@ enum scan_result {
 	SCAN_EXCEED_SHARED_PTE,
 	SCAN_PTE_NON_PRESENT,
 	SCAN_PTE_UFFD_WP,
+	SCAN_PTE_MAPPED_HUGEPAGE,
 	SCAN_PAGE_RO,
 	SCAN_LACK_REFERENCED_PAGE,
 	SCAN_PAGE_NULL,
@@ -1349,18 +1350,22 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
  * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
  * khugepaged should try to collapse the page table.
  */
-static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 					  unsigned long addr)
 {
 	struct mm_slot *mm_slot;
+	bool ret = false;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
 
 	spin_lock(&khugepaged_mm_lock);
 	mm_slot = get_mm_slot(mm);
-	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
+	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP)) {
 		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
+		ret = true;
+	}
 	spin_unlock(&khugepaged_mm_lock);
+	return ret;
 }
 
 static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -1397,9 +1402,16 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
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
@@ -1748,7 +1760,11 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
 		 * we locked the first page, then a THP might be there already.
 		 */
 		if (PageTransCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
+			result = compound_order(page) == HPAGE_PMD_ORDER &&
+					index == start
+					/* Maybe PMD-mapped */
+					? SCAN_PTE_MAPPED_HUGEPAGE
+					: SCAN_PAGE_COMPOUND;
 			goto out_unlock;
 		}
 
@@ -1986,7 +2002,11 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
 		 * into a PMD sized page
 		 */
 		if (PageTransCompound(page)) {
-			result = SCAN_PAGE_COMPOUND;
+			result = compound_order(page) == HPAGE_PMD_ORDER &&
+					xas.xa_index == start
+					/* Maybe PMD-mapped */
+					? SCAN_PTE_MAPPED_HUGEPAGE
+					: SCAN_PAGE_COMPOUND;
 			break;
 		}
 
@@ -2132,8 +2152,19 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 								  &mmap_locked,
 								  cc);
 			}
-			if (*result == SCAN_SUCCEED)
+			switch (*result) {
+			case SCAN_PTE_MAPPED_HUGEPAGE:
+				if (!khugepaged_add_pte_mapped_thp(mm,
+								   khugepaged_scan.address))
+					break;
+				fallthrough;
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
2.37.1.559.g78731f0fdb-goog

