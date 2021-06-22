Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47C3AFC7E
	for <lists+linux-api@lfdr.de>; Tue, 22 Jun 2021 07:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFVFOe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Jun 2021 01:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVFOe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Jun 2021 01:14:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AEC061574
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 22:12:18 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 5-20020ac859450000b029024ba4a903ccso6663827qtz.6
        for <linux-api@vger.kernel.org>; Mon, 21 Jun 2021 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aijKZJCzVvlZz7ITX50wcymoFDteyjh9x4J/W4CiFQY=;
        b=p7jv1qZgfIRRKEWaRTAlroMc9+f06zk7OfSFmH0lbYe+suB8y63NcbKvNhFQQXijtP
         hmKAB3gOqSnv3jhHdMgdcKuGWARHdxGUEV0KX5FykLrL6EARNnhnb5twwWqlb0VD+7I5
         oXQ5PSWWMwaLQLNmDgAHgBuXmW6MJWzD7b4vb+vjU2P4PUZglkjGHJpXfR3ZmXTtn/v1
         Oxp7Fe/aghB+z8N7oFDj5L/cmvQmFSrUWwbgeHx9Y1uCr3eBPv43YamAjM0vaj33xw1f
         J30hteu8KzdqxL8rlFoW6+NlgX4MvZ9U+bVYJjquumGOpVUhowFNUy765OVtbOWUE0bh
         jbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aijKZJCzVvlZz7ITX50wcymoFDteyjh9x4J/W4CiFQY=;
        b=j09FKfjsDcjFQATItDsLx3DCX7SoNUVVyyZ4hJehk3vGoiTlBcpzSU2/SJzqTQDiRO
         1SfcwEVXoh9q75VkgL8dumB5CepYQUHSkXZ5RRdKvLlg9PrwncP1y7POUnyr7ToJKICw
         Yrpa30qLM1nvx6rmsQGgNxtArvd1BgpK+Ni/P3ZXGtl4IGDBq77o6v99Amby+NTV7+BR
         O4Ij7GIvJO3R6H/8K9qe5aKrgQORMZdarNbI8L8vGlIipUb0DVsqOSnIqsn/1K65H3gf
         HZxszL+HQhqZ+T3QS/lelKnZ80qnaNv3iUg2F3i+ryjUewY5u5zI+OIOUbgBmejsrb3B
         HjsA==
X-Gm-Message-State: AOAM531R+HLPD4H2w0dPkfq7Zq2Bf3Bihq2gVHK8Kl9xoXbG5F1+NWW6
        ICSwzkY5hCFwUZZC5q/5VcP6hp4=
X-Google-Smtp-Source: ABdhPJwNWfytlZPXhZ+jtEhxvHP8PkLvMKxPJ52anSShqMGkPHc661FD+1IqrJnlcaI9Y6QwqkufVuo=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:a96d:1c45:bc7e:4095])
 (user=pcc job=sendgmr) by 2002:a25:acdf:: with SMTP id x31mr2486550ybd.222.1624338737922;
 Mon, 21 Jun 2021 22:12:17 -0700 (PDT)
Date:   Mon, 21 Jun 2021 22:12:04 -0700
Message-Id: <20210622051204.3682580-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2] arm64: allow TCR_EL1.TBID0 to be configured
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce a command line flag that controls whether TCR_EL1.TBID0
is set at boot time. Since this is a change to the userspace ABI the
option defaults to off for now, although it seems likely that we'll
be able to change the default at some future point.

Setting TCR_EL1.TBID0 increases the number of signature bits used by
the pointer authentication instructions for instruction addresses by 8,
which improves the security of pointer authentication, but it also has
the consequence of changing the operation of the branch instructions
so that they no longer ignore the top byte of the target address but
instead fault if they are non-zero.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/Ife724ad708142bc475f42e8c1d9609124994bbbd
---
v2:
- rebase to linux-next
- make it a command line flag

 arch/arm64/include/asm/compiler.h      | 19 ++++++++----
 arch/arm64/include/asm/memory.h        |  2 ++
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/pointer_auth.h  |  2 +-
 arch/arm64/include/asm/processor.h     |  2 ++
 arch/arm64/kernel/pointer_auth.c       | 12 +++++++
 arch/arm64/kernel/process.c            | 43 ++++++++++++++++++++++++++
 arch/arm64/kernel/ptrace.c             |  8 ++---
 arch/arm64/mm/fault.c                  | 14 ++++++++-
 arch/arm64/mm/proc.S                   | 29 +----------------
 10 files changed, 91 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index 6fb2e6bcc392..3c2c7a1a2abf 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -8,19 +8,26 @@
 #define ARM64_ASM_PREAMBLE
 #endif
 
+/* Open-code TCR_TBID0 value to avoid circular dependency. */
+#define tcr_tbid0_enabled() (init_tcr & (1UL << 51))
+
 /*
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
  */
-#define ptrauth_user_pac_mask()		GENMASK_ULL(54, vabits_actual)
+#define ptrauth_user_insn_pac_mask()                                           \
+	(tcr_tbid0_enabled() ? GENMASK_ULL(63, vabits_actual) :                \
+				     GENMASK_ULL(54, vabits_actual))
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
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 87b90dc27a43..e0d8b8443ca6 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -191,6 +191,8 @@ extern u64			kimage_vaddr;
 /* the offset between the kernel virtual and physical mappings */
 extern u64			kimage_voffset;
 
+extern u64			init_tcr;
+
 static inline unsigned long kaslr_offset(void)
 {
 	return kimage_vaddr - KIMAGE_VADDR;
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index b82575a33f8b..31fc7c4b75d4 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -275,6 +275,7 @@
 #define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
+#define TCR_TBID0		(UL(1) << 51)
 #define TCR_TBID1		(UL(1) << 52)
 #define TCR_NFD0		(UL(1) << 53)
 #define TCR_NFD1		(UL(1) << 54)
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index d50416be99be..1bb1b022e5ee 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -92,7 +92,7 @@ extern int ptrauth_get_enabled_keys(struct task_struct *tsk);
 
 static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 {
-	return ptrauth_clear_pac(ptr);
+	return ptrauth_clear_insn_pac(ptr);
 }
 
 static __always_inline void ptrauth_enable(void)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 9df3feeee890..b2a575359a9c 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -253,6 +253,8 @@ unsigned long get_wchan(struct task_struct *p);
 
 void set_task_sctlr_el1(u64 sctlr);
 
+void enable_tcr(u64 tcr);
+
 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 					 struct task_struct *next);
diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
index 60901ab0a7fe..9ac2fc2b4e46 100644
--- a/arch/arm64/kernel/pointer_auth.c
+++ b/arch/arm64/kernel/pointer_auth.c
@@ -109,3 +109,15 @@ int ptrauth_get_enabled_keys(struct task_struct *tsk)
 
 	return retval;
 }
+
+static int __init tbi_data(char *arg)
+{
+	bool tbi_data;
+
+	if (kstrtobool(arg, &tbi_data))
+		return -EINVAL;
+	if (tbi_data)
+		enable_tcr(TCR_TBID0);
+	return 0;
+}
+early_param("tbi_data", tbi_data);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b4bb67f17a2c..d7a2f6cb833e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -644,6 +644,49 @@ void arch_setup_new_exec(void)
 	}
 }
 
+#ifdef CONFIG_ARM64_64K_PAGES
+#define TCR_TG_FLAGS	(TCR_TG0_64K | TCR_TG1_64K)
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define TCR_TG_FLAGS	(TCR_TG0_16K | TCR_TG1_16K)
+#else /* CONFIG_ARM64_4K_PAGES */
+#define TCR_TG_FLAGS	(TCR_TG0_4K | TCR_TG1_4K)
+#endif
+
+#ifdef CONFIG_RANDOMIZE_BASE
+#define TCR_KASLR_FLAGS	TCR_NFD1
+#else
+#define TCR_KASLR_FLAGS	0
+#endif
+
+#define TCR_SMP_FLAGS	TCR_SHARED
+
+/* PTWs cacheable, inner/outer WBWA */
+#define TCR_CACHE_FLAGS	(TCR_IRGN_WBWA | TCR_ORGN_WBWA)
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define TCR_KASAN_SW_FLAGS (TCR_TBI1 | TCR_TBID1)
+#else
+#define TCR_KASAN_SW_FLAGS 0
+#endif
+
+u64 __section(".mmuoff.data.read") init_tcr =
+	TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | TCR_TG_FLAGS
+	| TCR_KASLR_FLAGS | TCR_ASID16 | TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS;
+EXPORT_SYMBOL(init_tcr);
+
+void __init enable_tcr(u64 tcr)
+{
+	u64 tmp;
+
+	init_tcr |= tcr;
+	__asm__ __volatile__(
+		"mrs %0, tcr_el1\n"
+		"orr %0, %0, %1\n"
+		"msr tcr_el1, %0\n"
+		"tlbi vmalle1\n"
+	 : "=&r"(tmp) : "r"(tcr));
+}
+
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 /*
  * Control the relaxed ABI allowing tagged user addresses into the kernel.
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index eb2f73939b7b..4d86870ed348 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -894,13 +894,11 @@ static int pac_mask_get(struct task_struct *target,
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
index 871c82ab0a30..9ee32afe121c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -529,11 +529,23 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	vm_fault_t fault;
 	unsigned long vm_flags;
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
index 97d7bcd8d4f2..bae9476e6c2a 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,31 +20,6 @@
 #include <asm/smp.h>
 #include <asm/sysreg.h>
 
-#ifdef CONFIG_ARM64_64K_PAGES
-#define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
-#elif defined(CONFIG_ARM64_16K_PAGES)
-#define TCR_TG_FLAGS	TCR_TG0_16K | TCR_TG1_16K
-#else /* CONFIG_ARM64_4K_PAGES */
-#define TCR_TG_FLAGS	TCR_TG0_4K | TCR_TG1_4K
-#endif
-
-#ifdef CONFIG_RANDOMIZE_BASE
-#define TCR_KASLR_FLAGS	TCR_NFD1
-#else
-#define TCR_KASLR_FLAGS	0
-#endif
-
-#define TCR_SMP_FLAGS	TCR_SHARED
-
-/* PTWs cacheable, inner/outer WBWA */
-#define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
-
-#ifdef CONFIG_KASAN_SW_TAGS
-#define TCR_KASAN_SW_FLAGS TCR_TBI1 | TCR_TBID1
-#else
-#define TCR_KASAN_SW_FLAGS 0
-#endif
-
 #ifdef CONFIG_KASAN_HW_TAGS
 #define TCR_KASAN_HW_FLAGS SYS_TCR_EL1_TCMA1 | TCR_TBI1 | TCR_TBID1
 #else
@@ -425,9 +400,7 @@ SYM_FUNC_START(__cpu_setup)
 	mair	.req	x17
 	tcr	.req	x16
 	mov_q	mair, MAIR_EL1_SET
-	mov_q	tcr, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
+	ldr_l	tcr, init_tcr
 
 #ifdef CONFIG_ARM64_MTE
 	/*
-- 
2.32.0.288.g62a8d224e6-goog

