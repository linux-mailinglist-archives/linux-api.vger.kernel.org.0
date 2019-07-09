Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884C863359
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2019 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGIJTt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Jul 2019 05:19:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfGIJTt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 9 Jul 2019 05:19:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37AAFB127;
        Tue,  9 Jul 2019 09:19:47 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:19:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 1/5] mm: introduce MADV_COLD
Message-ID: <20190709091945.GD26380@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-2-minchan@kernel.org>
 <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
 <20190627140203.GB5303@dhcp22.suse.cz>
 <d9341eb3-08eb-3c2b-9786-00b8a4f59953@intel.com>
 <20190627145302.GC5303@dhcp22.suse.cz>
 <20190627235618.GC33052@google.com>
 <20190701073500.GA136163@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701073500.GA136163@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 01-07-19 16:35:00, Minchan Kim wrote:
> >From 39df9f94e6204b8893f3f3feb692745657392657 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Fri, 24 May 2019 13:47:54 +0900
> Subject: [PATCH v3 1/5] mm: introduce MADV_COLD
> 
> When a process expects no accesses to a certain memory range, it could
> give a hint to kernel that the pages can be reclaimed when memory pressure
> happens but data should be preserved for future use.  This could reduce
> workingset eviction so it ends up increasing performance.
> 
> This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> MADV_COLD can be used by a process to mark a memory range as not expected
> to be used in the near future. The hint can help kernel in deciding which
> pages to evict early during memory pressure.
> 
> It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> 
> 	active file page -> inactive file LRU
> 	active anon page -> inacdtive anon LRU
> 
> Unlike MADV_FREE, it doesn't move active anonymous pages to inactive
> file LRU's head because MADV_COLD is a little bit different symantic.
> MADV_FREE means it's okay to discard when the memory pressure because
> the content of the page is *garbage* so freeing such pages is almost zero
> overhead since we don't need to swap out and access afterward causes just
> minor fault. Thus, it would make sense to put those freeable pages in
> inactive file LRU to compete other used-once pages. It makes sense for
> implmentaion point of view, too because it's not swapbacked memory any
> longer until it would be re-dirtied. Even, it could give a bonus to make
> them be reclaimed on swapless system. However, MADV_COLD doesn't mean
> garbage so reclaiming them requires swap-out/in in the end so it's bigger
> cost. Since we have designed VM LRU aging based on cost-model, anonymous
> cold pages would be better to position inactive anon's LRU list, not file
> LRU. Furthermore, it would help to avoid unnecessary scanning if system
> doesn't have a swap device. Let's start simpler way without adding
> complexity at this moment. However, keep in mind, too that it's a caveat
> that workloads with a lot of pages cache are likely to ignore MADV_COLD
> on anonymous memory because we rarely age anonymous LRU lists.
> 
> * man-page material
> 
> MADV_COLD (since Linux x.x)
> 
> Pages in the specified regions will be treated as less-recently-accessed
> compared to pages in the system with similar access frequencies.
> In contrast to MADV_FREE, the contents of the region are preserved
> regardless of subsequent writes to pages.
> 
> MADV_COLD cannot be applied to locked pages, Huge TLB pages, or VM_PFNMAP
> pages.
> 
> * v2
>  * add up the warn with lots of page cache workload - mhocko
>  * add man page stuff - dave
> 
> * v1
>  * remove page_mapcount filter - hannes, mhocko
>  * remove idle page handling - joelaf
> 
> * RFCv2
>  * add more description - mhocko
> 
> * RFCv1
>  * renaming from MADV_COOL to MADV_COLD - hannes
> 
> * internal review
>  * use clear_page_youn in deactivate_page - joelaf
>  * Revise the description - surenb
>  * Renaming from MADV_WARM to MADV_COOL - surenb
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

OK, looks reasonable to me. THP part still gives me a head spin but it
is consistent with madv_free part so I will trust that all weird corner
cases are already caught there.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
