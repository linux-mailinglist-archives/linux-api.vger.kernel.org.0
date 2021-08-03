Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78773DE67B
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 07:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhHCF7u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 01:59:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:34927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233749AbhHCF7q (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Aug 2021 01:59:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235529243"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="235529243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 22:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="479233337"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2021 22:59:31 -0700
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
Subject: [PATCH v7 2/5] mm/memplicy: add page allocation function for MPOL_PREFERRED_MANY policy
Date:   Tue,  3 Aug 2021 13:59:19 +0800
Message-Id: <1627970362-61305-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The semantics of MPOL_PREFERRED_MANY is similar to MPOL_PREFERRED,
that it will first try to allocate memory from the preferred node(s),
and fallback to all nodes in system when first try fails.

Add a dedicated function alloc_pages_preferred_many() for it just
like for 'interleave' policy, which will be used by 2 general
memoory allocation APIs: alloc_pages() and alloc_pages_vma()

Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Originally-by: Ben Widawsky <ben.widawsky@intel.com>
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 72f7ff760989..a00bb1c48a15 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2166,6 +2166,27 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 	return page;
 }
 
+static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
+						int nid, struct mempolicy *pol)
+{
+	struct page *page;
+	gfp_t preferred_gfp;
+
+	/*
+	 * This is a two pass approach. The first pass will only try the
+	 * preferred nodes but skip the direct reclaim and allow the
+	 * allocation to fail, while the second pass will try all the
+	 * nodes in system.
+	 */
+	preferred_gfp = gfp | __GFP_NOWARN;
+	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
+	page = __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
+	if (!page)
+		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
+
+	return page;
+}
+
 /**
  * alloc_pages_vma - Allocate a page for a VMA.
  * @gfp: GFP flags.
@@ -2201,6 +2222,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		page = alloc_pages_preferred_many(gfp, order, node, pol);
+		mpol_cond_put(pol);
+		goto out;
+	}
+
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
 		int hpage_node = node;
 
@@ -2278,6 +2305,9 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
+	else if (pol->mode == MPOL_PREFERRED_MANY)
+		page = alloc_pages_preferred_many(gfp, order,
+				numa_node_id(), pol);
 	else
 		page = __alloc_pages(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
-- 
2.14.1

