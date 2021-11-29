Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A223F461274
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 11:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbhK2KiA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 05:38:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57594 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbhK2Kf7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 05:35:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 38D981FD3A;
        Mon, 29 Nov 2021 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638181960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuCqQTK6cUbTziQFNFESc9EmLP5wyyCbpPrqf+6sY3Q=;
        b=dfF3JiYV6S02hlnhYITSR+6KU4VYpQnVCf/5pL80UYD1EPaHUzCgR1EwuSkrAtaIOzAA+M
        MLEaOShZ3s8B6WdOzAkMq0nNMd6StIwr2f4gMPp0yXg6lFssC+Llga1mXKVlNkrqCTYkhb
        o0qU9ZTZf2tD8aEA88l/0o7WG9J8CgM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6B17A3B81;
        Mon, 29 Nov 2021 10:32:39 +0000 (UTC)
Date:   Mon, 29 Nov 2021 11:32:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
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
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node syscall
Message-ID: <YaSsR0z6GN07qyH7@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 16-11-21 12:12:37, Aneesh Kumar K.V wrote:
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
> This will allocate from nodes closer to node 2 and will make sure kernel will
> only allocate from nodes 1, 2 and3. Memory will not be allocated from slow memory
> nodes 10, 11 and 12

I think you are not really explaining why the home node is really needed
for that usecase. You can limit memory access to those nodes even
without the home node. Why the defaulot local node is insufficient is
really a missing part in the explanation.

One usecase would be cpu less nodes and their preference for the
allocation. If there are others make sure to mention them in the
changelog.

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
> ---
>  .../admin-guide/mm/numa_memory_policy.rst     | 14 ++++-
>  include/linux/mempolicy.h                     |  1 +
>  mm/mempolicy.c                                | 62 +++++++++++++++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
> index 64fd0ba0d057..6eab52d4c3b2 100644
> --- a/Documentation/admin-guide/mm/numa_memory_policy.rst
> +++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
> @@ -408,7 +408,7 @@ follows:
>  Memory Policy APIs
>  ==================
>  
> -Linux supports 3 system calls for controlling memory policy.  These APIS
> +Linux supports 4 system calls for controlling memory policy.  These APIS
>  always affect only the calling task, the calling task's address space, or
>  some shared object mapped into the calling task's address space.
>  
> @@ -460,6 +460,18 @@ requested via the 'flags' argument.
>  
>  See the mbind(2) man page for more details.
>  
> +Set home node for a Range of Task's Address Spacec::
> +
> +	long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
> +  					 unsigned long home_node,
> +					 unsigned long flags);
> +
> +sys_set_mempolicy_home_node set the home node for a VMA policy present in the
> +task's address range. The system call updates the home node only for the existing
> +mempolicy range. Other address ranges are ignored.

> A home node is the NUMA node
> +closest to which page allocation will come from.

I woudl repgrase
The home node override the default allocation policy to allocate memory
close to the local node for an executing CPU.

[...]

> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
> +		unsigned long, home_node, unsigned long, flags)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	struct mempolicy *new;
> +	unsigned long vmstart;
> +	unsigned long vmend;
> +	unsigned long end;
> +	int err = -ENOENT;
> +
> +	if (start & ~PAGE_MASK)
> +		return -EINVAL;
> +	/*
> +	 * flags is used for future extension if any.
> +	 */
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	if (!node_online(home_node))
> +		return -EINVAL;

You really want to check the home_node before dereferencing the mask.

> +
> +	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
> +	end = start + len;
> +
> +	if (end < start)
> +		return -EINVAL;
> +	if (end == start)
> +		return 0;
> +	mmap_write_lock(mm);
> +	vma = find_vma(mm, start);
> +	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
> +
> +		vmstart = max(start, vma->vm_start);
> +		vmend   = min(end, vma->vm_end);
> +		new = mpol_dup(vma_policy(vma));
> +		if (IS_ERR(new)) {
> +			err = PTR_ERR(new);
> +			break;
> +		}
> +		/*
> +		 * Only update home node if there is an existing vma policy
> +		 */
> +		if (!new)
> +			continue;

Your changelog only mentions MPOL_BIND and MPOL_PREFERRED_MANY as
supported but you seem to be applying the home node to all existing
policies

> +		new->home_node = home_node;
> +		err = mbind_range(mm, vmstart, vmend, new);
> +		if (err)
> +			break;
> +	}
> +	mmap_write_unlock(mm);
> +	return err;
> +}
> +

Other than that I do not see any major issues.
-- 
Michal Hocko
SUSE Labs
