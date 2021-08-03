Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F453DE67D
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhHCF7w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 01:59:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:34943 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234020AbhHCF7u (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Aug 2021 01:59:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235529253"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="235529253"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 22:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="479233364"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2021 22:59:35 -0700
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
Subject: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY
Date:   Tue,  3 Aug 2021 13:59:20 +0800
Message-Id: <1627970362-61305-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Implement the missing huge page allocation functionality while obeying
the preferred node semantics. This is similar to the implementation
for general page allocation, as it uses a fallback mechanism to try
multiple preferred nodes first, and then all other nodes.

[akpm: fix compling issue when merging with other hugetlb patch]
[Thanks to 0day bot for catching the missing #ifdef CONFIG_NUMA issue]
Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Co-developed-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/hugetlb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95714fb28150..9279f6d478d9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1166,7 +1166,20 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
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
+#ifdef CONFIG_NUMA
+check_reserve:
+#endif
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
@@ -2147,6 +2160,21 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
+#ifdef CONFIG_NUMA
+	if (mpol->mode == MPOL_PREFERRED_MANY) {
+		gfp_t gfp = gfp_mask | __GFP_NOWARN;
+
+		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
+		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
+		if (page) {
+			mpol_cond_put(mpol);
+			return page;
+		}
+
+		/* Fallback to all nodes */
+		nodemask = NULL;
+	}
+#endif
 	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
 	mpol_cond_put(mpol);
 
-- 
2.14.1

