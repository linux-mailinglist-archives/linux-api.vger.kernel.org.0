Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4B3AC18A
	for <lists+linux-api@lfdr.de>; Fri, 18 Jun 2021 05:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFRDrL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Jun 2021 23:47:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:1056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhFRDrK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 Jun 2021 23:47:10 -0400
IronPort-SDR: u1sYw/vUODM0lHwXpK0Wh0CXq+4CmSgYW0r1kjLrKd9/B8BSc9343mLTqpsdQ+QZl0uibZs6bx
 lCsas/Wzoh2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267636033"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267636033"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:45:02 -0700
IronPort-SDR: APnfItg5ysWfcPVObQ0YruQPbopM7gCClGv2wkJQNQG0c8GwLD2o2wzOrRx+6Br9IzmfgHOfsl
 7csPe3W1MI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="485539846"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2021 20:44:57 -0700
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
Subject: [PATCH v5 -mm 3/6] mm/mempolicy: enable page allocation for MPOL_PREFERRED_MANY for general cases
Date:   Fri, 18 Jun 2021 11:44:41 +0800
Message-Id: <1623987884-43576-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
References: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

In order to support MPOL_PREFERRED_MANY which is used by
set_mempolicy(2), mbind(2), enable both alloc_pages() and
alloc_pages_vma() by using alloc_page_preferred_many().

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d17bf018efcc..9dce67fc9bb6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2207,6 +2207,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		goto out;
 	}
 
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		page = alloc_page_preferred_many(gfp, order, pol);
+		mpol_cond_put(pol);
+		goto out;
+	}
+
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
 		int hpage_node = node;
 
@@ -2286,6 +2292,8 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
+	else if (pol->mode == MPOL_PREFERRED_MANY)
+		page = alloc_page_preferred_many(gfp, order, pol);
 	else
 		page = __alloc_pages(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
-- 
2.7.4

