Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C49458689
	for <lists+linux-api@lfdr.de>; Sun, 21 Nov 2021 22:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhKUVXx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 21 Nov 2021 16:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhKUVXv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 21 Nov 2021 16:23:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7C3C061714
        for <linux-api@vger.kernel.org>; Sun, 21 Nov 2021 13:20:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so12110085pjj.0
        for <linux-api@vger.kernel.org>; Sun, 21 Nov 2021 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqE0RmM7gK/dQ2NmLgZR9iia6oknN538MGKbbKe5kmg=;
        b=VfC/2KESGaQJhZx98qZ8Oj4GzCRSg2ul/EXyAsOT9ISi6hBNsL2QZLd29Sz0YkNpmQ
         0YBDE+M6YHVNvIi0ZZ3Cj/zRzVsvGf+Vys4KOEw96zTFqb3Nz+tX09ak+jzdPS311HD2
         6h6IwrdQo5L0b+rC6Wa3aAoIRfUlLy+UnSl1cscI3u2b/F9JNH6qsaaJzwZp6epMutwl
         Afqy+7/W/bS36wRJLDmL4UZBs6MatKhiuUj4BS1XN2kf5+jIAiuYg6A7cT7WL1NI0xYf
         pt/imOiogakgr0a2B7O8XrpmO9V/cm2/9xoPUPED73AopdedrngeWrmBFuRvSApKkxat
         t1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqE0RmM7gK/dQ2NmLgZR9iia6oknN538MGKbbKe5kmg=;
        b=p1UudPnXzbw2LfnTGtU36g6Fo9MtCvQD2+HWFJGYxVpTQvZP6NVo+5qA/b4tqcusCD
         fdQ0P3kWXKYvgJtNQD2E5RRxjqHmLKKLEKgErl6sLCMYKvKAadSA0ByWrirx4nlpYGuJ
         z5YFmVOfXxtHBOkHOwE4G1KhzIfTWrBkPJ+K2pYIaieHYS+7MYl4fXjlr2SWMv0dup2+
         jCJnmxUv/rVRmfFHhgDjqEBnGJJqgaaQfIF7eMclw1Wo5IqpH5WQ1DP0u2ygGakAv/Pq
         9GsMCcErpVpGI0HuNYmTziNXf538HJkPdxRU2PfwWAKRA3wwrYVUrvp/EWETi2hLhH8a
         t/SQ==
X-Gm-Message-State: AOAM533z0cYhEe9GdPH5hMPhWDu051coR383mz9BTkWJtlcZ2q7Q42cK
        Yv/uQ7V2oNfNk1LzDWtaKvQ9bA==
X-Google-Smtp-Source: ABdhPJzl+7OeInZDP+uIq4cZqlN+tCWka/Xat9hKvRilfeB694CXKW6V/Om9i8wOj5ayuRPifae3og==
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr23804710pjb.93.1637529645456;
        Sun, 21 Nov 2021 13:20:45 -0800 (PST)
Received: from posk-p1g4.localdomain (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id k8sm6207924pfu.75.2021.11.21.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 13:20:45 -0800 (PST)
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
Subject: [PATCH v0.9 1/6] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Sun, 21 Nov 2021 13:20:35 -0800
Message-Id: <20211121212040.8649-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121212040.8649-1-posk@google.com>
References: <20211121212040.8649-1-posk@google.com>
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

