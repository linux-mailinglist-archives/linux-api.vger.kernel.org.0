Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA81461579
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhK2Mu1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 07:50:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56100 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377568AbhK2Ms1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 07:48:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4597E212CC;
        Mon, 29 Nov 2021 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638189909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DGx2F4uS/pziYriS2f2PCTMh0P5KzZg0RiHi7rx8Lo=;
        b=KdER+TEQ0CvuQC+rZoXv6Gbp2Vct895KSda4wfychCNVz/+t9Cx9XdV30Q6p3IJAAEBvM8
        PgU22UyvNJ2JJB0lETuR8A8qMMyyVdKGKUhbHl6yCox0EvDzBAd+p5eao9V/C1ZkAZpb9c
        TVR8emAWkJXEn7l8fGcOPOftaAS8bwU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F804A3B83;
        Mon, 29 Nov 2021 12:45:09 +0000 (UTC)
Date:   Mon, 29 Nov 2021 13:45:08 +0100
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
Message-ID: <YaTLVCKl9t5RCfQR@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <YaSsR0z6GN07qyH7@dhcp22.suse.cz>
 <87fsrf1bpu.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsrf1bpu.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 29-11-21 16:16:05, Aneesh Kumar K.V wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Tue 16-11-21 12:12:37, Aneesh Kumar K.V wrote:
[...]
> >> +SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
> >> +		unsigned long, home_node, unsigned long, flags)
> >> +{
> >> +	struct mm_struct *mm = current->mm;
> >> +	struct vm_area_struct *vma;
> >> +	struct mempolicy *new;
> >> +	unsigned long vmstart;
> >> +	unsigned long vmend;
> >> +	unsigned long end;
> >> +	int err = -ENOENT;
> >> +
> >> +	if (start & ~PAGE_MASK)
> >> +		return -EINVAL;
> >> +	/*
> >> +	 * flags is used for future extension if any.
> >> +	 */
> >> +	if (flags != 0)
> >> +		return -EINVAL;
> >> +
> >> +	if (!node_online(home_node))
> >> +		return -EINVAL;
> >
> > You really want to check the home_node before dereferencing the mask.
> >
> 
> Any reason why we want to check for home node first?

Because the given node is an index to node_states[N_ONLINE] bitmap. I do
not think we do range checking there.

> >> +	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
> >> +	end = start + len;
> >> +
> >> +	if (end < start)
> >> +		return -EINVAL;
> >> +	if (end == start)
> >> +		return 0;
> >> +	mmap_write_lock(mm);
> >> +	vma = find_vma(mm, start);
> >> +	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
> >> +
> >> +		vmstart = max(start, vma->vm_start);
> >> +		vmend   = min(end, vma->vm_end);
> >> +		new = mpol_dup(vma_policy(vma));
> >> +		if (IS_ERR(new)) {
> >> +			err = PTR_ERR(new);
> >> +			break;
> >> +		}
> >> +		/*
> >> +		 * Only update home node if there is an existing vma policy
> >> +		 */
> >> +		if (!new)
> >> +			continue;
> >
> > Your changelog only mentions MPOL_BIND and MPOL_PREFERRED_MANY as
> > supported but you seem to be applying the home node to all existing
> > policieso
> 
> 
> The restriction is done in policy_node. 
> 
> @@ -1801,6 +1856,11 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
> 		WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
> 	}
> 
> +	if ((policy->mode == MPOL_BIND ||
> +	     policy->mode == MPOL_PREFERRED_MANY) &&
> +	    policy->home_node != NUMA_NO_NODE)
> +		return policy->home_node;
> +
> 	return nd;
>  }

But you do allow to set the home node also for other policies and that
means that a default MPOL_INTERLEAVE would be different from the one
with home_node set up even though they behave exactly the same.
-- 
Michal Hocko
SUSE Labs
