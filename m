Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875538B628
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhETShu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhETSht (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 14:37:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5230C061574
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so23984933ybp.5
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7AGHruEohYGhGsLWhPGwuum8o/o2x19SU6E/6s7D8Dk=;
        b=Pu3+Y7jvQGx8TOSMwAdcxkGXw8ApHel7a6gqUY+qKmkRatYgL7/OGgrzh2m84E1DuF
         HeS7fQ48lhl3lKTaB/4TDRHwRY4ZZoZMeaGAfiFRPyBXj9wrcf1QYW8duk7okWzIuP1f
         TxhGswAS6VSC1jKQ+4piAoSF+rVPKyRUOOaNiyAcFQLR+Fpal+Q8F+vn2TuvkucY5o5H
         u+djwx1e06pV5Qam34NLzSiMuFLlQOSRS3/d6hYA9O6O/ixjMemucKHZekx6vPmLzcvv
         pTS6/eoBxdtZk7V/T1yc7r8HH7/s+ZqV8lrl5tTavriQJ0614+wXkIySy3Lh6mzoEmdA
         GQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7AGHruEohYGhGsLWhPGwuum8o/o2x19SU6E/6s7D8Dk=;
        b=SRjZXhoatMgxn8OSk/r2KtWrvZ+hJQX8PnqeG4rRJHMXwhjBNfzrUGxFINrerIGGgj
         yOxoSOs2WaloKz7YWKU2SOCka0UaQ4EgCaIyPGmQAYNUc4K0BGEn11ihTN9ZKREMiCHM
         TICerpEl+BAa7sBPI9PJlQHGWpoU33hfWgSvnYw4VWZRo2RfqgfVNMiRlIznKXadP8aT
         ZzJTgcKUAOtW3prw6c+OcpDJ1VRcKu59KJZsAc+gRrt+s1RQCUEGQ9wiw8kW/abFFRp3
         b+1Y5rav3KsMMkEgLY81ollFv5Ie55kShXL+VA3+/FoifEEJiN3nz64ShYx356mwSkcY
         kz6g==
X-Gm-Message-State: AOAM5326RFnHsf1ykeNTWdQwwnyk9iwjMku5DWE7dX+oVyoTcSnzpO7l
        YAtSwqrQg0Bs4on6XiibsZEIrQGt
X-Google-Smtp-Source: ABdhPJwZEzEbYEe6KExtIabrB2EPVXeZQ7vXbrODudHvRTn5hCfrxNnEWL2GkdoPkiN3kD73bJ9amJ9J
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:f13e:18cf:76e6:2dc4])
 (user=posk job=sendgmr) by 2002:a25:b6c6:: with SMTP id f6mr9686121ybm.16.1621535785956;
 Thu, 20 May 2021 11:36:25 -0700 (PDT)
Date:   Thu, 20 May 2021 11:36:08 -0700
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
Message-Id: <20210520183614.1227046-4-posk@google.com>
Mime-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [RFC PATCH v0.1 3/9] sched: add WF_CURRENT_CPU and externise ttwu
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add WF_CURRENT_CPU wake flag that advices the scheduler to
move the wakee to the current CPU. This is useful for fast on-CPU
context switching use cases such as UMCG.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 15 +++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d2527239c3e..88506bc2617f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3683,8 +3683,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..e55256bbb60b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6764,6 +6764,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
+		if ((wake_flags & WF_CURRENT_CPU) &&
+		    cpumask_test_cpu(cpu, p->cpus_ptr))
+			return cpu;
+
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f0194cee0ba..205d05571d9e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2027,13 +2027,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }
 
 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
 
-#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU       0x40 /* Wakee is on_cpu */
+#define WF_CURRENT_CPU  0x80 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3018,6 +3019,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.31.1.818.g46aad6cb9e-goog

