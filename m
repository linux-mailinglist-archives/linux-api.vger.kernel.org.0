Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470643DD47D
	for <lists+linux-api@lfdr.de>; Mon,  2 Aug 2021 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhHBLOo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 07:14:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33884 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHBLOo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Aug 2021 07:14:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 26F8521C2F;
        Mon,  2 Aug 2021 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627902874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFXbUA/npgsJimUjktGzlNShlCBsUVgSGGwA9ygYx1M=;
        b=FMKAn1haAEGcrI4uzbLy2n503nPYCSvDqQhDAGK7UZ//DsWH9h7hNzH8tx039cr/hE1PX/
        tg826pLpdqufS5qRg0DDS9k7kBKSMk0Y3uZa1760p8qCu/GOYhzgg3CG5SQFGIO2kC2h9G
        SPbId/Xs5TiGXkyLEyMUgUfytiXftOM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58655A3B83;
        Mon,  2 Aug 2021 11:14:33 +0000 (UTC)
Date:   Mon, 2 Aug 2021 13:14:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQfTlSy/vmI3ELgR@dhcp22.suse.cz>
References: <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
 <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
 <20210730030502.GA87066@shbuild999.sh.intel.com>
 <YQOeAgPS9+FUseIx@dhcp22.suse.cz>
 <20210730071840.GA87305@shbuild999.sh.intel.com>
 <20210802081130.GA42490@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802081130.GA42490@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 02-08-21 16:11:30, Feng Tang wrote:
> On Fri, Jul 30, 2021 at 03:18:40PM +0800, Tang, Feng wrote:
> [snip]
> > > > One thing is, it's possible that 'nd' is not set in the preferred
> > > > nodemask. 
> > > 
> > > Yes, and there shouldn't be any problem with that.  The given node is
> > > only used to get the respective zonelist (order distance ordered list of
> > > zones to try). get_page_from_freelist will then use the preferred node
> > > mask to filter this zone list. Is that more clear now?
> > 
> > Yes, from the code, the policy_node() is always coupled with
> > policy_nodemask(), which secures the 'nodemask' limit. Thanks for
> > the clarification!
> 
> Hi Michal,
> 
> To ensure the nodemask limit, the policy_nodemask() also needs some
> change to return the nodemask for 'prefer-many' policy, so here is a
> updated 1/6 patch, which mainly changes the node/nodemask selection
> for 'prefer-many' policy, could you review it? thanks!

right, I have mixed it with get_policy_nodemask

> @@ -1875,8 +1897,13 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>   */
>  nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>  {
> -	/* Lower zones don't get a nodemask applied for MPOL_BIND */
> -	if (unlikely(policy->mode == MPOL_BIND) &&
> +	int mode = policy->mode;
> +
> +	/*
> +	 * Lower zones don't get a nodemask applied for 'bind' and
> +	 * 'prefer-many' policies
> +	 */
> +	if (unlikely(mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY) &&
>  			apply_policy_zone(policy, gfp_zone(gfp)) &&
>  			cpuset_nodemask_valid_mems_allowed(&policy->nodes))
>  		return &policy->nodes;

Isn't this just too cryptic? Why didn't you simply
	if (mode == MPOL_PREFERRED_MANY)
		return &policy->mode;

in addition to the existing code? I mean why would you even care about
cpusets? Those are handled at the page allocator layer and will further
filter the given nodemask. 

-- 
Michal Hocko
SUSE Labs
