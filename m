Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8961EB4A
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfEOJqG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:46:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39392 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEOJqF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:46:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 541A780D;
        Wed, 15 May 2019 02:46:05 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C4FD3F703;
        Wed, 15 May 2019 02:46:02 -0700 (PDT)
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
Subject: [PATCH v9 10/16] sched/core: uclamp: Add uclamp_util_with()
Date:   Wed, 15 May 2019 10:44:53 +0100
Message-Id: <20190515094459.10317-11-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

So far uclamp_util() allows to clamp a specified utilization considering
the clamp values requested by RUNNABLE tasks in a CPU. For the Energy
Aware Scheduler (EAS) it is interesting to test how clamp values will
change when a task is becoming RUNNABLE on a given CPU.
For example, EAS is interested in comparing the energy impact of
different scheduling decisions and the clamp values can play a role on
that.

Add uclamp_util_with() which allows to clamp a given utilization by
considering the possible impact on CPU clamp values of a specified task.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v9:
 Message-ID: <20190507103845.tejg55wfsu3l3jwh@e110439-lin>
 - moved here the definition of uclamp_eff_value() from a previous patch
---
 kernel/sched/core.c  | 13 +++++++++++++
 kernel/sched/sched.h | 21 ++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f0e04298b1d7..eed7664437ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -868,6 +868,19 @@ uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
 	return uc_req;
 }
 
+unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id)
+{
+	struct uclamp_se uc_eff;
+
+	/* Task currently refcounted: use back-annotated (effective) value */
+	if (p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].value;
+
+	uc_eff = uclamp_eff_get(p, clamp_id);
+
+	return uc_eff.value;
+}
+
 /*
  * When a task is enqueued on a rq, the clamp bucket currently defined by the
  * task's uclamp::bucket_id is refcounted on that rq. This also immediately
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1ea44f4dec16..c95340a1d598 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2276,11 +2276,20 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+unsigned int uclamp_eff_value(struct task_struct *p, unsigned int clamp_id);
+
+static __always_inline
+unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
+			      struct task_struct *p)
 {
 	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
 	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
+	if (p) {
+		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
+		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+	}
+
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
@@ -2291,7 +2300,17 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 
 	return clamp(util, min_util, max_util);
 }
+
+static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+{
+	return uclamp_util_with(rq, util, NULL);
+}
 #else /* CONFIG_UCLAMP_TASK */
+static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
+					    struct task_struct *p)
+{
+	return util;
+}
 static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 {
 	return util;
-- 
2.21.0

