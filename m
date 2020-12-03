Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBE2CD2AE
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 10:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgLCJiY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 04:38:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:45076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbgLCJiY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Dec 2020 04:38:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84187AC55;
        Thu,  3 Dec 2020 09:37:42 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:37:39 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH -V6 RESEND 2/3] NOT kernel/man-pages:
 man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
Message-ID: <20201203093739.GB3306@suse.de>
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-3-ying.huang@intel.com>
 <20201202114357.GW3306@suse.de>
 <87ft4npskx.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87ft4npskx.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 03, 2020 at 09:49:02AM +0800, Huang, Ying wrote:
> >> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
> >> index 68011eecb..3754b3e12 100644
> >> --- a/man2/set_mempolicy.2
> >> +++ b/man2/set_mempolicy.2
> >> @@ -113,6 +113,12 @@ A nonempty
> >>  .I nodemask
> >>  specifies node IDs that are relative to the set of
> >>  node IDs allowed by the process's current cpuset.
> >> +.TP
> >> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
> >> +Enable the Linux kernel NUMA balancing for the task if it is supported
> >> +by kernel.
> >> +If the flag isn't supported by Linux kernel, return -1 and errno is
> >> +set to EINVAL.
> >>  .PP
> >>  .I nodemask
> >>  points to a bit mask of node IDs that contains up to
> >> @@ -293,6 +299,9 @@ argument specified both
> >
> > Should this be expanded more to clarify it applies to MPOL_BIND
> > specifically?
> >
> > Maybe the first patch should be expanded more and explictly fail if
> > MPOL_F_NUMA_BALANCING is used with anything other than MPOL_BIND?
> 
> For MPOL_PREFERRED, why could we not use NUMA balancing to migrate pages
> to the accessing local node if it is same as the preferred node? 

You could but the kernel patch does not do that by making preferred_nid
stick to the preferred node when hinting faults are trapped on that VMA.
It would have to be a separate patch coupled with a man page update. If
you wanted to go in this direction in the future, then the patch should
explicitly return an error *now* if MPOL_PREFERRED is or'd with
MPOL_F_NUMA_BALANCING so that an application becomes aware of
MPOL_F_NUMA_BALANCING then it can detect if support exists in the
current running kernel.

> Even for MPOL_INTERLEAVE, if the target node is the same as the
> accessing local node, can we use NUMA balancing to migrate pages?
> 

The intent of MPOL_INTERLEAVE is to average the costs of the memory
access so the average cost across the VMA is roughly similar across the
entire range. This may be particularly important if the VMA is shared
between multiple threads that are spread out on multiple nodes. A change
in semantics there should be clearly documented.

Similar, if you want to go in this direction, MPOL_F_NUMA_BALANCING
should be chcked against MPOL_INTERLEAVE and explicitly fail now so
suport can be detected at runtime.

> So, I prefer to make MPOL_F_NUMA_BALANCING to be
> 
>   Optimizing with NUMA balancing if possible, and we may add more
>   optimization in the future.
> 

Maybe, but I think it's best that the actual behaviour of the kernel is
documented instead of desired behaviour or future planning.

-- 
Mel Gorman
SUSE Labs
