Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39833E2B5B
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbhHFN3i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 09:29:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbhHFN3e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 09:29:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B36A21D16;
        Fri,  6 Aug 2021 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628256557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lpd8JDyRI7Mzv/OFJRWjI862VhZ/EWEqVLAjRNNmn+U=;
        b=bVRjC/oHFsTNcAEJ5Tj1qtx6fWLKYjufG84wu3UdXVyN5Qv3VEpU0S6PN8b7NMjCXorVNi
        t7O3OYKhdxklQtA0uUyB+77jjR1RRvATdz1svtjIgjZok8KK3LR1+VTJQB4R+Uq19aSJY5
        +EcOAQDreRORQTWOMK9dI5x1TgoWI+w=
Received: from suse.cz (mhocko.udp.ovpn2.prg.suse.de [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FF1CA3B85;
        Fri,  6 Aug 2021 13:29:17 +0000 (UTC)
Date:   Fri, 6 Aug 2021 15:29:16 +0200
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
Subject: Re: [PATCH v7 2/5] mm/memplicy: add page allocation function for
 MPOL_PREFERRED_MANY policy
Message-ID: <YQ05LPUeNFlOdMYj@dhcp22.suse.cz>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627970362-61305-3-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 03-08-21 13:59:19, Feng Tang wrote:
> The semantics of MPOL_PREFERRED_MANY is similar to MPOL_PREFERRED,
> that it will first try to allocate memory from the preferred node(s),
> and fallback to all nodes in system when first try fails.
> 
> Add a dedicated function alloc_pages_preferred_many() for it just
> like for 'interleave' policy, which will be used by 2 general
> memoory allocation APIs: alloc_pages() and alloc_pages_vma()
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Originally-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/mempolicy.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 72f7ff760989..a00bb1c48a15 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2166,6 +2166,27 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
>  	return page;
>  }
>  
> +static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
> +						int nid, struct mempolicy *pol)
> +{
> +	struct page *page;
> +	gfp_t preferred_gfp;
> +
> +	/*
> +	 * This is a two pass approach. The first pass will only try the
> +	 * preferred nodes but skip the direct reclaim and allow the
> +	 * allocation to fail, while the second pass will try all the
> +	 * nodes in system.
> +	 */
> +	preferred_gfp = gfp | __GFP_NOWARN;
> +	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> +	page = __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
> +	if (!page)
> +		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
> +
> +	return page;
> +}
> +
>  /**
>   * alloc_pages_vma - Allocate a page for a VMA.
>   * @gfp: GFP flags.
> @@ -2201,6 +2222,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		goto out;
>  	}
>  
> +	if (pol->mode == MPOL_PREFERRED_MANY) {
> +		page = alloc_pages_preferred_many(gfp, order, node, pol);
> +		mpol_cond_put(pol);
> +		goto out;
> +	}
> +
>  	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
>  		int hpage_node = node;
>  
> @@ -2278,6 +2305,9 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
>  	 */
>  	if (pol->mode == MPOL_INTERLEAVE)
>  		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
> +	else if (pol->mode == MPOL_PREFERRED_MANY)
> +		page = alloc_pages_preferred_many(gfp, order,
> +				numa_node_id(), pol);
>  	else
>  		page = __alloc_pages(gfp, order,
>  				policy_node(gfp, pol, numa_node_id()),
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs
