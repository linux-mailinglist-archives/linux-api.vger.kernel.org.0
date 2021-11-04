Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB1445ACA
	for <lists+linux-api@lfdr.de>; Thu,  4 Nov 2021 20:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhKDUAu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Nov 2021 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhKDUAt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Nov 2021 16:00:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44366C061714
        for <linux-api@vger.kernel.org>; Thu,  4 Nov 2021 12:58:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t11so9025478plq.11
        for <linux-api@vger.kernel.org>; Thu, 04 Nov 2021 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kn7HcLx2rgjoyJ/6+3r40P+Pen7ukIAo+wVP/YczDEw=;
        b=NnefiZ/HQboeZhUCkOlLFeSKbp/Nb79N0ujKczBC+icr521XdNlff2Et7z9NiC6bLz
         rACkbydAtEGgoRLvW2J0kU+OTYRV43EoalgfnXc3KuVABx2n1ZXrNNXcGzNTFza+85GN
         xuSqKDwiOgPc9g8GPEDQ/1uTggDB1hoqw6rbEmyIapzctyVRDqbgz7vmtk3s28Szak0A
         wQEgMcKBrYU9NRhYXUNu2Sp1xIeQfa6MG5LmAAbEuq59uSkc/aMGMRcPgbTPVTdk/2WW
         rFYF0MrHaPjXkKwncibx8ukVQje41jdMmYp8E4oxohJeHQh72l007FBjicodjYR1Rszj
         wN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kn7HcLx2rgjoyJ/6+3r40P+Pen7ukIAo+wVP/YczDEw=;
        b=zUPbQIbS0gY+aWhAxqWILDSblVGEkH8FfNiGF+y64KUsl80Hz/jjPgsX8ea8qEjpkx
         LHEeYDFe8rB3WFZEQoIa2LFDf4OlVZ7tOK6q6sY2syeU6D248XVHsl4GosGko+olT2lK
         P6Ra3TvNWDSbhAxyaUF8V/zzlXxDN5Z6XTBM+TYfuQQSGj5pK3ycEC7O1M5u2nXZWCL4
         ZlaKr10oYQC8MUWi4n4JKr+XO1034Vr0QUkk85Opif1a0K2cT20yU9gM1fF/0dn3sb4S
         330M3iJpwwykfrH6Ww/V2yb+UrbBhIyau2KZKOHR4VahMVmIIeaDYiyrfJbjTC50Fi77
         x8NA==
X-Gm-Message-State: AOAM530bemPmRCKKlqE89D+YbDEjNcWTa+ZF9eH2asgbckW7q8c+X6fT
        NpxhAwyUBk+TkxUQJaoW9+TUzg==
X-Google-Smtp-Source: ABdhPJzUPgDe2i60uA6JKyweoFtgtNwPlwTvdDud9kjKXef4u8SPVtK10C/rbFlVZDrrk7qE+K5rSw==
X-Received: by 2002:a17:90b:3e81:: with SMTP id rj1mr24697695pjb.111.1636055890785;
        Thu, 04 Nov 2021 12:58:10 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id w185sm5487853pfb.38.2021.11.04.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:58:10 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH v0.8 1/6] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Thu,  4 Nov 2021 12:57:59 -0700
Message-Id: <20211104195804.83240-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104195804.83240-1-posk@google.com>
References: <20211104195804.83240-1-posk@google.com>
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
index f2611b9cf503..763d94c0edf3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3963,8 +3963,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index 13950beb01a2..8827a8947c33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6890,6 +6890,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index f0b249ec581d..57f6bd05f537 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2028,13 +2028,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3052,6 +3053,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

