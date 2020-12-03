Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7522CD20B
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbgLCJFQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 04:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbgLCJFO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 04:05:14 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC9C061A53
        for <linux-api@vger.kernel.org>; Thu,  3 Dec 2020 01:04:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m13so947008pjh.6
        for <linux-api@vger.kernel.org>; Thu, 03 Dec 2020 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RE45BnfZO8dsaqxQM+yL8pTTmoV7DIUc5qUQQ1LQhXs=;
        b=Iji6Q1cEvTtj1F9roPV12D8mvtUcJK0ecUcA4PbiCioxCscYsJYjglSmp/UGQ7HRea
         y5VIV+jTF6QH94hTxlh9j1xefpHAsG8yG7sChPsmga+9zsZ+7kxmmQzuz7truhcNarhu
         byuIxzCjQRi99h0D7dA6YzA9e2QQ/a872iX4522Q4aVuTKzYZczqcfooKBu0Xrnhh8j8
         le6JL0pv7OuhX8DlSfM7uLHp/tO9wD2iorHdIPaetWv1hvRnuqlyHS9qXK0+9wiEvTh9
         nAJ9z5rhlGsgvT36rJEIm+1Km5bp5oSoQdQr27HdboYrnEBj3cTiTpEqgGQLEbvNs0Bb
         sKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RE45BnfZO8dsaqxQM+yL8pTTmoV7DIUc5qUQQ1LQhXs=;
        b=TbUlvlsrZZnbhfDMny7ocW5toB3MZJS6IghCuhTnPUWSfB9jl+YzLrfudPs8PwrO8m
         e+TY2Qx9dh8l0079b8fMz0qzaRl8wdQ/toaHT4Km+xwChlkOi65wJhRPyvfXe+66psmK
         JZBUQoiMMmtTRI3lLh8hIXFAaYxvEI3J37aMjFEdx8EwR73orAqz7U99u85MrvrxFR58
         mAmbmYAlPdEiv0rSdoalQeeR/hS7mSXpSVOtW6NPMgHr7OlOD3TXMwzfTyVBW34xxJEL
         vW/EeYyBkEE0KcjC7Ag9/81Eo7MbfmaqikGcC/NK0EBPMvgq1tEijmqbCyWd8fm0OLPN
         e8XQ==
X-Gm-Message-State: AOAM531WrW1amfciNKvzbErzRQT1+vas2UrLFPqQOF9Xn+/JVRKBFQQs
        LWvNOQXwpDog9bHQrRZYTdkrvVE=
X-Google-Smtp-Source: ABdhPJwpK5HLCQcKGELysuE2l18Awwd9mLx8WivQAy6LAzBq+jH1XX4lcz1c8Jdd6BBkJomCwsGrjmc=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a63:b046:: with SMTP id z6mr2259329pgo.44.1606986261186;
 Thu, 03 Dec 2020 01:04:21 -0800 (PST)
Date:   Thu,  3 Dec 2020 01:04:12 -0800
In-Reply-To: <d7b22bd755e464cc22d47c585c60a13b53cffea7.1606985721.git.pcc@google.com>
Message-Id: <72e98d2eb0eafa40ff8166230dcc4f8c37aad465.1606985721.git.pcc@google.com>
Mime-Version: 1.0
References: <d7b22bd755e464cc22d47c585c60a13b53cffea7.1606985721.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 2/2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This change introduces a prctl that allows the user program to control
which PAC keys are enabled in a particular task. The main reason
why this is useful is to enable a userspace ABI that uses PAC to
sign and authenticate function pointers and other pointers exposed
outside of the function, while still allowing binaries conforming
to the ABI to interoperate with legacy binaries that do not sign or
authenticate pointers.

The idea is that a dynamic loader or early startup code would issue
this prctl very early after establishing that a process may load legacy
binaries, but before executing any PAC instructions.

This change adds a small amount of overhead to kernel entry and exit
due to additional required instruction sequences.

On a DragonBoard 845c (Cortex-A75) with the powersave governor, the
overhead of similar instruction sequences was measured as 4.9ns when
simulating the common case where IA is left enabled, or 43.7ns when
simulating the uncommon case where IA is disabled. These numbers can
be seen as the worst case scenario, since in more realistic scenarios
a better performing governor would be used and a newer chip would be
used that would support PAC unlike Cortex-A75 and would be expected
to be faster than Cortex-A75.

On an Apple M1 under a hypervisor, the overhead of the entry/exit
instruction sequences introduced by this patch was measured as 0.3ns
in the case where IA is left enabled, and 33.0ns in the case where
IA is disabled.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Link: https://linux-review.googlesource.com/id/Ibc41a5e6a76b275efbaa126b31119dc197b927a5
---
v5:
- rebased onto the kasan series
- fix some compat checks to check the correct task
- add some new perf measurements

v4:
- split the patch in two
- move the PAC || MTE into a config and make code conditional
  on it
- rename ptrauth_prctl_* -> ptrauth_*
- add some notes on fork/exec/clone behavior and performance to
  the doc
- change -1 to sizeof(long) in the ptrace code
- improve some comments
- add a WARN_ON to arg_to_enxx_mask

v3:
- fix some style nits
- move kernel entry ISB to after setting EnIA
- rename sctlr -> sctlr_user
- remove init_sctlr

v2:
- added prctl(PR_PAC_GET_ENABLED_KEYS)
- added ptrace APIs for getting and setting the set of enabled
  keys
- optimized the instruction sequence for kernel entry/exit
- rebased on top of MTE series

 .../arm64/pointer-authentication.rst          | 34 ++++++++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/mte.h                  |  4 +-
 arch/arm64/include/asm/pointer_auth.h         | 25 +++++++-
 arch/arm64/include/asm/processor.h            |  9 ++-
 arch/arm64/include/asm/sysreg.h               |  4 +-
 arch/arm64/kernel/asm-offsets.c               |  3 +
 arch/arm64/kernel/entry.S                     | 39 +++++++++++-
 arch/arm64/kernel/mte.c                       |  2 +-
 arch/arm64/kernel/pointer_auth.c              | 62 +++++++++++++++++++
 arch/arm64/kernel/process.c                   | 10 ++-
 arch/arm64/kernel/ptrace.c                    | 41 ++++++++++++
 include/uapi/linux/elf.h                      |  1 +
 include/uapi/linux/prctl.h                    |  4 ++
 kernel/sys.c                                  | 16 +++++
 15 files changed, 242 insertions(+), 13 deletions(-)

diff --git a/Documentation/arm64/pointer-authentication.rst b/Documentation/arm64/pointer-authentication.rst
index 30b2ab06526b..f127666ea3a8 100644
--- a/Documentation/arm64/pointer-authentication.rst
+++ b/Documentation/arm64/pointer-authentication.rst
@@ -107,3 +107,37 @@ filter out the Pointer Authentication system key registers from
 KVM_GET/SET_REG_* ioctls and mask those features from cpufeature ID
 register. Any attempt to use the Pointer Authentication instructions will
 result in an UNDEFINED exception being injected into the guest.
+
+
+Enabling and disabling keys
+---------------------------
+
+The prctl PR_PAC_SET_ENABLED_KEYS allows the user program to control which
+PAC keys are enabled in a particular task. It takes two arguments, the
+first being a bitmask of PR_PAC_APIAKEY, PR_PAC_APIBKEY, PR_PAC_APDAKEY
+and PR_PAC_APDBKEY specifying which keys shall be affected by this prctl,
+and the second being a bitmask of the same bits specifying whether the key
+should be enabled or disabled. For example::
+
+  prctl(PR_PAC_SET_ENABLED_KEYS,
+        PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY,
+        PR_PAC_APIBKEY, 0, 0);
+
+disables all keys except the IB key.
+
+The main reason why this is useful is to enable a userspace ABI that uses PAC
+instructions to sign and authenticate function pointers and other pointers
+exposed outside of the function, while still allowing binaries conforming to
+the ABI to interoperate with legacy binaries that do not sign or authenticate
+pointers.
+
+The idea is that a dynamic loader or early startup code would issue this
+prctl very early after establishing that a process may load legacy binaries,
+but before executing any PAC instructions.
+
+For compatibility with previous kernel versions, processes start up with IA,
+IB, DA and DB enabled, and are reset to this state on exec(). Processes created
+via fork() and clone() inherit the key enabled state from the calling process.
+
+It is recommended to avoid disabling the IA key, as this has higher performance
+overhead than disabling any of the other keys.
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 21a289dcdf7d..50abad53abce 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1505,6 +1505,7 @@ config ARM64_PTR_AUTH
 	depends on LD_IS_LLD || LD_VERSION >= 233010000 || (CC_IS_GCC && GCC_VERSION < 90100)
 	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
+	select ARM64_NEED_SCTLR_USER
 	help
 	  Pointer authentication (part of the ARMv8.3 Extensions) provides
 	  instructions for signing and authenticating pointers against secret
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 4e807969e767..05ac68938a90 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -41,7 +41,7 @@ void mte_free_tag_storage(char *storage);
 
 void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
-void flush_mte_state(void);
+void mte_thread_init_user(void);
 void mte_suspend_exit(void);
 long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
@@ -61,7 +61,7 @@ static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
 {
 }
-static inline void flush_mte_state(void)
+static inline void mte_thread_init_user(void)
 {
 }
 static inline void mte_suspend_exit(void)
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index c6b4f0603024..1a85e25d98ba 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -3,6 +3,7 @@
 #define __ASM_POINTER_AUTH_H
 
 #include <linux/bitops.h>
+#include <linux/prctl.h>
 #include <linux/random.h>
 
 #include <asm/cpufeature.h>
@@ -71,13 +72,26 @@ static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kerne
 
 extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
 
+extern int ptrauth_set_enabled_keys(struct task_struct *tsk, unsigned long keys,
+				    unsigned long enabled);
+extern int ptrauth_get_enabled_keys(struct task_struct *tsk);
+
 static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 {
 	return ptrauth_clear_pac(ptr);
 }
 
-#define ptrauth_thread_init_user(tsk)					\
-	ptrauth_keys_init_user(&(tsk)->thread.keys_user)
+#define ptrauth_thread_init_user()                                             \
+	do {                                                                   \
+		ptrauth_keys_init_user(&current->thread.keys_user);            \
+									       \
+		/* enable all keys */                                          \
+		if (system_supports_address_auth())                            \
+			set_task_sctlr_el1(current->thread.sctlr_user |        \
+					   SCTLR_ELx_ENIA | SCTLR_ELx_ENIB |   \
+					   SCTLR_ELx_ENDA | SCTLR_ELx_ENDB);   \
+	} while (0)
+
 #define ptrauth_thread_init_kernel(tsk)					\
 	ptrauth_keys_init_kernel(&(tsk)->thread.keys_kernel)
 #define ptrauth_thread_switch_kernel(tsk)				\
@@ -85,10 +99,15 @@ static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
 #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
+#define ptrauth_set_enabled_keys(tsk, keys, enabled)	(-EINVAL)
+#define ptrauth_get_enabled_keys(tsk)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
-#define ptrauth_thread_init_user(tsk)
+#define ptrauth_thread_init_user()
 #define ptrauth_thread_init_kernel(tsk)
 #define ptrauth_thread_switch_kernel(tsk)
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
+#define PR_PAC_ENABLED_KEYS_MASK                                               \
+	(PR_PAC_APIAKEY | PR_PAC_APIBKEY | PR_PAC_APDAKEY | PR_PAC_APDBKEY)
+
 #endif /* __ASM_POINTER_AUTH_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 254c04b75879..3c9f9153d9f0 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -160,7 +160,9 @@ struct thread_struct {
 #endif
 };
 
-#define SCTLR_USER_MASK SCTLR_EL1_TCF0_MASK
+#define SCTLR_USER_MASK                                                        \
+	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
+	 SCTLR_EL1_TCF0_MASK)
 
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
@@ -311,6 +313,11 @@ extern void __init minsigstksz_setup(void);
 /* PR_PAC_RESET_KEYS prctl */
 #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
 
+/* PR_PAC_{SET,GET}_ENABLED_KEYS prctl */
+#define PAC_SET_ENABLED_KEYS(tsk, keys, enabled)				\
+	ptrauth_set_enabled_keys(tsk, keys, enabled)
+#define PAC_GET_ENABLED_KEYS(tsk) ptrauth_get_enabled_keys(tsk)
+
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 /* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
 long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 174817ba119c..f975776c0be4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -550,8 +550,10 @@
 #define SCTLR_ELx_TCF_ASYNC	(UL(0x2) << SCTLR_ELx_TCF_SHIFT)
 #define SCTLR_ELx_TCF_MASK	(UL(0x3) << SCTLR_ELx_TCF_SHIFT)
 
+#define SCTLR_ELx_ENIA_SHIFT	31
+
 #define SCTLR_ELx_ITFSB	(BIT(37))
-#define SCTLR_ELx_ENIA	(BIT(31))
+#define SCTLR_ELx_ENIA	(BIT(SCTLR_ELx_ENIA_SHIFT))
 #define SCTLR_ELx_ENIB	(BIT(30))
 #define SCTLR_ELx_ENDA	(BIT(27))
 #define SCTLR_ELx_EE    (BIT(25))
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index dfe6ed8446ac..fda13752f334 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -44,6 +44,9 @@ int main(void)
 #endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
+#ifdef CONFIG_ARM64_NEED_SCTLR_USER
+  DEFINE(THREAD_SCTLR_USER,	offsetof(struct task_struct, thread.sctlr_user));
+#endif
 #ifdef CONFIG_ARM64_PTR_AUTH
   DEFINE(THREAD_KEYS_USER,	offsetof(struct task_struct, thread.keys_user));
   DEFINE(THREAD_KEYS_KERNEL,	offsetof(struct task_struct, thread.keys_kernel));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 07646ef4f184..f1859668d32c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -247,7 +247,24 @@ alternative_else_nop_endif
 	check_mte_async_tcf x19, x22
 	apply_ssbd 1, x22, x23
 
-	ptrauth_keys_install_kernel tsk, x20, x22, x23
+	ptrauth_keys_install_kernel_nosync tsk, x20, x22, x23
+
+#ifdef CONFIG_ARM64_PTR_AUTH
+alternative_if ARM64_HAS_ADDRESS_AUTH
+	/*
+	 * Enable IA for in-kernel PAC if the task had it disabled. Although
+	 * this could be implemented with an unconditional MRS which would avoid
+	 * a load, this was measured to be slower on Cortex-A75 and Cortex-A76.
+	 */
+	ldr	x0, [tsk, THREAD_SCTLR_USER]
+	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+	mrs	x0, sctlr_el1
+	orr	x0, x0, SCTLR_ELx_ENIA
+	msr	sctlr_el1, x0
+1:
+	isb
+alternative_else_nop_endif
+#endif
 
 	mte_set_kernel_gcr x22, x23
 
@@ -366,9 +383,27 @@ alternative_else_nop_endif
 3:
 	scs_save tsk, x0
 
-	/* No kernel C function calls after this as user keys are set. */
+	/*
+	 * No kernel C function calls after this as user keys are set and IA may
+	 * be disabled.
+	 */
 	ptrauth_keys_install_user tsk, x0, x1, x2
 
+#ifdef CONFIG_ARM64_PTR_AUTH
+alternative_if ARM64_HAS_ADDRESS_AUTH
+	/*
+	 * IA was enabled for in-kernel PAC. Disable it now if needed.
+	 * All other per-task SCTLR bits were updated on task switch.
+	 */
+	ldr	x0, [tsk, THREAD_SCTLR_USER]
+	tbnz	x0, SCTLR_ELx_ENIA_SHIFT, 1f
+	mrs	x0, sctlr_el1
+	bic	x0, x0, SCTLR_ELx_ENIA
+	msr	sctlr_el1, x0
+1:
+alternative_else_nop_endif
+#endif
+
 	mte_set_user_gcr tsk, x0, x1
 
 	apply_ssbd 0, x0, x1
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 8c5bf77a0b02..fd9736c86923 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -180,7 +180,7 @@ static void set_gcr_el1_excl(u64 excl)
 	 */
 }
 
-void flush_mte_state(void)
+void mte_thread_init_user(void)
 {
 	if (!system_supports_mte())
 		return;
diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
index adb955fd9bdd..f03e5bfe4490 100644
--- a/arch/arm64/kernel/pointer_auth.c
+++ b/arch/arm64/kernel/pointer_auth.c
@@ -46,3 +46,65 @@ int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
 
 	return 0;
 }
+
+static u64 arg_to_enxx_mask(unsigned long arg)
+{
+	u64 sctlr_enxx_mask = 0;
+
+	WARN_ON(arg & ~PR_PAC_ENABLED_KEYS_MASK);
+	if (arg & PR_PAC_APIAKEY)
+		sctlr_enxx_mask |= SCTLR_ELx_ENIA;
+	if (arg & PR_PAC_APIBKEY)
+		sctlr_enxx_mask |= SCTLR_ELx_ENIB;
+	if (arg & PR_PAC_APDAKEY)
+		sctlr_enxx_mask |= SCTLR_ELx_ENDA;
+	if (arg & PR_PAC_APDBKEY)
+		sctlr_enxx_mask |= SCTLR_ELx_ENDB;
+	return sctlr_enxx_mask;
+}
+
+int ptrauth_set_enabled_keys(struct task_struct *tsk, unsigned long keys,
+			     unsigned long enabled)
+{
+	u64 sctlr = tsk->thread.sctlr_user;
+
+	if (!system_supports_address_auth())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(tsk)))
+		return -EINVAL;
+
+	if ((keys & ~PR_PAC_ENABLED_KEYS_MASK) || (enabled & ~keys))
+		return -EINVAL;
+
+	sctlr &= ~arg_to_enxx_mask(keys);
+	sctlr |= arg_to_enxx_mask(enabled);
+	if (tsk == current)
+		set_task_sctlr_el1(sctlr);
+	else
+		tsk->thread.sctlr_user = sctlr;
+
+	return 0;
+}
+
+int ptrauth_get_enabled_keys(struct task_struct *tsk)
+{
+	int retval = 0;
+
+	if (!system_supports_address_auth())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(tsk)))
+		return -EINVAL;
+
+	if (tsk->thread.sctlr_user & SCTLR_ELx_ENIA)
+		retval |= PR_PAC_APIAKEY;
+	if (tsk->thread.sctlr_user & SCTLR_ELx_ENIB)
+		retval |= PR_PAC_APIBKEY;
+	if (tsk->thread.sctlr_user & SCTLR_ELx_ENDA)
+		retval |= PR_PAC_APDAKEY;
+	if (tsk->thread.sctlr_user & SCTLR_ELx_ENDB)
+		retval |= PR_PAC_APDBKEY;
+
+	return retval;
+}
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 47e3dfb5d4a9..c08be4fb7167 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -339,7 +339,6 @@ void flush_thread(void)
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
-	flush_mte_state();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -545,7 +544,11 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 #ifdef CONFIG_ARM64_NEED_SCTLR_USER
 static void update_sctlr_el1(u64 sctlr)
 {
-	sysreg_clear_set(sctlr_el1, SCTLR_USER_MASK, sctlr);
+	/*
+	 * EnIA must not be cleared while in the kernel as this is necessary for
+	 * in-kernel PAC. It will be cleared on kernel exit if needed.
+	 */
+	sysreg_clear_set(sctlr_el1, SCTLR_USER_MASK & ~SCTLR_ELx_ENIA, sctlr);
 
 	/* ISB required for the kernel uaccess routines when setting TCF0. */
 	isb();
@@ -644,7 +647,8 @@ void arch_setup_new_exec(void)
 {
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
 
-	ptrauth_thread_init_user(current);
+	ptrauth_thread_init_user();
+	mte_thread_init_user();
 
 	if (task_spec_ssb_noexec(current)) {
 		arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f49b349e16a3..6cd1b1f5b0b2 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -911,6 +911,38 @@ static int pac_mask_get(struct task_struct *target,
 	return membuf_write(&to, &uregs, sizeof(uregs));
 }
 
+static int pac_enabled_keys_get(struct task_struct *target,
+				const struct user_regset *regset,
+				struct membuf to)
+{
+	long enabled_keys = ptrauth_get_enabled_keys(target);
+
+	if (IS_ERR_VALUE(enabled_keys))
+		return enabled_keys;
+
+	return membuf_write(&to, &enabled_keys, sizeof(enabled_keys));
+}
+
+static int pac_enabled_keys_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	long enabled_keys = ptrauth_get_enabled_keys(target);
+
+	if (IS_ERR_VALUE(enabled_keys))
+		return enabled_keys;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &enabled_keys, 0,
+				 sizeof(long));
+	if (ret)
+		return ret;
+
+	return ptrauth_set_enabled_keys(target, PR_PAC_ENABLED_KEYS_MASK,
+					enabled_keys);
+}
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 static __uint128_t pac_key_to_user(const struct ptrauth_key *key)
 {
@@ -1076,6 +1108,7 @@ enum aarch64_regset {
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
+	REGSET_PAC_ENABLED_KEYS,
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	REGSET_PACA_KEYS,
 	REGSET_PACG_KEYS,
@@ -1162,6 +1195,14 @@ static const struct user_regset aarch64_regsets[] = {
 		.regset_get = pac_mask_get,
 		/* this cannot be set dynamically */
 	},
+	[REGSET_PAC_ENABLED_KEYS] = {
+		.core_note_type = NT_ARM_PAC_ENABLED_KEYS,
+		.n = 1,
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.regset_get = pac_enabled_keys_get,
+		.set = pac_enabled_keys_set,
+	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	[REGSET_PACA_KEYS] = {
 		.core_note_type = NT_ARM_PACA_KEYS,
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 30f68b42eeb5..61bf4774b8f2 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -426,6 +426,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
 #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
 #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
+#define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7f0827705c9a..0d1bb3a2e59a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -247,4 +247,8 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Set/get enabled arm64 pointer authentication keys */
+#define PR_PAC_SET_ENABLED_KEYS		59
+#define PR_PAC_GET_ENABLED_KEYS		60
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..b7f2878f053b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -119,6 +119,12 @@
 #ifndef PAC_RESET_KEYS
 # define PAC_RESET_KEYS(a, b)	(-EINVAL)
 #endif
+#ifndef PAC_SET_ENABLED_KEYS
+# define PAC_SET_ENABLED_KEYS(a, b, c)	(-EINVAL)
+#endif
+#ifndef PAC_GET_ENABLED_KEYS
+# define PAC_GET_ENABLED_KEYS(a)	(-EINVAL)
+#endif
 #ifndef SET_TAGGED_ADDR_CTRL
 # define SET_TAGGED_ADDR_CTRL(a)	(-EINVAL)
 #endif
@@ -2497,6 +2503,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_PAC_SET_ENABLED_KEYS:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = PAC_SET_ENABLED_KEYS(me, arg2, arg3);
+		break;
+	case PR_PAC_GET_ENABLED_KEYS:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = PAC_GET_ENABLED_KEYS(me);
+		break;
 	case PR_SET_TAGGED_ADDR_CTRL:
 		if (arg3 || arg4 || arg5)
 			return -EINVAL;
-- 
2.29.2.454.gaff20da3a2-goog

