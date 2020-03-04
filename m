Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46B179778
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCDSEh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 13:04:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:33838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbgCDSEh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Mar 2020 13:04:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 950EFACCA;
        Wed,  4 Mar 2020 18:04:31 +0000 (UTC)
Subject: Re: [PATCH v2] mm: Proactive compaction
To:     Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>
References: <20200302213343.2712-1-nigupta@nvidia.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ae306f4d-4dff-a97b-00b1-71d7ab54f68b@suse.cz>
Date:   Wed, 4 Mar 2020 19:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302213343.2712-1-nigupta@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+CC linux-api (new tunable) and more folks who have discussed compaction before

On 3/2/20 10:33 PM, Nitin Gupta wrote:
> For some applications we need to allocate almost all memory as
> hugepages. However, on a running system, higher order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) shows that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.

Yeah, we should have something like this, currently kcompactd does only very
limited work.

> For a more proactive compaction, the approach taken here is to define
> per page-node tunable called 'proactiveness' which dictates
> bounds for external fragmentation for HUGETLB_PAGE_ORDER pages which
> kcompactd should try to maintain.
> 
> The tunable is exposed through sysfs:
>   /sys/kernel/mm/compaction/node-n/proactiveness
> 
> The value of this tunable is used to determine low and high thresholds
> for external fragmentation wrt HUGETLB_PAGE_ORDER order.
> 
> Note that previous version of this patch [1] was found to introduce too
> many tunables (per-order extfrag{low, high}) but this one reduces them
> to just (per-node proactiveness). Also, the new tunable is an
> opaque value instead of asking for specific bounds of "external
> fragmentation" which would have been difficult to estimate. The internal
> interpretation of this opaque value allows for future fine-tuning.

I guess we can live with that single tunable, like we have swappiness. The
per-order thresholds would be too much indeed. But does it have to be per-node?
Wouldn't a single one be enough?

> Currently, we use a simple translation from this tunable to [low, high]
> "proactive compaction score" thresholds (low=100-proactiveness,
> high=low+10%). The score for a node is defined as weighed mean of per-zone
> external fragmentation wrt HUGETLB_PAGE_ORDER. A zone's present_pages
> determines its weight. Proactive compaction is triggered when a node's
> score exceeds its high threshold value and continues till it reaches its
> low value.
> 
> To periodically check per-node score, we reuse per-node kcompactd
> threads which are woken up every few milliseconds to check the same. If

Few milliseconds would be excessive. The code seems to define that as 500, which
is somewhat better. Should there be also a backoff though if it finds out it has
nothing to do? And perhaps if kswapd is running on the node, kcompactd should
wait so they don't interfere?

> a node's score exceeds its high threshold (as derived from user provided
> proactiveness value), proactive compaction is started till its score
> reaches its low threshold value. By default, proactiveness is set to 0
> (=> low=100%, high=100%) for all nodes.

Maybe we can go with a non-0 yet conservative default after some more testing.

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
> userspace pages which are easy to move around. I intentionally avoided
> unmovable pages in this test to see how much latency we incur when
> hugepage allocations hit direct compaction.
> 
> 1. Kernel hugepage allocation latencies
> 
> With system in such a fragmented state, a kernel driver then allocates
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
> Total 2M hugepages allocated = 383859 (749G worth of hugepages out of 762G
> total free => 98% of free memory could be allocated as hugepages)
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
> Total 2M hugepages allocated = 11120 (21.7G worth of hugepages out of
> 25G total free => 98% of free memory could be allocated as hugepages)

By your description it seems to be a one-time fragmentation event followed by a
one-time stream of allocations? So kcompactd probably did the proactive work
just once? That works as a smoke test, but what I guess will be more important
is behavior under more complex workloads, where we should also check the vmstat
compact_daemon* stats and possibly also kcompactd kthreads CPU utilizations.

> 2. JAVA heap allocation
> 
> First fragment memory using the same method as for (1).
> 
> With memory in a fragmented state, run:
> 
> /usr/bin/time
>  java -Xms700G -Xmx700G -XX:+UseTransparentHugePages -XX:+AlwaysPreTouch
> 
> To allocate 700G of java heap using hugepages.
> 
> - With vanilla 5.6.0-rc3
> 
> 17.39user 1666.48system 27:37.89elapsed
> 
> - With 5.6.0-rc3 + this patch, with proactiveness=20
> 
> 8.35user 194.58system 3:19.62elapsed
> 
> Elapsed time remains around 3:15 as proactiveness is further increased.

Similar comment as for the above test. But that's a large reduction, so I wonder
how much time kcompactd took for this defragmentation. Was there a comparably
large delay between the fragmentation and the java application to let kcompactd
do the job? Or was it that much more efficient than the
one-compaction-per-single-hugepage that the java page faulting caused?

> 
> Backoff behavior
> ================
> 
> Above workloads produces a memory state which is easy to compact.
> However, if memory is filled with unmovable pages, proactive compaction
> should essentially back off. To test this aspect:
> 
> - Created a kernel driver that allocates almost all memory as hugepages
>   followed by freeing first 3/4 of each hugepage.
> - Set proactiveness=40 (for all nodes)
> - Note that proactive_compact_node() is deferred maximum number of times
>   with HPAGE_FRAG_CHECK_INTERVAL_MSEC of wait between each check
>   (=> ~30 seconds between retries).
> 
> [1] https://patchwork.kernel.org/patch/11098289/
> 
> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
> To: Mel Gorman <mgorman@techsingularity.net>
> To: Michal Hocko <mhocko@suse.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mike Kravetz <mike.kravetz@oracle.com>
> CC: linux-kernel <linux-kernel@vger.kernel.org>
> CC: linux-mm <linux-mm@kvack.org>

I haven't studied the code in detail yet, but leaving the mail for the reference
of new CC's.

Thanks,
Vlastimil

> ---
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
>  include/linux/compaction.h |  10 ++
>  mm/compaction.c            | 242 ++++++++++++++++++++++++++++++++++++-
>  mm/internal.h              |   1 +
>  mm/page_alloc.c            |   1 +
>  mm/vmstat.c                |  12 ++
>  5 files changed, 260 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 4b898cdbdf05..c98f45107164 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -60,6 +60,15 @@ enum compact_result {
>  
>  struct alloc_context; /* in mm/internal.h */
>  
> +// "node-%d"
> +#define COMPACTION_STATE_NAME_LEN 16
> +// Per-node compaction state
> +struct compaction_state {
> +	int node_id;
> +	unsigned int proactiveness;
> +	char name[COMPACTION_STATE_NAME_LEN];
> +};
> +
>  /*
>   * Number of free order-0 pages that should be available above given watermark
>   * to make sure compaction has reasonable chance of not running out of free
> @@ -90,6 +99,7 @@ extern int sysctl_compaction_handler(struct ctl_table *table, int write,
>  extern int sysctl_extfrag_threshold;
>  extern int sysctl_compact_unevictable_allowed;
>  
> +extern int extfrag_for_order(struct zone *zone, unsigned int order);
>  extern int fragmentation_index(struct zone *zone, unsigned int order);
>  extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>  		unsigned int order, unsigned int alloc_flags,
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 672d3c78c6ab..d906ccfedce0 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -25,6 +25,10 @@
>  #include <linux/psi.h>
>  #include "internal.h"
>  
> +#ifdef CONFIG_COMPACTION
> +static struct compaction_state compaction_states[MAX_NUMNODES];
> +#endif
> +
>  #ifdef CONFIG_COMPACTION
>  static inline void count_compact_event(enum vm_event_item item)
>  {
> @@ -50,6 +54,8 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
>  #define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
>  #define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
>  
> +static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
> +
>  static unsigned long release_freepages(struct list_head *freelist)
>  {
>  	struct page *page, *next;
> @@ -1846,6 +1852,51 @@ static inline bool is_via_compact_memory(int order)
>  	return order == -1;
>  }
>  
> +static int proactive_compaction_score_zone(struct zone *zone)
> +{
> +	unsigned long score;
> +
> +	score = zone->present_pages *
> +			extfrag_for_order(zone, HUGETLB_PAGE_ORDER);
> +	score = div64_ul(score,
> +			node_present_pages(zone->zone_pgdat->node_id) + 1);
> +	return score;
> +}
> +
> +static int proactive_compaction_score_node(pg_data_t *pgdat)
> +{
> +	unsigned long score = 0;
> +	int zoneid;
> +
> +	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
> +		struct zone *zone;
> +
> +		zone = &pgdat->node_zones[zoneid];
> +		score += proactive_compaction_score_zone(zone);
> +	}
> +
> +	return score;
> +}
> +
> +static int proactive_compaction_score_wmark(pg_data_t *pgdat, bool low)
> +{
> +	int wmark_low;
> +
> +	wmark_low = 100 - compaction_states[pgdat->node_id].proactiveness;
> +	return low ? wmark_low : min(wmark_low + 10, 100);
> +}
> +
> +static bool should_proactive_compact_node(pg_data_t *pgdat)
> +{
> +	int wmark_high;
> +
> +	if (!compaction_states[pgdat->node_id].proactiveness)
> +		return false;
> +
> +	wmark_high = proactive_compaction_score_wmark(pgdat, false);
> +	return proactive_compaction_score_node(pgdat) > wmark_high;
> +}
> +
>  static enum compact_result __compact_finished(struct compact_control *cc)
>  {
>  	unsigned int order;
> @@ -1872,6 +1923,19 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  			return COMPACT_PARTIAL_SKIPPED;
>  	}
>  
> +	if (cc->proactive_compaction) {
> +		int score, wmark_low;
> +
> +		score = proactive_compaction_score_zone(cc->zone);
> +		wmark_low = proactive_compaction_score_wmark(
> +					cc->zone->zone_pgdat, true);
> +		if (score > wmark_low)
> +			ret = COMPACT_CONTINUE;
> +		else
> +			ret = COMPACT_SUCCESS;
> +		goto out;
> +	}
> +
>  	if (is_via_compact_memory(cc->order))
>  		return COMPACT_CONTINUE;
>  
> @@ -1930,6 +1994,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  		}
>  	}
>  
> +out:
>  	if (cc->contended || fatal_signal_pending(current))
>  		ret = COMPACT_CONTENDED;
>  
> @@ -2301,6 +2366,7 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  		.alloc_flags = alloc_flags,
>  		.classzone_idx = classzone_idx,
>  		.direct_compaction = true,
> +		.proactive_compaction = false,
>  		.whole_zone = (prio == MIN_COMPACT_PRIORITY),
>  		.ignore_skip_hint = (prio == MIN_COMPACT_PRIORITY),
>  		.ignore_block_suitable = (prio == MIN_COMPACT_PRIORITY)
> @@ -2404,6 +2470,34 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
>  	return rc;
>  }
>  
> +/* Compact all zones within a node according to proactiveness */
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
> +		.direct_compaction = false,
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
> @@ -2417,9 +2511,10 @@ static void compact_node(int nid)
>  		.ignore_skip_hint = true,
>  		.whole_zone = true,
>  		.gfp_mask = GFP_KERNEL,
> +		.direct_compaction = false,
> +		.proactive_compaction = false,
>  	};
>  
> -
>  	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
>  
>  		zone = &pgdat->node_zones[zoneid];
> @@ -2492,6 +2587,118 @@ void compaction_unregister_node(struct node *node)
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
> +static struct kobject *compaction_kobjs[MAX_NUMNODES];
> +
> +static struct compaction_state *kobj_to_compaction_state(struct kobject *kobj)
> +{
> +	int node;
> +
> +	for_each_online_node(node) {
> +		if (compaction_kobjs[node] == kobj)
> +			return &compaction_states[node];
> +	}
> +
> +	return NULL;
> +}
> +
> +static ssize_t proactiveness_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	int err;
> +	unsigned long input;
> +	struct compaction_state *c = kobj_to_compaction_state(kobj);
> +
> +	err = kstrtoul(buf, 10, &input);
> +	if (err)
> +		return err;
> +	if (input > 100)
> +		return -EINVAL;
> +
> +	c->proactiveness = input;
> +	return count;
> +}
> +
> +static ssize_t proactiveness_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct compaction_state *c = kobj_to_compaction_state(kobj);
> +
> +	return sprintf(buf, "%u\n", c->proactiveness);
> +}
> +
> +COMPACTION_ATTR(proactiveness);
> +
> +static struct attribute *compaction_attrs[] = {
> +	&proactiveness_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group compaction_attr_group = {
> +	.attrs = compaction_attrs,
> +};
> +
> +static int compaction_sysfs_add_node(struct compaction_state *c,
> +	struct kobject *parent, struct kobject **compaction_kobjs,
> +	const struct attribute_group *compaction_attr_group)
> +{
> +	int retval;
> +
> +	compaction_kobjs[c->node_id] =
> +			kobject_create_and_add(c->name, parent);
> +	if (!compaction_kobjs[c->node_id])
> +		return -ENOMEM;
> +
> +	retval = sysfs_create_group(compaction_kobjs[c->node_id],
> +				compaction_attr_group);
> +	if (retval)
> +		kobject_put(compaction_kobjs[c->node_id]);
> +
> +	return retval;
> +}
> +
> +static void __init compaction_sysfs_init(void)
> +{
> +	struct compaction_state *c;
> +	int err, node;
> +
> +	compaction_kobj = kobject_create_and_add("compaction", mm_kobj);
> +	if (!compaction_kobj)
> +		return;
> +
> +	for_each_online_node(node) {
> +		c = &compaction_states[node];
> +		err = compaction_sysfs_add_node(c, compaction_kobj,
> +					compaction_kobjs,
> +					&compaction_attr_group);
> +		if (err)
> +			pr_err("compaction: Unable to add state %s", c->name);
> +	}
> +}
> +
> +static void __init compaction_init(void)
> +{
> +	int node;
> +
> +	for_each_online_node(node) {
> +		struct compaction_state *c = &compaction_states[node];
> +
> +		c->node_id = node;
> +		c->proactiveness = 0;
> +		snprintf(c->name, COMPACTION_STATE_NAME_LEN, "node-%d", node);
> +	}
> +}
> +#endif
> +
>  static inline bool kcompactd_work_requested(pg_data_t *pgdat)
>  {
>  	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
> @@ -2532,6 +2739,8 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>  		.mode = MIGRATE_SYNC_LIGHT,
>  		.ignore_skip_hint = false,
>  		.gfp_mask = GFP_KERNEL,
> +		.direct_compaction = false,
> +		.proactive_compaction = false,
>  	};
>  	trace_mm_compaction_kcompactd_wake(pgdat->node_id, cc.order,
>  							cc.classzone_idx);
> @@ -2629,6 +2838,7 @@ static int kcompactd(void *p)
>  {
>  	pg_data_t *pgdat = (pg_data_t*)p;
>  	struct task_struct *tsk = current;
> +	unsigned int proactive_defer = 0;
>  
>  	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>  
> @@ -2644,12 +2854,29 @@ static int kcompactd(void *p)
>  		unsigned long pflags;
>  
>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
> -		wait_event_freezable(pgdat->kcompactd_wait,
> -				kcompactd_work_requested(pgdat));
> +		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> +			kcompactd_work_requested(pgdat),
> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
>  
> -		psi_memstall_enter(&pflags);
> -		kcompactd_do_work(pgdat);
> -		psi_memstall_leave(&pflags);
> +			psi_memstall_enter(&pflags);
> +			kcompactd_do_work(pgdat);
> +			psi_memstall_leave(&pflags);
> +			continue;
> +		}
> +
> +		if (should_proactive_compact_node(pgdat)) {
> +			unsigned int prev_score, score;
> +
> +			if (proactive_defer) {
> +				proactive_defer--;
> +				continue;
> +			}
> +			prev_score = proactive_compaction_score_node(pgdat);
> +			proactive_compact_node(pgdat);
> +			score = proactive_compaction_score_node(pgdat);
> +			proactive_defer = score < prev_score ?
> +					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
> +		}
>  	}
>  
>  	return 0;
> @@ -2726,6 +2953,9 @@ static int __init kcompactd_init(void)
>  		return ret;
>  	}
>  
> +	compaction_init();
> +	compaction_sysfs_init();
> +
>  	for_each_node_state(nid, N_MEMORY)
>  		kcompactd_run(nid);
>  	return 0;
> diff --git a/mm/internal.h b/mm/internal.h
> index 3cf20ab3ca01..e66bafd6c7a2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -203,6 +203,7 @@ struct compact_control {
>  	bool no_set_skip_hint;		/* Don't mark blocks for skipping */
>  	bool ignore_block_suitable;	/* Scan blocks considered unsuitable */
>  	bool direct_compaction;		/* False from kcompactd or /proc/... */
> +	bool proactive_compaction;	/* kcompactd proactive compaction */
>  	bool whole_zone;		/* Whole zone should/has been scanned */
>  	bool contended;			/* Signal lock or sched contention */
>  	bool rescan;			/* Rescanning the same pageblock */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..e92c706e93ee 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8402,6 +8402,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  		.ignore_skip_hint = true,
>  		.no_set_skip_hint = true,
>  		.gfp_mask = current_gfp_context(gfp_mask),
> +		.proactive_compaction = false,
>  	};
>  	INIT_LIST_HEAD(&cc.migratepages);
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 78d53378db99..70d724122643 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1074,6 +1074,18 @@ static int __fragmentation_index(unsigned int order, struct contig_page_info *in
>  	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, requested))), info->free_blocks_total);
>  }
>  
> +int extfrag_for_order(struct zone *zone, unsigned int order)
> +{
> +	struct contig_page_info info;
> +
> +	fill_contig_page_info(zone, order, &info);
> +	if (info.free_pages == 0)
> +		return 0;
> +
> +	return (info.free_pages - (info.free_blocks_suitable << order)) * 100
> +							/ info.free_pages;
> +}
> +
>  /* Same as __fragmentation index but allocs contig_page_info on stack */
>  int fragmentation_index(struct zone *zone, unsigned int order)
>  {
> 

