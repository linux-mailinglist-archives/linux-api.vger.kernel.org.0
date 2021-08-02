Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E033DD4B2
	for <lists+linux-api@lfdr.de>; Mon,  2 Aug 2021 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhHBLdo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Aug 2021 07:33:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:26669 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhHBLdn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Aug 2021 07:33:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="235364585"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="235364585"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 04:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="510105180"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2021 04:33:27 -0700
Date:   Mon, 2 Aug 2021 19:33:26 +0800
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
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <20210802113326.GA78980@shbuild999.sh.intel.com>
References: <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
 <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
 <20210730030502.GA87066@shbuild999.sh.intel.com>
 <YQOeAgPS9+FUseIx@dhcp22.suse.cz>
 <20210730071840.GA87305@shbuild999.sh.intel.com>
 <20210802081130.GA42490@shbuild999.sh.intel.com>
 <YQfTlSy/vmI3ELgR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQfTlSy/vmI3ELgR@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 02, 2021 at 01:14:29PM +0200, Michal Hocko wrote:
> On Mon 02-08-21 16:11:30, Feng Tang wrote:
> > On Fri, Jul 30, 2021 at 03:18:40PM +0800, Tang, Feng wrote:
> > [snip]
> > > > > One thing is, it's possible that 'nd' is not set in the preferred
> > > > > nodemask. 
> > > > 
> > > > Yes, and there shouldn't be any problem with that.  The given node is
> > > > only used to get the respective zonelist (order distance ordered list of
> > > > zones to try). get_page_from_freelist will then use the preferred node
> > > > mask to filter this zone list. Is that more clear now?
> > > 
> > > Yes, from the code, the policy_node() is always coupled with
> > > policy_nodemask(), which secures the 'nodemask' limit. Thanks for
> > > the clarification!
> > 
> > Hi Michal,
> > 
> > To ensure the nodemask limit, the policy_nodemask() also needs some
> > change to return the nodemask for 'prefer-many' policy, so here is a
> > updated 1/6 patch, which mainly changes the node/nodemask selection
> > for 'prefer-many' policy, could you review it? thanks!
> 
> right, I have mixed it with get_policy_nodemask
> 
> > @@ -1875,8 +1897,13 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
> >   */
> >  nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> >  {
> > -	/* Lower zones don't get a nodemask applied for MPOL_BIND */
> > -	if (unlikely(policy->mode == MPOL_BIND) &&
> > +	int mode = policy->mode;
> > +
> > +	/*
> > +	 * Lower zones don't get a nodemask applied for 'bind' and
> > +	 * 'prefer-many' policies
> > +	 */
> > +	if (unlikely(mode == MPOL_BIND || mode == MPOL_PREFERRED_MANY) &&
> >  			apply_policy_zone(policy, gfp_zone(gfp)) &&
> >  			cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> >  		return &policy->nodes;
> 
> Isn't this just too cryptic? Why didn't you simply
> 	if (mode == MPOL_PREFERRED_MANY)
> 		return &policy->mode;
> 
> in addition to the existing code? I mean why would you even care about
> cpusets? Those are handled at the page allocator layer and will further
> filter the given nodemask. 

Ok, I will follow your suggestion and keep 'bind' handling unchanged.

And to be honest, I don't fully understand the current handling for
'bind' policy, will the returning NULL for 'bind' policy open a
sideway for the strict 'bind' limit. 

Thanks,
Feng


> -- 
> Michal Hocko
> SUSE Labs
