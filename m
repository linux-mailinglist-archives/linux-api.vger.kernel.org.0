Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012411BCF80
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 00:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgD1WLG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 18:11:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12754 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1WLF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 18:11:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea8a97e0001>; Tue, 28 Apr 2020 15:09:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Apr 2020 15:11:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Apr 2020 15:11:04 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Apr
 2020 22:11:04 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 28 Apr 2020 22:11:04 +0000
Received: from ng-desktop.nvidia.com (Not Verified[10.110.48.88]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea8a9f80000>; Tue, 28 Apr 2020 15:11:04 -0700
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
Subject: [PATCH v4] mm: Proactive compaction
Date:   Tue, 28 Apr 2020 15:10:55 -0700
Message-ID: <20200428221055.598-1-nigupta@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588111742; bh=XxVJgo2x7L/V0YQeaF4kw/val9bGxGvMgaKGrRCQ3tQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=AXXcvWx+4r9PgVFlTwYVeZJ7QycrkuM22mtqagsDZhBb4CzUu4v86ecqJ9JSMru1i
         gcQ8E+IewmvXXiG8/8eJImlcfqvemwgGQLuZXzvyxyxWAM91rF8GNyiB7aAjmQDNOR
         /q+9MeIwflo71daoxWm9YxbdiMuFUzaq75Z8yf24oT/0NSCgj+pHWpl/cwZGurLhN1
         oklfH3UjFj7TJmhuq9iApCYiGqIozW8dXlABtetK8CQOB6b6kIOSvpsdRkz/AbMkfX
         w62jcgLocTQAPQ/mbPstymOVmjn6icnCYy9zZjmd7p+0bN7Nc5XmkFbnHsEAHRsibz
         E8Hwa4TDOEuxg==
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

The tunable is exposed through sysfs:
  /sys/kernel/mm/compaction/proactiveness

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
 .../admin-guide/mm/proactive-compaction.rst   |  26 ++
 MAINTAINERS                                   |   6 +
 include/linux/compaction.h                    |   1 +
 mm/compaction.c                               | 236 +++++++++++++++++-
 mm/internal.h                                 |   1 +
 mm/page_alloc.c                               |   1 +
 mm/vmstat.c                                   |  17 ++
 7 files changed, 282 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/proactive-compaction.rst

diff --git a/Documentation/admin-guide/mm/proactive-compaction.rst b/Docume=
ntation/admin-guide/mm/proactive-compaction.rst
new file mode 100644
index 000000000000..510f47e38238
--- /dev/null
+++ b/Documentation/admin-guide/mm/proactive-compaction.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _proactive_compaction:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Proactive Compaction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Many applications benefit significantly from the use of huge pages.
+However, huge-page allocations often incur a high latency or even fail
+under fragmented memory conditions. Proactive compaction provides an
+effective solution to these problems by doing memory compaction in the
+background.
+
+The process of proactive compaction is controlled by a single tunable:
+
+        /sys/kernel/mm/compaction/proactiveness
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 26f281d9f32a..e448c0b35ecb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18737,6 +18737,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
=20
+PROACTIVE COMPACTION
+M:	Nitin Gupta <nigupta@nvidia.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/proactive-compaction.rst
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4b898cdbdf05..47c5df1fa59c 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -90,6 +90,7 @@ extern int sysctl_compaction_handler(struct ctl_table *ta=
ble, int write,
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
=20
+extern int extfrag_for_order(struct zone *zone, unsigned int order);
 extern int fragmentation_index(struct zone *zone, unsigned int order);
 extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		unsigned int order, unsigned int alloc_flags,
diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc93081..f2c0e78f1953 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -26,6 +26,16 @@
 #include "internal.h"
=20
 #ifdef CONFIG_COMPACTION
+/*
+ * Tunable for proactive compaction, exposed via sysfs:
+ *	/sys/kernel/mm/compaction/proactiveness
+ *
+ * This tunable determines how aggressively the kernel
+ * should compact memory in the background. It takes
+ * values in the range [0, 100].
+ */
+static unsigned int compaction_proactiveness =3D 20;
+
 static inline void count_compact_event(enum vm_event_item item)
 {
 	count_vm_event(item);
@@ -50,6 +60,11 @@ static inline void count_compact_events(enum vm_event_it=
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
@@ -1855,6 +1870,73 @@ static inline bool is_via_compact_memory(int order)
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
+			extfrag_for_order(zone, HUGETLB_PAGE_ORDER);
+	score =3D div64_ul(score,
+			node_present_pages(zone->zone_pgdat->node_id) + 1);
+	return score;
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
+	wmark_low =3D 100 - compaction_proactiveness;
+	return low ? wmark_low : min(wmark_low + 10, 100);
+}
+
+static bool should_proactive_compact_node(pg_data_t *pgdat)
+{
+	int wmark_high;
+
+	if (!compaction_proactiveness || kswapd_is_running(pgdat))
+		return false;
+
+	wmark_high =3D fragmentation_score_wmark(pgdat, false);
+	return fragmentation_score_node(pgdat) > wmark_high;
+}
+
 static enum compact_result __compact_finished(struct compact_control *cc)
 {
 	unsigned int order;
@@ -1881,6 +1963,25 @@ static enum compact_result __compact_finished(struct=
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
@@ -1939,6 +2040,7 @@ static enum compact_result __compact_finished(struct =
compact_control *cc)
 		}
 	}
=20
+out:
 	if (cc->contended || fatal_signal_pending(current))
 		ret =3D COMPACT_CONTENDED;
=20
@@ -2309,6 +2411,7 @@ static enum compact_result compact_zone_order(struct =
zone *zone, int order,
 		.alloc_flags =3D alloc_flags,
 		.classzone_idx =3D classzone_idx,
 		.direct_compaction =3D true,
+		.proactive_compaction =3D false,
 		.whole_zone =3D (prio =3D=3D MIN_COMPACT_PRIORITY),
 		.ignore_skip_hint =3D (prio =3D=3D MIN_COMPACT_PRIORITY),
 		.ignore_block_suitable =3D (prio =3D=3D MIN_COMPACT_PRIORITY)
@@ -2412,6 +2515,42 @@ enum compact_result try_to_compact_pages(gfp_t gfp_m=
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
+		.direct_compaction =3D false,
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
@@ -2425,9 +2564,10 @@ static void compact_node(int nid)
 		.ignore_skip_hint =3D true,
 		.whole_zone =3D true,
 		.gfp_mask =3D GFP_KERNEL,
+		.direct_compaction =3D false,
+		.proactive_compaction =3D false,
 	};
=20
-
 	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
=20
 		zone =3D &pgdat->node_zones[zoneid];
@@ -2500,6 +2640,63 @@ void compaction_unregister_node(struct node *node)
 }
 #endif /* CONFIG_SYSFS && CONFIG_NUMA */
=20
+#ifdef CONFIG_SYSFS
+
+#define COMPACTION_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
+
+#define COMPACTION_ATTR(_name) \
+	static struct kobj_attribute _name##_attr =3D \
+		__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static struct kobject *compaction_kobj;
+
+static ssize_t proactiveness_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long input;
+
+	err =3D kstrtoul(buf, 10, &input);
+	if (err)
+		return err;
+	if (input > 100)
+		return -EINVAL;
+
+	compaction_proactiveness =3D input;
+	return count;
+}
+
+static ssize_t proactiveness_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", compaction_proactiveness);
+}
+
+COMPACTION_ATTR(proactiveness);
+
+static struct attribute *compaction_attrs[] =3D {
+	&proactiveness_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group compaction_attr_group =3D {
+	.attrs =3D compaction_attrs,
+};
+
+static void __init compaction_sysfs_init(void)
+{
+	compaction_kobj =3D kobject_create_and_add("compaction", mm_kobj);
+	if (!compaction_kobj)
+		return;
+
+	if (sysfs_create_group(compaction_kobj, &compaction_attr_group)) {
+		kobject_put(compaction_kobj);
+		compaction_kobj =3D NULL;
+	}
+}
+#endif
+
 static inline bool kcompactd_work_requested(pg_data_t *pgdat)
 {
 	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
@@ -2540,6 +2737,8 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.mode =3D MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint =3D false,
 		.gfp_mask =3D GFP_KERNEL,
+		.direct_compaction =3D false,
+		.proactive_compaction =3D false,
 	};
 	trace_mm_compaction_kcompactd_wake(pgdat->node_id, cc.order,
 							cc.classzone_idx);
@@ -2637,6 +2836,7 @@ static int kcompactd(void *p)
 {
 	pg_data_t *pgdat =3D (pg_data_t*)p;
 	struct task_struct *tsk =3D current;
+	unsigned int proactive_defer =3D 0;
=20
 	const struct cpumask *cpumask =3D cpumask_of_node(pgdat->node_id);
=20
@@ -2652,12 +2852,34 @@ static int kcompactd(void *p)
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
@@ -2734,6 +2956,8 @@ static int __init kcompactd_init(void)
 		return ret;
 	}
=20
+	compaction_sysfs_init();
+
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..f389cc22ecaf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8479,6 +8479,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 		.no_set_skip_hint =3D true,
 		.gfp_mask =3D current_gfp_context(gfp_mask),
 		.alloc_contig =3D true,
+		.proactive_compaction =3D false,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
=20
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

