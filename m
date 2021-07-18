Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640203CCB01
	for <lists+linux-api@lfdr.de>; Sun, 18 Jul 2021 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhGRVoj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Jul 2021 17:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGRVoi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Jul 2021 17:44:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645FFC061764
        for <linux-api@vger.kernel.org>; Sun, 18 Jul 2021 14:41:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o12-20020a5b050c0000b02904f4a117bd74so22332046ybp.17
        for <linux-api@vger.kernel.org>; Sun, 18 Jul 2021 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=34U0ArTGqmXEjhOeCq4v/OslLn/g3DytngGhTp5TZL8=;
        b=pPvAdUp/CHeFKkyssuk3noamEwEUQ430z6Mm20okH/S7xjTEMSN1hLsGZyoIoqrNNS
         rzGK9ki2izgz4kD3nHi/YreNd4EAvRfyoeihoKKXGV7J+C6YcJIS0zn9s5tqxBNvPGIP
         CoYhAbkMOQE1fN18Jgyf8pF55oBU0iJdtTVwskGFybU3brpP1tWl6JZDfuFbbm1Zf3c2
         J5jfRBIUo+KEkQ9aUIW16s+J/v1hZDIVunR0lwrOIrhIONqBXZ2t7yGWPA+OOrSgaP5o
         lCR1vkyk7/alS9/emKMVqI9iNUS3KzrGBXzEwgzgeThZ7sKMYsQVxgkWSifn3LDH6kxd
         m3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=34U0ArTGqmXEjhOeCq4v/OslLn/g3DytngGhTp5TZL8=;
        b=C30f5ogTb0POSbTHiChe5LbQMLvNL2ueuyM/FHwAd/H13cWNxGaYE7S61bgFtN6xpQ
         9WC3NRNdvu65JQqULSV0p1inpugoGg4YjxlbcaOivZqAP/tQ2jFOhXDvDNAqYYQKQNJw
         o9zG3f44Nmt0tS3/OI7r7JjNINNbk6zFm6IYg3ziXGQHwh7XI6IxI3/BIWhJUyBjsCqy
         /PsYEf4UKSBXDBC8HOfy4zggNxs6W6ctzn/o7V5x3dHr2J1c+3y3LHWwRB9DS5u1Si+j
         P5FqpbVXbr4eHbbH5IWC4MBLrbrnhu6YLAZ2GFaE3ZcsHCZHht4Nl8j/tB92QAYObz9r
         sh5A==
X-Gm-Message-State: AOAM533vu0hWDu/VFNjiFJJlTKVCQVUEUcdKVi3W21pIsRpKXlovz/k6
        3H07Gs2FLFFpngGZFb5gg0zbpV6cPoI=
X-Google-Smtp-Source: ABdhPJyHpBJotkKu8PrUTO0MZGywY5JL/FZae0r63UdMIUbNcFIJSmjtRbMs4cLePCK/g7u/ncJ/RXD+Utc=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:b347:cf97:e43a:9891])
 (user=surenb job=sendgmr) by 2002:a25:694f:: with SMTP id e76mr26374379ybc.119.1626644498976;
 Sun, 18 Jul 2021 14:41:38 -0700 (PDT)
Date:   Sun, 18 Jul 2021 14:41:32 -0700
Message-Id: <20210718214134.2619099-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to be
 used in process_mrelease
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_mrelease needs to be added in the CONFIG_MMU-dependent block which
comes before __task_will_free_mem and task_will_free_mem. Move these
functions before this block so that new process_mrelease syscall can use
them.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v2:
- Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
required moving task_will_free_mem implemented in the first patch
- Renamed process_reap to process_mrelease, per majority of votes
- Replaced "dying process" with "process which was sent a SIGKILL signal" in
the manual page text, per Florian Weimer
- Added ERRORS section in the manual page text
- Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
- Separated boilerplate code wiring-up the new syscall into a separate patch
to facilitate the review process

 mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c729a4c4a1ac..d04a13dc9fde 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -501,6 +501,81 @@ bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
 	return false;
 }
 
+static inline bool __task_will_free_mem(struct task_struct *task)
+{
+	struct signal_struct *sig = task->signal;
+
+	/*
+	 * A coredumping process may sleep for an extended period in exit_mm(),
+	 * so the oom killer cannot assume that the process will promptly exit
+	 * and release memory.
+	 */
+	if (sig->flags & SIGNAL_GROUP_COREDUMP)
+		return false;
+
+	if (sig->flags & SIGNAL_GROUP_EXIT)
+		return true;
+
+	if (thread_group_empty(task) && (task->flags & PF_EXITING))
+		return true;
+
+	return false;
+}
+
+/*
+ * Checks whether the given task is dying or exiting and likely to
+ * release its address space. This means that all threads and processes
+ * sharing the same mm have to be killed or exiting.
+ * Caller has to make sure that task->mm is stable (hold task_lock or
+ * it operates on the current).
+ */
+static bool task_will_free_mem(struct task_struct *task)
+{
+	struct mm_struct *mm = task->mm;
+	struct task_struct *p;
+	bool ret = true;
+
+	/*
+	 * Skip tasks without mm because it might have passed its exit_mm and
+	 * exit_oom_victim. oom_reaper could have rescued that but do not rely
+	 * on that for now. We can consider find_lock_task_mm in future.
+	 */
+	if (!mm)
+		return false;
+
+	if (!__task_will_free_mem(task))
+		return false;
+
+	/*
+	 * This task has already been drained by the oom reaper so there are
+	 * only small chances it will free some more
+	 */
+	if (test_bit(MMF_OOM_SKIP, &mm->flags))
+		return false;
+
+	if (atomic_read(&mm->mm_users) <= 1)
+		return true;
+
+	/*
+	 * Make sure that all tasks which share the mm with the given tasks
+	 * are dying as well to make sure that a) nobody pins its mm and
+	 * b) the task is also reapable by the oom reaper.
+	 */
+	rcu_read_lock();
+	for_each_process(p) {
+		if (!process_shares_mm(p, mm))
+			continue;
+		if (same_thread_group(task, p))
+			continue;
+		ret = __task_will_free_mem(p);
+		if (!ret)
+			break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 #ifdef CONFIG_MMU
 /*
  * OOM Reaper kernel thread which tries to reap the memory used by the OOM
@@ -781,81 +856,6 @@ bool oom_killer_disable(signed long timeout)
 	return true;
 }
 
-static inline bool __task_will_free_mem(struct task_struct *task)
-{
-	struct signal_struct *sig = task->signal;
-
-	/*
-	 * A coredumping process may sleep for an extended period in exit_mm(),
-	 * so the oom killer cannot assume that the process will promptly exit
-	 * and release memory.
-	 */
-	if (sig->flags & SIGNAL_GROUP_COREDUMP)
-		return false;
-
-	if (sig->flags & SIGNAL_GROUP_EXIT)
-		return true;
-
-	if (thread_group_empty(task) && (task->flags & PF_EXITING))
-		return true;
-
-	return false;
-}
-
-/*
- * Checks whether the given task is dying or exiting and likely to
- * release its address space. This means that all threads and processes
- * sharing the same mm have to be killed or exiting.
- * Caller has to make sure that task->mm is stable (hold task_lock or
- * it operates on the current).
- */
-static bool task_will_free_mem(struct task_struct *task)
-{
-	struct mm_struct *mm = task->mm;
-	struct task_struct *p;
-	bool ret = true;
-
-	/*
-	 * Skip tasks without mm because it might have passed its exit_mm and
-	 * exit_oom_victim. oom_reaper could have rescued that but do not rely
-	 * on that for now. We can consider find_lock_task_mm in future.
-	 */
-	if (!mm)
-		return false;
-
-	if (!__task_will_free_mem(task))
-		return false;
-
-	/*
-	 * This task has already been drained by the oom reaper so there are
-	 * only small chances it will free some more
-	 */
-	if (test_bit(MMF_OOM_SKIP, &mm->flags))
-		return false;
-
-	if (atomic_read(&mm->mm_users) <= 1)
-		return true;
-
-	/*
-	 * Make sure that all tasks which share the mm with the given tasks
-	 * are dying as well to make sure that a) nobody pins its mm and
-	 * b) the task is also reapable by the oom reaper.
-	 */
-	rcu_read_lock();
-	for_each_process(p) {
-		if (!process_shares_mm(p, mm))
-			continue;
-		if (same_thread_group(task, p))
-			continue;
-		ret = __task_will_free_mem(p);
-		if (!ret)
-			break;
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static void __oom_kill_process(struct task_struct *victim, const char *message)
 {
 	struct task_struct *p;
-- 
2.32.0.402.g57bb445576-goog

