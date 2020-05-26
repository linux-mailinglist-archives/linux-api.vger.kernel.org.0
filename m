Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9317F1D8520
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgERSQp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 14:16:45 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7721 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgERSQn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 14:16:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec2d0100001>; Mon, 18 May 2020 11:12:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 11:14:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 11:14:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 18:14:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 18 May 2020 18:14:53 +0000
Received: from ng-desktop.nvidia.com (Not Verified[10.110.48.88]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec2d09d0000>; Mon, 18 May 2020 11:14:53 -0700
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Nitin Gupta <nigupta@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v5] mm: Proactive compaction
Date:   Mon, 18 May 2020 11:14:46 -0700
Message-ID: <20200518181446.25759-1-nigupta@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589825552; bh=TKT/WONayIZoH5NmSE+qpc/v34RwPKVydjNuYULGbcI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=o4WUt1kWUCom/IFr+0g5X6E3WNRB1TMvTBCe6x2mFQA9vKJMfC28H9pEQnF0e+Afp
         jnGsxQ/ghReEKPrZjTTajkkuolWDkVR4DwfiLDuSoY9+/DYsRu2OUVdqW+zaAg8ZU7
         pOt0Z0iQt/wu8QQxfiIx4WvnMleLpvdE24eXY1O1svUnWn6XY6/qsGfbnJNYmaUlru
         j2viyiQpRQiQgDiKCOoWqqb6iSLxODMXd+WJo0mYgNQEivowD6YYYgkqitck5oklsK
         XCJKsAYVy/sRXx+cmmhr9JChuvBf6WcdGGeHH6AnqTQVtuTi8VfS2CeREBqtkKsegy
         xD/GBMf9pHQag==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

For some applications, we need to allocate almost all memory as
hugepages. However, on a running system, higher-order allocations can
fail if the memory is fragmented. Linux kernel currently does on-demand
compaction as we request more hugepages, but this style of compaction
incurs very high latency. Experiments with one-time full memory
compaction (followed by hugepage allocations) show that kernel is able
to restore a highly fragmented memory state to a fairly compacted memory
state within <1 sec for a 32G system. Such data suggests that a more
proactive compaction can help us allocate a large fraction of memory as
hugepages keeping allocation latencies low.

For a more proactive compaction, the approach taken here is to define
a new tunable called 'proactiveness' which dictates bounds for external
fragmentation wrt HUGETLB_PAGE_ORDER order which kcompactd tries to
maintain.

The tunable is exposed through sysctl:
  /proc/sys/vm/compaction_proactiveness

It takes value in range [0, 100], with a default of 20.

Note that a previous version of this patch [1] was found to introduce too
many tunables (per-order extfrag{low, high}), but this one reduces them
to just one (proactiveness). Also, the new tunable is an opaque value
instead of asking for specific bounds of "external fragmentation", which
would have been difficult to estimate. The internal interpretation of
this opaque value allows for future fine-tuning.

Currently, we use a simple translation from this tunable to [low, high]
"fragmentation score" thresholds (low=3D100-proactiveness, high=3Dlow+10%).
The score for a node is defined as weighted mean of per-zone external
fragmentation wrt HUGETLB_PAGE_ORDER order. A zone's present_pages
determines its weight.

To periodically check per-node score, we reuse per-node kcompactd
threads, which are woken up every 500 milliseconds to check the same. If
a node's score exceeds its high threshold (as derived from user-provided
proactiveness value), proactive compaction is started until its score
reaches its low threshold value. By default, proactiveness is set to 20,
which implies threshold values of low=3D80 and high=3D90.

This patch is largely based on ideas from Michal Hocko posted here:
https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/

Performance data
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

System: x64_64, 1T RAM, 80 CPU threads.
Kernel: 5.6.0-rc3 + this patch

echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/defrag

Before starting the driver, the system was fragmented from a userspace
program that allocates all memory and then for each 2M aligned section,
frees 3/4 of base pages using munmap. The workload is mainly anonymous
userspace pages, which are easy to move around. I intentionally avoided
unmovable pages in this test to see how much latency we incur when
hugepage allocations hit direct compaction.

1. Kernel hugepage allocation latencies

With the system in such a fragmented state, a kernel driver then allocates
as many hugepages as possible and measures allocation latency:

(all latency values are in microseconds)

- With vanilla 5.6.0-rc3

echo 0 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness

  percentile latency
  =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93=E2=80=93 =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93
	   5    7894
	  10    9496
	  25   12561
	  30   15295
	  40   18244
	  50   21229
	  60   27556
	  75   30147
	  80   31047
	  90   32859
	  95   33799

Total 2M hugepages allocated =3D 383859 (749G worth of hugepages out of
762G total free =3D> 98% of free memory could be allocated as hugepages)

- With 5.6.0-rc3 + this patch, with proactiveness=3D20

echo 20 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness

  percentile latency
  =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93=E2=80=93 =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93
	   5       2
	  10       2
	  25       3
	  30       3
	  40       3
	  50       4
	  60       4
	  75       4
	  80       4
	  90       5
	  95     429

Total 2M hugepages allocated =3D 384105 (750G worth of hugepages out of
762G total free =3D> 98% of free memory could be allocated as hugepages)

2. JAVA heap allocation

In this test, we first fragment memory using the same method as for (1).

Then, we start a Java process with a heap size set to 700G and request
the heap to be allocated with THP hugepages. We also set THP to madvise
to allow hugepage backing of this heap.

/usr/bin/time
 java -Xms700G -Xmx700G -XX:+UseTransparentHugePages -XX:+AlwaysPreTouch

The above command allocates 700G of Java heap using hugepages.

- With vanilla 5.6.0-rc3

17.39user 1666.48system 27:37.89elapsed

- With 5.6.0-rc3 + this patch, with proactiveness=3D20

8.35user 194.58system 3:19.62elapsed

Elapsed time remains around 3:15, as proactiveness is further increased.

Note that proactive compaction happens throughout the runtime of these
workloads. The situation of one-time compaction, sufficient to supply
hugepages for following allocation stream, can probably happen for more
extreme proactiveness values, like 80 or 90.

In the above Java workload, proactiveness is set to 20. The test starts
with a node's score of 80 or higher, depending on the delay between the
fragmentation step and starting the benchmark, which gives more-or-less
time for the initial round of compaction. As the benchmark consumes
hugepages, node's score quickly rises above the high threshold (90) and
proactive compaction starts again, which brings down the score to the
low threshold level (80).  Repeat.

bpftrace also confirms proactive compaction running 20+ times during the
runtime of this Java benchmark. kcompactd threads consume 100% of one of
the CPUs while it tries to bring a node's score within thresholds.

Backoff behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Above workloads produce a memory state which is easy to compact.
However, if memory is filled with unmovable pages, proactive compaction
should essentially back off. To test this aspect:

- Created a kernel driver that allocates almost all memory as hugepages
  followed by freeing first 3/4 of each hugepage.
- Set proactiveness=3D40
- Note that proactive_compact_node() is deferred maximum number of times
  with HPAGE_FRAG_CHECK_INTERVAL_MSEC of wait between each check
  (=3D> ~30 seconds between retries).

[1] https://patchwork.kernel.org/patch/11098289/

Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
To: Mel Gorman <mgorman@techsingularity.net>
To: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mike Kravetz <mike.kravetz@oracle.com>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: David Rientjes <rientjes@google.com>
CC: Nitin Gupta <ngupta@nitingupta.dev>
CC: linux-kernel <linux-kernel@vger.kernel.org>
CC: linux-mm <linux-mm@kvack.org>
CC: Linux API <linux-api@vger.kernel.org>

---
Changelog v5 vs v4:
 - Change tunable from sysfs to sysctl (Vlastimil)
 - HUGETLB_PAGE_ORDER -> HPAGE_PMD_ORDER (Vlastimil)
 - Minor cleanups (remove redundant initializations, ...)

Changelog v4 vs v3:
 - Document various functions.
 - Added admin-guide for the new tunable `proactiveness`.
 - Rename proactive_compaction_score to fragmentation_score for clarity.

Changelog v3 vs v2:
 - Make proactiveness a global tunable and not per-node. Also upadated the
   patch description to reflect the same (Vlastimil Babka).
 - Don't start proactive compaction if kswapd is running (Vlastimil Babka).
 - Clarified in the description that compaction runs in parallel with
   the workload, instead of a one-time compaction followed by a stream of
   hugepage allocations.

Changelog v2 vs v1:
 - Introduce per-node and per-zone "proactive compaction score". This
   score is compared against watermarks which are set according to
   user provided proactiveness value.
 - Separate code-paths for proactive compaction from targeted compaction
   i.e. where pgdat->kcompactd_max_order is non-zero.
 - Renamed hpage_compaction_effort -> proactiveness. In future we may
   use more than extfrag wrt hugepage size to determine proactive
   compaction score.
---
 Documentation/admin-guide/sysctl/vm.rst |  13 ++
 include/linux/compaction.h              |   2 +
 kernel/sysctl.c                         |   9 ++
 mm/compaction.c                         | 165 +++++++++++++++++++++++-
 mm/internal.h                           |   1 +
 mm/vmstat.c                             |  17 +++
 6 files changed, 202 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-=
guide/sysctl/vm.rst
index 0329a4d3fa9e..e5d88cabe980 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -119,6 +119,19 @@ all zones are compacted such that free memory is avail=
able in contiguous
 blocks where possible. This can be important for example in the allocation=
 of
 huge pages although processes will also directly compact memory as require=
d.
=20
+compaction_proactiveness
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This tunable takes a value in the range [0, 100] with a default value of
+20. This tunable determines how aggressively compaction is done in the
+background. Setting it to 0 disables proactive compaction.
+
+Note that compaction has a non-trivial system-wide impact as pages
+belonging to different processes are moved around, which could also lead
+to latency spikes in unsuspecting applications. The kernel employs
+various heuristics to avoid wasting CPU cycles if it detects that
+proactive compaction is not being effective.
+
=20
 compact_unevictable_allowed
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4b898cdbdf05..ccd28978b296 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -85,11 +85,13 @@ static inline unsigned long compact_gap(unsigned int or=
der)
=20
 #ifdef CONFIG_COMPACTION
 extern int sysctl_compact_memory;
+extern int sysctl_compaction_proactiveness;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void __user *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
=20
+extern int extfrag_for_order(struct zone *zone, unsigned int order);
 extern int fragmentation_index(struct zone *zone, unsigned int order);
 extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		unsigned int order, unsigned int alloc_flags,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..51c90906efbc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1458,6 +1458,15 @@ static struct ctl_table vm_table[] =3D {
 		.mode		=3D 0200,
 		.proc_handler	=3D sysctl_compaction_handler,
 	},
+	{
+		.procname	=3D "compaction_proactiveness",
+		.data		=3D &sysctl_compaction_proactiveness,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D &one_hundred,
+	},
 	{
 		.procname	=3D "extfrag_threshold",
 		.data		=3D &sysctl_extfrag_threshold,
diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc93081..bf7f57a475ce 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -50,6 +50,11 @@ static inline void count_compact_events(enum vm_event_it=
em item, long delta)
 #define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
 #define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
=20
+/*
+ * Fragmentation score check interval for proactive compaction purposes.
+ */
+static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC =3D 500;
+
 static unsigned long release_freepages(struct list_head *freelist)
 {
 	struct page *page, *next;
@@ -1855,6 +1860,71 @@ static inline bool is_via_compact_memory(int order)
 	return order =3D=3D -1;
 }
=20
+static bool kswapd_is_running(pg_data_t *pgdat)
+{
+	return pgdat->kswapd && (pgdat->kswapd->state =3D=3D TASK_RUNNING);
+}
+
+/*
+ * A zone's fragmentation score is the external fragmentation wrt to the
+ * HUGETLB_PAGE_ORDER scaled by the zone's size. It returns a value in the
+ * range [0, 100].
+
+ * The scaling factor ensures that proactive compaction focuses on larger
+ * zones like ZONE_NORMAL, rather than smaller, specialized zones like
+ * ZONE_DMA32. For smaller zones, the score value remains close to zero,
+ * and thus never exceeds the high threshold for proactive compaction.
+ */
+static int fragmentation_score_zone(struct zone *zone)
+{
+	unsigned long score;
+
+	score =3D zone->present_pages *
+			extfrag_for_order(zone, HPAGE_PMD_ORDER);
+	return div64_ul(score, zone->zone_pgdat->node_present_pages + 1);
+}
+
+/*
+ * The per-node proactive (background) compaction process is started by it=
s
+ * corresponding kcompactd thread when the node's fragmentation score
+ * exceeds the high threshold. The compaction process remains active till
+ * the node's score falls below the low threshold, or one of the back-off
+ * conditions is met.
+ */
+static int fragmentation_score_node(pg_data_t *pgdat)
+{
+	unsigned long score =3D 0;
+	int zoneid;
+
+	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
+		struct zone *zone;
+
+		zone =3D &pgdat->node_zones[zoneid];
+		score +=3D fragmentation_score_zone(zone);
+	}
+
+	return score;
+}
+
+static int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
+{
+	int wmark_low;
+
+	wmark_low =3D 100 - sysctl_compaction_proactiveness;
+	return low ? wmark_low : min(wmark_low + 10, 100);
+}
+
+static bool should_proactive_compact_node(pg_data_t *pgdat)
+{
+	int wmark_high;
+
+	if (!sysctl_compaction_proactiveness || kswapd_is_running(pgdat))
+		return false;
+
+	wmark_high =3D fragmentation_score_wmark(pgdat, false);
+	return fragmentation_score_node(pgdat) > wmark_high;
+}
+
 static enum compact_result __compact_finished(struct compact_control *cc)
 {
 	unsigned int order;
@@ -1881,6 +1951,25 @@ static enum compact_result __compact_finished(struct=
 compact_control *cc)
 			return COMPACT_PARTIAL_SKIPPED;
 	}
=20
+	if (cc->proactive_compaction) {
+		int score, wmark_low;
+		pg_data_t *pgdat;
+
+		pgdat =3D cc->zone->zone_pgdat;
+		if (kswapd_is_running(pgdat))
+			return COMPACT_PARTIAL_SKIPPED;
+
+		score =3D fragmentation_score_zone(cc->zone);
+		wmark_low =3D fragmentation_score_wmark(pgdat, true);
+
+		if (score > wmark_low)
+			ret =3D COMPACT_CONTINUE;
+		else
+			ret =3D COMPACT_SUCCESS;
+
+		goto out;
+	}
+
 	if (is_via_compact_memory(cc->order))
 		return COMPACT_CONTINUE;
=20
@@ -1939,6 +2028,7 @@ static enum compact_result __compact_finished(struct =
compact_control *cc)
 		}
 	}
=20
+out:
 	if (cc->contended || fatal_signal_pending(current))
 		ret =3D COMPACT_CONTENDED;
=20
@@ -2412,6 +2502,41 @@ enum compact_result try_to_compact_pages(gfp_t gfp_m=
ask, unsigned int order,
 	return rc;
 }
=20
+/*
+ * Compact all zones within a node till each zone's fragmentation score
+ * reaches within proactive compaction thresholds (as determined by the
+ * proactiveness tunable).
+ *
+ * It is possible that the function returns before reaching score targets
+ * due to various back-off conditions, such as, contention on per-node or
+ * per-zone locks.
+ */
+static void proactive_compact_node(pg_data_t *pgdat)
+{
+	int zoneid;
+	struct zone *zone;
+	struct compact_control cc =3D {
+		.order =3D -1,
+		.mode =3D MIGRATE_SYNC_LIGHT,
+		.ignore_skip_hint =3D true,
+		.whole_zone =3D true,
+		.gfp_mask =3D GFP_KERNEL,
+		.proactive_compaction =3D true,
+	};
+
+	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
+		zone =3D &pgdat->node_zones[zoneid];
+		if (!populated_zone(zone))
+			continue;
+
+		cc.zone =3D zone;
+
+		compact_zone(&cc, NULL);
+
+		VM_BUG_ON(!list_empty(&cc.freepages));
+		VM_BUG_ON(!list_empty(&cc.migratepages));
+	}
+}
=20
 /* Compact all zones within a node */
 static void compact_node(int nid)
@@ -2458,6 +2583,13 @@ static void compact_nodes(void)
 /* The written value is actually unused, all memory is compacted */
 int sysctl_compact_memory;
=20
+/*
+ * Tunable for proactive compaction. It determines how
+ * aggressively the kernel should compact memory in the
+ * background. It takes values in the range [0, 100].
+ */
+int sysctl_compaction_proactiveness =3D 20;
+
 /*
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
@@ -2637,6 +2769,7 @@ static int kcompactd(void *p)
 {
 	pg_data_t *pgdat =3D (pg_data_t*)p;
 	struct task_struct *tsk =3D current;
+	unsigned int proactive_defer =3D 0;
=20
 	const struct cpumask *cpumask =3D cpumask_of_node(pgdat->node_id);
=20
@@ -2652,12 +2785,34 @@ static int kcompactd(void *p)
 		unsigned long pflags;
=20
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
-		wait_event_freezable(pgdat->kcompactd_wait,
-				kcompactd_work_requested(pgdat));
+		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
+			kcompactd_work_requested(pgdat),
+			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
+
+			psi_memstall_enter(&pflags);
+			kcompactd_do_work(pgdat);
+			psi_memstall_leave(&pflags);
+			continue;
+		}
=20
-		psi_memstall_enter(&pflags);
-		kcompactd_do_work(pgdat);
-		psi_memstall_leave(&pflags);
+		/* kcompactd wait timeout */
+		if (should_proactive_compact_node(pgdat)) {
+			unsigned int prev_score, score;
+
+			if (proactive_defer) {
+				proactive_defer--;
+				continue;
+			}
+			prev_score =3D fragmentation_score_node(pgdat);
+			proactive_compact_node(pgdat);
+			score =3D fragmentation_score_node(pgdat);
+			/*
+			 * Defer proactive compaction if the fragmentation
+			 * score did not go down i.e. no progress made.
+			 */
+			proactive_defer =3D score < prev_score ?
+					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
+		}
 	}
=20
 	return 0;
diff --git a/mm/internal.h b/mm/internal.h
index b5634e78f01d..9671bccd97d5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -228,6 +228,7 @@ struct compact_control {
 	bool no_set_skip_hint;		/* Don't mark blocks for skipping */
 	bool ignore_block_suitable;	/* Scan blocks considered unsuitable */
 	bool direct_compaction;		/* False from kcompactd or /proc/... */
+	bool proactive_compaction;	/* kcompactd proactive compaction */
 	bool whole_zone;		/* Whole zone should/has been scanned */
 	bool contended;			/* Signal lock or sched contention */
 	bool rescan;			/* Rescanning the same pageblock */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..d7ab7dbdc3a5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1074,6 +1074,23 @@ static int __fragmentation_index(unsigned int order,=
 struct contig_page_info *in
 	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, request=
ed))), info->free_blocks_total);
 }
=20
+/*
+ * Calculates external fragmentation within a zone wrt the given order.
+ * It is defined as the percentage of pages found in blocks of size
+ * less than 1 << order. It returns values in range [0, 100].
+ */
+int extfrag_for_order(struct zone *zone, unsigned int order)
+{
+	struct contig_page_info info;
+
+	fill_contig_page_info(zone, order, &info);
+	if (info.free_pages =3D=3D 0)
+		return 0;
+
+	return (info.free_pages - (info.free_blocks_suitable << order)) * 100
+							/ info.free_pages;
+}
+
 /* Same as __fragmentation index but allocs contig_page_info on stack */
 int fragmentation_index(struct zone *zone, unsigned int order)
 {
--=20
2.26.2

