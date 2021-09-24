Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76168417B58
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbhIXS5m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbhIXS5h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 14:57:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD76C061613
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 11:56:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m21so10660839pgu.13
        for <linux-api@vger.kernel.org>; Fri, 24 Sep 2021 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NGoW/Pauk57xfcR+YHAaw7k6fzsKu4UrCFosKDZQNhc=;
        b=jsHCR5rFzTcloSpo/nmpIFZpciSorWh4Y+oVGCvzGVncHgEBO/G44pcvRIwJrshFKW
         VjoSHczn2EvtVLXEP8/pEhu/4ZtVKH9YvuBvdrRUqQEyhPp318CJtE9qHIy6oo1wiUs9
         gOr5NSF1RSLgoKQhy1gViChfBGi54MpUO+B/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NGoW/Pauk57xfcR+YHAaw7k6fzsKu4UrCFosKDZQNhc=;
        b=abQYWcLXg5frilOnW4m1c68jt87w+IJrkhbNMHOM1/Cnh/U7Ku2yR00TLk5PIJ53l4
         8lc8Y0ncrLhYVxt3OkAgW/4m7HxYzSdUGxUoHDDZgVakkhF/x7yzWbJxckqs8ieRPs3E
         319lkyJuCVBfkQohN0vhjgfUnd4JquWvciJU9bf930ZqyH/GDSJofgZTaeGFiJdJ0S7G
         +wo1h8Uh45+xdH0z2uhxGGrO7ZGRz4PsCp2bC++4kydV5Q13c+RxVKQQ3kzUOkSV0n5q
         7BSnsKRKItBBd1HkpcDZHRBDFdxrSleDx0JDFa4s7qfPFr8lVlm/smAEgBVcGBIHCbC+
         Heag==
X-Gm-Message-State: AOAM533oNG2EduSYbG355mKfHilWcIwIwkWwKhf1w1mVGKY0VirC/Wi2
        Uaj717U32SUsXJZ3AV2S8sdpZw==
X-Google-Smtp-Source: ABdhPJyqUfeL746hH0cL1FYdt51gjGj7+Ui07J5qNrocIp8zuNCXfJ5ku/NGqVYCGF2G6hP7AMg8FQ==
X-Received: by 2002:a65:40c4:: with SMTP id u4mr5120061pgp.186.1632509761981;
        Fri, 24 Sep 2021 11:56:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x19sm9522763pfn.105.2021.09.24.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 11:56:01 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:56:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 6/6] coredump: Limit coredumps to a single thread group
Message-ID: <202109241154.A915C488E2@keescook>
References: <87v92qx2c6.fsf@disp2133>
 <87y27mvnke.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y27mvnke.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 23, 2021 at 07:12:33PM -0500, Eric W. Biederman wrote:
> 
> Today when a signal is delivered with a handler of SIG_DFL whose
> default behavior is to generate a core dump not only that process but
> every process that shares the mm is killed.
> 
> In the case of vfork this looks like a real world problem.  Consider
> the following well defined sequence.
> 
> 	if (vfork() == 0) {
> 		execve(...);
> 		_exit(EXIT_FAILURE);
> 	}
> 
> If a signal that generates a core dump is received after vfork but
> before the execve changes the mm the process that called vfork will
> also be killed (as the mm is shared).
> 
> Similarly if the execve fails after the point of no return the kernel
> delivers SIGSEGV which will kill both the exec'ing process and because
> the mm is shared the process that called vfork as well.
> 
> As far as I can tell this behavior is a violation of people's
> reasonable expectations, POSIX, and is unnecessarily fragile when the
> system is low on memory.
> 
> Solve this by making a userspace visible change to only kill a single
> process/thread group.  This is possible because Jann Horn recently
> modified[1] the coredump code so that the mm can safely be modified
> while the coredump is happening.  With LinuxThreads long gone I don't
> expect anyone to have a notice this behavior change in practice.
> 
> To accomplish this move the core_state pointer from mm_struct to
> signal_struct, which allows different thread groups to coredump
> simultatenously.
> 
> In zap_threads remove the work to kill anything except for the current
> thread group.
> 
> [1] a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
> Fixes: d89f3847def4 ("[PATCH] thread-aware coredumps, 2.5.43-C3")
> History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

This looks correct to me, but depends on the 5/6 not introducing any
races. So, to that end:

Reviewed-by: Kees Cook <keescook@chromium.org>

If you have some local tools you've been using for testing this series,
can you toss them into tools/testing/selftests/ptrace/ ? I can help
clean them up if want.

-Kees

> ---
>  fs/binfmt_elf.c              |  4 +-
>  fs/binfmt_elf_fdpic.c        |  2 +-
>  fs/coredump.c                | 84 ++++--------------------------------
>  fs/proc/array.c              |  6 +--
>  include/linux/mm_types.h     | 13 ------
>  include/linux/sched/signal.h | 13 ++++++
>  kernel/exit.c                | 13 ++----
>  kernel/fork.c                |  1 -
>  8 files changed, 32 insertions(+), 104 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 69d900a8473d..796e5327ee7d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1834,7 +1834,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  	/*
>  	 * Allocate a structure for each thread.
>  	 */
> -	for (ct = &dump_task->mm->core_state->dumper; ct; ct = ct->next) {
> +	for (ct = &dump_task->signal->core_state->dumper; ct; ct = ct->next) {
>  		t = kzalloc(offsetof(struct elf_thread_core_info,
>  				     notes[info->thread_notes]),
>  			    GFP_KERNEL);
> @@ -2024,7 +2024,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  	if (!elf_note_info_init(info))
>  		return 0;
>  
> -	for (ct = current->mm->core_state->dumper.next;
> +	for (ct = current->signal->core_state->dumper.next;
>  					ct; ct = ct->next) {
>  		ets = kzalloc(sizeof(*ets), GFP_KERNEL);
>  		if (!ets)
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 6d8fd6030cbb..c6f588dc4a9d 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1494,7 +1494,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>  	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, &vma_data_size))
>  		goto end_coredump;
>  
> -	for (ct = current->mm->core_state->dumper.next;
> +	for (ct = current->signal->core_state->dumper.next;
>  					ct; ct = ct->next) {
>  		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
>  					     ct->task, &thread_status_size);
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d576287fb88b..a6b3c196cdef 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -369,99 +369,34 @@ static int zap_process(struct task_struct *start, int exit_code, int flags)
>  	return nr;
>  }
>  
> -static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
> +static int zap_threads(struct task_struct *tsk,
>  			struct core_state *core_state, int exit_code)
>  {
> -	struct task_struct *g, *p;
> -	unsigned long flags;
>  	int nr = -EAGAIN;
>  
>  	spin_lock_irq(&tsk->sighand->siglock);
>  	if (!signal_group_exit(tsk->signal)) {
> -		mm->core_state = core_state;
> +		tsk->signal->core_state = core_state;
>  		tsk->signal->group_exit_task = tsk;
>  		nr = zap_process(tsk, exit_code, 0);
>  		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
> +		tsk->flags |= PF_DUMPCORE;
> +		atomic_set(&core_state->nr_threads, nr);
>  	}
>  	spin_unlock_irq(&tsk->sighand->siglock);
> -	if (unlikely(nr < 0))
> -		return nr;
> -
> -	tsk->flags |= PF_DUMPCORE;
> -	if (atomic_read(&mm->mm_users) == nr + 1)
> -		goto done;
> -	/*
> -	 * We should find and kill all tasks which use this mm, and we should
> -	 * count them correctly into ->nr_threads. We don't take tasklist
> -	 * lock, but this is safe wrt:
> -	 *
> -	 * fork:
> -	 *	None of sub-threads can fork after zap_process(leader). All
> -	 *	processes which were created before this point should be
> -	 *	visible to zap_threads() because copy_process() adds the new
> -	 *	process to the tail of init_task.tasks list, and lock/unlock
> -	 *	of ->siglock provides a memory barrier.
> -	 *
> -	 * do_exit:
> -	 *	The caller holds mm->mmap_lock. This means that the task which
> -	 *	uses this mm can't pass coredump_task_exit(), so it can't exit
> -	 *	or clear its ->mm.
> -	 *
> -	 * de_thread:
> -	 *	It does list_replace_rcu(&leader->tasks, &current->tasks),
> -	 *	we must see either old or new leader, this does not matter.
> -	 *	However, it can change p->sighand, so lock_task_sighand(p)
> -	 *	must be used. Since p->mm != NULL and we hold ->mmap_lock
> -	 *	it can't fail.
> -	 *
> -	 *	Note also that "g" can be the old leader with ->mm == NULL
> -	 *	and already unhashed and thus removed from ->thread_group.
> -	 *	This is OK, __unhash_process()->list_del_rcu() does not
> -	 *	clear the ->next pointer, we will find the new leader via
> -	 *	next_thread().
> -	 */
> -	rcu_read_lock();
> -	for_each_process(g) {
> -		if (g == tsk->group_leader)
> -			continue;
> -		if (g->flags & PF_KTHREAD)
> -			continue;
> -
> -		for_each_thread(g, p) {
> -			if (unlikely(!p->mm))
> -				continue;
> -			if (unlikely(p->mm == mm)) {
> -				lock_task_sighand(p, &flags);
> -				nr += zap_process(p, exit_code,
> -							SIGNAL_GROUP_EXIT);
> -				unlock_task_sighand(p, &flags);
> -			}
> -			break;
> -		}
> -	}
> -	rcu_read_unlock();
> -done:
> -	atomic_set(&core_state->nr_threads, nr);
>  	return nr;
>  }
>  
>  static int coredump_wait(int exit_code, struct core_state *core_state)
>  {
>  	struct task_struct *tsk = current;
> -	struct mm_struct *mm = tsk->mm;
>  	int core_waiters = -EBUSY;
>  
>  	init_completion(&core_state->startup);
>  	core_state->dumper.task = tsk;
>  	core_state->dumper.next = NULL;
>  
> -	if (mmap_write_lock_killable(mm))
> -		return -EINTR;
> -
> -	if (!mm->core_state)
> -		core_waiters = zap_threads(tsk, mm, core_state, exit_code);
> -	mmap_write_unlock(mm);
> -
> +	core_waiters = zap_threads(tsk, core_state, exit_code);
>  	if (core_waiters > 0) {
>  		struct core_thread *ptr;
>  
> @@ -483,7 +418,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  	return core_waiters;
>  }
>  
> -static void coredump_finish(struct mm_struct *mm, bool core_dumped)
> +static void coredump_finish(bool core_dumped)
>  {
>  	struct core_thread *curr, *next;
>  	struct task_struct *task;
> @@ -493,9 +428,10 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>  		current->signal->group_exit_code |= 0x80;
>  	current->signal->group_exit_task = NULL;
>  	current->signal->flags = SIGNAL_GROUP_EXIT;
> +	next = current->signal->core_state->dumper.next;
> +	current->signal->core_state = NULL;
>  	spin_unlock_irq(&current->sighand->siglock);
>  
> -	next = mm->core_state->dumper.next;
>  	while ((curr = next) != NULL) {
>  		next = curr->next;
>  		task = curr->task;
> @@ -507,8 +443,6 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>  		curr->task = NULL;
>  		wake_up_process(task);
>  	}
> -
> -	mm->core_state = NULL;
>  }
>  
>  static bool dump_interrupted(void)
> @@ -839,7 +773,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  fail_unlock:
>  	kfree(argv);
>  	kfree(cn.corename);
> -	coredump_finish(mm, core_dumped);
> +	coredump_finish(core_dumped);
>  	revert_creds(old_cred);
>  fail_creds:
>  	put_cred(cred);
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 49be8c8ef555..520c51be1e57 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -408,9 +408,9 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
>  		   cpumask_pr_args(&task->cpus_mask));
>  }
>  
> -static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
> +static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
>  {
> -	seq_put_decimal_ull(m, "CoreDumping:\t", !!mm->core_state);
> +	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
>  	seq_putc(m, '\n');
>  }
>  
> @@ -436,7 +436,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  
>  	if (mm) {
>  		task_mem(m, mm);
> -		task_core_dumping(m, mm);
> +		task_core_dumping(m, task);
>  		task_thp_status(m, mm);
>  		mmput(mm);
>  	}
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7f8ee09c711f..1039f6ae922c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -387,17 +387,6 @@ struct vm_area_struct {
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>  } __randomize_layout;
>  
> -struct core_thread {
> -	struct task_struct *task;
> -	struct core_thread *next;
> -};
> -
> -struct core_state {
> -	atomic_t nr_threads;
> -	struct core_thread dumper;
> -	struct completion startup;
> -};
> -
>  struct kioctx_table;
>  struct mm_struct {
>  	struct {
> @@ -518,8 +507,6 @@ struct mm_struct {
>  
>  		unsigned long flags; /* Must use atomic bitops to access */
>  
> -		struct core_state *core_state; /* coredumping support */
> -
>  #ifdef CONFIG_AIO
>  		spinlock_t			ioctx_lock;
>  		struct kioctx_table __rcu	*ioctx_table;
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index e5f4ce622ee6..a8fe2a593a3a 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -72,6 +72,17 @@ struct multiprocess_signals {
>  	struct hlist_node node;
>  };
>  
> +struct core_thread {
> +	struct task_struct *task;
> +	struct core_thread *next;
> +};
> +
> +struct core_state {
> +	atomic_t nr_threads;
> +	struct core_thread dumper;
> +	struct completion startup;
> +};
> +
>  /*
>   * NOTE! "signal_struct" does not have its own
>   * locking, because a shared signal_struct always
> @@ -110,6 +121,8 @@ struct signal_struct {
>  	int			group_stop_count;
>  	unsigned int		flags; /* see SIGNAL_* flags below */
>  
> +	struct core_state *core_state; /* coredumping support */
> +
>  	/*
>  	 * PR_SET_CHILD_SUBREAPER marks a process, like a service
>  	 * manager, to re-parent orphan (double-forking) child processes
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 774e6b5061b8..2b355e926c13 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -342,23 +342,18 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
>  static void coredump_task_exit(struct task_struct *tsk)
>  {
>  	struct core_state *core_state;
> -	struct mm_struct *mm;
> -
> -	mm = tsk->mm;
> -	if (!mm)
> -		return;
>  
>  	/*
>  	 * Serialize with any possible pending coredump.
> -	 * We must hold mmap_lock around checking core_state
> +	 * We must hold siglock around checking core_state
>  	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
>  	 * will increment ->nr_threads for each thread in the
>  	 * group without PF_POSTCOREDUMP set.
>  	 */
> -	mmap_read_lock(mm);
> +	spin_lock_irq(&tsk->sighand->siglock);
>  	tsk->flags |= PF_POSTCOREDUMP;
> -	core_state = mm->core_state;
> -	mmap_read_unlock(mm);
> +	core_state = tsk->signal->core_state;
> +	spin_unlock_irq(&tsk->sighand->siglock);
>  	if (core_state) {
>  		struct core_thread self;
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9bd9f2da9e41..c8adb76982f7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1044,7 +1044,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	seqcount_init(&mm->write_protect_seq);
>  	mmap_init_lock(mm);
>  	INIT_LIST_HEAD(&mm->mmlist);
> -	mm->core_state = NULL;
>  	mm_pgtables_bytes_init(mm);
>  	mm->map_count = 0;
>  	mm->locked_vm = 0;
> -- 
> 2.20.1
> 

-- 
Kees Cook
