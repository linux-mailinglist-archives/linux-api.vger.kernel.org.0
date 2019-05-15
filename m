Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC45B1EB5A
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfEOJpx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39316 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEOJpw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6C0180D;
        Wed, 15 May 2019 02:45:51 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9245B3F703;
        Wed, 15 May 2019 02:45:48 -0700 (PDT)
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
Subject: [PATCH v9 06/16] sched/core: uclamp: Extend sched_setattr() to support utilization clamping
Date:   Wed, 15 May 2019 10:44:49 +0100
Message-Id: <20190515094459.10317-7-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The SCHED_DEADLINE scheduling class provides an advanced and formal
model to define tasks requirements that can translate into proper
decisions for both task placements and frequencies selections. Other
classes have a more simplified model based on the POSIX concept of
priorities.

Such a simple priority based model however does not allow to exploit
most advanced features of the Linux scheduler like, for example, driving
frequencies selection via the schedutil cpufreq governor. However, also
for non SCHED_DEADLINE tasks, it's still interesting to define tasks
properties to support scheduler decisions.

Utilization clamping exposes to user-space a new set of per-task
attributes the scheduler can use as hints about the expected/required
utilization for a task. This allows to implement a "proactive" per-task
frequency control policy, a more advanced policy than the current one
based just on "passive" measured task utilization. For example, it's
possible to boost interactive tasks (e.g. to get better performance) or
cap background tasks (e.g. to be more energy/thermal efficient).

Introduce a new API to set utilization clamping values for a specified
task by extending sched_setattr(), a syscall which already allows to
define task specific properties for different scheduling classes. A new
pair of attributes allows to specify a minimum and maximum utilization
the scheduler can consider for a task.

Do that by validating the required clamp values before and then applying
the required changes using _the_ same pattern already in use for
__setscheduler(). This ensures that the task is re-enqueued with the new
clamp values.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v9:
 Message-ID: <20190507111347.4ivnjwbymsf7i3e6@e110439-lin>
 - return EOPNOTSUPP from uclamp_validate() on !CONFIG_UCLAMP_TASK
 - update commit message
---
 include/linux/sched.h            |  9 ++++
 include/uapi/linux/sched.h       | 12 ++++-
 include/uapi/linux/sched/types.h | 66 +++++++++++++++++++----
 kernel/sched/core.c              | 91 +++++++++++++++++++++++++++++---
 4 files changed, 161 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0860c8f55c1d..863f70843875 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -586,6 +586,7 @@ struct sched_dl_entity {
  * @value:		clamp value "assigned" to a se
  * @bucket_id:		bucket index corresponding to the "assigned" value
  * @active:		the se is currently refcounted in a rq's bucket
+ * @user_defined:	the requested clamp value comes from user-space
  *
  * The bucket_id is the index of the clamp bucket matching the clamp value
  * which is pre-computed and stored to avoid expensive integer divisions from
@@ -595,11 +596,19 @@ struct sched_dl_entity {
  * which can be different from the clamp value "requested" from user-space.
  * This allows to know a task is refcounted in the rq's bucket corresponding
  * to the "effective" bucket_id.
+ *
+ * The user_defined bit is set whenever a task has got a task-specific clamp
+ * value requested from userspace, i.e. the system defaults apply to this task
+ * just as a restriction. This allows to relax default clamps when a less
+ * restrictive task-specific value has been requested, thus allowing to
+ * implement a "nice" semantic. For example, a task running with a 20%
+ * default boost can still drop its own boosting to 0%.
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
 	unsigned int active		: 1;
+	unsigned int user_defined	: 1;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 261b6e43846c..62895bf8e65e 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -51,10 +51,20 @@
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
 #define SCHED_FLAG_KEEP_POLICY		0x08
+#define SCHED_FLAG_KEEP_PARAMS		0x10
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+
+#define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
+				 SCHED_FLAG_KEEP_PARAMS)
+
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
-			 SCHED_FLAG_KEEP_POLICY)
+			 SCHED_FLAG_KEEP_ALL		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 10fbb8031930..c852153ddb0d 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -9,6 +9,7 @@ struct sched_param {
 };
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
+#define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
 
 /*
  * Extended scheduling parameters data structure.
@@ -21,8 +22,33 @@ struct sched_param {
  * the tasks may be useful for a wide variety of application fields, e.g.,
  * multimedia, streaming, automation and control, and many others.
  *
- * This variant (sched_attr) is meant at describing a so-called
- * sporadic time-constrained task. In such model a task is specified by:
+ * This variant (sched_attr) allows to define additional attributes to
+ * improve the scheduler knowledge about task requirements.
+ *
+ * Scheduling Class Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes specifies the
+ * scheduling policy and relative POSIX attributes:
+ *
+ *  @size		size of the structure, for fwd/bwd compat.
+ *
+ *  @sched_policy	task's scheduling policy
+ *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
+ *  @sched_priority	task's static priority (SCHED_FIFO/RR)
+ *
+ * Certain more advanced scheduling features can be controlled by a
+ * predefined set of flags via the attribute:
+ *
+ *  @sched_flags	for customizing the scheduler behaviour
+ *
+ * Sporadic Time-Constrained Task Attributes
+ * =========================================
+ *
+ * A subset of sched_attr attributes allows to describe a so-called
+ * sporadic time-constrained task.
+ *
+ * In such a model a task is specified by:
  *  - the activation period or minimum instance inter-arrival time;
  *  - the maximum (or average, depending on the actual scheduling
  *    discipline) computation time of all instances, a.k.a. runtime;
@@ -34,14 +60,8 @@ struct sched_param {
  * than the runtime and must be completed by time instant t equal to
  * the instance activation time + the deadline.
  *
- * This is reflected by the actual fields of the sched_attr structure:
+ * This is reflected by the following fields of the sched_attr structure:
  *
- *  @size		size of the structure, for fwd/bwd compat.
- *
- *  @sched_policy	task's scheduling policy
- *  @sched_flags	for customizing the scheduler behaviour
- *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
- *  @sched_priority	task's static priority (SCHED_FIFO/RR)
  *  @sched_deadline	representative of the task's deadline
  *  @sched_runtime	representative of the task's runtime
  *  @sched_period	representative of the task's period
@@ -53,6 +73,29 @@ struct sched_param {
  * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
  * only user of this new interface. More information about the algorithm
  * available in the scheduling class file or in Documentation/.
+ *
+ * Task Utilization Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the utilization
+ * expected for a task. These attributes allow to inform the scheduler about
+ * the utilization boundaries within which it should schedule the task. These
+ * boundaries are valuable hints to support scheduler decisions on both task
+ * placement and frequency selection.
+ *
+ *  @sched_util_min	represents the minimum utilization
+ *  @sched_util_max	represents the maximum utilization
+ *
+ * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE]. It
+ * represents the percentage of CPU time used by a task when running at the
+ * maximum frequency on the highest capacity CPU of the system. For example, a
+ * 20% utilization task is a task running for 2ms every 10ms at maximum
+ * frequency.
+ *
+ * A task with a min utilization value bigger than 0 is more likely scheduled
+ * on a CPU with a capacity big enough to fit the specified value.
+ * A task with a max utilization value smaller than 1024 is more likely
+ * scheduled on a CPU with no more capacity than the specified value.
  */
 struct sched_attr {
 	__u32 size;
@@ -70,6 +113,11 @@ struct sched_attr {
 	__u64 sched_runtime;
 	__u64 sched_deadline;
 	__u64 sched_period;
+
+	/* Utilization hints */
+	__u32 sched_util_min;
+	__u32 sched_util_max;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43b29b2efa4c..3e035fbb187d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -793,10 +793,12 @@ static inline unsigned int uclamp_none(int clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
+static inline void uclamp_se_set(struct uclamp_se *uc_se,
+				 unsigned int value, bool user_defined)
 {
 	uc_se->value = value;
 	uc_se->bucket_id = uclamp_bucket_id(value);
+	uc_se->user_defined = user_defined;
 }
 
 static inline unsigned int
@@ -1004,11 +1006,11 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
-			      sysctl_sched_uclamp_util_min);
+			      sysctl_sched_uclamp_util_min, false);
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
-			      sysctl_sched_uclamp_util_max);
+			      sysctl_sched_uclamp_util_max, false);
 	}
 
 	/*
@@ -1026,6 +1028,42 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	return result;
 }
 
+static int uclamp_validate(struct task_struct *p,
+			   const struct sched_attr *attr)
+{
+	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
+	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
+		lower_bound = attr->sched_util_min;
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
+		upper_bound = attr->sched_util_max;
+
+	if (lower_bound > upper_bound)
+		return -EINVAL;
+	if (upper_bound > SCHED_CAPACITY_SCALE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+		return;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
+			      attr->sched_util_min, true);
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
+			      attr->sched_util_max, true);
+	}
+}
+
 static void uclamp_fork(struct task_struct *p)
 {
 	unsigned int clamp_id;
@@ -1047,11 +1085,11 @@ static void __init init_uclamp(void)
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
-			      uclamp_none(clamp_id));
+			      uclamp_none(clamp_id), false);
 	}
 
 	/* System defaults allow max clamp values for both indexes */
-	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX));
+	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX), false);
 	for_each_clamp_id(clamp_id)
 		uclamp_default[clamp_id] = uc_max;
 }
@@ -1059,6 +1097,13 @@ static void __init init_uclamp(void)
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
+static inline int uclamp_validate(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+static void __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
@@ -4378,6 +4423,13 @@ static void __setscheduler_params(struct task_struct *p,
 static void __setscheduler(struct rq *rq, struct task_struct *p,
 			   const struct sched_attr *attr, bool keep_boost)
 {
+	/*
+	 * If params can't change scheduling class changes aren't allowed
+	 * either.
+	 */
+	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
+		return;
+
 	__setscheduler_params(p, attr);
 
 	/*
@@ -4515,6 +4567,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	/* Update task specific "requested" clamps */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
+		retval = uclamp_validate(p, attr);
+		if (retval)
+			return retval;
+	}
+
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
@@ -4544,6 +4603,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (dl_policy(policy) && dl_param_changed(p, attr))
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		task_rq_unlock(rq, p, &rf);
@@ -4624,7 +4685,9 @@ static int __sched_setscheduler(struct task_struct *p,
 		put_prev_task(rq, p);
 
 	prev_class = p->sched_class;
+
 	__setscheduler(rq, p, attr, pi);
+	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
 		/*
@@ -4800,6 +4863,10 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return -EFAULT;
 
+	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
+	    size < SCHED_ATTR_SIZE_VER1)
+		return -EINVAL;
+
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -4869,10 +4936,15 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_lock();
 	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (p != NULL)
-		retval = sched_setattr(p, &attr);
+	if (likely(p))
+		get_task_struct(p);
 	rcu_read_unlock();
 
+	if (likely(p)) {
+		retval = sched_setattr(p, &attr);
+		put_task_struct(p);
+	}
+
 	return retval;
 }
 
@@ -5023,6 +5095,11 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		attr.sched_nice = task_nice(p);
 
+#ifdef CONFIG_UCLAMP_TASK
+	attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+#endif
+
 	rcu_read_unlock();
 
 	retval = sched_read_attr(uattr, &attr, size);
-- 
2.21.0

