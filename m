Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C543D8E0E
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhG1Mmb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 08:42:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39930 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhG1Mma (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 08:42:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A6BA1FF9B;
        Wed, 28 Jul 2021 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627476147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qE0e4wOwIM2Ykf5ORgyVCo3+kxWcajIMYmHfIA6nLmQ=;
        b=ntohU5YhnPckBDLRXy7jZyMABFIfjgtUiUSE+YSbG3Xy3cFXp6gLSSRYbXjtHRMsv68cT9
        aA+XbhgIsRwtoVAgIiH72jPBHGRTZEWXkNim1tSR7v2W9KDF0vqslft7+NnEDkYdctGdkY
        wnFQaT9K3yli+1v+FyncTDMcP0GMbyE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4EB51A3B83;
        Wed, 28 Jul 2021 12:42:27 +0000 (UTC)
Date:   Wed, 28 Jul 2021 14:42:26 +0200
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
Subject: Re: [PATCH v6 2/6] mm/memplicy: add page allocation function for
 MPOL_PREFERRED_MANY policy
Message-ID: <YQFQsnSt/DaWoQHV@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626077374-81682-3-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 12-07-21 16:09:30, Feng Tang wrote:
> The semantics of MPOL_PREFERRED_MANY is similar to MPOL_PREFERRED,
> that it will first try to allocate memory from the preferred node(s),
> and fallback to all nodes in system when first try fails.
> 
> Add a dedicated function for it just like 'interleave' policy.
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

It would be better to squash this together with the actual user of the
function added by the next patch.

> ---
>  mm/mempolicy.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 17b5800b7dcc..d17bf018efcc 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2153,6 +2153,25 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
>  	return page;
>  }
>  
> +static struct page *alloc_page_preferred_many(gfp_t gfp, unsigned int order,
> +						struct mempolicy *pol)

We likely want a node parameter to know which one we want to start with
for locality. Callers should use policy_node for that.

> +{
> +	struct page *page;
> +
> +	/*
> +	 * This is a two pass approach. The first pass will only try the
> +	 * preferred nodes but skip the direct reclaim and allow the
> +	 * allocation to fail, while the second pass will try all the
> +	 * nodes in system.
> +	 */
> +	page = __alloc_pages(((gfp | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM),
> +				order, first_node(pol->nodes), &pol->nodes);

Although most users will likely have some form of GFP_*USER* here and
clearing __GFP_DIRECT_RECLAIM will put all other reclaim modifiers out
of game I think it would be better to explicitly disable some of them to
prevent from surprises. E.g. any potential __GFP_NOFAIL would be more
than surprising here. We do not have any (hopefully) but this should be
pretty cheap to exclude as we already have to modify already.

	preferred_gfp = gfp | __GFP_NOWARN;
	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL)


> +	if (!page)
> +		page = __alloc_pages(gfp, order, numa_node_id(), NULL);
> +
> +	return page;
> +}
> +
>  /**
>   * alloc_pages_vma - Allocate a page for a VMA.
>   * @gfp: GFP flags.
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
