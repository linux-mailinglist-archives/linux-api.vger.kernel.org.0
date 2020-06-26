Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA02720BBB6
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2020 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgFZVjM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Jun 2020 17:39:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:42995 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFZVjJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 26 Jun 2020 17:39:09 -0400
IronPort-SDR: TVUnCpCGzPmFzRD4sdQs0OU5nIvYW6xe+u1JqeV9tZ4CV4VOsAVe0+VNKN4u8V8uMQbYo+GySZ
 UuP6xM5hWl3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="206996335"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="206996335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 14:39:08 -0700
IronPort-SDR: wtkKno96ilMUHD13jawhjY3cnDzp9bWzSifdkWAbNFi23SXHCUvSMa3IH5U0MJf3Td4FJwIU9w
 /pIzNHyZGPBA==
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="424199267"
Received: from jckalvin-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 14:39:07 -0700
Date:   Fri, 26 Jun 2020 14:39:05 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 00/18] multiple preferred nodes
Message-ID: <20200626213905.dpu2rgevazmisvhj@intel.com>
Mail-Followup-To: Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-api@vger.kernel.org
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
 <20200624075216.GC1320@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624075216.GC1320@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 20-06-24 09:52:16, Michal Hocko wrote:
> On Tue 23-06-20 09:12:11, Ben Widawsky wrote:
> > On 20-06-23 13:20:48, Michal Hocko wrote:
> [...]
> > > It would be also great to provide a high level semantic description
> > > here. I have very quickly glanced through patches and they are not
> > > really trivial to follow with many incremental steps so the higher level
> > > intention is lost easily.
> > > 
> > > Do I get it right that the default semantic is essentially
> > > 	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
> > > 	  semantic)
> > > 	- fallback to numa unrestricted allocation with the default
> > > 	  numa policy on the failure
> > > 
> > > Or are there any usecases to modify how hard to keep the preference over
> > > the fallback?
> > 
> > tl;dr is: yes, and no usecases.
> 
> OK, then I am wondering why the change has to be so involved. Except for
> syscall plumbing the only real change to the allocator path would be
> something like
> 
> static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> {
> 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
> 	if (unlikely(policy->mode == MPOL_BIND || 
> 	   	     policy->mode == MPOL_PREFERED_MANY) &&
> 			apply_policy_zone(policy, gfp_zone(gfp)) &&
> 			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
> 		return &policy->v.nodes;
> 
> 	return NULL;
> }
> 
> alloc_pages_current
> 
> 	if (pol->mode == MPOL_INTERLEAVE)
> 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
> 	else {
> 		gfp_t gfp_attempt = gfp;
> 
> 		/*
> 		 * Make sure the first allocation attempt will try hard
> 		 * but eventually fail without OOM killer or other
> 		 * disruption before falling back to the full nodemask
> 		 */
> 		if (pol->mode == MPOL_PREFERED_MANY)
> 			gfp_attempt |= __GFP_RETRY_MAYFAIL;	
> 
> 		page = __alloc_pages_nodemask(gfp_attempt, order,
> 				policy_node(gfp, pol, numa_node_id()),
> 				policy_nodemask(gfp, pol));
> 		if (!page && pol->mode == MPOL_PREFERED_MANY)
> 			page = __alloc_pages_nodemask(gfp, order,
> 				numa_node_id(), NULL);
> 	}
> 
> 	return page;
> 
> similar (well slightly more hairy) in alloc_pages_vma
> 
> Or do I miss something that really requires more involved approach like
> building custom zonelists and other larger changes to the allocator?

Hi Michal,

I'm mostly done implementing this change. It looks good, and so far I think it's
functionally equivalent. One thing though, above you use NULL for the fallback.
That actually should not be NULL because of the logic in policy_node to restrict
zones, and obey cpusets. I've implemented it as such, but I was hoping someone
with a deeper understanding, and more experience can confirm that was the
correct thing to do.

Thanks.
