Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C63AC184
	for <lists+linux-api@lfdr.de>; Fri, 18 Jun 2021 05:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhFRDq6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Jun 2021 23:46:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:1056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhFRDq6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 Jun 2021 23:46:58 -0400
IronPort-SDR: m+OeCOsucgo+2BZTyqI73Ft7RC3KxVmBzBncDhNG1jNGvP2s13AcKhFC3xXHJAhvTyq8lpaYJA
 4etx2xDGvkLw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267636012"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267636012"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 20:44:49 -0700
IronPort-SDR: 0N2poWjcGlgPP5SEiYJ9BPGJLhBrjBzjdcZAin1DppoX2RhJI+IkZgJFN4rXFpK/rQm+zYYswQ
 uhUDVVI5uv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="485539795"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 17 Jun 2021 20:44:44 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v5 -mm 0/6] Introduced multi-preference mempolicy
Date:   Fri, 18 Jun 2021 11:44:38 +0800
Message-Id: <1623987884-43576-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch series introduces the concept of the MPOL_PREFERRED_MANY mempolicy.
This mempolicy mode can be used with either the set_mempolicy(2) or mbind(2)
interfaces. Like the MPOL_PREFERRED interface, it allows an application to set a
preference for nodes which will fulfil memory allocation requests. Unlike the
MPOL_PREFERRED mode, it takes a set of nodes. Like the MPOL_BIND interface, it
works over a set of nodes. Unlike MPOL_BIND, it will not cause a SIGSEGV or
invoke the OOM killer if those preferred nodes are not available.

Along with these patches are patches for libnuma, numactl, numademo, and memhog.
They still need some polish, but can be found here:
https://gitlab.com/bwidawsk/numactl/-/tree/prefer-many
It allows new usage: `numactl -P 0,3,4`

The goal of the new mode is to enable some use-cases when using tiered memory
usage models which I've lovingly named.
1a. The Hare - The interconnect is fast enough to meet bandwidth and latency
requirements allowing preference to be given to all nodes with "fast" memory.
1b. The Indiscriminate Hare - An application knows it wants fast memory (or
perhaps slow memory), but doesn't care which node it runs on. The application
can prefer a set of nodes and then xpu bind to the local node (cpu, accelerator,
etc). This reverses the nodes are chosen today where the kernel attempts to use
local memory to the CPU whenever possible. This will attempt to use the local
accelerator to the memory.
2. The Tortoise - The administrator (or the application itself) is aware it only
needs slow memory, and so can prefer that.

Much of this is almost achievable with the bind interface, but the bind
interface suffers from an inability to fallback to another set of nodes if
binding fails to all nodes in the nodemask.

Like MPOL_BIND a nodemask is given. Inherently this removes ordering from the
preference.

> /* Set first two nodes as preferred in an 8 node system. */
> const unsigned long nodes = 0x3
> set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);

> /* Mimic interleave policy, but have fallback *.
> const unsigned long nodes = 0xaa
> set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);

Some internal discussion took place around the interface. There are two
alternatives which we have discussed, plus one I stuck in:
1. Ordered list of nodes. Currently it's believed that the added complexity is
   nod needed for expected usecases.
2. A flag for bind to allow falling back to other nodes. This confuses the
   notion of binding and is less flexible than the current solution.
3. Create flags or new modes that helps with some ordering. This offers both a
   friendlier API as well as a solution for more customized usage. It's unknown
   if it's worth the complexity to support this. Here is sample code for how
   this might work:

> // Prefer specific nodes for some something wacky
> set_mempolicy(MPOL_PREFER_MANY, 0x17c, 1024);
>
> // Default
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_SOCKET, NULL, 0);
> // which is the same as
> set_mempolicy(MPOL_DEFAULT, NULL, 0);
>
> // The Hare
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, NULL, 0);
>
> // The Tortoise
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_REV, NULL, 0);
>
> // Prefer the fast memory of the first two sockets
> set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, -1, 2);
>

In v1, Andi Kleen brought up reusing MPOL_PREFERRED as the mode for the API.
There wasn't consensus around this, so I've left the existing API as it was. I'm
open to more feedback here, but my slight preference is to use a new API as it
ensures if people are using it, they are entirely aware of what they're doing
and not accidentally misusing the old interface. (In a similar way to how
MPOL_LOCAL was introduced).

In v1, Michal also brought up renaming this MPOL_PREFERRED_MASK. I'm equally
fine with that change, but I hadn't heard much emphatic support for one way or
another, so I've left that too.


---
Changelog: 

  Since v4:
  * Rebased on latest -mm tree (v5.13-rc), whose mempolicy code has
    been refactored much since v4 submission
  * add a dedicated alloc_page_preferred_many() (Michal Hocko)
  * refactor and add fix to hugetlb supporting code (Michal Hocko) 

  Since v3:
  * Rebased against v5.12-rc2
  * Drop the v3/0013 patch of creating NO_SLOWPATH gfp_mask bit
  * Skip direct reclaim for the first allocation try for
    MPOL_PREFERRED_MANY, which makes its semantics close to
    existing MPOL_PREFFERRED policy

  Since v2:
  * Rebased against v5.11
  * Fix a stack overflow related panic, and a kernel warning (Feng)
  * Some code clearup (Feng)
  * One RFC patch to speedup mem alloc in some case (Feng)

  Since v1:
  * Dropped patch to replace numa_node_id in some places (mhocko)
  * Dropped all the page allocation patches in favor of new mechanism to
    use fallbacks. (mhocko)
  * Dropped the special snowflake preferred node algorithm (bwidawsk)
  * If the preferred node fails, ALL nodes are rechecked instead of just
    the non-preferred nodes.

Ben Widawsky (3):
  mm/mempolicy: enable page allocation for MPOL_PREFERRED_MANY for
    general cases
  mm/hugetlb: add support for mempolicy MPOL_PREFERRED_MANY
  mm/mempolicy: Advertise new MPOL_PREFERRED_MANY

Dave Hansen (1):
  mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes

Feng Tang (2):
  mm/memplicy: add page allocation function for MPOL_PREFERRED_MANY
    policy
  mm/mempolicy: unify the create() func for bind/interleave/prefer-many
    policies

 .../admin-guide/mm/numa_memory_policy.rst          | 16 +++--
 include/uapi/linux/mempolicy.h                     |  1 +
 mm/hugetlb.c                                       | 27 +++++++-
 mm/mempolicy.c                                     | 75 +++++++++++++++++-----
 4 files changed, 96 insertions(+), 23 deletions(-)

-- 
2.7.4

