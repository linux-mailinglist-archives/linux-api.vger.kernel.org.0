Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C73E2B73
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbhHFNgK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 09:36:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51718 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhHFNgI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 09:36:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1290A21F91;
        Fri,  6 Aug 2021 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628256952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE3Uk/UgQFDJwZHbh1+RL0Led8QeXNn8UlO09LuvY6U=;
        b=fiYr6g9t/DoJEyJF5CFB7zTZUyIAEfgvQ/bWOoomvQ4cGuOm9BM6a2tDqReI/4GvbSMXuZ
        hXyEDfPhJC34DRxbHFUjvKgZaGd/Qk9KAGxh6nbL2qjiWAsY6XnWHy2GyolEy2kSm8Ydtg
        6yYynAI7nKqmXwjrE37BErnSRIGMhnc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D35C5A3B8A;
        Fri,  6 Aug 2021 13:35:51 +0000 (UTC)
Date:   Fri, 6 Aug 2021 15:35:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <YQ06tNiDEsvl8004@dhcp22.suse.cz>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627970362-61305-4-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 03-08-21 13:59:20, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Implement the missing huge page allocation functionality while obeying
> the preferred node semantics. This is similar to the implementation
> for general page allocation, as it uses a fallback mechanism to try
> multiple preferred nodes first, and then all other nodes.
> 
> [akpm: fix compling issue when merging with other hugetlb patch]
> [Thanks to 0day bot for catching the missing #ifdef CONFIG_NUMA issue]
> Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

ifdefery is just ugly as hell. One way to get rid of that would be to
provide a mpol_is_preferred_many() wrapper and hide the CONFIG_NUMA in
mempolicy.h. I haven't checked but this might help to remove some other
ifdefery as well.

I especially dislike the label hidden in the ifdef. You can get rid of
that by checking the page for NULL.

> ---
>  mm/hugetlb.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95714fb28150..9279f6d478d9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1166,7 +1166,20 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  
>  	gfp_mask = htlb_alloc_mask(h);
>  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> +#ifdef CONFIG_NUMA
> +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> +		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +		if (page)
> +			goto check_reserve;
> +		/* Fallback to all nodes */
> +		nodemask = NULL;
> +	}
> +#endif
>  	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +
> +#ifdef CONFIG_NUMA
> +check_reserve:
> +#endif
>  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
>  		SetHPageRestoreReserve(page);
>  		h->resv_huge_pages--;
> @@ -2147,6 +2160,21 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  	nodemask_t *nodemask;
>  
>  	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
> +#ifdef CONFIG_NUMA
> +	if (mpol->mode == MPOL_PREFERRED_MANY) {
> +		gfp_t gfp = gfp_mask | __GFP_NOWARN;
> +
> +		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> +		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
> +		if (page) {
> +			mpol_cond_put(mpol);
> +			return page;
> +		}
> +
> +		/* Fallback to all nodes */
> +		nodemask = NULL;
> +	}
> +#endif
>  	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
>  	mpol_cond_put(mpol);
>  
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs
