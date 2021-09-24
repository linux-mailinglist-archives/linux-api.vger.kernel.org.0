Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2828F4168CC
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 02:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhIXAOR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 20:14:17 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34218 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXAOQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 20:14:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:38214)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYpW-007kDS-1a; Thu, 23 Sep 2021 18:12:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57458 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYpU-0086AU-I2; Thu, 23 Sep 2021 18:12:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <87v92qx2c6.fsf@disp2133>
Date:   Thu, 23 Sep 2021 19:12:33 -0500
In-Reply-To: <87v92qx2c6.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        23 Sep 2021 19:08:09 -0500")
Message-ID: <87y27mvnke.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTYpU-0086AU-I2;;;mid=<87y27mvnke.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/on7JEiOFM0/x6IJOujYsaok/SFAKOm/M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,XMNoVowels,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 893 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.2%), b_tie_ro: 9 (1.1%), parse: 1.57 (0.2%),
         extract_message_metadata: 18 (2.0%), get_uri_detail_list: 6 (0.7%),
        tests_pri_-1000: 15 (1.6%), tests_pri_-950: 1.41 (0.2%),
        tests_pri_-900: 1.17 (0.1%), tests_pri_-90: 79 (8.9%), check_bayes: 78
        (8.7%), b_tokenize: 21 (2.4%), b_tok_get_all: 15 (1.7%), b_comp_prob:
        4.4 (0.5%), b_tok_touch_all: 32 (3.6%), b_finish: 0.92 (0.1%),
        tests_pri_0: 751 (84.1%), check_dkim_signature: 0.83 (0.1%),
        check_dkim_adsp: 2.7 (0.3%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 8 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/6] coredump: Limit coredumps to a single thread group
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Today when a signal is delivered with a handler of SIG_DFL whose
default behavior is to generate a core dump not only that process but
every process that shares the mm is killed.

In the case of vfork this looks like a real world problem.  Consider
the following well defined sequence.

	if (vfork() == 0) {
		execve(...);
		_exit(EXIT_FAILURE);
	}

If a signal that generates a core dump is received after vfork but
before the execve changes the mm the process that called vfork will
also be killed (as the mm is shared).

Similarly if the execve fails after the point of no return the kernel
delivers SIGSEGV which will kill both the exec'ing process and because
the mm is shared the process that called vfork as well.

As far as I can tell this behavior is a violation of people's
reasonable expectations, POSIX, and is unnecessarily fragile when the
system is low on memory.

Solve this by making a userspace visible change to only kill a single
process/thread group.  This is possible because Jann Horn recently
modified[1] the coredump code so that the mm can safely be modified
while the coredump is happening.  With LinuxThreads long gone I don't
expect anyone to have a notice this behavior change in practice.

To accomplish this move the core_state pointer from mm_struct to
signal_struct, which allows different thread groups to coredump
simultatenously.

In zap_threads remove the work to kill anything except for the current
thread group.

[1] a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
Fixes: d89f3847def4 ("[PATCH] thread-aware coredumps, 2.5.43-C3")
History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_elf.c              |  4 +-
 fs/binfmt_elf_fdpic.c        |  2 +-
 fs/coredump.c                | 84 ++++--------------------------------
 fs/proc/array.c              |  6 +--
 include/linux/mm_types.h     | 13 ------
 include/linux/sched/signal.h | 13 ++++++
 kernel/exit.c                | 13 ++----
 kernel/fork.c                |  1 -
 8 files changed, 32 insertions(+), 104 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 69d900a8473d..796e5327ee7d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1834,7 +1834,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	/*
 	 * Allocate a structure for each thread.
 	 */
-	for (ct = &dump_task->mm->core_state->dumper; ct; ct = ct->next) {
+	for (ct = &dump_task->signal->core_state->dumper; ct; ct = ct->next) {
 		t = kzalloc(offsetof(struct elf_thread_core_info,
 				     notes[info->thread_notes]),
 			    GFP_KERNEL);
@@ -2024,7 +2024,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	if (!elf_note_info_init(info))
 		return 0;
 
-	for (ct = current->mm->core_state->dumper.next;
+	for (ct = current->signal->core_state->dumper.next;
 					ct; ct = ct->next) {
 		ets = kzalloc(sizeof(*ets), GFP_KERNEL);
 		if (!ets)
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 6d8fd6030cbb..c6f588dc4a9d 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1494,7 +1494,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, &vma_data_size))
 		goto end_coredump;
 
-	for (ct = current->mm->core_state->dumper.next;
+	for (ct = current->signal->core_state->dumper.next;
 					ct; ct = ct->next) {
 		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
 					     ct->task, &thread_status_size);
diff --git a/fs/coredump.c b/fs/coredump.c
index d576287fb88b..a6b3c196cdef 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -369,99 +369,34 @@ static int zap_process(struct task_struct *start, int exit_code, int flags)
 	return nr;
 }
 
-static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
+static int zap_threads(struct task_struct *tsk,
 			struct core_state *core_state, int exit_code)
 {
-	struct task_struct *g, *p;
-	unsigned long flags;
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!signal_group_exit(tsk->signal)) {
-		mm->core_state = core_state;
+		tsk->signal->core_state = core_state;
 		tsk->signal->group_exit_task = tsk;
 		nr = zap_process(tsk, exit_code, 0);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
+		tsk->flags |= PF_DUMPCORE;
+		atomic_set(&core_state->nr_threads, nr);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
-	if (unlikely(nr < 0))
-		return nr;
-
-	tsk->flags |= PF_DUMPCORE;
-	if (atomic_read(&mm->mm_users) == nr + 1)
-		goto done;
-	/*
-	 * We should find and kill all tasks which use this mm, and we should
-	 * count them correctly into ->nr_threads. We don't take tasklist
-	 * lock, but this is safe wrt:
-	 *
-	 * fork:
-	 *	None of sub-threads can fork after zap_process(leader). All
-	 *	processes which were created before this point should be
-	 *	visible to zap_threads() because copy_process() adds the new
-	 *	process to the tail of init_task.tasks list, and lock/unlock
-	 *	of ->siglock provides a memory barrier.
-	 *
-	 * do_exit:
-	 *	The caller holds mm->mmap_lock. This means that the task which
-	 *	uses this mm can't pass coredump_task_exit(), so it can't exit
-	 *	or clear its ->mm.
-	 *
-	 * de_thread:
-	 *	It does list_replace_rcu(&leader->tasks, &current->tasks),
-	 *	we must see either old or new leader, this does not matter.
-	 *	However, it can change p->sighand, so lock_task_sighand(p)
-	 *	must be used. Since p->mm != NULL and we hold ->mmap_lock
-	 *	it can't fail.
-	 *
-	 *	Note also that "g" can be the old leader with ->mm == NULL
-	 *	and already unhashed and thus removed from ->thread_group.
-	 *	This is OK, __unhash_process()->list_del_rcu() does not
-	 *	clear the ->next pointer, we will find the new leader via
-	 *	next_thread().
-	 */
-	rcu_read_lock();
-	for_each_process(g) {
-		if (g == tsk->group_leader)
-			continue;
-		if (g->flags & PF_KTHREAD)
-			continue;
-
-		for_each_thread(g, p) {
-			if (unlikely(!p->mm))
-				continue;
-			if (unlikely(p->mm == mm)) {
-				lock_task_sighand(p, &flags);
-				nr += zap_process(p, exit_code,
-							SIGNAL_GROUP_EXIT);
-				unlock_task_sighand(p, &flags);
-			}
-			break;
-		}
-	}
-	rcu_read_unlock();
-done:
-	atomic_set(&core_state->nr_threads, nr);
 	return nr;
 }
 
 static int coredump_wait(int exit_code, struct core_state *core_state)
 {
 	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
 	int core_waiters = -EBUSY;
 
 	init_completion(&core_state->startup);
 	core_state->dumper.task = tsk;
 	core_state->dumper.next = NULL;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
-	if (!mm->core_state)
-		core_waiters = zap_threads(tsk, mm, core_state, exit_code);
-	mmap_write_unlock(mm);
-
+	core_waiters = zap_threads(tsk, core_state, exit_code);
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
@@ -483,7 +418,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	return core_waiters;
 }
 
-static void coredump_finish(struct mm_struct *mm, bool core_dumped)
+static void coredump_finish(bool core_dumped)
 {
 	struct core_thread *curr, *next;
 	struct task_struct *task;
@@ -493,9 +428,10 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 		current->signal->group_exit_code |= 0x80;
 	current->signal->group_exit_task = NULL;
 	current->signal->flags = SIGNAL_GROUP_EXIT;
+	next = current->signal->core_state->dumper.next;
+	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
-	next = mm->core_state->dumper.next;
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -507,8 +443,6 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
 		curr->task = NULL;
 		wake_up_process(task);
 	}
-
-	mm->core_state = NULL;
 }
 
 static bool dump_interrupted(void)
@@ -839,7 +773,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 fail_unlock:
 	kfree(argv);
 	kfree(cn.corename);
-	coredump_finish(mm, core_dumped);
+	coredump_finish(core_dumped);
 	revert_creds(old_cred);
 fail_creds:
 	put_cred(cred);
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..520c51be1e57 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -408,9 +408,9 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 		   cpumask_pr_args(&task->cpus_mask));
 }
 
-static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
+static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
 {
-	seq_put_decimal_ull(m, "CoreDumping:\t", !!mm->core_state);
+	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
 	seq_putc(m, '\n');
 }
 
@@ -436,7 +436,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 
 	if (mm) {
 		task_mem(m, mm);
-		task_core_dumping(m, mm);
+		task_core_dumping(m, task);
 		task_thp_status(m, mm);
 		mmput(mm);
 	}
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..1039f6ae922c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,17 +387,6 @@ struct vm_area_struct {
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
 
-struct core_thread {
-	struct task_struct *task;
-	struct core_thread *next;
-};
-
-struct core_state {
-	atomic_t nr_threads;
-	struct core_thread dumper;
-	struct completion startup;
-};
-
 struct kioctx_table;
 struct mm_struct {
 	struct {
@@ -518,8 +507,6 @@ struct mm_struct {
 
 		unsigned long flags; /* Must use atomic bitops to access */
 
-		struct core_state *core_state; /* coredumping support */
-
 #ifdef CONFIG_AIO
 		spinlock_t			ioctx_lock;
 		struct kioctx_table __rcu	*ioctx_table;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e5f4ce622ee6..a8fe2a593a3a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -72,6 +72,17 @@ struct multiprocess_signals {
 	struct hlist_node node;
 };
 
+struct core_thread {
+	struct task_struct *task;
+	struct core_thread *next;
+};
+
+struct core_state {
+	atomic_t nr_threads;
+	struct core_thread dumper;
+	struct completion startup;
+};
+
 /*
  * NOTE! "signal_struct" does not have its own
  * locking, because a shared signal_struct always
@@ -110,6 +121,8 @@ struct signal_struct {
 	int			group_stop_count;
 	unsigned int		flags; /* see SIGNAL_* flags below */
 
+	struct core_state *core_state; /* coredumping support */
+
 	/*
 	 * PR_SET_CHILD_SUBREAPER marks a process, like a service
 	 * manager, to re-parent orphan (double-forking) child processes
diff --git a/kernel/exit.c b/kernel/exit.c
index 774e6b5061b8..2b355e926c13 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -342,23 +342,18 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 static void coredump_task_exit(struct task_struct *tsk)
 {
 	struct core_state *core_state;
-	struct mm_struct *mm;
-
-	mm = tsk->mm;
-	if (!mm)
-		return;
 
 	/*
 	 * Serialize with any possible pending coredump.
-	 * We must hold mmap_lock around checking core_state
+	 * We must hold siglock around checking core_state
 	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
 	 * will increment ->nr_threads for each thread in the
 	 * group without PF_POSTCOREDUMP set.
 	 */
-	mmap_read_lock(mm);
+	spin_lock_irq(&tsk->sighand->siglock);
 	tsk->flags |= PF_POSTCOREDUMP;
-	core_state = mm->core_state;
-	mmap_read_unlock(mm);
+	core_state = tsk->signal->core_state;
+	spin_unlock_irq(&tsk->sighand->siglock);
 	if (core_state) {
 		struct core_thread self;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 9bd9f2da9e41..c8adb76982f7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1044,7 +1044,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
-	mm->core_state = NULL;
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
-- 
2.20.1

