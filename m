Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4A45F307
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhKZRfn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 12:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237239AbhKZRdn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 12:33:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5DBC061395;
        Fri, 26 Nov 2021 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h3+KdbEwLkw21ebqbXuOFR9l+Vqgj6iW4M95SNDWufg=; b=UbFzk2nwewthjFShcCS1ykFGNX
        9TQYmUeeuIo/58AJSx+mdGwZqP+kU8y9l9arGmcPO0n56RMbSLlZDAbsPm9PIK+azm2gNnoIif4i1
        q/I03WRVLT1v/Q97qu3LbUj5o+aEvfTPb8MmIECNWipMbPCgoaZmcbFAtQGvB+0vk0aqIvq6hZC4F
        2UoZyCDLPrIA/PgpM1ubBDJ7l6FRYhmtY3dhsyNyClOwJrTabDNv7N0pfYPfuiFti/JPvnUZzblds
        a/scKGgX4AcdWLXyQOCx0Pojij+awqzkEo8PxPOOSOr++ogxYDj9eDun+WPvDUfMEtYdkg0LHdHzv
        pj864OqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqeil-00BQVW-Uq; Fri, 26 Nov 2021 17:09:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E47B630001C;
        Fri, 26 Nov 2021 18:09:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6C5A2D1EBB69; Fri, 26 Nov 2021 18:09:10 +0100 (CET)
Date:   Fri, 26 Nov 2021 18:09:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 25, 2021 at 09:28:49AM -0800, Peter Oskolkov wrote:

> it looks like the overall approach did not raise many objections - is
> it so? Have you finished reviewing the patch?

I've been trying to make sense of it, and while doing so deleted a bunch
of things and rewrote the rest.

Things that went *poof*:

 - wait_wake_only
 - server_tid_ptr (now: server_tid)
 - state_ts (now: state,blocked_ts,runnable_ts)

I've also changed next_tid to only be used as a context switch target,
never to find the server to enqueue the runnable tasks on.

All xchg() users seem to have disappeared.

Signals should now be handled, after which it'll go back to waiting on
RUNNING.

The code could fairly easily be changed to work on 32bit, big-endian is
the tricky bit, for now 64bit only.

Anyway, I only *think* the below code will work (it compiles with gcc-10
and gcc-11) but I've not yet come around to writing/updating the
userspace part, so it might explode on first contact -- I'll try that
next week if you don't beat me to it.

That said, the below code seems somewhat sensible to me (I would say,
having written it :), but I'm fairly sure I killed some capabilities the
other thing had (notably the first two items above).

If you want either of them restored, can you please give a use-case for
them? Because I cannot seem to think of any sane cases for either
wait_wake_only or server_tid_ptr.

Anyway, in large order it's very like what you did, but it's different
in pretty much all details.

Of note, it now has 5 hooks: sys_enter, pre-schedule, post-schedule
(still nop), sys_exit and notify_resume.

---
Subject: sched: User Mode Concurency Groups
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 26 17:24:27 CET 2021

XXX split and changelog

Originally-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -248,6 +248,7 @@ config X86
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UMCG			if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -371,6 +371,8 @@
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
+450	common	umcg_ctl		sys_umcg_ctl
+451	common	umcg_wait		sys_umcg_wait
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_UMCG		6	/* UMCG return to user hook */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -107,6 +108,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_UMCG		(1 << TIF_UMCG)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -341,6 +341,24 @@ do {									\
 		     : [umem] "m" (__m(addr))				\
 		     : : label)
 
+#define __try_cmpxchg_user_asm(itype, _ptr, _pold, _new, label)	({	\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm_volatile_goto("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : CC_OUT(z) (success),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] "r" (__new)				\
+		     : "memory", "cc"					\
+		     : label);						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #ifdef CONFIG_X86_32
@@ -411,6 +429,34 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       [efault] "i" (-EFAULT), "0" (err))
 
+#define __try_cmpxchg_user_asm(itype, _ptr, _pold, _new, label)	({	\
+	int __err = 0;							\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
+		     CC_SET(z)						\
+		     "2:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "3:	mov %[efault], %[errout]\n"		\
+		     "		jmp 2b\n"				\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     : CC_OUT(z) (success),				\
+		       [errout] "+r" (__err),				\
+		       [ptr] "+m" (*_ptr),				\
+		       [old] "+a" (__old)				\
+		     : [new] "r" (__new),				\
+		       [efault] "i" (-EFAULT)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);					})
+
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /* FIXME: this hack is definitely wrong -AK */
@@ -505,6 +551,21 @@ do {										\
 } while (0)
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+
+#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
+	__typeof__(*(_ptr)) __ret;					\
+	switch (sizeof(__ret)) {					\
+	case 4:	__ret = __try_cmpxchg_user_asm("l", (_ptr), (_oldp),	\
+					       (_nval), _label);	\
+		break;							\
+	case 8:	__ret = __try_cmpxchg_user_asm("q", (_ptr), (_oldp),	\
+					       (_nval), _label);	\
+		break;							\
+	default: __try_cmpxchg_user_wrong_size();			\
+	}								\
+	__ret;						})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1838,6 +1838,7 @@ static int bprm_execve(struct linux_binp
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	umcg_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -22,6 +22,10 @@
 # define _TIF_UPROBE			(0)
 #endif
 
+#ifndef _TIF_UMCG
+# define _TIF_UMCG			(0)
+#endif
+
 /*
  * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
  */
@@ -42,11 +46,13 @@
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_UMCG |		\
 				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_UMCG |		\
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -67,6 +67,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct umcg_task;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1294,6 +1295,15 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_UMCG
+	clockid_t		umcg_clock;
+	struct umcg_task __user	*umcg_task;
+	struct page		*umcg_worker_page;
+	struct task_struct	*umcg_server;
+	struct umcg_task __user *umcg_server_task;
+	struct page		*umcg_server_page;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
@@ -1687,6 +1697,13 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+
+#ifdef CONFIG_UMCG
+#define PF_UMCG_WORKER		0x01000000	/* UMCG worker */
+#else
+#define PF_UMCG_WORKER		0x00000000
+#endif
+
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
@@ -2285,6 +2302,67 @@ static inline void rseq_execve(struct ta
 {
 }
 
+#endif
+
+#ifdef CONFIG_UMCG
+
+extern void umcg_sys_enter(struct pt_regs *regs, long syscall);
+extern void umcg_sys_exit(struct pt_regs *regs);
+extern void umcg_notify_resume(struct pt_regs *regs);
+extern void umcg_worker_exit(void);
+extern void umcg_clear_child(struct task_struct *tsk);
+
+/* Called by bprm_execve() in fs/exec.c. */
+static inline void umcg_execve(struct task_struct *tsk)
+{
+	if (tsk->umcg_task)
+		umcg_clear_child(tsk);
+}
+
+/* Called by do_exit() in kernel/exit.c. */
+static inline void umcg_handle_exit(void)
+{
+	if (current->flags & PF_UMCG_WORKER)
+		umcg_worker_exit();
+}
+
+/*
+ * umcg_wq_worker_[sleeping|running] are called in core.c by
+ * sched_submit_work() and sched_update_worker().
+ */
+extern void umcg_wq_worker_sleeping(struct task_struct *tsk);
+extern void umcg_wq_worker_running(struct task_struct *tsk);
+
+#else  /* CONFIG_UMCG */
+
+static inline void umcg_sys_enter(struct pt_regs *regs, long syscall)
+{
+}
+
+static inline void umcg_sys_exit(struct pt_regs *regs)
+{
+}
+
+static inline void umcg_notify_resume(struct pt_regs *regs)
+{
+}
+
+static inline void umcg_clear_child(struct task_struct *tsk)
+{
+}
+static inline void umcg_execve(struct task_struct *tsk)
+{
+}
+static inline void umcg_handle_exit(void)
+{
+}
+static inline void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+}
+static inline void umcg_wq_worker_running(struct task_struct *tsk)
+{
+}
+
 #endif
 
 #ifdef CONFIG_DEBUG_RSEQ
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -72,6 +72,7 @@ struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
 enum landlock_rule_type;
+struct umcg_task;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1057,6 +1058,8 @@ asmlinkage long sys_landlock_add_rule(in
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
+asmlinkage long sys_umcg_ctl(u32 flags, struct umcg_task __user *self, clockid_t which_clock);
+asmlinkage long sys_umcg_wait(u32 flags, u64 abs_timeout);
 
 /*
  * Architecture-specific system calls
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -46,6 +46,7 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
+	SYSCALL_WORK_BIT_SYSCALL_UMCG,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
@@ -55,6 +56,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
 #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
 #define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
+#define SYSCALL_WORK_SYSCALL_UMCG	BIT(SYSCALL_WORK_BIT_SYSCALL_UMCG)
 #endif
 
 #include <asm/thread_info.h>
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -883,8 +883,13 @@ __SYSCALL(__NR_process_mrelease, sys_pro
 #define __NR_futex_waitv 449
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 
+#define __NR_umcg_ctl 450
+__SYSCALL(__NR_umcg_ctl, sys_umcg_ctl)
+#define __NR_umcg_wait 451
+__SYSCALL(__NR_umcg_wait, sys_umcg_wait)
 #undef __NR_syscalls
-#define __NR_syscalls 450
+
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UMCG_H
+#define _UAPI_LINUX_UMCG_H
+
+#include <linux/types.h>
+
+/*
+ * UMCG: User Managed Concurrency Groups.
+ *
+ * Syscalls (see kernel/sched/umcg.c):
+ *      sys_umcg_ctl()  - register/unregister UMCG tasks;
+ *      sys_umcg_wait() - wait/wake/context-switch.
+ *
+ * struct umcg_task (below): controls the state of UMCG tasks.
+ */
+
+/*
+ * UMCG task states, the first 6 bits of struct umcg_task.state_ts.
+ * The states represent the user space point of view.
+ *
+ *   ,--------(TF_PREEMPT + notify_resume)-------. ,------------.
+ *   |                                           v |            |
+ * RUNNING -(schedule)-> BLOCKED -(sys_exit)-> RUNNABLE  (signal + notify_resume)
+ *   ^                                           | ^            |
+ *   `--------------(sys_umcg_wait)--------------' `------------'
+ *
+ */
+#define UMCG_TASK_NONE			0x0000U
+#define UMCG_TASK_RUNNING		0x0001U
+#define UMCG_TASK_RUNNABLE		0x0002U
+#define UMCG_TASK_BLOCKED		0x0003U
+
+#define UMCG_TASK_MASK			0x00ffU
+
+/*
+ * UMCG_TF_PREEMPT: userspace indicates the worker should be preempted.
+ *
+ * Must only be set on UMCG_TASK_RUNNING; once set, any subsequent
+ * return-to-user (eg signal) will perform the equivalent of sys_umcg_wait() on
+ * it. That is, it will wake next_tid/server_tid, transfer to RUNNABLE and
+ * enqueue on the server's runnable list.
+ *
+ */
+#define UMCG_TF_PREEMPT			0x0100U
+
+#define UMCG_TF_MASK			0xff00U
+
+#define UMCG_TASK_ALIGN			64
+
+/**
+ * struct umcg_task - controls the state of UMCG tasks.
+ *
+ * The struct is aligned at 64 bytes to ensure that it fits into
+ * a single cache line.
+ */
+struct umcg_task {
+	/**
+	 * @state_ts: the current state of the UMCG task described by
+	 *            this struct, with a unique timestamp indicating
+	 *            when the last state change happened.
+	 *
+	 * Readable/writable by both the kernel and the userspace.
+	 *
+	 * UMCG task state:
+	 *   bits  0 -  7: task state;
+	 *   bits  8 - 15: state flags;
+	 *   bits 16 - 31: for userspace use;
+	 */
+	__u32	state;				/* r/w */
+
+	/**
+	 * @next_tid: the TID of the UMCG task that should be context-switched
+	 *            into in sys_umcg_wait(). Can be zero, in which case
+	 *            it'll switch to server_tid.
+	 *
+	 * @server_tid: the TID of the UMCG server that hosts this task,
+	 *		when RUNNABLE this task will get added to it's
+	 *		runnable_workers_ptr list.
+	 *
+	 * Read-only for the kernel, read/write for the userspace.
+	 */
+	__u32	next_tid;			/* r   */
+	__u32	server_tid;			/* r   */
+
+	__u32	__hole[1];
+
+	/*
+	 * Timestamps for when last we became BLOCKED, RUNNABLE, in CLOCK_MONOTONIC.
+	 */
+	__u64	blocked_ts;			/*   w */
+	__u64   runnable_ts;			/*   w */
+
+	/**
+	 * @runnable_workers_ptr: a single-linked list of runnable workers.
+	 *
+	 * Readable/writable by both the kernel and the userspace: the
+	 * kernel adds items to the list, userspace removes them.
+	 */
+	__u64	runnable_workers_ptr;		/* r/w */
+
+	__u64	__zero[3];
+
+} __attribute__((packed, aligned(UMCG_TASK_ALIGN)));
+
+/**
+ * enum umcg_ctl_flag - flags to pass to sys_umcg_ctl
+ * @UMCG_CTL_REGISTER:   register the current task as a UMCG task
+ * @UMCG_CTL_UNREGISTER: unregister the current task as a UMCG task
+ * @UMCG_CTL_WORKER:     register the current task as a UMCG worker
+ */
+enum umcg_ctl_flag {
+	UMCG_CTL_REGISTER	= 0x00001,
+	UMCG_CTL_UNREGISTER	= 0x00002,
+	UMCG_CTL_WORKER		= 0x10000,
+};
+
+#endif /* _UAPI_LINUX_UMCG_H */
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1693,6 +1693,21 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config HAVE_UMCG
+	bool
+
+config UMCG
+	bool "Enable User Managed Concurrency Groups API"
+	depends on 64BIT
+	depends on GENERIC_ENTRY
+	depends on HAVE_UMCG
+	default n
+	help
+	  Enable User Managed Concurrency Groups API, which form the basis
+	  for an in-process M:N userspace scheduling framework.
+	  At the moment this is an experimental/RFC feature that is not
+	  guaranteed to be backward-compatible.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/sched.h>
 
 #include "common.h"
 
@@ -76,6 +77,9 @@ static long syscall_trace_enter(struct p
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
+	if (work & SYSCALL_WORK_SYSCALL_UMCG)
+		umcg_sys_enter(regs, syscall);
+
 	syscall_enter_audit(regs, syscall);
 
 	return ret ? : syscall;
@@ -155,8 +159,7 @@ static unsigned long exit_to_user_mode_l
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
 	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
-
+	do {
 		local_irq_enable_exit_to_user(ti_work);
 
 		if (ti_work & _TIF_NEED_RESCHED)
@@ -168,6 +171,10 @@ static unsigned long exit_to_user_mode_l
 		if (ti_work & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
+		/* must be before handle_signal_work(); terminates on sigpending */
+		if (ti_work & _TIF_UMCG)
+			umcg_notify_resume(regs);
+
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			handle_signal_work(regs, ti_work);
 
@@ -188,7 +195,7 @@ static unsigned long exit_to_user_mode_l
 		tick_nohz_user_enter_prepare();
 
 		ti_work = READ_ONCE(current_thread_info()->flags);
-	}
+	} while (ti_work & EXIT_TO_USER_MODE_WORK);
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
 	return ti_work;
@@ -203,7 +210,7 @@ static void exit_to_user_mode_prepare(st
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
 
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+	if (unlikely(ti_work & (EXIT_TO_USER_MODE_WORK | _TIF_UMCG)))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
@@ -253,6 +260,9 @@ static void syscall_exit_work(struct pt_
 	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
+
+	if (work & SYSCALL_WORK_SYSCALL_UMCG)
+		umcg_sys_exit(regs);
 }
 
 /*
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -749,6 +749,10 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
 
+	/* Turn off UMCG sched hooks. */
+	if (unlikely(tsk->flags & PF_UMCG_WORKER))
+		tsk->flags &= ~PF_UMCG_WORKER;
+
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
@@ -786,6 +790,7 @@ void __noreturn do_exit(long code)
 
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
+	umcg_handle_exit();
 
 	/* sync mm's RSS info before statistics gathering */
 	if (tsk->mm)
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
 obj-$(CONFIG_SCHED_CORE) += core_sched.o
+obj-$(CONFIG_UMCG) += umcg.o
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3977,8 +3977,7 @@ bool ttwu_state_match(struct task_struct
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
@@ -4270,6 +4269,7 @@ static void __sched_fork(unsigned long c
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+	umcg_clear_child(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -6328,9 +6328,11 @@ static inline void sched_submit_work(str
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
+		else if (task_flags & PF_UMCG_WORKER)
+			umcg_wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
 	}
@@ -6348,9 +6350,11 @@ static inline void sched_submit_work(str
 
 static void sched_update_worker(struct task_struct *tsk)
 {
-	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_UMCG_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
+		else if (tsk->flags & PF_UMCG_WORKER)
+			umcg_wq_worker_running(tsk);
 		else
 			io_wq_worker_running(tsk);
 	}
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6890,6 +6890,10 @@ select_task_rq_fair(struct task_struct *
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
+		if ((wake_flags & WF_CURRENT_CPU) &&
+		    cpumask_test_cpu(cpu, p->cpus_ptr))
+			return cpu;
+
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2052,13 +2052,14 @@ static inline int task_on_rq_migrating(s
 }
 
 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
-
-#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU       0x40 /* Wakee is on_cpu */
+#define WF_CURRENT_CPU  0x80 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3076,6 +3077,8 @@ static inline bool is_per_cpu_kthread(st
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ *
+ */
+
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/umcg.h>
+
+#include <asm/syscall.h>
+
+#include "sched.h"
+
+static struct task_struct *umcg_get_task(u32 tid)
+{
+	struct task_struct *tsk = NULL;
+
+	if (tid) {
+		rcu_read_lock();
+		tsk = find_task_by_vpid(tid);
+		if (tsk && current->mm == tsk->mm && tsk->umcg_task)
+			get_task_struct(tsk);
+		else
+			tsk = NULL;
+		rcu_read_unlock();
+	}
+
+	return tsk;
+}
+
+/**
+ * umcg_pin_pages: pin pages containing struct umcg_task of this worker
+ *                 and its server.
+ */
+static int umcg_pin_pages(void)
+{
+	struct task_struct *server = NULL, *tsk = current;
+	struct umcg_task __user *self = tsk->umcg_task;
+	int server_tid;
+
+	if (tsk->umcg_worker_page ||
+	    tsk->umcg_server_page ||
+	    tsk->umcg_server_task ||
+	    tsk->umcg_server)
+		return -EBUSY;
+
+	if (get_user(server_tid, &self->server_tid))
+		return -EFAULT;
+
+	server = umcg_get_task(server_tid);
+	if (!server)
+		return -EINVAL;
+
+	if (pin_user_pages_fast((unsigned long)self, 1, 0,
+				&tsk->umcg_worker_page) != 1)
+		goto clear_self;
+
+	/* must cache due to possible concurrent change vs access_ok() */
+	tsk->umcg_server_task = server->umcg_task;
+	if (pin_user_pages_fast((unsigned long)tsk->umcg_server_task, 1, 0,
+				&tsk->umcg_server_page) != 1)
+		goto clear_server;
+
+	tsk->umcg_server = server;
+
+	return 0;
+
+clear_server:
+	tsk->umcg_server_task = NULL;
+	tsk->umcg_server_page = NULL;
+
+	unpin_user_page(tsk->umcg_worker_page);
+clear_self:
+	tsk->umcg_worker_page = NULL;
+	put_task_struct(server);
+
+	return -EFAULT;
+}
+
+static void umcg_unpin_pages(void)
+{
+	struct task_struct *tsk = current;
+
+	if (tsk->umcg_server) {
+		unpin_user_page(tsk->umcg_worker_page);
+		tsk->umcg_worker_page = NULL;
+
+		unpin_user_page(tsk->umcg_server_page);
+		tsk->umcg_server_page = NULL;
+		tsk->umcg_server_task = NULL;
+
+		put_task_struct(tsk->umcg_server);
+		tsk->umcg_server = NULL;
+	}
+}
+
+static void umcg_clear_task(struct task_struct *tsk)
+{
+	/*
+	 * This is either called for the current task, or for a newly forked
+	 * task that is not yet running, so we don't need strict atomicity
+	 * below.
+	 */
+	if (tsk->umcg_task) {
+		WRITE_ONCE(tsk->umcg_task, NULL);
+		tsk->umcg_server = NULL;
+
+		/* These can be simple writes - see the commment above. */
+		tsk->umcg_worker_page = NULL;
+		tsk->umcg_server_page = NULL;
+		tsk->umcg_server_task = NULL;
+
+		tsk->flags &= ~PF_UMCG_WORKER;
+		clear_task_syscall_work(tsk, SYSCALL_UMCG);
+		clear_tsk_thread_flag(tsk, TIF_UMCG);
+	}
+}
+
+/* Called for a forked or execve-ed child. */
+void umcg_clear_child(struct task_struct *tsk)
+{
+	umcg_clear_task(tsk);
+}
+
+/* Called both by normally (unregister) and abnormally exiting workers. */
+void umcg_worker_exit(void)
+{
+	umcg_unpin_pages();
+	umcg_clear_task(current);
+}
+
+/*
+ * Do a state transition, @from -> @to, and possible read @next after that.
+ *
+ * Will clear UMCG_TF_PREEMPT.
+ *
+ * When @to == {BLOCKED,RUNNABLE}, update timestamps.
+ *
+ * Returns:
+ *   0: success
+ *   -EAGAIN: when self->state != @from
+ *   -EFAULT
+ */
+static int umcg_update_state(struct task_struct *tsk, u32 from, u32 to, u32 *next)
+{
+	struct umcg_task *self = tsk->umcg_task;
+	u32 old, new;
+	u64 now;
+
+	if (to >= UMCG_TASK_RUNNABLE) {
+		switch (tsk->umcg_clock) {
+		case CLOCK_REALTIME:      now = ktime_get_real_ns();     break;
+		case CLOCK_MONOTONIC:     now = ktime_get_ns();          break;
+		case CLOCK_BOOTTIME:      now = ktime_get_boottime_ns(); break;
+		case CLOCK_TAI:           now = ktime_get_clocktai_ns(); break;
+		}
+	}
+
+	if (!user_access_begin(self, sizeof(*self)))
+		return -EFAULT;
+
+	unsafe_get_user(old, &self->state, Efault);
+	do {
+		if ((old & UMCG_TASK_MASK) != from)
+			goto fail;
+
+		new = old & ~(UMCG_TASK_MASK | UMCG_TF_PREEMPT);
+		new |= to & UMCG_TASK_MASK;
+
+	} while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
+
+	if (to == UMCG_TASK_BLOCKED)
+		unsafe_put_user(now, &self->blocked_ts, Efault);
+	if (to == UMCG_TASK_RUNNABLE)
+		unsafe_put_user(now, &self->runnable_ts, Efault);
+
+	if (next)
+		unsafe_get_user(*next, &self->next_tid, Efault);
+
+	user_access_end();
+	return 0;
+
+fail:
+	user_access_end();
+	return -EAGAIN;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/* Called from syscall enter path */
+void umcg_sys_enter(struct pt_regs *regs, long syscall)
+{
+	/* avoid recursion vs our own syscalls */
+	if (syscall == __NR_umcg_wait ||
+	    syscall == __NR_umcg_ctl)
+		return;
+
+	/* avoid recursion vs schedule() */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	if (umcg_pin_pages())
+		goto die;
+
+	current->flags |= PF_UMCG_WORKER;
+	return;
+
+die:
+	current->flags |= PF_UMCG_WORKER;
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+}
+
+static int umcg_wake_task(struct task_struct *tsk)
+{
+	int ret = umcg_update_state(tsk, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING, NULL);
+	if (ret)
+		return ret;
+
+	try_to_wake_up(tsk, TASK_NORMAL, WF_CURRENT_CPU);
+	return 0;
+}
+
+/*
+ * Wake @next_tid or server.
+ *
+ * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
+ *
+ * Returns:
+ *   0: success
+ *   -EFAULT
+ */
+static int umcg_wake_next(struct task_struct *tsk, u32 next_tid)
+{
+	struct task_struct *next = NULL;
+	int ret;
+
+	next = umcg_get_task(next_tid);
+	/*
+	 * umcg_wake_task(next) might fault; if we cannot fault, we'll eat it
+	 * and 'spuriously' not wake @next_tid but instead try and wake the
+	 * server.
+	 *
+	 * XXX: we can fix this by adding umcg_next_page to umcg_pin_pages().
+	 *
+	 * umcg_wake_task() can also fail due to next not having the right
+	 * state, then too will we try and wake the server.
+	 *
+	 * If we cannot wake the server due to state issues, too bad.
+	 */
+	if (!next || umcg_wake_task(next)) {
+		ret = umcg_wake_task(tsk->umcg_server);
+		if (ret == -EFAULT)
+			goto out;
+	}
+	ret = 0;
+out:
+	if (next)
+		put_task_struct(next);
+
+	return ret;
+}
+
+/* pre-schedule() */
+void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+	int next_tid;
+
+	/* Must not fault, mmap_sem might be held. */
+	pagefault_disable();
+
+	if (WARN_ON_ONCE(!tsk->umcg_server))
+		goto die;
+
+	if (umcg_update_state(tsk, UMCG_TASK_RUNNING, UMCG_TASK_BLOCKED, &next_tid))
+		goto die;
+
+	if (umcg_wake_next(tsk, next_tid))
+		goto die;
+
+	pagefault_enable();
+
+	/*
+	 * We're going to sleep, make sure to unpin the pages, this ensures
+	 * the pins are temporary.
+	 */
+	umcg_unpin_pages();
+
+	return;
+
+die:
+	pagefault_enable();
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+}
+
+/* post-schedule() */
+void umcg_wq_worker_running(struct task_struct *tsk)
+{
+	/* nothing here, see umcg_sys_exit() */
+}
+
+/*
+ * Enqueue @tsk on it's server's runnable list
+ *
+ * Must be called in umcg_pin_pages() context, relies on tsk->umcg_server.
+ *
+ * cmpxchg based single linked list add such that list integrity is never
+ * violated.  Userspace *MUST* remove it from the list before changing ->state.
+ * As such, we must change state to RUNNABLE before enqueue.
+ *
+ * Returns:
+ *   0: success
+ *   -EFAULT
+ */
+static int umcg_enqueue_runnable(struct task_struct *tsk)
+{
+	struct umcg_task __user *server = tsk->umcg_server_task;
+	struct umcg_task __user *self = tsk->umcg_task;
+	u64 self_ptr = (unsigned long)self;
+	u64 first_ptr;
+
+	/*
+	 * umcg_pin_pages() did access_ok() on both pointers, use self here
+	 * only because __user_access_begin() isn't available in generic code.
+	 */
+	if (!user_access_begin(self, sizeof(*self)))
+		return -EFAULT;
+
+	unsafe_get_user(first_ptr, &server->runnable_workers_ptr, Efault);
+	do {
+		unsafe_put_user(first_ptr, &self->runnable_workers_ptr, Efault);
+	} while (!unsafe_try_cmpxchg_user(&server->runnable_workers_ptr, &first_ptr, self_ptr, Efault));
+
+	user_access_end();
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/*
+ * umcg_wait: Wait for ->state to become RUNNING
+ *
+ * Returns:
+ *   0: success
+ *   -EINTR: pending signal
+ *   -EINVAL: ->state is not {RUNNABLE,RUNNING}
+ *   -ETIMEDOUT
+ *   -EFAULT
+ */
+int umcg_wait(u64 timo)
+{
+	struct task_struct *tsk = current;
+	struct umcg_task __user *self = tsk->umcg_task;
+	struct hrtimer_sleeper timeout;
+	struct page *page = NULL;
+	u32 state;
+	int ret;
+
+	if (timo) {
+		hrtimer_init_sleeper_on_stack(&timeout, tsk->umcg_clock,
+					      HRTIMER_MODE_ABS);
+		hrtimer_set_expires_range_ns(&timeout.timer, (s64)timo,
+					     tsk->timer_slack_ns);
+	}
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		ret = -EINTR;
+		if (signal_pending(current))
+			break;
+
+		/*
+		 * Faults can block and scribble our wait state.
+		 */
+		pagefault_disable();
+		if (get_user(state, &self->state)) {
+			pagefault_enable();
+
+			ret = -EFAULT;
+			if (page) {
+				unpin_user_page(page);
+				page = NULL;
+				break;
+			}
+
+			if (pin_user_pages_fast((unsigned long)self, 1, 0, &page) != 1) {
+				page = NULL;
+				break;
+			}
+
+			continue;
+		}
+
+		if (page) {
+			unpin_user_page(page);
+			page = NULL;
+		}
+		pagefault_enable();
+
+		state &= UMCG_TASK_MASK;
+		if (state != UMCG_TASK_RUNNABLE) {
+			ret = 0;
+			if (state == UMCG_TASK_RUNNING)
+				break;
+
+			ret = -EINVAL;
+			break;
+		}
+
+		if (timo)
+			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
+
+		freezable_schedule();
+
+		ret = -ETIMEDOUT;
+		if (timo && !timeout.task)
+			break;
+	}
+	__set_current_state(TASK_RUNNING);
+
+	if (timo) {
+		hrtimer_cancel(&timeout.timer);
+		destroy_hrtimer_on_stack(&timeout.timer);
+	}
+
+	return ret;
+}
+
+void umcg_sys_exit(struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	long syscall = syscall_get_nr(tsk, regs);
+
+	if (syscall == __NR_umcg_wait)
+		return;
+
+	/*
+	 * sys_umcg_ctl() will get here without having called umcg_sys_enter()
+	 * as such it will look like a syscall that blocked.
+	 */
+
+	if (tsk->umcg_server) {
+		/*
+		 * Didn't block, we done.
+		 */
+		umcg_unpin_pages();
+		return;
+	}
+
+	/* avoid recursion vs schedule() */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	if (umcg_pin_pages())
+		goto die;
+
+	if (umcg_update_state(tsk, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE, NULL))
+		goto die_unpin;
+
+	if (umcg_enqueue_runnable(tsk))
+		goto die_unpin;
+
+	/* server might not be runnable, too bad */
+	if (umcg_wake_task(tsk->umcg_server) == -EFAULT)
+		goto die_unpin;
+
+	umcg_unpin_pages();
+
+	switch (umcg_wait(0)) {
+	case -EFAULT:
+	case -EINVAL:
+	case -ETIMEDOUT: /* how!?! */
+		goto die;
+
+	case -EINTR:
+		/* notify_resume will continue the wait after the signal */
+		break;
+	default:
+		break;
+	}
+
+	current->flags |= PF_UMCG_WORKER;
+
+	return;
+
+die_unpin:
+	umcg_unpin_pages();
+die:
+	current->flags |= PF_UMCG_WORKER;
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+}
+
+void umcg_notify_resume(struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	struct umcg_task __user *self = tsk->umcg_task;
+	u32 state, next_tid;
+
+	/* avoid recursion vs schedule() */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	if (get_user(state, &self->state))
+		goto die;
+
+	state &= UMCG_TASK_MASK | UMCG_TF_MASK;
+	if (state == UMCG_TASK_RUNNING)
+		goto done;
+
+	if (state & UMCG_TF_PREEMPT) {
+		umcg_pin_pages();
+
+		if (umcg_update_state(tsk, UMCG_TASK_RUNNING,
+				      UMCG_TASK_RUNNABLE, &next_tid))
+			goto die_unpin;
+
+		if (umcg_enqueue_runnable(tsk))
+			goto die_unpin;
+
+		if (umcg_wake_next(tsk, next_tid))
+			goto die_unpin;
+
+		umcg_unpin_pages();
+	}
+
+	switch (umcg_wait(0)) {
+	case -EFAULT:
+	case -EINVAL:
+	case -ETIMEDOUT: /* how!?! */
+		goto die;
+
+	case -EINTR:
+		/* we'll will continue the wait after the signal */
+		break;
+	default:
+		break;
+	}
+
+done:
+	current->flags |= PF_UMCG_WORKER;
+	return;
+
+die_unpin:
+	umcg_unpin_pages();
+die:
+	current->flags |= PF_UMCG_WORKER;
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+}
+
+/**
+ * sys_umcg_wait: put the current task to sleep and/or wake another task.
+ * @flags:        zero or a value from enum umcg_wait_flag.
+ * @abs_timeout:  when to wake the task, in nanoseconds; zero for no timeout.
+ *
+ *
+ *
+ * Returns:
+ * 0             - OK;
+ * -ETIMEDOUT    - the timeout expired;
+ * -EFAULT       - failed accessing struct umcg_task __user of the current
+ *                 task, the server or next.
+ * -ESRCH        - the task to wake not found or not a UMCG task;
+ * -EINVAL       - another error happened (e.g. the current task is not a
+ *                 UMCG task, etc.)
+ */
+SYSCALL_DEFINE2(umcg_wait, u32, flags, u64, timo)
+{
+	struct task_struct *next, *tsk = current;
+	struct umcg_task __user *self = tsk->umcg_task;
+	bool worker = tsk->flags & PF_UMCG_WORKER;
+	u32 next_tid;
+	int ret;
+
+	if (!self || flags)
+		return -EINVAL;
+
+	if (worker)
+		tsk->flags &= ~PF_UMCG_WORKER;
+
+	/* see umcg_sys_{enter,exit}() */
+	umcg_pin_pages();
+
+	ret = umcg_update_state(tsk, UMCG_TASK_RUNNING, UMCG_TASK_RUNNABLE, &next_tid);
+	if (ret)
+		goto unpin;
+
+	next = umcg_get_task(next_tid);
+	if (!next) {
+		ret = -ESRCH;
+		goto unblock;
+	}
+
+	if (worker) {
+		ret = umcg_enqueue_runnable(tsk);
+		if (ret)
+			goto put_task;
+	}
+
+	ret = umcg_wake_task(next);
+	if (ret)
+		goto put_task;
+
+	put_task_struct(next);
+	umcg_unpin_pages();
+
+	ret = umcg_wait(timo);
+	switch (ret) {
+	case -EINTR:	/* umcg_notify_resume() will continue the wait */
+	case 0:		/* all done */
+		ret = 0;
+		break;
+
+	default:
+		/*
+		 * If this fails you get to keep the pieces; you'll get stuck
+		 * in umcg_notify_resume().
+		 */
+		umcg_update_state(tsk, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING, NULL);
+		break;
+	}
+out:
+	if (worker)
+		tsk->flags |= PF_UMCG_WORKER;
+	return ret;
+
+put_task:
+	put_task_struct(next);
+unblock:
+	umcg_update_state(tsk, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING, NULL);
+unpin:
+	umcg_unpin_pages();
+	goto out;
+}
+
+/**
+ * sys_umcg_ctl: (un)register the current task as a UMCG task.
+ * @flags:       ORed values from enum umcg_ctl_flag; see below;
+ * @self:        a pointer to struct umcg_task that describes this
+ *               task and governs the behavior of sys_umcg_wait if
+ *               registering; must be NULL if unregistering.
+ *
+ * @flags & UMCG_CTL_REGISTER: register a UMCG task:
+ *         UMCG workers:
+ *              - @flags & UMCG_CTL_WORKER
+ *              - self->state must be UMCG_TASK_BLOCKED
+ *         UMCG servers:
+ *              - !(@flags & UMCG_CTL_WORKER)
+ *              - self->state must be UMCG_TASK_RUNNING
+ *
+ *         All tasks:
+ *              - self->next_tid must be zero
+ *
+ *         If the conditions above are met, sys_umcg_ctl() immediately returns
+ *         if the registered task is a server; a worker will be added to
+ *         runnable_workers_ptr, and the worker put to sleep; an runnable server
+ *         from runnable_server_tid_ptr will be woken, if present.
+ *
+ * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
+ *           is a UMCG worker, the userspace is responsible for waking its
+ *           server (before or after calling sys_umcg_ctl).
+ *
+ * Return:
+ * 0                - success
+ * -EFAULT          - failed to read @self
+ * -EINVAL          - some other error occurred
+ */
+SYSCALL_DEFINE3(umcg_ctl, u32, flags, struct umcg_task __user *, self, clockid_t, which_clock)
+{
+	struct umcg_task ut;
+
+	if ((unsigned long)self % UMCG_TASK_ALIGN)
+		return -EINVAL;
+
+	if (flags == UMCG_CTL_UNREGISTER) {
+		if (self || !current->umcg_task)
+			return -EINVAL;
+
+		if (current->flags & PF_UMCG_WORKER)
+			umcg_worker_exit();
+		else
+			umcg_clear_task(current);
+
+		return 0;
+	}
+
+	if (!(flags & UMCG_CTL_REGISTER))
+		return -EINVAL;
+
+	switch (which_clock) {
+	case CLOCK_REALTIME:
+	case CLOCK_MONOTONIC:
+	case CLOCK_BOOTTIME:
+	case CLOCK_TAI:
+		current->umcg_clock = which_clock;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	flags &= ~UMCG_CTL_REGISTER;
+	if (flags && flags != UMCG_CTL_WORKER)
+		return -EINVAL;
+
+	if (current->umcg_task || !self)
+		return -EINVAL;
+
+	if (copy_from_user(&ut, self, sizeof(ut)))
+		return -EFAULT;
+
+	if (ut.next_tid || ut.__hole[0] || ut.__zero[0] || ut.__zero[1] || ut.__zero[2])
+		return -EINVAL;
+
+	if (flags == UMCG_CTL_WORKER) {
+		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_BLOCKED)
+			return -EINVAL;
+
+		WRITE_ONCE(current->umcg_task, self);
+		current->flags |= PF_UMCG_WORKER;	/* hook schedule() */
+		set_syscall_work(SYSCALL_UMCG);		/* hook syscall */
+		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
+
+		/* umcg_sys_exit() will transition to RUNNABLE and wait */
+
+	} else {
+		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_RUNNING)
+			return -EINVAL;
+
+		WRITE_ONCE(current->umcg_task, self);
+		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
+
+		/* umcg_notify_resume() would block if not RUNNING */
+	}
+
+	return 0;
+}
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -273,6 +273,10 @@ COND_SYSCALL(landlock_create_ruleset);
 COND_SYSCALL(landlock_add_rule);
 COND_SYSCALL(landlock_restrict_self);
 
+/* kernel/sched/umcg.c */
+COND_SYSCALL(umcg_ctl);
+COND_SYSCALL(umcg_wait);
+
 /* arch/example/kernel/sys_example.c */
 
 /* mm/fadvise.c */
