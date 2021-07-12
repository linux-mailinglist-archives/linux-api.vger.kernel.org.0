Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CC3C4D4E
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 12:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbhGLHMi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 03:12:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242365AbhGLHGo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 03:06:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6B9C21E2C;
        Mon, 12 Jul 2021 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626073430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1DJfBUe8rEk50R8LESRZ11BjVW4h1hks7CE3pHC4EFA=;
        b=H1s3SS9dzvFYmLW+tEtiSF1OY1Ya7cPZ1R7QlxQR9htR5SDSm+mq52Nv8X9Tv203qWUzeZ
        48lWz6Zkefx+xq5/5Rnjv3muPyaKgaXCR83Gqu3TSmNWpxsyJ6zWzCgDqON1l3LwGnEmlo
        W09+JeIm1H+NIELY4insKVEQdfwT670=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E140A4457;
        Mon, 12 Jul 2021 07:03:50 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:03:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-ID: <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api]

On Fri 09-07-21 10:50:48, Evan Green wrote:
> Currently it's not possible to enable hibernation without also enabling
> generic swap for a given swap area. These two use cases are not the
> same. For example there may be users who want to enable hibernation,
> but whose drives don't have the write endurance for generic swap
> activities.
> 
> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> generic swapping to it. This region can still be wired up for use in
> suspend-to-disk activities, but will never have regular pages swapped to
> it.

Could you expand some more on why a strict exclusion is really
necessary? I do understand that one might not want to have swap storage
available all the time but considering that swapon is really a light
operation so something like the following should be a reasonable
workaround, no?
	swapon storage/file
	s2disk
	swapoff storage

> Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
> under SwapTotal and SwapFree, since they are not usable as general swap.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Changes in v2:
>  - NOSWAP regions should not contribute to Swap stats in /proc/meminfo.
>    [David]
>  - Adjusted comment of SWAP_FLAG_NOSWAP [Pavel]
>  - Note: Opted not to take Pavel's tag since enough has changed in this
>    revision to warrant another look.
>  - Call swap_entry_free() in swap_free to avoid NOSWAP leaks back into
>    the general pool via swap_slots_cache [me].
> 
>  include/linux/swap.h |  4 +++-
>  mm/swapfile.c        | 52 +++++++++++++++++++++++++++++++-------------
>  2 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 6f5a43251593c8..995466c9f16a76 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -28,10 +28,11 @@ struct pagevec;
>  #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */
>  #define SWAP_FLAG_DISCARD_ONCE	0x20000 /* discard swap area at swapon-time */
>  #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
> +#define SWAP_FLAG_NOSWAP	0x80000 /* use only for hibernate, not swap */
>  
>  #define SWAP_FLAGS_VALID	(SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER | \
>  				 SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | \
> -				 SWAP_FLAG_DISCARD_PAGES)
> +				 SWAP_FLAG_DISCARD_PAGES | SWAP_FLAG_NOSWAP)
>  #define SWAP_BATCH 64
>  
>  static inline int current_is_kswapd(void)
> @@ -182,6 +183,7 @@ enum {
>  	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
>  	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
>  	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
> +	SWP_NOSWAP	= (1 << 13),	/* use only for suspend, not swap */
>  					/* add others here before... */
>  	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
>  };
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1e07d1c776f2ae..d9ab39d32e55ec 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -697,7 +697,8 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
>  	if (si->inuse_pages == si->pages) {
>  		si->lowest_bit = si->max;
>  		si->highest_bit = 0;
> -		del_from_avail_list(si);
> +		if (!(si->flags & SWP_NOSWAP))
> +			del_from_avail_list(si);
>  	}
>  }
>  
> @@ -726,10 +727,12 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		bool was_full = !si->highest_bit;
>  
>  		WRITE_ONCE(si->highest_bit, end);
> -		if (was_full && (si->flags & SWP_WRITEOK))
> +		if (was_full &&
> +		    ((si->flags & (SWP_WRITEOK | SWP_NOSWAP)) == SWP_WRITEOK))
>  			add_to_avail_list(si);
>  	}
> -	atomic_long_add(nr_entries, &nr_swap_pages);
> +	if (!(si->flags & SWP_NOSWAP))
> +		atomic_long_add(nr_entries, &nr_swap_pages);
>  	si->inuse_pages -= nr_entries;
>  	if (si->flags & SWP_BLKDEV)
>  		swap_slot_free_notify =
> @@ -1078,6 +1081,9 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  			WARN(!(si->flags & SWP_WRITEOK),
>  			     "swap_info %d in list but !SWP_WRITEOK\n",
>  			     si->type);
> +			WARN((si->flags & SWP_NOSWAP),
> +			     "swap_info %d in list but SWP_NOSWAP\n",
> +			     si->type);
>  			__del_from_avail_list(si);
>  			spin_unlock(&si->lock);
>  			goto nextsi;
> @@ -1338,8 +1344,12 @@ void swap_free(swp_entry_t entry)
>  	struct swap_info_struct *p;
>  
>  	p = _swap_info_get(entry);
> -	if (p)
> -		__swap_entry_free(p, entry);
> +	if (p) {
> +		if (p->flags & SWP_NOSWAP)
> +			swap_entry_free(p, entry);
> +		else
> +			__swap_entry_free(p, entry);
> +	}
>  }
>  
>  /*
> @@ -1783,8 +1793,10 @@ swp_entry_t get_swap_page_of_type(int type)
>  
>  	/* This is called for allocating swap entry, not cache */
>  	spin_lock(&si->lock);
> -	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
> -		atomic_long_dec(&nr_swap_pages);
> +	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry)) {
> +		if (!(si->flags & SWP_NOSWAP))
> +			atomic_long_dec(&nr_swap_pages);
> +	}
>  	spin_unlock(&si->lock);
>  fail:
>  	return entry;
> @@ -2454,8 +2466,6 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
>  static void _enable_swap_info(struct swap_info_struct *p)
>  {
>  	p->flags |= SWP_WRITEOK;
> -	atomic_long_add(p->pages, &nr_swap_pages);
> -	total_swap_pages += p->pages;
>  
>  	assert_spin_locked(&swap_lock);
>  	/*
> @@ -2469,7 +2479,11 @@ static void _enable_swap_info(struct swap_info_struct *p)
>  	 * swap_info_struct.
>  	 */
>  	plist_add(&p->list, &swap_active_head);
> -	add_to_avail_list(p);
> +	if (!(p->flags & SWP_NOSWAP)) {
> +		atomic_long_add(p->pages, &nr_swap_pages);
> +		total_swap_pages += p->pages;
> +		add_to_avail_list(p);
> +	}
>  }
>  
>  static void enable_swap_info(struct swap_info_struct *p, int prio,
> @@ -2564,7 +2578,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  		spin_unlock(&swap_lock);
>  		goto out_dput;
>  	}
> -	del_from_avail_list(p);
> +	if (!(p->flags & SWP_NOSWAP))
> +		del_from_avail_list(p);
> +
>  	spin_lock(&p->lock);
>  	if (p->prio < 0) {
>  		struct swap_info_struct *si = p;
> @@ -2581,8 +2597,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  		least_priority++;
>  	}
>  	plist_del(&p->list, &swap_active_head);
> -	atomic_long_sub(p->pages, &nr_swap_pages);
> -	total_swap_pages -= p->pages;
> +	if (!(p->flags & SWP_NOSWAP)) {
> +		atomic_long_sub(p->pages, &nr_swap_pages);
> +		total_swap_pages -= p->pages;
> +	}
>  	p->flags &= ~SWP_WRITEOK;
>  	spin_unlock(&p->lock);
>  	spin_unlock(&swap_lock);
> @@ -3329,16 +3347,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	if (swap_flags & SWAP_FLAG_PREFER)
>  		prio =
>  		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
> +
> +	if (swap_flags & SWAP_FLAG_NOSWAP)
> +		p->flags |= SWP_NOSWAP;
>  	enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
>  
> -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
> +	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s%s\n",
>  		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
>  		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
>  		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
>  		(p->flags & SWP_DISCARDABLE) ? "D" : "",
>  		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
>  		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> -		(frontswap_map) ? "FS" : "");
> +		(frontswap_map) ? "FS" : "",
> +		(p->flags & SWP_NOSWAP) ? "N" : "");
>  
>  	mutex_unlock(&swapon_mutex);
>  	atomic_inc(&proc_poll_event);
> -- 
> 2.31.0

-- 
Michal Hocko
SUSE Labs
