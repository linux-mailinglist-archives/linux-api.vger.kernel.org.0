Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D9C30F92
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaODf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 10:03:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:55636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaODf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 10:03:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C57EDAF52;
        Fri, 31 May 2019 14:03:32 +0000 (UTC)
Date:   Fri, 31 May 2019 16:03:32 +0200
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
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 1/6] mm: introduce MADV_COLD
Message-ID: <20190531140332.GT6896@dhcp22.suse.cz>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz>
 <20190531133904.GC195463@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531133904.GC195463@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 31-05-19 22:39:04, Minchan Kim wrote:
> On Fri, May 31, 2019 at 10:47:52AM +0200, Michal Hocko wrote:
> > On Fri 31-05-19 15:43:08, Minchan Kim wrote:
> > > When a process expects no accesses to a certain memory range, it could
> > > give a hint to kernel that the pages can be reclaimed when memory pressure
> > > happens but data should be preserved for future use.  This could reduce
> > > workingset eviction so it ends up increasing performance.
> > > 
> > > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > > MADV_COLD can be used by a process to mark a memory range as not expected
> > > to be used in the near future. The hint can help kernel in deciding which
> > > pages to evict early during memory pressure.
> > > 
> > > Internally, it works via deactivating pages from active list to inactive's
> > > head if the page is private because inactive list could be full of
> > > used-once pages which are first candidate for the reclaiming and that's a
> > > reason why MADV_FREE move pages to head of inactive LRU list. Therefore,
> > > if the memory pressure happens, they will be reclaimed earlier than other
> > > active pages unless there is no access until the time.
> > 
> > [I am intentionally not looking at the implementation because below
> > points should be clear from the changelog - sorry about nagging ;)]
> > 
> > What kind of pages can be deactivated? Anonymous/File backed.
> > Private/shared? If shared, are there any restrictions?
> 
> Both file and private pages could be deactived from each active LRU
> to each inactive LRU if the page has one map_count. In other words,
> 
>     if (page_mapcount(page) <= 1)
>         deactivate_page(page);

Why do we restrict to pages that are single mapped?

> > Are there any restrictions on mappings? E.g. what would be an effect of
> > this operation on hugetlbfs mapping?
> 
> VM_LOCKED|VM_HUGETLB|VM_PFNMAP vma will be skipped like MADV_FREE|DONTNEED

OK documenting that this is restricted to the same vmas as MADV_FREE|DONTNEED
is really useful to mention.

> 
> > 
> > Also you are talking about inactive LRU but what kind of LRU is that? Is
> > it the anonymous LRU? If yes, don't we have the same problem as with the
> 
> active file page -> inactive file LRU
> active anon page -> inacdtive anon LRU
> 
> > early MADV_FREE implementation when enough page cache causes that
> > deactivated anonymous memory doesn't get reclaimed anytime soon. Or
> > worse never when there is no swap available?
> 
> I think MADV_COLD is a little bit different symantic with MAVD_FREE.
> MADV_FREE means it's okay to discard when the memory pressure because
> the content of the page is *garbage*. Furthemore, freeing such pages is
> almost zero overhead since we don't need to swap out and access
> afterward causes minor fault. Thus, it would make sense to put those
> freeable pages in inactive file LRU to compete other used-once pages.
> 
> However, MADV_COLD doesn't means it's a garbage and freeing requires
> swap out/swap in afterward. So, it would be better to move inactive
> anon's LRU list, not file LRU. Furthermore, it would avoid unnecessary
> scanning of those cold anonymous if system doesn't have a swap device.

Please document this, if this is really a desirable semantic because
then you have the same set of problems as we've had with the early
MADV_FREE implementation mentioned above.

-- 
Michal Hocko
SUSE Labs
