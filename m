Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123344955F0
	for <lists+linux-api@lfdr.de>; Thu, 20 Jan 2022 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377868AbiATV1J (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jan 2022 16:27:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37628 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377867AbiATV1J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jan 2022 16:27:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C548760018;
        Thu, 20 Jan 2022 21:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA27C340E0;
        Thu, 20 Jan 2022 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1642714028;
        bh=uYKv82VENbhToK51CZ3LL2/11hT3VtmCN1kHzWHvC4Y=;
        h=Date:From:To:Subject:From;
        b=B8UxvEGmCnxO2p6D9OxbtthovuFY88SdqbQfb8iqHI3sYkemKVhYuoTqGtSQ/5NeO
         ngarIg2rfo7P2utntdfXpipCeldRWgodwM8O0QsGVpJf4oZ2eeVX0vfk3FVP0apKbX
         CJvMEVYZE7xLColhYUWol5voWoWSNIt+D+KnCqPk=
Date:   Thu, 20 Jan 2022 13:27:07 -0800
From:   akpm@linux-foundation.org
To:     aarcange@redhat.com, ak@linux.intel.com,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, vbabka@suse.cz, ying.huang@intel.com
Subject:  [merged]
 mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch removed
 from -mm tree
Message-ID: <20220120212707.ne31f9EwI%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


The patch titled
     Subject: mm/mempolicy: use policy_node helper with MPOL_PREFERRED_MANY
has been removed from the -mm tree.  Its filename was
     mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
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

Patches currently in -mm which might be from aneesh.kumar@linux.ibm.com are


