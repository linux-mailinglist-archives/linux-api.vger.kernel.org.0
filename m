Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0AB2CBBC7
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgLBLom (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 06:44:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:33744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgLBLom (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 Dec 2020 06:44:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17582AB7F;
        Wed,  2 Dec 2020 11:44:00 +0000 (UTC)
Date:   Wed, 2 Dec 2020 11:43:57 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
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
Message-ID: <20201202114357.GW3306@suse.de>
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201202084234.15797-3-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 02, 2020 at 04:42:33PM +0800, Huang Ying wrote:
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  man2/set_mempolicy.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
> index 68011eecb..3754b3e12 100644
> --- a/man2/set_mempolicy.2
> +++ b/man2/set_mempolicy.2
> @@ -113,6 +113,12 @@ A nonempty
>  .I nodemask
>  specifies node IDs that are relative to the set of
>  node IDs allowed by the process's current cpuset.
> +.TP
> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
> +Enable the Linux kernel NUMA balancing for the task if it is supported
> +by kernel.
> +If the flag isn't supported by Linux kernel, return -1 and errno is
> +set to EINVAL.
>  .PP
>  .I nodemask
>  points to a bit mask of node IDs that contains up to
> @@ -293,6 +299,9 @@ argument specified both

Should this be expanded more to clarify it applies to MPOL_BIND
specifically?

Maybe the first patch should be expanded more and explictly fail if
MPOL_F_NUMA_BALANCING is used with anything other than MPOL_BIND?

>  .B MPOL_F_STATIC_NODES
>  and
>  .BR MPOL_F_RELATIVE_NODES .
> +Or, the
> +.B MPOL_F_NUMA_BALANCING
> +isn't supported by the Linux kernel.

This will be difficult for an app to distinguish but we can't go back in
time and make this ENOSYS :(

The linux-api people might have more guidance but it may go to the
extent of including a small test program in the manual page for a
sequence that tests whether MPOL_F_NUMA_BALANCING works. They might have
a better recommendation on how it should be handled.

-- 
Mel Gorman
SUSE Labs
