Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC2207C6D
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 21:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406254AbgFXTwD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 15:52:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406243AbgFXTwD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 15:52:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id j94so3503545wrj.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 12:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2cMKilgf66FCIWnyDIhCH6x/r6ZjF/CwOV/tnIGSvEI=;
        b=ECE1eZtBbal+YL+cmJESQ7XCFQFzOSMFh7Hiabj7X4G8dF6sSNxM6UgQM6jlgVKSJq
         jpk4mPsm7VyhhTXLyRdfBJdXOhq5m4ji1fyKYdmblZ2lhqMh3+PKwHQ3WS61BjpiGWov
         FAVfHRel92JGChhsQRUclVbdkIYDBoXOVNMNDfr6KvUqB+al4dkgIT1iwPZcyZRI9sbv
         +MZy027lTrRUM6UF0PDrEA8zAOXas6CuZdboZm73jd5SYM178mbHMcGNo3ThXchy/7rm
         CEf6VzyUf1DKuq9BFquQJOOoYGgoJ78i8ukBg208Z8S2oXXFPpeEJVgOtH6au05k12Xj
         DmLw==
X-Gm-Message-State: AOAM533z73oqSlytwFuAYGI4q5lm8qXgNlNrLpUE3sU60ydgp3Ca0cEC
        ex6BnS+uaQfQkud7hT27ags=
X-Google-Smtp-Source: ABdhPJx2Ro4lrSHmIdUQEq4EprhrnHZQ/Lw8SWbIsSIzO01j2eVdYTyBrWifV5kpsmao7BgKx0bALg==
X-Received: by 2002:adf:e545:: with SMTP id z5mr31880147wrm.89.1593028321073;
        Wed, 24 Jun 2020 12:52:01 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id q128sm9159300wma.38.2020.06.24.12.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 12:51:59 -0700 (PDT)
Date:   Wed, 24 Jun 2020 21:51:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
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
Message-ID: <20200624195158.GX1320@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
 <20200624075216.GC1320@dhcp22.suse.cz>
 <20200624161643.75fkkvsxlmp3bf2e@intel.com>
 <20200624183917.GW1320@dhcp22.suse.cz>
 <20200624193733.tqeligjd3pdvrsmi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624193733.tqeligjd3pdvrsmi@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 24-06-20 12:37:33, Ben Widawsky wrote:
> On 20-06-24 20:39:17, Michal Hocko wrote:
> > On Wed 24-06-20 09:16:43, Ben Widawsky wrote:
> > > On 20-06-24 09:52:16, Michal Hocko wrote:
> > > > On Tue 23-06-20 09:12:11, Ben Widawsky wrote:
> > > > > On 20-06-23 13:20:48, Michal Hocko wrote:
> > > > [...]
> > > > > > It would be also great to provide a high level semantic description
> > > > > > here. I have very quickly glanced through patches and they are not
> > > > > > really trivial to follow with many incremental steps so the higher level
> > > > > > intention is lost easily.
> > > > > > 
> > > > > > Do I get it right that the default semantic is essentially
> > > > > > 	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
> > > > > > 	  semantic)
> > > > > > 	- fallback to numa unrestricted allocation with the default
> > > > > > 	  numa policy on the failure
> > > > > > 
> > > > > > Or are there any usecases to modify how hard to keep the preference over
> > > > > > the fallback?
> > > > > 
> > > > > tl;dr is: yes, and no usecases.
> > > > 
> > > > OK, then I am wondering why the change has to be so involved. Except for
> > > > syscall plumbing the only real change to the allocator path would be
> > > > something like
> > > > 
> > > > static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > > > {
> > > > 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
> > > > 	if (unlikely(policy->mode == MPOL_BIND || 
> > > > 	   	     policy->mode == MPOL_PREFERED_MANY) &&
> > > > 			apply_policy_zone(policy, gfp_zone(gfp)) &&
> > > > 			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
> > > > 		return &policy->v.nodes;
> > > > 
> > > > 	return NULL;
> > > > }
> > > > 
> > > > alloc_pages_current
> > > > 
> > > > 	if (pol->mode == MPOL_INTERLEAVE)
> > > > 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
> > > > 	else {
> > > > 		gfp_t gfp_attempt = gfp;
> > > > 
> > > > 		/*
> > > > 		 * Make sure the first allocation attempt will try hard
> > > > 		 * but eventually fail without OOM killer or other
> > > > 		 * disruption before falling back to the full nodemask
> > > > 		 */
> > > > 		if (pol->mode == MPOL_PREFERED_MANY)
> > > > 			gfp_attempt |= __GFP_RETRY_MAYFAIL;	
> > > > 
> > > > 		page = __alloc_pages_nodemask(gfp_attempt, order,
> > > > 				policy_node(gfp, pol, numa_node_id()),
> > > > 				policy_nodemask(gfp, pol));
> > > > 		if (!page && pol->mode == MPOL_PREFERED_MANY)
> > > > 			page = __alloc_pages_nodemask(gfp, order,
> > > > 				numa_node_id(), NULL);
> > > > 	}
> > > > 
> > > > 	return page;
> > > > 
> > > > similar (well slightly more hairy) in alloc_pages_vma
> > > > 
> > > > Or do I miss something that really requires more involved approach like
> > > > building custom zonelists and other larger changes to the allocator?
> > > 
> > > I think I'm missing how this allows selecting from multiple preferred nodes. In
> > > this case when you try to get the page from the freelist, you'll get the
> > > zonelist of the preferred node, and when you actually scan through on page
> > > allocation, you have no way to filter out the non-preferred nodes. I think the
> > > plumbing of multiple nodes has to go all the way through
> > > __alloc_pages_nodemask(). But it's possible I've missed the point.
> > 
> > policy_nodemask() will provide the nodemask which will be used as a
> > filter on the policy_node.
> 
> Ah, gotcha. Enabling independent masks seemed useful. Some bad decisions got me
> to that point. UAPI cannot get independent masks, and callers of these functions
> don't yet use them.
> 
> So let me ask before I actually type it up and find it's much much simpler, is
> there not some perceived benefit to having both masks being independent?

I am not sure I follow. Which two masks do you have in mind? zonelist
and user provided nodemask?

-- 
Michal Hocko
SUSE Labs
