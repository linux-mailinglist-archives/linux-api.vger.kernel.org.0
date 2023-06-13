Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8A72D612
	for <lists+linux-api@lfdr.de>; Tue, 13 Jun 2023 02:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbjFMAQ5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jun 2023 20:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjFMAQR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jun 2023 20:16:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9F2957;
        Mon, 12 Jun 2023 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615210; x=1718151210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WchKfqQNnYFXXNMxX3TqxAMzB4S9WkAXS/aRm3qIr7o=;
  b=Al0xAI+PUFsEVN9pTNbLZHllXr+EHXB/PJSOsmYJLEvdTGYC3TbIlpAW
   2hsIMbn0kst0HAZL4+s3OS1bnAkD08OMjMzrFTbBc6dkIcETtFXA9Hkqc
   2Zsu7jSgXvRuV1tBiUuv0bFUv2tfniDxMQjajOmnIy5fWHvEwctHXRF7g
   xcpBMZ9TUByTRHVWZtn3iMZX4qKTSrbUXMHRZXNvDmNPNHhvMUjWI/ri4
   6QRLgNI0BpLF2v93dkuQbSctgOzmpYPtLDa+1WlB6OTOQWCtT8ylfHIqh
   hPygRV21tSvBgQUHpEJLxgaF5oshbpcwUqxoaA/h8jHvFsIXvU9RANpoL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557292"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671087"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671087"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:30 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 27/42] x86/shstk: Add user control-protection fault handler
Date:   Mon, 12 Jun 2023 17:10:53 -0700
Message-Id: <20230613001108.3040476-28-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A control-protection fault is triggered when a control-flow transfer
attempt violates Shadow Stack or Indirect Branch Tracking constraints.
For example, the return address for a RET instruction differs from the copy
on the shadow stack.

There already exists a control-protection fault handler for handling kernel
IBT faults. Refactor this fault handler into separate user and kernel
handlers, like the page fault handler. Add a control-protection handler
for usermode. To avoid ifdeffery, put them both in a new file cet.c, which
is compiled in the case of either of the two CET features supported in the
kernel: kernel IBT or user mode shadow stack. Move some static inline
functions from traps.c into a header so they can be used in cet.c.

Opportunistically fix a comment in the kernel IBT part of the fault
handler that is on the end of the line instead of preceding it.

Keep the same behavior for the kernel side of the fault handler, except for
converting a BUG to a WARN in the case of a #CP happening when the feature
is missing. This unifies the behavior with the new shadow stack code, and
also prevents the kernel from crashing under this situation which is
potentially recoverable.

The control-protection fault handler works in a similar way as the general
protection fault handler. It provides the si_code SEGV_CPERR to the signal
handler.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/signal.c                 |  2 +-
 arch/arm64/kernel/signal.c               |  2 +-
 arch/arm64/kernel/signal32.c             |  2 +-
 arch/sparc/kernel/signal32.c             |  2 +-
 arch/sparc/kernel/signal_64.c            |  2 +-
 arch/x86/include/asm/disabled-features.h |  8 +-
 arch/x86/include/asm/idtentry.h          |  2 +-
 arch/x86/include/asm/traps.h             | 12 +++
 arch/x86/kernel/cet.c                    | 94 +++++++++++++++++++++---
 arch/x86/kernel/idt.c                    |  2 +-
 arch/x86/kernel/signal_32.c              |  2 +-
 arch/x86/kernel/signal_64.c              |  2 +-
 arch/x86/kernel/traps.c                  | 12 ---
 arch/x86/xen/enlighten_pv.c              |  2 +-
 arch/x86/xen/xen-asm.S                   |  2 +-
 include/uapi/asm-generic/siginfo.h       |  3 +-
 16 files changed, 117 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index e07f359254c3..9a3c9de5ac5e 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -681,7 +681,7 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 2cfc810d0a5b..06d31731c8ed 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1343,7 +1343,7 @@ void __init minsigstksz_setup(void)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 4700f8522d27..bbd542704730 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -460,7 +460,7 @@ void compat_setup_restart_syscall(struct pt_regs *regs)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index dad38960d1a8..82da8a2d769d 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -751,7 +751,7 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 570e43e6fda5..b4e410976e0d 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -562,7 +562,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index b9c7eae2e70f..702d93fdd10e 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -111,6 +111,12 @@
 #define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+#define DISABLE_IBT	0
+#else
+#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -134,7 +140,7 @@
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK18	0
+#define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b241af4ce9b4..61e0e6301f09 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -614,7 +614,7 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
 #endif
 
 /* #CP */
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 47ecfff2c83d..75e0dabf0c45 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -47,4 +47,16 @@ void __noreturn handle_stack_overflow(struct pt_regs *regs,
 				      struct stack_info *info);
 #endif
 
+static inline void cond_local_irq_enable(struct pt_regs *regs)
+{
+	if (regs->flags & X86_EFLAGS_IF)
+		local_irq_enable();
+}
+
+static inline void cond_local_irq_disable(struct pt_regs *regs)
+{
+	if (regs->flags & X86_EFLAGS_IF)
+		local_irq_disable();
+}
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 7ad22b705b64..cc10d8be9d74 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -4,10 +4,6 @@
 #include <asm/bugs.h>
 #include <asm/traps.h>
 
-static __ro_after_init bool ibt_fatal = true;
-
-extern void ibt_selftest_ip(void); /* code label defined in asm below */
-
 enum cp_error_code {
 	CP_EC        = (1 << 15) - 1,
 
@@ -20,15 +16,80 @@ enum cp_error_code {
 	CP_ENCL	     = 1 << 15,
 };
 
-DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+static const char cp_err[][10] = {
+	[0] = "unknown",
+	[1] = "near ret",
+	[2] = "far/iret",
+	[3] = "endbranch",
+	[4] = "rstorssp",
+	[5] = "setssbsy",
+};
+
+static const char *cp_err_string(unsigned long error_code)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
-		pr_err("Unexpected #CP\n");
-		BUG();
+	unsigned int cpec = error_code & CP_EC;
+
+	if (cpec >= ARRAY_SIZE(cp_err))
+		cpec = 0;
+	return cp_err[cpec];
+}
+
+static void do_unexpected_cp(struct pt_regs *regs, unsigned long error_code)
+{
+	WARN_ONCE(1, "Unexpected %s #CP, error_code: %s\n",
+		  user_mode(regs) ? "user mode" : "kernel mode",
+		  cp_err_string(error_code));
+}
+
+static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
+static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	struct task_struct *tsk;
+	unsigned long ssp;
+
+	/*
+	 * An exception was just taken from userspace. Since interrupts are disabled
+	 * here, no scheduling should have messed with the registers yet and they
+	 * will be whatever is live in userspace. So read the SSP before enabling
+	 * interrupts so locking the fpregs to do it later is not required.
+	 */
+	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+
+	cond_local_irq_enable(regs);
+
+	tsk = current;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_CP;
+
+	/* Ratelimit to prevent log spamming. */
+	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
+	    __ratelimit(&cpf_rate)) {
+		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)%s",
+			 tsk->comm, task_pid_nr(tsk),
+			 regs->ip, regs->sp, ssp, error_code,
+			 cp_err_string(error_code),
+			 error_code & CP_ENCL ? " in enclave" : "");
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
 	}
 
-	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
+	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
+	cond_local_irq_disable(regs);
+}
+
+static __ro_after_init bool ibt_fatal = true;
+
+/* code label defined in asm below */
+extern void ibt_selftest_ip(void);
+
+static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	if ((error_code & CP_EC) != CP_ENDBR) {
+		do_unexpected_cp(regs, error_code);
 		return;
+	}
 
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
 		regs->ax = 0;
@@ -74,3 +135,18 @@ static int __init ibt_setup(char *str)
 }
 
 __setup("ibt=", ibt_setup);
+
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	if (user_mode(regs)) {
+		if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+			do_user_cp_fault(regs, error_code);
+		else
+			do_unexpected_cp(regs, error_code);
+	} else {
+		if (cpu_feature_enabled(X86_FEATURE_IBT))
+			do_kernel_cp_fault(regs, error_code);
+		else
+			do_unexpected_cp(regs, error_code);
+	}
+}
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..5074b8420359 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -107,7 +107,7 @@ static const __initconst struct idt_data def_idts[] = {
 	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
 #endif
 
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 	INTG(X86_TRAP_CP,		asm_exc_control_protection),
 #endif
 
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f97..c12624bc82a3 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -402,7 +402,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 */
 static_assert(NSIGILL  == 11);
 static_assert(NSIGFPE  == 15);
-static_assert(NSIGSEGV == 9);
+static_assert(NSIGSEGV == 10);
 static_assert(NSIGBUS  == 5);
 static_assert(NSIGTRAP == 6);
 static_assert(NSIGCHLD == 6);
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 13a1e6083837..0e808c72bf7e 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -403,7 +403,7 @@ void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 */
 static_assert(NSIGILL  == 11);
 static_assert(NSIGFPE  == 15);
-static_assert(NSIGSEGV == 9);
+static_assert(NSIGSEGV == 10);
 static_assert(NSIGBUS  == 5);
 static_assert(NSIGTRAP == 6);
 static_assert(NSIGCHLD == 6);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6f666dfa97de..f358350624b2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -77,18 +77,6 @@
 
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
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 093b78c8bbec..5a034a994682 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -640,7 +640,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
 	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 	TRAP_ENTRY(exc_control_protection,		false ),
 #endif
 };
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 08f1ceb9eb81..9e5e68008785 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -148,7 +148,7 @@ xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 xen_pv_trap asm_exc_control_protection
 #endif
 #ifdef CONFIG_X86_MCE
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index ffbe4cec9f32..0f52d0ac47c5 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -242,7 +242,8 @@ typedef struct siginfo {
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
 #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
 #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
-#define NSIGSEGV	9
+#define SEGV_CPERR	10	/* Control protection fault */
+#define NSIGSEGV	10
 
 /*
  * SIGBUS si_codes
-- 
2.34.1

