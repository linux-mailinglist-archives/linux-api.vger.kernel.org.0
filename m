Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8953D8DDA
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 14:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhG1MbH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 08:31:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48438 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhG1MbG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 08:31:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6277922314;
        Wed, 28 Jul 2021 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627475464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npMFGiRKpe9E2NAzxS4y+5J6eprtxsqTY9vAsITRMUg=;
        b=grWfSWG5enS6L02jqEBUn/cVF8gY3gQ3BR/4ugX8P8YwDZw4VnyA+reyvLfcyqIgY4MIpT
        0MJ3wYrCYgUP+x91sRjSi6f5dMTVuwsiNqWRFiTLidGMb7HGnVyjgfrQgLS49ehsYtzyir
        CmoaE91Mp8qa0YNxL6qXl30SHvYJJHE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1EE79A3B81;
        Wed, 28 Jul 2021 12:31:04 +0000 (UTC)
Date:   Wed, 28 Jul 2021 14:31:03 +0200
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626077374-81682-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Sorry for a late review]

On Mon 12-07-21 16:09:29, Feng Tang wrote:
[...]
> @@ -1887,7 +1909,8 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>  /* Return the node id preferred by the given mempolicy, or the given id */
>  static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
>  {
> -	if (policy->mode == MPOL_PREFERRED) {
> +	if (policy->mode == MPOL_PREFERRED ||
> +	    policy->mode == MPOL_PREFERRED_MANY) {
>  		nd = first_node(policy->nodes);
>  	} else {
>  		/*

Do we really want to have the preferred node to be always the first node
in the node mask? Shouldn't that strive for a locality as well? Existing
callers already prefer numa_node_id() - aka local node - and I belive we
shouldn't just throw that away here.

> @@ -1931,6 +1954,7 @@ unsigned int mempolicy_slab_node(void)
>  
>  	switch (policy->mode) {
>  	case MPOL_PREFERRED:
> +	case MPOL_PREFERRED_MANY:
>  		return first_node(policy->nodes);

Similarly here but I am not really familiar with the slab numa code
enough to have strong opinions here.

> @@ -2173,10 +2198,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		 * node and don't fall back to other nodes, as the cost of
>  		 * remote accesses would likely offset THP benefits.
>  		 *
> -		 * If the policy is interleave, or does not allow the current
> -		 * node in its nodemask, we allocate the standard way.
> +		 * If the policy is interleave or multiple preferred nodes, or
> +		 * does not allow the current node in its nodemask, we allocate
> +		 * the standard way.
>  		 */
> -		if (pol->mode == MPOL_PREFERRED)
> +		if ((pol->mode == MPOL_PREFERRED ||
> +		     pol->mode == MPOL_PREFERRED_MANY))
>  			hpage_node = first_node(pol->nodes);

Same here.

> @@ -2451,6 +2479,9 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  		break;
>  
>  	case MPOL_PREFERRED:
> +	case MPOL_PREFERRED_MANY:
> +		if (node_isset(curnid, pol->nodes))
> +			goto out;
>  		polnid = first_node(pol->nodes);
>  		break;

I do not follow what is the point of using first_node here. Either the
node is in the mask or it is misplaced. What are you trying to achieve
here?
-- 
Michal Hocko
SUSE Labs
