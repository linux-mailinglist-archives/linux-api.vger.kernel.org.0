Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11133AC188
	for <lists+linux-api@lfdr.de>; Fri, 18 Jun 2021 05:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFRDrH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Jun 2021 23:47:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:1056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFRDrG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 Jun 2021 23:47:06 -0400
IronPort-SDR: Ltv0Y9oLvGAREHZi4ZJjP1sC0p4LUL0EqDrTaOdi0PwQpgWNxhi4xudVVDky6aO80TdGMjqpSa
 XoKoxM4hbb7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267636023"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267636023"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:44:57 -0700
IronPort-SDR: qre1y2t9vg8YJgpkUnAjXB2PyDD2TieBtFaqjrZwNpX7uwE4Asp0FAL2iItFqRdEwdrcEAWOyc
 vVNaUyf4WDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="485539825"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2021 20:44:54 -0700
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
Subject: [PATCH v5 -mm 2/6] mm/memplicy: add page allocation function for MPOL_PREFERRED_MANY policy
Date:   Fri, 18 Jun 2021 11:44:40 +0800
Message-Id: <1623987884-43576-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
References: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The semantics of MPOL_PREFERRED_MANY is similar to MPOL_PREFERRED,
that it will first try to allocate memory from the preferred node(s),
and fallback to all nodes in system when first try fails.

Add a dedicated function for it just like 'interleave' policy.

Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 17b5800b7dcc..d17bf018efcc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2153,6 +2153,25 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 	return page;
 }
 
+static struct page *alloc_page_preferred_many(gfp_t gfp, unsigned int order,
+						struct mempolicy *pol)
+{
+	struct page *page;
+
+	/*
+	 * This is a two pass approach. The first pass will only try the
+	 * preferred nodes but skip the direct reclaim and allow the
+	 * allocation to fail, while the second pass will try all the
+	 * nodes in system.
+	 */
+	page = __alloc_pages(((gfp | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM),
+				order, first_node(pol->nodes), &pol->nodes);
+	if (!page)
+		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
+
+	return page;
+}
+
 /**
  * alloc_pages_vma - Allocate a page for a VMA.
  * @gfp: GFP flags.
-- 
2.7.4

