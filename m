Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD113088E0
	for <lists+linux-api@lfdr.de>; Fri, 29 Jan 2021 13:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhA2MHu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Jan 2021 07:07:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:48926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232622AbhA2MFl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 29 Jan 2021 07:05:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEDE6AD7F;
        Fri, 29 Jan 2021 11:47:01 +0000 (UTC)
Date:   Fri, 29 Jan 2021 12:46:58 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
Message-ID: <20210129114624.GA25391@linux>
References: <20210127101813.6370-3-david@redhat.com>
 <20210129113451.22085-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129113451.22085-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 29, 2021 at 12:34:51PM +0100, David Hildenbrand wrote:
> Let's count the number of CMA pages per zone and print them in
> /proc/zoneinfo.
> 
> Having access to the total number of CMA pages per zone is helpful for
> debugging purposes to know where exactly the CMA pages ended up, and to
> figure out how many pages of a zone might behave differently, even after
> some of these pages might already have been allocated.
> 
> As one example, CMA pages part of a kernel zone cannot be used for
> ordinary kernel allocations but instead behave more like ZONE_MOVABLE.
> 
> For now, we are only able to get the global nr+free cma pages from
> /proc/meminfo and the free cma pages per zone from /proc/zoneinfo.
> 
> Example after this patch when booting a 6 GiB QEMU VM with
> "hugetlb_cma=2G":
>   # cat /proc/zoneinfo | grep cma
>           cma      0
>         nr_free_cma  0
>           cma      0
>         nr_free_cma  0
>           cma      524288
>         nr_free_cma  493016
>           cma      0
>           cma      0
>   # cat /proc/meminfo | grep Cma
>   CmaTotal:        2097152 kB
>   CmaFree:         1972064 kB
> 
> Note: We print even without CONFIG_CMA, just like "nr_free_cma"; this way,
>       one can be sure when spotting "cma 0", that there are definetly no
>       CMA pages located in a zone.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Looks good to me, I guess it is better to print it unconditionally
so the layout does not change.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

thanks

> ---
> 
> The third time is the charm.
> 
> v2 -> v3:
> - Print even without CONFIG_CMA. Use zone_cma_pages().
> - Adjust patch description
> - Dropped Oscar's RB due to the changes
> 
> v1 -> v2:
> - Print/track only with CONFIG_CMA
> - Extend patch description
> 
> ---
>  include/linux/mmzone.h | 15 +++++++++++++++
>  mm/page_alloc.c        |  1 +
>  mm/vmstat.c            |  6 ++++--
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ae588b2f87ef..caafd5e37080 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -503,6 +503,9 @@ struct zone {
>  	 * bootmem allocator):
>  	 *	managed_pages = present_pages - reserved_pages;
>  	 *
> +	 * cma pages is present pages that are assigned for CMA use
> +	 * (MIGRATE_CMA).
> +	 *
>  	 * So present_pages may be used by memory hotplug or memory power
>  	 * management logic to figure out unmanaged pages by checking
>  	 * (present_pages - managed_pages). And managed_pages should be used
> @@ -527,6 +530,9 @@ struct zone {
>  	atomic_long_t		managed_pages;
>  	unsigned long		spanned_pages;
>  	unsigned long		present_pages;
> +#ifdef CONFIG_CMA
> +	unsigned long		cma_pages;
> +#endif
>  
>  	const char		*name;
>  
> @@ -624,6 +630,15 @@ static inline unsigned long zone_managed_pages(struct zone *zone)
>  	return (unsigned long)atomic_long_read(&zone->managed_pages);
>  }
>  
> +static inline unsigned long zone_cma_pages(struct zone *zone)
> +{
> +#ifdef CONFIG_CMA
> +	return zone->cma_pages;
> +#else
> +	return 0;
> +#endif
> +}
> +
>  static inline unsigned long zone_end_pfn(const struct zone *zone)
>  {
>  	return zone->zone_start_pfn + zone->spanned_pages;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b031a5ae0bd5..9a82375bbcb2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2168,6 +2168,7 @@ void __init init_cma_reserved_pageblock(struct page *page)
>  	}
>  
>  	adjust_managed_page_count(page, pageblock_nr_pages);
> +	page_zone(page)->cma_pages += pageblock_nr_pages;
>  }
>  #endif
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 7758486097f9..b2537852d498 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1642,14 +1642,16 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>  		   "\n        high     %lu"
>  		   "\n        spanned  %lu"
>  		   "\n        present  %lu"
> -		   "\n        managed  %lu",
> +		   "\n        managed  %lu"
> +		   "\n        cma      %lu",
>  		   zone_page_state(zone, NR_FREE_PAGES),
>  		   min_wmark_pages(zone),
>  		   low_wmark_pages(zone),
>  		   high_wmark_pages(zone),
>  		   zone->spanned_pages,
>  		   zone->present_pages,
> -		   zone_managed_pages(zone));
> +		   zone_managed_pages(zone),
> +		   zone_cma_pages(zone));
>  
>  	seq_printf(m,
>  		   "\n        protection: (%ld",
> -- 
> 2.29.2
> 
> 

-- 
Oscar Salvador
SUSE L3
