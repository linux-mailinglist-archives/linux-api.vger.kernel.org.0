Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6797845C7AA
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352252AbhKXOoH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 09:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349791AbhKXOoC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 09:44:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B5C0746E0;
        Wed, 24 Nov 2021 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sz1Ajw3Y5rf/B/BfwJgFT5Gw2uQBApdZyWtOvsrkGRM=; b=k1fo0rdEgRndNd3HgJwX7gJ5cg
        wbdSICGJWgRhevBil6eYFHrakAO+TRotn0hnZleM69kitvpdGUqFqgyRJ4iv/PKCAdhfnEan1E72W
        cm/lcAFMPyDf5E+EoQhRcMII65xi332L0Gr38gwFfn6IEji1V9HSsjT1uUeoJzh5FIA11Jw5N/VCZ
        OCq9Cr8Rgv9vtkVCXi9cf5eOKuO3d4HkrprbFHHrxi5YXwdF7bAfO/SXpVXnOXXbtTPWKLJFYIjkB
        lzAHRJcuz8Waoi3AeTczuIGGSl5BTx06W1n6ZuLaXvFeM/dkJQ0Jc+R6PM4rZv9Kw7ZbHCWtVC2HF
        pZj0t9Mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpsv3-000Ge0-1P; Wed, 24 Nov 2021 14:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4828D300093;
        Wed, 24 Nov 2021 15:06:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35EA8203C25B1; Wed, 24 Nov 2021 15:06:38 +0100 (CET)
Date:   Wed, 24 Nov 2021 15:06:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 0/6] sched,mm,x86/uaccess: implement User Managed
 Concurrency Groups
Message-ID: <YZ5G7gO5Gc1zu/Cm@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122211327.5931-1-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 22, 2021 at 01:13:21PM -0800, Peter Oskolkov wrote:
> User Managed Concurrency Groups (UMCG) is an M:N threading
> subsystem/toolkit that lets user space application developers implement
> in-process user space schedulers.
> 
> This v0.9.1 patchset is the same as v0.9, where u32/u64 in
> uapi/linux/umcg.h are replaced with __u32/__u64, as test robot/lkp
> does not recognize u32/u64 for some reason.
> 
> v0.9 is v0.8 rebased on top of the current tip/sched/core,
> with a fix in umcg_update_state of an issue reported by Tao Zhou.
> 
> Key changes from patchset v0.7:
> https://lore.kernel.org/all/20211012232522.714898-1-posk@google.com/:
> 
> - added libumcg tools/lib/umcg;
> - worker "wakeup" is reworked so that it is now purely a userspace op,
>   instead of waking the thread in order for it to block on return
>   to the userspace immediately;
> - a couple of minor fixes and refactorings.
> 
> These big things remain to be addressed (in no particular order):
> - support tracing/debugging
> - make context switches faster (see umcg_do_context_switch in umcg.c)
> - support other architectures
> - cleanup and post selftests in tools/testing/selftests/umcg/
> - allow cross-mm wakeups (securely)

*groan*... so these patches do *NOT* support the very thing this all
started with, namely block + wakeup notifications. I'm really not sure
how that happened, as that was the sole purpose of the exercise.

Aside of that, the whole uaccess stuff is horrific :-( I'll reply to
that email separately, but the alternative is also included in the
random hackery below.

I'm still trying to make sense of it all, but I'm really not seeing how
any of this satisfies the initial goals, also it is once again 100% new
code :/

---
 arch/x86/Kconfig                  |    1 
 arch/x86/include/asm/uaccess.h    |  106 +++++++++++++++
 arch/x86/include/asm/uaccess_64.h |   93 -------------
 include/linux/entry-common.h      |    2 
 include/linux/sched.h             |   29 ++--
 include/linux/thread_info.h       |    2 
 include/linux/uaccess.h           |   46 ------
 init/Kconfig                      |    7 -
 kernel/entry/common.c             |   11 +
 kernel/sched/umcg.c               |  231 ++++++++++++++++++++-------------
 mm/maccess.c                      |  264 --------------------------------------
 11 files changed, 278 insertions(+), 514 deletions(-)

Index: linux-2.6/arch/x86/include/asm/uaccess_64.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/uaccess_64.h
+++ linux-2.6/arch/x86/include/asm/uaccess_64.h
@@ -79,97 +79,4 @@ __copy_from_user_flushcache(void *dst, c
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, src, size);
 }
-
-#define ARCH_HAS_ATOMIC_UACCESS_HELPERS 1
-
-static inline int __try_cmpxchg_user_32(u32 *uval, u32 __user *uaddr,
-						u32 oldval, u32 newval)
-{
-	int ret = 0;
-
-	asm volatile("\n"
-		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
-		"2:\n"
-		"\t.section .fixup, \"ax\"\n"
-		"3:\tmov     %3, %0\n"
-		"\tjmp     2b\n"
-		"\t.previous\n"
-		_ASM_EXTABLE_UA(1b, 3b)
-		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
-		: "i" (-EFAULT), "r" (newval), "1" (oldval)
-		: "memory"
-	);
-	*uval = oldval;
-	return ret;
-}
-
-static inline int __try_cmpxchg_user_64(u64 *uval, u64 __user *uaddr,
-						u64 oldval, u64 newval)
-{
-	int ret = 0;
-
-	asm volatile("\n"
-		"1:\t" LOCK_PREFIX "cmpxchgq %4, %2\n"
-		"2:\n"
-		"\t.section .fixup, \"ax\"\n"
-		"3:\tmov     %3, %0\n"
-		"\tjmp     2b\n"
-		"\t.previous\n"
-		_ASM_EXTABLE_UA(1b, 3b)
-		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
-		: "i" (-EFAULT), "r" (newval), "1" (oldval)
-		: "memory"
-	);
-	*uval = oldval;
-	return ret;
-}
-
-static inline int __try_xchg_user_32(u32 *oval, u32 __user *uaddr, u32 newval)
-{
-	u32 oldval = 0;
-	int ret = 0;
-
-	asm volatile("\n"
-		"1:\txchgl %0, %2\n"
-		"2:\n"
-		"\t.section .fixup, \"ax\"\n"
-		"3:\tmov     %3, %1\n"
-		"\tjmp     2b\n"
-		"\t.previous\n"
-		_ASM_EXTABLE_UA(1b, 3b)
-		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
-		: "i" (-EFAULT), "0" (newval), "1" (0)
-	);
-
-	if (ret)
-		return ret;
-
-	*oval = oldval;
-	return 0;
-}
-
-static inline int __try_xchg_user_64(u64 *oval, u64 __user *uaddr, u64 newval)
-{
-	u64 oldval = 0;
-	int ret = 0;
-
-	asm volatile("\n"
-		"1:\txchgq %0, %2\n"
-		"2:\n"
-		"\t.section .fixup, \"ax\"\n"
-		"3:\tmov     %3, %1\n"
-		"\tjmp     2b\n"
-		"\t.previous\n"
-		_ASM_EXTABLE_UA(1b, 3b)
-		: "=r" (oldval), "=r" (ret), "+m" (*uaddr)
-		: "i" (-EFAULT), "0" (newval), "1" (0)
-	);
-
-	if (ret)
-		return ret;
-
-	*oval = oldval;
-	return 0;
-}
-
 #endif /* _ASM_X86_UACCESS_64_H */
Index: linux-2.6/include/linux/uaccess.h
===================================================================
--- linux-2.6.orig/include/linux/uaccess.h
+++ linux-2.6/include/linux/uaccess.h
@@ -408,50 +408,4 @@ void __noreturn usercopy_abort(const cha
 			       unsigned long len);
 #endif
 
-#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
-/**
- * cmpxchg_user_[32|64][_nofault|]() - compare_exchange 32/64-bit values
- * @uaddr:     Destination address, in user space;
- * @curr_val:  Source address, in kernel space;
- * @new_val:   The value to write to the destination address.
- *
- * This is the standard cmpxchg: atomically: compare *@uaddr to *@curr_val;
- * if the values match, write @new_val to @uaddr, return 0; if the values
- * do not match, write *@uaddr to @curr_val, return -EAGAIN.
- *
- * The _nofault versions don't fault and can be used in
- * atomic/preempt-disabled contexts.
- *
- * Return:
- * 0      : OK/success;
- * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
- * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault);
- * -EAGAIN: @old did not match.
- */
-int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val);
-int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val);
-int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val);
-int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val);
-
-/**
- * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
- * @uaddr:   Destination address, in user space;
- * @val:     Source address, in kernel space.
- *
- * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
- *
- * The _nofault versions don't fault and can be used in
- * atomic/preempt-disabled contexts.
- *
- * Return:
- * 0      : OK/success;
- * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
- * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
- */
-int xchg_user_32_nofault(u32 __user *uaddr, u32 *val);
-int xchg_user_64_nofault(u64 __user *uaddr, u64 *val);
-int xchg_user_32(u32 __user *uaddr, u32 *val);
-int xchg_user_64(u64 __user *uaddr, u64 *val);
-#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
-
 #endif		/* __LINUX_UACCESS_H__ */
Index: linux-2.6/kernel/sched/umcg.c
===================================================================
--- linux-2.6.orig/kernel/sched/umcg.c
+++ linux-2.6/kernel/sched/umcg.c
@@ -39,6 +39,10 @@
  *                 and its server.
  *
  * The pages are pinned when the worker exits to the userspace and unpinned
+ *
+ * XXX exit is wrong; must pin on syscall-entry. Otherwise the pin is of
+ * XXX unbounded duration.
+ *
  * when the worker is in sched_submit_work(), i.e. when the worker is
  * about to be removed from its runqueue. Thus at most NR_CPUS UMCG pages
  * are pinned at any one time across the whole system.
@@ -67,10 +71,12 @@ static int umcg_pin_pages(u32 server_tid
 	tsk = current;
 
 	/* worker_ut is stable, don't need to repin */
-	if (!tsk->pinned_umcg_worker_page)
-		if (1 != pin_user_pages_fast((unsigned long)worker_ut, 1, 0,
-					&tsk->pinned_umcg_worker_page))
+	// XXX explain, this should never be so
+	if (!tsk->pinned_umcg_worker_page) {
+		if (pin_user_pages_fast((unsigned long)worker_ut, 1, 0,
+					&tsk->pinned_umcg_worker_page) != 1)
 			return -EFAULT;
+	}
 
 	/* server_ut may change, need to repin */
 	if (tsk->pinned_umcg_server_page) {
@@ -78,8 +84,8 @@ static int umcg_pin_pages(u32 server_tid
 		tsk->pinned_umcg_server_page = NULL;
 	}
 
-	if (1 != pin_user_pages_fast((unsigned long)server_ut, 1, 0,
-				&tsk->pinned_umcg_server_page))
+	if (pin_user_pages_fast((unsigned long)server_ut, 1, 0,
+				&tsk->pinned_umcg_server_page) != 1)
 		return -EFAULT;
 
 	return 0;
@@ -89,13 +95,14 @@ static void umcg_unpin_pages(void)
 {
 	struct task_struct *tsk = current;
 
-	if (tsk->pinned_umcg_worker_page)
+	if (tsk->pinned_umcg_worker_page) {
 		unpin_user_page(tsk->pinned_umcg_worker_page);
-	if (tsk->pinned_umcg_server_page)
+		tsk->pinned_umcg_worker_page = NULL;
+	}
+	if (tsk->pinned_umcg_server_page) {
 		unpin_user_page(tsk->pinned_umcg_server_page);
-
-	tsk->pinned_umcg_worker_page = NULL;
-	tsk->pinned_umcg_server_page = NULL;
+		tsk->pinned_umcg_server_page = NULL;
+	}
 }
 
 static void umcg_clear_task(struct task_struct *tsk)
@@ -137,12 +144,18 @@ void umcg_handle_exiting_worker(void)
  *
  * The function is basically cmpxchg(state_ts, expected, desired), with extra
  * code to set the timestamp in @desired.
+ *
+ * XXX I don't understand the need for this complexity; umcg_task is only 4
+ * XXX u64's long, that means there's 4 more in the cacheline, why can't the
+ * XXX timestamp get it's own word?
+ *
+ * XXX Also, is a single timestamp sufficient?
  */
-static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
-				bool may_fault)
+static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired)
 {
 	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
 	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
+	bool success;
 
 	/* Cut higher order bits. */
 	next_ts &= (1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1;
@@ -156,10 +169,17 @@ static int umcg_update_state(u64 __user
 	/* Set the new timestamp. */
 	desired |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
 
-	if (may_fault)
-		return cmpxchg_user_64(state_ts, expected, desired);
+	if (!user_access_begin(state_ts, sizeof(*state_ts)))
+		return -EFAULT;
+
+	success = __try_cmpxchg_user((u64 *)state_ts, expected, desired, Efault);
+	user_access_end();
+
+	return success ? 0 : -EAGAIN;
 
-	return cmpxchg_user_64_nofault(state_ts, expected, desired);
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 /**
@@ -233,8 +253,7 @@ SYSCALL_DEFINE2(umcg_ctl, u32, flags, st
 		WRITE_ONCE(current->umcg_task, self);
 		current->flags |= PF_UMCG_WORKER;
 
-		/* Trigger umcg_handle_resuming_worker() */
-		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		set_syscall_work(SYSCALL_UMCG);
 	} else {
 		if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING)
 			return -EINVAL;
@@ -263,7 +282,7 @@ static int handle_timedout_worker(struct
 		next_state = curr_state & ~UMCG_TASK_STATE_MASK;
 		next_state |= UMCG_TASK_BLOCKED;
 
-		ret = umcg_update_state(&self->state_ts, &curr_state, next_state, true);
+		ret = umcg_update_state(&self->state_ts, &curr_state, next_state);
 		if (ret)
 			return ret;
 
@@ -324,7 +343,7 @@ static int umcg_idle_loop(u64 abs_timeou
 				current->timer_slack_ns);
 	}
 
-	while (true) {
+	for (;;) {
 		u64 umcg_state;
 
 		/*
@@ -333,22 +352,18 @@ static int umcg_idle_loop(u64 abs_timeou
 		 * but faulting is not allowed; so we try a fast no-fault read,
 		 * and if it fails, pin the page temporarily.
 		 */
-retry_once:
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		/* Order set_current_state above with get_user below. */
-		smp_mb();
 		ret = -EFAULT;
 		if (get_user_nofault(umcg_state, &self->state_ts)) {
-			set_current_state(TASK_RUNNING);
-
 			if (pinned_page)
-				goto out;
-			else if (1 != pin_user_pages_fast((unsigned long)self,
-						1, 0, &pinned_page))
-					goto out;
+				break;
 
-			goto retry_once;
+			if (pin_user_pages_fast((unsigned long)self,
+						1, 0, &pinned_page) != 1)
+				break;
+
+			continue;
 		}
 
 		if (pinned_page) {
@@ -357,10 +372,8 @@ retry_once:
 		}
 
 		ret = 0;
-		if (!umcg_should_idle(umcg_state)) {
-			set_current_state(TASK_RUNNING);
-			goto out;
-		}
+		if (!umcg_should_idle(umcg_state))
+			break;
 
 		if (abs_timeout)
 			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
@@ -368,7 +381,6 @@ retry_once:
 		if (!abs_timeout || timeout.task)
 			freezable_schedule();
 
-		__set_current_state(TASK_RUNNING);
 
 		/*
 		 * Check for timeout before checking the state, as workers
@@ -377,27 +389,26 @@ retry_once:
 		 */
 		ret = -ETIMEDOUT;
 		if (abs_timeout && !timeout.task)
-			goto out;
+			break;
 
-		/* Order set_current_state above with get_user below. */
-		smp_mb();
 		ret = -EFAULT;
 		if (get_user(umcg_state, &self->state_ts))
-			goto out;
+			break;
 
 		ret = 0;
 		if (!umcg_should_idle(umcg_state))
-			goto out;
+			break;
 
 		ret = -EINTR;
 		if (fatal_signal_pending(current))
-			goto out;
+			break;
 
+		// XXX this *cannot* be right, a process can loose signals this way.
 		if (signal_pending(current))
 			flush_signals(current);
 	}
+	__set_current_state(TASK_RUNNING);
 
-out:
 	if (pinned_page) {
 		unpin_user_page(pinned_page);
 		pinned_page = NULL;
@@ -428,10 +439,7 @@ static bool umcg_wakeup_allowed(struct t
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	if (tsk->mm && tsk->mm == current->mm && READ_ONCE(tsk->umcg_task))
-		return true;
-
-	return false;
+	return tsk->mm && tsk->mm == current->mm && READ_ONCE(tsk->umcg_task);
 }
 
 /*
@@ -459,26 +467,6 @@ static int umcg_ttwu(u32 next_tid, int w
 	return 0;
 }
 
-/*
- * At the moment, umcg_do_context_switch simply wakes up @next with
- * WF_CURRENT_CPU and puts the current task to sleep.
- *
- * In the future an optimization will be added to adjust runtime accounting
- * so that from the kernel scheduling perspective the two tasks are
- * essentially treated as one. In addition, the context switch may be performed
- * right here on the fast path, instead of going through the wake/wait pair.
- */
-static int umcg_do_context_switch(u32 next_tid, u64 abs_timeout)
-{
-	int ret;
-
-	ret = umcg_ttwu(next_tid, WF_CURRENT_CPU);
-	if (ret)
-		return ret;
-
-	return umcg_idle_loop(abs_timeout);
-}
-
 /**
  * sys_umcg_wait: put the current task to sleep and/or wake another task.
  * @flags:        zero or a value from enum umcg_wait_flag.
@@ -509,6 +497,7 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 {
 	struct umcg_task __user *self = current->umcg_task;
 	u32 next_tid;
+	int ret;
 
 	if (!self)
 		return -EINVAL;
@@ -535,14 +524,17 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 		if (get_user(umcg_state, &self->state_ts))
 			return -EFAULT;
 
-		if ((umcg_state & UMCG_TF_LOCKED) && umcg_update_state(
-					&self->state_ts, &umcg_state,
-					umcg_state & ~UMCG_TF_LOCKED, true))
+		if ((umcg_state & UMCG_TF_LOCKED) &&
+		    umcg_update_state(&self->state_ts, &umcg_state,
+				      umcg_state & ~UMCG_TF_LOCKED))
 			return -EFAULT;
 	}
 
-	if (next_tid)
-		return umcg_do_context_switch(next_tid, abs_timeout);
+	if (next_tid) {
+		ret = umcg_ttwu(next_tid, WF_CURRENT_CPU);
+		if (ret)
+			return ret;
+	}
 
 	return umcg_idle_loop(abs_timeout);
 }
@@ -581,9 +573,10 @@ static int umcg_wake_idle_server_nofault
 	if ((state & UMCG_TASK_STATE_MASK) != UMCG_TASK_IDLE)
 		goto out_rcu;
 
+	pagefault_disable();
 	ret = umcg_update_state(&ut_server->state_ts, &state,
-			(state & ~UMCG_TASK_STATE_MASK) | UMCG_TASK_RUNNING,
-			false);
+				(state & ~UMCG_TASK_STATE_MASK) | UMCG_TASK_RUNNING);
+	pagefault_enable();
 
 	if (ret)
 		goto out_rcu;
@@ -621,8 +614,7 @@ static int umcg_wake_idle_server_may_fau
 		return -EAGAIN;
 
 	ret = umcg_update_state(&ut_server->state_ts, &state,
-			(state & ~UMCG_TASK_STATE_MASK) | UMCG_TASK_RUNNING,
-			true);
+				(state & ~UMCG_TASK_STATE_MASK) | UMCG_TASK_RUNNING);
 	if (ret)
 		return ret;
 
@@ -690,6 +682,11 @@ static void process_sleeping_worker(stru
 	 *
 	 * See Documentation/userspace-api/umcg.txt for details.
 	 */
+
+	// XXX this seems like a super gross hack, please explain more.
+	// XXX ideally we kill this LOCKED but entirely, that just smells
+	// XXX worse than fish gone bad.
+
 retry_once:
 	if (curr_state & UMCG_TF_LOCKED)
 		return;
@@ -701,7 +698,9 @@ retry_once:
 	next_state = curr_state & ~UMCG_TASK_STATE_MASK;
 	next_state |= UMCG_TASK_BLOCKED;
 
-	ret = umcg_update_state(&ut_worker->state_ts, &curr_state, next_state, false);
+	pagefault_disable();
+	ret = umcg_update_state(&ut_worker->state_ts, &curr_state, next_state);
+	pagefault_enable();
 	if (ret == -EAGAIN) {
 		if (retried)
 			goto die;
@@ -712,6 +711,8 @@ retry_once:
 	if (ret)
 		goto die;
 
+	// XXX write a real ordering comment, see ttwu() for examples
+	// XXX idem for all other barriers in this file.
 	smp_mb();  /* Order state read/write above and getting next_tid below. */
 	if (get_user_nofault(tid, &ut_worker->next_tid))
 		goto die;
@@ -739,7 +740,6 @@ void umcg_wq_worker_sleeping(struct task
 
 	if (server_tid) {
 		int ret = umcg_wake_idle_server_nofault(server_tid);
-
 		if (ret && ret != -EAGAIN)
 			goto die;
 	}
@@ -777,14 +777,25 @@ static bool enqueue_idle_worker(struct u
 		return false;
 
 	/* Make the head point to the worker. */
-	if (xchg_user_64(head_ptr, &first))
+	if (!user_access_begin(head_ptr, sizeof(*head_ptr)))
 		return false;
 
+	first = __xchg_user(head_ptr, (u64)node, Efault);
+	user_access_end();
+
+	// XXX vCPU goes on a holiday here and userspace is left
+	// XXX with a broken list, cmpxchg based list-add is safer
+	// XXX that way
+
 	/* Make the worker point to the previous head. */
 	if (put_user(first, node))
 		return false;
 
 	return true;
+
+Efault:
+	user_access_end();
+	return false;
 }
 
 /**
@@ -807,11 +818,18 @@ static bool get_idle_server(struct umcg_
 		return false;
 
 	tid = 0;
-	if (xchg_user_32((u32 __user *)server_tid_ptr, &tid))
+	if (!user_access_begin((u32 __user *)server_tid_ptr, sizeof(u32)))
 		return false;
 
+	tid = __xchg_user((u32 *)server_tid_ptr, 0, Efault);
+	user_access_end();
+
 	*server_tid = tid;
 	return true;
+
+Efault:
+	user_access_end();
+	return false;
 }
 
 /*
@@ -870,9 +888,10 @@ static bool process_waking_worker(struct
 		 * PREEMPTED.
 		 */
 	} else if (unlikely((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE &&
-			(curr_state & UMCG_TF_LOCKED)))
+			    (curr_state & UMCG_TF_LOCKED))) {
 		/* The worker prepares to sleep or to unregister. */
 		return false;
+	}
 
 	if (unlikely((curr_state & UMCG_TASK_STATE_MASK) == UMCG_TASK_IDLE))
 		goto die;
@@ -880,8 +899,7 @@ static bool process_waking_worker(struct
 	next_state = curr_state & ~UMCG_TASK_STATE_MASK;
 	next_state |= UMCG_TASK_IDLE;
 
-	if (umcg_update_state(&ut_worker->state_ts, &curr_state,
-			next_state, true))
+	if (umcg_update_state(&ut_worker->state_ts, &curr_state, next_state))
 		goto die;
 
 	if (!enqueue_idle_worker(ut_worker))
@@ -905,18 +923,53 @@ die:
  */
 void umcg_wq_worker_running(struct task_struct *tsk)
 {
-	set_tsk_thread_flag(tsk, TIF_NOTIFY_RESUME);
+	// XXX this cannot be right, userspace needs to know we're blocked
+	// XXX also, this was exactly what we had those pins for!
+
+	add self to blocked list();
+       	change state();
+	possibly wake next_tid();
+
+	umcg_unpin_pages();
+
+	// and then we go sleep.... the umcg_sys_exit() handler will then
+	// notify userspace we've woken up again and, if available, kick some
+	// idle thread to pick us up.
 }
 
-/* Called via TIF_NOTIFY_RESUME flag from exit_to_user_mode_loop. */
-void umcg_handle_resuming_worker(void)
+void umcg_sys_enter(struct pt_regs *regs)
 {
 	u32 server_tid;
 
 	/* Avoid recursion by removing PF_UMCG_WORKER */
 	current->flags &= ~PF_UMCG_WORKER;
 
-	do {
+	// XXX wth did umcg_task::server_tid go?
+
+	if (!server_tid)
+		umcg_unpin_pages();
+	else if (umcg_pin_pages(server_tid))
+		goto die;
+
+	goto out;
+
+die:
+	pr_warn("%s: killing task %d\n", __func__, current->pid);
+	force_sig(SIGKILL);
+out:
+	current->flags |= PF_UMCG_WORKER;
+}
+
+void umcg_sys_exit(struct pt_regs *regs)
+{
+	u32 server_tid;
+
+	umcg_unpin_pages();
+
+	/* Avoid recursion by removing PF_UMCG_WORKER */
+	current->flags &= ~PF_UMCG_WORKER;
+
+	for (;;) {
 		bool should_wait;
 
 		should_wait = process_waking_worker(current, &server_tid);
@@ -931,13 +984,7 @@ void umcg_handle_resuming_worker(void)
 		}
 
 		umcg_idle_loop(0);
-	} while (true);
-
-	if (!server_tid)
-		/* No server => no reason to pin pages. */
-		umcg_unpin_pages();
-	else if (umcg_pin_pages(server_tid))
-		goto die;
+	}
 
 	goto out;
 
Index: linux-2.6/mm/maccess.c
===================================================================
--- linux-2.6.orig/mm/maccess.c
+++ linux-2.6/mm/maccess.c
@@ -335,267 +335,3 @@ long strnlen_user_nofault(const void __u
 
 	return ret;
 }
-
-#ifdef ARCH_HAS_ATOMIC_UACCESS_HELPERS
-
-static int fix_pagefault(unsigned long uaddr, bool write_fault, int bytes)
-{
-	struct mm_struct *mm = current->mm;
-	int ret;
-
-	mmap_read_lock(mm);
-	ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
-			NULL);
-	mmap_read_unlock(mm);
-
-	return ret < 0 ? ret : 0;
-}
-
-int cmpxchg_user_32_nofault(u32 __user *uaddr, u32 *curr_val, u32 new_val)
-{
-	int ret = -EFAULT;
-	u32 __old = *curr_val;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
-		pagefault_enable();
-		return -EFAULT;
-	}
-	ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
-	user_access_end();
-
-	if (!ret)
-		ret =  *curr_val == __old ? 0 : -EAGAIN;
-
-	pagefault_enable();
-	return ret;
-}
-
-int cmpxchg_user_64_nofault(u64 __user *uaddr, u64 *curr_val, u64 new_val)
-{
-	int ret = -EFAULT;
-	u64 __old = *curr_val;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
-		pagefault_enable();
-		return -EFAULT;
-	}
-	ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
-	user_access_end();
-
-	if (!ret)
-		ret =  *curr_val == __old ? 0 : -EAGAIN;
-
-	pagefault_enable();
-
-	return ret;
-}
-
-int cmpxchg_user_32(u32 __user *uaddr, u32 *curr_val, u32 new_val)
-{
-	int ret = -EFAULT;
-	u32 __old = *curr_val;
-
-	/* Validate proper alignment. */
-	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
-			((unsigned long)curr_val % sizeof(*curr_val))))
-		return -EINVAL;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	while (true) {
-		ret = -EFAULT;
-		if (!user_access_begin(uaddr, sizeof(*uaddr)))
-			break;
-
-		ret = __try_cmpxchg_user_32(curr_val, uaddr, __old, new_val);
-		user_access_end();
-
-		if (!ret) {
-			ret =  *curr_val == __old ? 0 : -EAGAIN;
-			break;
-		}
-
-		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
-			break;
-	}
-
-	pagefault_enable();
-	return ret;
-}
-
-int cmpxchg_user_64(u64 __user *uaddr, u64 *curr_val, u64 new_val)
-{
-	int ret = -EFAULT;
-	u64 __old = *curr_val;
-
-	/* Validate proper alignment. */
-	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
-			((unsigned long)curr_val % sizeof(*curr_val))))
-		return -EINVAL;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	while (true) {
-		ret = -EFAULT;
-		if (!user_access_begin(uaddr, sizeof(*uaddr)))
-			break;
-
-		ret = __try_cmpxchg_user_64(curr_val, uaddr, __old, new_val);
-		user_access_end();
-
-		if (!ret) {
-			ret =  *curr_val == __old ? 0 : -EAGAIN;
-			break;
-		}
-
-		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
-			break;
-	}
-
-	pagefault_enable();
-	return ret;
-}
-
-/**
- * xchg_user_[32|64][_nofault|]() - exchange 32/64-bit values
- * @uaddr:   Destination address, in user space;
- * @val:     Source address, in kernel space.
- *
- * This is the standard atomic xchg: exchange values pointed to by @uaddr and @val.
- *
- * The _nofault versions don't fault and can be used in
- * atomic/preempt-disabled contexts.
- *
- * Return:
- * 0      : OK/success;
- * -EINVAL: @uaddr is not properly aligned ('may fault' versions only);
- * -EFAULT: memory access error (including mis-aligned @uaddr in _nofault).
- */
-int xchg_user_32_nofault(u32 __user *uaddr, u32 *val)
-{
-	int ret;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
-		pagefault_enable();
-		return -EFAULT;
-	}
-
-	ret = __try_xchg_user_32(val, uaddr, *val);
-	user_access_end();
-
-	pagefault_enable();
-
-	return ret;
-}
-
-int xchg_user_64_nofault(u64 __user *uaddr, u64 *val)
-{
-	int ret;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	if (!user_access_begin(uaddr, sizeof(*uaddr))) {
-		pagefault_enable();
-		return -EFAULT;
-	}
-
-	ret = __try_xchg_user_64(val, uaddr, *val);
-	user_access_end();
-
-	pagefault_enable();
-
-	return ret;
-}
-
-int xchg_user_32(u32 __user *uaddr, u32 *val)
-{
-	int ret = -EFAULT;
-
-	/* Validate proper alignment. */
-	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
-			((unsigned long)val % sizeof(*val))))
-		return -EINVAL;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	while (true) {
-		ret = -EFAULT;
-		if (!user_access_begin(uaddr, sizeof(*uaddr)))
-			break;
-
-		ret = __try_xchg_user_32(val, uaddr, *val);
-		user_access_end();
-
-		if (!ret)
-			break;
-
-		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
-			break;
-	}
-
-	pagefault_enable();
-
-	return ret;
-}
-
-int xchg_user_64(u64 __user *uaddr, u64 *val)
-{
-	int ret = -EFAULT;
-
-	/* Validate proper alignment. */
-	if (unlikely(((unsigned long)uaddr % sizeof(*uaddr)) ||
-			((unsigned long)val % sizeof(*val))))
-		return -EINVAL;
-
-	if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
-		return -EFAULT;
-
-	pagefault_disable();
-
-	while (true) {
-		ret = -EFAULT;
-		if (!user_access_begin(uaddr, sizeof(*uaddr)))
-			break;
-
-		ret = __try_xchg_user_64(val, uaddr, *val);
-		user_access_end();
-
-		if (!ret)
-			break;
-
-		if (fix_pagefault((unsigned long)uaddr, true, sizeof(*uaddr)) < 0)
-			break;
-	}
-
-	pagefault_enable();
-
-	return ret;
-}
-#endif		/* ARCH_HAS_ATOMIC_UACCESS_HELPERS */
Index: linux-2.6/include/linux/entry-common.h
===================================================================
--- linux-2.6.orig/include/linux/entry-common.h
+++ linux-2.6/include/linux/entry-common.h
@@ -42,11 +42,13 @@
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
 
Index: linux-2.6/include/linux/thread_info.h
===================================================================
--- linux-2.6.orig/include/linux/thread_info.h
+++ linux-2.6/include/linux/thread_info.h
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
+#define SYSCALL_WORK_SYSCALL_UMCG	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_UMCG)
 #endif
 
 #include <asm/thread_info.h>
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -2303,9 +2303,10 @@ static inline void rseq_execve(struct ta
 
 #ifdef CONFIG_UMCG
 
-void umcg_handle_resuming_worker(void);
-void umcg_handle_exiting_worker(void);
-void umcg_clear_child(struct task_struct *tsk);
+extern void umcg_sys_enter(struct pt_regs *regs);
+extern void umcg_sys_exit(struct pt_regs *regs);
+extern void umcg_handle_exiting_worker(void);
+extern void umcg_clear_child(struct task_struct *tsk);
 
 /* Called by bprm_execve() in fs/exec.c. */
 static inline void umcg_execve(struct task_struct *tsk)
@@ -2314,13 +2315,6 @@ static inline void umcg_execve(struct ta
 		umcg_clear_child(tsk);
 }
 
-/* Called by exit_to_user_mode_loop() in kernel/entry/common.c.*/
-static inline void umcg_handle_notify_resume(void)
-{
-	if (current->flags & PF_UMCG_WORKER)
-		umcg_handle_resuming_worker();
-}
-
 /* Called by do_exit() in kernel/exit.c. */
 static inline void umcg_handle_exit(void)
 {
@@ -2332,18 +2326,23 @@ static inline void umcg_handle_exit(void
  * umcg_wq_worker_[sleeping|running] are called in core.c by
  * sched_submit_work() and sched_update_worker().
  */
-void umcg_wq_worker_sleeping(struct task_struct *tsk);
-void umcg_wq_worker_running(struct task_struct *tsk);
+extern void umcg_wq_worker_sleeping(struct task_struct *tsk);
+extern void umcg_wq_worker_running(struct task_struct *tsk);
 
 #else  /* CONFIG_UMCG */
 
-static inline void umcg_clear_child(struct task_struct *tsk)
+static inline void umcg_sys_enter(struct pt_regs *regs)
 {
 }
-static inline void umcg_execve(struct task_struct *tsk)
+
+static inline void umcg_sys_exit(struct pt_regs *regs)
+{
+}
+
+static inline void umcg_clear_child(struct task_struct *tsk)
 {
 }
-static inline void umcg_handle_notify_resume(void)
+static inline void umcg_execve(struct task_struct *tsk)
 {
 }
 static inline void umcg_handle_exit(void)
Index: linux-2.6/kernel/entry/common.c
===================================================================
--- linux-2.6.orig/kernel/entry/common.c
+++ linux-2.6/kernel/entry/common.c
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
+		umcg_sys_enter(regs);
+
 	syscall_enter_audit(regs, syscall);
 
 	return ret ? : syscall;
@@ -171,10 +175,8 @@ static unsigned long exit_to_user_mode_l
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			handle_signal_work(regs, ti_work);
 
-		if (ti_work & _TIF_NOTIFY_RESUME) {
-			umcg_handle_notify_resume();
+		if (ti_work & _TIF_NOTIFY_RESUME)
 			tracehook_notify_resume(regs);
-		}
 
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
@@ -255,6 +257,9 @@ static void syscall_exit_work(struct pt_
 	step = report_single_step(work);
 	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
 		arch_syscall_exit_tracehook(regs, step);
+
+	if (work & SYSCALL_WORK_SYSCALL_UMCG)
+		umcg_sys_exit(regs);
 }
 
 /*
Index: linux-2.6/arch/x86/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86/Kconfig
+++ linux-2.6/arch/x86/Kconfig
@@ -248,6 +248,7 @@ config X86
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UMCG			if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
Index: linux-2.6/arch/x86/include/asm/uaccess.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/uaccess.h
+++ linux-2.6/arch/x86/include/asm/uaccess.h
@@ -341,6 +341,37 @@ do {									\
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
+
+#define __xchg_user_asm(itype, _ptr, _val, label)	({		\
+	__typeof__(*(_ptr)) __ret = (_val);				\
+	asm_volatile_goto("\n"						\
+			"1: " LOCK_PREFIX "xchg"itype" %[var], %[ptr]\n"\
+			_ASM_EXTABLE_UA(1b, %l[label])			\
+			: [var] "+r" (__ret).				\
+			  [ptr] "+m" (*(_ptr))				\
+			:						\
+			: "memory", "cc"				\
+			: label);					\
+	__ret;						})
+
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #ifdef CONFIG_X86_32
@@ -411,8 +442,83 @@ do {									\
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
+#define __xchg_user_asm(itype, _ptr, _val, label)	({		\
+	int __err = 0;							\
+	__typeof__(*(_ptr)) __ret = (_val);				\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "xchg"itype" %[var], %[ptr]\n"	\
+		     "2:\n"						\
+		     ".pushsection .fixup,\"ax\"\n"			\
+		     "3:	mov %[efault], %[errout]\n"		\
+		     "		jmp 2b\n"				\
+		     ".popsection\n"					\
+		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       [var] "+r" (__ret),				\
+		       [errout] "+r" (__err)				\
+		     : [efault] "i" (-EFAULT)				\
+		     : "memory", "cc");					\
+	if (unlikely(__err))						\
+		goto label;						\
+	__ret;						})
+
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
+extern void __try_cmpxchg_user_wrong_size(void);
+extern void __xchg_user_wrong_size(void);
+
+#define __try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
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
+#define __xchg_user(_ptr, _nval, _label)		({		\
+	__typeof__(*(_ptr)) __ret;					\
+	switch (sizeof(__ret)) {					\
+	case 4: __ret = __xchg_user_asm("l", (_ptr), (_nval), _label);	\
+		break;							\
+	case 8: __ret = __xchg_user_asm("q", (_ptr), (_nval), _label);	\
+		break;							\
+	default: __xchg_user_wrong_size();				\
+	}								\
+	__ret;						})
+
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct __user *)(x))
Index: linux-2.6/init/Kconfig
===================================================================
--- linux-2.6.orig/init/Kconfig
+++ linux-2.6/init/Kconfig
@@ -1693,9 +1693,14 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config HAVE_UMCG
+	defbool n
+
 config UMCG
 	bool "Enable User Managed Concurrency Groups API"
-	depends on X86_64
+	depends on 64BIT
+	depends on GENERIC_ENTRY
+	depends on HAVE_UMCG
 	default n
 	help
 	  Enable User Managed Concurrency Groups API, which form the basis
