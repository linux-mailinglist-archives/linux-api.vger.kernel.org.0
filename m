Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328DE466D53
	for <lists+linux-api@lfdr.de>; Thu,  2 Dec 2021 23:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbhLBW7D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Dec 2021 17:59:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58188 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhLBW7D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Dec 2021 17:59:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 394B2B8250A;
        Thu,  2 Dec 2021 22:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D48C53FD0;
        Thu,  2 Dec 2021 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638485738;
        bh=9JPXS6JB0sszCChpApl20tAYZRWpKBl+/3D7oa9tIZg=;
        h=Date:From:To:Subject:From;
        b=Ylk38iFza4s1DWD43kT/ThbYS2iIUiJj93pv86xJImFolxWkZ9WY+ns+mjEMQ90DG
         P5MKeoZCsZJ//+08aZNO8ri1fVIEH6l1tDU7ZC8dSeLWAdiUzk4s+5yyZplxSpUF5X
         JnGH6r0MSjhcUWTJODD4gFs1zCalVjOH98vlb9u8=
Date:   Thu, 02 Dec 2021 14:55:36 -0800
From:   akpm@linux-foundation.org
To:     aarcange@redhat.com, ak@linux.intel.com,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, mm-commits@vger.kernel.org,
        rdunlap@infradead.org, vbabka@suse.cz, ying.huang@intel.com
Subject:  +
 mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch added to
 -mm tree
Message-ID: <20211202225536.ARhuPP9Qk%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


The patch titled
     Subject: mm/mempolicy: use policy_node helper with MPOL_PREFERRED_MANY
has been added to the -mm tree.  Its filename is
     mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch

This patch should soon appear at
    https://ozlabs.org/~akpm/mmots/broken-out/mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch
and later at
    https://ozlabs.org/~akpm/mmotm/broken-out/mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next and is updated
there every 3-4 working days

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
@@ -2188,7 +2189,7 @@ struct page *alloc_pages(gfp_t gfp, unsi
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

mm-mempolicy-use-policy_node-helper-with-mpol_preferred_many.patch
mm-mempolicy-add-set_mempolicy_home_node-syscall.patch
mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch

