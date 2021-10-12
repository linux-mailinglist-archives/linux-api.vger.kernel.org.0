Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5542B019
	for <lists+linux-api@lfdr.de>; Wed, 13 Oct 2021 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhJLX1f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhJLX1e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 19:27:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63724C061745
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso849832pjb.1
        for <linux-api@vger.kernel.org>; Tue, 12 Oct 2021 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+AAlSGdfykU1tO7w/flE6eblBoqjmus4rn0qbCYx5Y=;
        b=AOOMDKLEjpTIzLN/vIxj+Sop5AXNOpIZViYdWXnt644rrwdnl8WZQLZU34oi5ObIW8
         LKfVKIZa+YTZ5GS6Zg7Ai/8ED7pCYe69eOp/AQCE6Acslk9WrjTEUjR8jfsTHx5DchuE
         sE/z/EmcB6hAKEaIfUwxF6SpTORvci8CD2JC4InwTBqLp6NgAqhx9cSEr3sBV1pwURXW
         OZ9yvzZNRilMWGVvXQBYwdOzLB1b/lXcDFi973ZAh+CNuP1p2osjYmCw0b7sntKP5FRO
         rBU0Yi66VVe7eweJ5YRvAeznEZLuzqrvw8RpC24/SCavF6BtN4QtcmmYMVb3eIkJmLkv
         r1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+AAlSGdfykU1tO7w/flE6eblBoqjmus4rn0qbCYx5Y=;
        b=vd4dn/wAvquJs0e0U0JhyFWhvdBLnkQrU+UkpEmKYPHM+3l2//idf+LAXPy+9Z9Gzh
         qXY5PhIY/cJlDx/H9Yg4hLqBSmfujRx9NY576uD+reC+P6ieXodZ2bYKE2OiEfT9qXAJ
         a4B4wgI23Dse0yTKi94qhaH9UVdj1m2YVc+bvNp8uMONg/EyAfHfmbQh+ZJHPc/I4HIF
         2P17R46N35ggCLiOJdkIKGTP99LGzyE+OElphDIIFrCgj0L6qlHEOz3R/uhs+eZ89whn
         rDvJRfELI1P17rj9lwhfzIfG55bFomhIPeiEiCGTpsVc/eCZGdVLGuIqrWris0/mburs
         2+BA==
X-Gm-Message-State: AOAM531PHD2oGy+1sXQtcowe7bIl/cshE65Z1JK6MMXMVMIzJd7Ex5L7
        mhnDNX1LVWBS5LK5zBb+xobqaA==
X-Google-Smtp-Source: ABdhPJyC/bMU8enieCExPqMGGvVINf9J+YdHsRgtgg57gRVB06c6oeDKHVZwlWLsky9sQunaICaWDQ==
X-Received: by 2002:a17:90b:4d84:: with SMTP id oj4mr9558127pjb.58.1634081131906;
        Tue, 12 Oct 2021 16:25:31 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id v20sm12675026pgc.38.2021.10.12.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:25:31 -0700 (PDT)
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
Subject: [PATCH v0.7 1/5] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Tue, 12 Oct 2021 16:25:18 -0700
Message-Id: <20211012232522.714898-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012232522.714898-1-posk@google.com>
References: <20211012232522.714898-1-posk@google.com>
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
index 935c2da00339..d6da1efb5ce6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3944,8 +3944,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index 87db481e8a56..c900a3f16607 100644
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
index a00fc7057d97..4b566607952b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2036,13 +2036,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3060,6 +3061,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

