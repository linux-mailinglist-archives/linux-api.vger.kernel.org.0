Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECCB1F9168
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2020 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgFOI3Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jun 2020 04:29:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728426AbgFOI3N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jun 2020 04:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592209749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGfbzyVCVbVxmC1s5MiEu/2YO9ITyb9/4mG3DwW8FpA=;
        b=YvG+uaqX66ubQzeK4C4JSzWrIkA0hv4DfQmGWhZhpFW2lFVjJDTcsYlOpj/X30bFOPdm3C
        kggAYM0Pv8EpzT2pLdYP1sgfiFy0Xnx6/KB2C/vhBoZA6SjpP0Xyf9SAO1O8m+divchItT
        N4Nhp4B95yKjs6LyaCAWNJYAaixzzJ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-UAhT9cnIOfKyEmE4hkIbUw-1; Mon, 15 Jun 2020 04:29:06 -0400
X-MC-Unique: UAhT9cnIOfKyEmE4hkIbUw-1
Received: by mail-ej1-f71.google.com with SMTP id i17so7481921ejb.9
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2020 01:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RGfbzyVCVbVxmC1s5MiEu/2YO9ITyb9/4mG3DwW8FpA=;
        b=GbjVkLrPiARvAMYVvDz82GSxXB1DoMAZNJzAl7HPFqw6SyNIxQeBQjzYFVbItrdY/K
         gCCcre/wFu9gf+g5cIwPUYGgQzobU6Uq7W2r3sagkQSMGWyaIXISV6+j6eIBXugZJzF2
         1swiZcrAU1K0zObXxbYCyrQ1uealpcR4sYQHw+SXeXlRtcsWuMdUho1wCt7z/mAsGLNK
         UiqNIn5ZjSKX+DcMyczSL3Auty/6E5s1L+rMYQZYf6lhZtwM4Q8+shd4sY7hxFNG9dmf
         hjgrcrBHNdl9NVf3+Daf/7JXD694f22uW84kt6tURNvAlHNJ6M9nrWUkc1lpFk7VegbR
         oiUA==
X-Gm-Message-State: AOAM530sZ8vmZjTNNiianaFr8M2rAWwOf7if7/HeiQrDB+MFGtp5LQ2I
        iXyQ6r3c5/jUTnwozF2iGqpttUj/kywuGaig/EX50CLkP7GZH7hAfcC64bMdG9oWHeOq4//pFzb
        n0dUV3NzsXRwHMK5gDvvI
X-Received: by 2002:aa7:de08:: with SMTP id h8mr22086493edv.164.1592209743958;
        Mon, 15 Jun 2020 01:29:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGQ4ti6OdAqb9y7kcJPNsvsNza1Sexvwgdx/sNaPZfAji8C0jPdH5VYh0eNDkCNh0mjZ0/Og==
X-Received: by 2002:aa7:de08:: with SMTP id h8mr22086453edv.164.1592209743421;
        Mon, 15 Jun 2020 01:29:03 -0700 (PDT)
Received: from localhost ([2001:470:5b39:29:79fc:ff4e:48ab:b845])
        by smtp.gmail.com with ESMTPSA id n9sm8661650ejk.21.2020.06.15.01.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:29:02 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:29:01 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v6] mm: Proactive compaction
Message-ID: <20200615082901.eccfhaklq6fz4bh6@butterfly.localdomain>
References: <20200601194822.30252-1-nigupta@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601194822.30252-1-nigupta@nvidia.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On Mon, Jun 01, 2020 at 12:48:22PM -0700, Nitin Gupta wrote:
> For some applications, we need to allocate almost all memory as
> hugepages. However, on a running system, higher-order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages, but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) show that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.
> 
> For a more proactive compaction, the approach taken here is to define a
> new sysctl called 'vm.compaction_proactiveness' which dictates bounds
> for external fragmentation which kcompactd tries to maintain.
> 
> The tunable takes a value in range [0, 100], with a default of 20.
> 
> Note that a previous version of this patch [1] was found to introduce
> too many tunables (per-order extfrag{low, high}), but this one reduces
> them to just one sysctl. Also, the new tunable is an opaque value
> instead of asking for specific bounds of "external fragmentation", which
> would have been difficult to estimate. The internal interpretation of
> this opaque value allows for future fine-tuning.
> 
> Currently, we use a simple translation from this tunable to [low, high]
> "fragmentation score" thresholds (low=100-proactiveness, high=low+10%).
> The score for a node is defined as weighted mean of per-zone external
> fragmentation. A zone's present_pages determines its weight.
> 
> To periodically check per-node score, we reuse per-node kcompactd
> threads, which are woken up every 500 milliseconds to check the same. If
> a node's score exceeds its high threshold (as derived from user-provided
> proactiveness value), proactive compaction is started until its score
> reaches its low threshold value. By default, proactiveness is set to 20,
> which implies threshold values of low=80 and high=90.
> 
> This patch is largely based on ideas from Michal Hocko [2]. See also the
> LWN article [3].
> 
> Performance data
> ================
> 
> System: x64_64, 1T RAM, 80 CPU threads.
> Kernel: 5.6.0-rc3 + this patch
> 
> echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
> echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/defrag
> 
> Before starting the driver, the system was fragmented from a userspace
> program that allocates all memory and then for each 2M aligned section,
> frees 3/4 of base pages using munmap. The workload is mainly anonymous
> userspace pages, which are easy to move around. I intentionally avoided
> unmovable pages in this test to see how much latency we incur when
> hugepage allocations hit direct compaction.
> 
> 1. Kernel hugepage allocation latencies
> 
> With the system in such a fragmented state, a kernel driver then
> allocates as many hugepages as possible and measures allocation
> latency:
> 
> (all latency values are in microseconds)
> 
> - With vanilla 5.6.0-rc3
> 
>   percentile latency
>   –––––––––– –––––––
> 	   5    7894
> 	  10    9496
> 	  25   12561
> 	  30   15295
> 	  40   18244
> 	  50   21229
> 	  60   27556
> 	  75   30147
> 	  80   31047
> 	  90   32859
> 	  95   33799
> 
> Total 2M hugepages allocated = 383859 (749G worth of hugepages out of
> 762G total free => 98% of free memory could be allocated as hugepages)
> 
> - With 5.6.0-rc3 + this patch, with proactiveness=20
> 
> sysctl -w vm.compaction_proactiveness=20
> 
>   percentile latency
>   –––––––––– –––––––
> 	   5       2
> 	  10       2
> 	  25       3
> 	  30       3
> 	  40       3
> 	  50       4
> 	  60       4
> 	  75       4
> 	  80       4
> 	  90       5
> 	  95     429
> 
> Total 2M hugepages allocated = 384105 (750G worth of hugepages out of
> 762G total free => 98% of free memory could be allocated as hugepages)
> 
> 2. JAVA heap allocation
> 
> In this test, we first fragment memory using the same method as for (1).
> 
> Then, we start a Java process with a heap size set to 700G and request
> the heap to be allocated with THP hugepages. We also set THP to madvise
> to allow hugepage backing of this heap.
> 
> /usr/bin/time
>  java -Xms700G -Xmx700G -XX:+UseTransparentHugePages -XX:+AlwaysPreTouch
> 
> The above command allocates 700G of Java heap using hugepages.
> 
> - With vanilla 5.6.0-rc3
> 
> 17.39user 1666.48system 27:37.89elapsed
> 
> - With 5.6.0-rc3 + this patch, with proactiveness=20
> 
> 8.35user 194.58system 3:19.62elapsed
> 
> Elapsed time remains around 3:15, as proactiveness is further increased.
> 
> Note that proactive compaction happens throughout the runtime of these
> workloads. The situation of one-time compaction, sufficient to supply
> hugepages for following allocation stream, can probably happen for more
> extreme proactiveness values, like 80 or 90.
> 
> In the above Java workload, proactiveness is set to 20. The test starts
> with a node's score of 80 or higher, depending on the delay between the
> fragmentation step and starting the benchmark, which gives more-or-less
> time for the initial round of compaction. As t	he benchmark consumes
> hugepages, node's score quickly rises above the high threshold (90) and
> proactive compaction starts again, which brings down the score to the
> low threshold level (80).  Repeat.
> 
> bpftrace also confirms proactive compaction running 20+ times during the
> runtime of this Java benchmark. kcompactd threads consume 100% of one of
> the CPUs while it tries to bring a node's score within thresholds.
> 
> Backoff behavior
> ================
> 
> Above workloads produce a memory state which is easy to compact.
> However, if memory is filled with unmovable pages, proactive compaction
> should essentially back off. To test this aspect:
> 
> - Created a kernel driver that allocates almost all memory as hugepages
>   followed by freeing first 3/4 of each hugepage.
> - Set proactiveness=40
> - Note that proactive_compact_node() is deferred maximum number of times
>   with HPAGE_FRAG_CHECK_INTERVAL_MSEC of wait between each check
>   (=> ~30 seconds between retries).
> 
> [1] https://patchwork.kernel.org/patch/11098289/
> [2] https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/
> [3] https://lwn.net/Articles/817905/
> 
> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> To: Mel Gorman <mgorman@techsingularity.net>
> To: Michal Hocko <mhocko@suse.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mike Kravetz <mike.kravetz@oracle.com>
> CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> CC: David Rientjes <rientjes@google.com>
> CC: Nitin Gupta <ngupta@nitingupta.dev>
> CC: linux-kernel <linux-kernel@vger.kernel.org>
> CC: linux-mm <linux-mm@kvack.org>
> CC: Linux API <linux-api@vger.kernel.org>
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
> Changelog v6 vs v5:
>  - Fallback to HUGETLB_PAGE_ORDER if HPAGE_PMD_ORDER is not defined, and
>    some cleanups (Vlastimil)
>  - Cap min threshold to avoid excess compaction load in case user sets
>    extreme values like 100 for `vm.compaction_proactiveness` sysctl (Khalid)
>  - Add some more explanation about the effect of tunable on compaction
>    behavior in user guide (Khalid)
> 
> Changelog v5 vs v4:
>  - Change tunable from sysfs to sysctl (Vlastimil)
>  - Replace HUGETLB_PAGE_ORDER with HPAGE_PMD_ORDER (Vlastimil)
>  - Minor cleanups (remove redundant initializations, ...)
> 
> Changelog v4 vs v3:
>  - Document various functions.
>  - Added admin-guide for the new tunable `proactiveness`.
>  - Rename proactive_compaction_score to fragmentation_score for clarity.
> 
> Changelog v3 vs v2:
>  - Make proactiveness a global tunable and not per-node. Also upadated
> the
>    patch description to reflect the same (Vlastimil Babka).
>  - Don't start proactive compaction if kswapd is running (Vlastimil
> Babka).
>  - Clarified in the description that compaction runs in parallel with
>    the workload, instead of a one-time compaction followed by a stream
> of
>    hugepage allocations.
> 
> Changelog v2 vs v1:
>  - Introduce per-node and per-zone "proactive compaction score". This
>    score is compared against watermarks which are set according to
>    user provided proactiveness value.
>  - Separate code-paths for proactive compaction from targeted compaction
>    i.e. where pgdat->kcompactd_max_order is non-zero.
>  - Renamed hpage_compaction_effort -> proactiveness. In future we may
>    use more than extfrag wrt hugepage size to determine proactive
>    compaction score.
> ---
>  Documentation/admin-guide/sysctl/vm.rst |  15 ++
>  include/linux/compaction.h              |   2 +
>  kernel/sysctl.c                         |   9 ++
>  mm/compaction.c                         | 183 +++++++++++++++++++++++-
>  mm/internal.h                           |   1 +
>  mm/vmstat.c                             |  18 +++
>  6 files changed, 223 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 0329a4d3fa9e..360914b4f346 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -119,6 +119,21 @@ all zones are compacted such that free memory is available in contiguous
>  blocks where possible. This can be important for example in the allocation of
>  huge pages although processes will also directly compact memory as required.
>  
> +compaction_proactiveness
> +========================
> +
> +This tunable takes a value in the range [0, 100] with a default value of
> +20. This tunable determines how aggressively compaction is done in the
> +background. Setting it to 0 disables proactive compaction.
> +
> +Note that compaction has a non-trivial system-wide impact as pages
> +belonging to different processes are moved around, which could also lead
> +to latency spikes in unsuspecting applications. The kernel employs
> +various heuristics to avoid wasting CPU cycles if it detects that
> +proactive compaction is not being effective.
> +
> +Be careful when setting it to extreme values like 100, as that may
> +cause excessive background compaction activity.
>  
>  compact_unevictable_allowed
>  ===========================
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 4b898cdbdf05..ccd28978b296 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -85,11 +85,13 @@ static inline unsigned long compact_gap(unsigned int order)
>  
>  #ifdef CONFIG_COMPACTION
>  extern int sysctl_compact_memory;
> +extern int sysctl_compaction_proactiveness;
>  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  			void __user *buffer, size_t *length, loff_t *ppos);
>  extern int sysctl_extfrag_threshold;
>  extern int sysctl_compact_unevictable_allowed;
>  
> +extern int extfrag_for_order(struct zone *zone, unsigned int order);
>  extern int fragmentation_index(struct zone *zone, unsigned int order);
>  extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>  		unsigned int order, unsigned int alloc_flags,
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..51c90906efbc 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1458,6 +1458,15 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0200,
>  		.proc_handler	= sysctl_compaction_handler,
>  	},
> +	{
> +		.procname	= "compaction_proactiveness",
> +		.data		= &sysctl_compaction_proactiveness,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &one_hundred,
> +	},
>  	{
>  		.procname	= "extfrag_threshold",
>  		.data		= &sysctl_extfrag_threshold,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 46f0fcc93081..822ff72817d5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -50,6 +50,24 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
>  #define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
>  #define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
>  
> +/*
> + * Fragmentation score check interval for proactive compaction purposes.
> + */
> +static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
> +
> +/*
> + * Page order with-respect-to which proactive compaction
> + * calculates external fragmentation, which is used as
> + * the "fragmentation score" of a node/zone.
> + */
> +#if defined HPAGE_PMD_ORDER
> +#define COMPACTION_HPAGE_ORDER	HPAGE_PMD_ORDER
> +#elif defined HUGETLB_PAGE_ORDER
> +#define COMPACTION_HPAGE_ORDER	HUGETLB_PAGE_ORDER
> +#else
> +#define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +#endif
> +
>  static unsigned long release_freepages(struct list_head *freelist)
>  {
>  	struct page *page, *next;
> @@ -1855,6 +1873,76 @@ static inline bool is_via_compact_memory(int order)
>  	return order == -1;
>  }
>  
> +static bool kswapd_is_running(pg_data_t *pgdat)
> +{
> +	return pgdat->kswapd && (pgdat->kswapd->state == TASK_RUNNING);
> +}
> +
> +/*
> + * A zone's fragmentation score is the external fragmentation wrt to the
> + * COMPACTION_HPAGE_ORDER scaled by the zone's size. It returns a value
> + * in the range [0, 100].
> + *
> + * The scaling factor ensures that proactive compaction focuses on larger
> + * zones like ZONE_NORMAL, rather than smaller, specialized zones like
> + * ZONE_DMA32. For smaller zones, the score value remains close to zero,
> + * and thus never exceeds the high threshold for proactive compaction.
> + */
> +static int fragmentation_score_zone(struct zone *zone)
> +{
> +	unsigned long score;
> +
> +	score = zone->present_pages *
> +			extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> +	return div64_ul(score, zone->zone_pgdat->node_present_pages + 1);
> +}
> +
> +/*
> + * The per-node proactive (background) compaction process is started by its
> + * corresponding kcompactd thread when the node's fragmentation score
> + * exceeds the high threshold. The compaction process remains active till
> + * the node's score falls below the low threshold, or one of the back-off
> + * conditions is met.
> + */
> +static int fragmentation_score_node(pg_data_t *pgdat)
> +{
> +	unsigned long score = 0;
> +	int zoneid;
> +
> +	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> +		struct zone *zone;
> +
> +		zone = &pgdat->node_zones[zoneid];
> +		score += fragmentation_score_zone(zone);
> +	}
> +
> +	return score;
> +}
> +
> +static int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
> +{
> +	int wmark_low;
> +
> +	/*
> +	 * Cap the low watermak to avoid excessive compaction
> +	 * activity in case a user sets the proactivess tunable
> +	 * close to 100 (maximum).
> +	 */
> +	wmark_low = max(100 - sysctl_compaction_proactiveness, 5);
> +	return low ? wmark_low : min(wmark_low + 10, 100);
> +}
> +
> +static bool should_proactive_compact_node(pg_data_t *pgdat)
> +{
> +	int wmark_high;
> +
> +	if (!sysctl_compaction_proactiveness || kswapd_is_running(pgdat))
> +		return false;
> +
> +	wmark_high = fragmentation_score_wmark(pgdat, false);
> +	return fragmentation_score_node(pgdat) > wmark_high;
> +}
> +
>  static enum compact_result __compact_finished(struct compact_control *cc)
>  {
>  	unsigned int order;
> @@ -1881,6 +1969,25 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  			return COMPACT_PARTIAL_SKIPPED;
>  	}
>  
> +	if (cc->proactive_compaction) {
> +		int score, wmark_low;
> +		pg_data_t *pgdat;
> +
> +		pgdat = cc->zone->zone_pgdat;
> +		if (kswapd_is_running(pgdat))
> +			return COMPACT_PARTIAL_SKIPPED;
> +
> +		score = fragmentation_score_zone(cc->zone);
> +		wmark_low = fragmentation_score_wmark(pgdat, true);
> +
> +		if (score > wmark_low)
> +			ret = COMPACT_CONTINUE;
> +		else
> +			ret = COMPACT_SUCCESS;
> +
> +		goto out;
> +	}
> +
>  	if (is_via_compact_memory(cc->order))
>  		return COMPACT_CONTINUE;
>  
> @@ -1939,6 +2046,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  		}
>  	}
>  
> +out:
>  	if (cc->contended || fatal_signal_pending(current))
>  		ret = COMPACT_CONTENDED;
>  
> @@ -2412,6 +2520,41 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
>  	return rc;
>  }
>  
> +/*
> + * Compact all zones within a node till each zone's fragmentation score
> + * reaches within proactive compaction thresholds (as determined by the
> + * proactiveness tunable).
> + *
> + * It is possible that the function returns before reaching score targets
> + * due to various back-off conditions, such as, contention on per-node or
> + * per-zone locks.
> + */
> +static void proactive_compact_node(pg_data_t *pgdat)
> +{
> +	int zoneid;
> +	struct zone *zone;
> +	struct compact_control cc = {
> +		.order = -1,
> +		.mode = MIGRATE_SYNC_LIGHT,
> +		.ignore_skip_hint = true,
> +		.whole_zone = true,
> +		.gfp_mask = GFP_KERNEL,
> +		.proactive_compaction = true,
> +	};
> +
> +	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> +		zone = &pgdat->node_zones[zoneid];
> +		if (!populated_zone(zone))
> +			continue;
> +
> +		cc.zone = zone;
> +
> +		compact_zone(&cc, NULL);
> +
> +		VM_BUG_ON(!list_empty(&cc.freepages));
> +		VM_BUG_ON(!list_empty(&cc.migratepages));
> +	}
> +}
>  
>  /* Compact all zones within a node */
>  static void compact_node(int nid)
> @@ -2458,6 +2601,13 @@ static void compact_nodes(void)
>  /* The written value is actually unused, all memory is compacted */
>  int sysctl_compact_memory;
>  
> +/*
> + * Tunable for proactive compaction. It determines how
> + * aggressively the kernel should compact memory in the
> + * background. It takes values in the range [0, 100].
> + */
> +int __read_mostly sysctl_compaction_proactiveness = 20;
> +
>  /*
>   * This is the entry point for compacting all nodes via
>   * /proc/sys/vm/compact_memory
> @@ -2637,6 +2787,7 @@ static int kcompactd(void *p)
>  {
>  	pg_data_t *pgdat = (pg_data_t*)p;
>  	struct task_struct *tsk = current;
> +	unsigned int proactive_defer = 0;
>  
>  	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>  
> @@ -2652,12 +2803,34 @@ static int kcompactd(void *p)
>  		unsigned long pflags;
>  
>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
> -		wait_event_freezable(pgdat->kcompactd_wait,
> -				kcompactd_work_requested(pgdat));
> +		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> +			kcompactd_work_requested(pgdat),
> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
> +
> +			psi_memstall_enter(&pflags);
> +			kcompactd_do_work(pgdat);
> +			psi_memstall_leave(&pflags);
> +			continue;
> +		}
>  
> -		psi_memstall_enter(&pflags);
> -		kcompactd_do_work(pgdat);
> -		psi_memstall_leave(&pflags);
> +		/* kcompactd wait timeout */
> +		if (should_proactive_compact_node(pgdat)) {
> +			unsigned int prev_score, score;
> +
> +			if (proactive_defer) {
> +				proactive_defer--;
> +				continue;
> +			}
> +			prev_score = fragmentation_score_node(pgdat);
> +			proactive_compact_node(pgdat);
> +			score = fragmentation_score_node(pgdat);
> +			/*
> +			 * Defer proactive compaction if the fragmentation
> +			 * score did not go down i.e. no progress made.
> +			 */
> +			proactive_defer = score < prev_score ?
> +					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/mm/internal.h b/mm/internal.h
> index b5634e78f01d..9671bccd97d5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -228,6 +228,7 @@ struct compact_control {
>  	bool no_set_skip_hint;		/* Don't mark blocks for skipping */
>  	bool ignore_block_suitable;	/* Scan blocks considered unsuitable */
>  	bool direct_compaction;		/* False from kcompactd or /proc/... */
> +	bool proactive_compaction;	/* kcompactd proactive compaction */
>  	bool whole_zone;		/* Whole zone should/has been scanned */
>  	bool contended;			/* Signal lock or sched contention */
>  	bool rescan;			/* Rescanning the same pageblock */
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 96d21a792b57..cc88f7533b8d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1074,6 +1074,24 @@ static int __fragmentation_index(unsigned int order, struct contig_page_info *in
>  	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, requested))), info->free_blocks_total);
>  }
>  
> +/*
> + * Calculates external fragmentation within a zone wrt the given order.
> + * It is defined as the percentage of pages found in blocks of size
> + * less than 1 << order. It returns values in range [0, 100].
> + */
> +int extfrag_for_order(struct zone *zone, unsigned int order)
> +{
> +	struct contig_page_info info;
> +
> +	fill_contig_page_info(zone, order, &info);
> +	if (info.free_pages == 0)
> +		return 0;
> +
> +	return div_u64((info.free_pages -
> +			(info.free_blocks_suitable << order)) * 100,
> +			info.free_pages);
> +}
> +
>  /* Same as __fragmentation index but allocs contig_page_info on stack */
>  int fragmentation_index(struct zone *zone, unsigned int order)
>  {

Just to let you know, this fails to compile for me with THP disabled on
v5.8-rc1:

  CC      mm/compaction.o
In file included from ./include/linux/dev_printk.h:14,
                 from ./include/linux/device.h:15,
                 from ./include/linux/node.h:18,
                 from ./include/linux/cpu.h:17,
                 from mm/compaction.c:11:
In function ‘fragmentation_score_zone’,
    inlined from ‘__compact_finished’ at mm/compaction.c:1982:11,
    inlined from ‘compact_zone’ at mm/compaction.c:2062:8:
./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
  373 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
  319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
  115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
   64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
      |                                ^~~~~~~~~~~~~~~
mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
 1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
      |                            ^~~~~~~~~~~~~~~~~~~~~~
In function ‘fragmentation_score_zone’,
    inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
  373 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
  319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
  115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
   64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
      |                                ^~~~~~~~~~~~~~~
mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
 1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
      |                            ^~~~~~~~~~~~~~~~~~~~~~
In function ‘fragmentation_score_zone’,
    inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
  373 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
  319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
  115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
   64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
      |                                ^~~~~~~~~~~~~~~
mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
 1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
      |                            ^~~~~~~~~~~~~~~~~~~~~~
In function ‘fragmentation_score_zone’,
    inlined from ‘kcompactd’ at mm/compaction.c:1918:12:
./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_397’ declared with attribute error: BUILD_BUG failed
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
  373 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  392 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
  319 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
./include/linux/huge_mm.h:115:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
  115 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
mm/compaction.c:64:32: note: in expansion of macro ‘HPAGE_PMD_ORDER’
   64 | #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
      |                                ^~~~~~~~~~~~~~~
mm/compaction.c:1898:28: note: in expansion of macro ‘COMPACTION_HPAGE_ORDER’
 1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
      |                            ^~~~~~~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:281: mm/compaction.o] Error 1
make: *** [Makefile:1764: mm] Error 2

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

