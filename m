Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6054D3D1FAA
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 10:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhGVHaw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 03:30:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:55161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGVHav (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 22 Jul 2021 03:30:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="233404455"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="233404455"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 01:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="scan'208";a="501660028"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jul 2021 01:11:22 -0700
Date:   Thu, 22 Jul 2021 16:11:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v6 4/6] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <20210722081122.GA2169@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-5-git-send-email-feng.tang@intel.com>
 <7cdf88d8-9eea-5547-ee77-7d46829bf2dd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdf88d8-9eea-5547-ee77-7d46829bf2dd@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Mike,

On Wed, Jul 21, 2021 at 01:49:15PM -0700, Mike Kravetz wrote:
> On 7/12/21 1:09 AM, Feng Tang wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > Implement the missing huge page allocation functionality while obeying
> > the preferred node semantics. This is similar to the implementation
> > for general page allocation, as it uses a fallback mechanism to try
> > multiple preferred nodes first, and then all other nodes.
> > 
> > [Thanks to 0day bot for caching the missing #ifdef CONFIG_NUMA issue]
> > 
> > Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Co-developed-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/hugetlb.c   | 25 +++++++++++++++++++++++++
> >  mm/mempolicy.c |  3 ++-
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 924553aa8f78..3e84508c1b8c 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1164,7 +1164,18 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
> >  
> >  	gfp_mask = htlb_alloc_mask(h);
> >  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> > +#ifdef CONFIG_NUMA
> > +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> > +		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> > +		if (page)
> > +			goto check_reserve;
> > +		/* Fallback to all nodes */
> > +		nodemask = NULL;
> > +	}
> > +#endif
> >  	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> > +
> > +check_reserve:
> >  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> >  		SetHPageRestoreReserve(page);
> >  		h->resv_huge_pages--;
> > @@ -2095,6 +2106,20 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
> >  	nodemask_t *nodemask;
> >  
> >  	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
> > +#ifdef CONFIG_NUMA
> > +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> > +		gfp_t gfp = (gfp_mask | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM;
> 
> I believe __GFP_NOWARN will be added later in alloc_buddy_huge_page, so
> no need to add here?

Thanks for the suggestion, will remove it. 

> > +
> > +		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
> > +		if (page) {
> > +			mpol_cond_put(mpol);
> > +			return page;
> > +		}
> > +
> > +		/* Fallback to all nodes */
> > +		nodemask = NULL;
> > +	}
> > +#endif
> >  	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
> >  	mpol_cond_put(mpol);
> >  
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 9dce67fc9bb6..93f8789758a7 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2054,7 +2054,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
> >  					huge_page_shift(hstate_vma(vma)));
> >  	} else {
> >  		nid = policy_node(gfp_flags, *mpol, numa_node_id());
> > -		if ((*mpol)->mode == MPOL_BIND)
> > +		if ((*mpol)->mode == MPOL_BIND ||
> > +		    (*mpol)->mode == MPOL_PREFERRED_MANY)
> >  			*nodemask = &(*mpol)->nodes;
> >  	}
> >  	return nid;
> > 
> 
> Other than the one nit above,
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!



Andrew,

I have to ask for your help again to fold this to the 4/6 patch, thanks!

- Feng

---------------------------8<--------------------------------------------

From de1cd29d8da96856a6d754a30a4c7585d87b8348 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Thu, 22 Jul 2021 16:00:49 +0800
Subject: [PATCH] mm/hugetlb: remove the unneeded __GFP_NOWARN flag setting

As the alloc_buddy_huge_page() will set it anyway.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 528947d..a96e283 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2162,9 +2162,9 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
 #ifdef CONFIG_NUMA
 	if (mpol->mode == MPOL_PREFERRED_MANY) {
-		gfp_t gfp = (gfp_mask | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM;
-
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h,
+					gfp_mask & ~__GFP_DIRECT_RECLAIM,
+					nid, nodemask, false);
 		if (page) {
 			mpol_cond_put(mpol);
 			return page;
-- 
2.7.4

