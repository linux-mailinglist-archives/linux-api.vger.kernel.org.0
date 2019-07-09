Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61A633BB
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2019 11:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGIJzW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Jul 2019 05:55:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbfGIJzW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 9 Jul 2019 05:55:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7524CAD3E;
        Tue,  9 Jul 2019 09:55:20 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:55:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190709095518.GF26380@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-5-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627115405.255259-5-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 27-06-19 20:54:04, Minchan Kim wrote:
> When a process expects no accesses to a certain memory range
> for a long time, it could hint kernel that the pages can be
> reclaimed instantly but data should be preserved for future use.
> This could reduce workingset eviction so it ends up increasing
> performance.
> 
> This patch introduces the new MADV_PAGEOUT hint to madvise(2)
> syscall. MADV_PAGEOUT can be used by a process to mark a memory
> range as not expected to be used for a long time so that kernel
> reclaims *any LRU* pages instantly. The hint can help kernel in
> deciding which pages to evict proactively.
> 
> - man-page material
> 
> MADV_PAGEOUT (since Linux x.x)
> 
> Do not expect access in the near future so pages in the specified
> regions could be reclaimed instantly regardless of memory pressure.
> Thus, access in the range after successful operation could cause
> major page fault but never lose the up-to-date contents unlike
> MADV_DONTNEED.

> It works for only private anonymous mappings and
> non-anonymous mappings that belong to files that the calling process
> could successfully open for writing; otherwise, it could be used for
> sidechannel attack.

I would rephrase this way:
"
Pages belonging to a shared mapping are only processed if a write access
is allowed for the calling process.
"

I wouldn't really mention side channel attacks for a man page. You can
mention can_do_mincore check and the side channel prevention in the
changelog that is not aimed for the man page.

> MADV_PAGEOUT cannot be applied to locked pages, Huge TLB pages, or
> VM_PFNMAP pages.
> 
> * v2
>  * add comment about SWAP_CLUSTER_MAX - mhocko
>  * add permission check to prevent sidechannel attack - mhocko
>  * add man page stuff - dave
> 
> * v1
>  * change pte to old and rely on the other's reference - hannes
>  * remove page_mapcount to check shared page - mhocko
> 
> * RFC v2
>  * make reclaim_pages simple via factoring out isolate logic - hannes
> 
> * RFCv1
>  * rename from MADV_COLD to MADV_PAGEOUT - hannes
>  * bail out if process is being killed - Hillf
>  * fix reclaim_pages bugs - Hillf
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---


I am still not convinced about the SWAP_CLUSTER_MAX batching and the
udnerlying OOM argument. Is one pmd worth of pages really an OOM risk?
Sure you can have many invocations in parallel and that would add on
but the same might happen with SWAP_CLUSTER_MAX. So I would just remove
the batching for now and think of it only if we really see this being a
problem for real. Unless you feel really strong about this, of course.

Anyway the patch looks ok to me otherwise.

Acked-by: Michal Hocko <mhocko@suse.co>
-- 
Michal Hocko
SUSE Labs
