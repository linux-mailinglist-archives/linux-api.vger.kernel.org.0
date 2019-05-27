Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FC2B755
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfE0OM1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 10:12:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfE0OM1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 10:12:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A564AC3F;
        Mon, 27 May 2019 14:12:25 +0000 (UTC)
Date:   Mon, 27 May 2019 16:12:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from
 user space)
Message-ID: <20190527141223.GD1658@dhcp22.suse.cz>
References: <155895155861.2824.318013775811596173.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155895155861.2824.318013775811596173.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api. Please always cc this list when proposing a new user
 visible api. Keeping the rest of the email intact for reference]

On Mon 27-05-19 13:05:58, Konstantin Khlebnikov wrote:
> Memory cgroup has no background memory reclaimer. Reclaiming after passing
> high-limit blocks task because works synchronously in task-work.
> 
> This implements manual kswapd-style memory reclaim initiated by userspace.
> It reclaims both physical memory and cgroup pages. It works in context of
> task who calls syscall madvise thus cpu time is accounted correctly.
> 
> Interface:
> 
> ret = madvise(ptr, size, MADV_STOCKPILE)
> 
> Returns:
>   0         - ok, free memory >= size
>   -EINVAL   - not supported
>   -ENOMEM   - not enough memory/cgroup limit
>   -EINTR    - interrupted by pending signal
>   -EAGAIN   - cannot reclaim enough memory
> 
> Argument 'size' is interpreted size of required free memory.
> Implementation triggers direct reclaim until amount of free memory is
> lower than that size. Argument 'ptr' could points to vma for specifying
> numa allocation policy, right now should be NULL.
> 
> Usage scenario: independent thread or standalone daemon estimates rate of
> allocations and calls MADV_STOCKPILE in loop to prepare free pages.
> Thus fast path avoids allocation latency induced by direct reclaim.
> 
> We are using this embedded into memory allocator based on MADV_FREE.
> 
> 
> Demonstration in memory cgroup with limit 1G:
> 
> touch zero
> truncate -s 5G zero
> 
> Without stockpile:
> 
> perf stat -e vmscan:* md5sum zero
> 
>  Performance counter stats for 'md5sum zero':
> 
>                  0      vmscan:mm_vmscan_kswapd_sleep
>                  0      vmscan:mm_vmscan_kswapd_wake
>                  0      vmscan:mm_vmscan_wakeup_kswapd
>                  0      vmscan:mm_vmscan_direct_reclaim_begin
>              10147      vmscan:mm_vmscan_memcg_reclaim_begin
>                  0      vmscan:mm_vmscan_memcg_softlimit_reclaim_begin
>                  0      vmscan:mm_vmscan_direct_reclaim_end
>              10147      vmscan:mm_vmscan_memcg_reclaim_end
>                  0      vmscan:mm_vmscan_memcg_softlimit_reclaim_end
>              99910      vmscan:mm_shrink_slab_start
>              99910      vmscan:mm_shrink_slab_end
>              39654      vmscan:mm_vmscan_lru_isolate
>                  0      vmscan:mm_vmscan_writepage
>              39652      vmscan:mm_vmscan_lru_shrink_inactive
>                  2      vmscan:mm_vmscan_lru_shrink_active
>              19982      vmscan:mm_vmscan_inactive_list_is_low
> 
>       10.886832585 seconds time elapsed
> 
>        8.928366000 seconds user
>        1.935212000 seconds sys
> 
> With stockpile:
> 
> stockpile 100 10 &   # up to 100M every 10ms
> perf stat -e vmscan:* md5sum zero
> 
>  Performance counter stats for 'md5sum zero':
> 
>                  0      vmscan:mm_vmscan_kswapd_sleep
>                  0      vmscan:mm_vmscan_kswapd_wake
>                  0      vmscan:mm_vmscan_wakeup_kswapd
>                  0      vmscan:mm_vmscan_direct_reclaim_begin
>                  0      vmscan:mm_vmscan_memcg_reclaim_begin
>                  0      vmscan:mm_vmscan_memcg_softlimit_reclaim_begin
>                  0      vmscan:mm_vmscan_direct_reclaim_end
>                  0      vmscan:mm_vmscan_memcg_reclaim_end
>                  0      vmscan:mm_vmscan_memcg_softlimit_reclaim_end
>                  0      vmscan:mm_shrink_slab_start
>                  0      vmscan:mm_shrink_slab_end
>                  0      vmscan:mm_vmscan_lru_isolate
>                  0      vmscan:mm_vmscan_writepage
>                  0      vmscan:mm_vmscan_lru_shrink_inactive
>                  0      vmscan:mm_vmscan_lru_shrink_active
>                  0      vmscan:mm_vmscan_inactive_list_is_low
> 
>       10.469776675 seconds time elapsed
> 
>        8.976261000 seconds user
>        1.491378000 seconds sys
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  include/linux/memcontrol.h             |    6 +++++
>  include/uapi/asm-generic/mman-common.h |    2 ++
>  mm/madvise.c                           |   39 ++++++++++++++++++++++++++++++
>  mm/memcontrol.c                        |   41 ++++++++++++++++++++++++++++++++
>  tools/vm/Makefile                      |    2 +-
>  tools/vm/stockpile.c                   |   30 +++++++++++++++++++++++
>  6 files changed, 119 insertions(+), 1 deletion(-)
>  create mode 100644 tools/vm/stockpile.c
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bc74d6a4407c..25325f18ad55 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -517,6 +517,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
>  }
>  
>  void mem_cgroup_handle_over_high(void);
> +int mem_cgroup_stockpile(unsigned long goal_pages);
>  
>  unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
>  
> @@ -968,6 +969,11 @@ static inline void mem_cgroup_handle_over_high(void)
>  {
>  }
>  
> +static inline int mem_cgroup_stockpile(unsigned long goal_page)
> +{
> +	return 0;
> +}
> +
>  static inline void mem_cgroup_enter_user_fault(void)
>  {
>  }
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index abd238d0f7a4..675145864fee 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -64,6 +64,8 @@
>  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
>  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
>  
> +#define MADV_STOCKPILE	20		/* stockpile free pages */
> +
>  /* compatibility flags */
>  #define MAP_FILE	0
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 628022e674a7..f908b08ecc9f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -686,6 +686,41 @@ static int madvise_inject_error(int behavior,
>  }
>  #endif
>  
> +static long madvise_stockpile(unsigned long start, size_t len)
> +{
> +	unsigned long goal_pages, progress;
> +	struct zonelist *zonelist;
> +	int ret;
> +
> +	if (start)
> +		return -EINVAL;
> +
> +	goal_pages = len >> PAGE_SHIFT;
> +
> +	if (goal_pages > totalram_pages() - totalreserve_pages)
> +		return -ENOMEM;
> +
> +	ret = mem_cgroup_stockpile(goal_pages);
> +	if (ret)
> +		return ret;
> +
> +	/* TODO: use vma mempolicy */
> +	zonelist = node_zonelist(numa_node_id(), GFP_HIGHUSER);
> +
> +	while (global_zone_page_state(NR_FREE_PAGES) <
> +			goal_pages + totalreserve_pages) {
> +
> +		if (signal_pending(current))
> +			return -EINTR;
> +
> +		progress = try_to_free_pages(zonelist, 0, GFP_HIGHUSER, NULL);
> +		if (!progress)
> +			return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
>  static long
>  madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		unsigned long start, unsigned long end, int behavior)
> @@ -728,6 +763,7 @@ madvise_behavior_valid(int behavior)
>  	case MADV_DODUMP:
>  	case MADV_WIPEONFORK:
>  	case MADV_KEEPONFORK:
> +	case MADV_STOCKPILE:
>  #ifdef CONFIG_MEMORY_FAILURE
>  	case MADV_SOFT_OFFLINE:
>  	case MADV_HWPOISON:
> @@ -834,6 +870,9 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  		return madvise_inject_error(behavior, start, start + len_in);
>  #endif
>  
> +	if (behavior == MADV_STOCKPILE)
> +		return madvise_stockpile(start, len);
> +
>  	write = madvise_need_mmap_write(behavior);
>  	if (write) {
>  		if (down_write_killable(&current->mm->mmap_sem))
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e50a2db5b4ff..dc23dc6bbeb3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2276,6 +2276,47 @@ void mem_cgroup_handle_over_high(void)
>  	current->memcg_nr_pages_over_high = 0;
>  }
>  
> +int mem_cgroup_stockpile(unsigned long goal_pages)
> +{
> +	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	unsigned long limit, nr_free, progress;
> +	struct mem_cgroup *memcg, *pos;
> +	int ret = 0;
> +
> +	pos = memcg = get_mem_cgroup_from_mm(current->mm);
> +
> +retry:
> +	if (signal_pending(current)) {
> +		ret = -EINTR;
> +		goto out;
> +	}
> +
> +	limit = min(pos->memory.max, pos->high);
> +	if (goal_pages > limit) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	nr_free = limit - page_counter_read(&pos->memory);
> +	if ((long)nr_free < (long)goal_pages) {
> +		progress = try_to_free_mem_cgroup_pages(pos,
> +				goal_pages - nr_free, GFP_HIGHUSER, true);
> +		if (progress || nr_retries--)
> +			goto retry;
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	pos = parent_mem_cgroup(pos);
> +	if (pos)
> +		goto retry;
> +
> +out:
> +	css_put(&memcg->css);
> +	return ret;
> +}
> +
>  static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		      unsigned int nr_pages)
>  {
> diff --git a/tools/vm/Makefile b/tools/vm/Makefile
> index 20f6cf04377f..e5b5bc0d9421 100644
> --- a/tools/vm/Makefile
> +++ b/tools/vm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for vm tools
>  #
> -TARGETS=page-types slabinfo page_owner_sort
> +TARGETS=page-types slabinfo page_owner_sort stockpile
>  
>  LIB_DIR = ../lib/api
>  LIBS = $(LIB_DIR)/libapi.a
> diff --git a/tools/vm/stockpile.c b/tools/vm/stockpile.c
> new file mode 100644
> index 000000000000..245e24f293ec
> --- /dev/null
> +++ b/tools/vm/stockpile.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sys/mman.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <err.h>
> +#include <errno.h>
> +
> +#ifndef MADV_STOCKPILE
> +# define MADV_STOCKPILE	20
> +#endif
> +
> +int main(int argc, char **argv)
> +{
> +	int interval;
> +	size_t size;
> +	int ret;
> +
> +	if (argc != 3)
> +		errx(1, "usage: %s <size_mb> <interval_ms>", argv[0]);
> +
> +	size = atol(argv[1]) << 20;
> +	interval = atoi(argv[2]) * 1000;
> +
> +	while (1) {
> +		ret = madvise(NULL, size, MADV_STOCKPILE);
> +		if (ret && errno != EAGAIN)
> +			err(2, "madvise(NULL, %zu, MADV_STOCKPILE)", size);
> +		usleep(interval);
> +	}
> +}
> 

-- 
Michal Hocko
SUSE Labs
