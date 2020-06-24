Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD97D207C95
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406231AbgFXUBn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 16:01:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:51746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406182AbgFXUBn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Jun 2020 16:01:43 -0400
IronPort-SDR: Oz16z02+PRn0Qqld/O4l6+vz4xoeurHeBE/5CRmXVUaM70CCZOTfVi5cUspMVasXN4egrfNZXh
 LLho+0F2UsMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142100476"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142100476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 13:01:42 -0700
IronPort-SDR: 1ZH2OkFMoJ1+8anq94ewEgwjdHTpl3dy1EE1reMSKpVLdfSh2GvZEy6MkZYFgk7YnD8C5tLI6R
 z7mvn/Jdr6sw==
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="423487613"
Received: from dshapova-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.143.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 13:01:41 -0700
Date:   Wed, 24 Jun 2020 13:01:40 -0700
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
Message-ID: <20200624200140.dypw6snshshzlbwa@intel.com>
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
 <20200624161643.75fkkvsxlmp3bf2e@intel.com>
 <20200624183917.GW1320@dhcp22.suse.cz>
 <20200624193733.tqeligjd3pdvrsmi@intel.com>
 <20200624195158.GX1320@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624195158.GX1320@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 20-06-24 21:51:58, Michal Hocko wrote:
> On Wed 24-06-20 12:37:33, Ben Widawsky wrote:
> > On 20-06-24 20:39:17, Michal Hocko wrote:
> > > On Wed 24-06-20 09:16:43, Ben Widawsky wrote:
> > > > On 20-06-24 09:52:16, Michal Hocko wrote:
> > > > > On Tue 23-06-20 09:12:11, Ben Widawsky wrote:
> > > > > > On 20-06-23 13:20:48, Michal Hocko wrote:
> > > > > [...]
> > > > > > > It would be also great to provide a high level semantic description
> > > > > > > here. I have very quickly glanced through patches and they are not
> > > > > > > really trivial to follow with many incremental steps so the higher level
> > > > > > > intention is lost easily.
> > > > > > > 
> > > > > > > Do I get it right that the default semantic is essentially
> > > > > > > 	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
> > > > > > > 	  semantic)
> > > > > > > 	- fallback to numa unrestricted allocation with the default
> > > > > > > 	  numa policy on the failure
> > > > > > > 
> > > > > > > Or are there any usecases to modify how hard to keep the preference over
> > > > > > > the fallback?
> > > > > > 
> > > > > > tl;dr is: yes, and no usecases.
> > > > > 
> > > > > OK, then I am wondering why the change has to be so involved. Except for
> > > > > syscall plumbing the only real change to the allocator path would be
> > > > > something like
> > > > > 
> > > > > static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > > > > {
> > > > > 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
> > > > > 	if (unlikely(policy->mode == MPOL_BIND || 
> > > > > 	   	     policy->mode == MPOL_PREFERED_MANY) &&
> > > > > 			apply_policy_zone(policy, gfp_zone(gfp)) &&
> > > > > 			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
> > > > > 		return &policy->v.nodes;
> > > > > 
> > > > > 	return NULL;
> > > > > }
> > > > > 
> > > > > alloc_pages_current
> > > > > 
> > > > > 	if (pol->mode == MPOL_INTERLEAVE)
> > > > > 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
> > > > > 	else {
> > > > > 		gfp_t gfp_attempt = gfp;
> > > > > 
> > > > > 		/*
> > > > > 		 * Make sure the first allocation attempt will try hard
> > > > > 		 * but eventually fail without OOM killer or other
> > > > > 		 * disruption before falling back to the full nodemask
> > > > > 		 */
> > > > > 		if (pol->mode == MPOL_PREFERED_MANY)
> > > > > 			gfp_attempt |= __GFP_RETRY_MAYFAIL;	
> > > > > 
> > > > > 		page = __alloc_pages_nodemask(gfp_attempt, order,
> > > > > 				policy_node(gfp, pol, numa_node_id()),
> > > > > 				policy_nodemask(gfp, pol));
> > > > > 		if (!page && pol->mode == MPOL_PREFERED_MANY)
> > > > > 			page = __alloc_pages_nodemask(gfp, order,
> > > > > 				numa_node_id(), NULL);
> > > > > 	}
> > > > > 
> > > > > 	return page;
> > > > > 
> > > > > similar (well slightly more hairy) in alloc_pages_vma
> > > > > 
> > > > > Or do I miss something that really requires more involved approach like
> > > > > building custom zonelists and other larger changes to the allocator?
> > > > 
> > > > I think I'm missing how this allows selecting from multiple preferred nodes. In
> > > > this case when you try to get the page from the freelist, you'll get the
> > > > zonelist of the preferred node, and when you actually scan through on page
> > > > allocation, you have no way to filter out the non-preferred nodes. I think the
> > > > plumbing of multiple nodes has to go all the way through
> > > > __alloc_pages_nodemask(). But it's possible I've missed the point.
> > > 
> > > policy_nodemask() will provide the nodemask which will be used as a
> > > filter on the policy_node.
> > 
> > Ah, gotcha. Enabling independent masks seemed useful. Some bad decisions got me
> > to that point. UAPI cannot get independent masks, and callers of these functions
> > don't yet use them.
> > 
> > So let me ask before I actually type it up and find it's much much simpler, is
> > there not some perceived benefit to having both masks being independent?
> 
> I am not sure I follow. Which two masks do you have in mind? zonelist
> and user provided nodemask?

Internally, a nodemask_t for preferred node, and a nodemask_t for bound nodes.

> 
> -- 
> Michal Hocko
> SUSE Labs
> 
