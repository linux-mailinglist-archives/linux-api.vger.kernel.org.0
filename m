Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B946461ABA
	for <lists+linux-api@lfdr.de>; Mon, 29 Nov 2021 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbhK2PY5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Nov 2021 10:24:57 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbhK2PWy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Nov 2021 10:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4417C21709;
        Mon, 29 Nov 2021 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638199176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMkuQ8zHorPAG7ibxnbSayAc3aKRfc15yBbo3tHNue4=;
        b=TD8sHqpIcNmZ7HPIyaJNSUtIW59QZ8Sq9RSyfvFqQ8J3M6VlnJUQ2tJqACOQ68OsbffdTq
        MFrLl17OP6Gr3R7vbtg9oqVdJ7JcvrhjldqUgNUYcD8FPY1GjXdLti5RD6wUEt/Ow6A3X5
        R7V6nPT5pSqtfCcplVyl3di+0VwiYZ8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0813CA3B84;
        Mon, 29 Nov 2021 15:19:35 +0000 (UTC)
Date:   Mon, 29 Nov 2021 16:19:35 +0100
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
Message-ID: <YaTvh+B4pf7oTFme@dhcp22.suse.cz>
References: <20211116064238.727454-1-aneesh.kumar@linux.ibm.com>
 <20211116064238.727454-3-aneesh.kumar@linux.ibm.com>
 <YaSsR0z6GN07qyH7@dhcp22.suse.cz>
 <87fsrf1bpu.fsf@linux.ibm.com>
 <YaTLVCKl9t5RCfQR@dhcp22.suse.cz>
 <8735nfcbvp.fsf@linux.ibm.com>
 <YaTpNJep2OXBkRLe@dhcp22.suse.cz>
 <87zgpnatza.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgpnatza.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 29-11-21 20:29:05, Aneesh Kumar K.V wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 29-11-21 19:17:06, Aneesh Kumar K.V wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> > [...]
> >> > But you do allow to set the home node also for other policies and that
> >> > means that a default MPOL_INTERLEAVE would be different from the one
> >> > with home_node set up even though they behave exactly the same.
> >> 
> >> I agree that there is no error returned if we try to set the home_node
> >> for other memory policies. But there should not be any behaviour
> >> differences. We ignore home_node for policies other than BIND and
> >> PREFERRED_MANY.
> >> 
> >> The reason I avoided erroring out for other policies was to simplify the
> >> error handling.
> >
> > But this leads to a future extensions problems. How do you tell whether
> > a specific policy has a support for home node?
> >
> >> For example, for a range of addr with a mix of memory
> >> policy MPOLD_BIND and MPOL_INTERLEAVE what should be the state after the
> >> above system call?
> >
> > Do we even allow to combinate different memory policies?
> >
> >> We could say, we ignore setting home_node for vma
> >> with policy MPOL_INTERLEAVE and leave the home node set for vma with
> >> policy MPOL_BIND. Or should we make the system call return error also
> >> undoing the changes done for vmas for which we have set the home_node?
> >
> > The error behavior is really nasty with the existing behavior. The
> > caller has no way to tell which vmas have been updated. The only way is
> > to query the state. So if we return an error because of an incompatible
> > mempolicy in place we are not much worse than now. If the "error" is
> > silent then we establish a dependency on the specific implementation.
> 
> How about
> 	for (; vma && vma->vm_start < end;  vma = vma->vm_next) {
> 
> 		vmstart = max(start, vma->vm_start);
> 		vmend   = min(end, vma->vm_end);
> 		new = mpol_dup(vma_policy(vma));
> 		if (IS_ERR(new)) {
> 			err = PTR_ERR(new);
> 			break;
> 		}
> 		/*
> 		 * Only update home node if there is an existing vma policy
> 		 */
> 		if (!new)
> 			continue;
> 
> 		/*
> 		 * If any vma in the range got policy other than MPOL_BIND
> 		 * or MPOL_PREFERRED_MANY we return error. We don't reset
> 		 * the home node for vmas we already updated before.
> 		 */
> 		if (new->mode != MPOL_BIND && new->mode != MPOL_PREFERRED_MANY) {
> 			err = -EINVAL;
> 			break;
> 		}

Maybe ENOSUPP to make the error handling slightly easier.
-- 
Michal Hocko
SUSE Labs
