Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBC435BC5
	for <lists+linux-api@lfdr.de>; Thu, 21 Oct 2021 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJUHfK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Oct 2021 03:35:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:3929 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhJUHfI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 21 Oct 2021 03:35:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="216131263"
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; 
   d="scan'208";a="216131263"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; 
   d="scan'208";a="444682526"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 00:32:07 -0700
Date:   Thu, 21 Oct 2021 15:32:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] mm/mempolicy: add set_mempolicy_home_node
 syscall
Message-ID: <20211021073206.GA20861@shbuild999.sh.intel.com>
References: <20211020092453.179929-1-aneesh.kumar@linux.ibm.com>
 <20211020092453.179929-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020092453.179929-2-aneesh.kumar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Aneesh,

On Wed, Oct 20, 2021 at 02:54:52PM +0530, Aneesh Kumar K.V wrote:
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

I can understand the requirement for MPOL_BIND, and for MPOL_PREFERRED_MANY,
it provides 3 levels of preference:
  home node --> preferred nodes --> all nodes
Any real usage cases for this? For a platform which may have 3 types of
memory (HBM, DRAM, PMEM), this may be useful.   

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
 
For this example, it's 'mbind + sys_set_mempolicy_home_node', will case
'set_mempolicy + sys_set_mempolicy_home_node' be also supported? 

Thanks,
Feng

> This will allocate from nodes closer to node 2 and will make sure kernel will
> only allocate from nodes 1, 2 and3. Memory will not be allocated from slow memory
> nodes 10, 11 and 12
> 
> With MPOL_PREFERRED_MANY on the other hand will first try to allocate from the
> closest node to node 2 from the node list 1, 2 and 3. If those nodes don't have
> enough memory, kernel will allocate from slow memory node 10, 11 and 12 which
> ever is closer to node 2.

[SNIP]
