Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D793E2B58
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 15:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbhHFN2c (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 09:28:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbhHFN2c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 09:28:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 78F891FED4;
        Fri,  6 Aug 2021 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628256493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5g2SBpEkCatphDUwYVXrJmzhDlPfjpgjUvk4dHWmc7s=;
        b=DLBtZe2U5qpqD52Mi1+ZGD14Nn5rs0T1Hw9vcj21EBJL0BZTBlzKJfKG8qZlFjd/MTfxCs
        gJeq1DOa+ka/YcKBwZFyF4cp3+P+0kPp3CuqHj6/hK6dgv8RfE25Z5GuZRGBpYuihfGAwK
        KSbcnd4poQ0SqLt3VJEeGzg/S89FtLQ=
Received: from suse.cz (mhocko.udp.ovpn2.prg.suse.de [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B766A3B91;
        Fri,  6 Aug 2021 13:28:13 +0000 (UTC)
Date:   Fri, 6 Aug 2021 15:28:12 +0200
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
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 1/5] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YQ047Gcakj2scjNK@dhcp22.suse.cz>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com>
 <1627970362-61305-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627970362-61305-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 03-08-21 13:59:18, Feng Tang wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The NUMA APIs currently allow passing in a "preferred node" as a
> single bit set in a nodemask.  If more than one bit it set, bits
> after the first are ignored.
> 
> This single node is generally OK for location-based NUMA where
> memory being allocated will eventually be operated on by a single
> CPU.  However, in systems with multiple memory types, folks want
> to target a *type* of memory instead of a location.  For instance,
> someone might want some high-bandwidth memory but do not care about
> the CPU next to which it is allocated.  Or, they want a cheap,
> high capacity allocation and want to target all NUMA nodes which
> have persistent memory in volatile mode.  In both of these cases,
> the application wants to target a *set* of nodes, but does not
> want strict MPOL_BIND behavior as that could lead to OOM killer or
> SIGSEGV.
> 
> So add MPOL_PREFERRED_MANY policy to support the multiple preferred
> nodes requirement. This is not a pie-in-the-sky dream for an API.
> This was a response to a specific ask of more than one group at Intel.
> Specifically:
> 
> 1. There are existing libraries that target memory types such as
>    https://github.com/memkind/memkind.  These are known to suffer
>    from SIGSEGV's when memory is low on targeted memory "kinds" that
>    span more than one node.  The MCDRAM on a Xeon Phi in "Cluster on
>    Die" mode is an example of this.
> 2. Volatile-use persistent memory users want to have a memory policy
>    which is targeted at either "cheap and slow" (PMEM) or "expensive and
>    fast" (DRAM).  However, they do not want to experience allocation
>    failures when the targeted type is unavailable.
> 3. Allocate-then-run.  Generally, we let the process scheduler decide
>    on which physical CPU to run a task.  That location provides a
>    default allocation policy, and memory availability is not generally
>    considered when placing tasks.  For situations where memory is
>    valuable and constrained, some users want to allocate memory first,
>    *then* allocate close compute resources to the allocation.  This is
>    the reverse of the normal (CPU) model.  Accelerators such as GPUs
>    that operate on core-mm-managed memory are interested in this model.
> 
> A check is added in sanitize_mpol_flags() to not permit 'prefer_many'
> policy to be used for now, and will be removed in later patch after all
> implementations for 'prefer_many' are ready, as suggested by Michal Hocko.
> 
> [Michal Hocko: suggest to refine policy_node/policy_nodemask handling]
> Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
> Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
-- 
Michal Hocko
SUSE Labs
