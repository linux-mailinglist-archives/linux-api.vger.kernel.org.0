Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5E20DFA6
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2020 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbgF2Uio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jun 2020 16:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbgF2TOS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jun 2020 15:14:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E7C008604
        for <linux-api@vger.kernel.org>; Mon, 29 Jun 2020 03:16:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so12362462edz.0
        for <linux-api@vger.kernel.org>; Mon, 29 Jun 2020 03:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O73s0LOtJXu7Fh+11xaWdZVxJaYAQpIuzZzQZGghGk0=;
        b=nKGLsHJbcOr6cONtglKbhMAZY5BTh5y2sRqE0qy6wT351ETYGRrOdSGP9YAe52BG4c
         u+ILiWUkl0ptJfMXegRQ0w3dVmV+RRMlzbm+g1fMPwawyH7KWqrY5jAIdFJrhNk853Hg
         uh1CMuSy44AMnfSKH1FkQ82eg4Nn93zjur38DFPAeVPFPWVP1GnZeenZxNaOxkCV4k8d
         KuDnKjQkJYLH8e4jOg/RTffX5mSsTXR/pRl3uyFzeJ3fcYWQ+r+QrDeASeWNonyxfA1z
         7Me5NPlrpl6WsTLJAl+s3vOr33nYEzg01EgUYEG16rQ2eaLZTPr0glZi72n+qkh0OtSZ
         nXvg==
X-Gm-Message-State: AOAM530/ONAHfqDPlIjV6OR7P0xaE+gV9YxxzNvP33H+vy18A0tjRuex
        Gw+RWkSplQNdJQikTo+Civ0=
X-Google-Smtp-Source: ABdhPJwKpj6ektay4WJQs/diddThZei9xqnQ8ZJlw/eJT+/nM4ohuXXxflgHSMBy0/BRNxXDlzNBjg==
X-Received: by 2002:aa7:d6cf:: with SMTP id x15mr16384517edr.164.1593425814345;
        Mon, 29 Jun 2020 03:16:54 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id a1sm18079226ejk.125.2020.06.29.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 03:16:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:16:52 +0200
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
Message-ID: <20200629101652.GG32461@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
 <20200624075216.GC1320@dhcp22.suse.cz>
 <20200626213905.dpu2rgevazmisvhj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626213905.dpu2rgevazmisvhj@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 26-06-20 14:39:05, Ben Widawsky wrote:
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
> Hi Michal,
> 
> I'm mostly done implementing this change. It looks good, and so far I think it's
> functionally equivalent. One thing though, above you use NULL for the fallback.
> That actually should not be NULL because of the logic in policy_node to restrict
> zones, and obey cpusets. I've implemented it as such, but I was hoping someone
> with a deeper understanding, and more experience can confirm that was the
> correct thing to do.

Cpusets are just plumbed into the allocator directly. Have a look at
__cpuset_zone_allowed call inside get_page_from_freelist. Anyway
functionally what you are looking for here is that the fallback
allocation should be exactly as if there was no mempolicy in place. And
that is expressed by NULL nodemask. The rest is done automagically...

-- 
Michal Hocko
SUSE Labs
