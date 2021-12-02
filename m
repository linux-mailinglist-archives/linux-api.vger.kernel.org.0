Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A1466442
	for <lists+linux-api@lfdr.de>; Thu,  2 Dec 2021 14:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbhLBNK7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Dec 2021 08:10:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59788 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbhLBNK6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Dec 2021 08:10:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A52F212BA;
        Thu,  2 Dec 2021 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638450455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fBEPWl3ouXPLdPayqv4809Ve4tC+0uurHMYlgkDtXWw=;
        b=JEFvhKkP1Oxhj4jZd8VjXF8roUnreaKsvkNUiP6ptWxUbuT4EHqDE/oXWp6L5thcx3i/aj
        tZRc64hyZhHEYD/RcV1O6mbk0rR6mD/DKo3/BoU0kI2nMUj7PbBeypgEZ1xU6+Qdr2Aya/
        Z33zm6xobygJRsaE6kOBvdx8fzTvp7M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09B78A3C2B;
        Thu,  2 Dec 2021 13:07:34 +0000 (UTC)
Date:   Thu, 2 Dec 2021 14:07:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        daniel.m.jordan@oracle.com, Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Message-ID: <YajFFk5bKmNBnAdh@dhcp22.suse.cz>
References: <20211202123810.267175-1-aneesh.kumar@linux.ibm.com>
 <20211202123810.267175-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202123810.267175-3-aneesh.kumar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 02-12-21 18:08:09, Aneesh Kumar K.V wrote:
> This syscall can be used to set a home node for the MPOL_BIND
> and MPOL_PREFERRED_MANY memory policy. Users should use this
> syscall after setting up a memory policy for the specified range
> as shown below.
> 
> mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,
> 	    new_nodes->size + 1, 0);
> sys_set_mempolicy_home_node((unsigned long)p, nr_pages * page_size,
> 				  home_node, 0);
> 
> The syscall allows specifying a home node/preferred node from which kernel
> will fulfill memory allocation requests first.
> 
> For address range with MPOL_BIND memory policy, if nodemask specifies more
> than one node, page allocations will come from the node in the nodemask
> with sufficient free memory that is closest to the home node/preferred node.
> 
> For MPOL_PREFERRED_MANY if the nodemask specifies more than one node,
> page allocation will come from the node in the nodemask with sufficient
> free memory that is closest to the home node/preferred node. If there is
> not enough memory in all the nodes specified in the nodemask, the allocation
> will be attempted from the closest numa node to the home node in the system.
> 
> This helps applications to hint at a memory allocation preference node
> and fallback to _only_ a set of nodes if the memory is not available
> on the preferred node.  Fallback allocation is attempted from the node which is
> nearest to the preferred node.
> 
> This helps applications to have control on memory allocation numa nodes and
> avoids default fallback to slow memory NUMA nodes. For example a system with
> NUMA nodes 1,2 and 3 with DRAM memory and 10, 11 and 12 of slow memory
> 
>  new_nodes = numa_bitmask_alloc(nr_nodes);
> 
>  numa_bitmask_setbit(new_nodes, 1);
>  numa_bitmask_setbit(new_nodes, 2);
>  numa_bitmask_setbit(new_nodes, 3);
> 
>  p = mmap(NULL, nr_pages * page_size, protflag, mapflag, -1, 0);
>  mbind(p, nr_pages * page_size, MPOL_BIND, new_nodes->maskp,  new_nodes->size + 1, 0);
> 
>  sys_set_mempolicy_home_node(p, nr_pages * page_size, 2, 0);
> 
> This will allocate from nodes closer to node 2 and will make sure the kernel will
> only allocate from nodes 1, 2, and 3. Memory will not be allocated from slow memory
> nodes 10, 11, and 12. This differs from default MPOL_BIND behavior in that with
> default MPOL_BIND the allocation will be attempted from node closer to the local node.
> One of the reasons to specify a home node is to allow allocations from cpu less
> NUMA node and its nearby NUMA nodes.
> 
> With MPOL_PREFERRED_MANY on the other hand will first try to allocate from the
> closest node to node 2 from the node list 1, 2 and 3. If those nodes don't have
> enough memory, kernel will allocate from slow memory node 10, 11 and 12 which
> ever is closer to node 2.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

LGTM
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
