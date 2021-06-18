Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB973AC18C
	for <lists+linux-api@lfdr.de>; Fri, 18 Jun 2021 05:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFRDrO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Jun 2021 23:47:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:1072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232179AbhFRDrO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 Jun 2021 23:47:14 -0400
IronPort-SDR: m7oJ/9f8daOHtv32KrQvJi1ZIJqZNnUIaXGTA/IMiALUCw5bh8/sFFNt7DULTi2DXNFGNuV/zR
 dlDY9xpgwgug==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267636042"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267636042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:45:05 -0700
IronPort-SDR: y3IaxVP0Txk7G62sYbw6pSd5e9G2OHejtUlWZ2NFnbKdDL8kCVh7KnKpdb3SATlG2BS+/DNNE4
 x+T7eqwH2lrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="485539879"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2021 20:45:02 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v5 -mm 4/6] mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY
Date:   Fri, 18 Jun 2021 11:44:42 +0800
Message-Id: <1623987884-43576-5-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
References: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Implement the missing huge page allocation functionality while obeying
the preferred node semantics. This is similar to the implementation
for general page allocation, as it uses a fallback mechanism to try
multiple preferred nodes first, and then all other nodes.

[Thanks to 0day bot for caching the missing #ifdef CONFIG_NUMA issue]

Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Co-developed-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/hugetlb.c   | 27 +++++++++++++++++++++++++--
 mm/mempolicy.c |  3 ++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4120680e31a..c771debd35a6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1143,7 +1143,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1164,7 +1164,18 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
+#ifdef CONFIG_NUMA
+	if (mpol->mode == MPOL_PREFERRED_MANY) {
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+		if (page)
+			goto check_reserve;
+		/* Fallback to all nodes */
+		nodemask = NULL;
+	}
+#endif
 	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+
+check_reserve:
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
@@ -2048,9 +2059,21 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
+#ifdef CONFIG_NUMA
+	if (mpol->mode == MPOL_PREFERRED_MANY) {
+		gfp_t gfp = (gfp_mask | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM;
+
+		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
+		if (page)
+			goto exit;
+		/* Fallback to all nodes */
+		nodemask = NULL;
+	}
+#endif
 	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
-	mpol_cond_put(mpol);
 
+exit:
+	mpol_cond_put(mpol);
 	return page;
 }
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9dce67fc9bb6..93f8789758a7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2054,7 +2054,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if ((*mpol)->mode == MPOL_BIND)
+		if ((*mpol)->mode == MPOL_BIND ||
+		    (*mpol)->mode == MPOL_PREFERRED_MANY)
 			*nodemask = &(*mpol)->nodes;
 	}
 	return nid;
-- 
2.7.4

