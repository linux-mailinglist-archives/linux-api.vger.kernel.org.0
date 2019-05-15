Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D51EB55
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEOJqE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:46:04 -0400
Received: from foss.arm.com ([217.140.101.70]:39372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfEOJqC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:46:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BB4A78;
        Wed, 15 May 2019 02:46:01 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D90433F703;
        Wed, 15 May 2019 02:45:58 -0700 (PDT)
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
Subject: [PATCH v9 09/16] sched/cpufreq: uclamp: Add clamps for FAIR and RT tasks
Date:   Wed, 15 May 2019 10:44:52 +0100
Message-Id: <20190515094459.10317-10-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Each time a frequency update is required via schedutil, a frequency is
selected to (possibly) satisfy the utilization reported by each
scheduling class and irqs. However, when utilization clamping is in use,
the frequency selection should consider userspace utilization clamping
hints.  This will allow, for example, to:

 - boost tasks which are directly affecting the user experience
   by running them at least at a minimum "requested" frequency

 - cap low priority tasks not directly affecting the user experience
   by running them only up to a maximum "allowed" frequency

These constraints are meant to support a per-task based tuning of the
frequency selection thus supporting a fine grained definition of
performance boosting vs energy saving strategies in kernel space.

Add support to clamp the utilization of RUNNABLE FAIR and RT tasks
within the boundaries defined by their aggregated utilization clamp
constraints.

Do that by considering the max(min_util, max_util) to give boosted tasks
the performance they need even when they happen to be co-scheduled with
other capped tasks.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
 kernel/sched/fair.c              |  4 ++++
 kernel/sched/rt.c                |  4 ++++
 kernel/sched/sched.h             | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5c41ea367422..7d786d99fdb4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -201,8 +201,10 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
 
-	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
+	if (!IS_BUILTIN(CONFIG_UCLAMP_TASK) &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
 		return max;
+	}
 
 	/*
 	 * Early check to see if IRQ/steal time saturates the CPU, can be
@@ -218,9 +220,16 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 * CFS tasks and we use the same metric to track the effective
 	 * utilization (PELT windows are synchronized) we can directly add them
 	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
 	 */
-	util = util_cfs;
-	util += cpu_util_rt(rq);
+	util = util_cfs + cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_util(rq, util);
 
 	dl_util = cpu_util_dl(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..5e5fe5462099 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10690,6 +10690,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	.task_change_group	= task_change_group_fair,
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1e6b909dca36..7fe730382092 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2400,6 +2400,10 @@ const struct sched_class rt_sched_class = {
 	.switched_to		= switched_to_rt,
 
 	.update_curr		= update_curr_rt,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a8a693c75669..1ea44f4dec16 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2275,6 +2275,29 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
+	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+
+	/*
+	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
+	 * RUNNABLE tasks with _different_ clamps, we can end up with an
+	 * inversion. Fix it now when the clamps are applied.
+	 */
+	if (unlikely(min_util >= max_util))
+		return min_util;
+
+	return clamp(util, min_util, max_util);
+}
+#else /* CONFIG_UCLAMP_TASK */
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	return util;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
 #  define arch_scale_freq_invariant()	true
-- 
2.21.0

