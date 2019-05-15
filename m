Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA31EB58
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEOJp4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfEOJpz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42313A78;
        Wed, 15 May 2019 02:45:55 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21BE73F703;
        Wed, 15 May 2019 02:45:51 -0700 (PDT)
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
Subject: [PATCH v9 07/16] sched/core: uclamp: Reset uclamp values on RESET_ON_FORK
Date:   Wed, 15 May 2019 10:44:50 +0100
Message-Id: <20190515094459.10317-8-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A forked tasks gets the same clamp values of its parent however, when
the RESET_ON_FORK flag is set on parent, e.g. via:

   sys_sched_setattr()
      sched_setattr()
         __sched_setscheduler(attr::SCHED_FLAG_RESET_ON_FORK)

the new forked task is expected to start with all attributes reset to
default values.

Do that for utilization clamp values too by checking the reset request
from the existing uclamp_fork() call which already provides the required
initialization for other uclamp related bits.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e035fbb187d..03b1cd82bc48 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1070,6 +1070,14 @@ static void uclamp_fork(struct task_struct *p)
 
 	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
+
+	if (likely(!p->sched_reset_on_fork))
+		return;
+
+	for_each_clamp_id(clamp_id) {
+		uclamp_se_set(&p->uclamp_req[clamp_id],
+			      uclamp_none(clamp_id), false);
+	}
 }
 
 static void __init init_uclamp(void)
-- 
2.21.0

