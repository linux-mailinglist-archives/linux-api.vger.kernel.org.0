Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1D3CBC13
	for <lists+linux-api@lfdr.de>; Fri, 16 Jul 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhGPSum (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhGPSuZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 14:50:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E67C061762
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bt15so6960808pjb.2
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCPnqnwkhUpJbwG5YpNTPwxxCuigLKiLFFGzIuCOfoc=;
        b=Xuel8BK9JsT3L2fadBruunrxO49P35kg5RNBCg0ogtTinqX/RJNvnzFnTZZHdsxvTv
         cieo0jCkSbkd34c/34cvMMI5XZWfnCnwyaUQNqAdv7Z8b4UeURDCOFB6gsp+KGSFPNlc
         MkIVItmPHtqpZyY6QZ2C6DNLBVbwAWihtLzbLzl9u2dFDUSFDSGy01ytyCENwHeAwhm9
         2pyhDK9cYvj6Z+AxzuoxtaSaNGU1YmtiLRME7rOFKPzP80nhXa/BF/UN0/7LEI3WR524
         oiaDnXpVulzL9h0ve6OPCNE4ezgB8oXhWyGOjURYqN9fvPYCVABUauFtII34sdfZGc5n
         DIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCPnqnwkhUpJbwG5YpNTPwxxCuigLKiLFFGzIuCOfoc=;
        b=XdxERm4lcZy3AascPiDEPqCKVRsjZljNwAIEKOnw8w8qtVM8iSVDUZFthlnT+WSew2
         2pch+d2XH8O+rPQ5j1zn1JDkIHtAe/TzEKDG/phlb2s+7/EtoLVjx2hfndgCypyonb5y
         B9YhGaxHxvx2VhrmVhl9rD0xMVFipeb7buRDLSXJnWouifC2ozNnr9UNjkXj4PW0K5U+
         xR5dwCLf9A4kkhTz0TICBR1XMrwd3DGgAsiJFAu38wU4aoEvhVjLm39ndJrEKEpbZ1pn
         2QTJpB6ZXvxpEElg1K+s7PPOlFTWRFh8N6TMFLjYKZB3pEWdTYPZv6WFaRXCol0v9sbA
         EMaA==
X-Gm-Message-State: AOAM532W0HAPrq3l4CrXVQhsL5EAawwwhIM9D3YXHsr2/ibdVhrXM4K4
        HwIWmv7ETomWSKWWkUubKZE1qg==
X-Google-Smtp-Source: ABdhPJxt2TQNSdsWaI/t/DNgYtWaN5Qcnj/3sv564RvLzubykA0Rrw0xlKr3H83D4N+nFSuuGMc1gQ==
X-Received: by 2002:a17:90a:4cc4:: with SMTP id k62mr17035943pjh.110.1626461249673;
        Fri, 16 Jul 2021 11:47:29 -0700 (PDT)
Received: from localhost.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id q125sm3170240pga.87.2021.07.16.11.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:47:29 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [RFC PATCH 1/4 v0.3] sched: add WF_CURRENT_CPU and externise ttwu
Date:   Fri, 16 Jul 2021 11:47:16 -0700
Message-Id: <20210716184719.269033-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716184719.269033-1-posk@google.com>
References: <20210716184719.269033-1-posk@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0c22cd026440..293f5801bf81 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3680,8 +3680,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
index 11d22943753f..16a9c93e6e82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6836,6 +6836,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index 9a1c6aeb9165..80de6836f8ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2031,13 +2031,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3037,6 +3038,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

