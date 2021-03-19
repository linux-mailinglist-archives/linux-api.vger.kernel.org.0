Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7134135D
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 04:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhCSDLP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Mar 2021 23:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCSDLF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Mar 2021 23:11:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8F1C06174A
        for <linux-api@vger.kernel.org>; Thu, 18 Mar 2021 20:11:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id k92so27671336qva.20
        for <linux-api@vger.kernel.org>; Thu, 18 Mar 2021 20:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j864d25R9oHF1bAS/o57VjFMOK2RIqLF81FPxBJA8mY=;
        b=M/zD1K51axCTSzEjWgreRcKH9UQdLuN3/7HH1DHaJGu4UeohKqZxB2JR67S0te6lor
         iCf4HXUgTQjTCzZa817pYnRNl7IMS8+cfTbU2ESCKglct2HTNuEXKXbPAIpBOpvxzbVn
         qNegAEpTLGgCF7UP4hehhRSOylQKKmY2cHwSogi64Qzqhvh+OZWzw7b6IZUqohESyhQI
         Y9Fp69eMPy8er3E9x9zgwb+qtIbxYtHrGZ+oiI0boyneyLJWPRucr7u3RsK85O9WZGGE
         UmzB2CJ0rj+vuwhOUvajmvTZ8Sm0OXrGEWw5nJei+H86SFIQZ8+e/UnrGXiPpO9T1FpJ
         yGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j864d25R9oHF1bAS/o57VjFMOK2RIqLF81FPxBJA8mY=;
        b=Fhk32PleZxj6Y43oRXHwvxOVALeNo74Q9hqsOM16E8uq+eG7XTiIzhNeccPETjYqxl
         7I9Fb6Z8fIBhOwH1uRErXZ6da1JIrTZ3CgnPgb2dUpoGnW/1SgM3wl7tg/wSJo/eyh4p
         Lo+xaqka237yR6WFIozChe0H1ebWUjM3YLPm3P3Tzr5CQystEJucVc+T6WHq8SrEUGz0
         ErdL6Obl4MjKFkVrxBhjNUf6E1kpf8IM6z4iw2m4jyL20Uwas91SM+Kk9D9+T+wU6UaO
         zIsmAbCDDledk2N5CwUjfgk9o1O29Sz6TeqGLM2ChA1HNtsv5wrPmUDwNwcW/qqlZPR2
         x9Wg==
X-Gm-Message-State: AOAM533Z37q7aUWHqAKLESdGjjWs7IJao1doxROn6YRdS4J3HdnIrBN6
        BA9BIMfKRR/paAvtw5NmBr2/77k=
X-Google-Smtp-Source: ABdhPJx7S5TOS6C45+k3SDxX5v62ejjZsOdO9cNoIohUoQ265uoISY/ainOHC5Su5v4nr41ivjfK4jg=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:455:89c6:cb5a:9b7f])
 (user=pcc job=sendgmr) by 2002:a0c:f946:: with SMTP id i6mr7557811qvo.40.1616123463998;
 Thu, 18 Mar 2021 20:11:03 -0700 (PDT)
Date:   Thu, 18 Mar 2021 20:10:53 -0700
In-Reply-To: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
Message-Id: <d6609065f8f40397a4124654eb68c9f490b4d477.1616123271.git.pcc@google.com>
Mime-Version: 1.0
References: <13d725cb8e741950fb9d6e64b2cd9bd54ff7c3f9.1616123271.git.pcc@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 2/3] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
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
v8:
- rebase to 5.12-rc3

v7:
- drop CONFIG_ARM64_NEED_SCTLR_USER

v6:
- rebased onto 5.11rc1
- changed the PR_PAC_{SET,GET}_ENABLED_KEYS values as a new prctl
  was introduced in 5.11

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
 arch/arm64/include/asm/mte.h                  |  4 +-
 arch/arm64/include/asm/pointer_auth.h         | 25 +++++++-
 arch/arm64/include/asm/processor.h            |  9 ++-
 arch/arm64/include/asm/sysreg.h               |  4 +-
 arch/arm64/kernel/asm-offsets.c               |  1 +
 arch/arm64/kernel/entry.S                     | 39 +++++++++++-
 arch/arm64/kernel/mte.c                       |  2 +-
 arch/arm64/kernel/pointer_auth.c              | 62 +++++++++++++++++++
 arch/arm64/kernel/process.c                   | 10 ++-
 arch/arm64/kernel/ptrace.c                    | 41 ++++++++++++
 include/uapi/linux/elf.h                      |  1 +
 include/uapi/linux/prctl.h                    |  4 ++
 kernel/sys.c                                  | 16 +++++
 14 files changed, 239 insertions(+), 13 deletions(-)

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
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 1a4909b44297..204fc37a1df8 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -39,7 +39,7 @@ void mte_free_tag_storage(char *storage);
 
 void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
-void flush_mte_state(void);
+void mte_thread_init_user(void);
 void mte_suspend_exit(void);
 long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
@@ -59,7 +59,7 @@ static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
 {
 }
-static inline void flush_mte_state(void)
+static inline void mte_thread_init_user(void)
 {
 }
 static inline void mte_suspend_exit(void)
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index b112a11e9302..cefe7e9b6fa9 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -3,6 +3,7 @@
 #define __ASM_POINTER_AUTH_H
 
 #include <linux/bitops.h>
+#include <linux/prctl.h>
 #include <linux/random.h>
 
 #include <asm/cpufeature.h>
@@ -71,6 +72,10 @@ static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kerne
 
 extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
 
+extern int ptrauth_set_enabled_keys(struct task_struct *tsk, unsigned long keys,
+				    unsigned long enabled);
+extern int ptrauth_get_enabled_keys(struct task_struct *tsk);
+
 static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 {
 	return ptrauth_clear_pac(ptr);
@@ -85,8 +90,17 @@ static __always_inline void ptrauth_enable(void)
 	isb();
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
@@ -95,10 +109,15 @@ static __always_inline void ptrauth_enable(void)
 #else /* CONFIG_ARM64_PTR_AUTH */
 #define ptrauth_enable()
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
index 80895bb30490..2f21c76324bb 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -156,7 +156,9 @@ struct thread_struct {
 	u64			sctlr_user;
 };
 
-#define SCTLR_USER_MASK SCTLR_EL1_TCF0_MASK
+#define SCTLR_USER_MASK                                                        \
+	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
+	 SCTLR_EL1_TCF0_MASK)
 
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
@@ -305,6 +307,11 @@ extern void __init minsigstksz_setup(void);
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
index d4a5fca984c3..9dc2e88b10c6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -565,8 +565,10 @@
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
index a36e2fc330d4..8b4fbad427b3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -43,6 +43,7 @@ int main(void)
 #endif
   BLANK();
   DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
+  DEFINE(THREAD_SCTLR_USER,	offsetof(struct task_struct, thread.sctlr_user));
 #ifdef CONFIG_ARM64_PTR_AUTH
   DEFINE(THREAD_KEYS_USER,	offsetof(struct task_struct, thread.keys_user));
   DEFINE(THREAD_KEYS_KERNEL,	offsetof(struct task_struct, thread.keys_kernel));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a31a0a713c85..36ae1cdfaeb6 100644
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
 
@@ -351,9 +368,27 @@ alternative_else_nop_endif
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
index ea8a90259e7f..27657f669929 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -146,7 +146,7 @@ static void set_gcr_el1_excl(u64 excl)
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
index bb89f6208a20..7cf46509e46b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -339,7 +339,6 @@ void flush_thread(void)
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
-	flush_mte_state();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -531,7 +530,11 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 
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
@@ -626,7 +629,8 @@ void arch_setup_new_exec(void)
 {
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
 
-	ptrauth_thread_init_user(current);
+	ptrauth_thread_init_user();
+	mte_thread_init_user();
 
 	if (task_spec_ssb_noexec(current)) {
 		arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 170f42fd6101..eb2f73939b7b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -909,6 +909,38 @@ static int pac_mask_get(struct task_struct *target,
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
@@ -1074,6 +1106,7 @@ enum aarch64_regset {
 #endif
 #ifdef CONFIG_ARM64_PTR_AUTH
 	REGSET_PAC_MASK,
+	REGSET_PAC_ENABLED_KEYS,
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	REGSET_PACA_KEYS,
 	REGSET_PACG_KEYS,
@@ -1160,6 +1193,14 @@ static const struct user_regset aarch64_regsets[] = {
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
index 667f1aed091c..18a9f59dc067 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -255,4 +255,8 @@ struct prctl_mm_map {
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 
+/* Set/get enabled arm64 pointer authentication keys */
+#define PR_PAC_SET_ENABLED_KEYS		60
+#define PR_PAC_GET_ENABLED_KEYS		61
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 2e2e3f378d97..3d62c9599dc0 100644
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
2.31.0.rc2.261.g7f71774620-goog

