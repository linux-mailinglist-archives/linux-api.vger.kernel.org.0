Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2705A3E87B0
	for <lists+linux-api@lfdr.de>; Wed, 11 Aug 2021 03:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhHKBhy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Aug 2021 21:37:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:50770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhHKBhx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Aug 2021 21:37:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="202201573"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="202201573"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 18:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="516263485"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2021 18:37:25 -0700
Date:   Wed, 11 Aug 2021 09:37:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
Message-ID: <20210811013724.GB2474@shbuild999.sh.intel.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
 <YQ06tNiDEsvl8004@dhcp22.suse.cz>
 <20210809024430.GA46432@shbuild999.sh.intel.com>
 <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
 <20210809123747.GB46432@shbuild999.sh.intel.com>
 <YRErZFQGZx4aPYuU@dhcp22.suse.cz>
 <20210810085048.GA67328@shbuild999.sh.intel.com>
 <81f33a1-8ff-f2d4-63ff-de6c81d86f3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f33a1-8ff-f2d4-63ff-de6c81d86f3@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Huge,

On Tue, Aug 10, 2021 at 02:35:05PM -0700, Hugh Dickins wrote:
> On Tue, 10 Aug 2021, Feng Tang wrote:
> > On Mon, Aug 09, 2021 at 03:19:32PM +0200, Michal Hocko wrote:
> > [snip]
> > > > > Do you think you can provide same helpers for other policies as well?
> > > > > Maybe we can get rid of some other ifdefery as well.
> > > > 
> > > > Sure. I can make separate patch(es) for that.
> > > > 
> > > > And you mean helper like mpol_is_bind/default/local/preferred? 
> > > > 
> > > > I just run 'git-grep MPOL', and for places using "mode == MPOL_XXX",
> > > > mostly they are in mempolicy.[ch], the only another place is in
> > > > shmem.c, do we need to create all the helpers for it and the
> > > > potential future users? 
> > > 
> > > I would just go with those instances which need to ifdef for NUMA.
> > > Thanks!
> > 
> > Yes, following is a patch to remove one CONFIG_NUMA check, though
> > an bolder idea to extend the patch by removing the CONFIG_TMPFS
> > check in the same line.
> > 
> > Thanks,
> > Feng
> > 
> > ---------8<---------------------------------
> > 
> > From 1a5858721ac8ce99c27c13d310bba2983dc73d97 Mon Sep 17 00:00:00 2001
> > From: Feng Tang <feng.tang@intel.com>
> > Date: Tue, 10 Aug 2021 17:00:59 +0800
> > Subject: [PATCH] mm: shmem: avoid open coded check for mempolicy's mode
> > 
> > Add a mempolicy helper to do the check, which can also remove
> > a CONFIG_NUMA option check.
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> No thanks: this is not an improvement.
> 
> The "#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)" is there to
> eliminate dead code that would not be automatically eliminated by the
> optimizer: it's not there just to avoid MPOL_DEFAULT, and it's there
> to cover shmem_get_sbmpol() along with shmem_show_mpol().

Thanks for the explaination! I did some tests that in !NUMA case, the
'sbinfo->mpol' is always NULL (I could be wrong) which makes the
2 functions almost non-ops.

> I know we tend to avoid #ifdefs in .c files, and that's good; and
> I know you could find other code in mm/shmem.c which might also be
> #ifdef'ed to eliminate other dead code in other configs; but unless
> there's a new drive to purge our .c source of all #ifdefs,
> please just leave this as is.
 
Ok, and sorry for the noise.

Thanks,
Feng

> Thanks,
> Hugh
> 
