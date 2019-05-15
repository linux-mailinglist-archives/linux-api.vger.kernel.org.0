Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A61EB41
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEOJqK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:46:10 -0400
Received: from foss.arm.com ([217.140.101.70]:39410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEOJqJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:46:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBC7A78;
        Wed, 15 May 2019 02:46:08 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 946783F703;
        Wed, 15 May 2019 02:46:05 -0700 (PDT)
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
Subject: [PATCH v9 11/16] sched/fair: uclamp: Add uclamp support to energy_compute()
Date:   Wed, 15 May 2019 10:44:54 +0100
Message-Id: <20190515094459.10317-12-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The Energy Aware Scheduler (EAS) estimates the energy impact of waking
up a task on a given CPU. This estimation is based on:
 a) an (active) power consumption defined for each CPU frequency
 b) an estimation of which frequency will be used on each CPU
 c) an estimation of the busy time (utilization) of each CPU

Utilization clamping can affect both b) and c).
A CPU is expected to run:
 - on an higher than required frequency, but for a shorter time, in case
   its estimated utilization will be smaller than the minimum utilization
   enforced by uclamp
 - on a smaller than required frequency, but for a longer time, in case
   its estimated utilization is bigger than the maximum utilization
   enforced by uclamp

While compute_energy() already accounts clamping effects on busy time,
the clamping effects on frequency selection are currently ignored.

Fix it by considering how CPU clamp values will be affected by a
task waking up and being RUNNABLE on that CPU.

Do that by refactoring schedutil_freq_util() to take an additional
task_struct* which allows EAS to evaluate the impact on clamp values of
a task being eventually queued in a CPU. Clamp values are applied to the
RT+CFS utilization only when a FREQUENCY_UTIL is required by
compute_energy().

Do note that switching from ENERGY_UTIL to FREQUENCY_UTIL in the
computation of the cpu_util signal implies that we are more likely to
estimate the highest OPP when a RT task is running in another CPU of
the same performance domain. This can have an impact on energy
estimation but:
 - it's not easy to say which approach is better, since it depends on
   the use case
 - the original approach could still be obtained by setting a smaller
   task-specific util_min whenever required

Since we are at that:
 - rename schedutil_freq_util() into schedutil_cpu_util(),
   since it's not only used for frequency selection.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c |  9 +++----
 kernel/sched/fair.c              | 40 +++++++++++++++++++++++++++-----
 kernel/sched/sched.h             | 20 +++++-----------
 3 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7d786d99fdb4..d0f4d2111bfe 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -195,8 +195,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * based on the task model parameters and gives the minimal utilization
  * required to meet deadlines.
  */
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-				  unsigned long max, enum schedutil_type type)
+unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum schedutil_type type,
+				 struct task_struct *p)
 {
 	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
@@ -229,7 +230,7 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 	 */
 	util = util_cfs + cpu_util_rt(rq);
 	if (type == FREQUENCY_UTIL)
-		util = uclamp_util(rq, util);
+		util = uclamp_util_with(rq, util, p);
 
 	dl_util = cpu_util_dl(rq);
 
@@ -289,7 +290,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_freq_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL);
+	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
 }
 
 /**
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e5fe5462099..b7eea9dc4644 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6498,11 +6498,21 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
-	long util, max_util, sum_util, energy = 0;
+	unsigned int max_util, util_cfs, cpu_util, cpu_cap;
+	unsigned long sum_util, energy = 0;
+	struct task_struct *tsk;
 	int cpu;
 
 	for (; pd; pd = pd->next) {
+		struct cpumask *pd_mask = perf_domain_span(pd);
+
+		/*
+		 * The energy model mandates all the CPUs of a performance
+		 * domain have the same capacity.
+		 */
+		cpu_cap = arch_scale_cpu_capacity(NULL, cpumask_first(pd_mask));
 		max_util = sum_util = 0;
+
 		/*
 		 * The capacity state of CPUs of the current rd can be driven by
 		 * CPUs of another rd if they belong to the same performance
@@ -6513,11 +6523,29 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * it will not appear in its pd list and will not be accounted
 		 * by compute_energy().
 		 */
-		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {
-			util = cpu_util_next(cpu, p, dst_cpu);
-			util = schedutil_energy_util(cpu, util);
-			max_util = max(util, max_util);
-			sum_util += util;
+		for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+			util_cfs = cpu_util_next(cpu, p, dst_cpu);
+
+			/*
+			 * Busy time computation: utilization clamping is not
+			 * required since the ratio (sum_util / cpu_capacity)
+			 * is already enough to scale the EM reported power
+			 * consumption at the (eventually clamped) cpu_capacity.
+			 */
+			sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+						       ENERGY_UTIL, NULL);
+
+			/*
+			 * Performance domain frequency: utilization clamping
+			 * must be considered since it affects the selection
+			 * of the performance domain frequency.
+			 * NOTE: in case RT tasks are running, by default the
+			 * FREQUENCY_UTIL's utilization can be max OPP.
+			 */
+			tsk = cpu == dst_cpu ? p : NULL;
+			cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+						      FREQUENCY_UTIL, tsk);
+			max_util = max(max_util, cpu_util);
 		}
 
 		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c95340a1d598..6335cfcc81ba 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2332,7 +2332,6 @@ static inline unsigned long capacity_orig_of(int cpu)
 }
 #endif
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 /**
  * enum schedutil_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
@@ -2348,15 +2347,11 @@ enum schedutil_type {
 	ENERGY_UTIL,
 };
 
-unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
-				  unsigned long max, enum schedutil_type type);
-
-static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
-{
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 
-	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
-}
+unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum schedutil_type type,
+				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
@@ -2385,11 +2380,8 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
 #else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
-{
-	return cfs;
-}
-#endif
+#define schedutil_cpu_util(cpu, util_cfs, max, type, p) 0
+#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
-- 
2.21.0

