Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59C63080AE
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 22:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhA1Vno (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 16:43:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:60692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhA1VnK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 28 Jan 2021 16:43:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4CFAAC55;
        Thu, 28 Jan 2021 21:42:21 +0000 (UTC)
Date:   Thu, 28 Jan 2021 22:42:19 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
Message-ID: <20210128214219.GA3113@localhost.localdomain>
References: <20210127101813.6370-3-david@redhat.com>
 <20210128164533.18566-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128164533.18566-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jan 28, 2021 at 05:45:33PM +0100, David Hildenbrand wrote:
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
> Note: We track/print only with CONFIG_CMA; "nr_free_cma" in /proc/zoneinfo
> is currently also printed without CONFIG_CMA.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

IMHO looks better to me, thanks:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> 
> v1 -> v2:
> - Print/track only with CONFIG_CMA
> - Extend patch description
> 
> ---
>  include/linux/mmzone.h | 6 ++++++
>  mm/page_alloc.c        | 1 +
>  mm/vmstat.c            | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ae588b2f87ef..27d22fb22e05 100644
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
> index 7758486097f9..957680db41fa 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1650,6 +1650,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>  		   zone->spanned_pages,
>  		   zone->present_pages,
>  		   zone_managed_pages(zone));
> +#ifdef CONFIG_CMA
> +	seq_printf(m,
> +		   "\n        cma      %lu",
> +		   zone->cma_pages);
> +#endif
>  
>  	seq_printf(m,
>  		   "\n        protection: (%ld",
> -- 
> 2.29.2
> 

-- 
Oscar Salvador
SUSE L3
