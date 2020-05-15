Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573231D5892
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOSCC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 14:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:58566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEOSCC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 15 May 2020 14:02:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44BDFAA7C;
        Fri, 15 May 2020 18:02:02 +0000 (UTC)
Subject: Re: [PATCH v4] mm: Proactive compaction
To:     Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20200428221055.598-1-nigupta@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <28993c4d-adc6-b83e-66a6-abb0a753f481@suse.cz>
Date:   Fri, 15 May 2020 20:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428221055.598-1-nigupta@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/29/20 12:10 AM, Nitin Gupta wrote:
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
> For a more proactive compaction, the approach taken here is to define
> a new tunable called 'proactiveness' which dictates bounds for external
> fragmentation wrt HUGETLB_PAGE_ORDER order which kcompactd tries to
> maintain.
> 
> The tunable is exposed through sysfs:
>   /sys/kernel/mm/compaction/proactiveness

I would prefer sysctl. Why?

During the mm evolution we seem to have end up with stuff scattered over several
places:

/proc/sys aka sysctl:
/proc/sys/vm/compact_unevictable_allowed
/proc/sys/vm/compact_memory - write-only one-time action trigger!

/sys/kernel/mm:
e.g. /sys/kernel/mm/transparent_hugepage/

This is unfortunate enough, and (influenced by my recent dive into sysctl
perhaps :), I would have preferred sysctl only. In this case it's consistent
that we have sysctls for compaction already, while this introduces a whole new
compaction directory in the /sys/kernel/mm/ space.

> It takes value in range [0, 100], with a default of 20.
> 
> Note that a previous version of this patch [1] was found to introduce too
> many tunables (per-order extfrag{low, high}), but this one reduces them
> to just one (proactiveness). Also, the new tunable is an opaque value
> instead of asking for specific bounds of "external fragmentation", which
> would have been difficult to estimate. The internal interpretation of
> this opaque value allows for future fine-tuning.
> 
> Currently, we use a simple translation from this tunable to [low, high]
> "fragmentation score" thresholds (low=100-proactiveness, high=low+10%).
> The score for a node is defined as weighted mean of per-zone external
> fragmentation wrt HUGETLB_PAGE_ORDER order. A zone's present_pages
> determines its weight.
> 
> To periodically check per-node score, we reuse per-node kcompactd
> threads, which are woken up every 500 milliseconds to check the same. If
> a node's score exceeds its high threshold (as derived from user-provided
> proactiveness value), proactive compaction is started until its score
> reaches its low threshold value. By default, proactiveness is set to 20,
> which implies threshold values of low=80 and high=90.
> 
> This patch is largely based on ideas from Michal Hocko posted here:
> https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/
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
> With the system in such a fragmented state, a kernel driver then allocates
> as many hugepages as possible and measures allocation latency:
> 
> (all latency values are in microseconds)
> 
> - With vanilla 5.6.0-rc3
> 
> echo 0 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness
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
> echo 20 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness
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

I still wonder how the single additional CPU during compaction resulted in such
an improvement. Isn't this against the Amdahl's law? :)

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
> time for the initial round of compaction. As the benchmark consumes
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
> 
> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
> To: Mel Gorman <mgorman@techsingularity.net>

I hope Mel can also comment on this, but in general I agree.

...

> +
> +/*
> + * A zone's fragmentation score is the external fragmentation wrt to the
> + * HUGETLB_PAGE_ORDER scaled by the zone's size. It returns a value in the
> + * range [0, 100].
> +
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
> +			extfrag_for_order(zone, HUGETLB_PAGE_ORDER);

HPAGE_PMD_ORDER would be a better match than HUGETLB_PAGE_ORDER, even if it
might be the same number. hugetlb pages are pre-reserved, unlike THP.

> +	score = div64_ul(score,
> +			node_present_pages(zone->zone_pgdat->node_id) + 1);

zone->zone_pgdat->node_present_pages is more direct

> +	return score;
> +}
> +
> +/*

> @@ -2309,6 +2411,7 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  		.alloc_flags = alloc_flags,
>  		.classzone_idx = classzone_idx,
>  		.direct_compaction = true,
> +		.proactive_compaction = false,

false, 0, NULL etc are implicitly initialized with this kind of initialization
(also in other places of the patch)

>  		.whole_zone = (prio == MIN_COMPACT_PRIORITY),
>  		.ignore_skip_hint = (prio == MIN_COMPACT_PRIORITY),
>  		.ignore_block_suitable = (prio == MIN_COMPACT_PRIORITY)
> @@ -2412,6 +2515,42 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
>  	return rc;
>  }
>  

> @@ -2500,6 +2640,63 @@ void compaction_unregister_node(struct node *node)
>  }
>  #endif /* CONFIG_SYSFS && CONFIG_NUMA */
>  
> +#ifdef CONFIG_SYSFS
> +
> +#define COMPACTION_ATTR_RO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> +
> +#define COMPACTION_ATTR(_name) \
> +	static struct kobj_attribute _name##_attr = \
> +		__ATTR(_name, 0644, _name##_show, _name##_store)
> +
> +static struct kobject *compaction_kobj;
> +
> +static ssize_t proactiveness_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	int err;
> +	unsigned long input;
> +
> +	err = kstrtoul(buf, 10, &input);
> +	if (err)
> +		return err;
> +	if (input > 100)
> +		return -EINVAL;

The sysctl way also allows to specify min/max in the descriptor and use the
generic handler
