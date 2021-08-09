Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3C3E465D
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhHINTz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 09:19:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54452 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhHINTz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 09:19:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A5AB21F4B;
        Mon,  9 Aug 2021 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628515173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX1f69WbRiWu5Eg3CL5L0jwPsMknl/HQ42nsUY/VTWg=;
        b=GosZusxyRFNBNmD8DfIK8+2PEdI3WjLBBd311s7hV+O0VT9gz3Gq3AuPmyg5hW7qbUbbeF
        WLrVKNIb0/vqs/f8tgH7FDlZr8dM7AXcjvhKvj2fhV6G7c3Tg3IzBZDXp7LUIEeZuLihue
        1FRI/+zqbTa7m8pHgf7x+ihdfZFxwcs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07737A3B81;
        Mon,  9 Aug 2021 13:19:32 +0000 (UTC)
Date:   Mon, 9 Aug 2021 15:19:32 +0200
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
Message-ID: <YRErZFQGZx4aPYuU@dhcp22.suse.cz>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-4-git-send-email-feng.tang@intel.com>
 <YQ06tNiDEsvl8004@dhcp22.suse.cz>
 <20210809024430.GA46432@shbuild999.sh.intel.com>
 <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
 <20210809123747.GB46432@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809123747.GB46432@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 09-08-21 20:37:47, Feng Tang wrote:
> On Mon, Aug 09, 2021 at 10:41:40AM +0200, Michal Hocko wrote:
> [snip]
> > > >From fc30718c40f02ba5ea73456af49173e66b5032c1 Mon Sep 17 00:00:00 2001
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > Date: Thu, 5 Aug 2021 23:01:11 -0400
> > > Subject: [PATCH] mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY
> > > 
> > > Implement the missing huge page allocation functionality while obeying the
> > > preferred node semantics.  This is similar to the implementation for
> > > general page allocation, as it uses a fallback mechanism to try multiple
> > > preferred nodes first, and then all other nodes. 
> > > 
> > > To avoid adding too many "#ifdef CONFIG_NUMA" check, add a helper function
> > > in mempolicy.h to check whether a mempolicy is MPOL_PREFERRED_MANY.
> > > 
> > > [akpm: fix compling issue when merging with other hugetlb patch]
> > > [Thanks to 0day bot for catching the !CONFIG_NUMA compiling issue]
> > > [Michal Hocko: suggest to remove the #ifdef CONFIG_NUMA check]
> > > Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> > > Link: https://lkml.kernel.org/r/1627970362-61305-4-git-send-email-feng.tang@intel.com
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Co-developed-by: Feng Tang <feng.tang@intel.com>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > 
> > Yeah. This looks much better. Thanks!
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thank you!
> 
> > Do you think you can provide same helpers for other policies as well?
> > Maybe we can get rid of some other ifdefery as well.
> 
> Sure. I can make separate patch(es) for that.
> 
> And you mean helper like mpol_is_bind/default/local/preferred? 
> 
> I just run 'git-grep MPOL', and for places using "mode == MPOL_XXX",
> mostly they are in mempolicy.[ch], the only another place is in
> shmem.c, do we need to create all the helpers for it and the
> potential future users? 

I would just go with those instances which need to ifdef for NUMA.
Thanks!
-- 
Michal Hocko
SUSE Labs
