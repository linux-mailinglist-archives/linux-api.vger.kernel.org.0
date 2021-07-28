Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383E13D91CD
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhG1PZN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 11:25:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:33565 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235457AbhG1PZN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Jul 2021 11:25:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="209575485"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="209575485"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 08:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506511592"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2021 08:25:07 -0700
Date:   Wed, 28 Jul 2021 23:25:07 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v6 2/6] mm/memplicy: add page allocation function for
 MPOL_PREFERRED_MANY policy
Message-ID: <20210728152507.GE43486@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-3-git-send-email-feng.tang@intel.com>
 <YQFQsnSt/DaWoQHV@dhcp22.suse.cz>
 <20210728151810.GD43486@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728151810.GD43486@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 28, 2021 at 11:18:10PM +0800, Tang, Feng wrote:
> On Wed, Jul 28, 2021 at 02:42:26PM +0200, Michal Hocko wrote:
> > On Mon 12-07-21 16:09:30, Feng Tang wrote:
> > > The semantics of MPOL_PREFERRED_MANY is similar to MPOL_PREFERRED,
> > > that it will first try to allocate memory from the preferred node(s),
> > > and fallback to all nodes in system when first try fails.
> > > 
> > > Add a dedicated function for it just like 'interleave' policy.
> > > 
> > > Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > 
> > It would be better to squash this together with the actual user of the
> > function added by the next patch.
>  
> Ok, will do
> 
> > > ---
> > >  mm/mempolicy.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 17b5800b7dcc..d17bf018efcc 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -2153,6 +2153,25 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
> > >  	return page;
> > >  }
> > >  
> > > +static struct page *alloc_page_preferred_many(gfp_t gfp, unsigned int order,
> > > +						struct mempolicy *pol)
> > 
> > We likely want a node parameter to know which one we want to start with
> > for locality. Callers should use policy_node for that.
>  
> Yes, locality should be considered, something like this?
> 
> 	int pnid, lnid = numa_node_id();
> 
> 	if (is_nodeset(lnid, &pol->nodes))
> 		pnid = local_nid;
> 	else
> 		pnid = first_node(pol->nodes);

One further thought is, if local node is not in the nodemask,
should we compare the distance of all the nodes in nodemask
to the local node and chose the shortest? 

Thanks,
Feng

> 	page = __alloc_pages(((gfp | __GFP_NOWARN) & ~__GFP_DIRECT_RECLAIM),
> 				order, pnid, &pol->nodes);
> 	if (!page)
> 		page = __alloc_pages(gfp, order, lnid, NULL);
> 	return page;
> 
