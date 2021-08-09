Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5872D3E3DFD
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 04:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhHICoz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 8 Aug 2021 22:44:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:40775 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhHICoz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 8 Aug 2021 22:44:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="201790018"
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="201790018"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2021 19:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="525015065"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2021 19:44:31 -0700
Date:   Mon, 9 Aug 2021 10:44:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <20210809024430.GA46432@shbuild999.sh.intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
 <YQ06tNiDEsvl8004@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ06tNiDEsvl8004@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michal,

Thanks for the review and ACKs to 1/5 and 2/5 patches.

On Fri, Aug 06, 2021 at 03:35:48PM +0200, Michal Hocko wrote:
> On Tue 03-08-21 13:59:20, Feng Tang wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > Implement the missing huge page allocation functionality while obeying
> > the preferred node semantics. This is similar to the implementation
> > for general page allocation, as it uses a fallback mechanism to try
> > multiple preferred nodes first, and then all other nodes.
> > 
> > [akpm: fix compling issue when merging with other hugetlb patch]
> > [Thanks to 0day bot for catching the missing #ifdef CONFIG_NUMA issue]
> > Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Co-developed-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> ifdefery is just ugly as hell. One way to get rid of that would be to
> provide a mpol_is_preferred_many() wrapper and hide the CONFIG_NUMA in
> mempolicy.h. I haven't checked but this might help to remove some other
> ifdefery as well.
> 
> I especially dislike the label hidden in the ifdef. You can get rid of
> that by checking the page for NULL.

Yes, the 'ifdef's were annoying to me too, and thanks for the suggestions.
Following is the revised patch upon the suggestion.

Thanks,
Feng

-------8<---------------------

From fc30718c40f02ba5ea73456af49173e66b5032c1 Mon Sep 17 00:00:00 2001
From: Ben Widawsky <ben.widawsky@intel.com>
Date: Thu, 5 Aug 2021 23:01:11 -0400
Subject: [PATCH] mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY

Implement the missing huge page allocation functionality while obeying the
preferred node semantics.  This is similar to the implementation for
general page allocation, as it uses a fallback mechanism to try multiple
preferred nodes first, and then all other nodes. 

To avoid adding too many "#ifdef CONFIG_NUMA" check, add a helper function
in mempolicy.h to check whether a mempolicy is MPOL_PREFERRED_MANY.

[akpm: fix compling issue when merging with other hugetlb patch]
[Thanks to 0day bot for catching the !CONFIG_NUMA compiling issue]
[Michal Hocko: suggest to remove the #ifdef CONFIG_NUMA check]
Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
Link: https://lkml.kernel.org/r/1627970362-61305-4-git-send-email-feng.tang@intel.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Co-developed-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
--
 include/linux/mempolicy.h | 12 ++++++++++++
 mm/hugetlb.c              | 28 ++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 0117e1e..60d5e6c 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -187,6 +187,12 @@ extern void mpol_put_task_policy(struct task_struct *);
 
 extern bool numa_demotion_enabled;
 
+static inline bool mpol_is_preferred_many(struct mempolicy *pol)
+{
+	return  (pol->mode == MPOL_PREFERRED_MANY);
+}
+
+
 #else
 
 struct mempolicy {};
@@ -297,5 +303,11 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 }
 
 #define numa_demotion_enabled	false
+
+static inline bool mpol_is_preferred_many(struct mempolicy *pol)
+{
+	return  false;
+}
+
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95714fb..75ea8bc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1145,7 +1145,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1166,7 +1166,17 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+
+	if (mpol_is_preferred_many(mpol)) {
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+
+		/* Fallback to all nodes if page==NULL */
+		nodemask = NULL;
+	}
+
+	if (!page)
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
@@ -2147,9 +2157,19 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
-	mpol_cond_put(mpol);
+	if (mpol_is_preferred_many(mpol)) {
+		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
+		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
+		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
+
+		/* Fallback to all nodes if page==NULL */
+		nodemask = NULL;
+	}
+
+	if (!page)
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
+	mpol_cond_put(mpol);
 	return page;
 }
 
-- 
2.7.4


