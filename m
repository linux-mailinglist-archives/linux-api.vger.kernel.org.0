Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0048EF20
	for <lists+linux-api@lfdr.de>; Fri, 14 Jan 2022 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbiANRPp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jan 2022 12:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiANRPo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jan 2022 12:15:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95017C061574;
        Fri, 14 Jan 2022 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=obMLePz8gzwSWYcfgTXlx8d93738wOycRllUtrFLNOY=; b=Es88OXu+Kk+Vb5Noch7OuhJkGc
        wDgyFBZGZ5uqebuTgz05IZTZVK6YspSSmGLKwGV+YpqzreCyBWBaLPcrcFxYE/XQ97oai8VOAe8A1
        gGHB9YCm3ILTWCKHGviey4KMdnclJVMdBPR88Hkn6qY2vKKkK0xoHtmvDZHSXKjPeMk3wF9A+7ebL
        ugwFou/tiyKntAUiWyk6RWEBCAYskTAuO6ouV0mBY+sKW7yZK2n+rmmljrTTJOmRfUH5DqYGEkc0U
        GN1/9S0DYgTrk7KuAdwNFCXMlnlZJIrN6JE4HpwOFNUIRgja1MX+klH8AfsLlBC+GK/SHnjA0i6jP
        TGh54e8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8QAX-005xtz-A5; Fri, 14 Jan 2022 17:15:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 647283002C1;
        Fri, 14 Jan 2022 18:15:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 189CE29BF6E8F; Fri, 14 Jan 2022 18:15:14 +0100 (CET)
Date:   Fri, 14 Jan 2022 18:15:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeGvovSckivQnKX8@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 14, 2022 at 03:09:55PM +0100, Peter Zijlstra wrote:
> 
> Hi!
> 
> I've seen you send a new version based on this, but I figured I ought to
> reply to this first.
> 
> On Tue, Dec 21, 2021 at 05:19:00PM +0000, Peter Oskolkov wrote:
> 
> > > +/* pre-schedule() */
> > > +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> > > +{
> > > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > > +
> > > +	/* Must not fault, mmap_sem might be held. */
> > > +	pagefault_disable();
> > > +
> > > +	if (WARN_ON_ONCE(!tsk->umcg_server))
> > > +		UMCG_DIE_PF("no server");
> > 
> > We can get here if a running worker (no pinned pages) gets a pagefault
> > in the userspace. Is umcg_sys_enter() called for pagefaults? If not,
> > we should not kill the worker; also the userspace won't be able to
> > detect this worker blocking on a pagefault...
> 
> Ufff.. good one. No #PF doesn't pass through sys_enter, I'll have to go
> fix that.

Something like the below I think.. it builds, but I've not yet tested
it.


---
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -73,18 +73,6 @@
 
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
-static inline void cond_local_irq_enable(struct pt_regs *regs)
-{
-	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_enable();
-}
-
-static inline void cond_local_irq_disable(struct pt_regs *regs)
-{
-	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_disable();
-}
-
 __always_inline int is_valid_bugaddr(unsigned long addr)
 {
 	if (addr < TASK_SIZE_MAX)
@@ -177,9 +165,9 @@ static void do_error_trap(struct pt_regs
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
-		cond_local_irq_enable(regs);
+		irqentry_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
-		cond_local_irq_disable(regs);
+		irqentry_irq_disable(regs);
 	}
 }
 
@@ -300,7 +288,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_
 	if (!user_mode(regs))
 		die("Split lock detected\n", regs, error_code);
 
-	local_irq_enable();
+	irqentry_irq_enable(regs);
 
 	if (handle_user_split_lock(regs, error_code))
 		goto out;
@@ -309,7 +297,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_
 		error_code, BUS_ADRALN, NULL);
 
 out:
-	local_irq_disable();
+	irqentry_irq_disable(regs);
 }
 
 #ifdef CONFIG_VMAP_STACK
@@ -473,14 +461,14 @@ DEFINE_IDTENTRY(exc_bounds)
 	if (notify_die(DIE_TRAP, "bounds", regs, 0,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
 		return;
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 
 	if (!user_mode(regs))
 		die("bounds", regs, 0);
 
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, 0, 0, NULL);
 
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 enum kernel_gp_hint {
@@ -567,7 +555,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	unsigned long gp_addr;
 	int ret;
 
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
@@ -638,7 +626,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
 	die_addr(desc, regs, error_code, gp_addr);
 
 exit:
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 static bool do_int3(struct pt_regs *regs)
@@ -665,9 +653,9 @@ static void do_int3_user(struct pt_regs
 	if (do_int3(regs))
 		return;
 
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 	do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 DEFINE_IDTENTRY_RAW(exc_int3)
@@ -1003,7 +991,7 @@ static __always_inline void exc_debug_us
 		goto out;
 
 	/* It's safe to allow irq's after DR6 has been saved */
-	local_irq_enable();
+	irqentry_irq_enable(regs);
 
 	if (v8086_mode(regs)) {
 		handle_vm86_trap((struct kernel_vm86_regs *)regs, 0, X86_TRAP_DB);
@@ -1020,7 +1008,7 @@ static __always_inline void exc_debug_us
 		send_sigtrap(regs, 0, get_si_code(dr6));
 
 out_irq:
-	local_irq_disable();
+	irqentry_irq_disable(regs);
 out:
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
@@ -1064,7 +1052,7 @@ static void math_error(struct pt_regs *r
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
 
-	cond_local_irq_enable(regs);
+	irqentry_irq_enable(regs);
 
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr, 0, 0))
@@ -1099,7 +1087,7 @@ static void math_error(struct pt_regs *r
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
 exit:
-	cond_local_irq_disable(regs);
+	irqentry_irq_disable(regs);
 }
 
 DEFINE_IDTENTRY(exc_coprocessor_error)
@@ -1160,7 +1148,7 @@ static bool handle_xfd_event(struct pt_r
 	if (WARN_ON(!user_mode(regs)))
 		return false;
 
-	local_irq_enable();
+	irqentry_irq_enable(regs);
 
 	err = xfd_enable_feature(xfd_err);
 
@@ -1173,7 +1161,7 @@ static bool handle_xfd_event(struct pt_r
 		break;
 	}
 
-	local_irq_disable();
+	irqentry_irq_disable(regs);
 	return true;
 }
 
@@ -1188,12 +1176,12 @@ DEFINE_IDTENTRY(exc_device_not_available
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
 
-		cond_local_irq_enable(regs);
+		irqentry_irq_enable(regs);
 
 		info.regs = regs;
 		math_emulate(&info);
 
-		cond_local_irq_disable(regs);
+		irqentry_irq_disable(regs);
 		return;
 	}
 #endif
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1209,6 +1209,12 @@ do_kern_addr_fault(struct pt_regs *regs,
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
 /*
+ * EFLAGS[3] is unused and ABI defined to be 0, use it to store IRQ state,
+ * because do_user_addr_fault() is too convoluted to track things.
+ */
+#define X86_EFLAGS_MISC		(1UL << 3)
+
+/*
  * Handle faults in the user portion of the address space.  Nothing in here
  * should check X86_PF_USER without a specific justification: for almost
  * all purposes, we should treat a normal kernel access to user memory
@@ -1290,13 +1296,11 @@ void do_user_addr_fault(struct pt_regs *
 	 * User-mode registers count as a user access even for any
 	 * potential system fault or CPU buglet:
 	 */
-	if (user_mode(regs)) {
-		local_irq_enable();
+	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
-	} else {
-		if (regs->flags & X86_EFLAGS_IF)
-			local_irq_enable();
-	}
+
+	irqentry_irq_enable(regs);
+	regs->flags |= X86_EFLAGS_MISC;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
@@ -1483,14 +1487,10 @@ handle_page_fault(struct pt_regs *regs,
 		do_kern_addr_fault(regs, error_code, address);
 	} else {
 		do_user_addr_fault(regs, error_code, address);
-		/*
-		 * User address page fault handling might have reenabled
-		 * interrupts. Fixing up all potential exit points of
-		 * do_user_addr_fault() and its leaf functions is just not
-		 * doable w/o creating an unholy mess or turning the code
-		 * upside down.
-		 */
-		local_irq_disable();
+		if (regs->flags & X86_EFLAGS_MISC) {
+			regs->flags &= ~X86_EFLAGS_MISC;
+			irqentry_irq_disable(regs);
+		}
 	}
 }
 
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,6 +7,7 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <asm/ptrace.h>
 
 #include <asm/entry-common.h>
 
@@ -218,6 +219,24 @@ static inline void local_irq_disable_exi
 }
 #endif
 
+static inline void irqentry_irq_enable(struct pt_regs *regs)
+{
+	if (!regs_irqs_disabled(regs)) {
+		local_irq_enable();
+		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
+			umcg_sys_enter(regs, 0);
+	}
+}
+
+static inline void irqentry_irq_disable(struct pt_regs *regs)
+{
+	if (!regs_irqs_disabled(regs)) {
+		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
+			umcg_sys_exit(regs);
+		local_irq_disable();
+	}
+}
+
 /**
  * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
  *				 to user mode.
