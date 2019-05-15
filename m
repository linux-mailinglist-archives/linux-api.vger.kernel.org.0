Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6441EB52
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOJqh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:46:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39442 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfEOJqQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:46:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68351A78;
        Wed, 15 May 2019 02:46:15 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50F9D3F703;
        Wed, 15 May 2019 02:46:12 -0700 (PDT)
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
Subject: [PATCH v9 13/16] sched/core: uclamp: Propagate parent clamps
Date:   Wed, 15 May 2019 10:44:56 +0100
Message-Id: <20190515094459.10317-14-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are (potentially) constrained based on parent's assigned
resources. This requires to properly propagate and aggregate parent
attributes down to its descendants.

Let's implement this mechanism by adding a new "effective" clamp value
for each task group. The effective clamp value is defined as the smaller
value between the clamp value of a group and the effective clamp value
of its parent. This is the actual clamp value enforced on tasks in a
task group.

Since it can be interesting for userspace, e.g. system management
software, to know exactly what the currently propagated/enforced
configuration is, the effective clamp values are exposed to user-space
by means of a new pair of read-only attributes
cpu.util.{min,max}.effective.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  19 +++++
 kernel/sched/core.c                     | 108 ++++++++++++++++++++++--
 kernel/sched/sched.h                    |   2 +
 3 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3a940bfe4e8c..4d13f88bfe25 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -990,6 +990,16 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This minimum utilization
         value is used to clamp the task specific minimum utilization clamp.
 
+  cpu.util.min.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports minimum utilization clamp value currently enforced on a task
+        group.
+
+        The actual minimum utilization in the range [0, 1024].
+
+        This value can be lower then cpu.util.min in case a parent cgroup
+        allows only smaller minimum utilization values.
+
   cpu.util.max
         A read-write single value file which exists on non-root cgroups.
         The default is "1024". i.e. no utilization capping
@@ -1000,6 +1010,15 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.util.max.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports maximum utilization clamp value currently enforced on a task
+        group.
+
+        The actual maximum utilization in the range [0, 1024].
+
+        This value can be lower then cpu.util.max in case a parent cgroup
+        is enforcing a more restrictive clamping on max utilization.
 
 
 Memory
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 19437257a08d..efedbd3a0ce6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -761,6 +761,18 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/*
+ * Serializes updates of utilization clamp values
+ *
+ * The (slow-path) user-space triggers utilization clamp value updates which
+ * can require updates on (fast-path) scheduler's data structures used to
+ * support enqueue/dequeue operations.
+ * While the per-CPU rq lock protects fast-path update operations, user-space
+ * requests are serialized using a mutex to reduce the risk of conflicting
+ * updates or API abuses.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
 /* Max allowed minimum utilization */
 unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
@@ -1125,6 +1137,8 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
+	mutex_init(&uclamp_mutex);
+
 	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 		cpu_rq(cpu)->uclamp_flags = 0;
@@ -1141,6 +1155,7 @@ static void __init init_uclamp(void)
 		uclamp_default[clamp_id] = uc_max;
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		root_task_group.uclamp_req[clamp_id] = uc_max;
+		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
 }
@@ -6705,8 +6720,10 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	int clamp_id;
 
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		tg->uclamp_req[clamp_id] = parent->uclamp_req[clamp_id];
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
+	}
 #endif
 }
 
@@ -6956,6 +6973,44 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css,
+				unsigned int clamp_id)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_se, *uc_parent;
+	unsigned int value;
+
+	css_for_each_descendant_pre(css, top_css) {
+		value = css_tg(css)->uclamp_req[clamp_id].value;
+
+		uc_parent = NULL;
+		if (css_tg(css)->parent)
+			uc_parent = &css_tg(css)->parent->uclamp[clamp_id];
+
+		/*
+		 * Skip the whole subtrees if the current effective clamp is
+		 * already matching the TG's clamp value.
+		 * In this case, all the subtrees already have top_value, or a
+		 * more restrictive value, as effective clamp.
+		 */
+		uc_se = &css_tg(css)->uclamp[clamp_id];
+		if (uc_se->value == value &&
+		    uc_parent && uc_parent->value >= value) {
+			css = css_rightmost_descendant(css);
+			continue;
+		}
+
+		/* Propagate the most restrictive effective value */
+		if (uc_parent && uc_parent->value < value)
+			value = uc_parent->value;
+		if (uc_se->value == value)
+			continue;
+
+		uc_se->value = value;
+		uc_se->bucket_id = uclamp_bucket_id(value);
+	}
+}
+
 static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 min_value)
 {
@@ -6965,6 +7020,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	if (min_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(css);
@@ -6981,8 +7037,12 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN], min_value, false);
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(css, UCLAMP_MIN);
+
 out:
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return ret;
 }
@@ -6996,6 +7056,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	if (max_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(css);
@@ -7012,21 +7073,28 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX], max_value, false);
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(css, UCLAMP_MAX);
+
 out:
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return ret;
 }
 
 static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
-				  enum uclamp_id clamp_id)
+				  enum uclamp_id clamp_id,
+				  bool effective)
 {
 	struct task_group *tg;
 	u64 util_clamp;
 
 	rcu_read_lock();
 	tg = css_tg(css);
-	util_clamp = tg->uclamp_req[clamp_id].value;
+	util_clamp = effective
+		? tg->uclamp[clamp_id].value
+		: tg->uclamp_req[clamp_id].value;
 	rcu_read_unlock();
 
 	return util_clamp;
@@ -7035,13 +7103,25 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
 static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
 				 struct cftype *cft)
 {
-	return cpu_uclamp_read(css, UCLAMP_MIN);
+	return cpu_uclamp_read(css, UCLAMP_MIN, false);
 }
 
 static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
 				 struct cftype *cft)
 {
-	return cpu_uclamp_read(css, UCLAMP_MAX);
+	return cpu_uclamp_read(css, UCLAMP_MAX, false);
+}
+
+static u64 cpu_util_min_effective_read_u64(struct cgroup_subsys_state *css,
+					   struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MIN, true);
+}
+
+static u64 cpu_util_max_effective_read_u64(struct cgroup_subsys_state *css,
+					   struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MAX, true);
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
@@ -7396,11 +7476,19 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_util_min_read_u64,
 		.write_u64 = cpu_util_min_write_u64,
 	},
+	{
+		.name = "util.min.effective",
+		.read_u64 = cpu_util_min_effective_read_u64,
+	},
 	{
 		.name = "util.max",
 		.read_u64 = cpu_util_max_read_u64,
 		.write_u64 = cpu_util_max_write_u64,
 	},
+	{
+		.name = "util.max.effective",
+		.read_u64 = cpu_util_max_effective_read_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7576,12 +7664,22 @@ static struct cftype cpu_files[] = {
 		.read_u64 = cpu_util_min_read_u64,
 		.write_u64 = cpu_util_min_write_u64,
 	},
+	{
+		.name = "util.min.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_min_effective_read_u64,
+	},
 	{
 		.name = "util.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_util_max_read_u64,
 		.write_u64 = cpu_util_max_write_u64,
 	},
+	{
+		.name = "util.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_max_effective_read_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fd31527fdcc8..f3c65af96756 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -403,6 +403,8 @@ struct task_group {
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Clamp values requested for a task group */
 	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a task group */
+	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
 };
-- 
2.21.0

