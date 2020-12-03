Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BC2CD405
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLCKx5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 05:53:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:38628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgLCKx5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Dec 2020 05:53:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65793ACBA;
        Thu,  3 Dec 2020 10:53:15 +0000 (UTC)
Date:   Thu, 3 Dec 2020 10:53:13 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH -V6 RESEND 1/3] numa balancing: Migrate on fault among
 multiple bound nodes
Message-ID: <20201203105313.GF3306@suse.de>
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-2-ying.huang@intel.com>
 <20201202114054.GV3306@suse.de>
 <20201203102550.GK2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201203102550.GK2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 03, 2020 at 11:25:50AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 02, 2020 at 11:40:54AM +0000, Mel Gorman wrote:
> > On Wed, Dec 02, 2020 at 04:42:32PM +0800, Huang Ying wrote:
> > > Now, NUMA balancing can only optimize the page placement among the
> > > NUMA nodes if the default memory policy is used.  Because the memory
> > > policy specified explicitly should take precedence.  But this seems
> > > too strict in some situations.  For example, on a system with 4 NUMA
> > > nodes, if the memory of an application is bound to the node 0 and 1,
> > > NUMA balancing can potentially migrate the pages between the node 0
> > > and 1 to reduce cross-node accessing without breaking the explicit
> > > memory binding policy.
> > > 
> > 
> > Ok, I think this part is ok and while the test case is somewhat
> > superficial, it at least demonstrated that the NUMA balancing overhead
> > did not offset any potential benefit
> > 
> > Acked-by: Mel Gorman <mgorman@suse.de>
> 
> Who do we expect to merge this, me through tip/sched/core or akpm ?

I would expect akpm, it's much more on the mm side because it affects
the semantics of memory policies. It should also have more mm-orientated
review than just mine because it affects user-visible semantics and the
ability to detect whether the feature is available or not needs to be
treated with care.

-- 
Mel Gorman
SUSE Labs
