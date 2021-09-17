Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08F40FEF0
	for <lists+linux-api@lfdr.de>; Fri, 17 Sep 2021 20:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhIQSEx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Sep 2021 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbhIQSEw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Sep 2021 14:04:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B113C061574
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v2so6680546plp.8
        for <linux-api@vger.kernel.org>; Fri, 17 Sep 2021 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZlFi53YDDZ2miUWudnEZW4z2rpJQ5+m8J2ABeeEGiss=;
        b=PwUHON38u6VuzVsfD/HVQtP8CD6IFBOP9Y/WippjAc24bMniBZGOkAgk55P0L06ZgR
         iNdTyDk8BQ4sawfP1Ak+bzMmDz56uoil8zHkaYRoReMq4ptHFy7i7BSL6l0znWKoTfKo
         mPTy5MdWTlzzfBukq3S4r1lNzUsXqqkBYHNiiHjjK2GRC6RpFicfb5gq5RA57PBXOpR6
         HQZiM7nXb168MvKZdyqfCQZlFrc6hw5RoNPaWTOvqqaIprhZIL1s7ngBsZV0WLyqyo7Z
         TUH6UmTMlxDOrSndqgYV7DZGZA5WthIeuOFZaDBoubHdff3au2k9wvnQkX7mumVsmHYG
         KVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlFi53YDDZ2miUWudnEZW4z2rpJQ5+m8J2ABeeEGiss=;
        b=CYay8EjcF7V0WD9CgEX0cnOGUlCQPuXGz05x/KmzuGoi7+xVu70p1KH4PtJqtgeFd/
         0DXajmYsEtXv9QH/CCnOvDWPbWZgKnU2ltgChV7DUscdw/3o/Jnmpl9yxSfFIEAyEgfG
         hUI8PXFWAi4pONJ55y59i+gEMRtUKOcqxYF/O5iGQZdKXbBpT8iPTUY1j8SAuzw+TxIH
         can6xI1NNdHQEu/Jr3SQgHlUZKLnMoPhy8CbKJclbtJNLeOmPgatEiwF2FhuroZQC0xr
         QHAa30/bEBjlOEWJHDry2/bOYxMiYcJxEIjJqjQ4rCrxDL4Uzj/e/pGuniriOX2lCpBn
         YS+g==
X-Gm-Message-State: AOAM533bcS2p5PG/KCIxQDi4lZWuEs7gtRqdGDEtdLAjx7g7YKwQgD82
        DaOnJJtF6tDsHiChI30L2msHsQ==
X-Google-Smtp-Source: ABdhPJxGT3RyQOCtOyp5FgOu8vH46tbboL/+PatLJvIQUYRJaIsHaZxQN+On+AZrDpVUJhtghuKGTw==
X-Received: by 2002:a17:903:22ce:b0:13b:9a00:f090 with SMTP id y14-20020a17090322ce00b0013b9a00f090mr10620365plg.11.1631901810178;
        Fri, 17 Sep 2021 11:03:30 -0700 (PDT)
Received: from posk-g1.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id b24sm5781773pfi.205.2021.09.17.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 11:03:29 -0700 (PDT)
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
Subject: [PATCH 1/5 v0.6] sched/umcg: add WF_CURRENT_CPU and externise ttwu
Date:   Fri, 17 Sep 2021 11:03:19 -0700
Message-Id: <20210917180323.278250-2-posk@google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917180323.278250-1-posk@google.com>
References: <20210917180323.278250-1-posk@google.com>
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
index b36b5d7f2617..12a9d053e724 100644
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
index e26d622762a9..7face28b1830 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6863,6 +6863,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index 148d5d3255a5..2a79c302ee81 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2040,13 +2040,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3054,6 +3055,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);

+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--
2.25.1

