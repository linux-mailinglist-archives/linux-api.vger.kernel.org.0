Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62345308DD
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 08:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEaGnm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 02:43:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38732 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGnm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 02:43:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so3604025plb.5;
        Thu, 30 May 2019 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+TrQWebb1OQqIMsOPBwXOFrxSHqKpw5UQ00aCYRV6U=;
        b=kuACxbXH+9FoOl8y32mUGUSFvG3BNUwt7h4d8u+U1DMvt0f0dWSJxfj0SIY9/t3bGB
         J6Xc51DsKnBPFaE4WbaMPk1mAgGh7Uoe9JiYM5kmLCvZOUS/NwOpzEGLN1TVUAciqAZY
         j/MFHhAydSn2PLOj6PmQ59xb5YmVCJTGYCNMeiLopGArg/Hc3cTHxmLOuBW3cOKVHjYN
         Gudc1YJevZoVh/8NVigzrpCmlDHGNfTao83N+IApxFs1dKuDmEDuGtiQ1ARmSLXeRDrW
         Wxg+6NIRSZuT02jPArGbPPUbPMYXC7btU9n1KVReG/mzKU5L1n9Tq0Uc4NCQvXJGkqRQ
         8SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G+TrQWebb1OQqIMsOPBwXOFrxSHqKpw5UQ00aCYRV6U=;
        b=D+U91XJKs/JiHkNBeOOQsPRUbNMzWJMJL0M58Rddpdm21dhoAxkrZZLGFaJgTZdv8s
         9qCuLtAAngT1weANQ4rd/vzxu02STb+VIQY5GCmtFj41pF6HmatcFicay0BDqGPKGbTl
         19EpDi1EOArhIupC11ytfsB7MiWlvGZtEVgbicZWcfPuS/6CwZdJlu9uPknc5C7EC4TY
         Hh85HgBqftnKDnmhyqHeWxaqBKgB3TJp/g3cyIjQw3xDonBYyuzGpF9u7J4eV05eFWIp
         BBuTdO7ZuWmCaKttMkgjWeVPrncnxdwb3TOgdborLbfaypQgMXvifPKiJaHytflHfveh
         UzBg==
X-Gm-Message-State: APjAAAXXb8K5GhPaK9IIZIDQJAUtkkdfYEwx3L8GbUfl+ABQlzz6YIB2
        xsr7zNZSEmFT3th6bCHyx78=
X-Google-Smtp-Source: APXvYqwAhOWjoSgAiirZU4CO+Y4FLGljQXQatDXZpfewPZcwELP4PX2gZp7hdg8bFpts+exduLmpIQ==
X-Received: by 2002:a17:902:2ba7:: with SMTP id l36mr7376613plb.334.1559285020728;
        Thu, 30 May 2019 23:43:40 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f30sm4243340pjg.13.2019.05.30.23.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:43:39 -0700 (PDT)
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
        hdanton@sina.com, Minchan Kim <minchan@kernel.org>
Subject: [RFCv2 3/6] mm: introduce MADV_PAGEOUT
Date:   Fri, 31 May 2019 15:43:10 +0900
Message-Id: <20190531064313.193437-4-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190531064313.193437-1-minchan@kernel.org>
References: <20190531064313.193437-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When a process expects no accesses to a certain memory range
for a long time, it could hint kernel that the pages can be
reclaimed instantly but data should be preserved for future use.
This could reduce workingset eviction so it ends up increasing
performance.

This patch introduces the new MADV_PAGEOUT hint to madvise(2)
syscall. MADV_PAGEOUT can be used by a process to mark a memory
range as not expected to be used for a long time so that kernel
reclaims the memory instantly. The hint can help kernel in deciding
which pages to evict proactively.

* RFCv1
 * rename from MADV_COLD to MADV_PAGEOUT - hannes
 * bail out if process is being killed - Hillf
 * fix reclaim_pages bugs - Hillf

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/swap.h                   |   1 +
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/madvise.c                           | 126 +++++++++++++++++++++++++
 mm/vmscan.c                            |  77 +++++++++++++++
 4 files changed, 205 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0ce997edb8bb..063c0c1e112b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -365,6 +365,7 @@ extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
 extern unsigned long vm_total_pages;
 
+extern unsigned long reclaim_pages(struct list_head *page_list);
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 1190f4e7f7b9..92e347a89ddc 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -44,6 +44,7 @@
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
 #define MADV_COLD	5		/* deactivatie these pages */
+#define MADV_PAGEOUT	6		/* reclaim these pages */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_FREE	8		/* free pages only if memory pressure */
diff --git a/mm/madvise.c b/mm/madvise.c
index bff150eab6da..9d749a1420b4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -41,6 +41,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
 	case MADV_COLD:
+	case MADV_PAGEOUT:
 	case MADV_FREE:
 		return 0;
 	default:
@@ -415,6 +416,128 @@ static long madvise_cold(struct vm_area_struct *vma,
 	return 0;
 }
 
+static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
+				unsigned long end, struct mm_walk *walk)
+{
+	pte_t *orig_pte, *pte, ptent;
+	spinlock_t *ptl;
+	LIST_HEAD(page_list);
+	struct page *page;
+	int isolated = 0;
+	struct vm_area_struct *vma = walk->vma;
+	unsigned long next;
+
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+	next = pmd_addr_end(addr, end);
+	if (pmd_trans_huge(*pmd)) {
+		ptl = pmd_trans_huge_lock(pmd, vma);
+		if (!ptl)
+			return 0;
+
+		if (is_huge_zero_pmd(*pmd))
+			goto huge_unlock;
+
+		page = pmd_page(*pmd);
+		if (page_mapcount(page) > 1)
+			goto huge_unlock;
+
+		if (next - addr != HPAGE_PMD_SIZE) {
+			int err;
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
+		if (isolate_lru_page(page))
+			goto huge_unlock;
+
+		list_add(&page->lru, &page_list);
+huge_unlock:
+		spin_unlock(ptl);
+		reclaim_pages(&page_list);
+		return 0;
+	}
+
+	if (pmd_trans_unstable(pmd))
+		return 0;
+regular_page:
+	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
+		ptent = *pte;
+		if (!pte_present(ptent))
+			continue;
+
+		page = vm_normal_page(vma, addr, ptent);
+		if (!page)
+			continue;
+
+		if (page_mapcount(page) > 1)
+			continue;
+
+		if (isolate_lru_page(page))
+			continue;
+
+		isolated++;
+		list_add(&page->lru, &page_list);
+		if (isolated >= SWAP_CLUSTER_MAX) {
+			pte_unmap_unlock(orig_pte, ptl);
+			reclaim_pages(&page_list);
+			isolated = 0;
+			pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+			orig_pte = pte;
+		}
+	}
+
+	pte_unmap_unlock(orig_pte, ptl);
+	reclaim_pages(&page_list);
+	cond_resched();
+
+	return 0;
+}
+
+static void madvise_pageout_page_range(struct mmu_gather *tlb,
+			     struct vm_area_struct *vma,
+			     unsigned long addr, unsigned long end)
+{
+	struct mm_walk warm_walk = {
+		.pmd_entry = madvise_pageout_pte_range,
+		.mm = vma->vm_mm,
+	};
+
+	tlb_start_vma(tlb, vma);
+	walk_page_range(addr, end, &warm_walk);
+	tlb_end_vma(tlb, vma);
+}
+
+
+static long madvise_pageout(struct vm_area_struct *vma,
+			struct vm_area_struct **prev,
+			unsigned long start_addr, unsigned long end_addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_gather tlb;
+
+	*prev = vma;
+	if (vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP))
+		return -EINVAL;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
+	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
+	tlb_finish_mmu(&tlb, start_addr, end_addr);
+
+	return 0;
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
@@ -805,6 +928,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		return madvise_willneed(vma, prev, start, end);
 	case MADV_COLD:
 		return madvise_cold(vma, prev, start, end);
+	case MADV_PAGEOUT:
+		return madvise_pageout(vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
@@ -827,6 +952,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_DONTNEED:
 	case MADV_FREE:
 	case MADV_COLD:
+	case MADV_PAGEOUT:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0973a46a0472..280dd808fb91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2126,6 +2126,83 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			nr_deactivate, nr_rotated, sc->priority, file);
 }
 
+unsigned long reclaim_pages(struct list_head *page_list)
+{
+	int nid = -1;
+	unsigned long nr_isolated[2] = {0, };
+	unsigned long nr_reclaimed = 0;
+	LIST_HEAD(node_page_list);
+	struct reclaim_stat dummy_stat;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.priority = DEF_PRIORITY,
+		.may_writepage = 1,
+		.may_unmap = 1,
+		.may_swap = 1,
+	};
+
+	while (!list_empty(page_list)) {
+		struct page *page;
+
+		page = lru_to_page(page_list);
+		if (nid == -1) {
+			nid = page_to_nid(page);
+			INIT_LIST_HEAD(&node_page_list);
+			nr_isolated[0] = nr_isolated[1] = 0;
+		}
+
+		if (nid == page_to_nid(page)) {
+			list_move(&page->lru, &node_page_list);
+			nr_isolated[!!page_is_file_cache(page)] +=
+						hpage_nr_pages(page);
+			continue;
+		}
+
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
+					nr_isolated[0]);
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
+					nr_isolated[1]);
+		nr_reclaimed += shrink_page_list(&node_page_list,
+				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
+				&dummy_stat, true);
+		while (!list_empty(&node_page_list)) {
+			struct page *page = lru_to_page(&node_page_list);
+
+			list_del(&page->lru);
+			putback_lru_page(page);
+		}
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
+					-nr_isolated[0]);
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
+					-nr_isolated[1]);
+		nid = -1;
+	}
+
+	if (!list_empty(&node_page_list)) {
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
+					nr_isolated[0]);
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
+					nr_isolated[1]);
+		nr_reclaimed += shrink_page_list(&node_page_list,
+				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
+				&dummy_stat, true);
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
+					-nr_isolated[0]);
+		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
+					-nr_isolated[1]);
+
+		while (!list_empty(&node_page_list)) {
+			struct page *page = lru_to_page(&node_page_list);
+
+			list_del(&page->lru);
+			putback_lru_page(page);
+		}
+
+	}
+
+	return nr_reclaimed;
+}
+
 /*
  * The inactive anon list should be small enough that the VM never has
  * to do too much work.
-- 
2.22.0.rc1.257.g3120a18244-goog

