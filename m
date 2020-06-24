Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438E206E3C
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389980AbgFXHwU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 03:52:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52109 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgFXHwU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 03:52:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so1394310wmg.1
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 00:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vEfxaSqCVYVbhmxk9OFTIs6iy9TarTkNEwCUYfPyeYY=;
        b=jO3ILIE+OGsTICLqzWkj4cVVVJZsbXwF+7927RanmjkCZ5CiLnOE2ZaDt7jDDNGcvK
         DFo5RnJVx0vqvq+LNpkxnjImOXpbMd93SLO2xB0ZocXCL08DsVS+NovbQnkzN5pnjtAM
         A+zkuZpNhPW7T/rhnJHZv6HOi0WeHGGl7O+DCaSh1FiRRzshd+lc+SJaLl3xZO4ftiVI
         O9x/QaZV+b/jppUblk4PrnSmR3H1M0GyUBAwbaljRzLj4Gc9FcspIz2QWQ0JpsBDA9uW
         JBI+UczDbrfrBTbJMG+w3bSbHJNDbvug8UjipCsvgL97C1se3L0X+heiPrMxUEyzVFnS
         LBQA==
X-Gm-Message-State: AOAM533HM9ZUfGq4C8oX4c2KJk54vnkV0hMdWAqI6gWNzmYkWPPNt7mr
        WDMenIM0AOqAmdhPlccNJqw=
X-Google-Smtp-Source: ABdhPJzNio31HT5WXaJ/z40RekkTBMk1/J8+VjwLSXqC41uB6a3gUDqLOEqeF6hJDEEUG/cafvVWpg==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr28035865wmc.124.1592985138263;
        Wed, 24 Jun 2020 00:52:18 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id a16sm25100777wrx.8.2020.06.24.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:52:17 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:52:16 +0200
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
Message-ID: <20200624075216.GC1320@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623161211.qjup5km5eiisy5wy@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 23-06-20 09:12:11, Ben Widawsky wrote:
> On 20-06-23 13:20:48, Michal Hocko wrote:
[...]
> > It would be also great to provide a high level semantic description
> > here. I have very quickly glanced through patches and they are not
> > really trivial to follow with many incremental steps so the higher level
> > intention is lost easily.
> > 
> > Do I get it right that the default semantic is essentially
> > 	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
> > 	  semantic)
> > 	- fallback to numa unrestricted allocation with the default
> > 	  numa policy on the failure
> > 
> > Or are there any usecases to modify how hard to keep the preference over
> > the fallback?
> 
> tl;dr is: yes, and no usecases.

OK, then I am wondering why the change has to be so involved. Except for
syscall plumbing the only real change to the allocator path would be
something like

static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
{
	/* Lower zones don't get a nodemask applied for MPOL_BIND */
	if (unlikely(policy->mode == MPOL_BIND || 
	   	     policy->mode == MPOL_PREFERED_MANY) &&
			apply_policy_zone(policy, gfp_zone(gfp)) &&
			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
		return &policy->v.nodes;

	return NULL;
}

alloc_pages_current

	if (pol->mode == MPOL_INTERLEAVE)
		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
	else {
		gfp_t gfp_attempt = gfp;

		/*
		 * Make sure the first allocation attempt will try hard
		 * but eventually fail without OOM killer or other
		 * disruption before falling back to the full nodemask
		 */
		if (pol->mode == MPOL_PREFERED_MANY)
			gfp_attempt |= __GFP_RETRY_MAYFAIL;	

		page = __alloc_pages_nodemask(gfp_attempt, order,
				policy_node(gfp, pol, numa_node_id()),
				policy_nodemask(gfp, pol));
		if (!page && pol->mode == MPOL_PREFERED_MANY)
			page = __alloc_pages_nodemask(gfp, order,
				numa_node_id(), NULL);
	}

	return page;

similar (well slightly more hairy) in alloc_pages_vma

Or do I miss something that really requires more involved approach like
building custom zonelists and other larger changes to the allocator?
-- 
Michal Hocko
SUSE Labs
