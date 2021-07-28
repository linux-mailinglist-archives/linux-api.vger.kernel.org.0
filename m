Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD83D8FA2
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhG1Nwx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 09:52:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:37965 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237424AbhG1NuI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Jul 2021 09:50:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212698756"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="212698756"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 06:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506467370"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2021 06:50:00 -0700
Date:   Wed, 28 Jul 2021 21:50:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210728135000.GB43486@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-7-git-send-email-feng.tang@intel.com>
 <YQFS3uZEQvPQ9y8Z@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFS3uZEQvPQ9y8Z@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 28, 2021 at 02:51:42PM +0200, Michal Hocko wrote:
> On Mon 12-07-21 16:09:34, Feng Tang wrote:
> > As they all do the same thing: sanity check and save nodemask info, create
> > one mpol_new_nodemask() to reduce redundancy.
> 
> Do we really need a create() callback these days?

I think it tries to provide a per-policy sanity check (though
it's the same for all existing ones), and a per-policy
nodemask setting (current 'prefer' policy is different from
others).

> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Other than that LGTM
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

- Feng

> > ---
> >  mm/mempolicy.c | 24 ++++--------------------
> >  1 file changed, 4 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index d90247d6a71b..e5ce5a7e8d92 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -192,7 +192,7 @@ static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
> >  	nodes_onto(*ret, tmp, *rel);
> >  }
> >  
> > -static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
> > +static int mpol_new_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
> >  {
> >  	if (nodes_empty(*nodes))
> >  		return -EINVAL;
> > @@ -210,22 +210,6 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
> >  	return 0;
> >  }
> >  
> > -static int mpol_new_preferred_many(struct mempolicy *pol, const nodemask_t *nodes)
> > -{
> > -	if (nodes_empty(*nodes))
> > -		return -EINVAL;
> > -	pol->nodes = *nodes;
> > -	return 0;
> > -}
> > -
> > -static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
> > -{
> > -	if (nodes_empty(*nodes))
> > -		return -EINVAL;
> > -	pol->nodes = *nodes;
> > -	return 0;
> > -}
> > -
> >  /*
> >   * mpol_set_nodemask is called after mpol_new() to set up the nodemask, if
> >   * any, for the new policy.  mpol_new() has already validated the nodes
> > @@ -405,7 +389,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> >  		.rebind = mpol_rebind_default,
> >  	},
> >  	[MPOL_INTERLEAVE] = {
> > -		.create = mpol_new_interleave,
> > +		.create = mpol_new_nodemask,
> >  		.rebind = mpol_rebind_nodemask,
> >  	},
> >  	[MPOL_PREFERRED] = {
> > @@ -413,14 +397,14 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> >  		.rebind = mpol_rebind_preferred,
> >  	},
> >  	[MPOL_BIND] = {
> > -		.create = mpol_new_bind,
> > +		.create = mpol_new_nodemask,
> >  		.rebind = mpol_rebind_nodemask,
> >  	},
> >  	[MPOL_LOCAL] = {
> >  		.rebind = mpol_rebind_default,
> >  	},
> >  	[MPOL_PREFERRED_MANY] = {
> > -		.create = mpol_new_preferred_many,
> > +		.create = mpol_new_nodemask,
> >  		.rebind = mpol_rebind_preferred,
> >  	},
> >  };
> > -- 
> > 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs
