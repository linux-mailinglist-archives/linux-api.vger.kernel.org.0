Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18B203058
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgFVHKC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 03:10:02 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:45806 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgFVHKC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 03:10:02 -0400
Received: by mail-ej1-f65.google.com with SMTP id a1so2862602ejg.12
        for <linux-api@vger.kernel.org>; Mon, 22 Jun 2020 00:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXQZAoKaQ85xb6lR9U0VGvt7vanuquPVxRZo+duTvfI=;
        b=ZbvkcFaZkg68kdGSjnDhhhS4dO3Klu9bXjhA83sqIyPoiSOk1d/xUU9eFkA/UzAoAr
         sVe4sfaClf20vJqDN3erc881rVwlqbuJr0xO7l/ygmYJAowtz7LHuNAy0OE+mmSn6FXl
         GOKMCd5eimrgsxDG6FTWe15cxfdmZX5GDXuIFKoxE1VGVNlPj8xDXaAlY5cPqVjrSCNs
         xShr5mpfjcXPlWVJEFhDpjhbF9XRpRxMSlOUJTLejDaU/faPlHFt6ANpqhPaH9VUVhdP
         himXr2IOfc0q8/P6dJmtCO3Rp0LiLqggkPewY52UTAapTLI+kpa+bmfti4UBVlTjavG3
         62Uw==
X-Gm-Message-State: AOAM530poXXhRVtljtKWZSvsGNFQ3btjtzcRalaKiBGLJBf8UiQ+JqRI
        Aa7x+f5q9ex8YcyfECOKqWw=
X-Google-Smtp-Source: ABdhPJxBrTPpCzk+2FQ/fo8+zXLNz+4GRPZv2YBkssEWPvBSGUtG1kVWvl9z6JoSn0c9NI9zWKRjVA==
X-Received: by 2002:a17:907:7290:: with SMTP id dt16mr5824117ejc.63.1592809799655;
        Mon, 22 Jun 2020 00:09:59 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id sd15sm3562106ejb.66.2020.06.22.00.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:09:58 -0700 (PDT)
Date:   Mon, 22 Jun 2020 09:09:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 00/18] multiple preferred nodes
Message-ID: <20200622070957.GB31426@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619162425.1052382-1-ben.widawsky@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

User visible APIs changes/additions should be posted to the linux-api
mailing list. Now added.

On Fri 19-06-20 09:24:07, Ben Widawsky wrote:
> This patch series introduces the concept of the MPOL_PREFERRED_MANY mempolicy.
> This mempolicy mode can be used with either the set_mempolicy(2) or mbind(2)
> interfaces. Like the MPOL_PREFERRED interface, it allows an application to set a
> preference for nodes which will fulfil memory allocation requests. Like the
> MPOL_BIND interface, it works over a set of nodes.
> 
> Summary:
> 1-2: Random fixes I found along the way
> 3-4: Logic to handle many preferred nodes in page allocation
> 5-9: Plumbing to allow multiple preferred nodes in mempolicy
> 10-13: Teach page allocation APIs about nodemasks
> 14: Provide a helper to generate preferred nodemasks
> 15: Have page allocation callers generate preferred nodemasks
> 16-17: Flip the switch to have __alloc_pages_nodemask take preferred mask.
> 18: Expose the new uapi
> 
> Along with these patches are patches for libnuma, numactl, numademo, and memhog.
> They still need some polish, but can be found here:
> https://gitlab.com/bwidawsk/numactl/-/tree/prefer-many
> It allows new usage: `numactl -P 0,3,4`
> 
> The goal of the new mode is to enable some use-cases when using tiered memory
> usage models which I've lovingly named.
> 1a. The Hare - The interconnect is fast enough to meet bandwidth and latency
> requirements allowing preference to be given to all nodes with "fast" memory.
> 1b. The Indiscriminate Hare - An application knows it wants fast memory (or
> perhaps slow memory), but doesn't care which node it runs on. The application
> can prefer a set of nodes and then xpu bind to the local node (cpu, accelerator,
> etc). This reverses the nodes are chosen today where the kernel attempts to use
> local memory to the CPU whenever possible. This will attempt to use the local
> accelerator to the memory.
> 2. The Tortoise - The administrator (or the application itself) is aware it only
> needs slow memory, and so can prefer that.
> 
> Much of this is almost achievable with the bind interface, but the bind
> interface suffers from an inability to fallback to another set of nodes if
> binding fails to all nodes in the nodemask.
> 
> Like MPOL_BIND a nodemask is given. Inherently this removes ordering from the
> preference.
> 
> > /* Set first two nodes as preferred in an 8 node system. */
> > const unsigned long nodes = 0x3
> > set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);
> 
> > /* Mimic interleave policy, but have fallback *.
> > const unsigned long nodes = 0xaa
> > set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);
> 
> Some internal discussion took place around the interface. There are two
> alternatives which we have discussed, plus one I stuck in:
> 1. Ordered list of nodes. Currently it's believed that the added complexity is
>    nod needed for expected usecases.
> 2. A flag for bind to allow falling back to other nodes. This confuses the
>    notion of binding and is less flexible than the current solution.
> 3. Create flags or new modes that helps with some ordering. This offers both a
>    friendlier API as well as a solution for more customized usage. It's unknown
>    if it's worth the complexity to support this. Here is sample code for how
>    this might work:
> 
> > // Default
> > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_SOCKET, NULL, 0);
> > // which is the same as
> > set_mempolicy(MPOL_DEFAULT, NULL, 0);
> >
> > // The Hare
> > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, NULL, 0);
> >
> > // The Tortoise
> > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_REV, NULL, 0);
> >
> > // Prefer the fast memory of the first two sockets
> > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, -1, 2);
> >
> > // Prefer specific nodes for some something wacky
> > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_CUSTOM, 0x17c, 1024);
> 
> ---
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>
> Cc: Li Xinhai <lixinhai.lxh@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mina Almasry <almasrymina@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> 
> Ben Widawsky (14):
>   mm/mempolicy: Add comment for missing LOCAL
>   mm/mempolicy: Use node_mem_id() instead of node_id()
>   mm/page_alloc: start plumbing multi preferred node
>   mm/page_alloc: add preferred pass to page allocation
>   mm: Finish handling MPOL_PREFERRED_MANY
>   mm: clean up alloc_pages_vma (thp)
>   mm: Extract THP hugepage allocation
>   mm/mempolicy: Use __alloc_page_node for interleaved
>   mm: kill __alloc_pages
>   mm/mempolicy: Introduce policy_preferred_nodes()
>   mm: convert callers of __alloc_pages_nodemask to pmask
>   alloc_pages_nodemask: turn preferred nid into a nodemask
>   mm: Use less stack for page allocations
>   mm/mempolicy: Advertise new MPOL_PREFERRED_MANY
> 
> Dave Hansen (4):
>   mm/mempolicy: convert single preferred_node to full nodemask
>   mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
>   mm/mempolicy: allow preferred code to take a nodemask
>   mm/mempolicy: refactor rebind code for PREFERRED_MANY
> 
>  .../admin-guide/mm/numa_memory_policy.rst     |  22 +-
>  include/linux/gfp.h                           |  19 +-
>  include/linux/mempolicy.h                     |   4 +-
>  include/linux/migrate.h                       |   4 +-
>  include/linux/mmzone.h                        |   3 +
>  include/uapi/linux/mempolicy.h                |   6 +-
>  mm/hugetlb.c                                  |  10 +-
>  mm/internal.h                                 |   1 +
>  mm/mempolicy.c                                | 271 +++++++++++++-----
>  mm/page_alloc.c                               | 179 +++++++++++-
>  10 files changed, 403 insertions(+), 116 deletions(-)
> 
> 
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
