Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3338D3DCD89
	for <lists+linux-api@lfdr.de>; Sun,  1 Aug 2021 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhHAUGc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 1 Aug 2021 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHAUGb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Aug 2021 16:06:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587B6C0613D3
        for <linux-api@vger.kernel.org>; Sun,  1 Aug 2021 13:06:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso28547726pjb.1
        for <linux-api@vger.kernel.org>; Sun, 01 Aug 2021 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCPnqnwkhUpJbwG5YpNTPwxxCuigLKiLFFGzIuCOfoc=;
        b=IpSW8r9zaSH4oRDUs3Pg0es824Pb7yXKWxj281dCKHHkF5SlVQxracuMrevOuJf6ZS
         1R4Z8elXmy8leUdqpJhWlmHJ7Q9MWDxbiGTWCerQJBKGwL0glZ7LFy3X7s7e+t88n+3g
         YM22THFp3KWGl8aXUJBdIDOpGkXI5BvgPnCFdt7OzxcfF6jp5CStY1sfXgunp3LTpXIl
         zg7ONpyyCeioW1yqyNi6sTNJ365FZD6KWpUwvGtv0p/qRJkUFTjskayjYBdsdN7cR2NH
         NR4VDWwJMfK0RltVZOGDcwJHjC6Dchtw7nGzh2wDYipBn99ZSMvETBa5XkN3Ldw0y4qu
         gUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCPnqnwkhUpJbwG5YpNTPwxxCuigLKiLFFGzIuCOfoc=;
        b=Qya/s9ztGCZEOfuHCu1OjaianNR3scwnih/Tfqb1IGkd/UeCJJuXUvkHmeIhEO86bC
         LEiGo/fHeOEt6S6yTPFwfD3127tFQfxlN2Ev3Kh16Rj5gtT8WCkJZ758gMluk3qAZ0ua
         ENgGOyypp+9pMP0mh/29YUZxXMBZ5cHI6RIVVR14FZ0PTWcAR8cQBlHiPMc+/lFa+lxv
         fS8ZhcCHHizpa5zOoPuF7UfpWdtLBFeqClzoUquVY+C2SNajdcqW57wxBS8l98f4unZP
         XqBHkCkHi6Kw2nEO13ycPiSHG/HkJgMyGB5Ul5ERnDEO/NhxZ0tp5BS/ivNMq2l9OSTn
         OGtg==
X-Gm-Message-State: AOAM5338yTQUMDj2j1mZ/qPcXD7jsHGc7hsQSYH801TC1iGQQy3o7fco
        6nrpwZJZDQa+9YtMdz2sZPU8jw==
X-Google-Smtp-Source: ABdhPJx/Dnr6GvumM7FMu9/7Srv3lbAl0o365nfrISWXULmh5aT3nsOn8kHmXWDpZy/mJnB0gJcUnA==
X-Received: by 2002:a65:4307:: with SMTP id j7mr4588063pgq.387.1627848382865;
        Sun, 01 Aug 2021 13:06:22 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b3sm9293714pfi.179.2021.08.01.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:06:22 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
X-Google-Original-From: Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: [PATCH 1/4 v0.4] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Sun,  1 Aug 2021 13:06:14 -0700
Message-Id: <20210801200617.623745-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210801200617.623745-1-posk@google.com>
References: <20210801200617.623745-1-posk@google.com>
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

