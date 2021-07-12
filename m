Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E23C566B
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbhGLISS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 04:18:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:12162 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349123AbhGLINs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Jul 2021 04:13:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="190322254"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="190322254"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 01:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="459109365"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2021 01:09:48 -0700
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
Subject: [PATCH v6 3/6] mm/mempolicy: enable page allocation for MPOL_PREFERRED_MANY for general cases
Date:   Mon, 12 Jul 2021 16:09:31 +0800
Message-Id: <1626077374-81682-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
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

