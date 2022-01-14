Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6548F241
	for <lists+linux-api@lfdr.de>; Fri, 14 Jan 2022 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiANWIT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jan 2022 17:08:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiANWIR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jan 2022 17:08:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74A0FB8262E;
        Fri, 14 Jan 2022 22:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF92BC36AE5;
        Fri, 14 Jan 2022 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1642198095;
        bh=ZbCchHDUPBb6OYDDv+U+Z5Qx/7yv5P7aY7rSX3YQsHc=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=qMkOv4HRiqzQVJ/4iNU5zcQbSsEMambZ0Y5GRW14MooyQHgzsgxsmv6/XE4sts3El
         C5Z/QEeZxIvcSHAjEKv3E1fMVpYfz5vmIpTaIJb34z9dp0Pqd8qtF0ln4Z1qhy9vlS
         QkajX+71dMS7ocL4DmDWGsmFgqOfY21ZPPmrj2kg=
Date:   Fri, 14 Jan 2022 14:08:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, torvalds@linux-foundation.org,
        vbabka@suse.cz, ying.huang@intel.com
Subject:  [patch 096/146] mm/mempolicy: use policy_node helper with
 MPOL_PREFERRED_MANY
Message-ID: <20220114220814.xl_k70knk%akpm@linux-foundation.org>
In-Reply-To: <20220114140222.6b14f0061194d3200000c52d@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: mm/mempolicy: use policy_node helper with MPOL_PREFERRED_MANY

Patch series "mm: add new syscall set_mempolicy_home_node", v6.


This patch (of 3):

A followup patch will enable setting a home node with MPOL_PREFERRED_MANY
memory policy.  To facilitate that switch to using policy_node helper. 
There is no functional change in this patch.

Link: https://lkml.kernel.org/r/20211202123810.267175-1-aneesh.kumar@linux.ibm.com
Link: https://lkml.kernel.org/r/20211202123810.267175-2-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: <linux-api@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mempolicy.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/mm/mempolicy.c~mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many
+++ a/mm/mempolicy.c
@@ -2062,7 +2062,7 @@ static struct page *alloc_pages_preferre
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 	page = __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
 	if (!page)
-		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
+		page = __alloc_pages(gfp, order, nid, NULL);
 
 	return page;
 }
@@ -2104,6 +2104,7 @@ struct page *alloc_pages_vma(gfp_t gfp,
 	}
 
 	if (pol->mode == MPOL_PREFERRED_MANY) {
+		node = policy_node(gfp, pol, node);
 		page = alloc_pages_preferred_many(gfp, order, node, pol);
 		mpol_cond_put(pol);
 		goto out;
@@ -2187,7 +2188,7 @@ struct page *alloc_pages(gfp_t gfp, unsi
 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
 	else if (pol->mode == MPOL_PREFERRED_MANY)
 		page = alloc_pages_preferred_many(gfp, order,
-				numa_node_id(), pol);
+				  policy_node(gfp, pol, numa_node_id()), pol);
 	else
 		page = __alloc_pages(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
_
