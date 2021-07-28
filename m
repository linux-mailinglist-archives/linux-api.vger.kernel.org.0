Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A433D8E45
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhG1Mvq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 08:51:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42398 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG1Mvp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 08:51:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 87E4A1FFA6;
        Wed, 28 Jul 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627476703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N760nZXvzpnDdyilSPHJO7qHvhAQ/EWT5M2KTQvmNio=;
        b=L9ooC+Cid5z+SAxxhYycJx8a1SyFK/P4dXwd1vPVmHKHVmfUi5JgXDVje5P0uejK8KbYtF
        kbvnl0e4WiWdBZaOGbdJkZ1SRSCyUD00WW/dya+zf1NZu6PyoU65kvo8pa6lCW2rYQPnRs
        hi/24Gokpq0kZUKt+jreVX/3avsmNfs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F831A3B88;
        Wed, 28 Jul 2021 12:51:43 +0000 (UTC)
Date:   Wed, 28 Jul 2021 14:51:42 +0200
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
Subject: Re: [PATCH v6 6/6] mm/mempolicy: unify the create() func for
 bind/interleave/prefer-many policies
Message-ID: <YQFS3uZEQvPQ9y8Z@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-7-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626077374-81682-7-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 12-07-21 16:09:34, Feng Tang wrote:
> As they all do the same thing: sanity check and save nodemask info, create
> one mpol_new_nodemask() to reduce redundancy.

Do we really need a create() callback these days?

> Signed-off-by: Feng Tang <feng.tang@intel.com>

Other than that LGTM
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mempolicy.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d90247d6a71b..e5ce5a7e8d92 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -192,7 +192,7 @@ static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
>  	nodes_onto(*ret, tmp, *rel);
>  }
>  
> -static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
> +static int mpol_new_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
>  {
>  	if (nodes_empty(*nodes))
>  		return -EINVAL;
> @@ -210,22 +210,6 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
>  	return 0;
>  }
>  
> -static int mpol_new_preferred_many(struct mempolicy *pol, const nodemask_t *nodes)
> -{
> -	if (nodes_empty(*nodes))
> -		return -EINVAL;
> -	pol->nodes = *nodes;
> -	return 0;
> -}
> -
> -static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
> -{
> -	if (nodes_empty(*nodes))
> -		return -EINVAL;
> -	pol->nodes = *nodes;
> -	return 0;
> -}
> -
>  /*
>   * mpol_set_nodemask is called after mpol_new() to set up the nodemask, if
>   * any, for the new policy.  mpol_new() has already validated the nodes
> @@ -405,7 +389,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  		.rebind = mpol_rebind_default,
>  	},
>  	[MPOL_INTERLEAVE] = {
> -		.create = mpol_new_interleave,
> +		.create = mpol_new_nodemask,
>  		.rebind = mpol_rebind_nodemask,
>  	},
>  	[MPOL_PREFERRED] = {
> @@ -413,14 +397,14 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  		.rebind = mpol_rebind_preferred,
>  	},
>  	[MPOL_BIND] = {
> -		.create = mpol_new_bind,
> +		.create = mpol_new_nodemask,
>  		.rebind = mpol_rebind_nodemask,
>  	},
>  	[MPOL_LOCAL] = {
>  		.rebind = mpol_rebind_default,
>  	},
>  	[MPOL_PREFERRED_MANY] = {
> -		.create = mpol_new_preferred_many,
> +		.create = mpol_new_nodemask,
>  		.rebind = mpol_rebind_preferred,
>  	},
>  };
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
