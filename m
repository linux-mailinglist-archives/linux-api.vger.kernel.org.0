Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836553DB1AD
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 05:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhG3DFM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 23:05:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:30228 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhG3DFM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Jul 2021 23:05:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="276795839"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="276795839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 20:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="518685854"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2021 20:05:03 -0700
Date:   Fri, 30 Jul 2021 11:05:02 +0800
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
Message-ID: <20210730030502.GA87066@shbuild999.sh.intel.com>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
 <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
 <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
 <20210729070918.GA96680@shbuild999.sh.intel.com>
 <YQKvZDXmRSVVRvfi@dhcp22.suse.cz>
 <20210729151242.GA42865@shbuild999.sh.intel.com>
 <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQLVf3pkQTHLemAZ@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 29, 2021 at 06:21:19PM +0200, Michal Hocko wrote:
> On Thu 29-07-21 23:12:42, Feng Tang wrote:
> > On Thu, Jul 29, 2021 at 03:38:44PM +0200, Michal Hocko wrote:
> [...]
> > > Also the
> > > semantic to give nodes some ordering based on their numbers sounds
> > > rather weird to me.
> > 
> > I agree, and as I admitted in the first reply, this need to be fixed.
> 
> OK. I was not really clear that we are on the same page here.
> 
> > > The semantic I am proposing is to allocate from prefered nodes in
> > > distance order starting from the local node.
> > 
> > So the plan is:
> > * if the local node is set in 'prefer-many's nodemask, then chose
> > * otherwise chose the node with the shortest distance to local node
> > ?
> 
> Yes and what I am trying to say is that you will achieve that simply by
> doing the following in policy_node:
> 	if (policy->mode == MPOL_PREFERRED_MANY)
> 		return nd;

One thing is, it's possible that 'nd' is not set in the preferred
nodemask. 

For policy_node(), most of its caller use the local node id as 'nd'
parameter. For HBM and PMEM memory nodes, they are cpuless nodes,
so they will not be a 'local node', but some use cases only prefer
these nodes.

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
