Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72F71EB61
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfEOJpi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:38 -0400
Received: from foss.arm.com ([217.140.101.70]:39246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEOJpi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26915A78;
        Wed, 15 May 2019 02:45:38 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4F9C3F703;
        Wed, 15 May 2019 02:45:34 -0700 (PDT)
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
Subject: [PATCH v9 02/16] sched/core: uclamp: Add bucket local max tracking
Date:   Wed, 15 May 2019 10:44:45 +0100
Message-Id: <20190515094459.10317-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Because of bucketization, different task-specific clamp values are
tracked in the same bucket.  For example, with 20% bucket size and
assuming to have:
  Task1: util_min=25%
  Task2: util_min=35%
both tasks will be refcounted in the [20..39]% bucket and always boosted
only up to 20% thus implementing a simple floor aggregation normally
used in histograms.

In systems with only few and well-defined clamp values, it would be
useful to track the exact clamp value required by a task whenever
possible. For example, if a system requires only 23% and 47% boost
values then it's possible to track the exact boost required by each
task using only 3 buckets of ~33% size each.

Introduce a mechanism to max aggregate the requested clamp values of
RUNNABLE tasks in the same bucket. Keep it simple by resetting the
bucket value to its base value only when a bucket becomes inactive.
Allow a limited and controlled overboosting margin for tasks recounted
in the same bucket.

In systems where the boost values are not known in advance, it is still
possible to control the maximum acceptable overboosting margin by tuning
the number of clamp groups. For example, 20 groups ensure a 5% maximum
overboost.

Remove the rq bucket initialization code since a correct bucket value
is now computed when a task is refcounted into a CPU's rq.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v9
 Message-ID: <20190415144930.pntid6evu6r67l4o@e110439-lin>
 - fix "max local update" by moving into uclamp_rq_inc_id()
---
 kernel/sched/core.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29c0d465fd9e..79b57cbbe032 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,6 +773,11 @@ static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 	return clamp_value / UCLAMP_BUCKET_DELTA;
 }
 
+static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
+{
+	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
+}
+
 static inline unsigned int uclamp_none(int clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
@@ -810,6 +815,11 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
  * When a task is enqueued on a rq, the clamp bucket currently defined by the
  * task's uclamp::bucket_id is refcounted on that rq. This also immediately
  * updates the rq's clamp value if required.
+ *
+ * Tasks can have a task-specific value requested from user-space, track
+ * within each bucket the maximum value for tasks refcounted in it.
+ * This "local max aggregation" allows to track the exact "requested" value
+ * for each bucket when all its RUNNABLE tasks require the same clamp.
  */
 static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 				    unsigned int clamp_id)
@@ -823,8 +833,15 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
 
+	/*
+	 * Local max aggregation: rq buckets always track the max
+	 * "requested" clamp value of its RUNNABLE tasks.
+	 */
+	if (bucket->tasks == 1 || uc_se->value > bucket->value)
+		bucket->value = uc_se->value;
+
 	if (uc_se->value > READ_ONCE(uc_rq->value))
-		WRITE_ONCE(uc_rq->value, bucket->value);
+		WRITE_ONCE(uc_rq->value, uc_se->value);
 }
 
 /*
@@ -851,6 +868,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	if (likely(bucket->tasks))
 		bucket->tasks--;
 
+	/*
+	 * Keep "local max aggregation" simple and accept to (possibly)
+	 * overboost some RUNNABLE tasks in the same bucket.
+	 * The rq clamp bucket value is reset to its base value whenever
+	 * there are no more RUNNABLE tasks refcounting it.
+	 */
 	if (likely(bucket->tasks))
 		return;
 
@@ -891,25 +914,9 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		struct uclamp_bucket *bucket;
-		struct uclamp_rq *uc_rq;
-		unsigned int bucket_id;
-
+	for_each_possible_cpu(cpu)
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 
-		for_each_clamp_id(clamp_id) {
-			uc_rq = &cpu_rq(cpu)->uclamp[clamp_id];
-
-			bucket_id = 1;
-			while (bucket_id < UCLAMP_BUCKETS) {
-				bucket = &uc_rq->bucket[bucket_id];
-				bucket->value = bucket_id * UCLAMP_BUCKET_DELTA;
-				++bucket_id;
-			}
-		}
-	}
-
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp[clamp_id],
 			      uclamp_none(clamp_id));
-- 
2.21.0

