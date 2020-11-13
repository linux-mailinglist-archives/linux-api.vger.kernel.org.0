Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECE72B147A
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMCxz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKMCxz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:53:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E80C0613D1
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h9so8791060ybj.10
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wBhO4JctSwtB97vOsr0bCF5NihN5XGwZ+Nb5W+rfZP0=;
        b=YypM+RuVo8tyfowITaA8ZO8V+MF1D2keb1FJM9OA1hF1b6SMvTHJ2A3IK+7OqSz6Nd
         J9ekkrxHz9X4hI+kUX+8WYO7Xa0ZEHDnGfQdeOaMpshjAhTXsZHJ/6Lg9bTPw0Zh7AXO
         47wDI//0nij8S62+QzlAAcaBwa1DXZgknVDhjNDoUssP8K29XmGfsiEkPdSsurpqYPzj
         1TksrWW0i0XQ0pDFeCgjUgTnlSVQE6zyTCR9xBBYAsJftLT6o9LY26gcqncuAFG2q5/o
         QJfC1YgYWXxEMUkSu5xxY+XX8Bmxq/JzWofccmTfktBpzW4JN0BUrBV0FGucLXxObUNq
         HdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wBhO4JctSwtB97vOsr0bCF5NihN5XGwZ+Nb5W+rfZP0=;
        b=h4gEVVU4NcZDK0vxbRo7Isqi9vKEqpux4lKXIBidIhUR6gBL2JlucGxfOmwdH/A0LH
         he1C73mTPV5/ywZt4tKCQrsPMXlDDo7UMikXPoXHSXRjIucidOQKTpmsJnqBDqhdnhKu
         ZVspu5W0lvwt4Q06KrkGxE4Lpvx7onedRyKgng1q2hJ+IBi2+/nql1R7YaN6zjjkBuz8
         N++vUYDGuMcvfN2Lhcu5yGRlqZA7SgvU9/3jFehvHh0WQYeZg9WEoPeE3bp2+WCgA2BQ
         CG38mdzFFKYeN9XCtIGhF4iUzKKxuGXGkmtafGBuI/kliEeeiaDv3+Olvp9qR5ZdEIhm
         xt/w==
X-Gm-Message-State: AOAM533e9A2xQPQ0ewU9knyIYHy4nCoO7x7rfcpxkFQXXqt6k17iAowV
        AL4k/J4FtgtpclgEV+NUMdXNNh4=
X-Google-Smtp-Source: ABdhPJyv7TeYiZ/LMtuevysK93KSJ+xR+0bYhVy3Fs63qLlIMzwT3yEHeaQbJ/iF+scdCjWF/WiGNPU=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:d713:: with SMTP id o19mr106749ybg.378.1605236034085;
 Thu, 12 Nov 2020 18:53:54 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:53:36 -0800
In-Reply-To: <cover.1605235762.git.pcc@google.com>
Message-Id: <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605235762.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
address exposed via siginfo.si_addr and sigcontext.fault_address. However,
the tag bits may be needed by tools in order to accurately diagnose
memory errors, such as HWASan [1] or future tools based on the Memory
Tagging Extension (MTE).

We should not stop clearing these bits in the existing fault address
fields, because there may be existing userspace applications that are
expecting the tag bits to be cleared. Instead, introduce a flag in
sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
there if the signal handler has this flag set.

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446
---
v16:
- add missing file

v15:
- switched to the SA_EXPOSE_TAGBITS approach
  proposed by Eric
- rebased to 5.10-rc3

v14:
- fix an inaccuracy in the commit message
- add some comments to arch_addr_tag_bits_mask

v13:
- renamed si_xflags to si_faultflags
- rebased to 5.10-rc2

v12:
- add new fields to signal_compat.c test cases
- rebased to 5.10-rc1
- mask out bits 63:60 for tag check faults

v11:
- add a comment explaining what the arch hook should do
- rename ignored bits to tag bits

v10:
- rename the flag to SIFAULTFLAG_ADDR_IGNORED_BITS
- use an arch hook to specify which bits are ignored, instead
  of passing them explicitly
- while refactoring for the arch hook, noticed that my previous
  patches missed a case involving cache maintenance instructions,
  so expose the tag bits for that signal as well

v9:
- make the ignored bits fields generic
- add some new dependent patches that prepare us to store the
  field in such a way that userspace can detect their presence

v8:
- rebase onto 5.8rc2

v7:
- switch to a new siginfo field instead of using sigcontext
- merge the patch back into one since the other patches are now
  unnecessary

v6:
- move fault address and fault code into the kernel_siginfo data structure
- split the patch in three since it was getting large and now has
  generic and arch-specific parts

v5:
- add padding to fault_addr_top_byte_context in order to ensure the correct
  size and preserve sp alignment

v4:
- expose only the tag bits in the context instead of the entire FAR_EL1
- remove mention of the new context from the sigcontext.__reserved[] note

v3:
- add documentation to tagged-pointers.rst
- update comments in sigcontext.h

v2:
- revert changes to hw_breakpoint.c
- rename set_thread_esr to set_thread_far_esr

 Documentation/arm64/tagged-pointers.rst | 25 ++++++---
 arch/arm64/include/asm/exception.h      |  2 +-
 arch/arm64/include/asm/signal.h         | 25 +++++++++
 arch/arm64/include/asm/system_misc.h    |  2 +-
 arch/arm64/include/asm/traps.h          |  6 +--
 arch/arm64/kernel/debug-monitors.c      |  5 +-
 arch/arm64/kernel/entry-common.c        |  2 -
 arch/arm64/kernel/ptrace.c              |  7 +--
 arch/arm64/kernel/sys_compat.c          |  5 +-
 arch/arm64/kernel/traps.c               | 29 ++++++-----
 arch/arm64/mm/fault.c                   | 68 ++++++++++++++-----------
 include/linux/signal.h                  | 14 +++++
 include/linux/signal_types.h            |  2 +-
 include/uapi/asm-generic/signal-defs.h  |  3 ++
 kernel/signal.c                         | 23 ++++++---
 15 files changed, 141 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
index eab4323609b9..19d284b70384 100644
--- a/Documentation/arm64/tagged-pointers.rst
+++ b/Documentation/arm64/tagged-pointers.rst
@@ -53,12 +53,25 @@ visibility.
 Preserving tags
 ---------------
 
-Non-zero tags are not preserved when delivering signals. This means that
-signal handlers in applications making use of tags cannot rely on the
-tag information for user virtual addresses being maintained for fields
-inside siginfo_t. One exception to this rule is for signals raised in
-response to watchpoint debug exceptions, where the tag information will
-be preserved.
+When delivering signals, non-zero tags are not preserved in
+siginfo.si_addr unless the flag SA_EXPOSE_TAGBITS was set in
+sigaction.sa_flags when the signal handler was installed. This means
+that signal handlers in applications making use of tags cannot rely
+on the tag information for user virtual addresses being maintained
+in these fields unless the flag was set.
+
+Due to architecture limitations, bits 63:60 of the fault address
+are not preserved in response to synchronous tag check faults
+(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
+treat the values of these bits as undefined in order to accommodate
+future architecture revisions which may preserve the bits.
+
+For signals raised in response to watchpoint debug exceptions, the
+tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
+flag setting.
+
+Non-zero tags are never preserved in sigcontext.fault_address
+regardless of the SA_EXPOSE_TAGBITS flag setting.
 
 The architecture prevents the use of a tagged PC, so the upper byte will
 be set to a sign-extension of bit 55 on exception return.
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 99b9383cd036..2a8aa1884d8a 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -32,7 +32,7 @@ static inline u32 disr_to_esr(u64 disr)
 }
 
 asmlinkage void enter_from_user_mode(void);
-void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
+void do_mem_abort(unsigned long far, unsigned int esr, struct pt_regs *regs);
 void do_undefinstr(struct pt_regs *regs);
 void do_bti(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
new file mode 100644
index 000000000000..ef449f5f4ba8
--- /dev/null
+++ b/arch/arm64/include/asm/signal.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_ASM_SIGNAL_H
+#define __ARM64_ASM_SIGNAL_H
+
+#include <asm/memory.h>
+#include <uapi/asm/signal.h>
+#include <uapi/asm/siginfo.h>
+
+static inline void __user *arch_untagged_si_addr(void __user *addr,
+						 unsigned long sig,
+						 unsigned long si_code)
+{
+	/*
+	 * For historical reasons, all bits of the fault address are exposed as
+	 * address bits for watchpoint exceptions. New architectures should
+	 * handle the tag bits consistently.
+	 */
+	if (sig == SIGTRAP && si_code == TRAP_BRKPT)
+		return addr;
+
+	return untagged_addr(addr);
+}
+#define arch_untagged_si_addr arch_untagged_si_addr
+
+#endif
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 1ab63cfbbaf1..673be2d1263c 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -22,7 +22,7 @@ void die(const char *msg, struct pt_regs *regs, int err);
 
 struct siginfo;
 void arm64_notify_die(const char *str, struct pt_regs *regs,
-		      int signo, int sicode, void __user *addr,
+		      int signo, int sicode, unsigned long far,
 		      int err);
 
 void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d96dc2c7c09d..54f32a0675df 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -26,9 +26,9 @@ void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address, unsigned int err);
 void arm64_notify_segfault(unsigned long addr);
-void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
-void arm64_force_sig_mceerr(int code, void __user *addr, short lsb, const char *str);
-void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr, const char *str);
+void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *str);
+void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *str);
+void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index fa76151de6ff..4f3661eeb7ec 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -234,9 +234,8 @@ static void send_user_sigtrap(int si_code)
 	if (interrupts_enabled(regs))
 		local_irq_enable();
 
-	arm64_force_sig_fault(SIGTRAP, si_code,
-			     (void __user *)instruction_pointer(regs),
-			     "User debug trap");
+	arm64_force_sig_fault(SIGTRAP, si_code, instruction_pointer(regs),
+			      "User debug trap");
 }
 
 static int single_step_handler(unsigned long unused, unsigned int esr,
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 43d4c329775f..dbbddfbf4a72 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -22,7 +22,6 @@ static void notrace el1_abort(struct pt_regs *regs, unsigned long esr)
 	unsigned long far = read_sysreg(far_el1);
 
 	local_daif_inherit(regs);
-	far = untagged_addr(far);
 	do_mem_abort(far, esr, regs);
 }
 NOKPROBE_SYMBOL(el1_abort);
@@ -114,7 +113,6 @@ static void notrace el0_da(struct pt_regs *regs, unsigned long esr)
 
 	user_exit_irqoff();
 	local_daif_restore(DAIF_PROCCTX);
-	far = untagged_addr(far);
 	do_mem_abort(far, esr, regs);
 }
 NOKPROBE_SYMBOL(el0_da);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f49b349e16a3..8ac487c84e37 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -192,14 +192,11 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				break;
 			}
 		}
-		arm64_force_sig_ptrace_errno_trap(si_errno,
-						  (void __user *)bkpt->trigger,
+		arm64_force_sig_ptrace_errno_trap(si_errno, bkpt->trigger,
 						  desc);
 	}
 #endif
-	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT,
-			      (void __user *)(bkpt->trigger),
-			      desc);
+	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT, bkpt->trigger, desc);
 }
 
 /*
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 3c18c2454089..265fe3eb1069 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -68,7 +68,7 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
  */
 long compat_arm_syscall(struct pt_regs *regs, int scno)
 {
-	void __user *addr;
+	unsigned long addr;
 
 	switch (scno) {
 	/*
@@ -111,8 +111,7 @@ long compat_arm_syscall(struct pt_regs *regs, int scno)
 		break;
 	}
 
-	addr  = (void __user *)instruction_pointer(regs) -
-		(compat_thumb_mode(regs) ? 2 : 4);
+	addr = instruction_pointer(regs) - (compat_thumb_mode(regs) ? 2 : 4);
 
 	arm64_notify_die("Oops - bad compat syscall(2)", regs,
 			 SIGILL, ILL_ILLTRP, addr, scno);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8af4e0e85736..f4ddbe9ed3f1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -170,32 +170,32 @@ static void arm64_show_signal(int signo, const char *str)
 	__show_regs(regs);
 }
 
-void arm64_force_sig_fault(int signo, int code, void __user *addr,
+void arm64_force_sig_fault(int signo, int code, unsigned long far,
 			   const char *str)
 {
 	arm64_show_signal(signo, str);
 	if (signo == SIGKILL)
 		force_sig(SIGKILL);
 	else
-		force_sig_fault(signo, code, addr);
+		force_sig_fault(signo, code, (void __user *)far);
 }
 
-void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
+void arm64_force_sig_mceerr(int code, unsigned long far, short lsb,
 			    const char *str)
 {
 	arm64_show_signal(SIGBUS, str);
-	force_sig_mceerr(code, addr, lsb);
+	force_sig_mceerr(code, (void __user *)far, lsb);
 }
 
-void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr,
+void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far,
 				       const char *str)
 {
 	arm64_show_signal(SIGTRAP, str);
-	force_sig_ptrace_errno_trap(errno, addr);
+	force_sig_ptrace_errno_trap(errno, (void __user *)far);
 }
 
 void arm64_notify_die(const char *str, struct pt_regs *regs,
-		      int signo, int sicode, void __user *addr,
+		      int signo, int sicode, unsigned long far,
 		      int err)
 {
 	if (user_mode(regs)) {
@@ -203,7 +203,7 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		current->thread.fault_address = 0;
 		current->thread.fault_code = err;
 
-		arm64_force_sig_fault(signo, sicode, addr, str);
+		arm64_force_sig_fault(signo, sicode, far, str);
 	} else {
 		die(str, regs, err);
 	}
@@ -374,7 +374,7 @@ void force_signal_inject(int signal, int code, unsigned long address, unsigned i
 		signal = SIGKILL;
 	}
 
-	arm64_notify_die(desc, regs, signal, code, (void __user *)address, err);
+	arm64_notify_die(desc, regs, signal, code, address, err);
 }
 
 /*
@@ -385,7 +385,7 @@ void arm64_notify_segfault(unsigned long addr)
 	int code;
 
 	mmap_read_lock(current->mm);
-	if (find_vma(current->mm, addr) == NULL)
+	if (find_vma(current->mm, untagged_addr(addr)) == NULL)
 		code = SEGV_MAPERR;
 	else
 		code = SEGV_ACCERR;
@@ -448,12 +448,13 @@ NOKPROBE_SYMBOL(do_ptrauth_fault);
 
 static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 {
-	unsigned long address;
+	unsigned long tagged_address, address;
 	int rt = ESR_ELx_SYS64_ISS_RT(esr);
 	int crm = (esr & ESR_ELx_SYS64_ISS_CRM_MASK) >> ESR_ELx_SYS64_ISS_CRM_SHIFT;
 	int ret = 0;
 
-	address = untagged_addr(pt_regs_read_reg(regs, rt));
+	tagged_address = pt_regs_read_reg(regs, rt);
+	address = untagged_addr(tagged_address);
 
 	switch (crm) {
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAU:	/* DC CVAU, gets promoted */
@@ -480,7 +481,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	}
 
 	if (ret)
-		arm64_notify_segfault(address);
+		arm64_notify_segfault(tagged_address);
 	else
 		arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
@@ -772,7 +773,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
  */
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 {
-	void __user *pc = (void __user *)instruction_pointer(regs);
+	unsigned long pc = instruction_pointer(regs);
 
 	current->thread.fault_address = 0;
 	current->thread.fault_code = esr;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1ee94002801f..c5375cb7763d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -40,7 +40,7 @@
 #include <asm/traps.h>
 
 struct fault_info {
-	int	(*fn)(unsigned long addr, unsigned int esr,
+	int	(*fn)(unsigned long far, unsigned int esr,
 		      struct pt_regs *regs);
 	int	sig;
 	int	code;
@@ -385,8 +385,11 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
 	current->thread.fault_code = esr;
 }
 
-static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+static void do_bad_area(unsigned long far, unsigned int esr,
+			struct pt_regs *regs)
 {
+	unsigned long addr = untagged_addr(far);
+
 	/*
 	 * If we are in kernel mode at this point, we have no context to
 	 * handle this fault with.
@@ -395,8 +398,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		const struct fault_info *inf = esr_to_fault_info(esr);
 
 		set_thread_esr(addr, esr);
-		arm64_force_sig_fault(inf->sig, inf->code, (void __user *)addr,
-				      inf->name);
+		arm64_force_sig_fault(inf->sig, inf->code, far, inf->name);
 	} else {
 		__do_kernel_fault(addr, esr, regs);
 	}
@@ -448,7 +450,7 @@ static bool is_write_abort(unsigned int esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
-static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
+static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 				   struct pt_regs *regs)
 {
 	const struct fault_info *inf;
@@ -456,6 +458,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
+	unsigned long addr = untagged_addr(far);
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -567,8 +570,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * We had some memory, but were unable to successfully fix up
 		 * this page fault.
 		 */
-		arm64_force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr,
-				      inf->name);
+		arm64_force_sig_fault(SIGBUS, BUS_ADRERR, far, inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -576,8 +578,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
-		arm64_force_sig_mceerr(BUS_MCEERR_AR, (void __user *)addr, lsb,
-				       inf->name);
+		arm64_force_sig_mceerr(BUS_MCEERR_AR, far, lsb, inf->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -585,8 +586,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		arm64_force_sig_fault(SIGSEGV,
 				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
-				      (void __user *)addr,
-				      inf->name);
+				      far, inf->name);
 	}
 
 	return 0;
@@ -596,33 +596,35 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	return 0;
 }
 
-static int __kprobes do_translation_fault(unsigned long addr,
+static int __kprobes do_translation_fault(unsigned long far,
 					  unsigned int esr,
 					  struct pt_regs *regs)
 {
+	unsigned long addr = untagged_addr(far);
+
 	if (is_ttbr0_addr(addr))
-		return do_page_fault(addr, esr, regs);
+		return do_page_fault(far, esr, regs);
 
-	do_bad_area(addr, esr, regs);
+	do_bad_area(far, esr, regs);
 	return 0;
 }
 
-static int do_alignment_fault(unsigned long addr, unsigned int esr,
+static int do_alignment_fault(unsigned long far, unsigned int esr,
 			      struct pt_regs *regs)
 {
-	do_bad_area(addr, esr, regs);
+	do_bad_area(far, esr, regs);
 	return 0;
 }
 
-static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+static int do_bad(unsigned long far, unsigned int esr, struct pt_regs *regs)
 {
 	return 1; /* "fault" */
 }
 
-static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
-	void __user *siaddr;
+	unsigned long siaddr;
 
 	inf = esr_to_fault_info(esr);
 
@@ -635,18 +637,23 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	}
 
 	if (esr & ESR_ELx_FnV)
-		siaddr = NULL;
+		siaddr = 0;
 	else
-		siaddr  = (void __user *)addr;
+		siaddr  = untagged_addr(far);
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
 }
 
-static int do_tag_check_fault(unsigned long addr, unsigned int esr,
+static int do_tag_check_fault(unsigned long far, unsigned int esr,
 			      struct pt_regs *regs)
 {
-	do_bad_area(addr, esr, regs);
+	/*
+	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
+	 * check faults. Mask them out now so that userspace doesn't see them.
+	 */
+	far &= (1UL << 60) - 1;
+	do_bad_area(far, esr, regs);
 	return 0;
 }
 
@@ -717,11 +724,12 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
 };
 
-void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+void do_mem_abort(unsigned long far, unsigned int esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf = esr_to_fault_info(esr);
+	unsigned long addr = untagged_addr(far);
 
-	if (!inf->fn(addr, esr, regs))
+	if (!inf->fn(far, esr, regs))
 		return;
 
 	if (!user_mode(regs)) {
@@ -730,8 +738,7 @@ void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		show_pte(addr);
 	}
 
-	arm64_notify_die(inf->name, regs,
-			 inf->sig, inf->code, (void __user *)addr, esr);
+	arm64_notify_die(inf->name, regs, inf->sig, inf->code, addr, esr);
 }
 NOKPROBE_SYMBOL(do_mem_abort);
 
@@ -744,8 +751,8 @@ NOKPROBE_SYMBOL(do_el0_irq_bp_hardening);
 
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
-	arm64_notify_die("SP/PC alignment exception", regs,
-			 SIGBUS, BUS_ADRALN, (void __user *)addr, esr);
+	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRALN,
+			 addr, esr);
 }
 NOKPROBE_SYMBOL(do_sp_pc_abort);
 
@@ -871,8 +878,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 		arm64_apply_bp_hardening();
 
 	if (inf->fn(addr_if_watchpoint, esr, regs)) {
-		arm64_notify_die(inf->name, regs,
-				 inf->sig, inf->code, (void __user *)pc, esr);
+		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
 	}
 
 	debug_exception_exit(regs);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index b256f9c65661..205526c4003a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -469,4 +469,18 @@ struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
 #endif
 
+#ifndef arch_untagged_si_addr
+/*
+ * Given a fault address and a signal and si_code which correspond to the
+ * _sigfault union member, returns the address that must appear in si_addr if
+ * the signal handler does not have SA_EXPOSE_TAGBITS enabled in sa_flags.
+ */
+static inline void __user *arch_untagged_si_addr(void __user *addr,
+						 unsigned long sig,
+						 unsigned long si_code)
+{
+	return addr;
+}
+#endif
+
 #endif /* _LINUX_SIGNAL_H */
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index a7887ad84d36..68e06c75c5b2 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -78,6 +78,6 @@ struct ksignal {
 
 #define UAPI_SA_FLAGS                                                          \
 	(SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
-	 SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
+	 SA_NODEFER | SA_RESETHAND | SA_EXPOSE_TAGBITS | __ARCH_UAPI_SA_FLAGS)
 
 #endif /* _LINUX_SIGNAL_TYPES_H */
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 0126ebda4d31..5276bdd4a9e2 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -20,6 +20,8 @@
  * so this bit allows flag bit support to be detected from userspace while
  * allowing an old kernel to be distinguished from a kernel that supports every
  * flag bit.
+ * SA_EXPOSE_TAGBITS exposes an architecture-defined set of tag bits in
+ * siginfo.si_addr.
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -49,6 +51,7 @@
 #define SA_RESETHAND	0x80000000
 #endif
 #define SA_UNSUPPORTED	0x00000400
+#define SA_EXPOSE_TAGBITS	0x00000800
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f34819e80de..16be62e6d341 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1650,6 +1650,15 @@ void force_sigsegv(int sig)
 	force_sig(SIGSEGV);
 }
 
+static void __user *get_si_addr(void __user *addr, unsigned long sig,
+				unsigned long si_code)
+{
+	if (current->sighand->action[sig - 1].sa.sa_flags & SA_EXPOSE_TAGBITS)
+		return addr;
+
+	return arch_untagged_si_addr(addr, sig, si_code);
+}
+
 int force_sig_fault_to_task(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
@@ -1661,7 +1670,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code  = code;
-	info.si_addr  = addr;
+	info.si_addr  = get_si_addr(addr, sig, code);
 #ifdef __ARCH_SI_TRAPNO
 	info.si_trapno = trapno;
 #endif
@@ -1693,7 +1702,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 	info.si_signo = sig;
 	info.si_errno = 0;
 	info.si_code  = code;
-	info.si_addr  = addr;
+	info.si_addr  = get_si_addr(addr, sig, code);
 #ifdef __ARCH_SI_TRAPNO
 	info.si_trapno = trapno;
 #endif
@@ -1714,7 +1723,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = code;
-	info.si_addr = addr;
+	info.si_addr = get_si_addr(addr, SIGBUS, code);
 	info.si_addr_lsb = lsb;
 	return force_sig_info(&info);
 }
@@ -1728,7 +1737,7 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = code;
-	info.si_addr = addr;
+	info.si_addr = get_si_addr(addr, SIGBUS, code);
 	info.si_addr_lsb = lsb;
 	return send_sig_info(info.si_signo, &info, t);
 }
@@ -1742,7 +1751,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
 	info.si_code  = SEGV_BNDERR;
-	info.si_addr  = addr;
+	info.si_addr  = get_si_addr(addr, SIGSEGV, SEGV_BNDERR);
 	info.si_lower = lower;
 	info.si_upper = upper;
 	return force_sig_info(&info);
@@ -1757,7 +1766,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
 	info.si_code  = SEGV_PKUERR;
-	info.si_addr  = addr;
+	info.si_addr  = get_si_addr(addr, SIGSEGV, SEGV_PKUERR);
 	info.si_pkey  = pkey;
 	return force_sig_info(&info);
 }
@@ -1774,7 +1783,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	info.si_signo = SIGTRAP;
 	info.si_errno = errno;
 	info.si_code  = TRAP_HWBKPT;
-	info.si_addr  = addr;
+	info.si_addr  = get_si_addr(addr, SIGTRAP, TRAP_HWBKPT);
 	return force_sig_info(&info);
 }
 
-- 
2.29.2.299.gdc1121823c-goog

