Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC19207BAF
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 20:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405820AbgFXSjW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 14:39:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34363 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405808AbgFXSjV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 14:39:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so291166wrw.1
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 11:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WPLJJBf/lJKRfE0nK6AuawFua6bQlcJVOnPGb3ePz2E=;
        b=qurrpy2KoRtaM8ii/54kMYGHZfUS0WY6HIo82/NNKwxRDWRcwwlGrdzDy95NB3WTbc
         i23bh8WvxQdUY625+8jMg+CWx4I0SEuFhFTXKmj63gVMWfMycg27Hyp+xWR/Jw4Ndkg0
         mlFS9YKUpZsggrJKradRXcU08IH660td9d0FgXZThSM2LwRmfO33jLDQZXA9c5rjiVdQ
         ZhVwZv1QVOFIBO9hP4Dvu0Oz1awXyxk8gbvmtIHgtZ9GMs597PSDjC+2kE10rgZlVTCx
         WqE5aq2W4qLusxKegf3KMJWY21+ooGSlC1LCsxEtH3Pbwo1X1eGnO3ezTge4w0wekosZ
         V8eQ==
X-Gm-Message-State: AOAM532UAobdAN05dZF9nPe+AES4lZTWUmzLxYMj6TC02veDwHFJNW4P
        6a0N+4e6r9r0WSOMSSVQ74I=
X-Google-Smtp-Source: ABdhPJzG1J7UOIbj3D5FegqhdaC4Ed8a/hoCqqo84Wvhgyil9nUm55P13RKaZE3H0wCv+QDB8D5lqg==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr34145363wru.115.1593023959580;
        Wed, 24 Jun 2020 11:39:19 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id o15sm8950965wmm.31.2020.06.24.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:39:18 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:39:17 +0200
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
Message-ID: <20200624183917.GW1320@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
 <20200624075216.GC1320@dhcp22.suse.cz>
 <20200624161643.75fkkvsxlmp3bf2e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624161643.75fkkvsxlmp3bf2e@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 24-06-20 09:16:43, Ben Widawsky wrote:
> On 20-06-24 09:52:16, Michal Hocko wrote:
> > On Tue 23-06-20 09:12:11, Ben Widawsky wrote:
> > > On 20-06-23 13:20:48, Michal Hocko wrote:
> > [...]
> > > > It would be also great to provide a high level semantic description
> > > > here. I have very quickly glanced through patches and they are not
> > > > really trivial to follow with many incremental steps so the higher level
> > > > intention is lost easily.
> > > > 
> > > > Do I get it right that the default semantic is essentially
> > > > 	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
> > > > 	  semantic)
> > > > 	- fallback to numa unrestricted allocation with the default
> > > > 	  numa policy on the failure
> > > > 
> > > > Or are there any usecases to modify how hard to keep the preference over
> > > > the fallback?
> > > 
> > > tl;dr is: yes, and no usecases.
> > 
> > OK, then I am wondering why the change has to be so involved. Except for
> > syscall plumbing the only real change to the allocator path would be
> > something like
> > 
> > static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > {
> > 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
> > 	if (unlikely(policy->mode == MPOL_BIND || 
> > 	   	     policy->mode == MPOL_PREFERED_MANY) &&
> > 			apply_policy_zone(policy, gfp_zone(gfp)) &&
> > 			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
> > 		return &policy->v.nodes;
> > 
> > 	return NULL;
> > }
> > 
> > alloc_pages_current
> > 
> > 	if (pol->mode == MPOL_INTERLEAVE)
> > 		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
> > 	else {
> > 		gfp_t gfp_attempt = gfp;
> > 
> > 		/*
> > 		 * Make sure the first allocation attempt will try hard
> > 		 * but eventually fail without OOM killer or other
> > 		 * disruption before falling back to the full nodemask
> > 		 */
> > 		if (pol->mode == MPOL_PREFERED_MANY)
> > 			gfp_attempt |= __GFP_RETRY_MAYFAIL;	
> > 
> > 		page = __alloc_pages_nodemask(gfp_attempt, order,
> > 				policy_node(gfp, pol, numa_node_id()),
> > 				policy_nodemask(gfp, pol));
> > 		if (!page && pol->mode == MPOL_PREFERED_MANY)
> > 			page = __alloc_pages_nodemask(gfp, order,
> > 				numa_node_id(), NULL);
> > 	}
> > 
> > 	return page;
> > 
> > similar (well slightly more hairy) in alloc_pages_vma
> > 
> > Or do I miss something that really requires more involved approach like
> > building custom zonelists and other larger changes to the allocator?
> 
> I think I'm missing how this allows selecting from multiple preferred nodes. In
> this case when you try to get the page from the freelist, you'll get the
> zonelist of the preferred node, and when you actually scan through on page
> allocation, you have no way to filter out the non-preferred nodes. I think the
> plumbing of multiple nodes has to go all the way through
> __alloc_pages_nodemask(). But it's possible I've missed the point.

policy_nodemask() will provide the nodemask which will be used as a
filter on the policy_node.
-- 
Michal Hocko
SUSE Labs
