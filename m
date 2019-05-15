Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0331EB64
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfEOJpm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEOJpm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964C115A2;
        Wed, 15 May 2019 02:45:41 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66B773F703;
        Wed, 15 May 2019 02:45:38 -0700 (PDT)
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
Subject: [PATCH v9 03/16] sched/core: uclamp: Enforce last task's UCLAMP_MAX
Date:   Wed, 15 May 2019 10:44:46 +0100
Message-Id: <20190515094459.10317-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When a task sleeps it removes its max utilization clamp from its CPU.
However, the blocked utilization on that CPU can be higher than the max
clamp value enforced while the task was running. This allows undesired
CPU frequency increases while a CPU is idle, for example, when another
CPU on the same frequency domain triggers a frequency update, since
schedutil can now see the full not clamped blocked utilization of the
idle CPU.

Fix this by using
  uclamp_rq_dec_id(p, rq, UCLAMP_MAX)
    uclamp_rq_max_value(rq, UCLAMP_MAX, clamp_value)
to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
condition.

Don't track any minimum utilization clamps since an idle CPU never
requires a minimum frequency. The decay of the blocked utilization is
good enough to reduce the CPU frequency.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  | 49 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |  2 ++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 79b57cbbe032..b4014d98ee01 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -791,8 +791,36 @@ static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
 	uc_se->bucket_id = uclamp_bucket_id(value);
 }
 
+static inline unsigned int
+uclamp_idle_value(struct rq *rq, unsigned int clamp_id,
+		  unsigned int clamp_value)
+{
+	/*
+	 * Avoid blocked utilization pushing up the frequency when we go
+	 * idle (which drops the max-clamp) by retaining the last known
+	 * max-clamp.
+	 */
+	if (clamp_id == UCLAMP_MAX) {
+		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
+		return clamp_value;
+	}
+
+	return uclamp_none(UCLAMP_MIN);
+}
+
+static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
+				     unsigned int clamp_value)
+{
+	/* Reset max-clamp retention only on idle exit */
+	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		return;
+
+	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
+}
+
 static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
+unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
+				 unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
 	int bucket_id = UCLAMP_BUCKETS - 1;
@@ -808,7 +836,7 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
 	}
 
 	/* No tasks -- default clamp values */
-	return uclamp_none(clamp_id);
+	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
 /*
@@ -833,6 +861,8 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
 
+	uclamp_idle_reset(rq, clamp_id, uc_se->value);
+
 	/*
 	 * Local max aggregation: rq buckets always track the max
 	 * "requested" clamp value of its RUNNABLE tasks.
@@ -859,6 +889,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
 	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
 	struct uclamp_bucket *bucket;
+	unsigned int bkt_clamp;
 	unsigned int rq_clamp;
 
 	lockdep_assert_held(&rq->lock);
@@ -883,8 +914,10 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * e.g. due to future modification, warn and fixup the expected value.
 	 */
 	SCHED_WARN_ON(bucket->value > rq_clamp);
-	if (bucket->value >= rq_clamp)
-		WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
+	if (bucket->value >= rq_clamp) {
+		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
+		WRITE_ONCE(uc_rq->value, bkt_clamp);
+	}
 }
 
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
@@ -896,6 +929,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
+
+	/* Reset clamp idle holding when there is one RUNNABLE task */
+	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
@@ -914,8 +951,10 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		cpu_rq(cpu)->uclamp_flags = 0;
+	}
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp[clamp_id],
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ebea7a2bb7d..a8a693c75669 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -880,6 +880,8 @@ struct rq {
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utilization clamp values based on CPU's RUNNABLE tasks */
 	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
+	unsigned int		uclamp_flags;
+#define UCLAMP_FLAG_IDLE 0x01
 #endif
 
 	struct cfs_rq		cfs;
-- 
2.21.0

