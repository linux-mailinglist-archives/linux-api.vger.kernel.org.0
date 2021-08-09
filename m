Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D13E45AD
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 14:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhHIMiM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 08:38:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:33314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhHIMiM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 9 Aug 2021 08:38:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="275719038"
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="275719038"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 05:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="670778789"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Aug 2021 05:37:47 -0700
Date:   Mon, 9 Aug 2021 20:37:47 +0800
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <20210809123747.GB46432@shbuild999.sh.intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
 <YQ06tNiDEsvl8004@dhcp22.suse.cz>
 <20210809024430.GA46432@shbuild999.sh.intel.com>
 <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 09, 2021 at 10:41:40AM +0200, Michal Hocko wrote:
[snip]
> > >From fc30718c40f02ba5ea73456af49173e66b5032c1 Mon Sep 17 00:00:00 2001
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > Date: Thu, 5 Aug 2021 23:01:11 -0400
> > Subject: [PATCH] mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY
> > 
> > Implement the missing huge page allocation functionality while obeying the
> > preferred node semantics.  This is similar to the implementation for
> > general page allocation, as it uses a fallback mechanism to try multiple
> > preferred nodes first, and then all other nodes. 
> > 
> > To avoid adding too many "#ifdef CONFIG_NUMA" check, add a helper function
> > in mempolicy.h to check whether a mempolicy is MPOL_PREFERRED_MANY.
> > 
> > [akpm: fix compling issue when merging with other hugetlb patch]
> > [Thanks to 0day bot for catching the !CONFIG_NUMA compiling issue]
> > [Michal Hocko: suggest to remove the #ifdef CONFIG_NUMA check]
> > Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> > Link: https://lkml.kernel.org/r/1627970362-61305-4-git-send-email-feng.tang@intel.com
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Co-developed-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Yeah. This looks much better. Thanks!
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you!

> Do you think you can provide same helpers for other policies as well?
> Maybe we can get rid of some other ifdefery as well.

Sure. I can make separate patch(es) for that.

And you mean helper like mpol_is_bind/default/local/preferred? 

I just run 'git-grep MPOL', and for places using "mode == MPOL_XXX",
mostly they are in mempolicy.[ch], the only another place is in
shmem.c, do we need to create all the helpers for it and the
potential future users? 

Thanks,
Feng
