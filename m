Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F73278F38
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYQ7k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 12:59:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:28344 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgIYQ7j (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 25 Sep 2020 12:59:39 -0400
IronPort-SDR: yBZ1rEq6ydFN2eqs8T655QXMZkOOZ6j84HMrbp7KGK5MmPWBz9KqKpsmU3LssCY/fX51aKyb1z
 kSNQ5ku8LvbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="158942259"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="158942259"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:57:16 -0700
IronPort-SDR: oAhpvDyQfu3Ob5yS4gn2h7BMsyP/9git+o+mrcL/hLp/0ifyHu9SYnAqQcn3kvvPkdCuEY220g
 +32rvFq05W+Q==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="487499144"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:57:15 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v13 04/26] x86/cet: Add control-protection fault handler
Date:   Fri, 25 Sep 2020 07:56:27 -0700
Message-Id: <20200925145649.5438-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925145649.5438-1-yu-cheng.yu@intel.com>
References: <20200925145649.5438-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A control-protection fault is triggered when a control-flow transfer
attempt violates Shadow Stack or Indirect Branch Tracking constraints.
For example, the return address for a RET instruction differs from the copy
on the Shadow Stack; or an indirect JMP instruction, without the NOTRACK
prefix, arrives at a non-ENDBR opcode.

The control-protection fault handler works in a similar way as the general
protection fault handler.  It provides the si_code SEGV_CPERR to the signal
handler.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v13:
- Change X86_INTEL_* to X86_*.

v10:
- Change CONFIG_X86_64 to CONFIG_X86_INTEL_CET.

v9:
- Add Shadow Stack pointer to the fault printout.

 arch/x86/include/asm/idtentry.h    |  4 ++
 arch/x86/kernel/idt.c              |  4 ++
 arch/x86/kernel/signal_compat.c    |  2 +-
 arch/x86/kernel/traps.c            | 59 ++++++++++++++++++++++++++++++
 include/uapi/asm-generic/siginfo.h |  3 +-
 5 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a43366191212..6293d94b9b66 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -532,6 +532,10 @@ DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_GP,	exc_general_protection);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_AC,	exc_alignment_check);
 
+#ifdef CONFIG_X86_CET
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP, exc_control_protection);
+#endif
+
 /* Raw exception entries which need extra work */
 DECLARE_IDTENTRY_RAW(X86_TRAP_UD,		exc_invalid_op);
 DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 7ecf9babf0cb..34f2a7383d5d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -112,6 +112,10 @@ static const __initconst struct idt_data def_idts[] = {
 #elif defined(CONFIG_X86_32)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
 #endif
+
+#ifdef CONFIG_X86_CET
+	INTG(X86_TRAP_CP,		asm_exc_control_protection),
+#endif
 };
 
 /*
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 9ccbf0576cd0..c572a3de1037 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
 	 */
 	BUILD_BUG_ON(NSIGILL  != 11);
 	BUILD_BUG_ON(NSIGFPE  != 15);
-	BUILD_BUG_ON(NSIGSEGV != 7);
+	BUILD_BUG_ON(NSIGSEGV != 8);
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 81a2fb711091..97a049258e33 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -597,6 +597,65 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#ifdef CONFIG_X86_CET
+static const char * const control_protection_err[] = {
+	"unknown",
+	"near-ret",
+	"far-ret/iret",
+	"endbranch",
+	"rstorssp",
+	"setssbsy",
+};
+
+/*
+ * When a control protection exception occurs, send a signal
+ * to the responsible application.  Currently, control
+ * protection is only enabled for the user mode.  This
+ * exception should not come from the kernel mode.
+ */
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	struct task_struct *tsk;
+
+	if (notify_die(DIE_TRAP, "control protection fault", regs,
+		       error_code, X86_TRAP_CP, SIGSEGV) == NOTIFY_STOP)
+		return;
+	cond_local_irq_enable(regs);
+
+	if (!user_mode(regs))
+		die("kernel control protection fault", regs, error_code);
+
+	if (!static_cpu_has(X86_FEATURE_SHSTK) &&
+	    !static_cpu_has(X86_FEATURE_IBT))
+		WARN_ONCE(1, "CET is disabled but got control protection fault\n");
+
+	tsk = current;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_CP;
+
+	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
+	    printk_ratelimit()) {
+		unsigned int max_err;
+		unsigned long ssp;
+
+		max_err = ARRAY_SIZE(control_protection_err) - 1;
+		if ((error_code < 0) || (error_code > max_err))
+			error_code = 0;
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+		pr_info("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)",
+			tsk->comm, task_pid_nr(tsk),
+			regs->ip, regs->sp, ssp, error_code,
+			control_protection_err[error_code]);
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
+	}
+
+	force_sig_fault(SIGSEGV, SEGV_CPERR,
+			(void __user *)uprobe_get_trap_addr(regs));
+	cond_local_irq_disable(regs);
+}
+#endif
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..91e10cbe3bb0 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -229,7 +229,8 @@ typedef struct siginfo {
 #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
 #define SEGV_ADIDERR	6	/* Disrupting MCD error */
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
-#define NSIGSEGV	7
+#define SEGV_CPERR	8	/* Control protection fault */
+#define NSIGSEGV	8
 
 /*
  * SIGBUS si_codes
-- 
2.21.0

