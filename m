Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A5459674
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 22:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbhKVVQm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 16:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbhKVVQk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 16:16:40 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A9C061748
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:33 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q16so693177pgq.10
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 13:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqE0RmM7gK/dQ2NmLgZR9iia6oknN538MGKbbKe5kmg=;
        b=B/9H1pt16NWQ39wGHFGukrvBNeHvWhiur7RkNs+rOWIkk+sPqXw5NOko1pXmiPpa6O
         K8wYCOeLZgorVM71C26wSkg/xrPOm4xExbiEkRkD2r+Njg+TSwfKg7ByhlvahBIaHHGU
         fsM61NbK87lnRkYhQPuXfJLwgKMmWrFKXaAnPwhavKgONlvxmDcAiXSALvGYKAFXXo7/
         fGd82gkgGNCohiAz4iuSThXufAyDmEE/kZmG7hMbGRk2RIi0kh21GcvxYuWafU3Lg0jH
         cPVpCmtNauxSMu5OP5lUwMXWN3/8ykUnuiRDKOlQwZh65KgSK+JM0yMioy/widY9jsmM
         uIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqE0RmM7gK/dQ2NmLgZR9iia6oknN538MGKbbKe5kmg=;
        b=G2ULJaJ07jQatYBC11Q6TdoXCje2qS6cb8WjFlOeM4PpDvcTkthdQx3SFotSzwmMBC
         mYFnIBabFP9khmlIwOsNUViR69IClOmhx6LTC3YPCVMgIzxsdhydiV1UNvR4+TzIOF3u
         9SSkKYo3TroKubTrg927xJAHbpOZHPcq7ZvKibFNkENqSD3yeyeJqTPMl/6xOV3ZzrIJ
         WOHh0Pwp5hLZeYJCchnu1ZwFuqpS4+0S1X5hH9aw5fhUAnC9E4KkB46p4i796g8YSw0C
         MwL7tKLkyRcZoaZdbwXJeejuUkgjijod+o3phJiw4MEbBjFgG1xtgX7iXKo6pyQRHOwo
         YxPw==
X-Gm-Message-State: AOAM5300mGc3rQODag+dkd7ktjKnymS2bmg3Kul0OqZo3toQQMNqegij
        7BJBbJMeQ1mH0C9bzuKMzXuoWHou1n9LQQ==
X-Google-Smtp-Source: ABdhPJyctbI18V/fm6b/C39Y7/7conhzMwGLbxRmM1/9J9ajHs+3VCktPhRrPQdDugYeqBH6emxJZg==
X-Received: by 2002:a05:6a00:23cc:b0:49f:bfaa:e2f6 with SMTP id g12-20020a056a0023cc00b0049fbfaae2f6mr47164393pfc.35.1637615612603;
        Mon, 22 Nov 2021 13:13:32 -0800 (PST)
Received: from posk-p1g4.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id h3sm10453671pfi.207.2021.11.22.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:13:32 -0800 (PST)
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
Subject: [PATCH v0.9.1 1/6] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Mon, 22 Nov 2021 13:13:22 -0800
Message-Id: <20211122211327.5931-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122211327.5931-1-posk@google.com>
References: <20211122211327.5931-1-posk@google.com>
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
index beaa8be6241e..5344aa0afe5a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3977,8 +3977,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index 884f29d07963..399422e6479b 100644
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
index eb971151e7e4..5e1ecf89c12b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2052,13 +2052,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3076,6 +3077,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

