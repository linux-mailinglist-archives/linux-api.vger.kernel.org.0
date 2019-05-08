Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8413218028
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEHTAf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 15:00:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52246 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfEHTAf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 15:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G5cSp6uXMPnnzFNazt27d470pw/eFBtk4HEyqUtsqls=; b=NVKayVoyG7DIerq67jDawzKuW
        Z8DyXl57CA29JIEnjkvQDkz47ar/picbGRJetShXTWoRnpuGCTy/TAo4z1jDS8ptFebBowu0YwoA3
        1LWeN32ilwW40UU5OS7D+TL+grn1eI73hYHJKnumIOOODWZYqwmCgk+FR20mdOT4MwEO1jExULTQH
        978E00mwL4rlORhP/8v8RqibzJJdKyCgREbgcw50hAJd4ORJEs17bnWrhx+b86bBZj0iRFG6aFyS8
        nK8RSgVBeqblNFUBglYTchSLmEyYryMYY1AreMSrt+IfuCc92OfKDDKgKOClRa++ZHxYfoEth7v0b
        YmHgCyUFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hORna-0003RS-0P; Wed, 08 May 2019 19:00:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7ED198030A; Wed,  8 May 2019 21:00:11 +0200 (CEST)
Date:   Wed, 8 May 2019 21:00:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v8 04/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190508190011.GB32547@worktop.programming.kicks-ass.net>
References: <20190402104153.25404-1-patrick.bellasi@arm.com>
 <20190402104153.25404-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402104153.25404-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


There was a bunch of repetition that seemed fragile; does something like
the below make sense?


Index: linux-2.6/kernel/sched/core.c
===================================================================
--- linux-2.6.orig/kernel/sched/core.c
+++ linux-2.6/kernel/sched/core.c
@@ -770,6 +770,9 @@ unsigned int sysctl_sched_uclamp_util_ma
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
+#define for_each_clamp_id(clamp_id)	\
+	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
+
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
 
@@ -790,6 +793,12 @@ static inline unsigned int uclamp_none(i
 	return SCHED_CAPACITY_SCALE;
 }
 
+static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
+{
+	uc_se->value = value;
+	uc_se->bucket_id = uclamp_bucket_id(value);
+}
+
 static inline unsigned int
 uclamp_idle_value(struct rq *rq, unsigned int clamp_id, unsigned int clamp_value)
 {
@@ -977,7 +986,7 @@ static inline void uclamp_rq_inc(struct
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(p, rq, clamp_id);
 
 	/* Reset clamp idle holding when there is one RUNNABLE task */
@@ -992,7 +1001,7 @@ static inline void uclamp_rq_dec(struct
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+	for_each_clamp_id(clamp_id)
 		uclamp_rq_dec_id(p, rq, clamp_id);
 }
 
@@ -1021,16 +1030,13 @@ int sysctl_sched_uclamp_handler(struct c
 	}
 
 	if (old_min != sysctl_sched_uclamp_util_min) {
-		uclamp_default[UCLAMP_MIN].value =
-			sysctl_sched_uclamp_util_min;
-		uclamp_default[UCLAMP_MIN].bucket_id =
-			uclamp_bucket_id(sysctl_sched_uclamp_util_min);
+		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
+			      sysctl_sched_uclamp_util_min);
 	}
+
 	if (old_max != sysctl_sched_uclamp_util_max) {
-		uclamp_default[UCLAMP_MAX].value =
-			sysctl_sched_uclamp_util_max;
-		uclamp_default[UCLAMP_MAX].bucket_id =
-			uclamp_bucket_id(sysctl_sched_uclamp_util_max);
+		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
+			      sysctl_sched_uclamp_util_max);
 	}
 
 	/*
@@ -1052,7 +1058,7 @@ static void uclamp_fork(struct task_stru
 {
 	unsigned int clamp_id;
 
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
 }
 
@@ -1067,17 +1073,12 @@ static void __init init_uclamp(void)
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
-		struct uclamp_se *uc_se = &init_task.uclamp_req[clamp_id];
-
-		uc_se->value = uclamp_none(clamp_id);
-		uc_se->bucket_id = uclamp_bucket_id(uc_se->value);
-	}
+	for_each_clamp_id(clamp_id)
+		uclamp_se_set(&init_task.uclamp_req[clamp_id], uclamp_none(clamp_id));
 
 	/* System defaults allow max clamp values for both indexes */
-	uc_max.value = uclamp_none(UCLAMP_MAX);
-	uc_max.bucket_id = uclamp_bucket_id(uc_max.value);
-	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX));
+	for_each_clamp_id(clamp_id)
 		uclamp_default[clamp_id] = uc_max;
 }
 

