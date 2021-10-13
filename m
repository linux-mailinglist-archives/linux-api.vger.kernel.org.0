Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B642C090
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhJMMw3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Oct 2021 08:52:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhJMMw2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Oct 2021 08:52:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 846512012C;
        Wed, 13 Oct 2021 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634129424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0oM2bcULqvUCqAd5NlAA+skVcS0RHEYYVlMraivQH4=;
        b=JoNu3L0wxTN+jxb537qpOnMHY+Cs0hVmHnRtUOi+P/pjYtWTUKwVk4Zrc2QAZqDuNI6IUY
        TGpzmxELzaCzqRKMN7et9CAThIBE7r+scg6OKM4AweaS7d42XXQ3BG2YwjRXKBMOczHHSc
        WqXRGeYhG9M5ftpmF4rNEgIH4Ngo6Jo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15503A3B8F;
        Wed, 13 Oct 2021 12:50:19 +0000 (UTC)
Date:   Wed, 13 Oct 2021 14:50:22 +0200
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
Subject: Re: [RFC PATCH] mm/mempolicy: add MPOL_PREFERRED_STRICT memory policy
Message-ID: <YWbWDlpQzQ9GC+B6@dhcp22.suse.cz>
References: <20211013094539.962357-1-aneesh.kumar@linux.ibm.com>
 <YWa4FoicH0VztGTl@dhcp22.suse.cz>
 <YWa5geHLIPe2aUxB@dhcp22.suse.cz>
 <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4399a215-296f-e880-c5f4-8065ab13d210@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 13-10-21 18:05:49, Aneesh Kumar K.V wrote:
> On 10/13/21 16:18, Michal Hocko wrote:
> > On Wed 13-10-21 12:42:34, Michal Hocko wrote:
> > > [Cc linux-api]
> > > 
> > > On Wed 13-10-21 15:15:39, Aneesh Kumar K.V wrote:
> > > > This mempolicy mode can be used with either the set_mempolicy(2)
> > > > or mbind(2) interfaces.  Like the MPOL_PREFERRED interface, it
> > > > allows an application to set a preference node from which the kernel
> > > > will fulfill memory allocation requests. Unlike the MPOL_PREFERRED mode,
> > > > it takes a set of nodes. The nodes in the nodemask are used as fallback
> > > > allocation nodes if memory is not available on the preferred node.
> > > > Unlike MPOL_PREFERRED_MANY, it will not fall back memory allocations
> > > > to all nodes in the system. Like the MPOL_BIND interface, it works over a
> > > > set of nodes and will cause a SIGSEGV or invoke the OOM killer if
> > > > memory is not available on those preferred nodes.
> > > > 
> > > > This patch helps applications to hint a memory allocation preference node
> > > > and fallback to _only_ a set of nodes if the memory is not available
> > > > on the preferred node.  Fallback allocation is attempted from the node which is
> > > > nearest to the preferred node.
> > > > 
> > > > This new memory policy helps applications to have explicit control on slow
> > > > memory allocation and avoids default fallback to slow memory NUMA nodes.
> > > > The difference with MPOL_BIND is the ability to specify a preferred node
> > > > which is the first node in the nodemask argument passed.
> > 
> > I am sorry but I do not understand the semantic diffrence from
> > MPOL_BIND. Could you be more specific please?
> > 
> 
> 
> 
> MPOL_BIND
> 	This mode specifies that memory must come from the set of
> 	nodes specified by the policy.  Memory will be allocated from
> 	the node in the set with sufficient free memory that is
> 	closest to the node where the allocation takes place.
> 
> 
> MPOL_PREFERRED_STRICT
> 	This mode specifies that the allocation should be attempted
> 	from the first node specified in the nodemask of the policy.
> 	If that allocation fails, the kernel will search other nodes
> 	in the nodemask, in order of increasing distance from the
> 	preferred node based on information provided by the platform   firmware.
> 
> The difference is the ability to specify the preferred node as the first
> node in the nodemask and all fallback allocations are based on the distance
> from the preferred node. With MPOL_BIND they base based on the node where
> the allocation takes place.

OK, this makes it more clear. Thanks! 

I am still not sure the semantic makes sense though. Why should
the lowest node in the nodemask have any special meaning? What if it is
a node with a higher number that somebody preferes to start with?
-- 
Michal Hocko
SUSE Labs
