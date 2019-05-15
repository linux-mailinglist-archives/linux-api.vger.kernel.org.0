Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3A1EB5D
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2019 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEOJpt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 May 2019 05:45:49 -0400
Received: from foss.arm.com ([217.140.101.70]:39294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEOJps (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 May 2019 05:45:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52674A78;
        Wed, 15 May 2019 02:45:48 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37C443F703;
        Wed, 15 May 2019 02:45:45 -0700 (PDT)
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
Subject: [PATCH v9 05/16] sched/core: Allow sched_setattr() to use the current policy
Date:   Wed, 15 May 2019 10:44:48 +0100
Message-Id: <20190515094459.10317-6-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515094459.10317-1-patrick.bellasi@arm.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The sched_setattr() syscall mandates that a policy is always specified.
This requires to always know which policy a task will have when
attributes are configured and this makes it impossible to add more
generic task attributes valid across different scheduling policies.
Reading the policy before setting generic tasks attributes is racy since
we cannot be sure it is not changed concurrently.

Introduce the required support to change generic task attributes without
affecting the current task policy. This is done by adding an attribute flag
(SCHED_FLAG_KEEP_POLICY) to enforce the usage of the current policy.

Add support for the SETPARAM_POLICY policy, which is already used by the
sched_setparam() POSIX syscall, to the sched_setattr() non-POSIX
syscall.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>

---
Changes in v9:
 Message-ID: <20190509145901.um7rrsslg7de4blf@e110439-lin>
 - get rid of not necessary SCHED_POLICY_MAX define
 - update sched_setattr() syscall to just force the current policy on
   SCHED_FLAG_KEEP_POLICY
---
 include/uapi/linux/sched.h | 4 +++-
 kernel/sched/core.c        | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 22627f80063e..261b6e43846c 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -50,9 +50,11 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_KEEP_POLICY		0x08
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_KEEP_POLICY)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dac73a5959b6..43b29b2efa4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4863,6 +4863,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 
 	if ((int)attr.sched_policy < 0)
 		return -EINVAL;
+	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
+		attr.sched_policy = SETPARAM_POLICY;
 
 	rcu_read_lock();
 	retval = -ESRCH;
-- 
2.21.0

