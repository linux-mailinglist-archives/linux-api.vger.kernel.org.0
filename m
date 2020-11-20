Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550192BB716
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgKTUeD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 15:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbgKTUeD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 15:34:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B4C0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 12:34:02 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l7so7650751pgq.16
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jjXw7jnqEOMPqMubBvRdxq4jhp3AaPaKRUPPk/9dVOA=;
        b=NCot0hIqwu/a9igt/mc/wk8EN0TnO/LUTxVHAEtst20lfTdV793jymnjtfAHcIj6aj
         EB4u3TFXPm9FYMBsrcnNyMIvwNFsopwpMIZrSk0yZzoFljzYhP6yavO1jdgopsH6BUsl
         pOMXETdbi5ulw09cpDKHV4q6VI7uhbCsuHyR8lAGJjNZyR2krZVZmvuDEisNRq6dh6xs
         KrBxvYOPijbJT7pxEDtI5EsM9ZrMK386V99ZSRCFPTQqOzjtHVIwtJhZY74h5H6H4JIm
         5V+oSeA/MGVl9sPiBE/j9L33deDMBzIZ/I7lLhwYkSmK5qID61mXkxeCKiRjrsOfI69P
         8njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jjXw7jnqEOMPqMubBvRdxq4jhp3AaPaKRUPPk/9dVOA=;
        b=QyNSEMu4CE2xnoVfE3HIctILmH6aaundP7xVZrTX5speScXkAiPL/CwucCXbMsaI/L
         XnkTki6GagLIlSNfJ8TXuWvHmzGa+NUtDAkyXtJepgDjLtYvDqmYRgkZgeLgqnC/1Ls7
         C9vybcS59Hf23NZDJT0mgyXe1jpQ13mJSUtezmUjt9nl/U/HNYNUD8LfEkpKQB9gOS2p
         G4CvATIgUjNrbdZpQh8CiUAyv4g38W0Op/itWMAsGrpS8IqQtPOM+8X/p42aaQ6JwdXS
         GyRorW1M8NePeD37lXV2UxoZQP2YrVSyGyWiZCDW11r9uGI7PcP9UUCqIpH/gNob4jEw
         8WKQ==
X-Gm-Message-State: AOAM53344VJ+vVyC9mgyKnzRt9IAx+WhJveII7qlPh3g7u+RMyh5i6oT
        nTivWHgNieaSaaUbuqUpB00oluE=
X-Google-Smtp-Source: ABdhPJzwvFGQZdP2RH5tsHcBuv97jFvKxBIruOD7FNxtvXZfhcI0a2yIaH+SZ5TcmB11EboJXBARR08=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a05:6a00:794:b029:197:e418:ac4d with SMTP id
 g20-20020a056a000794b0290197e418ac4dmr1543653pfu.47.1605904442439; Fri, 20
 Nov 2020 12:34:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:33:46 -0800
In-Reply-To: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
Message-Id: <0010296597784267472fa13b39f8238d87a72cf8.1605904350.git.pcc@google.com>
Mime-Version: 1.0
References: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v21 2/2] arm64: expose FAR_EL1 tag bits in siginfo
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

Expose these bits via the arch_untagged_si_addr mechanism, so that
they are only exposed to signal handlers with the SA_EXPOSE_TAGBITS
flag set.

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446
---
v21:
- split out the arch-generic part
- add some comments

v20:
- use the sigaction copy

v19:
- move the code for hiding the tag bits outside the lock

v18:
- move the SA_EXPOSE_TAGBITS handling to get_signal

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

 Documentation/arm64/tagged-pointers.rst | 25 ++++++--
 arch/arm64/include/asm/exception.h      |  2 +-
 arch/arm64/include/asm/signal.h         | 25 ++++++++
 arch/arm64/include/asm/system_misc.h    |  2 +-
 arch/arm64/include/asm/traps.h          |  6 +-
 arch/arm64/kernel/debug-monitors.c      |  5 +-
 arch/arm64/kernel/entry-common.c        |  2 -
 arch/arm64/kernel/ptrace.c              |  7 +--
 arch/arm64/kernel/sys_compat.c          |  5 +-
 arch/arm64/kernel/traps.c               | 29 ++++-----
 arch/arm64/mm/fault.c                   | 83 +++++++++++++++----------
 11 files changed, 120 insertions(+), 71 deletions(-)
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
index 1ee94002801f..29a6b8c9e830 100644
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
 
@@ -634,19 +636,30 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		return 0;
 	}
 
-	if (esr & ESR_ELx_FnV)
-		siaddr = NULL;
-	else
-		siaddr  = (void __user *)addr;
+	if (esr & ESR_ELx_FnV) {
+		siaddr = 0;
+	} else {
+		/*
+		 * The architecture specifies that the tag bits of FAR_EL1 are
+		 * UNKNOWN for synchronous external aborts. Mask them out now
+		 * so that userspace doesn't see them.
+		 */
+		siaddr  = untagged_addr(far);
+	}
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
 
@@ -717,11 +730,12 @@ static const struct fault_info fault_info[] = {
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
@@ -730,8 +744,12 @@ void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		show_pte(addr);
 	}
 
-	arm64_notify_die(inf->name, regs,
-			 inf->sig, inf->code, (void __user *)addr, esr);
+	/*
+	 * At this point we have an unrecognized fault type whose tag bits may
+	 * have been defined as UNKNOWN. Therefore we only expose the untagged
+	 * address to the signal handler.
+	 */
+	arm64_notify_die(inf->name, regs, inf->sig, inf->code, addr, esr);
 }
 NOKPROBE_SYMBOL(do_mem_abort);
 
@@ -744,8 +762,8 @@ NOKPROBE_SYMBOL(do_el0_irq_bp_hardening);
 
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
-	arm64_notify_die("SP/PC alignment exception", regs,
-			 SIGBUS, BUS_ADRALN, (void __user *)addr, esr);
+	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRALN,
+			 addr, esr);
 }
 NOKPROBE_SYMBOL(do_sp_pc_abort);
 
@@ -871,8 +889,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 		arm64_apply_bp_hardening();
 
 	if (inf->fn(addr_if_watchpoint, esr, regs)) {
-		arm64_notify_die(inf->name, regs,
-				 inf->sig, inf->code, (void __user *)pc, esr);
+		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
 	}
 
 	debug_exception_exit(regs);
-- 
2.29.2.454.gaff20da3a2-goog

