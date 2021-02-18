Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9431E9B9
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBRMZN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 07:25:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:52820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhBRKZZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 18 Feb 2021 05:25:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613642491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yHdRd/hxWaiH12nTXuW5kLIB588HE7uAVphy/I3/zs=;
        b=li4tdSAr9XOarrgJVgwIH7v+hf4PF6ifZU/lSDeW2Nj2b7c8Y2zoaBkAzMXDax465ArmjC
        /YNWCCKwM+edMaPdJ3ppGXtbbBp5rPzn5Pfjo17pVnUGEWLS13+ZevY60x7/5McTlO6f9b
        e7/B4wjet7hrQVdEhjYgd39yyxgFebQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A044ADDC;
        Thu, 18 Feb 2021 10:01:31 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:01:30 +0100
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
Message-ID: <YC46+maSFBiWqU0o@dhcp22.suse.cz>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
 <9B5BFA9A-E945-4665-B335-A0B8E36D4463@fb.com>
 <YC4nx/qChwNdfLmB@dhcp22.suse.cz>
 <97A31D94-671B-4400-8114-9039B28E54A7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97A31D94-671B-4400-8114-9039B28E54A7@fb.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 18-02-21 09:53:25, Song Liu wrote:
> 
> 
> > On Feb 18, 2021, at 12:39 AM, Michal Hocko <mhocko@suse.com> wrote:
> > 
> > On Thu 18-02-21 08:11:13, Song Liu wrote:
> >> 
> >> 
> >>> On Feb 16, 2021, at 8:24 PM, David Rientjes <rientjes@google.com> wrote:
> >>> 
> >>> Hi everybody,
> >>> 
> >>> Khugepaged is slow by default, it scans at most 4096 pages every 10s.  
> >>> That's normally fine as a system-wide setting, but some applications would 
> >>> benefit from a more aggressive approach (as long as they are willing to 
> >>> pay for it).
> >>> 
> >>> Instead of adding priorities for eligible ranges of memory to khugepaged, 
> >>> temporarily speeding khugepaged up for the whole system, or sharding its 
> >>> work for memory belonging to a certain process, one approach would be to 
> >>> allow userspace to induce hugepage collapse.
> >>> 
> >>> The benefit to this approach would be that this is done in process context 
> >>> so its cpu is charged to the process that is inducing the collapse.  
> >>> Khugepaged is not involved.
> >>> 
> >>> Idea was to allow userspace to induce hugepage collapse through the new 
> >>> process_madvise() call.  This allows us to collapse hugepages on behalf of 
> >>> current or another process for a vectored set of ranges.
> >>> 
> >>> This could be done through a new process_madvise() mode *or* it could be a 
> >>> flag to MADV_HUGEPAGE since process_madvise() allows for a flag parameter 
> >>> to be passed.  For example, MADV_F_SYNC.
> >>> 
> >>> When done, this madvise call would allocate a hugepage on the right node 
> >>> and attempt to do the collapse in process context just as khugepaged would 
> >>> otherwise do.
> >> 
> >> This is very interesting idea. One question, IIUC, the user process will 
> >> block until all small pages in given ranges are collapsed into THPs.
> > 
> > Do you mean that PF would be blocked due to exclusive mmap_sem? Or is
> > there anything else oyu have in mind?
> 
> I was thinking about memory defragmentation when the application asks for
> many THPs. Say the application looks like
> 
> main()
> {
> 	malloc();
> 	madvise(HUGE);
> 	process_madvise();
> 	
> 	/* start doing work */
> }
> 
> IIUC, when process_madvise() finishes, the THPs should be ready. However, 
> if defragmentation takes a long time, the process will wait in process_madvise().

OK, I see. The operation is definitely free which is to be expected. You
can do the same from a thread which can spend time collapsing THPs.
There are still internal resources that might block others - e.g. the
above mentioned mmap_sem. We can try hard to reduce the lock time but
this is unlikely to be completely free of any interruption of the
workload.
-- 
Michal Hocko
SUSE Labs
