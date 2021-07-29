Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4713DA73D
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhG2PMx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 11:12:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:15975 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhG2PMx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Jul 2021 11:12:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="212895755"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="212895755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 08:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="507255384"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2021 08:12:42 -0700
Date:   Thu, 29 Jul 2021 23:12:42 +0800
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6 1/6] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <20210729151242.GA42865@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
 <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 29, 2021 at 03:38:44PM +0200, Michal Hocko wrote:
> On Thu 29-07-21 15:09:18, Feng Tang wrote:
> > On Wed, Jul 28, 2021 at 06:12:21PM +0200, Michal Hocko wrote:
> > > On Wed 28-07-21 22:11:56, Feng Tang wrote:
> > > > On Wed, Jul 28, 2021 at 02:31:03PM +0200, Michal Hocko wrote:
> > > > > [Sorry for a late review]
> > > > 
> > > > Not at all. Thank you for all your reviews and suggestions from v1
> > > > to v6!
> > > > 
> > > > > On Mon 12-07-21 16:09:29, Feng Tang wrote:
> > > > > [...]
> > > > > > @@ -1887,7 +1909,8 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > > > > >  /* Return the node id preferred by the given mempolicy, or the given id */
> > > > > >  static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
> > > > > >  {
> > > > > > -	if (policy->mode == MPOL_PREFERRED) {
> > > > > > +	if (policy->mode == MPOL_PREFERRED ||
> > > > > > +	    policy->mode == MPOL_PREFERRED_MANY) {
> > > > > >  		nd = first_node(policy->nodes);
> > > > > >  	} else {
> > > > > >  		/*
> > > > > 
> > > > > Do we really want to have the preferred node to be always the first node
> > > > > in the node mask? Shouldn't that strive for a locality as well? Existing
> > > > > callers already prefer numa_node_id() - aka local node - and I belive we
> > > > > shouldn't just throw that away here.
> > > >  
> > > > I think it's about the difference of 'local' and 'prefer/perfer-many'
> > > > policy. There are different kinds of memory HW: HBM(High Bandwidth
> > > > Memory), normal DRAM, PMEM (Persistent Memory), which have different
> > > > price, bandwidth, speed etc. A platform may have two, or all three of
> > > > these types, and there are real use case which want memory comes
> > > > 'preferred' node/nodes than the local node.
> > > > 
> > > > And good point for 'local node', if the 'prefer-many' policy's
> > > > nodemask has local node set, we should pick it han this
> > > > 'first_node', and the same semantic also applies to the other
> > > > several places you pointed out. Or do I misunderstand you point?
> > > 
> > > Yeah. Essentially what I am trying to tell is that for
> > > MPOL_PREFERRED_MANY you simply want to return the given node without any
> > > alternation. That node will be used for the fallback zonelist and the
> > > nodemask would make sure we won't get out of the policy.
> > 
> > I think I got your point now :)
> > 
> > With current mainline code, the 'prefer' policy will return the preferred
> > node.
> 
> Yes this makes sense as there is only one node.
> 
> > For 'prefer-many', we would like to keep the similar semantic, that the
> > preference of node is 'preferred' > 'local' > all other nodes.
> 
> Yes but which of the preferred nodes you want to start with. Say your
> nodemask preferring nodes 0 and 2 with the following topology
> 	0	1	2	3
> 0	10	30	20	30
> 1	30	10	20	30
> 2	20	30	10	30
> 3	30	30	30	10
> 
> And say you are running on cpu 1. I believe you want your allocation
> preferably from node 2 rathern than 0, right?

Yes, and in one earlier reply, I had a similar thought
https://lore.kernel.org/lkml/20210728152507.GE43486@shbuild999.sh.intel.com/

  "
  One further thought is, if local node is not in the nodemask,
  should we compare the distance of all the nodes in nodemask
  to the local node and chose the shortest?
  "
And we may add a new API if there is no existing one:
	int cloest_node(int nid, nodemask_t *nmask);
to pick the best node from 'prefer-many' nodemsk.

> With your approach you
> would start with node 0 which would be more distant from cpu 1. 

> Also the
> semantic to give nodes some ordering based on their numbers sounds
> rather weird to me.

I agree, and as I admitted in the first reply, this need to be fixed.

> The semantic I am proposing is to allocate from prefered nodes in
> distance order starting from the local node.

So the plan is:
* if the local node is set in 'prefer-many's nodemask, then chose
* otherwise chose the node with the shortest distance to local node
?

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
