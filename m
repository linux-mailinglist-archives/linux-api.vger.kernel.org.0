Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB031E797
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 09:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBRIoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 03:44:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:58776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhBRIko (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 18 Feb 2021 03:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613637576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DBMYblLrEsQFhRN2m635S4SLoXw63tSAA1O97qFL/Lk=;
        b=L8nxBdkVMggG4RAKrtj7i1lnGx9S/EB9xBKz8XnvlCwput6yZwsnyUVvbdW08oCzG06to/
        zT4dvdgwKVGYk1GGDyTPtG5yREGSaSbEqpl7TezHgt0/olDW9edM/evTPpYdB68Pot+lLm
        xP/GfxLTVp63i+CLPy234a4btk5hgKI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 463C1AC6E;
        Thu, 18 Feb 2021 08:39:36 +0000 (UTC)
Date:   Thu, 18 Feb 2021 09:39:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC] Hugepage collapse in process context
Message-ID: <YC4nx/qChwNdfLmB@dhcp22.suse.cz>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
 <9B5BFA9A-E945-4665-B335-A0B8E36D4463@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B5BFA9A-E945-4665-B335-A0B8E36D4463@fb.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 18-02-21 08:11:13, Song Liu wrote:
> 
> 
> > On Feb 16, 2021, at 8:24 PM, David Rientjes <rientjes@google.com> wrote:
> > 
> > Hi everybody,
> > 
> > Khugepaged is slow by default, it scans at most 4096 pages every 10s.  
> > That's normally fine as a system-wide setting, but some applications would 
> > benefit from a more aggressive approach (as long as they are willing to 
> > pay for it).
> > 
> > Instead of adding priorities for eligible ranges of memory to khugepaged, 
> > temporarily speeding khugepaged up for the whole system, or sharding its 
> > work for memory belonging to a certain process, one approach would be to 
> > allow userspace to induce hugepage collapse.
> > 
> > The benefit to this approach would be that this is done in process context 
> > so its cpu is charged to the process that is inducing the collapse.  
> > Khugepaged is not involved.
> > 
> > Idea was to allow userspace to induce hugepage collapse through the new 
> > process_madvise() call.  This allows us to collapse hugepages on behalf of 
> > current or another process for a vectored set of ranges.
> > 
> > This could be done through a new process_madvise() mode *or* it could be a 
> > flag to MADV_HUGEPAGE since process_madvise() allows for a flag parameter 
> > to be passed.  For example, MADV_F_SYNC.
> > 
> > When done, this madvise call would allocate a hugepage on the right node 
> > and attempt to do the collapse in process context just as khugepaged would 
> > otherwise do.
> 
> This is very interesting idea. One question, IIUC, the user process will 
> block until all small pages in given ranges are collapsed into THPs.

Do you mean that PF would be blocked due to exclusive mmap_sem? Or is
there anything else oyu have in mind?

> What 
> would happen if the memory is so fragmented that we cannot allocate that 
> many huge pages? Do we need some fail over mechanisms? 

IIRC khugepaged preallocates pages without holding any locks and I would
expect the same will be done for madvise as well.
-- 
Michal Hocko
SUSE Labs
