Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE98931D680
	for <lists+linux-api@lfdr.de>; Wed, 17 Feb 2021 09:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhBQIWW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Feb 2021 03:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhBQIWV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 17 Feb 2021 03:22:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613550094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+AtVtNBB4nXDoZsK/9xd9pLXgJM8teFm4x1vJhLij10=;
        b=Y9Ln5+k1Q/qEgc6nUUNieToU3pSXz895sM6C41AVkL2IpyIhrw17TYfKQhwtwe88DXVfp0
        8tgvNzgb4hdKaodkjJ3RE+dwMAKzsGtoYXObPBvqJq17B9pqu5tnZ1mXpLBoE7OTVVHpjg
        3IxoF5uDcnqBWKHiZS2BTcwfVNkSQyM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AD89B923;
        Wed, 17 Feb 2021 08:21:34 +0000 (UTC)
Date:   Wed, 17 Feb 2021 09:21:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC] Hugepage collapse in process context
Message-ID: <YCzSDPbBsksCX5zP@dhcp22.suse.cz>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api]

On Tue 16-02-21 20:24:16, David Rientjes wrote:
> Hi everybody,
> 
> Khugepaged is slow by default, it scans at most 4096 pages every 10s.  
> That's normally fine as a system-wide setting, but some applications would 
> benefit from a more aggressive approach (as long as they are willing to 
> pay for it).
> 
> Instead of adding priorities for eligible ranges of memory to khugepaged, 
> temporarily speeding khugepaged up for the whole system, or sharding its 
> work for memory belonging to a certain process, one approach would be to 
> allow userspace to induce hugepage collapse.
> 
> The benefit to this approach would be that this is done in process context 
> so its cpu is charged to the process that is inducing the collapse.  
> Khugepaged is not involved.

Yes, this makes a lot of sense to me.

> Idea was to allow userspace to induce hugepage collapse through the new 
> process_madvise() call.  This allows us to collapse hugepages on behalf of 
> current or another process for a vectored set of ranges.

Yes, madvise sounds like a good fit for the purpose.

> This could be done through a new process_madvise() mode *or* it could be a 
> flag to MADV_HUGEPAGE since process_madvise() allows for a flag parameter 
> to be passed.  For example, MADV_F_SYNC.

Would this MADV_F_SYNC be applicable to other madvise modes? Most
existing madvise modes do not seem to make much sense. We can argue that
MADV_PAGEOUT would guarantee the range was indeed reclaimed but I am not
sure we want to provide such a strong semantic because it can limit
future reclaim optimizations.

To me MADV_HUGEPAGE_COLLAPSE sounds like the easiest way forward.
-- 
Michal Hocko
SUSE Labs
