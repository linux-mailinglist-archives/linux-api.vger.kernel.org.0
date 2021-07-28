Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5843D92EC
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhG1QM1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 12:12:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53932 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhG1QMZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 12:12:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CA6022293;
        Wed, 28 Jul 2021 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627488742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kUdjHN6ZjAAS2wKnuZpa+CixfoM+bec+V6sZbEG0aY=;
        b=F5G7Fy1PiHzByYDhfZhAuEj0eq33weXQWYYHoWaXZljXsEGWRtFb9hPj1Y++L77G8HYrsP
        eJFFzDkHoe8nfV2fj49HDWBDJboTS4xf4RpwUQSxMPe9MtejYLBskR5ywVQwyx4k9l/4of
        t4DgnRXpGxfbXFeJhix3Yw85jaBquB0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21E03A3B83;
        Wed, 28 Jul 2021 16:12:22 +0000 (UTC)
Date:   Wed, 28 Jul 2021 18:12:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <YQGB5cB5NlgOuNIN@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-2-git-send-email-feng.tang@intel.com>
 <YQFOB4UDK+dNZeOV@dhcp22.suse.cz>
 <20210728141156.GC43486@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728141156.GC43486@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 28-07-21 22:11:56, Feng Tang wrote:
> On Wed, Jul 28, 2021 at 02:31:03PM +0200, Michal Hocko wrote:
> > [Sorry for a late review]
> 
> Not at all. Thank you for all your reviews and suggestions from v1
> to v6!
> 
> > On Mon 12-07-21 16:09:29, Feng Tang wrote:
> > [...]
> > > @@ -1887,7 +1909,8 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > >  /* Return the node id preferred by the given mempolicy, or the given id */
> > >  static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
> > >  {
> > > -	if (policy->mode == MPOL_PREFERRED) {
> > > +	if (policy->mode == MPOL_PREFERRED ||
> > > +	    policy->mode == MPOL_PREFERRED_MANY) {
> > >  		nd = first_node(policy->nodes);
> > >  	} else {
> > >  		/*
> > 
> > Do we really want to have the preferred node to be always the first node
> > in the node mask? Shouldn't that strive for a locality as well? Existing
> > callers already prefer numa_node_id() - aka local node - and I belive we
> > shouldn't just throw that away here.
>  
> I think it's about the difference of 'local' and 'prefer/perfer-many'
> policy. There are different kinds of memory HW: HBM(High Bandwidth
> Memory), normal DRAM, PMEM (Persistent Memory), which have different
> price, bandwidth, speed etc. A platform may have two, or all three of
> these types, and there are real use case which want memory comes
> 'preferred' node/nodes than the local node.
> 
> And good point for 'local node', if the 'prefer-many' policy's
> nodemask has local node set, we should pick it han this
> 'first_node', and the same semantic also applies to the other
> several places you pointed out. Or do I misunderstand you point?

Yeah. Essentially what I am trying to tell is that for
MPOL_PREFERRED_MANY you simply want to return the given node without any
alternation. That node will be used for the fallback zonelist and the
nodemask would make sure we won't get out of the policy.
-- 
Michal Hocko
SUSE Labs
