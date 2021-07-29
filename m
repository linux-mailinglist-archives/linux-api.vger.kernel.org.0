Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811783D9E12
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 09:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhG2HJ2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 03:09:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:64994 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234339AbhG2HJ1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Jul 2021 03:09:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="212810214"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="212810214"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 00:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="438102616"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2021 00:09:19 -0700
Date:   Thu, 29 Jul 2021 15:09:18 +0800
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
Message-ID: <20210729070918.GA96680@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
 <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 28, 2021 at 06:12:21PM +0200, Michal Hocko wrote:
> On Wed 28-07-21 22:11:56, Feng Tang wrote:
> > On Wed, Jul 28, 2021 at 02:31:03PM +0200, Michal Hocko wrote:
> > > [Sorry for a late review]
> > 
> > Not at all. Thank you for all your reviews and suggestions from v1
> > to v6!
> > 
> > > On Mon 12-07-21 16:09:29, Feng Tang wrote:
> > > [...]
> > > > @@ -1887,7 +1909,8 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > > >  /* Return the node id preferred by the given mempolicy, or the given id */
> > > >  static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
> > > >  {
> > > > -	if (policy->mode == MPOL_PREFERRED) {
> > > > +	if (policy->mode == MPOL_PREFERRED ||
> > > > +	    policy->mode == MPOL_PREFERRED_MANY) {
> > > >  		nd = first_node(policy->nodes);
> > > >  	} else {
> > > >  		/*
> > > 
> > > Do we really want to have the preferred node to be always the first node
> > > in the node mask? Shouldn't that strive for a locality as well? Existing
> > > callers already prefer numa_node_id() - aka local node - and I belive we
> > > shouldn't just throw that away here.
> >  
> > I think it's about the difference of 'local' and 'prefer/perfer-many'
> > policy. There are different kinds of memory HW: HBM(High Bandwidth
> > Memory), normal DRAM, PMEM (Persistent Memory), which have different
> > price, bandwidth, speed etc. A platform may have two, or all three of
> > these types, and there are real use case which want memory comes
> > 'preferred' node/nodes than the local node.
> > 
> > And good point for 'local node', if the 'prefer-many' policy's
> > nodemask has local node set, we should pick it han this
> > 'first_node', and the same semantic also applies to the other
> > several places you pointed out. Or do I misunderstand you point?
> 
> Yeah. Essentially what I am trying to tell is that for
> MPOL_PREFERRED_MANY you simply want to return the given node without any
> alternation. That node will be used for the fallback zonelist and the
> nodemask would make sure we won't get out of the policy.

I think I got your point now :)

With current mainline code, the 'prefer' policy will return the preferred
node.

For 'prefer-many', we would like to keep the similar semantic, that the
preference of node is 'preferred' > 'local' > all other nodes. There is
some customer use case, whose platform has both DRAM and cheaper, bigger
and slower PMEM, and they anlayzed the hotness of their huge data, and
they want to put huge cold data into the PMEM, and only fallback to DRAM
as the last step. The HW topology could be simplified like this:

Socket 0:  Node 0 (CPU + 64GB DRAM), Node 2 (512GB PMEM)
Socket 1:  Node 1 (CPU + 64GB DRAM), Node 3 (512GB PMEM)

E.g they want to allocate memory for colde application data with
'prefer-many' policy + 0xC nodemask (N2+N3 PMEM nodes), so no matter the
application is running on Node 0 or Node 1, the 'local' node only has DRAM
which is not their preference, and want a preferred-->local-->others order. 

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
