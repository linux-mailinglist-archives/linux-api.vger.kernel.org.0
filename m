Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A99F75D14
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 04:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfGZCfD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 22:35:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45799 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZCfD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 22:35:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so24154325plr.12;
        Thu, 25 Jul 2019 19:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uelhR0bVtCikiO3UjN5/qieUxFslDUIqUJrGkVz98o=;
        b=Nb1DZrb0AHta/GHTPhgUw9v0mr9+lMXze6QXty1JADheqRUGT0akcOYDDNVbJ+jvhe
         TcV899MhXTYzNnQlERcDNnF8Z9K/f0fplT2E1YXXrJ8/CAKHeQ/rPDQGBKYq/u5EHYU8
         IBxDNhTu1cGUkPCYMigStPeT9XRrMcD2f4t+qWWYo8qzaaYceUJMsk1agTbbKAVuC7E8
         woU+8Z0VOg7UqvDaSwW2y7aAxu5U95WDc4iuq9I5MPWitAxnWzxBo+K6VQ71zXoLMMYT
         +tTT9gD2oOUvd0MHLTDh0Sp9QHzF9JFZy56qre9UdMU65lxoA9X1HCzfS+nDD1KOydLa
         7jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0uelhR0bVtCikiO3UjN5/qieUxFslDUIqUJrGkVz98o=;
        b=rdx5+xbzZNxCrOCl8SMP+v11BUlwwUAvwpRYqz7C+4lXvICWbjfRK4zumgZ+/vKePa
         GEvVmwXbUwXssjjekKP0pAdHCwRBCRQcT2i1h8KQMMfkQ3B0XTj2Ye/LbwnnF0t4ZNHw
         U9qWWR0+Bft4FB+jJr4RCLYlsyiORv5QwcANtiVGAOk+5IhkH9WCpcNPchdyR4nMlDss
         LMIAY5S3yiI247qFhe+G/BRJnuobmINiK3ZckgdPLXpsAsjqkb75HQ4TJIqLBg7S4Xm+
         Q450M5MWZMUoMUtcmlhPfZS2mVd6Aig0tWTSRncO6qKCgg0hnKfBuY8vom2YNRTEjP9o
         9h/g==
X-Gm-Message-State: APjAAAUETOZ99qU2+YQduLmkFJENCA612z2w7AGbDu/Mx7AcZzxv44iz
        WWFSjmPGcHPXfZFPktHn5R4=
X-Google-Smtp-Source: APXvYqxiGcZ8zBMIzJvwkXZqeTobDQDNvXHVXN5DDOJjlQ39/Hi0HLMdq6JxMCc004FRNhGuThOfSw==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr90124110plr.185.1564108501869;
        Thu, 25 Jul 2019 19:35:01 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l31sm88958450pgm.63.2019.07.25.19.34.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 19:35:00 -0700 (PDT)
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
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v7 3/5] mm: account nr_isolated_xxx in [isolate|putback]_lru_page
Date:   Fri, 26 Jul 2019 11:34:33 +0900
Message-Id: <20190726023435.214162-4-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726023435.214162-1-minchan@kernel.org>
References: <20190726023435.214162-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The isolate counting is pecpu counter so it would be not huge gain
to work them by batch. Rather than complicating to make them batch,
let's make it more stright-foward via adding the counting logic
into [isolate|putback]_lru_page API.

* v1
 * fix accounting bug - Hillf

Link: http://lkml.kernel.org/r/20190531165927.GA20067@cmpxchg.org
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/compaction.c     |  2 --
 mm/gup.c            |  7 +------
 mm/khugepaged.c     |  3 ---
 mm/memory-failure.c |  3 ---
 mm/memory_hotplug.c |  4 ----
 mm/mempolicy.c      |  3 ---
 mm/migrate.c        | 37 ++++++++-----------------------------
 mm/vmscan.c         | 22 ++++++++++++++++------
 8 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d99d59412c755..ac4ead029b4a1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -984,8 +984,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/* Successfully isolated */
 		del_page_from_lru_list(page, lruvec, page_lru(page));
-		inc_node_page_state(page,
-				NR_ISOLATED_ANON + page_is_file_cache(page));
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index 012060efddf18..357cfc1ca37d1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1460,13 +1460,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					drain_allow = false;
 				}
 
-				if (!isolate_lru_page(head)) {
+				if (!isolate_lru_page(head))
 					list_add_tail(&head->lru, &cma_page_list);
-					mod_node_page_state(page_pgdat(head),
-							    NR_ISOLATED_ANON +
-							    page_is_file_cache(head),
-							    hpage_nr_pages(head));
-				}
 			}
 		}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eaaa21b232156..a8b517d6df4ab 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -503,7 +503,6 @@ void __khugepaged_exit(struct mm_struct *mm)
 
 static void release_pte_page(struct page *page)
 {
-	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
 	unlock_page(page);
 	putback_lru_page(page);
 }
@@ -602,8 +601,6 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			result = SCAN_DEL_PAGE_LRU;
 			goto out;
 		}
-		inc_node_page_state(page,
-				NR_ISOLATED_ANON + page_is_file_cache(page));
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7ef849da8278c..9900bb95d7740 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1791,9 +1791,6 @@ static int __soft_offline_page(struct page *page, int flags)
 		 * so use !__PageMovable instead for LRU page's mapping
 		 * cannot have PAGE_MAPPING_MOVABLE.
 		 */
-		if (!__PageMovable(page))
-			inc_node_page_state(page, NR_ISOLATED_ANON +
-						page_is_file_cache(page));
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5b8811945bbba..9a82e12bd0e73 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1373,10 +1373,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
 		if (!ret) { /* Success */
 			list_add_tail(&page->lru, &source);
-			if (!__PageMovable(page))
-				inc_node_page_state(page, NR_ISOLATED_ANON +
-						    page_is_file_cache(page));
-
 		} else {
 			pr_warn("failed to isolate pfn %lx\n", pfn);
 			dump_page(page, "isolation failed");
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 547cd403ed020..e8bbec6148dfe 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -977,9 +977,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
 		if (!isolate_lru_page(head)) {
 			list_add_tail(&head->lru, pagelist);
-			mod_node_page_state(page_pgdat(head),
-				NR_ISOLATED_ANON + page_is_file_cache(head),
-				hpage_nr_pages(head));
 		} else if (flags & MPOL_MF_STRICT) {
 			/*
 			 * Non-movable page may reach here.  And, there may be
diff --git a/mm/migrate.c b/mm/migrate.c
index 92d346646ed55..84b89d2d69065 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -190,8 +190,6 @@ void putback_movable_pages(struct list_head *l)
 			unlock_page(page);
 			put_page(page);
 		} else {
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_cache(page), -hpage_nr_pages(page));
 			putback_lru_page(page);
 		}
 	}
@@ -1177,10 +1175,17 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		return -ENOMEM;
 
 	if (page_count(page) == 1) {
+		bool is_lru = !__PageMovable(page);
+
 		/* page was freed from under us. So we are done. */
 		ClearPageActive(page);
 		ClearPageUnevictable(page);
-		if (unlikely(__PageMovable(page))) {
+		if (likely(is_lru))
+			mod_node_page_state(page_pgdat(page),
+						NR_ISOLATED_ANON +
+						page_is_file_cache(page),
+						-hpage_nr_pages(page));
+		else {
 			lock_page(page);
 			if (!PageMovable(page))
 				__ClearPageIsolated(page);
@@ -1206,15 +1211,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		 * restored.
 		 */
 		list_del(&page->lru);
-
-		/*
-		 * Compaction can migrate also non-LRU pages which are
-		 * not accounted to NR_ISOLATED_*. They can be recognized
-		 * as __PageMovable
-		 */
-		if (likely(!__PageMovable(page)))
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_cache(page), -hpage_nr_pages(page));
 	}
 
 	/*
@@ -1568,9 +1564,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 
 		err = 0;
 		list_add_tail(&head->lru, pagelist);
-		mod_node_page_state(page_pgdat(head),
-			NR_ISOLATED_ANON + page_is_file_cache(head),
-			hpage_nr_pages(head));
 	}
 out_putpage:
 	/*
@@ -1886,8 +1879,6 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
-	int page_lru;
-
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
 	/* Avoid migrating to a node that is nearly full */
@@ -1909,10 +1900,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 	}
 
-	page_lru = page_is_file_cache(page);
-	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
-				hpage_nr_pages(page));
-
 	/*
 	 * Isolating the page has taken another reference, so the
 	 * caller's reference can be safely dropped without the page
@@ -1967,8 +1954,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
-			dec_node_page_state(page, NR_ISOLATED_ANON +
-					page_is_file_cache(page));
 			putback_lru_page(page);
 		}
 		isolated = 0;
@@ -1998,7 +1983,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated = 0;
 	struct page *new_page = NULL;
-	int page_lru = page_is_file_cache(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
 	new_page = alloc_pages_node(node,
@@ -2044,8 +2028,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 		/* Retake the callers reference and putback on LRU */
 		get_page(page);
 		putback_lru_page(page);
-		mod_node_page_state(page_pgdat(page),
-			 NR_ISOLATED_ANON + page_lru, -HPAGE_PMD_NR);
 
 		goto out_unlock;
 	}
@@ -2095,9 +2077,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	count_vm_events(PGMIGRATE_SUCCESS, HPAGE_PMD_NR);
 	count_vm_numa_events(NUMA_PAGE_MIGRATE, HPAGE_PMD_NR);
 
-	mod_node_page_state(page_pgdat(page),
-			NR_ISOLATED_ANON + page_lru,
-			-HPAGE_PMD_NR);
 	return isolated;
 
 out_fail:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 436577236dd3e..d1d7163c281de 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1021,6 +1021,9 @@ int remove_mapping(struct address_space *mapping, struct page *page)
 void putback_lru_page(struct page *page)
 {
 	lru_cache_add(page);
+	mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_cache(page),
+				-hpage_nr_pages(page));
 	put_page(page);		/* drop ref from isolate */
 }
 
@@ -1486,6 +1489,9 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 */
 		nr_reclaimed += nr_pages;
 
+		mod_node_page_state(pgdat, NR_ISOLATED_ANON +
+						page_is_file_cache(page),
+						-nr_pages);
 		/*
 		 * Is there need to periodically free_page_list? It would
 		 * appear not as the counts should be low
@@ -1561,7 +1567,6 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
 	ret = shrink_page_list(&clean_pages, zone->zone_pgdat, &sc,
 			TTU_IGNORE_ACCESS, &dummy_stat, true);
 	list_splice(&clean_pages, page_list);
-	mod_node_page_state(zone->zone_pgdat, NR_ISOLATED_FILE, -ret);
 	return ret;
 }
 
@@ -1637,6 +1642,9 @@ int __isolate_lru_page(struct page *page, isolate_mode_t mode)
 		 */
 		ClearPageLRU(page);
 		ret = 0;
+		__mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
+						page_is_file_cache(page),
+						hpage_nr_pages(page));
 	}
 
 	return ret;
@@ -1768,6 +1776,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
 				    total_scan, skipped, nr_taken, mode, lru);
 	update_lru_sizes(lruvec, lru, nr_zone_taken);
+
 	return nr_taken;
 }
 
@@ -1816,6 +1825,9 @@ int isolate_lru_page(struct page *page)
 			ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, lru);
 			ret = 0;
+			mod_node_page_state(pgdat, NR_ISOLATED_ANON +
+						page_is_file_cache(page),
+						hpage_nr_pages(page));
 		}
 		spin_unlock_irq(&pgdat->lru_lock);
 	}
@@ -1907,6 +1919,9 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
 		list_move(&page->lru, &lruvec->lists[lru]);
 
+		__mod_node_page_state(pgdat, NR_ISOLATED_ANON +
+						page_is_file_cache(page),
+						-hpage_nr_pages(page));
 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
 			__ClearPageActive(page);
@@ -1984,7 +1999,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &page_list,
 				     &nr_scanned, sc, lru);
 
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
 	reclaim_stat->recent_scanned[file] += nr_taken;
 
 	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
@@ -2010,8 +2024,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	move_pages_to_lru(lruvec, &page_list);
 
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-
 	spin_unlock_irq(&pgdat->lru_lock);
 
 	mem_cgroup_uncharge_list(&page_list);
@@ -2070,7 +2082,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	nr_taken = isolate_lru_pages(nr_to_scan, lruvec, &l_hold,
 				     &nr_scanned, sc, lru);
 
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
 	reclaim_stat->recent_scanned[file] += nr_taken;
 
 	__count_vm_events(PGREFILL, nr_scanned);
@@ -2139,7 +2150,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
 
-	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	spin_unlock_irq(&pgdat->lru_lock);
 
 	mem_cgroup_uncharge_list(&l_active);
-- 
2.22.0.709.g102302147b-goog

