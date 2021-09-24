Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B354168C6
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbhIXAMu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 20:12:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41614 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbhIXAMt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 20:12:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:33162)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYo9-005GHU-6P; Thu, 23 Sep 2021 18:11:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57290 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYo7-008617-LO; Thu, 23 Sep 2021 18:11:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <87v92qx2c6.fsf@disp2133>
Date:   Thu, 23 Sep 2021 19:11:08 -0500
In-Reply-To: <87v92qx2c6.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        23 Sep 2021 19:08:09 -0500")
Message-ID: <87a6k2x277.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTYo7-008617-LO;;;mid=<87a6k2x277.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mRGgujfjxQcT6DhZ0b7fSGVrUsAZ73Og=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 473 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.3 (0.9%), b_tie_ro: 3.0 (0.6%), parse: 1.37
        (0.3%), extract_message_metadata: 12 (2.5%), get_uri_detail_list: 3.4
        (0.7%), tests_pri_-1000: 10 (2.2%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 66 (13.9%), check_bayes:
        65 (13.6%), b_tokenize: 8 (1.7%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 1.74 (0.4%), b_tok_touch_all: 44 (9.3%), b_finish: 0.74
        (0.2%), tests_pri_0: 364 (76.9%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.23 (0.3%), tests_pri_10:
        2.9 (0.6%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 4/6] exit: Factor coredump_exit_mm out of exit_mm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Separate the coredump logic from the ordinary exit_mm logic
by moving the coredump logic out of exit_mm into it's own
function coredump_exit_mm.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c |  6 ++--
 kernel/exit.c | 76 +++++++++++++++++++++++++++------------------------
 mm/oom_kill.c |  6 ++--
 3 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 3224dee44d30..5e0e08a7fb9b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -404,8 +404,8 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 	 *
 	 * do_exit:
 	 *	The caller holds mm->mmap_lock. This means that the task which
-	 *	uses this mm can't pass exit_mm(), so it can't exit or clear
-	 *	its ->mm.
+	 *	uses this mm can't pass coredump_exit_mm(), so it can't exit or
+	 *	clear its ->mm.
 	 *
 	 * de_thread:
 	 *	It does list_replace_rcu(&leader->tasks, &current->tasks),
@@ -500,7 +500,7 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 		next = curr->next;
 		task = curr->task;
 		/*
-		 * see exit_mm(), curr->task must not see
+		 * see coredump_exit_mm(), curr->task must not see
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..cb1619d8fd64 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -339,6 +339,46 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 	}
 }
 
+static void coredump_exit_mm(struct mm_struct *mm)
+{
+	struct core_state *core_state;
+
+	/*
+	 * Serialize with any possible pending coredump.
+	 * We must hold mmap_lock around checking core_state
+	 * and clearing tsk->mm.  The core-inducing thread
+	 * will increment ->nr_threads for each thread in the
+	 * group with ->mm != NULL.
+	 */
+	core_state = mm->core_state;
+	if (core_state) {
+		struct core_thread self;
+
+		mmap_read_unlock(mm);
+
+		self.task = current;
+		if (self.task->flags & PF_SIGNALED)
+			self.next = xchg(&core_state->dumper.next, &self);
+		else
+			self.task = NULL;
+		/*
+		 * Implies mb(), the result of xchg() must be visible
+		 * to core_state->dumper.
+		 */
+		if (atomic_dec_and_test(&core_state->nr_threads))
+			complete(&core_state->startup);
+
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (!self.task) /* see coredump_finish() */
+				break;
+			freezable_schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+		mmap_read_lock(mm);
+	}
+}
+
 #ifdef CONFIG_MEMCG
 /*
  * A task is exiting.   If it owned this mm, find a new owner for the mm.
@@ -434,47 +474,13 @@ void mm_update_next_owner(struct mm_struct *mm)
 static void exit_mm(void)
 {
 	struct mm_struct *mm = current->mm;
-	struct core_state *core_state;
 
 	exit_mm_release(current, mm);
 	if (!mm)
 		return;
 	sync_mm_rss(mm);
-	/*
-	 * Serialize with any possible pending coredump.
-	 * We must hold mmap_lock around checking core_state
-	 * and clearing tsk->mm.  The core-inducing thread
-	 * will increment ->nr_threads for each thread in the
-	 * group with ->mm != NULL.
-	 */
 	mmap_read_lock(mm);
-	core_state = mm->core_state;
-	if (core_state) {
-		struct core_thread self;
-
-		mmap_read_unlock(mm);
-
-		self.task = current;
-		if (self.task->flags & PF_SIGNALED)
-			self.next = xchg(&core_state->dumper.next, &self);
-		else
-			self.task = NULL;
-		/*
-		 * Implies mb(), the result of xchg() must be visible
-		 * to core_state->dumper.
-		 */
-		if (atomic_dec_and_test(&core_state->nr_threads))
-			complete(&core_state->startup);
-
-		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			if (!self.task) /* see coredump_finish() */
-				break;
-			freezable_schedule();
-		}
-		__set_current_state(TASK_RUNNING);
-		mmap_read_lock(mm);
-	}
+	coredump_exit_mm(mm);
 	mmgrab(mm);
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..295c8bdfd6c8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -787,9 +787,9 @@ static inline bool __task_will_free_mem(struct task_struct *task)
 	struct signal_struct *sig = task->signal;
 
 	/*
-	 * A coredumping process may sleep for an extended period in exit_mm(),
-	 * so the oom killer cannot assume that the process will promptly exit
-	 * and release memory.
+	 * A coredumping process may sleep for an extended period in
+	 * coredump_exit_mm(), so the oom killer cannot assume that
+	 * the process will promptly exit and release memory.
 	 */
 	if (sig->flags & SIGNAL_GROUP_COREDUMP)
 		return false;
-- 
2.20.1

