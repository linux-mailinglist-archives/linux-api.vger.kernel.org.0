Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF97403F3B
	for <lists+linux-api@lfdr.de>; Wed,  8 Sep 2021 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbhIHSuW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350223AbhIHSuV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 14:50:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31661C061757
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 11:49:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so1989406pjw.2
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLM8tZxIm3DpNgvKtJLq9vNV4FJyC60nU3qu5GCMqcA=;
        b=I3GxgqxWN/TJBeTv4BGI7hunQKjECL9lnNM18Y0Lx0SiehE1JFU1VfnFDJDWuGevSd
         g2fyNH6inB2WyBz6OGeAByCeTMaa9vRBhtm4TDA3KfoTB3EtCw+UX5aol+Q7ct0H6Q7Z
         J69ZnyqMWO2X2W49Vr/IwjOdJuLFU/prFCtKsH7VGSYttIrJPi8u1EyvoF+DmMT8Zo8J
         8AyWc2K6t8KF9TWgH4nrl12Sbj3Dd3rj7P/e387gdqBZNRk+fQO2KpUkUt+QexGvMDXx
         xb2N7mrC4W5vvvAnBK5dgxzr0/ea6x1vE4PAjXf0jKPAMxnBCEw3LAoqftPSRX39r7YI
         +ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLM8tZxIm3DpNgvKtJLq9vNV4FJyC60nU3qu5GCMqcA=;
        b=hngQxK5WSAxSggKlVBAK6gJ4PFZbjGhNf/P2OvvkpOugTBT/JsE6MBOnU2ItN3Sjz6
         oAZkIMZmCAMoO7aQ1wzOarN3U7+muQTNCpuOFE3Z1LS3E3KpN8Ma1cDvJ0YHraEEo/A0
         KIP9tYNtXuoIP+Bg8kz3swjWBcOcSf26sfLrm5/H/5AcJ7+SKh/pkqCJpswu6trCbX2k
         WE3ArSzaN2CcKWgVvdbXmEX8OAQQJDU7vEaCw7IYa7etD2B0sz4Uq2lTOT3MaCyPjy7/
         3SAzV7sS3ldo84N2YK5rURYiWatWONZr0Kkbk+zCTYcCXAfcm9xddLjqJYbsi3U6aMOd
         ZDiw==
X-Gm-Message-State: AOAM532nqkBxUS5nOqAvbzertjhdrKP6cbniJ1B5aXBQ+XND77LE4ebh
        4gL99IkGyB9kCl8k7YHuHWKekg==
X-Google-Smtp-Source: ABdhPJxHbzxD3tNttO1vXpgAQwT04oUZ+sb1G1k3NyRWnJUDfar572vi9txND2jfHjJE3Az7luoPXA==
X-Received: by 2002:a17:90a:192:: with SMTP id 18mr5827008pjc.119.1631126952717;
        Wed, 08 Sep 2021 11:49:12 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m64sm3645640pga.55.2021.09.08.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:49:12 -0700 (PDT)
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
Subject: [PATCH 1/4 v0.5] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Wed,  8 Sep 2021 11:49:02 -0700
Message-Id: <20210908184905.163787-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908184905.163787-1-posk@google.com>
References: <20210908184905.163787-1-posk@google.com>
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
index a22cc3c156ce..377c4d931546 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3878,8 +3878,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
index 7b3e85912a1f..133eea90e045 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6893,6 +6893,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index e7e2bba5b520..bb807650722a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2041,13 +2041,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3048,6 +3049,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

