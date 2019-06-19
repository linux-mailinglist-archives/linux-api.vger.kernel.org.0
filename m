Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69B24B96F
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 15:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfFSNJs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 09:09:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbfFSNJr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 19 Jun 2019 09:09:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53761B002;
        Wed, 19 Jun 2019 13:09:46 +0000 (UTC)
Date:   Wed, 19 Jun 2019 15:09:44 +0200
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
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 2/5] mm: change PAGEREF_RECLAIM_CLEAN with
 PAGE_REFRECLAIM
Message-ID: <20190619130943.GP2968@dhcp22.suse.cz>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-3-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610111252.239156-3-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 10-06-19 20:12:49, Minchan Kim wrote:
> The local variable references in shrink_page_list is PAGEREF_RECLAIM_CLEAN
> as default. It is for preventing to reclaim dirty pages when CMA try to
> migrate pages. Strictly speaking, we don't need it because CMA didn't allow
> to write out by .may_writepage = 0 in reclaim_clean_pages_from_list.
> 
> Moreover, it has a problem to prevent anonymous pages's swap out even
> though force_reclaim = true in shrink_page_list on upcoming patch.
> So this patch makes references's default value to PAGEREF_RECLAIM and
> rename force_reclaim with ignore_references to make it more clear.
> 
> This is a preparatory work for next patch.
> 
> * RFCv1
>  * use ignore_referecnes as parameter name - hannes
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

The code path is quite tricky to follow but the patch looks OK to me.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 84dcb651d05c..0973a46a0472 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1102,7 +1102,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  				      struct scan_control *sc,
>  				      enum ttu_flags ttu_flags,
>  				      struct reclaim_stat *stat,
> -				      bool force_reclaim)
> +				      bool ignore_references)
>  {
>  	LIST_HEAD(ret_pages);
>  	LIST_HEAD(free_pages);
> @@ -1116,7 +1116,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  		struct address_space *mapping;
>  		struct page *page;
>  		int may_enter_fs;
> -		enum page_references references = PAGEREF_RECLAIM_CLEAN;
> +		enum page_references references = PAGEREF_RECLAIM;
>  		bool dirty, writeback;
>  		unsigned int nr_pages;
>  
> @@ -1247,7 +1247,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  			}
>  		}
>  
> -		if (!force_reclaim)
> +		if (!ignore_references)
>  			references = page_check_references(page, sc);
>  
>  		switch (references) {
> -- 
> 2.22.0.rc2.383.gf4fbbf30c2-goog

-- 
Michal Hocko
SUSE Labs
