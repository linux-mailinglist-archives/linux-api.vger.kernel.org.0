Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493043E2B50
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhHFN2I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 09:28:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42266 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbhHFN2I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 09:28:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C13E41FE58;
        Fri,  6 Aug 2021 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628256471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIrIr2JHOUXujG0/ZIq8z/HG/qc7xRJ1Ya7B7C+n03I=;
        b=USmH0WXxJg+bdsSvc9rx3Xu+1NafJrMq94VVFau0PZTrTbFs42u15zI8bJxhrESWdXP7h6
        KzmL4+FzJVVULB5ZZzw9Uw9WXVAJ3QceVKLC8cjsoYEYnwIqp0+hV20ycZdp1iDQrdU3lR
        D0cdmCOacZTWMpYGi/Y4fVQDq0guNq0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C85FA3B8B;
        Fri,  6 Aug 2021 13:27:51 +0000 (UTC)
Date:   Fri, 6 Aug 2021 15:27:48 +0200
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
Subject: Re: [PATCH v7 1/5] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQ041Djm5GzjU3WR@dhcp22.suse.cz>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627970362-61305-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 03-08-21 13:59:18, Feng Tang wrote:
[...]
> @@ -1936,7 +1969,9 @@ unsigned int mempolicy_slab_node(void)
>  	case MPOL_INTERLEAVE:
>  		return interleave_nodes(policy);
>  
> -	case MPOL_BIND: {
> +	case MPOL_BIND:
> +	case MPOL_PREFERRED_MANY:
> +	{
>  		struct zoneref *z;

I guess this is ok for now but it would be great if slab maintainers
could have a look here. I suspect this will need some more changes. E.g.
I find it highly suspicious how fallback_alloc uses mempolicy_slab_node.
Let's say that the local node is not a part of the nodemask.
mempolicy_slab_node will switch to the first node in the order list
which is ok but fallback_alloc then iterates over the whole zonelist
without any policy node mask constrains. get_any_partial looks very
similar.


-- 
Michal Hocko
SUSE Labs
