Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C489B1EB5C
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEOJpq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEOJpp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC32580D;
        Wed, 15 May 2019 02:45:44 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4D9E3F703;
        Wed, 15 May 2019 02:45:41 -0700 (PDT)
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
Subject: [PATCH v9 04/16] sched/core: uclamp: Add system default clamps
Date:   Wed, 15 May 2019 10:44:47 +0100
Message-Id: <20190515094459.10317-5-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Tasks without a user-defined clamp value are considered not clamped
and by default their utilization can have any value in the
[0..SCHED_CAPACITY_SCALE] range.

Tasks with a user-defined clamp value are allowed to request any value
in that range, and the required clamp is unconditionally enforced.
However, a "System Management Software" could be interested in limiting
the range of clamp values allowed for all tasks.

Add a privileged interface to define a system default configuration via:

  /proc/sys/kernel/sched_uclamp_util_{min,max}

which works as an unconditional clamp range restriction for all tasks.

With the default configuration, the full SCHED_CAPACITY_SCALE range of
values is allowed for each clamp index. Otherwise, the task-specific
clamp is capped by the corresponding system default value.

Do that by tracking, for each task, the "effective" clamp value and
bucket the task has been refcounted in at enqueue time. This
allows to lazy aggregate "requested" and "system default" values at
enqueue time and simplifies refcounting updates at dequeue time.

The cached bucket ids are used to avoid (relatively) more expensive
integer divisions every time a task is enqueued.

An active flag is used to report when the "effective" value is valid and
thus the task is actually refcounted in the corresponding rq's bucket.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v9:
 Message-ID: <20190508190011.GB32547@worktop.programming.kicks-ass.net>:
 - use for_each_clamp_id() and uclamp_se_set() to make code less fragile
 - s/sched_uclamp_util_{min,max}/sched_util_clamp_{min,max}/
 Message-ID: <20190507103845.tejg55wfsu3l3jwh@e110439-lin>
 - removed uclamp_eff_bucket_id() because not used
 - removed uclamp_eff_value() and moved to a following patch
---
 include/linux/sched.h        | 10 ++++
 include/linux/sched/sysctl.h | 11 ++++
 kernel/sched/core.c          | 99 +++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c              | 16 ++++++
 4 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cdc22406877..0860c8f55c1d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -585,14 +585,21 @@ struct sched_dl_entity {
  * Utilization clamp for a scheduling entity
  * @value:		clamp value "assigned" to a se
  * @bucket_id:		bucket index corresponding to the "assigned" value
+ * @active:		the se is currently refcounted in a rq's bucket
  *
  * The bucket_id is the index of the clamp bucket matching the clamp value
  * which is pre-computed and stored to avoid expensive integer divisions from
  * the fast path.
+ *
+ * The active bit is set whenever a task has got an "effective" value assigned,
+ * which can be different from the clamp value "requested" from user-space.
+ * This allows to know a task is refcounted in the rq's bucket corresponding
+ * to the "effective" bucket_id.
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
+	unsigned int active		: 1;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -677,6 +684,9 @@ struct task_struct {
 	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
+	/* Clamp values requested for a scheduling entity */
+	struct uclamp_se		uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a scheduling entity */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 99ce6d728df7..d4f6215ee03f 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+#ifdef CONFIG_UCLAMP_TASK
+extern unsigned int sysctl_sched_uclamp_util_min;
+extern unsigned int sysctl_sched_uclamp_util_max;
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
@@ -75,6 +80,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
 
+#ifdef CONFIG_UCLAMP_TASK
+extern int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+				       void __user *buffer, size_t *lenp,
+				       loff_t *ppos);
+#endif
+
 extern int sysctl_numa_balancing(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b4014d98ee01..dac73a5959b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -761,6 +761,14 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/* Max allowed minimum utilization */
+unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
+
+/* Max allowed maximum utilization */
+unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+
+/* All clamps are required to be less or equal than these values */
+static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
@@ -839,6 +847,25 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+/*
+ * The effective clamp bucket index of a task depends on, by increasing
+ * priority:
+ * - the task specific clamp value, when explicitly requested from userspace
+ * - the system default clamp value, defined by the sysadmin
+ */
+static inline struct uclamp_se
+uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
+{
+	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+	struct uclamp_se uc_max = uclamp_default[clamp_id];
+
+	/* System default restrictions always apply */
+	if (unlikely(uc_req.value > uc_max.value))
+		return uc_max;
+
+	return uc_req;
+}
+
 /*
  * When a task is enqueued on a rq, the clamp bucket currently defined by the
  * task's uclamp::bucket_id is refcounted on that rq. This also immediately
@@ -858,8 +885,12 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 
 	lockdep_assert_held(&rq->lock);
 
+	/* Update task effective clamp */
+	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
+
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
+	uc_se->active = true;
 
 	uclamp_idle_reset(rq, clamp_id, uc_se->value);
 
@@ -898,6 +929,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	SCHED_WARN_ON(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
+	uc_se->active = false;
 
 	/*
 	 * Keep "local max aggregation" simple and accept to (possibly)
@@ -946,8 +978,65 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos)
+{
+	int old_min, old_max;
+	static DEFINE_MUTEX(mutex);
+	int result;
+
+	mutex_lock(&mutex);
+	old_min = sysctl_sched_uclamp_util_min;
+	old_max = sysctl_sched_uclamp_util_max;
+
+	result = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (result)
+		goto undo;
+	if (!write)
+		goto done;
+
+	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
+	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
+	if (old_min != sysctl_sched_uclamp_util_min) {
+		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
+			      sysctl_sched_uclamp_util_min);
+	}
+	if (old_max != sysctl_sched_uclamp_util_max) {
+		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
+			      sysctl_sched_uclamp_util_max);
+	}
+
+	/*
+	 * Updating all the RUNNABLE task is expensive, keep it simple and do
+	 * just a lazy update at each next enqueue time.
+	 */
+	goto done;
+
+undo:
+	sysctl_sched_uclamp_util_min = old_min;
+	sysctl_sched_uclamp_util_max = old_max;
+done:
+	mutex_unlock(&mutex);
+
+	return result;
+}
+
+static void uclamp_fork(struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	for_each_clamp_id(clamp_id)
+		p->uclamp[clamp_id].active = false;
+}
+
 static void __init init_uclamp(void)
 {
+	struct uclamp_se uc_max = {};
 	unsigned int clamp_id;
 	int cpu;
 
@@ -957,14 +1046,20 @@ static void __init init_uclamp(void)
 	}
 
 	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&init_task.uclamp[clamp_id],
+		uclamp_se_set(&init_task.uclamp_req[clamp_id],
 			      uclamp_none(clamp_id));
 	}
+
+	/* System defaults allow max clamp values for both indexes */
+	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX));
+	for_each_clamp_id(clamp_id)
+		uclamp_default[clamp_id] = uc_max;
 }
 
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -2510,6 +2605,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	uclamp_fork(p);
+
 	/*
 	 * Revert to default priority/policy on fork if requested.
 	 */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9ec050bcf46..2bab3f0c765b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -455,6 +455,22 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rr_handler,
 	},
+#ifdef CONFIG_UCLAMP_TASK
+	{
+		.procname	= "sched_util_clamp_min",
+		.data		= &sysctl_sched_uclamp_util_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
+	{
+		.procname	= "sched_util_clamp_max",
+		.data		= &sysctl_sched_uclamp_util_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
+#endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
 		.procname	= "sched_autogroup_enabled",
-- 
2.21.0

