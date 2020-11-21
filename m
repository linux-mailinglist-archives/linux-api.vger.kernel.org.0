Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587D42BBE4F
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 11:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKUJ7S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 04:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgKUJ7R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 04:59:17 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C1C061A49
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 01:59:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i67so8734212pgc.3
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 01:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=meClIThUUCGmqBFGTKtEb888kGSslOj9VbNWIQpUrzM=;
        b=avqNQpzDHDwm2BZA3GuzxPalcyCOMf69cJWcy+em3kOeqOLZz43EmmRVcguzVJPy+u
         15PzDkaGXQjiEmIotQHEEOG3jffeLLr2l80D7YJkCkAKTgn7vmvt6l4x7q0lHwn1bicG
         cbw+26RLSA7qQO/5w1V3qDXwqvE0ScfbesfM1+xglDtNzh6PHw66pS3gJ+GQtFNxPGbp
         8RITOUB93/NIt96rBkz0zpasCwWRRDl6nsvizhu/Ckpxt8+pzc+NZQXUkqr8JlBS9h1w
         iS9X4zqV+GOC/3FJ+fH/VvODQvIxhJYyUJZX9qg4r3BFa+H2iECswmMBH7rCw7XsXHqy
         S3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=meClIThUUCGmqBFGTKtEb888kGSslOj9VbNWIQpUrzM=;
        b=POkzeFNZBum7EzVrfTM4imEOrpNjpdWvLj3yqEFeWBkUe95JFIi62pAYu8hdJuX7PR
         251kIaiGaRqUg9s00oBHDR2LtvrTRTvZBSgfSvIGG7zx3/zgARiixqV9B/4Awvh2CZbC
         CW6IbDuoPCS59qxIfGArSZ/nGzAatxTEJif7cWqHUjX653ZArC99l/quPHMIWv7wDZR+
         21WL71N2YXu1CffnHVp4ADce/odD/4bXlZv3r2VW+EeHj5wknU17wQCs6Cxy8WpVyWyz
         VHUWsVOvaHjmcxFv6a/SChK/DwOFAaPDHStw/udnBWPXyBD+U1auYanANis/2AlVvHl+
         pG+A==
X-Gm-Message-State: AOAM5321W4YznGbU/7TQPBQqCa/baHrpptTSZ/zFzi5o2UJsj1ophc3Q
        dsLoPoTpZdSCFX7dKOgzbYIY8bY=
X-Google-Smtp-Source: ABdhPJyspOhT2hOJtPmGesSa9WQR6w7gGjgrk+NwpxIQwaGPzftFL2NSScJ1hg60po0dC4itGDyUdEA=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:902:ed45:b029:d9:ea8e:cee4 with SMTP id
 y5-20020a170902ed45b02900d9ea8ecee4mr5435709plb.82.1605952756404; Sat, 21 Nov
 2020 01:59:16 -0800 (PST)
Date:   Sat, 21 Nov 2020 01:59:03 -0800
In-Reply-To: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
Message-Id: <64c0fa360333fd5275582d25019614156a8302bc.1605952129.git.pcc@google.com>
Mime-Version: 1.0
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 2/2] arm64: allow TCR_EL1.TBID0 to be configured
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce a Kconfig option that controls whether TCR_EL1.TBID0 is
set at boot time.

Setting TCR_EL1.TBID0 increases the number of signature bits used by
the pointer authentication instructions for instruction addresses by 8,
which improves the security of pointer authentication, but it also has
the consequence of changing the operation of the branch instructions
so that they no longer ignore the top byte of the target address but
instead fault if they are non-zero. Since this is a change to the
userspace ABI the option defaults to off.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
---
This is more of an RFC. An open question is how to expose this.
Having it be a build-time flag is probably the simplest option
but I guess it could also be a boot flag. Since it involves an
ABI change we may also want a prctl() so that userspace can
figure out which mode it is in.

I think we should try to avoid it being a per-task property
so that we don't need to swap yet another system register on
task switch.

This goes on top of my FAR_EL1 series because it involves
a change to how FAR_EL1 is handled on instruction aborts.

 arch/arm64/Kconfig                     | 18 ++++++++++++++++++
 arch/arm64/include/asm/compiler.h      | 18 ++++++++++++------
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/pointer_auth.h  |  2 +-
 arch/arm64/kernel/ptrace.c             |  8 +++-----
 arch/arm64/mm/fault.c                  | 14 +++++++++++++-
 arch/arm64/mm/proc.S                   |  8 +++++++-
 7 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..6ea17249f33f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1532,6 +1532,24 @@ config ARM64_PTR_AUTH
 	  This feature works with FUNCTION_GRAPH_TRACER option only if
 	  DYNAMIC_FTRACE_WITH_REGS is enabled.
 
+config ARM64_TBI_DATA
+	bool "Restrict top-byte ignore to data accesses"
+	help
+	  Normally, the kernel will enable top-byte ignore for instruction
+	  accesses as well as data accesses. With this configuration option
+	  enabled, on hardware supporting pointer authentication top-byte
+	  ignore will only be enabled for data accesses.
+
+	  The most important consequence of this is that it increases
+	  the number of signature bits used by the pointer authentication
+	  instructions for instruction addresses by 8, which improves the
+	  security of pointer authentication, but it also has the consequence
+	  of changing the operation of the branch instructions so that they
+	  no longer ignore the top byte of the target address but instead
+	  fault if they are non-zero. If your userspace does not depend on
+	  branch instructions ignoring the top byte it is recommended to
+	  select this option.
+
 config CC_HAS_BRANCH_PROT_PAC_RET
 	# GCC 9 or later, clang 8 or later
 	def_bool $(cc-option,-mbranch-protection=pac-ret+leaf)
diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index 6fb2e6bcc392..7332fd35bf6f 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -12,15 +12,21 @@
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
  */
-#define ptrauth_user_pac_mask()		GENMASK_ULL(54, vabits_actual)
+#ifdef CONFIG_ARM64_TBI_DATA
+#define ptrauth_user_insn_pac_mask()	GENMASK_ULL(63, vabits_actual)
+#else
+#define ptrauth_user_insn_pac_mask()	GENMASK_ULL(54, vabits_actual)
+#endif
+#define ptrauth_user_data_pac_mask()	GENMASK_ULL(54, vabits_actual)
 #define ptrauth_kernel_pac_mask()	GENMASK_ULL(63, vabits_actual)
 
 /* Valid for EL0 TTBR0 and EL1 TTBR1 instruction pointers */
-#define ptrauth_clear_pac(ptr)						\
-	((ptr & BIT_ULL(55)) ? (ptr | ptrauth_kernel_pac_mask()) :	\
-			       (ptr & ~ptrauth_user_pac_mask()))
+#define ptrauth_clear_insn_pac(ptr)                                            \
+	((ptr & BIT_ULL(55)) ? (ptr | ptrauth_kernel_pac_mask()) :             \
+				     (ptr & ~ptrauth_user_insn_pac_mask()))
 
-#define __builtin_return_address(val)					\
-	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
+#define __builtin_return_address(val)                                          \
+	((void *)(ptrauth_clear_insn_pac(                                      \
+		(unsigned long)__builtin_return_address(val))))
 
 #endif /* __ASM_COMPILER_H */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 42442a0ae2ab..90e69048442d 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -260,6 +260,7 @@
 #define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
+#define TCR_TBID0		(UL(1) << 51)
 #define TCR_TBID1		(UL(1) << 52)
 #define TCR_NFD0		(UL(1) << 53)
 #define TCR_NFD1		(UL(1) << 54)
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index c6b4f0603024..a0022867b8ed 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -73,7 +73,7 @@ extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
 
 static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 {
-	return ptrauth_clear_pac(ptr);
+	return ptrauth_clear_insn_pac(ptr);
 }
 
 #define ptrauth_thread_init_user(tsk)					\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8ac487c84e37..44afc5c3427e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -893,13 +893,11 @@ static int pac_mask_get(struct task_struct *target,
 {
 	/*
 	 * The PAC bits can differ across data and instruction pointers
-	 * depending on TCR_EL1.TBID*, which we may make use of in future, so
-	 * we expose separate masks.
+	 * depending on TCR_EL1.TBID0, so we expose separate masks.
 	 */
-	unsigned long mask = ptrauth_user_pac_mask();
 	struct user_pac_mask uregs = {
-		.data_mask = mask,
-		.insn_mask = mask,
+		.data_mask = ptrauth_user_data_pac_mask(),
+		.insn_mask = ptrauth_user_insn_pac_mask(),
 	};
 
 	if (!system_supports_address_auth())
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 29a6b8c9e830..617f9f43f528 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -458,11 +458,23 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	vm_fault_t fault;
 	unsigned long vm_flags = VM_ACCESS_FLAGS;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
-	unsigned long addr = untagged_addr(far);
+	unsigned long addr;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
 
+	/*
+	 * If TBID0 is set then we may get an IABT with a tagged address here as
+	 * a result of branching to a tagged address. In this case we want to
+	 * avoid untagging the address, let the VMA lookup fail and get a
+	 * SIGSEGV. Leaving the address as is will also work if TBID0 is clear
+	 * or unsupported because the tag bits of FAR_EL1 will be clear.
+	 */
+	if (is_el0_instruction_abort(esr))
+		addr = far;
+	else
+		addr = untagged_addr(far);
+
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
 	 * the fault.
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 97a97a61a8dc..0e715b9604a1 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -45,6 +45,12 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
+#ifdef CONFIG_ARM64_TBI_DATA
+#define TCR_TBI_DATA_FLAGS TCR_TBID0
+#else
+#define TCR_TBI_DATA_FLAGS 0
+#endif
+
 /*
  * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
  * changed during __cpu_setup to Normal Tagged if the system supports MTE.
@@ -456,7 +462,7 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+			TCR_TBI0 | TCR_TBI_DATA_FLAGS | TCR_A1 | TCR_KASAN_FLAGS
 	tcr_clear_errata_bits x10, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
-- 
2.29.2.454.gaff20da3a2-goog

