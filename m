Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975BF1EB4C
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEOJqQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:46:16 -0400
Received: from foss.arm.com ([217.140.101.70]:39424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEOJqM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 115CF80D;
        Wed, 15 May 2019 02:46:12 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBD133F703;
        Wed, 15 May 2019 02:46:08 -0700 (PDT)
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
Subject: [PATCH v9 12/16] sched/core: uclamp: Extend CPU's cgroup controller
Date:   Wed, 15 May 2019 10:44:55 +0100
Message-Id: <20190515094459.10317-13-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The cgroup CPU bandwidth controller allows to assign a specified
(maximum) bandwidth to the tasks of a group. However this bandwidth is
defined and enforced only on a temporal base, without considering the
actual frequency a CPU is running on. Thus, the amount of computation
completed by a task within an allocated bandwidth can be very different
depending on the actual frequency the CPU is running that task.
The amount of computation can be affected also by the specific CPU a
task is running on, especially when running on asymmetric capacity
systems like Arm's big.LITTLE.

With the availability of schedutil, the scheduler is now able
to drive frequency selections based on actual task utilization.
Moreover, the utilization clamping support provides a mechanism to
bias the frequency selection operated by schedutil depending on
constraints assigned to the tasks currently RUNNABLE on a CPU.

Giving the mechanisms described above, it is now possible to extend the
cpu controller to specify the minimum (or maximum) utilization which
should be considered for tasks RUNNABLE on a cpu.
This makes it possible to better defined the actual computational
power assigned to task groups, thus improving the cgroup CPU bandwidth
controller which is currently based just on time constraints.

Extend the CPU controller with a couple of new attributes util.{min,max}
which allows to enforce utilization boosting and capping for all the
tasks in a group. Specifically:

- util.min: defines the minimum utilization which should be considered
	    i.e. the RUNNABLE tasks of this group will run at least at a
		 minimum frequency which corresponds to the util.min
		 utilization

- util.max: defines the maximum utilization which should be considered
	    i.e. the RUNNABLE tasks of this group will run up to a
		 maximum frequency which corresponds to the util.max
		 utilization

These attributes:

a) are available only for non-root nodes, both on default and legacy
   hierarchies, while system wide clamps are defined by a generic
   interface which does not depends on cgroups. This system wide
   interface enforces constraints on tasks in the root node.

b) enforce effective constraints at each level of the hierarchy which
   are a restriction of the group requests considering its parent's
   effective constraints. Root group effective constraints are defined
   by the system wide interface.
   This mechanism allows each (non-root) level of the hierarchy to:
   - request whatever clamp values it would like to get
   - effectively get only up to the maximum amount allowed by its parent

c) have higher priority than task-specific clamps, defined via
   sched_setattr(), thus allowing to control and restrict task requests

Add two new attributes to the cpu controller to collect "requested"
clamp values. Allow that at each non-root level of the hierarchy.
Validate local consistency by enforcing util.min < util.max.
Keep it simple by do not caring now about "effective" values computation
and propagation along the hierarchy.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v9
 Message-ID: <20190507114232.npsvba4itex5qpvl@e110439-lin>
 - make alloc_uclamp_sched_group() a void function
 Message-ID: <20190508190011.GB32547@worktop.programming.kicks-ass.net>:
- use for_each_clamp_id() and uclamp_se_set() to make code less fragile
---
 Documentation/admin-guide/cgroup-v2.rst |  27 +++++
 init/Kconfig                            |  22 ++++
 kernel/sched/core.c                     | 135 +++++++++++++++++++++++-
 kernel/sched/sched.h                    |   6 ++
 4 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 20f92c16ffbf..3a940bfe4e8c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -909,6 +909,12 @@ controller implements weight and absolute bandwidth limit models for
 normal scheduling policy and absolute bandwidth allocation model for
 realtime scheduling policy.
 
+Cycles distribution is based, by default, on a temporal base and it
+does not account for the frequency at which tasks are executed.
+The (optional) utilization clamping support allows to enforce a minimum
+bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
+which should never be exceeded by a CPU.
+
 WARNING: cgroup2 doesn't yet support control of realtime processes and
 the cpu controller can only be enabled when all RT processes are in
 the root cgroup.  Be aware that system management software may already
@@ -974,6 +980,27 @@ All time durations are in microseconds.
 	Shows pressure stall information for CPU. See
 	Documentation/accounting/psi.txt for details.
 
+  cpu.util.min
+        A read-write single value file which exists on non-root cgroups.
+        The default is "0", i.e. no utilization boosting.
+
+        The requested minimum utilization in the range [0, 1024].
+
+        This interface allows reading and setting minimum utilization clamp
+        values similar to the sched_setattr(2). This minimum utilization
+        value is used to clamp the task specific minimum utilization clamp.
+
+  cpu.util.max
+        A read-write single value file which exists on non-root cgroups.
+        The default is "1024". i.e. no utilization capping
+
+        The requested maximum utilization in the range [0, 1024].
+
+        This interface allows reading and setting maximum utilization clamp
+        values similar to the sched_setattr(2). This maximum utilization
+        value is used to clamp the task specific maximum utilization clamp.
+
+
 
 Memory
 ------
diff --git a/init/Kconfig b/init/Kconfig
index 8e103505456a..5617742b97e5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -894,6 +894,28 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config UCLAMP_TASK_GROUP
+	bool "Utilization clamping per group of tasks"
+	depends on CGROUP_SCHED
+	depends on UCLAMP_TASK
+	default n
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max
+	  CPU bandwidth which is allowed for each single task in a group.
+	  The max bandwidth allows to clamp the maximum frequency a task
+	  can use, while the min bandwidth allows to define a minimum
+	  frequency a task will always use.
+
+	  When task group based utilization clamping is enabled, an eventually
+	  specified task-specific clamp value is constrained by the cgroup
+	  specified clamp value. Both minimum and maximum task clamping cannot
+	  be bigger than the corresponding clamping defined at task group level.
+
+	  If in doubt, say N.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eed7664437ac..19437257a08d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1137,8 +1137,12 @@ static void __init init_uclamp(void)
 
 	/* System defaults allow max clamp values for both indexes */
 	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX), false);
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		uclamp_default[clamp_id] = uc_max;
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+		root_task_group.uclamp_req[clamp_id] = uc_max;
+#endif
+	}
 }
 
 #else /* CONFIG_UCLAMP_TASK */
@@ -6695,6 +6699,17 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
 /* task_group_lock serializes the addition/removal of task groups */
 static DEFINE_SPINLOCK(task_group_lock);
 
+static inline void alloc_uclamp_sched_group(struct task_group *tg,
+					    struct task_group *parent)
+{
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	int clamp_id;
+
+	for_each_clamp_id(clamp_id)
+		tg->uclamp_req[clamp_id] = parent->uclamp_req[clamp_id];
+#endif
+}
+
 static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
@@ -6718,6 +6733,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	alloc_uclamp_sched_group(tg, parent);
+
 	return tg;
 
 err:
@@ -6938,6 +6955,96 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 min_value)
+{
+	struct task_group *tg;
+	int ret = 0;
+
+	if (min_value > SCHED_CAPACITY_SCALE)
+		return -ERANGE;
+
+	rcu_read_lock();
+
+	tg = css_tg(css);
+	if (tg == &root_task_group) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (tg->uclamp_req[UCLAMP_MIN].value == min_value)
+		goto out;
+	if (tg->uclamp_req[UCLAMP_MAX].value < min_value) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN], min_value, false);
+
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 max_value)
+{
+	struct task_group *tg;
+	int ret = 0;
+
+	if (max_value > SCHED_CAPACITY_SCALE)
+		return -ERANGE;
+
+	rcu_read_lock();
+
+	tg = css_tg(css);
+	if (tg == &root_task_group) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (tg->uclamp_req[UCLAMP_MAX].value == max_value)
+		goto out;
+	if (tg->uclamp_req[UCLAMP_MIN].value > max_value) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX], max_value, false);
+
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
+				  enum uclamp_id clamp_id)
+{
+	struct task_group *tg;
+	u64 util_clamp;
+
+	rcu_read_lock();
+	tg = css_tg(css);
+	util_clamp = tg->uclamp_req[clamp_id].value;
+	rcu_read_unlock();
+
+	return util_clamp;
+}
+
+static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MIN);
+}
+
+static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MAX);
+}
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
@@ -7282,6 +7389,18 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "util.min",
+		.read_u64 = cpu_util_min_read_u64,
+		.write_u64 = cpu_util_min_write_u64,
+	},
+	{
+		.name = "util.max",
+		.read_u64 = cpu_util_max_read_u64,
+		.write_u64 = cpu_util_max_write_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7449,6 +7568,20 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "util.min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_min_read_u64,
+		.write_u64 = cpu_util_min_write_u64,
+	},
+	{
+		.name = "util.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_max_read_u64,
+		.write_u64 = cpu_util_max_write_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6335cfcc81ba..fd31527fdcc8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -399,6 +399,12 @@ struct task_group {
 #endif
 
 	struct cfs_bandwidth	cfs_bandwidth;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Clamp values requested for a task group */
+	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+#endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.21.0

