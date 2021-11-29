Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73634623F1
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhK2WHk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 17:07:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50444 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhK2WFi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 17:05:38 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F0D6B81630
        for <linux-api@vger.kernel.org>; Mon, 29 Nov 2021 22:02:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F8976023B;
        Mon, 29 Nov 2021 22:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638223337;
        bh=ez5xBqgP4xioj9P3KggOcm53sTo1oiCCfuOT52CzGp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CtuZfGIeBal7t5KeSad31YgVbEd4aQd0DTyf6/KaWGZTxInAVilRgLm/gnqTU8HNs
         djvpDZlEDAwgNCT0JdB492YLfn1pyFdq3uW3toWb8vjeZnceSkau/KiVN8WrIPtvT5
         Yvk9QaAdRsmZxzWu21ZWYVvHvr3iXIKFLF6Zxgyg=
Date:   Mon, 29 Nov 2021 14:02:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/mempolicy: add set_mempolicy_home_node
 syscall
Message-Id: <20211129140215.11b7cf9f1034a7fe7017768c@linux-foundation.org>
In-Reply-To: <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
        <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 16 Nov 2021 12:12:37 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

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
> 
> With MPOL_PREFERRED_MANY on the other hand will first try to allocate from the
> closest node to node 2 from the node list 1, 2 and 3. If those nodes don't have
> enough memory, kernel will allocate from slow memory node 10, 11 and 12 which
> ever is closer to node 2.
> 
> ...
>
> @@ -1477,6 +1478,60 @@ static long kernel_mbind(unsigned long start, unsigned long len,
>  	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
>  }
>  
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

What's the thinking here?  The node can later be offlined and the
kernel takes no action to reset home nodes, so why not permit setting a
presently-offline node as the home node?  Checking here seems rather
arbitrary?


