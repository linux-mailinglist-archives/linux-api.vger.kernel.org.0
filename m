Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE773D92FB
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhG1QPj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 12:15:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhG1QP2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 12:15:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5DAC31FFD4;
        Wed, 28 Jul 2021 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627488925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xoPVca8js9y9snyRSKAlYaCIdY+QKI6XS6rLmdx3N8I=;
        b=uvq87d8IoaGI4sM7/K/O/NBMWzeDchWDqTXdTXVA/6AWqym+4TC0zR4+d5VQkLb/fEccNA
        eDkG7yq6BDC11nr0pOPxPrUIQ0RWoKszm3oZzf4YOJkNBKuaFNyvZN205v5IZAr+OkXYcs
        9TbtHt7pGO+19aM2HKkp7uObQSXkAhY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2E979A3B84;
        Wed, 28 Jul 2021 16:15:25 +0000 (UTC)
Date:   Wed, 28 Jul 2021 18:15:24 +0200
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
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v6 2/6] mm/memplicy: add page allocation function for
 MPOL_PREFERRED_MANY policy
Message-ID: <YQGCnDZUEhwbinnn@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-3-git-send-email-feng.tang@intel.com>
 <YQFQsnSt/DaWoQHV@dhcp22.suse.cz>
 <20210728151810.GD43486@shbuild999.sh.intel.com>
 <20210728152507.GE43486@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728152507.GE43486@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 28-07-21 23:25:07, Feng Tang wrote:
> On Wed, Jul 28, 2021 at 11:18:10PM +0800, Tang, Feng wrote:
> > On Wed, Jul 28, 2021 at 02:42:26PM +0200, Michal Hocko wrote:
> > > On Mon 12-07-21 16:09:30, Feng Tang wrote:
> > > > The semantics of MPOL_PREFERRED_MANY is similar to MPOL_PREFERRED,
> > > > that it will first try to allocate memory from the preferred node(s),
> > > > and fallback to all nodes in system when first try fails.
> > > > 
> > > > Add a dedicated function for it just like 'interleave' policy.
> > > > 
> > > > Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
> > > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > > Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > 
> > > It would be better to squash this together with the actual user of the
> > > function added by the next patch.
> >  
> > Ok, will do
> > 
> > > > ---
> > > >  mm/mempolicy.c | 19 +++++++++++++++++++
> > > >  1 file changed, 19 insertions(+)
> > > > 
> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 17b5800b7dcc..d17bf018efcc 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -2153,6 +2153,25 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
> > > >  	return page;
> > > >  }
> > > >  
> > > > +static struct page *alloc_page_preferred_many(gfp_t gfp, unsigned int order,
> > > > +						struct mempolicy *pol)
> > > 
> > > We likely want a node parameter to know which one we want to start with
> > > for locality. Callers should use policy_node for that.
> >  
> > Yes, locality should be considered, something like this?
> > 
> > 	int pnid, lnid = numa_node_id();
> > 
> > 	if (is_nodeset(lnid, &pol->nodes))
> > 		pnid = local_nid;
> > 	else
> > 		pnid = first_node(pol->nodes);
> 
> One further thought is, if local node is not in the nodemask,
> should we compare the distance of all the nodes in nodemask
> to the local node and chose the shortest? 

Nope, That is zonelist for. Nodemask will do the rest.
-- 
Michal Hocko
SUSE Labs
