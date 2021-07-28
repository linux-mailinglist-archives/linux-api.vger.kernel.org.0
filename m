Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64FA3D8E29
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhG1Mr3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 08:47:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51072 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbhG1Mr2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 08:47:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B58FA22319;
        Wed, 28 Jul 2021 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627476445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EY9hnViqgNkITZKfwU8A+2DXRShAbB8e006BrNU9EUA=;
        b=p/UNkGke6IeE6hvLVkNQT3mfouqZHYRvLlWkdaVdkw3vUpU1ih7lZuutI4zV3Hf8sPAhBB
        oyAcN9O1Xzb/RsOHMnjNyBcu8IPM43Vpyf2V+Wi/3moXSQvxB4cPA9ZEAoMezQCueKLpYr
        XQjwdTGzkzZvThjBdS1sig55zyTJYfU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FF98A3B81;
        Wed, 28 Jul 2021 12:47:24 +0000 (UTC)
Date:   Wed, 28 Jul 2021 14:47:23 +0200
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
Subject: Re: [PATCH v6 5/6] mm/mempolicy: Advertise new MPOL_PREFERRED_MANY
Message-ID: <YQFR27gkFNqJqzGN@dhcp22.suse.cz>
References: <1626077374-81682-1-git-send-email-feng.tang@intel.com>
 <1626077374-81682-6-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626077374-81682-6-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 12-07-21 16:09:33, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Adds a new mode to the existing mempolicy modes, MPOL_PREFERRED_MANY.
> 
> MPOL_PREFERRED_MANY will be adequately documented in the internal
> admin-guide with this patch. Eventually, the man pages for mbind(2),
> get_mempolicy(2), set_mempolicy(2) and numactl(8) will also have text
> about this mode. Those shall contain the canonical reference.
> 
> NUMA systems continue to become more prevalent. New technologies like
> PMEM make finer grain control over memory access patterns increasingly
> desirable. MPOL_PREFERRED_MANY allows userspace to specify a set of
> nodes that will be tried first when performing allocations. If those
> allocations fail, all remaining nodes will be tried. It's a straight
> forward API which solves many of the presumptive needs of system
> administrators wanting to optimize workloads on such machines. The mode
> will work either per VMA, or per thread.
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-13-ben.widawsky@intel.com
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  Documentation/admin-guide/mm/numa_memory_policy.rst | 16 ++++++++++++----
>  mm/mempolicy.c                                      |  7 +------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index 067a90a1499c..cd653561e531 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -245,6 +245,14 @@ MPOL_INTERLEAVED
>  	address range or file.  During system boot up, the temporary
>  	interleaved system default policy works in this mode.
>  
> +MPOL_PREFERRED_MANY
> +        This mode specifies that the allocation should be attempted from the
> +        nodemask specified in the policy. If that allocation fails, the kernel
> +        will search other nodes, in order of increasing distance from the first
> +        set bit in the nodemask based on information provided by the platform
> +        firmware. It is similar to MPOL_PREFERRED with the main exception that
> +        is an error to have an empty nodemask.

I believe the target audience of this documents are users rather than
kernel developers and for those the wording might be rather cryptic. I
would rephrase like this
	This mode specifices that the allocation should be preferrably
	satisfied from the nodemask specified in the policy. If there is
	a memory pressure on all nodes in the nodemask the allocation
	can fall back to all existing numa nodes. This is effectively
	MPOL_PREFERRED allowed for a mask rather than a single node.

With that or similar feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
