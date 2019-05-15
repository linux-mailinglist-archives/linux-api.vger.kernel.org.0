Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169541EB60
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfEOJpf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:35 -0400
Received: from foss.arm.com ([217.140.101.70]:39224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJpf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A55A515A2;
        Wed, 15 May 2019 02:45:34 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 603AF3F703;
        Wed, 15 May 2019 02:45:31 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v9 01/16] sched/core: uclamp: Add CPU's clamp buckets refcounting
Date:   Wed, 15 May 2019 10:44:44 +0100
Message-Id: <20190515094459.10317-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Utilization clamping allows to clamp the CPU's utilization within a
[util_min, util_max] range, depending on the set of RUNNABLE tasks on
that CPU. Each task references two "clamp buckets" defining its minimum
and maximum (util_{min,max}) utilization "clamp values". A CPU's clamp
bucket is active if there is at least one RUNNABLE tasks enqueued on
that CPU and refcounting that bucket.

When a task is {en,de}queued {on,from} a rq, the set of active clamp
buckets on that CPU can change. If the set of active clamp buckets
changes for a CPU a new "aggregated" clamp value is computed for that
CPU. This is because each clamp bucket enforces a different utilization
clamp value.

Clamp values are always MAX aggregated for both util_min and util_max.
This ensures that no task can affect the performance of other
co-scheduled tasks which are more boosted (i.e. with higher util_min
clamp) or less capped (i.e. with higher util_max clamp).

A task has:
   task_struct::uclamp[clamp_id]::bucket_id
to track the "bucket index" of the CPU's clamp bucket it refcounts while
enqueued, for each clamp index (clamp_id).

A runqueue has:
   rq::uclamp[clamp_id]::bucket[bucket_id].tasks
to track how many RUNNABLE tasks on that CPU refcount each
clamp bucket (bucket_id) of a clamp index (clamp_id).
It also has a:
   rq::uclamp[clamp_id]::bucket[bucket_id].value
to track the clamp value of each clamp bucket (bucket_id) of a clamp
index (clamp_id).

The rq::uclamp::bucket[clamp_id][] array is scanned every time it's
needed to find a new MAX aggregated clamp value for a clamp_id. This
operation is required only when it's dequeued the last task of a clamp
bucket tracking the current MAX aggregated clamp value. In this case,
the CPU is either entering IDLE or going to schedule a less boosted or
more clamped task.
The expected number of different clamp values configured at build time
is small enough to fit the full unordered array into a single cache
line, for configurations of up to 7 buckets.

Add to struct rq the basic data structures required to refcount the
number of RUNNABLE tasks for each clamp bucket. Add also the max
aggregation required to update the rq's clamp value at each
enqueue/dequeue event.

Use a simple linear mapping of clamp values into clamp buckets.
Pre-compute and cache bucket_id to avoid integer divisions at
enqueue/dequeue time.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v9:
 Message-ID: <20190408114908.evij7pqml6ltqtnl@e110439-lin>
 - move uclamp_bucket_base_value() into the following patch
 - simplify bits_per() definition
 Message-ID: <20190508190011.GB32547@worktop.programming.kicks-ass.net>
 - use for_each_clamp_id() and uclamp_se_set() to make code less fragile
 Others:
 - add rq's lockdep assert to uclamp_rq_{inc,dec}_id()
---
 include/linux/log2.h           |  34 +++++++
 include/linux/sched.h          |  39 ++++++++
 include/linux/sched/topology.h |   6 --
 init/Kconfig                   |  53 +++++++++++
 kernel/sched/core.c            | 166 +++++++++++++++++++++++++++++++++
 kernel/sched/sched.h           |  51 ++++++++++
 6 files changed, 343 insertions(+), 6 deletions(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 2af7f77866d0..01d6ba6d8647 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -224,4 +224,38 @@ int __order_base_2(unsigned long n)
 		ilog2((n) - 1) + 1) :		\
 	__order_base_2(n)			\
 )
+
+static inline __attribute__((const))
+int __bits_per(unsigned long n)
+{
+	if (n < 2)
+		return 1;
+	if (is_power_of_2(n))
+		return order_base_2(n) + 1;
+	return order_base_2(n);
+}
+
+/**
+ * bits_per - calculate the number of bits required for the argument
+ * @n: parameter
+ *
+ * This is constant-capable and can be used for compile time
+ * initializations, e.g bitfields.
+ *
+ * The first few values calculated by this routine:
+ * bf(0) = 1
+ * bf(1) = 1
+ * bf(2) = 2
+ * bf(3) = 2
+ * bf(4) = 3
+ * ... and so on.
+ */
+#define bits_per(n)				\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 0 || (n) == 1)		\
+			? 1 : ilog2(n) + 1	\
+	) :					\
+	__bits_per(n)				\
+)
 #endif /* _LINUX_LOG2_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a1538..0cdc22406877 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -282,6 +282,18 @@ struct vtime {
 	u64			gtime;
 };
 
+/*
+ * Utilization clamp constraints.
+ * @UCLAMP_MIN:	Minimum utilization
+ * @UCLAMP_MAX:	Maximum utilization
+ * @UCLAMP_CNT:	Utilization clamp constraints count
+ */
+enum uclamp_id {
+	UCLAMP_MIN = 0,
+	UCLAMP_MAX,
+	UCLAMP_CNT
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
@@ -313,6 +325,10 @@ struct sched_info {
 # define SCHED_FIXEDPOINT_SHIFT		10
 # define SCHED_FIXEDPOINT_SCALE		(1L << SCHED_FIXEDPOINT_SHIFT)
 
+/* Increase resolution of cpu_capacity calculations */
+# define SCHED_CAPACITY_SHIFT		SCHED_FIXEDPOINT_SHIFT
+# define SCHED_CAPACITY_SCALE		(1L << SCHED_CAPACITY_SHIFT)
+
 struct load_weight {
 	unsigned long			weight;
 	u32				inv_weight;
@@ -561,6 +577,25 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
 
+#ifdef CONFIG_UCLAMP_TASK
+/* Number of utilization clamp buckets (shorter alias) */
+#define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
+
+/*
+ * Utilization clamp for a scheduling entity
+ * @value:		clamp value "assigned" to a se
+ * @bucket_id:		bucket index corresponding to the "assigned" value
+ *
+ * The bucket_id is the index of the clamp bucket matching the clamp value
+ * which is pre-computed and stored to avoid expensive integer divisions from
+ * the fast path.
+ */
+struct uclamp_se {
+	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
+	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
+};
+#endif /* CONFIG_UCLAMP_TASK */
+
 union rcu_special {
 	struct {
 		u8			blocked;
@@ -641,6 +676,10 @@ struct task_struct {
 #endif
 	struct sched_dl_entity		dl;
 
+#ifdef CONFIG_UCLAMP_TASK
+	struct uclamp_se		uclamp[UCLAMP_CNT];
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cfc0a89a7159..2bf680b42f3c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -6,12 +6,6 @@
 
 #include <linux/sched/idle.h>
 
-/*
- * Increase resolution of cpu_capacity calculations
- */
-#define SCHED_CAPACITY_SHIFT	SCHED_FIXEDPOINT_SHIFT
-#define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
-
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..8e103505456a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -668,6 +668,59 @@ config HAVE_UNSTABLE_SCHED_CLOCK
 config GENERIC_SCHED_CLOCK
 	bool
 
+menu "Scheduler features"
+
+config UCLAMP_TASK
+	bool "Enable utilization clamping for RT/FAIR tasks"
+	depends on CPU_FREQ_GOV_SCHEDUTIL
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks scheduled on that CPU.
+
+	  With this option, the user can specify the min and max CPU
+	  utilization allowed for RUNNABLE tasks. The max utilization defines
+	  the maximum frequency a task should use while the min utilization
+	  defines the minimum frequency it should use.
+
+	  Both min and max utilization clamp values are hints to the scheduler,
+	  aiming at improving its frequency selection policy, but they do not
+	  enforce or grant any specific bandwidth for tasks.
+
+	  If in doubt, say N.
+
+config UCLAMP_BUCKETS_COUNT
+	int "Number of supported utilization clamp buckets"
+	range 5 20
+	default 5
+	depends on UCLAMP_TASK
+	help
+	  Defines the number of clamp buckets to use. The range of each bucket
+	  will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
+	  number of clamp buckets the finer their granularity and the higher
+	  the precision of clamping aggregation and tracking at run-time.
+
+	  For example, with the minimum configuration value we will have 5
+	  clamp buckets tracking 20% utilization each. A 25% boosted tasks will
+	  be refcounted in the [20..39]% bucket and will set the bucket clamp
+	  effective value to 25%.
+	  If a second 30% boosted task should be co-scheduled on the same CPU,
+	  that task will be refcounted in the same bucket of the first task and
+	  it will boost the bucket clamp effective value to 30%.
+	  The clamp effective value of a bucket is reset to its nominal value
+	  (20% in the example above) when there are no more tasks refcounted in
+	  that bucket.
+
+	  An additional boost/capping margin can be added to some tasks. In the
+	  example above the 25% task will be boosted to 30% until it exits the
+	  CPU. If that should be considered not acceptable on certain systems,
+	  it's always possible to reduce the margin by increasing the number of
+	  clamp buckets to trade off used memory for run-time tracking
+	  precision.
+
+	  If in doubt, use the default value.
+
+endmenu
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cef22c5499a8..29c0d465fd9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -760,6 +760,168 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+
+/* Integer rounded range for each bucket */
+#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
+
+#define for_each_clamp_id(clamp_id) \
+	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
+
+static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
+{
+	return clamp_value / UCLAMP_BUCKET_DELTA;
+}
+
+static inline unsigned int uclamp_none(int clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+	return SCHED_CAPACITY_SCALE;
+}
+
+static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
+{
+	uc_se->value = value;
+	uc_se->bucket_id = uclamp_bucket_id(value);
+}
+
+static inline
+unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
+{
+	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
+	int bucket_id = UCLAMP_BUCKETS - 1;
+
+	/*
+	 * Since both min and max clamps are max aggregated, find the
+	 * top most bucket with tasks in.
+	 */
+	for ( ; bucket_id >= 0; bucket_id--) {
+		if (!bucket[bucket_id].tasks)
+			continue;
+		return bucket[bucket_id].value;
+	}
+
+	/* No tasks -- default clamp values */
+	return uclamp_none(clamp_id);
+}
+
+/*
+ * When a task is enqueued on a rq, the clamp bucket currently defined by the
+ * task's uclamp::bucket_id is refcounted on that rq. This also immediately
+ * updates the rq's clamp value if required.
+ */
+static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
+				    unsigned int clamp_id)
+{
+	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
+	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
+	struct uclamp_bucket *bucket;
+
+	lockdep_assert_held(&rq->lock);
+
+	bucket = &uc_rq->bucket[uc_se->bucket_id];
+	bucket->tasks++;
+
+	if (uc_se->value > READ_ONCE(uc_rq->value))
+		WRITE_ONCE(uc_rq->value, bucket->value);
+}
+
+/*
+ * When a task is dequeued from a rq, the clamp bucket refcounted by the task
+ * is released. If this is the last task reference counting the rq's max
+ * active clamp value, then the rq's clamp value is updated.
+ *
+ * Both refcounted tasks and rq's cached clamp values are expected to be
+ * always valid. If it's detected they are not, as defensive programming,
+ * enforce the expected state and warn.
+ */
+static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
+				    unsigned int clamp_id)
+{
+	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
+	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
+	struct uclamp_bucket *bucket;
+	unsigned int rq_clamp;
+
+	lockdep_assert_held(&rq->lock);
+
+	bucket = &uc_rq->bucket[uc_se->bucket_id];
+	SCHED_WARN_ON(!bucket->tasks);
+	if (likely(bucket->tasks))
+		bucket->tasks--;
+
+	if (likely(bucket->tasks))
+		return;
+
+	rq_clamp = READ_ONCE(uc_rq->value);
+	/*
+	 * Defensive programming: this should never happen. If it happens,
+	 * e.g. due to future modification, warn and fixup the expected value.
+	 */
+	SCHED_WARN_ON(bucket->value > rq_clamp);
+	if (bucket->value >= rq_clamp)
+		WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
+}
+
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for_each_clamp_id(clamp_id)
+		uclamp_rq_inc_id(rq, p, clamp_id);
+}
+
+static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for_each_clamp_id(clamp_id)
+		uclamp_rq_dec_id(rq, p, clamp_id);
+}
+
+static void __init init_uclamp(void)
+{
+	unsigned int clamp_id;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct uclamp_bucket *bucket;
+		struct uclamp_rq *uc_rq;
+		unsigned int bucket_id;
+
+		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+
+		for_each_clamp_id(clamp_id) {
+			uc_rq = &cpu_rq(cpu)->uclamp[clamp_id];
+
+			bucket_id = 1;
+			while (bucket_id < UCLAMP_BUCKETS) {
+				bucket = &uc_rq->bucket[bucket_id];
+				bucket->value = bucket_id * UCLAMP_BUCKET_DELTA;
+				++bucket_id;
+			}
+		}
+	}
+
+	for_each_clamp_id(clamp_id) {
+		uclamp_se_set(&init_task.uclamp[clamp_id],
+			      uclamp_none(clamp_id));
+	}
+}
+
+#else /* CONFIG_UCLAMP_TASK */
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
+static inline void init_uclamp(void) { }
+#endif /* CONFIG_UCLAMP_TASK */
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
@@ -770,6 +932,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, flags & ENQUEUE_WAKEUP);
 	}
 
+	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -783,6 +946,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
+	uclamp_rq_dec(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -6063,6 +6227,8 @@ void __init sched_init(void)
 
 	psi_init();
 
+	init_uclamp();
+
 	scheduler_running = 1;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..3ebea7a2bb7d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -797,6 +797,48 @@ extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_UCLAMP_TASK
+/*
+ * struct uclamp_bucket - Utilization clamp bucket
+ * @value: utilization clamp value for tasks on this clamp bucket
+ * @tasks: number of RUNNABLE tasks on this clamp bucket
+ *
+ * Keep track of how many tasks are RUNNABLE for a given utilization
+ * clamp value.
+ */
+struct uclamp_bucket {
+	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
+	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
+};
+
+/*
+ * struct uclamp_rq - rq's utilization clamp
+ * @value: currently active clamp values for a rq
+ * @bucket: utilization clamp buckets affecting a rq
+ *
+ * Keep track of RUNNABLE tasks on a rq to aggregate their clamp values.
+ * A clamp value is affecting a rq when there is at least one task RUNNABLE
+ * (or actually running) with that value.
+ *
+ * There are up to UCLAMP_CNT possible different clamp values, currently there
+ * are only two: minimum utilization and maximum utilization.
+ *
+ * All utilization clamping values are MAX aggregated, since:
+ * - for util_min: we want to run the CPU at least at the max of the minimum
+ *   utilization required by its currently RUNNABLE tasks.
+ * - for util_max: we want to allow the CPU to run up to the max of the
+ *   maximum utilization allowed by its currently RUNNABLE tasks.
+ *
+ * Since on each system we expect only a limited number of different
+ * utilization clamp values (UCLAMP_BUCKETS), use a simple array to track
+ * the metrics required to compute all the per-rq utilization clamp values.
+ */
+struct uclamp_rq {
+	unsigned int value;
+	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
+};
+#endif /* CONFIG_UCLAMP_TASK */
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -835,6 +877,11 @@ struct rq {
 	unsigned long		nr_load_updates;
 	u64			nr_switches;
 
+#ifdef CONFIG_UCLAMP_TASK
+	/* Utilization clamp values based on CPU's RUNNABLE tasks */
+	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
+#endif
+
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
@@ -1649,6 +1696,10 @@ extern const u32		sched_prio_to_wmult[40];
 struct sched_class {
 	const struct sched_class *next;
 
+#ifdef CONFIG_UCLAMP_TASK
+	int uclamp_enabled;
+#endif
+
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
-- 
2.21.0

