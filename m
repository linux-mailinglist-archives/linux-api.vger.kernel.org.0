Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553E1287F8F
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 02:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgJIAow (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Oct 2020 20:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAov (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Oct 2020 20:44:51 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78590C0613D2
        for <linux-api@vger.kernel.org>; Thu,  8 Oct 2020 17:44:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c19so5347445qkk.20
        for <linux-api@vger.kernel.org>; Thu, 08 Oct 2020 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Jdso/8bHNkC7fyszmrqDMhC+gy5VV0QM3Uz5mxvQO1w=;
        b=Jy34MJt39BRdi+9h3rlcyslZ9m9AgMB0KEEwR8fYGq4Mb8W5PEgXZJstqir3Ya+snj
         bn960zk+EtbsjM8/E6wTn+WEn+CNlQMpgr6iLFR4XThiTVF/NKGeu58K3jVSjm04Hu70
         VnvaLbY4Jg1w9DOL1eUMCtcaHcXn0Ppv2wxJWo6/uAoc18J0xREeDPpF5TGT98b7j7Bd
         nuiEWoTEj3guHCyVvPsxInTR8TueNM+HqwwWvIHlJpFrqXTIFyVwNfYfhAz85J3PIrHk
         6r4wWGbZOGXeU5UVE9cIFSV45vM0KnfvyeVprEEMytt4TFbe//KcRYcvLJuYgWEbzjFn
         NYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jdso/8bHNkC7fyszmrqDMhC+gy5VV0QM3Uz5mxvQO1w=;
        b=ea6fP+cF0bxlB9EUjwyMVP29DOMNGqhKpF7mftfiPzPMnVX/Cd8wIq5IxJ/251ZLNI
         l6SZssvm+WZmO6TyKfzCqlAZbdo7KUpy8kA+NbulNOaLPKr5ttiKIFY0HqrKy0/Gqjm9
         2gso82/BRCGqTZFTpUuU7qc8LNSAU9eoMNWALFBjStedO7rT/fPIJ955+p1waQ5t9o+Y
         b9xRADRoZk1V/fATXnlkj5mbKLow3M13zVDdH1VMdbkEObyrZYlTQyf/Ef7/zFaMwzVW
         0IycUNGSXbHLPr8HAsstioGyfrXQnyhUmJwPBSG2LeZh0dnAS/4GtwNuIdH06N2Z7Eow
         5+GQ==
X-Gm-Message-State: AOAM533SVvhSl5YBfSOwjlWWFZs+45qok8N0gnd5oEYeQcQFBj1Pbnlp
        hDkbmwXPzWVIFS3vgumOc8NJLZE=
X-Google-Smtp-Source: ABdhPJwsNy+g6UtoTH1GS2S4pyJo3+huy79A8kpEg/p+bD2er+NCoknMyx+vZ6cSj+6v8D7aE/OenHs=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:ad4:42b3:: with SMTP id e19mr10373203qvr.6.1602204290605;
 Thu, 08 Oct 2020 17:44:50 -0700 (PDT)
Date:   Thu,  8 Oct 2020 17:44:19 -0700
In-Reply-To: <cover.1602204097.git.pcc@google.com>
Message-Id: <85edee0c4c0b3e44be7ce36fa066610dc3f78a92.1602204097.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602204097.git.pcc@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v11 8/8] arm64: expose FAR_EL1 tag bits in siginfo
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
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
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
expecting the tag bits to be cleared. Instead, create a new pair of
union fields in siginfo._sigfault, and store the tag bits of FAR_EL1
there, together with a mask specifying which bits are valid.

A flag is added to si_xflags to allow userspace to determine whether
the values in the fields are valid.

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ia8876bad8c798e0a32df7c2ce1256c4771c81446
---
v11:
- add a comment explaining what the arch hook should do
- rename ignored bits to tag bits

v10:
- rename the flag to SIXFLAG_ADDR_IGNORED_BITS
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

 Documentation/arm64/tagged-pointers.rst | 21 ++++++---
 arch/arm64/include/asm/exception.h      |  2 +-
 arch/arm64/include/asm/signal.h         | 17 +++++++
 arch/arm64/include/asm/system_misc.h    |  2 +-
 arch/arm64/include/asm/traps.h          |  6 +--
 arch/arm64/kernel/debug-monitors.c      |  5 +--
 arch/arm64/kernel/entry-common.c        |  2 -
 arch/arm64/kernel/ptrace.c              |  7 +--
 arch/arm64/kernel/sys_compat.c          |  5 +--
 arch/arm64/kernel/traps.c               | 29 ++++++------
 arch/arm64/mm/fault.c                   | 59 +++++++++++++------------
 arch/x86/kernel/signal_compat.c         |  4 +-
 include/linux/compat.h                  |  2 +
 include/linux/signal.h                  | 16 +++++++
 include/uapi/asm-generic/siginfo.h      | 10 +++++
 kernel/signal.c                         | 18 +++++++-
 16 files changed, 134 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal.h

diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
index eab4323609b9..032c09a876f4 100644
--- a/Documentation/arm64/tagged-pointers.rst
+++ b/Documentation/arm64/tagged-pointers.rst
@@ -53,12 +53,21 @@ visibility.
 Preserving tags
 ---------------
 
-Non-zero tags are not preserved when delivering signals. This means that
-signal handlers in applications making use of tags cannot rely on the
-tag information for user virtual addresses being maintained for fields
-inside siginfo_t. One exception to this rule is for signals raised in
-response to watchpoint debug exceptions, where the tag information will
-be preserved.
+Non-zero tags are not preserved in the fault address fields
+siginfo.si_addr or sigcontext.fault_address when delivering
+signals. This means that signal handlers in applications making use
+of tags cannot rely on the tag information for user virtual addresses
+being maintained in these fields. One exception to this rule is for
+signals raised in response to watchpoint debug exceptions, where the
+tag information will be preserved.
+
+The fault address tag is preserved in the si_addr_tag_bits field
+of siginfo, which is set for signals raised in response to data aborts
+and instruction aborts. The si_addr_tag_bits_mask field indicates
+which bits of the field are valid. The validity of these fields is
+indicated by the SIXFLAG_ADDR_TAG_BITS flag in siginfo.si_xflags,
+and the validity of si_xflags in turn is indicated by the kernel
+indicating support for the sigaction.sa_flags flag SA_XFLAGS.
 
 The architecture prevents the use of a tagged PC, so the upper byte will
 be set to a sign-extension of bit 55 on exception return.
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 7577a754d443..950d55dae948 100644
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
index 000000000000..01cb002feacb
--- /dev/null
+++ b/arch/arm64/include/asm/signal.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_ASM_SIGNAL_H
+#define __ARM64_ASM_SIGNAL_H
+
+#include <uapi/asm/signal.h>
+#include <uapi/asm/siginfo.h>
+
+static inline unsigned long arch_addr_tag_bits_mask(unsigned long sig,
+						    unsigned long si_code)
+{
+	if (sig == SIGTRAP && si_code == TRAP_BRKPT)
+		return 0;
+	return 0xffUL << 56;
+}
+#define arch_addr_tag_bits_mask arch_addr_tag_bits_mask
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
index cee5928e1b7d..9bb5376608d3 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -26,9 +26,9 @@ void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 void force_signal_inject(int signal, int code, unsigned long address);
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
index 7310a4f7f993..943e932def37 100644
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
index d3be9dbf5490..65ed01606480 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -22,7 +22,6 @@ static void notrace el1_abort(struct pt_regs *regs, unsigned long esr)
 	unsigned long far = read_sysreg(far_el1);
 
 	local_daif_inherit(regs);
-	far = untagged_addr(far);
 	do_mem_abort(far, esr, regs);
 }
 NOKPROBE_SYMBOL(el1_abort);
@@ -104,7 +103,6 @@ static void notrace el0_da(struct pt_regs *regs, unsigned long esr)
 
 	user_exit_irqoff();
 	local_daif_restore(DAIF_PROCCTX);
-	far = untagged_addr(far);
 	do_mem_abort(far, esr, regs);
 }
 NOKPROBE_SYMBOL(el0_da);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d8ebfd813e28..3f12c731fa9a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -191,14 +191,11 @@ static void ptrace_hbptriggered(struct perf_event *bp,
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
index 13ebd5ca2070..8f8105076f92 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -234,32 +234,32 @@ static void arm64_show_signal(int signo, const char *str)
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
@@ -267,7 +267,7 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		current->thread.fault_address = 0;
 		current->thread.fault_code = err;
 
-		arm64_force_sig_fault(signo, sicode, addr, str);
+		arm64_force_sig_fault(signo, sicode, far, str);
 	} else {
 		die(str, regs, err);
 	}
@@ -438,7 +438,7 @@ void force_signal_inject(int signal, int code, unsigned long address)
 		signal = SIGKILL;
 	}
 
-	arm64_notify_die(desc, regs, signal, code, (void __user *)address, 0);
+	arm64_notify_die(desc, regs, signal, code, address, 0);
 }
 
 /*
@@ -449,7 +449,7 @@ void arm64_notify_segfault(unsigned long addr)
 	int code;
 
 	mmap_read_lock(current->mm);
-	if (find_vma(current->mm, addr) == NULL)
+	if (find_vma(current->mm, untagged_addr(addr)) == NULL)
 		code = SEGV_MAPERR;
 	else
 		code = SEGV_ACCERR;
@@ -501,12 +501,13 @@ NOKPROBE_SYMBOL(do_bti);
 
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
@@ -533,7 +534,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	}
 
 	if (ret)
-		arm64_notify_segfault(address);
+		arm64_notify_segfault(tagged_address);
 	else
 		arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
@@ -824,7 +825,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
  */
 void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
 {
-	void __user *pc = (void __user *)instruction_pointer(regs);
+	unsigned long pc = instruction_pointer(regs);
 
 	current->thread.fault_address = 0;
 	current->thread.fault_code = esr;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f07333e86c2f..d17953d9b3d9 100644
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
@@ -383,8 +383,11 @@ static void set_thread_esr(unsigned long address, unsigned int esr)
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
@@ -393,8 +396,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		const struct fault_info *inf = esr_to_fault_info(esr);
 
 		set_thread_esr(addr, esr);
-		arm64_force_sig_fault(inf->sig, inf->code, (void __user *)addr,
-				      inf->name);
+		arm64_force_sig_fault(inf->sig, inf->code, far, inf->name);
 	} else {
 		__do_kernel_fault(addr, esr, regs);
 	}
@@ -446,7 +448,7 @@ static bool is_write_abort(unsigned int esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
-static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
+static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 				   struct pt_regs *regs)
 {
 	const struct fault_info *inf;
@@ -454,6 +456,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
+	unsigned long addr = untagged_addr(far);
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -565,8 +568,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 * We had some memory, but were unable to successfully fix up
 		 * this page fault.
 		 */
-		arm64_force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr,
-				      inf->name);
+		arm64_force_sig_fault(SIGBUS, BUS_ADRERR, far, inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -574,8 +576,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
-		arm64_force_sig_mceerr(BUS_MCEERR_AR, (void __user *)addr, lsb,
-				       inf->name);
+		arm64_force_sig_mceerr(BUS_MCEERR_AR, far, lsb, inf->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -583,8 +584,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		arm64_force_sig_fault(SIGSEGV,
 				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
-				      (void __user *)addr,
-				      inf->name);
+				      far, inf->name);
 	}
 
 	return 0;
@@ -594,33 +594,35 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
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
 
@@ -633,9 +635,9 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	}
 
 	if (esr & ESR_ELx_FnV)
-		siaddr = NULL;
+		siaddr = 0;
 	else
-		siaddr  = (void __user *)addr;
+		siaddr  = untagged_addr(far);
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
@@ -708,11 +710,12 @@ static const struct fault_info fault_info[] = {
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
@@ -721,8 +724,7 @@ void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		show_pte(addr);
 	}
 
-	arm64_notify_die(inf->name, regs,
-			 inf->sig, inf->code, (void __user *)addr, esr);
+	arm64_notify_die(inf->name, regs, inf->sig, inf->code, addr, esr);
 }
 NOKPROBE_SYMBOL(do_mem_abort);
 
@@ -735,8 +737,8 @@ NOKPROBE_SYMBOL(do_el0_irq_bp_hardening);
 
 void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
-	arm64_notify_die("SP/PC alignment exception", regs,
-			 SIGBUS, BUS_ADRALN, (void __user *)addr, esr);
+	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRALN,
+			 addr, esr);
 }
 NOKPROBE_SYMBOL(do_sp_pc_abort);
 
@@ -862,8 +864,7 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 		arm64_apply_bp_hardening();
 
 	if (inf->fn(addr_if_watchpoint, esr, regs)) {
-		arm64_notify_die(inf->name, regs,
-				 inf->sig, inf->code, (void __user *)pc, esr);
+		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
 	}
 
 	debug_exception_exit(regs);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 6b99f0c8a068..9a40c47f66c2 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -121,8 +121,8 @@ static inline void signal_compat_build_tests(void)
 #endif
 
 	CHECK_CSI_OFFSET(_sigfault);
-	CHECK_CSI_SIZE  (_sigfault, 8*sizeof(int));
-	CHECK_SI_SIZE   (_sigfault, 16*sizeof(int));
+	CHECK_CSI_SIZE  (_sigfault, 10*sizeof(int));
+	CHECK_SI_SIZE   (_sigfault, 20*sizeof(int));
 
 	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x10);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr) != 0x0C);
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 758f95aff5b5..cf9ff9d4e816 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -234,6 +234,8 @@ typedef struct compat_siginfo {
 				compat_uptr_t _pad[6];
 			};
 			u64 _xflags;
+			compat_uptr_t _addr_tag_bits;
+			compat_uptr_t _addr_tag_bits_mask;
 		} _sigfault;
 
 		/* SIGPOLL */
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9b7fef0c559d..e12f211f5c12 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -480,4 +480,20 @@ struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
 #endif
 
+#ifndef arch_addr_tag_bits_mask
+/*
+ * Given a signal and si_code which correspond to the _sigfault union member,
+ * if tag bits are present in the fault address which must appear in
+ * si_addr_tag_bits instead of si_addr, this hook must return a bitmask where 1
+ * corresponds to bits appearing in si_addr_tag_bits and 0 corresponds to bits
+ * appearing in si_addr. The value returned by this function will also be
+ * available in si_addr_tag_bits_mask.
+ */
+static inline unsigned long arch_addr_tag_bits_mask(unsigned long sig,
+						    unsigned long si_code)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_SIGNAL_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index fc12513f5d09..07fac6d409f5 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -94,6 +94,8 @@ union __sifields {
 			void *_pad[6];
 		};
 		u64 _xflags;
+		unsigned long _addr_tag_bits;
+		unsigned long _addr_tag_bits_mask;
 	} _sigfault;
 
 	/* SIGPOLL */
@@ -156,6 +158,8 @@ typedef struct siginfo {
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
 /* si_xflags is only valid if 0 < si_code < SI_KERNEL */
 #define si_xflags	_sifields._sigfault._xflags
+#define si_addr_tag_bits	_sifields._sigfault._addr_tag_bits
+#define si_addr_tag_bits_mask	_sifields._sigfault._addr_tag_bits_mask
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
@@ -296,6 +300,12 @@ typedef struct siginfo {
 #define EMT_TAGOVF	1	/* tag overflow */
 #define NSIGEMT		1
 
+/*
+ * SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT si_xflags
+ */
+#define SIXFLAG_ADDR_TAG_BITS	1
+/* si_addr_tag_bits{,_mask} fields valid */
+
 /*
  * sigevent definitions
  * 
diff --git a/kernel/signal.c b/kernel/signal.c
index 5c715a01942f..f41b40c9caf1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1652,11 +1652,16 @@ void force_sigsegv(int sig)
 static void set_sigfault_common_fields(struct kernel_siginfo *info, int sig,
 				       int code, void __user *addr)
 {
+	unsigned long addr_long = (unsigned long)addr;
+	unsigned long tag_bits_mask = arch_addr_tag_bits_mask(sig, code);
+
 	info->si_signo = sig;
 	info->si_errno = 0;
 	info->si_code = code;
-	info->si_addr = addr;
-	info->si_xflags = 0;
+	info->si_addr = (void __user *)(addr_long & ~tag_bits_mask);
+	info->si_xflags = SIXFLAG_ADDR_TAG_BITS;
+	info->si_addr_tag_bits = addr_long & tag_bits_mask;
+	info->si_addr_tag_bits_mask = tag_bits_mask;
 }
 
 int force_sig_fault_to_task(int sig, int code, void __user *addr
@@ -3271,6 +3276,13 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		to->si_trapno = from->si_trapno;
 #endif
 		to->si_xflags = from->si_xflags;
+		/*
+		 * These assignments involve a truncation, but as with si_addr
+		 * they will be derived from a 32-bit fault address so we
+		 * should not expect any truncation in practice.
+		 */
+		to->si_addr_tag_bits = from->si_addr_tag_bits;
+		to->si_addr_tag_bits_mask = from->si_addr_tag_bits_mask;
 	}
 
 	switch (layout) {
@@ -3347,6 +3359,8 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		to->si_trapno = from->si_trapno;
 #endif
 		to->si_xflags = from->si_xflags;
+		to->si_addr_tag_bits = from->si_addr_tag_bits;
+		to->si_addr_tag_bits_mask = from->si_addr_tag_bits_mask;
 	}
 
 	switch (layout) {
-- 
2.28.0.1011.ga647a8990f-goog

