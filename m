Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAD3D9027
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhG1OMG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 10:12:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:14393 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235425AbhG1OMF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Jul 2021 10:12:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="199850425"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="199850425"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 07:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="437784978"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2021 07:11:57 -0700
Date:   Wed, 28 Jul 2021 22:11:56 +0800
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
Message-ID: <20210728141156.GC43486@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
 <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 28, 2021 at 02:31:03PM +0200, Michal Hocko wrote:
> [Sorry for a late review]

Not at all. Thank you for all your reviews and suggestions from v1
to v6!

> On Mon 12-07-21 16:09:29, Feng Tang wrote:
> [...]
> > @@ -1887,7 +1909,8 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> >  /* Return the node id preferred by the given mempolicy, or the given id */
> >  static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
> >  {
> > -	if (policy->mode == MPOL_PREFERRED) {
> > +	if (policy->mode == MPOL_PREFERRED ||
> > +	    policy->mode == MPOL_PREFERRED_MANY) {
> >  		nd = first_node(policy->nodes);
> >  	} else {
> >  		/*
> 
> Do we really want to have the preferred node to be always the first node
> in the node mask? Shouldn't that strive for a locality as well? Existing
> callers already prefer numa_node_id() - aka local node - and I belive we
> shouldn't just throw that away here.
 
I think it's about the difference of 'local' and 'prefer/perfer-many'
policy. There are different kinds of memory HW: HBM(High Bandwidth
Memory), normal DRAM, PMEM (Persistent Memory), which have different
price, bandwidth, speed etc. A platform may have two, or all three of
these types, and there are real use case which want memory comes
'preferred' node/nodes than the local node.

And good point for 'local node', if the 'prefer-many' policy's
nodemask has local node set, we should pick it han this
'first_node', and the same semantic also applies to the other
several places you pointed out. Or do I misunderstand you point?

Thanks,
Feng

> > @@ -1931,6 +1954,7 @@ unsigned int mempolicy_slab_node(void)
> >  
> >  	switch (policy->mode) {
> >  	case MPOL_PREFERRED:
> > +	case MPOL_PREFERRED_MANY:
> >  		return first_node(policy->nodes);
> 
> Similarly here but I am not really familiar with the slab numa code
> enough to have strong opinions here.
> 
> > @@ -2173,10 +2198,12 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  		 * node and don't fall back to other nodes, as the cost of
> >  		 * remote accesses would likely offset THP benefits.
> >  		 *
> > -		 * If the policy is interleave, or does not allow the current
> > -		 * node in its nodemask, we allocate the standard way.
> > +		 * If the policy is interleave or multiple preferred nodes, or
> > +		 * does not allow the current node in its nodemask, we allocate
> > +		 * the standard way.
> >  		 */
> > -		if (pol->mode == MPOL_PREFERRED)
> > +		if ((pol->mode == MPOL_PREFERRED ||
> > +		     pol->mode == MPOL_PREFERRED_MANY))
> >  			hpage_node = first_node(pol->nodes);
> 
> Same here.
> 
> > @@ -2451,6 +2479,9 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
> >  		break;
> >  
> >  	case MPOL_PREFERRED:
> > +	case MPOL_PREFERRED_MANY:
> > +		if (node_isset(curnid, pol->nodes))
> > +			goto out;
> >  		polnid = first_node(pol->nodes);
> >  		break;
> 
> I do not follow what is the point of using first_node here. Either the
> node is in the mask or it is misplaced. What are you trying to achieve
> here?
> -- 
> Michal Hocko
> SUSE Labs
