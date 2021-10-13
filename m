Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4142BD65
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 12:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJMKol (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 06:44:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhJMKoi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 06:44:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8FEF222F0;
        Wed, 13 Oct 2021 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634121754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1CHTvdF544ivd1Oo7Fv2dEr1vmP+UN6neItO/ose08=;
        b=NzuqaGhsaCQvdwPYQmX+rtzyb3tRrzPrApQdhGXwjFB26+GMfPdyarjWoP8c0BEgielXJI
        +v2HGCXgqx2a4c3CrlvZ3SWxgjeOEfQMLbAM0ODw6PAKDBcKqw0deKQhXqrcwnupF0b7At
        y1z5yxsAmeO/jAxSCiwhHIJGTLIh3Q0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22A2DA3B84;
        Wed, 13 Oct 2021 10:42:34 +0000 (UTC)
Date:   Wed, 13 Oct 2021 12:42:30 +0200
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
Subject: Re: [RFC PATCH] mm/mempolicy: add MPOL_PREFERRED_STRICT  memory
 policy
Message-ID: <YWa4FoicH0VztGTl@dhcp22.suse.cz>
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api]

On Wed 13-10-21 15:15:39, Aneesh Kumar K.V wrote:
> This mempolicy mode can be used with either the set_mempolicy(2)
> or mbind(2) interfaces.  Like the MPOL_PREFERRED interface, it
> allows an application to set a preference node from which the kernel
> will fulfill memory allocation requests. Unlike the MPOL_PREFERRED mode,
> it takes a set of nodes. The nodes in the nodemask are used as fallback
> allocation nodes if memory is not available on the preferred node.
> Unlike MPOL_PREFERRED_MANY, it will not fall back memory allocations
> to all nodes in the system. Like the MPOL_BIND interface, it works over a
> set of nodes and will cause a SIGSEGV or invoke the OOM killer if
> memory is not available on those preferred nodes.
> 
> This patch helps applications to hint a memory allocation preference node
> and fallback to _only_ a set of nodes if the memory is not available
> on the preferred node.  Fallback allocation is attempted from the node which is
> nearest to the preferred node.
> 
> This new memory policy helps applications to have explicit control on slow
> memory allocation and avoids default fallback to slow memory NUMA nodes.
> The difference with MPOL_BIND is the ability to specify a preferred node
> which is the first node in the nodemask argument passed.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>b
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  .../admin-guide/mm/numa_memory_policy.rst     |  7 +++
>  include/uapi/linux/mempolicy.h                |  1 +
>  mm/mempolicy.c                                | 43 +++++++++++++++++--
>  3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index 64fd0ba0d057..4dfdcbd22d67 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -252,6 +252,13 @@ MPOL_PREFERRED_MANY
>  	can fall back to all existing numa nodes. This is effectively
>  	MPOL_PREFERRED allowed for a mask rather than a single node.
>  
> +MPOL_PREFERRED_STRICT
> +	This mode specifies that the allocation should be attempted
> +	from the first node specified in the nodemask of the policy.
> +	If that allocation fails, the kernel will search other nodes
> +	in the nodemask, in order of increasing distance from the
> +	preferred node based on information provided by the platform firmware.
> +
>  NUMA memory policy supports the following optional mode flags:
>  
>  MPOL_F_STATIC_NODES
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 046d0ccba4cd..8aa1d1963235 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -23,6 +23,7 @@ enum {
>  	MPOL_INTERLEAVE,
>  	MPOL_LOCAL,
>  	MPOL_PREFERRED_MANY,
> +	MPOL_PREFERRED_STRICT,
>  	MPOL_MAX,	/* always last member of enum */
>  };
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1592b081c58e..59080dd1ea69 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -407,6 +407,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  		.create = mpol_new_nodemask,
>  		.rebind = mpol_rebind_preferred,
>  	},
> +	[MPOL_PREFERRED_STRICT] = {
> +		.create = mpol_new_nodemask,
> +		.rebind = mpol_rebind_preferred,
> +	},
>  };
>  
>  static int migrate_page_add(struct page *page, struct list_head *pagelist,
> @@ -900,6 +904,7 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_PREFERRED_STRICT:
>  		*nodes = p->nodes;
>  		break;
>  	case MPOL_LOCAL:
> @@ -1781,7 +1786,7 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>  		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
>  		return &policy->nodes;
>  
> -	if (mode == MPOL_PREFERRED_MANY)
> +	if (mode == MPOL_PREFERRED_MANY || mode == MPOL_PREFERRED_STRICT)
>  		return &policy->nodes;
>  
>  	return NULL;
> @@ -1796,7 +1801,7 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>   */
>  static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
>  {
> -	if (policy->mode == MPOL_PREFERRED) {
> +	if (policy->mode == MPOL_PREFERRED || policy->mode == MPOL_PREFERRED_STRICT) {
>  		nd = first_node(policy->nodes);
>  	} else {
>  		/*
> @@ -1840,6 +1845,7 @@ unsigned int mempolicy_slab_node(void)
>  
>  	switch (policy->mode) {
>  	case MPOL_PREFERRED:
> +	case MPOL_PREFERRED_STRICT:
>  		return first_node(policy->nodes);
>  
>  	case MPOL_INTERLEAVE:
> @@ -1952,7 +1958,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
>  					huge_page_shift(hstate_vma(vma)));
>  	} else {
>  		nid = policy_node(gfp_flags, *mpol, numa_node_id());
> -		if (mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY)
> +		if (mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY ||
> +			mode == MPOL_PREFERRED_STRICT)
>  			*nodemask = &(*mpol)->nodes;
>  	}
>  	return nid;
> @@ -1986,6 +1993,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  	switch (mempolicy->mode) {
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_PREFERRED_STRICT:
>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
>  		*mask = mempolicy->nodes;
> @@ -2072,6 +2080,23 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
>  	return page;
>  }
>  
> +static struct page *alloc_pages_preferred_strict(gfp_t gfp, unsigned int order,
> +						 struct mempolicy *pol)
> +{
> +	int nid;
> +	gfp_t preferred_gfp;
> +
> +	/*
> +	 * With MPOL_PREFERRED_STRICT first node in the policy nodemask
> +	 * is picked as the preferred node id and the fallback allocation
> +	 * is still restricted to the preferred nodes in the nodemask.
> +	 */
> +	preferred_gfp = gfp | __GFP_NOWARN;
> +	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> +	nid = first_node(pol->nodes);
> +	return __alloc_pages(preferred_gfp, order, nid, &pol->nodes);
> +}
> +
>  /**
>   * alloc_pages_vma - Allocate a page for a VMA.
>   * @gfp: GFP flags.
> @@ -2113,6 +2138,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		goto out;
>  	}
>  
> +	if (pol->mode == MPOL_PREFERRED_STRICT) {
> +		page = alloc_pages_preferred_strict(gfp, order, pol);
> +		mpol_cond_put(pol);
> +		goto out;
> +	}
> +
>  	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
>  		int hpage_node = node;
>  
> @@ -2193,6 +2224,8 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
>  	else if (pol->mode == MPOL_PREFERRED_MANY)
>  		page = alloc_pages_preferred_many(gfp, order,
>  				numa_node_id(), pol);
> +	else if (pol->mode == MPOL_PREFERRED_STRICT)
> +		page = alloc_pages_preferred_strict(gfp, order, pol);
>  	else
>  		page = __alloc_pages(gfp, order,
>  				policy_node(gfp, pol, numa_node_id()),
> @@ -2265,6 +2298,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  	case MPOL_INTERLEAVE:
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_PREFERRED_STRICT:
>  		return !!nodes_equal(a->nodes, b->nodes);
>  	case MPOL_LOCAL:
>  		return true;
> @@ -2405,6 +2439,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  		break;
>  
>  	case MPOL_PREFERRED:
> +	case MPOL_PREFERRED_STRICT:
>  		if (node_isset(curnid, pol->nodes))
>  			goto out;
>  		polnid = first_node(pol->nodes);
> @@ -2866,6 +2901,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>  			err = 0;
>  		goto out;
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_PREFERRED_STRICT:
>  	case MPOL_BIND:
>  		/*
>  		 * Insist on a nodelist
> @@ -2953,6 +2989,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  		break;
>  	case MPOL_PREFERRED:
>  	case MPOL_PREFERRED_MANY:
> +	case MPOL_PREFERRED_STRICT:
>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
>  		nodes = pol->nodes;
> -- 
> 2.31.1

-- 
Michal Hocko
SUSE Labs
