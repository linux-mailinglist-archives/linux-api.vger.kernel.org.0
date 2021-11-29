Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57D84611E4
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 11:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhK2KR6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 05:17:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45282 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhK2KP5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 05:15:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 96044212B8;
        Mon, 29 Nov 2021 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638180759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pA9YqZ69k2RDZMsosyr11zY9Syhy5lnsxy3Oc3i5Y5k=;
        b=iX+WLZUWByNymOPWSVc83MyyEaAgZtjx5iUvL8h8YKUEgMzsA/1nA+AR8XFowHcNjx47yy
        mOhXT7wgLoUrBCHiBSyOpmCQLd9hvSdfBrfCD7XbW+YMrHJqtc37sgle71KMKtp/IA7scl
        eCycsfkqpkOO7b6rs7f8xHFi45KzcCE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 677B2A3B83;
        Mon, 29 Nov 2021 10:12:39 +0000 (UTC)
Date:   Mon, 29 Nov 2021 11:12:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: [PATCH 4/3] mm: drop node from alloc_pages_vma
Message-ID: <YaSnlv4QpryEpesG@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116064238.727454-2-aneesh.kumar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

alloc_pages_vma is meant to allocate a page with a vma specific memory
policy. The initial node parameter is always a local node so it is
pointless to waste a function argument for this. Drop the parameter.

Signed-off-by: Michal Hocko <mhocko@suse.com>

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b976c4177299..2ffca4f65687 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -598,9 +598,9 @@ struct page *alloc_pages(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc(gfp_t gfp, unsigned order);
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
-			int node, bool hugepage);
+			bool hugepage);
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
-	alloc_pages_vma(gfp_mask, order, vma, addr, numa_node_id(), true)
+	alloc_pages_vma(gfp_mask, order, vma, addr, true)
 #else
 static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
@@ -610,14 +610,14 @@ static inline struct folio *folio_alloc(gfp_t gfp, unsigned int order)
 {
 	return __folio_alloc_node(gfp, order, numa_node_id());
 }
-#define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
+#define alloc_pages_vma(gfp_mask, order, vma, addr, false)\
 	alloc_pages(gfp_mask, order)
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
 	alloc_pages(gfp_mask, order)
 #endif
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 #define alloc_page_vma(gfp_mask, vma, addr)			\
-	alloc_pages_vma(gfp_mask, 0, vma, addr, numa_node_id(), false)
+	alloc_pages_vma(gfp_mask, 0, vma, addr, false)
 
 extern unsigned long __get_free_pages(gfp_t gfp_mask, unsigned int order);
 extern unsigned long get_zeroed_page(gfp_t gfp_mask);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cdd6430932d1..b66e9bdfed66 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2143,9 +2143,10 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
  * Return: The page on success or NULL if allocation fails.
  */
 struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr, int node, bool hugepage)
+		unsigned long addr, bool hugepage)
 {
 	struct mempolicy *pol;
+	int node = numa_node_id();
 	struct page *page;
 	int preferred_nid;
 	nodemask_t *nmask;
diff --git a/mm/shmem.c b/mm/shmem.c
index dc038ce78700..2d81f8d512d5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1559,8 +1559,7 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 		return NULL;
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
-	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
-			       true);
+	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, true);
 	shmem_pseudo_vma_destroy(&pvma);
 	if (page)
 		prep_transhuge_page(page);
-- 
Michal Hocko
SUSE Labs
